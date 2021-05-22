library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;

-- This implements a SPI Master
--
-- The Master must set the clock frequency, as well as polarity and phase (aka SPI mode).
-- Clock frequency : 
-- SPI mode        : 0.  Data in and out is valid on rising edge of clock.
-- The "out" side changes the data on the falling edge of the preceding clock
-- cycle, while the "in" side captures the data on   (or shortly after) the
-- rising edge of the clock cycle. The out side holds the data valid until the
-- falling edge of the current clock cycle. For the first cycle, the first bit
-- must be on the MOSI line before the rising clock edge.
--
-- The clock must be pulled low before the chip select is activated. The chip
-- select line must be activated, which normally means being toggled low, for
-- the peripheral before the start of the transfer, and then deactivated
-- afterward. Most peripherals allow or require several transfers while the
-- select line is low; this routine might be called several times before
-- deselecting the chip.
--
-- Data bits are shifted MSB first.

entity spi_master is
   port (
      clk_i      : in  std_logic;
      rst_i      : in  std_logic;

      -- CPU interface
      valid_i    : in  std_logic;
      ready_o    : out std_logic;
      data_i     : in  std_logic_vector( 7 downto 0);
      data_o     : out std_logic_vector( 7 downto 0);

      -- Connect to SD card
      spi_sclk_o : out std_logic;       -- sd_sck_io
      spi_mosi_o : out std_logic;       -- sd_cmd_io
      spi_miso_i : in  std_logic        -- sd_dat_io(0)
   );
end spi_master;

architecture structural of spi_master is

   constant CLK_PERIOD_CYCLES : integer := 100;           

   signal timer      : std_logic_vector(6 downto 0);   -- Free running timer up to 128.
   signal timer_next : std_logic_vector(6 downto 0);   -- Time for next event

   signal data_r     : std_logic_vector(7 downto 0);
   signal counter    : integer range 0 to 8;

   type state_t is (IDLE_ST, LOW_ST, HIGH_ST);
   signal state : state_t;

   -- Debug
   signal spi_sclk_s : std_logic;
   signal spi_mosi_s : std_logic;
   signal spi_miso_s : std_logic;

   -- Debug
   constant DEBUG_MODE                : boolean := false; -- TRUE OR FALSE

   attribute mark_debug               : boolean;
   attribute mark_debug of state      : signal is DEBUG_MODE;
   attribute mark_debug of spi_sclk_s : signal is DEBUG_MODE;
   attribute mark_debug of spi_mosi_s : signal is DEBUG_MODE;
   attribute mark_debug of spi_miso_s : signal is DEBUG_MODE;
   attribute mark_debug of data_r     : signal is DEBUG_MODE;
   attribute mark_debug of counter    : signal is DEBUG_MODE;
   attribute mark_debug of timer      : signal is DEBUG_MODE;
   attribute mark_debug of timer_next : signal is DEBUG_MODE;
   
   attribute dont_touch : string;

    attribute dont_touch of state : signal is "true";
    attribute dont_touch of valid_i : signal is "true";
    attribute dont_touch of ready_o : signal is "true";
    
begin

   -- Debug
   spi_sclk_s <= spi_sclk_o;
   spi_mosi_s <= spi_mosi_o;
   spi_miso_s <= spi_miso_i;


   

   data_o <= data_r;

   --------------------------
   -- State manchine
   --------------------------

   p_fsm : process (clk_i)
   begin
      if rising_edge(clk_i) then
         case state is
            when IDLE_ST =>
               ready_o <= '1';
               if valid_i = '1' then
                  data_r     <= data_i;
                  counter    <= 7;
                  spi_mosi_o <= data_i(7);
                  timer_next <= timer + CLK_PERIOD_CYCLES/2;
                  state      <= LOW_ST;
               end if;

            when LOW_ST =>
               ready_o <= '0';
               if timer = timer_next then
                  -- input data is captured on rising edge of SCLK.
                  data_r     <= data_r(6 downto 0) & spi_miso_i;
                  spi_sclk_o <= '1';
                  timer_next <= timer + CLK_PERIOD_CYCLES/2;
                  state      <= HIGH_ST;
               end if;

            when HIGH_ST =>
               if timer = timer_next then
                  -- output data is propagated on falling edge of SCLK.
                  spi_sclk_o <= '0';
                  spi_mosi_o <= data_r(7);
                  timer_next <= timer + CLK_PERIOD_CYCLES/2;
                  if counter > 0 then
                     counter <= counter - 1;
                     state   <= LOW_ST;
                  else
                     state   <= IDLE_ST;
                  end if;
               end if;
         end case;

         if rst_i = '1' then
            spi_sclk_o <= '0';
            spi_mosi_o <= '1';
            state      <= IDLE_ST;
         end if;
      end if;
   end process p_fsm;


   ----------------------
   -- Free running timer
   ----------------------

   p_timer : process (clk_i)
   begin
      if rising_edge(clk_i) then
         timer <= timer + 1;

         if rst_i = '1' then
            timer <= (others => '0');
         end if;
      end if;
   end process p_timer;

end architecture structural;


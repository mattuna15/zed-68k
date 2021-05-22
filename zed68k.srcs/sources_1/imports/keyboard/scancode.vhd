library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;

entity scancode is
   port (
      clk_i      : in  std_logic;
 
      keycode_i  : in  std_logic_vector(7 downto 0);
      valid_i    : in  std_logic;
      ascii_o    : out std_logic_vector(7 downto 0);
      valid_o    : out std_logic
   );
end entity scancode;

architecture structural of scancode is

   constant KBD_SHIFT_LEFT  : std_logic_vector(7 downto 0) := X"12";
   constant KBD_SHIFT_RIGHT : std_logic_vector(7 downto 0) := X"59";
   constant KBD_RELEASE     : std_logic_vector(7 downto 0) := X"F0";

   subtype t_ascii is std_logic_vector(7 downto 0);
   type t_keytab is array(0 to 131) of t_ascii;

   constant keytab_normal : t_keytab := (
	x"00",x"19",x"00",x"00",x"13",x"11",x"12",x"1C",x"00",x"1A",x"18",x"16",x"00",x"09",x"60",x"00", -- 0
	x"00",x"00",x"00",x"00",x"00",x"71",x"31",x"00",x"00",x"00",x"7A",x"73",x"61",x"77",x"32",x"00", -- 1
	x"00",x"63",x"78",x"64",x"65",x"34",x"33",x"00",x"00",x"20",x"76",x"66",x"74",x"72",x"35",x"00", -- 2
	x"00",x"6E",x"62",x"68",x"67",x"79",x"36",x"00",x"00",x"00",x"6D",x"6A",x"75",x"37",x"38",x"00", -- 3
	x"00",x"2C",x"6B",x"69",x"6F",x"30",x"39",x"00",x"00",x"2E",x"2F",x"6C",x"3B",x"70",x"2D",x"00", -- 4
	x"00",x"00",x"27",x"00",x"5B",x"3D",x"00",x"00",x"00",x"00",x"0D",x"5D",x"00",x"00",x"00",x"00", -- 5
	x"00",x"00",x"00",x"00",x"00",x"00",x"08",x"00",x"00",x"31",x"00",x"34",x"37",x"00",x"00",x"00", -- 6
	x"30",x"2E",x"32",x"35",x"36",x"38",x"03",x"00",x"1B",x"2B",x"33",x"2D",x"2A",x"39",x"00",x"00", -- 7
	x"00",x"00",x"00",x"17"
   );

   constant keytab_shifted : t_keytab := (
	x"00",x"19",x"00",x"00",x"13",x"11",x"12",x"1C",x"00",x"1A",x"18",x"16",x"00",x"09",x"00",x"00", -- 0
	x"00",x"00",x"00",x"00",x"00",x"51",x"21",x"00",x"00",x"00",x"5A",x"53",x"41",x"57",x"22",x"00", -- 1
	x"00",x"43",x"58",x"44",x"45",x"24",x"23",x"00",x"00",x"20",x"56",x"46",x"54",x"52",x"25",x"00", -- 2
	x"00",x"4E",x"42",x"48",x"47",x"59",x"5E",x"00",x"00",x"00",x"4D",x"4A",x"55",x"26",x"2A",x"00", -- 3
	x"00",x"3C",x"4B",x"49",x"4F",x"29",x"28",x"00",x"00",x"3E",x"3F",x"4C",x"3A",x"50",x"5F",x"00", -- 4
	x"00",x"00",x"40",x"00",x"7B",x"2B",x"00",x"00",x"00",x"00",x"0D",x"7D",x"00",x"00",x"00",x"00", -- 5
	x"00",x"00",x"00",x"00",x"00",x"00",x"08",x"00",x"00",x"31",x"00",x"34",x"37",x"00",x"00",x"00", -- 6
	x"30",x"2E",x"32",x"35",x"36",x"38",x"0C",x"00",x"1B",x"2B",x"33",x"2D",x"2A",x"39",x"00",x"00", -- 7
	x"00",x"00",x"00",x"17"
   );
   

   signal releasemode : std_logic;
   signal shifted     : std_logic;

   signal ascii       : std_logic_vector(7 downto 0);
   signal valid       : std_logic := '0';

begin

   --------------------------------
   -- State machine
   --------------------------------

   fsm_proc : process (clk_i)
   begin
      if rising_edge(clk_i) then
         valid <= '0';

         if valid_i = '1' then
            if releasemode = '1' then
               releasemode <= '0';
               if keycode_i = KBD_SHIFT_LEFT or keycode_i = KBD_SHIFT_RIGHT then
                  shifted <= '0';
               end if;
            else
               case keycode_i is
                  when KBD_RELEASE     => releasemode <= '1';
                  when KBD_SHIFT_LEFT  => shifted <= '1';
                  when KBD_SHIFT_RIGHT => shifted <= '1';
                  when others => 
                     if keycode_i(7) = '0' then
                        if shifted = '1' then
                           ascii <= keytab_shifted(to_integer(keycode_i(6 downto 0)));
                           valid <= '1';
                        else
                           ascii <= keytab_normal(to_integer(keycode_i(6 downto 0)));
                           valid <= '1';
                        end if;
                     end if;
               end case;
            end if;  -- else
         end if;   -- valid_i = '1'
      end if;
   end process fsm_proc;


   -----------------------
   -- Drive output signals
   -----------------------

   ascii_o <= ascii;
   valid_o <= valid;

end architecture structural;


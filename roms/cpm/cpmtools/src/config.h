/* config.h for MingW build of cpmtools
 *
 */
/* needed defines */

#define HAVE_MODE_T 1

#if 0
/* These are all handled by #ifdef MINGW */
/* needed for open() modes, e.g. O_RDONLY
#define HAVE_FCNTL_H 1

/* needed for maximum compiler values */
#define HAVE_LIMITS_H 1
#endif

/* needed header for Windows */
#define HAVE_WINDOWS_H 1

/* ++tlb - This is arbitrary, but any longer breaks Windows' cmd.exe's
 * ability to delete, copy and otherwise manipulate files, etc.
 *
 * This should be plenty long in any case.
 */
#define _POSIX_PATH_MAX 256

/* undefine for now - phase 2 */
#undef HAVE_LIBDSK_H


#line 1 "..\\ArtLib\\L_BltInc.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTINC.CPP
 * DESCRIPTION: Generates code for bit block transfer (blit) image copying
 *              and manipulation routines.  This file repeatedly includes
 *              the L_BLTCPY.cpp file and uses the C pre-processor to create
 *              the L_BLTINC.i file (containing many variations of the basic
 *              pixel copying function) which is then used by the main
 *              L_BLT.c file.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltInc.cpp 6     3/29/99 3:20p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltInc.cpp $
 * 
 * 6     3/29/99 3:20p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 5     3/25/99 8:59a Agmsmith
 * Restore corrupted SourceSafe files.
 * 
 * 5     3/24/99 5:40p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 4     9/21/98 6:11p Agmsmith
 * Added hole copies.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 5     8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 4     8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 3     8/12/98 4:04p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 3     7/27/98 4:54p Lzou
 * Have finished Alpha & Unity, and Alpha & Stretching bitmap copy.
 * 
 * 2     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/

/*****************************************************************************
 *****************************************************************************
 ** I N C L U D E   F I L E S                                               **
 *****************************************************************************
 ****************************************************************************/

#line 1 ".\\c_artlib.h"



/*****************************************************************************
 *
 * FILE:        C_ArtLib.h
 *
 * DESCRIPTION: The user changeable library configuration file.  The various
 *              defines here turn on and off parts of the library and set
 *              compile time limits for array sizes etc.
 *
 * Only defines are allowed in this file (because it is included before any
 * other types are defined).
 *
 * Note that this may be broken up into C_Grafix.h, C_Sound.h and other system
 * modules if we ever decide that it is more convenient to do it that way.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Projects - 1999/Mono 2/C_ArtLib.h 52    29/09/99 5:13p Agmsmith $
 *****************************************************************************
 * $Log: /Projects - 1999/Mono 2/C_ArtLib.h $
 * 
 * 52    29/09/99 5:13p Agmsmith
 * Now have voice chat.  Note that it doesn't do anything unless you also
 * turn on the enable flag in the game .INI file.
 * 
 * 51    28/09/99 6:38p Agmsmith
 * 
 * 50    9/24/99 10:52a Russellk
 * More 3D models allowed
 * 
 * 49    9/20/99 2:03p Russellk
 * Gotta buffer music
 * 
 * 48    20/09/99 12:04p Agmsmith
 * Added Bink video player.
 *
 * 47    9/20/99 11:14a Russellk
 *
 * 46    9/16/99 2:27p Russellk
 *
 * 45    9/14/99 12:11p Russellk
 * Speed test dropped - not used.
 *
 * 44    9/13/99 4:09p Russellk
 * Reduced stop warnings as our sound system does stops on sounds which
 * may have already stopped.
 *
 * 43    9/08/99 11:05a Russellk
 * Monpoly cd now required
 *
 * 42    8/27/99 12:24p Russellk
 *
 * 41    8/20/99 10:58a Agmsmith
 * Added error message controls for SetPitch and SetCamera and
 * SetViewport.
 *
 * 40    8/20/99 10:25a Russellk
 *
 * 39    8/17/99 4:56p Russellk
 * Now requires a CD, soon will require one named monopoly.
 *
 * 38    8/13/99 10:41a Russellk
 * Global sound level lowered
 *
 * 37    8/11/99 12:12 Davew
 * Turned off the use of the old frame stuff for PC3D.
 *
 * 36    8/04/99 2:31p Russellk
 *
 * 35    8/03/99 3:05p Agmsmith
 * Added default sound level to compensate for poorly recorded sound
 * samples.
 *
 * 34    7/27/99 16:20 Davew
 * Disabled the new Frame/Mesh stuff
 *
 * 33    7/27/99 15:29 Davew
 * Added the CE_ARTLIB_3DUsingOldFrame #define
 *
 * 32    7/21/99 11:26a Russellk
 *
 * 31    7/20/99 11:05a Agmsmith
 *
 * 30    7/20/99 9:47a Agmsmith
 * Updated with new and delete override define.
 *
 * 29    7/19/99 2:38p Agmsmith
 * Updated to match current library version.
 *
 * 28    6/21/99 11:54a Timp
 * Turned off multitasking
 *
 * 27    6/11/99 11:31a Russellk
 *
 * 26    6/03/99 5:02p Timp
 * Added MONOPOLY2000 define for L_Main.cpp to detect.  L_Main has to do
 * editbox handling for the M2K chat module.
 *
 * 25    5/31/99 3:35p Russellk
 *
 * 24    5/30/99 4:16p Russellk
 * gaphics debug lines added
 *
 * 23    5/27/99 3:29p Davide
 * Added 200 extra runtime memory items for the custom board editor
 *
 * 22    5/12/99 9:53a Russellk
 *
 * 21    4/29/99 3:20p Russellk
 *
 * 20    27/04/99 19:32 Timp
 * Turn on Unicode
 *
 * 19    4/27/99 3:05p Russellk
 *
 * 18    4/27/99 2:56p Russellk
 *
 * 17    4/15/99 1:36p Kens
 * changed CE_ARTLIB_EnableSystemGrafix3D to TRUE
 *
 * 16    4/13/99 1:55p Russellk
 * Modifed to use setbackdrop & other demo defines
 *
 * 15    4/12/99 2:51p Russellk
 *
 * 14    4/09/99 17:38 Davew
 * Changed some video buffering settings
 *
 * 13    4/09/99 10:42 Davew
 * Enabled the system video
 *
 * 12    4/09/99 9:51 Davew
 * Added the new video defs
 *
 * 11    4/05/99 4:13p Russellk
 * Extra shade level support
 *
 * 10    3/30/99 1:45p Russellk
 *
 * 9     3/25/99 9:34a Russellk
 *
 * 8     3/24/99 9:41a Russellk
 *
 * 7     3/04/99 8:53a Russellk
 * IBar complete with Programmer graphics - 5 more (easy) bars to program
 * when finished graphics are ready.
 *
 * 6     2/19/99 4:14p Russellk
 * IBAR current player support for starter functions.  Colors go with
 * player, property bar running, mouseovers for everything.
 *
 * 5     2/17/99 8:45a Russellk
 *
 * 4     2/11/99 2:08p Russellk
 * New IBAR look & features begun.
 *
 * 3     2/03/99 2:52p Russellk
 * Library update
 *
 * 34    2/02/99 12:15p Agmsmith
 * More chunky options.
 *
 * 33    2/01/99 4:49p Agmsmith
 * More chunky options.
 *
 * 32    2/01/99 2:54p Agmsmith
 * Adding sequencer commands for setting video attributes.
 *
 * 31    1/27/99 7:35p Agmsmith
 * Optionally prompt the user when saving files overwrites the file.
 *
 * 30    1/26/99 12:38p Agmsmith
 * Only enable the DopeTab converter if the user wants it.
 *
 * 29    1/19/99 12:05p Agmsmith
 *
 * 28    1/19/99 11:58a Agmsmith
 *
 * 27    1/19/99 11:52a Agmsmith
 * Remove unnecessary features.
 *
 * 26    1/18/99 2:00p Agmsmith
 * Documentation improvements.
 *
 * 25    1/17/99 2:38p Agmsmith
 * Adding DirIni module: directory paths and .INI files.
 *
 * 24    1/16/99 4:42p Agmsmith
 * Allow optional use of old blitter routines.
 *
 * 20    1/07/99 6:32p Agmsmith
 * More changes for Dope Sheet - GrowChunk related.
 *
 * 18    12/09/98 5:28p Agmsmith
 * Added URL data source.
 *
 * 17    11/02/98 5:21p Agmsmith
 * Added external file data source.
 *
 * 16    10/29/98 6:37p Agmsmith
 * New improved memory and data system added.  Memory and data systems
 * have been separated.  Now have memory pools, and optional corruption
 * check.  The data system has data groups rather than files and
 * individual items can come from any data source. Also has a least
 * recently used data unloading system (rather than programmer set
 * priorities).  And it can all be turned off for AndrewX!
 *
 * 1     9/15/98 10:05a Agmsmith
 * Library control defines now in a separate file from the main program
 * exports, so that they can be included early without worrying about
 * defining data types.
 ****************************************************************************/

// What game am I?  L_Main.cpp needs to know for Monopoly 2000 chat stuff.


/*****************************************************************************
 * For the following flags set the define to 1 if you want the mode enabled
 * or set the define to 0 if you want the mode disabled.
 */


// - Enable this flag for debug mode (enables sanity checking).





// Enables the library for various destination platforms.
// Currently only Win95 is supported and therefore should be the only one set,
// but hopefully some of the modules can be reused for both.  But only if
// people stop trying to reinvent the wheel!  Argh.


// Some compilers can't handle variables that are declared as being enum
// types, instead use an integer to hold them (but the enum will still
// be used to define the constants).  Other compilers allow enums and
// even show the symbolic names for values in the debugger.


// Controls which character set is used for ACHAR and related functions.
// If 1 then Unicode and 16 bit characters are used (useful for doing
// international games), 0 for ordinary ASCII.


// Enable this flag to turn on Multitasking (game thread separate from the
// animation thread, so that you get smoother animations).  Disable it for
// games that have a main loop that runs once per frame (input, compute,
// draw, repeat).


// Set this to non-zero to disable the overridden new and delete operators
// in PC3D, which can cause problems when compiling with MFC which also
// overrides the global new and delete operators.  Automatically turns it
// off when not using the PC3D stuff.



/*****************************************************************************
 * Enable flags for the various systems (and sub-systems) contained in the
 * library.  If you wish to remove a system set the flag to zero and recompile
 * library from scratch.  An unused system removed from memory with provide
 * smaller executable code.  Most systems are fairly independent but some are
 * not. For example you cannot remove the Memory system without removing the
 * Data system (it will be obvious at link time which one you are missing).
 *
 * Please add new systems in alphabetical order to this list.
 */

































/*****************************************************************************
 * Parameters and other compile time settings for the various systems, again
 * in alphabetical order by system.
 */

// Button defines.

// 1 to use messages from the L_UIMSG module for setting mouse position, 0 for
// using ordinary Windows messages.  If ordinary Windows messages are used then
// the button code is called from a different thread than the game and can
// push buttons while the game isn't expecting them.  If you use UIMSG mode then
// your game code has to call the LI_BUTTON_ProcessInputMessage.

// Defines the number of button lists to allocate. Each button list can have
// any number of buttons. Buttons are given priority based on the button list
// they are contained in and the order of the buttons within each button list.
// Button lists are specified by a number between 0 and BUTTON_NUMBER_OF_BUTTON_LISTS - 1,
// where button list N has a higher priority than button list N+1. This means all
// buttons in button list N have a higher priority than all buttons in button list
// N+1. Further, in any button list N, buttons are ordered from 0 to the number of
// buttons in the list minus 1 where similarly, button X in the list will have a higher
// priority than button X+1 in the list. It is important to keep this in mind when
// designing button lists because unless a button is transparent, processing stops
// after one button is triggered.
// You can define any number of button lists you want. However the more
// button lists, and thus more buttons are defined, the more memory
// is required and also more processing time.


// Chunky file stuff.

// If you don't need to write chunks to files or DataIDs then turn this off.

// Enables the routine for inserting and deleting inside a chunky DataID.

// Enables the routines used by the dope sheet for manipulating chunky
// sequences (things like creating a new sequence, adding frames, ...).

// Turns on routines for dumping chunks to a text file and loading them
// from a text file.

// Turns on code used for loading chunky files by file name, and processing
// the file name subchunks while loading.

// Kind of like maximum number of open files, except for chunk readers.

// A multiple of 4 is good.

// Should be large enough to hold the largest possible lowest level subchunk.


// Data System Defines

// Number of data groups (kind of like the old data files) that can exist,
// user groups are numbered from 1 to this value minus 1.  There is also a
// special data group for in-memory items just after the user groups.  The
// high word in a DataID thus can be from 1 to CE_ARTLIB_DataMaxGroups
// inclusive.

// Maximum number of runtime created data items simultaneously allocated,
// for things like temporary bitmaps identified by a DataID.  In other
// words, this is the size of the memory (and other sources) data group,
// that's the group with index number equal to CE_ARTLIB_DataMaxGroups.




// These enable and disable the various different kinds of data source,
// mostly to save space by not compiling the code needed for ones you
// don't use.

// Enables the code which can write out changed data items.  This also
// enables code which converts internal formats into external file
// formats (such as a bitmap to PNG converter).  This is useful for
// tools like the dope sheet, but not needed for most games (unless
// you want to conveniently do a screen dump to a file).

// If TRUE then the data system will automatically unload data items until it
// has enough free memory space in the data pool, when it is loading some
// other data item.  The least recently used item(s) will be the one(s) to be
// unloaded.  If FALSE (zero) then you just run out of memory when loading
// when there isn't any free memory.  Items with reference counts aren't
// unloaded in any case.  Also, if FALSE, there will be less CPU overhead when
// accessing data items (moving item to top of doubly linked list) and less
// memory used (4 bytes per item for previous pointer, next is still used).

// Enable this to turn on the hash table which lets you find DataIDs based
// on the file name.  Useful for utilities like the dope sheet which don't
// have a data file and DataIDs, just file names linking data together.

// Enable this to allow direct reading of TAB files (8 bit with alpha
// transparency) and internal conversion to UAP (NEWBITMAPHEADER) format.
// Also reads 8 bit BMP images and converts them to UAPs too.

// Enable this to make the external file data source ask for permission
// when it saves to a file.

// Set to 1 to collect the usage statistics and dump them to the debug log
// when data files are closed etc.  Only works in debug mode.  0 for none.



// Grafix system defines






// - Requested screen size for this application.


// Bit block copy routine defines.

// Set to 1 to turn on bounding box checks while bliting - warns you if you are
// copying outside the bitmap.  Leave zero or don't use debug mode to turn it off.


// Which colour to use for the ColorKeyPureGreenBitBlt series
// of functions.  Note that the alpha blit still uses the old
// pure green only code (there's too much stuff to fix).
// Pick only one of these, or pick none if you want black to
// be the transparent colour.  Also see LE_BLT_KeyRedLimit etc.

// Turn this on to use the older blitter routines, they are slightly
// faster (use MMX) for the 8 bit to N bit copies but have math problems
// (can't draw 1 pixel tall, cuts off half a pixel on the edges of
// source images, can't scale true colour images).  The new routines
// also have problems, mostly with clipping and a confusing API (needs
// to be rethought).

// To enable full 255 levels of alpha channel effects instead of normal
// 16 alpha levels. The new 255 alpha levels ranges from 0 (transparent),
// 1*255/255, 2*255/255, ..., 255*255/255. This works for both bitmap
// unity and stretch copies of 16to16, 24to24, and 32to32 bit colour depths.


// Main program defines.


// Note that the window message processing thread is at the normal thread
// priority.  All other threads must be at lower priorities otherwise the
// gradual windows slowdown bug will happen (as the windows kernel queue
// grows larger and larger).

// String given as your window class name and used for the window title too,
// and copied to the LE_MAIN_ApplicationNameString variable (which you should
// use instead, to avoid wasting memory).

// Name you want to use for your .INI user preferences file.  This file will
// be in the same directory as the program executable.  Used for the global
// search path list as well as your stuff.

// This is the disk label on the CD-ROM for the game.  The program will look
// for a CD-ROM drive with a disk in it with this label (in case the user has
// several drives, and for copy protection).  You set the label when you make
// the CD-ROM.  Then, if found, the magic path name of "CD:" will be replaced
// with the actual drive letter of the CD-ROM.  Use "" if your game will work
// with any CD-ROM and NULL if you don't want to check for a CD-ROM.

// Add user defined Windows messages here.


// Memory System Defines.




// The initial sizes of the standard memory pools.  The User one is used for
// runtime allocated memory (but not runtime data items).  The Data pool is
// used by the data system only (included runtime created data items), it can
// deallocate items when it needs space and reallocate and reload them later
// when it needs the item.  The user pool on the other hand has to stick
// around because it can't be reloaded, which is why it is separate.

// Number of memory pools that the system can keep track of, should be at
// least 3 for the standard user, library and data pools.


// Fills memory with $AA when freshly allocated, fills it with
// $BB when it is deallocated.  Useful for debugging.  Also,
// CE_ARTLIB_MemoryBoundsCheckMargin bytes before and after the
// allocated block are filled with a serial number that gets
// checked during deallocation to see if you are overwriting
// memory.


// Keyboard system defines.

// Set to nonzero if you want to use the array of latched keys feature.
// Normally you should use the UIMSG keyboard messages, since using
// the arrays can lead to lost keys (like when the user hits the same
// key twice while you are busy doing something else, or hits multiple
// keys and you then can't tell which one was first).

// Mouse system defines

// Turn on if you want UIMSG_MOUSE_MOVED messages, which can slow you down
// since there are a lot of them (about 60 per second).  If you use the
// button module and you want roll-over buttons (ones that semi-press when
// you wave the mouse over them), then you need to turn this on.
// Note that even with this off, you still get mouse click messages.

// Use this if you wish to monitor mouse activity without using messages,
// though it isn't as reliable as the messages since you can miss clicks
// and get the order of clicking wrong.



// Sequencer (new animation engine) defines.



































// General render defines.


// Rend3D system defines



// Just array size limits for the hack which maps PC3D pointers into DataIDs.

// Indicates we are using the old frame/mesh classes in PC3D



// Sound system defines.  Note that current values are in LE_SOUND_CurrentHardwareHz etc.

// Desired speed of the output mixed sound.

// Desired bits per sample of the output mixed sound.

// 2 for stereo, 1 for mono output.

// Non-zero to enable the use of 3D sounds.

// Spooling seems to kill performance - only a couple background sounds get this long.
// Sounds this long or shorter get fully decompressed and loaded into memory
// (their own DirectSound buffer) and not spooled.  They are also eligible for
// caching.

// Spooled sounds use a DirectSound buffer this long, should be as long as the
// longest delay between feedings.  On a P-90 running the Pony game over the
// network this can be 7 seconds.

// Number of non-spooled data file based sounds that can have their
// DirectSound buffers cached for quick replay.  Use zero to turn off this
// caching feature and associated code.

// Non-zero to enable the voice chat feature.  Of course, you also
// have to check for data and send it across the network for it to work.

// Maximum number of voice chats you expect to be listening to
// simultaneously, usually equal to the maximum number of players
// plus a few spectators.  A sound buffer will be allocated for
// each one up to this maximum.  Don't make it too large since it
// does a linear search to map player IDs to buffers.


// Timer system defines

// Just how many timers do you want to use today?
// Extra ones will slow down your game a bit.

// Set this to the standard update rate for ticks.  This is 60 for 60hz
// that comes from North American TV and power system update rates.
// In some European countries it is 50.


// User Interface Message system defines.

// Size of the event queue in messages.


// Video system defines

// 1 to enable multi-tasking mode for avi data buffering
// 0 to switch to normal single-threaded video player

// 0 -- switch on normal video playback mode
// 1 -- switch on video frame jump playback mode

// Number of preallocated avi data buffers for avi data preloading.
// Normally, 3 avi data buffers are enough. More avi data buffers may
// be helpful when sometimes playing back an enormous big video clip
// or on a slow computer.

// This instructs the video player to roughly each time buffer a
// user specified (MULTIPLE_SECONDS_DATA) seconds of avi data. Thus,
// the video player buffers the following amount of data (in seconds)
// CE_ARTLIB_VideoAVIBufferNumber * CE_ARTLIB_VideoMultipleSecondsData.

// This is only for debugging/testing purpose, showing how many avi data
// buffers are used, how much amount of avi data are preloaded, and how they
// are fed. This is useful when playing back video clips on a slow machine.
// Four colours are used to show the video player's buffering states.
//    yellowish green  -- current (playing) avi data buffer
//    black            -- empty avi data buffer
//    blue             -- freshly loaded avi data (both audio and video data)
//    red              -- buffer with valid video data (audio data are fed)
//

// Init system Defines

// When set to 0 the game shutdown MessageBox is not displayed.
// Available in debug mode only.

#line 644 ".\\c_artlib.h"
#line 72 "..\\ArtLib\\L_BltInc.cpp"
// Needed for CE_ARTLIB_BlitUseGreenColourKey and other defines.



/*****************************************************************************
 *****************************************************************************
 ** M A C R O   D E F I N I T I O N S                                       **
 *****************************************************************************
 ****************************************************************************/




  // Used for making defines which get done in the second pass, when the
  // L_BLTINC.i file is included by L_BLT.c.  Needed because the ## token
  // concatenator can't take symbolic arguments.

// Some symbolic defines used to control code generation.  Can't use an enum,
// since this is for the preprocessor.









/*****************************************************************************
 *****************************************************************************
 ** G L O B A L   V A R I A B L E S                                         **
 *****************************************************************************
 ****************************************************************************/

/*****************************************************************************
 *****************************************************************************
 ** S T A T I C   V A R I A B L E S                                         **
 *****************************************************************************
 ****************************************************************************/



/*****************************************************************************
 *****************************************************************************
 ** I M P L E M E N T A T I O N   C O D E                                   **
 *****************************************************************************
 ****************************************************************************/

// Generate blitter copy functions by repeatedly including L_BLTCPY.c with
// assorted different defines for source and destination depths and other
// settings.

//
// =============================================================
//
//          Unity & Solid, Raw bitmap copy
//







#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 16 ## Solid ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 16, Solid, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        
          

#line 406 "..\\ArtLib\\L_BLTCPY.cpp"
            int             PixelsAcrossToBlt;        // blt width in pixels
            register int    PixelCounter;             // pixel counter

            register DWORD  dwSourceData;             // holder for source data

            
              register DWORD   dwDestinationData1;                // holders for destination data
            



#line 418 "..\\ArtLib\\L_BLTCPY.cpp"
            register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
            register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
          #line 421 "..\\ArtLib\\L_BLTCPY.cpp"
        

















#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX;
        











#line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 2;
        







#line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        
          







#line 577 "..\\ArtLib\\L_BLTCPY.cpp"
            PixelsAcrossToBlt = CopyWidth;
          #line 579 "..\\ArtLib\\L_BLTCPY.cpp"
        



#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        























#line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        

          

#line 619 "..\\ArtLib\\L_BLTCPY.cpp"
            // initialise current blt pointers
            lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
            lpSourceBltPointer = lpSourceScanlineBeginBlt;
          
            // initialise pixel counter
            PixelCounter = PixelsAcrossToBlt;
            while (PixelCounter > 0)
            {
              // process four pixels at a time if possible
              if (PixelCounter >= 4)
              {
                // get four pixels of source data
                
                  dwSourceData = *((LPLONG)lpSourceBltPointer);
                  lpSourceBltPointer += 4;
                #line 635 "..\\ArtLib\\L_BLTCPY.cpp"
              
                
                  // convert 8 bit indices to 16 bit color values
                  dwDestinationData1 = (WORD)SourceColorTable[(dwSourceData & 0xff) * 2];
                  dwSourceData >>= 8;
                  dwDestinationData1 |= SourceColorTable[(dwSourceData & 0xff) * 2] << 16;
                  dwSourceData >>= 8;

                  // copy the converted data to destination bitmap
                  *((LPLONG)lpDestinationBltPointer) = dwDestinationData1;
                  lpDestinationBltPointer += 4;
                  dwDestinationData1 = (WORD)SourceColorTable[(dwSourceData & 0xff) * 2];
                  dwSourceData >>= 8;
                  dwDestinationData1 |= SourceColorTable[(dwSourceData & 0xff) * 2] << 16;
                  *((LPLONG)lpDestinationBltPointer) = dwDestinationData1;
                  lpDestinationBltPointer += 4;

                

































#line 687 "..\\ArtLib\\L_BLTCPY.cpp"

                  // decrement the PixelCounter by 4
                  PixelCounter -= 4;
              }
              // process two pixels at a time if possible
              else if (PixelCounter >= 2)
              {
                // get two pixels of source data
                
                  dwSourceData = *((LPWORD)lpSourceBltPointer);
                  lpSourceBltPointer += 2;
                #line 699 "..\\ArtLib\\L_BLTCPY.cpp"
              
                
                  // convert 8 bit indices to 16 bit color values
                  // and copy the converted data to destination bitmap
                  dwDestinationData1 = (WORD)SourceColorTable[(dwSourceData & 0xff) * 2];
                  dwSourceData >>= 8;
                  dwDestinationData1 |= SourceColorTable[(dwSourceData & 0xff) * 2] << 16;
                  *((LPLONG)lpDestinationBltPointer) = dwDestinationData1;
                  lpDestinationBltPointer += 4;

                




















#line 731 "..\\ArtLib\\L_BLTCPY.cpp"

                  // decrement the pixel counter by 2
                  PixelCounter -= 2;
              }
              // process one pixel
              else
              {
                // get one pixel of source data
                
                  dwSourceData = *((LPBYTE)lpSourceBltPointer);
                  lpSourceBltPointer += 1;
                #line 743 "..\\ArtLib\\L_BLTCPY.cpp"
              
                
                  // convert 8 bit indices to 16 bit color values
                  // and copy the converted data to destination bitmap
                  dwDestinationData1 = SourceColorTable[(dwSourceData & 0xff) * 2];
                  *((LPWORD)lpDestinationBltPointer) = (WORD)dwDestinationData1;
                  lpDestinationBltPointer += 2;

                














#line 767 "..\\ArtLib\\L_BLTCPY.cpp"

                  // decrement the pixel counter by 1
                  PixelCounter -= 1;
              }
            }
          #line 773 "..\\ArtLib\\L_BLTCPY.cpp"

        





















































































































































































































































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 137 "..\\ArtLib\\L_BltInc.cpp"



#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 24 ## Solid ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 24, Solid, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        
          

#line 406 "..\\ArtLib\\L_BLTCPY.cpp"
            int             PixelsAcrossToBlt;        // blt width in pixels
            register int    PixelCounter;             // pixel counter

            register DWORD  dwSourceData;             // holder for source data

            

#line 414 "..\\ArtLib\\L_BLTCPY.cpp"
              register DWORD   dwDestinationData1;                // holders for destination data
              register DWORD   dwDestinationData2;
              register DWORD   dwDestinationData3;
            #line 418 "..\\ArtLib\\L_BLTCPY.cpp"
            register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
            register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
          #line 421 "..\\ArtLib\\L_BLTCPY.cpp"
        

















#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 525 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX;
        











#line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        



#line 555 "..\\ArtLib\\L_BLTCPY.cpp"
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 3;
        



#line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        
          







#line 577 "..\\ArtLib\\L_BLTCPY.cpp"
            PixelsAcrossToBlt = CopyWidth;
          #line 579 "..\\ArtLib\\L_BLTCPY.cpp"
        



#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        























#line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        

          

#line 619 "..\\ArtLib\\L_BLTCPY.cpp"
            // initialise current blt pointers
            lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
            lpSourceBltPointer = lpSourceScanlineBeginBlt;
          
            // initialise pixel counter
            PixelCounter = PixelsAcrossToBlt;
            while (PixelCounter > 0)
            {
              // process four pixels at a time if possible
              if (PixelCounter >= 4)
              {
                // get four pixels of source data
                
                  dwSourceData = *((LPLONG)lpSourceBltPointer);
                  lpSourceBltPointer += 4;
                #line 635 "..\\ArtLib\\L_BLTCPY.cpp"
              
                















#line 653 "..\\ArtLib\\L_BLTCPY.cpp"
                  // convert 8 bit indices to 24 bit color values
                  dwDestinationData1 = SourceColorTable[(dwSourceData & 0xff) * 2];
                  dwSourceData >>= 8;
                  dwDestinationData1 |= SourceColorTable[(dwSourceData & 0xff) * 2] << 24;
                  dwDestinationData2 = SourceColorTable[(dwSourceData & 0xff) * 2] >> 8;
                  dwSourceData >>= 8;
                  dwDestinationData2 |= SourceColorTable[(dwSourceData & 0xff) * 2] << 16;
                  dwDestinationData3 = SourceColorTable[(dwSourceData & 0xff) * 2] >> 16;
                  dwSourceData >>= 8;
                  dwDestinationData3 |= SourceColorTable[(dwSourceData & 0xff) * 2] << 8;

                  // copy the converted data to destination bitmap
                  *((LPLONG)lpDestinationBltPointer) = dwDestinationData1;
                  lpDestinationBltPointer += 4;
                  *((LPLONG)lpDestinationBltPointer) = dwDestinationData2;
                  lpDestinationBltPointer += 4;
                  *((LPLONG)lpDestinationBltPointer) = dwDestinationData3;
                  lpDestinationBltPointer += 4;

                













#line 687 "..\\ArtLib\\L_BLTCPY.cpp"

                  // decrement the PixelCounter by 4
                  PixelCounter -= 4;
              }
              // process two pixels at a time if possible
              else if (PixelCounter >= 2)
              {
                // get two pixels of source data
                
                  dwSourceData = *((LPWORD)lpSourceBltPointer);
                  lpSourceBltPointer += 2;
                #line 699 "..\\ArtLib\\L_BLTCPY.cpp"
              
                








#line 710 "..\\ArtLib\\L_BLTCPY.cpp"
                  // convert 8 bit indices to 24 bit color values
                  dwDestinationData1 = SourceColorTable[(dwSourceData & 0xff) * 2];
                  dwSourceData >>= 8;
                  dwDestinationData1 |= SourceColorTable[(dwSourceData & 0xff) * 2] << 24;
                  dwDestinationData2 = SourceColorTable[(dwSourceData & 0xff) * 2] >> 8;

                  // copy the converted data to destination bitmap
                  *((LPLONG)lpDestinationBltPointer) = dwDestinationData1;
                  lpDestinationBltPointer += 4;
                  *((LPWORD)lpDestinationBltPointer) = (WORD)dwDestinationData2;
                  lpDestinationBltPointer += 2;

                







#line 731 "..\\ArtLib\\L_BLTCPY.cpp"

                  // decrement the pixel counter by 2
                  PixelCounter -= 2;
              }
              // process one pixel
              else
              {
                // get one pixel of source data
                
                  dwSourceData = *((LPBYTE)lpSourceBltPointer);
                  lpSourceBltPointer += 1;
                #line 743 "..\\ArtLib\\L_BLTCPY.cpp"
              
                






#line 752 "..\\ArtLib\\L_BLTCPY.cpp"
                  // convert 8 bit indices to 24 bit color values
                  dwDestinationData1 = SourceColorTable[(dwSourceData & 0xff) * 2];

                  // copy the converted data to destination bitmap
                  *((LPWORD)lpDestinationBltPointer) = (WORD)(dwDestinationData1);
                  lpDestinationBltPointer += 2;
                  *((LPBYTE)lpDestinationBltPointer) = (BYTE)(dwDestinationData1 >> 16);
                  lpDestinationBltPointer += 1;

                




#line 767 "..\\ArtLib\\L_BLTCPY.cpp"

                  // decrement the pixel counter by 1
                  PixelCounter -= 1;
              }
            }
          #line 773 "..\\ArtLib\\L_BLTCPY.cpp"

        





















































































































































































































































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 141 "..\\ArtLib\\L_BltInc.cpp"



#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 32 ## Solid ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 32, Solid, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        
          

#line 406 "..\\ArtLib\\L_BLTCPY.cpp"
            int             PixelsAcrossToBlt;        // blt width in pixels
            register int    PixelCounter;             // pixel counter

            register DWORD  dwSourceData;             // holder for source data

            

#line 414 "..\\ArtLib\\L_BLTCPY.cpp"



#line 418 "..\\ArtLib\\L_BLTCPY.cpp"
            register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
            register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
          #line 421 "..\\ArtLib\\L_BLTCPY.cpp"
        

















#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 525 "..\\ArtLib\\L_BLTCPY.cpp"

#line 527 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = DestinationBitmapWidth * 4;
        #line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX;
        











#line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        



#line 555 "..\\ArtLib\\L_BLTCPY.cpp"



#line 559 "..\\ArtLib\\L_BLTCPY.cpp"
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 4;
        #line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        
          







#line 577 "..\\ArtLib\\L_BLTCPY.cpp"
            PixelsAcrossToBlt = CopyWidth;
          #line 579 "..\\ArtLib\\L_BLTCPY.cpp"
        



#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        























#line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        

          

#line 619 "..\\ArtLib\\L_BLTCPY.cpp"
            // initialise current blt pointers
            lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
            lpSourceBltPointer = lpSourceScanlineBeginBlt;
          
            // initialise pixel counter
            PixelCounter = PixelsAcrossToBlt;
            while (PixelCounter > 0)
            {
              // process four pixels at a time if possible
              if (PixelCounter >= 4)
              {
                // get four pixels of source data
                
                  dwSourceData = *((LPLONG)lpSourceBltPointer);
                  lpSourceBltPointer += 4;
                #line 635 "..\\ArtLib\\L_BLTCPY.cpp"
              
                















#line 653 "..\\ArtLib\\L_BLTCPY.cpp"



















#line 673 "..\\ArtLib\\L_BLTCPY.cpp"
                  // convert 8 bit indices to 32 bit color values
                  // and copy the converted data to destination bitmap
                  *((LPLONG)lpDestinationBltPointer) = SourceColorTable[(dwSourceData & 0xff) * 2];
                  lpDestinationBltPointer += 4;
                  dwSourceData >>= 8;
                  *((LPLONG)lpDestinationBltPointer) = SourceColorTable[(dwSourceData & 0xff) * 2];
                  lpDestinationBltPointer += 4;
                  dwSourceData >>= 8;
                  *((LPLONG)lpDestinationBltPointer) = SourceColorTable[(dwSourceData & 0xff) * 2];
                  lpDestinationBltPointer += 4;
                  dwSourceData >>= 8;
                  *((LPLONG)lpDestinationBltPointer) = SourceColorTable[(dwSourceData & 0xff) * 2];
                  lpDestinationBltPointer += 4;
                #line 687 "..\\ArtLib\\L_BLTCPY.cpp"

                  // decrement the PixelCounter by 4
                  PixelCounter -= 4;
              }
              // process two pixels at a time if possible
              else if (PixelCounter >= 2)
              {
                // get two pixels of source data
                
                  dwSourceData = *((LPWORD)lpSourceBltPointer);
                  lpSourceBltPointer += 2;
                #line 699 "..\\ArtLib\\L_BLTCPY.cpp"
              
                








#line 710 "..\\ArtLib\\L_BLTCPY.cpp"












#line 723 "..\\ArtLib\\L_BLTCPY.cpp"
                  // convert 8 bit indices to 32 bit color values
                  // and copy the converted data to destination bitmap
                  *((LPLONG)lpDestinationBltPointer) = SourceColorTable[(dwSourceData & 0xff) * 2];
                  lpDestinationBltPointer += 4;
                  dwSourceData >>= 8;
                  *((LPLONG)lpDestinationBltPointer) = SourceColorTable[(dwSourceData & 0xff) * 2];
                  lpDestinationBltPointer += 4;
                #line 731 "..\\ArtLib\\L_BLTCPY.cpp"

                  // decrement the pixel counter by 2
                  PixelCounter -= 2;
              }
              // process one pixel
              else
              {
                // get one pixel of source data
                
                  dwSourceData = *((LPBYTE)lpSourceBltPointer);
                  lpSourceBltPointer += 1;
                #line 743 "..\\ArtLib\\L_BLTCPY.cpp"
              
                






#line 752 "..\\ArtLib\\L_BLTCPY.cpp"









#line 762 "..\\ArtLib\\L_BLTCPY.cpp"
                  // convert 8 bit indices to 32 bit color values
                  // and copy the converted data to destination bitmap
                  *((LPLONG)lpDestinationBltPointer) = SourceColorTable[(dwSourceData & 0xff) * 2];
                  lpDestinationBltPointer += 4;
                #line 767 "..\\ArtLib\\L_BLTCPY.cpp"

                  // decrement the pixel counter by 1
                  PixelCounter -= 1;
              }
            }
          #line 773 "..\\ArtLib\\L_BLTCPY.cpp"

        





















































































































































































































































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 145 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 16 ## To ## 16 ## Solid ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (16, 16, Solid, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        
          
            int     BytesAcrossToBlt;               // blt width in bytes
          














#line 421 "..\\ArtLib\\L_BLTCPY.cpp"
        

















#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        

#line 515 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = (SourceBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        



#line 536 "..\\ArtLib\\L_BLTCPY.cpp"
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX * 2;
        







#line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 2;
        







#line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        
          
            
              BytesAcrossToBlt = CopyWidth * 2;
            



#line 576 "..\\ArtLib\\L_BLTCPY.cpp"
          

#line 579 "..\\ArtLib\\L_BLTCPY.cpp"
        



#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        























#line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        

          
              memcpy(lpDestinationScanlineBeginBlt, lpSourceScanlineBeginBlt, BytesAcrossToBlt);
          

























































































































































#line 773 "..\\ArtLib\\L_BLTCPY.cpp"

        





















































































































































































































































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 151 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 24 ## To ## 24 ## Solid ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (24, 24, Solid, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        
          
            int     BytesAcrossToBlt;               // blt width in bytes
          














#line 421 "..\\ArtLib\\L_BLTCPY.cpp"
        

















#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        

#line 515 "..\\ArtLib\\L_BLTCPY.cpp"

#line 517 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = (SourceBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 525 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        



#line 536 "..\\ArtLib\\L_BLTCPY.cpp"



#line 540 "..\\ArtLib\\L_BLTCPY.cpp"
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX * 3;
        



#line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        



#line 555 "..\\ArtLib\\L_BLTCPY.cpp"
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 3;
        



#line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        
          
            

#line 572 "..\\ArtLib\\L_BLTCPY.cpp"
              BytesAcrossToBlt = CopyWidth * 3;
            

#line 576 "..\\ArtLib\\L_BLTCPY.cpp"
          

#line 579 "..\\ArtLib\\L_BLTCPY.cpp"
        



#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        























#line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        

          
              memcpy(lpDestinationScanlineBeginBlt, lpSourceScanlineBeginBlt, BytesAcrossToBlt);
          

























































































































































#line 773 "..\\ArtLib\\L_BLTCPY.cpp"

        





















































































































































































































































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 157 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 32 ## To ## 32 ## Solid ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (32, 32, Solid, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        
          
            int     BytesAcrossToBlt;               // blt width in bytes
          














#line 421 "..\\ArtLib\\L_BLTCPY.cpp"
        

















#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        

#line 515 "..\\ArtLib\\L_BLTCPY.cpp"

#line 517 "..\\ArtLib\\L_BLTCPY.cpp"

#line 519 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = SourceBitmapWidth * 4;
        #line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 525 "..\\ArtLib\\L_BLTCPY.cpp"

#line 527 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = DestinationBitmapWidth * 4;
        #line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        



#line 536 "..\\ArtLib\\L_BLTCPY.cpp"



#line 540 "..\\ArtLib\\L_BLTCPY.cpp"



#line 544 "..\\ArtLib\\L_BLTCPY.cpp"
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX * 4;
        #line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        



#line 555 "..\\ArtLib\\L_BLTCPY.cpp"



#line 559 "..\\ArtLib\\L_BLTCPY.cpp"
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 4;
        #line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        
          
            

#line 572 "..\\ArtLib\\L_BLTCPY.cpp"

#line 574 "..\\ArtLib\\L_BLTCPY.cpp"
              BytesAcrossToBlt = CopyWidth * 4;
            #line 576 "..\\ArtLib\\L_BLTCPY.cpp"
          

#line 579 "..\\ArtLib\\L_BLTCPY.cpp"
        



#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        























#line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        

          
              memcpy(lpDestinationScanlineBeginBlt, lpSourceScanlineBeginBlt, BytesAcrossToBlt);
          

























































































































































#line 773 "..\\ArtLib\\L_BLTCPY.cpp"

        





















































































































































































































































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 163 "..\\ArtLib\\L_BltInc.cpp"

//
//
// =============================================================
//
//          Unity & Solid with Colour Key, Raw bitmap copy
//














#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 16 ## SolidColourKey ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 16, SolidColourKey, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        


















#line 422 "..\\ArtLib\\L_BLTCPY.cpp"
          int             PixelsAcrossToBlt;        // blt width in pixels
          register int    PixelCounter;             // pixel counter
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
          register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
          register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
        





#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX;
        











#line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 2;
        







#line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        











#line 580 "..\\ArtLib\\L_BLTCPY.cpp"
          PixelsAcrossToBlt = CopyWidth;
        

#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          
            redLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          













#line 610 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        































































































































































#line 775 "..\\ArtLib\\L_BLTCPY.cpp"

          // initialise current blt pointers
          lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
          lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
          // initialise pixel counter
          PixelCounter = PixelsAcrossToBlt;
          while (PixelCounter > 0)
          {
          


























































































#line 876 "..\\ArtLib\\L_BLTCPY.cpp"
                // lzou - Here does one pixel case only. Two and four pixel cases
                //      - will be implemented later on.

            // get one pixel of source data
            
              rawPixel = *((LPBYTE)lpSourceBltPointer);
              lpSourceBltPointer += 1;
            #line 884 "..\\ArtLib\\L_BLTCPY.cpp"

            // from 8 bit to 16 bit colour depth
            

              // convert 8 bit indices to 16 bit color values
              // and copy the converted data to destination bitmap

              rawPixel = SourceColorTable[(rawPixel & 0xff) * 2];

              // see if the pixel needs to be copied
              
                if( (rawPixel & redMask) >= redLimit  ||
                  (rawPixel & greenMask) < greenLimit ||
                  (rawPixel & blueMask) >= blueLimit )
              





#line 905 "..\\ArtLib\\L_BLTCPY.cpp"
              {
                *((LPWORD)lpDestinationBltPointer) = (WORD) rawPixel;
              }

              // update DestinationBitsPntr
              lpDestinationBltPointer += 2;  // advanced 2 bytes

            // from 8 bit to 24 bit colour depth
            


























































#line 973 "..\\ArtLib\\L_BLTCPY.cpp"
          #line 974 "..\\ArtLib\\L_BLTCPY.cpp"

            // decrement the pixel counter by 1
            PixelCounter -= 1;
          }
        









































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 185 "..\\ArtLib\\L_BltInc.cpp"



#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 24 ## SolidColourKey ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 24, SolidColourKey, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        


















#line 422 "..\\ArtLib\\L_BLTCPY.cpp"
          int             PixelsAcrossToBlt;        // blt width in pixels
          register int    PixelCounter;             // pixel counter
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
          register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
          register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
        





#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 525 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX;
        











#line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        



#line 555 "..\\ArtLib\\L_BLTCPY.cpp"
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 3;
        



#line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        











#line 580 "..\\ArtLib\\L_BLTCPY.cpp"
          PixelsAcrossToBlt = CopyWidth;
        

#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          






#line 596 "..\\ArtLib\\L_BLTCPY.cpp"
            redLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          






#line 610 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        































































































































































#line 775 "..\\ArtLib\\L_BLTCPY.cpp"

          // initialise current blt pointers
          lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
          lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
          // initialise pixel counter
          PixelCounter = PixelsAcrossToBlt;
          while (PixelCounter > 0)
          {
          


























































































#line 876 "..\\ArtLib\\L_BLTCPY.cpp"
                // lzou - Here does one pixel case only. Two and four pixel cases
                //      - will be implemented later on.

            // get one pixel of source data
            
              rawPixel = *((LPBYTE)lpSourceBltPointer);
              lpSourceBltPointer += 1;
            #line 884 "..\\ArtLib\\L_BLTCPY.cpp"

            // from 8 bit to 16 bit colour depth
            


























#line 914 "..\\ArtLib\\L_BLTCPY.cpp"

              // convert 8 bit indices to 24 bit color values
              // and copy the converted data to destination bitmap

              rawPixel = SourceColorTable[(rawPixel & 0xff) * 2];

              // see if the pixel needs to be copied
              
                if( (rawPixel & redMask) >= redLimit  ||
                  (rawPixel & greenMask) < greenLimit ||
                  (rawPixel & blueMask) >= blueLimit )
              





#line 932 "..\\ArtLib\\L_BLTCPY.cpp"
              {
                *((LPWORD)lpDestinationBltPointer) = (WORD) rawPixel;
                lpDestinationBltPointer += 2;
                *((LPBYTE)lpDestinationBltPointer) = (BYTE) (((DWORD) rawPixel) >> 16);
                lpDestinationBltPointer ++;
              }
              else
              {
                // if the pixel is not copied,
                // advance DestinationBitsPntr 3 bytes
                lpDestinationBltPointer += 3;
              }

            // from 8 bit to 32 bit colour depth
            

























#line 973 "..\\ArtLib\\L_BLTCPY.cpp"
          #line 974 "..\\ArtLib\\L_BLTCPY.cpp"

            // decrement the pixel counter by 1
            PixelCounter -= 1;
          }
        









































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 189 "..\\ArtLib\\L_BltInc.cpp"



#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 32 ## SolidColourKey ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 32, SolidColourKey, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        


















#line 422 "..\\ArtLib\\L_BLTCPY.cpp"
          int             PixelsAcrossToBlt;        // blt width in pixels
          register int    PixelCounter;             // pixel counter
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
          register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
          register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
        





#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 525 "..\\ArtLib\\L_BLTCPY.cpp"

#line 527 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = DestinationBitmapWidth * 4;
        #line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX;
        











#line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        



#line 555 "..\\ArtLib\\L_BLTCPY.cpp"



#line 559 "..\\ArtLib\\L_BLTCPY.cpp"
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 4;
        #line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        











#line 580 "..\\ArtLib\\L_BLTCPY.cpp"
          PixelsAcrossToBlt = CopyWidth;
        

#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          






#line 596 "..\\ArtLib\\L_BLTCPY.cpp"






#line 603 "..\\ArtLib\\L_BLTCPY.cpp"
            redLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          #line 610 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        































































































































































#line 775 "..\\ArtLib\\L_BLTCPY.cpp"

          // initialise current blt pointers
          lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
          lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
          // initialise pixel counter
          PixelCounter = PixelsAcrossToBlt;
          while (PixelCounter > 0)
          {
          


























































































#line 876 "..\\ArtLib\\L_BLTCPY.cpp"
                // lzou - Here does one pixel case only. Two and four pixel cases
                //      - will be implemented later on.

            // get one pixel of source data
            
              rawPixel = *((LPBYTE)lpSourceBltPointer);
              lpSourceBltPointer += 1;
            #line 884 "..\\ArtLib\\L_BLTCPY.cpp"

            // from 8 bit to 16 bit colour depth
            


























#line 914 "..\\ArtLib\\L_BLTCPY.cpp"
































#line 947 "..\\ArtLib\\L_BLTCPY.cpp"

              // convert 8 bit indices to 32 bit color values
              // and copy the converted data to destination bitmap

              rawPixel = SourceColorTable[(rawPixel & 0xff) * 2];

              // see if the pixel needs to be copied
              
                if( (rawPixel & redMask) >= redLimit  ||
                  (rawPixel & greenMask) < greenLimit ||
                  (rawPixel & blueMask) >= blueLimit )
              





#line 965 "..\\ArtLib\\L_BLTCPY.cpp"
              {
                *((LPLONG)lpDestinationBltPointer) = (DWORD) rawPixel;
              }

              // update DestinationBitsPntr
              lpDestinationBltPointer += 4;

            #line 973 "..\\ArtLib\\L_BLTCPY.cpp"
          #line 974 "..\\ArtLib\\L_BLTCPY.cpp"

            // decrement the pixel counter by 1
            PixelCounter -= 1;
          }
        









































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 193 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 16 ## To ## 16 ## SolidColourKey ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (16, 16, SolidColourKey, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        


















#line 422 "..\\ArtLib\\L_BLTCPY.cpp"
          int             PixelsAcrossToBlt;        // blt width in pixels
          register int    PixelCounter;             // pixel counter
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
          register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
          register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
        





#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        

#line 515 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = (SourceBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        



#line 536 "..\\ArtLib\\L_BLTCPY.cpp"
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX * 2;
        







#line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 2;
        







#line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        











#line 580 "..\\ArtLib\\L_BLTCPY.cpp"
          PixelsAcrossToBlt = CopyWidth;
        

#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          
            redLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          













#line 610 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        































































































































































#line 775 "..\\ArtLib\\L_BLTCPY.cpp"

          // initialise current blt pointers
          lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
          lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
          // initialise pixel counter
          PixelCounter = PixelsAcrossToBlt;
          while (PixelCounter > 0)
          {
          

            // for 16 bit colour depth
            
              // get one pixel of source data
              rawPixel = *((LPWORD)lpSourceBltPointer);
              lpSourceBltPointer += 2;

              // see if the pixel needs to be copied
              
                if( (rawPixel & redMask) >= redLimit  ||
                  (rawPixel & greenMask) < greenLimit ||
                  (rawPixel & blueMask) >= blueLimit )
              





#line 804 "..\\ArtLib\\L_BLTCPY.cpp"
              {
                // copy this pixel to destination bitmap
                *((LPWORD)lpDestinationBltPointer) = (WORD) rawPixel;
              }

              // update DestinationBitsPntr
              lpDestinationBltPointer += 2;

            // for 24 bit colour depth
            



























































#line 874 "..\\ArtLib\\L_BLTCPY.cpp"

          

































































































#line 974 "..\\ArtLib\\L_BLTCPY.cpp"

            // decrement the pixel counter by 1
            PixelCounter -= 1;
          }
        









































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 199 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 24 ## To ## 24 ## SolidColourKey ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (24, 24, SolidColourKey, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        


















#line 422 "..\\ArtLib\\L_BLTCPY.cpp"
          int             PixelsAcrossToBlt;        // blt width in pixels
          register int    PixelCounter;             // pixel counter
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
          register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
          register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
        





#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        

#line 515 "..\\ArtLib\\L_BLTCPY.cpp"

#line 517 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = (SourceBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 525 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        



#line 536 "..\\ArtLib\\L_BLTCPY.cpp"



#line 540 "..\\ArtLib\\L_BLTCPY.cpp"
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX * 3;
        



#line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        



#line 555 "..\\ArtLib\\L_BLTCPY.cpp"
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 3;
        



#line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        











#line 580 "..\\ArtLib\\L_BLTCPY.cpp"
          PixelsAcrossToBlt = CopyWidth;
        

#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          






#line 596 "..\\ArtLib\\L_BLTCPY.cpp"
            redLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          






#line 610 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        































































































































































#line 775 "..\\ArtLib\\L_BLTCPY.cpp"

          // initialise current blt pointers
          lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
          lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
          // initialise pixel counter
          PixelCounter = PixelsAcrossToBlt;
          while (PixelCounter > 0)
          {
          

            // for 16 bit colour depth
            

























#line 814 "..\\ArtLib\\L_BLTCPY.cpp"
              // get one pixel of source data
//              rawPixel = *((LPLONG)lpSourceBltPointer);
//              lpSourceBltPointer += 3;
              rawPixel = *((LPWORD)lpSourceBltPointer);
              lpSourceBltPointer += 2;
              rawPixel |= ((DWORD) *((LPBYTE)lpSourceBltPointer) << 16);
              lpSourceBltPointer ++;

              // see if the pixel needs to be copied
              
                if( (rawPixel & redMask) >= redLimit  ||
                  (rawPixel & greenMask) < greenLimit ||
                  (rawPixel & blueMask) >= blueLimit )
              





#line 834 "..\\ArtLib\\L_BLTCPY.cpp"
              {
                // copy this pixel to destination bitmap
                *((LPWORD)lpDestinationBltPointer) = (WORD) rawPixel;
                lpDestinationBltPointer += 2;
                *((LPBYTE)lpDestinationBltPointer) = (BYTE) (((DWORD) rawPixel) >> 16);
                lpDestinationBltPointer ++;
              }
              else
              {
                // if the pixel is not copied (transparent),
                // advance DestinationBitsPntr by 3 bytes
                lpDestinationBltPointer += 3;
              }

            // for 32 bit colour depth
            























#line 874 "..\\ArtLib\\L_BLTCPY.cpp"

          

































































































#line 974 "..\\ArtLib\\L_BLTCPY.cpp"

            // decrement the pixel counter by 1
            PixelCounter -= 1;
          }
        









































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 205 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 32 ## To ## 32 ## SolidColourKey ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (32, 32, SolidColourKey, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/

  

    // Solid (or wiht holes) & Unity bitmap copy

    
      {
        LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
        int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
        LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
        int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes

        


















#line 422 "..\\ArtLib\\L_BLTCPY.cpp"
          int             PixelsAcrossToBlt;        // blt width in pixels
          register int    PixelCounter;             // pixel counter
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
          register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
          register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
        





#line 440 "..\\ArtLib\\L_BLTCPY.cpp"

        register int  LinesToBlt;      // blt height in pixels

        RECT  SourceRectangleToUpdate; // source rectangle to be updated
        int   SourceOffsetX;           // offset in pixels used for image clipping
        int   SourceOffsetY;           // used for image clipping
        int   CopyWidth;               // copy width after clipping
        int   CopyHeight;              // copy height after clipping
        int   DestinationOffsetX;      // used for image clipping
        int   DestinationOffsetY;      // used for image clipping

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 459 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 468 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // find the actual source area (inside source rectangle) to be updated
        // using destination bounding rectangle and destination invalid rectangle

        if( DestInvalidRectangle != NULL )
        {
          SourceRectangleToUpdate.left = SourceRectangle->left +
            (DestInvalidRectangle->left - DestBoundingRectangle->left);
          SourceRectangleToUpdate.right = SourceRectangle->left +
            (DestInvalidRectangle->right - DestBoundingRectangle->left);
          SourceRectangleToUpdate.top = SourceRectangle->top +
            (DestInvalidRectangle->top - DestBoundingRectangle->top);
          SourceRectangleToUpdate.bottom = SourceRectangle->top +
            (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangleToUpdate.left;
          SourceOffsetY = (int) SourceRectangleToUpdate.top;
          CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
          CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
        }
        else // don't know the DestInvalidRectangle
        {
          // initialise clipping parameters
          SourceOffsetX = (int) SourceRectangle->left;
          SourceOffsetY = (int) SourceRectangle->top;
          CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
          CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
        }

        DestinationOffsetX = DestinationX;
        DestinationOffsetY = DestinationY;

        // get both source and destination bitmaps clipped
        LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
          &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
          &DestinationOffsetX, &DestinationOffsetY,
          DestinationBitmapWidth, DestinationBitmapHeight);

        // calculate bitmap widths in bytes
        // force all pixels aligned in DWORD boundary

        

#line 515 "..\\ArtLib\\L_BLTCPY.cpp"

#line 517 "..\\ArtLib\\L_BLTCPY.cpp"

#line 519 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = SourceBitmapWidth * 4;
        #line 521 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 525 "..\\ArtLib\\L_BLTCPY.cpp"

#line 527 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = DestinationBitmapWidth * 4;
        #line 529 "..\\ArtLib\\L_BLTCPY.cpp"
        
        // calculate start position of blt in source bitmap
        



#line 536 "..\\ArtLib\\L_BLTCPY.cpp"



#line 540 "..\\ArtLib\\L_BLTCPY.cpp"



#line 544 "..\\ArtLib\\L_BLTCPY.cpp"
          lpSourceScanlineBeginBlt = SourceBitmapBits +
            SourceOffsetY * SourceBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceOffsetX * 4;
        #line 548 "..\\ArtLib\\L_BLTCPY.cpp"

        // calculate start position of blt in destination bitmap
        



#line 555 "..\\ArtLib\\L_BLTCPY.cpp"



#line 559 "..\\ArtLib\\L_BLTCPY.cpp"
          lpDestinationScanlineBeginBlt = DestinationBitmapBits +
            DestinationOffsetY * DestinationBitmapWidthInBytes;
          lpDestinationScanlineBeginBlt += DestinationOffsetX * 4;
        #line 563 "..\\ArtLib\\L_BLTCPY.cpp"

        // get the image width and height after clipping
        LinesToBlt = CopyHeight;

        











#line 580 "..\\ArtLib\\L_BLTCPY.cpp"
          PixelsAcrossToBlt = CopyWidth;
        

#line 584 "..\\ArtLib\\L_BLTCPY.cpp"

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          






#line 596 "..\\ArtLib\\L_BLTCPY.cpp"






#line 603 "..\\ArtLib\\L_BLTCPY.cpp"
            redLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          #line 610 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 611 "..\\ArtLib\\L_BLTCPY.cpp"

        while (LinesToBlt > 0)
        {
        































































































































































#line 775 "..\\ArtLib\\L_BLTCPY.cpp"

          // initialise current blt pointers
          lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
          lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
          // initialise pixel counter
          PixelCounter = PixelsAcrossToBlt;
          while (PixelCounter > 0)
          {
          

            // for 16 bit colour depth
            

























#line 814 "..\\ArtLib\\L_BLTCPY.cpp"



































#line 850 "..\\ArtLib\\L_BLTCPY.cpp"
              // get one pixel of source data
              rawPixel = *((LPLONG)lpSourceBltPointer);
              lpSourceBltPointer += 4;

              // see if the pixel needs to be copied
              
                if( (rawPixel & redMask) >= redLimit  ||
                  (rawPixel & greenMask) < greenLimit ||
                  (rawPixel & blueMask) >= blueLimit )
              





#line 866 "..\\ArtLib\\L_BLTCPY.cpp"
              {
                // copy this pixel to destination bitmap
                *((LPLONG)lpDestinationBltPointer) = (DWORD) rawPixel;
              }

              // update DestinationBitsPntr
              lpDestinationBltPointer += 4;
            #line 874 "..\\ArtLib\\L_BLTCPY.cpp"

          

































































































#line 974 "..\\ArtLib\\L_BLTCPY.cpp"

            // decrement the pixel counter by 1
            PixelCounter -= 1;
          }
        









































































#line 1053 "..\\ArtLib\\L_BLTCPY.cpp"

          // update pointers to the next scanline
          lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
          lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
          LinesToBlt --;
        }

        // successful
        return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
      }
    #line 1064 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1065 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 211 "..\\ArtLib\\L_BltInc.cpp"

//
// =============================================================
//
//          Unity & Alpha, Raw bitmap copy
//














#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.








#line 241 "..\\ArtLib\\L_BLTCPY.cpp"

#line 243 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 246 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 248 "..\\ArtLib\\L_BLTCPY.cpp"


#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 16 ## Alpha ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 16, Alpha, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    
      UNS16 NumberOfAlphaColors,
    #line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/

  

    // (Alpha and Unity) bitmap copy
    // do alpha & unity bitmap copy from 8 bit color depth
    // to 16, 24, and 32 bit colour depths, raw source bitmap

    
    {
      LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
      int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
      LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
      int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes
      int     PixelsAcrossToBlt;             // blt width in pixels

      register int     LinesToBlt;               // blt height in pixels
      register int     PixelCounter;             // pixel counter
      register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
      register DWORD   dwSourceData;             // holder for source data
      register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
      register DWORD   dwDestinationData;        // holders for destination data

      register DWORD dwAlphaData;   // holder source and data blended
      register DWORD dwAlpha;       // 32 bit alpha channel

      RECT  SourceRectangleToUpdate; // source rectangle to be updated
      int   SourceOffsetX;           // offset in pixels used for image clipping
      int   SourceOffsetY;           // used for image clipping
      int   CopyWidth;               // copy width after clipping
      int   CopyHeight;              // copy height after clipping
      int   DestinationOffsetX;      // used for image clipping
      int   DestinationOffsetY;      // used for image clipping
      

#line 1129 "..\\ArtLib\\L_BLTCPY.cpp"

      // validate the source/destination bitmap pointers

      if( SourceBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1138 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid source bitmap pointer
      }

      if( DestinationBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1147 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid destination bitmap pointer
      }

      // find out the actual source rectangle to be updated using
      // destination bounding rectangle and destination invalid rectangle

      if( DestInvalidRectangle != NULL )
      {
        SourceRectangleToUpdate.left = SourceRectangle->left +
          (DestInvalidRectangle->left - DestBoundingRectangle->left);
        SourceRectangleToUpdate.right = SourceRectangle->left +
          (DestInvalidRectangle->right - DestBoundingRectangle->left);
        SourceRectangleToUpdate.top = SourceRectangle->top +
          (DestInvalidRectangle->top - DestBoundingRectangle->top);
        SourceRectangleToUpdate.bottom = SourceRectangle->top +
          (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangleToUpdate.left;
        SourceOffsetY = (int) SourceRectangleToUpdate.top;
        CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
        CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
      }
      else // don't know the DestInvalidRectangle
      {
        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
        CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
      }

      DestinationOffsetX = DestinationX;
      DestinationOffsetY = DestinationY;
      
      // get both source and destination bitmaps clipped
      LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
        &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
        &DestinationOffsetX, &DestinationOffsetY,
        DestinationBitmapWidth, DestinationBitmapHeight);
      
      // calculate bitmap widths in bytes
      // force all pixels aligned by 4 bytes boundary

      
        SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
      





#line 1200 "..\\ArtLib\\L_BLTCPY.cpp"

      
        DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 2 + 3) & 0xfffffffc;
      



#line 1208 "..\\ArtLib\\L_BLTCPY.cpp"
      
      // calculate start position of blt in source bitmap
      lpSourceScanlineBeginBlt = SourceBitmapBits + SourceOffsetY *
        SourceBitmapWidthInBytes;
      
        lpSourceScanlineBeginBlt += SourceOffsetX;
      





#line 1221 "..\\ArtLib\\L_BLTCPY.cpp"

      // calculate start position of blt in destination bitmap
      lpDestinationScanlineBeginBlt = DestinationBitmapBits +
        DestinationOffsetY * DestinationBitmapWidthInBytes;
      
        lpDestinationScanlineBeginBlt += DestinationOffsetX * 2;
      



#line 1232 "..\\ArtLib\\L_BLTCPY.cpp"

      // If not 8 bit colour depth, we need to filter out
      // all pure green colour pixels.
      



#line 1240 "..\\ArtLib\\L_BLTCPY.cpp"



#line 1244 "..\\ArtLib\\L_BLTCPY.cpp"



#line 1248 "..\\ArtLib\\L_BLTCPY.cpp"
        
      













#line 1264 "..\\ArtLib\\L_BLTCPY.cpp"

      // get the image width and height after clipping
      LinesToBlt = CopyHeight;
      PixelsAcrossToBlt = CopyWidth;
      
      while (LinesToBlt > 0)
      {
        // initialise current blt pointers
        lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
        lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
        // initialise pixel counter
        PixelCounter = PixelsAcrossToBlt;
        while (PixelCounter > 0)
        {
          // process one pixel each time

          // get one pixel of source data
          
            dwSourceData = *((LPBYTE)lpSourceBltPointer);
            lpSourceBltPointer ++;
          















#line 1302 "..\\ArtLib\\L_BLTCPY.cpp"

        
          if( dwSourceData != 0 )          // use hole technique
        

#line 1308 "..\\ArtLib\\L_BLTCPY.cpp"
          {
          
            if ( dwSourceData >= NumberOfAlphaColors )
            {
              
                *((LPWORD)lpDestinationBltPointer) = (WORD)SourceColorTable[(dwSourceData & 0xff) * 2];
                lpDestinationBltPointer += 2;

              














#line 1332 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            // apply alpha channel effect to both the source/destination bitmaps
            // ( see l_type.h for details )
            else
          #line 1337 "..\\ArtLib\\L_BLTCPY.cpp"
            {
              // get the alpha channel data from the source bitmap
              
                dwAlpha = SourceColorTable[(dwSourceData & 0xff) * 2 + 1];
                dwDestinationData = SourceColorTable[(dwSourceData & 0xff) * 2];
              #line 1343 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel data from the destination bitmap
              
                dwSourceData = *((LPWORD)lpDestinationBltPointer) & 0x0000ffff;
              



#line 1352 "..\\ArtLib\\L_BLTCPY.cpp"

              // do alpha channel effect here ...

            



















































































































































































































































































































































































































































#line 1792 "..\\ArtLib\\L_BLTCPY.cpp"
              
                // work out the final alpha effect -- dwAlphaData
















#line 1811 "..\\ArtLib\\L_BLTCPY.cpp"
                dwAlphaData = 
                  ((dwDestinationData & LE_BLT_dwRedMask) +
                  (dwSourceData & LE_BLT_dwRedMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwRedMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwGreenMask) +
                  (dwSourceData & LE_BLT_dwGreenMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwGreenMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwBlueMask) +
                  (dwSourceData & LE_BLT_dwBlueMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwBlueMask;
#line 1824 "..\\ArtLib\\L_BLTCPY.cpp"
              













#line 1839 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 1840 "..\\ArtLib\\L_BLTCPY.cpp"

              // copy the resultant dwAlphaData to destination bitmap
              
                *((LPWORD)lpDestinationBltPointer) = (WORD)dwAlphaData;
                lpDestinationBltPointer += 2;
              







#line 1854 "..\\ArtLib\\L_BLTCPY.cpp"
            }
          }
          else
          {
            // update the destination bitmap pointer
            
              lpDestinationBltPointer += 2;
            



#line 1866 "..\\ArtLib\\L_BLTCPY.cpp"
          }

          // get the pixel counter updated
          PixelCounter --;
        }

        // update pointers to the next scanline
        lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
        lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
        LinesToBlt --;
      }

      // successful
      return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
    }
    #line 1882 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1883 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 232 "..\\ArtLib\\L_BltInc.cpp"



#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.








#line 241 "..\\ArtLib\\L_BLTCPY.cpp"

#line 243 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 246 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 248 "..\\ArtLib\\L_BLTCPY.cpp"


#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 24 ## Alpha ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 24, Alpha, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    
      UNS16 NumberOfAlphaColors,
    #line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/

  

    // (Alpha and Unity) bitmap copy
    // do alpha & unity bitmap copy from 8 bit color depth
    // to 16, 24, and 32 bit colour depths, raw source bitmap

    
    {
      LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
      int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
      LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
      int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes
      int     PixelsAcrossToBlt;             // blt width in pixels

      register int     LinesToBlt;               // blt height in pixels
      register int     PixelCounter;             // pixel counter
      register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
      register DWORD   dwSourceData;             // holder for source data
      register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
      register DWORD   dwDestinationData;        // holders for destination data

      register DWORD dwAlphaData;   // holder source and data blended
      register DWORD dwAlpha;       // 32 bit alpha channel

      RECT  SourceRectangleToUpdate; // source rectangle to be updated
      int   SourceOffsetX;           // offset in pixels used for image clipping
      int   SourceOffsetY;           // used for image clipping
      int   CopyWidth;               // copy width after clipping
      int   CopyHeight;              // copy height after clipping
      int   DestinationOffsetX;      // used for image clipping
      int   DestinationOffsetY;      // used for image clipping
      

#line 1129 "..\\ArtLib\\L_BLTCPY.cpp"

      // validate the source/destination bitmap pointers

      if( SourceBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1138 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid source bitmap pointer
      }

      if( DestinationBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1147 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid destination bitmap pointer
      }

      // find out the actual source rectangle to be updated using
      // destination bounding rectangle and destination invalid rectangle

      if( DestInvalidRectangle != NULL )
      {
        SourceRectangleToUpdate.left = SourceRectangle->left +
          (DestInvalidRectangle->left - DestBoundingRectangle->left);
        SourceRectangleToUpdate.right = SourceRectangle->left +
          (DestInvalidRectangle->right - DestBoundingRectangle->left);
        SourceRectangleToUpdate.top = SourceRectangle->top +
          (DestInvalidRectangle->top - DestBoundingRectangle->top);
        SourceRectangleToUpdate.bottom = SourceRectangle->top +
          (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangleToUpdate.left;
        SourceOffsetY = (int) SourceRectangleToUpdate.top;
        CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
        CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
      }
      else // don't know the DestInvalidRectangle
      {
        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
        CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
      }

      DestinationOffsetX = DestinationX;
      DestinationOffsetY = DestinationY;
      
      // get both source and destination bitmaps clipped
      LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
        &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
        &DestinationOffsetX, &DestinationOffsetY,
        DestinationBitmapWidth, DestinationBitmapHeight);
      
      // calculate bitmap widths in bytes
      // force all pixels aligned by 4 bytes boundary

      
        SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
      





#line 1200 "..\\ArtLib\\L_BLTCPY.cpp"

      

#line 1204 "..\\ArtLib\\L_BLTCPY.cpp"
        DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 3 + 3) & 0xfffffffc;
      

#line 1208 "..\\ArtLib\\L_BLTCPY.cpp"
      
      // calculate start position of blt in source bitmap
      lpSourceScanlineBeginBlt = SourceBitmapBits + SourceOffsetY *
        SourceBitmapWidthInBytes;
      
        lpSourceScanlineBeginBlt += SourceOffsetX;
      





#line 1221 "..\\ArtLib\\L_BLTCPY.cpp"

      // calculate start position of blt in destination bitmap
      lpDestinationScanlineBeginBlt = DestinationBitmapBits +
        DestinationOffsetY * DestinationBitmapWidthInBytes;
      

#line 1228 "..\\ArtLib\\L_BLTCPY.cpp"
        lpDestinationScanlineBeginBlt += DestinationOffsetX * 3;
      

#line 1232 "..\\ArtLib\\L_BLTCPY.cpp"

      // If not 8 bit colour depth, we need to filter out
      // all pure green colour pixels.
      



#line 1240 "..\\ArtLib\\L_BLTCPY.cpp"



#line 1244 "..\\ArtLib\\L_BLTCPY.cpp"



#line 1248 "..\\ArtLib\\L_BLTCPY.cpp"
        
      













#line 1264 "..\\ArtLib\\L_BLTCPY.cpp"

      // get the image width and height after clipping
      LinesToBlt = CopyHeight;
      PixelsAcrossToBlt = CopyWidth;
      
      while (LinesToBlt > 0)
      {
        // initialise current blt pointers
        lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
        lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
        // initialise pixel counter
        PixelCounter = PixelsAcrossToBlt;
        while (PixelCounter > 0)
        {
          // process one pixel each time

          // get one pixel of source data
          
            dwSourceData = *((LPBYTE)lpSourceBltPointer);
            lpSourceBltPointer ++;
          















#line 1302 "..\\ArtLib\\L_BLTCPY.cpp"

        
          if( dwSourceData != 0 )          // use hole technique
        

#line 1308 "..\\ArtLib\\L_BLTCPY.cpp"
          {
          
            if ( dwSourceData >= NumberOfAlphaColors )
            {
              



#line 1317 "..\\ArtLib\\L_BLTCPY.cpp"
                // convert 8 bit indices to 24 bit colour values
                dwDestinationData = SourceColorTable[(dwSourceData & 0xff) * 2];

                // copy the converted data to destination bitmap
                *((LPWORD)lpDestinationBltPointer) = (WORD)(dwDestinationData);
                lpDestinationBltPointer += 2;
                *((LPBYTE)lpDestinationBltPointer) = (BYTE)(dwDestinationData >> 16);
                lpDestinationBltPointer += 1;

              




#line 1332 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            // apply alpha channel effect to both the source/destination bitmaps
            // ( see l_type.h for details )
            else
          #line 1337 "..\\ArtLib\\L_BLTCPY.cpp"
            {
              // get the alpha channel data from the source bitmap
              
                dwAlpha = SourceColorTable[(dwSourceData & 0xff) * 2 + 1];
                dwDestinationData = SourceColorTable[(dwSourceData & 0xff) * 2];
              #line 1343 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel data from the destination bitmap
              

#line 1348 "..\\ArtLib\\L_BLTCPY.cpp"
                dwSourceData = *((LPLONG)lpDestinationBltPointer) & 0x00ffffff;
              

#line 1352 "..\\ArtLib\\L_BLTCPY.cpp"

              // do alpha channel effect here ...

            



















































































































































































































































































































































































































































#line 1792 "..\\ArtLib\\L_BLTCPY.cpp"
              
                // work out the final alpha effect -- dwAlphaData
















#line 1811 "..\\ArtLib\\L_BLTCPY.cpp"
                dwAlphaData = 
                  ((dwDestinationData & LE_BLT_dwRedMask) +
                  (dwSourceData & LE_BLT_dwRedMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwRedMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwGreenMask) +
                  (dwSourceData & LE_BLT_dwGreenMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwGreenMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwBlueMask) +
                  (dwSourceData & LE_BLT_dwBlueMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwBlueMask;
#line 1824 "..\\ArtLib\\L_BLTCPY.cpp"
              













#line 1839 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 1840 "..\\ArtLib\\L_BLTCPY.cpp"

              // copy the resultant dwAlphaData to destination bitmap
              


#line 1846 "..\\ArtLib\\L_BLTCPY.cpp"
                *((LPWORD)lpDestinationBltPointer) = (WORD)dwAlphaData;
                lpDestinationBltPointer += 2;
                *((LPBYTE)lpDestinationBltPointer) = (BYTE)(dwAlphaData >> 16);
                lpDestinationBltPointer += 1;
              


#line 1854 "..\\ArtLib\\L_BLTCPY.cpp"
            }
          }
          else
          {
            // update the destination bitmap pointer
            

#line 1862 "..\\ArtLib\\L_BLTCPY.cpp"
              lpDestinationBltPointer += 3;
            

#line 1866 "..\\ArtLib\\L_BLTCPY.cpp"
          }

          // get the pixel counter updated
          PixelCounter --;
        }

        // update pointers to the next scanline
        lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
        lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
        LinesToBlt --;
      }

      // successful
      return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
    }
    #line 1882 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1883 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 236 "..\\ArtLib\\L_BltInc.cpp"



#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.








#line 241 "..\\ArtLib\\L_BLTCPY.cpp"

#line 243 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 246 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 248 "..\\ArtLib\\L_BLTCPY.cpp"


#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 32 ## Alpha ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 32, Alpha, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    
      UNS16 NumberOfAlphaColors,
    #line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/

  

    // (Alpha and Unity) bitmap copy
    // do alpha & unity bitmap copy from 8 bit color depth
    // to 16, 24, and 32 bit colour depths, raw source bitmap

    
    {
      LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
      int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
      LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
      int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes
      int     PixelsAcrossToBlt;             // blt width in pixels

      register int     LinesToBlt;               // blt height in pixels
      register int     PixelCounter;             // pixel counter
      register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
      register DWORD   dwSourceData;             // holder for source data
      register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
      register DWORD   dwDestinationData;        // holders for destination data

      register DWORD dwAlphaData;   // holder source and data blended
      register DWORD dwAlpha;       // 32 bit alpha channel

      RECT  SourceRectangleToUpdate; // source rectangle to be updated
      int   SourceOffsetX;           // offset in pixels used for image clipping
      int   SourceOffsetY;           // used for image clipping
      int   CopyWidth;               // copy width after clipping
      int   CopyHeight;              // copy height after clipping
      int   DestinationOffsetX;      // used for image clipping
      int   DestinationOffsetY;      // used for image clipping
      

#line 1129 "..\\ArtLib\\L_BLTCPY.cpp"

      // validate the source/destination bitmap pointers

      if( SourceBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1138 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid source bitmap pointer
      }

      if( DestinationBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1147 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid destination bitmap pointer
      }

      // find out the actual source rectangle to be updated using
      // destination bounding rectangle and destination invalid rectangle

      if( DestInvalidRectangle != NULL )
      {
        SourceRectangleToUpdate.left = SourceRectangle->left +
          (DestInvalidRectangle->left - DestBoundingRectangle->left);
        SourceRectangleToUpdate.right = SourceRectangle->left +
          (DestInvalidRectangle->right - DestBoundingRectangle->left);
        SourceRectangleToUpdate.top = SourceRectangle->top +
          (DestInvalidRectangle->top - DestBoundingRectangle->top);
        SourceRectangleToUpdate.bottom = SourceRectangle->top +
          (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangleToUpdate.left;
        SourceOffsetY = (int) SourceRectangleToUpdate.top;
        CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
        CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
      }
      else // don't know the DestInvalidRectangle
      {
        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
        CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
      }

      DestinationOffsetX = DestinationX;
      DestinationOffsetY = DestinationY;
      
      // get both source and destination bitmaps clipped
      LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
        &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
        &DestinationOffsetX, &DestinationOffsetY,
        DestinationBitmapWidth, DestinationBitmapHeight);
      
      // calculate bitmap widths in bytes
      // force all pixels aligned by 4 bytes boundary

      
        SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
      





#line 1200 "..\\ArtLib\\L_BLTCPY.cpp"

      

#line 1204 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1206 "..\\ArtLib\\L_BLTCPY.cpp"
        DestinationBitmapWidthInBytes = DestinationBitmapWidth * 4;
      #line 1208 "..\\ArtLib\\L_BLTCPY.cpp"
      
      // calculate start position of blt in source bitmap
      lpSourceScanlineBeginBlt = SourceBitmapBits + SourceOffsetY *
        SourceBitmapWidthInBytes;
      
        lpSourceScanlineBeginBlt += SourceOffsetX;
      





#line 1221 "..\\ArtLib\\L_BLTCPY.cpp"

      // calculate start position of blt in destination bitmap
      lpDestinationScanlineBeginBlt = DestinationBitmapBits +
        DestinationOffsetY * DestinationBitmapWidthInBytes;
      

#line 1228 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1230 "..\\ArtLib\\L_BLTCPY.cpp"
        lpDestinationScanlineBeginBlt += DestinationOffsetX * 4;
      #line 1232 "..\\ArtLib\\L_BLTCPY.cpp"

      // If not 8 bit colour depth, we need to filter out
      // all pure green colour pixels.
      



#line 1240 "..\\ArtLib\\L_BLTCPY.cpp"



#line 1244 "..\\ArtLib\\L_BLTCPY.cpp"



#line 1248 "..\\ArtLib\\L_BLTCPY.cpp"
        
      













#line 1264 "..\\ArtLib\\L_BLTCPY.cpp"

      // get the image width and height after clipping
      LinesToBlt = CopyHeight;
      PixelsAcrossToBlt = CopyWidth;
      
      while (LinesToBlt > 0)
      {
        // initialise current blt pointers
        lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
        lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
        // initialise pixel counter
        PixelCounter = PixelsAcrossToBlt;
        while (PixelCounter > 0)
        {
          // process one pixel each time

          // get one pixel of source data
          
            dwSourceData = *((LPBYTE)lpSourceBltPointer);
            lpSourceBltPointer ++;
          















#line 1302 "..\\ArtLib\\L_BLTCPY.cpp"

        
          if( dwSourceData != 0 )          // use hole technique
        

#line 1308 "..\\ArtLib\\L_BLTCPY.cpp"
          {
          
            if ( dwSourceData >= NumberOfAlphaColors )
            {
              



#line 1317 "..\\ArtLib\\L_BLTCPY.cpp"









#line 1327 "..\\ArtLib\\L_BLTCPY.cpp"
                // convert 8 bit indices to 32 bit color values
                // and copy the converted data to destination bitmap
                *((LPLONG)lpDestinationBltPointer) = SourceColorTable[(dwSourceData & 0xff) * 2];
                lpDestinationBltPointer += 4;
              #line 1332 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            // apply alpha channel effect to both the source/destination bitmaps
            // ( see l_type.h for details )
            else
          #line 1337 "..\\ArtLib\\L_BLTCPY.cpp"
            {
              // get the alpha channel data from the source bitmap
              
                dwAlpha = SourceColorTable[(dwSourceData & 0xff) * 2 + 1];
                dwDestinationData = SourceColorTable[(dwSourceData & 0xff) * 2];
              #line 1343 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel data from the destination bitmap
              

#line 1348 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1350 "..\\ArtLib\\L_BLTCPY.cpp"
                dwSourceData = *((LPLONG)lpDestinationBltPointer);
              #line 1352 "..\\ArtLib\\L_BLTCPY.cpp"

              // do alpha channel effect here ...

            



















































































































































































































































































































































































































































#line 1792 "..\\ArtLib\\L_BLTCPY.cpp"
              
                // work out the final alpha effect -- dwAlphaData
















#line 1811 "..\\ArtLib\\L_BLTCPY.cpp"
                dwAlphaData = 
                  ((dwDestinationData & LE_BLT_dwRedMask) +
                  (dwSourceData & LE_BLT_dwRedMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwRedMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwGreenMask) +
                  (dwSourceData & LE_BLT_dwGreenMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwGreenMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwBlueMask) +
                  (dwSourceData & LE_BLT_dwBlueMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwBlueMask;
#line 1824 "..\\ArtLib\\L_BLTCPY.cpp"
              













#line 1839 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 1840 "..\\ArtLib\\L_BLTCPY.cpp"

              // copy the resultant dwAlphaData to destination bitmap
              


#line 1846 "..\\ArtLib\\L_BLTCPY.cpp"




#line 1851 "..\\ArtLib\\L_BLTCPY.cpp"
                *((LPLONG)lpDestinationBltPointer) = dwAlphaData;
                lpDestinationBltPointer += 4;
              #line 1854 "..\\ArtLib\\L_BLTCPY.cpp"
            }
          }
          else
          {
            // update the destination bitmap pointer
            

#line 1862 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1864 "..\\ArtLib\\L_BLTCPY.cpp"
              lpDestinationBltPointer += 4;
            #line 1866 "..\\ArtLib\\L_BLTCPY.cpp"
          }

          // get the pixel counter updated
          PixelCounter --;
        }

        // update pointers to the next scanline
        lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
        lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
        LinesToBlt --;
      }

      // successful
      return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
    }
    #line 1882 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1883 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 240 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.








#line 241 "..\\ArtLib\\L_BLTCPY.cpp"

#line 243 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 246 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 248 "..\\ArtLib\\L_BLTCPY.cpp"


#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 16 ## To ## 16 ## Alpha ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (16, 16, Alpha, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"
    INT16 nAlphaValue,
  #line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/

  

    // (Alpha and Unity) bitmap copy
    // do alpha & unity bitmap copy from 8 bit color depth
    // to 16, 24, and 32 bit colour depths, raw source bitmap

    
    {
      LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
      int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
      LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
      int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes
      int     PixelsAcrossToBlt;             // blt width in pixels

      register int     LinesToBlt;               // blt height in pixels
      register int     PixelCounter;             // pixel counter
      register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
      register DWORD   dwSourceData;             // holder for source data
      register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
      register DWORD   dwDestinationData;        // holders for destination data

      register DWORD dwAlphaData;   // holder source and data blended
      register DWORD dwAlpha;       // 32 bit alpha channel

      RECT  SourceRectangleToUpdate; // source rectangle to be updated
      int   SourceOffsetX;           // offset in pixels used for image clipping
      int   SourceOffsetY;           // used for image clipping
      int   CopyWidth;               // copy width after clipping
      int   CopyHeight;              // copy height after clipping
      int   DestinationOffsetX;      // used for image clipping
      int   DestinationOffsetY;      // used for image clipping
      
        WORD  wPureGreen;            // to filter out pure green colour
      #line 1129 "..\\ArtLib\\L_BLTCPY.cpp"

      // validate the source/destination bitmap pointers

      if( SourceBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1138 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid source bitmap pointer
      }

      if( DestinationBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1147 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid destination bitmap pointer
      }

      // find out the actual source rectangle to be updated using
      // destination bounding rectangle and destination invalid rectangle

      if( DestInvalidRectangle != NULL )
      {
        SourceRectangleToUpdate.left = SourceRectangle->left +
          (DestInvalidRectangle->left - DestBoundingRectangle->left);
        SourceRectangleToUpdate.right = SourceRectangle->left +
          (DestInvalidRectangle->right - DestBoundingRectangle->left);
        SourceRectangleToUpdate.top = SourceRectangle->top +
          (DestInvalidRectangle->top - DestBoundingRectangle->top);
        SourceRectangleToUpdate.bottom = SourceRectangle->top +
          (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangleToUpdate.left;
        SourceOffsetY = (int) SourceRectangleToUpdate.top;
        CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
        CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
      }
      else // don't know the DestInvalidRectangle
      {
        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
        CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
      }

      DestinationOffsetX = DestinationX;
      DestinationOffsetY = DestinationY;
      
      // get both source and destination bitmaps clipped
      LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
        &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
        &DestinationOffsetX, &DestinationOffsetY,
        DestinationBitmapWidth, DestinationBitmapHeight);
      
      // calculate bitmap widths in bytes
      // force all pixels aligned by 4 bytes boundary

      

#line 1194 "..\\ArtLib\\L_BLTCPY.cpp"
        SourceBitmapWidthInBytes = (SourceBitmapWidth * 2 + 3) & 0xfffffffc;
      



#line 1200 "..\\ArtLib\\L_BLTCPY.cpp"

      
        DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 2 + 3) & 0xfffffffc;
      



#line 1208 "..\\ArtLib\\L_BLTCPY.cpp"
      
      // calculate start position of blt in source bitmap
      lpSourceScanlineBeginBlt = SourceBitmapBits + SourceOffsetY *
        SourceBitmapWidthInBytes;
      

#line 1215 "..\\ArtLib\\L_BLTCPY.cpp"
        lpSourceScanlineBeginBlt += SourceOffsetX * 2;
      



#line 1221 "..\\ArtLib\\L_BLTCPY.cpp"

      // calculate start position of blt in destination bitmap
      lpDestinationScanlineBeginBlt = DestinationBitmapBits +
        DestinationOffsetY * DestinationBitmapWidthInBytes;
      
        lpDestinationScanlineBeginBlt += DestinationOffsetX * 2;
      



#line 1232 "..\\ArtLib\\L_BLTCPY.cpp"

      // If not 8 bit colour depth, we need to filter out
      // all pure green colour pixels.
      
        // make a COLORREF for pure green colour
        wPureGreen = (WORD) LI_BLT_ConvertColorRefTo16BitColor(
          (COLORREF) RGB (0, 255, 0));
      







#line 1248 "..\\ArtLib\\L_BLTCPY.cpp"
        
      
        // get the alpha data
        dwAlpha = (DWORD) nAlphaValue;

        
          // check the validity of dwAlpha
          if ( dwAlpha < 0 || dwAlpha > 255 )
          {
            if ( dwAlpha < 0 )
              dwAlpha = 0;
            else
              dwAlpha = 255;
          }
        #line 1263 "..\\ArtLib\\L_BLTCPY.cpp"
      #line 1264 "..\\ArtLib\\L_BLTCPY.cpp"

      // get the image width and height after clipping
      LinesToBlt = CopyHeight;
      PixelsAcrossToBlt = CopyWidth;
      
      while (LinesToBlt > 0)
      {
        // initialise current blt pointers
        lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
        lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
        // initialise pixel counter
        PixelCounter = PixelsAcrossToBlt;
        while (PixelCounter > 0)
        {
          // process one pixel each time

          // get one pixel of source data
          


#line 1286 "..\\ArtLib\\L_BLTCPY.cpp"
            dwDestinationData = *((LPWORD)lpSourceBltPointer);
            dwSourceData = dwDestinationData;
            lpSourceBltPointer += 2;
          











#line 1302 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 1306 "..\\ArtLib\\L_BLTCPY.cpp"
          if( dwSourceData != wPureGreen ) // use pure green colour key
        #line 1308 "..\\ArtLib\\L_BLTCPY.cpp"
          {
          


























#line 1337 "..\\ArtLib\\L_BLTCPY.cpp"
            {
              // get the alpha channel data from the source bitmap
              


#line 1343 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel data from the destination bitmap
              
                dwSourceData = *((LPWORD)lpDestinationBltPointer) & 0x0000ffff;
              



#line 1352 "..\\ArtLib\\L_BLTCPY.cpp"

              // do alpha channel effect here ...

            



















































































































































































































































































































































































































































#line 1792 "..\\ArtLib\\L_BLTCPY.cpp"
              































#line 1825 "..\\ArtLib\\L_BLTCPY.cpp"
                // work out the final alpha effect -- dwAlphaData
                dwAlphaData = 
                  ((dwDestinationData & LE_BLT_dwRedMask) * dwAlpha / 255 +
                  (dwSourceData & LE_BLT_dwRedMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwRedMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwGreenMask) * dwAlpha / 255 +
                  (dwSourceData & LE_BLT_dwGreenMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwGreenMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwBlueMask) * dwAlpha / 255 +
                  (dwSourceData & LE_BLT_dwBlueMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwBlueMask;
              #line 1839 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 1840 "..\\ArtLib\\L_BLTCPY.cpp"

              // copy the resultant dwAlphaData to destination bitmap
              
                *((LPWORD)lpDestinationBltPointer) = (WORD)dwAlphaData;
                lpDestinationBltPointer += 2;
              







#line 1854 "..\\ArtLib\\L_BLTCPY.cpp"
            }
          }
          else
          {
            // update the destination bitmap pointer
            
              lpDestinationBltPointer += 2;
            



#line 1866 "..\\ArtLib\\L_BLTCPY.cpp"
          }

          // get the pixel counter updated
          PixelCounter --;
        }

        // update pointers to the next scanline
        lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
        lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
        LinesToBlt --;
      }

      // successful
      return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
    }
    #line 1882 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1883 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 246 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.








#line 241 "..\\ArtLib\\L_BLTCPY.cpp"

#line 243 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 246 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 248 "..\\ArtLib\\L_BLTCPY.cpp"


#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 24 ## To ## 24 ## Alpha ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (24, 24, Alpha, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"
    INT16 nAlphaValue,
  #line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/

  

    // (Alpha and Unity) bitmap copy
    // do alpha & unity bitmap copy from 8 bit color depth
    // to 16, 24, and 32 bit colour depths, raw source bitmap

    
    {
      LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
      int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
      LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
      int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes
      int     PixelsAcrossToBlt;             // blt width in pixels

      register int     LinesToBlt;               // blt height in pixels
      register int     PixelCounter;             // pixel counter
      register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
      register DWORD   dwSourceData;             // holder for source data
      register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
      register DWORD   dwDestinationData;        // holders for destination data

      register DWORD dwAlphaData;   // holder source and data blended
      register DWORD dwAlpha;       // 32 bit alpha channel

      RECT  SourceRectangleToUpdate; // source rectangle to be updated
      int   SourceOffsetX;           // offset in pixels used for image clipping
      int   SourceOffsetY;           // used for image clipping
      int   CopyWidth;               // copy width after clipping
      int   CopyHeight;              // copy height after clipping
      int   DestinationOffsetX;      // used for image clipping
      int   DestinationOffsetY;      // used for image clipping
      
        WORD  wPureGreen;            // to filter out pure green colour
      #line 1129 "..\\ArtLib\\L_BLTCPY.cpp"

      // validate the source/destination bitmap pointers

      if( SourceBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1138 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid source bitmap pointer
      }

      if( DestinationBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1147 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid destination bitmap pointer
      }

      // find out the actual source rectangle to be updated using
      // destination bounding rectangle and destination invalid rectangle

      if( DestInvalidRectangle != NULL )
      {
        SourceRectangleToUpdate.left = SourceRectangle->left +
          (DestInvalidRectangle->left - DestBoundingRectangle->left);
        SourceRectangleToUpdate.right = SourceRectangle->left +
          (DestInvalidRectangle->right - DestBoundingRectangle->left);
        SourceRectangleToUpdate.top = SourceRectangle->top +
          (DestInvalidRectangle->top - DestBoundingRectangle->top);
        SourceRectangleToUpdate.bottom = SourceRectangle->top +
          (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangleToUpdate.left;
        SourceOffsetY = (int) SourceRectangleToUpdate.top;
        CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
        CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
      }
      else // don't know the DestInvalidRectangle
      {
        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
        CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
      }

      DestinationOffsetX = DestinationX;
      DestinationOffsetY = DestinationY;
      
      // get both source and destination bitmaps clipped
      LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
        &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
        &DestinationOffsetX, &DestinationOffsetY,
        DestinationBitmapWidth, DestinationBitmapHeight);
      
      // calculate bitmap widths in bytes
      // force all pixels aligned by 4 bytes boundary

      

#line 1194 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1196 "..\\ArtLib\\L_BLTCPY.cpp"
        SourceBitmapWidthInBytes = (SourceBitmapWidth * 3 + 3) & 0xfffffffc;
      

#line 1200 "..\\ArtLib\\L_BLTCPY.cpp"

      

#line 1204 "..\\ArtLib\\L_BLTCPY.cpp"
        DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 3 + 3) & 0xfffffffc;
      

#line 1208 "..\\ArtLib\\L_BLTCPY.cpp"
      
      // calculate start position of blt in source bitmap
      lpSourceScanlineBeginBlt = SourceBitmapBits + SourceOffsetY *
        SourceBitmapWidthInBytes;
      

#line 1215 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1217 "..\\ArtLib\\L_BLTCPY.cpp"
        lpSourceScanlineBeginBlt += SourceOffsetX * 3;
      

#line 1221 "..\\ArtLib\\L_BLTCPY.cpp"

      // calculate start position of blt in destination bitmap
      lpDestinationScanlineBeginBlt = DestinationBitmapBits +
        DestinationOffsetY * DestinationBitmapWidthInBytes;
      

#line 1228 "..\\ArtLib\\L_BLTCPY.cpp"
        lpDestinationScanlineBeginBlt += DestinationOffsetX * 3;
      

#line 1232 "..\\ArtLib\\L_BLTCPY.cpp"

      // If not 8 bit colour depth, we need to filter out
      // all pure green colour pixels.
      



#line 1240 "..\\ArtLib\\L_BLTCPY.cpp"
        // make a COLORREF for pure green colour
        wPureGreen = (WORD) LI_BLT_ConvertColorRefTo24BitColor(
          (COLORREF) RGB (0, 255, 0));
      



#line 1248 "..\\ArtLib\\L_BLTCPY.cpp"
        
      
        // get the alpha data
        dwAlpha = (DWORD) nAlphaValue;

        
          // check the validity of dwAlpha
          if ( dwAlpha < 0 || dwAlpha > 255 )
          {
            if ( dwAlpha < 0 )
              dwAlpha = 0;
            else
              dwAlpha = 255;
          }
        #line 1263 "..\\ArtLib\\L_BLTCPY.cpp"
      #line 1264 "..\\ArtLib\\L_BLTCPY.cpp"

      // get the image width and height after clipping
      LinesToBlt = CopyHeight;
      PixelsAcrossToBlt = CopyWidth;
      
      while (LinesToBlt > 0)
      {
        // initialise current blt pointers
        lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
        lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
        // initialise pixel counter
        PixelCounter = PixelsAcrossToBlt;
        while (PixelCounter > 0)
        {
          // process one pixel each time

          // get one pixel of source data
          


#line 1286 "..\\ArtLib\\L_BLTCPY.cpp"



#line 1290 "..\\ArtLib\\L_BLTCPY.cpp"
//            dwDestinationData = *((LPDWORD)lpSourceBltPointer);
//            dwSourceData = dwDestinationData &= 0x00ffffff;
//            lpSourceBltPointer += 3;
            dwDestinationData = *((LPWORD)lpSourceBltPointer);
            lpSourceBltPointer += 2;
            dwDestinationData |= (((DWORD) *((LPBYTE)lpSourceBltPointer)) << 16);
            lpSourceBltPointer ++;
            dwSourceData = dwDestinationData;
          


#line 1302 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 1306 "..\\ArtLib\\L_BLTCPY.cpp"
          if( dwSourceData != wPureGreen ) // use pure green colour key
        #line 1308 "..\\ArtLib\\L_BLTCPY.cpp"
          {
          


























#line 1337 "..\\ArtLib\\L_BLTCPY.cpp"
            {
              // get the alpha channel data from the source bitmap
              


#line 1343 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel data from the destination bitmap
              

#line 1348 "..\\ArtLib\\L_BLTCPY.cpp"
                dwSourceData = *((LPLONG)lpDestinationBltPointer) & 0x00ffffff;
              

#line 1352 "..\\ArtLib\\L_BLTCPY.cpp"

              // do alpha channel effect here ...

            



















































































































































































































































































































































































































































#line 1792 "..\\ArtLib\\L_BLTCPY.cpp"
              































#line 1825 "..\\ArtLib\\L_BLTCPY.cpp"
                // work out the final alpha effect -- dwAlphaData
                dwAlphaData = 
                  ((dwDestinationData & LE_BLT_dwRedMask) * dwAlpha / 255 +
                  (dwSourceData & LE_BLT_dwRedMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwRedMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwGreenMask) * dwAlpha / 255 +
                  (dwSourceData & LE_BLT_dwGreenMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwGreenMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwBlueMask) * dwAlpha / 255 +
                  (dwSourceData & LE_BLT_dwBlueMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwBlueMask;
              #line 1839 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 1840 "..\\ArtLib\\L_BLTCPY.cpp"

              // copy the resultant dwAlphaData to destination bitmap
              


#line 1846 "..\\ArtLib\\L_BLTCPY.cpp"
                *((LPWORD)lpDestinationBltPointer) = (WORD)dwAlphaData;
                lpDestinationBltPointer += 2;
                *((LPBYTE)lpDestinationBltPointer) = (BYTE)(dwAlphaData >> 16);
                lpDestinationBltPointer += 1;
              


#line 1854 "..\\ArtLib\\L_BLTCPY.cpp"
            }
          }
          else
          {
            // update the destination bitmap pointer
            

#line 1862 "..\\ArtLib\\L_BLTCPY.cpp"
              lpDestinationBltPointer += 3;
            

#line 1866 "..\\ArtLib\\L_BLTCPY.cpp"
          }

          // get the pixel counter updated
          PixelCounter --;
        }

        // update pointers to the next scanline
        lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
        lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
        LinesToBlt --;
      }

      // successful
      return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
    }
    #line 1882 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1883 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 252 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.








#line 241 "..\\ArtLib\\L_BLTCPY.cpp"

#line 243 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 246 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 248 "..\\ArtLib\\L_BLTCPY.cpp"


#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/


  




#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 32 ## To ## 32 ## Alpha ## Unity ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (32, 32, Alpha, Unity, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"
    INT16 nAlphaValue,
  #line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,


#line 328 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer DestBoundingRectangle,
  INT16 DestinationX,
  INT16 DestinationY)
#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/

  

    // (Alpha and Unity) bitmap copy
    // do alpha & unity bitmap copy from 8 bit color depth
    // to 16, 24, and 32 bit colour depths, raw source bitmap

    
    {
      LPBYTE  lpSourceScanlineBeginBlt;      // pointer to source scanline position to begin blt
      int     SourceBitmapWidthInBytes;      // source bitmap width in bytes
      LPBYTE  lpDestinationScanlineBeginBlt; // pointer to destination scanline position to begin blt
      int     DestinationBitmapWidthInBytes; // destination bitmap width in bytes
      int     PixelsAcrossToBlt;             // blt width in pixels

      register int     LinesToBlt;               // blt height in pixels
      register int     PixelCounter;             // pixel counter
      register LPBYTE  lpSourceBltPointer;       // pointer to current blt source
      register DWORD   dwSourceData;             // holder for source data
      register LPBYTE  lpDestinationBltPointer;  // pointer to current blt destination
      register DWORD   dwDestinationData;        // holders for destination data

      register DWORD dwAlphaData;   // holder source and data blended
      register DWORD dwAlpha;       // 32 bit alpha channel

      RECT  SourceRectangleToUpdate; // source rectangle to be updated
      int   SourceOffsetX;           // offset in pixels used for image clipping
      int   SourceOffsetY;           // used for image clipping
      int   CopyWidth;               // copy width after clipping
      int   CopyHeight;              // copy height after clipping
      int   DestinationOffsetX;      // used for image clipping
      int   DestinationOffsetY;      // used for image clipping
      
        WORD  wPureGreen;            // to filter out pure green colour
      #line 1129 "..\\ArtLib\\L_BLTCPY.cpp"

      // validate the source/destination bitmap pointers

      if( SourceBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1138 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid source bitmap pointer
      }

      if( DestinationBitmapBits == NULL )
      {
      
        sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
        LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
      #line 1147 "..\\ArtLib\\L_BLTCPY.cpp"
        return FALSE;  // invalid destination bitmap pointer
      }

      // find out the actual source rectangle to be updated using
      // destination bounding rectangle and destination invalid rectangle

      if( DestInvalidRectangle != NULL )
      {
        SourceRectangleToUpdate.left = SourceRectangle->left +
          (DestInvalidRectangle->left - DestBoundingRectangle->left);
        SourceRectangleToUpdate.right = SourceRectangle->left +
          (DestInvalidRectangle->right - DestBoundingRectangle->left);
        SourceRectangleToUpdate.top = SourceRectangle->top +
          (DestInvalidRectangle->top - DestBoundingRectangle->top);
        SourceRectangleToUpdate.bottom = SourceRectangle->top +
          (DestInvalidRectangle->bottom - DestBoundingRectangle->top);

        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangleToUpdate.left;
        SourceOffsetY = (int) SourceRectangleToUpdate.top;
        CopyWidth  = (int) (SourceRectangleToUpdate.right - SourceRectangleToUpdate.left);
        CopyHeight = (int) (SourceRectangleToUpdate.bottom - SourceRectangleToUpdate.top);
      }
      else // don't know the DestInvalidRectangle
      {
        // initialise clipping parameters
        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        CopyWidth  = (int) (SourceRectangle->right - SourceRectangle->left);
        CopyHeight = (int) (SourceRectangle->bottom - SourceRectangle->top);
      }

      DestinationOffsetX = DestinationX;
      DestinationOffsetY = DestinationY;
      
      // get both source and destination bitmaps clipped
      LI_BLT_GetBitmapClipped(&SourceOffsetX, &SourceOffsetY,
        &CopyWidth, &CopyHeight, SourceBitmapWidth, SourceBitmapHeight,
        &DestinationOffsetX, &DestinationOffsetY,
        DestinationBitmapWidth, DestinationBitmapHeight);
      
      // calculate bitmap widths in bytes
      // force all pixels aligned by 4 bytes boundary

      

#line 1194 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1196 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1198 "..\\ArtLib\\L_BLTCPY.cpp"
        SourceBitmapWidthInBytes = SourceBitmapWidth * 4;
      #line 1200 "..\\ArtLib\\L_BLTCPY.cpp"

      

#line 1204 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1206 "..\\ArtLib\\L_BLTCPY.cpp"
        DestinationBitmapWidthInBytes = DestinationBitmapWidth * 4;
      #line 1208 "..\\ArtLib\\L_BLTCPY.cpp"
      
      // calculate start position of blt in source bitmap
      lpSourceScanlineBeginBlt = SourceBitmapBits + SourceOffsetY *
        SourceBitmapWidthInBytes;
      

#line 1215 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1217 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1219 "..\\ArtLib\\L_BLTCPY.cpp"
        lpSourceScanlineBeginBlt += SourceOffsetX * 4;
      #line 1221 "..\\ArtLib\\L_BLTCPY.cpp"

      // calculate start position of blt in destination bitmap
      lpDestinationScanlineBeginBlt = DestinationBitmapBits +
        DestinationOffsetY * DestinationBitmapWidthInBytes;
      

#line 1228 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1230 "..\\ArtLib\\L_BLTCPY.cpp"
        lpDestinationScanlineBeginBlt += DestinationOffsetX * 4;
      #line 1232 "..\\ArtLib\\L_BLTCPY.cpp"

      // If not 8 bit colour depth, we need to filter out
      // all pure green colour pixels.
      



#line 1240 "..\\ArtLib\\L_BLTCPY.cpp"



#line 1244 "..\\ArtLib\\L_BLTCPY.cpp"
        // make a COLORREF for pure green colour
        wPureGreen = (WORD) LI_BLT_ConvertColorRefTo32BitColor(
          (COLORREF) RGB (0, 255, 0));
      #line 1248 "..\\ArtLib\\L_BLTCPY.cpp"
        
      
        // get the alpha data
        dwAlpha = (DWORD) nAlphaValue;

        
          // check the validity of dwAlpha
          if ( dwAlpha < 0 || dwAlpha > 255 )
          {
            if ( dwAlpha < 0 )
              dwAlpha = 0;
            else
              dwAlpha = 255;
          }
        #line 1263 "..\\ArtLib\\L_BLTCPY.cpp"
      #line 1264 "..\\ArtLib\\L_BLTCPY.cpp"

      // get the image width and height after clipping
      LinesToBlt = CopyHeight;
      PixelsAcrossToBlt = CopyWidth;
      
      while (LinesToBlt > 0)
      {
        // initialise current blt pointers
        lpDestinationBltPointer = lpDestinationScanlineBeginBlt;
        lpSourceBltPointer = lpSourceScanlineBeginBlt;
        
        // initialise pixel counter
        PixelCounter = PixelsAcrossToBlt;
        while (PixelCounter > 0)
        {
          // process one pixel each time

          // get one pixel of source data
          


#line 1286 "..\\ArtLib\\L_BLTCPY.cpp"



#line 1290 "..\\ArtLib\\L_BLTCPY.cpp"








#line 1299 "..\\ArtLib\\L_BLTCPY.cpp"
            dwSourceData = dwDestinationData = *((LPLONG)lpSourceBltPointer);
            lpSourceBltPointer += 4;
          #line 1302 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 1306 "..\\ArtLib\\L_BLTCPY.cpp"
          if( dwSourceData != wPureGreen ) // use pure green colour key
        #line 1308 "..\\ArtLib\\L_BLTCPY.cpp"
          {
          


























#line 1337 "..\\ArtLib\\L_BLTCPY.cpp"
            {
              // get the alpha channel data from the source bitmap
              


#line 1343 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel data from the destination bitmap
              

#line 1348 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1350 "..\\ArtLib\\L_BLTCPY.cpp"
                dwSourceData = *((LPLONG)lpDestinationBltPointer);
              #line 1352 "..\\ArtLib\\L_BLTCPY.cpp"

              // do alpha channel effect here ...

            



















































































































































































































































































































































































































































#line 1792 "..\\ArtLib\\L_BLTCPY.cpp"
              































#line 1825 "..\\ArtLib\\L_BLTCPY.cpp"
                // work out the final alpha effect -- dwAlphaData
                dwAlphaData = 
                  ((dwDestinationData & LE_BLT_dwRedMask) * dwAlpha / 255 +
                  (dwSourceData & LE_BLT_dwRedMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwRedMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwGreenMask) * dwAlpha / 255 +
                  (dwSourceData & LE_BLT_dwGreenMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwGreenMask;
                dwAlphaData |=
                  ((dwDestinationData & LE_BLT_dwBlueMask) * dwAlpha / 255 +
                  (dwSourceData & LE_BLT_dwBlueMask) * (255 - dwAlpha) / 255)
                  & LE_BLT_dwBlueMask;
              #line 1839 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 1840 "..\\ArtLib\\L_BLTCPY.cpp"

              // copy the resultant dwAlphaData to destination bitmap
              


#line 1846 "..\\ArtLib\\L_BLTCPY.cpp"




#line 1851 "..\\ArtLib\\L_BLTCPY.cpp"
                *((LPLONG)lpDestinationBltPointer) = dwAlphaData;
                lpDestinationBltPointer += 4;
              #line 1854 "..\\ArtLib\\L_BLTCPY.cpp"
            }
          }
          else
          {
            // update the destination bitmap pointer
            

#line 1862 "..\\ArtLib\\L_BLTCPY.cpp"

#line 1864 "..\\ArtLib\\L_BLTCPY.cpp"
              lpDestinationBltPointer += 4;
            #line 1866 "..\\ArtLib\\L_BLTCPY.cpp"
          }

          // get the pixel counter updated
          PixelCounter --;
        }

        // update pointers to the next scanline
        lpDestinationScanlineBeginBlt += DestinationBitmapWidthInBytes;
        lpSourceScanlineBeginBlt += SourceBitmapWidthInBytes;
        LinesToBlt --;
      }

      // successful
      return TRUE;   // from 8 bit to 16, 24, and 32 bit colour depths
    }
    #line 1882 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 1883 "..\\ArtLib\\L_BLTCPY.cpp"
#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 258 "..\\ArtLib\\L_BltInc.cpp"


//
//
// =============================================================
//
//          Stretching & Solid, Raw bitmap copy
//














#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 16 ## Solid ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 16, Solid, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        
          
            register DWORD dwSourceData;           // holder for source data
            
              register DWORD   dwDestinationData1; // holders for destination data
            #line 1981 "..\\ArtLib\\L_BLTCPY.cpp"
          #line 1982 "..\\ArtLib\\L_BLTCPY.cpp"
        









#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        























#line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        
          // from 8 bit to 16 bit colour depth
          
            return LI_BLT_Copy8To16SolidUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceColorTable,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);

          // from 8 bit to 24 bit colour depth
          










































































#line 2154 "..\\ArtLib\\L_BLTCPY.cpp"
        





























































































#line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX;
        











#line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 2;
        







#line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              
                SourceBitsPntr += Counter;
              





#line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            





































































































#line 2602 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel of source data
              
                
                  dwSourceData = *SourceBitsPntr;
                



#line 2612 "..\\ArtLib\\L_BLTCPY.cpp"
              #line 2613 "..\\ArtLib\\L_BLTCPY.cpp"

              // from 8 bit to 16 bit colour depth
              

                // convert 8 bit indices to 16 bit color values
                // and copy the converted data to destination bitmap

                
                  dwDestinationData1 = SourceColorTable[(dwSourceData & 0xff) * 2];
                  *((LPWORD)DestinationBitsPntr) = (WORD)dwDestinationData1;
                  DestinationBitsPntr += 2;

                

































#line 2660 "..\\ArtLib\\L_BLTCPY.cpp"

              // from 8 bit to 24 bit colour depth
              








































































































#line 2768 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 281 "..\\ArtLib\\L_BltInc.cpp"



#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 24 ## Solid ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 24, Solid, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        
          
            register DWORD dwSourceData;           // holder for source data
            
              register DWORD   dwDestinationData1; // holders for destination data
            #line 1981 "..\\ArtLib\\L_BLTCPY.cpp"
          #line 1982 "..\\ArtLib\\L_BLTCPY.cpp"
        









#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        























#line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        
          // from 8 bit to 16 bit colour depth
          















#line 2079 "..\\ArtLib\\L_BLTCPY.cpp"
            return LI_BLT_Copy8To24SolidUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceColorTable,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);

          // from 8 bit to 32 bit colour depth
          


























































#line 2154 "..\\ArtLib\\L_BLTCPY.cpp"
        





























































































#line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 2379 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX;
        











#line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        



#line 2410 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 3;
        



#line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              
                SourceBitsPntr += Counter;
              





#line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            





































































































#line 2602 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel of source data
              
                
                  dwSourceData = *SourceBitsPntr;
                



#line 2612 "..\\ArtLib\\L_BLTCPY.cpp"
              #line 2613 "..\\ArtLib\\L_BLTCPY.cpp"

              // from 8 bit to 16 bit colour depth
              














































#line 2663 "..\\ArtLib\\L_BLTCPY.cpp"

                
                  // convert 8 bit indices to 24 bit color values
                  dwDestinationData1 = SourceColorTable[(dwSourceData & 0xff) * 2];

                  // copy the converted data to destination bitmap
                  *((LPWORD)DestinationBitsPntr) = (WORD)(dwDestinationData1);
                  DestinationBitsPntr += 2;
                  *((LPBYTE)DestinationBitsPntr) = (BYTE)(dwDestinationData1 >> 16);
                  DestinationBitsPntr += 1;

                













































#line 2721 "..\\ArtLib\\L_BLTCPY.cpp"

              // from 8 bit to 32 bit colour depth
              











































#line 2768 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 285 "..\\ArtLib\\L_BltInc.cpp"



#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 32 ## Solid ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 32, Solid, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        
          
            register DWORD dwSourceData;           // holder for source data
            

#line 1981 "..\\ArtLib\\L_BLTCPY.cpp"
          #line 1982 "..\\ArtLib\\L_BLTCPY.cpp"
        









#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        























#line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        
          // from 8 bit to 16 bit colour depth
          















#line 2079 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2095 "..\\ArtLib\\L_BLTCPY.cpp"
            return LI_BLT_Copy8To32SolidUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceColorTable,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);

          // from 16 bit to 16 bit colour depth
          










































#line 2154 "..\\ArtLib\\L_BLTCPY.cpp"
        





























































































#line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 2379 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2381 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = DestinationBitmapWidth * 4;
        #line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX;
        











#line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        



#line 2410 "..\\ArtLib\\L_BLTCPY.cpp"



#line 2414 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 4;
        #line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              
                SourceBitsPntr += Counter;
              





#line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            





































































































#line 2602 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel of source data
              
                
                  dwSourceData = *SourceBitsPntr;
                



#line 2612 "..\\ArtLib\\L_BLTCPY.cpp"
              #line 2613 "..\\ArtLib\\L_BLTCPY.cpp"

              // from 8 bit to 16 bit colour depth
              














































#line 2663 "..\\ArtLib\\L_BLTCPY.cpp"




























































#line 2724 "..\\ArtLib\\L_BLTCPY.cpp"
                // convert 8 bit indices to 32 bit color values
                // and copy the converted data to destination bitmap

                
                  *((LPLONG)DestinationBitsPntr) = SourceColorTable[(dwSourceData & 0xff) * 2];
                  DestinationBitsPntr += 4;

                


































#line 2767 "..\\ArtLib\\L_BLTCPY.cpp"
              #line 2768 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 289 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 16 ## To ## 16 ## Solid ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (16, 16, Solid, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        
          




#line 1982 "..\\ArtLib\\L_BLTCPY.cpp"
        









#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        























#line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        
          // from 8 bit to 16 bit colour depth
          















#line 2079 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2095 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2111 "..\\ArtLib\\L_BLTCPY.cpp"
            return LI_BLT_Copy16To16SolidUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);

          // from 24 bit to 24 bit colour depth
          



























#line 2154 "..\\ArtLib\\L_BLTCPY.cpp"
        





























































































#line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        

#line 2369 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = (SourceBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        



#line 2392 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX * 2;
        







#line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 2;
        







#line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              

#line 2488 "..\\ArtLib\\L_BLTCPY.cpp"
                SourceBitsPntr += Counter * 2;
              



#line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            

              // for 16 bit colour depth
              
                
                  *((LPWORD)DestinationBitsPntr) = *((LPWORD)SourceBitsPntr);
                  DestinationBitsPntr += 2;
                






















#line 2530 "..\\ArtLib\\L_BLTCPY.cpp"

              // for 24 bit colour depth
              



































































#line 2601 "..\\ArtLib\\L_BLTCPY.cpp"
            






































































































































































#line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 295 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 24 ## To ## 24 ## Solid ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (24, 24, Solid, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        
          




#line 1982 "..\\ArtLib\\L_BLTCPY.cpp"
        









#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        























#line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        
          // from 8 bit to 16 bit colour depth
          















#line 2079 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2095 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2111 "..\\ArtLib\\L_BLTCPY.cpp"














#line 2126 "..\\ArtLib\\L_BLTCPY.cpp"
            return LI_BLT_Copy24To24SolidUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);

          // from 32 bit to 32 bit colour depth
          












#line 2154 "..\\ArtLib\\L_BLTCPY.cpp"
        





























































































#line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        

#line 2369 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2371 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = (SourceBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 2379 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        



#line 2392 "..\\ArtLib\\L_BLTCPY.cpp"



#line 2396 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX * 3;
        



#line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        



#line 2410 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 3;
        



#line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              

#line 2488 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2490 "..\\ArtLib\\L_BLTCPY.cpp"
                SourceBitsPntr += Counter * 3;
              

#line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            

              // for 16 bit colour depth
              





























#line 2533 "..\\ArtLib\\L_BLTCPY.cpp"
                
                  *((LPWORD)DestinationBitsPntr) = *((LPWORD)SourceBitsPntr);
                  SourceBitsPntr += 2;
                  DestinationBitsPntr += 2;
                  *((LPBYTE)DestinationBitsPntr) = *((LPBYTE)SourceBitsPntr);
                  DestinationBitsPntr += 1;

                  // set SourceBitsPntr back 2 bytes ( restore it )
                  SourceBitsPntr -= 2;
                



























#line 2571 "..\\ArtLib\\L_BLTCPY.cpp"

              // for 32 bit colour depth
              


























#line 2601 "..\\ArtLib\\L_BLTCPY.cpp"
            






































































































































































#line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 301 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  

#line 238 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 32 ## To ## 32 ## Solid ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (32, 32, Solid, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        
          




#line 1982 "..\\ArtLib\\L_BLTCPY.cpp"
        









#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        























#line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        
          // from 8 bit to 16 bit colour depth
          















#line 2079 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2095 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2111 "..\\ArtLib\\L_BLTCPY.cpp"














#line 2126 "..\\ArtLib\\L_BLTCPY.cpp"














#line 2141 "..\\ArtLib\\L_BLTCPY.cpp"
            return LI_BLT_Copy32To32SolidUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);
          #line 2154 "..\\ArtLib\\L_BLTCPY.cpp"
        





























































































#line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        

#line 2369 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2371 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2373 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = SourceBitmapWidth * 4;
        #line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 2379 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2381 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = DestinationBitmapWidth * 4;
        #line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        



#line 2392 "..\\ArtLib\\L_BLTCPY.cpp"



#line 2396 "..\\ArtLib\\L_BLTCPY.cpp"



#line 2400 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX * 4;
        #line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        



#line 2410 "..\\ArtLib\\L_BLTCPY.cpp"



#line 2414 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 4;
        #line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              

#line 2488 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2490 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2492 "..\\ArtLib\\L_BLTCPY.cpp"
                SourceBitsPntr += Counter * 4;
              #line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            

              // for 16 bit colour depth
              





























#line 2533 "..\\ArtLib\\L_BLTCPY.cpp"








































#line 2574 "..\\ArtLib\\L_BLTCPY.cpp"
                
                  *((LPLONG)DestinationBitsPntr) = *((LPLONG)SourceBitsPntr);
                  DestinationBitsPntr += 4;
                





















#line 2600 "..\\ArtLib\\L_BLTCPY.cpp"
              #line 2601 "..\\ArtLib\\L_BLTCPY.cpp"
            






































































































































































#line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 307 "..\\ArtLib\\L_BltInc.cpp"

//
//
// =============================================================
//
//          Stretching & Solid with Colour Key, Raw bitmap copy
//














#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 16 ## SolidColourKey ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 16, SolidColourKey, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        






#line 1983 "..\\ArtLib\\L_BLTCPY.cpp"
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
        

#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          
            redLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          













#line 2054 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        





























































































#line 2155 "..\\ArtLib\\L_BLTCPY.cpp"
          // from 8 bit to 16 bit colour depth
          
            return LI_BLT_Copy8To16SolidColourKeyUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceColorTable,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);

          // from 8 bit to 24 bit colour depth
          










































































#line 2248 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX;
        











#line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 2;
        







#line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              
                SourceBitsPntr += Counter;
              





#line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            





































































































#line 2602 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel of source data
              
                

#line 2608 "..\\ArtLib\\L_BLTCPY.cpp"
                  rawPixel = *SourceBitsPntr;
                

#line 2612 "..\\ArtLib\\L_BLTCPY.cpp"
              #line 2613 "..\\ArtLib\\L_BLTCPY.cpp"

              // from 8 bit to 16 bit colour depth
              

                // convert 8 bit indices to 16 bit color values
                // and copy the converted data to destination bitmap

                




#line 2626 "..\\ArtLib\\L_BLTCPY.cpp"
                  rawPixel = SourceColorTable[(rawPixel & 0xff) * 2];

                  // see if the pixel needs to be copied
                  
                    if( (rawPixel & redMask) >= redLimit  ||
                      (rawPixel & greenMask) < greenLimit ||
                      (rawPixel & blueMask) >= blueLimit )
                  





#line 2640 "..\\ArtLib\\L_BLTCPY.cpp"
                  {
                    *((LPWORD)DestinationBitsPntr) = (WORD) rawPixel;
                  }

                  // update DestinationBitsPntr
                  DestinationBitsPntr += 2;  // advanced 2 bytes

                











#line 2660 "..\\ArtLib\\L_BLTCPY.cpp"

              // from 8 bit to 24 bit colour depth
              








































































































#line 2768 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 329 "..\\ArtLib\\L_BltInc.cpp"



#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 24 ## SolidColourKey ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 24, SolidColourKey, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        






#line 1983 "..\\ArtLib\\L_BLTCPY.cpp"
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
        

#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          






#line 2040 "..\\ArtLib\\L_BLTCPY.cpp"
            redLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          






#line 2054 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        





























































































#line 2155 "..\\ArtLib\\L_BLTCPY.cpp"
          // from 8 bit to 16 bit colour depth
          















#line 2173 "..\\ArtLib\\L_BLTCPY.cpp"
            return LI_BLT_Copy8To24SolidColourKeyUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceColorTable,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);

          // from 8 bit to 32 bit colour depth
          


























































#line 2248 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 2379 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX;
        











#line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        



#line 2410 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 3;
        



#line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              
                SourceBitsPntr += Counter;
              





#line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            





































































































#line 2602 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel of source data
              
                

#line 2608 "..\\ArtLib\\L_BLTCPY.cpp"
                  rawPixel = *SourceBitsPntr;
                

#line 2612 "..\\ArtLib\\L_BLTCPY.cpp"
              #line 2613 "..\\ArtLib\\L_BLTCPY.cpp"

              // from 8 bit to 16 bit colour depth
              














































#line 2663 "..\\ArtLib\\L_BLTCPY.cpp"

                









#line 2675 "..\\ArtLib\\L_BLTCPY.cpp"
                  rawPixel = SourceColorTable[(rawPixel & 0xff) * 2];

                  // see if the pixel needs to be copied
                  
                    if( (rawPixel & redMask) >= redLimit  ||
                      (rawPixel & greenMask) < greenLimit ||
                      (rawPixel & blueMask) >= blueLimit )
                  





#line 2689 "..\\ArtLib\\L_BLTCPY.cpp"
                  {
                    *((LPWORD)DestinationBitsPntr) = (WORD) rawPixel;
                    DestinationBitsPntr += 2;
                    *((LPBYTE)DestinationBitsPntr) = (BYTE) (((DWORD) rawPixel) >> 16);
                    DestinationBitsPntr ++;
                  }
                  else
                  {
                    // if the pixel is not copied (transparent),
                    // update DestinationBitsPntr
                    DestinationBitsPntr += 3;
                  }

                

















#line 2721 "..\\ArtLib\\L_BLTCPY.cpp"

              // from 8 bit to 32 bit colour depth
              











































#line 2768 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 333 "..\\ArtLib\\L_BltInc.cpp"



#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 32 ## SolidColourKey ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 32, SolidColourKey, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    

#line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        






#line 1983 "..\\ArtLib\\L_BLTCPY.cpp"
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
        

#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          






#line 2040 "..\\ArtLib\\L_BLTCPY.cpp"






#line 2047 "..\\ArtLib\\L_BLTCPY.cpp"
            redLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          #line 2054 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        





























































































#line 2155 "..\\ArtLib\\L_BLTCPY.cpp"
          // from 8 bit to 16 bit colour depth
          















#line 2173 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2189 "..\\ArtLib\\L_BLTCPY.cpp"
            return LI_BLT_Copy8To32SolidColourKeyUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceColorTable,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);

          // from 16 bit to 16 bit colour depth
          










































#line 2248 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        
          SourceBitmapWidthInBytes = (SourceBitmapWidth + 3) & 0xfffffffc;
        





#line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 2379 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2381 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = DestinationBitmapWidth * 4;
        #line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX;
        











#line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        



#line 2410 "..\\ArtLib\\L_BLTCPY.cpp"



#line 2414 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 4;
        #line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              
                SourceBitsPntr += Counter;
              





#line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            





































































































#line 2602 "..\\ArtLib\\L_BLTCPY.cpp"

              // get one pixel of source data
              
                

#line 2608 "..\\ArtLib\\L_BLTCPY.cpp"
                  rawPixel = *SourceBitsPntr;
                

#line 2612 "..\\ArtLib\\L_BLTCPY.cpp"
              #line 2613 "..\\ArtLib\\L_BLTCPY.cpp"

              // from 8 bit to 16 bit colour depth
              














































#line 2663 "..\\ArtLib\\L_BLTCPY.cpp"




























































#line 2724 "..\\ArtLib\\L_BLTCPY.cpp"
                // convert 8 bit indices to 32 bit color values
                // and copy the converted data to destination bitmap

                



#line 2732 "..\\ArtLib\\L_BLTCPY.cpp"
                  rawPixel = SourceColorTable[(rawPixel & 0xff) * 2];

                  // see if the pixel needs to be copied
                  
                    if( (rawPixel & redMask) >= redLimit  ||
                      (rawPixel & greenMask) < greenLimit ||
                      (rawPixel & blueMask) >= blueLimit )
                  





#line 2746 "..\\ArtLib\\L_BLTCPY.cpp"
                  {
                    *((LPLONG)DestinationBitsPntr) = (DWORD) rawPixel;
                  }

                  // update DestinationBitsPntr
                  DestinationBitsPntr += 4;

                












#line 2767 "..\\ArtLib\\L_BLTCPY.cpp"
              #line 2768 "..\\ArtLib\\L_BLTCPY.cpp"
            #line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 337 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 16 ## To ## 16 ## SolidColourKey ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (16, 16, SolidColourKey, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        






#line 1983 "..\\ArtLib\\L_BLTCPY.cpp"
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
        

#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          
            redLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo16BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          













#line 2054 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        





























































































#line 2155 "..\\ArtLib\\L_BLTCPY.cpp"
          // from 8 bit to 16 bit colour depth
          















#line 2173 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2189 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2205 "..\\ArtLib\\L_BLTCPY.cpp"
            return LI_BLT_Copy16To16SolidColourKeyUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);

          // from 24 bit to 24 bit colour depth
          



























#line 2248 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        

#line 2369 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = (SourceBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 2 + 3) & 0xfffffffc;
        



#line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        



#line 2392 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX * 2;
        







#line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 2;
        







#line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              

#line 2488 "..\\ArtLib\\L_BLTCPY.cpp"
                SourceBitsPntr += Counter * 2;
              



#line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            

              // for 16 bit colour depth
              
                


#line 2507 "..\\ArtLib\\L_BLTCPY.cpp"
                  // get one pixel of source data
                  rawPixel = *((LPWORD)SourceBitsPntr);

                  // see if the pixel needs to be copied
                  
                    if( (rawPixel & redMask) >= redLimit  ||
                      (rawPixel & greenMask) < greenLimit ||
                      (rawPixel & blueMask) >= blueLimit )
                  





#line 2522 "..\\ArtLib\\L_BLTCPY.cpp"
                  {
                    // copy this pixel to destination bitmap
                    *((LPWORD)DestinationBitsPntr) = (WORD) rawPixel;
                  }

                  // update DestinationBitsPntr
                  DestinationBitsPntr += 2;
                #line 2530 "..\\ArtLib\\L_BLTCPY.cpp"

              // for 24 bit colour depth
              



































































#line 2601 "..\\ArtLib\\L_BLTCPY.cpp"
            






































































































































































#line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 343 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 24 ## To ## 24 ## SolidColourKey ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (24, 24, SolidColourKey, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        






#line 1983 "..\\ArtLib\\L_BLTCPY.cpp"
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
        

#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          






#line 2040 "..\\ArtLib\\L_BLTCPY.cpp"
            redLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo24BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          






#line 2054 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        





























































































#line 2155 "..\\ArtLib\\L_BLTCPY.cpp"
          // from 8 bit to 16 bit colour depth
          















#line 2173 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2189 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2205 "..\\ArtLib\\L_BLTCPY.cpp"














#line 2220 "..\\ArtLib\\L_BLTCPY.cpp"
            return LI_BLT_Copy24To24SolidColourKeyUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);

          // from 32 bit to 32 bit colour depth
          












#line 2248 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        

#line 2369 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2371 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = (SourceBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 2379 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = (DestinationBitmapWidth * 3 + 3) & 0xfffffffc;
        

#line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        



#line 2392 "..\\ArtLib\\L_BLTCPY.cpp"



#line 2396 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX * 3;
        



#line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        



#line 2410 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 3;
        



#line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              

#line 2488 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2490 "..\\ArtLib\\L_BLTCPY.cpp"
                SourceBitsPntr += Counter * 3;
              

#line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            

              // for 16 bit colour depth
              





























#line 2533 "..\\ArtLib\\L_BLTCPY.cpp"
                








#line 2543 "..\\ArtLib\\L_BLTCPY.cpp"
                  // get one pixel of source data
                  rawPixel = *((LPLONG)SourceBitsPntr);

                  // see if the pixel needs to be copied
                  
                    if( (rawPixel & redMask) >= redLimit  ||
                      (rawPixel & greenMask) < greenLimit ||
                      (rawPixel & blueMask) >= blueLimit )
                  





#line 2558 "..\\ArtLib\\L_BLTCPY.cpp"
                  {
                    *((LPWORD)DestinationBitsPntr) = (WORD) rawPixel;
                    DestinationBitsPntr += 2;
                    *((LPBYTE)DestinationBitsPntr) = (BYTE) (((DWORD) rawPixel) >> 16);
                    DestinationBitsPntr ++;
                  }
                  else
                  {
                    // if this pixel is not copied (transparent),
                    // update DestinationBitsPntr
                    DestinationBitsPntr += 3;  // advanced 3 bytes
                  }
                #line 2571 "..\\ArtLib\\L_BLTCPY.cpp"

              // for 32 bit colour depth
              


























#line 2601 "..\\ArtLib\\L_BLTCPY.cpp"
            






































































































































































#line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 349 "..\\ArtLib\\L_BltInc.cpp"





#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.



  
    
  

#line 240 "..\\ArtLib\\L_BLTCPY.cpp"










#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 32 ## To ## 32 ## SolidColourKey ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (32, 32, SolidColourKey, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  




#line 315 "..\\ArtLib\\L_BLTCPY.cpp"

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/

  

    // do solid (holes) & stretching bitmap copy for 8, 16, 24, and 32 bit colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        register int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        register UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        register UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  SourceBitsPntr;       // pointer to current source pixel to copy from
        register UNS8Pointer  DestinationBitsPntr;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        






#line 1983 "..\\ArtLib\\L_BLTCPY.cpp"
          register DWORD  redLimit;
          register DWORD  greenLimit;
          register DWORD  blueLimit;
          register DWORD  redMask = LE_BLT_dwRedMask;
          register DWORD  greenMask = LE_BLT_dwGreenMask;
          register DWORD  blueMask = LE_BLT_dwBlueMask;
          register DWORD  rawPixel;
        

#line 1993 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord XStretchTable;
        StretchTableRecord YStretchTable;

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2005 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2014 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;
        DestinationOffsetY = (int) DestBoundingRectangle->top;
        DestinationWidth   = (int) (DestBoundingRectangle->right - DestBoundingRectangle->left);
        DestinationHeight  = (int) (DestBoundingRectangle->bottom - DestBoundingRectangle->top);

        // If colour key is defined, work out colour limits
        
          // find the colour limits corresponding to the current colour depth.
          






#line 2040 "..\\ArtLib\\L_BLTCPY.cpp"






#line 2047 "..\\ArtLib\\L_BLTCPY.cpp"
            redLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (LE_BLT_KeyRedLimit, 0, 0));
            greenLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (0, LE_BLT_KeyGreenLimit, 0));
            blueLimit = LI_BLT_ConvertColorRefTo32BitColor (
              LE_GRAFIX_MakeColorRef (0, 0, LE_BLT_KeyBlueLimit));
          #line 2054 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2055 "..\\ArtLib\\L_BLTCPY.cpp"

        // Special Case Handling -- no stretching is needed, if both
        // the source and destination rectangles are of the same size
        if( DestinationWidth == SourceWidth && DestinationHeight == SourceHeight )
        {
        





























































































#line 2155 "..\\ArtLib\\L_BLTCPY.cpp"
          // from 8 bit to 16 bit colour depth
          















#line 2173 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2189 "..\\ArtLib\\L_BLTCPY.cpp"















#line 2205 "..\\ArtLib\\L_BLTCPY.cpp"














#line 2220 "..\\ArtLib\\L_BLTCPY.cpp"














#line 2235 "..\\ArtLib\\L_BLTCPY.cpp"
            return LI_BLT_Copy32To32SolidColourKeyUnityRaw (
              SourceBitmapBits,
              SourceBitmapWidth,
              SourceBitmapHeight,
              SourceRectangle,
              DestinationBitmapBits,
              DestinationBitmapWidth,
              DestinationBitmapHeight,
              DestInvalidRectangle,
              DestBoundingRectangle,
              (UNS16)DestinationOffsetX,
              (UNS16)DestinationOffsetY);
          #line 2248 "..\\ArtLib\\L_BLTCPY.cpp"
        #line 2249 "..\\ArtLib\\L_BLTCPY.cpp"
        }  // end of special case, no stretching needed

        // If stretching is needed, then, work out the stretch mapping
        // from source to destination pixels

        // first, initialise the two StretchTable variables
        memset(&XStretchTable, 0, sizeof(StretchTableRecord));
        memset(&YStretchTable, 0, sizeof(StretchTableRecord));

        CalculateStretchTable(&XStretchTable, SourceBitmapWidth, SourceOffsetX,
          SourceWidth, DestinationBitmapWidth, DestinationOffsetX, DestinationWidth);
        
        CalculateStretchTable(&YStretchTable, SourceBitmapHeight, SourceOffsetY,
          SourceHeight, DestinationBitmapHeight, DestinationOffsetY, DestinationHeight);

        // validate the stretch table calculation
        if(XStretchTable.destinationStretchSize <= 0 ||
          YStretchTable.destinationStretchSize <= 0)
          return FALSE;  // Nothing to be done.
        
        // get the final results from the above two calculated stretch tables
        //
        // Note: If the DestInvalidRectangle is given (not NULL), then, work
        //       out the corresponding source area (inside SourceRectangle)
        //       to update.

        if( DestInvalidRectangle != NULL )
        {
          // get the true start offset within the destination rectangle
          DestinationOffsetX = (int) DestInvalidRectangle->left;
          DestinationOffsetY = (int) DestInvalidRectangle->top;

          // width and height to blt
          DestinationWidth = (int) (DestInvalidRectangle->right - DestInvalidRectangle->left);
          DestinationHeight = (int) (DestInvalidRectangle->bottom - DestInvalidRectangle->top);

          // now, find the corresponding start offset in the source rectangle

          // first do X direction (horizontal)

          if( DestInvalidRectangle->left == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >=0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->left;
          }

          XPixelCounter = 0;
          XOffsetPntr = XStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest column.
            if( (Counter = *XOffsetPntr++) != 0 )
            {
              XPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in X direction
          SourceOffsetX = XStretchTable.sourceStartOffset + XPixelCounter;

          // now do Y direction (vertical)

          if( DestInvalidRectangle->top == 0 )
          {
            CurrentRemainingPixel = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            CurrentRemainingPixel = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            CurrentRemainingPixel = (int) DestInvalidRectangle->top;
          }

          YPixelCounter = 0;
          YOffsetPntr = YStretchTable.pixelOffsets;
          while( CurrentRemainingPixel > 0 )
          {
            // Skip the source pixel to the next closest row.
            if( (Counter = *YOffsetPntr++) != 0 )
            {
              YPixelCounter += Counter;
            }

            // update the CurrentRemainingPixel
            CurrentRemainingPixel--;
          }

          // get the source start offset in Y direction
          SourceOffsetY = YStretchTable.sourceStartOffset + YPixelCounter;
        }
        else  // don't know the DestInvalidRectangle
        {
          SourceOffsetX = XStretchTable.sourceStartOffset;
          SourceOffsetY = YStretchTable.sourceStartOffset;
          
          DestinationOffsetX = XStretchTable.destinationStartOffset;
          DestinationOffsetY = YStretchTable.destinationStartOffset;
          
          DestinationWidth = XStretchTable.destinationStretchSize;
          DestinationHeight = YStretchTable.destinationStretchSize;
        }

        // find bitmap width in bytes for both source and destination bitmaps
        // and force pixels to align by 4 bytes boundary

        

#line 2369 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2371 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2373 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceBitmapWidthInBytes = SourceBitmapWidth * 4;
        #line 2375 "..\\ArtLib\\L_BLTCPY.cpp"

        

#line 2379 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2381 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationBitmapWidthInBytes = DestinationBitmapWidth * 4;
        #line 2383 "..\\ArtLib\\L_BLTCPY.cpp"

        // get pointers to their scan lines to begin blt
        // for both source and destination bitmaps

        



#line 2392 "..\\ArtLib\\L_BLTCPY.cpp"



#line 2396 "..\\ArtLib\\L_BLTCPY.cpp"



#line 2400 "..\\ArtLib\\L_BLTCPY.cpp"
          SourceScanlineBltPtr = SourceBitmapBits +
            SourceBitmapWidthInBytes * SourceOffsetY;
          SourceScanlineBltPtr += SourceOffsetX * 4;
        #line 2404 "..\\ArtLib\\L_BLTCPY.cpp"

        



#line 2410 "..\\ArtLib\\L_BLTCPY.cpp"



#line 2414 "..\\ArtLib\\L_BLTCPY.cpp"
          DestinationScanlineBltPtr = DestinationBitmapBits +
            DestinationBitmapWidthInBytes * DestinationOffsetY;
          DestinationScanlineBltPtr += DestinationOffsetX * 4;
        #line 2418 "..\\ArtLib\\L_BLTCPY.cpp"

        // find pixel offsets for DestInvalidRectangle

        YPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->top == 0 )
          {
            YPixelCounter = 0;
          }
          else if( DestInvalidRectangle->top > 0 && DestBoundingRectangle->top >= 0 )
          {
            YPixelCounter = (int) (DestInvalidRectangle->top - DestBoundingRectangle->top);
          }
          else
          {
            YPixelCounter = (int) DestInvalidRectangle->top;
          }
        }

        YOffsetPntr = YStretchTable.pixelOffsets + YPixelCounter;

        XPixelCounter = 0;
        if( DestInvalidRectangle != NULL )
        {
          if( DestInvalidRectangle->left == 0 )
          {
            XPixelCounter = 0;
          }
          else if( DestInvalidRectangle->left > 0 && DestBoundingRectangle->left >= 0 )
          {
            XPixelCounter = (int)(DestInvalidRectangle->left - DestBoundingRectangle->left);
          }
          else
          {
            XPixelCounter = (int) DestInvalidRectangle->left;
          }
        }

        // Copy the scan lines as fast as possible.

        while(DestinationHeight > 0)
        {
          // Skip the source row pointer to the next closest row.
          if( (Counter = *YOffsetPntr++) != 0 )
            SourceScanlineBltPtr += Counter * SourceBitmapWidthInBytes;
          
          // Now copy a scan line, stretching as we go.
          
          // get to the pixel to copy from (in source bitmap) and to (in destination bitmap)

          DestinationBitsPntr = DestinationScanlineBltPtr;
          SourceBitsPntr = SourceScanlineBltPtr;

          XOffsetPntr = (UNS8Pointer) XStretchTable.pixelOffsets + XPixelCounter;

          CurrentDestinationWidth = DestinationWidth;

          // copy a scan line, stretch as we go

          while (CurrentDestinationWidth > 0)
          {
            // Skip the source pointer to the next source pixel.
            
            if ((Counter = *XOffsetPntr++) != 0)
            {
              // Special cases for each of the depths we handle.
              

#line 2488 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2490 "..\\ArtLib\\L_BLTCPY.cpp"

#line 2492 "..\\ArtLib\\L_BLTCPY.cpp"
                SourceBitsPntr += Counter * 4;
              #line 2494 "..\\ArtLib\\L_BLTCPY.cpp"
            }
            
            // Copy a pixel from source to destination and position the
            // destination pointer at the next destination pixel.

            

              // for 16 bit colour depth
              





























#line 2533 "..\\ArtLib\\L_BLTCPY.cpp"








































#line 2574 "..\\ArtLib\\L_BLTCPY.cpp"
                


#line 2578 "..\\ArtLib\\L_BLTCPY.cpp"
                  // get one pixel of source data
                  rawPixel = *((LPLONG)SourceBitsPntr);

                  // see if the pixel needs to be copied
                  
                    if( (rawPixel & redMask) >= redLimit  ||
                      (rawPixel & greenMask) < greenLimit ||
                      (rawPixel & blueMask) >= blueLimit )
                  





#line 2593 "..\\ArtLib\\L_BLTCPY.cpp"
                  {
                    *((LPLONG)DestinationBitsPntr) = rawPixel;
                  }

                  // update DestinationBitsPntr
                  DestinationBitsPntr += 4;  // advanced 4 bytes
                #line 2600 "..\\ArtLib\\L_BLTCPY.cpp"
              #line 2601 "..\\ArtLib\\L_BLTCPY.cpp"
            






































































































































































#line 2769 "..\\ArtLib\\L_BLTCPY.cpp"

            // update the CurrentDestinationWidth
            CurrentDestinationWidth--;
          }
          
          // Move down to the next destination scan line.
          
          DestinationScanlineBltPtr += DestinationBitmapWidthInBytes;
          DestinationHeight--;
        }
        return TRUE;
      }
    #line 2782 "..\\ArtLib\\L_BLTCPY.cpp"
  #line 2783 "..\\ArtLib\\L_BLTCPY.cpp"
#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3863 "..\\ArtLib\\L_BLTCPY.cpp"

  // successful
  return TRUE;
}

// Cleanup - undo all the definitions we made in this file.




#undef FUNCTION_NAME
#undef NAME_TO_STRING
#undef NAME_AS_STRING
#line 355 "..\\ArtLib\\L_BltInc.cpp"

//
//
// =============================================================
//
//          Stretching & Alpha, Raw bitmap copy
//














#line 1 "..\\ArtLib\\L_BLTCPY.cpp"
/*****************************************************************************
 *
 * FILE:        L_BLTCPY.C
 * DESCRIPTION: A snippet of C source code for copying pixels between bitmaps,
 *              it is repeatedly included by L_BLT.c with various different
 *              #defines to control code generation of multiple varieties of
 *              the same pixel copying function.
 *
 * � Copyright 1998 Artech Digital Entertainments.  All rights reserved.
 *
 * $Header: /Artlib_99/ArtLib/L_BltCpy.cpp 12    6/25/99 1:07p Lzou $
 *****************************************************************************
 * $Log: /Artlib_99/ArtLib/L_BltCpy.cpp $
 * 
 * 12    6/25/99 1:07p Lzou
 * Fixed a bug in blt with alpha channel effects. The bug sometimes causes
 * wrong colour effects along edges in 16 bit colour depth.
 * 
 * 11    4/07/99 5:10p Lzou
 * Enabled (8 bit) blit stretch copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 10    4/07/99 4:56p Lzou
 * Enabled (8 bit) blit unity copy routines to use full 255 levels of
 * alpha channel effects.
 * 
 * 9     4/05/99 5:12p Lzou
 * Have implemented bitmap stretch copy with full 255 levels of alpha
 * channel effects for 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 8     4/03/99 4:09p Agmsmith
 * Fix corrupted SourceSafe history.
 * 
 * 8     4/01/99 5:35p Lzou
 * Have implemented bitmap unity copy with 255 alpha levels for 16to16,
 * 24to24, and 32to32 bit colour depths.
 * 
 * 7     3/30/99 12:35p Lzou
 * Some small changes.
 * 
 * 6     3/30/99 12:20p Lzou
 * Fixed one potential bug for 24 bit colour depth.
 * 
 * 5     3/29/99 3:22p Lzou
 * Have implemented bitmap stretch copy with alpha channel effects for
 * 16to16, 24to24, and 32to32 bit colour depths.
 * 
 * 4     3/26/99 5:23p Lzou
 * Fixed one bug in bitmap stretch copy with alpha channel effects from 8
 * to 24 bit colour depth.
 * 
 * 3     3/24/99 5:39p Lzou
 * Have implemented bitmap unity copy with alpha channel effects for 16 to
 * 16 bit colour depth, 24 to 24 bit colour depth, and 32 to 32 bit colour
 * depth.
 * 
 * 2     2/03/99 1:45p Lzou
 * Fixed one bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 1     2/03/99 1:45p Agmsmith
 * SourceSafe went corrupt again, deleted and replaced this file.
 * 
 * 9     2/02/99 10:24a Lzou
 * We have both colour key and holes copy modes from 8 to 16, 24, and 32
 * bit colour depth.
 * 
 * 8     1/29/99 5:06p Lzou
 * Fixed a bug in alpha channel unity bitmap copy from 8 to 24 bit colour
 * depth.
 * 
 * 7     1/28/99 11:39a Lzou
 * Fixed a bug in unity raw bitmap copy from 8 to 24 bit colour depth.
 * 
 * 6     1/22/99 4:47p Lzou
 * Fixed a bug in unity bitmap copy with holes from 8 to 24 bit colour
 * depth.
 * 
 * 5     1/22/99 1:09p Lzou
 * Added in unity bitmap copy with holes from 8 to screen native colour
 * depth.
 * 
 * 4     12/18/98 5:37p Agmsmith
 * Add L_BLT in front of global variables, dwRedShift is just too
 * anonymous.
 * 
 * 3     9/17/98 4:18p Agmsmith
 * Added colour filling functions, compiles under C++ now.
 * 
 * 2     9/15/98 11:56a Agmsmith
 * Converted to use C++
 * 
 * 17    9/10/98 10:41a Agmsmith
 * So include C_Main.h since it is needed.
 * 
 * 16    8/17/98 5:04p Lzou
 * Have done a proof reading. A bug is fixed.
 * 
 * 15    8/17/98 1:25p Lzou
 * Have implemented Holes & Stretching bitmap copy.
 * 
 * 14    8/14/98 3:10p Lzou
 * I am doing Holes & Stretching bitmap copy.
 * 
 * 13    8/13/98 5:29p Lzou
 * Have implemented Solid with Colour Key & Unity bitmap copy.
 * 
 * 12    8/13/98 2:06p Lzou
 * A bug is fixed. The problem is that C_MAIN.h is not included during one
 * of the two levels of preprocessing.
 * 
 * 11    8/13/98 10:18a Lzou
 * Test for the colour key bitmap copy.
 * 
 * 10    8/12/98 5:46p Lzou
 * Debugging the colour key blt.
 * 
 * 9     8/12/98 4:56p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy (from 8
 * bit to 16, 24, and 32 bit colour depth).
 * 
 * 8     8/12/98 1:02p Lzou
 * Have implemented Solid with Colour Key & Stretching bitmap copy.
 * 
 * 7     8/12/98 10:15a Lzou
 * I am now working on Solid with Colour Key & Unity/Stretching bitmap
 * copy.
 * 
 * 6     8/11/98 1:00p Lzou
 * A bug is fixed in bitmap 24 to 24 bit stretching copy.
 * 
 * 5     8/11/98 11:23a Lzou
 * The BLT should now be faster than it was yesterday.
 * 
 * 4     8/10/98 4:34p Lzou
 * Have modified function argument list to include DestInvalidRectangle
 * and DestBoundingRectangle in a bid to make blt faster.
 * 
 * 1     8/10/98 11:39a Lzou
 * Working on BLT speed improving. This is a temporary check in.
 * 
 * 3     8/05/98 5:52p Lzou
 * Have done proof reading.
 * 
 * 2     8/04/98 3:05p Lzou
 * Check my BLT routines into Artech production library.
 * 
 * 16    8/04/98 2:26p Lzou
 * Have finished testing Solid & Unity/Stretching and Alpha &
 * Unity/Stretching BLT routines.
 * 
 * 15    7/27/98 4:50p Lzou
 * Have removed most of function calls from the Stretching & Solid bitmap
 * copy. Use inline code instead.
 * 
 * 14    7/23/98 4:42p Lzou
 * Have removed function calls for the same source/destination colour
 * depth in the Solid & Unity bitmap copy.
 * 
 * 13    7/22/98 3:05p Lzou
 * Have done the Alpha & Stretching bitmap copy.
 * 
 * 12    7/22/98 1:09p Lzou
 * Nothing really important.
 * 
 * 11    7/22/98 1:02p Lzou
 * Have finished the Alpha & Unity bitmap copy.
 * 
 * 10    7/21/98 4:09p Lzou
 * Temporarily check in before implementing the Alpha & Unity, Alpha &
 * Stretching bitmap copies.
 * 
 * 9     7/16/98 6:20p Lzou
 * Using inline code to replace function calls in a bid to make the blt
 * faster.
 * 
 * 8     7/15/98 12:53p Lzou
 * Minute change.
 * 
 * 7     7/15/98 12:39p Lzou
 * Have added in some comments on and descriptions of both the Solid &
 * Unity and Solid & Stretching bitmap copies.
 * 
 * 6     7/15/98 12:17p Lzou
 * Have finished the Solid & Stretching bitmap copy.
 * 
 * 5     7/14/98 2:32p Lzou
 * Have done all of the Unity & Solid bitmap copy. Have partly done the
 * Stretching & Solid bitmap copy.
 * 
 * 4     7/10/98 1:32p Lzou
 * Have finished implementing the solid & unity bitmap copy from 8 bit
 * colour depth to 16 bit, 24 bit, and 32 bit colour depth.
 * 
 * 3     7/06/98 1:06p Lzou
 * A temporarily check in.
 * 
 * 2     7/03/98 5:27p Lzou
 * a bit is done.
 * 
 * 1     7/02/98 3:22p Lzou
 * Implement the BLT module
 * 
 * 1     6/12/98 3:40p Agmsmith
 * Preprocessor code generation of the various different blitter copy
 * functions.
 ****************************************************************************/


// First make up the function name, it is of the form
// LI_BLT_Copy(source depth)To(dest depth)(options).
//
// The invoker specifies #defines with these names to set the options:
// INC_SOURCE_DEPTH - pixel source depth: 8 (for TABs only), 16, 24, 32.
// INC_DEST_DEPTH - pixel destination bitmap depth: 16, 24, 32.
// INC_COPYMODE - one of INC_SOLID, INC_HOLES, INC_ALPHA.
// INC_COLOURKEY - either TRUE (1) for green is transparent or FALSE (0).
// INC_STRETCHMODE - INC_UNITY for no stretching or INC_STRETCH for stretching.
// INC_SOURCEFORMAT - INC_GENERAL for NEWBITMAPHEADER format source bitmap or
//                    INC_RAWBITMAP for pointer to bits and separate width and
//                    height for the source bitmap.
//
// The options in the function name are:
// Solid - Copy with no transparency tests at all.
// Holes - Copy with colour index zero being transparent, rest solid.
// Alpha - Copy with blended transparency, either from palette or as a number.
// ColourKey - Copy with greenish or some other colour being transparent.
// General - Uses the bitmap header to figure it out.
// Raw - You specify the bitmap width, height and palette separately.
// Unity - Source and destination pixels are copied at a 1 to 1 ratio, no stretch.
// Stretch - Source and destination can be different sizes.








#line 241 "..\\ArtLib\\L_BLTCPY.cpp"

#line 243 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 246 "..\\ArtLib\\L_BLTCPY.cpp"
    
  #line 248 "..\\ArtLib\\L_BLTCPY.cpp"


#line 251 "..\\ArtLib\\L_BLTCPY.cpp"

/*  this bit doesn't work
#if INC_COLOURKEY
  #define COPY_OPTION_WITH_KEY COPY_OPTION ## ColourKey
#else
  #define COPY_OPTION_WITH_KEY COPY_OPTION
#endif
*/



#line 263 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 267 "..\\ArtLib\\L_BLTCPY.cpp"



#line 271 "..\\ArtLib\\L_BLTCPY.cpp"
  


#line 275 "..\\ArtLib\\L_BLTCPY.cpp"

// LateDefine FUNCTION_NAME LI_BLT_Copy ## INC_SOURCE_DEPTH ## To ## INC_DEST_DEPTH ## COPY_OPTION_WITH_KEY ## STRETCH_OPTION ## SOURCE_FORMAT_OPTION
#define FUNCTION_NAME LI_BLT_Copy ## 8 ## To ## 16 ## Alpha ## Stretch ## Raw
#define NAME_TO_STRING(a,b,c,d,e) "LI_BLT_Copy" #a "To" #b #c #d #e
// LateDefine NAME_AS_STRING NAME_TO_STRING (INC_SOURCE_DEPTH, INC_DEST_DEPTH, COPY_OPTION_WITH_KEY, STRETCH_OPTION, SOURCE_FORMAT_OPTION)
#define NAME_AS_STRING NAME_TO_STRING (8, 16, Alpha, Stretch, Raw)

#pragma message ("Now compiling " NAME_AS_STRING)


/* Generate the function header.  It looks something like this:
BOOL LI_BLT_Copy8To16AlphaStretchRaw (
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  LE_BLT_AlphaPaletteEntryPointer SourceColourTable,
  UNS16 NumberOfAlphaColours,
  TYPE_RectPointer SourceRectangle, 
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,
  TYPE_RectPointer DestBoundingRectangle)
*/

BOOL FUNCTION_NAME (

// First the arguments describing the source bitmap.


#line 306 "..\\ArtLib\\L_BLTCPY.cpp"
  UNS8Pointer SourceBitmapBits,
  UNS16 SourceBitmapWidth,
  UNS16 SourceBitmapHeight,
  
    LPLONG SourceColorTable,
    
      UNS16 NumberOfAlphaColors,
    #line 314 "..\\ArtLib\\L_BLTCPY.cpp"
  

#line 317 "..\\ArtLib\\L_BLTCPY.cpp"
#line 318 "..\\ArtLib\\L_BLTCPY.cpp"
  TYPE_RectPointer SourceRectangle, 

// Then the destination bitmap description.
  UNS8Pointer DestinationBitmapBits,
  UNS16 DestinationBitmapWidth,
  UNS16 DestinationBitmapHeight,
  TYPE_RectPointer DestInvalidRectangle,

  TYPE_RectPointer DestBoundingRectangle)




#line 332 "..\\ArtLib\\L_BLTCPY.cpp"
{

/*************************************************************************
 *
 *            Solid and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Tuesday 14 July 1998
 *
 * ---------------------------------------------------------------------
 *
 *    Solid with Colour Key (holes for 8 bit) and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap. No stretching
 *     is attempted. Colour key effect is applied.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:24:55  Thursday 13 August 1998
 *  11:28:10  Friday   22 January 1999 (add in Unity bitmap copy with holes)
 *
 *************************************************************************/








































































































































































































































































































































































































































































































































































































































































































#line 1066 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Unity Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with alpha channel
 *     effect. No stretching is attempted.
 *
 *     The copy mode includes:
 *         from  8 bit to 16 bit colour depth
 *         from  8 bit to 24 bit colour depth
 *         from  8 bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  16:49:25  Tuesday 21 July 1998
 *
 *************************************************************************/


























































































































































































































































































































































































































































































































































































































































































































































































































#line 1884 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *      Solid and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, stretches
 *     it when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:28:00  Wednesday 15 July 1998
 *
 *  ---------------------------------------------------------------------
 *
 *      Solid with Colour Key/Holes and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap with colour key effect,
 *     stretches it when needed.
 *
 *     The colour key copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *     The hole copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  10:20:55  Wednesday 12 August 1998
 *
 *************************************************************************/
















































































































































































































































































































































































































































































































































































































































































































































































































































































#line 2784 "..\\ArtLib\\L_BLTCPY.cpp"

/*************************************************************************
 *
 *            Alpha and Stretching Bitmap Copy
 *
 *  DESCRIPTION:
 *     Copies a source bitmap to a destination bitmap, with alpha channel
 *     effect, stretches when needed.
 *
 *     The copy mode includes:
 *         from 8  bit to 16 bit colour depth
 *         from 8  bit to 24 bit colour depth
 *         from 8  bit to 32 bit colour depth
 *         from 16 bit to 16 bit colour depth
 *         from 24 bit to 24 bit colour depth
 *         from 32 bit to 32 bit colour depth
 *
 *  RETURN:
 *     TRUE for success, FALSE for failure.
 *
 *  14:05:00  Wednesday 22 July 1998
 *
 *************************************************************************/

  

    // do alpha & stretching bitmap copy from 8 bit to 16, 24, and 32 bit
    // colour depths, raw source bitmap

    
      {
        int   SourceOffsetX;         // offset in pixels
        int   SourceOffsetY;         // offset in pixels
        int   DestinationOffsetX;    // offset in pixels
        int   DestinationOffsetY;    // offset in pixels

        int   SourceWidth;           // width of source rectangle
        int   SourceHeight;          // height of souce rectangle
        int   DestinationWidth;      // width of destination rectangle
        int   DestinationHeight;     // height of destination rectangle

        int   SourceBitmapWidthInBytes;       // source bitmap width in bytes
        int   DestinationBitmapWidthInBytes;  // destination bitmap width in bytes

        UNS8Pointer  SourceScanlineBltPtr;       // pointer to each scan line to blt
        UNS8Pointer  DestinationScanlineBltPtr;  // pointer to each scan line to blt

        register UNS8Pointer  lpSourceBltPointer;       // pointer to current source pixel to copy from
        register UNS8Pointer  lpDestinationBltPointer;  // pointer to current destination pixel to copy to

        register UNS8Pointer   XOffsetPntr;
        register UNS8Pointer   YOffsetPntr;

        register unsigned char  Counter;
        register int   XPixelCounter;
        register int   YPixelCounter;
        register int   CurrentRemainingPixel;
        register int   CurrentDestinationWidth;

        register DWORD dwSourceData;        // holder for source data
        register DWORD dwDestinationData;   // holders for destination data

        register DWORD dwAlphaData;   // holder source and data blended
        register DWORD dwAlpha;       // 32 bit alpha channel
        

#line 2856 "..\\ArtLib\\L_BLTCPY.cpp"

        StretchTableRecord  XStretchTable;  // stretch table, horizontal
        StretchTableRecord  YStretchTable;  // strctch table, vertical

        // validate the source/destination bitmap pointers

        if( SourceBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": SourceBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2868 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid source bitmap pointer
        }

        if( DestinationBitmapBits == NULL )
        {
        
          sprintf (LE_ERROR_DebugMessageBuffer, NAME_AS_STRING ": DestinationBitmapBits == NULL\n\n");
          LE_ERROR_DebugMsg(LE_ERROR_DebugMessageBuffer, LE_ERROR_DebugMsgToFileAndScreen);
        #line 2877 "..\\ArtLib\\L_BLTCPY.cpp"
          return FALSE;  // invalid destination bitmap pointer
        }

        // prepare some parameters for image clipping and function calls

        SourceOffsetX = (int) SourceRectangle->left;
        SourceOffsetY = (int) SourceRectangle->top;
        SourceWidth   = (int) (SourceRectangle->right - SourceRectangle->left);
        SourceHeight  = (int) (SourceRectangle->bottom - SourceRectangle->top);

        DestinationOffsetX = (int) DestBoundingRectangle->left;

        {

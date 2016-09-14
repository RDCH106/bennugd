/*
 *  Copyright � 2006-2013 SplinterGU (Fenix/Bennugd)
 *  Copyright � 2002-2006 Fenix Team (Fenix)
 *  Copyright � 1999-2002 Jos� Luis Cebri�n Pag�e (Fenix)
 *
 *  This file is part of Bennu - Game Development
 *
 *  This software is provided 'as-is', without any express or implied
 *  warranty. In no event will the authors be held liable for any damages
 *  arising from the use of this software.
 *
 *  Permission is granted to anyone to use this software for any purpose,
 *  including commercial applications, and to alter it and redistribute it
 *  freely, subject to the following restrictions:
 *
 *     1. The origin of this software must not be misrepresented; you must not
 *     claim that you wrote the original software. If you use this software
 *     in a product, an acknowledgment in the product documentation would be
 *     appreciated but is not required.
 *
 *     2. Altered source versions must be plainly marked as such, and must not be
 *     misrepresented as being the original software.
 *
 *     3. This notice may not be removed or altered from any source
 *     distribution.
 *
 */

#ifndef __MOD_DRAW_EXPORTS
#define __MOD_DRAW_EXPORTS

/* --------------------------------------------------------------------------- */

#include "bgddl.h"

/* --------------------------------------------------------------------------- */
/* Declaracion de funciones                                                    */

DLSYSFUNCS __bgdexport( mod_draw, functions_exports )[] =
{
    /* Funciones de primitivas */
    FUNC( "DRAWING_MAP"     , "II"          , TYPE_INT  , moddraw_drawing_map       ),
    FUNC( "DRAWING_COLOR"   , "I"           , TYPE_INT  , moddraw_drawing_color     ),
    FUNC( "DRAW_LINE"       , "IIII"        , TYPE_INT  , moddraw_line              ),
    FUNC( "DRAW_RECT"       , "IIII"        , TYPE_INT  , moddraw_rect              ),
    FUNC( "DRAW_BOX"        , "IIII"        , TYPE_INT  , moddraw_box               ),
    FUNC( "DRAW_CIRCLE"     , "III"         , TYPE_INT  , moddraw_circle            ),
    FUNC( "DRAW_FCIRCLE"    , "III"         , TYPE_INT  , moddraw_fcircle           ),
    FUNC( "DRAW_CURVE"      , "IIIIIIIII"   , TYPE_INT  , moddraw_bezier            ),
    FUNC( "DRAWING_Z"       , "I"           , TYPE_INT  , moddraw_drawing_at        ),
    FUNC( "DELETE_DRAW"     , "I"           , TYPE_INT  , moddraw_delete_drawing    ),
    FUNC( "MOVE_DRAW"       , "III"         , TYPE_INT  , moddraw_move_drawing      ),
    FUNC( "DRAWING_ALPHA"   , "I"           , TYPE_INT  , moddraw_drawing_alpha     ),
    FUNC( "DRAWING_STIPPLE" , "I"           , TYPE_INT  , moddraw_drawing_stipple   ),
    FUNC( "PUT_PIXEL"       , "III"         , TYPE_INT  , moddraw_put_pixel         ),
    FUNC( "GET_PIXEL"       , "II"          , TYPE_INT  , moddraw_get_pixel         ),
    FUNC( "MAP_GET_PIXEL"   , "IIII"        , TYPE_INT  , moddraw_map_get_pixel     ),
    FUNC( "MAP_PUT_PIXEL"   , "IIIII"       , TYPE_INT  , moddraw_map_put_pixel     ),
    FUNC( NULL              , NULL          , 0         , NULL                      )
};

/* --------------------------------------------------------------------------- */

char * __bgdexport( mod_draw, modules_dependency )[] =
{
    "libgrbase",
    "librender",
    "libdraw",
    NULL
};

/* --------------------------------------------------------------------------- */

#endif

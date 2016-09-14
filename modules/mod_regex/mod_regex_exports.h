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

#ifndef __MOD_REGEX_EXPORTS
#define __MOD_REGEX_EXPORTS

/* ----------------------------------------------------------------- */

#include "bgddl.h"

/* --------------------------------------------------------------------------- */

#if defined(__BGDC__) || !defined(__STATIC__)

/* ----------------------------------------------------------------- */
/* Definicion de variables globales (usada en tiempo de compilacion) */

char * __bgdexport( mod_regex, globals_def ) =
    "STRING regex_reg[15];\n"
    ;

#endif

/* --------------------------------------------------------------------------- */

DLSYSFUNCS __bgdexport( mod_regex, functions_exports) [] =
{
    /* Regex */
    FUNC( "REGEX"                , "SS"    , TYPE_INT    , modregex_regex           ),
    FUNC( "REGEX_REPLACE"        , "SSS"   , TYPE_STRING , modregex_regex_replace   ),
    FUNC( "SPLIT"                , "SSPI"  , TYPE_INT    , modregex_split           ),
    FUNC( "JOIN"                 , "SPI"   , TYPE_STRING , modregex_join            ),
    FUNC( 0                      , 0       , 0           , 0                        )
};

/* --------------------------------------------------------------------------- */

#endif

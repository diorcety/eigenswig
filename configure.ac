AC_PREREQ(2.69)

AC_INIT([msfreej],[1.0.0],[diorcet.yann@gmail.com])
AM_INIT_AUTOMAKE
LT_INIT([win32-dll shared disable-static])

AC_LIBTOOL_WIN32_DLL

AC_CONFIG_HEADERS(config.h)

dnl never run autotools and configure automatically
dnl AM_MAINTAINER_MODE
${CFLAGS=""}
${CXXFLAGS=""}

AC_PROG_CC
AC_LANG([C++])
AC_PROG_CXX
AX_CXX_COMPILE_STDCXX_11

case $target_os in 
	*mingw*)
		mingw_found=yes
	;;
esac

AM_CONDITIONAL(BUILD_WIN32, test x$mingw_found = xyes)

dnl conditionnal build of wrappers 
AC_ARG_ENABLE(wrappers,
	[AS_HELP_STRING([--enable-wrappers], [Disable wrappers])],
	[case "${enableval}" in
		yes)	build_wrappers=true ;;
		no)	build_wrappers=false ;;
		*)	AC_MSG_ERROR(bad value ${enableval} for --enable-wrappers) ;;
	esac],
	[build_wrappers=auto]
)

dnl conditionnal build of python wrappers 
AC_ARG_ENABLE(wrapper-python,
	[AS_HELP_STRING([--disable-wrapper-python], [Disable python wrapper])],
	[case "${enableval}" in
		yes)	build_wrapper_python=true ;;
		no)	build_wrapper_python=false ;;
		*)	AC_MSG_ERROR(bad value ${enableval} for --disable-wrapper-python) ;;
	esac],
	[build_wrapper_python=auto]
)

dnl conditionnal build of java wrappers 
AC_ARG_ENABLE(wrapper-java,
	[AS_HELP_STRING([--disable-wrapper-java], [Disable java wrapper])],
	[case "${enableval}" in
		yes)	build_wrapper_java=true ;;
		no)	build_wrapper_java=false ;;
		*)	AC_MSG_ERROR(bad value ${enableval} for --disable-wrapper-java) ;;
	esac],
	[build_wrapper_java=auto]
)

dnl conditionnal build of csharp wrappers 
AC_ARG_ENABLE(wrapper-csharp,
	[AS_HELP_STRING([--disable-wrapper-csharp], [Disable csharp wrapper])],
	[case "${enableval}" in
		yes)	build_wrapper_csharp=true ;;
		no)	build_wrapper_csharp=false ;;
		*)	AC_MSG_ERROR(bad value ${enableval} for --disable-wrapper-csharp) ;;
	esac],
	[build_wrapper_csharp=auto]
)

dnl c++11
if test "$build_wrappers" != "false" ; then
	AC_LANG_PUSH([C++])
	AX_CHECK_COMPILE_FLAG([-std=c++0x], [],
		[if test "$build_wrappers" = "true" ; then
			AC_MSG_ERROR([C++11 is not handled by your compiler. wrappers cannot be compiled.])
		else
			build_wrappers=false
		fi]
	)
	AC_LANG_POP
fi

dnl swig
if test "$build_wrapper_python" != "false" || test "$build_wrapper_java" != "false" || test "$build_wrapper_csharp" != "false" ; then
	AX_PKG_SWIG(2.0, [], 
		[if test "$build_wrapper_python" = "true" || test "$build_wrapper_java" = "true" || test "$build_wrapper_csharp" = "true" ; then
			AC_MSG_ERROR([Could not found swig, python & java & csharp wrapper cannot be compiled.])
		else
			build_wrapper_python=false
		fi]
	)
fi

dnl python
if test "$build_wrapper_python" != "false" ; then
	AM_PATH_PYTHON(2.5, [], 
		[if test "$build_wrapper_python" = "true" ; then
			AC_MSG_ERROR([Could not found python, python wrapper cannot be compiled.])
		else
			build_wrapper_python=false
		fi]
	)
	AC_PYTHON_DEVEL(>= '2.5', [], 
		[if test "$build_wrapper_python" = "true" ; then
			AC_MSG_ERROR([Could not found python development files, python wrapper cannot be compiled.])
		else
			build_wrapper_python=false
		fi]
	)
fi

dnl java
if test "$build_wrapper_java" != "false" ; then
	AC_CHECK_JAVA_HOME
	AC_SUBST(JAVA_HOME)
	if test "x$JAVA_HOME" = "x" ; then
		if test "$build_wrapper_java" = "true" ; then
			AC_MSG_ERROR([Could not found java home, java wrapper cannot be compiled.])
		else
			build_wrapper_java=false
		fi
	else
		dnl Check for JNI headers
		JNI_CPPFLAGS=""
		for dir in `find $JAVA_HOME/include -follow -type d`
		do
			JNI_CPPFLAGS="$JNI_CPPFLAGS -I$dir"
		done
		AC_SUBST(JNI_CPPFLAGS)
	fi
	AC_PROG_JAVAC
	AC_PROG_JAVADOC	
	AC_PATH_PROG([ANT], [ant])
	ANT_FLAGS=
	AC_SUBST(ANT_FLAGS)
	if test "x$JAVAC" = "x" || test "x$ANT" = "x"; then
		build_wrapper_java_jar=false
	else
		build_wrapper_java_jar=true
	fi
	if test "x$JAVADOC" = "x"; then
		build_wrapper_java_doc=false
	else
		build_wrapper_java_doc=true
	fi
fi

dnl csharp 
if test "$build_wrapper_csharp" != "false" ; then
	AC_PATH_PROG([GMCS], [gmcs])
	if test "x$GMCS" = "x" ; then
		build_wrapper_csharp_lib=false
	else
		build_wrapper_csharp_lib=true
	fi
fi

AM_CONDITIONAL(BUILD_WRAPPERS, test x$build_wrappers != xfalse)
AM_CONDITIONAL(BUILD_WRAPPER_PYTHON, test x$build_wrappers != xfalse && test x$build_wrapper_python != xfalse)
AM_CONDITIONAL(BUILD_WRAPPER_JAVA, test x$build_wrappers != xfalse && test x$build_wrapper_java != xfalse)
AM_CONDITIONAL(BUILD_WRAPPER_JAVA_JAR, test x$build_wrappers != xfalse && test x$build_wrapper_java != xfalse && test x$build_wrapper_java_jar != xfalse)
AM_CONDITIONAL(BUILD_WRAPPER_JAVA_DOC, test x$build_wrappers != xfalse && test x$build_wrapper_java != xfalse && test x$build_wrapper_java_doc != xfalse)
AM_CONDITIONAL(BUILD_WRAPPER_JAVA_DOC, test x$build_wrappers != xfalse && test x$build_wrapper_java != xfalse && test x$build_wrapper_java_doc != xfalse)
AM_CONDITIONAL(BUILD_WRAPPER_CSHARP, test x$build_wrappers != xfalse && test x$build_wrapper_csharp != xfalse)
AM_CONDITIONAL(BUILD_WRAPPER_CSHARP_LIB, test x$build_wrappers != xfalse && test x$build_wrapper_csharp != xfalse && test x$build_wrapper_csharp_lib != xfalse)
if test "$build_wrappers" != "false" ; then
	build_wrappers=true
	if test "$build_wrapper_python" != "false" ; then
		build_wrapper_python=true
		wrappers="$wrappers python"
	fi
	if test "$build_wrapper_java" != "false" ; then
		build_wrapper_java=true
		wrappers="$wrappers java"
	fi
	if test "$build_wrapper_csharp" != "false" ; then
		build_wrapper_csharp=true
		wrappers="$wrappers csharp"
	fi
fi


AC_ARG_ENABLE(debug,
	[AS_HELP_STRING([--enable-debug=[yes/no]], [Enables the display of traces showing the execution of the library. (default=yes)])],
	[case "${enableval}" in
		yes)	debug_enabled=yes;;
		no)	debug_enabled=no;;
		*)	AC_MSG_ERROR("Bad value for --enable-debug");;
	esac],
	[debug_enabled=no]
)
AS_CASE([$debug_enabled],
		[yes],[
			CFLAGS="$CFLAGS -g -O0"
			CXXFLAGS="$CXXFLAGS -g -O0"
			OBJCFLAGS="$OBJCFLAGS -g -O0"
		],
		[no],
		[
			case "$CFLAGS" in
				*-O*)
				;;
				*)
					CFLAGS="$CFLAGS -O2"
					CXXFLAGS="$CXXFLAGS -O2"
					OBJCFLAGS="$OBJCFLAGS -O2"
				;;
			esac
		],
		[AC_MSG_ERROR([Bad value ($debug_enabled) for --enable-debug. Valid values are yes or no.])])
AM_CONDITIONAL([BUILD_DEBUG], [test x$debug_enabled = xyes])

AC_ARG_ENABLE(strict,
AC_HELP_STRING([--enable-strict],[Enable error on compilation warning [default=yes]]),
[wall_werror=$enableval],
[
	wall_werror=yes
]
)
CFLAGS="$CFLAGS -Wall"
CXXFLAGS="$CXXFLAGS -Wall"

if test "$GCC" = "yes" && test "$wall_werror" = "yes" ; then
	CFLAGS="$CFLAGS -Werror"
	CXXFLAGS="$CXXFLAGS -Werror"
fi

# check for libraries that have pkg-config files installed
PKG_CHECK_MODULES(EIGEN3, eigen3)

# create the following files from their .in counterparts
AC_CONFIG_FILES([
	Makefile
	wrapper/Makefile
	wrapper/swig/Makefile
	wrapper/python/Makefile
	wrapper/java/Makefile
	wrapper/csharp/Makefile
])
AC_OUTPUT

printf "* %-30s %s\n" "Wrappers"			"$wrappers"


## Process this file with automake to produce Makefile.in
.NOTPARALLEL:

if BUILD_WRAPPER_JAVA

AM_CPPFLAGS=\
	-I$(top_srcdir)/src

COMMON_CFLAGS=\
	$(EIGEN3_CFLAGS)

SWIG_CFLAGS=$(COMMON_CFLAGS)

JAVA_SOURCE=src
JAVA_PACKAGE=org.eigen3
JAVA_PACKAGE_SOURCE=$(JAVA_SOURCE)
JAVA_PACKAGE_DIR=$(JAVA_SOURCE)/org/mediastreamer2/freej

JAVADOC_DIR=doc

lib_LTLIBRARIES = libeigen3_java.la

libeigen3_java_la_SOURCES = eigen3_wrap.cpp
libeigen3_java_la_CXXFLAGS = $(COMMON_CFLAGS) $(STRICT_OPTIONS) $(JNI_CPPFLAGS) -std=c++0x -Wno-strict-aliasing
libeigen3_java_la_LDFLAGS = -avoid-version -Wl,-no-undefined
libeigen3_java_la_LIBADD = -llinphone_java $(LINPHONE_LIBS) $(MEDIASTREAMER_LIBS) $(FREEJ_LIBS)

eigen3_wrap.cpp: $(top_srcdir)/wrapper/swig/*.i
	mkdir -p $(JAVA_PACKAGE_DIR)
	$(SWIG) $(SWIG_CFLAGS) -c++ -java -package $(JAVA_PACKAGE) -outdir $(JAVA_PACKAGE_DIR) -o $@ $(top_srcdir)/wrapper/swig/eigen3.i

clean-local:
	rm -rf eigen3.xml eigen3_wrap.cpp eigen3_wrap.h $(JAVA_PACKAGE_SOURCE) $(JAVA_SOURCE) $(JAVADOC_DIR)

if BUILD_WRAPPER_JAVA_JAR
# Make sure this doesn't fail if ant is not configured.
#	$(ANT) $(ANT_FLAGS) clean
endif

$(JAVADOC_DIR):
# Generate the javadoc
if BUILD_WRAPPER_JAVA_DOC
#	$(JAVADOC) -d $(JAVADOC_DIR) -sourcepath $(JAVA_PACKAGE_SOURCE) $(JAVA_PACKAGE)
endif

all-local: $(JAVADOC_DIR)
if BUILD_WRAPPER_JAVA_JAR
#	$(ANT) $(ANT_FLAGS) jar
endif

check-local: all
if BUILD_WRAPPER_JAVA_JAR
#	$(ANT) $(ANT_FLAGS) test
endif


endif

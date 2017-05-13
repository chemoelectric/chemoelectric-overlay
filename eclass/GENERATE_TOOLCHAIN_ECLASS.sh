#!/bin/sh

awk < /usr/portage/eclass/toolchain.eclass "
/^IUSE_DEF=/ {
  print
  print \"\n# Add Ada support.\"
  print \"# I used to provide an option to use a special bootstrapping compiler,\"
  print \"# but now leave reliable bootstrapping of gnat as an exercise for the reader.\"
  print \"# A given version of gnat may be picky about the compiler used.\"
  print \"# One possibility is to use my sys-devel/gnat-bootstrap, plus, via\"
  print \"# package.env, some settings for CC, CXX, GNATMAKE, and GNATBIND, to tell\"
  print \"# emerge to use the bootstrap compiler. You might also try using\"
  print \"# dev-lang/gnat-gcc.\"
  print \"[[ \${PN} == \\\"gcc\\\" ]] && IUSE_DEF+=( ada )\"
  next
}

/We do NOT want 'ADA support'/ {
  print \"\t# Add Ada support.\"
  print \"\tis_ada && GCC_LANG+=\\\",ada\\\"\"
  next
}

/toolchain_src_install\(\)/ { installing = 1 }
/^}/ {
  # We are at the end of the toolchain_src_install function.
  if ( installing ) {
    installing = 0
    print \"\n\t# Add Ada support.\"
    print \"\t# Work around gcc-config's ignorance of gnat tools by providing\"
    print \"\t# copies of them under names gcc-config can handle.\"
    print \"\tif is_ada ; then\"
    print \"\t        for gnattool in gnat gnatbind gnatchop gnatclean gnatfind \\\\\"
    print \"\t                gnatkr gnatlink gnatls gnatmake gnatname gnatprep gnatxref ; do\"
    print \"\t                local toollink\"
    print \"\t                if is_crosscompile\"
    print \"\t                then\"
    print \"\t                        toollink=\\\"\${D}\${PREFIX}/\${CHOST}/\${CTARGET}/gcc-bin/\${GCC_CONFIG_VER}/\${CTARGET}-\${gnattool}\\\"\"
    print \"\t                else\"
    print \"\t                        toollink=\\\"\${D}\${PREFIX}/\${CTARGET}/gcc-bin/\${GCC_CONFIG_VER}/\${CTARGET}-\${gnattool}\\\"\"
    print \"\t                fi\"
    print \"\t                [[ -e \\\"\${toollink}\\\" ]] || ln -s \\\"\${gnattool}\\\" \\\"\${toollink}\\\"\"
    print \"\t        done\"
    print \"\tfi\"
  }
}

/ldpaths=\"\\$\\{ldpath\\}\\$\\{ldpaths:\\+:\\$\\{ldpaths\\}\\}\"/ {
  # We need to add adalib to the LDPATH.
  print \"\t\t\t# Add Ada support.\"
  print \"\t\t\tis_ada && ldpath=\\\"\${ldpath}:\${ldpath}/adalib\\\"\"
}

/^HOMEPAGE=/ {
  print
  print \"\n# Add Ada support. Clear any funky flags before building the compiler.\"
  print \"# (I believe the GCC Makefiles use CFLAGS or CXXFLAGS when compiling Ada,\"
  print \"# anyway, and that they use ADAFLAGS for notations like -gnatXXXX.)\"
  print \"unset ADAFLAGS\"
  print \"\"
  next
}

/# is_ada/ { next }

{ print }
" \
    | sed -e 's|\([ 	]emake[ 	]\)|\1P= |g'

# The sed above clears the ‘$(P)’ that appears in the Ada sections of
# some GCC Makefile hierarchies, without being set anywhere in the
# Makefiles. Portage, of course, sets the environment variable P to
# ${PN}-${PV}.

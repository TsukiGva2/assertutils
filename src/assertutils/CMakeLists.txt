add_library(assertutils SHARED
	error.c
	assertutils.c

	"${assertutils_SOURCE_DIR}/include/assertutils/error.h"
	"${assertutils_SOURCE_DIR}/include/assertutils/assertutils.h"
)

target_include_directories(assertutils PUBLIC "${assertutils_SOURCE_DIR}/include/assertutils")

set_target_properties(assertutils 
	PROPERTIES
	PUBLIC_HEADER "${assertutils_SOURCE_DIR}/include/assertutils/error.h;${assertutils_SOURCE_DIR}/include/assertutils/assertutils.h"
)

install(TARGETS assertutils
        LIBRARY DESTINATION lib/assertutils
        PUBLIC_HEADER DESTINATION include/assertutils
)


#include "../include/assertutils.h"

STATUS thisFuncFails(void) {
	ASSERT(1, "Damn");
	return OK;
}

STATUS wrapperFunction(void) {
	DEFER(thisFuncFails(), fail);
	return OK;

fail:
	return FAIL;
}

int main(void) {
	INFO( "calling troublesome function..." );

	DEFER(wrapperFunction(), quit);

	return 0;

quit  : return 1;
}

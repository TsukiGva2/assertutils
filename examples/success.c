#include "../include/assertutils.h"

STATUS thisFuncRocks(void) {
	ASSERT(0, "What?");
	return OK;
}

STATUS wrapperFunction(void) {
	DEFER(thisFuncRocks(), fail);
	return OK;

fail:
	return FAIL;
}

int main(void) {
	INFO( "calling correct function..." );

	DEFER(wrapperFunction(), quit);

	NICE( "it's all good, man!" );
	return 0;

quit  : return 1;
}

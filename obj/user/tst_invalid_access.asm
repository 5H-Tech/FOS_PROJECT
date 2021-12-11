
obj/user/tst_invalid_access:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 57 00 00 00       	call   80008d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp

	uint32 kilo = 1024;
  80003e:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)

//	cprintf("envID = %d\n",envID);

	/// testing illegal memory access
	{
		uint32 size = 4*kilo;
  800045:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800048:	c1 e0 02             	shl    $0x2,%eax
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)

		unsigned char *x = (unsigned char *)0x80000000;
  80004e:	c7 45 e8 00 00 00 80 	movl   $0x80000000,-0x18(%ebp)

		int i=0;
  800055:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(;i< size+20;i++)
  80005c:	eb 0e                	jmp    80006c <_main+0x34>
		{
			x[i]=-1;
  80005e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800061:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800064:	01 d0                	add    %edx,%eax
  800066:	c6 00 ff             	movb   $0xff,(%eax)
		uint32 size = 4*kilo;

		unsigned char *x = (unsigned char *)0x80000000;

		int i=0;
		for(;i< size+20;i++)
  800069:	ff 45 f4             	incl   -0xc(%ebp)
  80006c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80006f:	8d 50 14             	lea    0x14(%eax),%edx
  800072:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800075:	39 c2                	cmp    %eax,%edx
  800077:	77 e5                	ja     80005e <_main+0x26>
		{
			x[i]=-1;
		}

		panic("ERROR: FOS SHOULD NOT panic here, it should panic earlier in page_fault_handler(), since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK. REMEMBER: creating new page in page file shouldn't be allowed except ONLY for new stack pages\n");
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	68 c0 1a 80 00       	push   $0x801ac0
  800081:	6a 1a                	push   $0x1a
  800083:	68 c9 1b 80 00       	push   $0x801bc9
  800088:	e8 45 01 00 00       	call   8001d2 <_panic>

0080008d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80008d:	55                   	push   %ebp
  80008e:	89 e5                	mov    %esp,%ebp
  800090:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800093:	e8 07 12 00 00       	call   80129f <sys_getenvindex>
  800098:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80009b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80009e:	89 d0                	mov    %edx,%eax
  8000a0:	c1 e0 03             	shl    $0x3,%eax
  8000a3:	01 d0                	add    %edx,%eax
  8000a5:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000ac:	01 c8                	add    %ecx,%eax
  8000ae:	01 c0                	add    %eax,%eax
  8000b0:	01 d0                	add    %edx,%eax
  8000b2:	01 c0                	add    %eax,%eax
  8000b4:	01 d0                	add    %edx,%eax
  8000b6:	89 c2                	mov    %eax,%edx
  8000b8:	c1 e2 05             	shl    $0x5,%edx
  8000bb:	29 c2                	sub    %eax,%edx
  8000bd:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8000c4:	89 c2                	mov    %eax,%edx
  8000c6:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8000cc:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d6:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8000dc:	84 c0                	test   %al,%al
  8000de:	74 0f                	je     8000ef <libmain+0x62>
		binaryname = myEnv->prog_name;
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	05 40 3c 01 00       	add    $0x13c40,%eax
  8000ea:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000ef:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000f3:	7e 0a                	jle    8000ff <libmain+0x72>
		binaryname = argv[0];
  8000f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000f8:	8b 00                	mov    (%eax),%eax
  8000fa:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8000ff:	83 ec 08             	sub    $0x8,%esp
  800102:	ff 75 0c             	pushl  0xc(%ebp)
  800105:	ff 75 08             	pushl  0x8(%ebp)
  800108:	e8 2b ff ff ff       	call   800038 <_main>
  80010d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800110:	e8 25 13 00 00       	call   80143a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	68 fc 1b 80 00       	push   $0x801bfc
  80011d:	e8 52 03 00 00       	call   800474 <cprintf>
  800122:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800125:	a1 20 30 80 00       	mov    0x803020,%eax
  80012a:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800130:	a1 20 30 80 00       	mov    0x803020,%eax
  800135:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	52                   	push   %edx
  80013f:	50                   	push   %eax
  800140:	68 24 1c 80 00       	push   $0x801c24
  800145:	e8 2a 03 00 00       	call   800474 <cprintf>
  80014a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80014d:	a1 20 30 80 00       	mov    0x803020,%eax
  800152:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800158:	a1 20 30 80 00       	mov    0x803020,%eax
  80015d:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800163:	83 ec 04             	sub    $0x4,%esp
  800166:	52                   	push   %edx
  800167:	50                   	push   %eax
  800168:	68 4c 1c 80 00       	push   $0x801c4c
  80016d:	e8 02 03 00 00       	call   800474 <cprintf>
  800172:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800175:	a1 20 30 80 00       	mov    0x803020,%eax
  80017a:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800180:	83 ec 08             	sub    $0x8,%esp
  800183:	50                   	push   %eax
  800184:	68 8d 1c 80 00       	push   $0x801c8d
  800189:	e8 e6 02 00 00       	call   800474 <cprintf>
  80018e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800191:	83 ec 0c             	sub    $0xc,%esp
  800194:	68 fc 1b 80 00       	push   $0x801bfc
  800199:	e8 d6 02 00 00       	call   800474 <cprintf>
  80019e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001a1:	e8 ae 12 00 00       	call   801454 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001a6:	e8 19 00 00 00       	call   8001c4 <exit>
}
  8001ab:	90                   	nop
  8001ac:	c9                   	leave  
  8001ad:	c3                   	ret    

008001ae <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001ae:	55                   	push   %ebp
  8001af:	89 e5                	mov    %esp,%ebp
  8001b1:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001b4:	83 ec 0c             	sub    $0xc,%esp
  8001b7:	6a 00                	push   $0x0
  8001b9:	e8 ad 10 00 00       	call   80126b <sys_env_destroy>
  8001be:	83 c4 10             	add    $0x10,%esp
}
  8001c1:	90                   	nop
  8001c2:	c9                   	leave  
  8001c3:	c3                   	ret    

008001c4 <exit>:

void
exit(void)
{
  8001c4:	55                   	push   %ebp
  8001c5:	89 e5                	mov    %esp,%ebp
  8001c7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001ca:	e8 02 11 00 00       	call   8012d1 <sys_env_exit>
}
  8001cf:	90                   	nop
  8001d0:	c9                   	leave  
  8001d1:	c3                   	ret    

008001d2 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8001d2:	55                   	push   %ebp
  8001d3:	89 e5                	mov    %esp,%ebp
  8001d5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8001d8:	8d 45 10             	lea    0x10(%ebp),%eax
  8001db:	83 c0 04             	add    $0x4,%eax
  8001de:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8001e1:	a1 18 31 80 00       	mov    0x803118,%eax
  8001e6:	85 c0                	test   %eax,%eax
  8001e8:	74 16                	je     800200 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8001ea:	a1 18 31 80 00       	mov    0x803118,%eax
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	50                   	push   %eax
  8001f3:	68 a4 1c 80 00       	push   $0x801ca4
  8001f8:	e8 77 02 00 00       	call   800474 <cprintf>
  8001fd:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800200:	a1 00 30 80 00       	mov    0x803000,%eax
  800205:	ff 75 0c             	pushl  0xc(%ebp)
  800208:	ff 75 08             	pushl  0x8(%ebp)
  80020b:	50                   	push   %eax
  80020c:	68 a9 1c 80 00       	push   $0x801ca9
  800211:	e8 5e 02 00 00       	call   800474 <cprintf>
  800216:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800219:	8b 45 10             	mov    0x10(%ebp),%eax
  80021c:	83 ec 08             	sub    $0x8,%esp
  80021f:	ff 75 f4             	pushl  -0xc(%ebp)
  800222:	50                   	push   %eax
  800223:	e8 e1 01 00 00       	call   800409 <vcprintf>
  800228:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80022b:	83 ec 08             	sub    $0x8,%esp
  80022e:	6a 00                	push   $0x0
  800230:	68 c5 1c 80 00       	push   $0x801cc5
  800235:	e8 cf 01 00 00       	call   800409 <vcprintf>
  80023a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80023d:	e8 82 ff ff ff       	call   8001c4 <exit>

	// should not return here
	while (1) ;
  800242:	eb fe                	jmp    800242 <_panic+0x70>

00800244 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800244:	55                   	push   %ebp
  800245:	89 e5                	mov    %esp,%ebp
  800247:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80024a:	a1 20 30 80 00       	mov    0x803020,%eax
  80024f:	8b 50 74             	mov    0x74(%eax),%edx
  800252:	8b 45 0c             	mov    0xc(%ebp),%eax
  800255:	39 c2                	cmp    %eax,%edx
  800257:	74 14                	je     80026d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800259:	83 ec 04             	sub    $0x4,%esp
  80025c:	68 c8 1c 80 00       	push   $0x801cc8
  800261:	6a 26                	push   $0x26
  800263:	68 14 1d 80 00       	push   $0x801d14
  800268:	e8 65 ff ff ff       	call   8001d2 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80026d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800274:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80027b:	e9 b6 00 00 00       	jmp    800336 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800280:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800283:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028a:	8b 45 08             	mov    0x8(%ebp),%eax
  80028d:	01 d0                	add    %edx,%eax
  80028f:	8b 00                	mov    (%eax),%eax
  800291:	85 c0                	test   %eax,%eax
  800293:	75 08                	jne    80029d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800295:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800298:	e9 96 00 00 00       	jmp    800333 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80029d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002a4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002ab:	eb 5d                	jmp    80030a <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8002ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002b8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002bb:	c1 e2 04             	shl    $0x4,%edx
  8002be:	01 d0                	add    %edx,%eax
  8002c0:	8a 40 04             	mov    0x4(%eax),%al
  8002c3:	84 c0                	test   %al,%al
  8002c5:	75 40                	jne    800307 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002cc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002d2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002d5:	c1 e2 04             	shl    $0x4,%edx
  8002d8:	01 d0                	add    %edx,%eax
  8002da:	8b 00                	mov    (%eax),%eax
  8002dc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8002df:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002e7:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8002e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002ec:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f6:	01 c8                	add    %ecx,%eax
  8002f8:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002fa:	39 c2                	cmp    %eax,%edx
  8002fc:	75 09                	jne    800307 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8002fe:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800305:	eb 12                	jmp    800319 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800307:	ff 45 e8             	incl   -0x18(%ebp)
  80030a:	a1 20 30 80 00       	mov    0x803020,%eax
  80030f:	8b 50 74             	mov    0x74(%eax),%edx
  800312:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800315:	39 c2                	cmp    %eax,%edx
  800317:	77 94                	ja     8002ad <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800319:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80031d:	75 14                	jne    800333 <CheckWSWithoutLastIndex+0xef>
			panic(
  80031f:	83 ec 04             	sub    $0x4,%esp
  800322:	68 20 1d 80 00       	push   $0x801d20
  800327:	6a 3a                	push   $0x3a
  800329:	68 14 1d 80 00       	push   $0x801d14
  80032e:	e8 9f fe ff ff       	call   8001d2 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800333:	ff 45 f0             	incl   -0x10(%ebp)
  800336:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800339:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80033c:	0f 8c 3e ff ff ff    	jl     800280 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800342:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800349:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800350:	eb 20                	jmp    800372 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800352:	a1 20 30 80 00       	mov    0x803020,%eax
  800357:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80035d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800360:	c1 e2 04             	shl    $0x4,%edx
  800363:	01 d0                	add    %edx,%eax
  800365:	8a 40 04             	mov    0x4(%eax),%al
  800368:	3c 01                	cmp    $0x1,%al
  80036a:	75 03                	jne    80036f <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80036c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80036f:	ff 45 e0             	incl   -0x20(%ebp)
  800372:	a1 20 30 80 00       	mov    0x803020,%eax
  800377:	8b 50 74             	mov    0x74(%eax),%edx
  80037a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80037d:	39 c2                	cmp    %eax,%edx
  80037f:	77 d1                	ja     800352 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800381:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800384:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800387:	74 14                	je     80039d <CheckWSWithoutLastIndex+0x159>
		panic(
  800389:	83 ec 04             	sub    $0x4,%esp
  80038c:	68 74 1d 80 00       	push   $0x801d74
  800391:	6a 44                	push   $0x44
  800393:	68 14 1d 80 00       	push   $0x801d14
  800398:	e8 35 fe ff ff       	call   8001d2 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80039d:	90                   	nop
  80039e:	c9                   	leave  
  80039f:	c3                   	ret    

008003a0 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8003a0:	55                   	push   %ebp
  8003a1:	89 e5                	mov    %esp,%ebp
  8003a3:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8003a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a9:	8b 00                	mov    (%eax),%eax
  8003ab:	8d 48 01             	lea    0x1(%eax),%ecx
  8003ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003b1:	89 0a                	mov    %ecx,(%edx)
  8003b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8003b6:	88 d1                	mov    %dl,%cl
  8003b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003bb:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8003bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c2:	8b 00                	mov    (%eax),%eax
  8003c4:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003c9:	75 2c                	jne    8003f7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8003cb:	a0 24 30 80 00       	mov    0x803024,%al
  8003d0:	0f b6 c0             	movzbl %al,%eax
  8003d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003d6:	8b 12                	mov    (%edx),%edx
  8003d8:	89 d1                	mov    %edx,%ecx
  8003da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003dd:	83 c2 08             	add    $0x8,%edx
  8003e0:	83 ec 04             	sub    $0x4,%esp
  8003e3:	50                   	push   %eax
  8003e4:	51                   	push   %ecx
  8003e5:	52                   	push   %edx
  8003e6:	e8 3e 0e 00 00       	call   801229 <sys_cputs>
  8003eb:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003fa:	8b 40 04             	mov    0x4(%eax),%eax
  8003fd:	8d 50 01             	lea    0x1(%eax),%edx
  800400:	8b 45 0c             	mov    0xc(%ebp),%eax
  800403:	89 50 04             	mov    %edx,0x4(%eax)
}
  800406:	90                   	nop
  800407:	c9                   	leave  
  800408:	c3                   	ret    

00800409 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800409:	55                   	push   %ebp
  80040a:	89 e5                	mov    %esp,%ebp
  80040c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800412:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800419:	00 00 00 
	b.cnt = 0;
  80041c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800423:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800426:	ff 75 0c             	pushl  0xc(%ebp)
  800429:	ff 75 08             	pushl  0x8(%ebp)
  80042c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800432:	50                   	push   %eax
  800433:	68 a0 03 80 00       	push   $0x8003a0
  800438:	e8 11 02 00 00       	call   80064e <vprintfmt>
  80043d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800440:	a0 24 30 80 00       	mov    0x803024,%al
  800445:	0f b6 c0             	movzbl %al,%eax
  800448:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80044e:	83 ec 04             	sub    $0x4,%esp
  800451:	50                   	push   %eax
  800452:	52                   	push   %edx
  800453:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800459:	83 c0 08             	add    $0x8,%eax
  80045c:	50                   	push   %eax
  80045d:	e8 c7 0d 00 00       	call   801229 <sys_cputs>
  800462:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800465:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80046c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800472:	c9                   	leave  
  800473:	c3                   	ret    

00800474 <cprintf>:

int cprintf(const char *fmt, ...) {
  800474:	55                   	push   %ebp
  800475:	89 e5                	mov    %esp,%ebp
  800477:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80047a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800481:	8d 45 0c             	lea    0xc(%ebp),%eax
  800484:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800487:	8b 45 08             	mov    0x8(%ebp),%eax
  80048a:	83 ec 08             	sub    $0x8,%esp
  80048d:	ff 75 f4             	pushl  -0xc(%ebp)
  800490:	50                   	push   %eax
  800491:	e8 73 ff ff ff       	call   800409 <vcprintf>
  800496:	83 c4 10             	add    $0x10,%esp
  800499:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80049c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80049f:	c9                   	leave  
  8004a0:	c3                   	ret    

008004a1 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8004a1:	55                   	push   %ebp
  8004a2:	89 e5                	mov    %esp,%ebp
  8004a4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8004a7:	e8 8e 0f 00 00       	call   80143a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8004ac:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004af:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b5:	83 ec 08             	sub    $0x8,%esp
  8004b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8004bb:	50                   	push   %eax
  8004bc:	e8 48 ff ff ff       	call   800409 <vcprintf>
  8004c1:	83 c4 10             	add    $0x10,%esp
  8004c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8004c7:	e8 88 0f 00 00       	call   801454 <sys_enable_interrupt>
	return cnt;
  8004cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004cf:	c9                   	leave  
  8004d0:	c3                   	ret    

008004d1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004d1:	55                   	push   %ebp
  8004d2:	89 e5                	mov    %esp,%ebp
  8004d4:	53                   	push   %ebx
  8004d5:	83 ec 14             	sub    $0x14,%esp
  8004d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8004db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004de:	8b 45 14             	mov    0x14(%ebp),%eax
  8004e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004e4:	8b 45 18             	mov    0x18(%ebp),%eax
  8004e7:	ba 00 00 00 00       	mov    $0x0,%edx
  8004ec:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004ef:	77 55                	ja     800546 <printnum+0x75>
  8004f1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004f4:	72 05                	jb     8004fb <printnum+0x2a>
  8004f6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004f9:	77 4b                	ja     800546 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004fb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004fe:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800501:	8b 45 18             	mov    0x18(%ebp),%eax
  800504:	ba 00 00 00 00       	mov    $0x0,%edx
  800509:	52                   	push   %edx
  80050a:	50                   	push   %eax
  80050b:	ff 75 f4             	pushl  -0xc(%ebp)
  80050e:	ff 75 f0             	pushl  -0x10(%ebp)
  800511:	e8 46 13 00 00       	call   80185c <__udivdi3>
  800516:	83 c4 10             	add    $0x10,%esp
  800519:	83 ec 04             	sub    $0x4,%esp
  80051c:	ff 75 20             	pushl  0x20(%ebp)
  80051f:	53                   	push   %ebx
  800520:	ff 75 18             	pushl  0x18(%ebp)
  800523:	52                   	push   %edx
  800524:	50                   	push   %eax
  800525:	ff 75 0c             	pushl  0xc(%ebp)
  800528:	ff 75 08             	pushl  0x8(%ebp)
  80052b:	e8 a1 ff ff ff       	call   8004d1 <printnum>
  800530:	83 c4 20             	add    $0x20,%esp
  800533:	eb 1a                	jmp    80054f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800535:	83 ec 08             	sub    $0x8,%esp
  800538:	ff 75 0c             	pushl  0xc(%ebp)
  80053b:	ff 75 20             	pushl  0x20(%ebp)
  80053e:	8b 45 08             	mov    0x8(%ebp),%eax
  800541:	ff d0                	call   *%eax
  800543:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800546:	ff 4d 1c             	decl   0x1c(%ebp)
  800549:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80054d:	7f e6                	jg     800535 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80054f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800552:	bb 00 00 00 00       	mov    $0x0,%ebx
  800557:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80055a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80055d:	53                   	push   %ebx
  80055e:	51                   	push   %ecx
  80055f:	52                   	push   %edx
  800560:	50                   	push   %eax
  800561:	e8 06 14 00 00       	call   80196c <__umoddi3>
  800566:	83 c4 10             	add    $0x10,%esp
  800569:	05 d4 1f 80 00       	add    $0x801fd4,%eax
  80056e:	8a 00                	mov    (%eax),%al
  800570:	0f be c0             	movsbl %al,%eax
  800573:	83 ec 08             	sub    $0x8,%esp
  800576:	ff 75 0c             	pushl  0xc(%ebp)
  800579:	50                   	push   %eax
  80057a:	8b 45 08             	mov    0x8(%ebp),%eax
  80057d:	ff d0                	call   *%eax
  80057f:	83 c4 10             	add    $0x10,%esp
}
  800582:	90                   	nop
  800583:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800586:	c9                   	leave  
  800587:	c3                   	ret    

00800588 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800588:	55                   	push   %ebp
  800589:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80058b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80058f:	7e 1c                	jle    8005ad <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800591:	8b 45 08             	mov    0x8(%ebp),%eax
  800594:	8b 00                	mov    (%eax),%eax
  800596:	8d 50 08             	lea    0x8(%eax),%edx
  800599:	8b 45 08             	mov    0x8(%ebp),%eax
  80059c:	89 10                	mov    %edx,(%eax)
  80059e:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a1:	8b 00                	mov    (%eax),%eax
  8005a3:	83 e8 08             	sub    $0x8,%eax
  8005a6:	8b 50 04             	mov    0x4(%eax),%edx
  8005a9:	8b 00                	mov    (%eax),%eax
  8005ab:	eb 40                	jmp    8005ed <getuint+0x65>
	else if (lflag)
  8005ad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005b1:	74 1e                	je     8005d1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b6:	8b 00                	mov    (%eax),%eax
  8005b8:	8d 50 04             	lea    0x4(%eax),%edx
  8005bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005be:	89 10                	mov    %edx,(%eax)
  8005c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c3:	8b 00                	mov    (%eax),%eax
  8005c5:	83 e8 04             	sub    $0x4,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	ba 00 00 00 00       	mov    $0x0,%edx
  8005cf:	eb 1c                	jmp    8005ed <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	8b 00                	mov    (%eax),%eax
  8005d6:	8d 50 04             	lea    0x4(%eax),%edx
  8005d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dc:	89 10                	mov    %edx,(%eax)
  8005de:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e1:	8b 00                	mov    (%eax),%eax
  8005e3:	83 e8 04             	sub    $0x4,%eax
  8005e6:	8b 00                	mov    (%eax),%eax
  8005e8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005ed:	5d                   	pop    %ebp
  8005ee:	c3                   	ret    

008005ef <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005ef:	55                   	push   %ebp
  8005f0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005f2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005f6:	7e 1c                	jle    800614 <getint+0x25>
		return va_arg(*ap, long long);
  8005f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fb:	8b 00                	mov    (%eax),%eax
  8005fd:	8d 50 08             	lea    0x8(%eax),%edx
  800600:	8b 45 08             	mov    0x8(%ebp),%eax
  800603:	89 10                	mov    %edx,(%eax)
  800605:	8b 45 08             	mov    0x8(%ebp),%eax
  800608:	8b 00                	mov    (%eax),%eax
  80060a:	83 e8 08             	sub    $0x8,%eax
  80060d:	8b 50 04             	mov    0x4(%eax),%edx
  800610:	8b 00                	mov    (%eax),%eax
  800612:	eb 38                	jmp    80064c <getint+0x5d>
	else if (lflag)
  800614:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800618:	74 1a                	je     800634 <getint+0x45>
		return va_arg(*ap, long);
  80061a:	8b 45 08             	mov    0x8(%ebp),%eax
  80061d:	8b 00                	mov    (%eax),%eax
  80061f:	8d 50 04             	lea    0x4(%eax),%edx
  800622:	8b 45 08             	mov    0x8(%ebp),%eax
  800625:	89 10                	mov    %edx,(%eax)
  800627:	8b 45 08             	mov    0x8(%ebp),%eax
  80062a:	8b 00                	mov    (%eax),%eax
  80062c:	83 e8 04             	sub    $0x4,%eax
  80062f:	8b 00                	mov    (%eax),%eax
  800631:	99                   	cltd   
  800632:	eb 18                	jmp    80064c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800634:	8b 45 08             	mov    0x8(%ebp),%eax
  800637:	8b 00                	mov    (%eax),%eax
  800639:	8d 50 04             	lea    0x4(%eax),%edx
  80063c:	8b 45 08             	mov    0x8(%ebp),%eax
  80063f:	89 10                	mov    %edx,(%eax)
  800641:	8b 45 08             	mov    0x8(%ebp),%eax
  800644:	8b 00                	mov    (%eax),%eax
  800646:	83 e8 04             	sub    $0x4,%eax
  800649:	8b 00                	mov    (%eax),%eax
  80064b:	99                   	cltd   
}
  80064c:	5d                   	pop    %ebp
  80064d:	c3                   	ret    

0080064e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80064e:	55                   	push   %ebp
  80064f:	89 e5                	mov    %esp,%ebp
  800651:	56                   	push   %esi
  800652:	53                   	push   %ebx
  800653:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800656:	eb 17                	jmp    80066f <vprintfmt+0x21>
			if (ch == '\0')
  800658:	85 db                	test   %ebx,%ebx
  80065a:	0f 84 af 03 00 00    	je     800a0f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800660:	83 ec 08             	sub    $0x8,%esp
  800663:	ff 75 0c             	pushl  0xc(%ebp)
  800666:	53                   	push   %ebx
  800667:	8b 45 08             	mov    0x8(%ebp),%eax
  80066a:	ff d0                	call   *%eax
  80066c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80066f:	8b 45 10             	mov    0x10(%ebp),%eax
  800672:	8d 50 01             	lea    0x1(%eax),%edx
  800675:	89 55 10             	mov    %edx,0x10(%ebp)
  800678:	8a 00                	mov    (%eax),%al
  80067a:	0f b6 d8             	movzbl %al,%ebx
  80067d:	83 fb 25             	cmp    $0x25,%ebx
  800680:	75 d6                	jne    800658 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800682:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800686:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80068d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800694:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80069b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8006a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8006a5:	8d 50 01             	lea    0x1(%eax),%edx
  8006a8:	89 55 10             	mov    %edx,0x10(%ebp)
  8006ab:	8a 00                	mov    (%eax),%al
  8006ad:	0f b6 d8             	movzbl %al,%ebx
  8006b0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006b3:	83 f8 55             	cmp    $0x55,%eax
  8006b6:	0f 87 2b 03 00 00    	ja     8009e7 <vprintfmt+0x399>
  8006bc:	8b 04 85 f8 1f 80 00 	mov    0x801ff8(,%eax,4),%eax
  8006c3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006c5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006c9:	eb d7                	jmp    8006a2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006cb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006cf:	eb d1                	jmp    8006a2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006d1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006d8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006db:	89 d0                	mov    %edx,%eax
  8006dd:	c1 e0 02             	shl    $0x2,%eax
  8006e0:	01 d0                	add    %edx,%eax
  8006e2:	01 c0                	add    %eax,%eax
  8006e4:	01 d8                	add    %ebx,%eax
  8006e6:	83 e8 30             	sub    $0x30,%eax
  8006e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8006ef:	8a 00                	mov    (%eax),%al
  8006f1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006f4:	83 fb 2f             	cmp    $0x2f,%ebx
  8006f7:	7e 3e                	jle    800737 <vprintfmt+0xe9>
  8006f9:	83 fb 39             	cmp    $0x39,%ebx
  8006fc:	7f 39                	jg     800737 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006fe:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800701:	eb d5                	jmp    8006d8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800703:	8b 45 14             	mov    0x14(%ebp),%eax
  800706:	83 c0 04             	add    $0x4,%eax
  800709:	89 45 14             	mov    %eax,0x14(%ebp)
  80070c:	8b 45 14             	mov    0x14(%ebp),%eax
  80070f:	83 e8 04             	sub    $0x4,%eax
  800712:	8b 00                	mov    (%eax),%eax
  800714:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800717:	eb 1f                	jmp    800738 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800719:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80071d:	79 83                	jns    8006a2 <vprintfmt+0x54>
				width = 0;
  80071f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800726:	e9 77 ff ff ff       	jmp    8006a2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80072b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800732:	e9 6b ff ff ff       	jmp    8006a2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800737:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800738:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80073c:	0f 89 60 ff ff ff    	jns    8006a2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800742:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800745:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800748:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80074f:	e9 4e ff ff ff       	jmp    8006a2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800754:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800757:	e9 46 ff ff ff       	jmp    8006a2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80075c:	8b 45 14             	mov    0x14(%ebp),%eax
  80075f:	83 c0 04             	add    $0x4,%eax
  800762:	89 45 14             	mov    %eax,0x14(%ebp)
  800765:	8b 45 14             	mov    0x14(%ebp),%eax
  800768:	83 e8 04             	sub    $0x4,%eax
  80076b:	8b 00                	mov    (%eax),%eax
  80076d:	83 ec 08             	sub    $0x8,%esp
  800770:	ff 75 0c             	pushl  0xc(%ebp)
  800773:	50                   	push   %eax
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	ff d0                	call   *%eax
  800779:	83 c4 10             	add    $0x10,%esp
			break;
  80077c:	e9 89 02 00 00       	jmp    800a0a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800781:	8b 45 14             	mov    0x14(%ebp),%eax
  800784:	83 c0 04             	add    $0x4,%eax
  800787:	89 45 14             	mov    %eax,0x14(%ebp)
  80078a:	8b 45 14             	mov    0x14(%ebp),%eax
  80078d:	83 e8 04             	sub    $0x4,%eax
  800790:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800792:	85 db                	test   %ebx,%ebx
  800794:	79 02                	jns    800798 <vprintfmt+0x14a>
				err = -err;
  800796:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800798:	83 fb 64             	cmp    $0x64,%ebx
  80079b:	7f 0b                	jg     8007a8 <vprintfmt+0x15a>
  80079d:	8b 34 9d 40 1e 80 00 	mov    0x801e40(,%ebx,4),%esi
  8007a4:	85 f6                	test   %esi,%esi
  8007a6:	75 19                	jne    8007c1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8007a8:	53                   	push   %ebx
  8007a9:	68 e5 1f 80 00       	push   $0x801fe5
  8007ae:	ff 75 0c             	pushl  0xc(%ebp)
  8007b1:	ff 75 08             	pushl  0x8(%ebp)
  8007b4:	e8 5e 02 00 00       	call   800a17 <printfmt>
  8007b9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007bc:	e9 49 02 00 00       	jmp    800a0a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007c1:	56                   	push   %esi
  8007c2:	68 ee 1f 80 00       	push   $0x801fee
  8007c7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ca:	ff 75 08             	pushl  0x8(%ebp)
  8007cd:	e8 45 02 00 00       	call   800a17 <printfmt>
  8007d2:	83 c4 10             	add    $0x10,%esp
			break;
  8007d5:	e9 30 02 00 00       	jmp    800a0a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007da:	8b 45 14             	mov    0x14(%ebp),%eax
  8007dd:	83 c0 04             	add    $0x4,%eax
  8007e0:	89 45 14             	mov    %eax,0x14(%ebp)
  8007e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e6:	83 e8 04             	sub    $0x4,%eax
  8007e9:	8b 30                	mov    (%eax),%esi
  8007eb:	85 f6                	test   %esi,%esi
  8007ed:	75 05                	jne    8007f4 <vprintfmt+0x1a6>
				p = "(null)";
  8007ef:	be f1 1f 80 00       	mov    $0x801ff1,%esi
			if (width > 0 && padc != '-')
  8007f4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007f8:	7e 6d                	jle    800867 <vprintfmt+0x219>
  8007fa:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007fe:	74 67                	je     800867 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800800:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800803:	83 ec 08             	sub    $0x8,%esp
  800806:	50                   	push   %eax
  800807:	56                   	push   %esi
  800808:	e8 0c 03 00 00       	call   800b19 <strnlen>
  80080d:	83 c4 10             	add    $0x10,%esp
  800810:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800813:	eb 16                	jmp    80082b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800815:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800819:	83 ec 08             	sub    $0x8,%esp
  80081c:	ff 75 0c             	pushl  0xc(%ebp)
  80081f:	50                   	push   %eax
  800820:	8b 45 08             	mov    0x8(%ebp),%eax
  800823:	ff d0                	call   *%eax
  800825:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800828:	ff 4d e4             	decl   -0x1c(%ebp)
  80082b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80082f:	7f e4                	jg     800815 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800831:	eb 34                	jmp    800867 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800833:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800837:	74 1c                	je     800855 <vprintfmt+0x207>
  800839:	83 fb 1f             	cmp    $0x1f,%ebx
  80083c:	7e 05                	jle    800843 <vprintfmt+0x1f5>
  80083e:	83 fb 7e             	cmp    $0x7e,%ebx
  800841:	7e 12                	jle    800855 <vprintfmt+0x207>
					putch('?', putdat);
  800843:	83 ec 08             	sub    $0x8,%esp
  800846:	ff 75 0c             	pushl  0xc(%ebp)
  800849:	6a 3f                	push   $0x3f
  80084b:	8b 45 08             	mov    0x8(%ebp),%eax
  80084e:	ff d0                	call   *%eax
  800850:	83 c4 10             	add    $0x10,%esp
  800853:	eb 0f                	jmp    800864 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800855:	83 ec 08             	sub    $0x8,%esp
  800858:	ff 75 0c             	pushl  0xc(%ebp)
  80085b:	53                   	push   %ebx
  80085c:	8b 45 08             	mov    0x8(%ebp),%eax
  80085f:	ff d0                	call   *%eax
  800861:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800864:	ff 4d e4             	decl   -0x1c(%ebp)
  800867:	89 f0                	mov    %esi,%eax
  800869:	8d 70 01             	lea    0x1(%eax),%esi
  80086c:	8a 00                	mov    (%eax),%al
  80086e:	0f be d8             	movsbl %al,%ebx
  800871:	85 db                	test   %ebx,%ebx
  800873:	74 24                	je     800899 <vprintfmt+0x24b>
  800875:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800879:	78 b8                	js     800833 <vprintfmt+0x1e5>
  80087b:	ff 4d e0             	decl   -0x20(%ebp)
  80087e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800882:	79 af                	jns    800833 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800884:	eb 13                	jmp    800899 <vprintfmt+0x24b>
				putch(' ', putdat);
  800886:	83 ec 08             	sub    $0x8,%esp
  800889:	ff 75 0c             	pushl  0xc(%ebp)
  80088c:	6a 20                	push   $0x20
  80088e:	8b 45 08             	mov    0x8(%ebp),%eax
  800891:	ff d0                	call   *%eax
  800893:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800896:	ff 4d e4             	decl   -0x1c(%ebp)
  800899:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80089d:	7f e7                	jg     800886 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80089f:	e9 66 01 00 00       	jmp    800a0a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8008a4:	83 ec 08             	sub    $0x8,%esp
  8008a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8008aa:	8d 45 14             	lea    0x14(%ebp),%eax
  8008ad:	50                   	push   %eax
  8008ae:	e8 3c fd ff ff       	call   8005ef <getint>
  8008b3:	83 c4 10             	add    $0x10,%esp
  8008b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008c2:	85 d2                	test   %edx,%edx
  8008c4:	79 23                	jns    8008e9 <vprintfmt+0x29b>
				putch('-', putdat);
  8008c6:	83 ec 08             	sub    $0x8,%esp
  8008c9:	ff 75 0c             	pushl  0xc(%ebp)
  8008cc:	6a 2d                	push   $0x2d
  8008ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d1:	ff d0                	call   *%eax
  8008d3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008dc:	f7 d8                	neg    %eax
  8008de:	83 d2 00             	adc    $0x0,%edx
  8008e1:	f7 da                	neg    %edx
  8008e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008e9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008f0:	e9 bc 00 00 00       	jmp    8009b1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008f5:	83 ec 08             	sub    $0x8,%esp
  8008f8:	ff 75 e8             	pushl  -0x18(%ebp)
  8008fb:	8d 45 14             	lea    0x14(%ebp),%eax
  8008fe:	50                   	push   %eax
  8008ff:	e8 84 fc ff ff       	call   800588 <getuint>
  800904:	83 c4 10             	add    $0x10,%esp
  800907:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80090a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80090d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800914:	e9 98 00 00 00       	jmp    8009b1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800919:	83 ec 08             	sub    $0x8,%esp
  80091c:	ff 75 0c             	pushl  0xc(%ebp)
  80091f:	6a 58                	push   $0x58
  800921:	8b 45 08             	mov    0x8(%ebp),%eax
  800924:	ff d0                	call   *%eax
  800926:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800929:	83 ec 08             	sub    $0x8,%esp
  80092c:	ff 75 0c             	pushl  0xc(%ebp)
  80092f:	6a 58                	push   $0x58
  800931:	8b 45 08             	mov    0x8(%ebp),%eax
  800934:	ff d0                	call   *%eax
  800936:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800939:	83 ec 08             	sub    $0x8,%esp
  80093c:	ff 75 0c             	pushl  0xc(%ebp)
  80093f:	6a 58                	push   $0x58
  800941:	8b 45 08             	mov    0x8(%ebp),%eax
  800944:	ff d0                	call   *%eax
  800946:	83 c4 10             	add    $0x10,%esp
			break;
  800949:	e9 bc 00 00 00       	jmp    800a0a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80094e:	83 ec 08             	sub    $0x8,%esp
  800951:	ff 75 0c             	pushl  0xc(%ebp)
  800954:	6a 30                	push   $0x30
  800956:	8b 45 08             	mov    0x8(%ebp),%eax
  800959:	ff d0                	call   *%eax
  80095b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80095e:	83 ec 08             	sub    $0x8,%esp
  800961:	ff 75 0c             	pushl  0xc(%ebp)
  800964:	6a 78                	push   $0x78
  800966:	8b 45 08             	mov    0x8(%ebp),%eax
  800969:	ff d0                	call   *%eax
  80096b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80096e:	8b 45 14             	mov    0x14(%ebp),%eax
  800971:	83 c0 04             	add    $0x4,%eax
  800974:	89 45 14             	mov    %eax,0x14(%ebp)
  800977:	8b 45 14             	mov    0x14(%ebp),%eax
  80097a:	83 e8 04             	sub    $0x4,%eax
  80097d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80097f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800982:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800989:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800990:	eb 1f                	jmp    8009b1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800992:	83 ec 08             	sub    $0x8,%esp
  800995:	ff 75 e8             	pushl  -0x18(%ebp)
  800998:	8d 45 14             	lea    0x14(%ebp),%eax
  80099b:	50                   	push   %eax
  80099c:	e8 e7 fb ff ff       	call   800588 <getuint>
  8009a1:	83 c4 10             	add    $0x10,%esp
  8009a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009a7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8009aa:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009b1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009b8:	83 ec 04             	sub    $0x4,%esp
  8009bb:	52                   	push   %edx
  8009bc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009bf:	50                   	push   %eax
  8009c0:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c3:	ff 75 f0             	pushl  -0x10(%ebp)
  8009c6:	ff 75 0c             	pushl  0xc(%ebp)
  8009c9:	ff 75 08             	pushl  0x8(%ebp)
  8009cc:	e8 00 fb ff ff       	call   8004d1 <printnum>
  8009d1:	83 c4 20             	add    $0x20,%esp
			break;
  8009d4:	eb 34                	jmp    800a0a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009d6:	83 ec 08             	sub    $0x8,%esp
  8009d9:	ff 75 0c             	pushl  0xc(%ebp)
  8009dc:	53                   	push   %ebx
  8009dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e0:	ff d0                	call   *%eax
  8009e2:	83 c4 10             	add    $0x10,%esp
			break;
  8009e5:	eb 23                	jmp    800a0a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009e7:	83 ec 08             	sub    $0x8,%esp
  8009ea:	ff 75 0c             	pushl  0xc(%ebp)
  8009ed:	6a 25                	push   $0x25
  8009ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f2:	ff d0                	call   *%eax
  8009f4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009f7:	ff 4d 10             	decl   0x10(%ebp)
  8009fa:	eb 03                	jmp    8009ff <vprintfmt+0x3b1>
  8009fc:	ff 4d 10             	decl   0x10(%ebp)
  8009ff:	8b 45 10             	mov    0x10(%ebp),%eax
  800a02:	48                   	dec    %eax
  800a03:	8a 00                	mov    (%eax),%al
  800a05:	3c 25                	cmp    $0x25,%al
  800a07:	75 f3                	jne    8009fc <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a09:	90                   	nop
		}
	}
  800a0a:	e9 47 fc ff ff       	jmp    800656 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a0f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a10:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a13:	5b                   	pop    %ebx
  800a14:	5e                   	pop    %esi
  800a15:	5d                   	pop    %ebp
  800a16:	c3                   	ret    

00800a17 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a17:	55                   	push   %ebp
  800a18:	89 e5                	mov    %esp,%ebp
  800a1a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a1d:	8d 45 10             	lea    0x10(%ebp),%eax
  800a20:	83 c0 04             	add    $0x4,%eax
  800a23:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a26:	8b 45 10             	mov    0x10(%ebp),%eax
  800a29:	ff 75 f4             	pushl  -0xc(%ebp)
  800a2c:	50                   	push   %eax
  800a2d:	ff 75 0c             	pushl  0xc(%ebp)
  800a30:	ff 75 08             	pushl  0x8(%ebp)
  800a33:	e8 16 fc ff ff       	call   80064e <vprintfmt>
  800a38:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a3b:	90                   	nop
  800a3c:	c9                   	leave  
  800a3d:	c3                   	ret    

00800a3e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a3e:	55                   	push   %ebp
  800a3f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a44:	8b 40 08             	mov    0x8(%eax),%eax
  800a47:	8d 50 01             	lea    0x1(%eax),%edx
  800a4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a53:	8b 10                	mov    (%eax),%edx
  800a55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a58:	8b 40 04             	mov    0x4(%eax),%eax
  800a5b:	39 c2                	cmp    %eax,%edx
  800a5d:	73 12                	jae    800a71 <sprintputch+0x33>
		*b->buf++ = ch;
  800a5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a62:	8b 00                	mov    (%eax),%eax
  800a64:	8d 48 01             	lea    0x1(%eax),%ecx
  800a67:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a6a:	89 0a                	mov    %ecx,(%edx)
  800a6c:	8b 55 08             	mov    0x8(%ebp),%edx
  800a6f:	88 10                	mov    %dl,(%eax)
}
  800a71:	90                   	nop
  800a72:	5d                   	pop    %ebp
  800a73:	c3                   	ret    

00800a74 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a74:	55                   	push   %ebp
  800a75:	89 e5                	mov    %esp,%ebp
  800a77:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a83:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	01 d0                	add    %edx,%eax
  800a8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a95:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a99:	74 06                	je     800aa1 <vsnprintf+0x2d>
  800a9b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a9f:	7f 07                	jg     800aa8 <vsnprintf+0x34>
		return -E_INVAL;
  800aa1:	b8 03 00 00 00       	mov    $0x3,%eax
  800aa6:	eb 20                	jmp    800ac8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800aa8:	ff 75 14             	pushl  0x14(%ebp)
  800aab:	ff 75 10             	pushl  0x10(%ebp)
  800aae:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ab1:	50                   	push   %eax
  800ab2:	68 3e 0a 80 00       	push   $0x800a3e
  800ab7:	e8 92 fb ff ff       	call   80064e <vprintfmt>
  800abc:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800abf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ac2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ac5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ac8:	c9                   	leave  
  800ac9:	c3                   	ret    

00800aca <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800aca:	55                   	push   %ebp
  800acb:	89 e5                	mov    %esp,%ebp
  800acd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ad0:	8d 45 10             	lea    0x10(%ebp),%eax
  800ad3:	83 c0 04             	add    $0x4,%eax
  800ad6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ad9:	8b 45 10             	mov    0x10(%ebp),%eax
  800adc:	ff 75 f4             	pushl  -0xc(%ebp)
  800adf:	50                   	push   %eax
  800ae0:	ff 75 0c             	pushl  0xc(%ebp)
  800ae3:	ff 75 08             	pushl  0x8(%ebp)
  800ae6:	e8 89 ff ff ff       	call   800a74 <vsnprintf>
  800aeb:	83 c4 10             	add    $0x10,%esp
  800aee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800af1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800af4:	c9                   	leave  
  800af5:	c3                   	ret    

00800af6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800af6:	55                   	push   %ebp
  800af7:	89 e5                	mov    %esp,%ebp
  800af9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800afc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b03:	eb 06                	jmp    800b0b <strlen+0x15>
		n++;
  800b05:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b08:	ff 45 08             	incl   0x8(%ebp)
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0e:	8a 00                	mov    (%eax),%al
  800b10:	84 c0                	test   %al,%al
  800b12:	75 f1                	jne    800b05 <strlen+0xf>
		n++;
	return n;
  800b14:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b17:	c9                   	leave  
  800b18:	c3                   	ret    

00800b19 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b19:	55                   	push   %ebp
  800b1a:	89 e5                	mov    %esp,%ebp
  800b1c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b1f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b26:	eb 09                	jmp    800b31 <strnlen+0x18>
		n++;
  800b28:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b2b:	ff 45 08             	incl   0x8(%ebp)
  800b2e:	ff 4d 0c             	decl   0xc(%ebp)
  800b31:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b35:	74 09                	je     800b40 <strnlen+0x27>
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	8a 00                	mov    (%eax),%al
  800b3c:	84 c0                	test   %al,%al
  800b3e:	75 e8                	jne    800b28 <strnlen+0xf>
		n++;
	return n;
  800b40:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b43:	c9                   	leave  
  800b44:	c3                   	ret    

00800b45 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b45:	55                   	push   %ebp
  800b46:	89 e5                	mov    %esp,%ebp
  800b48:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b51:	90                   	nop
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	8d 50 01             	lea    0x1(%eax),%edx
  800b58:	89 55 08             	mov    %edx,0x8(%ebp)
  800b5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b5e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b61:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b64:	8a 12                	mov    (%edx),%dl
  800b66:	88 10                	mov    %dl,(%eax)
  800b68:	8a 00                	mov    (%eax),%al
  800b6a:	84 c0                	test   %al,%al
  800b6c:	75 e4                	jne    800b52 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b71:	c9                   	leave  
  800b72:	c3                   	ret    

00800b73 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b73:	55                   	push   %ebp
  800b74:	89 e5                	mov    %esp,%ebp
  800b76:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b86:	eb 1f                	jmp    800ba7 <strncpy+0x34>
		*dst++ = *src;
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	8d 50 01             	lea    0x1(%eax),%edx
  800b8e:	89 55 08             	mov    %edx,0x8(%ebp)
  800b91:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b94:	8a 12                	mov    (%edx),%dl
  800b96:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9b:	8a 00                	mov    (%eax),%al
  800b9d:	84 c0                	test   %al,%al
  800b9f:	74 03                	je     800ba4 <strncpy+0x31>
			src++;
  800ba1:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ba4:	ff 45 fc             	incl   -0x4(%ebp)
  800ba7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800baa:	3b 45 10             	cmp    0x10(%ebp),%eax
  800bad:	72 d9                	jb     800b88 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800baf:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800bb2:	c9                   	leave  
  800bb3:	c3                   	ret    

00800bb4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800bb4:	55                   	push   %ebp
  800bb5:	89 e5                	mov    %esp,%ebp
  800bb7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800bba:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bc0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bc4:	74 30                	je     800bf6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bc6:	eb 16                	jmp    800bde <strlcpy+0x2a>
			*dst++ = *src++;
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	8d 50 01             	lea    0x1(%eax),%edx
  800bce:	89 55 08             	mov    %edx,0x8(%ebp)
  800bd1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bd4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bd7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bda:	8a 12                	mov    (%edx),%dl
  800bdc:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bde:	ff 4d 10             	decl   0x10(%ebp)
  800be1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800be5:	74 09                	je     800bf0 <strlcpy+0x3c>
  800be7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bea:	8a 00                	mov    (%eax),%al
  800bec:	84 c0                	test   %al,%al
  800bee:	75 d8                	jne    800bc8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800bf6:	8b 55 08             	mov    0x8(%ebp),%edx
  800bf9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bfc:	29 c2                	sub    %eax,%edx
  800bfe:	89 d0                	mov    %edx,%eax
}
  800c00:	c9                   	leave  
  800c01:	c3                   	ret    

00800c02 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c02:	55                   	push   %ebp
  800c03:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c05:	eb 06                	jmp    800c0d <strcmp+0xb>
		p++, q++;
  800c07:	ff 45 08             	incl   0x8(%ebp)
  800c0a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	8a 00                	mov    (%eax),%al
  800c12:	84 c0                	test   %al,%al
  800c14:	74 0e                	je     800c24 <strcmp+0x22>
  800c16:	8b 45 08             	mov    0x8(%ebp),%eax
  800c19:	8a 10                	mov    (%eax),%dl
  800c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1e:	8a 00                	mov    (%eax),%al
  800c20:	38 c2                	cmp    %al,%dl
  800c22:	74 e3                	je     800c07 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	8a 00                	mov    (%eax),%al
  800c29:	0f b6 d0             	movzbl %al,%edx
  800c2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2f:	8a 00                	mov    (%eax),%al
  800c31:	0f b6 c0             	movzbl %al,%eax
  800c34:	29 c2                	sub    %eax,%edx
  800c36:	89 d0                	mov    %edx,%eax
}
  800c38:	5d                   	pop    %ebp
  800c39:	c3                   	ret    

00800c3a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c3a:	55                   	push   %ebp
  800c3b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c3d:	eb 09                	jmp    800c48 <strncmp+0xe>
		n--, p++, q++;
  800c3f:	ff 4d 10             	decl   0x10(%ebp)
  800c42:	ff 45 08             	incl   0x8(%ebp)
  800c45:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c48:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c4c:	74 17                	je     800c65 <strncmp+0x2b>
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c51:	8a 00                	mov    (%eax),%al
  800c53:	84 c0                	test   %al,%al
  800c55:	74 0e                	je     800c65 <strncmp+0x2b>
  800c57:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5a:	8a 10                	mov    (%eax),%dl
  800c5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5f:	8a 00                	mov    (%eax),%al
  800c61:	38 c2                	cmp    %al,%dl
  800c63:	74 da                	je     800c3f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c65:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c69:	75 07                	jne    800c72 <strncmp+0x38>
		return 0;
  800c6b:	b8 00 00 00 00       	mov    $0x0,%eax
  800c70:	eb 14                	jmp    800c86 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c72:	8b 45 08             	mov    0x8(%ebp),%eax
  800c75:	8a 00                	mov    (%eax),%al
  800c77:	0f b6 d0             	movzbl %al,%edx
  800c7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7d:	8a 00                	mov    (%eax),%al
  800c7f:	0f b6 c0             	movzbl %al,%eax
  800c82:	29 c2                	sub    %eax,%edx
  800c84:	89 d0                	mov    %edx,%eax
}
  800c86:	5d                   	pop    %ebp
  800c87:	c3                   	ret    

00800c88 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c88:	55                   	push   %ebp
  800c89:	89 e5                	mov    %esp,%ebp
  800c8b:	83 ec 04             	sub    $0x4,%esp
  800c8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c91:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c94:	eb 12                	jmp    800ca8 <strchr+0x20>
		if (*s == c)
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	8a 00                	mov    (%eax),%al
  800c9b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c9e:	75 05                	jne    800ca5 <strchr+0x1d>
			return (char *) s;
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	eb 11                	jmp    800cb6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ca5:	ff 45 08             	incl   0x8(%ebp)
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	8a 00                	mov    (%eax),%al
  800cad:	84 c0                	test   %al,%al
  800caf:	75 e5                	jne    800c96 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800cb1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cb6:	c9                   	leave  
  800cb7:	c3                   	ret    

00800cb8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800cb8:	55                   	push   %ebp
  800cb9:	89 e5                	mov    %esp,%ebp
  800cbb:	83 ec 04             	sub    $0x4,%esp
  800cbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cc4:	eb 0d                	jmp    800cd3 <strfind+0x1b>
		if (*s == c)
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	8a 00                	mov    (%eax),%al
  800ccb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cce:	74 0e                	je     800cde <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cd0:	ff 45 08             	incl   0x8(%ebp)
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	8a 00                	mov    (%eax),%al
  800cd8:	84 c0                	test   %al,%al
  800cda:	75 ea                	jne    800cc6 <strfind+0xe>
  800cdc:	eb 01                	jmp    800cdf <strfind+0x27>
		if (*s == c)
			break;
  800cde:	90                   	nop
	return (char *) s;
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ce2:	c9                   	leave  
  800ce3:	c3                   	ret    

00800ce4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ce4:	55                   	push   %ebp
  800ce5:	89 e5                	mov    %esp,%ebp
  800ce7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800cf0:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800cf6:	eb 0e                	jmp    800d06 <memset+0x22>
		*p++ = c;
  800cf8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cfb:	8d 50 01             	lea    0x1(%eax),%edx
  800cfe:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d01:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d04:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d06:	ff 4d f8             	decl   -0x8(%ebp)
  800d09:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d0d:	79 e9                	jns    800cf8 <memset+0x14>
		*p++ = c;

	return v;
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d12:	c9                   	leave  
  800d13:	c3                   	ret    

00800d14 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d14:	55                   	push   %ebp
  800d15:	89 e5                	mov    %esp,%ebp
  800d17:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d26:	eb 16                	jmp    800d3e <memcpy+0x2a>
		*d++ = *s++;
  800d28:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d2b:	8d 50 01             	lea    0x1(%eax),%edx
  800d2e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d31:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d34:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d37:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d3a:	8a 12                	mov    (%edx),%dl
  800d3c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800d41:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d44:	89 55 10             	mov    %edx,0x10(%ebp)
  800d47:	85 c0                	test   %eax,%eax
  800d49:	75 dd                	jne    800d28 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d4e:	c9                   	leave  
  800d4f:	c3                   	ret    

00800d50 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d50:	55                   	push   %ebp
  800d51:	89 e5                	mov    %esp,%ebp
  800d53:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d62:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d65:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d68:	73 50                	jae    800dba <memmove+0x6a>
  800d6a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d6d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d70:	01 d0                	add    %edx,%eax
  800d72:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d75:	76 43                	jbe    800dba <memmove+0x6a>
		s += n;
  800d77:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800d7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d80:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d83:	eb 10                	jmp    800d95 <memmove+0x45>
			*--d = *--s;
  800d85:	ff 4d f8             	decl   -0x8(%ebp)
  800d88:	ff 4d fc             	decl   -0x4(%ebp)
  800d8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d8e:	8a 10                	mov    (%eax),%dl
  800d90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d93:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800d95:	8b 45 10             	mov    0x10(%ebp),%eax
  800d98:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d9b:	89 55 10             	mov    %edx,0x10(%ebp)
  800d9e:	85 c0                	test   %eax,%eax
  800da0:	75 e3                	jne    800d85 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800da2:	eb 23                	jmp    800dc7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800da4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da7:	8d 50 01             	lea    0x1(%eax),%edx
  800daa:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dad:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800db0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800db3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800db6:	8a 12                	mov    (%edx),%dl
  800db8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800dba:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dc0:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc3:	85 c0                	test   %eax,%eax
  800dc5:	75 dd                	jne    800da4 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dca:	c9                   	leave  
  800dcb:	c3                   	ret    

00800dcc <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800dcc:	55                   	push   %ebp
  800dcd:	89 e5                	mov    %esp,%ebp
  800dcf:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800dd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddb:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800dde:	eb 2a                	jmp    800e0a <memcmp+0x3e>
		if (*s1 != *s2)
  800de0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de3:	8a 10                	mov    (%eax),%dl
  800de5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de8:	8a 00                	mov    (%eax),%al
  800dea:	38 c2                	cmp    %al,%dl
  800dec:	74 16                	je     800e04 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800dee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df1:	8a 00                	mov    (%eax),%al
  800df3:	0f b6 d0             	movzbl %al,%edx
  800df6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df9:	8a 00                	mov    (%eax),%al
  800dfb:	0f b6 c0             	movzbl %al,%eax
  800dfe:	29 c2                	sub    %eax,%edx
  800e00:	89 d0                	mov    %edx,%eax
  800e02:	eb 18                	jmp    800e1c <memcmp+0x50>
		s1++, s2++;
  800e04:	ff 45 fc             	incl   -0x4(%ebp)
  800e07:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e0a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e10:	89 55 10             	mov    %edx,0x10(%ebp)
  800e13:	85 c0                	test   %eax,%eax
  800e15:	75 c9                	jne    800de0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e17:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e1c:	c9                   	leave  
  800e1d:	c3                   	ret    

00800e1e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e1e:	55                   	push   %ebp
  800e1f:	89 e5                	mov    %esp,%ebp
  800e21:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e24:	8b 55 08             	mov    0x8(%ebp),%edx
  800e27:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2a:	01 d0                	add    %edx,%eax
  800e2c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e2f:	eb 15                	jmp    800e46 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	8a 00                	mov    (%eax),%al
  800e36:	0f b6 d0             	movzbl %al,%edx
  800e39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3c:	0f b6 c0             	movzbl %al,%eax
  800e3f:	39 c2                	cmp    %eax,%edx
  800e41:	74 0d                	je     800e50 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e43:	ff 45 08             	incl   0x8(%ebp)
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
  800e49:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e4c:	72 e3                	jb     800e31 <memfind+0x13>
  800e4e:	eb 01                	jmp    800e51 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e50:	90                   	nop
	return (void *) s;
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e54:	c9                   	leave  
  800e55:	c3                   	ret    

00800e56 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e56:	55                   	push   %ebp
  800e57:	89 e5                	mov    %esp,%ebp
  800e59:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e5c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e63:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e6a:	eb 03                	jmp    800e6f <strtol+0x19>
		s++;
  800e6c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	8a 00                	mov    (%eax),%al
  800e74:	3c 20                	cmp    $0x20,%al
  800e76:	74 f4                	je     800e6c <strtol+0x16>
  800e78:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7b:	8a 00                	mov    (%eax),%al
  800e7d:	3c 09                	cmp    $0x9,%al
  800e7f:	74 eb                	je     800e6c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800e81:	8b 45 08             	mov    0x8(%ebp),%eax
  800e84:	8a 00                	mov    (%eax),%al
  800e86:	3c 2b                	cmp    $0x2b,%al
  800e88:	75 05                	jne    800e8f <strtol+0x39>
		s++;
  800e8a:	ff 45 08             	incl   0x8(%ebp)
  800e8d:	eb 13                	jmp    800ea2 <strtol+0x4c>
	else if (*s == '-')
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	8a 00                	mov    (%eax),%al
  800e94:	3c 2d                	cmp    $0x2d,%al
  800e96:	75 0a                	jne    800ea2 <strtol+0x4c>
		s++, neg = 1;
  800e98:	ff 45 08             	incl   0x8(%ebp)
  800e9b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ea2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ea6:	74 06                	je     800eae <strtol+0x58>
  800ea8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800eac:	75 20                	jne    800ece <strtol+0x78>
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	3c 30                	cmp    $0x30,%al
  800eb5:	75 17                	jne    800ece <strtol+0x78>
  800eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eba:	40                   	inc    %eax
  800ebb:	8a 00                	mov    (%eax),%al
  800ebd:	3c 78                	cmp    $0x78,%al
  800ebf:	75 0d                	jne    800ece <strtol+0x78>
		s += 2, base = 16;
  800ec1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ec5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ecc:	eb 28                	jmp    800ef6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ece:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed2:	75 15                	jne    800ee9 <strtol+0x93>
  800ed4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed7:	8a 00                	mov    (%eax),%al
  800ed9:	3c 30                	cmp    $0x30,%al
  800edb:	75 0c                	jne    800ee9 <strtol+0x93>
		s++, base = 8;
  800edd:	ff 45 08             	incl   0x8(%ebp)
  800ee0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800ee7:	eb 0d                	jmp    800ef6 <strtol+0xa0>
	else if (base == 0)
  800ee9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eed:	75 07                	jne    800ef6 <strtol+0xa0>
		base = 10;
  800eef:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	3c 2f                	cmp    $0x2f,%al
  800efd:	7e 19                	jle    800f18 <strtol+0xc2>
  800eff:	8b 45 08             	mov    0x8(%ebp),%eax
  800f02:	8a 00                	mov    (%eax),%al
  800f04:	3c 39                	cmp    $0x39,%al
  800f06:	7f 10                	jg     800f18 <strtol+0xc2>
			dig = *s - '0';
  800f08:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0b:	8a 00                	mov    (%eax),%al
  800f0d:	0f be c0             	movsbl %al,%eax
  800f10:	83 e8 30             	sub    $0x30,%eax
  800f13:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f16:	eb 42                	jmp    800f5a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	3c 60                	cmp    $0x60,%al
  800f1f:	7e 19                	jle    800f3a <strtol+0xe4>
  800f21:	8b 45 08             	mov    0x8(%ebp),%eax
  800f24:	8a 00                	mov    (%eax),%al
  800f26:	3c 7a                	cmp    $0x7a,%al
  800f28:	7f 10                	jg     800f3a <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	8a 00                	mov    (%eax),%al
  800f2f:	0f be c0             	movsbl %al,%eax
  800f32:	83 e8 57             	sub    $0x57,%eax
  800f35:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f38:	eb 20                	jmp    800f5a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	3c 40                	cmp    $0x40,%al
  800f41:	7e 39                	jle    800f7c <strtol+0x126>
  800f43:	8b 45 08             	mov    0x8(%ebp),%eax
  800f46:	8a 00                	mov    (%eax),%al
  800f48:	3c 5a                	cmp    $0x5a,%al
  800f4a:	7f 30                	jg     800f7c <strtol+0x126>
			dig = *s - 'A' + 10;
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	8a 00                	mov    (%eax),%al
  800f51:	0f be c0             	movsbl %al,%eax
  800f54:	83 e8 37             	sub    $0x37,%eax
  800f57:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f5d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f60:	7d 19                	jge    800f7b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f62:	ff 45 08             	incl   0x8(%ebp)
  800f65:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f68:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f6c:	89 c2                	mov    %eax,%edx
  800f6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f71:	01 d0                	add    %edx,%eax
  800f73:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f76:	e9 7b ff ff ff       	jmp    800ef6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800f7b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800f7c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f80:	74 08                	je     800f8a <strtol+0x134>
		*endptr = (char *) s;
  800f82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f85:	8b 55 08             	mov    0x8(%ebp),%edx
  800f88:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800f8a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f8e:	74 07                	je     800f97 <strtol+0x141>
  800f90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f93:	f7 d8                	neg    %eax
  800f95:	eb 03                	jmp    800f9a <strtol+0x144>
  800f97:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f9a:	c9                   	leave  
  800f9b:	c3                   	ret    

00800f9c <ltostr>:

void
ltostr(long value, char *str)
{
  800f9c:	55                   	push   %ebp
  800f9d:	89 e5                	mov    %esp,%ebp
  800f9f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fa2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fa9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fb0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fb4:	79 13                	jns    800fc9 <ltostr+0x2d>
	{
		neg = 1;
  800fb6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800fbd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800fc3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800fc6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800fd1:	99                   	cltd   
  800fd2:	f7 f9                	idiv   %ecx
  800fd4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800fd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fda:	8d 50 01             	lea    0x1(%eax),%edx
  800fdd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fe0:	89 c2                	mov    %eax,%edx
  800fe2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe5:	01 d0                	add    %edx,%eax
  800fe7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800fea:	83 c2 30             	add    $0x30,%edx
  800fed:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800fef:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ff2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ff7:	f7 e9                	imul   %ecx
  800ff9:	c1 fa 02             	sar    $0x2,%edx
  800ffc:	89 c8                	mov    %ecx,%eax
  800ffe:	c1 f8 1f             	sar    $0x1f,%eax
  801001:	29 c2                	sub    %eax,%edx
  801003:	89 d0                	mov    %edx,%eax
  801005:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801008:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80100b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801010:	f7 e9                	imul   %ecx
  801012:	c1 fa 02             	sar    $0x2,%edx
  801015:	89 c8                	mov    %ecx,%eax
  801017:	c1 f8 1f             	sar    $0x1f,%eax
  80101a:	29 c2                	sub    %eax,%edx
  80101c:	89 d0                	mov    %edx,%eax
  80101e:	c1 e0 02             	shl    $0x2,%eax
  801021:	01 d0                	add    %edx,%eax
  801023:	01 c0                	add    %eax,%eax
  801025:	29 c1                	sub    %eax,%ecx
  801027:	89 ca                	mov    %ecx,%edx
  801029:	85 d2                	test   %edx,%edx
  80102b:	75 9c                	jne    800fc9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80102d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801034:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801037:	48                   	dec    %eax
  801038:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80103b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80103f:	74 3d                	je     80107e <ltostr+0xe2>
		start = 1 ;
  801041:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801048:	eb 34                	jmp    80107e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80104a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80104d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801050:	01 d0                	add    %edx,%eax
  801052:	8a 00                	mov    (%eax),%al
  801054:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801057:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80105a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105d:	01 c2                	add    %eax,%edx
  80105f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801062:	8b 45 0c             	mov    0xc(%ebp),%eax
  801065:	01 c8                	add    %ecx,%eax
  801067:	8a 00                	mov    (%eax),%al
  801069:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80106b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80106e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801071:	01 c2                	add    %eax,%edx
  801073:	8a 45 eb             	mov    -0x15(%ebp),%al
  801076:	88 02                	mov    %al,(%edx)
		start++ ;
  801078:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80107b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80107e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801081:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801084:	7c c4                	jl     80104a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801086:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801089:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108c:	01 d0                	add    %edx,%eax
  80108e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801091:	90                   	nop
  801092:	c9                   	leave  
  801093:	c3                   	ret    

00801094 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801094:	55                   	push   %ebp
  801095:	89 e5                	mov    %esp,%ebp
  801097:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80109a:	ff 75 08             	pushl  0x8(%ebp)
  80109d:	e8 54 fa ff ff       	call   800af6 <strlen>
  8010a2:	83 c4 04             	add    $0x4,%esp
  8010a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010a8:	ff 75 0c             	pushl  0xc(%ebp)
  8010ab:	e8 46 fa ff ff       	call   800af6 <strlen>
  8010b0:	83 c4 04             	add    $0x4,%esp
  8010b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010c4:	eb 17                	jmp    8010dd <strcconcat+0x49>
		final[s] = str1[s] ;
  8010c6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010cc:	01 c2                	add    %eax,%edx
  8010ce:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d4:	01 c8                	add    %ecx,%eax
  8010d6:	8a 00                	mov    (%eax),%al
  8010d8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010da:	ff 45 fc             	incl   -0x4(%ebp)
  8010dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010e3:	7c e1                	jl     8010c6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8010e5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8010ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010f3:	eb 1f                	jmp    801114 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8010f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f8:	8d 50 01             	lea    0x1(%eax),%edx
  8010fb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010fe:	89 c2                	mov    %eax,%edx
  801100:	8b 45 10             	mov    0x10(%ebp),%eax
  801103:	01 c2                	add    %eax,%edx
  801105:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801108:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110b:	01 c8                	add    %ecx,%eax
  80110d:	8a 00                	mov    (%eax),%al
  80110f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801111:	ff 45 f8             	incl   -0x8(%ebp)
  801114:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801117:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80111a:	7c d9                	jl     8010f5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80111c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80111f:	8b 45 10             	mov    0x10(%ebp),%eax
  801122:	01 d0                	add    %edx,%eax
  801124:	c6 00 00             	movb   $0x0,(%eax)
}
  801127:	90                   	nop
  801128:	c9                   	leave  
  801129:	c3                   	ret    

0080112a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80112a:	55                   	push   %ebp
  80112b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80112d:	8b 45 14             	mov    0x14(%ebp),%eax
  801130:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801136:	8b 45 14             	mov    0x14(%ebp),%eax
  801139:	8b 00                	mov    (%eax),%eax
  80113b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801142:	8b 45 10             	mov    0x10(%ebp),%eax
  801145:	01 d0                	add    %edx,%eax
  801147:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80114d:	eb 0c                	jmp    80115b <strsplit+0x31>
			*string++ = 0;
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
  801152:	8d 50 01             	lea    0x1(%eax),%edx
  801155:	89 55 08             	mov    %edx,0x8(%ebp)
  801158:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	8a 00                	mov    (%eax),%al
  801160:	84 c0                	test   %al,%al
  801162:	74 18                	je     80117c <strsplit+0x52>
  801164:	8b 45 08             	mov    0x8(%ebp),%eax
  801167:	8a 00                	mov    (%eax),%al
  801169:	0f be c0             	movsbl %al,%eax
  80116c:	50                   	push   %eax
  80116d:	ff 75 0c             	pushl  0xc(%ebp)
  801170:	e8 13 fb ff ff       	call   800c88 <strchr>
  801175:	83 c4 08             	add    $0x8,%esp
  801178:	85 c0                	test   %eax,%eax
  80117a:	75 d3                	jne    80114f <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80117c:	8b 45 08             	mov    0x8(%ebp),%eax
  80117f:	8a 00                	mov    (%eax),%al
  801181:	84 c0                	test   %al,%al
  801183:	74 5a                	je     8011df <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801185:	8b 45 14             	mov    0x14(%ebp),%eax
  801188:	8b 00                	mov    (%eax),%eax
  80118a:	83 f8 0f             	cmp    $0xf,%eax
  80118d:	75 07                	jne    801196 <strsplit+0x6c>
		{
			return 0;
  80118f:	b8 00 00 00 00       	mov    $0x0,%eax
  801194:	eb 66                	jmp    8011fc <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801196:	8b 45 14             	mov    0x14(%ebp),%eax
  801199:	8b 00                	mov    (%eax),%eax
  80119b:	8d 48 01             	lea    0x1(%eax),%ecx
  80119e:	8b 55 14             	mov    0x14(%ebp),%edx
  8011a1:	89 0a                	mov    %ecx,(%edx)
  8011a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ad:	01 c2                	add    %eax,%edx
  8011af:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011b4:	eb 03                	jmp    8011b9 <strsplit+0x8f>
			string++;
  8011b6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bc:	8a 00                	mov    (%eax),%al
  8011be:	84 c0                	test   %al,%al
  8011c0:	74 8b                	je     80114d <strsplit+0x23>
  8011c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c5:	8a 00                	mov    (%eax),%al
  8011c7:	0f be c0             	movsbl %al,%eax
  8011ca:	50                   	push   %eax
  8011cb:	ff 75 0c             	pushl  0xc(%ebp)
  8011ce:	e8 b5 fa ff ff       	call   800c88 <strchr>
  8011d3:	83 c4 08             	add    $0x8,%esp
  8011d6:	85 c0                	test   %eax,%eax
  8011d8:	74 dc                	je     8011b6 <strsplit+0x8c>
			string++;
	}
  8011da:	e9 6e ff ff ff       	jmp    80114d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011df:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e3:	8b 00                	mov    (%eax),%eax
  8011e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ef:	01 d0                	add    %edx,%eax
  8011f1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8011f7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8011fc:	c9                   	leave  
  8011fd:	c3                   	ret    

008011fe <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8011fe:	55                   	push   %ebp
  8011ff:	89 e5                	mov    %esp,%ebp
  801201:	57                   	push   %edi
  801202:	56                   	push   %esi
  801203:	53                   	push   %ebx
  801204:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80120d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801210:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801213:	8b 7d 18             	mov    0x18(%ebp),%edi
  801216:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801219:	cd 30                	int    $0x30
  80121b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80121e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801221:	83 c4 10             	add    $0x10,%esp
  801224:	5b                   	pop    %ebx
  801225:	5e                   	pop    %esi
  801226:	5f                   	pop    %edi
  801227:	5d                   	pop    %ebp
  801228:	c3                   	ret    

00801229 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801229:	55                   	push   %ebp
  80122a:	89 e5                	mov    %esp,%ebp
  80122c:	83 ec 04             	sub    $0x4,%esp
  80122f:	8b 45 10             	mov    0x10(%ebp),%eax
  801232:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801235:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801239:	8b 45 08             	mov    0x8(%ebp),%eax
  80123c:	6a 00                	push   $0x0
  80123e:	6a 00                	push   $0x0
  801240:	52                   	push   %edx
  801241:	ff 75 0c             	pushl  0xc(%ebp)
  801244:	50                   	push   %eax
  801245:	6a 00                	push   $0x0
  801247:	e8 b2 ff ff ff       	call   8011fe <syscall>
  80124c:	83 c4 18             	add    $0x18,%esp
}
  80124f:	90                   	nop
  801250:	c9                   	leave  
  801251:	c3                   	ret    

00801252 <sys_cgetc>:

int
sys_cgetc(void)
{
  801252:	55                   	push   %ebp
  801253:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	6a 01                	push   $0x1
  801261:	e8 98 ff ff ff       	call   8011fe <syscall>
  801266:	83 c4 18             	add    $0x18,%esp
}
  801269:	c9                   	leave  
  80126a:	c3                   	ret    

0080126b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80126b:	55                   	push   %ebp
  80126c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	50                   	push   %eax
  80127a:	6a 05                	push   $0x5
  80127c:	e8 7d ff ff ff       	call   8011fe <syscall>
  801281:	83 c4 18             	add    $0x18,%esp
}
  801284:	c9                   	leave  
  801285:	c3                   	ret    

00801286 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801286:	55                   	push   %ebp
  801287:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	6a 02                	push   $0x2
  801295:	e8 64 ff ff ff       	call   8011fe <syscall>
  80129a:	83 c4 18             	add    $0x18,%esp
}
  80129d:	c9                   	leave  
  80129e:	c3                   	ret    

0080129f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80129f:	55                   	push   %ebp
  8012a0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	6a 03                	push   $0x3
  8012ae:	e8 4b ff ff ff       	call   8011fe <syscall>
  8012b3:	83 c4 18             	add    $0x18,%esp
}
  8012b6:	c9                   	leave  
  8012b7:	c3                   	ret    

008012b8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012b8:	55                   	push   %ebp
  8012b9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012bb:	6a 00                	push   $0x0
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	6a 04                	push   $0x4
  8012c7:	e8 32 ff ff ff       	call   8011fe <syscall>
  8012cc:	83 c4 18             	add    $0x18,%esp
}
  8012cf:	c9                   	leave  
  8012d0:	c3                   	ret    

008012d1 <sys_env_exit>:


void sys_env_exit(void)
{
  8012d1:	55                   	push   %ebp
  8012d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 00                	push   $0x0
  8012de:	6a 06                	push   $0x6
  8012e0:	e8 19 ff ff ff       	call   8011fe <syscall>
  8012e5:	83 c4 18             	add    $0x18,%esp
}
  8012e8:	90                   	nop
  8012e9:	c9                   	leave  
  8012ea:	c3                   	ret    

008012eb <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8012ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	52                   	push   %edx
  8012fb:	50                   	push   %eax
  8012fc:	6a 07                	push   $0x7
  8012fe:	e8 fb fe ff ff       	call   8011fe <syscall>
  801303:	83 c4 18             	add    $0x18,%esp
}
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
  80130b:	56                   	push   %esi
  80130c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80130d:	8b 75 18             	mov    0x18(%ebp),%esi
  801310:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801313:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801316:	8b 55 0c             	mov    0xc(%ebp),%edx
  801319:	8b 45 08             	mov    0x8(%ebp),%eax
  80131c:	56                   	push   %esi
  80131d:	53                   	push   %ebx
  80131e:	51                   	push   %ecx
  80131f:	52                   	push   %edx
  801320:	50                   	push   %eax
  801321:	6a 08                	push   $0x8
  801323:	e8 d6 fe ff ff       	call   8011fe <syscall>
  801328:	83 c4 18             	add    $0x18,%esp
}
  80132b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80132e:	5b                   	pop    %ebx
  80132f:	5e                   	pop    %esi
  801330:	5d                   	pop    %ebp
  801331:	c3                   	ret    

00801332 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801332:	55                   	push   %ebp
  801333:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801335:	8b 55 0c             	mov    0xc(%ebp),%edx
  801338:	8b 45 08             	mov    0x8(%ebp),%eax
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	52                   	push   %edx
  801342:	50                   	push   %eax
  801343:	6a 09                	push   $0x9
  801345:	e8 b4 fe ff ff       	call   8011fe <syscall>
  80134a:	83 c4 18             	add    $0x18,%esp
}
  80134d:	c9                   	leave  
  80134e:	c3                   	ret    

0080134f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80134f:	55                   	push   %ebp
  801350:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 00                	push   $0x0
  801358:	ff 75 0c             	pushl  0xc(%ebp)
  80135b:	ff 75 08             	pushl  0x8(%ebp)
  80135e:	6a 0a                	push   $0xa
  801360:	e8 99 fe ff ff       	call   8011fe <syscall>
  801365:	83 c4 18             	add    $0x18,%esp
}
  801368:	c9                   	leave  
  801369:	c3                   	ret    

0080136a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80136a:	55                   	push   %ebp
  80136b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80136d:	6a 00                	push   $0x0
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	6a 00                	push   $0x0
  801377:	6a 0b                	push   $0xb
  801379:	e8 80 fe ff ff       	call   8011fe <syscall>
  80137e:	83 c4 18             	add    $0x18,%esp
}
  801381:	c9                   	leave  
  801382:	c3                   	ret    

00801383 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801383:	55                   	push   %ebp
  801384:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801386:	6a 00                	push   $0x0
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	6a 0c                	push   $0xc
  801392:	e8 67 fe ff ff       	call   8011fe <syscall>
  801397:	83 c4 18             	add    $0x18,%esp
}
  80139a:	c9                   	leave  
  80139b:	c3                   	ret    

0080139c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 0d                	push   $0xd
  8013ab:	e8 4e fe ff ff       	call   8011fe <syscall>
  8013b0:	83 c4 18             	add    $0x18,%esp
}
  8013b3:	c9                   	leave  
  8013b4:	c3                   	ret    

008013b5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013b5:	55                   	push   %ebp
  8013b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	ff 75 0c             	pushl  0xc(%ebp)
  8013c1:	ff 75 08             	pushl  0x8(%ebp)
  8013c4:	6a 11                	push   $0x11
  8013c6:	e8 33 fe ff ff       	call   8011fe <syscall>
  8013cb:	83 c4 18             	add    $0x18,%esp
	return;
  8013ce:	90                   	nop
}
  8013cf:	c9                   	leave  
  8013d0:	c3                   	ret    

008013d1 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8013d1:	55                   	push   %ebp
  8013d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	ff 75 0c             	pushl  0xc(%ebp)
  8013dd:	ff 75 08             	pushl  0x8(%ebp)
  8013e0:	6a 12                	push   $0x12
  8013e2:	e8 17 fe ff ff       	call   8011fe <syscall>
  8013e7:	83 c4 18             	add    $0x18,%esp
	return ;
  8013ea:	90                   	nop
}
  8013eb:	c9                   	leave  
  8013ec:	c3                   	ret    

008013ed <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8013ed:	55                   	push   %ebp
  8013ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 0e                	push   $0xe
  8013fc:	e8 fd fd ff ff       	call   8011fe <syscall>
  801401:	83 c4 18             	add    $0x18,%esp
}
  801404:	c9                   	leave  
  801405:	c3                   	ret    

00801406 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801406:	55                   	push   %ebp
  801407:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	ff 75 08             	pushl  0x8(%ebp)
  801414:	6a 0f                	push   $0xf
  801416:	e8 e3 fd ff ff       	call   8011fe <syscall>
  80141b:	83 c4 18             	add    $0x18,%esp
}
  80141e:	c9                   	leave  
  80141f:	c3                   	ret    

00801420 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801420:	55                   	push   %ebp
  801421:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	6a 10                	push   $0x10
  80142f:	e8 ca fd ff ff       	call   8011fe <syscall>
  801434:	83 c4 18             	add    $0x18,%esp
}
  801437:	90                   	nop
  801438:	c9                   	leave  
  801439:	c3                   	ret    

0080143a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80143a:	55                   	push   %ebp
  80143b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	6a 14                	push   $0x14
  801449:	e8 b0 fd ff ff       	call   8011fe <syscall>
  80144e:	83 c4 18             	add    $0x18,%esp
}
  801451:	90                   	nop
  801452:	c9                   	leave  
  801453:	c3                   	ret    

00801454 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801454:	55                   	push   %ebp
  801455:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801457:	6a 00                	push   $0x0
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	6a 15                	push   $0x15
  801463:	e8 96 fd ff ff       	call   8011fe <syscall>
  801468:	83 c4 18             	add    $0x18,%esp
}
  80146b:	90                   	nop
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <sys_cputc>:


void
sys_cputc(const char c)
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
  801471:	83 ec 04             	sub    $0x4,%esp
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
  801477:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80147a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	50                   	push   %eax
  801487:	6a 16                	push   $0x16
  801489:	e8 70 fd ff ff       	call   8011fe <syscall>
  80148e:	83 c4 18             	add    $0x18,%esp
}
  801491:	90                   	nop
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 17                	push   $0x17
  8014a3:	e8 56 fd ff ff       	call   8011fe <syscall>
  8014a8:	83 c4 18             	add    $0x18,%esp
}
  8014ab:	90                   	nop
  8014ac:	c9                   	leave  
  8014ad:	c3                   	ret    

008014ae <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014ae:	55                   	push   %ebp
  8014af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	ff 75 0c             	pushl  0xc(%ebp)
  8014bd:	50                   	push   %eax
  8014be:	6a 18                	push   $0x18
  8014c0:	e8 39 fd ff ff       	call   8011fe <syscall>
  8014c5:	83 c4 18             	add    $0x18,%esp
}
  8014c8:	c9                   	leave  
  8014c9:	c3                   	ret    

008014ca <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8014ca:	55                   	push   %ebp
  8014cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	52                   	push   %edx
  8014da:	50                   	push   %eax
  8014db:	6a 1b                	push   $0x1b
  8014dd:	e8 1c fd ff ff       	call   8011fe <syscall>
  8014e2:	83 c4 18             	add    $0x18,%esp
}
  8014e5:	c9                   	leave  
  8014e6:	c3                   	ret    

008014e7 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014e7:	55                   	push   %ebp
  8014e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	52                   	push   %edx
  8014f7:	50                   	push   %eax
  8014f8:	6a 19                	push   $0x19
  8014fa:	e8 ff fc ff ff       	call   8011fe <syscall>
  8014ff:	83 c4 18             	add    $0x18,%esp
}
  801502:	90                   	nop
  801503:	c9                   	leave  
  801504:	c3                   	ret    

00801505 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801508:	8b 55 0c             	mov    0xc(%ebp),%edx
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	52                   	push   %edx
  801515:	50                   	push   %eax
  801516:	6a 1a                	push   $0x1a
  801518:	e8 e1 fc ff ff       	call   8011fe <syscall>
  80151d:	83 c4 18             	add    $0x18,%esp
}
  801520:	90                   	nop
  801521:	c9                   	leave  
  801522:	c3                   	ret    

00801523 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801523:	55                   	push   %ebp
  801524:	89 e5                	mov    %esp,%ebp
  801526:	83 ec 04             	sub    $0x4,%esp
  801529:	8b 45 10             	mov    0x10(%ebp),%eax
  80152c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80152f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801532:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801536:	8b 45 08             	mov    0x8(%ebp),%eax
  801539:	6a 00                	push   $0x0
  80153b:	51                   	push   %ecx
  80153c:	52                   	push   %edx
  80153d:	ff 75 0c             	pushl  0xc(%ebp)
  801540:	50                   	push   %eax
  801541:	6a 1c                	push   $0x1c
  801543:	e8 b6 fc ff ff       	call   8011fe <syscall>
  801548:	83 c4 18             	add    $0x18,%esp
}
  80154b:	c9                   	leave  
  80154c:	c3                   	ret    

0080154d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80154d:	55                   	push   %ebp
  80154e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801550:	8b 55 0c             	mov    0xc(%ebp),%edx
  801553:	8b 45 08             	mov    0x8(%ebp),%eax
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	52                   	push   %edx
  80155d:	50                   	push   %eax
  80155e:	6a 1d                	push   $0x1d
  801560:	e8 99 fc ff ff       	call   8011fe <syscall>
  801565:	83 c4 18             	add    $0x18,%esp
}
  801568:	c9                   	leave  
  801569:	c3                   	ret    

0080156a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80156a:	55                   	push   %ebp
  80156b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80156d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801570:	8b 55 0c             	mov    0xc(%ebp),%edx
  801573:	8b 45 08             	mov    0x8(%ebp),%eax
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	51                   	push   %ecx
  80157b:	52                   	push   %edx
  80157c:	50                   	push   %eax
  80157d:	6a 1e                	push   $0x1e
  80157f:	e8 7a fc ff ff       	call   8011fe <syscall>
  801584:	83 c4 18             	add    $0x18,%esp
}
  801587:	c9                   	leave  
  801588:	c3                   	ret    

00801589 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80158c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	52                   	push   %edx
  801599:	50                   	push   %eax
  80159a:	6a 1f                	push   $0x1f
  80159c:	e8 5d fc ff ff       	call   8011fe <syscall>
  8015a1:	83 c4 18             	add    $0x18,%esp
}
  8015a4:	c9                   	leave  
  8015a5:	c3                   	ret    

008015a6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 20                	push   $0x20
  8015b5:	e8 44 fc ff ff       	call   8011fe <syscall>
  8015ba:	83 c4 18             	add    $0x18,%esp
}
  8015bd:	c9                   	leave  
  8015be:	c3                   	ret    

008015bf <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8015bf:	55                   	push   %ebp
  8015c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	6a 00                	push   $0x0
  8015c7:	ff 75 14             	pushl  0x14(%ebp)
  8015ca:	ff 75 10             	pushl  0x10(%ebp)
  8015cd:	ff 75 0c             	pushl  0xc(%ebp)
  8015d0:	50                   	push   %eax
  8015d1:	6a 21                	push   $0x21
  8015d3:	e8 26 fc ff ff       	call   8011fe <syscall>
  8015d8:	83 c4 18             	add    $0x18,%esp
}
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8015e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	50                   	push   %eax
  8015ec:	6a 22                	push   $0x22
  8015ee:	e8 0b fc ff ff       	call   8011fe <syscall>
  8015f3:	83 c4 18             	add    $0x18,%esp
}
  8015f6:	90                   	nop
  8015f7:	c9                   	leave  
  8015f8:	c3                   	ret    

008015f9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8015f9:	55                   	push   %ebp
  8015fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	50                   	push   %eax
  801608:	6a 23                	push   $0x23
  80160a:	e8 ef fb ff ff       	call   8011fe <syscall>
  80160f:	83 c4 18             	add    $0x18,%esp
}
  801612:	90                   	nop
  801613:	c9                   	leave  
  801614:	c3                   	ret    

00801615 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801615:	55                   	push   %ebp
  801616:	89 e5                	mov    %esp,%ebp
  801618:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80161b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80161e:	8d 50 04             	lea    0x4(%eax),%edx
  801621:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	52                   	push   %edx
  80162b:	50                   	push   %eax
  80162c:	6a 24                	push   $0x24
  80162e:	e8 cb fb ff ff       	call   8011fe <syscall>
  801633:	83 c4 18             	add    $0x18,%esp
	return result;
  801636:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801639:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80163c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80163f:	89 01                	mov    %eax,(%ecx)
  801641:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801644:	8b 45 08             	mov    0x8(%ebp),%eax
  801647:	c9                   	leave  
  801648:	c2 04 00             	ret    $0x4

0080164b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80164b:	55                   	push   %ebp
  80164c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	ff 75 10             	pushl  0x10(%ebp)
  801655:	ff 75 0c             	pushl  0xc(%ebp)
  801658:	ff 75 08             	pushl  0x8(%ebp)
  80165b:	6a 13                	push   $0x13
  80165d:	e8 9c fb ff ff       	call   8011fe <syscall>
  801662:	83 c4 18             	add    $0x18,%esp
	return ;
  801665:	90                   	nop
}
  801666:	c9                   	leave  
  801667:	c3                   	ret    

00801668 <sys_rcr2>:
uint32 sys_rcr2()
{
  801668:	55                   	push   %ebp
  801669:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 25                	push   $0x25
  801677:	e8 82 fb ff ff       	call   8011fe <syscall>
  80167c:	83 c4 18             	add    $0x18,%esp
}
  80167f:	c9                   	leave  
  801680:	c3                   	ret    

00801681 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
  801684:	83 ec 04             	sub    $0x4,%esp
  801687:	8b 45 08             	mov    0x8(%ebp),%eax
  80168a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80168d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	50                   	push   %eax
  80169a:	6a 26                	push   $0x26
  80169c:	e8 5d fb ff ff       	call   8011fe <syscall>
  8016a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016a4:	90                   	nop
}
  8016a5:	c9                   	leave  
  8016a6:	c3                   	ret    

008016a7 <rsttst>:
void rsttst()
{
  8016a7:	55                   	push   %ebp
  8016a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 28                	push   $0x28
  8016b6:	e8 43 fb ff ff       	call   8011fe <syscall>
  8016bb:	83 c4 18             	add    $0x18,%esp
	return ;
  8016be:	90                   	nop
}
  8016bf:	c9                   	leave  
  8016c0:	c3                   	ret    

008016c1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8016c1:	55                   	push   %ebp
  8016c2:	89 e5                	mov    %esp,%ebp
  8016c4:	83 ec 04             	sub    $0x4,%esp
  8016c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ca:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016cd:	8b 55 18             	mov    0x18(%ebp),%edx
  8016d0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016d4:	52                   	push   %edx
  8016d5:	50                   	push   %eax
  8016d6:	ff 75 10             	pushl  0x10(%ebp)
  8016d9:	ff 75 0c             	pushl  0xc(%ebp)
  8016dc:	ff 75 08             	pushl  0x8(%ebp)
  8016df:	6a 27                	push   $0x27
  8016e1:	e8 18 fb ff ff       	call   8011fe <syscall>
  8016e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8016e9:	90                   	nop
}
  8016ea:	c9                   	leave  
  8016eb:	c3                   	ret    

008016ec <chktst>:
void chktst(uint32 n)
{
  8016ec:	55                   	push   %ebp
  8016ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	ff 75 08             	pushl  0x8(%ebp)
  8016fa:	6a 29                	push   $0x29
  8016fc:	e8 fd fa ff ff       	call   8011fe <syscall>
  801701:	83 c4 18             	add    $0x18,%esp
	return ;
  801704:	90                   	nop
}
  801705:	c9                   	leave  
  801706:	c3                   	ret    

00801707 <inctst>:

void inctst()
{
  801707:	55                   	push   %ebp
  801708:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 2a                	push   $0x2a
  801716:	e8 e3 fa ff ff       	call   8011fe <syscall>
  80171b:	83 c4 18             	add    $0x18,%esp
	return ;
  80171e:	90                   	nop
}
  80171f:	c9                   	leave  
  801720:	c3                   	ret    

00801721 <gettst>:
uint32 gettst()
{
  801721:	55                   	push   %ebp
  801722:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 2b                	push   $0x2b
  801730:	e8 c9 fa ff ff       	call   8011fe <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
}
  801738:	c9                   	leave  
  801739:	c3                   	ret    

0080173a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80173a:	55                   	push   %ebp
  80173b:	89 e5                	mov    %esp,%ebp
  80173d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 2c                	push   $0x2c
  80174c:	e8 ad fa ff ff       	call   8011fe <syscall>
  801751:	83 c4 18             	add    $0x18,%esp
  801754:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801757:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80175b:	75 07                	jne    801764 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80175d:	b8 01 00 00 00       	mov    $0x1,%eax
  801762:	eb 05                	jmp    801769 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801764:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801769:	c9                   	leave  
  80176a:	c3                   	ret    

0080176b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80176b:	55                   	push   %ebp
  80176c:	89 e5                	mov    %esp,%ebp
  80176e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 2c                	push   $0x2c
  80177d:	e8 7c fa ff ff       	call   8011fe <syscall>
  801782:	83 c4 18             	add    $0x18,%esp
  801785:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801788:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80178c:	75 07                	jne    801795 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80178e:	b8 01 00 00 00       	mov    $0x1,%eax
  801793:	eb 05                	jmp    80179a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801795:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80179a:	c9                   	leave  
  80179b:	c3                   	ret    

0080179c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80179c:	55                   	push   %ebp
  80179d:	89 e5                	mov    %esp,%ebp
  80179f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 2c                	push   $0x2c
  8017ae:	e8 4b fa ff ff       	call   8011fe <syscall>
  8017b3:	83 c4 18             	add    $0x18,%esp
  8017b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017b9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017bd:	75 07                	jne    8017c6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8017bf:	b8 01 00 00 00       	mov    $0x1,%eax
  8017c4:	eb 05                	jmp    8017cb <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8017c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017cb:	c9                   	leave  
  8017cc:	c3                   	ret    

008017cd <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8017cd:	55                   	push   %ebp
  8017ce:	89 e5                	mov    %esp,%ebp
  8017d0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 2c                	push   $0x2c
  8017df:	e8 1a fa ff ff       	call   8011fe <syscall>
  8017e4:	83 c4 18             	add    $0x18,%esp
  8017e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8017ea:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8017ee:	75 07                	jne    8017f7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8017f0:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f5:	eb 05                	jmp    8017fc <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8017f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017fc:	c9                   	leave  
  8017fd:	c3                   	ret    

008017fe <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8017fe:	55                   	push   %ebp
  8017ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	ff 75 08             	pushl  0x8(%ebp)
  80180c:	6a 2d                	push   $0x2d
  80180e:	e8 eb f9 ff ff       	call   8011fe <syscall>
  801813:	83 c4 18             	add    $0x18,%esp
	return ;
  801816:	90                   	nop
}
  801817:	c9                   	leave  
  801818:	c3                   	ret    

00801819 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801819:	55                   	push   %ebp
  80181a:	89 e5                	mov    %esp,%ebp
  80181c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80181d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801820:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801823:	8b 55 0c             	mov    0xc(%ebp),%edx
  801826:	8b 45 08             	mov    0x8(%ebp),%eax
  801829:	6a 00                	push   $0x0
  80182b:	53                   	push   %ebx
  80182c:	51                   	push   %ecx
  80182d:	52                   	push   %edx
  80182e:	50                   	push   %eax
  80182f:	6a 2e                	push   $0x2e
  801831:	e8 c8 f9 ff ff       	call   8011fe <syscall>
  801836:	83 c4 18             	add    $0x18,%esp
}
  801839:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801841:	8b 55 0c             	mov    0xc(%ebp),%edx
  801844:	8b 45 08             	mov    0x8(%ebp),%eax
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	52                   	push   %edx
  80184e:	50                   	push   %eax
  80184f:	6a 2f                	push   $0x2f
  801851:	e8 a8 f9 ff ff       	call   8011fe <syscall>
  801856:	83 c4 18             	add    $0x18,%esp
}
  801859:	c9                   	leave  
  80185a:	c3                   	ret    
  80185b:	90                   	nop

0080185c <__udivdi3>:
  80185c:	55                   	push   %ebp
  80185d:	57                   	push   %edi
  80185e:	56                   	push   %esi
  80185f:	53                   	push   %ebx
  801860:	83 ec 1c             	sub    $0x1c,%esp
  801863:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801867:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80186b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80186f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801873:	89 ca                	mov    %ecx,%edx
  801875:	89 f8                	mov    %edi,%eax
  801877:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80187b:	85 f6                	test   %esi,%esi
  80187d:	75 2d                	jne    8018ac <__udivdi3+0x50>
  80187f:	39 cf                	cmp    %ecx,%edi
  801881:	77 65                	ja     8018e8 <__udivdi3+0x8c>
  801883:	89 fd                	mov    %edi,%ebp
  801885:	85 ff                	test   %edi,%edi
  801887:	75 0b                	jne    801894 <__udivdi3+0x38>
  801889:	b8 01 00 00 00       	mov    $0x1,%eax
  80188e:	31 d2                	xor    %edx,%edx
  801890:	f7 f7                	div    %edi
  801892:	89 c5                	mov    %eax,%ebp
  801894:	31 d2                	xor    %edx,%edx
  801896:	89 c8                	mov    %ecx,%eax
  801898:	f7 f5                	div    %ebp
  80189a:	89 c1                	mov    %eax,%ecx
  80189c:	89 d8                	mov    %ebx,%eax
  80189e:	f7 f5                	div    %ebp
  8018a0:	89 cf                	mov    %ecx,%edi
  8018a2:	89 fa                	mov    %edi,%edx
  8018a4:	83 c4 1c             	add    $0x1c,%esp
  8018a7:	5b                   	pop    %ebx
  8018a8:	5e                   	pop    %esi
  8018a9:	5f                   	pop    %edi
  8018aa:	5d                   	pop    %ebp
  8018ab:	c3                   	ret    
  8018ac:	39 ce                	cmp    %ecx,%esi
  8018ae:	77 28                	ja     8018d8 <__udivdi3+0x7c>
  8018b0:	0f bd fe             	bsr    %esi,%edi
  8018b3:	83 f7 1f             	xor    $0x1f,%edi
  8018b6:	75 40                	jne    8018f8 <__udivdi3+0x9c>
  8018b8:	39 ce                	cmp    %ecx,%esi
  8018ba:	72 0a                	jb     8018c6 <__udivdi3+0x6a>
  8018bc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8018c0:	0f 87 9e 00 00 00    	ja     801964 <__udivdi3+0x108>
  8018c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8018cb:	89 fa                	mov    %edi,%edx
  8018cd:	83 c4 1c             	add    $0x1c,%esp
  8018d0:	5b                   	pop    %ebx
  8018d1:	5e                   	pop    %esi
  8018d2:	5f                   	pop    %edi
  8018d3:	5d                   	pop    %ebp
  8018d4:	c3                   	ret    
  8018d5:	8d 76 00             	lea    0x0(%esi),%esi
  8018d8:	31 ff                	xor    %edi,%edi
  8018da:	31 c0                	xor    %eax,%eax
  8018dc:	89 fa                	mov    %edi,%edx
  8018de:	83 c4 1c             	add    $0x1c,%esp
  8018e1:	5b                   	pop    %ebx
  8018e2:	5e                   	pop    %esi
  8018e3:	5f                   	pop    %edi
  8018e4:	5d                   	pop    %ebp
  8018e5:	c3                   	ret    
  8018e6:	66 90                	xchg   %ax,%ax
  8018e8:	89 d8                	mov    %ebx,%eax
  8018ea:	f7 f7                	div    %edi
  8018ec:	31 ff                	xor    %edi,%edi
  8018ee:	89 fa                	mov    %edi,%edx
  8018f0:	83 c4 1c             	add    $0x1c,%esp
  8018f3:	5b                   	pop    %ebx
  8018f4:	5e                   	pop    %esi
  8018f5:	5f                   	pop    %edi
  8018f6:	5d                   	pop    %ebp
  8018f7:	c3                   	ret    
  8018f8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8018fd:	89 eb                	mov    %ebp,%ebx
  8018ff:	29 fb                	sub    %edi,%ebx
  801901:	89 f9                	mov    %edi,%ecx
  801903:	d3 e6                	shl    %cl,%esi
  801905:	89 c5                	mov    %eax,%ebp
  801907:	88 d9                	mov    %bl,%cl
  801909:	d3 ed                	shr    %cl,%ebp
  80190b:	89 e9                	mov    %ebp,%ecx
  80190d:	09 f1                	or     %esi,%ecx
  80190f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801913:	89 f9                	mov    %edi,%ecx
  801915:	d3 e0                	shl    %cl,%eax
  801917:	89 c5                	mov    %eax,%ebp
  801919:	89 d6                	mov    %edx,%esi
  80191b:	88 d9                	mov    %bl,%cl
  80191d:	d3 ee                	shr    %cl,%esi
  80191f:	89 f9                	mov    %edi,%ecx
  801921:	d3 e2                	shl    %cl,%edx
  801923:	8b 44 24 08          	mov    0x8(%esp),%eax
  801927:	88 d9                	mov    %bl,%cl
  801929:	d3 e8                	shr    %cl,%eax
  80192b:	09 c2                	or     %eax,%edx
  80192d:	89 d0                	mov    %edx,%eax
  80192f:	89 f2                	mov    %esi,%edx
  801931:	f7 74 24 0c          	divl   0xc(%esp)
  801935:	89 d6                	mov    %edx,%esi
  801937:	89 c3                	mov    %eax,%ebx
  801939:	f7 e5                	mul    %ebp
  80193b:	39 d6                	cmp    %edx,%esi
  80193d:	72 19                	jb     801958 <__udivdi3+0xfc>
  80193f:	74 0b                	je     80194c <__udivdi3+0xf0>
  801941:	89 d8                	mov    %ebx,%eax
  801943:	31 ff                	xor    %edi,%edi
  801945:	e9 58 ff ff ff       	jmp    8018a2 <__udivdi3+0x46>
  80194a:	66 90                	xchg   %ax,%ax
  80194c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801950:	89 f9                	mov    %edi,%ecx
  801952:	d3 e2                	shl    %cl,%edx
  801954:	39 c2                	cmp    %eax,%edx
  801956:	73 e9                	jae    801941 <__udivdi3+0xe5>
  801958:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80195b:	31 ff                	xor    %edi,%edi
  80195d:	e9 40 ff ff ff       	jmp    8018a2 <__udivdi3+0x46>
  801962:	66 90                	xchg   %ax,%ax
  801964:	31 c0                	xor    %eax,%eax
  801966:	e9 37 ff ff ff       	jmp    8018a2 <__udivdi3+0x46>
  80196b:	90                   	nop

0080196c <__umoddi3>:
  80196c:	55                   	push   %ebp
  80196d:	57                   	push   %edi
  80196e:	56                   	push   %esi
  80196f:	53                   	push   %ebx
  801970:	83 ec 1c             	sub    $0x1c,%esp
  801973:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801977:	8b 74 24 34          	mov    0x34(%esp),%esi
  80197b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80197f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801983:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801987:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80198b:	89 f3                	mov    %esi,%ebx
  80198d:	89 fa                	mov    %edi,%edx
  80198f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801993:	89 34 24             	mov    %esi,(%esp)
  801996:	85 c0                	test   %eax,%eax
  801998:	75 1a                	jne    8019b4 <__umoddi3+0x48>
  80199a:	39 f7                	cmp    %esi,%edi
  80199c:	0f 86 a2 00 00 00    	jbe    801a44 <__umoddi3+0xd8>
  8019a2:	89 c8                	mov    %ecx,%eax
  8019a4:	89 f2                	mov    %esi,%edx
  8019a6:	f7 f7                	div    %edi
  8019a8:	89 d0                	mov    %edx,%eax
  8019aa:	31 d2                	xor    %edx,%edx
  8019ac:	83 c4 1c             	add    $0x1c,%esp
  8019af:	5b                   	pop    %ebx
  8019b0:	5e                   	pop    %esi
  8019b1:	5f                   	pop    %edi
  8019b2:	5d                   	pop    %ebp
  8019b3:	c3                   	ret    
  8019b4:	39 f0                	cmp    %esi,%eax
  8019b6:	0f 87 ac 00 00 00    	ja     801a68 <__umoddi3+0xfc>
  8019bc:	0f bd e8             	bsr    %eax,%ebp
  8019bf:	83 f5 1f             	xor    $0x1f,%ebp
  8019c2:	0f 84 ac 00 00 00    	je     801a74 <__umoddi3+0x108>
  8019c8:	bf 20 00 00 00       	mov    $0x20,%edi
  8019cd:	29 ef                	sub    %ebp,%edi
  8019cf:	89 fe                	mov    %edi,%esi
  8019d1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8019d5:	89 e9                	mov    %ebp,%ecx
  8019d7:	d3 e0                	shl    %cl,%eax
  8019d9:	89 d7                	mov    %edx,%edi
  8019db:	89 f1                	mov    %esi,%ecx
  8019dd:	d3 ef                	shr    %cl,%edi
  8019df:	09 c7                	or     %eax,%edi
  8019e1:	89 e9                	mov    %ebp,%ecx
  8019e3:	d3 e2                	shl    %cl,%edx
  8019e5:	89 14 24             	mov    %edx,(%esp)
  8019e8:	89 d8                	mov    %ebx,%eax
  8019ea:	d3 e0                	shl    %cl,%eax
  8019ec:	89 c2                	mov    %eax,%edx
  8019ee:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019f2:	d3 e0                	shl    %cl,%eax
  8019f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8019f8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019fc:	89 f1                	mov    %esi,%ecx
  8019fe:	d3 e8                	shr    %cl,%eax
  801a00:	09 d0                	or     %edx,%eax
  801a02:	d3 eb                	shr    %cl,%ebx
  801a04:	89 da                	mov    %ebx,%edx
  801a06:	f7 f7                	div    %edi
  801a08:	89 d3                	mov    %edx,%ebx
  801a0a:	f7 24 24             	mull   (%esp)
  801a0d:	89 c6                	mov    %eax,%esi
  801a0f:	89 d1                	mov    %edx,%ecx
  801a11:	39 d3                	cmp    %edx,%ebx
  801a13:	0f 82 87 00 00 00    	jb     801aa0 <__umoddi3+0x134>
  801a19:	0f 84 91 00 00 00    	je     801ab0 <__umoddi3+0x144>
  801a1f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801a23:	29 f2                	sub    %esi,%edx
  801a25:	19 cb                	sbb    %ecx,%ebx
  801a27:	89 d8                	mov    %ebx,%eax
  801a29:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801a2d:	d3 e0                	shl    %cl,%eax
  801a2f:	89 e9                	mov    %ebp,%ecx
  801a31:	d3 ea                	shr    %cl,%edx
  801a33:	09 d0                	or     %edx,%eax
  801a35:	89 e9                	mov    %ebp,%ecx
  801a37:	d3 eb                	shr    %cl,%ebx
  801a39:	89 da                	mov    %ebx,%edx
  801a3b:	83 c4 1c             	add    $0x1c,%esp
  801a3e:	5b                   	pop    %ebx
  801a3f:	5e                   	pop    %esi
  801a40:	5f                   	pop    %edi
  801a41:	5d                   	pop    %ebp
  801a42:	c3                   	ret    
  801a43:	90                   	nop
  801a44:	89 fd                	mov    %edi,%ebp
  801a46:	85 ff                	test   %edi,%edi
  801a48:	75 0b                	jne    801a55 <__umoddi3+0xe9>
  801a4a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a4f:	31 d2                	xor    %edx,%edx
  801a51:	f7 f7                	div    %edi
  801a53:	89 c5                	mov    %eax,%ebp
  801a55:	89 f0                	mov    %esi,%eax
  801a57:	31 d2                	xor    %edx,%edx
  801a59:	f7 f5                	div    %ebp
  801a5b:	89 c8                	mov    %ecx,%eax
  801a5d:	f7 f5                	div    %ebp
  801a5f:	89 d0                	mov    %edx,%eax
  801a61:	e9 44 ff ff ff       	jmp    8019aa <__umoddi3+0x3e>
  801a66:	66 90                	xchg   %ax,%ax
  801a68:	89 c8                	mov    %ecx,%eax
  801a6a:	89 f2                	mov    %esi,%edx
  801a6c:	83 c4 1c             	add    $0x1c,%esp
  801a6f:	5b                   	pop    %ebx
  801a70:	5e                   	pop    %esi
  801a71:	5f                   	pop    %edi
  801a72:	5d                   	pop    %ebp
  801a73:	c3                   	ret    
  801a74:	3b 04 24             	cmp    (%esp),%eax
  801a77:	72 06                	jb     801a7f <__umoddi3+0x113>
  801a79:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801a7d:	77 0f                	ja     801a8e <__umoddi3+0x122>
  801a7f:	89 f2                	mov    %esi,%edx
  801a81:	29 f9                	sub    %edi,%ecx
  801a83:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801a87:	89 14 24             	mov    %edx,(%esp)
  801a8a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a8e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801a92:	8b 14 24             	mov    (%esp),%edx
  801a95:	83 c4 1c             	add    $0x1c,%esp
  801a98:	5b                   	pop    %ebx
  801a99:	5e                   	pop    %esi
  801a9a:	5f                   	pop    %edi
  801a9b:	5d                   	pop    %ebp
  801a9c:	c3                   	ret    
  801a9d:	8d 76 00             	lea    0x0(%esi),%esi
  801aa0:	2b 04 24             	sub    (%esp),%eax
  801aa3:	19 fa                	sbb    %edi,%edx
  801aa5:	89 d1                	mov    %edx,%ecx
  801aa7:	89 c6                	mov    %eax,%esi
  801aa9:	e9 71 ff ff ff       	jmp    801a1f <__umoddi3+0xb3>
  801aae:	66 90                	xchg   %ax,%ax
  801ab0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ab4:	72 ea                	jb     801aa0 <__umoddi3+0x134>
  801ab6:	89 d9                	mov    %ebx,%ecx
  801ab8:	e9 62 ff ff ff       	jmp    801a1f <__umoddi3+0xb3>

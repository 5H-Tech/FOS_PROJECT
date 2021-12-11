
obj/user/ef_tst_semaphore_1slave:     file format elf32-i386


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
  800031:	e8 e0 00 00 00       	call   800116 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Slave program: enter critical section, print it's ID, exit and signal the master program
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int32 parentenvID = sys_getparentenvid();
  80003e:	e8 fe 12 00 00       	call   801341 <sys_getparentenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int id = sys_getenvindex();
  800046:	e8 dd 12 00 00       	call   801328 <sys_getenvindex>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cprintf("%d: before the critical section\n", id);
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	ff 75 f0             	pushl  -0x10(%ebp)
  800054:	68 00 1c 80 00       	push   $0x801c00
  800059:	e8 9f 04 00 00       	call   8004fd <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp

	sys_waitSemaphore(parentenvID, "cs1") ;
  800061:	83 ec 08             	sub    $0x8,%esp
  800064:	68 21 1c 80 00       	push   $0x801c21
  800069:	ff 75 f4             	pushl  -0xc(%ebp)
  80006c:	e8 ff 14 00 00       	call   801570 <sys_waitSemaphore>
  800071:	83 c4 10             	add    $0x10,%esp
		cprintf("%d: inside the critical section\n", id) ;
  800074:	83 ec 08             	sub    $0x8,%esp
  800077:	ff 75 f0             	pushl  -0x10(%ebp)
  80007a:	68 28 1c 80 00       	push   $0x801c28
  80007f:	e8 79 04 00 00       	call   8004fd <cprintf>
  800084:	83 c4 10             	add    $0x10,%esp
		cprintf("my ID is %d\n", id);
  800087:	83 ec 08             	sub    $0x8,%esp
  80008a:	ff 75 f0             	pushl  -0x10(%ebp)
  80008d:	68 49 1c 80 00       	push   $0x801c49
  800092:	e8 66 04 00 00       	call   8004fd <cprintf>
  800097:	83 c4 10             	add    $0x10,%esp
		int sem1val = sys_getSemaphoreValue(parentenvID, "cs1");
  80009a:	83 ec 08             	sub    $0x8,%esp
  80009d:	68 21 1c 80 00       	push   $0x801c21
  8000a2:	ff 75 f4             	pushl  -0xc(%ebp)
  8000a5:	e8 a9 14 00 00       	call   801553 <sys_getSemaphoreValue>
  8000aa:	83 c4 10             	add    $0x10,%esp
  8000ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (sem1val > 0)
  8000b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8000b4:	7e 14                	jle    8000ca <_main+0x92>
			panic("Error: more than 1 process inside the CS... please review your semaphore code again...");
  8000b6:	83 ec 04             	sub    $0x4,%esp
  8000b9:	68 58 1c 80 00       	push   $0x801c58
  8000be:	6a 11                	push   $0x11
  8000c0:	68 b0 1c 80 00       	push   $0x801cb0
  8000c5:	e8 91 01 00 00       	call   80025b <_panic>
		env_sleep(1000) ;
  8000ca:	83 ec 0c             	sub    $0xc,%esp
  8000cd:	68 e8 03 00 00       	push   $0x3e8
  8000d2:	e8 0d 18 00 00       	call   8018e4 <env_sleep>
  8000d7:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "cs1") ;
  8000da:	83 ec 08             	sub    $0x8,%esp
  8000dd:	68 21 1c 80 00       	push   $0x801c21
  8000e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8000e5:	e8 a4 14 00 00       	call   80158e <sys_signalSemaphore>
  8000ea:	83 c4 10             	add    $0x10,%esp

	cprintf("%d: after the critical section\n", id);
  8000ed:	83 ec 08             	sub    $0x8,%esp
  8000f0:	ff 75 f0             	pushl  -0x10(%ebp)
  8000f3:	68 d0 1c 80 00       	push   $0x801cd0
  8000f8:	e8 00 04 00 00       	call   8004fd <cprintf>
  8000fd:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "depend1") ;
  800100:	83 ec 08             	sub    $0x8,%esp
  800103:	68 f0 1c 80 00       	push   $0x801cf0
  800108:	ff 75 f4             	pushl  -0xc(%ebp)
  80010b:	e8 7e 14 00 00       	call   80158e <sys_signalSemaphore>
  800110:	83 c4 10             	add    $0x10,%esp
	return;
  800113:	90                   	nop
}
  800114:	c9                   	leave  
  800115:	c3                   	ret    

00800116 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800116:	55                   	push   %ebp
  800117:	89 e5                	mov    %esp,%ebp
  800119:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80011c:	e8 07 12 00 00       	call   801328 <sys_getenvindex>
  800121:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800124:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800127:	89 d0                	mov    %edx,%eax
  800129:	c1 e0 03             	shl    $0x3,%eax
  80012c:	01 d0                	add    %edx,%eax
  80012e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800135:	01 c8                	add    %ecx,%eax
  800137:	01 c0                	add    %eax,%eax
  800139:	01 d0                	add    %edx,%eax
  80013b:	01 c0                	add    %eax,%eax
  80013d:	01 d0                	add    %edx,%eax
  80013f:	89 c2                	mov    %eax,%edx
  800141:	c1 e2 05             	shl    $0x5,%edx
  800144:	29 c2                	sub    %eax,%edx
  800146:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80014d:	89 c2                	mov    %eax,%edx
  80014f:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800155:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80015a:	a1 20 30 80 00       	mov    0x803020,%eax
  80015f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800165:	84 c0                	test   %al,%al
  800167:	74 0f                	je     800178 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800169:	a1 20 30 80 00       	mov    0x803020,%eax
  80016e:	05 40 3c 01 00       	add    $0x13c40,%eax
  800173:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800178:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80017c:	7e 0a                	jle    800188 <libmain+0x72>
		binaryname = argv[0];
  80017e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800181:	8b 00                	mov    (%eax),%eax
  800183:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800188:	83 ec 08             	sub    $0x8,%esp
  80018b:	ff 75 0c             	pushl  0xc(%ebp)
  80018e:	ff 75 08             	pushl  0x8(%ebp)
  800191:	e8 a2 fe ff ff       	call   800038 <_main>
  800196:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800199:	e8 25 13 00 00       	call   8014c3 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80019e:	83 ec 0c             	sub    $0xc,%esp
  8001a1:	68 10 1d 80 00       	push   $0x801d10
  8001a6:	e8 52 03 00 00       	call   8004fd <cprintf>
  8001ab:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001ae:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b3:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001b9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001be:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	52                   	push   %edx
  8001c8:	50                   	push   %eax
  8001c9:	68 38 1d 80 00       	push   $0x801d38
  8001ce:	e8 2a 03 00 00       	call   8004fd <cprintf>
  8001d3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8001d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001db:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8001e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e6:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8001ec:	83 ec 04             	sub    $0x4,%esp
  8001ef:	52                   	push   %edx
  8001f0:	50                   	push   %eax
  8001f1:	68 60 1d 80 00       	push   $0x801d60
  8001f6:	e8 02 03 00 00       	call   8004fd <cprintf>
  8001fb:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800203:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800209:	83 ec 08             	sub    $0x8,%esp
  80020c:	50                   	push   %eax
  80020d:	68 a1 1d 80 00       	push   $0x801da1
  800212:	e8 e6 02 00 00       	call   8004fd <cprintf>
  800217:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80021a:	83 ec 0c             	sub    $0xc,%esp
  80021d:	68 10 1d 80 00       	push   $0x801d10
  800222:	e8 d6 02 00 00       	call   8004fd <cprintf>
  800227:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80022a:	e8 ae 12 00 00       	call   8014dd <sys_enable_interrupt>

	// exit gracefully
	exit();
  80022f:	e8 19 00 00 00       	call   80024d <exit>
}
  800234:	90                   	nop
  800235:	c9                   	leave  
  800236:	c3                   	ret    

00800237 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800237:	55                   	push   %ebp
  800238:	89 e5                	mov    %esp,%ebp
  80023a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80023d:	83 ec 0c             	sub    $0xc,%esp
  800240:	6a 00                	push   $0x0
  800242:	e8 ad 10 00 00       	call   8012f4 <sys_env_destroy>
  800247:	83 c4 10             	add    $0x10,%esp
}
  80024a:	90                   	nop
  80024b:	c9                   	leave  
  80024c:	c3                   	ret    

0080024d <exit>:

void
exit(void)
{
  80024d:	55                   	push   %ebp
  80024e:	89 e5                	mov    %esp,%ebp
  800250:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800253:	e8 02 11 00 00       	call   80135a <sys_env_exit>
}
  800258:	90                   	nop
  800259:	c9                   	leave  
  80025a:	c3                   	ret    

0080025b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80025b:	55                   	push   %ebp
  80025c:	89 e5                	mov    %esp,%ebp
  80025e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800261:	8d 45 10             	lea    0x10(%ebp),%eax
  800264:	83 c0 04             	add    $0x4,%eax
  800267:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80026a:	a1 18 31 80 00       	mov    0x803118,%eax
  80026f:	85 c0                	test   %eax,%eax
  800271:	74 16                	je     800289 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800273:	a1 18 31 80 00       	mov    0x803118,%eax
  800278:	83 ec 08             	sub    $0x8,%esp
  80027b:	50                   	push   %eax
  80027c:	68 b8 1d 80 00       	push   $0x801db8
  800281:	e8 77 02 00 00       	call   8004fd <cprintf>
  800286:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800289:	a1 00 30 80 00       	mov    0x803000,%eax
  80028e:	ff 75 0c             	pushl  0xc(%ebp)
  800291:	ff 75 08             	pushl  0x8(%ebp)
  800294:	50                   	push   %eax
  800295:	68 bd 1d 80 00       	push   $0x801dbd
  80029a:	e8 5e 02 00 00       	call   8004fd <cprintf>
  80029f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a5:	83 ec 08             	sub    $0x8,%esp
  8002a8:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ab:	50                   	push   %eax
  8002ac:	e8 e1 01 00 00       	call   800492 <vcprintf>
  8002b1:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002b4:	83 ec 08             	sub    $0x8,%esp
  8002b7:	6a 00                	push   $0x0
  8002b9:	68 d9 1d 80 00       	push   $0x801dd9
  8002be:	e8 cf 01 00 00       	call   800492 <vcprintf>
  8002c3:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002c6:	e8 82 ff ff ff       	call   80024d <exit>

	// should not return here
	while (1) ;
  8002cb:	eb fe                	jmp    8002cb <_panic+0x70>

008002cd <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002cd:	55                   	push   %ebp
  8002ce:	89 e5                	mov    %esp,%ebp
  8002d0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d8:	8b 50 74             	mov    0x74(%eax),%edx
  8002db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002de:	39 c2                	cmp    %eax,%edx
  8002e0:	74 14                	je     8002f6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002e2:	83 ec 04             	sub    $0x4,%esp
  8002e5:	68 dc 1d 80 00       	push   $0x801ddc
  8002ea:	6a 26                	push   $0x26
  8002ec:	68 28 1e 80 00       	push   $0x801e28
  8002f1:	e8 65 ff ff ff       	call   80025b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002fd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800304:	e9 b6 00 00 00       	jmp    8003bf <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800309:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80030c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800313:	8b 45 08             	mov    0x8(%ebp),%eax
  800316:	01 d0                	add    %edx,%eax
  800318:	8b 00                	mov    (%eax),%eax
  80031a:	85 c0                	test   %eax,%eax
  80031c:	75 08                	jne    800326 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80031e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800321:	e9 96 00 00 00       	jmp    8003bc <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800326:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80032d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800334:	eb 5d                	jmp    800393 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800336:	a1 20 30 80 00       	mov    0x803020,%eax
  80033b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800341:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800344:	c1 e2 04             	shl    $0x4,%edx
  800347:	01 d0                	add    %edx,%eax
  800349:	8a 40 04             	mov    0x4(%eax),%al
  80034c:	84 c0                	test   %al,%al
  80034e:	75 40                	jne    800390 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800350:	a1 20 30 80 00       	mov    0x803020,%eax
  800355:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80035b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80035e:	c1 e2 04             	shl    $0x4,%edx
  800361:	01 d0                	add    %edx,%eax
  800363:	8b 00                	mov    (%eax),%eax
  800365:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800368:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80036b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800370:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800372:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800375:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80037c:	8b 45 08             	mov    0x8(%ebp),%eax
  80037f:	01 c8                	add    %ecx,%eax
  800381:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800383:	39 c2                	cmp    %eax,%edx
  800385:	75 09                	jne    800390 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800387:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80038e:	eb 12                	jmp    8003a2 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800390:	ff 45 e8             	incl   -0x18(%ebp)
  800393:	a1 20 30 80 00       	mov    0x803020,%eax
  800398:	8b 50 74             	mov    0x74(%eax),%edx
  80039b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80039e:	39 c2                	cmp    %eax,%edx
  8003a0:	77 94                	ja     800336 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003a6:	75 14                	jne    8003bc <CheckWSWithoutLastIndex+0xef>
			panic(
  8003a8:	83 ec 04             	sub    $0x4,%esp
  8003ab:	68 34 1e 80 00       	push   $0x801e34
  8003b0:	6a 3a                	push   $0x3a
  8003b2:	68 28 1e 80 00       	push   $0x801e28
  8003b7:	e8 9f fe ff ff       	call   80025b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003bc:	ff 45 f0             	incl   -0x10(%ebp)
  8003bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003c5:	0f 8c 3e ff ff ff    	jl     800309 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003cb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003d2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003d9:	eb 20                	jmp    8003fb <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003db:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003e6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003e9:	c1 e2 04             	shl    $0x4,%edx
  8003ec:	01 d0                	add    %edx,%eax
  8003ee:	8a 40 04             	mov    0x4(%eax),%al
  8003f1:	3c 01                	cmp    $0x1,%al
  8003f3:	75 03                	jne    8003f8 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8003f5:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003f8:	ff 45 e0             	incl   -0x20(%ebp)
  8003fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800400:	8b 50 74             	mov    0x74(%eax),%edx
  800403:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800406:	39 c2                	cmp    %eax,%edx
  800408:	77 d1                	ja     8003db <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80040a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80040d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800410:	74 14                	je     800426 <CheckWSWithoutLastIndex+0x159>
		panic(
  800412:	83 ec 04             	sub    $0x4,%esp
  800415:	68 88 1e 80 00       	push   $0x801e88
  80041a:	6a 44                	push   $0x44
  80041c:	68 28 1e 80 00       	push   $0x801e28
  800421:	e8 35 fe ff ff       	call   80025b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800426:	90                   	nop
  800427:	c9                   	leave  
  800428:	c3                   	ret    

00800429 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800429:	55                   	push   %ebp
  80042a:	89 e5                	mov    %esp,%ebp
  80042c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80042f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800432:	8b 00                	mov    (%eax),%eax
  800434:	8d 48 01             	lea    0x1(%eax),%ecx
  800437:	8b 55 0c             	mov    0xc(%ebp),%edx
  80043a:	89 0a                	mov    %ecx,(%edx)
  80043c:	8b 55 08             	mov    0x8(%ebp),%edx
  80043f:	88 d1                	mov    %dl,%cl
  800441:	8b 55 0c             	mov    0xc(%ebp),%edx
  800444:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800448:	8b 45 0c             	mov    0xc(%ebp),%eax
  80044b:	8b 00                	mov    (%eax),%eax
  80044d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800452:	75 2c                	jne    800480 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800454:	a0 24 30 80 00       	mov    0x803024,%al
  800459:	0f b6 c0             	movzbl %al,%eax
  80045c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80045f:	8b 12                	mov    (%edx),%edx
  800461:	89 d1                	mov    %edx,%ecx
  800463:	8b 55 0c             	mov    0xc(%ebp),%edx
  800466:	83 c2 08             	add    $0x8,%edx
  800469:	83 ec 04             	sub    $0x4,%esp
  80046c:	50                   	push   %eax
  80046d:	51                   	push   %ecx
  80046e:	52                   	push   %edx
  80046f:	e8 3e 0e 00 00       	call   8012b2 <sys_cputs>
  800474:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800477:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800480:	8b 45 0c             	mov    0xc(%ebp),%eax
  800483:	8b 40 04             	mov    0x4(%eax),%eax
  800486:	8d 50 01             	lea    0x1(%eax),%edx
  800489:	8b 45 0c             	mov    0xc(%ebp),%eax
  80048c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80048f:	90                   	nop
  800490:	c9                   	leave  
  800491:	c3                   	ret    

00800492 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800492:	55                   	push   %ebp
  800493:	89 e5                	mov    %esp,%ebp
  800495:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80049b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004a2:	00 00 00 
	b.cnt = 0;
  8004a5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004ac:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004af:	ff 75 0c             	pushl  0xc(%ebp)
  8004b2:	ff 75 08             	pushl  0x8(%ebp)
  8004b5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004bb:	50                   	push   %eax
  8004bc:	68 29 04 80 00       	push   $0x800429
  8004c1:	e8 11 02 00 00       	call   8006d7 <vprintfmt>
  8004c6:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004c9:	a0 24 30 80 00       	mov    0x803024,%al
  8004ce:	0f b6 c0             	movzbl %al,%eax
  8004d1:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004d7:	83 ec 04             	sub    $0x4,%esp
  8004da:	50                   	push   %eax
  8004db:	52                   	push   %edx
  8004dc:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004e2:	83 c0 08             	add    $0x8,%eax
  8004e5:	50                   	push   %eax
  8004e6:	e8 c7 0d 00 00       	call   8012b2 <sys_cputs>
  8004eb:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004ee:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8004f5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004fb:	c9                   	leave  
  8004fc:	c3                   	ret    

008004fd <cprintf>:

int cprintf(const char *fmt, ...) {
  8004fd:	55                   	push   %ebp
  8004fe:	89 e5                	mov    %esp,%ebp
  800500:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800503:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80050a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80050d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800510:	8b 45 08             	mov    0x8(%ebp),%eax
  800513:	83 ec 08             	sub    $0x8,%esp
  800516:	ff 75 f4             	pushl  -0xc(%ebp)
  800519:	50                   	push   %eax
  80051a:	e8 73 ff ff ff       	call   800492 <vcprintf>
  80051f:	83 c4 10             	add    $0x10,%esp
  800522:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800525:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800528:	c9                   	leave  
  800529:	c3                   	ret    

0080052a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80052a:	55                   	push   %ebp
  80052b:	89 e5                	mov    %esp,%ebp
  80052d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800530:	e8 8e 0f 00 00       	call   8014c3 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800535:	8d 45 0c             	lea    0xc(%ebp),%eax
  800538:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80053b:	8b 45 08             	mov    0x8(%ebp),%eax
  80053e:	83 ec 08             	sub    $0x8,%esp
  800541:	ff 75 f4             	pushl  -0xc(%ebp)
  800544:	50                   	push   %eax
  800545:	e8 48 ff ff ff       	call   800492 <vcprintf>
  80054a:	83 c4 10             	add    $0x10,%esp
  80054d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800550:	e8 88 0f 00 00       	call   8014dd <sys_enable_interrupt>
	return cnt;
  800555:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800558:	c9                   	leave  
  800559:	c3                   	ret    

0080055a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80055a:	55                   	push   %ebp
  80055b:	89 e5                	mov    %esp,%ebp
  80055d:	53                   	push   %ebx
  80055e:	83 ec 14             	sub    $0x14,%esp
  800561:	8b 45 10             	mov    0x10(%ebp),%eax
  800564:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800567:	8b 45 14             	mov    0x14(%ebp),%eax
  80056a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80056d:	8b 45 18             	mov    0x18(%ebp),%eax
  800570:	ba 00 00 00 00       	mov    $0x0,%edx
  800575:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800578:	77 55                	ja     8005cf <printnum+0x75>
  80057a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80057d:	72 05                	jb     800584 <printnum+0x2a>
  80057f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800582:	77 4b                	ja     8005cf <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800584:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800587:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80058a:	8b 45 18             	mov    0x18(%ebp),%eax
  80058d:	ba 00 00 00 00       	mov    $0x0,%edx
  800592:	52                   	push   %edx
  800593:	50                   	push   %eax
  800594:	ff 75 f4             	pushl  -0xc(%ebp)
  800597:	ff 75 f0             	pushl  -0x10(%ebp)
  80059a:	e8 f9 13 00 00       	call   801998 <__udivdi3>
  80059f:	83 c4 10             	add    $0x10,%esp
  8005a2:	83 ec 04             	sub    $0x4,%esp
  8005a5:	ff 75 20             	pushl  0x20(%ebp)
  8005a8:	53                   	push   %ebx
  8005a9:	ff 75 18             	pushl  0x18(%ebp)
  8005ac:	52                   	push   %edx
  8005ad:	50                   	push   %eax
  8005ae:	ff 75 0c             	pushl  0xc(%ebp)
  8005b1:	ff 75 08             	pushl  0x8(%ebp)
  8005b4:	e8 a1 ff ff ff       	call   80055a <printnum>
  8005b9:	83 c4 20             	add    $0x20,%esp
  8005bc:	eb 1a                	jmp    8005d8 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005be:	83 ec 08             	sub    $0x8,%esp
  8005c1:	ff 75 0c             	pushl  0xc(%ebp)
  8005c4:	ff 75 20             	pushl  0x20(%ebp)
  8005c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ca:	ff d0                	call   *%eax
  8005cc:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005cf:	ff 4d 1c             	decl   0x1c(%ebp)
  8005d2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005d6:	7f e6                	jg     8005be <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005d8:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005db:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005e6:	53                   	push   %ebx
  8005e7:	51                   	push   %ecx
  8005e8:	52                   	push   %edx
  8005e9:	50                   	push   %eax
  8005ea:	e8 b9 14 00 00       	call   801aa8 <__umoddi3>
  8005ef:	83 c4 10             	add    $0x10,%esp
  8005f2:	05 f4 20 80 00       	add    $0x8020f4,%eax
  8005f7:	8a 00                	mov    (%eax),%al
  8005f9:	0f be c0             	movsbl %al,%eax
  8005fc:	83 ec 08             	sub    $0x8,%esp
  8005ff:	ff 75 0c             	pushl  0xc(%ebp)
  800602:	50                   	push   %eax
  800603:	8b 45 08             	mov    0x8(%ebp),%eax
  800606:	ff d0                	call   *%eax
  800608:	83 c4 10             	add    $0x10,%esp
}
  80060b:	90                   	nop
  80060c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80060f:	c9                   	leave  
  800610:	c3                   	ret    

00800611 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800611:	55                   	push   %ebp
  800612:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800614:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800618:	7e 1c                	jle    800636 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80061a:	8b 45 08             	mov    0x8(%ebp),%eax
  80061d:	8b 00                	mov    (%eax),%eax
  80061f:	8d 50 08             	lea    0x8(%eax),%edx
  800622:	8b 45 08             	mov    0x8(%ebp),%eax
  800625:	89 10                	mov    %edx,(%eax)
  800627:	8b 45 08             	mov    0x8(%ebp),%eax
  80062a:	8b 00                	mov    (%eax),%eax
  80062c:	83 e8 08             	sub    $0x8,%eax
  80062f:	8b 50 04             	mov    0x4(%eax),%edx
  800632:	8b 00                	mov    (%eax),%eax
  800634:	eb 40                	jmp    800676 <getuint+0x65>
	else if (lflag)
  800636:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80063a:	74 1e                	je     80065a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80063c:	8b 45 08             	mov    0x8(%ebp),%eax
  80063f:	8b 00                	mov    (%eax),%eax
  800641:	8d 50 04             	lea    0x4(%eax),%edx
  800644:	8b 45 08             	mov    0x8(%ebp),%eax
  800647:	89 10                	mov    %edx,(%eax)
  800649:	8b 45 08             	mov    0x8(%ebp),%eax
  80064c:	8b 00                	mov    (%eax),%eax
  80064e:	83 e8 04             	sub    $0x4,%eax
  800651:	8b 00                	mov    (%eax),%eax
  800653:	ba 00 00 00 00       	mov    $0x0,%edx
  800658:	eb 1c                	jmp    800676 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80065a:	8b 45 08             	mov    0x8(%ebp),%eax
  80065d:	8b 00                	mov    (%eax),%eax
  80065f:	8d 50 04             	lea    0x4(%eax),%edx
  800662:	8b 45 08             	mov    0x8(%ebp),%eax
  800665:	89 10                	mov    %edx,(%eax)
  800667:	8b 45 08             	mov    0x8(%ebp),%eax
  80066a:	8b 00                	mov    (%eax),%eax
  80066c:	83 e8 04             	sub    $0x4,%eax
  80066f:	8b 00                	mov    (%eax),%eax
  800671:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800676:	5d                   	pop    %ebp
  800677:	c3                   	ret    

00800678 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800678:	55                   	push   %ebp
  800679:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80067b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80067f:	7e 1c                	jle    80069d <getint+0x25>
		return va_arg(*ap, long long);
  800681:	8b 45 08             	mov    0x8(%ebp),%eax
  800684:	8b 00                	mov    (%eax),%eax
  800686:	8d 50 08             	lea    0x8(%eax),%edx
  800689:	8b 45 08             	mov    0x8(%ebp),%eax
  80068c:	89 10                	mov    %edx,(%eax)
  80068e:	8b 45 08             	mov    0x8(%ebp),%eax
  800691:	8b 00                	mov    (%eax),%eax
  800693:	83 e8 08             	sub    $0x8,%eax
  800696:	8b 50 04             	mov    0x4(%eax),%edx
  800699:	8b 00                	mov    (%eax),%eax
  80069b:	eb 38                	jmp    8006d5 <getint+0x5d>
	else if (lflag)
  80069d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006a1:	74 1a                	je     8006bd <getint+0x45>
		return va_arg(*ap, long);
  8006a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a6:	8b 00                	mov    (%eax),%eax
  8006a8:	8d 50 04             	lea    0x4(%eax),%edx
  8006ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ae:	89 10                	mov    %edx,(%eax)
  8006b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b3:	8b 00                	mov    (%eax),%eax
  8006b5:	83 e8 04             	sub    $0x4,%eax
  8006b8:	8b 00                	mov    (%eax),%eax
  8006ba:	99                   	cltd   
  8006bb:	eb 18                	jmp    8006d5 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c0:	8b 00                	mov    (%eax),%eax
  8006c2:	8d 50 04             	lea    0x4(%eax),%edx
  8006c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c8:	89 10                	mov    %edx,(%eax)
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8b 00                	mov    (%eax),%eax
  8006cf:	83 e8 04             	sub    $0x4,%eax
  8006d2:	8b 00                	mov    (%eax),%eax
  8006d4:	99                   	cltd   
}
  8006d5:	5d                   	pop    %ebp
  8006d6:	c3                   	ret    

008006d7 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006d7:	55                   	push   %ebp
  8006d8:	89 e5                	mov    %esp,%ebp
  8006da:	56                   	push   %esi
  8006db:	53                   	push   %ebx
  8006dc:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006df:	eb 17                	jmp    8006f8 <vprintfmt+0x21>
			if (ch == '\0')
  8006e1:	85 db                	test   %ebx,%ebx
  8006e3:	0f 84 af 03 00 00    	je     800a98 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006e9:	83 ec 08             	sub    $0x8,%esp
  8006ec:	ff 75 0c             	pushl  0xc(%ebp)
  8006ef:	53                   	push   %ebx
  8006f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f3:	ff d0                	call   *%eax
  8006f5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8006fb:	8d 50 01             	lea    0x1(%eax),%edx
  8006fe:	89 55 10             	mov    %edx,0x10(%ebp)
  800701:	8a 00                	mov    (%eax),%al
  800703:	0f b6 d8             	movzbl %al,%ebx
  800706:	83 fb 25             	cmp    $0x25,%ebx
  800709:	75 d6                	jne    8006e1 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80070b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80070f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800716:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80071d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800724:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80072b:	8b 45 10             	mov    0x10(%ebp),%eax
  80072e:	8d 50 01             	lea    0x1(%eax),%edx
  800731:	89 55 10             	mov    %edx,0x10(%ebp)
  800734:	8a 00                	mov    (%eax),%al
  800736:	0f b6 d8             	movzbl %al,%ebx
  800739:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80073c:	83 f8 55             	cmp    $0x55,%eax
  80073f:	0f 87 2b 03 00 00    	ja     800a70 <vprintfmt+0x399>
  800745:	8b 04 85 18 21 80 00 	mov    0x802118(,%eax,4),%eax
  80074c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80074e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800752:	eb d7                	jmp    80072b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800754:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800758:	eb d1                	jmp    80072b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80075a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800761:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800764:	89 d0                	mov    %edx,%eax
  800766:	c1 e0 02             	shl    $0x2,%eax
  800769:	01 d0                	add    %edx,%eax
  80076b:	01 c0                	add    %eax,%eax
  80076d:	01 d8                	add    %ebx,%eax
  80076f:	83 e8 30             	sub    $0x30,%eax
  800772:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800775:	8b 45 10             	mov    0x10(%ebp),%eax
  800778:	8a 00                	mov    (%eax),%al
  80077a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80077d:	83 fb 2f             	cmp    $0x2f,%ebx
  800780:	7e 3e                	jle    8007c0 <vprintfmt+0xe9>
  800782:	83 fb 39             	cmp    $0x39,%ebx
  800785:	7f 39                	jg     8007c0 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800787:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80078a:	eb d5                	jmp    800761 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80078c:	8b 45 14             	mov    0x14(%ebp),%eax
  80078f:	83 c0 04             	add    $0x4,%eax
  800792:	89 45 14             	mov    %eax,0x14(%ebp)
  800795:	8b 45 14             	mov    0x14(%ebp),%eax
  800798:	83 e8 04             	sub    $0x4,%eax
  80079b:	8b 00                	mov    (%eax),%eax
  80079d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007a0:	eb 1f                	jmp    8007c1 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007a2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007a6:	79 83                	jns    80072b <vprintfmt+0x54>
				width = 0;
  8007a8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007af:	e9 77 ff ff ff       	jmp    80072b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007b4:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007bb:	e9 6b ff ff ff       	jmp    80072b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007c0:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007c1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007c5:	0f 89 60 ff ff ff    	jns    80072b <vprintfmt+0x54>
				width = precision, precision = -1;
  8007cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007d1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007d8:	e9 4e ff ff ff       	jmp    80072b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007dd:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007e0:	e9 46 ff ff ff       	jmp    80072b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e8:	83 c0 04             	add    $0x4,%eax
  8007eb:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f1:	83 e8 04             	sub    $0x4,%eax
  8007f4:	8b 00                	mov    (%eax),%eax
  8007f6:	83 ec 08             	sub    $0x8,%esp
  8007f9:	ff 75 0c             	pushl  0xc(%ebp)
  8007fc:	50                   	push   %eax
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	ff d0                	call   *%eax
  800802:	83 c4 10             	add    $0x10,%esp
			break;
  800805:	e9 89 02 00 00       	jmp    800a93 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80080a:	8b 45 14             	mov    0x14(%ebp),%eax
  80080d:	83 c0 04             	add    $0x4,%eax
  800810:	89 45 14             	mov    %eax,0x14(%ebp)
  800813:	8b 45 14             	mov    0x14(%ebp),%eax
  800816:	83 e8 04             	sub    $0x4,%eax
  800819:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80081b:	85 db                	test   %ebx,%ebx
  80081d:	79 02                	jns    800821 <vprintfmt+0x14a>
				err = -err;
  80081f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800821:	83 fb 64             	cmp    $0x64,%ebx
  800824:	7f 0b                	jg     800831 <vprintfmt+0x15a>
  800826:	8b 34 9d 60 1f 80 00 	mov    0x801f60(,%ebx,4),%esi
  80082d:	85 f6                	test   %esi,%esi
  80082f:	75 19                	jne    80084a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800831:	53                   	push   %ebx
  800832:	68 05 21 80 00       	push   $0x802105
  800837:	ff 75 0c             	pushl  0xc(%ebp)
  80083a:	ff 75 08             	pushl  0x8(%ebp)
  80083d:	e8 5e 02 00 00       	call   800aa0 <printfmt>
  800842:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800845:	e9 49 02 00 00       	jmp    800a93 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80084a:	56                   	push   %esi
  80084b:	68 0e 21 80 00       	push   $0x80210e
  800850:	ff 75 0c             	pushl  0xc(%ebp)
  800853:	ff 75 08             	pushl  0x8(%ebp)
  800856:	e8 45 02 00 00       	call   800aa0 <printfmt>
  80085b:	83 c4 10             	add    $0x10,%esp
			break;
  80085e:	e9 30 02 00 00       	jmp    800a93 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800863:	8b 45 14             	mov    0x14(%ebp),%eax
  800866:	83 c0 04             	add    $0x4,%eax
  800869:	89 45 14             	mov    %eax,0x14(%ebp)
  80086c:	8b 45 14             	mov    0x14(%ebp),%eax
  80086f:	83 e8 04             	sub    $0x4,%eax
  800872:	8b 30                	mov    (%eax),%esi
  800874:	85 f6                	test   %esi,%esi
  800876:	75 05                	jne    80087d <vprintfmt+0x1a6>
				p = "(null)";
  800878:	be 11 21 80 00       	mov    $0x802111,%esi
			if (width > 0 && padc != '-')
  80087d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800881:	7e 6d                	jle    8008f0 <vprintfmt+0x219>
  800883:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800887:	74 67                	je     8008f0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800889:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80088c:	83 ec 08             	sub    $0x8,%esp
  80088f:	50                   	push   %eax
  800890:	56                   	push   %esi
  800891:	e8 0c 03 00 00       	call   800ba2 <strnlen>
  800896:	83 c4 10             	add    $0x10,%esp
  800899:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80089c:	eb 16                	jmp    8008b4 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80089e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008a2:	83 ec 08             	sub    $0x8,%esp
  8008a5:	ff 75 0c             	pushl  0xc(%ebp)
  8008a8:	50                   	push   %eax
  8008a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ac:	ff d0                	call   *%eax
  8008ae:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b1:	ff 4d e4             	decl   -0x1c(%ebp)
  8008b4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b8:	7f e4                	jg     80089e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008ba:	eb 34                	jmp    8008f0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008bc:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008c0:	74 1c                	je     8008de <vprintfmt+0x207>
  8008c2:	83 fb 1f             	cmp    $0x1f,%ebx
  8008c5:	7e 05                	jle    8008cc <vprintfmt+0x1f5>
  8008c7:	83 fb 7e             	cmp    $0x7e,%ebx
  8008ca:	7e 12                	jle    8008de <vprintfmt+0x207>
					putch('?', putdat);
  8008cc:	83 ec 08             	sub    $0x8,%esp
  8008cf:	ff 75 0c             	pushl  0xc(%ebp)
  8008d2:	6a 3f                	push   $0x3f
  8008d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d7:	ff d0                	call   *%eax
  8008d9:	83 c4 10             	add    $0x10,%esp
  8008dc:	eb 0f                	jmp    8008ed <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008de:	83 ec 08             	sub    $0x8,%esp
  8008e1:	ff 75 0c             	pushl  0xc(%ebp)
  8008e4:	53                   	push   %ebx
  8008e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e8:	ff d0                	call   *%eax
  8008ea:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008ed:	ff 4d e4             	decl   -0x1c(%ebp)
  8008f0:	89 f0                	mov    %esi,%eax
  8008f2:	8d 70 01             	lea    0x1(%eax),%esi
  8008f5:	8a 00                	mov    (%eax),%al
  8008f7:	0f be d8             	movsbl %al,%ebx
  8008fa:	85 db                	test   %ebx,%ebx
  8008fc:	74 24                	je     800922 <vprintfmt+0x24b>
  8008fe:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800902:	78 b8                	js     8008bc <vprintfmt+0x1e5>
  800904:	ff 4d e0             	decl   -0x20(%ebp)
  800907:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80090b:	79 af                	jns    8008bc <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80090d:	eb 13                	jmp    800922 <vprintfmt+0x24b>
				putch(' ', putdat);
  80090f:	83 ec 08             	sub    $0x8,%esp
  800912:	ff 75 0c             	pushl  0xc(%ebp)
  800915:	6a 20                	push   $0x20
  800917:	8b 45 08             	mov    0x8(%ebp),%eax
  80091a:	ff d0                	call   *%eax
  80091c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80091f:	ff 4d e4             	decl   -0x1c(%ebp)
  800922:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800926:	7f e7                	jg     80090f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800928:	e9 66 01 00 00       	jmp    800a93 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80092d:	83 ec 08             	sub    $0x8,%esp
  800930:	ff 75 e8             	pushl  -0x18(%ebp)
  800933:	8d 45 14             	lea    0x14(%ebp),%eax
  800936:	50                   	push   %eax
  800937:	e8 3c fd ff ff       	call   800678 <getint>
  80093c:	83 c4 10             	add    $0x10,%esp
  80093f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800942:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800945:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800948:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80094b:	85 d2                	test   %edx,%edx
  80094d:	79 23                	jns    800972 <vprintfmt+0x29b>
				putch('-', putdat);
  80094f:	83 ec 08             	sub    $0x8,%esp
  800952:	ff 75 0c             	pushl  0xc(%ebp)
  800955:	6a 2d                	push   $0x2d
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	ff d0                	call   *%eax
  80095c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80095f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800962:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800965:	f7 d8                	neg    %eax
  800967:	83 d2 00             	adc    $0x0,%edx
  80096a:	f7 da                	neg    %edx
  80096c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80096f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800972:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800979:	e9 bc 00 00 00       	jmp    800a3a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80097e:	83 ec 08             	sub    $0x8,%esp
  800981:	ff 75 e8             	pushl  -0x18(%ebp)
  800984:	8d 45 14             	lea    0x14(%ebp),%eax
  800987:	50                   	push   %eax
  800988:	e8 84 fc ff ff       	call   800611 <getuint>
  80098d:	83 c4 10             	add    $0x10,%esp
  800990:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800993:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800996:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80099d:	e9 98 00 00 00       	jmp    800a3a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009a2:	83 ec 08             	sub    $0x8,%esp
  8009a5:	ff 75 0c             	pushl  0xc(%ebp)
  8009a8:	6a 58                	push   $0x58
  8009aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ad:	ff d0                	call   *%eax
  8009af:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009b2:	83 ec 08             	sub    $0x8,%esp
  8009b5:	ff 75 0c             	pushl  0xc(%ebp)
  8009b8:	6a 58                	push   $0x58
  8009ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bd:	ff d0                	call   *%eax
  8009bf:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009c2:	83 ec 08             	sub    $0x8,%esp
  8009c5:	ff 75 0c             	pushl  0xc(%ebp)
  8009c8:	6a 58                	push   $0x58
  8009ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cd:	ff d0                	call   *%eax
  8009cf:	83 c4 10             	add    $0x10,%esp
			break;
  8009d2:	e9 bc 00 00 00       	jmp    800a93 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009d7:	83 ec 08             	sub    $0x8,%esp
  8009da:	ff 75 0c             	pushl  0xc(%ebp)
  8009dd:	6a 30                	push   $0x30
  8009df:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e2:	ff d0                	call   *%eax
  8009e4:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009e7:	83 ec 08             	sub    $0x8,%esp
  8009ea:	ff 75 0c             	pushl  0xc(%ebp)
  8009ed:	6a 78                	push   $0x78
  8009ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f2:	ff d0                	call   *%eax
  8009f4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fa:	83 c0 04             	add    $0x4,%eax
  8009fd:	89 45 14             	mov    %eax,0x14(%ebp)
  800a00:	8b 45 14             	mov    0x14(%ebp),%eax
  800a03:	83 e8 04             	sub    $0x4,%eax
  800a06:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a08:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a12:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a19:	eb 1f                	jmp    800a3a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a1b:	83 ec 08             	sub    $0x8,%esp
  800a1e:	ff 75 e8             	pushl  -0x18(%ebp)
  800a21:	8d 45 14             	lea    0x14(%ebp),%eax
  800a24:	50                   	push   %eax
  800a25:	e8 e7 fb ff ff       	call   800611 <getuint>
  800a2a:	83 c4 10             	add    $0x10,%esp
  800a2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a30:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a33:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a3a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a41:	83 ec 04             	sub    $0x4,%esp
  800a44:	52                   	push   %edx
  800a45:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a48:	50                   	push   %eax
  800a49:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4c:	ff 75 f0             	pushl  -0x10(%ebp)
  800a4f:	ff 75 0c             	pushl  0xc(%ebp)
  800a52:	ff 75 08             	pushl  0x8(%ebp)
  800a55:	e8 00 fb ff ff       	call   80055a <printnum>
  800a5a:	83 c4 20             	add    $0x20,%esp
			break;
  800a5d:	eb 34                	jmp    800a93 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a5f:	83 ec 08             	sub    $0x8,%esp
  800a62:	ff 75 0c             	pushl  0xc(%ebp)
  800a65:	53                   	push   %ebx
  800a66:	8b 45 08             	mov    0x8(%ebp),%eax
  800a69:	ff d0                	call   *%eax
  800a6b:	83 c4 10             	add    $0x10,%esp
			break;
  800a6e:	eb 23                	jmp    800a93 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a70:	83 ec 08             	sub    $0x8,%esp
  800a73:	ff 75 0c             	pushl  0xc(%ebp)
  800a76:	6a 25                	push   $0x25
  800a78:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7b:	ff d0                	call   *%eax
  800a7d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a80:	ff 4d 10             	decl   0x10(%ebp)
  800a83:	eb 03                	jmp    800a88 <vprintfmt+0x3b1>
  800a85:	ff 4d 10             	decl   0x10(%ebp)
  800a88:	8b 45 10             	mov    0x10(%ebp),%eax
  800a8b:	48                   	dec    %eax
  800a8c:	8a 00                	mov    (%eax),%al
  800a8e:	3c 25                	cmp    $0x25,%al
  800a90:	75 f3                	jne    800a85 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a92:	90                   	nop
		}
	}
  800a93:	e9 47 fc ff ff       	jmp    8006df <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a98:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a99:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a9c:	5b                   	pop    %ebx
  800a9d:	5e                   	pop    %esi
  800a9e:	5d                   	pop    %ebp
  800a9f:	c3                   	ret    

00800aa0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800aa0:	55                   	push   %ebp
  800aa1:	89 e5                	mov    %esp,%ebp
  800aa3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800aa6:	8d 45 10             	lea    0x10(%ebp),%eax
  800aa9:	83 c0 04             	add    $0x4,%eax
  800aac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800aaf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ab5:	50                   	push   %eax
  800ab6:	ff 75 0c             	pushl  0xc(%ebp)
  800ab9:	ff 75 08             	pushl  0x8(%ebp)
  800abc:	e8 16 fc ff ff       	call   8006d7 <vprintfmt>
  800ac1:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ac4:	90                   	nop
  800ac5:	c9                   	leave  
  800ac6:	c3                   	ret    

00800ac7 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ac7:	55                   	push   %ebp
  800ac8:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800aca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acd:	8b 40 08             	mov    0x8(%eax),%eax
  800ad0:	8d 50 01             	lea    0x1(%eax),%edx
  800ad3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad6:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adc:	8b 10                	mov    (%eax),%edx
  800ade:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae1:	8b 40 04             	mov    0x4(%eax),%eax
  800ae4:	39 c2                	cmp    %eax,%edx
  800ae6:	73 12                	jae    800afa <sprintputch+0x33>
		*b->buf++ = ch;
  800ae8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aeb:	8b 00                	mov    (%eax),%eax
  800aed:	8d 48 01             	lea    0x1(%eax),%ecx
  800af0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af3:	89 0a                	mov    %ecx,(%edx)
  800af5:	8b 55 08             	mov    0x8(%ebp),%edx
  800af8:	88 10                	mov    %dl,(%eax)
}
  800afa:	90                   	nop
  800afb:	5d                   	pop    %ebp
  800afc:	c3                   	ret    

00800afd <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800afd:	55                   	push   %ebp
  800afe:	89 e5                	mov    %esp,%ebp
  800b00:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	01 d0                	add    %edx,%eax
  800b14:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b1e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b22:	74 06                	je     800b2a <vsnprintf+0x2d>
  800b24:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b28:	7f 07                	jg     800b31 <vsnprintf+0x34>
		return -E_INVAL;
  800b2a:	b8 03 00 00 00       	mov    $0x3,%eax
  800b2f:	eb 20                	jmp    800b51 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b31:	ff 75 14             	pushl  0x14(%ebp)
  800b34:	ff 75 10             	pushl  0x10(%ebp)
  800b37:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b3a:	50                   	push   %eax
  800b3b:	68 c7 0a 80 00       	push   $0x800ac7
  800b40:	e8 92 fb ff ff       	call   8006d7 <vprintfmt>
  800b45:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b48:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b4b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b51:	c9                   	leave  
  800b52:	c3                   	ret    

00800b53 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b53:	55                   	push   %ebp
  800b54:	89 e5                	mov    %esp,%ebp
  800b56:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b59:	8d 45 10             	lea    0x10(%ebp),%eax
  800b5c:	83 c0 04             	add    $0x4,%eax
  800b5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b62:	8b 45 10             	mov    0x10(%ebp),%eax
  800b65:	ff 75 f4             	pushl  -0xc(%ebp)
  800b68:	50                   	push   %eax
  800b69:	ff 75 0c             	pushl  0xc(%ebp)
  800b6c:	ff 75 08             	pushl  0x8(%ebp)
  800b6f:	e8 89 ff ff ff       	call   800afd <vsnprintf>
  800b74:	83 c4 10             	add    $0x10,%esp
  800b77:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b7d:	c9                   	leave  
  800b7e:	c3                   	ret    

00800b7f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b7f:	55                   	push   %ebp
  800b80:	89 e5                	mov    %esp,%ebp
  800b82:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b8c:	eb 06                	jmp    800b94 <strlen+0x15>
		n++;
  800b8e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b91:	ff 45 08             	incl   0x8(%ebp)
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
  800b97:	8a 00                	mov    (%eax),%al
  800b99:	84 c0                	test   %al,%al
  800b9b:	75 f1                	jne    800b8e <strlen+0xf>
		n++;
	return n;
  800b9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba0:	c9                   	leave  
  800ba1:	c3                   	ret    

00800ba2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ba2:	55                   	push   %ebp
  800ba3:	89 e5                	mov    %esp,%ebp
  800ba5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ba8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800baf:	eb 09                	jmp    800bba <strnlen+0x18>
		n++;
  800bb1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bb4:	ff 45 08             	incl   0x8(%ebp)
  800bb7:	ff 4d 0c             	decl   0xc(%ebp)
  800bba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bbe:	74 09                	je     800bc9 <strnlen+0x27>
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	8a 00                	mov    (%eax),%al
  800bc5:	84 c0                	test   %al,%al
  800bc7:	75 e8                	jne    800bb1 <strnlen+0xf>
		n++;
	return n;
  800bc9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bcc:	c9                   	leave  
  800bcd:	c3                   	ret    

00800bce <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bce:	55                   	push   %ebp
  800bcf:	89 e5                	mov    %esp,%ebp
  800bd1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bda:	90                   	nop
  800bdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bde:	8d 50 01             	lea    0x1(%eax),%edx
  800be1:	89 55 08             	mov    %edx,0x8(%ebp)
  800be4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bea:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bed:	8a 12                	mov    (%edx),%dl
  800bef:	88 10                	mov    %dl,(%eax)
  800bf1:	8a 00                	mov    (%eax),%al
  800bf3:	84 c0                	test   %al,%al
  800bf5:	75 e4                	jne    800bdb <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bf7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bfa:	c9                   	leave  
  800bfb:	c3                   	ret    

00800bfc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bfc:	55                   	push   %ebp
  800bfd:	89 e5                	mov    %esp,%ebp
  800bff:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c02:	8b 45 08             	mov    0x8(%ebp),%eax
  800c05:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c08:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c0f:	eb 1f                	jmp    800c30 <strncpy+0x34>
		*dst++ = *src;
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
  800c14:	8d 50 01             	lea    0x1(%eax),%edx
  800c17:	89 55 08             	mov    %edx,0x8(%ebp)
  800c1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c1d:	8a 12                	mov    (%edx),%dl
  800c1f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c24:	8a 00                	mov    (%eax),%al
  800c26:	84 c0                	test   %al,%al
  800c28:	74 03                	je     800c2d <strncpy+0x31>
			src++;
  800c2a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c2d:	ff 45 fc             	incl   -0x4(%ebp)
  800c30:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c33:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c36:	72 d9                	jb     800c11 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c38:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c3b:	c9                   	leave  
  800c3c:	c3                   	ret    

00800c3d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c3d:	55                   	push   %ebp
  800c3e:	89 e5                	mov    %esp,%ebp
  800c40:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c49:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c4d:	74 30                	je     800c7f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c4f:	eb 16                	jmp    800c67 <strlcpy+0x2a>
			*dst++ = *src++;
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	8d 50 01             	lea    0x1(%eax),%edx
  800c57:	89 55 08             	mov    %edx,0x8(%ebp)
  800c5a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c5d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c60:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c63:	8a 12                	mov    (%edx),%dl
  800c65:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c67:	ff 4d 10             	decl   0x10(%ebp)
  800c6a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c6e:	74 09                	je     800c79 <strlcpy+0x3c>
  800c70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c73:	8a 00                	mov    (%eax),%al
  800c75:	84 c0                	test   %al,%al
  800c77:	75 d8                	jne    800c51 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c7f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c82:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c85:	29 c2                	sub    %eax,%edx
  800c87:	89 d0                	mov    %edx,%eax
}
  800c89:	c9                   	leave  
  800c8a:	c3                   	ret    

00800c8b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c8b:	55                   	push   %ebp
  800c8c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c8e:	eb 06                	jmp    800c96 <strcmp+0xb>
		p++, q++;
  800c90:	ff 45 08             	incl   0x8(%ebp)
  800c93:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	8a 00                	mov    (%eax),%al
  800c9b:	84 c0                	test   %al,%al
  800c9d:	74 0e                	je     800cad <strcmp+0x22>
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	8a 10                	mov    (%eax),%dl
  800ca4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca7:	8a 00                	mov    (%eax),%al
  800ca9:	38 c2                	cmp    %al,%dl
  800cab:	74 e3                	je     800c90 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	8a 00                	mov    (%eax),%al
  800cb2:	0f b6 d0             	movzbl %al,%edx
  800cb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb8:	8a 00                	mov    (%eax),%al
  800cba:	0f b6 c0             	movzbl %al,%eax
  800cbd:	29 c2                	sub    %eax,%edx
  800cbf:	89 d0                	mov    %edx,%eax
}
  800cc1:	5d                   	pop    %ebp
  800cc2:	c3                   	ret    

00800cc3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cc3:	55                   	push   %ebp
  800cc4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cc6:	eb 09                	jmp    800cd1 <strncmp+0xe>
		n--, p++, q++;
  800cc8:	ff 4d 10             	decl   0x10(%ebp)
  800ccb:	ff 45 08             	incl   0x8(%ebp)
  800cce:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cd1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd5:	74 17                	je     800cee <strncmp+0x2b>
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	8a 00                	mov    (%eax),%al
  800cdc:	84 c0                	test   %al,%al
  800cde:	74 0e                	je     800cee <strncmp+0x2b>
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	8a 10                	mov    (%eax),%dl
  800ce5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	38 c2                	cmp    %al,%dl
  800cec:	74 da                	je     800cc8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf2:	75 07                	jne    800cfb <strncmp+0x38>
		return 0;
  800cf4:	b8 00 00 00 00       	mov    $0x0,%eax
  800cf9:	eb 14                	jmp    800d0f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	8a 00                	mov    (%eax),%al
  800d00:	0f b6 d0             	movzbl %al,%edx
  800d03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d06:	8a 00                	mov    (%eax),%al
  800d08:	0f b6 c0             	movzbl %al,%eax
  800d0b:	29 c2                	sub    %eax,%edx
  800d0d:	89 d0                	mov    %edx,%eax
}
  800d0f:	5d                   	pop    %ebp
  800d10:	c3                   	ret    

00800d11 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d11:	55                   	push   %ebp
  800d12:	89 e5                	mov    %esp,%ebp
  800d14:	83 ec 04             	sub    $0x4,%esp
  800d17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d1d:	eb 12                	jmp    800d31 <strchr+0x20>
		if (*s == c)
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8a 00                	mov    (%eax),%al
  800d24:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d27:	75 05                	jne    800d2e <strchr+0x1d>
			return (char *) s;
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	eb 11                	jmp    800d3f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d2e:	ff 45 08             	incl   0x8(%ebp)
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	8a 00                	mov    (%eax),%al
  800d36:	84 c0                	test   %al,%al
  800d38:	75 e5                	jne    800d1f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d3a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d3f:	c9                   	leave  
  800d40:	c3                   	ret    

00800d41 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d41:	55                   	push   %ebp
  800d42:	89 e5                	mov    %esp,%ebp
  800d44:	83 ec 04             	sub    $0x4,%esp
  800d47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d4d:	eb 0d                	jmp    800d5c <strfind+0x1b>
		if (*s == c)
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d57:	74 0e                	je     800d67 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d59:	ff 45 08             	incl   0x8(%ebp)
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	8a 00                	mov    (%eax),%al
  800d61:	84 c0                	test   %al,%al
  800d63:	75 ea                	jne    800d4f <strfind+0xe>
  800d65:	eb 01                	jmp    800d68 <strfind+0x27>
		if (*s == c)
			break;
  800d67:	90                   	nop
	return (char *) s;
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d6b:	c9                   	leave  
  800d6c:	c3                   	ret    

00800d6d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d6d:	55                   	push   %ebp
  800d6e:	89 e5                	mov    %esp,%ebp
  800d70:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
  800d76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d79:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d7f:	eb 0e                	jmp    800d8f <memset+0x22>
		*p++ = c;
  800d81:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d84:	8d 50 01             	lea    0x1(%eax),%edx
  800d87:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d8d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d8f:	ff 4d f8             	decl   -0x8(%ebp)
  800d92:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d96:	79 e9                	jns    800d81 <memset+0x14>
		*p++ = c;

	return v;
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d9b:	c9                   	leave  
  800d9c:	c3                   	ret    

00800d9d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d9d:	55                   	push   %ebp
  800d9e:	89 e5                	mov    %esp,%ebp
  800da0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800da3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800daf:	eb 16                	jmp    800dc7 <memcpy+0x2a>
		*d++ = *s++;
  800db1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db4:	8d 50 01             	lea    0x1(%eax),%edx
  800db7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dbd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dc0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dc3:	8a 12                	mov    (%edx),%dl
  800dc5:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dc7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dca:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dcd:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd0:	85 c0                	test   %eax,%eax
  800dd2:	75 dd                	jne    800db1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dd7:	c9                   	leave  
  800dd8:	c3                   	ret    

00800dd9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dd9:	55                   	push   %ebp
  800dda:	89 e5                	mov    %esp,%ebp
  800ddc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800deb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800df1:	73 50                	jae    800e43 <memmove+0x6a>
  800df3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df6:	8b 45 10             	mov    0x10(%ebp),%eax
  800df9:	01 d0                	add    %edx,%eax
  800dfb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dfe:	76 43                	jbe    800e43 <memmove+0x6a>
		s += n;
  800e00:	8b 45 10             	mov    0x10(%ebp),%eax
  800e03:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e06:	8b 45 10             	mov    0x10(%ebp),%eax
  800e09:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e0c:	eb 10                	jmp    800e1e <memmove+0x45>
			*--d = *--s;
  800e0e:	ff 4d f8             	decl   -0x8(%ebp)
  800e11:	ff 4d fc             	decl   -0x4(%ebp)
  800e14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e17:	8a 10                	mov    (%eax),%dl
  800e19:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e21:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e24:	89 55 10             	mov    %edx,0x10(%ebp)
  800e27:	85 c0                	test   %eax,%eax
  800e29:	75 e3                	jne    800e0e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e2b:	eb 23                	jmp    800e50 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e30:	8d 50 01             	lea    0x1(%eax),%edx
  800e33:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e36:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e39:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e3c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e3f:	8a 12                	mov    (%edx),%dl
  800e41:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e43:	8b 45 10             	mov    0x10(%ebp),%eax
  800e46:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e49:	89 55 10             	mov    %edx,0x10(%ebp)
  800e4c:	85 c0                	test   %eax,%eax
  800e4e:	75 dd                	jne    800e2d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e50:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e53:	c9                   	leave  
  800e54:	c3                   	ret    

00800e55 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e55:	55                   	push   %ebp
  800e56:	89 e5                	mov    %esp,%ebp
  800e58:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e64:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e67:	eb 2a                	jmp    800e93 <memcmp+0x3e>
		if (*s1 != *s2)
  800e69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6c:	8a 10                	mov    (%eax),%dl
  800e6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e71:	8a 00                	mov    (%eax),%al
  800e73:	38 c2                	cmp    %al,%dl
  800e75:	74 16                	je     800e8d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e77:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7a:	8a 00                	mov    (%eax),%al
  800e7c:	0f b6 d0             	movzbl %al,%edx
  800e7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e82:	8a 00                	mov    (%eax),%al
  800e84:	0f b6 c0             	movzbl %al,%eax
  800e87:	29 c2                	sub    %eax,%edx
  800e89:	89 d0                	mov    %edx,%eax
  800e8b:	eb 18                	jmp    800ea5 <memcmp+0x50>
		s1++, s2++;
  800e8d:	ff 45 fc             	incl   -0x4(%ebp)
  800e90:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e93:	8b 45 10             	mov    0x10(%ebp),%eax
  800e96:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e99:	89 55 10             	mov    %edx,0x10(%ebp)
  800e9c:	85 c0                	test   %eax,%eax
  800e9e:	75 c9                	jne    800e69 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ea0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ea5:	c9                   	leave  
  800ea6:	c3                   	ret    

00800ea7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ea7:	55                   	push   %ebp
  800ea8:	89 e5                	mov    %esp,%ebp
  800eaa:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ead:	8b 55 08             	mov    0x8(%ebp),%edx
  800eb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb3:	01 d0                	add    %edx,%eax
  800eb5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800eb8:	eb 15                	jmp    800ecf <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800eba:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebd:	8a 00                	mov    (%eax),%al
  800ebf:	0f b6 d0             	movzbl %al,%edx
  800ec2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec5:	0f b6 c0             	movzbl %al,%eax
  800ec8:	39 c2                	cmp    %eax,%edx
  800eca:	74 0d                	je     800ed9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ecc:	ff 45 08             	incl   0x8(%ebp)
  800ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ed5:	72 e3                	jb     800eba <memfind+0x13>
  800ed7:	eb 01                	jmp    800eda <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ed9:	90                   	nop
	return (void *) s;
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800edd:	c9                   	leave  
  800ede:	c3                   	ret    

00800edf <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800edf:	55                   	push   %ebp
  800ee0:	89 e5                	mov    %esp,%ebp
  800ee2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ee5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800eec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ef3:	eb 03                	jmp    800ef8 <strtol+0x19>
		s++;
  800ef5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  800efb:	8a 00                	mov    (%eax),%al
  800efd:	3c 20                	cmp    $0x20,%al
  800eff:	74 f4                	je     800ef5 <strtol+0x16>
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	8a 00                	mov    (%eax),%al
  800f06:	3c 09                	cmp    $0x9,%al
  800f08:	74 eb                	je     800ef5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	3c 2b                	cmp    $0x2b,%al
  800f11:	75 05                	jne    800f18 <strtol+0x39>
		s++;
  800f13:	ff 45 08             	incl   0x8(%ebp)
  800f16:	eb 13                	jmp    800f2b <strtol+0x4c>
	else if (*s == '-')
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	3c 2d                	cmp    $0x2d,%al
  800f1f:	75 0a                	jne    800f2b <strtol+0x4c>
		s++, neg = 1;
  800f21:	ff 45 08             	incl   0x8(%ebp)
  800f24:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f2b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2f:	74 06                	je     800f37 <strtol+0x58>
  800f31:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f35:	75 20                	jne    800f57 <strtol+0x78>
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	8a 00                	mov    (%eax),%al
  800f3c:	3c 30                	cmp    $0x30,%al
  800f3e:	75 17                	jne    800f57 <strtol+0x78>
  800f40:	8b 45 08             	mov    0x8(%ebp),%eax
  800f43:	40                   	inc    %eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	3c 78                	cmp    $0x78,%al
  800f48:	75 0d                	jne    800f57 <strtol+0x78>
		s += 2, base = 16;
  800f4a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f4e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f55:	eb 28                	jmp    800f7f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f57:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5b:	75 15                	jne    800f72 <strtol+0x93>
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	8a 00                	mov    (%eax),%al
  800f62:	3c 30                	cmp    $0x30,%al
  800f64:	75 0c                	jne    800f72 <strtol+0x93>
		s++, base = 8;
  800f66:	ff 45 08             	incl   0x8(%ebp)
  800f69:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f70:	eb 0d                	jmp    800f7f <strtol+0xa0>
	else if (base == 0)
  800f72:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f76:	75 07                	jne    800f7f <strtol+0xa0>
		base = 10;
  800f78:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f82:	8a 00                	mov    (%eax),%al
  800f84:	3c 2f                	cmp    $0x2f,%al
  800f86:	7e 19                	jle    800fa1 <strtol+0xc2>
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8b:	8a 00                	mov    (%eax),%al
  800f8d:	3c 39                	cmp    $0x39,%al
  800f8f:	7f 10                	jg     800fa1 <strtol+0xc2>
			dig = *s - '0';
  800f91:	8b 45 08             	mov    0x8(%ebp),%eax
  800f94:	8a 00                	mov    (%eax),%al
  800f96:	0f be c0             	movsbl %al,%eax
  800f99:	83 e8 30             	sub    $0x30,%eax
  800f9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f9f:	eb 42                	jmp    800fe3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa4:	8a 00                	mov    (%eax),%al
  800fa6:	3c 60                	cmp    $0x60,%al
  800fa8:	7e 19                	jle    800fc3 <strtol+0xe4>
  800faa:	8b 45 08             	mov    0x8(%ebp),%eax
  800fad:	8a 00                	mov    (%eax),%al
  800faf:	3c 7a                	cmp    $0x7a,%al
  800fb1:	7f 10                	jg     800fc3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	0f be c0             	movsbl %al,%eax
  800fbb:	83 e8 57             	sub    $0x57,%eax
  800fbe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fc1:	eb 20                	jmp    800fe3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc6:	8a 00                	mov    (%eax),%al
  800fc8:	3c 40                	cmp    $0x40,%al
  800fca:	7e 39                	jle    801005 <strtol+0x126>
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	3c 5a                	cmp    $0x5a,%al
  800fd3:	7f 30                	jg     801005 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	8a 00                	mov    (%eax),%al
  800fda:	0f be c0             	movsbl %al,%eax
  800fdd:	83 e8 37             	sub    $0x37,%eax
  800fe0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fe3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fe6:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fe9:	7d 19                	jge    801004 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800feb:	ff 45 08             	incl   0x8(%ebp)
  800fee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff1:	0f af 45 10          	imul   0x10(%ebp),%eax
  800ff5:	89 c2                	mov    %eax,%edx
  800ff7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffa:	01 d0                	add    %edx,%eax
  800ffc:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fff:	e9 7b ff ff ff       	jmp    800f7f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801004:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801005:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801009:	74 08                	je     801013 <strtol+0x134>
		*endptr = (char *) s;
  80100b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100e:	8b 55 08             	mov    0x8(%ebp),%edx
  801011:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801013:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801017:	74 07                	je     801020 <strtol+0x141>
  801019:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101c:	f7 d8                	neg    %eax
  80101e:	eb 03                	jmp    801023 <strtol+0x144>
  801020:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801023:	c9                   	leave  
  801024:	c3                   	ret    

00801025 <ltostr>:

void
ltostr(long value, char *str)
{
  801025:	55                   	push   %ebp
  801026:	89 e5                	mov    %esp,%ebp
  801028:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80102b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801032:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801039:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80103d:	79 13                	jns    801052 <ltostr+0x2d>
	{
		neg = 1;
  80103f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801046:	8b 45 0c             	mov    0xc(%ebp),%eax
  801049:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80104c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80104f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80105a:	99                   	cltd   
  80105b:	f7 f9                	idiv   %ecx
  80105d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801060:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801063:	8d 50 01             	lea    0x1(%eax),%edx
  801066:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801069:	89 c2                	mov    %eax,%edx
  80106b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106e:	01 d0                	add    %edx,%eax
  801070:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801073:	83 c2 30             	add    $0x30,%edx
  801076:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801078:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80107b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801080:	f7 e9                	imul   %ecx
  801082:	c1 fa 02             	sar    $0x2,%edx
  801085:	89 c8                	mov    %ecx,%eax
  801087:	c1 f8 1f             	sar    $0x1f,%eax
  80108a:	29 c2                	sub    %eax,%edx
  80108c:	89 d0                	mov    %edx,%eax
  80108e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801091:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801094:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801099:	f7 e9                	imul   %ecx
  80109b:	c1 fa 02             	sar    $0x2,%edx
  80109e:	89 c8                	mov    %ecx,%eax
  8010a0:	c1 f8 1f             	sar    $0x1f,%eax
  8010a3:	29 c2                	sub    %eax,%edx
  8010a5:	89 d0                	mov    %edx,%eax
  8010a7:	c1 e0 02             	shl    $0x2,%eax
  8010aa:	01 d0                	add    %edx,%eax
  8010ac:	01 c0                	add    %eax,%eax
  8010ae:	29 c1                	sub    %eax,%ecx
  8010b0:	89 ca                	mov    %ecx,%edx
  8010b2:	85 d2                	test   %edx,%edx
  8010b4:	75 9c                	jne    801052 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c0:	48                   	dec    %eax
  8010c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010c4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010c8:	74 3d                	je     801107 <ltostr+0xe2>
		start = 1 ;
  8010ca:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010d1:	eb 34                	jmp    801107 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d9:	01 d0                	add    %edx,%eax
  8010db:	8a 00                	mov    (%eax),%al
  8010dd:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e6:	01 c2                	add    %eax,%edx
  8010e8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ee:	01 c8                	add    %ecx,%eax
  8010f0:	8a 00                	mov    (%eax),%al
  8010f2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010f4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fa:	01 c2                	add    %eax,%edx
  8010fc:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010ff:	88 02                	mov    %al,(%edx)
		start++ ;
  801101:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801104:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801107:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80110a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80110d:	7c c4                	jl     8010d3 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80110f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801112:	8b 45 0c             	mov    0xc(%ebp),%eax
  801115:	01 d0                	add    %edx,%eax
  801117:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80111a:	90                   	nop
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
  801120:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801123:	ff 75 08             	pushl  0x8(%ebp)
  801126:	e8 54 fa ff ff       	call   800b7f <strlen>
  80112b:	83 c4 04             	add    $0x4,%esp
  80112e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801131:	ff 75 0c             	pushl  0xc(%ebp)
  801134:	e8 46 fa ff ff       	call   800b7f <strlen>
  801139:	83 c4 04             	add    $0x4,%esp
  80113c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80113f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801146:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80114d:	eb 17                	jmp    801166 <strcconcat+0x49>
		final[s] = str1[s] ;
  80114f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801152:	8b 45 10             	mov    0x10(%ebp),%eax
  801155:	01 c2                	add    %eax,%edx
  801157:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	01 c8                	add    %ecx,%eax
  80115f:	8a 00                	mov    (%eax),%al
  801161:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801163:	ff 45 fc             	incl   -0x4(%ebp)
  801166:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801169:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80116c:	7c e1                	jl     80114f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80116e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801175:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80117c:	eb 1f                	jmp    80119d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80117e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801181:	8d 50 01             	lea    0x1(%eax),%edx
  801184:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801187:	89 c2                	mov    %eax,%edx
  801189:	8b 45 10             	mov    0x10(%ebp),%eax
  80118c:	01 c2                	add    %eax,%edx
  80118e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801191:	8b 45 0c             	mov    0xc(%ebp),%eax
  801194:	01 c8                	add    %ecx,%eax
  801196:	8a 00                	mov    (%eax),%al
  801198:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80119a:	ff 45 f8             	incl   -0x8(%ebp)
  80119d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011a3:	7c d9                	jl     80117e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ab:	01 d0                	add    %edx,%eax
  8011ad:	c6 00 00             	movb   $0x0,(%eax)
}
  8011b0:	90                   	nop
  8011b1:	c9                   	leave  
  8011b2:	c3                   	ret    

008011b3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011b3:	55                   	push   %ebp
  8011b4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c2:	8b 00                	mov    (%eax),%eax
  8011c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ce:	01 d0                	add    %edx,%eax
  8011d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011d6:	eb 0c                	jmp    8011e4 <strsplit+0x31>
			*string++ = 0;
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	8d 50 01             	lea    0x1(%eax),%edx
  8011de:	89 55 08             	mov    %edx,0x8(%ebp)
  8011e1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e7:	8a 00                	mov    (%eax),%al
  8011e9:	84 c0                	test   %al,%al
  8011eb:	74 18                	je     801205 <strsplit+0x52>
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	8a 00                	mov    (%eax),%al
  8011f2:	0f be c0             	movsbl %al,%eax
  8011f5:	50                   	push   %eax
  8011f6:	ff 75 0c             	pushl  0xc(%ebp)
  8011f9:	e8 13 fb ff ff       	call   800d11 <strchr>
  8011fe:	83 c4 08             	add    $0x8,%esp
  801201:	85 c0                	test   %eax,%eax
  801203:	75 d3                	jne    8011d8 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801205:	8b 45 08             	mov    0x8(%ebp),%eax
  801208:	8a 00                	mov    (%eax),%al
  80120a:	84 c0                	test   %al,%al
  80120c:	74 5a                	je     801268 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80120e:	8b 45 14             	mov    0x14(%ebp),%eax
  801211:	8b 00                	mov    (%eax),%eax
  801213:	83 f8 0f             	cmp    $0xf,%eax
  801216:	75 07                	jne    80121f <strsplit+0x6c>
		{
			return 0;
  801218:	b8 00 00 00 00       	mov    $0x0,%eax
  80121d:	eb 66                	jmp    801285 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80121f:	8b 45 14             	mov    0x14(%ebp),%eax
  801222:	8b 00                	mov    (%eax),%eax
  801224:	8d 48 01             	lea    0x1(%eax),%ecx
  801227:	8b 55 14             	mov    0x14(%ebp),%edx
  80122a:	89 0a                	mov    %ecx,(%edx)
  80122c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801233:	8b 45 10             	mov    0x10(%ebp),%eax
  801236:	01 c2                	add    %eax,%edx
  801238:	8b 45 08             	mov    0x8(%ebp),%eax
  80123b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80123d:	eb 03                	jmp    801242 <strsplit+0x8f>
			string++;
  80123f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801242:	8b 45 08             	mov    0x8(%ebp),%eax
  801245:	8a 00                	mov    (%eax),%al
  801247:	84 c0                	test   %al,%al
  801249:	74 8b                	je     8011d6 <strsplit+0x23>
  80124b:	8b 45 08             	mov    0x8(%ebp),%eax
  80124e:	8a 00                	mov    (%eax),%al
  801250:	0f be c0             	movsbl %al,%eax
  801253:	50                   	push   %eax
  801254:	ff 75 0c             	pushl  0xc(%ebp)
  801257:	e8 b5 fa ff ff       	call   800d11 <strchr>
  80125c:	83 c4 08             	add    $0x8,%esp
  80125f:	85 c0                	test   %eax,%eax
  801261:	74 dc                	je     80123f <strsplit+0x8c>
			string++;
	}
  801263:	e9 6e ff ff ff       	jmp    8011d6 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801268:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801269:	8b 45 14             	mov    0x14(%ebp),%eax
  80126c:	8b 00                	mov    (%eax),%eax
  80126e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801275:	8b 45 10             	mov    0x10(%ebp),%eax
  801278:	01 d0                	add    %edx,%eax
  80127a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801280:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801285:	c9                   	leave  
  801286:	c3                   	ret    

00801287 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801287:	55                   	push   %ebp
  801288:	89 e5                	mov    %esp,%ebp
  80128a:	57                   	push   %edi
  80128b:	56                   	push   %esi
  80128c:	53                   	push   %ebx
  80128d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801290:	8b 45 08             	mov    0x8(%ebp),%eax
  801293:	8b 55 0c             	mov    0xc(%ebp),%edx
  801296:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801299:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80129c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80129f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012a2:	cd 30                	int    $0x30
  8012a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012aa:	83 c4 10             	add    $0x10,%esp
  8012ad:	5b                   	pop    %ebx
  8012ae:	5e                   	pop    %esi
  8012af:	5f                   	pop    %edi
  8012b0:	5d                   	pop    %ebp
  8012b1:	c3                   	ret    

008012b2 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012b2:	55                   	push   %ebp
  8012b3:	89 e5                	mov    %esp,%ebp
  8012b5:	83 ec 04             	sub    $0x4,%esp
  8012b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012be:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	52                   	push   %edx
  8012ca:	ff 75 0c             	pushl  0xc(%ebp)
  8012cd:	50                   	push   %eax
  8012ce:	6a 00                	push   $0x0
  8012d0:	e8 b2 ff ff ff       	call   801287 <syscall>
  8012d5:	83 c4 18             	add    $0x18,%esp
}
  8012d8:	90                   	nop
  8012d9:	c9                   	leave  
  8012da:	c3                   	ret    

008012db <sys_cgetc>:

int
sys_cgetc(void)
{
  8012db:	55                   	push   %ebp
  8012dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 00                	push   $0x0
  8012e2:	6a 00                	push   $0x0
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 01                	push   $0x1
  8012ea:	e8 98 ff ff ff       	call   801287 <syscall>
  8012ef:	83 c4 18             	add    $0x18,%esp
}
  8012f2:	c9                   	leave  
  8012f3:	c3                   	ret    

008012f4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012f4:	55                   	push   %ebp
  8012f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	50                   	push   %eax
  801303:	6a 05                	push   $0x5
  801305:	e8 7d ff ff ff       	call   801287 <syscall>
  80130a:	83 c4 18             	add    $0x18,%esp
}
  80130d:	c9                   	leave  
  80130e:	c3                   	ret    

0080130f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80130f:	55                   	push   %ebp
  801310:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801312:	6a 00                	push   $0x0
  801314:	6a 00                	push   $0x0
  801316:	6a 00                	push   $0x0
  801318:	6a 00                	push   $0x0
  80131a:	6a 00                	push   $0x0
  80131c:	6a 02                	push   $0x2
  80131e:	e8 64 ff ff ff       	call   801287 <syscall>
  801323:	83 c4 18             	add    $0x18,%esp
}
  801326:	c9                   	leave  
  801327:	c3                   	ret    

00801328 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801328:	55                   	push   %ebp
  801329:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80132b:	6a 00                	push   $0x0
  80132d:	6a 00                	push   $0x0
  80132f:	6a 00                	push   $0x0
  801331:	6a 00                	push   $0x0
  801333:	6a 00                	push   $0x0
  801335:	6a 03                	push   $0x3
  801337:	e8 4b ff ff ff       	call   801287 <syscall>
  80133c:	83 c4 18             	add    $0x18,%esp
}
  80133f:	c9                   	leave  
  801340:	c3                   	ret    

00801341 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801341:	55                   	push   %ebp
  801342:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	6a 00                	push   $0x0
  80134a:	6a 00                	push   $0x0
  80134c:	6a 00                	push   $0x0
  80134e:	6a 04                	push   $0x4
  801350:	e8 32 ff ff ff       	call   801287 <syscall>
  801355:	83 c4 18             	add    $0x18,%esp
}
  801358:	c9                   	leave  
  801359:	c3                   	ret    

0080135a <sys_env_exit>:


void sys_env_exit(void)
{
  80135a:	55                   	push   %ebp
  80135b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	6a 00                	push   $0x0
  801367:	6a 06                	push   $0x6
  801369:	e8 19 ff ff ff       	call   801287 <syscall>
  80136e:	83 c4 18             	add    $0x18,%esp
}
  801371:	90                   	nop
  801372:	c9                   	leave  
  801373:	c3                   	ret    

00801374 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801374:	55                   	push   %ebp
  801375:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801377:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137a:	8b 45 08             	mov    0x8(%ebp),%eax
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	52                   	push   %edx
  801384:	50                   	push   %eax
  801385:	6a 07                	push   $0x7
  801387:	e8 fb fe ff ff       	call   801287 <syscall>
  80138c:	83 c4 18             	add    $0x18,%esp
}
  80138f:	c9                   	leave  
  801390:	c3                   	ret    

00801391 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
  801394:	56                   	push   %esi
  801395:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801396:	8b 75 18             	mov    0x18(%ebp),%esi
  801399:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80139c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80139f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	56                   	push   %esi
  8013a6:	53                   	push   %ebx
  8013a7:	51                   	push   %ecx
  8013a8:	52                   	push   %edx
  8013a9:	50                   	push   %eax
  8013aa:	6a 08                	push   $0x8
  8013ac:	e8 d6 fe ff ff       	call   801287 <syscall>
  8013b1:	83 c4 18             	add    $0x18,%esp
}
  8013b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013b7:	5b                   	pop    %ebx
  8013b8:	5e                   	pop    %esi
  8013b9:	5d                   	pop    %ebp
  8013ba:	c3                   	ret    

008013bb <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013bb:	55                   	push   %ebp
  8013bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	6a 00                	push   $0x0
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	52                   	push   %edx
  8013cb:	50                   	push   %eax
  8013cc:	6a 09                	push   $0x9
  8013ce:	e8 b4 fe ff ff       	call   801287 <syscall>
  8013d3:	83 c4 18             	add    $0x18,%esp
}
  8013d6:	c9                   	leave  
  8013d7:	c3                   	ret    

008013d8 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013d8:	55                   	push   %ebp
  8013d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	ff 75 0c             	pushl  0xc(%ebp)
  8013e4:	ff 75 08             	pushl  0x8(%ebp)
  8013e7:	6a 0a                	push   $0xa
  8013e9:	e8 99 fe ff ff       	call   801287 <syscall>
  8013ee:	83 c4 18             	add    $0x18,%esp
}
  8013f1:	c9                   	leave  
  8013f2:	c3                   	ret    

008013f3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013f3:	55                   	push   %ebp
  8013f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 0b                	push   $0xb
  801402:	e8 80 fe ff ff       	call   801287 <syscall>
  801407:	83 c4 18             	add    $0x18,%esp
}
  80140a:	c9                   	leave  
  80140b:	c3                   	ret    

0080140c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80140c:	55                   	push   %ebp
  80140d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80140f:	6a 00                	push   $0x0
  801411:	6a 00                	push   $0x0
  801413:	6a 00                	push   $0x0
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	6a 0c                	push   $0xc
  80141b:	e8 67 fe ff ff       	call   801287 <syscall>
  801420:	83 c4 18             	add    $0x18,%esp
}
  801423:	c9                   	leave  
  801424:	c3                   	ret    

00801425 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801425:	55                   	push   %ebp
  801426:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801428:	6a 00                	push   $0x0
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	6a 0d                	push   $0xd
  801434:	e8 4e fe ff ff       	call   801287 <syscall>
  801439:	83 c4 18             	add    $0x18,%esp
}
  80143c:	c9                   	leave  
  80143d:	c3                   	ret    

0080143e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80143e:	55                   	push   %ebp
  80143f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	ff 75 0c             	pushl  0xc(%ebp)
  80144a:	ff 75 08             	pushl  0x8(%ebp)
  80144d:	6a 11                	push   $0x11
  80144f:	e8 33 fe ff ff       	call   801287 <syscall>
  801454:	83 c4 18             	add    $0x18,%esp
	return;
  801457:	90                   	nop
}
  801458:	c9                   	leave  
  801459:	c3                   	ret    

0080145a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80145a:	55                   	push   %ebp
  80145b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	ff 75 0c             	pushl  0xc(%ebp)
  801466:	ff 75 08             	pushl  0x8(%ebp)
  801469:	6a 12                	push   $0x12
  80146b:	e8 17 fe ff ff       	call   801287 <syscall>
  801470:	83 c4 18             	add    $0x18,%esp
	return ;
  801473:	90                   	nop
}
  801474:	c9                   	leave  
  801475:	c3                   	ret    

00801476 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801476:	55                   	push   %ebp
  801477:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 0e                	push   $0xe
  801485:	e8 fd fd ff ff       	call   801287 <syscall>
  80148a:	83 c4 18             	add    $0x18,%esp
}
  80148d:	c9                   	leave  
  80148e:	c3                   	ret    

0080148f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80148f:	55                   	push   %ebp
  801490:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	ff 75 08             	pushl  0x8(%ebp)
  80149d:	6a 0f                	push   $0xf
  80149f:	e8 e3 fd ff ff       	call   801287 <syscall>
  8014a4:	83 c4 18             	add    $0x18,%esp
}
  8014a7:	c9                   	leave  
  8014a8:	c3                   	ret    

008014a9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014a9:	55                   	push   %ebp
  8014aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 10                	push   $0x10
  8014b8:	e8 ca fd ff ff       	call   801287 <syscall>
  8014bd:	83 c4 18             	add    $0x18,%esp
}
  8014c0:	90                   	nop
  8014c1:	c9                   	leave  
  8014c2:	c3                   	ret    

008014c3 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014c3:	55                   	push   %ebp
  8014c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 14                	push   $0x14
  8014d2:	e8 b0 fd ff ff       	call   801287 <syscall>
  8014d7:	83 c4 18             	add    $0x18,%esp
}
  8014da:	90                   	nop
  8014db:	c9                   	leave  
  8014dc:	c3                   	ret    

008014dd <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014dd:	55                   	push   %ebp
  8014de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 15                	push   $0x15
  8014ec:	e8 96 fd ff ff       	call   801287 <syscall>
  8014f1:	83 c4 18             	add    $0x18,%esp
}
  8014f4:	90                   	nop
  8014f5:	c9                   	leave  
  8014f6:	c3                   	ret    

008014f7 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014f7:	55                   	push   %ebp
  8014f8:	89 e5                	mov    %esp,%ebp
  8014fa:	83 ec 04             	sub    $0x4,%esp
  8014fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801500:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801503:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	50                   	push   %eax
  801510:	6a 16                	push   $0x16
  801512:	e8 70 fd ff ff       	call   801287 <syscall>
  801517:	83 c4 18             	add    $0x18,%esp
}
  80151a:	90                   	nop
  80151b:	c9                   	leave  
  80151c:	c3                   	ret    

0080151d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80151d:	55                   	push   %ebp
  80151e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	6a 17                	push   $0x17
  80152c:	e8 56 fd ff ff       	call   801287 <syscall>
  801531:	83 c4 18             	add    $0x18,%esp
}
  801534:	90                   	nop
  801535:	c9                   	leave  
  801536:	c3                   	ret    

00801537 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801537:	55                   	push   %ebp
  801538:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80153a:	8b 45 08             	mov    0x8(%ebp),%eax
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	ff 75 0c             	pushl  0xc(%ebp)
  801546:	50                   	push   %eax
  801547:	6a 18                	push   $0x18
  801549:	e8 39 fd ff ff       	call   801287 <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801556:	8b 55 0c             	mov    0xc(%ebp),%edx
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	52                   	push   %edx
  801563:	50                   	push   %eax
  801564:	6a 1b                	push   $0x1b
  801566:	e8 1c fd ff ff       	call   801287 <syscall>
  80156b:	83 c4 18             	add    $0x18,%esp
}
  80156e:	c9                   	leave  
  80156f:	c3                   	ret    

00801570 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801570:	55                   	push   %ebp
  801571:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801573:	8b 55 0c             	mov    0xc(%ebp),%edx
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	52                   	push   %edx
  801580:	50                   	push   %eax
  801581:	6a 19                	push   $0x19
  801583:	e8 ff fc ff ff       	call   801287 <syscall>
  801588:	83 c4 18             	add    $0x18,%esp
}
  80158b:	90                   	nop
  80158c:	c9                   	leave  
  80158d:	c3                   	ret    

0080158e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80158e:	55                   	push   %ebp
  80158f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801591:	8b 55 0c             	mov    0xc(%ebp),%edx
  801594:	8b 45 08             	mov    0x8(%ebp),%eax
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	52                   	push   %edx
  80159e:	50                   	push   %eax
  80159f:	6a 1a                	push   $0x1a
  8015a1:	e8 e1 fc ff ff       	call   801287 <syscall>
  8015a6:	83 c4 18             	add    $0x18,%esp
}
  8015a9:	90                   	nop
  8015aa:	c9                   	leave  
  8015ab:	c3                   	ret    

008015ac <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015ac:	55                   	push   %ebp
  8015ad:	89 e5                	mov    %esp,%ebp
  8015af:	83 ec 04             	sub    $0x4,%esp
  8015b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015b8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015bb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c2:	6a 00                	push   $0x0
  8015c4:	51                   	push   %ecx
  8015c5:	52                   	push   %edx
  8015c6:	ff 75 0c             	pushl  0xc(%ebp)
  8015c9:	50                   	push   %eax
  8015ca:	6a 1c                	push   $0x1c
  8015cc:	e8 b6 fc ff ff       	call   801287 <syscall>
  8015d1:	83 c4 18             	add    $0x18,%esp
}
  8015d4:	c9                   	leave  
  8015d5:	c3                   	ret    

008015d6 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	52                   	push   %edx
  8015e6:	50                   	push   %eax
  8015e7:	6a 1d                	push   $0x1d
  8015e9:	e8 99 fc ff ff       	call   801287 <syscall>
  8015ee:	83 c4 18             	add    $0x18,%esp
}
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	51                   	push   %ecx
  801604:	52                   	push   %edx
  801605:	50                   	push   %eax
  801606:	6a 1e                	push   $0x1e
  801608:	e8 7a fc ff ff       	call   801287 <syscall>
  80160d:	83 c4 18             	add    $0x18,%esp
}
  801610:	c9                   	leave  
  801611:	c3                   	ret    

00801612 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801612:	55                   	push   %ebp
  801613:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801615:	8b 55 0c             	mov    0xc(%ebp),%edx
  801618:	8b 45 08             	mov    0x8(%ebp),%eax
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	6a 00                	push   $0x0
  801621:	52                   	push   %edx
  801622:	50                   	push   %eax
  801623:	6a 1f                	push   $0x1f
  801625:	e8 5d fc ff ff       	call   801287 <syscall>
  80162a:	83 c4 18             	add    $0x18,%esp
}
  80162d:	c9                   	leave  
  80162e:	c3                   	ret    

0080162f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80162f:	55                   	push   %ebp
  801630:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	6a 20                	push   $0x20
  80163e:	e8 44 fc ff ff       	call   801287 <syscall>
  801643:	83 c4 18             	add    $0x18,%esp
}
  801646:	c9                   	leave  
  801647:	c3                   	ret    

00801648 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801648:	55                   	push   %ebp
  801649:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	6a 00                	push   $0x0
  801650:	ff 75 14             	pushl  0x14(%ebp)
  801653:	ff 75 10             	pushl  0x10(%ebp)
  801656:	ff 75 0c             	pushl  0xc(%ebp)
  801659:	50                   	push   %eax
  80165a:	6a 21                	push   $0x21
  80165c:	e8 26 fc ff ff       	call   801287 <syscall>
  801661:	83 c4 18             	add    $0x18,%esp
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	50                   	push   %eax
  801675:	6a 22                	push   $0x22
  801677:	e8 0b fc ff ff       	call   801287 <syscall>
  80167c:	83 c4 18             	add    $0x18,%esp
}
  80167f:	90                   	nop
  801680:	c9                   	leave  
  801681:	c3                   	ret    

00801682 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801685:	8b 45 08             	mov    0x8(%ebp),%eax
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	50                   	push   %eax
  801691:	6a 23                	push   $0x23
  801693:	e8 ef fb ff ff       	call   801287 <syscall>
  801698:	83 c4 18             	add    $0x18,%esp
}
  80169b:	90                   	nop
  80169c:	c9                   	leave  
  80169d:	c3                   	ret    

0080169e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80169e:	55                   	push   %ebp
  80169f:	89 e5                	mov    %esp,%ebp
  8016a1:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016a4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016a7:	8d 50 04             	lea    0x4(%eax),%edx
  8016aa:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	52                   	push   %edx
  8016b4:	50                   	push   %eax
  8016b5:	6a 24                	push   $0x24
  8016b7:	e8 cb fb ff ff       	call   801287 <syscall>
  8016bc:	83 c4 18             	add    $0x18,%esp
	return result;
  8016bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016c8:	89 01                	mov    %eax,(%ecx)
  8016ca:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d0:	c9                   	leave  
  8016d1:	c2 04 00             	ret    $0x4

008016d4 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016d4:	55                   	push   %ebp
  8016d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	ff 75 10             	pushl  0x10(%ebp)
  8016de:	ff 75 0c             	pushl  0xc(%ebp)
  8016e1:	ff 75 08             	pushl  0x8(%ebp)
  8016e4:	6a 13                	push   $0x13
  8016e6:	e8 9c fb ff ff       	call   801287 <syscall>
  8016eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ee:	90                   	nop
}
  8016ef:	c9                   	leave  
  8016f0:	c3                   	ret    

008016f1 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016f1:	55                   	push   %ebp
  8016f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 25                	push   $0x25
  801700:	e8 82 fb ff ff       	call   801287 <syscall>
  801705:	83 c4 18             	add    $0x18,%esp
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
  80170d:	83 ec 04             	sub    $0x4,%esp
  801710:	8b 45 08             	mov    0x8(%ebp),%eax
  801713:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801716:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	50                   	push   %eax
  801723:	6a 26                	push   $0x26
  801725:	e8 5d fb ff ff       	call   801287 <syscall>
  80172a:	83 c4 18             	add    $0x18,%esp
	return ;
  80172d:	90                   	nop
}
  80172e:	c9                   	leave  
  80172f:	c3                   	ret    

00801730 <rsttst>:
void rsttst()
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 28                	push   $0x28
  80173f:	e8 43 fb ff ff       	call   801287 <syscall>
  801744:	83 c4 18             	add    $0x18,%esp
	return ;
  801747:	90                   	nop
}
  801748:	c9                   	leave  
  801749:	c3                   	ret    

0080174a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80174a:	55                   	push   %ebp
  80174b:	89 e5                	mov    %esp,%ebp
  80174d:	83 ec 04             	sub    $0x4,%esp
  801750:	8b 45 14             	mov    0x14(%ebp),%eax
  801753:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801756:	8b 55 18             	mov    0x18(%ebp),%edx
  801759:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80175d:	52                   	push   %edx
  80175e:	50                   	push   %eax
  80175f:	ff 75 10             	pushl  0x10(%ebp)
  801762:	ff 75 0c             	pushl  0xc(%ebp)
  801765:	ff 75 08             	pushl  0x8(%ebp)
  801768:	6a 27                	push   $0x27
  80176a:	e8 18 fb ff ff       	call   801287 <syscall>
  80176f:	83 c4 18             	add    $0x18,%esp
	return ;
  801772:	90                   	nop
}
  801773:	c9                   	leave  
  801774:	c3                   	ret    

00801775 <chktst>:
void chktst(uint32 n)
{
  801775:	55                   	push   %ebp
  801776:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	ff 75 08             	pushl  0x8(%ebp)
  801783:	6a 29                	push   $0x29
  801785:	e8 fd fa ff ff       	call   801287 <syscall>
  80178a:	83 c4 18             	add    $0x18,%esp
	return ;
  80178d:	90                   	nop
}
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <inctst>:

void inctst()
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 2a                	push   $0x2a
  80179f:	e8 e3 fa ff ff       	call   801287 <syscall>
  8017a4:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a7:	90                   	nop
}
  8017a8:	c9                   	leave  
  8017a9:	c3                   	ret    

008017aa <gettst>:
uint32 gettst()
{
  8017aa:	55                   	push   %ebp
  8017ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 2b                	push   $0x2b
  8017b9:	e8 c9 fa ff ff       	call   801287 <syscall>
  8017be:	83 c4 18             	add    $0x18,%esp
}
  8017c1:	c9                   	leave  
  8017c2:	c3                   	ret    

008017c3 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017c3:	55                   	push   %ebp
  8017c4:	89 e5                	mov    %esp,%ebp
  8017c6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 2c                	push   $0x2c
  8017d5:	e8 ad fa ff ff       	call   801287 <syscall>
  8017da:	83 c4 18             	add    $0x18,%esp
  8017dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017e0:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017e4:	75 07                	jne    8017ed <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017e6:	b8 01 00 00 00       	mov    $0x1,%eax
  8017eb:	eb 05                	jmp    8017f2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
  8017f7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 2c                	push   $0x2c
  801806:	e8 7c fa ff ff       	call   801287 <syscall>
  80180b:	83 c4 18             	add    $0x18,%esp
  80180e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801811:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801815:	75 07                	jne    80181e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801817:	b8 01 00 00 00       	mov    $0x1,%eax
  80181c:	eb 05                	jmp    801823 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80181e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801823:	c9                   	leave  
  801824:	c3                   	ret    

00801825 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801825:	55                   	push   %ebp
  801826:	89 e5                	mov    %esp,%ebp
  801828:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 2c                	push   $0x2c
  801837:	e8 4b fa ff ff       	call   801287 <syscall>
  80183c:	83 c4 18             	add    $0x18,%esp
  80183f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801842:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801846:	75 07                	jne    80184f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801848:	b8 01 00 00 00       	mov    $0x1,%eax
  80184d:	eb 05                	jmp    801854 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80184f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801854:	c9                   	leave  
  801855:	c3                   	ret    

00801856 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801856:	55                   	push   %ebp
  801857:	89 e5                	mov    %esp,%ebp
  801859:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 2c                	push   $0x2c
  801868:	e8 1a fa ff ff       	call   801287 <syscall>
  80186d:	83 c4 18             	add    $0x18,%esp
  801870:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801873:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801877:	75 07                	jne    801880 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801879:	b8 01 00 00 00       	mov    $0x1,%eax
  80187e:	eb 05                	jmp    801885 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801880:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	ff 75 08             	pushl  0x8(%ebp)
  801895:	6a 2d                	push   $0x2d
  801897:	e8 eb f9 ff ff       	call   801287 <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
	return ;
  80189f:	90                   	nop
}
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
  8018a5:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018a6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018a9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018af:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b2:	6a 00                	push   $0x0
  8018b4:	53                   	push   %ebx
  8018b5:	51                   	push   %ecx
  8018b6:	52                   	push   %edx
  8018b7:	50                   	push   %eax
  8018b8:	6a 2e                	push   $0x2e
  8018ba:	e8 c8 f9 ff ff       	call   801287 <syscall>
  8018bf:	83 c4 18             	add    $0x18,%esp
}
  8018c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	52                   	push   %edx
  8018d7:	50                   	push   %eax
  8018d8:	6a 2f                	push   $0x2f
  8018da:	e8 a8 f9 ff ff       	call   801287 <syscall>
  8018df:	83 c4 18             	add    $0x18,%esp
}
  8018e2:	c9                   	leave  
  8018e3:	c3                   	ret    

008018e4 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018e4:	55                   	push   %ebp
  8018e5:	89 e5                	mov    %esp,%ebp
  8018e7:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018ea:	8b 55 08             	mov    0x8(%ebp),%edx
  8018ed:	89 d0                	mov    %edx,%eax
  8018ef:	c1 e0 02             	shl    $0x2,%eax
  8018f2:	01 d0                	add    %edx,%eax
  8018f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018fb:	01 d0                	add    %edx,%eax
  8018fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801904:	01 d0                	add    %edx,%eax
  801906:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80190d:	01 d0                	add    %edx,%eax
  80190f:	c1 e0 04             	shl    $0x4,%eax
  801912:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801915:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80191c:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80191f:	83 ec 0c             	sub    $0xc,%esp
  801922:	50                   	push   %eax
  801923:	e8 76 fd ff ff       	call   80169e <sys_get_virtual_time>
  801928:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  80192b:	eb 41                	jmp    80196e <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80192d:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801930:	83 ec 0c             	sub    $0xc,%esp
  801933:	50                   	push   %eax
  801934:	e8 65 fd ff ff       	call   80169e <sys_get_virtual_time>
  801939:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80193c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80193f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801942:	29 c2                	sub    %eax,%edx
  801944:	89 d0                	mov    %edx,%eax
  801946:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801949:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80194c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80194f:	89 d1                	mov    %edx,%ecx
  801951:	29 c1                	sub    %eax,%ecx
  801953:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801956:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801959:	39 c2                	cmp    %eax,%edx
  80195b:	0f 97 c0             	seta   %al
  80195e:	0f b6 c0             	movzbl %al,%eax
  801961:	29 c1                	sub    %eax,%ecx
  801963:	89 c8                	mov    %ecx,%eax
  801965:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801968:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80196b:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80196e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801971:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801974:	72 b7                	jb     80192d <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801976:	90                   	nop
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
  80197c:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80197f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801986:	eb 03                	jmp    80198b <busy_wait+0x12>
  801988:	ff 45 fc             	incl   -0x4(%ebp)
  80198b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80198e:	3b 45 08             	cmp    0x8(%ebp),%eax
  801991:	72 f5                	jb     801988 <busy_wait+0xf>
	return i;
  801993:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801996:	c9                   	leave  
  801997:	c3                   	ret    

00801998 <__udivdi3>:
  801998:	55                   	push   %ebp
  801999:	57                   	push   %edi
  80199a:	56                   	push   %esi
  80199b:	53                   	push   %ebx
  80199c:	83 ec 1c             	sub    $0x1c,%esp
  80199f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019a3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019af:	89 ca                	mov    %ecx,%edx
  8019b1:	89 f8                	mov    %edi,%eax
  8019b3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019b7:	85 f6                	test   %esi,%esi
  8019b9:	75 2d                	jne    8019e8 <__udivdi3+0x50>
  8019bb:	39 cf                	cmp    %ecx,%edi
  8019bd:	77 65                	ja     801a24 <__udivdi3+0x8c>
  8019bf:	89 fd                	mov    %edi,%ebp
  8019c1:	85 ff                	test   %edi,%edi
  8019c3:	75 0b                	jne    8019d0 <__udivdi3+0x38>
  8019c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ca:	31 d2                	xor    %edx,%edx
  8019cc:	f7 f7                	div    %edi
  8019ce:	89 c5                	mov    %eax,%ebp
  8019d0:	31 d2                	xor    %edx,%edx
  8019d2:	89 c8                	mov    %ecx,%eax
  8019d4:	f7 f5                	div    %ebp
  8019d6:	89 c1                	mov    %eax,%ecx
  8019d8:	89 d8                	mov    %ebx,%eax
  8019da:	f7 f5                	div    %ebp
  8019dc:	89 cf                	mov    %ecx,%edi
  8019de:	89 fa                	mov    %edi,%edx
  8019e0:	83 c4 1c             	add    $0x1c,%esp
  8019e3:	5b                   	pop    %ebx
  8019e4:	5e                   	pop    %esi
  8019e5:	5f                   	pop    %edi
  8019e6:	5d                   	pop    %ebp
  8019e7:	c3                   	ret    
  8019e8:	39 ce                	cmp    %ecx,%esi
  8019ea:	77 28                	ja     801a14 <__udivdi3+0x7c>
  8019ec:	0f bd fe             	bsr    %esi,%edi
  8019ef:	83 f7 1f             	xor    $0x1f,%edi
  8019f2:	75 40                	jne    801a34 <__udivdi3+0x9c>
  8019f4:	39 ce                	cmp    %ecx,%esi
  8019f6:	72 0a                	jb     801a02 <__udivdi3+0x6a>
  8019f8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019fc:	0f 87 9e 00 00 00    	ja     801aa0 <__udivdi3+0x108>
  801a02:	b8 01 00 00 00       	mov    $0x1,%eax
  801a07:	89 fa                	mov    %edi,%edx
  801a09:	83 c4 1c             	add    $0x1c,%esp
  801a0c:	5b                   	pop    %ebx
  801a0d:	5e                   	pop    %esi
  801a0e:	5f                   	pop    %edi
  801a0f:	5d                   	pop    %ebp
  801a10:	c3                   	ret    
  801a11:	8d 76 00             	lea    0x0(%esi),%esi
  801a14:	31 ff                	xor    %edi,%edi
  801a16:	31 c0                	xor    %eax,%eax
  801a18:	89 fa                	mov    %edi,%edx
  801a1a:	83 c4 1c             	add    $0x1c,%esp
  801a1d:	5b                   	pop    %ebx
  801a1e:	5e                   	pop    %esi
  801a1f:	5f                   	pop    %edi
  801a20:	5d                   	pop    %ebp
  801a21:	c3                   	ret    
  801a22:	66 90                	xchg   %ax,%ax
  801a24:	89 d8                	mov    %ebx,%eax
  801a26:	f7 f7                	div    %edi
  801a28:	31 ff                	xor    %edi,%edi
  801a2a:	89 fa                	mov    %edi,%edx
  801a2c:	83 c4 1c             	add    $0x1c,%esp
  801a2f:	5b                   	pop    %ebx
  801a30:	5e                   	pop    %esi
  801a31:	5f                   	pop    %edi
  801a32:	5d                   	pop    %ebp
  801a33:	c3                   	ret    
  801a34:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a39:	89 eb                	mov    %ebp,%ebx
  801a3b:	29 fb                	sub    %edi,%ebx
  801a3d:	89 f9                	mov    %edi,%ecx
  801a3f:	d3 e6                	shl    %cl,%esi
  801a41:	89 c5                	mov    %eax,%ebp
  801a43:	88 d9                	mov    %bl,%cl
  801a45:	d3 ed                	shr    %cl,%ebp
  801a47:	89 e9                	mov    %ebp,%ecx
  801a49:	09 f1                	or     %esi,%ecx
  801a4b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a4f:	89 f9                	mov    %edi,%ecx
  801a51:	d3 e0                	shl    %cl,%eax
  801a53:	89 c5                	mov    %eax,%ebp
  801a55:	89 d6                	mov    %edx,%esi
  801a57:	88 d9                	mov    %bl,%cl
  801a59:	d3 ee                	shr    %cl,%esi
  801a5b:	89 f9                	mov    %edi,%ecx
  801a5d:	d3 e2                	shl    %cl,%edx
  801a5f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a63:	88 d9                	mov    %bl,%cl
  801a65:	d3 e8                	shr    %cl,%eax
  801a67:	09 c2                	or     %eax,%edx
  801a69:	89 d0                	mov    %edx,%eax
  801a6b:	89 f2                	mov    %esi,%edx
  801a6d:	f7 74 24 0c          	divl   0xc(%esp)
  801a71:	89 d6                	mov    %edx,%esi
  801a73:	89 c3                	mov    %eax,%ebx
  801a75:	f7 e5                	mul    %ebp
  801a77:	39 d6                	cmp    %edx,%esi
  801a79:	72 19                	jb     801a94 <__udivdi3+0xfc>
  801a7b:	74 0b                	je     801a88 <__udivdi3+0xf0>
  801a7d:	89 d8                	mov    %ebx,%eax
  801a7f:	31 ff                	xor    %edi,%edi
  801a81:	e9 58 ff ff ff       	jmp    8019de <__udivdi3+0x46>
  801a86:	66 90                	xchg   %ax,%ax
  801a88:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a8c:	89 f9                	mov    %edi,%ecx
  801a8e:	d3 e2                	shl    %cl,%edx
  801a90:	39 c2                	cmp    %eax,%edx
  801a92:	73 e9                	jae    801a7d <__udivdi3+0xe5>
  801a94:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a97:	31 ff                	xor    %edi,%edi
  801a99:	e9 40 ff ff ff       	jmp    8019de <__udivdi3+0x46>
  801a9e:	66 90                	xchg   %ax,%ax
  801aa0:	31 c0                	xor    %eax,%eax
  801aa2:	e9 37 ff ff ff       	jmp    8019de <__udivdi3+0x46>
  801aa7:	90                   	nop

00801aa8 <__umoddi3>:
  801aa8:	55                   	push   %ebp
  801aa9:	57                   	push   %edi
  801aaa:	56                   	push   %esi
  801aab:	53                   	push   %ebx
  801aac:	83 ec 1c             	sub    $0x1c,%esp
  801aaf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ab3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ab7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801abb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801abf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ac3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ac7:	89 f3                	mov    %esi,%ebx
  801ac9:	89 fa                	mov    %edi,%edx
  801acb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801acf:	89 34 24             	mov    %esi,(%esp)
  801ad2:	85 c0                	test   %eax,%eax
  801ad4:	75 1a                	jne    801af0 <__umoddi3+0x48>
  801ad6:	39 f7                	cmp    %esi,%edi
  801ad8:	0f 86 a2 00 00 00    	jbe    801b80 <__umoddi3+0xd8>
  801ade:	89 c8                	mov    %ecx,%eax
  801ae0:	89 f2                	mov    %esi,%edx
  801ae2:	f7 f7                	div    %edi
  801ae4:	89 d0                	mov    %edx,%eax
  801ae6:	31 d2                	xor    %edx,%edx
  801ae8:	83 c4 1c             	add    $0x1c,%esp
  801aeb:	5b                   	pop    %ebx
  801aec:	5e                   	pop    %esi
  801aed:	5f                   	pop    %edi
  801aee:	5d                   	pop    %ebp
  801aef:	c3                   	ret    
  801af0:	39 f0                	cmp    %esi,%eax
  801af2:	0f 87 ac 00 00 00    	ja     801ba4 <__umoddi3+0xfc>
  801af8:	0f bd e8             	bsr    %eax,%ebp
  801afb:	83 f5 1f             	xor    $0x1f,%ebp
  801afe:	0f 84 ac 00 00 00    	je     801bb0 <__umoddi3+0x108>
  801b04:	bf 20 00 00 00       	mov    $0x20,%edi
  801b09:	29 ef                	sub    %ebp,%edi
  801b0b:	89 fe                	mov    %edi,%esi
  801b0d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b11:	89 e9                	mov    %ebp,%ecx
  801b13:	d3 e0                	shl    %cl,%eax
  801b15:	89 d7                	mov    %edx,%edi
  801b17:	89 f1                	mov    %esi,%ecx
  801b19:	d3 ef                	shr    %cl,%edi
  801b1b:	09 c7                	or     %eax,%edi
  801b1d:	89 e9                	mov    %ebp,%ecx
  801b1f:	d3 e2                	shl    %cl,%edx
  801b21:	89 14 24             	mov    %edx,(%esp)
  801b24:	89 d8                	mov    %ebx,%eax
  801b26:	d3 e0                	shl    %cl,%eax
  801b28:	89 c2                	mov    %eax,%edx
  801b2a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b2e:	d3 e0                	shl    %cl,%eax
  801b30:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b34:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b38:	89 f1                	mov    %esi,%ecx
  801b3a:	d3 e8                	shr    %cl,%eax
  801b3c:	09 d0                	or     %edx,%eax
  801b3e:	d3 eb                	shr    %cl,%ebx
  801b40:	89 da                	mov    %ebx,%edx
  801b42:	f7 f7                	div    %edi
  801b44:	89 d3                	mov    %edx,%ebx
  801b46:	f7 24 24             	mull   (%esp)
  801b49:	89 c6                	mov    %eax,%esi
  801b4b:	89 d1                	mov    %edx,%ecx
  801b4d:	39 d3                	cmp    %edx,%ebx
  801b4f:	0f 82 87 00 00 00    	jb     801bdc <__umoddi3+0x134>
  801b55:	0f 84 91 00 00 00    	je     801bec <__umoddi3+0x144>
  801b5b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b5f:	29 f2                	sub    %esi,%edx
  801b61:	19 cb                	sbb    %ecx,%ebx
  801b63:	89 d8                	mov    %ebx,%eax
  801b65:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b69:	d3 e0                	shl    %cl,%eax
  801b6b:	89 e9                	mov    %ebp,%ecx
  801b6d:	d3 ea                	shr    %cl,%edx
  801b6f:	09 d0                	or     %edx,%eax
  801b71:	89 e9                	mov    %ebp,%ecx
  801b73:	d3 eb                	shr    %cl,%ebx
  801b75:	89 da                	mov    %ebx,%edx
  801b77:	83 c4 1c             	add    $0x1c,%esp
  801b7a:	5b                   	pop    %ebx
  801b7b:	5e                   	pop    %esi
  801b7c:	5f                   	pop    %edi
  801b7d:	5d                   	pop    %ebp
  801b7e:	c3                   	ret    
  801b7f:	90                   	nop
  801b80:	89 fd                	mov    %edi,%ebp
  801b82:	85 ff                	test   %edi,%edi
  801b84:	75 0b                	jne    801b91 <__umoddi3+0xe9>
  801b86:	b8 01 00 00 00       	mov    $0x1,%eax
  801b8b:	31 d2                	xor    %edx,%edx
  801b8d:	f7 f7                	div    %edi
  801b8f:	89 c5                	mov    %eax,%ebp
  801b91:	89 f0                	mov    %esi,%eax
  801b93:	31 d2                	xor    %edx,%edx
  801b95:	f7 f5                	div    %ebp
  801b97:	89 c8                	mov    %ecx,%eax
  801b99:	f7 f5                	div    %ebp
  801b9b:	89 d0                	mov    %edx,%eax
  801b9d:	e9 44 ff ff ff       	jmp    801ae6 <__umoddi3+0x3e>
  801ba2:	66 90                	xchg   %ax,%ax
  801ba4:	89 c8                	mov    %ecx,%eax
  801ba6:	89 f2                	mov    %esi,%edx
  801ba8:	83 c4 1c             	add    $0x1c,%esp
  801bab:	5b                   	pop    %ebx
  801bac:	5e                   	pop    %esi
  801bad:	5f                   	pop    %edi
  801bae:	5d                   	pop    %ebp
  801baf:	c3                   	ret    
  801bb0:	3b 04 24             	cmp    (%esp),%eax
  801bb3:	72 06                	jb     801bbb <__umoddi3+0x113>
  801bb5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801bb9:	77 0f                	ja     801bca <__umoddi3+0x122>
  801bbb:	89 f2                	mov    %esi,%edx
  801bbd:	29 f9                	sub    %edi,%ecx
  801bbf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801bc3:	89 14 24             	mov    %edx,(%esp)
  801bc6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bca:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bce:	8b 14 24             	mov    (%esp),%edx
  801bd1:	83 c4 1c             	add    $0x1c,%esp
  801bd4:	5b                   	pop    %ebx
  801bd5:	5e                   	pop    %esi
  801bd6:	5f                   	pop    %edi
  801bd7:	5d                   	pop    %ebp
  801bd8:	c3                   	ret    
  801bd9:	8d 76 00             	lea    0x0(%esi),%esi
  801bdc:	2b 04 24             	sub    (%esp),%eax
  801bdf:	19 fa                	sbb    %edi,%edx
  801be1:	89 d1                	mov    %edx,%ecx
  801be3:	89 c6                	mov    %eax,%esi
  801be5:	e9 71 ff ff ff       	jmp    801b5b <__umoddi3+0xb3>
  801bea:	66 90                	xchg   %ax,%ax
  801bec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bf0:	72 ea                	jb     801bdc <__umoddi3+0x134>
  801bf2:	89 d9                	mov    %ebx,%ecx
  801bf4:	e9 62 ff ff ff       	jmp    801b5b <__umoddi3+0xb3>

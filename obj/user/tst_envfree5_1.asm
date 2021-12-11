
obj/user/tst_envfree5_1:     file format elf32-i386


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
  800031:	e8 10 01 00 00       	call   800146 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests the usage of shared variables
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	// Testing removing the shared variables
	// Testing scenario 5_1: Kill ONE program has shared variables and it free it
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	6a 01                	push   $0x1
  800043:	6a 04                	push   $0x4
  800045:	68 80 1c 80 00       	push   $0x801c80
  80004a:	e8 9c 12 00 00       	call   8012eb <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*numOfFinished = 0 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int freeFrames_before = sys_calculate_free_frames() ;
  80005e:	e8 b0 14 00 00       	call   801513 <sys_calculate_free_frames>
  800063:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800066:	e8 2b 15 00 00       	call   801596 <sys_pf_calculate_allocated_pages>
  80006b:	89 45 ec             	mov    %eax,-0x14(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80006e:	83 ec 08             	sub    $0x8,%esp
  800071:	ff 75 f0             	pushl  -0x10(%ebp)
  800074:	68 90 1c 80 00       	push   $0x801c90
  800079:	e8 af 04 00 00       	call   80052d <cprintf>
  80007e:	83 c4 10             	add    $0x10,%esp

	int32 envIdProcessA = sys_create_env("ef_tshr4", 2000,(myEnv->SecondListSize), 50);
  800081:	a1 20 30 80 00       	mov    0x803020,%eax
  800086:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80008c:	6a 32                	push   $0x32
  80008e:	50                   	push   %eax
  80008f:	68 d0 07 00 00       	push   $0x7d0
  800094:	68 c3 1c 80 00       	push   $0x801cc3
  800099:	e8 ca 16 00 00       	call   801768 <sys_create_env>
  80009e:	83 c4 10             	add    $0x10,%esp
  8000a1:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_run_env(envIdProcessA);
  8000a4:	83 ec 0c             	sub    $0xc,%esp
  8000a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8000aa:	e8 d7 16 00 00       	call   801786 <sys_run_env>
  8000af:	83 c4 10             	add    $0x10,%esp

	while (*numOfFinished != 1) ;
  8000b2:	90                   	nop
  8000b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b6:	8b 00                	mov    (%eax),%eax
  8000b8:	83 f8 01             	cmp    $0x1,%eax
  8000bb:	75 f6                	jne    8000b3 <_main+0x7b>
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000bd:	e8 51 14 00 00       	call   801513 <sys_calculate_free_frames>
  8000c2:	83 ec 08             	sub    $0x8,%esp
  8000c5:	50                   	push   %eax
  8000c6:	68 cc 1c 80 00       	push   $0x801ccc
  8000cb:	e8 5d 04 00 00       	call   80052d <cprintf>
  8000d0:	83 c4 10             	add    $0x10,%esp

	sys_free_env(envIdProcessA);
  8000d3:	83 ec 0c             	sub    $0xc,%esp
  8000d6:	ff 75 e8             	pushl  -0x18(%ebp)
  8000d9:	e8 c4 16 00 00       	call   8017a2 <sys_free_env>
  8000de:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  8000e1:	e8 2d 14 00 00       	call   801513 <sys_calculate_free_frames>
  8000e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  8000e9:	e8 a8 14 00 00       	call   801596 <sys_pf_calculate_allocated_pages>
  8000ee:	89 45 e0             	mov    %eax,-0x20(%ebp)

	if ((freeFrames_after - freeFrames_before) != 0) {
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000f7:	74 27                	je     800120 <_main+0xe8>
		cprintf("\n---# of free frames after closing running programs not as before running = %d\n", freeFrames_after);
  8000f9:	83 ec 08             	sub    $0x8,%esp
  8000fc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000ff:	68 00 1d 80 00       	push   $0x801d00
  800104:	e8 24 04 00 00       	call   80052d <cprintf>
  800109:	83 c4 10             	add    $0x10,%esp
		panic("env_free() does not work correctly... check it again.");
  80010c:	83 ec 04             	sub    $0x4,%esp
  80010f:	68 50 1d 80 00       	push   $0x801d50
  800114:	6a 1e                	push   $0x1e
  800116:	68 86 1d 80 00       	push   $0x801d86
  80011b:	e8 6b 01 00 00       	call   80028b <_panic>
	}

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  800120:	83 ec 08             	sub    $0x8,%esp
  800123:	ff 75 e4             	pushl  -0x1c(%ebp)
  800126:	68 9c 1d 80 00       	push   $0x801d9c
  80012b:	e8 fd 03 00 00       	call   80052d <cprintf>
  800130:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 5_1 for envfree completed successfully.\n");
  800133:	83 ec 0c             	sub    $0xc,%esp
  800136:	68 fc 1d 80 00       	push   $0x801dfc
  80013b:	e8 ed 03 00 00       	call   80052d <cprintf>
  800140:	83 c4 10             	add    $0x10,%esp
	return;
  800143:	90                   	nop
}
  800144:	c9                   	leave  
  800145:	c3                   	ret    

00800146 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800146:	55                   	push   %ebp
  800147:	89 e5                	mov    %esp,%ebp
  800149:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80014c:	e8 f7 12 00 00       	call   801448 <sys_getenvindex>
  800151:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800154:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800157:	89 d0                	mov    %edx,%eax
  800159:	c1 e0 03             	shl    $0x3,%eax
  80015c:	01 d0                	add    %edx,%eax
  80015e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800165:	01 c8                	add    %ecx,%eax
  800167:	01 c0                	add    %eax,%eax
  800169:	01 d0                	add    %edx,%eax
  80016b:	01 c0                	add    %eax,%eax
  80016d:	01 d0                	add    %edx,%eax
  80016f:	89 c2                	mov    %eax,%edx
  800171:	c1 e2 05             	shl    $0x5,%edx
  800174:	29 c2                	sub    %eax,%edx
  800176:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80017d:	89 c2                	mov    %eax,%edx
  80017f:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800185:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80018a:	a1 20 30 80 00       	mov    0x803020,%eax
  80018f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800195:	84 c0                	test   %al,%al
  800197:	74 0f                	je     8001a8 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800199:	a1 20 30 80 00       	mov    0x803020,%eax
  80019e:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001a3:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001a8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001ac:	7e 0a                	jle    8001b8 <libmain+0x72>
		binaryname = argv[0];
  8001ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b1:	8b 00                	mov    (%eax),%eax
  8001b3:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001b8:	83 ec 08             	sub    $0x8,%esp
  8001bb:	ff 75 0c             	pushl  0xc(%ebp)
  8001be:	ff 75 08             	pushl  0x8(%ebp)
  8001c1:	e8 72 fe ff ff       	call   800038 <_main>
  8001c6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001c9:	e8 15 14 00 00       	call   8015e3 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001ce:	83 ec 0c             	sub    $0xc,%esp
  8001d1:	68 60 1e 80 00       	push   $0x801e60
  8001d6:	e8 52 03 00 00       	call   80052d <cprintf>
  8001db:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001de:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e3:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ee:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001f4:	83 ec 04             	sub    $0x4,%esp
  8001f7:	52                   	push   %edx
  8001f8:	50                   	push   %eax
  8001f9:	68 88 1e 80 00       	push   $0x801e88
  8001fe:	e8 2a 03 00 00       	call   80052d <cprintf>
  800203:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800206:	a1 20 30 80 00       	mov    0x803020,%eax
  80020b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800211:	a1 20 30 80 00       	mov    0x803020,%eax
  800216:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80021c:	83 ec 04             	sub    $0x4,%esp
  80021f:	52                   	push   %edx
  800220:	50                   	push   %eax
  800221:	68 b0 1e 80 00       	push   $0x801eb0
  800226:	e8 02 03 00 00       	call   80052d <cprintf>
  80022b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80022e:	a1 20 30 80 00       	mov    0x803020,%eax
  800233:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800239:	83 ec 08             	sub    $0x8,%esp
  80023c:	50                   	push   %eax
  80023d:	68 f1 1e 80 00       	push   $0x801ef1
  800242:	e8 e6 02 00 00       	call   80052d <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 60 1e 80 00       	push   $0x801e60
  800252:	e8 d6 02 00 00       	call   80052d <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80025a:	e8 9e 13 00 00       	call   8015fd <sys_enable_interrupt>

	// exit gracefully
	exit();
  80025f:	e8 19 00 00 00       	call   80027d <exit>
}
  800264:	90                   	nop
  800265:	c9                   	leave  
  800266:	c3                   	ret    

00800267 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800267:	55                   	push   %ebp
  800268:	89 e5                	mov    %esp,%ebp
  80026a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80026d:	83 ec 0c             	sub    $0xc,%esp
  800270:	6a 00                	push   $0x0
  800272:	e8 9d 11 00 00       	call   801414 <sys_env_destroy>
  800277:	83 c4 10             	add    $0x10,%esp
}
  80027a:	90                   	nop
  80027b:	c9                   	leave  
  80027c:	c3                   	ret    

0080027d <exit>:

void
exit(void)
{
  80027d:	55                   	push   %ebp
  80027e:	89 e5                	mov    %esp,%ebp
  800280:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800283:	e8 f2 11 00 00       	call   80147a <sys_env_exit>
}
  800288:	90                   	nop
  800289:	c9                   	leave  
  80028a:	c3                   	ret    

0080028b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80028b:	55                   	push   %ebp
  80028c:	89 e5                	mov    %esp,%ebp
  80028e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800291:	8d 45 10             	lea    0x10(%ebp),%eax
  800294:	83 c0 04             	add    $0x4,%eax
  800297:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80029a:	a1 18 31 80 00       	mov    0x803118,%eax
  80029f:	85 c0                	test   %eax,%eax
  8002a1:	74 16                	je     8002b9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002a3:	a1 18 31 80 00       	mov    0x803118,%eax
  8002a8:	83 ec 08             	sub    $0x8,%esp
  8002ab:	50                   	push   %eax
  8002ac:	68 08 1f 80 00       	push   $0x801f08
  8002b1:	e8 77 02 00 00       	call   80052d <cprintf>
  8002b6:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002b9:	a1 00 30 80 00       	mov    0x803000,%eax
  8002be:	ff 75 0c             	pushl  0xc(%ebp)
  8002c1:	ff 75 08             	pushl  0x8(%ebp)
  8002c4:	50                   	push   %eax
  8002c5:	68 0d 1f 80 00       	push   $0x801f0d
  8002ca:	e8 5e 02 00 00       	call   80052d <cprintf>
  8002cf:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d5:	83 ec 08             	sub    $0x8,%esp
  8002d8:	ff 75 f4             	pushl  -0xc(%ebp)
  8002db:	50                   	push   %eax
  8002dc:	e8 e1 01 00 00       	call   8004c2 <vcprintf>
  8002e1:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002e4:	83 ec 08             	sub    $0x8,%esp
  8002e7:	6a 00                	push   $0x0
  8002e9:	68 29 1f 80 00       	push   $0x801f29
  8002ee:	e8 cf 01 00 00       	call   8004c2 <vcprintf>
  8002f3:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002f6:	e8 82 ff ff ff       	call   80027d <exit>

	// should not return here
	while (1) ;
  8002fb:	eb fe                	jmp    8002fb <_panic+0x70>

008002fd <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002fd:	55                   	push   %ebp
  8002fe:	89 e5                	mov    %esp,%ebp
  800300:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800303:	a1 20 30 80 00       	mov    0x803020,%eax
  800308:	8b 50 74             	mov    0x74(%eax),%edx
  80030b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030e:	39 c2                	cmp    %eax,%edx
  800310:	74 14                	je     800326 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800312:	83 ec 04             	sub    $0x4,%esp
  800315:	68 2c 1f 80 00       	push   $0x801f2c
  80031a:	6a 26                	push   $0x26
  80031c:	68 78 1f 80 00       	push   $0x801f78
  800321:	e8 65 ff ff ff       	call   80028b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800326:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80032d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800334:	e9 b6 00 00 00       	jmp    8003ef <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800339:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800343:	8b 45 08             	mov    0x8(%ebp),%eax
  800346:	01 d0                	add    %edx,%eax
  800348:	8b 00                	mov    (%eax),%eax
  80034a:	85 c0                	test   %eax,%eax
  80034c:	75 08                	jne    800356 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80034e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800351:	e9 96 00 00 00       	jmp    8003ec <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800356:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80035d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800364:	eb 5d                	jmp    8003c3 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800366:	a1 20 30 80 00       	mov    0x803020,%eax
  80036b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800371:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800374:	c1 e2 04             	shl    $0x4,%edx
  800377:	01 d0                	add    %edx,%eax
  800379:	8a 40 04             	mov    0x4(%eax),%al
  80037c:	84 c0                	test   %al,%al
  80037e:	75 40                	jne    8003c0 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800380:	a1 20 30 80 00       	mov    0x803020,%eax
  800385:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80038b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80038e:	c1 e2 04             	shl    $0x4,%edx
  800391:	01 d0                	add    %edx,%eax
  800393:	8b 00                	mov    (%eax),%eax
  800395:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800398:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80039b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003a0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8003af:	01 c8                	add    %ecx,%eax
  8003b1:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003b3:	39 c2                	cmp    %eax,%edx
  8003b5:	75 09                	jne    8003c0 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8003b7:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003be:	eb 12                	jmp    8003d2 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003c0:	ff 45 e8             	incl   -0x18(%ebp)
  8003c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c8:	8b 50 74             	mov    0x74(%eax),%edx
  8003cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003ce:	39 c2                	cmp    %eax,%edx
  8003d0:	77 94                	ja     800366 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003d2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003d6:	75 14                	jne    8003ec <CheckWSWithoutLastIndex+0xef>
			panic(
  8003d8:	83 ec 04             	sub    $0x4,%esp
  8003db:	68 84 1f 80 00       	push   $0x801f84
  8003e0:	6a 3a                	push   $0x3a
  8003e2:	68 78 1f 80 00       	push   $0x801f78
  8003e7:	e8 9f fe ff ff       	call   80028b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003ec:	ff 45 f0             	incl   -0x10(%ebp)
  8003ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003f5:	0f 8c 3e ff ff ff    	jl     800339 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003fb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800402:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800409:	eb 20                	jmp    80042b <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80040b:	a1 20 30 80 00       	mov    0x803020,%eax
  800410:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800416:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800419:	c1 e2 04             	shl    $0x4,%edx
  80041c:	01 d0                	add    %edx,%eax
  80041e:	8a 40 04             	mov    0x4(%eax),%al
  800421:	3c 01                	cmp    $0x1,%al
  800423:	75 03                	jne    800428 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800425:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800428:	ff 45 e0             	incl   -0x20(%ebp)
  80042b:	a1 20 30 80 00       	mov    0x803020,%eax
  800430:	8b 50 74             	mov    0x74(%eax),%edx
  800433:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800436:	39 c2                	cmp    %eax,%edx
  800438:	77 d1                	ja     80040b <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80043a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80043d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800440:	74 14                	je     800456 <CheckWSWithoutLastIndex+0x159>
		panic(
  800442:	83 ec 04             	sub    $0x4,%esp
  800445:	68 d8 1f 80 00       	push   $0x801fd8
  80044a:	6a 44                	push   $0x44
  80044c:	68 78 1f 80 00       	push   $0x801f78
  800451:	e8 35 fe ff ff       	call   80028b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800456:	90                   	nop
  800457:	c9                   	leave  
  800458:	c3                   	ret    

00800459 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800459:	55                   	push   %ebp
  80045a:	89 e5                	mov    %esp,%ebp
  80045c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80045f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	8d 48 01             	lea    0x1(%eax),%ecx
  800467:	8b 55 0c             	mov    0xc(%ebp),%edx
  80046a:	89 0a                	mov    %ecx,(%edx)
  80046c:	8b 55 08             	mov    0x8(%ebp),%edx
  80046f:	88 d1                	mov    %dl,%cl
  800471:	8b 55 0c             	mov    0xc(%ebp),%edx
  800474:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800482:	75 2c                	jne    8004b0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800484:	a0 24 30 80 00       	mov    0x803024,%al
  800489:	0f b6 c0             	movzbl %al,%eax
  80048c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80048f:	8b 12                	mov    (%edx),%edx
  800491:	89 d1                	mov    %edx,%ecx
  800493:	8b 55 0c             	mov    0xc(%ebp),%edx
  800496:	83 c2 08             	add    $0x8,%edx
  800499:	83 ec 04             	sub    $0x4,%esp
  80049c:	50                   	push   %eax
  80049d:	51                   	push   %ecx
  80049e:	52                   	push   %edx
  80049f:	e8 2e 0f 00 00       	call   8013d2 <sys_cputs>
  8004a4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b3:	8b 40 04             	mov    0x4(%eax),%eax
  8004b6:	8d 50 01             	lea    0x1(%eax),%edx
  8004b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bc:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004bf:	90                   	nop
  8004c0:	c9                   	leave  
  8004c1:	c3                   	ret    

008004c2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004c2:	55                   	push   %ebp
  8004c3:	89 e5                	mov    %esp,%ebp
  8004c5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004cb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004d2:	00 00 00 
	b.cnt = 0;
  8004d5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004dc:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004df:	ff 75 0c             	pushl  0xc(%ebp)
  8004e2:	ff 75 08             	pushl  0x8(%ebp)
  8004e5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004eb:	50                   	push   %eax
  8004ec:	68 59 04 80 00       	push   $0x800459
  8004f1:	e8 11 02 00 00       	call   800707 <vprintfmt>
  8004f6:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004f9:	a0 24 30 80 00       	mov    0x803024,%al
  8004fe:	0f b6 c0             	movzbl %al,%eax
  800501:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800507:	83 ec 04             	sub    $0x4,%esp
  80050a:	50                   	push   %eax
  80050b:	52                   	push   %edx
  80050c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800512:	83 c0 08             	add    $0x8,%eax
  800515:	50                   	push   %eax
  800516:	e8 b7 0e 00 00       	call   8013d2 <sys_cputs>
  80051b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80051e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800525:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80052b:	c9                   	leave  
  80052c:	c3                   	ret    

0080052d <cprintf>:

int cprintf(const char *fmt, ...) {
  80052d:	55                   	push   %ebp
  80052e:	89 e5                	mov    %esp,%ebp
  800530:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800533:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80053a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80053d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800540:	8b 45 08             	mov    0x8(%ebp),%eax
  800543:	83 ec 08             	sub    $0x8,%esp
  800546:	ff 75 f4             	pushl  -0xc(%ebp)
  800549:	50                   	push   %eax
  80054a:	e8 73 ff ff ff       	call   8004c2 <vcprintf>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800555:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800558:	c9                   	leave  
  800559:	c3                   	ret    

0080055a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80055a:	55                   	push   %ebp
  80055b:	89 e5                	mov    %esp,%ebp
  80055d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800560:	e8 7e 10 00 00       	call   8015e3 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800565:	8d 45 0c             	lea    0xc(%ebp),%eax
  800568:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80056b:	8b 45 08             	mov    0x8(%ebp),%eax
  80056e:	83 ec 08             	sub    $0x8,%esp
  800571:	ff 75 f4             	pushl  -0xc(%ebp)
  800574:	50                   	push   %eax
  800575:	e8 48 ff ff ff       	call   8004c2 <vcprintf>
  80057a:	83 c4 10             	add    $0x10,%esp
  80057d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800580:	e8 78 10 00 00       	call   8015fd <sys_enable_interrupt>
	return cnt;
  800585:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800588:	c9                   	leave  
  800589:	c3                   	ret    

0080058a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80058a:	55                   	push   %ebp
  80058b:	89 e5                	mov    %esp,%ebp
  80058d:	53                   	push   %ebx
  80058e:	83 ec 14             	sub    $0x14,%esp
  800591:	8b 45 10             	mov    0x10(%ebp),%eax
  800594:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800597:	8b 45 14             	mov    0x14(%ebp),%eax
  80059a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80059d:	8b 45 18             	mov    0x18(%ebp),%eax
  8005a0:	ba 00 00 00 00       	mov    $0x0,%edx
  8005a5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005a8:	77 55                	ja     8005ff <printnum+0x75>
  8005aa:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005ad:	72 05                	jb     8005b4 <printnum+0x2a>
  8005af:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005b2:	77 4b                	ja     8005ff <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005b4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005b7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005ba:	8b 45 18             	mov    0x18(%ebp),%eax
  8005bd:	ba 00 00 00 00       	mov    $0x0,%edx
  8005c2:	52                   	push   %edx
  8005c3:	50                   	push   %eax
  8005c4:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8005ca:	e8 35 14 00 00       	call   801a04 <__udivdi3>
  8005cf:	83 c4 10             	add    $0x10,%esp
  8005d2:	83 ec 04             	sub    $0x4,%esp
  8005d5:	ff 75 20             	pushl  0x20(%ebp)
  8005d8:	53                   	push   %ebx
  8005d9:	ff 75 18             	pushl  0x18(%ebp)
  8005dc:	52                   	push   %edx
  8005dd:	50                   	push   %eax
  8005de:	ff 75 0c             	pushl  0xc(%ebp)
  8005e1:	ff 75 08             	pushl  0x8(%ebp)
  8005e4:	e8 a1 ff ff ff       	call   80058a <printnum>
  8005e9:	83 c4 20             	add    $0x20,%esp
  8005ec:	eb 1a                	jmp    800608 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005ee:	83 ec 08             	sub    $0x8,%esp
  8005f1:	ff 75 0c             	pushl  0xc(%ebp)
  8005f4:	ff 75 20             	pushl  0x20(%ebp)
  8005f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fa:	ff d0                	call   *%eax
  8005fc:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005ff:	ff 4d 1c             	decl   0x1c(%ebp)
  800602:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800606:	7f e6                	jg     8005ee <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800608:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80060b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800610:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800613:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800616:	53                   	push   %ebx
  800617:	51                   	push   %ecx
  800618:	52                   	push   %edx
  800619:	50                   	push   %eax
  80061a:	e8 f5 14 00 00       	call   801b14 <__umoddi3>
  80061f:	83 c4 10             	add    $0x10,%esp
  800622:	05 54 22 80 00       	add    $0x802254,%eax
  800627:	8a 00                	mov    (%eax),%al
  800629:	0f be c0             	movsbl %al,%eax
  80062c:	83 ec 08             	sub    $0x8,%esp
  80062f:	ff 75 0c             	pushl  0xc(%ebp)
  800632:	50                   	push   %eax
  800633:	8b 45 08             	mov    0x8(%ebp),%eax
  800636:	ff d0                	call   *%eax
  800638:	83 c4 10             	add    $0x10,%esp
}
  80063b:	90                   	nop
  80063c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80063f:	c9                   	leave  
  800640:	c3                   	ret    

00800641 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800641:	55                   	push   %ebp
  800642:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800644:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800648:	7e 1c                	jle    800666 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80064a:	8b 45 08             	mov    0x8(%ebp),%eax
  80064d:	8b 00                	mov    (%eax),%eax
  80064f:	8d 50 08             	lea    0x8(%eax),%edx
  800652:	8b 45 08             	mov    0x8(%ebp),%eax
  800655:	89 10                	mov    %edx,(%eax)
  800657:	8b 45 08             	mov    0x8(%ebp),%eax
  80065a:	8b 00                	mov    (%eax),%eax
  80065c:	83 e8 08             	sub    $0x8,%eax
  80065f:	8b 50 04             	mov    0x4(%eax),%edx
  800662:	8b 00                	mov    (%eax),%eax
  800664:	eb 40                	jmp    8006a6 <getuint+0x65>
	else if (lflag)
  800666:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80066a:	74 1e                	je     80068a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80066c:	8b 45 08             	mov    0x8(%ebp),%eax
  80066f:	8b 00                	mov    (%eax),%eax
  800671:	8d 50 04             	lea    0x4(%eax),%edx
  800674:	8b 45 08             	mov    0x8(%ebp),%eax
  800677:	89 10                	mov    %edx,(%eax)
  800679:	8b 45 08             	mov    0x8(%ebp),%eax
  80067c:	8b 00                	mov    (%eax),%eax
  80067e:	83 e8 04             	sub    $0x4,%eax
  800681:	8b 00                	mov    (%eax),%eax
  800683:	ba 00 00 00 00       	mov    $0x0,%edx
  800688:	eb 1c                	jmp    8006a6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80068a:	8b 45 08             	mov    0x8(%ebp),%eax
  80068d:	8b 00                	mov    (%eax),%eax
  80068f:	8d 50 04             	lea    0x4(%eax),%edx
  800692:	8b 45 08             	mov    0x8(%ebp),%eax
  800695:	89 10                	mov    %edx,(%eax)
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	8b 00                	mov    (%eax),%eax
  80069c:	83 e8 04             	sub    $0x4,%eax
  80069f:	8b 00                	mov    (%eax),%eax
  8006a1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006a6:	5d                   	pop    %ebp
  8006a7:	c3                   	ret    

008006a8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006a8:	55                   	push   %ebp
  8006a9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006ab:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006af:	7e 1c                	jle    8006cd <getint+0x25>
		return va_arg(*ap, long long);
  8006b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b4:	8b 00                	mov    (%eax),%eax
  8006b6:	8d 50 08             	lea    0x8(%eax),%edx
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	89 10                	mov    %edx,(%eax)
  8006be:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c1:	8b 00                	mov    (%eax),%eax
  8006c3:	83 e8 08             	sub    $0x8,%eax
  8006c6:	8b 50 04             	mov    0x4(%eax),%edx
  8006c9:	8b 00                	mov    (%eax),%eax
  8006cb:	eb 38                	jmp    800705 <getint+0x5d>
	else if (lflag)
  8006cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006d1:	74 1a                	je     8006ed <getint+0x45>
		return va_arg(*ap, long);
  8006d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d6:	8b 00                	mov    (%eax),%eax
  8006d8:	8d 50 04             	lea    0x4(%eax),%edx
  8006db:	8b 45 08             	mov    0x8(%ebp),%eax
  8006de:	89 10                	mov    %edx,(%eax)
  8006e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e3:	8b 00                	mov    (%eax),%eax
  8006e5:	83 e8 04             	sub    $0x4,%eax
  8006e8:	8b 00                	mov    (%eax),%eax
  8006ea:	99                   	cltd   
  8006eb:	eb 18                	jmp    800705 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f0:	8b 00                	mov    (%eax),%eax
  8006f2:	8d 50 04             	lea    0x4(%eax),%edx
  8006f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f8:	89 10                	mov    %edx,(%eax)
  8006fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fd:	8b 00                	mov    (%eax),%eax
  8006ff:	83 e8 04             	sub    $0x4,%eax
  800702:	8b 00                	mov    (%eax),%eax
  800704:	99                   	cltd   
}
  800705:	5d                   	pop    %ebp
  800706:	c3                   	ret    

00800707 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800707:	55                   	push   %ebp
  800708:	89 e5                	mov    %esp,%ebp
  80070a:	56                   	push   %esi
  80070b:	53                   	push   %ebx
  80070c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80070f:	eb 17                	jmp    800728 <vprintfmt+0x21>
			if (ch == '\0')
  800711:	85 db                	test   %ebx,%ebx
  800713:	0f 84 af 03 00 00    	je     800ac8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800719:	83 ec 08             	sub    $0x8,%esp
  80071c:	ff 75 0c             	pushl  0xc(%ebp)
  80071f:	53                   	push   %ebx
  800720:	8b 45 08             	mov    0x8(%ebp),%eax
  800723:	ff d0                	call   *%eax
  800725:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800728:	8b 45 10             	mov    0x10(%ebp),%eax
  80072b:	8d 50 01             	lea    0x1(%eax),%edx
  80072e:	89 55 10             	mov    %edx,0x10(%ebp)
  800731:	8a 00                	mov    (%eax),%al
  800733:	0f b6 d8             	movzbl %al,%ebx
  800736:	83 fb 25             	cmp    $0x25,%ebx
  800739:	75 d6                	jne    800711 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80073b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80073f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800746:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80074d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800754:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80075b:	8b 45 10             	mov    0x10(%ebp),%eax
  80075e:	8d 50 01             	lea    0x1(%eax),%edx
  800761:	89 55 10             	mov    %edx,0x10(%ebp)
  800764:	8a 00                	mov    (%eax),%al
  800766:	0f b6 d8             	movzbl %al,%ebx
  800769:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80076c:	83 f8 55             	cmp    $0x55,%eax
  80076f:	0f 87 2b 03 00 00    	ja     800aa0 <vprintfmt+0x399>
  800775:	8b 04 85 78 22 80 00 	mov    0x802278(,%eax,4),%eax
  80077c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80077e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800782:	eb d7                	jmp    80075b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800784:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800788:	eb d1                	jmp    80075b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80078a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800791:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800794:	89 d0                	mov    %edx,%eax
  800796:	c1 e0 02             	shl    $0x2,%eax
  800799:	01 d0                	add    %edx,%eax
  80079b:	01 c0                	add    %eax,%eax
  80079d:	01 d8                	add    %ebx,%eax
  80079f:	83 e8 30             	sub    $0x30,%eax
  8007a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a8:	8a 00                	mov    (%eax),%al
  8007aa:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007ad:	83 fb 2f             	cmp    $0x2f,%ebx
  8007b0:	7e 3e                	jle    8007f0 <vprintfmt+0xe9>
  8007b2:	83 fb 39             	cmp    $0x39,%ebx
  8007b5:	7f 39                	jg     8007f0 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007b7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007ba:	eb d5                	jmp    800791 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8007bf:	83 c0 04             	add    $0x4,%eax
  8007c2:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c8:	83 e8 04             	sub    $0x4,%eax
  8007cb:	8b 00                	mov    (%eax),%eax
  8007cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007d0:	eb 1f                	jmp    8007f1 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d6:	79 83                	jns    80075b <vprintfmt+0x54>
				width = 0;
  8007d8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007df:	e9 77 ff ff ff       	jmp    80075b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007e4:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007eb:	e9 6b ff ff ff       	jmp    80075b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007f0:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007f1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007f5:	0f 89 60 ff ff ff    	jns    80075b <vprintfmt+0x54>
				width = precision, precision = -1;
  8007fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800801:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800808:	e9 4e ff ff ff       	jmp    80075b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80080d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800810:	e9 46 ff ff ff       	jmp    80075b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800815:	8b 45 14             	mov    0x14(%ebp),%eax
  800818:	83 c0 04             	add    $0x4,%eax
  80081b:	89 45 14             	mov    %eax,0x14(%ebp)
  80081e:	8b 45 14             	mov    0x14(%ebp),%eax
  800821:	83 e8 04             	sub    $0x4,%eax
  800824:	8b 00                	mov    (%eax),%eax
  800826:	83 ec 08             	sub    $0x8,%esp
  800829:	ff 75 0c             	pushl  0xc(%ebp)
  80082c:	50                   	push   %eax
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	ff d0                	call   *%eax
  800832:	83 c4 10             	add    $0x10,%esp
			break;
  800835:	e9 89 02 00 00       	jmp    800ac3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80083a:	8b 45 14             	mov    0x14(%ebp),%eax
  80083d:	83 c0 04             	add    $0x4,%eax
  800840:	89 45 14             	mov    %eax,0x14(%ebp)
  800843:	8b 45 14             	mov    0x14(%ebp),%eax
  800846:	83 e8 04             	sub    $0x4,%eax
  800849:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80084b:	85 db                	test   %ebx,%ebx
  80084d:	79 02                	jns    800851 <vprintfmt+0x14a>
				err = -err;
  80084f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800851:	83 fb 64             	cmp    $0x64,%ebx
  800854:	7f 0b                	jg     800861 <vprintfmt+0x15a>
  800856:	8b 34 9d c0 20 80 00 	mov    0x8020c0(,%ebx,4),%esi
  80085d:	85 f6                	test   %esi,%esi
  80085f:	75 19                	jne    80087a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800861:	53                   	push   %ebx
  800862:	68 65 22 80 00       	push   $0x802265
  800867:	ff 75 0c             	pushl  0xc(%ebp)
  80086a:	ff 75 08             	pushl  0x8(%ebp)
  80086d:	e8 5e 02 00 00       	call   800ad0 <printfmt>
  800872:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800875:	e9 49 02 00 00       	jmp    800ac3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80087a:	56                   	push   %esi
  80087b:	68 6e 22 80 00       	push   $0x80226e
  800880:	ff 75 0c             	pushl  0xc(%ebp)
  800883:	ff 75 08             	pushl  0x8(%ebp)
  800886:	e8 45 02 00 00       	call   800ad0 <printfmt>
  80088b:	83 c4 10             	add    $0x10,%esp
			break;
  80088e:	e9 30 02 00 00       	jmp    800ac3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800893:	8b 45 14             	mov    0x14(%ebp),%eax
  800896:	83 c0 04             	add    $0x4,%eax
  800899:	89 45 14             	mov    %eax,0x14(%ebp)
  80089c:	8b 45 14             	mov    0x14(%ebp),%eax
  80089f:	83 e8 04             	sub    $0x4,%eax
  8008a2:	8b 30                	mov    (%eax),%esi
  8008a4:	85 f6                	test   %esi,%esi
  8008a6:	75 05                	jne    8008ad <vprintfmt+0x1a6>
				p = "(null)";
  8008a8:	be 71 22 80 00       	mov    $0x802271,%esi
			if (width > 0 && padc != '-')
  8008ad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b1:	7e 6d                	jle    800920 <vprintfmt+0x219>
  8008b3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008b7:	74 67                	je     800920 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008bc:	83 ec 08             	sub    $0x8,%esp
  8008bf:	50                   	push   %eax
  8008c0:	56                   	push   %esi
  8008c1:	e8 0c 03 00 00       	call   800bd2 <strnlen>
  8008c6:	83 c4 10             	add    $0x10,%esp
  8008c9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008cc:	eb 16                	jmp    8008e4 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008ce:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008d2:	83 ec 08             	sub    $0x8,%esp
  8008d5:	ff 75 0c             	pushl  0xc(%ebp)
  8008d8:	50                   	push   %eax
  8008d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dc:	ff d0                	call   *%eax
  8008de:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008e1:	ff 4d e4             	decl   -0x1c(%ebp)
  8008e4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008e8:	7f e4                	jg     8008ce <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008ea:	eb 34                	jmp    800920 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008ec:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008f0:	74 1c                	je     80090e <vprintfmt+0x207>
  8008f2:	83 fb 1f             	cmp    $0x1f,%ebx
  8008f5:	7e 05                	jle    8008fc <vprintfmt+0x1f5>
  8008f7:	83 fb 7e             	cmp    $0x7e,%ebx
  8008fa:	7e 12                	jle    80090e <vprintfmt+0x207>
					putch('?', putdat);
  8008fc:	83 ec 08             	sub    $0x8,%esp
  8008ff:	ff 75 0c             	pushl  0xc(%ebp)
  800902:	6a 3f                	push   $0x3f
  800904:	8b 45 08             	mov    0x8(%ebp),%eax
  800907:	ff d0                	call   *%eax
  800909:	83 c4 10             	add    $0x10,%esp
  80090c:	eb 0f                	jmp    80091d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80090e:	83 ec 08             	sub    $0x8,%esp
  800911:	ff 75 0c             	pushl  0xc(%ebp)
  800914:	53                   	push   %ebx
  800915:	8b 45 08             	mov    0x8(%ebp),%eax
  800918:	ff d0                	call   *%eax
  80091a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80091d:	ff 4d e4             	decl   -0x1c(%ebp)
  800920:	89 f0                	mov    %esi,%eax
  800922:	8d 70 01             	lea    0x1(%eax),%esi
  800925:	8a 00                	mov    (%eax),%al
  800927:	0f be d8             	movsbl %al,%ebx
  80092a:	85 db                	test   %ebx,%ebx
  80092c:	74 24                	je     800952 <vprintfmt+0x24b>
  80092e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800932:	78 b8                	js     8008ec <vprintfmt+0x1e5>
  800934:	ff 4d e0             	decl   -0x20(%ebp)
  800937:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80093b:	79 af                	jns    8008ec <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80093d:	eb 13                	jmp    800952 <vprintfmt+0x24b>
				putch(' ', putdat);
  80093f:	83 ec 08             	sub    $0x8,%esp
  800942:	ff 75 0c             	pushl  0xc(%ebp)
  800945:	6a 20                	push   $0x20
  800947:	8b 45 08             	mov    0x8(%ebp),%eax
  80094a:	ff d0                	call   *%eax
  80094c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80094f:	ff 4d e4             	decl   -0x1c(%ebp)
  800952:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800956:	7f e7                	jg     80093f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800958:	e9 66 01 00 00       	jmp    800ac3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80095d:	83 ec 08             	sub    $0x8,%esp
  800960:	ff 75 e8             	pushl  -0x18(%ebp)
  800963:	8d 45 14             	lea    0x14(%ebp),%eax
  800966:	50                   	push   %eax
  800967:	e8 3c fd ff ff       	call   8006a8 <getint>
  80096c:	83 c4 10             	add    $0x10,%esp
  80096f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800972:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800975:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800978:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80097b:	85 d2                	test   %edx,%edx
  80097d:	79 23                	jns    8009a2 <vprintfmt+0x29b>
				putch('-', putdat);
  80097f:	83 ec 08             	sub    $0x8,%esp
  800982:	ff 75 0c             	pushl  0xc(%ebp)
  800985:	6a 2d                	push   $0x2d
  800987:	8b 45 08             	mov    0x8(%ebp),%eax
  80098a:	ff d0                	call   *%eax
  80098c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80098f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800992:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800995:	f7 d8                	neg    %eax
  800997:	83 d2 00             	adc    $0x0,%edx
  80099a:	f7 da                	neg    %edx
  80099c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009a2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a9:	e9 bc 00 00 00       	jmp    800a6a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009ae:	83 ec 08             	sub    $0x8,%esp
  8009b1:	ff 75 e8             	pushl  -0x18(%ebp)
  8009b4:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b7:	50                   	push   %eax
  8009b8:	e8 84 fc ff ff       	call   800641 <getuint>
  8009bd:	83 c4 10             	add    $0x10,%esp
  8009c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009c6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009cd:	e9 98 00 00 00       	jmp    800a6a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009d2:	83 ec 08             	sub    $0x8,%esp
  8009d5:	ff 75 0c             	pushl  0xc(%ebp)
  8009d8:	6a 58                	push   $0x58
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	ff d0                	call   *%eax
  8009df:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009e2:	83 ec 08             	sub    $0x8,%esp
  8009e5:	ff 75 0c             	pushl  0xc(%ebp)
  8009e8:	6a 58                	push   $0x58
  8009ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ed:	ff d0                	call   *%eax
  8009ef:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009f2:	83 ec 08             	sub    $0x8,%esp
  8009f5:	ff 75 0c             	pushl  0xc(%ebp)
  8009f8:	6a 58                	push   $0x58
  8009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fd:	ff d0                	call   *%eax
  8009ff:	83 c4 10             	add    $0x10,%esp
			break;
  800a02:	e9 bc 00 00 00       	jmp    800ac3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a07:	83 ec 08             	sub    $0x8,%esp
  800a0a:	ff 75 0c             	pushl  0xc(%ebp)
  800a0d:	6a 30                	push   $0x30
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	ff d0                	call   *%eax
  800a14:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a17:	83 ec 08             	sub    $0x8,%esp
  800a1a:	ff 75 0c             	pushl  0xc(%ebp)
  800a1d:	6a 78                	push   $0x78
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	ff d0                	call   *%eax
  800a24:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a27:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2a:	83 c0 04             	add    $0x4,%eax
  800a2d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a30:	8b 45 14             	mov    0x14(%ebp),%eax
  800a33:	83 e8 04             	sub    $0x4,%eax
  800a36:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a42:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a49:	eb 1f                	jmp    800a6a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a4b:	83 ec 08             	sub    $0x8,%esp
  800a4e:	ff 75 e8             	pushl  -0x18(%ebp)
  800a51:	8d 45 14             	lea    0x14(%ebp),%eax
  800a54:	50                   	push   %eax
  800a55:	e8 e7 fb ff ff       	call   800641 <getuint>
  800a5a:	83 c4 10             	add    $0x10,%esp
  800a5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a60:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a63:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a6a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a6e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a71:	83 ec 04             	sub    $0x4,%esp
  800a74:	52                   	push   %edx
  800a75:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a78:	50                   	push   %eax
  800a79:	ff 75 f4             	pushl  -0xc(%ebp)
  800a7c:	ff 75 f0             	pushl  -0x10(%ebp)
  800a7f:	ff 75 0c             	pushl  0xc(%ebp)
  800a82:	ff 75 08             	pushl  0x8(%ebp)
  800a85:	e8 00 fb ff ff       	call   80058a <printnum>
  800a8a:	83 c4 20             	add    $0x20,%esp
			break;
  800a8d:	eb 34                	jmp    800ac3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a8f:	83 ec 08             	sub    $0x8,%esp
  800a92:	ff 75 0c             	pushl  0xc(%ebp)
  800a95:	53                   	push   %ebx
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	ff d0                	call   *%eax
  800a9b:	83 c4 10             	add    $0x10,%esp
			break;
  800a9e:	eb 23                	jmp    800ac3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800aa0:	83 ec 08             	sub    $0x8,%esp
  800aa3:	ff 75 0c             	pushl  0xc(%ebp)
  800aa6:	6a 25                	push   $0x25
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	ff d0                	call   *%eax
  800aad:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ab0:	ff 4d 10             	decl   0x10(%ebp)
  800ab3:	eb 03                	jmp    800ab8 <vprintfmt+0x3b1>
  800ab5:	ff 4d 10             	decl   0x10(%ebp)
  800ab8:	8b 45 10             	mov    0x10(%ebp),%eax
  800abb:	48                   	dec    %eax
  800abc:	8a 00                	mov    (%eax),%al
  800abe:	3c 25                	cmp    $0x25,%al
  800ac0:	75 f3                	jne    800ab5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ac2:	90                   	nop
		}
	}
  800ac3:	e9 47 fc ff ff       	jmp    80070f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ac8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ac9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800acc:	5b                   	pop    %ebx
  800acd:	5e                   	pop    %esi
  800ace:	5d                   	pop    %ebp
  800acf:	c3                   	ret    

00800ad0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ad0:	55                   	push   %ebp
  800ad1:	89 e5                	mov    %esp,%ebp
  800ad3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ad6:	8d 45 10             	lea    0x10(%ebp),%eax
  800ad9:	83 c0 04             	add    $0x4,%eax
  800adc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800adf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ae2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae5:	50                   	push   %eax
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	ff 75 08             	pushl  0x8(%ebp)
  800aec:	e8 16 fc ff ff       	call   800707 <vprintfmt>
  800af1:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800af4:	90                   	nop
  800af5:	c9                   	leave  
  800af6:	c3                   	ret    

00800af7 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800af7:	55                   	push   %ebp
  800af8:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800afa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afd:	8b 40 08             	mov    0x8(%eax),%eax
  800b00:	8d 50 01             	lea    0x1(%eax),%edx
  800b03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b06:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0c:	8b 10                	mov    (%eax),%edx
  800b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b11:	8b 40 04             	mov    0x4(%eax),%eax
  800b14:	39 c2                	cmp    %eax,%edx
  800b16:	73 12                	jae    800b2a <sprintputch+0x33>
		*b->buf++ = ch;
  800b18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1b:	8b 00                	mov    (%eax),%eax
  800b1d:	8d 48 01             	lea    0x1(%eax),%ecx
  800b20:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b23:	89 0a                	mov    %ecx,(%edx)
  800b25:	8b 55 08             	mov    0x8(%ebp),%edx
  800b28:	88 10                	mov    %dl,(%eax)
}
  800b2a:	90                   	nop
  800b2b:	5d                   	pop    %ebp
  800b2c:	c3                   	ret    

00800b2d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b2d:	55                   	push   %ebp
  800b2e:	89 e5                	mov    %esp,%ebp
  800b30:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	01 d0                	add    %edx,%eax
  800b44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b47:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b4e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b52:	74 06                	je     800b5a <vsnprintf+0x2d>
  800b54:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b58:	7f 07                	jg     800b61 <vsnprintf+0x34>
		return -E_INVAL;
  800b5a:	b8 03 00 00 00       	mov    $0x3,%eax
  800b5f:	eb 20                	jmp    800b81 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b61:	ff 75 14             	pushl  0x14(%ebp)
  800b64:	ff 75 10             	pushl  0x10(%ebp)
  800b67:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b6a:	50                   	push   %eax
  800b6b:	68 f7 0a 80 00       	push   $0x800af7
  800b70:	e8 92 fb ff ff       	call   800707 <vprintfmt>
  800b75:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b78:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b7b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b81:	c9                   	leave  
  800b82:	c3                   	ret    

00800b83 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b83:	55                   	push   %ebp
  800b84:	89 e5                	mov    %esp,%ebp
  800b86:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b89:	8d 45 10             	lea    0x10(%ebp),%eax
  800b8c:	83 c0 04             	add    $0x4,%eax
  800b8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b92:	8b 45 10             	mov    0x10(%ebp),%eax
  800b95:	ff 75 f4             	pushl  -0xc(%ebp)
  800b98:	50                   	push   %eax
  800b99:	ff 75 0c             	pushl  0xc(%ebp)
  800b9c:	ff 75 08             	pushl  0x8(%ebp)
  800b9f:	e8 89 ff ff ff       	call   800b2d <vsnprintf>
  800ba4:	83 c4 10             	add    $0x10,%esp
  800ba7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800baa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bad:	c9                   	leave  
  800bae:	c3                   	ret    

00800baf <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800baf:	55                   	push   %ebp
  800bb0:	89 e5                	mov    %esp,%ebp
  800bb2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bbc:	eb 06                	jmp    800bc4 <strlen+0x15>
		n++;
  800bbe:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bc1:	ff 45 08             	incl   0x8(%ebp)
  800bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc7:	8a 00                	mov    (%eax),%al
  800bc9:	84 c0                	test   %al,%al
  800bcb:	75 f1                	jne    800bbe <strlen+0xf>
		n++;
	return n;
  800bcd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bd0:	c9                   	leave  
  800bd1:	c3                   	ret    

00800bd2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bd2:	55                   	push   %ebp
  800bd3:	89 e5                	mov    %esp,%ebp
  800bd5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bd8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bdf:	eb 09                	jmp    800bea <strnlen+0x18>
		n++;
  800be1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800be4:	ff 45 08             	incl   0x8(%ebp)
  800be7:	ff 4d 0c             	decl   0xc(%ebp)
  800bea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bee:	74 09                	je     800bf9 <strnlen+0x27>
  800bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf3:	8a 00                	mov    (%eax),%al
  800bf5:	84 c0                	test   %al,%al
  800bf7:	75 e8                	jne    800be1 <strnlen+0xf>
		n++;
	return n;
  800bf9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bfc:	c9                   	leave  
  800bfd:	c3                   	ret    

00800bfe <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bfe:	55                   	push   %ebp
  800bff:	89 e5                	mov    %esp,%ebp
  800c01:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
  800c07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c0a:	90                   	nop
  800c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0e:	8d 50 01             	lea    0x1(%eax),%edx
  800c11:	89 55 08             	mov    %edx,0x8(%ebp)
  800c14:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c17:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c1a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c1d:	8a 12                	mov    (%edx),%dl
  800c1f:	88 10                	mov    %dl,(%eax)
  800c21:	8a 00                	mov    (%eax),%al
  800c23:	84 c0                	test   %al,%al
  800c25:	75 e4                	jne    800c0b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c27:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c2a:	c9                   	leave  
  800c2b:	c3                   	ret    

00800c2c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c2c:	55                   	push   %ebp
  800c2d:	89 e5                	mov    %esp,%ebp
  800c2f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c32:	8b 45 08             	mov    0x8(%ebp),%eax
  800c35:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c3f:	eb 1f                	jmp    800c60 <strncpy+0x34>
		*dst++ = *src;
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	8d 50 01             	lea    0x1(%eax),%edx
  800c47:	89 55 08             	mov    %edx,0x8(%ebp)
  800c4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c4d:	8a 12                	mov    (%edx),%dl
  800c4f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c54:	8a 00                	mov    (%eax),%al
  800c56:	84 c0                	test   %al,%al
  800c58:	74 03                	je     800c5d <strncpy+0x31>
			src++;
  800c5a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c5d:	ff 45 fc             	incl   -0x4(%ebp)
  800c60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c63:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c66:	72 d9                	jb     800c41 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c68:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c6b:	c9                   	leave  
  800c6c:	c3                   	ret    

00800c6d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c6d:	55                   	push   %ebp
  800c6e:	89 e5                	mov    %esp,%ebp
  800c70:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c79:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7d:	74 30                	je     800caf <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c7f:	eb 16                	jmp    800c97 <strlcpy+0x2a>
			*dst++ = *src++;
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	8d 50 01             	lea    0x1(%eax),%edx
  800c87:	89 55 08             	mov    %edx,0x8(%ebp)
  800c8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c8d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c90:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c93:	8a 12                	mov    (%edx),%dl
  800c95:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c97:	ff 4d 10             	decl   0x10(%ebp)
  800c9a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9e:	74 09                	je     800ca9 <strlcpy+0x3c>
  800ca0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca3:	8a 00                	mov    (%eax),%al
  800ca5:	84 c0                	test   %al,%al
  800ca7:	75 d8                	jne    800c81 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cac:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800caf:	8b 55 08             	mov    0x8(%ebp),%edx
  800cb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb5:	29 c2                	sub    %eax,%edx
  800cb7:	89 d0                	mov    %edx,%eax
}
  800cb9:	c9                   	leave  
  800cba:	c3                   	ret    

00800cbb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cbb:	55                   	push   %ebp
  800cbc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cbe:	eb 06                	jmp    800cc6 <strcmp+0xb>
		p++, q++;
  800cc0:	ff 45 08             	incl   0x8(%ebp)
  800cc3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	8a 00                	mov    (%eax),%al
  800ccb:	84 c0                	test   %al,%al
  800ccd:	74 0e                	je     800cdd <strcmp+0x22>
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	8a 10                	mov    (%eax),%dl
  800cd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd7:	8a 00                	mov    (%eax),%al
  800cd9:	38 c2                	cmp    %al,%dl
  800cdb:	74 e3                	je     800cc0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	8a 00                	mov    (%eax),%al
  800ce2:	0f b6 d0             	movzbl %al,%edx
  800ce5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	0f b6 c0             	movzbl %al,%eax
  800ced:	29 c2                	sub    %eax,%edx
  800cef:	89 d0                	mov    %edx,%eax
}
  800cf1:	5d                   	pop    %ebp
  800cf2:	c3                   	ret    

00800cf3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cf3:	55                   	push   %ebp
  800cf4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cf6:	eb 09                	jmp    800d01 <strncmp+0xe>
		n--, p++, q++;
  800cf8:	ff 4d 10             	decl   0x10(%ebp)
  800cfb:	ff 45 08             	incl   0x8(%ebp)
  800cfe:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d05:	74 17                	je     800d1e <strncmp+0x2b>
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	84 c0                	test   %al,%al
  800d0e:	74 0e                	je     800d1e <strncmp+0x2b>
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 10                	mov    (%eax),%dl
  800d15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d18:	8a 00                	mov    (%eax),%al
  800d1a:	38 c2                	cmp    %al,%dl
  800d1c:	74 da                	je     800cf8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d1e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d22:	75 07                	jne    800d2b <strncmp+0x38>
		return 0;
  800d24:	b8 00 00 00 00       	mov    $0x0,%eax
  800d29:	eb 14                	jmp    800d3f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	8a 00                	mov    (%eax),%al
  800d30:	0f b6 d0             	movzbl %al,%edx
  800d33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	0f b6 c0             	movzbl %al,%eax
  800d3b:	29 c2                	sub    %eax,%edx
  800d3d:	89 d0                	mov    %edx,%eax
}
  800d3f:	5d                   	pop    %ebp
  800d40:	c3                   	ret    

00800d41 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d41:	55                   	push   %ebp
  800d42:	89 e5                	mov    %esp,%ebp
  800d44:	83 ec 04             	sub    $0x4,%esp
  800d47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d4d:	eb 12                	jmp    800d61 <strchr+0x20>
		if (*s == c)
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d57:	75 05                	jne    800d5e <strchr+0x1d>
			return (char *) s;
  800d59:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5c:	eb 11                	jmp    800d6f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d5e:	ff 45 08             	incl   0x8(%ebp)
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	84 c0                	test   %al,%al
  800d68:	75 e5                	jne    800d4f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d6f:	c9                   	leave  
  800d70:	c3                   	ret    

00800d71 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d71:	55                   	push   %ebp
  800d72:	89 e5                	mov    %esp,%ebp
  800d74:	83 ec 04             	sub    $0x4,%esp
  800d77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d7d:	eb 0d                	jmp    800d8c <strfind+0x1b>
		if (*s == c)
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	8a 00                	mov    (%eax),%al
  800d84:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d87:	74 0e                	je     800d97 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d89:	ff 45 08             	incl   0x8(%ebp)
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8f:	8a 00                	mov    (%eax),%al
  800d91:	84 c0                	test   %al,%al
  800d93:	75 ea                	jne    800d7f <strfind+0xe>
  800d95:	eb 01                	jmp    800d98 <strfind+0x27>
		if (*s == c)
			break;
  800d97:	90                   	nop
	return (char *) s;
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d9b:	c9                   	leave  
  800d9c:	c3                   	ret    

00800d9d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d9d:	55                   	push   %ebp
  800d9e:	89 e5                	mov    %esp,%ebp
  800da0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
  800da6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800da9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dac:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800daf:	eb 0e                	jmp    800dbf <memset+0x22>
		*p++ = c;
  800db1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db4:	8d 50 01             	lea    0x1(%eax),%edx
  800db7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800dba:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dbd:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dbf:	ff 4d f8             	decl   -0x8(%ebp)
  800dc2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dc6:	79 e9                	jns    800db1 <memset+0x14>
		*p++ = c;

	return v;
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dcb:	c9                   	leave  
  800dcc:	c3                   	ret    

00800dcd <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dcd:	55                   	push   %ebp
  800dce:	89 e5                	mov    %esp,%ebp
  800dd0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ddf:	eb 16                	jmp    800df7 <memcpy+0x2a>
		*d++ = *s++;
  800de1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de4:	8d 50 01             	lea    0x1(%eax),%edx
  800de7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dea:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ded:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800df3:	8a 12                	mov    (%edx),%dl
  800df5:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800df7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfa:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dfd:	89 55 10             	mov    %edx,0x10(%ebp)
  800e00:	85 c0                	test   %eax,%eax
  800e02:	75 dd                	jne    800de1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e04:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e07:	c9                   	leave  
  800e08:	c3                   	ret    

00800e09 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e09:	55                   	push   %ebp
  800e0a:	89 e5                	mov    %esp,%ebp
  800e0c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e21:	73 50                	jae    800e73 <memmove+0x6a>
  800e23:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e26:	8b 45 10             	mov    0x10(%ebp),%eax
  800e29:	01 d0                	add    %edx,%eax
  800e2b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e2e:	76 43                	jbe    800e73 <memmove+0x6a>
		s += n;
  800e30:	8b 45 10             	mov    0x10(%ebp),%eax
  800e33:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e36:	8b 45 10             	mov    0x10(%ebp),%eax
  800e39:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e3c:	eb 10                	jmp    800e4e <memmove+0x45>
			*--d = *--s;
  800e3e:	ff 4d f8             	decl   -0x8(%ebp)
  800e41:	ff 4d fc             	decl   -0x4(%ebp)
  800e44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e47:	8a 10                	mov    (%eax),%dl
  800e49:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e4c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e51:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e54:	89 55 10             	mov    %edx,0x10(%ebp)
  800e57:	85 c0                	test   %eax,%eax
  800e59:	75 e3                	jne    800e3e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e5b:	eb 23                	jmp    800e80 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e60:	8d 50 01             	lea    0x1(%eax),%edx
  800e63:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e66:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e69:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e6c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e6f:	8a 12                	mov    (%edx),%dl
  800e71:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e73:	8b 45 10             	mov    0x10(%ebp),%eax
  800e76:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e79:	89 55 10             	mov    %edx,0x10(%ebp)
  800e7c:	85 c0                	test   %eax,%eax
  800e7e:	75 dd                	jne    800e5d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e80:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e83:	c9                   	leave  
  800e84:	c3                   	ret    

00800e85 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e85:	55                   	push   %ebp
  800e86:	89 e5                	mov    %esp,%ebp
  800e88:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e94:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e97:	eb 2a                	jmp    800ec3 <memcmp+0x3e>
		if (*s1 != *s2)
  800e99:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e9c:	8a 10                	mov    (%eax),%dl
  800e9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea1:	8a 00                	mov    (%eax),%al
  800ea3:	38 c2                	cmp    %al,%dl
  800ea5:	74 16                	je     800ebd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ea7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eaa:	8a 00                	mov    (%eax),%al
  800eac:	0f b6 d0             	movzbl %al,%edx
  800eaf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eb2:	8a 00                	mov    (%eax),%al
  800eb4:	0f b6 c0             	movzbl %al,%eax
  800eb7:	29 c2                	sub    %eax,%edx
  800eb9:	89 d0                	mov    %edx,%eax
  800ebb:	eb 18                	jmp    800ed5 <memcmp+0x50>
		s1++, s2++;
  800ebd:	ff 45 fc             	incl   -0x4(%ebp)
  800ec0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ec3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec9:	89 55 10             	mov    %edx,0x10(%ebp)
  800ecc:	85 c0                	test   %eax,%eax
  800ece:	75 c9                	jne    800e99 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ed0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed5:	c9                   	leave  
  800ed6:	c3                   	ret    

00800ed7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ed7:	55                   	push   %ebp
  800ed8:	89 e5                	mov    %esp,%ebp
  800eda:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800edd:	8b 55 08             	mov    0x8(%ebp),%edx
  800ee0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee3:	01 d0                	add    %edx,%eax
  800ee5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ee8:	eb 15                	jmp    800eff <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	0f b6 d0             	movzbl %al,%edx
  800ef2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef5:	0f b6 c0             	movzbl %al,%eax
  800ef8:	39 c2                	cmp    %eax,%edx
  800efa:	74 0d                	je     800f09 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800efc:	ff 45 08             	incl   0x8(%ebp)
  800eff:	8b 45 08             	mov    0x8(%ebp),%eax
  800f02:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f05:	72 e3                	jb     800eea <memfind+0x13>
  800f07:	eb 01                	jmp    800f0a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f09:	90                   	nop
	return (void *) s;
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f0d:	c9                   	leave  
  800f0e:	c3                   	ret    

00800f0f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f0f:	55                   	push   %ebp
  800f10:	89 e5                	mov    %esp,%ebp
  800f12:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f1c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f23:	eb 03                	jmp    800f28 <strtol+0x19>
		s++;
  800f25:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	8a 00                	mov    (%eax),%al
  800f2d:	3c 20                	cmp    $0x20,%al
  800f2f:	74 f4                	je     800f25 <strtol+0x16>
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	8a 00                	mov    (%eax),%al
  800f36:	3c 09                	cmp    $0x9,%al
  800f38:	74 eb                	je     800f25 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	3c 2b                	cmp    $0x2b,%al
  800f41:	75 05                	jne    800f48 <strtol+0x39>
		s++;
  800f43:	ff 45 08             	incl   0x8(%ebp)
  800f46:	eb 13                	jmp    800f5b <strtol+0x4c>
	else if (*s == '-')
  800f48:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4b:	8a 00                	mov    (%eax),%al
  800f4d:	3c 2d                	cmp    $0x2d,%al
  800f4f:	75 0a                	jne    800f5b <strtol+0x4c>
		s++, neg = 1;
  800f51:	ff 45 08             	incl   0x8(%ebp)
  800f54:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f5b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5f:	74 06                	je     800f67 <strtol+0x58>
  800f61:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f65:	75 20                	jne    800f87 <strtol+0x78>
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	8a 00                	mov    (%eax),%al
  800f6c:	3c 30                	cmp    $0x30,%al
  800f6e:	75 17                	jne    800f87 <strtol+0x78>
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	40                   	inc    %eax
  800f74:	8a 00                	mov    (%eax),%al
  800f76:	3c 78                	cmp    $0x78,%al
  800f78:	75 0d                	jne    800f87 <strtol+0x78>
		s += 2, base = 16;
  800f7a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f7e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f85:	eb 28                	jmp    800faf <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8b:	75 15                	jne    800fa2 <strtol+0x93>
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	3c 30                	cmp    $0x30,%al
  800f94:	75 0c                	jne    800fa2 <strtol+0x93>
		s++, base = 8;
  800f96:	ff 45 08             	incl   0x8(%ebp)
  800f99:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fa0:	eb 0d                	jmp    800faf <strtol+0xa0>
	else if (base == 0)
  800fa2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa6:	75 07                	jne    800faf <strtol+0xa0>
		base = 10;
  800fa8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	3c 2f                	cmp    $0x2f,%al
  800fb6:	7e 19                	jle    800fd1 <strtol+0xc2>
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	3c 39                	cmp    $0x39,%al
  800fbf:	7f 10                	jg     800fd1 <strtol+0xc2>
			dig = *s - '0';
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	8a 00                	mov    (%eax),%al
  800fc6:	0f be c0             	movsbl %al,%eax
  800fc9:	83 e8 30             	sub    $0x30,%eax
  800fcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fcf:	eb 42                	jmp    801013 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	3c 60                	cmp    $0x60,%al
  800fd8:	7e 19                	jle    800ff3 <strtol+0xe4>
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	3c 7a                	cmp    $0x7a,%al
  800fe1:	7f 10                	jg     800ff3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	0f be c0             	movsbl %al,%eax
  800feb:	83 e8 57             	sub    $0x57,%eax
  800fee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ff1:	eb 20                	jmp    801013 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	3c 40                	cmp    $0x40,%al
  800ffa:	7e 39                	jle    801035 <strtol+0x126>
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	8a 00                	mov    (%eax),%al
  801001:	3c 5a                	cmp    $0x5a,%al
  801003:	7f 30                	jg     801035 <strtol+0x126>
			dig = *s - 'A' + 10;
  801005:	8b 45 08             	mov    0x8(%ebp),%eax
  801008:	8a 00                	mov    (%eax),%al
  80100a:	0f be c0             	movsbl %al,%eax
  80100d:	83 e8 37             	sub    $0x37,%eax
  801010:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801013:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801016:	3b 45 10             	cmp    0x10(%ebp),%eax
  801019:	7d 19                	jge    801034 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80101b:	ff 45 08             	incl   0x8(%ebp)
  80101e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801021:	0f af 45 10          	imul   0x10(%ebp),%eax
  801025:	89 c2                	mov    %eax,%edx
  801027:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80102a:	01 d0                	add    %edx,%eax
  80102c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80102f:	e9 7b ff ff ff       	jmp    800faf <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801034:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801035:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801039:	74 08                	je     801043 <strtol+0x134>
		*endptr = (char *) s;
  80103b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103e:	8b 55 08             	mov    0x8(%ebp),%edx
  801041:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801043:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801047:	74 07                	je     801050 <strtol+0x141>
  801049:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104c:	f7 d8                	neg    %eax
  80104e:	eb 03                	jmp    801053 <strtol+0x144>
  801050:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801053:	c9                   	leave  
  801054:	c3                   	ret    

00801055 <ltostr>:

void
ltostr(long value, char *str)
{
  801055:	55                   	push   %ebp
  801056:	89 e5                	mov    %esp,%ebp
  801058:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80105b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801062:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801069:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80106d:	79 13                	jns    801082 <ltostr+0x2d>
	{
		neg = 1;
  80106f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801076:	8b 45 0c             	mov    0xc(%ebp),%eax
  801079:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80107c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80107f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
  801085:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80108a:	99                   	cltd   
  80108b:	f7 f9                	idiv   %ecx
  80108d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801090:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801093:	8d 50 01             	lea    0x1(%eax),%edx
  801096:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801099:	89 c2                	mov    %eax,%edx
  80109b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109e:	01 d0                	add    %edx,%eax
  8010a0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010a3:	83 c2 30             	add    $0x30,%edx
  8010a6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010ab:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010b0:	f7 e9                	imul   %ecx
  8010b2:	c1 fa 02             	sar    $0x2,%edx
  8010b5:	89 c8                	mov    %ecx,%eax
  8010b7:	c1 f8 1f             	sar    $0x1f,%eax
  8010ba:	29 c2                	sub    %eax,%edx
  8010bc:	89 d0                	mov    %edx,%eax
  8010be:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010c1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010c4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010c9:	f7 e9                	imul   %ecx
  8010cb:	c1 fa 02             	sar    $0x2,%edx
  8010ce:	89 c8                	mov    %ecx,%eax
  8010d0:	c1 f8 1f             	sar    $0x1f,%eax
  8010d3:	29 c2                	sub    %eax,%edx
  8010d5:	89 d0                	mov    %edx,%eax
  8010d7:	c1 e0 02             	shl    $0x2,%eax
  8010da:	01 d0                	add    %edx,%eax
  8010dc:	01 c0                	add    %eax,%eax
  8010de:	29 c1                	sub    %eax,%ecx
  8010e0:	89 ca                	mov    %ecx,%edx
  8010e2:	85 d2                	test   %edx,%edx
  8010e4:	75 9c                	jne    801082 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f0:	48                   	dec    %eax
  8010f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010f4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010f8:	74 3d                	je     801137 <ltostr+0xe2>
		start = 1 ;
  8010fa:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801101:	eb 34                	jmp    801137 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801103:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801106:	8b 45 0c             	mov    0xc(%ebp),%eax
  801109:	01 d0                	add    %edx,%eax
  80110b:	8a 00                	mov    (%eax),%al
  80110d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801110:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801113:	8b 45 0c             	mov    0xc(%ebp),%eax
  801116:	01 c2                	add    %eax,%edx
  801118:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80111b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111e:	01 c8                	add    %ecx,%eax
  801120:	8a 00                	mov    (%eax),%al
  801122:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801124:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801127:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112a:	01 c2                	add    %eax,%edx
  80112c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80112f:	88 02                	mov    %al,(%edx)
		start++ ;
  801131:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801134:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801137:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80113a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80113d:	7c c4                	jl     801103 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80113f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801142:	8b 45 0c             	mov    0xc(%ebp),%eax
  801145:	01 d0                	add    %edx,%eax
  801147:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80114a:	90                   	nop
  80114b:	c9                   	leave  
  80114c:	c3                   	ret    

0080114d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80114d:	55                   	push   %ebp
  80114e:	89 e5                	mov    %esp,%ebp
  801150:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801153:	ff 75 08             	pushl  0x8(%ebp)
  801156:	e8 54 fa ff ff       	call   800baf <strlen>
  80115b:	83 c4 04             	add    $0x4,%esp
  80115e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801161:	ff 75 0c             	pushl  0xc(%ebp)
  801164:	e8 46 fa ff ff       	call   800baf <strlen>
  801169:	83 c4 04             	add    $0x4,%esp
  80116c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80116f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801176:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80117d:	eb 17                	jmp    801196 <strcconcat+0x49>
		final[s] = str1[s] ;
  80117f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801182:	8b 45 10             	mov    0x10(%ebp),%eax
  801185:	01 c2                	add    %eax,%edx
  801187:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80118a:	8b 45 08             	mov    0x8(%ebp),%eax
  80118d:	01 c8                	add    %ecx,%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801193:	ff 45 fc             	incl   -0x4(%ebp)
  801196:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801199:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80119c:	7c e1                	jl     80117f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80119e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011a5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011ac:	eb 1f                	jmp    8011cd <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011b1:	8d 50 01             	lea    0x1(%eax),%edx
  8011b4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011b7:	89 c2                	mov    %eax,%edx
  8011b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011bc:	01 c2                	add    %eax,%edx
  8011be:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c4:	01 c8                	add    %ecx,%eax
  8011c6:	8a 00                	mov    (%eax),%al
  8011c8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011ca:	ff 45 f8             	incl   -0x8(%ebp)
  8011cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011d3:	7c d9                	jl     8011ae <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011db:	01 d0                	add    %edx,%eax
  8011dd:	c6 00 00             	movb   $0x0,(%eax)
}
  8011e0:	90                   	nop
  8011e1:	c9                   	leave  
  8011e2:	c3                   	ret    

008011e3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011e3:	55                   	push   %ebp
  8011e4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f2:	8b 00                	mov    (%eax),%eax
  8011f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fe:	01 d0                	add    %edx,%eax
  801200:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801206:	eb 0c                	jmp    801214 <strsplit+0x31>
			*string++ = 0;
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8d 50 01             	lea    0x1(%eax),%edx
  80120e:	89 55 08             	mov    %edx,0x8(%ebp)
  801211:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801214:	8b 45 08             	mov    0x8(%ebp),%eax
  801217:	8a 00                	mov    (%eax),%al
  801219:	84 c0                	test   %al,%al
  80121b:	74 18                	je     801235 <strsplit+0x52>
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
  801220:	8a 00                	mov    (%eax),%al
  801222:	0f be c0             	movsbl %al,%eax
  801225:	50                   	push   %eax
  801226:	ff 75 0c             	pushl  0xc(%ebp)
  801229:	e8 13 fb ff ff       	call   800d41 <strchr>
  80122e:	83 c4 08             	add    $0x8,%esp
  801231:	85 c0                	test   %eax,%eax
  801233:	75 d3                	jne    801208 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801235:	8b 45 08             	mov    0x8(%ebp),%eax
  801238:	8a 00                	mov    (%eax),%al
  80123a:	84 c0                	test   %al,%al
  80123c:	74 5a                	je     801298 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80123e:	8b 45 14             	mov    0x14(%ebp),%eax
  801241:	8b 00                	mov    (%eax),%eax
  801243:	83 f8 0f             	cmp    $0xf,%eax
  801246:	75 07                	jne    80124f <strsplit+0x6c>
		{
			return 0;
  801248:	b8 00 00 00 00       	mov    $0x0,%eax
  80124d:	eb 66                	jmp    8012b5 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80124f:	8b 45 14             	mov    0x14(%ebp),%eax
  801252:	8b 00                	mov    (%eax),%eax
  801254:	8d 48 01             	lea    0x1(%eax),%ecx
  801257:	8b 55 14             	mov    0x14(%ebp),%edx
  80125a:	89 0a                	mov    %ecx,(%edx)
  80125c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801263:	8b 45 10             	mov    0x10(%ebp),%eax
  801266:	01 c2                	add    %eax,%edx
  801268:	8b 45 08             	mov    0x8(%ebp),%eax
  80126b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80126d:	eb 03                	jmp    801272 <strsplit+0x8f>
			string++;
  80126f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	8a 00                	mov    (%eax),%al
  801277:	84 c0                	test   %al,%al
  801279:	74 8b                	je     801206 <strsplit+0x23>
  80127b:	8b 45 08             	mov    0x8(%ebp),%eax
  80127e:	8a 00                	mov    (%eax),%al
  801280:	0f be c0             	movsbl %al,%eax
  801283:	50                   	push   %eax
  801284:	ff 75 0c             	pushl  0xc(%ebp)
  801287:	e8 b5 fa ff ff       	call   800d41 <strchr>
  80128c:	83 c4 08             	add    $0x8,%esp
  80128f:	85 c0                	test   %eax,%eax
  801291:	74 dc                	je     80126f <strsplit+0x8c>
			string++;
	}
  801293:	e9 6e ff ff ff       	jmp    801206 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801298:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801299:	8b 45 14             	mov    0x14(%ebp),%eax
  80129c:	8b 00                	mov    (%eax),%eax
  80129e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a8:	01 d0                	add    %edx,%eax
  8012aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012b0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012b5:	c9                   	leave  
  8012b6:	c3                   	ret    

008012b7 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8012b7:	55                   	push   %ebp
  8012b8:	89 e5                	mov    %esp,%ebp
  8012ba:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8012bd:	83 ec 04             	sub    $0x4,%esp
  8012c0:	68 d0 23 80 00       	push   $0x8023d0
  8012c5:	6a 16                	push   $0x16
  8012c7:	68 f5 23 80 00       	push   $0x8023f5
  8012cc:	e8 ba ef ff ff       	call   80028b <_panic>

008012d1 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8012d1:	55                   	push   %ebp
  8012d2:	89 e5                	mov    %esp,%ebp
  8012d4:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8012d7:	83 ec 04             	sub    $0x4,%esp
  8012da:	68 04 24 80 00       	push   $0x802404
  8012df:	6a 2e                	push   $0x2e
  8012e1:	68 f5 23 80 00       	push   $0x8023f5
  8012e6:	e8 a0 ef ff ff       	call   80028b <_panic>

008012eb <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
  8012ee:	83 ec 18             	sub    $0x18,%esp
  8012f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f4:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8012f7:	83 ec 04             	sub    $0x4,%esp
  8012fa:	68 28 24 80 00       	push   $0x802428
  8012ff:	6a 3b                	push   $0x3b
  801301:	68 f5 23 80 00       	push   $0x8023f5
  801306:	e8 80 ef ff ff       	call   80028b <_panic>

0080130b <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80130b:	55                   	push   %ebp
  80130c:	89 e5                	mov    %esp,%ebp
  80130e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801311:	83 ec 04             	sub    $0x4,%esp
  801314:	68 28 24 80 00       	push   $0x802428
  801319:	6a 41                	push   $0x41
  80131b:	68 f5 23 80 00       	push   $0x8023f5
  801320:	e8 66 ef ff ff       	call   80028b <_panic>

00801325 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
  801328:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80132b:	83 ec 04             	sub    $0x4,%esp
  80132e:	68 28 24 80 00       	push   $0x802428
  801333:	6a 47                	push   $0x47
  801335:	68 f5 23 80 00       	push   $0x8023f5
  80133a:	e8 4c ef ff ff       	call   80028b <_panic>

0080133f <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80133f:	55                   	push   %ebp
  801340:	89 e5                	mov    %esp,%ebp
  801342:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801345:	83 ec 04             	sub    $0x4,%esp
  801348:	68 28 24 80 00       	push   $0x802428
  80134d:	6a 4c                	push   $0x4c
  80134f:	68 f5 23 80 00       	push   $0x8023f5
  801354:	e8 32 ef ff ff       	call   80028b <_panic>

00801359 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
  80135c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80135f:	83 ec 04             	sub    $0x4,%esp
  801362:	68 28 24 80 00       	push   $0x802428
  801367:	6a 52                	push   $0x52
  801369:	68 f5 23 80 00       	push   $0x8023f5
  80136e:	e8 18 ef ff ff       	call   80028b <_panic>

00801373 <shrink>:
}
void shrink(uint32 newSize)
{
  801373:	55                   	push   %ebp
  801374:	89 e5                	mov    %esp,%ebp
  801376:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801379:	83 ec 04             	sub    $0x4,%esp
  80137c:	68 28 24 80 00       	push   $0x802428
  801381:	6a 56                	push   $0x56
  801383:	68 f5 23 80 00       	push   $0x8023f5
  801388:	e8 fe ee ff ff       	call   80028b <_panic>

0080138d <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80138d:	55                   	push   %ebp
  80138e:	89 e5                	mov    %esp,%ebp
  801390:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801393:	83 ec 04             	sub    $0x4,%esp
  801396:	68 28 24 80 00       	push   $0x802428
  80139b:	6a 5b                	push   $0x5b
  80139d:	68 f5 23 80 00       	push   $0x8023f5
  8013a2:	e8 e4 ee ff ff       	call   80028b <_panic>

008013a7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8013a7:	55                   	push   %ebp
  8013a8:	89 e5                	mov    %esp,%ebp
  8013aa:	57                   	push   %edi
  8013ab:	56                   	push   %esi
  8013ac:	53                   	push   %ebx
  8013ad:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013bc:	8b 7d 18             	mov    0x18(%ebp),%edi
  8013bf:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8013c2:	cd 30                	int    $0x30
  8013c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8013c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8013ca:	83 c4 10             	add    $0x10,%esp
  8013cd:	5b                   	pop    %ebx
  8013ce:	5e                   	pop    %esi
  8013cf:	5f                   	pop    %edi
  8013d0:	5d                   	pop    %ebp
  8013d1:	c3                   	ret    

008013d2 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8013d2:	55                   	push   %ebp
  8013d3:	89 e5                	mov    %esp,%ebp
  8013d5:	83 ec 04             	sub    $0x4,%esp
  8013d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013db:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8013de:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	52                   	push   %edx
  8013ea:	ff 75 0c             	pushl  0xc(%ebp)
  8013ed:	50                   	push   %eax
  8013ee:	6a 00                	push   $0x0
  8013f0:	e8 b2 ff ff ff       	call   8013a7 <syscall>
  8013f5:	83 c4 18             	add    $0x18,%esp
}
  8013f8:	90                   	nop
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <sys_cgetc>:

int
sys_cgetc(void)
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 01                	push   $0x1
  80140a:	e8 98 ff ff ff       	call   8013a7 <syscall>
  80140f:	83 c4 18             	add    $0x18,%esp
}
  801412:	c9                   	leave  
  801413:	c3                   	ret    

00801414 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801417:	8b 45 08             	mov    0x8(%ebp),%eax
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	50                   	push   %eax
  801423:	6a 05                	push   $0x5
  801425:	e8 7d ff ff ff       	call   8013a7 <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
}
  80142d:	c9                   	leave  
  80142e:	c3                   	ret    

0080142f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80142f:	55                   	push   %ebp
  801430:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801432:	6a 00                	push   $0x0
  801434:	6a 00                	push   $0x0
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	6a 02                	push   $0x2
  80143e:	e8 64 ff ff ff       	call   8013a7 <syscall>
  801443:	83 c4 18             	add    $0x18,%esp
}
  801446:	c9                   	leave  
  801447:	c3                   	ret    

00801448 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801448:	55                   	push   %ebp
  801449:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	6a 03                	push   $0x3
  801457:	e8 4b ff ff ff       	call   8013a7 <syscall>
  80145c:	83 c4 18             	add    $0x18,%esp
}
  80145f:	c9                   	leave  
  801460:	c3                   	ret    

00801461 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801461:	55                   	push   %ebp
  801462:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	6a 04                	push   $0x4
  801470:	e8 32 ff ff ff       	call   8013a7 <syscall>
  801475:	83 c4 18             	add    $0x18,%esp
}
  801478:	c9                   	leave  
  801479:	c3                   	ret    

0080147a <sys_env_exit>:


void sys_env_exit(void)
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	6a 06                	push   $0x6
  801489:	e8 19 ff ff ff       	call   8013a7 <syscall>
  80148e:	83 c4 18             	add    $0x18,%esp
}
  801491:	90                   	nop
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801497:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	52                   	push   %edx
  8014a4:	50                   	push   %eax
  8014a5:	6a 07                	push   $0x7
  8014a7:	e8 fb fe ff ff       	call   8013a7 <syscall>
  8014ac:	83 c4 18             	add    $0x18,%esp
}
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
  8014b4:	56                   	push   %esi
  8014b5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8014b6:	8b 75 18             	mov    0x18(%ebp),%esi
  8014b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014bc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c5:	56                   	push   %esi
  8014c6:	53                   	push   %ebx
  8014c7:	51                   	push   %ecx
  8014c8:	52                   	push   %edx
  8014c9:	50                   	push   %eax
  8014ca:	6a 08                	push   $0x8
  8014cc:	e8 d6 fe ff ff       	call   8013a7 <syscall>
  8014d1:	83 c4 18             	add    $0x18,%esp
}
  8014d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8014d7:	5b                   	pop    %ebx
  8014d8:	5e                   	pop    %esi
  8014d9:	5d                   	pop    %ebp
  8014da:	c3                   	ret    

008014db <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8014db:	55                   	push   %ebp
  8014dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8014de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	52                   	push   %edx
  8014eb:	50                   	push   %eax
  8014ec:	6a 09                	push   $0x9
  8014ee:	e8 b4 fe ff ff       	call   8013a7 <syscall>
  8014f3:	83 c4 18             	add    $0x18,%esp
}
  8014f6:	c9                   	leave  
  8014f7:	c3                   	ret    

008014f8 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8014f8:	55                   	push   %ebp
  8014f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	ff 75 0c             	pushl  0xc(%ebp)
  801504:	ff 75 08             	pushl  0x8(%ebp)
  801507:	6a 0a                	push   $0xa
  801509:	e8 99 fe ff ff       	call   8013a7 <syscall>
  80150e:	83 c4 18             	add    $0x18,%esp
}
  801511:	c9                   	leave  
  801512:	c3                   	ret    

00801513 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 0b                	push   $0xb
  801522:	e8 80 fe ff ff       	call   8013a7 <syscall>
  801527:	83 c4 18             	add    $0x18,%esp
}
  80152a:	c9                   	leave  
  80152b:	c3                   	ret    

0080152c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80152c:	55                   	push   %ebp
  80152d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 0c                	push   $0xc
  80153b:	e8 67 fe ff ff       	call   8013a7 <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
}
  801543:	c9                   	leave  
  801544:	c3                   	ret    

00801545 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 0d                	push   $0xd
  801554:	e8 4e fe ff ff       	call   8013a7 <syscall>
  801559:	83 c4 18             	add    $0x18,%esp
}
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	ff 75 0c             	pushl  0xc(%ebp)
  80156a:	ff 75 08             	pushl  0x8(%ebp)
  80156d:	6a 11                	push   $0x11
  80156f:	e8 33 fe ff ff       	call   8013a7 <syscall>
  801574:	83 c4 18             	add    $0x18,%esp
	return;
  801577:	90                   	nop
}
  801578:	c9                   	leave  
  801579:	c3                   	ret    

0080157a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80157a:	55                   	push   %ebp
  80157b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	ff 75 0c             	pushl  0xc(%ebp)
  801586:	ff 75 08             	pushl  0x8(%ebp)
  801589:	6a 12                	push   $0x12
  80158b:	e8 17 fe ff ff       	call   8013a7 <syscall>
  801590:	83 c4 18             	add    $0x18,%esp
	return ;
  801593:	90                   	nop
}
  801594:	c9                   	leave  
  801595:	c3                   	ret    

00801596 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801596:	55                   	push   %ebp
  801597:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 0e                	push   $0xe
  8015a5:	e8 fd fd ff ff       	call   8013a7 <syscall>
  8015aa:	83 c4 18             	add    $0x18,%esp
}
  8015ad:	c9                   	leave  
  8015ae:	c3                   	ret    

008015af <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8015af:	55                   	push   %ebp
  8015b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	ff 75 08             	pushl  0x8(%ebp)
  8015bd:	6a 0f                	push   $0xf
  8015bf:	e8 e3 fd ff ff       	call   8013a7 <syscall>
  8015c4:	83 c4 18             	add    $0x18,%esp
}
  8015c7:	c9                   	leave  
  8015c8:	c3                   	ret    

008015c9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8015c9:	55                   	push   %ebp
  8015ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 10                	push   $0x10
  8015d8:	e8 ca fd ff ff       	call   8013a7 <syscall>
  8015dd:	83 c4 18             	add    $0x18,%esp
}
  8015e0:	90                   	nop
  8015e1:	c9                   	leave  
  8015e2:	c3                   	ret    

008015e3 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8015e3:	55                   	push   %ebp
  8015e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 14                	push   $0x14
  8015f2:	e8 b0 fd ff ff       	call   8013a7 <syscall>
  8015f7:	83 c4 18             	add    $0x18,%esp
}
  8015fa:	90                   	nop
  8015fb:	c9                   	leave  
  8015fc:	c3                   	ret    

008015fd <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8015fd:	55                   	push   %ebp
  8015fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801600:	6a 00                	push   $0x0
  801602:	6a 00                	push   $0x0
  801604:	6a 00                	push   $0x0
  801606:	6a 00                	push   $0x0
  801608:	6a 00                	push   $0x0
  80160a:	6a 15                	push   $0x15
  80160c:	e8 96 fd ff ff       	call   8013a7 <syscall>
  801611:	83 c4 18             	add    $0x18,%esp
}
  801614:	90                   	nop
  801615:	c9                   	leave  
  801616:	c3                   	ret    

00801617 <sys_cputc>:


void
sys_cputc(const char c)
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
  80161a:	83 ec 04             	sub    $0x4,%esp
  80161d:	8b 45 08             	mov    0x8(%ebp),%eax
  801620:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801623:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	50                   	push   %eax
  801630:	6a 16                	push   $0x16
  801632:	e8 70 fd ff ff       	call   8013a7 <syscall>
  801637:	83 c4 18             	add    $0x18,%esp
}
  80163a:	90                   	nop
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    

0080163d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80163d:	55                   	push   %ebp
  80163e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 17                	push   $0x17
  80164c:	e8 56 fd ff ff       	call   8013a7 <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	90                   	nop
  801655:	c9                   	leave  
  801656:	c3                   	ret    

00801657 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801657:	55                   	push   %ebp
  801658:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	ff 75 0c             	pushl  0xc(%ebp)
  801666:	50                   	push   %eax
  801667:	6a 18                	push   $0x18
  801669:	e8 39 fd ff ff       	call   8013a7 <syscall>
  80166e:	83 c4 18             	add    $0x18,%esp
}
  801671:	c9                   	leave  
  801672:	c3                   	ret    

00801673 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801673:	55                   	push   %ebp
  801674:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801676:	8b 55 0c             	mov    0xc(%ebp),%edx
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	52                   	push   %edx
  801683:	50                   	push   %eax
  801684:	6a 1b                	push   $0x1b
  801686:	e8 1c fd ff ff       	call   8013a7 <syscall>
  80168b:	83 c4 18             	add    $0x18,%esp
}
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801693:	8b 55 0c             	mov    0xc(%ebp),%edx
  801696:	8b 45 08             	mov    0x8(%ebp),%eax
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	52                   	push   %edx
  8016a0:	50                   	push   %eax
  8016a1:	6a 19                	push   $0x19
  8016a3:	e8 ff fc ff ff       	call   8013a7 <syscall>
  8016a8:	83 c4 18             	add    $0x18,%esp
}
  8016ab:	90                   	nop
  8016ac:	c9                   	leave  
  8016ad:	c3                   	ret    

008016ae <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	52                   	push   %edx
  8016be:	50                   	push   %eax
  8016bf:	6a 1a                	push   $0x1a
  8016c1:	e8 e1 fc ff ff       	call   8013a7 <syscall>
  8016c6:	83 c4 18             	add    $0x18,%esp
}
  8016c9:	90                   	nop
  8016ca:	c9                   	leave  
  8016cb:	c3                   	ret    

008016cc <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8016cc:	55                   	push   %ebp
  8016cd:	89 e5                	mov    %esp,%ebp
  8016cf:	83 ec 04             	sub    $0x4,%esp
  8016d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8016d8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016db:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016df:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e2:	6a 00                	push   $0x0
  8016e4:	51                   	push   %ecx
  8016e5:	52                   	push   %edx
  8016e6:	ff 75 0c             	pushl  0xc(%ebp)
  8016e9:	50                   	push   %eax
  8016ea:	6a 1c                	push   $0x1c
  8016ec:	e8 b6 fc ff ff       	call   8013a7 <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
}
  8016f4:	c9                   	leave  
  8016f5:	c3                   	ret    

008016f6 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8016f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	52                   	push   %edx
  801706:	50                   	push   %eax
  801707:	6a 1d                	push   $0x1d
  801709:	e8 99 fc ff ff       	call   8013a7 <syscall>
  80170e:	83 c4 18             	add    $0x18,%esp
}
  801711:	c9                   	leave  
  801712:	c3                   	ret    

00801713 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801713:	55                   	push   %ebp
  801714:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801716:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801719:	8b 55 0c             	mov    0xc(%ebp),%edx
  80171c:	8b 45 08             	mov    0x8(%ebp),%eax
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	51                   	push   %ecx
  801724:	52                   	push   %edx
  801725:	50                   	push   %eax
  801726:	6a 1e                	push   $0x1e
  801728:	e8 7a fc ff ff       	call   8013a7 <syscall>
  80172d:	83 c4 18             	add    $0x18,%esp
}
  801730:	c9                   	leave  
  801731:	c3                   	ret    

00801732 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801732:	55                   	push   %ebp
  801733:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801735:	8b 55 0c             	mov    0xc(%ebp),%edx
  801738:	8b 45 08             	mov    0x8(%ebp),%eax
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	52                   	push   %edx
  801742:	50                   	push   %eax
  801743:	6a 1f                	push   $0x1f
  801745:	e8 5d fc ff ff       	call   8013a7 <syscall>
  80174a:	83 c4 18             	add    $0x18,%esp
}
  80174d:	c9                   	leave  
  80174e:	c3                   	ret    

0080174f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80174f:	55                   	push   %ebp
  801750:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 20                	push   $0x20
  80175e:	e8 44 fc ff ff       	call   8013a7 <syscall>
  801763:	83 c4 18             	add    $0x18,%esp
}
  801766:	c9                   	leave  
  801767:	c3                   	ret    

00801768 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801768:	55                   	push   %ebp
  801769:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80176b:	8b 45 08             	mov    0x8(%ebp),%eax
  80176e:	6a 00                	push   $0x0
  801770:	ff 75 14             	pushl  0x14(%ebp)
  801773:	ff 75 10             	pushl  0x10(%ebp)
  801776:	ff 75 0c             	pushl  0xc(%ebp)
  801779:	50                   	push   %eax
  80177a:	6a 21                	push   $0x21
  80177c:	e8 26 fc ff ff       	call   8013a7 <syscall>
  801781:	83 c4 18             	add    $0x18,%esp
}
  801784:	c9                   	leave  
  801785:	c3                   	ret    

00801786 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801786:	55                   	push   %ebp
  801787:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801789:	8b 45 08             	mov    0x8(%ebp),%eax
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	50                   	push   %eax
  801795:	6a 22                	push   $0x22
  801797:	e8 0b fc ff ff       	call   8013a7 <syscall>
  80179c:	83 c4 18             	add    $0x18,%esp
}
  80179f:	90                   	nop
  8017a0:	c9                   	leave  
  8017a1:	c3                   	ret    

008017a2 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8017a2:	55                   	push   %ebp
  8017a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	50                   	push   %eax
  8017b1:	6a 23                	push   $0x23
  8017b3:	e8 ef fb ff ff       	call   8013a7 <syscall>
  8017b8:	83 c4 18             	add    $0x18,%esp
}
  8017bb:	90                   	nop
  8017bc:	c9                   	leave  
  8017bd:	c3                   	ret    

008017be <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8017be:	55                   	push   %ebp
  8017bf:	89 e5                	mov    %esp,%ebp
  8017c1:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8017c4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8017c7:	8d 50 04             	lea    0x4(%eax),%edx
  8017ca:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	52                   	push   %edx
  8017d4:	50                   	push   %eax
  8017d5:	6a 24                	push   $0x24
  8017d7:	e8 cb fb ff ff       	call   8013a7 <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
	return result;
  8017df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017e5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017e8:	89 01                	mov    %eax,(%ecx)
  8017ea:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8017ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f0:	c9                   	leave  
  8017f1:	c2 04 00             	ret    $0x4

008017f4 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	ff 75 10             	pushl  0x10(%ebp)
  8017fe:	ff 75 0c             	pushl  0xc(%ebp)
  801801:	ff 75 08             	pushl  0x8(%ebp)
  801804:	6a 13                	push   $0x13
  801806:	e8 9c fb ff ff       	call   8013a7 <syscall>
  80180b:	83 c4 18             	add    $0x18,%esp
	return ;
  80180e:	90                   	nop
}
  80180f:	c9                   	leave  
  801810:	c3                   	ret    

00801811 <sys_rcr2>:
uint32 sys_rcr2()
{
  801811:	55                   	push   %ebp
  801812:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 25                	push   $0x25
  801820:	e8 82 fb ff ff       	call   8013a7 <syscall>
  801825:	83 c4 18             	add    $0x18,%esp
}
  801828:	c9                   	leave  
  801829:	c3                   	ret    

0080182a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80182a:	55                   	push   %ebp
  80182b:	89 e5                	mov    %esp,%ebp
  80182d:	83 ec 04             	sub    $0x4,%esp
  801830:	8b 45 08             	mov    0x8(%ebp),%eax
  801833:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801836:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	50                   	push   %eax
  801843:	6a 26                	push   $0x26
  801845:	e8 5d fb ff ff       	call   8013a7 <syscall>
  80184a:	83 c4 18             	add    $0x18,%esp
	return ;
  80184d:	90                   	nop
}
  80184e:	c9                   	leave  
  80184f:	c3                   	ret    

00801850 <rsttst>:
void rsttst()
{
  801850:	55                   	push   %ebp
  801851:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 28                	push   $0x28
  80185f:	e8 43 fb ff ff       	call   8013a7 <syscall>
  801864:	83 c4 18             	add    $0x18,%esp
	return ;
  801867:	90                   	nop
}
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
  80186d:	83 ec 04             	sub    $0x4,%esp
  801870:	8b 45 14             	mov    0x14(%ebp),%eax
  801873:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801876:	8b 55 18             	mov    0x18(%ebp),%edx
  801879:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80187d:	52                   	push   %edx
  80187e:	50                   	push   %eax
  80187f:	ff 75 10             	pushl  0x10(%ebp)
  801882:	ff 75 0c             	pushl  0xc(%ebp)
  801885:	ff 75 08             	pushl  0x8(%ebp)
  801888:	6a 27                	push   $0x27
  80188a:	e8 18 fb ff ff       	call   8013a7 <syscall>
  80188f:	83 c4 18             	add    $0x18,%esp
	return ;
  801892:	90                   	nop
}
  801893:	c9                   	leave  
  801894:	c3                   	ret    

00801895 <chktst>:
void chktst(uint32 n)
{
  801895:	55                   	push   %ebp
  801896:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	ff 75 08             	pushl  0x8(%ebp)
  8018a3:	6a 29                	push   $0x29
  8018a5:	e8 fd fa ff ff       	call   8013a7 <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ad:	90                   	nop
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <inctst>:

void inctst()
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 2a                	push   $0x2a
  8018bf:	e8 e3 fa ff ff       	call   8013a7 <syscall>
  8018c4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c7:	90                   	nop
}
  8018c8:	c9                   	leave  
  8018c9:	c3                   	ret    

008018ca <gettst>:
uint32 gettst()
{
  8018ca:	55                   	push   %ebp
  8018cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 2b                	push   $0x2b
  8018d9:	e8 c9 fa ff ff       	call   8013a7 <syscall>
  8018de:	83 c4 18             	add    $0x18,%esp
}
  8018e1:	c9                   	leave  
  8018e2:	c3                   	ret    

008018e3 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8018e3:	55                   	push   %ebp
  8018e4:	89 e5                	mov    %esp,%ebp
  8018e6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 2c                	push   $0x2c
  8018f5:	e8 ad fa ff ff       	call   8013a7 <syscall>
  8018fa:	83 c4 18             	add    $0x18,%esp
  8018fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801900:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801904:	75 07                	jne    80190d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801906:	b8 01 00 00 00       	mov    $0x1,%eax
  80190b:	eb 05                	jmp    801912 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80190d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801912:	c9                   	leave  
  801913:	c3                   	ret    

00801914 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801914:	55                   	push   %ebp
  801915:	89 e5                	mov    %esp,%ebp
  801917:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 2c                	push   $0x2c
  801926:	e8 7c fa ff ff       	call   8013a7 <syscall>
  80192b:	83 c4 18             	add    $0x18,%esp
  80192e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801931:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801935:	75 07                	jne    80193e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801937:	b8 01 00 00 00       	mov    $0x1,%eax
  80193c:	eb 05                	jmp    801943 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80193e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801943:	c9                   	leave  
  801944:	c3                   	ret    

00801945 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801945:	55                   	push   %ebp
  801946:	89 e5                	mov    %esp,%ebp
  801948:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 2c                	push   $0x2c
  801957:	e8 4b fa ff ff       	call   8013a7 <syscall>
  80195c:	83 c4 18             	add    $0x18,%esp
  80195f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801962:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801966:	75 07                	jne    80196f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801968:	b8 01 00 00 00       	mov    $0x1,%eax
  80196d:	eb 05                	jmp    801974 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80196f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801974:	c9                   	leave  
  801975:	c3                   	ret    

00801976 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801976:	55                   	push   %ebp
  801977:	89 e5                	mov    %esp,%ebp
  801979:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 2c                	push   $0x2c
  801988:	e8 1a fa ff ff       	call   8013a7 <syscall>
  80198d:	83 c4 18             	add    $0x18,%esp
  801990:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801993:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801997:	75 07                	jne    8019a0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801999:	b8 01 00 00 00       	mov    $0x1,%eax
  80199e:	eb 05                	jmp    8019a5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8019a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019a5:	c9                   	leave  
  8019a6:	c3                   	ret    

008019a7 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	ff 75 08             	pushl  0x8(%ebp)
  8019b5:	6a 2d                	push   $0x2d
  8019b7:	e8 eb f9 ff ff       	call   8013a7 <syscall>
  8019bc:	83 c4 18             	add    $0x18,%esp
	return ;
  8019bf:	90                   	nop
}
  8019c0:	c9                   	leave  
  8019c1:	c3                   	ret    

008019c2 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8019c2:	55                   	push   %ebp
  8019c3:	89 e5                	mov    %esp,%ebp
  8019c5:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8019c6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019c9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d2:	6a 00                	push   $0x0
  8019d4:	53                   	push   %ebx
  8019d5:	51                   	push   %ecx
  8019d6:	52                   	push   %edx
  8019d7:	50                   	push   %eax
  8019d8:	6a 2e                	push   $0x2e
  8019da:	e8 c8 f9 ff ff       	call   8013a7 <syscall>
  8019df:	83 c4 18             	add    $0x18,%esp
}
  8019e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8019e5:	c9                   	leave  
  8019e6:	c3                   	ret    

008019e7 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8019e7:	55                   	push   %ebp
  8019e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8019ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	52                   	push   %edx
  8019f7:	50                   	push   %eax
  8019f8:	6a 2f                	push   $0x2f
  8019fa:	e8 a8 f9 ff ff       	call   8013a7 <syscall>
  8019ff:	83 c4 18             	add    $0x18,%esp
}
  801a02:	c9                   	leave  
  801a03:	c3                   	ret    

00801a04 <__udivdi3>:
  801a04:	55                   	push   %ebp
  801a05:	57                   	push   %edi
  801a06:	56                   	push   %esi
  801a07:	53                   	push   %ebx
  801a08:	83 ec 1c             	sub    $0x1c,%esp
  801a0b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a0f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a13:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a17:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a1b:	89 ca                	mov    %ecx,%edx
  801a1d:	89 f8                	mov    %edi,%eax
  801a1f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a23:	85 f6                	test   %esi,%esi
  801a25:	75 2d                	jne    801a54 <__udivdi3+0x50>
  801a27:	39 cf                	cmp    %ecx,%edi
  801a29:	77 65                	ja     801a90 <__udivdi3+0x8c>
  801a2b:	89 fd                	mov    %edi,%ebp
  801a2d:	85 ff                	test   %edi,%edi
  801a2f:	75 0b                	jne    801a3c <__udivdi3+0x38>
  801a31:	b8 01 00 00 00       	mov    $0x1,%eax
  801a36:	31 d2                	xor    %edx,%edx
  801a38:	f7 f7                	div    %edi
  801a3a:	89 c5                	mov    %eax,%ebp
  801a3c:	31 d2                	xor    %edx,%edx
  801a3e:	89 c8                	mov    %ecx,%eax
  801a40:	f7 f5                	div    %ebp
  801a42:	89 c1                	mov    %eax,%ecx
  801a44:	89 d8                	mov    %ebx,%eax
  801a46:	f7 f5                	div    %ebp
  801a48:	89 cf                	mov    %ecx,%edi
  801a4a:	89 fa                	mov    %edi,%edx
  801a4c:	83 c4 1c             	add    $0x1c,%esp
  801a4f:	5b                   	pop    %ebx
  801a50:	5e                   	pop    %esi
  801a51:	5f                   	pop    %edi
  801a52:	5d                   	pop    %ebp
  801a53:	c3                   	ret    
  801a54:	39 ce                	cmp    %ecx,%esi
  801a56:	77 28                	ja     801a80 <__udivdi3+0x7c>
  801a58:	0f bd fe             	bsr    %esi,%edi
  801a5b:	83 f7 1f             	xor    $0x1f,%edi
  801a5e:	75 40                	jne    801aa0 <__udivdi3+0x9c>
  801a60:	39 ce                	cmp    %ecx,%esi
  801a62:	72 0a                	jb     801a6e <__udivdi3+0x6a>
  801a64:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a68:	0f 87 9e 00 00 00    	ja     801b0c <__udivdi3+0x108>
  801a6e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a73:	89 fa                	mov    %edi,%edx
  801a75:	83 c4 1c             	add    $0x1c,%esp
  801a78:	5b                   	pop    %ebx
  801a79:	5e                   	pop    %esi
  801a7a:	5f                   	pop    %edi
  801a7b:	5d                   	pop    %ebp
  801a7c:	c3                   	ret    
  801a7d:	8d 76 00             	lea    0x0(%esi),%esi
  801a80:	31 ff                	xor    %edi,%edi
  801a82:	31 c0                	xor    %eax,%eax
  801a84:	89 fa                	mov    %edi,%edx
  801a86:	83 c4 1c             	add    $0x1c,%esp
  801a89:	5b                   	pop    %ebx
  801a8a:	5e                   	pop    %esi
  801a8b:	5f                   	pop    %edi
  801a8c:	5d                   	pop    %ebp
  801a8d:	c3                   	ret    
  801a8e:	66 90                	xchg   %ax,%ax
  801a90:	89 d8                	mov    %ebx,%eax
  801a92:	f7 f7                	div    %edi
  801a94:	31 ff                	xor    %edi,%edi
  801a96:	89 fa                	mov    %edi,%edx
  801a98:	83 c4 1c             	add    $0x1c,%esp
  801a9b:	5b                   	pop    %ebx
  801a9c:	5e                   	pop    %esi
  801a9d:	5f                   	pop    %edi
  801a9e:	5d                   	pop    %ebp
  801a9f:	c3                   	ret    
  801aa0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801aa5:	89 eb                	mov    %ebp,%ebx
  801aa7:	29 fb                	sub    %edi,%ebx
  801aa9:	89 f9                	mov    %edi,%ecx
  801aab:	d3 e6                	shl    %cl,%esi
  801aad:	89 c5                	mov    %eax,%ebp
  801aaf:	88 d9                	mov    %bl,%cl
  801ab1:	d3 ed                	shr    %cl,%ebp
  801ab3:	89 e9                	mov    %ebp,%ecx
  801ab5:	09 f1                	or     %esi,%ecx
  801ab7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801abb:	89 f9                	mov    %edi,%ecx
  801abd:	d3 e0                	shl    %cl,%eax
  801abf:	89 c5                	mov    %eax,%ebp
  801ac1:	89 d6                	mov    %edx,%esi
  801ac3:	88 d9                	mov    %bl,%cl
  801ac5:	d3 ee                	shr    %cl,%esi
  801ac7:	89 f9                	mov    %edi,%ecx
  801ac9:	d3 e2                	shl    %cl,%edx
  801acb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801acf:	88 d9                	mov    %bl,%cl
  801ad1:	d3 e8                	shr    %cl,%eax
  801ad3:	09 c2                	or     %eax,%edx
  801ad5:	89 d0                	mov    %edx,%eax
  801ad7:	89 f2                	mov    %esi,%edx
  801ad9:	f7 74 24 0c          	divl   0xc(%esp)
  801add:	89 d6                	mov    %edx,%esi
  801adf:	89 c3                	mov    %eax,%ebx
  801ae1:	f7 e5                	mul    %ebp
  801ae3:	39 d6                	cmp    %edx,%esi
  801ae5:	72 19                	jb     801b00 <__udivdi3+0xfc>
  801ae7:	74 0b                	je     801af4 <__udivdi3+0xf0>
  801ae9:	89 d8                	mov    %ebx,%eax
  801aeb:	31 ff                	xor    %edi,%edi
  801aed:	e9 58 ff ff ff       	jmp    801a4a <__udivdi3+0x46>
  801af2:	66 90                	xchg   %ax,%ax
  801af4:	8b 54 24 08          	mov    0x8(%esp),%edx
  801af8:	89 f9                	mov    %edi,%ecx
  801afa:	d3 e2                	shl    %cl,%edx
  801afc:	39 c2                	cmp    %eax,%edx
  801afe:	73 e9                	jae    801ae9 <__udivdi3+0xe5>
  801b00:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b03:	31 ff                	xor    %edi,%edi
  801b05:	e9 40 ff ff ff       	jmp    801a4a <__udivdi3+0x46>
  801b0a:	66 90                	xchg   %ax,%ax
  801b0c:	31 c0                	xor    %eax,%eax
  801b0e:	e9 37 ff ff ff       	jmp    801a4a <__udivdi3+0x46>
  801b13:	90                   	nop

00801b14 <__umoddi3>:
  801b14:	55                   	push   %ebp
  801b15:	57                   	push   %edi
  801b16:	56                   	push   %esi
  801b17:	53                   	push   %ebx
  801b18:	83 ec 1c             	sub    $0x1c,%esp
  801b1b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b1f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b23:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b27:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b2f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b33:	89 f3                	mov    %esi,%ebx
  801b35:	89 fa                	mov    %edi,%edx
  801b37:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b3b:	89 34 24             	mov    %esi,(%esp)
  801b3e:	85 c0                	test   %eax,%eax
  801b40:	75 1a                	jne    801b5c <__umoddi3+0x48>
  801b42:	39 f7                	cmp    %esi,%edi
  801b44:	0f 86 a2 00 00 00    	jbe    801bec <__umoddi3+0xd8>
  801b4a:	89 c8                	mov    %ecx,%eax
  801b4c:	89 f2                	mov    %esi,%edx
  801b4e:	f7 f7                	div    %edi
  801b50:	89 d0                	mov    %edx,%eax
  801b52:	31 d2                	xor    %edx,%edx
  801b54:	83 c4 1c             	add    $0x1c,%esp
  801b57:	5b                   	pop    %ebx
  801b58:	5e                   	pop    %esi
  801b59:	5f                   	pop    %edi
  801b5a:	5d                   	pop    %ebp
  801b5b:	c3                   	ret    
  801b5c:	39 f0                	cmp    %esi,%eax
  801b5e:	0f 87 ac 00 00 00    	ja     801c10 <__umoddi3+0xfc>
  801b64:	0f bd e8             	bsr    %eax,%ebp
  801b67:	83 f5 1f             	xor    $0x1f,%ebp
  801b6a:	0f 84 ac 00 00 00    	je     801c1c <__umoddi3+0x108>
  801b70:	bf 20 00 00 00       	mov    $0x20,%edi
  801b75:	29 ef                	sub    %ebp,%edi
  801b77:	89 fe                	mov    %edi,%esi
  801b79:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b7d:	89 e9                	mov    %ebp,%ecx
  801b7f:	d3 e0                	shl    %cl,%eax
  801b81:	89 d7                	mov    %edx,%edi
  801b83:	89 f1                	mov    %esi,%ecx
  801b85:	d3 ef                	shr    %cl,%edi
  801b87:	09 c7                	or     %eax,%edi
  801b89:	89 e9                	mov    %ebp,%ecx
  801b8b:	d3 e2                	shl    %cl,%edx
  801b8d:	89 14 24             	mov    %edx,(%esp)
  801b90:	89 d8                	mov    %ebx,%eax
  801b92:	d3 e0                	shl    %cl,%eax
  801b94:	89 c2                	mov    %eax,%edx
  801b96:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b9a:	d3 e0                	shl    %cl,%eax
  801b9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ba0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ba4:	89 f1                	mov    %esi,%ecx
  801ba6:	d3 e8                	shr    %cl,%eax
  801ba8:	09 d0                	or     %edx,%eax
  801baa:	d3 eb                	shr    %cl,%ebx
  801bac:	89 da                	mov    %ebx,%edx
  801bae:	f7 f7                	div    %edi
  801bb0:	89 d3                	mov    %edx,%ebx
  801bb2:	f7 24 24             	mull   (%esp)
  801bb5:	89 c6                	mov    %eax,%esi
  801bb7:	89 d1                	mov    %edx,%ecx
  801bb9:	39 d3                	cmp    %edx,%ebx
  801bbb:	0f 82 87 00 00 00    	jb     801c48 <__umoddi3+0x134>
  801bc1:	0f 84 91 00 00 00    	je     801c58 <__umoddi3+0x144>
  801bc7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bcb:	29 f2                	sub    %esi,%edx
  801bcd:	19 cb                	sbb    %ecx,%ebx
  801bcf:	89 d8                	mov    %ebx,%eax
  801bd1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bd5:	d3 e0                	shl    %cl,%eax
  801bd7:	89 e9                	mov    %ebp,%ecx
  801bd9:	d3 ea                	shr    %cl,%edx
  801bdb:	09 d0                	or     %edx,%eax
  801bdd:	89 e9                	mov    %ebp,%ecx
  801bdf:	d3 eb                	shr    %cl,%ebx
  801be1:	89 da                	mov    %ebx,%edx
  801be3:	83 c4 1c             	add    $0x1c,%esp
  801be6:	5b                   	pop    %ebx
  801be7:	5e                   	pop    %esi
  801be8:	5f                   	pop    %edi
  801be9:	5d                   	pop    %ebp
  801bea:	c3                   	ret    
  801beb:	90                   	nop
  801bec:	89 fd                	mov    %edi,%ebp
  801bee:	85 ff                	test   %edi,%edi
  801bf0:	75 0b                	jne    801bfd <__umoddi3+0xe9>
  801bf2:	b8 01 00 00 00       	mov    $0x1,%eax
  801bf7:	31 d2                	xor    %edx,%edx
  801bf9:	f7 f7                	div    %edi
  801bfb:	89 c5                	mov    %eax,%ebp
  801bfd:	89 f0                	mov    %esi,%eax
  801bff:	31 d2                	xor    %edx,%edx
  801c01:	f7 f5                	div    %ebp
  801c03:	89 c8                	mov    %ecx,%eax
  801c05:	f7 f5                	div    %ebp
  801c07:	89 d0                	mov    %edx,%eax
  801c09:	e9 44 ff ff ff       	jmp    801b52 <__umoddi3+0x3e>
  801c0e:	66 90                	xchg   %ax,%ax
  801c10:	89 c8                	mov    %ecx,%eax
  801c12:	89 f2                	mov    %esi,%edx
  801c14:	83 c4 1c             	add    $0x1c,%esp
  801c17:	5b                   	pop    %ebx
  801c18:	5e                   	pop    %esi
  801c19:	5f                   	pop    %edi
  801c1a:	5d                   	pop    %ebp
  801c1b:	c3                   	ret    
  801c1c:	3b 04 24             	cmp    (%esp),%eax
  801c1f:	72 06                	jb     801c27 <__umoddi3+0x113>
  801c21:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c25:	77 0f                	ja     801c36 <__umoddi3+0x122>
  801c27:	89 f2                	mov    %esi,%edx
  801c29:	29 f9                	sub    %edi,%ecx
  801c2b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c2f:	89 14 24             	mov    %edx,(%esp)
  801c32:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c36:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c3a:	8b 14 24             	mov    (%esp),%edx
  801c3d:	83 c4 1c             	add    $0x1c,%esp
  801c40:	5b                   	pop    %ebx
  801c41:	5e                   	pop    %esi
  801c42:	5f                   	pop    %edi
  801c43:	5d                   	pop    %ebp
  801c44:	c3                   	ret    
  801c45:	8d 76 00             	lea    0x0(%esi),%esi
  801c48:	2b 04 24             	sub    (%esp),%eax
  801c4b:	19 fa                	sbb    %edi,%edx
  801c4d:	89 d1                	mov    %edx,%ecx
  801c4f:	89 c6                	mov    %eax,%esi
  801c51:	e9 71 ff ff ff       	jmp    801bc7 <__umoddi3+0xb3>
  801c56:	66 90                	xchg   %ax,%ax
  801c58:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c5c:	72 ea                	jb     801c48 <__umoddi3+0x134>
  801c5e:	89 d9                	mov    %ebx,%ecx
  801c60:	e9 62 ff ff ff       	jmp    801bc7 <__umoddi3+0xb3>

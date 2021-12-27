
obj/user/tst_envfree1:     file format elf32-i386


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
  800031:	e8 9c 01 00 00       	call   8001d2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests environment free run tef1 5 3
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	// Testing scenario 1: without using dynamic allocation/de-allocation, shared variables and semaphores
	// Testing removing the allocated pages in mem, WS, mapped page tables, env's directory and env's page file

	int freeFrames_before = sys_calculate_free_frames() ;
  80003e:	e8 6c 14 00 00       	call   8014af <sys_calculate_free_frames>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800046:	e8 e7 14 00 00       	call   801532 <sys_pf_calculate_allocated_pages>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	ff 75 f4             	pushl  -0xc(%ebp)
  800054:	68 c0 1c 80 00       	push   $0x801cc0
  800059:	e8 5b 05 00 00       	call   8005b9 <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp

	/*[4] CREATE AND RUN ProcessA & ProcessB*/
	//Create 3 processes

	int32 envIdProcessA = sys_create_env("ef_fib", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  800061:	a1 20 30 80 00       	mov    0x803020,%eax
  800066:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80006c:	89 c2                	mov    %eax,%edx
  80006e:	a1 20 30 80 00       	mov    0x803020,%eax
  800073:	8b 40 74             	mov    0x74(%eax),%eax
  800076:	6a 32                	push   $0x32
  800078:	52                   	push   %edx
  800079:	50                   	push   %eax
  80007a:	68 f3 1c 80 00       	push   $0x801cf3
  80007f:	e8 80 16 00 00       	call   801704 <sys_create_env>
  800084:	83 c4 10             	add    $0x10,%esp
  800087:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int32 envIdProcessB = sys_create_env("ef_fact", (myEnv->page_WS_max_size)-1,(myEnv->SecondListSize), 50);
  80008a:	a1 20 30 80 00       	mov    0x803020,%eax
  80008f:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800095:	89 c2                	mov    %eax,%edx
  800097:	a1 20 30 80 00       	mov    0x803020,%eax
  80009c:	8b 40 74             	mov    0x74(%eax),%eax
  80009f:	48                   	dec    %eax
  8000a0:	6a 32                	push   $0x32
  8000a2:	52                   	push   %edx
  8000a3:	50                   	push   %eax
  8000a4:	68 fa 1c 80 00       	push   $0x801cfa
  8000a9:	e8 56 16 00 00       	call   801704 <sys_create_env>
  8000ae:	83 c4 10             	add    $0x10,%esp
  8000b1:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int32 envIdProcessC = sys_create_env("ef_fos_add",(myEnv->page_WS_max_size)*4,(myEnv->SecondListSize), 50);
  8000b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b9:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000bf:	89 c2                	mov    %eax,%edx
  8000c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c6:	8b 40 74             	mov    0x74(%eax),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	6a 32                	push   $0x32
  8000ce:	52                   	push   %edx
  8000cf:	50                   	push   %eax
  8000d0:	68 02 1d 80 00       	push   $0x801d02
  8000d5:	e8 2a 16 00 00       	call   801704 <sys_create_env>
  8000da:	83 c4 10             	add    $0x10,%esp
  8000dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//Run 3 processes
	sys_run_env(envIdProcessA);
  8000e0:	83 ec 0c             	sub    $0xc,%esp
  8000e3:	ff 75 ec             	pushl  -0x14(%ebp)
  8000e6:	e8 37 16 00 00       	call   801722 <sys_run_env>
  8000eb:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	ff 75 e8             	pushl  -0x18(%ebp)
  8000f4:	e8 29 16 00 00       	call   801722 <sys_run_env>
  8000f9:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessC);
  8000fc:	83 ec 0c             	sub    $0xc,%esp
  8000ff:	ff 75 e4             	pushl  -0x1c(%ebp)
  800102:	e8 1b 16 00 00       	call   801722 <sys_run_env>
  800107:	83 c4 10             	add    $0x10,%esp

	env_sleep(6000);
  80010a:	83 ec 0c             	sub    $0xc,%esp
  80010d:	68 70 17 00 00       	push   $0x1770
  800112:	e8 89 18 00 00       	call   8019a0 <env_sleep>
  800117:	83 c4 10             	add    $0x10,%esp
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  80011a:	e8 90 13 00 00       	call   8014af <sys_calculate_free_frames>
  80011f:	83 ec 08             	sub    $0x8,%esp
  800122:	50                   	push   %eax
  800123:	68 10 1d 80 00       	push   $0x801d10
  800128:	e8 8c 04 00 00       	call   8005b9 <cprintf>
  80012d:	83 c4 10             	add    $0x10,%esp

	//Kill the 3 processes
	sys_free_env(envIdProcessA);
  800130:	83 ec 0c             	sub    $0xc,%esp
  800133:	ff 75 ec             	pushl  -0x14(%ebp)
  800136:	e8 03 16 00 00       	call   80173e <sys_free_env>
  80013b:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessB);
  80013e:	83 ec 0c             	sub    $0xc,%esp
  800141:	ff 75 e8             	pushl  -0x18(%ebp)
  800144:	e8 f5 15 00 00       	call   80173e <sys_free_env>
  800149:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessC);
  80014c:	83 ec 0c             	sub    $0xc,%esp
  80014f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800152:	e8 e7 15 00 00       	call   80173e <sys_free_env>
  800157:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  80015a:	e8 50 13 00 00       	call   8014af <sys_calculate_free_frames>
  80015f:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  800162:	e8 cb 13 00 00       	call   801532 <sys_pf_calculate_allocated_pages>
  800167:	89 45 dc             	mov    %eax,-0x24(%ebp)
	cprintf("freeFrames_after= %d\n",freeFrames_after);
  80016a:	83 ec 08             	sub    $0x8,%esp
  80016d:	ff 75 e0             	pushl  -0x20(%ebp)
  800170:	68 42 1d 80 00       	push   $0x801d42
  800175:	e8 3f 04 00 00       	call   8005b9 <cprintf>
  80017a:	83 c4 10             	add    $0x10,%esp
	cprintf("freeFrames_before= %d\n",freeFrames_before);
  80017d:	83 ec 08             	sub    $0x8,%esp
  800180:	ff 75 f4             	pushl  -0xc(%ebp)
  800183:	68 58 1d 80 00       	push   $0x801d58
  800188:	e8 2c 04 00 00       	call   8005b9 <cprintf>
  80018d:	83 c4 10             	add    $0x10,%esp
	if((freeFrames_after - freeFrames_before) !=0)
  800190:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800193:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800196:	74 14                	je     8001ac <_main+0x174>
		panic("env_free() does not work correctly... check it again.") ;
  800198:	83 ec 04             	sub    $0x4,%esp
  80019b:	68 70 1d 80 00       	push   $0x801d70
  8001a0:	6a 27                	push   $0x27
  8001a2:	68 a6 1d 80 00       	push   $0x801da6
  8001a7:	e8 6b 01 00 00       	call   800317 <_panic>

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  8001ac:	83 ec 08             	sub    $0x8,%esp
  8001af:	ff 75 e0             	pushl  -0x20(%ebp)
  8001b2:	68 bc 1d 80 00       	push   $0x801dbc
  8001b7:	e8 fd 03 00 00       	call   8005b9 <cprintf>
  8001bc:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 1 for envfree completed successfully.\n");
  8001bf:	83 ec 0c             	sub    $0xc,%esp
  8001c2:	68 1c 1e 80 00       	push   $0x801e1c
  8001c7:	e8 ed 03 00 00       	call   8005b9 <cprintf>
  8001cc:	83 c4 10             	add    $0x10,%esp
	return;
  8001cf:	90                   	nop
}
  8001d0:	c9                   	leave  
  8001d1:	c3                   	ret    

008001d2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001d2:	55                   	push   %ebp
  8001d3:	89 e5                	mov    %esp,%ebp
  8001d5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001d8:	e8 07 12 00 00       	call   8013e4 <sys_getenvindex>
  8001dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001e3:	89 d0                	mov    %edx,%eax
  8001e5:	c1 e0 03             	shl    $0x3,%eax
  8001e8:	01 d0                	add    %edx,%eax
  8001ea:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001f1:	01 c8                	add    %ecx,%eax
  8001f3:	01 c0                	add    %eax,%eax
  8001f5:	01 d0                	add    %edx,%eax
  8001f7:	01 c0                	add    %eax,%eax
  8001f9:	01 d0                	add    %edx,%eax
  8001fb:	89 c2                	mov    %eax,%edx
  8001fd:	c1 e2 05             	shl    $0x5,%edx
  800200:	29 c2                	sub    %eax,%edx
  800202:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800209:	89 c2                	mov    %eax,%edx
  80020b:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800211:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800216:	a1 20 30 80 00       	mov    0x803020,%eax
  80021b:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800221:	84 c0                	test   %al,%al
  800223:	74 0f                	je     800234 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800225:	a1 20 30 80 00       	mov    0x803020,%eax
  80022a:	05 40 3c 01 00       	add    $0x13c40,%eax
  80022f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800234:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800238:	7e 0a                	jle    800244 <libmain+0x72>
		binaryname = argv[0];
  80023a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023d:	8b 00                	mov    (%eax),%eax
  80023f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800244:	83 ec 08             	sub    $0x8,%esp
  800247:	ff 75 0c             	pushl  0xc(%ebp)
  80024a:	ff 75 08             	pushl  0x8(%ebp)
  80024d:	e8 e6 fd ff ff       	call   800038 <_main>
  800252:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800255:	e8 25 13 00 00       	call   80157f <sys_disable_interrupt>
	cprintf("**************************************\n");
  80025a:	83 ec 0c             	sub    $0xc,%esp
  80025d:	68 80 1e 80 00       	push   $0x801e80
  800262:	e8 52 03 00 00       	call   8005b9 <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80026a:	a1 20 30 80 00       	mov    0x803020,%eax
  80026f:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800275:	a1 20 30 80 00       	mov    0x803020,%eax
  80027a:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800280:	83 ec 04             	sub    $0x4,%esp
  800283:	52                   	push   %edx
  800284:	50                   	push   %eax
  800285:	68 a8 1e 80 00       	push   $0x801ea8
  80028a:	e8 2a 03 00 00       	call   8005b9 <cprintf>
  80028f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800292:	a1 20 30 80 00       	mov    0x803020,%eax
  800297:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80029d:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a2:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8002a8:	83 ec 04             	sub    $0x4,%esp
  8002ab:	52                   	push   %edx
  8002ac:	50                   	push   %eax
  8002ad:	68 d0 1e 80 00       	push   $0x801ed0
  8002b2:	e8 02 03 00 00       	call   8005b9 <cprintf>
  8002b7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8002bf:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002c5:	83 ec 08             	sub    $0x8,%esp
  8002c8:	50                   	push   %eax
  8002c9:	68 11 1f 80 00       	push   $0x801f11
  8002ce:	e8 e6 02 00 00       	call   8005b9 <cprintf>
  8002d3:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002d6:	83 ec 0c             	sub    $0xc,%esp
  8002d9:	68 80 1e 80 00       	push   $0x801e80
  8002de:	e8 d6 02 00 00       	call   8005b9 <cprintf>
  8002e3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002e6:	e8 ae 12 00 00       	call   801599 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002eb:	e8 19 00 00 00       	call   800309 <exit>
}
  8002f0:	90                   	nop
  8002f1:	c9                   	leave  
  8002f2:	c3                   	ret    

008002f3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002f3:	55                   	push   %ebp
  8002f4:	89 e5                	mov    %esp,%ebp
  8002f6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002f9:	83 ec 0c             	sub    $0xc,%esp
  8002fc:	6a 00                	push   $0x0
  8002fe:	e8 ad 10 00 00       	call   8013b0 <sys_env_destroy>
  800303:	83 c4 10             	add    $0x10,%esp
}
  800306:	90                   	nop
  800307:	c9                   	leave  
  800308:	c3                   	ret    

00800309 <exit>:

void
exit(void)
{
  800309:	55                   	push   %ebp
  80030a:	89 e5                	mov    %esp,%ebp
  80030c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80030f:	e8 02 11 00 00       	call   801416 <sys_env_exit>
}
  800314:	90                   	nop
  800315:	c9                   	leave  
  800316:	c3                   	ret    

00800317 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800317:	55                   	push   %ebp
  800318:	89 e5                	mov    %esp,%ebp
  80031a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80031d:	8d 45 10             	lea    0x10(%ebp),%eax
  800320:	83 c0 04             	add    $0x4,%eax
  800323:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800326:	a1 18 31 80 00       	mov    0x803118,%eax
  80032b:	85 c0                	test   %eax,%eax
  80032d:	74 16                	je     800345 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80032f:	a1 18 31 80 00       	mov    0x803118,%eax
  800334:	83 ec 08             	sub    $0x8,%esp
  800337:	50                   	push   %eax
  800338:	68 28 1f 80 00       	push   $0x801f28
  80033d:	e8 77 02 00 00       	call   8005b9 <cprintf>
  800342:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800345:	a1 00 30 80 00       	mov    0x803000,%eax
  80034a:	ff 75 0c             	pushl  0xc(%ebp)
  80034d:	ff 75 08             	pushl  0x8(%ebp)
  800350:	50                   	push   %eax
  800351:	68 2d 1f 80 00       	push   $0x801f2d
  800356:	e8 5e 02 00 00       	call   8005b9 <cprintf>
  80035b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80035e:	8b 45 10             	mov    0x10(%ebp),%eax
  800361:	83 ec 08             	sub    $0x8,%esp
  800364:	ff 75 f4             	pushl  -0xc(%ebp)
  800367:	50                   	push   %eax
  800368:	e8 e1 01 00 00       	call   80054e <vcprintf>
  80036d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800370:	83 ec 08             	sub    $0x8,%esp
  800373:	6a 00                	push   $0x0
  800375:	68 49 1f 80 00       	push   $0x801f49
  80037a:	e8 cf 01 00 00       	call   80054e <vcprintf>
  80037f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800382:	e8 82 ff ff ff       	call   800309 <exit>

	// should not return here
	while (1) ;
  800387:	eb fe                	jmp    800387 <_panic+0x70>

00800389 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800389:	55                   	push   %ebp
  80038a:	89 e5                	mov    %esp,%ebp
  80038c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80038f:	a1 20 30 80 00       	mov    0x803020,%eax
  800394:	8b 50 74             	mov    0x74(%eax),%edx
  800397:	8b 45 0c             	mov    0xc(%ebp),%eax
  80039a:	39 c2                	cmp    %eax,%edx
  80039c:	74 14                	je     8003b2 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80039e:	83 ec 04             	sub    $0x4,%esp
  8003a1:	68 4c 1f 80 00       	push   $0x801f4c
  8003a6:	6a 26                	push   $0x26
  8003a8:	68 98 1f 80 00       	push   $0x801f98
  8003ad:	e8 65 ff ff ff       	call   800317 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003c0:	e9 b6 00 00 00       	jmp    80047b <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8003c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d2:	01 d0                	add    %edx,%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	85 c0                	test   %eax,%eax
  8003d8:	75 08                	jne    8003e2 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003da:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003dd:	e9 96 00 00 00       	jmp    800478 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003e9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003f0:	eb 5d                	jmp    80044f <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003fd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800400:	c1 e2 04             	shl    $0x4,%edx
  800403:	01 d0                	add    %edx,%eax
  800405:	8a 40 04             	mov    0x4(%eax),%al
  800408:	84 c0                	test   %al,%al
  80040a:	75 40                	jne    80044c <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80040c:	a1 20 30 80 00       	mov    0x803020,%eax
  800411:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800417:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80041a:	c1 e2 04             	shl    $0x4,%edx
  80041d:	01 d0                	add    %edx,%eax
  80041f:	8b 00                	mov    (%eax),%eax
  800421:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800424:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800427:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80042c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80042e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800431:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800438:	8b 45 08             	mov    0x8(%ebp),%eax
  80043b:	01 c8                	add    %ecx,%eax
  80043d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80043f:	39 c2                	cmp    %eax,%edx
  800441:	75 09                	jne    80044c <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800443:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80044a:	eb 12                	jmp    80045e <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80044c:	ff 45 e8             	incl   -0x18(%ebp)
  80044f:	a1 20 30 80 00       	mov    0x803020,%eax
  800454:	8b 50 74             	mov    0x74(%eax),%edx
  800457:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80045a:	39 c2                	cmp    %eax,%edx
  80045c:	77 94                	ja     8003f2 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80045e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800462:	75 14                	jne    800478 <CheckWSWithoutLastIndex+0xef>
			panic(
  800464:	83 ec 04             	sub    $0x4,%esp
  800467:	68 a4 1f 80 00       	push   $0x801fa4
  80046c:	6a 3a                	push   $0x3a
  80046e:	68 98 1f 80 00       	push   $0x801f98
  800473:	e8 9f fe ff ff       	call   800317 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800478:	ff 45 f0             	incl   -0x10(%ebp)
  80047b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80047e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800481:	0f 8c 3e ff ff ff    	jl     8003c5 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800487:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80048e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800495:	eb 20                	jmp    8004b7 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800497:	a1 20 30 80 00       	mov    0x803020,%eax
  80049c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004a2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004a5:	c1 e2 04             	shl    $0x4,%edx
  8004a8:	01 d0                	add    %edx,%eax
  8004aa:	8a 40 04             	mov    0x4(%eax),%al
  8004ad:	3c 01                	cmp    $0x1,%al
  8004af:	75 03                	jne    8004b4 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8004b1:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004b4:	ff 45 e0             	incl   -0x20(%ebp)
  8004b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8004bc:	8b 50 74             	mov    0x74(%eax),%edx
  8004bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004c2:	39 c2                	cmp    %eax,%edx
  8004c4:	77 d1                	ja     800497 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004cc:	74 14                	je     8004e2 <CheckWSWithoutLastIndex+0x159>
		panic(
  8004ce:	83 ec 04             	sub    $0x4,%esp
  8004d1:	68 f8 1f 80 00       	push   $0x801ff8
  8004d6:	6a 44                	push   $0x44
  8004d8:	68 98 1f 80 00       	push   $0x801f98
  8004dd:	e8 35 fe ff ff       	call   800317 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004e2:	90                   	nop
  8004e3:	c9                   	leave  
  8004e4:	c3                   	ret    

008004e5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004e5:	55                   	push   %ebp
  8004e6:	89 e5                	mov    %esp,%ebp
  8004e8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ee:	8b 00                	mov    (%eax),%eax
  8004f0:	8d 48 01             	lea    0x1(%eax),%ecx
  8004f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004f6:	89 0a                	mov    %ecx,(%edx)
  8004f8:	8b 55 08             	mov    0x8(%ebp),%edx
  8004fb:	88 d1                	mov    %dl,%cl
  8004fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800500:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800504:	8b 45 0c             	mov    0xc(%ebp),%eax
  800507:	8b 00                	mov    (%eax),%eax
  800509:	3d ff 00 00 00       	cmp    $0xff,%eax
  80050e:	75 2c                	jne    80053c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800510:	a0 24 30 80 00       	mov    0x803024,%al
  800515:	0f b6 c0             	movzbl %al,%eax
  800518:	8b 55 0c             	mov    0xc(%ebp),%edx
  80051b:	8b 12                	mov    (%edx),%edx
  80051d:	89 d1                	mov    %edx,%ecx
  80051f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800522:	83 c2 08             	add    $0x8,%edx
  800525:	83 ec 04             	sub    $0x4,%esp
  800528:	50                   	push   %eax
  800529:	51                   	push   %ecx
  80052a:	52                   	push   %edx
  80052b:	e8 3e 0e 00 00       	call   80136e <sys_cputs>
  800530:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800533:	8b 45 0c             	mov    0xc(%ebp),%eax
  800536:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80053c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80053f:	8b 40 04             	mov    0x4(%eax),%eax
  800542:	8d 50 01             	lea    0x1(%eax),%edx
  800545:	8b 45 0c             	mov    0xc(%ebp),%eax
  800548:	89 50 04             	mov    %edx,0x4(%eax)
}
  80054b:	90                   	nop
  80054c:	c9                   	leave  
  80054d:	c3                   	ret    

0080054e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80054e:	55                   	push   %ebp
  80054f:	89 e5                	mov    %esp,%ebp
  800551:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800557:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80055e:	00 00 00 
	b.cnt = 0;
  800561:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800568:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80056b:	ff 75 0c             	pushl  0xc(%ebp)
  80056e:	ff 75 08             	pushl  0x8(%ebp)
  800571:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800577:	50                   	push   %eax
  800578:	68 e5 04 80 00       	push   $0x8004e5
  80057d:	e8 11 02 00 00       	call   800793 <vprintfmt>
  800582:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800585:	a0 24 30 80 00       	mov    0x803024,%al
  80058a:	0f b6 c0             	movzbl %al,%eax
  80058d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800593:	83 ec 04             	sub    $0x4,%esp
  800596:	50                   	push   %eax
  800597:	52                   	push   %edx
  800598:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80059e:	83 c0 08             	add    $0x8,%eax
  8005a1:	50                   	push   %eax
  8005a2:	e8 c7 0d 00 00       	call   80136e <sys_cputs>
  8005a7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005aa:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005b1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005b7:	c9                   	leave  
  8005b8:	c3                   	ret    

008005b9 <cprintf>:

int cprintf(const char *fmt, ...) {
  8005b9:	55                   	push   %ebp
  8005ba:	89 e5                	mov    %esp,%ebp
  8005bc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005bf:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005c6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cf:	83 ec 08             	sub    $0x8,%esp
  8005d2:	ff 75 f4             	pushl  -0xc(%ebp)
  8005d5:	50                   	push   %eax
  8005d6:	e8 73 ff ff ff       	call   80054e <vcprintf>
  8005db:	83 c4 10             	add    $0x10,%esp
  8005de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005e4:	c9                   	leave  
  8005e5:	c3                   	ret    

008005e6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005e6:	55                   	push   %ebp
  8005e7:	89 e5                	mov    %esp,%ebp
  8005e9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005ec:	e8 8e 0f 00 00       	call   80157f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005f1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fa:	83 ec 08             	sub    $0x8,%esp
  8005fd:	ff 75 f4             	pushl  -0xc(%ebp)
  800600:	50                   	push   %eax
  800601:	e8 48 ff ff ff       	call   80054e <vcprintf>
  800606:	83 c4 10             	add    $0x10,%esp
  800609:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80060c:	e8 88 0f 00 00       	call   801599 <sys_enable_interrupt>
	return cnt;
  800611:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800614:	c9                   	leave  
  800615:	c3                   	ret    

00800616 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800616:	55                   	push   %ebp
  800617:	89 e5                	mov    %esp,%ebp
  800619:	53                   	push   %ebx
  80061a:	83 ec 14             	sub    $0x14,%esp
  80061d:	8b 45 10             	mov    0x10(%ebp),%eax
  800620:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800623:	8b 45 14             	mov    0x14(%ebp),%eax
  800626:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800629:	8b 45 18             	mov    0x18(%ebp),%eax
  80062c:	ba 00 00 00 00       	mov    $0x0,%edx
  800631:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800634:	77 55                	ja     80068b <printnum+0x75>
  800636:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800639:	72 05                	jb     800640 <printnum+0x2a>
  80063b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80063e:	77 4b                	ja     80068b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800640:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800643:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800646:	8b 45 18             	mov    0x18(%ebp),%eax
  800649:	ba 00 00 00 00       	mov    $0x0,%edx
  80064e:	52                   	push   %edx
  80064f:	50                   	push   %eax
  800650:	ff 75 f4             	pushl  -0xc(%ebp)
  800653:	ff 75 f0             	pushl  -0x10(%ebp)
  800656:	e8 f9 13 00 00       	call   801a54 <__udivdi3>
  80065b:	83 c4 10             	add    $0x10,%esp
  80065e:	83 ec 04             	sub    $0x4,%esp
  800661:	ff 75 20             	pushl  0x20(%ebp)
  800664:	53                   	push   %ebx
  800665:	ff 75 18             	pushl  0x18(%ebp)
  800668:	52                   	push   %edx
  800669:	50                   	push   %eax
  80066a:	ff 75 0c             	pushl  0xc(%ebp)
  80066d:	ff 75 08             	pushl  0x8(%ebp)
  800670:	e8 a1 ff ff ff       	call   800616 <printnum>
  800675:	83 c4 20             	add    $0x20,%esp
  800678:	eb 1a                	jmp    800694 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80067a:	83 ec 08             	sub    $0x8,%esp
  80067d:	ff 75 0c             	pushl  0xc(%ebp)
  800680:	ff 75 20             	pushl  0x20(%ebp)
  800683:	8b 45 08             	mov    0x8(%ebp),%eax
  800686:	ff d0                	call   *%eax
  800688:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80068b:	ff 4d 1c             	decl   0x1c(%ebp)
  80068e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800692:	7f e6                	jg     80067a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800694:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800697:	bb 00 00 00 00       	mov    $0x0,%ebx
  80069c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80069f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006a2:	53                   	push   %ebx
  8006a3:	51                   	push   %ecx
  8006a4:	52                   	push   %edx
  8006a5:	50                   	push   %eax
  8006a6:	e8 b9 14 00 00       	call   801b64 <__umoddi3>
  8006ab:	83 c4 10             	add    $0x10,%esp
  8006ae:	05 74 22 80 00       	add    $0x802274,%eax
  8006b3:	8a 00                	mov    (%eax),%al
  8006b5:	0f be c0             	movsbl %al,%eax
  8006b8:	83 ec 08             	sub    $0x8,%esp
  8006bb:	ff 75 0c             	pushl  0xc(%ebp)
  8006be:	50                   	push   %eax
  8006bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c2:	ff d0                	call   *%eax
  8006c4:	83 c4 10             	add    $0x10,%esp
}
  8006c7:	90                   	nop
  8006c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006cb:	c9                   	leave  
  8006cc:	c3                   	ret    

008006cd <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006cd:	55                   	push   %ebp
  8006ce:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006d0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006d4:	7e 1c                	jle    8006f2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d9:	8b 00                	mov    (%eax),%eax
  8006db:	8d 50 08             	lea    0x8(%eax),%edx
  8006de:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e1:	89 10                	mov    %edx,(%eax)
  8006e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e6:	8b 00                	mov    (%eax),%eax
  8006e8:	83 e8 08             	sub    $0x8,%eax
  8006eb:	8b 50 04             	mov    0x4(%eax),%edx
  8006ee:	8b 00                	mov    (%eax),%eax
  8006f0:	eb 40                	jmp    800732 <getuint+0x65>
	else if (lflag)
  8006f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006f6:	74 1e                	je     800716 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fb:	8b 00                	mov    (%eax),%eax
  8006fd:	8d 50 04             	lea    0x4(%eax),%edx
  800700:	8b 45 08             	mov    0x8(%ebp),%eax
  800703:	89 10                	mov    %edx,(%eax)
  800705:	8b 45 08             	mov    0x8(%ebp),%eax
  800708:	8b 00                	mov    (%eax),%eax
  80070a:	83 e8 04             	sub    $0x4,%eax
  80070d:	8b 00                	mov    (%eax),%eax
  80070f:	ba 00 00 00 00       	mov    $0x0,%edx
  800714:	eb 1c                	jmp    800732 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800716:	8b 45 08             	mov    0x8(%ebp),%eax
  800719:	8b 00                	mov    (%eax),%eax
  80071b:	8d 50 04             	lea    0x4(%eax),%edx
  80071e:	8b 45 08             	mov    0x8(%ebp),%eax
  800721:	89 10                	mov    %edx,(%eax)
  800723:	8b 45 08             	mov    0x8(%ebp),%eax
  800726:	8b 00                	mov    (%eax),%eax
  800728:	83 e8 04             	sub    $0x4,%eax
  80072b:	8b 00                	mov    (%eax),%eax
  80072d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800732:	5d                   	pop    %ebp
  800733:	c3                   	ret    

00800734 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800734:	55                   	push   %ebp
  800735:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800737:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80073b:	7e 1c                	jle    800759 <getint+0x25>
		return va_arg(*ap, long long);
  80073d:	8b 45 08             	mov    0x8(%ebp),%eax
  800740:	8b 00                	mov    (%eax),%eax
  800742:	8d 50 08             	lea    0x8(%eax),%edx
  800745:	8b 45 08             	mov    0x8(%ebp),%eax
  800748:	89 10                	mov    %edx,(%eax)
  80074a:	8b 45 08             	mov    0x8(%ebp),%eax
  80074d:	8b 00                	mov    (%eax),%eax
  80074f:	83 e8 08             	sub    $0x8,%eax
  800752:	8b 50 04             	mov    0x4(%eax),%edx
  800755:	8b 00                	mov    (%eax),%eax
  800757:	eb 38                	jmp    800791 <getint+0x5d>
	else if (lflag)
  800759:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80075d:	74 1a                	je     800779 <getint+0x45>
		return va_arg(*ap, long);
  80075f:	8b 45 08             	mov    0x8(%ebp),%eax
  800762:	8b 00                	mov    (%eax),%eax
  800764:	8d 50 04             	lea    0x4(%eax),%edx
  800767:	8b 45 08             	mov    0x8(%ebp),%eax
  80076a:	89 10                	mov    %edx,(%eax)
  80076c:	8b 45 08             	mov    0x8(%ebp),%eax
  80076f:	8b 00                	mov    (%eax),%eax
  800771:	83 e8 04             	sub    $0x4,%eax
  800774:	8b 00                	mov    (%eax),%eax
  800776:	99                   	cltd   
  800777:	eb 18                	jmp    800791 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800779:	8b 45 08             	mov    0x8(%ebp),%eax
  80077c:	8b 00                	mov    (%eax),%eax
  80077e:	8d 50 04             	lea    0x4(%eax),%edx
  800781:	8b 45 08             	mov    0x8(%ebp),%eax
  800784:	89 10                	mov    %edx,(%eax)
  800786:	8b 45 08             	mov    0x8(%ebp),%eax
  800789:	8b 00                	mov    (%eax),%eax
  80078b:	83 e8 04             	sub    $0x4,%eax
  80078e:	8b 00                	mov    (%eax),%eax
  800790:	99                   	cltd   
}
  800791:	5d                   	pop    %ebp
  800792:	c3                   	ret    

00800793 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800793:	55                   	push   %ebp
  800794:	89 e5                	mov    %esp,%ebp
  800796:	56                   	push   %esi
  800797:	53                   	push   %ebx
  800798:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80079b:	eb 17                	jmp    8007b4 <vprintfmt+0x21>
			if (ch == '\0')
  80079d:	85 db                	test   %ebx,%ebx
  80079f:	0f 84 af 03 00 00    	je     800b54 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007a5:	83 ec 08             	sub    $0x8,%esp
  8007a8:	ff 75 0c             	pushl  0xc(%ebp)
  8007ab:	53                   	push   %ebx
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	ff d0                	call   *%eax
  8007b1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b7:	8d 50 01             	lea    0x1(%eax),%edx
  8007ba:	89 55 10             	mov    %edx,0x10(%ebp)
  8007bd:	8a 00                	mov    (%eax),%al
  8007bf:	0f b6 d8             	movzbl %al,%ebx
  8007c2:	83 fb 25             	cmp    $0x25,%ebx
  8007c5:	75 d6                	jne    80079d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007c7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007cb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007d2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007d9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007e0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ea:	8d 50 01             	lea    0x1(%eax),%edx
  8007ed:	89 55 10             	mov    %edx,0x10(%ebp)
  8007f0:	8a 00                	mov    (%eax),%al
  8007f2:	0f b6 d8             	movzbl %al,%ebx
  8007f5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007f8:	83 f8 55             	cmp    $0x55,%eax
  8007fb:	0f 87 2b 03 00 00    	ja     800b2c <vprintfmt+0x399>
  800801:	8b 04 85 98 22 80 00 	mov    0x802298(,%eax,4),%eax
  800808:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80080a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80080e:	eb d7                	jmp    8007e7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800810:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800814:	eb d1                	jmp    8007e7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800816:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80081d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800820:	89 d0                	mov    %edx,%eax
  800822:	c1 e0 02             	shl    $0x2,%eax
  800825:	01 d0                	add    %edx,%eax
  800827:	01 c0                	add    %eax,%eax
  800829:	01 d8                	add    %ebx,%eax
  80082b:	83 e8 30             	sub    $0x30,%eax
  80082e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800831:	8b 45 10             	mov    0x10(%ebp),%eax
  800834:	8a 00                	mov    (%eax),%al
  800836:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800839:	83 fb 2f             	cmp    $0x2f,%ebx
  80083c:	7e 3e                	jle    80087c <vprintfmt+0xe9>
  80083e:	83 fb 39             	cmp    $0x39,%ebx
  800841:	7f 39                	jg     80087c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800843:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800846:	eb d5                	jmp    80081d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800848:	8b 45 14             	mov    0x14(%ebp),%eax
  80084b:	83 c0 04             	add    $0x4,%eax
  80084e:	89 45 14             	mov    %eax,0x14(%ebp)
  800851:	8b 45 14             	mov    0x14(%ebp),%eax
  800854:	83 e8 04             	sub    $0x4,%eax
  800857:	8b 00                	mov    (%eax),%eax
  800859:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80085c:	eb 1f                	jmp    80087d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80085e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800862:	79 83                	jns    8007e7 <vprintfmt+0x54>
				width = 0;
  800864:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80086b:	e9 77 ff ff ff       	jmp    8007e7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800870:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800877:	e9 6b ff ff ff       	jmp    8007e7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80087c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80087d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800881:	0f 89 60 ff ff ff    	jns    8007e7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800887:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80088a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80088d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800894:	e9 4e ff ff ff       	jmp    8007e7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800899:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80089c:	e9 46 ff ff ff       	jmp    8007e7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a4:	83 c0 04             	add    $0x4,%eax
  8008a7:	89 45 14             	mov    %eax,0x14(%ebp)
  8008aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ad:	83 e8 04             	sub    $0x4,%eax
  8008b0:	8b 00                	mov    (%eax),%eax
  8008b2:	83 ec 08             	sub    $0x8,%esp
  8008b5:	ff 75 0c             	pushl  0xc(%ebp)
  8008b8:	50                   	push   %eax
  8008b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bc:	ff d0                	call   *%eax
  8008be:	83 c4 10             	add    $0x10,%esp
			break;
  8008c1:	e9 89 02 00 00       	jmp    800b4f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c9:	83 c0 04             	add    $0x4,%eax
  8008cc:	89 45 14             	mov    %eax,0x14(%ebp)
  8008cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d2:	83 e8 04             	sub    $0x4,%eax
  8008d5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008d7:	85 db                	test   %ebx,%ebx
  8008d9:	79 02                	jns    8008dd <vprintfmt+0x14a>
				err = -err;
  8008db:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008dd:	83 fb 64             	cmp    $0x64,%ebx
  8008e0:	7f 0b                	jg     8008ed <vprintfmt+0x15a>
  8008e2:	8b 34 9d e0 20 80 00 	mov    0x8020e0(,%ebx,4),%esi
  8008e9:	85 f6                	test   %esi,%esi
  8008eb:	75 19                	jne    800906 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008ed:	53                   	push   %ebx
  8008ee:	68 85 22 80 00       	push   $0x802285
  8008f3:	ff 75 0c             	pushl  0xc(%ebp)
  8008f6:	ff 75 08             	pushl  0x8(%ebp)
  8008f9:	e8 5e 02 00 00       	call   800b5c <printfmt>
  8008fe:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800901:	e9 49 02 00 00       	jmp    800b4f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800906:	56                   	push   %esi
  800907:	68 8e 22 80 00       	push   $0x80228e
  80090c:	ff 75 0c             	pushl  0xc(%ebp)
  80090f:	ff 75 08             	pushl  0x8(%ebp)
  800912:	e8 45 02 00 00       	call   800b5c <printfmt>
  800917:	83 c4 10             	add    $0x10,%esp
			break;
  80091a:	e9 30 02 00 00       	jmp    800b4f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80091f:	8b 45 14             	mov    0x14(%ebp),%eax
  800922:	83 c0 04             	add    $0x4,%eax
  800925:	89 45 14             	mov    %eax,0x14(%ebp)
  800928:	8b 45 14             	mov    0x14(%ebp),%eax
  80092b:	83 e8 04             	sub    $0x4,%eax
  80092e:	8b 30                	mov    (%eax),%esi
  800930:	85 f6                	test   %esi,%esi
  800932:	75 05                	jne    800939 <vprintfmt+0x1a6>
				p = "(null)";
  800934:	be 91 22 80 00       	mov    $0x802291,%esi
			if (width > 0 && padc != '-')
  800939:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80093d:	7e 6d                	jle    8009ac <vprintfmt+0x219>
  80093f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800943:	74 67                	je     8009ac <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800945:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800948:	83 ec 08             	sub    $0x8,%esp
  80094b:	50                   	push   %eax
  80094c:	56                   	push   %esi
  80094d:	e8 0c 03 00 00       	call   800c5e <strnlen>
  800952:	83 c4 10             	add    $0x10,%esp
  800955:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800958:	eb 16                	jmp    800970 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80095a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80095e:	83 ec 08             	sub    $0x8,%esp
  800961:	ff 75 0c             	pushl  0xc(%ebp)
  800964:	50                   	push   %eax
  800965:	8b 45 08             	mov    0x8(%ebp),%eax
  800968:	ff d0                	call   *%eax
  80096a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80096d:	ff 4d e4             	decl   -0x1c(%ebp)
  800970:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800974:	7f e4                	jg     80095a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800976:	eb 34                	jmp    8009ac <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800978:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80097c:	74 1c                	je     80099a <vprintfmt+0x207>
  80097e:	83 fb 1f             	cmp    $0x1f,%ebx
  800981:	7e 05                	jle    800988 <vprintfmt+0x1f5>
  800983:	83 fb 7e             	cmp    $0x7e,%ebx
  800986:	7e 12                	jle    80099a <vprintfmt+0x207>
					putch('?', putdat);
  800988:	83 ec 08             	sub    $0x8,%esp
  80098b:	ff 75 0c             	pushl  0xc(%ebp)
  80098e:	6a 3f                	push   $0x3f
  800990:	8b 45 08             	mov    0x8(%ebp),%eax
  800993:	ff d0                	call   *%eax
  800995:	83 c4 10             	add    $0x10,%esp
  800998:	eb 0f                	jmp    8009a9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80099a:	83 ec 08             	sub    $0x8,%esp
  80099d:	ff 75 0c             	pushl  0xc(%ebp)
  8009a0:	53                   	push   %ebx
  8009a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a4:	ff d0                	call   *%eax
  8009a6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009a9:	ff 4d e4             	decl   -0x1c(%ebp)
  8009ac:	89 f0                	mov    %esi,%eax
  8009ae:	8d 70 01             	lea    0x1(%eax),%esi
  8009b1:	8a 00                	mov    (%eax),%al
  8009b3:	0f be d8             	movsbl %al,%ebx
  8009b6:	85 db                	test   %ebx,%ebx
  8009b8:	74 24                	je     8009de <vprintfmt+0x24b>
  8009ba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009be:	78 b8                	js     800978 <vprintfmt+0x1e5>
  8009c0:	ff 4d e0             	decl   -0x20(%ebp)
  8009c3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009c7:	79 af                	jns    800978 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009c9:	eb 13                	jmp    8009de <vprintfmt+0x24b>
				putch(' ', putdat);
  8009cb:	83 ec 08             	sub    $0x8,%esp
  8009ce:	ff 75 0c             	pushl  0xc(%ebp)
  8009d1:	6a 20                	push   $0x20
  8009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d6:	ff d0                	call   *%eax
  8009d8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009db:	ff 4d e4             	decl   -0x1c(%ebp)
  8009de:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e2:	7f e7                	jg     8009cb <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009e4:	e9 66 01 00 00       	jmp    800b4f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009e9:	83 ec 08             	sub    $0x8,%esp
  8009ec:	ff 75 e8             	pushl  -0x18(%ebp)
  8009ef:	8d 45 14             	lea    0x14(%ebp),%eax
  8009f2:	50                   	push   %eax
  8009f3:	e8 3c fd ff ff       	call   800734 <getint>
  8009f8:	83 c4 10             	add    $0x10,%esp
  8009fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009fe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a01:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a04:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a07:	85 d2                	test   %edx,%edx
  800a09:	79 23                	jns    800a2e <vprintfmt+0x29b>
				putch('-', putdat);
  800a0b:	83 ec 08             	sub    $0x8,%esp
  800a0e:	ff 75 0c             	pushl  0xc(%ebp)
  800a11:	6a 2d                	push   $0x2d
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	ff d0                	call   *%eax
  800a18:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a1e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a21:	f7 d8                	neg    %eax
  800a23:	83 d2 00             	adc    $0x0,%edx
  800a26:	f7 da                	neg    %edx
  800a28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a2b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a2e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a35:	e9 bc 00 00 00       	jmp    800af6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a3a:	83 ec 08             	sub    $0x8,%esp
  800a3d:	ff 75 e8             	pushl  -0x18(%ebp)
  800a40:	8d 45 14             	lea    0x14(%ebp),%eax
  800a43:	50                   	push   %eax
  800a44:	e8 84 fc ff ff       	call   8006cd <getuint>
  800a49:	83 c4 10             	add    $0x10,%esp
  800a4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a4f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a52:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a59:	e9 98 00 00 00       	jmp    800af6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a5e:	83 ec 08             	sub    $0x8,%esp
  800a61:	ff 75 0c             	pushl  0xc(%ebp)
  800a64:	6a 58                	push   $0x58
  800a66:	8b 45 08             	mov    0x8(%ebp),%eax
  800a69:	ff d0                	call   *%eax
  800a6b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a6e:	83 ec 08             	sub    $0x8,%esp
  800a71:	ff 75 0c             	pushl  0xc(%ebp)
  800a74:	6a 58                	push   $0x58
  800a76:	8b 45 08             	mov    0x8(%ebp),%eax
  800a79:	ff d0                	call   *%eax
  800a7b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a7e:	83 ec 08             	sub    $0x8,%esp
  800a81:	ff 75 0c             	pushl  0xc(%ebp)
  800a84:	6a 58                	push   $0x58
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	ff d0                	call   *%eax
  800a8b:	83 c4 10             	add    $0x10,%esp
			break;
  800a8e:	e9 bc 00 00 00       	jmp    800b4f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a93:	83 ec 08             	sub    $0x8,%esp
  800a96:	ff 75 0c             	pushl  0xc(%ebp)
  800a99:	6a 30                	push   $0x30
  800a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9e:	ff d0                	call   *%eax
  800aa0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800aa3:	83 ec 08             	sub    $0x8,%esp
  800aa6:	ff 75 0c             	pushl  0xc(%ebp)
  800aa9:	6a 78                	push   $0x78
  800aab:	8b 45 08             	mov    0x8(%ebp),%eax
  800aae:	ff d0                	call   *%eax
  800ab0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ab3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab6:	83 c0 04             	add    $0x4,%eax
  800ab9:	89 45 14             	mov    %eax,0x14(%ebp)
  800abc:	8b 45 14             	mov    0x14(%ebp),%eax
  800abf:	83 e8 04             	sub    $0x4,%eax
  800ac2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ac4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ace:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ad5:	eb 1f                	jmp    800af6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ad7:	83 ec 08             	sub    $0x8,%esp
  800ada:	ff 75 e8             	pushl  -0x18(%ebp)
  800add:	8d 45 14             	lea    0x14(%ebp),%eax
  800ae0:	50                   	push   %eax
  800ae1:	e8 e7 fb ff ff       	call   8006cd <getuint>
  800ae6:	83 c4 10             	add    $0x10,%esp
  800ae9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aec:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800aef:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800af6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800afa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800afd:	83 ec 04             	sub    $0x4,%esp
  800b00:	52                   	push   %edx
  800b01:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b04:	50                   	push   %eax
  800b05:	ff 75 f4             	pushl  -0xc(%ebp)
  800b08:	ff 75 f0             	pushl  -0x10(%ebp)
  800b0b:	ff 75 0c             	pushl  0xc(%ebp)
  800b0e:	ff 75 08             	pushl  0x8(%ebp)
  800b11:	e8 00 fb ff ff       	call   800616 <printnum>
  800b16:	83 c4 20             	add    $0x20,%esp
			break;
  800b19:	eb 34                	jmp    800b4f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b1b:	83 ec 08             	sub    $0x8,%esp
  800b1e:	ff 75 0c             	pushl  0xc(%ebp)
  800b21:	53                   	push   %ebx
  800b22:	8b 45 08             	mov    0x8(%ebp),%eax
  800b25:	ff d0                	call   *%eax
  800b27:	83 c4 10             	add    $0x10,%esp
			break;
  800b2a:	eb 23                	jmp    800b4f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b2c:	83 ec 08             	sub    $0x8,%esp
  800b2f:	ff 75 0c             	pushl  0xc(%ebp)
  800b32:	6a 25                	push   $0x25
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	ff d0                	call   *%eax
  800b39:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b3c:	ff 4d 10             	decl   0x10(%ebp)
  800b3f:	eb 03                	jmp    800b44 <vprintfmt+0x3b1>
  800b41:	ff 4d 10             	decl   0x10(%ebp)
  800b44:	8b 45 10             	mov    0x10(%ebp),%eax
  800b47:	48                   	dec    %eax
  800b48:	8a 00                	mov    (%eax),%al
  800b4a:	3c 25                	cmp    $0x25,%al
  800b4c:	75 f3                	jne    800b41 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b4e:	90                   	nop
		}
	}
  800b4f:	e9 47 fc ff ff       	jmp    80079b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b54:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b55:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b58:	5b                   	pop    %ebx
  800b59:	5e                   	pop    %esi
  800b5a:	5d                   	pop    %ebp
  800b5b:	c3                   	ret    

00800b5c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b5c:	55                   	push   %ebp
  800b5d:	89 e5                	mov    %esp,%ebp
  800b5f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b62:	8d 45 10             	lea    0x10(%ebp),%eax
  800b65:	83 c0 04             	add    $0x4,%eax
  800b68:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6e:	ff 75 f4             	pushl  -0xc(%ebp)
  800b71:	50                   	push   %eax
  800b72:	ff 75 0c             	pushl  0xc(%ebp)
  800b75:	ff 75 08             	pushl  0x8(%ebp)
  800b78:	e8 16 fc ff ff       	call   800793 <vprintfmt>
  800b7d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b80:	90                   	nop
  800b81:	c9                   	leave  
  800b82:	c3                   	ret    

00800b83 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b83:	55                   	push   %ebp
  800b84:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b89:	8b 40 08             	mov    0x8(%eax),%eax
  800b8c:	8d 50 01             	lea    0x1(%eax),%edx
  800b8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b92:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b98:	8b 10                	mov    (%eax),%edx
  800b9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9d:	8b 40 04             	mov    0x4(%eax),%eax
  800ba0:	39 c2                	cmp    %eax,%edx
  800ba2:	73 12                	jae    800bb6 <sprintputch+0x33>
		*b->buf++ = ch;
  800ba4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba7:	8b 00                	mov    (%eax),%eax
  800ba9:	8d 48 01             	lea    0x1(%eax),%ecx
  800bac:	8b 55 0c             	mov    0xc(%ebp),%edx
  800baf:	89 0a                	mov    %ecx,(%edx)
  800bb1:	8b 55 08             	mov    0x8(%ebp),%edx
  800bb4:	88 10                	mov    %dl,(%eax)
}
  800bb6:	90                   	nop
  800bb7:	5d                   	pop    %ebp
  800bb8:	c3                   	ret    

00800bb9 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bb9:	55                   	push   %ebp
  800bba:	89 e5                	mov    %esp,%ebp
  800bbc:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800bc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	01 d0                	add    %edx,%eax
  800bd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bda:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bde:	74 06                	je     800be6 <vsnprintf+0x2d>
  800be0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800be4:	7f 07                	jg     800bed <vsnprintf+0x34>
		return -E_INVAL;
  800be6:	b8 03 00 00 00       	mov    $0x3,%eax
  800beb:	eb 20                	jmp    800c0d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bed:	ff 75 14             	pushl  0x14(%ebp)
  800bf0:	ff 75 10             	pushl  0x10(%ebp)
  800bf3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bf6:	50                   	push   %eax
  800bf7:	68 83 0b 80 00       	push   $0x800b83
  800bfc:	e8 92 fb ff ff       	call   800793 <vprintfmt>
  800c01:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c04:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c07:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c0d:	c9                   	leave  
  800c0e:	c3                   	ret    

00800c0f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c0f:	55                   	push   %ebp
  800c10:	89 e5                	mov    %esp,%ebp
  800c12:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c15:	8d 45 10             	lea    0x10(%ebp),%eax
  800c18:	83 c0 04             	add    $0x4,%eax
  800c1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c21:	ff 75 f4             	pushl  -0xc(%ebp)
  800c24:	50                   	push   %eax
  800c25:	ff 75 0c             	pushl  0xc(%ebp)
  800c28:	ff 75 08             	pushl  0x8(%ebp)
  800c2b:	e8 89 ff ff ff       	call   800bb9 <vsnprintf>
  800c30:	83 c4 10             	add    $0x10,%esp
  800c33:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c36:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c39:	c9                   	leave  
  800c3a:	c3                   	ret    

00800c3b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c3b:	55                   	push   %ebp
  800c3c:	89 e5                	mov    %esp,%ebp
  800c3e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c41:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c48:	eb 06                	jmp    800c50 <strlen+0x15>
		n++;
  800c4a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c4d:	ff 45 08             	incl   0x8(%ebp)
  800c50:	8b 45 08             	mov    0x8(%ebp),%eax
  800c53:	8a 00                	mov    (%eax),%al
  800c55:	84 c0                	test   %al,%al
  800c57:	75 f1                	jne    800c4a <strlen+0xf>
		n++;
	return n;
  800c59:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c5c:	c9                   	leave  
  800c5d:	c3                   	ret    

00800c5e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c5e:	55                   	push   %ebp
  800c5f:	89 e5                	mov    %esp,%ebp
  800c61:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c6b:	eb 09                	jmp    800c76 <strnlen+0x18>
		n++;
  800c6d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c70:	ff 45 08             	incl   0x8(%ebp)
  800c73:	ff 4d 0c             	decl   0xc(%ebp)
  800c76:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c7a:	74 09                	je     800c85 <strnlen+0x27>
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	8a 00                	mov    (%eax),%al
  800c81:	84 c0                	test   %al,%al
  800c83:	75 e8                	jne    800c6d <strnlen+0xf>
		n++;
	return n;
  800c85:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c88:	c9                   	leave  
  800c89:	c3                   	ret    

00800c8a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c8a:	55                   	push   %ebp
  800c8b:	89 e5                	mov    %esp,%ebp
  800c8d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c96:	90                   	nop
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	8d 50 01             	lea    0x1(%eax),%edx
  800c9d:	89 55 08             	mov    %edx,0x8(%ebp)
  800ca0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ca3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ca6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ca9:	8a 12                	mov    (%edx),%dl
  800cab:	88 10                	mov    %dl,(%eax)
  800cad:	8a 00                	mov    (%eax),%al
  800caf:	84 c0                	test   %al,%al
  800cb1:	75 e4                	jne    800c97 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cb6:	c9                   	leave  
  800cb7:	c3                   	ret    

00800cb8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cb8:	55                   	push   %ebp
  800cb9:	89 e5                	mov    %esp,%ebp
  800cbb:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cc4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ccb:	eb 1f                	jmp    800cec <strncpy+0x34>
		*dst++ = *src;
  800ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd0:	8d 50 01             	lea    0x1(%eax),%edx
  800cd3:	89 55 08             	mov    %edx,0x8(%ebp)
  800cd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cd9:	8a 12                	mov    (%edx),%dl
  800cdb:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce0:	8a 00                	mov    (%eax),%al
  800ce2:	84 c0                	test   %al,%al
  800ce4:	74 03                	je     800ce9 <strncpy+0x31>
			src++;
  800ce6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ce9:	ff 45 fc             	incl   -0x4(%ebp)
  800cec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cef:	3b 45 10             	cmp    0x10(%ebp),%eax
  800cf2:	72 d9                	jb     800ccd <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800cf4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cf7:	c9                   	leave  
  800cf8:	c3                   	ret    

00800cf9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800cf9:	55                   	push   %ebp
  800cfa:	89 e5                	mov    %esp,%ebp
  800cfc:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d05:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d09:	74 30                	je     800d3b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d0b:	eb 16                	jmp    800d23 <strlcpy+0x2a>
			*dst++ = *src++;
  800d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d10:	8d 50 01             	lea    0x1(%eax),%edx
  800d13:	89 55 08             	mov    %edx,0x8(%ebp)
  800d16:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d19:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d1c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d1f:	8a 12                	mov    (%edx),%dl
  800d21:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d23:	ff 4d 10             	decl   0x10(%ebp)
  800d26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d2a:	74 09                	je     800d35 <strlcpy+0x3c>
  800d2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2f:	8a 00                	mov    (%eax),%al
  800d31:	84 c0                	test   %al,%al
  800d33:	75 d8                	jne    800d0d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d3b:	8b 55 08             	mov    0x8(%ebp),%edx
  800d3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d41:	29 c2                	sub    %eax,%edx
  800d43:	89 d0                	mov    %edx,%eax
}
  800d45:	c9                   	leave  
  800d46:	c3                   	ret    

00800d47 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d47:	55                   	push   %ebp
  800d48:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d4a:	eb 06                	jmp    800d52 <strcmp+0xb>
		p++, q++;
  800d4c:	ff 45 08             	incl   0x8(%ebp)
  800d4f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8a 00                	mov    (%eax),%al
  800d57:	84 c0                	test   %al,%al
  800d59:	74 0e                	je     800d69 <strcmp+0x22>
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	8a 10                	mov    (%eax),%dl
  800d60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d63:	8a 00                	mov    (%eax),%al
  800d65:	38 c2                	cmp    %al,%dl
  800d67:	74 e3                	je     800d4c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	8a 00                	mov    (%eax),%al
  800d6e:	0f b6 d0             	movzbl %al,%edx
  800d71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d74:	8a 00                	mov    (%eax),%al
  800d76:	0f b6 c0             	movzbl %al,%eax
  800d79:	29 c2                	sub    %eax,%edx
  800d7b:	89 d0                	mov    %edx,%eax
}
  800d7d:	5d                   	pop    %ebp
  800d7e:	c3                   	ret    

00800d7f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d7f:	55                   	push   %ebp
  800d80:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d82:	eb 09                	jmp    800d8d <strncmp+0xe>
		n--, p++, q++;
  800d84:	ff 4d 10             	decl   0x10(%ebp)
  800d87:	ff 45 08             	incl   0x8(%ebp)
  800d8a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d8d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d91:	74 17                	je     800daa <strncmp+0x2b>
  800d93:	8b 45 08             	mov    0x8(%ebp),%eax
  800d96:	8a 00                	mov    (%eax),%al
  800d98:	84 c0                	test   %al,%al
  800d9a:	74 0e                	je     800daa <strncmp+0x2b>
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	8a 10                	mov    (%eax),%dl
  800da1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da4:	8a 00                	mov    (%eax),%al
  800da6:	38 c2                	cmp    %al,%dl
  800da8:	74 da                	je     800d84 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800daa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dae:	75 07                	jne    800db7 <strncmp+0x38>
		return 0;
  800db0:	b8 00 00 00 00       	mov    $0x0,%eax
  800db5:	eb 14                	jmp    800dcb <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800db7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dba:	8a 00                	mov    (%eax),%al
  800dbc:	0f b6 d0             	movzbl %al,%edx
  800dbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc2:	8a 00                	mov    (%eax),%al
  800dc4:	0f b6 c0             	movzbl %al,%eax
  800dc7:	29 c2                	sub    %eax,%edx
  800dc9:	89 d0                	mov    %edx,%eax
}
  800dcb:	5d                   	pop    %ebp
  800dcc:	c3                   	ret    

00800dcd <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800dcd:	55                   	push   %ebp
  800dce:	89 e5                	mov    %esp,%ebp
  800dd0:	83 ec 04             	sub    $0x4,%esp
  800dd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dd9:	eb 12                	jmp    800ded <strchr+0x20>
		if (*s == c)
  800ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dde:	8a 00                	mov    (%eax),%al
  800de0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800de3:	75 05                	jne    800dea <strchr+0x1d>
			return (char *) s;
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	eb 11                	jmp    800dfb <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dea:	ff 45 08             	incl   0x8(%ebp)
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	8a 00                	mov    (%eax),%al
  800df2:	84 c0                	test   %al,%al
  800df4:	75 e5                	jne    800ddb <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800df6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800dfb:	c9                   	leave  
  800dfc:	c3                   	ret    

00800dfd <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800dfd:	55                   	push   %ebp
  800dfe:	89 e5                	mov    %esp,%ebp
  800e00:	83 ec 04             	sub    $0x4,%esp
  800e03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e06:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e09:	eb 0d                	jmp    800e18 <strfind+0x1b>
		if (*s == c)
  800e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0e:	8a 00                	mov    (%eax),%al
  800e10:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e13:	74 0e                	je     800e23 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e15:	ff 45 08             	incl   0x8(%ebp)
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	8a 00                	mov    (%eax),%al
  800e1d:	84 c0                	test   %al,%al
  800e1f:	75 ea                	jne    800e0b <strfind+0xe>
  800e21:	eb 01                	jmp    800e24 <strfind+0x27>
		if (*s == c)
			break;
  800e23:	90                   	nop
	return (char *) s;
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e27:	c9                   	leave  
  800e28:	c3                   	ret    

00800e29 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e29:	55                   	push   %ebp
  800e2a:	89 e5                	mov    %esp,%ebp
  800e2c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e32:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e35:	8b 45 10             	mov    0x10(%ebp),%eax
  800e38:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e3b:	eb 0e                	jmp    800e4b <memset+0x22>
		*p++ = c;
  800e3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e40:	8d 50 01             	lea    0x1(%eax),%edx
  800e43:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e46:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e49:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e4b:	ff 4d f8             	decl   -0x8(%ebp)
  800e4e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e52:	79 e9                	jns    800e3d <memset+0x14>
		*p++ = c;

	return v;
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e57:	c9                   	leave  
  800e58:	c3                   	ret    

00800e59 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e59:	55                   	push   %ebp
  800e5a:	89 e5                	mov    %esp,%ebp
  800e5c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e62:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e6b:	eb 16                	jmp    800e83 <memcpy+0x2a>
		*d++ = *s++;
  800e6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e70:	8d 50 01             	lea    0x1(%eax),%edx
  800e73:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e76:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e79:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e7c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e7f:	8a 12                	mov    (%edx),%dl
  800e81:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e83:	8b 45 10             	mov    0x10(%ebp),%eax
  800e86:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e89:	89 55 10             	mov    %edx,0x10(%ebp)
  800e8c:	85 c0                	test   %eax,%eax
  800e8e:	75 dd                	jne    800e6d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e93:	c9                   	leave  
  800e94:	c3                   	ret    

00800e95 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e95:	55                   	push   %ebp
  800e96:	89 e5                	mov    %esp,%ebp
  800e98:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ea7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eaa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ead:	73 50                	jae    800eff <memmove+0x6a>
  800eaf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb5:	01 d0                	add    %edx,%eax
  800eb7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800eba:	76 43                	jbe    800eff <memmove+0x6a>
		s += n;
  800ebc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ebf:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ec8:	eb 10                	jmp    800eda <memmove+0x45>
			*--d = *--s;
  800eca:	ff 4d f8             	decl   -0x8(%ebp)
  800ecd:	ff 4d fc             	decl   -0x4(%ebp)
  800ed0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ed3:	8a 10                	mov    (%eax),%dl
  800ed5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800eda:	8b 45 10             	mov    0x10(%ebp),%eax
  800edd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ee0:	89 55 10             	mov    %edx,0x10(%ebp)
  800ee3:	85 c0                	test   %eax,%eax
  800ee5:	75 e3                	jne    800eca <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ee7:	eb 23                	jmp    800f0c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ee9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eec:	8d 50 01             	lea    0x1(%eax),%edx
  800eef:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ef2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ef5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ef8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800efb:	8a 12                	mov    (%edx),%dl
  800efd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800eff:	8b 45 10             	mov    0x10(%ebp),%eax
  800f02:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f05:	89 55 10             	mov    %edx,0x10(%ebp)
  800f08:	85 c0                	test   %eax,%eax
  800f0a:	75 dd                	jne    800ee9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f0c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f0f:	c9                   	leave  
  800f10:	c3                   	ret    

00800f11 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f11:	55                   	push   %ebp
  800f12:	89 e5                	mov    %esp,%ebp
  800f14:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f20:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f23:	eb 2a                	jmp    800f4f <memcmp+0x3e>
		if (*s1 != *s2)
  800f25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f28:	8a 10                	mov    (%eax),%dl
  800f2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f2d:	8a 00                	mov    (%eax),%al
  800f2f:	38 c2                	cmp    %al,%dl
  800f31:	74 16                	je     800f49 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f33:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	0f b6 d0             	movzbl %al,%edx
  800f3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f3e:	8a 00                	mov    (%eax),%al
  800f40:	0f b6 c0             	movzbl %al,%eax
  800f43:	29 c2                	sub    %eax,%edx
  800f45:	89 d0                	mov    %edx,%eax
  800f47:	eb 18                	jmp    800f61 <memcmp+0x50>
		s1++, s2++;
  800f49:	ff 45 fc             	incl   -0x4(%ebp)
  800f4c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f52:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f55:	89 55 10             	mov    %edx,0x10(%ebp)
  800f58:	85 c0                	test   %eax,%eax
  800f5a:	75 c9                	jne    800f25 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f5c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f61:	c9                   	leave  
  800f62:	c3                   	ret    

00800f63 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f63:	55                   	push   %ebp
  800f64:	89 e5                	mov    %esp,%ebp
  800f66:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f69:	8b 55 08             	mov    0x8(%ebp),%edx
  800f6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6f:	01 d0                	add    %edx,%eax
  800f71:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f74:	eb 15                	jmp    800f8b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	8a 00                	mov    (%eax),%al
  800f7b:	0f b6 d0             	movzbl %al,%edx
  800f7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f81:	0f b6 c0             	movzbl %al,%eax
  800f84:	39 c2                	cmp    %eax,%edx
  800f86:	74 0d                	je     800f95 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f88:	ff 45 08             	incl   0x8(%ebp)
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f91:	72 e3                	jb     800f76 <memfind+0x13>
  800f93:	eb 01                	jmp    800f96 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f95:	90                   	nop
	return (void *) s;
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f99:	c9                   	leave  
  800f9a:	c3                   	ret    

00800f9b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f9b:	55                   	push   %ebp
  800f9c:	89 e5                	mov    %esp,%ebp
  800f9e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fa1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fa8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800faf:	eb 03                	jmp    800fb4 <strtol+0x19>
		s++;
  800fb1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	8a 00                	mov    (%eax),%al
  800fb9:	3c 20                	cmp    $0x20,%al
  800fbb:	74 f4                	je     800fb1 <strtol+0x16>
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	8a 00                	mov    (%eax),%al
  800fc2:	3c 09                	cmp    $0x9,%al
  800fc4:	74 eb                	je     800fb1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	8a 00                	mov    (%eax),%al
  800fcb:	3c 2b                	cmp    $0x2b,%al
  800fcd:	75 05                	jne    800fd4 <strtol+0x39>
		s++;
  800fcf:	ff 45 08             	incl   0x8(%ebp)
  800fd2:	eb 13                	jmp    800fe7 <strtol+0x4c>
	else if (*s == '-')
  800fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd7:	8a 00                	mov    (%eax),%al
  800fd9:	3c 2d                	cmp    $0x2d,%al
  800fdb:	75 0a                	jne    800fe7 <strtol+0x4c>
		s++, neg = 1;
  800fdd:	ff 45 08             	incl   0x8(%ebp)
  800fe0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fe7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800feb:	74 06                	je     800ff3 <strtol+0x58>
  800fed:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ff1:	75 20                	jne    801013 <strtol+0x78>
  800ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	3c 30                	cmp    $0x30,%al
  800ffa:	75 17                	jne    801013 <strtol+0x78>
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	40                   	inc    %eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	3c 78                	cmp    $0x78,%al
  801004:	75 0d                	jne    801013 <strtol+0x78>
		s += 2, base = 16;
  801006:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80100a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801011:	eb 28                	jmp    80103b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801013:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801017:	75 15                	jne    80102e <strtol+0x93>
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
  80101c:	8a 00                	mov    (%eax),%al
  80101e:	3c 30                	cmp    $0x30,%al
  801020:	75 0c                	jne    80102e <strtol+0x93>
		s++, base = 8;
  801022:	ff 45 08             	incl   0x8(%ebp)
  801025:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80102c:	eb 0d                	jmp    80103b <strtol+0xa0>
	else if (base == 0)
  80102e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801032:	75 07                	jne    80103b <strtol+0xa0>
		base = 10;
  801034:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
  80103e:	8a 00                	mov    (%eax),%al
  801040:	3c 2f                	cmp    $0x2f,%al
  801042:	7e 19                	jle    80105d <strtol+0xc2>
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	8a 00                	mov    (%eax),%al
  801049:	3c 39                	cmp    $0x39,%al
  80104b:	7f 10                	jg     80105d <strtol+0xc2>
			dig = *s - '0';
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
  801050:	8a 00                	mov    (%eax),%al
  801052:	0f be c0             	movsbl %al,%eax
  801055:	83 e8 30             	sub    $0x30,%eax
  801058:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80105b:	eb 42                	jmp    80109f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	8a 00                	mov    (%eax),%al
  801062:	3c 60                	cmp    $0x60,%al
  801064:	7e 19                	jle    80107f <strtol+0xe4>
  801066:	8b 45 08             	mov    0x8(%ebp),%eax
  801069:	8a 00                	mov    (%eax),%al
  80106b:	3c 7a                	cmp    $0x7a,%al
  80106d:	7f 10                	jg     80107f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80106f:	8b 45 08             	mov    0x8(%ebp),%eax
  801072:	8a 00                	mov    (%eax),%al
  801074:	0f be c0             	movsbl %al,%eax
  801077:	83 e8 57             	sub    $0x57,%eax
  80107a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80107d:	eb 20                	jmp    80109f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8a 00                	mov    (%eax),%al
  801084:	3c 40                	cmp    $0x40,%al
  801086:	7e 39                	jle    8010c1 <strtol+0x126>
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	8a 00                	mov    (%eax),%al
  80108d:	3c 5a                	cmp    $0x5a,%al
  80108f:	7f 30                	jg     8010c1 <strtol+0x126>
			dig = *s - 'A' + 10;
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	8a 00                	mov    (%eax),%al
  801096:	0f be c0             	movsbl %al,%eax
  801099:	83 e8 37             	sub    $0x37,%eax
  80109c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80109f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010a2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010a5:	7d 19                	jge    8010c0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010a7:	ff 45 08             	incl   0x8(%ebp)
  8010aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ad:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010b1:	89 c2                	mov    %eax,%edx
  8010b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010b6:	01 d0                	add    %edx,%eax
  8010b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010bb:	e9 7b ff ff ff       	jmp    80103b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010c0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010c5:	74 08                	je     8010cf <strtol+0x134>
		*endptr = (char *) s;
  8010c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8010cd:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010d3:	74 07                	je     8010dc <strtol+0x141>
  8010d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d8:	f7 d8                	neg    %eax
  8010da:	eb 03                	jmp    8010df <strtol+0x144>
  8010dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010df:	c9                   	leave  
  8010e0:	c3                   	ret    

008010e1 <ltostr>:

void
ltostr(long value, char *str)
{
  8010e1:	55                   	push   %ebp
  8010e2:	89 e5                	mov    %esp,%ebp
  8010e4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010f9:	79 13                	jns    80110e <ltostr+0x2d>
	{
		neg = 1;
  8010fb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801102:	8b 45 0c             	mov    0xc(%ebp),%eax
  801105:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801108:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80110b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80110e:	8b 45 08             	mov    0x8(%ebp),%eax
  801111:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801116:	99                   	cltd   
  801117:	f7 f9                	idiv   %ecx
  801119:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80111c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80111f:	8d 50 01             	lea    0x1(%eax),%edx
  801122:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801125:	89 c2                	mov    %eax,%edx
  801127:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112a:	01 d0                	add    %edx,%eax
  80112c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80112f:	83 c2 30             	add    $0x30,%edx
  801132:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801134:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801137:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80113c:	f7 e9                	imul   %ecx
  80113e:	c1 fa 02             	sar    $0x2,%edx
  801141:	89 c8                	mov    %ecx,%eax
  801143:	c1 f8 1f             	sar    $0x1f,%eax
  801146:	29 c2                	sub    %eax,%edx
  801148:	89 d0                	mov    %edx,%eax
  80114a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80114d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801150:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801155:	f7 e9                	imul   %ecx
  801157:	c1 fa 02             	sar    $0x2,%edx
  80115a:	89 c8                	mov    %ecx,%eax
  80115c:	c1 f8 1f             	sar    $0x1f,%eax
  80115f:	29 c2                	sub    %eax,%edx
  801161:	89 d0                	mov    %edx,%eax
  801163:	c1 e0 02             	shl    $0x2,%eax
  801166:	01 d0                	add    %edx,%eax
  801168:	01 c0                	add    %eax,%eax
  80116a:	29 c1                	sub    %eax,%ecx
  80116c:	89 ca                	mov    %ecx,%edx
  80116e:	85 d2                	test   %edx,%edx
  801170:	75 9c                	jne    80110e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801172:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801179:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80117c:	48                   	dec    %eax
  80117d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801180:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801184:	74 3d                	je     8011c3 <ltostr+0xe2>
		start = 1 ;
  801186:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80118d:	eb 34                	jmp    8011c3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80118f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801192:	8b 45 0c             	mov    0xc(%ebp),%eax
  801195:	01 d0                	add    %edx,%eax
  801197:	8a 00                	mov    (%eax),%al
  801199:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80119c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80119f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a2:	01 c2                	add    %eax,%edx
  8011a4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011aa:	01 c8                	add    %ecx,%eax
  8011ac:	8a 00                	mov    (%eax),%al
  8011ae:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011b0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b6:	01 c2                	add    %eax,%edx
  8011b8:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011bb:	88 02                	mov    %al,(%edx)
		start++ ;
  8011bd:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011c0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011c6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011c9:	7c c4                	jl     80118f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011cb:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d1:	01 d0                	add    %edx,%eax
  8011d3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011d6:	90                   	nop
  8011d7:	c9                   	leave  
  8011d8:	c3                   	ret    

008011d9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011d9:	55                   	push   %ebp
  8011da:	89 e5                	mov    %esp,%ebp
  8011dc:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011df:	ff 75 08             	pushl  0x8(%ebp)
  8011e2:	e8 54 fa ff ff       	call   800c3b <strlen>
  8011e7:	83 c4 04             	add    $0x4,%esp
  8011ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011ed:	ff 75 0c             	pushl  0xc(%ebp)
  8011f0:	e8 46 fa ff ff       	call   800c3b <strlen>
  8011f5:	83 c4 04             	add    $0x4,%esp
  8011f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801202:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801209:	eb 17                	jmp    801222 <strcconcat+0x49>
		final[s] = str1[s] ;
  80120b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80120e:	8b 45 10             	mov    0x10(%ebp),%eax
  801211:	01 c2                	add    %eax,%edx
  801213:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801216:	8b 45 08             	mov    0x8(%ebp),%eax
  801219:	01 c8                	add    %ecx,%eax
  80121b:	8a 00                	mov    (%eax),%al
  80121d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80121f:	ff 45 fc             	incl   -0x4(%ebp)
  801222:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801225:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801228:	7c e1                	jl     80120b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80122a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801231:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801238:	eb 1f                	jmp    801259 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80123a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80123d:	8d 50 01             	lea    0x1(%eax),%edx
  801240:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801243:	89 c2                	mov    %eax,%edx
  801245:	8b 45 10             	mov    0x10(%ebp),%eax
  801248:	01 c2                	add    %eax,%edx
  80124a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80124d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801250:	01 c8                	add    %ecx,%eax
  801252:	8a 00                	mov    (%eax),%al
  801254:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801256:	ff 45 f8             	incl   -0x8(%ebp)
  801259:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80125c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80125f:	7c d9                	jl     80123a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801261:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801264:	8b 45 10             	mov    0x10(%ebp),%eax
  801267:	01 d0                	add    %edx,%eax
  801269:	c6 00 00             	movb   $0x0,(%eax)
}
  80126c:	90                   	nop
  80126d:	c9                   	leave  
  80126e:	c3                   	ret    

0080126f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80126f:	55                   	push   %ebp
  801270:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801272:	8b 45 14             	mov    0x14(%ebp),%eax
  801275:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80127b:	8b 45 14             	mov    0x14(%ebp),%eax
  80127e:	8b 00                	mov    (%eax),%eax
  801280:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801287:	8b 45 10             	mov    0x10(%ebp),%eax
  80128a:	01 d0                	add    %edx,%eax
  80128c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801292:	eb 0c                	jmp    8012a0 <strsplit+0x31>
			*string++ = 0;
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	8d 50 01             	lea    0x1(%eax),%edx
  80129a:	89 55 08             	mov    %edx,0x8(%ebp)
  80129d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	8a 00                	mov    (%eax),%al
  8012a5:	84 c0                	test   %al,%al
  8012a7:	74 18                	je     8012c1 <strsplit+0x52>
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	8a 00                	mov    (%eax),%al
  8012ae:	0f be c0             	movsbl %al,%eax
  8012b1:	50                   	push   %eax
  8012b2:	ff 75 0c             	pushl  0xc(%ebp)
  8012b5:	e8 13 fb ff ff       	call   800dcd <strchr>
  8012ba:	83 c4 08             	add    $0x8,%esp
  8012bd:	85 c0                	test   %eax,%eax
  8012bf:	75 d3                	jne    801294 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	8a 00                	mov    (%eax),%al
  8012c6:	84 c0                	test   %al,%al
  8012c8:	74 5a                	je     801324 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8012ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8012cd:	8b 00                	mov    (%eax),%eax
  8012cf:	83 f8 0f             	cmp    $0xf,%eax
  8012d2:	75 07                	jne    8012db <strsplit+0x6c>
		{
			return 0;
  8012d4:	b8 00 00 00 00       	mov    $0x0,%eax
  8012d9:	eb 66                	jmp    801341 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012db:	8b 45 14             	mov    0x14(%ebp),%eax
  8012de:	8b 00                	mov    (%eax),%eax
  8012e0:	8d 48 01             	lea    0x1(%eax),%ecx
  8012e3:	8b 55 14             	mov    0x14(%ebp),%edx
  8012e6:	89 0a                	mov    %ecx,(%edx)
  8012e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f2:	01 c2                	add    %eax,%edx
  8012f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012f9:	eb 03                	jmp    8012fe <strsplit+0x8f>
			string++;
  8012fb:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801301:	8a 00                	mov    (%eax),%al
  801303:	84 c0                	test   %al,%al
  801305:	74 8b                	je     801292 <strsplit+0x23>
  801307:	8b 45 08             	mov    0x8(%ebp),%eax
  80130a:	8a 00                	mov    (%eax),%al
  80130c:	0f be c0             	movsbl %al,%eax
  80130f:	50                   	push   %eax
  801310:	ff 75 0c             	pushl  0xc(%ebp)
  801313:	e8 b5 fa ff ff       	call   800dcd <strchr>
  801318:	83 c4 08             	add    $0x8,%esp
  80131b:	85 c0                	test   %eax,%eax
  80131d:	74 dc                	je     8012fb <strsplit+0x8c>
			string++;
	}
  80131f:	e9 6e ff ff ff       	jmp    801292 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801324:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801325:	8b 45 14             	mov    0x14(%ebp),%eax
  801328:	8b 00                	mov    (%eax),%eax
  80132a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801331:	8b 45 10             	mov    0x10(%ebp),%eax
  801334:	01 d0                	add    %edx,%eax
  801336:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80133c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801341:	c9                   	leave  
  801342:	c3                   	ret    

00801343 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801343:	55                   	push   %ebp
  801344:	89 e5                	mov    %esp,%ebp
  801346:	57                   	push   %edi
  801347:	56                   	push   %esi
  801348:	53                   	push   %ebx
  801349:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80134c:	8b 45 08             	mov    0x8(%ebp),%eax
  80134f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801352:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801355:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801358:	8b 7d 18             	mov    0x18(%ebp),%edi
  80135b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80135e:	cd 30                	int    $0x30
  801360:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801363:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801366:	83 c4 10             	add    $0x10,%esp
  801369:	5b                   	pop    %ebx
  80136a:	5e                   	pop    %esi
  80136b:	5f                   	pop    %edi
  80136c:	5d                   	pop    %ebp
  80136d:	c3                   	ret    

0080136e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80136e:	55                   	push   %ebp
  80136f:	89 e5                	mov    %esp,%ebp
  801371:	83 ec 04             	sub    $0x4,%esp
  801374:	8b 45 10             	mov    0x10(%ebp),%eax
  801377:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80137a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	52                   	push   %edx
  801386:	ff 75 0c             	pushl  0xc(%ebp)
  801389:	50                   	push   %eax
  80138a:	6a 00                	push   $0x0
  80138c:	e8 b2 ff ff ff       	call   801343 <syscall>
  801391:	83 c4 18             	add    $0x18,%esp
}
  801394:	90                   	nop
  801395:	c9                   	leave  
  801396:	c3                   	ret    

00801397 <sys_cgetc>:

int
sys_cgetc(void)
{
  801397:	55                   	push   %ebp
  801398:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 00                	push   $0x0
  8013a4:	6a 01                	push   $0x1
  8013a6:	e8 98 ff ff ff       	call   801343 <syscall>
  8013ab:	83 c4 18             	add    $0x18,%esp
}
  8013ae:	c9                   	leave  
  8013af:	c3                   	ret    

008013b0 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8013b0:	55                   	push   %ebp
  8013b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	50                   	push   %eax
  8013bf:	6a 05                	push   $0x5
  8013c1:	e8 7d ff ff ff       	call   801343 <syscall>
  8013c6:	83 c4 18             	add    $0x18,%esp
}
  8013c9:	c9                   	leave  
  8013ca:	c3                   	ret    

008013cb <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013cb:	55                   	push   %ebp
  8013cc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 02                	push   $0x2
  8013da:	e8 64 ff ff ff       	call   801343 <syscall>
  8013df:	83 c4 18             	add    $0x18,%esp
}
  8013e2:	c9                   	leave  
  8013e3:	c3                   	ret    

008013e4 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013e4:	55                   	push   %ebp
  8013e5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 03                	push   $0x3
  8013f3:	e8 4b ff ff ff       	call   801343 <syscall>
  8013f8:	83 c4 18             	add    $0x18,%esp
}
  8013fb:	c9                   	leave  
  8013fc:	c3                   	ret    

008013fd <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013fd:	55                   	push   %ebp
  8013fe:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 04                	push   $0x4
  80140c:	e8 32 ff ff ff       	call   801343 <syscall>
  801411:	83 c4 18             	add    $0x18,%esp
}
  801414:	c9                   	leave  
  801415:	c3                   	ret    

00801416 <sys_env_exit>:


void sys_env_exit(void)
{
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 06                	push   $0x6
  801425:	e8 19 ff ff ff       	call   801343 <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
}
  80142d:	90                   	nop
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801433:	8b 55 0c             	mov    0xc(%ebp),%edx
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	52                   	push   %edx
  801440:	50                   	push   %eax
  801441:	6a 07                	push   $0x7
  801443:	e8 fb fe ff ff       	call   801343 <syscall>
  801448:	83 c4 18             	add    $0x18,%esp
}
  80144b:	c9                   	leave  
  80144c:	c3                   	ret    

0080144d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80144d:	55                   	push   %ebp
  80144e:	89 e5                	mov    %esp,%ebp
  801450:	56                   	push   %esi
  801451:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801452:	8b 75 18             	mov    0x18(%ebp),%esi
  801455:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801458:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80145b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	56                   	push   %esi
  801462:	53                   	push   %ebx
  801463:	51                   	push   %ecx
  801464:	52                   	push   %edx
  801465:	50                   	push   %eax
  801466:	6a 08                	push   $0x8
  801468:	e8 d6 fe ff ff       	call   801343 <syscall>
  80146d:	83 c4 18             	add    $0x18,%esp
}
  801470:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801473:	5b                   	pop    %ebx
  801474:	5e                   	pop    %esi
  801475:	5d                   	pop    %ebp
  801476:	c3                   	ret    

00801477 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80147a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	52                   	push   %edx
  801487:	50                   	push   %eax
  801488:	6a 09                	push   $0x9
  80148a:	e8 b4 fe ff ff       	call   801343 <syscall>
  80148f:	83 c4 18             	add    $0x18,%esp
}
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	ff 75 0c             	pushl  0xc(%ebp)
  8014a0:	ff 75 08             	pushl  0x8(%ebp)
  8014a3:	6a 0a                	push   $0xa
  8014a5:	e8 99 fe ff ff       	call   801343 <syscall>
  8014aa:	83 c4 18             	add    $0x18,%esp
}
  8014ad:	c9                   	leave  
  8014ae:	c3                   	ret    

008014af <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8014af:	55                   	push   %ebp
  8014b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 0b                	push   $0xb
  8014be:	e8 80 fe ff ff       	call   801343 <syscall>
  8014c3:	83 c4 18             	add    $0x18,%esp
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 0c                	push   $0xc
  8014d7:	e8 67 fe ff ff       	call   801343 <syscall>
  8014dc:	83 c4 18             	add    $0x18,%esp
}
  8014df:	c9                   	leave  
  8014e0:	c3                   	ret    

008014e1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014e1:	55                   	push   %ebp
  8014e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 0d                	push   $0xd
  8014f0:	e8 4e fe ff ff       	call   801343 <syscall>
  8014f5:	83 c4 18             	add    $0x18,%esp
}
  8014f8:	c9                   	leave  
  8014f9:	c3                   	ret    

008014fa <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	ff 75 0c             	pushl  0xc(%ebp)
  801506:	ff 75 08             	pushl  0x8(%ebp)
  801509:	6a 11                	push   $0x11
  80150b:	e8 33 fe ff ff       	call   801343 <syscall>
  801510:	83 c4 18             	add    $0x18,%esp
	return;
  801513:	90                   	nop
}
  801514:	c9                   	leave  
  801515:	c3                   	ret    

00801516 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801516:	55                   	push   %ebp
  801517:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	ff 75 0c             	pushl  0xc(%ebp)
  801522:	ff 75 08             	pushl  0x8(%ebp)
  801525:	6a 12                	push   $0x12
  801527:	e8 17 fe ff ff       	call   801343 <syscall>
  80152c:	83 c4 18             	add    $0x18,%esp
	return ;
  80152f:	90                   	nop
}
  801530:	c9                   	leave  
  801531:	c3                   	ret    

00801532 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801532:	55                   	push   %ebp
  801533:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 0e                	push   $0xe
  801541:	e8 fd fd ff ff       	call   801343 <syscall>
  801546:	83 c4 18             	add    $0x18,%esp
}
  801549:	c9                   	leave  
  80154a:	c3                   	ret    

0080154b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80154b:	55                   	push   %ebp
  80154c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	ff 75 08             	pushl  0x8(%ebp)
  801559:	6a 0f                	push   $0xf
  80155b:	e8 e3 fd ff ff       	call   801343 <syscall>
  801560:	83 c4 18             	add    $0x18,%esp
}
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 10                	push   $0x10
  801574:	e8 ca fd ff ff       	call   801343 <syscall>
  801579:	83 c4 18             	add    $0x18,%esp
}
  80157c:	90                   	nop
  80157d:	c9                   	leave  
  80157e:	c3                   	ret    

0080157f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80157f:	55                   	push   %ebp
  801580:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	6a 14                	push   $0x14
  80158e:	e8 b0 fd ff ff       	call   801343 <syscall>
  801593:	83 c4 18             	add    $0x18,%esp
}
  801596:	90                   	nop
  801597:	c9                   	leave  
  801598:	c3                   	ret    

00801599 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801599:	55                   	push   %ebp
  80159a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 15                	push   $0x15
  8015a8:	e8 96 fd ff ff       	call   801343 <syscall>
  8015ad:	83 c4 18             	add    $0x18,%esp
}
  8015b0:	90                   	nop
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <sys_cputc>:


void
sys_cputc(const char c)
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
  8015b6:	83 ec 04             	sub    $0x4,%esp
  8015b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015bf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	50                   	push   %eax
  8015cc:	6a 16                	push   $0x16
  8015ce:	e8 70 fd ff ff       	call   801343 <syscall>
  8015d3:	83 c4 18             	add    $0x18,%esp
}
  8015d6:	90                   	nop
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 17                	push   $0x17
  8015e8:	e8 56 fd ff ff       	call   801343 <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	90                   	nop
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	ff 75 0c             	pushl  0xc(%ebp)
  801602:	50                   	push   %eax
  801603:	6a 18                	push   $0x18
  801605:	e8 39 fd ff ff       	call   801343 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801612:	8b 55 0c             	mov    0xc(%ebp),%edx
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	52                   	push   %edx
  80161f:	50                   	push   %eax
  801620:	6a 1b                	push   $0x1b
  801622:	e8 1c fd ff ff       	call   801343 <syscall>
  801627:	83 c4 18             	add    $0x18,%esp
}
  80162a:	c9                   	leave  
  80162b:	c3                   	ret    

0080162c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80162c:	55                   	push   %ebp
  80162d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80162f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	52                   	push   %edx
  80163c:	50                   	push   %eax
  80163d:	6a 19                	push   $0x19
  80163f:	e8 ff fc ff ff       	call   801343 <syscall>
  801644:	83 c4 18             	add    $0x18,%esp
}
  801647:	90                   	nop
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80164d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	52                   	push   %edx
  80165a:	50                   	push   %eax
  80165b:	6a 1a                	push   $0x1a
  80165d:	e8 e1 fc ff ff       	call   801343 <syscall>
  801662:	83 c4 18             	add    $0x18,%esp
}
  801665:	90                   	nop
  801666:	c9                   	leave  
  801667:	c3                   	ret    

00801668 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801668:	55                   	push   %ebp
  801669:	89 e5                	mov    %esp,%ebp
  80166b:	83 ec 04             	sub    $0x4,%esp
  80166e:	8b 45 10             	mov    0x10(%ebp),%eax
  801671:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801674:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801677:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	6a 00                	push   $0x0
  801680:	51                   	push   %ecx
  801681:	52                   	push   %edx
  801682:	ff 75 0c             	pushl  0xc(%ebp)
  801685:	50                   	push   %eax
  801686:	6a 1c                	push   $0x1c
  801688:	e8 b6 fc ff ff       	call   801343 <syscall>
  80168d:	83 c4 18             	add    $0x18,%esp
}
  801690:	c9                   	leave  
  801691:	c3                   	ret    

00801692 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801692:	55                   	push   %ebp
  801693:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801695:	8b 55 0c             	mov    0xc(%ebp),%edx
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	52                   	push   %edx
  8016a2:	50                   	push   %eax
  8016a3:	6a 1d                	push   $0x1d
  8016a5:	e8 99 fc ff ff       	call   801343 <syscall>
  8016aa:	83 c4 18             	add    $0x18,%esp
}
  8016ad:	c9                   	leave  
  8016ae:	c3                   	ret    

008016af <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8016af:	55                   	push   %ebp
  8016b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8016b2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	51                   	push   %ecx
  8016c0:	52                   	push   %edx
  8016c1:	50                   	push   %eax
  8016c2:	6a 1e                	push   $0x1e
  8016c4:	e8 7a fc ff ff       	call   801343 <syscall>
  8016c9:	83 c4 18             	add    $0x18,%esp
}
  8016cc:	c9                   	leave  
  8016cd:	c3                   	ret    

008016ce <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016ce:	55                   	push   %ebp
  8016cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	52                   	push   %edx
  8016de:	50                   	push   %eax
  8016df:	6a 1f                	push   $0x1f
  8016e1:	e8 5d fc ff ff       	call   801343 <syscall>
  8016e6:	83 c4 18             	add    $0x18,%esp
}
  8016e9:	c9                   	leave  
  8016ea:	c3                   	ret    

008016eb <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016eb:	55                   	push   %ebp
  8016ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 20                	push   $0x20
  8016fa:	e8 44 fc ff ff       	call   801343 <syscall>
  8016ff:	83 c4 18             	add    $0x18,%esp
}
  801702:	c9                   	leave  
  801703:	c3                   	ret    

00801704 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	6a 00                	push   $0x0
  80170c:	ff 75 14             	pushl  0x14(%ebp)
  80170f:	ff 75 10             	pushl  0x10(%ebp)
  801712:	ff 75 0c             	pushl  0xc(%ebp)
  801715:	50                   	push   %eax
  801716:	6a 21                	push   $0x21
  801718:	e8 26 fc ff ff       	call   801343 <syscall>
  80171d:	83 c4 18             	add    $0x18,%esp
}
  801720:	c9                   	leave  
  801721:	c3                   	ret    

00801722 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801722:	55                   	push   %ebp
  801723:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	50                   	push   %eax
  801731:	6a 22                	push   $0x22
  801733:	e8 0b fc ff ff       	call   801343 <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
}
  80173b:	90                   	nop
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801741:	8b 45 08             	mov    0x8(%ebp),%eax
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	50                   	push   %eax
  80174d:	6a 23                	push   $0x23
  80174f:	e8 ef fb ff ff       	call   801343 <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
}
  801757:	90                   	nop
  801758:	c9                   	leave  
  801759:	c3                   	ret    

0080175a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80175a:	55                   	push   %ebp
  80175b:	89 e5                	mov    %esp,%ebp
  80175d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801760:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801763:	8d 50 04             	lea    0x4(%eax),%edx
  801766:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	52                   	push   %edx
  801770:	50                   	push   %eax
  801771:	6a 24                	push   $0x24
  801773:	e8 cb fb ff ff       	call   801343 <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
	return result;
  80177b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80177e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801781:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801784:	89 01                	mov    %eax,(%ecx)
  801786:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801789:	8b 45 08             	mov    0x8(%ebp),%eax
  80178c:	c9                   	leave  
  80178d:	c2 04 00             	ret    $0x4

00801790 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	ff 75 10             	pushl  0x10(%ebp)
  80179a:	ff 75 0c             	pushl  0xc(%ebp)
  80179d:	ff 75 08             	pushl  0x8(%ebp)
  8017a0:	6a 13                	push   $0x13
  8017a2:	e8 9c fb ff ff       	call   801343 <syscall>
  8017a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8017aa:	90                   	nop
}
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <sys_rcr2>:
uint32 sys_rcr2()
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 25                	push   $0x25
  8017bc:	e8 82 fb ff ff       	call   801343 <syscall>
  8017c1:	83 c4 18             	add    $0x18,%esp
}
  8017c4:	c9                   	leave  
  8017c5:	c3                   	ret    

008017c6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017c6:	55                   	push   %ebp
  8017c7:	89 e5                	mov    %esp,%ebp
  8017c9:	83 ec 04             	sub    $0x4,%esp
  8017cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017d2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	50                   	push   %eax
  8017df:	6a 26                	push   $0x26
  8017e1:	e8 5d fb ff ff       	call   801343 <syscall>
  8017e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e9:	90                   	nop
}
  8017ea:	c9                   	leave  
  8017eb:	c3                   	ret    

008017ec <rsttst>:
void rsttst()
{
  8017ec:	55                   	push   %ebp
  8017ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 28                	push   $0x28
  8017fb:	e8 43 fb ff ff       	call   801343 <syscall>
  801800:	83 c4 18             	add    $0x18,%esp
	return ;
  801803:	90                   	nop
}
  801804:	c9                   	leave  
  801805:	c3                   	ret    

00801806 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801806:	55                   	push   %ebp
  801807:	89 e5                	mov    %esp,%ebp
  801809:	83 ec 04             	sub    $0x4,%esp
  80180c:	8b 45 14             	mov    0x14(%ebp),%eax
  80180f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801812:	8b 55 18             	mov    0x18(%ebp),%edx
  801815:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801819:	52                   	push   %edx
  80181a:	50                   	push   %eax
  80181b:	ff 75 10             	pushl  0x10(%ebp)
  80181e:	ff 75 0c             	pushl  0xc(%ebp)
  801821:	ff 75 08             	pushl  0x8(%ebp)
  801824:	6a 27                	push   $0x27
  801826:	e8 18 fb ff ff       	call   801343 <syscall>
  80182b:	83 c4 18             	add    $0x18,%esp
	return ;
  80182e:	90                   	nop
}
  80182f:	c9                   	leave  
  801830:	c3                   	ret    

00801831 <chktst>:
void chktst(uint32 n)
{
  801831:	55                   	push   %ebp
  801832:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	ff 75 08             	pushl  0x8(%ebp)
  80183f:	6a 29                	push   $0x29
  801841:	e8 fd fa ff ff       	call   801343 <syscall>
  801846:	83 c4 18             	add    $0x18,%esp
	return ;
  801849:	90                   	nop
}
  80184a:	c9                   	leave  
  80184b:	c3                   	ret    

0080184c <inctst>:

void inctst()
{
  80184c:	55                   	push   %ebp
  80184d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 2a                	push   $0x2a
  80185b:	e8 e3 fa ff ff       	call   801343 <syscall>
  801860:	83 c4 18             	add    $0x18,%esp
	return ;
  801863:	90                   	nop
}
  801864:	c9                   	leave  
  801865:	c3                   	ret    

00801866 <gettst>:
uint32 gettst()
{
  801866:	55                   	push   %ebp
  801867:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 2b                	push   $0x2b
  801875:	e8 c9 fa ff ff       	call   801343 <syscall>
  80187a:	83 c4 18             	add    $0x18,%esp
}
  80187d:	c9                   	leave  
  80187e:	c3                   	ret    

0080187f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80187f:	55                   	push   %ebp
  801880:	89 e5                	mov    %esp,%ebp
  801882:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 2c                	push   $0x2c
  801891:	e8 ad fa ff ff       	call   801343 <syscall>
  801896:	83 c4 18             	add    $0x18,%esp
  801899:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80189c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8018a0:	75 07                	jne    8018a9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8018a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8018a7:	eb 05                	jmp    8018ae <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8018a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
  8018b3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 2c                	push   $0x2c
  8018c2:	e8 7c fa ff ff       	call   801343 <syscall>
  8018c7:	83 c4 18             	add    $0x18,%esp
  8018ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018cd:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018d1:	75 07                	jne    8018da <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018d3:	b8 01 00 00 00       	mov    $0x1,%eax
  8018d8:	eb 05                	jmp    8018df <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018da:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
  8018e4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 2c                	push   $0x2c
  8018f3:	e8 4b fa ff ff       	call   801343 <syscall>
  8018f8:	83 c4 18             	add    $0x18,%esp
  8018fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018fe:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801902:	75 07                	jne    80190b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801904:	b8 01 00 00 00       	mov    $0x1,%eax
  801909:	eb 05                	jmp    801910 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80190b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801910:	c9                   	leave  
  801911:	c3                   	ret    

00801912 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801912:	55                   	push   %ebp
  801913:	89 e5                	mov    %esp,%ebp
  801915:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 2c                	push   $0x2c
  801924:	e8 1a fa ff ff       	call   801343 <syscall>
  801929:	83 c4 18             	add    $0x18,%esp
  80192c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80192f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801933:	75 07                	jne    80193c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801935:	b8 01 00 00 00       	mov    $0x1,%eax
  80193a:	eb 05                	jmp    801941 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80193c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801941:	c9                   	leave  
  801942:	c3                   	ret    

00801943 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801943:	55                   	push   %ebp
  801944:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	ff 75 08             	pushl  0x8(%ebp)
  801951:	6a 2d                	push   $0x2d
  801953:	e8 eb f9 ff ff       	call   801343 <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
	return ;
  80195b:	90                   	nop
}
  80195c:	c9                   	leave  
  80195d:	c3                   	ret    

0080195e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80195e:	55                   	push   %ebp
  80195f:	89 e5                	mov    %esp,%ebp
  801961:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801962:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801965:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801968:	8b 55 0c             	mov    0xc(%ebp),%edx
  80196b:	8b 45 08             	mov    0x8(%ebp),%eax
  80196e:	6a 00                	push   $0x0
  801970:	53                   	push   %ebx
  801971:	51                   	push   %ecx
  801972:	52                   	push   %edx
  801973:	50                   	push   %eax
  801974:	6a 2e                	push   $0x2e
  801976:	e8 c8 f9 ff ff       	call   801343 <syscall>
  80197b:	83 c4 18             	add    $0x18,%esp
}
  80197e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801981:	c9                   	leave  
  801982:	c3                   	ret    

00801983 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801983:	55                   	push   %ebp
  801984:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801986:	8b 55 0c             	mov    0xc(%ebp),%edx
  801989:	8b 45 08             	mov    0x8(%ebp),%eax
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	52                   	push   %edx
  801993:	50                   	push   %eax
  801994:	6a 2f                	push   $0x2f
  801996:	e8 a8 f9 ff ff       	call   801343 <syscall>
  80199b:	83 c4 18             	add    $0x18,%esp
}
  80199e:	c9                   	leave  
  80199f:	c3                   	ret    

008019a0 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
  8019a3:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8019a6:	8b 55 08             	mov    0x8(%ebp),%edx
  8019a9:	89 d0                	mov    %edx,%eax
  8019ab:	c1 e0 02             	shl    $0x2,%eax
  8019ae:	01 d0                	add    %edx,%eax
  8019b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019b7:	01 d0                	add    %edx,%eax
  8019b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019c0:	01 d0                	add    %edx,%eax
  8019c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019c9:	01 d0                	add    %edx,%eax
  8019cb:	c1 e0 04             	shl    $0x4,%eax
  8019ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8019d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8019d8:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8019db:	83 ec 0c             	sub    $0xc,%esp
  8019de:	50                   	push   %eax
  8019df:	e8 76 fd ff ff       	call   80175a <sys_get_virtual_time>
  8019e4:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8019e7:	eb 41                	jmp    801a2a <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8019e9:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8019ec:	83 ec 0c             	sub    $0xc,%esp
  8019ef:	50                   	push   %eax
  8019f0:	e8 65 fd ff ff       	call   80175a <sys_get_virtual_time>
  8019f5:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8019f8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019fe:	29 c2                	sub    %eax,%edx
  801a00:	89 d0                	mov    %edx,%eax
  801a02:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801a05:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a08:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a0b:	89 d1                	mov    %edx,%ecx
  801a0d:	29 c1                	sub    %eax,%ecx
  801a0f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a12:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a15:	39 c2                	cmp    %eax,%edx
  801a17:	0f 97 c0             	seta   %al
  801a1a:	0f b6 c0             	movzbl %al,%eax
  801a1d:	29 c1                	sub    %eax,%ecx
  801a1f:	89 c8                	mov    %ecx,%eax
  801a21:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801a24:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a27:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a2d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a30:	72 b7                	jb     8019e9 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a32:	90                   	nop
  801a33:	c9                   	leave  
  801a34:	c3                   	ret    

00801a35 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a35:	55                   	push   %ebp
  801a36:	89 e5                	mov    %esp,%ebp
  801a38:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801a3b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801a42:	eb 03                	jmp    801a47 <busy_wait+0x12>
  801a44:	ff 45 fc             	incl   -0x4(%ebp)
  801a47:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a4a:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a4d:	72 f5                	jb     801a44 <busy_wait+0xf>
	return i;
  801a4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801a52:	c9                   	leave  
  801a53:	c3                   	ret    

00801a54 <__udivdi3>:
  801a54:	55                   	push   %ebp
  801a55:	57                   	push   %edi
  801a56:	56                   	push   %esi
  801a57:	53                   	push   %ebx
  801a58:	83 ec 1c             	sub    $0x1c,%esp
  801a5b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a5f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a63:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a67:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a6b:	89 ca                	mov    %ecx,%edx
  801a6d:	89 f8                	mov    %edi,%eax
  801a6f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a73:	85 f6                	test   %esi,%esi
  801a75:	75 2d                	jne    801aa4 <__udivdi3+0x50>
  801a77:	39 cf                	cmp    %ecx,%edi
  801a79:	77 65                	ja     801ae0 <__udivdi3+0x8c>
  801a7b:	89 fd                	mov    %edi,%ebp
  801a7d:	85 ff                	test   %edi,%edi
  801a7f:	75 0b                	jne    801a8c <__udivdi3+0x38>
  801a81:	b8 01 00 00 00       	mov    $0x1,%eax
  801a86:	31 d2                	xor    %edx,%edx
  801a88:	f7 f7                	div    %edi
  801a8a:	89 c5                	mov    %eax,%ebp
  801a8c:	31 d2                	xor    %edx,%edx
  801a8e:	89 c8                	mov    %ecx,%eax
  801a90:	f7 f5                	div    %ebp
  801a92:	89 c1                	mov    %eax,%ecx
  801a94:	89 d8                	mov    %ebx,%eax
  801a96:	f7 f5                	div    %ebp
  801a98:	89 cf                	mov    %ecx,%edi
  801a9a:	89 fa                	mov    %edi,%edx
  801a9c:	83 c4 1c             	add    $0x1c,%esp
  801a9f:	5b                   	pop    %ebx
  801aa0:	5e                   	pop    %esi
  801aa1:	5f                   	pop    %edi
  801aa2:	5d                   	pop    %ebp
  801aa3:	c3                   	ret    
  801aa4:	39 ce                	cmp    %ecx,%esi
  801aa6:	77 28                	ja     801ad0 <__udivdi3+0x7c>
  801aa8:	0f bd fe             	bsr    %esi,%edi
  801aab:	83 f7 1f             	xor    $0x1f,%edi
  801aae:	75 40                	jne    801af0 <__udivdi3+0x9c>
  801ab0:	39 ce                	cmp    %ecx,%esi
  801ab2:	72 0a                	jb     801abe <__udivdi3+0x6a>
  801ab4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ab8:	0f 87 9e 00 00 00    	ja     801b5c <__udivdi3+0x108>
  801abe:	b8 01 00 00 00       	mov    $0x1,%eax
  801ac3:	89 fa                	mov    %edi,%edx
  801ac5:	83 c4 1c             	add    $0x1c,%esp
  801ac8:	5b                   	pop    %ebx
  801ac9:	5e                   	pop    %esi
  801aca:	5f                   	pop    %edi
  801acb:	5d                   	pop    %ebp
  801acc:	c3                   	ret    
  801acd:	8d 76 00             	lea    0x0(%esi),%esi
  801ad0:	31 ff                	xor    %edi,%edi
  801ad2:	31 c0                	xor    %eax,%eax
  801ad4:	89 fa                	mov    %edi,%edx
  801ad6:	83 c4 1c             	add    $0x1c,%esp
  801ad9:	5b                   	pop    %ebx
  801ada:	5e                   	pop    %esi
  801adb:	5f                   	pop    %edi
  801adc:	5d                   	pop    %ebp
  801add:	c3                   	ret    
  801ade:	66 90                	xchg   %ax,%ax
  801ae0:	89 d8                	mov    %ebx,%eax
  801ae2:	f7 f7                	div    %edi
  801ae4:	31 ff                	xor    %edi,%edi
  801ae6:	89 fa                	mov    %edi,%edx
  801ae8:	83 c4 1c             	add    $0x1c,%esp
  801aeb:	5b                   	pop    %ebx
  801aec:	5e                   	pop    %esi
  801aed:	5f                   	pop    %edi
  801aee:	5d                   	pop    %ebp
  801aef:	c3                   	ret    
  801af0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801af5:	89 eb                	mov    %ebp,%ebx
  801af7:	29 fb                	sub    %edi,%ebx
  801af9:	89 f9                	mov    %edi,%ecx
  801afb:	d3 e6                	shl    %cl,%esi
  801afd:	89 c5                	mov    %eax,%ebp
  801aff:	88 d9                	mov    %bl,%cl
  801b01:	d3 ed                	shr    %cl,%ebp
  801b03:	89 e9                	mov    %ebp,%ecx
  801b05:	09 f1                	or     %esi,%ecx
  801b07:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b0b:	89 f9                	mov    %edi,%ecx
  801b0d:	d3 e0                	shl    %cl,%eax
  801b0f:	89 c5                	mov    %eax,%ebp
  801b11:	89 d6                	mov    %edx,%esi
  801b13:	88 d9                	mov    %bl,%cl
  801b15:	d3 ee                	shr    %cl,%esi
  801b17:	89 f9                	mov    %edi,%ecx
  801b19:	d3 e2                	shl    %cl,%edx
  801b1b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b1f:	88 d9                	mov    %bl,%cl
  801b21:	d3 e8                	shr    %cl,%eax
  801b23:	09 c2                	or     %eax,%edx
  801b25:	89 d0                	mov    %edx,%eax
  801b27:	89 f2                	mov    %esi,%edx
  801b29:	f7 74 24 0c          	divl   0xc(%esp)
  801b2d:	89 d6                	mov    %edx,%esi
  801b2f:	89 c3                	mov    %eax,%ebx
  801b31:	f7 e5                	mul    %ebp
  801b33:	39 d6                	cmp    %edx,%esi
  801b35:	72 19                	jb     801b50 <__udivdi3+0xfc>
  801b37:	74 0b                	je     801b44 <__udivdi3+0xf0>
  801b39:	89 d8                	mov    %ebx,%eax
  801b3b:	31 ff                	xor    %edi,%edi
  801b3d:	e9 58 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b42:	66 90                	xchg   %ax,%ax
  801b44:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b48:	89 f9                	mov    %edi,%ecx
  801b4a:	d3 e2                	shl    %cl,%edx
  801b4c:	39 c2                	cmp    %eax,%edx
  801b4e:	73 e9                	jae    801b39 <__udivdi3+0xe5>
  801b50:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b53:	31 ff                	xor    %edi,%edi
  801b55:	e9 40 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b5a:	66 90                	xchg   %ax,%ax
  801b5c:	31 c0                	xor    %eax,%eax
  801b5e:	e9 37 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b63:	90                   	nop

00801b64 <__umoddi3>:
  801b64:	55                   	push   %ebp
  801b65:	57                   	push   %edi
  801b66:	56                   	push   %esi
  801b67:	53                   	push   %ebx
  801b68:	83 ec 1c             	sub    $0x1c,%esp
  801b6b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b6f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b73:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b77:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b7b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b7f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b83:	89 f3                	mov    %esi,%ebx
  801b85:	89 fa                	mov    %edi,%edx
  801b87:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b8b:	89 34 24             	mov    %esi,(%esp)
  801b8e:	85 c0                	test   %eax,%eax
  801b90:	75 1a                	jne    801bac <__umoddi3+0x48>
  801b92:	39 f7                	cmp    %esi,%edi
  801b94:	0f 86 a2 00 00 00    	jbe    801c3c <__umoddi3+0xd8>
  801b9a:	89 c8                	mov    %ecx,%eax
  801b9c:	89 f2                	mov    %esi,%edx
  801b9e:	f7 f7                	div    %edi
  801ba0:	89 d0                	mov    %edx,%eax
  801ba2:	31 d2                	xor    %edx,%edx
  801ba4:	83 c4 1c             	add    $0x1c,%esp
  801ba7:	5b                   	pop    %ebx
  801ba8:	5e                   	pop    %esi
  801ba9:	5f                   	pop    %edi
  801baa:	5d                   	pop    %ebp
  801bab:	c3                   	ret    
  801bac:	39 f0                	cmp    %esi,%eax
  801bae:	0f 87 ac 00 00 00    	ja     801c60 <__umoddi3+0xfc>
  801bb4:	0f bd e8             	bsr    %eax,%ebp
  801bb7:	83 f5 1f             	xor    $0x1f,%ebp
  801bba:	0f 84 ac 00 00 00    	je     801c6c <__umoddi3+0x108>
  801bc0:	bf 20 00 00 00       	mov    $0x20,%edi
  801bc5:	29 ef                	sub    %ebp,%edi
  801bc7:	89 fe                	mov    %edi,%esi
  801bc9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bcd:	89 e9                	mov    %ebp,%ecx
  801bcf:	d3 e0                	shl    %cl,%eax
  801bd1:	89 d7                	mov    %edx,%edi
  801bd3:	89 f1                	mov    %esi,%ecx
  801bd5:	d3 ef                	shr    %cl,%edi
  801bd7:	09 c7                	or     %eax,%edi
  801bd9:	89 e9                	mov    %ebp,%ecx
  801bdb:	d3 e2                	shl    %cl,%edx
  801bdd:	89 14 24             	mov    %edx,(%esp)
  801be0:	89 d8                	mov    %ebx,%eax
  801be2:	d3 e0                	shl    %cl,%eax
  801be4:	89 c2                	mov    %eax,%edx
  801be6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bea:	d3 e0                	shl    %cl,%eax
  801bec:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bf0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bf4:	89 f1                	mov    %esi,%ecx
  801bf6:	d3 e8                	shr    %cl,%eax
  801bf8:	09 d0                	or     %edx,%eax
  801bfa:	d3 eb                	shr    %cl,%ebx
  801bfc:	89 da                	mov    %ebx,%edx
  801bfe:	f7 f7                	div    %edi
  801c00:	89 d3                	mov    %edx,%ebx
  801c02:	f7 24 24             	mull   (%esp)
  801c05:	89 c6                	mov    %eax,%esi
  801c07:	89 d1                	mov    %edx,%ecx
  801c09:	39 d3                	cmp    %edx,%ebx
  801c0b:	0f 82 87 00 00 00    	jb     801c98 <__umoddi3+0x134>
  801c11:	0f 84 91 00 00 00    	je     801ca8 <__umoddi3+0x144>
  801c17:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c1b:	29 f2                	sub    %esi,%edx
  801c1d:	19 cb                	sbb    %ecx,%ebx
  801c1f:	89 d8                	mov    %ebx,%eax
  801c21:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c25:	d3 e0                	shl    %cl,%eax
  801c27:	89 e9                	mov    %ebp,%ecx
  801c29:	d3 ea                	shr    %cl,%edx
  801c2b:	09 d0                	or     %edx,%eax
  801c2d:	89 e9                	mov    %ebp,%ecx
  801c2f:	d3 eb                	shr    %cl,%ebx
  801c31:	89 da                	mov    %ebx,%edx
  801c33:	83 c4 1c             	add    $0x1c,%esp
  801c36:	5b                   	pop    %ebx
  801c37:	5e                   	pop    %esi
  801c38:	5f                   	pop    %edi
  801c39:	5d                   	pop    %ebp
  801c3a:	c3                   	ret    
  801c3b:	90                   	nop
  801c3c:	89 fd                	mov    %edi,%ebp
  801c3e:	85 ff                	test   %edi,%edi
  801c40:	75 0b                	jne    801c4d <__umoddi3+0xe9>
  801c42:	b8 01 00 00 00       	mov    $0x1,%eax
  801c47:	31 d2                	xor    %edx,%edx
  801c49:	f7 f7                	div    %edi
  801c4b:	89 c5                	mov    %eax,%ebp
  801c4d:	89 f0                	mov    %esi,%eax
  801c4f:	31 d2                	xor    %edx,%edx
  801c51:	f7 f5                	div    %ebp
  801c53:	89 c8                	mov    %ecx,%eax
  801c55:	f7 f5                	div    %ebp
  801c57:	89 d0                	mov    %edx,%eax
  801c59:	e9 44 ff ff ff       	jmp    801ba2 <__umoddi3+0x3e>
  801c5e:	66 90                	xchg   %ax,%ax
  801c60:	89 c8                	mov    %ecx,%eax
  801c62:	89 f2                	mov    %esi,%edx
  801c64:	83 c4 1c             	add    $0x1c,%esp
  801c67:	5b                   	pop    %ebx
  801c68:	5e                   	pop    %esi
  801c69:	5f                   	pop    %edi
  801c6a:	5d                   	pop    %ebp
  801c6b:	c3                   	ret    
  801c6c:	3b 04 24             	cmp    (%esp),%eax
  801c6f:	72 06                	jb     801c77 <__umoddi3+0x113>
  801c71:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c75:	77 0f                	ja     801c86 <__umoddi3+0x122>
  801c77:	89 f2                	mov    %esi,%edx
  801c79:	29 f9                	sub    %edi,%ecx
  801c7b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c7f:	89 14 24             	mov    %edx,(%esp)
  801c82:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c86:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c8a:	8b 14 24             	mov    (%esp),%edx
  801c8d:	83 c4 1c             	add    $0x1c,%esp
  801c90:	5b                   	pop    %ebx
  801c91:	5e                   	pop    %esi
  801c92:	5f                   	pop    %edi
  801c93:	5d                   	pop    %ebp
  801c94:	c3                   	ret    
  801c95:	8d 76 00             	lea    0x0(%esi),%esi
  801c98:	2b 04 24             	sub    (%esp),%eax
  801c9b:	19 fa                	sbb    %edi,%edx
  801c9d:	89 d1                	mov    %edx,%ecx
  801c9f:	89 c6                	mov    %eax,%esi
  801ca1:	e9 71 ff ff ff       	jmp    801c17 <__umoddi3+0xb3>
  801ca6:	66 90                	xchg   %ax,%ax
  801ca8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801cac:	72 ea                	jb     801c98 <__umoddi3+0x134>
  801cae:	89 d9                	mov    %ebx,%ecx
  801cb0:	e9 62 ff ff ff       	jmp    801c17 <__umoddi3+0xb3>

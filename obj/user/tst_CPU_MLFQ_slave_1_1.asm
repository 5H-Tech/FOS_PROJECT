
obj/user/tst_CPU_MLFQ_slave_1_1:     file format elf32-i386


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
  800031:	e8 f0 00 00 00       	call   800126 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int ID;
	for (int i = 0; i < 3; ++i) {
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 5e                	jmp    8000a5 <_main+0x6d>
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800047:	a1 20 30 80 00       	mov    0x803020,%eax
  80004c:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800052:	a1 20 30 80 00       	mov    0x803020,%eax
  800057:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80005d:	89 c1                	mov    %eax,%ecx
  80005f:	a1 20 30 80 00       	mov    0x803020,%eax
  800064:	8b 40 74             	mov    0x74(%eax),%eax
  800067:	52                   	push   %edx
  800068:	51                   	push   %ecx
  800069:	50                   	push   %eax
  80006a:	68 20 1c 80 00       	push   $0x801c20
  80006f:	e8 e4 15 00 00       	call   801658 <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if (ID == E_ENV_CREATION_ERROR)
  80007a:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  80007e:	75 14                	jne    800094 <_main+0x5c>
			panic("RUNNING OUT OF ENV!! terminating...");
  800080:	83 ec 04             	sub    $0x4,%esp
  800083:	68 30 1c 80 00       	push   $0x801c30
  800088:	6a 09                	push   $0x9
  80008a:	68 54 1c 80 00       	push   $0x801c54
  80008f:	e8 d7 01 00 00       	call   80026b <_panic>
		sys_run_env(ID);
  800094:	83 ec 0c             	sub    $0xc,%esp
  800097:	ff 75 f0             	pushl  -0x10(%ebp)
  80009a:	e8 d7 15 00 00       	call   801676 <sys_run_env>
  80009f:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 3; ++i) {
  8000a2:	ff 45 f4             	incl   -0xc(%ebp)
  8000a5:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  8000a9:	7e 9c                	jle    800047 <_main+0xf>
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
		if (ID == E_ENV_CREATION_ERROR)
			panic("RUNNING OUT OF ENV!! terminating...");
		sys_run_env(ID);
	}
	env_sleep(50);
  8000ab:	83 ec 0c             	sub    $0xc,%esp
  8000ae:	6a 32                	push   $0x32
  8000b0:	e8 3f 18 00 00       	call   8018f4 <env_sleep>
  8000b5:	83 c4 10             	add    $0x10,%esp

	ID = sys_create_env("cpuMLFQ1Slave_2", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000bd:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c8:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000ce:	89 c1                	mov    %eax,%ecx
  8000d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d5:	8b 40 74             	mov    0x74(%eax),%eax
  8000d8:	52                   	push   %edx
  8000d9:	51                   	push   %ecx
  8000da:	50                   	push   %eax
  8000db:	68 72 1c 80 00       	push   $0x801c72
  8000e0:	e8 73 15 00 00       	call   801658 <sys_create_env>
  8000e5:	83 c4 10             	add    $0x10,%esp
  8000e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (ID == E_ENV_CREATION_ERROR)
  8000eb:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  8000ef:	75 14                	jne    800105 <_main+0xcd>
		panic("RUNNING OUT OF ENV!! terminating...");
  8000f1:	83 ec 04             	sub    $0x4,%esp
  8000f4:	68 30 1c 80 00       	push   $0x801c30
  8000f9:	6a 10                	push   $0x10
  8000fb:	68 54 1c 80 00       	push   $0x801c54
  800100:	e8 66 01 00 00       	call   80026b <_panic>
	sys_run_env(ID);
  800105:	83 ec 0c             	sub    $0xc,%esp
  800108:	ff 75 f0             	pushl  -0x10(%ebp)
  80010b:	e8 66 15 00 00       	call   801676 <sys_run_env>
  800110:	83 c4 10             	add    $0x10,%esp

	env_sleep(5000);
  800113:	83 ec 0c             	sub    $0xc,%esp
  800116:	68 88 13 00 00       	push   $0x1388
  80011b:	e8 d4 17 00 00       	call   8018f4 <env_sleep>
  800120:	83 c4 10             	add    $0x10,%esp

	return;
  800123:	90                   	nop
}
  800124:	c9                   	leave  
  800125:	c3                   	ret    

00800126 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800126:	55                   	push   %ebp
  800127:	89 e5                	mov    %esp,%ebp
  800129:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80012c:	e8 07 12 00 00       	call   801338 <sys_getenvindex>
  800131:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800134:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800137:	89 d0                	mov    %edx,%eax
  800139:	c1 e0 03             	shl    $0x3,%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800145:	01 c8                	add    %ecx,%eax
  800147:	01 c0                	add    %eax,%eax
  800149:	01 d0                	add    %edx,%eax
  80014b:	01 c0                	add    %eax,%eax
  80014d:	01 d0                	add    %edx,%eax
  80014f:	89 c2                	mov    %eax,%edx
  800151:	c1 e2 05             	shl    $0x5,%edx
  800154:	29 c2                	sub    %eax,%edx
  800156:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80015d:	89 c2                	mov    %eax,%edx
  80015f:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800165:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80016a:	a1 20 30 80 00       	mov    0x803020,%eax
  80016f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800175:	84 c0                	test   %al,%al
  800177:	74 0f                	je     800188 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800179:	a1 20 30 80 00       	mov    0x803020,%eax
  80017e:	05 40 3c 01 00       	add    $0x13c40,%eax
  800183:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800188:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80018c:	7e 0a                	jle    800198 <libmain+0x72>
		binaryname = argv[0];
  80018e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800191:	8b 00                	mov    (%eax),%eax
  800193:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800198:	83 ec 08             	sub    $0x8,%esp
  80019b:	ff 75 0c             	pushl  0xc(%ebp)
  80019e:	ff 75 08             	pushl  0x8(%ebp)
  8001a1:	e8 92 fe ff ff       	call   800038 <_main>
  8001a6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001a9:	e8 25 13 00 00       	call   8014d3 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001ae:	83 ec 0c             	sub    $0xc,%esp
  8001b1:	68 9c 1c 80 00       	push   $0x801c9c
  8001b6:	e8 52 03 00 00       	call   80050d <cprintf>
  8001bb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001be:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c3:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ce:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001d4:	83 ec 04             	sub    $0x4,%esp
  8001d7:	52                   	push   %edx
  8001d8:	50                   	push   %eax
  8001d9:	68 c4 1c 80 00       	push   $0x801cc4
  8001de:	e8 2a 03 00 00       	call   80050d <cprintf>
  8001e3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8001e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001eb:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8001f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f6:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8001fc:	83 ec 04             	sub    $0x4,%esp
  8001ff:	52                   	push   %edx
  800200:	50                   	push   %eax
  800201:	68 ec 1c 80 00       	push   $0x801cec
  800206:	e8 02 03 00 00       	call   80050d <cprintf>
  80020b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80020e:	a1 20 30 80 00       	mov    0x803020,%eax
  800213:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800219:	83 ec 08             	sub    $0x8,%esp
  80021c:	50                   	push   %eax
  80021d:	68 2d 1d 80 00       	push   $0x801d2d
  800222:	e8 e6 02 00 00       	call   80050d <cprintf>
  800227:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80022a:	83 ec 0c             	sub    $0xc,%esp
  80022d:	68 9c 1c 80 00       	push   $0x801c9c
  800232:	e8 d6 02 00 00       	call   80050d <cprintf>
  800237:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80023a:	e8 ae 12 00 00       	call   8014ed <sys_enable_interrupt>

	// exit gracefully
	exit();
  80023f:	e8 19 00 00 00       	call   80025d <exit>
}
  800244:	90                   	nop
  800245:	c9                   	leave  
  800246:	c3                   	ret    

00800247 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800247:	55                   	push   %ebp
  800248:	89 e5                	mov    %esp,%ebp
  80024a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80024d:	83 ec 0c             	sub    $0xc,%esp
  800250:	6a 00                	push   $0x0
  800252:	e8 ad 10 00 00       	call   801304 <sys_env_destroy>
  800257:	83 c4 10             	add    $0x10,%esp
}
  80025a:	90                   	nop
  80025b:	c9                   	leave  
  80025c:	c3                   	ret    

0080025d <exit>:

void
exit(void)
{
  80025d:	55                   	push   %ebp
  80025e:	89 e5                	mov    %esp,%ebp
  800260:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800263:	e8 02 11 00 00       	call   80136a <sys_env_exit>
}
  800268:	90                   	nop
  800269:	c9                   	leave  
  80026a:	c3                   	ret    

0080026b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80026b:	55                   	push   %ebp
  80026c:	89 e5                	mov    %esp,%ebp
  80026e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800271:	8d 45 10             	lea    0x10(%ebp),%eax
  800274:	83 c0 04             	add    $0x4,%eax
  800277:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80027a:	a1 18 31 80 00       	mov    0x803118,%eax
  80027f:	85 c0                	test   %eax,%eax
  800281:	74 16                	je     800299 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800283:	a1 18 31 80 00       	mov    0x803118,%eax
  800288:	83 ec 08             	sub    $0x8,%esp
  80028b:	50                   	push   %eax
  80028c:	68 44 1d 80 00       	push   $0x801d44
  800291:	e8 77 02 00 00       	call   80050d <cprintf>
  800296:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800299:	a1 00 30 80 00       	mov    0x803000,%eax
  80029e:	ff 75 0c             	pushl  0xc(%ebp)
  8002a1:	ff 75 08             	pushl  0x8(%ebp)
  8002a4:	50                   	push   %eax
  8002a5:	68 49 1d 80 00       	push   $0x801d49
  8002aa:	e8 5e 02 00 00       	call   80050d <cprintf>
  8002af:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b5:	83 ec 08             	sub    $0x8,%esp
  8002b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8002bb:	50                   	push   %eax
  8002bc:	e8 e1 01 00 00       	call   8004a2 <vcprintf>
  8002c1:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002c4:	83 ec 08             	sub    $0x8,%esp
  8002c7:	6a 00                	push   $0x0
  8002c9:	68 65 1d 80 00       	push   $0x801d65
  8002ce:	e8 cf 01 00 00       	call   8004a2 <vcprintf>
  8002d3:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002d6:	e8 82 ff ff ff       	call   80025d <exit>

	// should not return here
	while (1) ;
  8002db:	eb fe                	jmp    8002db <_panic+0x70>

008002dd <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002dd:	55                   	push   %ebp
  8002de:	89 e5                	mov    %esp,%ebp
  8002e0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e8:	8b 50 74             	mov    0x74(%eax),%edx
  8002eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ee:	39 c2                	cmp    %eax,%edx
  8002f0:	74 14                	je     800306 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002f2:	83 ec 04             	sub    $0x4,%esp
  8002f5:	68 68 1d 80 00       	push   $0x801d68
  8002fa:	6a 26                	push   $0x26
  8002fc:	68 b4 1d 80 00       	push   $0x801db4
  800301:	e8 65 ff ff ff       	call   80026b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800306:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80030d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800314:	e9 b6 00 00 00       	jmp    8003cf <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800319:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80031c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800323:	8b 45 08             	mov    0x8(%ebp),%eax
  800326:	01 d0                	add    %edx,%eax
  800328:	8b 00                	mov    (%eax),%eax
  80032a:	85 c0                	test   %eax,%eax
  80032c:	75 08                	jne    800336 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80032e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800331:	e9 96 00 00 00       	jmp    8003cc <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800336:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80033d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800344:	eb 5d                	jmp    8003a3 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800346:	a1 20 30 80 00       	mov    0x803020,%eax
  80034b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800351:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800354:	c1 e2 04             	shl    $0x4,%edx
  800357:	01 d0                	add    %edx,%eax
  800359:	8a 40 04             	mov    0x4(%eax),%al
  80035c:	84 c0                	test   %al,%al
  80035e:	75 40                	jne    8003a0 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800360:	a1 20 30 80 00       	mov    0x803020,%eax
  800365:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80036b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80036e:	c1 e2 04             	shl    $0x4,%edx
  800371:	01 d0                	add    %edx,%eax
  800373:	8b 00                	mov    (%eax),%eax
  800375:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800378:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80037b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800380:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800382:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800385:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80038c:	8b 45 08             	mov    0x8(%ebp),%eax
  80038f:	01 c8                	add    %ecx,%eax
  800391:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800393:	39 c2                	cmp    %eax,%edx
  800395:	75 09                	jne    8003a0 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800397:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80039e:	eb 12                	jmp    8003b2 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003a0:	ff 45 e8             	incl   -0x18(%ebp)
  8003a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a8:	8b 50 74             	mov    0x74(%eax),%edx
  8003ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003ae:	39 c2                	cmp    %eax,%edx
  8003b0:	77 94                	ja     800346 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003b2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003b6:	75 14                	jne    8003cc <CheckWSWithoutLastIndex+0xef>
			panic(
  8003b8:	83 ec 04             	sub    $0x4,%esp
  8003bb:	68 c0 1d 80 00       	push   $0x801dc0
  8003c0:	6a 3a                	push   $0x3a
  8003c2:	68 b4 1d 80 00       	push   $0x801db4
  8003c7:	e8 9f fe ff ff       	call   80026b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003cc:	ff 45 f0             	incl   -0x10(%ebp)
  8003cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003d2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003d5:	0f 8c 3e ff ff ff    	jl     800319 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003db:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003e2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003e9:	eb 20                	jmp    80040b <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003f6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003f9:	c1 e2 04             	shl    $0x4,%edx
  8003fc:	01 d0                	add    %edx,%eax
  8003fe:	8a 40 04             	mov    0x4(%eax),%al
  800401:	3c 01                	cmp    $0x1,%al
  800403:	75 03                	jne    800408 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800405:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800408:	ff 45 e0             	incl   -0x20(%ebp)
  80040b:	a1 20 30 80 00       	mov    0x803020,%eax
  800410:	8b 50 74             	mov    0x74(%eax),%edx
  800413:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800416:	39 c2                	cmp    %eax,%edx
  800418:	77 d1                	ja     8003eb <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80041a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80041d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800420:	74 14                	je     800436 <CheckWSWithoutLastIndex+0x159>
		panic(
  800422:	83 ec 04             	sub    $0x4,%esp
  800425:	68 14 1e 80 00       	push   $0x801e14
  80042a:	6a 44                	push   $0x44
  80042c:	68 b4 1d 80 00       	push   $0x801db4
  800431:	e8 35 fe ff ff       	call   80026b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800436:	90                   	nop
  800437:	c9                   	leave  
  800438:	c3                   	ret    

00800439 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800439:	55                   	push   %ebp
  80043a:	89 e5                	mov    %esp,%ebp
  80043c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80043f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800442:	8b 00                	mov    (%eax),%eax
  800444:	8d 48 01             	lea    0x1(%eax),%ecx
  800447:	8b 55 0c             	mov    0xc(%ebp),%edx
  80044a:	89 0a                	mov    %ecx,(%edx)
  80044c:	8b 55 08             	mov    0x8(%ebp),%edx
  80044f:	88 d1                	mov    %dl,%cl
  800451:	8b 55 0c             	mov    0xc(%ebp),%edx
  800454:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800458:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045b:	8b 00                	mov    (%eax),%eax
  80045d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800462:	75 2c                	jne    800490 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800464:	a0 24 30 80 00       	mov    0x803024,%al
  800469:	0f b6 c0             	movzbl %al,%eax
  80046c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80046f:	8b 12                	mov    (%edx),%edx
  800471:	89 d1                	mov    %edx,%ecx
  800473:	8b 55 0c             	mov    0xc(%ebp),%edx
  800476:	83 c2 08             	add    $0x8,%edx
  800479:	83 ec 04             	sub    $0x4,%esp
  80047c:	50                   	push   %eax
  80047d:	51                   	push   %ecx
  80047e:	52                   	push   %edx
  80047f:	e8 3e 0e 00 00       	call   8012c2 <sys_cputs>
  800484:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800487:	8b 45 0c             	mov    0xc(%ebp),%eax
  80048a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800490:	8b 45 0c             	mov    0xc(%ebp),%eax
  800493:	8b 40 04             	mov    0x4(%eax),%eax
  800496:	8d 50 01             	lea    0x1(%eax),%edx
  800499:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80049f:	90                   	nop
  8004a0:	c9                   	leave  
  8004a1:	c3                   	ret    

008004a2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004a2:	55                   	push   %ebp
  8004a3:	89 e5                	mov    %esp,%ebp
  8004a5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004ab:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004b2:	00 00 00 
	b.cnt = 0;
  8004b5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004bc:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004bf:	ff 75 0c             	pushl  0xc(%ebp)
  8004c2:	ff 75 08             	pushl  0x8(%ebp)
  8004c5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004cb:	50                   	push   %eax
  8004cc:	68 39 04 80 00       	push   $0x800439
  8004d1:	e8 11 02 00 00       	call   8006e7 <vprintfmt>
  8004d6:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004d9:	a0 24 30 80 00       	mov    0x803024,%al
  8004de:	0f b6 c0             	movzbl %al,%eax
  8004e1:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004e7:	83 ec 04             	sub    $0x4,%esp
  8004ea:	50                   	push   %eax
  8004eb:	52                   	push   %edx
  8004ec:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004f2:	83 c0 08             	add    $0x8,%eax
  8004f5:	50                   	push   %eax
  8004f6:	e8 c7 0d 00 00       	call   8012c2 <sys_cputs>
  8004fb:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004fe:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800505:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80050b:	c9                   	leave  
  80050c:	c3                   	ret    

0080050d <cprintf>:

int cprintf(const char *fmt, ...) {
  80050d:	55                   	push   %ebp
  80050e:	89 e5                	mov    %esp,%ebp
  800510:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800513:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80051a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80051d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800520:	8b 45 08             	mov    0x8(%ebp),%eax
  800523:	83 ec 08             	sub    $0x8,%esp
  800526:	ff 75 f4             	pushl  -0xc(%ebp)
  800529:	50                   	push   %eax
  80052a:	e8 73 ff ff ff       	call   8004a2 <vcprintf>
  80052f:	83 c4 10             	add    $0x10,%esp
  800532:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800535:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800538:	c9                   	leave  
  800539:	c3                   	ret    

0080053a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80053a:	55                   	push   %ebp
  80053b:	89 e5                	mov    %esp,%ebp
  80053d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800540:	e8 8e 0f 00 00       	call   8014d3 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800545:	8d 45 0c             	lea    0xc(%ebp),%eax
  800548:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80054b:	8b 45 08             	mov    0x8(%ebp),%eax
  80054e:	83 ec 08             	sub    $0x8,%esp
  800551:	ff 75 f4             	pushl  -0xc(%ebp)
  800554:	50                   	push   %eax
  800555:	e8 48 ff ff ff       	call   8004a2 <vcprintf>
  80055a:	83 c4 10             	add    $0x10,%esp
  80055d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800560:	e8 88 0f 00 00       	call   8014ed <sys_enable_interrupt>
	return cnt;
  800565:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800568:	c9                   	leave  
  800569:	c3                   	ret    

0080056a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80056a:	55                   	push   %ebp
  80056b:	89 e5                	mov    %esp,%ebp
  80056d:	53                   	push   %ebx
  80056e:	83 ec 14             	sub    $0x14,%esp
  800571:	8b 45 10             	mov    0x10(%ebp),%eax
  800574:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800577:	8b 45 14             	mov    0x14(%ebp),%eax
  80057a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80057d:	8b 45 18             	mov    0x18(%ebp),%eax
  800580:	ba 00 00 00 00       	mov    $0x0,%edx
  800585:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800588:	77 55                	ja     8005df <printnum+0x75>
  80058a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80058d:	72 05                	jb     800594 <printnum+0x2a>
  80058f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800592:	77 4b                	ja     8005df <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800594:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800597:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80059a:	8b 45 18             	mov    0x18(%ebp),%eax
  80059d:	ba 00 00 00 00       	mov    $0x0,%edx
  8005a2:	52                   	push   %edx
  8005a3:	50                   	push   %eax
  8005a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8005a7:	ff 75 f0             	pushl  -0x10(%ebp)
  8005aa:	e8 f9 13 00 00       	call   8019a8 <__udivdi3>
  8005af:	83 c4 10             	add    $0x10,%esp
  8005b2:	83 ec 04             	sub    $0x4,%esp
  8005b5:	ff 75 20             	pushl  0x20(%ebp)
  8005b8:	53                   	push   %ebx
  8005b9:	ff 75 18             	pushl  0x18(%ebp)
  8005bc:	52                   	push   %edx
  8005bd:	50                   	push   %eax
  8005be:	ff 75 0c             	pushl  0xc(%ebp)
  8005c1:	ff 75 08             	pushl  0x8(%ebp)
  8005c4:	e8 a1 ff ff ff       	call   80056a <printnum>
  8005c9:	83 c4 20             	add    $0x20,%esp
  8005cc:	eb 1a                	jmp    8005e8 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005ce:	83 ec 08             	sub    $0x8,%esp
  8005d1:	ff 75 0c             	pushl  0xc(%ebp)
  8005d4:	ff 75 20             	pushl  0x20(%ebp)
  8005d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005da:	ff d0                	call   *%eax
  8005dc:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005df:	ff 4d 1c             	decl   0x1c(%ebp)
  8005e2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005e6:	7f e6                	jg     8005ce <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005e8:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005eb:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005f6:	53                   	push   %ebx
  8005f7:	51                   	push   %ecx
  8005f8:	52                   	push   %edx
  8005f9:	50                   	push   %eax
  8005fa:	e8 b9 14 00 00       	call   801ab8 <__umoddi3>
  8005ff:	83 c4 10             	add    $0x10,%esp
  800602:	05 74 20 80 00       	add    $0x802074,%eax
  800607:	8a 00                	mov    (%eax),%al
  800609:	0f be c0             	movsbl %al,%eax
  80060c:	83 ec 08             	sub    $0x8,%esp
  80060f:	ff 75 0c             	pushl  0xc(%ebp)
  800612:	50                   	push   %eax
  800613:	8b 45 08             	mov    0x8(%ebp),%eax
  800616:	ff d0                	call   *%eax
  800618:	83 c4 10             	add    $0x10,%esp
}
  80061b:	90                   	nop
  80061c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80061f:	c9                   	leave  
  800620:	c3                   	ret    

00800621 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800621:	55                   	push   %ebp
  800622:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800624:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800628:	7e 1c                	jle    800646 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80062a:	8b 45 08             	mov    0x8(%ebp),%eax
  80062d:	8b 00                	mov    (%eax),%eax
  80062f:	8d 50 08             	lea    0x8(%eax),%edx
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	89 10                	mov    %edx,(%eax)
  800637:	8b 45 08             	mov    0x8(%ebp),%eax
  80063a:	8b 00                	mov    (%eax),%eax
  80063c:	83 e8 08             	sub    $0x8,%eax
  80063f:	8b 50 04             	mov    0x4(%eax),%edx
  800642:	8b 00                	mov    (%eax),%eax
  800644:	eb 40                	jmp    800686 <getuint+0x65>
	else if (lflag)
  800646:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80064a:	74 1e                	je     80066a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80064c:	8b 45 08             	mov    0x8(%ebp),%eax
  80064f:	8b 00                	mov    (%eax),%eax
  800651:	8d 50 04             	lea    0x4(%eax),%edx
  800654:	8b 45 08             	mov    0x8(%ebp),%eax
  800657:	89 10                	mov    %edx,(%eax)
  800659:	8b 45 08             	mov    0x8(%ebp),%eax
  80065c:	8b 00                	mov    (%eax),%eax
  80065e:	83 e8 04             	sub    $0x4,%eax
  800661:	8b 00                	mov    (%eax),%eax
  800663:	ba 00 00 00 00       	mov    $0x0,%edx
  800668:	eb 1c                	jmp    800686 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80066a:	8b 45 08             	mov    0x8(%ebp),%eax
  80066d:	8b 00                	mov    (%eax),%eax
  80066f:	8d 50 04             	lea    0x4(%eax),%edx
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	89 10                	mov    %edx,(%eax)
  800677:	8b 45 08             	mov    0x8(%ebp),%eax
  80067a:	8b 00                	mov    (%eax),%eax
  80067c:	83 e8 04             	sub    $0x4,%eax
  80067f:	8b 00                	mov    (%eax),%eax
  800681:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800686:	5d                   	pop    %ebp
  800687:	c3                   	ret    

00800688 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800688:	55                   	push   %ebp
  800689:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80068b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80068f:	7e 1c                	jle    8006ad <getint+0x25>
		return va_arg(*ap, long long);
  800691:	8b 45 08             	mov    0x8(%ebp),%eax
  800694:	8b 00                	mov    (%eax),%eax
  800696:	8d 50 08             	lea    0x8(%eax),%edx
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	89 10                	mov    %edx,(%eax)
  80069e:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a1:	8b 00                	mov    (%eax),%eax
  8006a3:	83 e8 08             	sub    $0x8,%eax
  8006a6:	8b 50 04             	mov    0x4(%eax),%edx
  8006a9:	8b 00                	mov    (%eax),%eax
  8006ab:	eb 38                	jmp    8006e5 <getint+0x5d>
	else if (lflag)
  8006ad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006b1:	74 1a                	je     8006cd <getint+0x45>
		return va_arg(*ap, long);
  8006b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b6:	8b 00                	mov    (%eax),%eax
  8006b8:	8d 50 04             	lea    0x4(%eax),%edx
  8006bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006be:	89 10                	mov    %edx,(%eax)
  8006c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	83 e8 04             	sub    $0x4,%eax
  8006c8:	8b 00                	mov    (%eax),%eax
  8006ca:	99                   	cltd   
  8006cb:	eb 18                	jmp    8006e5 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d0:	8b 00                	mov    (%eax),%eax
  8006d2:	8d 50 04             	lea    0x4(%eax),%edx
  8006d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d8:	89 10                	mov    %edx,(%eax)
  8006da:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dd:	8b 00                	mov    (%eax),%eax
  8006df:	83 e8 04             	sub    $0x4,%eax
  8006e2:	8b 00                	mov    (%eax),%eax
  8006e4:	99                   	cltd   
}
  8006e5:	5d                   	pop    %ebp
  8006e6:	c3                   	ret    

008006e7 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006e7:	55                   	push   %ebp
  8006e8:	89 e5                	mov    %esp,%ebp
  8006ea:	56                   	push   %esi
  8006eb:	53                   	push   %ebx
  8006ec:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006ef:	eb 17                	jmp    800708 <vprintfmt+0x21>
			if (ch == '\0')
  8006f1:	85 db                	test   %ebx,%ebx
  8006f3:	0f 84 af 03 00 00    	je     800aa8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006f9:	83 ec 08             	sub    $0x8,%esp
  8006fc:	ff 75 0c             	pushl  0xc(%ebp)
  8006ff:	53                   	push   %ebx
  800700:	8b 45 08             	mov    0x8(%ebp),%eax
  800703:	ff d0                	call   *%eax
  800705:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800708:	8b 45 10             	mov    0x10(%ebp),%eax
  80070b:	8d 50 01             	lea    0x1(%eax),%edx
  80070e:	89 55 10             	mov    %edx,0x10(%ebp)
  800711:	8a 00                	mov    (%eax),%al
  800713:	0f b6 d8             	movzbl %al,%ebx
  800716:	83 fb 25             	cmp    $0x25,%ebx
  800719:	75 d6                	jne    8006f1 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80071b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80071f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800726:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80072d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800734:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80073b:	8b 45 10             	mov    0x10(%ebp),%eax
  80073e:	8d 50 01             	lea    0x1(%eax),%edx
  800741:	89 55 10             	mov    %edx,0x10(%ebp)
  800744:	8a 00                	mov    (%eax),%al
  800746:	0f b6 d8             	movzbl %al,%ebx
  800749:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80074c:	83 f8 55             	cmp    $0x55,%eax
  80074f:	0f 87 2b 03 00 00    	ja     800a80 <vprintfmt+0x399>
  800755:	8b 04 85 98 20 80 00 	mov    0x802098(,%eax,4),%eax
  80075c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80075e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800762:	eb d7                	jmp    80073b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800764:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800768:	eb d1                	jmp    80073b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80076a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800771:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800774:	89 d0                	mov    %edx,%eax
  800776:	c1 e0 02             	shl    $0x2,%eax
  800779:	01 d0                	add    %edx,%eax
  80077b:	01 c0                	add    %eax,%eax
  80077d:	01 d8                	add    %ebx,%eax
  80077f:	83 e8 30             	sub    $0x30,%eax
  800782:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800785:	8b 45 10             	mov    0x10(%ebp),%eax
  800788:	8a 00                	mov    (%eax),%al
  80078a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80078d:	83 fb 2f             	cmp    $0x2f,%ebx
  800790:	7e 3e                	jle    8007d0 <vprintfmt+0xe9>
  800792:	83 fb 39             	cmp    $0x39,%ebx
  800795:	7f 39                	jg     8007d0 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800797:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80079a:	eb d5                	jmp    800771 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80079c:	8b 45 14             	mov    0x14(%ebp),%eax
  80079f:	83 c0 04             	add    $0x4,%eax
  8007a2:	89 45 14             	mov    %eax,0x14(%ebp)
  8007a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a8:	83 e8 04             	sub    $0x4,%eax
  8007ab:	8b 00                	mov    (%eax),%eax
  8007ad:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007b0:	eb 1f                	jmp    8007d1 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007b2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007b6:	79 83                	jns    80073b <vprintfmt+0x54>
				width = 0;
  8007b8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007bf:	e9 77 ff ff ff       	jmp    80073b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007c4:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007cb:	e9 6b ff ff ff       	jmp    80073b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007d0:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007d1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d5:	0f 89 60 ff ff ff    	jns    80073b <vprintfmt+0x54>
				width = precision, precision = -1;
  8007db:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007e1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007e8:	e9 4e ff ff ff       	jmp    80073b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007ed:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007f0:	e9 46 ff ff ff       	jmp    80073b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f8:	83 c0 04             	add    $0x4,%eax
  8007fb:	89 45 14             	mov    %eax,0x14(%ebp)
  8007fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800801:	83 e8 04             	sub    $0x4,%eax
  800804:	8b 00                	mov    (%eax),%eax
  800806:	83 ec 08             	sub    $0x8,%esp
  800809:	ff 75 0c             	pushl  0xc(%ebp)
  80080c:	50                   	push   %eax
  80080d:	8b 45 08             	mov    0x8(%ebp),%eax
  800810:	ff d0                	call   *%eax
  800812:	83 c4 10             	add    $0x10,%esp
			break;
  800815:	e9 89 02 00 00       	jmp    800aa3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80081a:	8b 45 14             	mov    0x14(%ebp),%eax
  80081d:	83 c0 04             	add    $0x4,%eax
  800820:	89 45 14             	mov    %eax,0x14(%ebp)
  800823:	8b 45 14             	mov    0x14(%ebp),%eax
  800826:	83 e8 04             	sub    $0x4,%eax
  800829:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80082b:	85 db                	test   %ebx,%ebx
  80082d:	79 02                	jns    800831 <vprintfmt+0x14a>
				err = -err;
  80082f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800831:	83 fb 64             	cmp    $0x64,%ebx
  800834:	7f 0b                	jg     800841 <vprintfmt+0x15a>
  800836:	8b 34 9d e0 1e 80 00 	mov    0x801ee0(,%ebx,4),%esi
  80083d:	85 f6                	test   %esi,%esi
  80083f:	75 19                	jne    80085a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800841:	53                   	push   %ebx
  800842:	68 85 20 80 00       	push   $0x802085
  800847:	ff 75 0c             	pushl  0xc(%ebp)
  80084a:	ff 75 08             	pushl  0x8(%ebp)
  80084d:	e8 5e 02 00 00       	call   800ab0 <printfmt>
  800852:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800855:	e9 49 02 00 00       	jmp    800aa3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80085a:	56                   	push   %esi
  80085b:	68 8e 20 80 00       	push   $0x80208e
  800860:	ff 75 0c             	pushl  0xc(%ebp)
  800863:	ff 75 08             	pushl  0x8(%ebp)
  800866:	e8 45 02 00 00       	call   800ab0 <printfmt>
  80086b:	83 c4 10             	add    $0x10,%esp
			break;
  80086e:	e9 30 02 00 00       	jmp    800aa3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800873:	8b 45 14             	mov    0x14(%ebp),%eax
  800876:	83 c0 04             	add    $0x4,%eax
  800879:	89 45 14             	mov    %eax,0x14(%ebp)
  80087c:	8b 45 14             	mov    0x14(%ebp),%eax
  80087f:	83 e8 04             	sub    $0x4,%eax
  800882:	8b 30                	mov    (%eax),%esi
  800884:	85 f6                	test   %esi,%esi
  800886:	75 05                	jne    80088d <vprintfmt+0x1a6>
				p = "(null)";
  800888:	be 91 20 80 00       	mov    $0x802091,%esi
			if (width > 0 && padc != '-')
  80088d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800891:	7e 6d                	jle    800900 <vprintfmt+0x219>
  800893:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800897:	74 67                	je     800900 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800899:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80089c:	83 ec 08             	sub    $0x8,%esp
  80089f:	50                   	push   %eax
  8008a0:	56                   	push   %esi
  8008a1:	e8 0c 03 00 00       	call   800bb2 <strnlen>
  8008a6:	83 c4 10             	add    $0x10,%esp
  8008a9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008ac:	eb 16                	jmp    8008c4 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008ae:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008b2:	83 ec 08             	sub    $0x8,%esp
  8008b5:	ff 75 0c             	pushl  0xc(%ebp)
  8008b8:	50                   	push   %eax
  8008b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bc:	ff d0                	call   *%eax
  8008be:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008c1:	ff 4d e4             	decl   -0x1c(%ebp)
  8008c4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008c8:	7f e4                	jg     8008ae <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008ca:	eb 34                	jmp    800900 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008cc:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008d0:	74 1c                	je     8008ee <vprintfmt+0x207>
  8008d2:	83 fb 1f             	cmp    $0x1f,%ebx
  8008d5:	7e 05                	jle    8008dc <vprintfmt+0x1f5>
  8008d7:	83 fb 7e             	cmp    $0x7e,%ebx
  8008da:	7e 12                	jle    8008ee <vprintfmt+0x207>
					putch('?', putdat);
  8008dc:	83 ec 08             	sub    $0x8,%esp
  8008df:	ff 75 0c             	pushl  0xc(%ebp)
  8008e2:	6a 3f                	push   $0x3f
  8008e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e7:	ff d0                	call   *%eax
  8008e9:	83 c4 10             	add    $0x10,%esp
  8008ec:	eb 0f                	jmp    8008fd <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008ee:	83 ec 08             	sub    $0x8,%esp
  8008f1:	ff 75 0c             	pushl  0xc(%ebp)
  8008f4:	53                   	push   %ebx
  8008f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f8:	ff d0                	call   *%eax
  8008fa:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008fd:	ff 4d e4             	decl   -0x1c(%ebp)
  800900:	89 f0                	mov    %esi,%eax
  800902:	8d 70 01             	lea    0x1(%eax),%esi
  800905:	8a 00                	mov    (%eax),%al
  800907:	0f be d8             	movsbl %al,%ebx
  80090a:	85 db                	test   %ebx,%ebx
  80090c:	74 24                	je     800932 <vprintfmt+0x24b>
  80090e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800912:	78 b8                	js     8008cc <vprintfmt+0x1e5>
  800914:	ff 4d e0             	decl   -0x20(%ebp)
  800917:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80091b:	79 af                	jns    8008cc <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80091d:	eb 13                	jmp    800932 <vprintfmt+0x24b>
				putch(' ', putdat);
  80091f:	83 ec 08             	sub    $0x8,%esp
  800922:	ff 75 0c             	pushl  0xc(%ebp)
  800925:	6a 20                	push   $0x20
  800927:	8b 45 08             	mov    0x8(%ebp),%eax
  80092a:	ff d0                	call   *%eax
  80092c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80092f:	ff 4d e4             	decl   -0x1c(%ebp)
  800932:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800936:	7f e7                	jg     80091f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800938:	e9 66 01 00 00       	jmp    800aa3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80093d:	83 ec 08             	sub    $0x8,%esp
  800940:	ff 75 e8             	pushl  -0x18(%ebp)
  800943:	8d 45 14             	lea    0x14(%ebp),%eax
  800946:	50                   	push   %eax
  800947:	e8 3c fd ff ff       	call   800688 <getint>
  80094c:	83 c4 10             	add    $0x10,%esp
  80094f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800952:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800955:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800958:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80095b:	85 d2                	test   %edx,%edx
  80095d:	79 23                	jns    800982 <vprintfmt+0x29b>
				putch('-', putdat);
  80095f:	83 ec 08             	sub    $0x8,%esp
  800962:	ff 75 0c             	pushl  0xc(%ebp)
  800965:	6a 2d                	push   $0x2d
  800967:	8b 45 08             	mov    0x8(%ebp),%eax
  80096a:	ff d0                	call   *%eax
  80096c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80096f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800972:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800975:	f7 d8                	neg    %eax
  800977:	83 d2 00             	adc    $0x0,%edx
  80097a:	f7 da                	neg    %edx
  80097c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80097f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800982:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800989:	e9 bc 00 00 00       	jmp    800a4a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80098e:	83 ec 08             	sub    $0x8,%esp
  800991:	ff 75 e8             	pushl  -0x18(%ebp)
  800994:	8d 45 14             	lea    0x14(%ebp),%eax
  800997:	50                   	push   %eax
  800998:	e8 84 fc ff ff       	call   800621 <getuint>
  80099d:	83 c4 10             	add    $0x10,%esp
  8009a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009a3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009a6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009ad:	e9 98 00 00 00       	jmp    800a4a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
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
			putch('X', putdat);
  8009d2:	83 ec 08             	sub    $0x8,%esp
  8009d5:	ff 75 0c             	pushl  0xc(%ebp)
  8009d8:	6a 58                	push   $0x58
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	ff d0                	call   *%eax
  8009df:	83 c4 10             	add    $0x10,%esp
			break;
  8009e2:	e9 bc 00 00 00       	jmp    800aa3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009e7:	83 ec 08             	sub    $0x8,%esp
  8009ea:	ff 75 0c             	pushl  0xc(%ebp)
  8009ed:	6a 30                	push   $0x30
  8009ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f2:	ff d0                	call   *%eax
  8009f4:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009f7:	83 ec 08             	sub    $0x8,%esp
  8009fa:	ff 75 0c             	pushl  0xc(%ebp)
  8009fd:	6a 78                	push   $0x78
  8009ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800a02:	ff d0                	call   *%eax
  800a04:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a07:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0a:	83 c0 04             	add    $0x4,%eax
  800a0d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a10:	8b 45 14             	mov    0x14(%ebp),%eax
  800a13:	83 e8 04             	sub    $0x4,%eax
  800a16:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a1b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a22:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a29:	eb 1f                	jmp    800a4a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a2b:	83 ec 08             	sub    $0x8,%esp
  800a2e:	ff 75 e8             	pushl  -0x18(%ebp)
  800a31:	8d 45 14             	lea    0x14(%ebp),%eax
  800a34:	50                   	push   %eax
  800a35:	e8 e7 fb ff ff       	call   800621 <getuint>
  800a3a:	83 c4 10             	add    $0x10,%esp
  800a3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a40:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a43:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a4a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a51:	83 ec 04             	sub    $0x4,%esp
  800a54:	52                   	push   %edx
  800a55:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a58:	50                   	push   %eax
  800a59:	ff 75 f4             	pushl  -0xc(%ebp)
  800a5c:	ff 75 f0             	pushl  -0x10(%ebp)
  800a5f:	ff 75 0c             	pushl  0xc(%ebp)
  800a62:	ff 75 08             	pushl  0x8(%ebp)
  800a65:	e8 00 fb ff ff       	call   80056a <printnum>
  800a6a:	83 c4 20             	add    $0x20,%esp
			break;
  800a6d:	eb 34                	jmp    800aa3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a6f:	83 ec 08             	sub    $0x8,%esp
  800a72:	ff 75 0c             	pushl  0xc(%ebp)
  800a75:	53                   	push   %ebx
  800a76:	8b 45 08             	mov    0x8(%ebp),%eax
  800a79:	ff d0                	call   *%eax
  800a7b:	83 c4 10             	add    $0x10,%esp
			break;
  800a7e:	eb 23                	jmp    800aa3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a80:	83 ec 08             	sub    $0x8,%esp
  800a83:	ff 75 0c             	pushl  0xc(%ebp)
  800a86:	6a 25                	push   $0x25
  800a88:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8b:	ff d0                	call   *%eax
  800a8d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a90:	ff 4d 10             	decl   0x10(%ebp)
  800a93:	eb 03                	jmp    800a98 <vprintfmt+0x3b1>
  800a95:	ff 4d 10             	decl   0x10(%ebp)
  800a98:	8b 45 10             	mov    0x10(%ebp),%eax
  800a9b:	48                   	dec    %eax
  800a9c:	8a 00                	mov    (%eax),%al
  800a9e:	3c 25                	cmp    $0x25,%al
  800aa0:	75 f3                	jne    800a95 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800aa2:	90                   	nop
		}
	}
  800aa3:	e9 47 fc ff ff       	jmp    8006ef <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800aa8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800aa9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800aac:	5b                   	pop    %ebx
  800aad:	5e                   	pop    %esi
  800aae:	5d                   	pop    %ebp
  800aaf:	c3                   	ret    

00800ab0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ab0:	55                   	push   %ebp
  800ab1:	89 e5                	mov    %esp,%ebp
  800ab3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ab6:	8d 45 10             	lea    0x10(%ebp),%eax
  800ab9:	83 c0 04             	add    $0x4,%eax
  800abc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800abf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac5:	50                   	push   %eax
  800ac6:	ff 75 0c             	pushl  0xc(%ebp)
  800ac9:	ff 75 08             	pushl  0x8(%ebp)
  800acc:	e8 16 fc ff ff       	call   8006e7 <vprintfmt>
  800ad1:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ad4:	90                   	nop
  800ad5:	c9                   	leave  
  800ad6:	c3                   	ret    

00800ad7 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ad7:	55                   	push   %ebp
  800ad8:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ada:	8b 45 0c             	mov    0xc(%ebp),%eax
  800add:	8b 40 08             	mov    0x8(%eax),%eax
  800ae0:	8d 50 01             	lea    0x1(%eax),%edx
  800ae3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae6:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aec:	8b 10                	mov    (%eax),%edx
  800aee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af1:	8b 40 04             	mov    0x4(%eax),%eax
  800af4:	39 c2                	cmp    %eax,%edx
  800af6:	73 12                	jae    800b0a <sprintputch+0x33>
		*b->buf++ = ch;
  800af8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afb:	8b 00                	mov    (%eax),%eax
  800afd:	8d 48 01             	lea    0x1(%eax),%ecx
  800b00:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b03:	89 0a                	mov    %ecx,(%edx)
  800b05:	8b 55 08             	mov    0x8(%ebp),%edx
  800b08:	88 10                	mov    %dl,(%eax)
}
  800b0a:	90                   	nop
  800b0b:	5d                   	pop    %ebp
  800b0c:	c3                   	ret    

00800b0d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b0d:	55                   	push   %ebp
  800b0e:	89 e5                	mov    %esp,%ebp
  800b10:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
  800b16:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	01 d0                	add    %edx,%eax
  800b24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b2e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b32:	74 06                	je     800b3a <vsnprintf+0x2d>
  800b34:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b38:	7f 07                	jg     800b41 <vsnprintf+0x34>
		return -E_INVAL;
  800b3a:	b8 03 00 00 00       	mov    $0x3,%eax
  800b3f:	eb 20                	jmp    800b61 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b41:	ff 75 14             	pushl  0x14(%ebp)
  800b44:	ff 75 10             	pushl  0x10(%ebp)
  800b47:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b4a:	50                   	push   %eax
  800b4b:	68 d7 0a 80 00       	push   $0x800ad7
  800b50:	e8 92 fb ff ff       	call   8006e7 <vprintfmt>
  800b55:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b58:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b5b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b61:	c9                   	leave  
  800b62:	c3                   	ret    

00800b63 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b63:	55                   	push   %ebp
  800b64:	89 e5                	mov    %esp,%ebp
  800b66:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b69:	8d 45 10             	lea    0x10(%ebp),%eax
  800b6c:	83 c0 04             	add    $0x4,%eax
  800b6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b72:	8b 45 10             	mov    0x10(%ebp),%eax
  800b75:	ff 75 f4             	pushl  -0xc(%ebp)
  800b78:	50                   	push   %eax
  800b79:	ff 75 0c             	pushl  0xc(%ebp)
  800b7c:	ff 75 08             	pushl  0x8(%ebp)
  800b7f:	e8 89 ff ff ff       	call   800b0d <vsnprintf>
  800b84:	83 c4 10             	add    $0x10,%esp
  800b87:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b8d:	c9                   	leave  
  800b8e:	c3                   	ret    

00800b8f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b8f:	55                   	push   %ebp
  800b90:	89 e5                	mov    %esp,%ebp
  800b92:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b95:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b9c:	eb 06                	jmp    800ba4 <strlen+0x15>
		n++;
  800b9e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ba1:	ff 45 08             	incl   0x8(%ebp)
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	8a 00                	mov    (%eax),%al
  800ba9:	84 c0                	test   %al,%al
  800bab:	75 f1                	jne    800b9e <strlen+0xf>
		n++;
	return n;
  800bad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bb0:	c9                   	leave  
  800bb1:	c3                   	ret    

00800bb2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bb2:	55                   	push   %ebp
  800bb3:	89 e5                	mov    %esp,%ebp
  800bb5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bb8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bbf:	eb 09                	jmp    800bca <strnlen+0x18>
		n++;
  800bc1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bc4:	ff 45 08             	incl   0x8(%ebp)
  800bc7:	ff 4d 0c             	decl   0xc(%ebp)
  800bca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bce:	74 09                	je     800bd9 <strnlen+0x27>
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	8a 00                	mov    (%eax),%al
  800bd5:	84 c0                	test   %al,%al
  800bd7:	75 e8                	jne    800bc1 <strnlen+0xf>
		n++;
	return n;
  800bd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bdc:	c9                   	leave  
  800bdd:	c3                   	ret    

00800bde <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bde:	55                   	push   %ebp
  800bdf:	89 e5                	mov    %esp,%ebp
  800be1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bea:	90                   	nop
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	8d 50 01             	lea    0x1(%eax),%edx
  800bf1:	89 55 08             	mov    %edx,0x8(%ebp)
  800bf4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bfa:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bfd:	8a 12                	mov    (%edx),%dl
  800bff:	88 10                	mov    %dl,(%eax)
  800c01:	8a 00                	mov    (%eax),%al
  800c03:	84 c0                	test   %al,%al
  800c05:	75 e4                	jne    800beb <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c07:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c0a:	c9                   	leave  
  800c0b:	c3                   	ret    

00800c0c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c0c:	55                   	push   %ebp
  800c0d:	89 e5                	mov    %esp,%ebp
  800c0f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c18:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c1f:	eb 1f                	jmp    800c40 <strncpy+0x34>
		*dst++ = *src;
  800c21:	8b 45 08             	mov    0x8(%ebp),%eax
  800c24:	8d 50 01             	lea    0x1(%eax),%edx
  800c27:	89 55 08             	mov    %edx,0x8(%ebp)
  800c2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c2d:	8a 12                	mov    (%edx),%dl
  800c2f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c34:	8a 00                	mov    (%eax),%al
  800c36:	84 c0                	test   %al,%al
  800c38:	74 03                	je     800c3d <strncpy+0x31>
			src++;
  800c3a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c3d:	ff 45 fc             	incl   -0x4(%ebp)
  800c40:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c43:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c46:	72 d9                	jb     800c21 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c48:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c4b:	c9                   	leave  
  800c4c:	c3                   	ret    

00800c4d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c4d:	55                   	push   %ebp
  800c4e:	89 e5                	mov    %esp,%ebp
  800c50:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c59:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c5d:	74 30                	je     800c8f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c5f:	eb 16                	jmp    800c77 <strlcpy+0x2a>
			*dst++ = *src++;
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	8d 50 01             	lea    0x1(%eax),%edx
  800c67:	89 55 08             	mov    %edx,0x8(%ebp)
  800c6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c6d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c70:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c73:	8a 12                	mov    (%edx),%dl
  800c75:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c77:	ff 4d 10             	decl   0x10(%ebp)
  800c7a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7e:	74 09                	je     800c89 <strlcpy+0x3c>
  800c80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c83:	8a 00                	mov    (%eax),%al
  800c85:	84 c0                	test   %al,%al
  800c87:	75 d8                	jne    800c61 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c8f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c92:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c95:	29 c2                	sub    %eax,%edx
  800c97:	89 d0                	mov    %edx,%eax
}
  800c99:	c9                   	leave  
  800c9a:	c3                   	ret    

00800c9b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c9b:	55                   	push   %ebp
  800c9c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c9e:	eb 06                	jmp    800ca6 <strcmp+0xb>
		p++, q++;
  800ca0:	ff 45 08             	incl   0x8(%ebp)
  800ca3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	8a 00                	mov    (%eax),%al
  800cab:	84 c0                	test   %al,%al
  800cad:	74 0e                	je     800cbd <strcmp+0x22>
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8a 10                	mov    (%eax),%dl
  800cb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb7:	8a 00                	mov    (%eax),%al
  800cb9:	38 c2                	cmp    %al,%dl
  800cbb:	74 e3                	je     800ca0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	8a 00                	mov    (%eax),%al
  800cc2:	0f b6 d0             	movzbl %al,%edx
  800cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc8:	8a 00                	mov    (%eax),%al
  800cca:	0f b6 c0             	movzbl %al,%eax
  800ccd:	29 c2                	sub    %eax,%edx
  800ccf:	89 d0                	mov    %edx,%eax
}
  800cd1:	5d                   	pop    %ebp
  800cd2:	c3                   	ret    

00800cd3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cd3:	55                   	push   %ebp
  800cd4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cd6:	eb 09                	jmp    800ce1 <strncmp+0xe>
		n--, p++, q++;
  800cd8:	ff 4d 10             	decl   0x10(%ebp)
  800cdb:	ff 45 08             	incl   0x8(%ebp)
  800cde:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ce1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce5:	74 17                	je     800cfe <strncmp+0x2b>
  800ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cea:	8a 00                	mov    (%eax),%al
  800cec:	84 c0                	test   %al,%al
  800cee:	74 0e                	je     800cfe <strncmp+0x2b>
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	8a 10                	mov    (%eax),%dl
  800cf5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf8:	8a 00                	mov    (%eax),%al
  800cfa:	38 c2                	cmp    %al,%dl
  800cfc:	74 da                	je     800cd8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cfe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d02:	75 07                	jne    800d0b <strncmp+0x38>
		return 0;
  800d04:	b8 00 00 00 00       	mov    $0x0,%eax
  800d09:	eb 14                	jmp    800d1f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8a 00                	mov    (%eax),%al
  800d10:	0f b6 d0             	movzbl %al,%edx
  800d13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	0f b6 c0             	movzbl %al,%eax
  800d1b:	29 c2                	sub    %eax,%edx
  800d1d:	89 d0                	mov    %edx,%eax
}
  800d1f:	5d                   	pop    %ebp
  800d20:	c3                   	ret    

00800d21 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d21:	55                   	push   %ebp
  800d22:	89 e5                	mov    %esp,%ebp
  800d24:	83 ec 04             	sub    $0x4,%esp
  800d27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d2d:	eb 12                	jmp    800d41 <strchr+0x20>
		if (*s == c)
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8a 00                	mov    (%eax),%al
  800d34:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d37:	75 05                	jne    800d3e <strchr+0x1d>
			return (char *) s;
  800d39:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3c:	eb 11                	jmp    800d4f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d3e:	ff 45 08             	incl   0x8(%ebp)
  800d41:	8b 45 08             	mov    0x8(%ebp),%eax
  800d44:	8a 00                	mov    (%eax),%al
  800d46:	84 c0                	test   %al,%al
  800d48:	75 e5                	jne    800d2f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d4a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d4f:	c9                   	leave  
  800d50:	c3                   	ret    

00800d51 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d51:	55                   	push   %ebp
  800d52:	89 e5                	mov    %esp,%ebp
  800d54:	83 ec 04             	sub    $0x4,%esp
  800d57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d5d:	eb 0d                	jmp    800d6c <strfind+0x1b>
		if (*s == c)
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d67:	74 0e                	je     800d77 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d69:	ff 45 08             	incl   0x8(%ebp)
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	8a 00                	mov    (%eax),%al
  800d71:	84 c0                	test   %al,%al
  800d73:	75 ea                	jne    800d5f <strfind+0xe>
  800d75:	eb 01                	jmp    800d78 <strfind+0x27>
		if (*s == c)
			break;
  800d77:	90                   	nop
	return (char *) s;
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d7b:	c9                   	leave  
  800d7c:	c3                   	ret    

00800d7d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d7d:	55                   	push   %ebp
  800d7e:	89 e5                	mov    %esp,%ebp
  800d80:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d89:	8b 45 10             	mov    0x10(%ebp),%eax
  800d8c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d8f:	eb 0e                	jmp    800d9f <memset+0x22>
		*p++ = c;
  800d91:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d94:	8d 50 01             	lea    0x1(%eax),%edx
  800d97:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d9d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d9f:	ff 4d f8             	decl   -0x8(%ebp)
  800da2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800da6:	79 e9                	jns    800d91 <memset+0x14>
		*p++ = c;

	return v;
  800da8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dab:	c9                   	leave  
  800dac:	c3                   	ret    

00800dad <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dad:	55                   	push   %ebp
  800dae:	89 e5                	mov    %esp,%ebp
  800db0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800db3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800db9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800dbf:	eb 16                	jmp    800dd7 <memcpy+0x2a>
		*d++ = *s++;
  800dc1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc4:	8d 50 01             	lea    0x1(%eax),%edx
  800dc7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dcd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dd3:	8a 12                	mov    (%edx),%dl
  800dd5:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dd7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dda:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ddd:	89 55 10             	mov    %edx,0x10(%ebp)
  800de0:	85 c0                	test   %eax,%eax
  800de2:	75 dd                	jne    800dc1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800de4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800de7:	c9                   	leave  
  800de8:	c3                   	ret    

00800de9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800de9:	55                   	push   %ebp
  800dea:	89 e5                	mov    %esp,%ebp
  800dec:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800def:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800df5:	8b 45 08             	mov    0x8(%ebp),%eax
  800df8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dfb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dfe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e01:	73 50                	jae    800e53 <memmove+0x6a>
  800e03:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e06:	8b 45 10             	mov    0x10(%ebp),%eax
  800e09:	01 d0                	add    %edx,%eax
  800e0b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e0e:	76 43                	jbe    800e53 <memmove+0x6a>
		s += n;
  800e10:	8b 45 10             	mov    0x10(%ebp),%eax
  800e13:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e16:	8b 45 10             	mov    0x10(%ebp),%eax
  800e19:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e1c:	eb 10                	jmp    800e2e <memmove+0x45>
			*--d = *--s;
  800e1e:	ff 4d f8             	decl   -0x8(%ebp)
  800e21:	ff 4d fc             	decl   -0x4(%ebp)
  800e24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e27:	8a 10                	mov    (%eax),%dl
  800e29:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e31:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e34:	89 55 10             	mov    %edx,0x10(%ebp)
  800e37:	85 c0                	test   %eax,%eax
  800e39:	75 e3                	jne    800e1e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e3b:	eb 23                	jmp    800e60 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e3d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e40:	8d 50 01             	lea    0x1(%eax),%edx
  800e43:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e46:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e49:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e4c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e4f:	8a 12                	mov    (%edx),%dl
  800e51:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e53:	8b 45 10             	mov    0x10(%ebp),%eax
  800e56:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e59:	89 55 10             	mov    %edx,0x10(%ebp)
  800e5c:	85 c0                	test   %eax,%eax
  800e5e:	75 dd                	jne    800e3d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e63:	c9                   	leave  
  800e64:	c3                   	ret    

00800e65 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e65:	55                   	push   %ebp
  800e66:	89 e5                	mov    %esp,%ebp
  800e68:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e74:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e77:	eb 2a                	jmp    800ea3 <memcmp+0x3e>
		if (*s1 != *s2)
  800e79:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7c:	8a 10                	mov    (%eax),%dl
  800e7e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e81:	8a 00                	mov    (%eax),%al
  800e83:	38 c2                	cmp    %al,%dl
  800e85:	74 16                	je     800e9d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e8a:	8a 00                	mov    (%eax),%al
  800e8c:	0f b6 d0             	movzbl %al,%edx
  800e8f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e92:	8a 00                	mov    (%eax),%al
  800e94:	0f b6 c0             	movzbl %al,%eax
  800e97:	29 c2                	sub    %eax,%edx
  800e99:	89 d0                	mov    %edx,%eax
  800e9b:	eb 18                	jmp    800eb5 <memcmp+0x50>
		s1++, s2++;
  800e9d:	ff 45 fc             	incl   -0x4(%ebp)
  800ea0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ea3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea9:	89 55 10             	mov    %edx,0x10(%ebp)
  800eac:	85 c0                	test   %eax,%eax
  800eae:	75 c9                	jne    800e79 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800eb0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eb5:	c9                   	leave  
  800eb6:	c3                   	ret    

00800eb7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800eb7:	55                   	push   %ebp
  800eb8:	89 e5                	mov    %esp,%ebp
  800eba:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ebd:	8b 55 08             	mov    0x8(%ebp),%edx
  800ec0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec3:	01 d0                	add    %edx,%eax
  800ec5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ec8:	eb 15                	jmp    800edf <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800eca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecd:	8a 00                	mov    (%eax),%al
  800ecf:	0f b6 d0             	movzbl %al,%edx
  800ed2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed5:	0f b6 c0             	movzbl %al,%eax
  800ed8:	39 c2                	cmp    %eax,%edx
  800eda:	74 0d                	je     800ee9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800edc:	ff 45 08             	incl   0x8(%ebp)
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ee5:	72 e3                	jb     800eca <memfind+0x13>
  800ee7:	eb 01                	jmp    800eea <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ee9:	90                   	nop
	return (void *) s;
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eed:	c9                   	leave  
  800eee:	c3                   	ret    

00800eef <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eef:	55                   	push   %ebp
  800ef0:	89 e5                	mov    %esp,%ebp
  800ef2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ef5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800efc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f03:	eb 03                	jmp    800f08 <strtol+0x19>
		s++;
  800f05:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f08:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0b:	8a 00                	mov    (%eax),%al
  800f0d:	3c 20                	cmp    $0x20,%al
  800f0f:	74 f4                	je     800f05 <strtol+0x16>
  800f11:	8b 45 08             	mov    0x8(%ebp),%eax
  800f14:	8a 00                	mov    (%eax),%al
  800f16:	3c 09                	cmp    $0x9,%al
  800f18:	74 eb                	je     800f05 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	8a 00                	mov    (%eax),%al
  800f1f:	3c 2b                	cmp    $0x2b,%al
  800f21:	75 05                	jne    800f28 <strtol+0x39>
		s++;
  800f23:	ff 45 08             	incl   0x8(%ebp)
  800f26:	eb 13                	jmp    800f3b <strtol+0x4c>
	else if (*s == '-')
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	8a 00                	mov    (%eax),%al
  800f2d:	3c 2d                	cmp    $0x2d,%al
  800f2f:	75 0a                	jne    800f3b <strtol+0x4c>
		s++, neg = 1;
  800f31:	ff 45 08             	incl   0x8(%ebp)
  800f34:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f3b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3f:	74 06                	je     800f47 <strtol+0x58>
  800f41:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f45:	75 20                	jne    800f67 <strtol+0x78>
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	8a 00                	mov    (%eax),%al
  800f4c:	3c 30                	cmp    $0x30,%al
  800f4e:	75 17                	jne    800f67 <strtol+0x78>
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	40                   	inc    %eax
  800f54:	8a 00                	mov    (%eax),%al
  800f56:	3c 78                	cmp    $0x78,%al
  800f58:	75 0d                	jne    800f67 <strtol+0x78>
		s += 2, base = 16;
  800f5a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f5e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f65:	eb 28                	jmp    800f8f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f67:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f6b:	75 15                	jne    800f82 <strtol+0x93>
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	8a 00                	mov    (%eax),%al
  800f72:	3c 30                	cmp    $0x30,%al
  800f74:	75 0c                	jne    800f82 <strtol+0x93>
		s++, base = 8;
  800f76:	ff 45 08             	incl   0x8(%ebp)
  800f79:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f80:	eb 0d                	jmp    800f8f <strtol+0xa0>
	else if (base == 0)
  800f82:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f86:	75 07                	jne    800f8f <strtol+0xa0>
		base = 10;
  800f88:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f92:	8a 00                	mov    (%eax),%al
  800f94:	3c 2f                	cmp    $0x2f,%al
  800f96:	7e 19                	jle    800fb1 <strtol+0xc2>
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	8a 00                	mov    (%eax),%al
  800f9d:	3c 39                	cmp    $0x39,%al
  800f9f:	7f 10                	jg     800fb1 <strtol+0xc2>
			dig = *s - '0';
  800fa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa4:	8a 00                	mov    (%eax),%al
  800fa6:	0f be c0             	movsbl %al,%eax
  800fa9:	83 e8 30             	sub    $0x30,%eax
  800fac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800faf:	eb 42                	jmp    800ff3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb4:	8a 00                	mov    (%eax),%al
  800fb6:	3c 60                	cmp    $0x60,%al
  800fb8:	7e 19                	jle    800fd3 <strtol+0xe4>
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	8a 00                	mov    (%eax),%al
  800fbf:	3c 7a                	cmp    $0x7a,%al
  800fc1:	7f 10                	jg     800fd3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc6:	8a 00                	mov    (%eax),%al
  800fc8:	0f be c0             	movsbl %al,%eax
  800fcb:	83 e8 57             	sub    $0x57,%eax
  800fce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fd1:	eb 20                	jmp    800ff3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd6:	8a 00                	mov    (%eax),%al
  800fd8:	3c 40                	cmp    $0x40,%al
  800fda:	7e 39                	jle    801015 <strtol+0x126>
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	8a 00                	mov    (%eax),%al
  800fe1:	3c 5a                	cmp    $0x5a,%al
  800fe3:	7f 30                	jg     801015 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	8a 00                	mov    (%eax),%al
  800fea:	0f be c0             	movsbl %al,%eax
  800fed:	83 e8 37             	sub    $0x37,%eax
  800ff0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800ff3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ff6:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ff9:	7d 19                	jge    801014 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800ffb:	ff 45 08             	incl   0x8(%ebp)
  800ffe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801001:	0f af 45 10          	imul   0x10(%ebp),%eax
  801005:	89 c2                	mov    %eax,%edx
  801007:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80100a:	01 d0                	add    %edx,%eax
  80100c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80100f:	e9 7b ff ff ff       	jmp    800f8f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801014:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801015:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801019:	74 08                	je     801023 <strtol+0x134>
		*endptr = (char *) s;
  80101b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101e:	8b 55 08             	mov    0x8(%ebp),%edx
  801021:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801023:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801027:	74 07                	je     801030 <strtol+0x141>
  801029:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80102c:	f7 d8                	neg    %eax
  80102e:	eb 03                	jmp    801033 <strtol+0x144>
  801030:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801033:	c9                   	leave  
  801034:	c3                   	ret    

00801035 <ltostr>:

void
ltostr(long value, char *str)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
  801038:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80103b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801042:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801049:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80104d:	79 13                	jns    801062 <ltostr+0x2d>
	{
		neg = 1;
  80104f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801056:	8b 45 0c             	mov    0xc(%ebp),%eax
  801059:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80105c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80105f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801062:	8b 45 08             	mov    0x8(%ebp),%eax
  801065:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80106a:	99                   	cltd   
  80106b:	f7 f9                	idiv   %ecx
  80106d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801070:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801073:	8d 50 01             	lea    0x1(%eax),%edx
  801076:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801079:	89 c2                	mov    %eax,%edx
  80107b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107e:	01 d0                	add    %edx,%eax
  801080:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801083:	83 c2 30             	add    $0x30,%edx
  801086:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801088:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80108b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801090:	f7 e9                	imul   %ecx
  801092:	c1 fa 02             	sar    $0x2,%edx
  801095:	89 c8                	mov    %ecx,%eax
  801097:	c1 f8 1f             	sar    $0x1f,%eax
  80109a:	29 c2                	sub    %eax,%edx
  80109c:	89 d0                	mov    %edx,%eax
  80109e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010a4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010a9:	f7 e9                	imul   %ecx
  8010ab:	c1 fa 02             	sar    $0x2,%edx
  8010ae:	89 c8                	mov    %ecx,%eax
  8010b0:	c1 f8 1f             	sar    $0x1f,%eax
  8010b3:	29 c2                	sub    %eax,%edx
  8010b5:	89 d0                	mov    %edx,%eax
  8010b7:	c1 e0 02             	shl    $0x2,%eax
  8010ba:	01 d0                	add    %edx,%eax
  8010bc:	01 c0                	add    %eax,%eax
  8010be:	29 c1                	sub    %eax,%ecx
  8010c0:	89 ca                	mov    %ecx,%edx
  8010c2:	85 d2                	test   %edx,%edx
  8010c4:	75 9c                	jne    801062 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d0:	48                   	dec    %eax
  8010d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010d4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010d8:	74 3d                	je     801117 <ltostr+0xe2>
		start = 1 ;
  8010da:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010e1:	eb 34                	jmp    801117 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e9:	01 d0                	add    %edx,%eax
  8010eb:	8a 00                	mov    (%eax),%al
  8010ed:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f6:	01 c2                	add    %eax,%edx
  8010f8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fe:	01 c8                	add    %ecx,%eax
  801100:	8a 00                	mov    (%eax),%al
  801102:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801104:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801107:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110a:	01 c2                	add    %eax,%edx
  80110c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80110f:	88 02                	mov    %al,(%edx)
		start++ ;
  801111:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801114:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801117:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80111a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80111d:	7c c4                	jl     8010e3 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80111f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801122:	8b 45 0c             	mov    0xc(%ebp),%eax
  801125:	01 d0                	add    %edx,%eax
  801127:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80112a:	90                   	nop
  80112b:	c9                   	leave  
  80112c:	c3                   	ret    

0080112d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80112d:	55                   	push   %ebp
  80112e:	89 e5                	mov    %esp,%ebp
  801130:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801133:	ff 75 08             	pushl  0x8(%ebp)
  801136:	e8 54 fa ff ff       	call   800b8f <strlen>
  80113b:	83 c4 04             	add    $0x4,%esp
  80113e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801141:	ff 75 0c             	pushl  0xc(%ebp)
  801144:	e8 46 fa ff ff       	call   800b8f <strlen>
  801149:	83 c4 04             	add    $0x4,%esp
  80114c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80114f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801156:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80115d:	eb 17                	jmp    801176 <strcconcat+0x49>
		final[s] = str1[s] ;
  80115f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801162:	8b 45 10             	mov    0x10(%ebp),%eax
  801165:	01 c2                	add    %eax,%edx
  801167:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	01 c8                	add    %ecx,%eax
  80116f:	8a 00                	mov    (%eax),%al
  801171:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801173:	ff 45 fc             	incl   -0x4(%ebp)
  801176:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801179:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80117c:	7c e1                	jl     80115f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80117e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801185:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80118c:	eb 1f                	jmp    8011ad <strcconcat+0x80>
		final[s++] = str2[i] ;
  80118e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801191:	8d 50 01             	lea    0x1(%eax),%edx
  801194:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801197:	89 c2                	mov    %eax,%edx
  801199:	8b 45 10             	mov    0x10(%ebp),%eax
  80119c:	01 c2                	add    %eax,%edx
  80119e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a4:	01 c8                	add    %ecx,%eax
  8011a6:	8a 00                	mov    (%eax),%al
  8011a8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011aa:	ff 45 f8             	incl   -0x8(%ebp)
  8011ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011b0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011b3:	7c d9                	jl     80118e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011bb:	01 d0                	add    %edx,%eax
  8011bd:	c6 00 00             	movb   $0x0,(%eax)
}
  8011c0:	90                   	nop
  8011c1:	c9                   	leave  
  8011c2:	c3                   	ret    

008011c3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011c3:	55                   	push   %ebp
  8011c4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d2:	8b 00                	mov    (%eax),%eax
  8011d4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011db:	8b 45 10             	mov    0x10(%ebp),%eax
  8011de:	01 d0                	add    %edx,%eax
  8011e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e6:	eb 0c                	jmp    8011f4 <strsplit+0x31>
			*string++ = 0;
  8011e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011eb:	8d 50 01             	lea    0x1(%eax),%edx
  8011ee:	89 55 08             	mov    %edx,0x8(%ebp)
  8011f1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f7:	8a 00                	mov    (%eax),%al
  8011f9:	84 c0                	test   %al,%al
  8011fb:	74 18                	je     801215 <strsplit+0x52>
  8011fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801200:	8a 00                	mov    (%eax),%al
  801202:	0f be c0             	movsbl %al,%eax
  801205:	50                   	push   %eax
  801206:	ff 75 0c             	pushl  0xc(%ebp)
  801209:	e8 13 fb ff ff       	call   800d21 <strchr>
  80120e:	83 c4 08             	add    $0x8,%esp
  801211:	85 c0                	test   %eax,%eax
  801213:	75 d3                	jne    8011e8 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801215:	8b 45 08             	mov    0x8(%ebp),%eax
  801218:	8a 00                	mov    (%eax),%al
  80121a:	84 c0                	test   %al,%al
  80121c:	74 5a                	je     801278 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80121e:	8b 45 14             	mov    0x14(%ebp),%eax
  801221:	8b 00                	mov    (%eax),%eax
  801223:	83 f8 0f             	cmp    $0xf,%eax
  801226:	75 07                	jne    80122f <strsplit+0x6c>
		{
			return 0;
  801228:	b8 00 00 00 00       	mov    $0x0,%eax
  80122d:	eb 66                	jmp    801295 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80122f:	8b 45 14             	mov    0x14(%ebp),%eax
  801232:	8b 00                	mov    (%eax),%eax
  801234:	8d 48 01             	lea    0x1(%eax),%ecx
  801237:	8b 55 14             	mov    0x14(%ebp),%edx
  80123a:	89 0a                	mov    %ecx,(%edx)
  80123c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801243:	8b 45 10             	mov    0x10(%ebp),%eax
  801246:	01 c2                	add    %eax,%edx
  801248:	8b 45 08             	mov    0x8(%ebp),%eax
  80124b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80124d:	eb 03                	jmp    801252 <strsplit+0x8f>
			string++;
  80124f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801252:	8b 45 08             	mov    0x8(%ebp),%eax
  801255:	8a 00                	mov    (%eax),%al
  801257:	84 c0                	test   %al,%al
  801259:	74 8b                	je     8011e6 <strsplit+0x23>
  80125b:	8b 45 08             	mov    0x8(%ebp),%eax
  80125e:	8a 00                	mov    (%eax),%al
  801260:	0f be c0             	movsbl %al,%eax
  801263:	50                   	push   %eax
  801264:	ff 75 0c             	pushl  0xc(%ebp)
  801267:	e8 b5 fa ff ff       	call   800d21 <strchr>
  80126c:	83 c4 08             	add    $0x8,%esp
  80126f:	85 c0                	test   %eax,%eax
  801271:	74 dc                	je     80124f <strsplit+0x8c>
			string++;
	}
  801273:	e9 6e ff ff ff       	jmp    8011e6 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801278:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801279:	8b 45 14             	mov    0x14(%ebp),%eax
  80127c:	8b 00                	mov    (%eax),%eax
  80127e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801285:	8b 45 10             	mov    0x10(%ebp),%eax
  801288:	01 d0                	add    %edx,%eax
  80128a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801290:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801295:	c9                   	leave  
  801296:	c3                   	ret    

00801297 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801297:	55                   	push   %ebp
  801298:	89 e5                	mov    %esp,%ebp
  80129a:	57                   	push   %edi
  80129b:	56                   	push   %esi
  80129c:	53                   	push   %ebx
  80129d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012a9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012ac:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012af:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012b2:	cd 30                	int    $0x30
  8012b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012ba:	83 c4 10             	add    $0x10,%esp
  8012bd:	5b                   	pop    %ebx
  8012be:	5e                   	pop    %esi
  8012bf:	5f                   	pop    %edi
  8012c0:	5d                   	pop    %ebp
  8012c1:	c3                   	ret    

008012c2 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012c2:	55                   	push   %ebp
  8012c3:	89 e5                	mov    %esp,%ebp
  8012c5:	83 ec 04             	sub    $0x4,%esp
  8012c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012ce:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d5:	6a 00                	push   $0x0
  8012d7:	6a 00                	push   $0x0
  8012d9:	52                   	push   %edx
  8012da:	ff 75 0c             	pushl  0xc(%ebp)
  8012dd:	50                   	push   %eax
  8012de:	6a 00                	push   $0x0
  8012e0:	e8 b2 ff ff ff       	call   801297 <syscall>
  8012e5:	83 c4 18             	add    $0x18,%esp
}
  8012e8:	90                   	nop
  8012e9:	c9                   	leave  
  8012ea:	c3                   	ret    

008012eb <sys_cgetc>:

int
sys_cgetc(void)
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 01                	push   $0x1
  8012fa:	e8 98 ff ff ff       	call   801297 <syscall>
  8012ff:	83 c4 18             	add    $0x18,%esp
}
  801302:	c9                   	leave  
  801303:	c3                   	ret    

00801304 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801304:	55                   	push   %ebp
  801305:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801307:	8b 45 08             	mov    0x8(%ebp),%eax
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	50                   	push   %eax
  801313:	6a 05                	push   $0x5
  801315:	e8 7d ff ff ff       	call   801297 <syscall>
  80131a:	83 c4 18             	add    $0x18,%esp
}
  80131d:	c9                   	leave  
  80131e:	c3                   	ret    

0080131f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80131f:	55                   	push   %ebp
  801320:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801322:	6a 00                	push   $0x0
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	6a 02                	push   $0x2
  80132e:	e8 64 ff ff ff       	call   801297 <syscall>
  801333:	83 c4 18             	add    $0x18,%esp
}
  801336:	c9                   	leave  
  801337:	c3                   	ret    

00801338 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801338:	55                   	push   %ebp
  801339:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	6a 00                	push   $0x0
  801345:	6a 03                	push   $0x3
  801347:	e8 4b ff ff ff       	call   801297 <syscall>
  80134c:	83 c4 18             	add    $0x18,%esp
}
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801354:	6a 00                	push   $0x0
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	6a 04                	push   $0x4
  801360:	e8 32 ff ff ff       	call   801297 <syscall>
  801365:	83 c4 18             	add    $0x18,%esp
}
  801368:	c9                   	leave  
  801369:	c3                   	ret    

0080136a <sys_env_exit>:


void sys_env_exit(void)
{
  80136a:	55                   	push   %ebp
  80136b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80136d:	6a 00                	push   $0x0
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	6a 00                	push   $0x0
  801377:	6a 06                	push   $0x6
  801379:	e8 19 ff ff ff       	call   801297 <syscall>
  80137e:	83 c4 18             	add    $0x18,%esp
}
  801381:	90                   	nop
  801382:	c9                   	leave  
  801383:	c3                   	ret    

00801384 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801384:	55                   	push   %ebp
  801385:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801387:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138a:	8b 45 08             	mov    0x8(%ebp),%eax
  80138d:	6a 00                	push   $0x0
  80138f:	6a 00                	push   $0x0
  801391:	6a 00                	push   $0x0
  801393:	52                   	push   %edx
  801394:	50                   	push   %eax
  801395:	6a 07                	push   $0x7
  801397:	e8 fb fe ff ff       	call   801297 <syscall>
  80139c:	83 c4 18             	add    $0x18,%esp
}
  80139f:	c9                   	leave  
  8013a0:	c3                   	ret    

008013a1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013a1:	55                   	push   %ebp
  8013a2:	89 e5                	mov    %esp,%ebp
  8013a4:	56                   	push   %esi
  8013a5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013a6:	8b 75 18             	mov    0x18(%ebp),%esi
  8013a9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013ac:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	56                   	push   %esi
  8013b6:	53                   	push   %ebx
  8013b7:	51                   	push   %ecx
  8013b8:	52                   	push   %edx
  8013b9:	50                   	push   %eax
  8013ba:	6a 08                	push   $0x8
  8013bc:	e8 d6 fe ff ff       	call   801297 <syscall>
  8013c1:	83 c4 18             	add    $0x18,%esp
}
  8013c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013c7:	5b                   	pop    %ebx
  8013c8:	5e                   	pop    %esi
  8013c9:	5d                   	pop    %ebp
  8013ca:	c3                   	ret    

008013cb <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013cb:	55                   	push   %ebp
  8013cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	52                   	push   %edx
  8013db:	50                   	push   %eax
  8013dc:	6a 09                	push   $0x9
  8013de:	e8 b4 fe ff ff       	call   801297 <syscall>
  8013e3:	83 c4 18             	add    $0x18,%esp
}
  8013e6:	c9                   	leave  
  8013e7:	c3                   	ret    

008013e8 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013e8:	55                   	push   %ebp
  8013e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	ff 75 0c             	pushl  0xc(%ebp)
  8013f4:	ff 75 08             	pushl  0x8(%ebp)
  8013f7:	6a 0a                	push   $0xa
  8013f9:	e8 99 fe ff ff       	call   801297 <syscall>
  8013fe:	83 c4 18             	add    $0x18,%esp
}
  801401:	c9                   	leave  
  801402:	c3                   	ret    

00801403 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801403:	55                   	push   %ebp
  801404:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	6a 00                	push   $0x0
  801410:	6a 0b                	push   $0xb
  801412:	e8 80 fe ff ff       	call   801297 <syscall>
  801417:	83 c4 18             	add    $0x18,%esp
}
  80141a:	c9                   	leave  
  80141b:	c3                   	ret    

0080141c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80141c:	55                   	push   %ebp
  80141d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 00                	push   $0x0
  801429:	6a 0c                	push   $0xc
  80142b:	e8 67 fe ff ff       	call   801297 <syscall>
  801430:	83 c4 18             	add    $0x18,%esp
}
  801433:	c9                   	leave  
  801434:	c3                   	ret    

00801435 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801435:	55                   	push   %ebp
  801436:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	6a 0d                	push   $0xd
  801444:	e8 4e fe ff ff       	call   801297 <syscall>
  801449:	83 c4 18             	add    $0x18,%esp
}
  80144c:	c9                   	leave  
  80144d:	c3                   	ret    

0080144e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80144e:	55                   	push   %ebp
  80144f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	ff 75 0c             	pushl  0xc(%ebp)
  80145a:	ff 75 08             	pushl  0x8(%ebp)
  80145d:	6a 11                	push   $0x11
  80145f:	e8 33 fe ff ff       	call   801297 <syscall>
  801464:	83 c4 18             	add    $0x18,%esp
	return;
  801467:	90                   	nop
}
  801468:	c9                   	leave  
  801469:	c3                   	ret    

0080146a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80146a:	55                   	push   %ebp
  80146b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	ff 75 0c             	pushl  0xc(%ebp)
  801476:	ff 75 08             	pushl  0x8(%ebp)
  801479:	6a 12                	push   $0x12
  80147b:	e8 17 fe ff ff       	call   801297 <syscall>
  801480:	83 c4 18             	add    $0x18,%esp
	return ;
  801483:	90                   	nop
}
  801484:	c9                   	leave  
  801485:	c3                   	ret    

00801486 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801486:	55                   	push   %ebp
  801487:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 0e                	push   $0xe
  801495:	e8 fd fd ff ff       	call   801297 <syscall>
  80149a:	83 c4 18             	add    $0x18,%esp
}
  80149d:	c9                   	leave  
  80149e:	c3                   	ret    

0080149f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80149f:	55                   	push   %ebp
  8014a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	ff 75 08             	pushl  0x8(%ebp)
  8014ad:	6a 0f                	push   $0xf
  8014af:	e8 e3 fd ff ff       	call   801297 <syscall>
  8014b4:	83 c4 18             	add    $0x18,%esp
}
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 10                	push   $0x10
  8014c8:	e8 ca fd ff ff       	call   801297 <syscall>
  8014cd:	83 c4 18             	add    $0x18,%esp
}
  8014d0:	90                   	nop
  8014d1:	c9                   	leave  
  8014d2:	c3                   	ret    

008014d3 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014d3:	55                   	push   %ebp
  8014d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 14                	push   $0x14
  8014e2:	e8 b0 fd ff ff       	call   801297 <syscall>
  8014e7:	83 c4 18             	add    $0x18,%esp
}
  8014ea:	90                   	nop
  8014eb:	c9                   	leave  
  8014ec:	c3                   	ret    

008014ed <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014ed:	55                   	push   %ebp
  8014ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 15                	push   $0x15
  8014fc:	e8 96 fd ff ff       	call   801297 <syscall>
  801501:	83 c4 18             	add    $0x18,%esp
}
  801504:	90                   	nop
  801505:	c9                   	leave  
  801506:	c3                   	ret    

00801507 <sys_cputc>:


void
sys_cputc(const char c)
{
  801507:	55                   	push   %ebp
  801508:	89 e5                	mov    %esp,%ebp
  80150a:	83 ec 04             	sub    $0x4,%esp
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
  801510:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801513:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	50                   	push   %eax
  801520:	6a 16                	push   $0x16
  801522:	e8 70 fd ff ff       	call   801297 <syscall>
  801527:	83 c4 18             	add    $0x18,%esp
}
  80152a:	90                   	nop
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 17                	push   $0x17
  80153c:	e8 56 fd ff ff       	call   801297 <syscall>
  801541:	83 c4 18             	add    $0x18,%esp
}
  801544:	90                   	nop
  801545:	c9                   	leave  
  801546:	c3                   	ret    

00801547 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80154a:	8b 45 08             	mov    0x8(%ebp),%eax
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	ff 75 0c             	pushl  0xc(%ebp)
  801556:	50                   	push   %eax
  801557:	6a 18                	push   $0x18
  801559:	e8 39 fd ff ff       	call   801297 <syscall>
  80155e:	83 c4 18             	add    $0x18,%esp
}
  801561:	c9                   	leave  
  801562:	c3                   	ret    

00801563 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801563:	55                   	push   %ebp
  801564:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801566:	8b 55 0c             	mov    0xc(%ebp),%edx
  801569:	8b 45 08             	mov    0x8(%ebp),%eax
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	52                   	push   %edx
  801573:	50                   	push   %eax
  801574:	6a 1b                	push   $0x1b
  801576:	e8 1c fd ff ff       	call   801297 <syscall>
  80157b:	83 c4 18             	add    $0x18,%esp
}
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801583:	8b 55 0c             	mov    0xc(%ebp),%edx
  801586:	8b 45 08             	mov    0x8(%ebp),%eax
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	52                   	push   %edx
  801590:	50                   	push   %eax
  801591:	6a 19                	push   $0x19
  801593:	e8 ff fc ff ff       	call   801297 <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
}
  80159b:	90                   	nop
  80159c:	c9                   	leave  
  80159d:	c3                   	ret    

0080159e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80159e:	55                   	push   %ebp
  80159f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	52                   	push   %edx
  8015ae:	50                   	push   %eax
  8015af:	6a 1a                	push   $0x1a
  8015b1:	e8 e1 fc ff ff       	call   801297 <syscall>
  8015b6:	83 c4 18             	add    $0x18,%esp
}
  8015b9:	90                   	nop
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
  8015bf:	83 ec 04             	sub    $0x4,%esp
  8015c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015c8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015cb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d2:	6a 00                	push   $0x0
  8015d4:	51                   	push   %ecx
  8015d5:	52                   	push   %edx
  8015d6:	ff 75 0c             	pushl  0xc(%ebp)
  8015d9:	50                   	push   %eax
  8015da:	6a 1c                	push   $0x1c
  8015dc:	e8 b6 fc ff ff       	call   801297 <syscall>
  8015e1:	83 c4 18             	add    $0x18,%esp
}
  8015e4:	c9                   	leave  
  8015e5:	c3                   	ret    

008015e6 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015e6:	55                   	push   %ebp
  8015e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	52                   	push   %edx
  8015f6:	50                   	push   %eax
  8015f7:	6a 1d                	push   $0x1d
  8015f9:	e8 99 fc ff ff       	call   801297 <syscall>
  8015fe:	83 c4 18             	add    $0x18,%esp
}
  801601:	c9                   	leave  
  801602:	c3                   	ret    

00801603 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801603:	55                   	push   %ebp
  801604:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801606:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801609:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	51                   	push   %ecx
  801614:	52                   	push   %edx
  801615:	50                   	push   %eax
  801616:	6a 1e                	push   $0x1e
  801618:	e8 7a fc ff ff       	call   801297 <syscall>
  80161d:	83 c4 18             	add    $0x18,%esp
}
  801620:	c9                   	leave  
  801621:	c3                   	ret    

00801622 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801622:	55                   	push   %ebp
  801623:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801625:	8b 55 0c             	mov    0xc(%ebp),%edx
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	52                   	push   %edx
  801632:	50                   	push   %eax
  801633:	6a 1f                	push   $0x1f
  801635:	e8 5d fc ff ff       	call   801297 <syscall>
  80163a:	83 c4 18             	add    $0x18,%esp
}
  80163d:	c9                   	leave  
  80163e:	c3                   	ret    

0080163f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80163f:	55                   	push   %ebp
  801640:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 20                	push   $0x20
  80164e:	e8 44 fc ff ff       	call   801297 <syscall>
  801653:	83 c4 18             	add    $0x18,%esp
}
  801656:	c9                   	leave  
  801657:	c3                   	ret    

00801658 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	6a 00                	push   $0x0
  801660:	ff 75 14             	pushl  0x14(%ebp)
  801663:	ff 75 10             	pushl  0x10(%ebp)
  801666:	ff 75 0c             	pushl  0xc(%ebp)
  801669:	50                   	push   %eax
  80166a:	6a 21                	push   $0x21
  80166c:	e8 26 fc ff ff       	call   801297 <syscall>
  801671:	83 c4 18             	add    $0x18,%esp
}
  801674:	c9                   	leave  
  801675:	c3                   	ret    

00801676 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801676:	55                   	push   %ebp
  801677:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	50                   	push   %eax
  801685:	6a 22                	push   $0x22
  801687:	e8 0b fc ff ff       	call   801297 <syscall>
  80168c:	83 c4 18             	add    $0x18,%esp
}
  80168f:	90                   	nop
  801690:	c9                   	leave  
  801691:	c3                   	ret    

00801692 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801692:	55                   	push   %ebp
  801693:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801695:	8b 45 08             	mov    0x8(%ebp),%eax
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	50                   	push   %eax
  8016a1:	6a 23                	push   $0x23
  8016a3:	e8 ef fb ff ff       	call   801297 <syscall>
  8016a8:	83 c4 18             	add    $0x18,%esp
}
  8016ab:	90                   	nop
  8016ac:	c9                   	leave  
  8016ad:	c3                   	ret    

008016ae <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
  8016b1:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016b4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016b7:	8d 50 04             	lea    0x4(%eax),%edx
  8016ba:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	52                   	push   %edx
  8016c4:	50                   	push   %eax
  8016c5:	6a 24                	push   $0x24
  8016c7:	e8 cb fb ff ff       	call   801297 <syscall>
  8016cc:	83 c4 18             	add    $0x18,%esp
	return result;
  8016cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016d8:	89 01                	mov    %eax,(%ecx)
  8016da:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e0:	c9                   	leave  
  8016e1:	c2 04 00             	ret    $0x4

008016e4 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	ff 75 10             	pushl  0x10(%ebp)
  8016ee:	ff 75 0c             	pushl  0xc(%ebp)
  8016f1:	ff 75 08             	pushl  0x8(%ebp)
  8016f4:	6a 13                	push   $0x13
  8016f6:	e8 9c fb ff ff       	call   801297 <syscall>
  8016fb:	83 c4 18             	add    $0x18,%esp
	return ;
  8016fe:	90                   	nop
}
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <sys_rcr2>:
uint32 sys_rcr2()
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 25                	push   $0x25
  801710:	e8 82 fb ff ff       	call   801297 <syscall>
  801715:	83 c4 18             	add    $0x18,%esp
}
  801718:	c9                   	leave  
  801719:	c3                   	ret    

0080171a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80171a:	55                   	push   %ebp
  80171b:	89 e5                	mov    %esp,%ebp
  80171d:	83 ec 04             	sub    $0x4,%esp
  801720:	8b 45 08             	mov    0x8(%ebp),%eax
  801723:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801726:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	50                   	push   %eax
  801733:	6a 26                	push   $0x26
  801735:	e8 5d fb ff ff       	call   801297 <syscall>
  80173a:	83 c4 18             	add    $0x18,%esp
	return ;
  80173d:	90                   	nop
}
  80173e:	c9                   	leave  
  80173f:	c3                   	ret    

00801740 <rsttst>:
void rsttst()
{
  801740:	55                   	push   %ebp
  801741:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 28                	push   $0x28
  80174f:	e8 43 fb ff ff       	call   801297 <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
	return ;
  801757:	90                   	nop
}
  801758:	c9                   	leave  
  801759:	c3                   	ret    

0080175a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80175a:	55                   	push   %ebp
  80175b:	89 e5                	mov    %esp,%ebp
  80175d:	83 ec 04             	sub    $0x4,%esp
  801760:	8b 45 14             	mov    0x14(%ebp),%eax
  801763:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801766:	8b 55 18             	mov    0x18(%ebp),%edx
  801769:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80176d:	52                   	push   %edx
  80176e:	50                   	push   %eax
  80176f:	ff 75 10             	pushl  0x10(%ebp)
  801772:	ff 75 0c             	pushl  0xc(%ebp)
  801775:	ff 75 08             	pushl  0x8(%ebp)
  801778:	6a 27                	push   $0x27
  80177a:	e8 18 fb ff ff       	call   801297 <syscall>
  80177f:	83 c4 18             	add    $0x18,%esp
	return ;
  801782:	90                   	nop
}
  801783:	c9                   	leave  
  801784:	c3                   	ret    

00801785 <chktst>:
void chktst(uint32 n)
{
  801785:	55                   	push   %ebp
  801786:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	ff 75 08             	pushl  0x8(%ebp)
  801793:	6a 29                	push   $0x29
  801795:	e8 fd fa ff ff       	call   801297 <syscall>
  80179a:	83 c4 18             	add    $0x18,%esp
	return ;
  80179d:	90                   	nop
}
  80179e:	c9                   	leave  
  80179f:	c3                   	ret    

008017a0 <inctst>:

void inctst()
{
  8017a0:	55                   	push   %ebp
  8017a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 2a                	push   $0x2a
  8017af:	e8 e3 fa ff ff       	call   801297 <syscall>
  8017b4:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b7:	90                   	nop
}
  8017b8:	c9                   	leave  
  8017b9:	c3                   	ret    

008017ba <gettst>:
uint32 gettst()
{
  8017ba:	55                   	push   %ebp
  8017bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 2b                	push   $0x2b
  8017c9:	e8 c9 fa ff ff       	call   801297 <syscall>
  8017ce:	83 c4 18             	add    $0x18,%esp
}
  8017d1:	c9                   	leave  
  8017d2:	c3                   	ret    

008017d3 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017d3:	55                   	push   %ebp
  8017d4:	89 e5                	mov    %esp,%ebp
  8017d6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 2c                	push   $0x2c
  8017e5:	e8 ad fa ff ff       	call   801297 <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
  8017ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017f0:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017f4:	75 07                	jne    8017fd <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8017fb:	eb 05                	jmp    801802 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801802:	c9                   	leave  
  801803:	c3                   	ret    

00801804 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801804:	55                   	push   %ebp
  801805:	89 e5                	mov    %esp,%ebp
  801807:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 2c                	push   $0x2c
  801816:	e8 7c fa ff ff       	call   801297 <syscall>
  80181b:	83 c4 18             	add    $0x18,%esp
  80181e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801821:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801825:	75 07                	jne    80182e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801827:	b8 01 00 00 00       	mov    $0x1,%eax
  80182c:	eb 05                	jmp    801833 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80182e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801833:	c9                   	leave  
  801834:	c3                   	ret    

00801835 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801835:	55                   	push   %ebp
  801836:	89 e5                	mov    %esp,%ebp
  801838:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 2c                	push   $0x2c
  801847:	e8 4b fa ff ff       	call   801297 <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
  80184f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801852:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801856:	75 07                	jne    80185f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801858:	b8 01 00 00 00       	mov    $0x1,%eax
  80185d:	eb 05                	jmp    801864 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80185f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801864:	c9                   	leave  
  801865:	c3                   	ret    

00801866 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801866:	55                   	push   %ebp
  801867:	89 e5                	mov    %esp,%ebp
  801869:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 2c                	push   $0x2c
  801878:	e8 1a fa ff ff       	call   801297 <syscall>
  80187d:	83 c4 18             	add    $0x18,%esp
  801880:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801883:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801887:	75 07                	jne    801890 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801889:	b8 01 00 00 00       	mov    $0x1,%eax
  80188e:	eb 05                	jmp    801895 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801890:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	ff 75 08             	pushl  0x8(%ebp)
  8018a5:	6a 2d                	push   $0x2d
  8018a7:	e8 eb f9 ff ff       	call   801297 <syscall>
  8018ac:	83 c4 18             	add    $0x18,%esp
	return ;
  8018af:	90                   	nop
}
  8018b0:	c9                   	leave  
  8018b1:	c3                   	ret    

008018b2 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018b2:	55                   	push   %ebp
  8018b3:	89 e5                	mov    %esp,%ebp
  8018b5:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018b6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018b9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c2:	6a 00                	push   $0x0
  8018c4:	53                   	push   %ebx
  8018c5:	51                   	push   %ecx
  8018c6:	52                   	push   %edx
  8018c7:	50                   	push   %eax
  8018c8:	6a 2e                	push   $0x2e
  8018ca:	e8 c8 f9 ff ff       	call   801297 <syscall>
  8018cf:	83 c4 18             	add    $0x18,%esp
}
  8018d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018d5:	c9                   	leave  
  8018d6:	c3                   	ret    

008018d7 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018d7:	55                   	push   %ebp
  8018d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	52                   	push   %edx
  8018e7:	50                   	push   %eax
  8018e8:	6a 2f                	push   $0x2f
  8018ea:	e8 a8 f9 ff ff       	call   801297 <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
}
  8018f2:	c9                   	leave  
  8018f3:	c3                   	ret    

008018f4 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018f4:	55                   	push   %ebp
  8018f5:	89 e5                	mov    %esp,%ebp
  8018f7:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018fa:	8b 55 08             	mov    0x8(%ebp),%edx
  8018fd:	89 d0                	mov    %edx,%eax
  8018ff:	c1 e0 02             	shl    $0x2,%eax
  801902:	01 d0                	add    %edx,%eax
  801904:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80190b:	01 d0                	add    %edx,%eax
  80190d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801914:	01 d0                	add    %edx,%eax
  801916:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80191d:	01 d0                	add    %edx,%eax
  80191f:	c1 e0 04             	shl    $0x4,%eax
  801922:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801925:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80192c:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80192f:	83 ec 0c             	sub    $0xc,%esp
  801932:	50                   	push   %eax
  801933:	e8 76 fd ff ff       	call   8016ae <sys_get_virtual_time>
  801938:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  80193b:	eb 41                	jmp    80197e <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80193d:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801940:	83 ec 0c             	sub    $0xc,%esp
  801943:	50                   	push   %eax
  801944:	e8 65 fd ff ff       	call   8016ae <sys_get_virtual_time>
  801949:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80194c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80194f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801952:	29 c2                	sub    %eax,%edx
  801954:	89 d0                	mov    %edx,%eax
  801956:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801959:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80195c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80195f:	89 d1                	mov    %edx,%ecx
  801961:	29 c1                	sub    %eax,%ecx
  801963:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801966:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801969:	39 c2                	cmp    %eax,%edx
  80196b:	0f 97 c0             	seta   %al
  80196e:	0f b6 c0             	movzbl %al,%eax
  801971:	29 c1                	sub    %eax,%ecx
  801973:	89 c8                	mov    %ecx,%eax
  801975:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801978:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80197b:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80197e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801981:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801984:	72 b7                	jb     80193d <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801986:	90                   	nop
  801987:	c9                   	leave  
  801988:	c3                   	ret    

00801989 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801989:	55                   	push   %ebp
  80198a:	89 e5                	mov    %esp,%ebp
  80198c:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80198f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801996:	eb 03                	jmp    80199b <busy_wait+0x12>
  801998:	ff 45 fc             	incl   -0x4(%ebp)
  80199b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80199e:	3b 45 08             	cmp    0x8(%ebp),%eax
  8019a1:	72 f5                	jb     801998 <busy_wait+0xf>
	return i;
  8019a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8019a6:	c9                   	leave  
  8019a7:	c3                   	ret    

008019a8 <__udivdi3>:
  8019a8:	55                   	push   %ebp
  8019a9:	57                   	push   %edi
  8019aa:	56                   	push   %esi
  8019ab:	53                   	push   %ebx
  8019ac:	83 ec 1c             	sub    $0x1c,%esp
  8019af:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019b3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019bb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019bf:	89 ca                	mov    %ecx,%edx
  8019c1:	89 f8                	mov    %edi,%eax
  8019c3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019c7:	85 f6                	test   %esi,%esi
  8019c9:	75 2d                	jne    8019f8 <__udivdi3+0x50>
  8019cb:	39 cf                	cmp    %ecx,%edi
  8019cd:	77 65                	ja     801a34 <__udivdi3+0x8c>
  8019cf:	89 fd                	mov    %edi,%ebp
  8019d1:	85 ff                	test   %edi,%edi
  8019d3:	75 0b                	jne    8019e0 <__udivdi3+0x38>
  8019d5:	b8 01 00 00 00       	mov    $0x1,%eax
  8019da:	31 d2                	xor    %edx,%edx
  8019dc:	f7 f7                	div    %edi
  8019de:	89 c5                	mov    %eax,%ebp
  8019e0:	31 d2                	xor    %edx,%edx
  8019e2:	89 c8                	mov    %ecx,%eax
  8019e4:	f7 f5                	div    %ebp
  8019e6:	89 c1                	mov    %eax,%ecx
  8019e8:	89 d8                	mov    %ebx,%eax
  8019ea:	f7 f5                	div    %ebp
  8019ec:	89 cf                	mov    %ecx,%edi
  8019ee:	89 fa                	mov    %edi,%edx
  8019f0:	83 c4 1c             	add    $0x1c,%esp
  8019f3:	5b                   	pop    %ebx
  8019f4:	5e                   	pop    %esi
  8019f5:	5f                   	pop    %edi
  8019f6:	5d                   	pop    %ebp
  8019f7:	c3                   	ret    
  8019f8:	39 ce                	cmp    %ecx,%esi
  8019fa:	77 28                	ja     801a24 <__udivdi3+0x7c>
  8019fc:	0f bd fe             	bsr    %esi,%edi
  8019ff:	83 f7 1f             	xor    $0x1f,%edi
  801a02:	75 40                	jne    801a44 <__udivdi3+0x9c>
  801a04:	39 ce                	cmp    %ecx,%esi
  801a06:	72 0a                	jb     801a12 <__udivdi3+0x6a>
  801a08:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a0c:	0f 87 9e 00 00 00    	ja     801ab0 <__udivdi3+0x108>
  801a12:	b8 01 00 00 00       	mov    $0x1,%eax
  801a17:	89 fa                	mov    %edi,%edx
  801a19:	83 c4 1c             	add    $0x1c,%esp
  801a1c:	5b                   	pop    %ebx
  801a1d:	5e                   	pop    %esi
  801a1e:	5f                   	pop    %edi
  801a1f:	5d                   	pop    %ebp
  801a20:	c3                   	ret    
  801a21:	8d 76 00             	lea    0x0(%esi),%esi
  801a24:	31 ff                	xor    %edi,%edi
  801a26:	31 c0                	xor    %eax,%eax
  801a28:	89 fa                	mov    %edi,%edx
  801a2a:	83 c4 1c             	add    $0x1c,%esp
  801a2d:	5b                   	pop    %ebx
  801a2e:	5e                   	pop    %esi
  801a2f:	5f                   	pop    %edi
  801a30:	5d                   	pop    %ebp
  801a31:	c3                   	ret    
  801a32:	66 90                	xchg   %ax,%ax
  801a34:	89 d8                	mov    %ebx,%eax
  801a36:	f7 f7                	div    %edi
  801a38:	31 ff                	xor    %edi,%edi
  801a3a:	89 fa                	mov    %edi,%edx
  801a3c:	83 c4 1c             	add    $0x1c,%esp
  801a3f:	5b                   	pop    %ebx
  801a40:	5e                   	pop    %esi
  801a41:	5f                   	pop    %edi
  801a42:	5d                   	pop    %ebp
  801a43:	c3                   	ret    
  801a44:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a49:	89 eb                	mov    %ebp,%ebx
  801a4b:	29 fb                	sub    %edi,%ebx
  801a4d:	89 f9                	mov    %edi,%ecx
  801a4f:	d3 e6                	shl    %cl,%esi
  801a51:	89 c5                	mov    %eax,%ebp
  801a53:	88 d9                	mov    %bl,%cl
  801a55:	d3 ed                	shr    %cl,%ebp
  801a57:	89 e9                	mov    %ebp,%ecx
  801a59:	09 f1                	or     %esi,%ecx
  801a5b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a5f:	89 f9                	mov    %edi,%ecx
  801a61:	d3 e0                	shl    %cl,%eax
  801a63:	89 c5                	mov    %eax,%ebp
  801a65:	89 d6                	mov    %edx,%esi
  801a67:	88 d9                	mov    %bl,%cl
  801a69:	d3 ee                	shr    %cl,%esi
  801a6b:	89 f9                	mov    %edi,%ecx
  801a6d:	d3 e2                	shl    %cl,%edx
  801a6f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a73:	88 d9                	mov    %bl,%cl
  801a75:	d3 e8                	shr    %cl,%eax
  801a77:	09 c2                	or     %eax,%edx
  801a79:	89 d0                	mov    %edx,%eax
  801a7b:	89 f2                	mov    %esi,%edx
  801a7d:	f7 74 24 0c          	divl   0xc(%esp)
  801a81:	89 d6                	mov    %edx,%esi
  801a83:	89 c3                	mov    %eax,%ebx
  801a85:	f7 e5                	mul    %ebp
  801a87:	39 d6                	cmp    %edx,%esi
  801a89:	72 19                	jb     801aa4 <__udivdi3+0xfc>
  801a8b:	74 0b                	je     801a98 <__udivdi3+0xf0>
  801a8d:	89 d8                	mov    %ebx,%eax
  801a8f:	31 ff                	xor    %edi,%edi
  801a91:	e9 58 ff ff ff       	jmp    8019ee <__udivdi3+0x46>
  801a96:	66 90                	xchg   %ax,%ax
  801a98:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a9c:	89 f9                	mov    %edi,%ecx
  801a9e:	d3 e2                	shl    %cl,%edx
  801aa0:	39 c2                	cmp    %eax,%edx
  801aa2:	73 e9                	jae    801a8d <__udivdi3+0xe5>
  801aa4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801aa7:	31 ff                	xor    %edi,%edi
  801aa9:	e9 40 ff ff ff       	jmp    8019ee <__udivdi3+0x46>
  801aae:	66 90                	xchg   %ax,%ax
  801ab0:	31 c0                	xor    %eax,%eax
  801ab2:	e9 37 ff ff ff       	jmp    8019ee <__udivdi3+0x46>
  801ab7:	90                   	nop

00801ab8 <__umoddi3>:
  801ab8:	55                   	push   %ebp
  801ab9:	57                   	push   %edi
  801aba:	56                   	push   %esi
  801abb:	53                   	push   %ebx
  801abc:	83 ec 1c             	sub    $0x1c,%esp
  801abf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ac3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ac7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801acb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801acf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ad3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ad7:	89 f3                	mov    %esi,%ebx
  801ad9:	89 fa                	mov    %edi,%edx
  801adb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801adf:	89 34 24             	mov    %esi,(%esp)
  801ae2:	85 c0                	test   %eax,%eax
  801ae4:	75 1a                	jne    801b00 <__umoddi3+0x48>
  801ae6:	39 f7                	cmp    %esi,%edi
  801ae8:	0f 86 a2 00 00 00    	jbe    801b90 <__umoddi3+0xd8>
  801aee:	89 c8                	mov    %ecx,%eax
  801af0:	89 f2                	mov    %esi,%edx
  801af2:	f7 f7                	div    %edi
  801af4:	89 d0                	mov    %edx,%eax
  801af6:	31 d2                	xor    %edx,%edx
  801af8:	83 c4 1c             	add    $0x1c,%esp
  801afb:	5b                   	pop    %ebx
  801afc:	5e                   	pop    %esi
  801afd:	5f                   	pop    %edi
  801afe:	5d                   	pop    %ebp
  801aff:	c3                   	ret    
  801b00:	39 f0                	cmp    %esi,%eax
  801b02:	0f 87 ac 00 00 00    	ja     801bb4 <__umoddi3+0xfc>
  801b08:	0f bd e8             	bsr    %eax,%ebp
  801b0b:	83 f5 1f             	xor    $0x1f,%ebp
  801b0e:	0f 84 ac 00 00 00    	je     801bc0 <__umoddi3+0x108>
  801b14:	bf 20 00 00 00       	mov    $0x20,%edi
  801b19:	29 ef                	sub    %ebp,%edi
  801b1b:	89 fe                	mov    %edi,%esi
  801b1d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b21:	89 e9                	mov    %ebp,%ecx
  801b23:	d3 e0                	shl    %cl,%eax
  801b25:	89 d7                	mov    %edx,%edi
  801b27:	89 f1                	mov    %esi,%ecx
  801b29:	d3 ef                	shr    %cl,%edi
  801b2b:	09 c7                	or     %eax,%edi
  801b2d:	89 e9                	mov    %ebp,%ecx
  801b2f:	d3 e2                	shl    %cl,%edx
  801b31:	89 14 24             	mov    %edx,(%esp)
  801b34:	89 d8                	mov    %ebx,%eax
  801b36:	d3 e0                	shl    %cl,%eax
  801b38:	89 c2                	mov    %eax,%edx
  801b3a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b3e:	d3 e0                	shl    %cl,%eax
  801b40:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b44:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b48:	89 f1                	mov    %esi,%ecx
  801b4a:	d3 e8                	shr    %cl,%eax
  801b4c:	09 d0                	or     %edx,%eax
  801b4e:	d3 eb                	shr    %cl,%ebx
  801b50:	89 da                	mov    %ebx,%edx
  801b52:	f7 f7                	div    %edi
  801b54:	89 d3                	mov    %edx,%ebx
  801b56:	f7 24 24             	mull   (%esp)
  801b59:	89 c6                	mov    %eax,%esi
  801b5b:	89 d1                	mov    %edx,%ecx
  801b5d:	39 d3                	cmp    %edx,%ebx
  801b5f:	0f 82 87 00 00 00    	jb     801bec <__umoddi3+0x134>
  801b65:	0f 84 91 00 00 00    	je     801bfc <__umoddi3+0x144>
  801b6b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b6f:	29 f2                	sub    %esi,%edx
  801b71:	19 cb                	sbb    %ecx,%ebx
  801b73:	89 d8                	mov    %ebx,%eax
  801b75:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b79:	d3 e0                	shl    %cl,%eax
  801b7b:	89 e9                	mov    %ebp,%ecx
  801b7d:	d3 ea                	shr    %cl,%edx
  801b7f:	09 d0                	or     %edx,%eax
  801b81:	89 e9                	mov    %ebp,%ecx
  801b83:	d3 eb                	shr    %cl,%ebx
  801b85:	89 da                	mov    %ebx,%edx
  801b87:	83 c4 1c             	add    $0x1c,%esp
  801b8a:	5b                   	pop    %ebx
  801b8b:	5e                   	pop    %esi
  801b8c:	5f                   	pop    %edi
  801b8d:	5d                   	pop    %ebp
  801b8e:	c3                   	ret    
  801b8f:	90                   	nop
  801b90:	89 fd                	mov    %edi,%ebp
  801b92:	85 ff                	test   %edi,%edi
  801b94:	75 0b                	jne    801ba1 <__umoddi3+0xe9>
  801b96:	b8 01 00 00 00       	mov    $0x1,%eax
  801b9b:	31 d2                	xor    %edx,%edx
  801b9d:	f7 f7                	div    %edi
  801b9f:	89 c5                	mov    %eax,%ebp
  801ba1:	89 f0                	mov    %esi,%eax
  801ba3:	31 d2                	xor    %edx,%edx
  801ba5:	f7 f5                	div    %ebp
  801ba7:	89 c8                	mov    %ecx,%eax
  801ba9:	f7 f5                	div    %ebp
  801bab:	89 d0                	mov    %edx,%eax
  801bad:	e9 44 ff ff ff       	jmp    801af6 <__umoddi3+0x3e>
  801bb2:	66 90                	xchg   %ax,%ax
  801bb4:	89 c8                	mov    %ecx,%eax
  801bb6:	89 f2                	mov    %esi,%edx
  801bb8:	83 c4 1c             	add    $0x1c,%esp
  801bbb:	5b                   	pop    %ebx
  801bbc:	5e                   	pop    %esi
  801bbd:	5f                   	pop    %edi
  801bbe:	5d                   	pop    %ebp
  801bbf:	c3                   	ret    
  801bc0:	3b 04 24             	cmp    (%esp),%eax
  801bc3:	72 06                	jb     801bcb <__umoddi3+0x113>
  801bc5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801bc9:	77 0f                	ja     801bda <__umoddi3+0x122>
  801bcb:	89 f2                	mov    %esi,%edx
  801bcd:	29 f9                	sub    %edi,%ecx
  801bcf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801bd3:	89 14 24             	mov    %edx,(%esp)
  801bd6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bda:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bde:	8b 14 24             	mov    (%esp),%edx
  801be1:	83 c4 1c             	add    $0x1c,%esp
  801be4:	5b                   	pop    %ebx
  801be5:	5e                   	pop    %esi
  801be6:	5f                   	pop    %edi
  801be7:	5d                   	pop    %ebp
  801be8:	c3                   	ret    
  801be9:	8d 76 00             	lea    0x0(%esi),%esi
  801bec:	2b 04 24             	sub    (%esp),%eax
  801bef:	19 fa                	sbb    %edi,%edx
  801bf1:	89 d1                	mov    %edx,%ecx
  801bf3:	89 c6                	mov    %eax,%esi
  801bf5:	e9 71 ff ff ff       	jmp    801b6b <__umoddi3+0xb3>
  801bfa:	66 90                	xchg   %ax,%ax
  801bfc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c00:	72 ea                	jb     801bec <__umoddi3+0x134>
  801c02:	89 d9                	mov    %ebx,%ecx
  801c04:	e9 62 ff ff ff       	jmp    801b6b <__umoddi3+0xb3>

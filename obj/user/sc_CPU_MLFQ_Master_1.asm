
obj/user/sc_CPU_MLFQ_Master_1:     file format elf32-i386


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
  800031:	e8 8b 00 00 00       	call   8000c1 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int ID;
	for (int i = 0; i < 5; ++i) {
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 5e                	jmp    8000a5 <_main+0x6d>
			ID = sys_create_env("tmlfq_1", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
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
  80006a:	68 c0 1b 80 00       	push   $0x801bc0
  80006f:	e8 7f 15 00 00       	call   8015f3 <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)
			if (ID == E_ENV_CREATION_ERROR)
  80007a:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  80007e:	75 14                	jne    800094 <_main+0x5c>
				panic("RUNNING OUT OF ENV!! terminating...");
  800080:	83 ec 04             	sub    $0x4,%esp
  800083:	68 c8 1b 80 00       	push   $0x801bc8
  800088:	6a 0a                	push   $0xa
  80008a:	68 ec 1b 80 00       	push   $0x801bec
  80008f:	e8 72 01 00 00       	call   800206 <_panic>
			sys_run_env(ID);
  800094:	83 ec 0c             	sub    $0xc,%esp
  800097:	ff 75 f0             	pushl  -0x10(%ebp)
  80009a:	e8 72 15 00 00       	call   801611 <sys_run_env>
  80009f:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 5; ++i) {
  8000a2:	ff 45 f4             	incl   -0xc(%ebp)
  8000a5:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
  8000a9:	7e 9c                	jle    800047 <_main+0xf>
				panic("RUNNING OUT OF ENV!! terminating...");
			sys_run_env(ID);
		}

		//env_sleep(80000);
		int x = busy_wait(50000000);
  8000ab:	83 ec 0c             	sub    $0xc,%esp
  8000ae:	68 80 f0 fa 02       	push   $0x2faf080
  8000b3:	e8 6c 18 00 00       	call   801924 <busy_wait>
  8000b8:	83 c4 10             	add    $0x10,%esp
  8000bb:	89 45 ec             	mov    %eax,-0x14(%ebp)

}
  8000be:	90                   	nop
  8000bf:	c9                   	leave  
  8000c0:	c3                   	ret    

008000c1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c1:	55                   	push   %ebp
  8000c2:	89 e5                	mov    %esp,%ebp
  8000c4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000c7:	e8 07 12 00 00       	call   8012d3 <sys_getenvindex>
  8000cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d2:	89 d0                	mov    %edx,%eax
  8000d4:	c1 e0 03             	shl    $0x3,%eax
  8000d7:	01 d0                	add    %edx,%eax
  8000d9:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000e0:	01 c8                	add    %ecx,%eax
  8000e2:	01 c0                	add    %eax,%eax
  8000e4:	01 d0                	add    %edx,%eax
  8000e6:	01 c0                	add    %eax,%eax
  8000e8:	01 d0                	add    %edx,%eax
  8000ea:	89 c2                	mov    %eax,%edx
  8000ec:	c1 e2 05             	shl    $0x5,%edx
  8000ef:	29 c2                	sub    %eax,%edx
  8000f1:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8000f8:	89 c2                	mov    %eax,%edx
  8000fa:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800100:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800105:	a1 20 30 80 00       	mov    0x803020,%eax
  80010a:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800110:	84 c0                	test   %al,%al
  800112:	74 0f                	je     800123 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	05 40 3c 01 00       	add    $0x13c40,%eax
  80011e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800123:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800127:	7e 0a                	jle    800133 <libmain+0x72>
		binaryname = argv[0];
  800129:	8b 45 0c             	mov    0xc(%ebp),%eax
  80012c:	8b 00                	mov    (%eax),%eax
  80012e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800133:	83 ec 08             	sub    $0x8,%esp
  800136:	ff 75 0c             	pushl  0xc(%ebp)
  800139:	ff 75 08             	pushl  0x8(%ebp)
  80013c:	e8 f7 fe ff ff       	call   800038 <_main>
  800141:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800144:	e8 25 13 00 00       	call   80146e <sys_disable_interrupt>
	cprintf("**************************************\n");
  800149:	83 ec 0c             	sub    $0xc,%esp
  80014c:	68 20 1c 80 00       	push   $0x801c20
  800151:	e8 52 03 00 00       	call   8004a8 <cprintf>
  800156:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800159:	a1 20 30 80 00       	mov    0x803020,%eax
  80015e:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800164:	a1 20 30 80 00       	mov    0x803020,%eax
  800169:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80016f:	83 ec 04             	sub    $0x4,%esp
  800172:	52                   	push   %edx
  800173:	50                   	push   %eax
  800174:	68 48 1c 80 00       	push   $0x801c48
  800179:	e8 2a 03 00 00       	call   8004a8 <cprintf>
  80017e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800181:	a1 20 30 80 00       	mov    0x803020,%eax
  800186:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80018c:	a1 20 30 80 00       	mov    0x803020,%eax
  800191:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800197:	83 ec 04             	sub    $0x4,%esp
  80019a:	52                   	push   %edx
  80019b:	50                   	push   %eax
  80019c:	68 70 1c 80 00       	push   $0x801c70
  8001a1:	e8 02 03 00 00       	call   8004a8 <cprintf>
  8001a6:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ae:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8001b4:	83 ec 08             	sub    $0x8,%esp
  8001b7:	50                   	push   %eax
  8001b8:	68 b1 1c 80 00       	push   $0x801cb1
  8001bd:	e8 e6 02 00 00       	call   8004a8 <cprintf>
  8001c2:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 20 1c 80 00       	push   $0x801c20
  8001cd:	e8 d6 02 00 00       	call   8004a8 <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001d5:	e8 ae 12 00 00       	call   801488 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001da:	e8 19 00 00 00       	call   8001f8 <exit>
}
  8001df:	90                   	nop
  8001e0:	c9                   	leave  
  8001e1:	c3                   	ret    

008001e2 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001e2:	55                   	push   %ebp
  8001e3:	89 e5                	mov    %esp,%ebp
  8001e5:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001e8:	83 ec 0c             	sub    $0xc,%esp
  8001eb:	6a 00                	push   $0x0
  8001ed:	e8 ad 10 00 00       	call   80129f <sys_env_destroy>
  8001f2:	83 c4 10             	add    $0x10,%esp
}
  8001f5:	90                   	nop
  8001f6:	c9                   	leave  
  8001f7:	c3                   	ret    

008001f8 <exit>:

void
exit(void)
{
  8001f8:	55                   	push   %ebp
  8001f9:	89 e5                	mov    %esp,%ebp
  8001fb:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001fe:	e8 02 11 00 00       	call   801305 <sys_env_exit>
}
  800203:	90                   	nop
  800204:	c9                   	leave  
  800205:	c3                   	ret    

00800206 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800206:	55                   	push   %ebp
  800207:	89 e5                	mov    %esp,%ebp
  800209:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80020c:	8d 45 10             	lea    0x10(%ebp),%eax
  80020f:	83 c0 04             	add    $0x4,%eax
  800212:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800215:	a1 18 31 80 00       	mov    0x803118,%eax
  80021a:	85 c0                	test   %eax,%eax
  80021c:	74 16                	je     800234 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80021e:	a1 18 31 80 00       	mov    0x803118,%eax
  800223:	83 ec 08             	sub    $0x8,%esp
  800226:	50                   	push   %eax
  800227:	68 c8 1c 80 00       	push   $0x801cc8
  80022c:	e8 77 02 00 00       	call   8004a8 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800234:	a1 00 30 80 00       	mov    0x803000,%eax
  800239:	ff 75 0c             	pushl  0xc(%ebp)
  80023c:	ff 75 08             	pushl  0x8(%ebp)
  80023f:	50                   	push   %eax
  800240:	68 cd 1c 80 00       	push   $0x801ccd
  800245:	e8 5e 02 00 00       	call   8004a8 <cprintf>
  80024a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80024d:	8b 45 10             	mov    0x10(%ebp),%eax
  800250:	83 ec 08             	sub    $0x8,%esp
  800253:	ff 75 f4             	pushl  -0xc(%ebp)
  800256:	50                   	push   %eax
  800257:	e8 e1 01 00 00       	call   80043d <vcprintf>
  80025c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80025f:	83 ec 08             	sub    $0x8,%esp
  800262:	6a 00                	push   $0x0
  800264:	68 e9 1c 80 00       	push   $0x801ce9
  800269:	e8 cf 01 00 00       	call   80043d <vcprintf>
  80026e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800271:	e8 82 ff ff ff       	call   8001f8 <exit>

	// should not return here
	while (1) ;
  800276:	eb fe                	jmp    800276 <_panic+0x70>

00800278 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800278:	55                   	push   %ebp
  800279:	89 e5                	mov    %esp,%ebp
  80027b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80027e:	a1 20 30 80 00       	mov    0x803020,%eax
  800283:	8b 50 74             	mov    0x74(%eax),%edx
  800286:	8b 45 0c             	mov    0xc(%ebp),%eax
  800289:	39 c2                	cmp    %eax,%edx
  80028b:	74 14                	je     8002a1 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80028d:	83 ec 04             	sub    $0x4,%esp
  800290:	68 ec 1c 80 00       	push   $0x801cec
  800295:	6a 26                	push   $0x26
  800297:	68 38 1d 80 00       	push   $0x801d38
  80029c:	e8 65 ff ff ff       	call   800206 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002af:	e9 b6 00 00 00       	jmp    80036a <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8002b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002be:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c1:	01 d0                	add    %edx,%eax
  8002c3:	8b 00                	mov    (%eax),%eax
  8002c5:	85 c0                	test   %eax,%eax
  8002c7:	75 08                	jne    8002d1 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8002c9:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8002cc:	e9 96 00 00 00       	jmp    800367 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8002d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002d8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002df:	eb 5d                	jmp    80033e <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8002e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002ec:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002ef:	c1 e2 04             	shl    $0x4,%edx
  8002f2:	01 d0                	add    %edx,%eax
  8002f4:	8a 40 04             	mov    0x4(%eax),%al
  8002f7:	84 c0                	test   %al,%al
  8002f9:	75 40                	jne    80033b <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800300:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800306:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800309:	c1 e2 04             	shl    $0x4,%edx
  80030c:	01 d0                	add    %edx,%eax
  80030e:	8b 00                	mov    (%eax),%eax
  800310:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800313:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800316:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80031b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80031d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800320:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800327:	8b 45 08             	mov    0x8(%ebp),%eax
  80032a:	01 c8                	add    %ecx,%eax
  80032c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80032e:	39 c2                	cmp    %eax,%edx
  800330:	75 09                	jne    80033b <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800332:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800339:	eb 12                	jmp    80034d <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80033b:	ff 45 e8             	incl   -0x18(%ebp)
  80033e:	a1 20 30 80 00       	mov    0x803020,%eax
  800343:	8b 50 74             	mov    0x74(%eax),%edx
  800346:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800349:	39 c2                	cmp    %eax,%edx
  80034b:	77 94                	ja     8002e1 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80034d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800351:	75 14                	jne    800367 <CheckWSWithoutLastIndex+0xef>
			panic(
  800353:	83 ec 04             	sub    $0x4,%esp
  800356:	68 44 1d 80 00       	push   $0x801d44
  80035b:	6a 3a                	push   $0x3a
  80035d:	68 38 1d 80 00       	push   $0x801d38
  800362:	e8 9f fe ff ff       	call   800206 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800367:	ff 45 f0             	incl   -0x10(%ebp)
  80036a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80036d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800370:	0f 8c 3e ff ff ff    	jl     8002b4 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800376:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80037d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800384:	eb 20                	jmp    8003a6 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800386:	a1 20 30 80 00       	mov    0x803020,%eax
  80038b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800391:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800394:	c1 e2 04             	shl    $0x4,%edx
  800397:	01 d0                	add    %edx,%eax
  800399:	8a 40 04             	mov    0x4(%eax),%al
  80039c:	3c 01                	cmp    $0x1,%al
  80039e:	75 03                	jne    8003a3 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8003a0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003a3:	ff 45 e0             	incl   -0x20(%ebp)
  8003a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ab:	8b 50 74             	mov    0x74(%eax),%edx
  8003ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003b1:	39 c2                	cmp    %eax,%edx
  8003b3:	77 d1                	ja     800386 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003b8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8003bb:	74 14                	je     8003d1 <CheckWSWithoutLastIndex+0x159>
		panic(
  8003bd:	83 ec 04             	sub    $0x4,%esp
  8003c0:	68 98 1d 80 00       	push   $0x801d98
  8003c5:	6a 44                	push   $0x44
  8003c7:	68 38 1d 80 00       	push   $0x801d38
  8003cc:	e8 35 fe ff ff       	call   800206 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8003d1:	90                   	nop
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8003da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003dd:	8b 00                	mov    (%eax),%eax
  8003df:	8d 48 01             	lea    0x1(%eax),%ecx
  8003e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003e5:	89 0a                	mov    %ecx,(%edx)
  8003e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8003ea:	88 d1                	mov    %dl,%cl
  8003ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003ef:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8003f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f6:	8b 00                	mov    (%eax),%eax
  8003f8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003fd:	75 2c                	jne    80042b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8003ff:	a0 24 30 80 00       	mov    0x803024,%al
  800404:	0f b6 c0             	movzbl %al,%eax
  800407:	8b 55 0c             	mov    0xc(%ebp),%edx
  80040a:	8b 12                	mov    (%edx),%edx
  80040c:	89 d1                	mov    %edx,%ecx
  80040e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800411:	83 c2 08             	add    $0x8,%edx
  800414:	83 ec 04             	sub    $0x4,%esp
  800417:	50                   	push   %eax
  800418:	51                   	push   %ecx
  800419:	52                   	push   %edx
  80041a:	e8 3e 0e 00 00       	call   80125d <sys_cputs>
  80041f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800422:	8b 45 0c             	mov    0xc(%ebp),%eax
  800425:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80042b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80042e:	8b 40 04             	mov    0x4(%eax),%eax
  800431:	8d 50 01             	lea    0x1(%eax),%edx
  800434:	8b 45 0c             	mov    0xc(%ebp),%eax
  800437:	89 50 04             	mov    %edx,0x4(%eax)
}
  80043a:	90                   	nop
  80043b:	c9                   	leave  
  80043c:	c3                   	ret    

0080043d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80043d:	55                   	push   %ebp
  80043e:	89 e5                	mov    %esp,%ebp
  800440:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800446:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80044d:	00 00 00 
	b.cnt = 0;
  800450:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800457:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80045a:	ff 75 0c             	pushl  0xc(%ebp)
  80045d:	ff 75 08             	pushl  0x8(%ebp)
  800460:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800466:	50                   	push   %eax
  800467:	68 d4 03 80 00       	push   $0x8003d4
  80046c:	e8 11 02 00 00       	call   800682 <vprintfmt>
  800471:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800474:	a0 24 30 80 00       	mov    0x803024,%al
  800479:	0f b6 c0             	movzbl %al,%eax
  80047c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800482:	83 ec 04             	sub    $0x4,%esp
  800485:	50                   	push   %eax
  800486:	52                   	push   %edx
  800487:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80048d:	83 c0 08             	add    $0x8,%eax
  800490:	50                   	push   %eax
  800491:	e8 c7 0d 00 00       	call   80125d <sys_cputs>
  800496:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800499:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8004a0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004a6:	c9                   	leave  
  8004a7:	c3                   	ret    

008004a8 <cprintf>:

int cprintf(const char *fmt, ...) {
  8004a8:	55                   	push   %ebp
  8004a9:	89 e5                	mov    %esp,%ebp
  8004ab:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004ae:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8004b5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004be:	83 ec 08             	sub    $0x8,%esp
  8004c1:	ff 75 f4             	pushl  -0xc(%ebp)
  8004c4:	50                   	push   %eax
  8004c5:	e8 73 ff ff ff       	call   80043d <vcprintf>
  8004ca:	83 c4 10             	add    $0x10,%esp
  8004cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8004d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004d3:	c9                   	leave  
  8004d4:	c3                   	ret    

008004d5 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8004d5:	55                   	push   %ebp
  8004d6:	89 e5                	mov    %esp,%ebp
  8004d8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8004db:	e8 8e 0f 00 00       	call   80146e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8004e0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e9:	83 ec 08             	sub    $0x8,%esp
  8004ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ef:	50                   	push   %eax
  8004f0:	e8 48 ff ff ff       	call   80043d <vcprintf>
  8004f5:	83 c4 10             	add    $0x10,%esp
  8004f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8004fb:	e8 88 0f 00 00       	call   801488 <sys_enable_interrupt>
	return cnt;
  800500:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800503:	c9                   	leave  
  800504:	c3                   	ret    

00800505 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800505:	55                   	push   %ebp
  800506:	89 e5                	mov    %esp,%ebp
  800508:	53                   	push   %ebx
  800509:	83 ec 14             	sub    $0x14,%esp
  80050c:	8b 45 10             	mov    0x10(%ebp),%eax
  80050f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800512:	8b 45 14             	mov    0x14(%ebp),%eax
  800515:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800518:	8b 45 18             	mov    0x18(%ebp),%eax
  80051b:	ba 00 00 00 00       	mov    $0x0,%edx
  800520:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800523:	77 55                	ja     80057a <printnum+0x75>
  800525:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800528:	72 05                	jb     80052f <printnum+0x2a>
  80052a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80052d:	77 4b                	ja     80057a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80052f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800532:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800535:	8b 45 18             	mov    0x18(%ebp),%eax
  800538:	ba 00 00 00 00       	mov    $0x0,%edx
  80053d:	52                   	push   %edx
  80053e:	50                   	push   %eax
  80053f:	ff 75 f4             	pushl  -0xc(%ebp)
  800542:	ff 75 f0             	pushl  -0x10(%ebp)
  800545:	e8 fa 13 00 00       	call   801944 <__udivdi3>
  80054a:	83 c4 10             	add    $0x10,%esp
  80054d:	83 ec 04             	sub    $0x4,%esp
  800550:	ff 75 20             	pushl  0x20(%ebp)
  800553:	53                   	push   %ebx
  800554:	ff 75 18             	pushl  0x18(%ebp)
  800557:	52                   	push   %edx
  800558:	50                   	push   %eax
  800559:	ff 75 0c             	pushl  0xc(%ebp)
  80055c:	ff 75 08             	pushl  0x8(%ebp)
  80055f:	e8 a1 ff ff ff       	call   800505 <printnum>
  800564:	83 c4 20             	add    $0x20,%esp
  800567:	eb 1a                	jmp    800583 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800569:	83 ec 08             	sub    $0x8,%esp
  80056c:	ff 75 0c             	pushl  0xc(%ebp)
  80056f:	ff 75 20             	pushl  0x20(%ebp)
  800572:	8b 45 08             	mov    0x8(%ebp),%eax
  800575:	ff d0                	call   *%eax
  800577:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80057a:	ff 4d 1c             	decl   0x1c(%ebp)
  80057d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800581:	7f e6                	jg     800569 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800583:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800586:	bb 00 00 00 00       	mov    $0x0,%ebx
  80058b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80058e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800591:	53                   	push   %ebx
  800592:	51                   	push   %ecx
  800593:	52                   	push   %edx
  800594:	50                   	push   %eax
  800595:	e8 ba 14 00 00       	call   801a54 <__umoddi3>
  80059a:	83 c4 10             	add    $0x10,%esp
  80059d:	05 14 20 80 00       	add    $0x802014,%eax
  8005a2:	8a 00                	mov    (%eax),%al
  8005a4:	0f be c0             	movsbl %al,%eax
  8005a7:	83 ec 08             	sub    $0x8,%esp
  8005aa:	ff 75 0c             	pushl  0xc(%ebp)
  8005ad:	50                   	push   %eax
  8005ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b1:	ff d0                	call   *%eax
  8005b3:	83 c4 10             	add    $0x10,%esp
}
  8005b6:	90                   	nop
  8005b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005ba:	c9                   	leave  
  8005bb:	c3                   	ret    

008005bc <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8005bc:	55                   	push   %ebp
  8005bd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005bf:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005c3:	7e 1c                	jle    8005e1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8005c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	8d 50 08             	lea    0x8(%eax),%edx
  8005cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d0:	89 10                	mov    %edx,(%eax)
  8005d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d5:	8b 00                	mov    (%eax),%eax
  8005d7:	83 e8 08             	sub    $0x8,%eax
  8005da:	8b 50 04             	mov    0x4(%eax),%edx
  8005dd:	8b 00                	mov    (%eax),%eax
  8005df:	eb 40                	jmp    800621 <getuint+0x65>
	else if (lflag)
  8005e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005e5:	74 1e                	je     800605 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ea:	8b 00                	mov    (%eax),%eax
  8005ec:	8d 50 04             	lea    0x4(%eax),%edx
  8005ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f2:	89 10                	mov    %edx,(%eax)
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	8b 00                	mov    (%eax),%eax
  8005f9:	83 e8 04             	sub    $0x4,%eax
  8005fc:	8b 00                	mov    (%eax),%eax
  8005fe:	ba 00 00 00 00       	mov    $0x0,%edx
  800603:	eb 1c                	jmp    800621 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800605:	8b 45 08             	mov    0x8(%ebp),%eax
  800608:	8b 00                	mov    (%eax),%eax
  80060a:	8d 50 04             	lea    0x4(%eax),%edx
  80060d:	8b 45 08             	mov    0x8(%ebp),%eax
  800610:	89 10                	mov    %edx,(%eax)
  800612:	8b 45 08             	mov    0x8(%ebp),%eax
  800615:	8b 00                	mov    (%eax),%eax
  800617:	83 e8 04             	sub    $0x4,%eax
  80061a:	8b 00                	mov    (%eax),%eax
  80061c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800621:	5d                   	pop    %ebp
  800622:	c3                   	ret    

00800623 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800623:	55                   	push   %ebp
  800624:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800626:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80062a:	7e 1c                	jle    800648 <getint+0x25>
		return va_arg(*ap, long long);
  80062c:	8b 45 08             	mov    0x8(%ebp),%eax
  80062f:	8b 00                	mov    (%eax),%eax
  800631:	8d 50 08             	lea    0x8(%eax),%edx
  800634:	8b 45 08             	mov    0x8(%ebp),%eax
  800637:	89 10                	mov    %edx,(%eax)
  800639:	8b 45 08             	mov    0x8(%ebp),%eax
  80063c:	8b 00                	mov    (%eax),%eax
  80063e:	83 e8 08             	sub    $0x8,%eax
  800641:	8b 50 04             	mov    0x4(%eax),%edx
  800644:	8b 00                	mov    (%eax),%eax
  800646:	eb 38                	jmp    800680 <getint+0x5d>
	else if (lflag)
  800648:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80064c:	74 1a                	je     800668 <getint+0x45>
		return va_arg(*ap, long);
  80064e:	8b 45 08             	mov    0x8(%ebp),%eax
  800651:	8b 00                	mov    (%eax),%eax
  800653:	8d 50 04             	lea    0x4(%eax),%edx
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	89 10                	mov    %edx,(%eax)
  80065b:	8b 45 08             	mov    0x8(%ebp),%eax
  80065e:	8b 00                	mov    (%eax),%eax
  800660:	83 e8 04             	sub    $0x4,%eax
  800663:	8b 00                	mov    (%eax),%eax
  800665:	99                   	cltd   
  800666:	eb 18                	jmp    800680 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800668:	8b 45 08             	mov    0x8(%ebp),%eax
  80066b:	8b 00                	mov    (%eax),%eax
  80066d:	8d 50 04             	lea    0x4(%eax),%edx
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	89 10                	mov    %edx,(%eax)
  800675:	8b 45 08             	mov    0x8(%ebp),%eax
  800678:	8b 00                	mov    (%eax),%eax
  80067a:	83 e8 04             	sub    $0x4,%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	99                   	cltd   
}
  800680:	5d                   	pop    %ebp
  800681:	c3                   	ret    

00800682 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800682:	55                   	push   %ebp
  800683:	89 e5                	mov    %esp,%ebp
  800685:	56                   	push   %esi
  800686:	53                   	push   %ebx
  800687:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80068a:	eb 17                	jmp    8006a3 <vprintfmt+0x21>
			if (ch == '\0')
  80068c:	85 db                	test   %ebx,%ebx
  80068e:	0f 84 af 03 00 00    	je     800a43 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800694:	83 ec 08             	sub    $0x8,%esp
  800697:	ff 75 0c             	pushl  0xc(%ebp)
  80069a:	53                   	push   %ebx
  80069b:	8b 45 08             	mov    0x8(%ebp),%eax
  80069e:	ff d0                	call   *%eax
  8006a0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8006a6:	8d 50 01             	lea    0x1(%eax),%edx
  8006a9:	89 55 10             	mov    %edx,0x10(%ebp)
  8006ac:	8a 00                	mov    (%eax),%al
  8006ae:	0f b6 d8             	movzbl %al,%ebx
  8006b1:	83 fb 25             	cmp    $0x25,%ebx
  8006b4:	75 d6                	jne    80068c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006b6:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8006ba:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8006c1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8006c8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8006cf:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8006d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8006d9:	8d 50 01             	lea    0x1(%eax),%edx
  8006dc:	89 55 10             	mov    %edx,0x10(%ebp)
  8006df:	8a 00                	mov    (%eax),%al
  8006e1:	0f b6 d8             	movzbl %al,%ebx
  8006e4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006e7:	83 f8 55             	cmp    $0x55,%eax
  8006ea:	0f 87 2b 03 00 00    	ja     800a1b <vprintfmt+0x399>
  8006f0:	8b 04 85 38 20 80 00 	mov    0x802038(,%eax,4),%eax
  8006f7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006f9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006fd:	eb d7                	jmp    8006d6 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006ff:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800703:	eb d1                	jmp    8006d6 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800705:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80070c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80070f:	89 d0                	mov    %edx,%eax
  800711:	c1 e0 02             	shl    $0x2,%eax
  800714:	01 d0                	add    %edx,%eax
  800716:	01 c0                	add    %eax,%eax
  800718:	01 d8                	add    %ebx,%eax
  80071a:	83 e8 30             	sub    $0x30,%eax
  80071d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800720:	8b 45 10             	mov    0x10(%ebp),%eax
  800723:	8a 00                	mov    (%eax),%al
  800725:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800728:	83 fb 2f             	cmp    $0x2f,%ebx
  80072b:	7e 3e                	jle    80076b <vprintfmt+0xe9>
  80072d:	83 fb 39             	cmp    $0x39,%ebx
  800730:	7f 39                	jg     80076b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800732:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800735:	eb d5                	jmp    80070c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800737:	8b 45 14             	mov    0x14(%ebp),%eax
  80073a:	83 c0 04             	add    $0x4,%eax
  80073d:	89 45 14             	mov    %eax,0x14(%ebp)
  800740:	8b 45 14             	mov    0x14(%ebp),%eax
  800743:	83 e8 04             	sub    $0x4,%eax
  800746:	8b 00                	mov    (%eax),%eax
  800748:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80074b:	eb 1f                	jmp    80076c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80074d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800751:	79 83                	jns    8006d6 <vprintfmt+0x54>
				width = 0;
  800753:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80075a:	e9 77 ff ff ff       	jmp    8006d6 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80075f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800766:	e9 6b ff ff ff       	jmp    8006d6 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80076b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80076c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800770:	0f 89 60 ff ff ff    	jns    8006d6 <vprintfmt+0x54>
				width = precision, precision = -1;
  800776:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800779:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80077c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800783:	e9 4e ff ff ff       	jmp    8006d6 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800788:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80078b:	e9 46 ff ff ff       	jmp    8006d6 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800790:	8b 45 14             	mov    0x14(%ebp),%eax
  800793:	83 c0 04             	add    $0x4,%eax
  800796:	89 45 14             	mov    %eax,0x14(%ebp)
  800799:	8b 45 14             	mov    0x14(%ebp),%eax
  80079c:	83 e8 04             	sub    $0x4,%eax
  80079f:	8b 00                	mov    (%eax),%eax
  8007a1:	83 ec 08             	sub    $0x8,%esp
  8007a4:	ff 75 0c             	pushl  0xc(%ebp)
  8007a7:	50                   	push   %eax
  8007a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ab:	ff d0                	call   *%eax
  8007ad:	83 c4 10             	add    $0x10,%esp
			break;
  8007b0:	e9 89 02 00 00       	jmp    800a3e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b8:	83 c0 04             	add    $0x4,%eax
  8007bb:	89 45 14             	mov    %eax,0x14(%ebp)
  8007be:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c1:	83 e8 04             	sub    $0x4,%eax
  8007c4:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8007c6:	85 db                	test   %ebx,%ebx
  8007c8:	79 02                	jns    8007cc <vprintfmt+0x14a>
				err = -err;
  8007ca:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8007cc:	83 fb 64             	cmp    $0x64,%ebx
  8007cf:	7f 0b                	jg     8007dc <vprintfmt+0x15a>
  8007d1:	8b 34 9d 80 1e 80 00 	mov    0x801e80(,%ebx,4),%esi
  8007d8:	85 f6                	test   %esi,%esi
  8007da:	75 19                	jne    8007f5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8007dc:	53                   	push   %ebx
  8007dd:	68 25 20 80 00       	push   $0x802025
  8007e2:	ff 75 0c             	pushl  0xc(%ebp)
  8007e5:	ff 75 08             	pushl  0x8(%ebp)
  8007e8:	e8 5e 02 00 00       	call   800a4b <printfmt>
  8007ed:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007f0:	e9 49 02 00 00       	jmp    800a3e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007f5:	56                   	push   %esi
  8007f6:	68 2e 20 80 00       	push   $0x80202e
  8007fb:	ff 75 0c             	pushl  0xc(%ebp)
  8007fe:	ff 75 08             	pushl  0x8(%ebp)
  800801:	e8 45 02 00 00       	call   800a4b <printfmt>
  800806:	83 c4 10             	add    $0x10,%esp
			break;
  800809:	e9 30 02 00 00       	jmp    800a3e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80080e:	8b 45 14             	mov    0x14(%ebp),%eax
  800811:	83 c0 04             	add    $0x4,%eax
  800814:	89 45 14             	mov    %eax,0x14(%ebp)
  800817:	8b 45 14             	mov    0x14(%ebp),%eax
  80081a:	83 e8 04             	sub    $0x4,%eax
  80081d:	8b 30                	mov    (%eax),%esi
  80081f:	85 f6                	test   %esi,%esi
  800821:	75 05                	jne    800828 <vprintfmt+0x1a6>
				p = "(null)";
  800823:	be 31 20 80 00       	mov    $0x802031,%esi
			if (width > 0 && padc != '-')
  800828:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80082c:	7e 6d                	jle    80089b <vprintfmt+0x219>
  80082e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800832:	74 67                	je     80089b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800834:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800837:	83 ec 08             	sub    $0x8,%esp
  80083a:	50                   	push   %eax
  80083b:	56                   	push   %esi
  80083c:	e8 0c 03 00 00       	call   800b4d <strnlen>
  800841:	83 c4 10             	add    $0x10,%esp
  800844:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800847:	eb 16                	jmp    80085f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800849:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80084d:	83 ec 08             	sub    $0x8,%esp
  800850:	ff 75 0c             	pushl  0xc(%ebp)
  800853:	50                   	push   %eax
  800854:	8b 45 08             	mov    0x8(%ebp),%eax
  800857:	ff d0                	call   *%eax
  800859:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80085c:	ff 4d e4             	decl   -0x1c(%ebp)
  80085f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800863:	7f e4                	jg     800849 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800865:	eb 34                	jmp    80089b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800867:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80086b:	74 1c                	je     800889 <vprintfmt+0x207>
  80086d:	83 fb 1f             	cmp    $0x1f,%ebx
  800870:	7e 05                	jle    800877 <vprintfmt+0x1f5>
  800872:	83 fb 7e             	cmp    $0x7e,%ebx
  800875:	7e 12                	jle    800889 <vprintfmt+0x207>
					putch('?', putdat);
  800877:	83 ec 08             	sub    $0x8,%esp
  80087a:	ff 75 0c             	pushl  0xc(%ebp)
  80087d:	6a 3f                	push   $0x3f
  80087f:	8b 45 08             	mov    0x8(%ebp),%eax
  800882:	ff d0                	call   *%eax
  800884:	83 c4 10             	add    $0x10,%esp
  800887:	eb 0f                	jmp    800898 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800889:	83 ec 08             	sub    $0x8,%esp
  80088c:	ff 75 0c             	pushl  0xc(%ebp)
  80088f:	53                   	push   %ebx
  800890:	8b 45 08             	mov    0x8(%ebp),%eax
  800893:	ff d0                	call   *%eax
  800895:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800898:	ff 4d e4             	decl   -0x1c(%ebp)
  80089b:	89 f0                	mov    %esi,%eax
  80089d:	8d 70 01             	lea    0x1(%eax),%esi
  8008a0:	8a 00                	mov    (%eax),%al
  8008a2:	0f be d8             	movsbl %al,%ebx
  8008a5:	85 db                	test   %ebx,%ebx
  8008a7:	74 24                	je     8008cd <vprintfmt+0x24b>
  8008a9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008ad:	78 b8                	js     800867 <vprintfmt+0x1e5>
  8008af:	ff 4d e0             	decl   -0x20(%ebp)
  8008b2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008b6:	79 af                	jns    800867 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008b8:	eb 13                	jmp    8008cd <vprintfmt+0x24b>
				putch(' ', putdat);
  8008ba:	83 ec 08             	sub    $0x8,%esp
  8008bd:	ff 75 0c             	pushl  0xc(%ebp)
  8008c0:	6a 20                	push   $0x20
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	ff d0                	call   *%eax
  8008c7:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008ca:	ff 4d e4             	decl   -0x1c(%ebp)
  8008cd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d1:	7f e7                	jg     8008ba <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8008d3:	e9 66 01 00 00       	jmp    800a3e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8008d8:	83 ec 08             	sub    $0x8,%esp
  8008db:	ff 75 e8             	pushl  -0x18(%ebp)
  8008de:	8d 45 14             	lea    0x14(%ebp),%eax
  8008e1:	50                   	push   %eax
  8008e2:	e8 3c fd ff ff       	call   800623 <getint>
  8008e7:	83 c4 10             	add    $0x10,%esp
  8008ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ed:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008f6:	85 d2                	test   %edx,%edx
  8008f8:	79 23                	jns    80091d <vprintfmt+0x29b>
				putch('-', putdat);
  8008fa:	83 ec 08             	sub    $0x8,%esp
  8008fd:	ff 75 0c             	pushl  0xc(%ebp)
  800900:	6a 2d                	push   $0x2d
  800902:	8b 45 08             	mov    0x8(%ebp),%eax
  800905:	ff d0                	call   *%eax
  800907:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80090a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80090d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800910:	f7 d8                	neg    %eax
  800912:	83 d2 00             	adc    $0x0,%edx
  800915:	f7 da                	neg    %edx
  800917:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80091a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80091d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800924:	e9 bc 00 00 00       	jmp    8009e5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800929:	83 ec 08             	sub    $0x8,%esp
  80092c:	ff 75 e8             	pushl  -0x18(%ebp)
  80092f:	8d 45 14             	lea    0x14(%ebp),%eax
  800932:	50                   	push   %eax
  800933:	e8 84 fc ff ff       	call   8005bc <getuint>
  800938:	83 c4 10             	add    $0x10,%esp
  80093b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80093e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800941:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800948:	e9 98 00 00 00       	jmp    8009e5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80094d:	83 ec 08             	sub    $0x8,%esp
  800950:	ff 75 0c             	pushl  0xc(%ebp)
  800953:	6a 58                	push   $0x58
  800955:	8b 45 08             	mov    0x8(%ebp),%eax
  800958:	ff d0                	call   *%eax
  80095a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80095d:	83 ec 08             	sub    $0x8,%esp
  800960:	ff 75 0c             	pushl  0xc(%ebp)
  800963:	6a 58                	push   $0x58
  800965:	8b 45 08             	mov    0x8(%ebp),%eax
  800968:	ff d0                	call   *%eax
  80096a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80096d:	83 ec 08             	sub    $0x8,%esp
  800970:	ff 75 0c             	pushl  0xc(%ebp)
  800973:	6a 58                	push   $0x58
  800975:	8b 45 08             	mov    0x8(%ebp),%eax
  800978:	ff d0                	call   *%eax
  80097a:	83 c4 10             	add    $0x10,%esp
			break;
  80097d:	e9 bc 00 00 00       	jmp    800a3e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800982:	83 ec 08             	sub    $0x8,%esp
  800985:	ff 75 0c             	pushl  0xc(%ebp)
  800988:	6a 30                	push   $0x30
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	ff d0                	call   *%eax
  80098f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800992:	83 ec 08             	sub    $0x8,%esp
  800995:	ff 75 0c             	pushl  0xc(%ebp)
  800998:	6a 78                	push   $0x78
  80099a:	8b 45 08             	mov    0x8(%ebp),%eax
  80099d:	ff d0                	call   *%eax
  80099f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a5:	83 c0 04             	add    $0x4,%eax
  8009a8:	89 45 14             	mov    %eax,0x14(%ebp)
  8009ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ae:	83 e8 04             	sub    $0x4,%eax
  8009b1:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8009bd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8009c4:	eb 1f                	jmp    8009e5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8009c6:	83 ec 08             	sub    $0x8,%esp
  8009c9:	ff 75 e8             	pushl  -0x18(%ebp)
  8009cc:	8d 45 14             	lea    0x14(%ebp),%eax
  8009cf:	50                   	push   %eax
  8009d0:	e8 e7 fb ff ff       	call   8005bc <getuint>
  8009d5:	83 c4 10             	add    $0x10,%esp
  8009d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009db:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8009de:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009e5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009ec:	83 ec 04             	sub    $0x4,%esp
  8009ef:	52                   	push   %edx
  8009f0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009f3:	50                   	push   %eax
  8009f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f7:	ff 75 f0             	pushl  -0x10(%ebp)
  8009fa:	ff 75 0c             	pushl  0xc(%ebp)
  8009fd:	ff 75 08             	pushl  0x8(%ebp)
  800a00:	e8 00 fb ff ff       	call   800505 <printnum>
  800a05:	83 c4 20             	add    $0x20,%esp
			break;
  800a08:	eb 34                	jmp    800a3e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a0a:	83 ec 08             	sub    $0x8,%esp
  800a0d:	ff 75 0c             	pushl  0xc(%ebp)
  800a10:	53                   	push   %ebx
  800a11:	8b 45 08             	mov    0x8(%ebp),%eax
  800a14:	ff d0                	call   *%eax
  800a16:	83 c4 10             	add    $0x10,%esp
			break;
  800a19:	eb 23                	jmp    800a3e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a1b:	83 ec 08             	sub    $0x8,%esp
  800a1e:	ff 75 0c             	pushl  0xc(%ebp)
  800a21:	6a 25                	push   $0x25
  800a23:	8b 45 08             	mov    0x8(%ebp),%eax
  800a26:	ff d0                	call   *%eax
  800a28:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a2b:	ff 4d 10             	decl   0x10(%ebp)
  800a2e:	eb 03                	jmp    800a33 <vprintfmt+0x3b1>
  800a30:	ff 4d 10             	decl   0x10(%ebp)
  800a33:	8b 45 10             	mov    0x10(%ebp),%eax
  800a36:	48                   	dec    %eax
  800a37:	8a 00                	mov    (%eax),%al
  800a39:	3c 25                	cmp    $0x25,%al
  800a3b:	75 f3                	jne    800a30 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a3d:	90                   	nop
		}
	}
  800a3e:	e9 47 fc ff ff       	jmp    80068a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a43:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a44:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a47:	5b                   	pop    %ebx
  800a48:	5e                   	pop    %esi
  800a49:	5d                   	pop    %ebp
  800a4a:	c3                   	ret    

00800a4b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a4b:	55                   	push   %ebp
  800a4c:	89 e5                	mov    %esp,%ebp
  800a4e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a51:	8d 45 10             	lea    0x10(%ebp),%eax
  800a54:	83 c0 04             	add    $0x4,%eax
  800a57:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800a5d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a60:	50                   	push   %eax
  800a61:	ff 75 0c             	pushl  0xc(%ebp)
  800a64:	ff 75 08             	pushl  0x8(%ebp)
  800a67:	e8 16 fc ff ff       	call   800682 <vprintfmt>
  800a6c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a6f:	90                   	nop
  800a70:	c9                   	leave  
  800a71:	c3                   	ret    

00800a72 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a72:	55                   	push   %ebp
  800a73:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a78:	8b 40 08             	mov    0x8(%eax),%eax
  800a7b:	8d 50 01             	lea    0x1(%eax),%edx
  800a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a81:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a87:	8b 10                	mov    (%eax),%edx
  800a89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8c:	8b 40 04             	mov    0x4(%eax),%eax
  800a8f:	39 c2                	cmp    %eax,%edx
  800a91:	73 12                	jae    800aa5 <sprintputch+0x33>
		*b->buf++ = ch;
  800a93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a96:	8b 00                	mov    (%eax),%eax
  800a98:	8d 48 01             	lea    0x1(%eax),%ecx
  800a9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a9e:	89 0a                	mov    %ecx,(%edx)
  800aa0:	8b 55 08             	mov    0x8(%ebp),%edx
  800aa3:	88 10                	mov    %dl,(%eax)
}
  800aa5:	90                   	nop
  800aa6:	5d                   	pop    %ebp
  800aa7:	c3                   	ret    

00800aa8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800aa8:	55                   	push   %ebp
  800aa9:	89 e5                	mov    %esp,%ebp
  800aab:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800aae:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	01 d0                	add    %edx,%eax
  800abf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ac9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800acd:	74 06                	je     800ad5 <vsnprintf+0x2d>
  800acf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ad3:	7f 07                	jg     800adc <vsnprintf+0x34>
		return -E_INVAL;
  800ad5:	b8 03 00 00 00       	mov    $0x3,%eax
  800ada:	eb 20                	jmp    800afc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800adc:	ff 75 14             	pushl  0x14(%ebp)
  800adf:	ff 75 10             	pushl  0x10(%ebp)
  800ae2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ae5:	50                   	push   %eax
  800ae6:	68 72 0a 80 00       	push   $0x800a72
  800aeb:	e8 92 fb ff ff       	call   800682 <vprintfmt>
  800af0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800af3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800af6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800afc:	c9                   	leave  
  800afd:	c3                   	ret    

00800afe <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800afe:	55                   	push   %ebp
  800aff:	89 e5                	mov    %esp,%ebp
  800b01:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b04:	8d 45 10             	lea    0x10(%ebp),%eax
  800b07:	83 c0 04             	add    $0x4,%eax
  800b0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b10:	ff 75 f4             	pushl  -0xc(%ebp)
  800b13:	50                   	push   %eax
  800b14:	ff 75 0c             	pushl  0xc(%ebp)
  800b17:	ff 75 08             	pushl  0x8(%ebp)
  800b1a:	e8 89 ff ff ff       	call   800aa8 <vsnprintf>
  800b1f:	83 c4 10             	add    $0x10,%esp
  800b22:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b25:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b28:	c9                   	leave  
  800b29:	c3                   	ret    

00800b2a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b2a:	55                   	push   %ebp
  800b2b:	89 e5                	mov    %esp,%ebp
  800b2d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b30:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b37:	eb 06                	jmp    800b3f <strlen+0x15>
		n++;
  800b39:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b3c:	ff 45 08             	incl   0x8(%ebp)
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8a 00                	mov    (%eax),%al
  800b44:	84 c0                	test   %al,%al
  800b46:	75 f1                	jne    800b39 <strlen+0xf>
		n++;
	return n;
  800b48:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b4b:	c9                   	leave  
  800b4c:	c3                   	ret    

00800b4d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b4d:	55                   	push   %ebp
  800b4e:	89 e5                	mov    %esp,%ebp
  800b50:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b53:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b5a:	eb 09                	jmp    800b65 <strnlen+0x18>
		n++;
  800b5c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b5f:	ff 45 08             	incl   0x8(%ebp)
  800b62:	ff 4d 0c             	decl   0xc(%ebp)
  800b65:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b69:	74 09                	je     800b74 <strnlen+0x27>
  800b6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6e:	8a 00                	mov    (%eax),%al
  800b70:	84 c0                	test   %al,%al
  800b72:	75 e8                	jne    800b5c <strnlen+0xf>
		n++;
	return n;
  800b74:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b77:	c9                   	leave  
  800b78:	c3                   	ret    

00800b79 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b79:	55                   	push   %ebp
  800b7a:	89 e5                	mov    %esp,%ebp
  800b7c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b85:	90                   	nop
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	8d 50 01             	lea    0x1(%eax),%edx
  800b8c:	89 55 08             	mov    %edx,0x8(%ebp)
  800b8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b92:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b95:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b98:	8a 12                	mov    (%edx),%dl
  800b9a:	88 10                	mov    %dl,(%eax)
  800b9c:	8a 00                	mov    (%eax),%al
  800b9e:	84 c0                	test   %al,%al
  800ba0:	75 e4                	jne    800b86 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ba2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba5:	c9                   	leave  
  800ba6:	c3                   	ret    

00800ba7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ba7:	55                   	push   %ebp
  800ba8:	89 e5                	mov    %esp,%ebp
  800baa:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bad:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bb3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bba:	eb 1f                	jmp    800bdb <strncpy+0x34>
		*dst++ = *src;
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	8d 50 01             	lea    0x1(%eax),%edx
  800bc2:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc8:	8a 12                	mov    (%edx),%dl
  800bca:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bcf:	8a 00                	mov    (%eax),%al
  800bd1:	84 c0                	test   %al,%al
  800bd3:	74 03                	je     800bd8 <strncpy+0x31>
			src++;
  800bd5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bd8:	ff 45 fc             	incl   -0x4(%ebp)
  800bdb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bde:	3b 45 10             	cmp    0x10(%ebp),%eax
  800be1:	72 d9                	jb     800bbc <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800be3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800be6:	c9                   	leave  
  800be7:	c3                   	ret    

00800be8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800be8:	55                   	push   %ebp
  800be9:	89 e5                	mov    %esp,%ebp
  800beb:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bf4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bf8:	74 30                	je     800c2a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bfa:	eb 16                	jmp    800c12 <strlcpy+0x2a>
			*dst++ = *src++;
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	8d 50 01             	lea    0x1(%eax),%edx
  800c02:	89 55 08             	mov    %edx,0x8(%ebp)
  800c05:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c08:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c0b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c0e:	8a 12                	mov    (%edx),%dl
  800c10:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c12:	ff 4d 10             	decl   0x10(%ebp)
  800c15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c19:	74 09                	je     800c24 <strlcpy+0x3c>
  800c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1e:	8a 00                	mov    (%eax),%al
  800c20:	84 c0                	test   %al,%al
  800c22:	75 d8                	jne    800bfc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c2a:	8b 55 08             	mov    0x8(%ebp),%edx
  800c2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c30:	29 c2                	sub    %eax,%edx
  800c32:	89 d0                	mov    %edx,%eax
}
  800c34:	c9                   	leave  
  800c35:	c3                   	ret    

00800c36 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c36:	55                   	push   %ebp
  800c37:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c39:	eb 06                	jmp    800c41 <strcmp+0xb>
		p++, q++;
  800c3b:	ff 45 08             	incl   0x8(%ebp)
  800c3e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	8a 00                	mov    (%eax),%al
  800c46:	84 c0                	test   %al,%al
  800c48:	74 0e                	je     800c58 <strcmp+0x22>
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	8a 10                	mov    (%eax),%dl
  800c4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c52:	8a 00                	mov    (%eax),%al
  800c54:	38 c2                	cmp    %al,%dl
  800c56:	74 e3                	je     800c3b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c58:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5b:	8a 00                	mov    (%eax),%al
  800c5d:	0f b6 d0             	movzbl %al,%edx
  800c60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c63:	8a 00                	mov    (%eax),%al
  800c65:	0f b6 c0             	movzbl %al,%eax
  800c68:	29 c2                	sub    %eax,%edx
  800c6a:	89 d0                	mov    %edx,%eax
}
  800c6c:	5d                   	pop    %ebp
  800c6d:	c3                   	ret    

00800c6e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c71:	eb 09                	jmp    800c7c <strncmp+0xe>
		n--, p++, q++;
  800c73:	ff 4d 10             	decl   0x10(%ebp)
  800c76:	ff 45 08             	incl   0x8(%ebp)
  800c79:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c7c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c80:	74 17                	je     800c99 <strncmp+0x2b>
  800c82:	8b 45 08             	mov    0x8(%ebp),%eax
  800c85:	8a 00                	mov    (%eax),%al
  800c87:	84 c0                	test   %al,%al
  800c89:	74 0e                	je     800c99 <strncmp+0x2b>
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	8a 10                	mov    (%eax),%dl
  800c90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c93:	8a 00                	mov    (%eax),%al
  800c95:	38 c2                	cmp    %al,%dl
  800c97:	74 da                	je     800c73 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c99:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9d:	75 07                	jne    800ca6 <strncmp+0x38>
		return 0;
  800c9f:	b8 00 00 00 00       	mov    $0x0,%eax
  800ca4:	eb 14                	jmp    800cba <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	8a 00                	mov    (%eax),%al
  800cab:	0f b6 d0             	movzbl %al,%edx
  800cae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb1:	8a 00                	mov    (%eax),%al
  800cb3:	0f b6 c0             	movzbl %al,%eax
  800cb6:	29 c2                	sub    %eax,%edx
  800cb8:	89 d0                	mov    %edx,%eax
}
  800cba:	5d                   	pop    %ebp
  800cbb:	c3                   	ret    

00800cbc <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cbc:	55                   	push   %ebp
  800cbd:	89 e5                	mov    %esp,%ebp
  800cbf:	83 ec 04             	sub    $0x4,%esp
  800cc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cc8:	eb 12                	jmp    800cdc <strchr+0x20>
		if (*s == c)
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	8a 00                	mov    (%eax),%al
  800ccf:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cd2:	75 05                	jne    800cd9 <strchr+0x1d>
			return (char *) s;
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	eb 11                	jmp    800cea <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cd9:	ff 45 08             	incl   0x8(%ebp)
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	8a 00                	mov    (%eax),%al
  800ce1:	84 c0                	test   %al,%al
  800ce3:	75 e5                	jne    800cca <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ce5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cea:	c9                   	leave  
  800ceb:	c3                   	ret    

00800cec <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800cec:	55                   	push   %ebp
  800ced:	89 e5                	mov    %esp,%ebp
  800cef:	83 ec 04             	sub    $0x4,%esp
  800cf2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cf8:	eb 0d                	jmp    800d07 <strfind+0x1b>
		if (*s == c)
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	8a 00                	mov    (%eax),%al
  800cff:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d02:	74 0e                	je     800d12 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d04:	ff 45 08             	incl   0x8(%ebp)
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	84 c0                	test   %al,%al
  800d0e:	75 ea                	jne    800cfa <strfind+0xe>
  800d10:	eb 01                	jmp    800d13 <strfind+0x27>
		if (*s == c)
			break;
  800d12:	90                   	nop
	return (char *) s;
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d16:	c9                   	leave  
  800d17:	c3                   	ret    

00800d18 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d18:	55                   	push   %ebp
  800d19:	89 e5                	mov    %esp,%ebp
  800d1b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d24:	8b 45 10             	mov    0x10(%ebp),%eax
  800d27:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d2a:	eb 0e                	jmp    800d3a <memset+0x22>
		*p++ = c;
  800d2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d2f:	8d 50 01             	lea    0x1(%eax),%edx
  800d32:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d35:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d38:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d3a:	ff 4d f8             	decl   -0x8(%ebp)
  800d3d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d41:	79 e9                	jns    800d2c <memset+0x14>
		*p++ = c;

	return v;
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d46:	c9                   	leave  
  800d47:	c3                   	ret    

00800d48 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d48:	55                   	push   %ebp
  800d49:	89 e5                	mov    %esp,%ebp
  800d4b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d51:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d5a:	eb 16                	jmp    800d72 <memcpy+0x2a>
		*d++ = *s++;
  800d5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d5f:	8d 50 01             	lea    0x1(%eax),%edx
  800d62:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d65:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d68:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d6b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d6e:	8a 12                	mov    (%edx),%dl
  800d70:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d72:	8b 45 10             	mov    0x10(%ebp),%eax
  800d75:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d78:	89 55 10             	mov    %edx,0x10(%ebp)
  800d7b:	85 c0                	test   %eax,%eax
  800d7d:	75 dd                	jne    800d5c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d82:	c9                   	leave  
  800d83:	c3                   	ret    

00800d84 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d84:	55                   	push   %ebp
  800d85:	89 e5                	mov    %esp,%ebp
  800d87:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d90:	8b 45 08             	mov    0x8(%ebp),%eax
  800d93:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d99:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d9c:	73 50                	jae    800dee <memmove+0x6a>
  800d9e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800da1:	8b 45 10             	mov    0x10(%ebp),%eax
  800da4:	01 d0                	add    %edx,%eax
  800da6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800da9:	76 43                	jbe    800dee <memmove+0x6a>
		s += n;
  800dab:	8b 45 10             	mov    0x10(%ebp),%eax
  800dae:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800db1:	8b 45 10             	mov    0x10(%ebp),%eax
  800db4:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800db7:	eb 10                	jmp    800dc9 <memmove+0x45>
			*--d = *--s;
  800db9:	ff 4d f8             	decl   -0x8(%ebp)
  800dbc:	ff 4d fc             	decl   -0x4(%ebp)
  800dbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc2:	8a 10                	mov    (%eax),%dl
  800dc4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc7:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dc9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dcf:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd2:	85 c0                	test   %eax,%eax
  800dd4:	75 e3                	jne    800db9 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dd6:	eb 23                	jmp    800dfb <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800dd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ddb:	8d 50 01             	lea    0x1(%eax),%edx
  800dde:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800de4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800de7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dea:	8a 12                	mov    (%edx),%dl
  800dec:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800dee:	8b 45 10             	mov    0x10(%ebp),%eax
  800df1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df4:	89 55 10             	mov    %edx,0x10(%ebp)
  800df7:	85 c0                	test   %eax,%eax
  800df9:	75 dd                	jne    800dd8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dfe:	c9                   	leave  
  800dff:	c3                   	ret    

00800e00 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e00:	55                   	push   %ebp
  800e01:	89 e5                	mov    %esp,%ebp
  800e03:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e06:	8b 45 08             	mov    0x8(%ebp),%eax
  800e09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e12:	eb 2a                	jmp    800e3e <memcmp+0x3e>
		if (*s1 != *s2)
  800e14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e17:	8a 10                	mov    (%eax),%dl
  800e19:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1c:	8a 00                	mov    (%eax),%al
  800e1e:	38 c2                	cmp    %al,%dl
  800e20:	74 16                	je     800e38 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e25:	8a 00                	mov    (%eax),%al
  800e27:	0f b6 d0             	movzbl %al,%edx
  800e2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2d:	8a 00                	mov    (%eax),%al
  800e2f:	0f b6 c0             	movzbl %al,%eax
  800e32:	29 c2                	sub    %eax,%edx
  800e34:	89 d0                	mov    %edx,%eax
  800e36:	eb 18                	jmp    800e50 <memcmp+0x50>
		s1++, s2++;
  800e38:	ff 45 fc             	incl   -0x4(%ebp)
  800e3b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e41:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e44:	89 55 10             	mov    %edx,0x10(%ebp)
  800e47:	85 c0                	test   %eax,%eax
  800e49:	75 c9                	jne    800e14 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e50:	c9                   	leave  
  800e51:	c3                   	ret    

00800e52 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e52:	55                   	push   %ebp
  800e53:	89 e5                	mov    %esp,%ebp
  800e55:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e58:	8b 55 08             	mov    0x8(%ebp),%edx
  800e5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5e:	01 d0                	add    %edx,%eax
  800e60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e63:	eb 15                	jmp    800e7a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	8a 00                	mov    (%eax),%al
  800e6a:	0f b6 d0             	movzbl %al,%edx
  800e6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e70:	0f b6 c0             	movzbl %al,%eax
  800e73:	39 c2                	cmp    %eax,%edx
  800e75:	74 0d                	je     800e84 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e77:	ff 45 08             	incl   0x8(%ebp)
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e80:	72 e3                	jb     800e65 <memfind+0x13>
  800e82:	eb 01                	jmp    800e85 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e84:	90                   	nop
	return (void *) s;
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e88:	c9                   	leave  
  800e89:	c3                   	ret    

00800e8a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e8a:	55                   	push   %ebp
  800e8b:	89 e5                	mov    %esp,%ebp
  800e8d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e90:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e97:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e9e:	eb 03                	jmp    800ea3 <strtol+0x19>
		s++;
  800ea0:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	8a 00                	mov    (%eax),%al
  800ea8:	3c 20                	cmp    $0x20,%al
  800eaa:	74 f4                	je     800ea0 <strtol+0x16>
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	3c 09                	cmp    $0x9,%al
  800eb3:	74 eb                	je     800ea0 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	8a 00                	mov    (%eax),%al
  800eba:	3c 2b                	cmp    $0x2b,%al
  800ebc:	75 05                	jne    800ec3 <strtol+0x39>
		s++;
  800ebe:	ff 45 08             	incl   0x8(%ebp)
  800ec1:	eb 13                	jmp    800ed6 <strtol+0x4c>
	else if (*s == '-')
  800ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec6:	8a 00                	mov    (%eax),%al
  800ec8:	3c 2d                	cmp    $0x2d,%al
  800eca:	75 0a                	jne    800ed6 <strtol+0x4c>
		s++, neg = 1;
  800ecc:	ff 45 08             	incl   0x8(%ebp)
  800ecf:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ed6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eda:	74 06                	je     800ee2 <strtol+0x58>
  800edc:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ee0:	75 20                	jne    800f02 <strtol+0x78>
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	8a 00                	mov    (%eax),%al
  800ee7:	3c 30                	cmp    $0x30,%al
  800ee9:	75 17                	jne    800f02 <strtol+0x78>
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	40                   	inc    %eax
  800eef:	8a 00                	mov    (%eax),%al
  800ef1:	3c 78                	cmp    $0x78,%al
  800ef3:	75 0d                	jne    800f02 <strtol+0x78>
		s += 2, base = 16;
  800ef5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ef9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f00:	eb 28                	jmp    800f2a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f02:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f06:	75 15                	jne    800f1d <strtol+0x93>
  800f08:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0b:	8a 00                	mov    (%eax),%al
  800f0d:	3c 30                	cmp    $0x30,%al
  800f0f:	75 0c                	jne    800f1d <strtol+0x93>
		s++, base = 8;
  800f11:	ff 45 08             	incl   0x8(%ebp)
  800f14:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f1b:	eb 0d                	jmp    800f2a <strtol+0xa0>
	else if (base == 0)
  800f1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f21:	75 07                	jne    800f2a <strtol+0xa0>
		base = 10;
  800f23:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	8a 00                	mov    (%eax),%al
  800f2f:	3c 2f                	cmp    $0x2f,%al
  800f31:	7e 19                	jle    800f4c <strtol+0xc2>
  800f33:	8b 45 08             	mov    0x8(%ebp),%eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	3c 39                	cmp    $0x39,%al
  800f3a:	7f 10                	jg     800f4c <strtol+0xc2>
			dig = *s - '0';
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	0f be c0             	movsbl %al,%eax
  800f44:	83 e8 30             	sub    $0x30,%eax
  800f47:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f4a:	eb 42                	jmp    800f8e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	8a 00                	mov    (%eax),%al
  800f51:	3c 60                	cmp    $0x60,%al
  800f53:	7e 19                	jle    800f6e <strtol+0xe4>
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	8a 00                	mov    (%eax),%al
  800f5a:	3c 7a                	cmp    $0x7a,%al
  800f5c:	7f 10                	jg     800f6e <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	8a 00                	mov    (%eax),%al
  800f63:	0f be c0             	movsbl %al,%eax
  800f66:	83 e8 57             	sub    $0x57,%eax
  800f69:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f6c:	eb 20                	jmp    800f8e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	3c 40                	cmp    $0x40,%al
  800f75:	7e 39                	jle    800fb0 <strtol+0x126>
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	3c 5a                	cmp    $0x5a,%al
  800f7e:	7f 30                	jg     800fb0 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	0f be c0             	movsbl %al,%eax
  800f88:	83 e8 37             	sub    $0x37,%eax
  800f8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f91:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f94:	7d 19                	jge    800faf <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f96:	ff 45 08             	incl   0x8(%ebp)
  800f99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9c:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fa0:	89 c2                	mov    %eax,%edx
  800fa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fa5:	01 d0                	add    %edx,%eax
  800fa7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800faa:	e9 7b ff ff ff       	jmp    800f2a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800faf:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fb0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fb4:	74 08                	je     800fbe <strtol+0x134>
		*endptr = (char *) s;
  800fb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb9:	8b 55 08             	mov    0x8(%ebp),%edx
  800fbc:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fbe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fc2:	74 07                	je     800fcb <strtol+0x141>
  800fc4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc7:	f7 d8                	neg    %eax
  800fc9:	eb 03                	jmp    800fce <strtol+0x144>
  800fcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fce:	c9                   	leave  
  800fcf:	c3                   	ret    

00800fd0 <ltostr>:

void
ltostr(long value, char *str)
{
  800fd0:	55                   	push   %ebp
  800fd1:	89 e5                	mov    %esp,%ebp
  800fd3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fd6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fdd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fe4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fe8:	79 13                	jns    800ffd <ltostr+0x2d>
	{
		neg = 1;
  800fea:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ff1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800ff7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800ffa:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801005:	99                   	cltd   
  801006:	f7 f9                	idiv   %ecx
  801008:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80100b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100e:	8d 50 01             	lea    0x1(%eax),%edx
  801011:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801014:	89 c2                	mov    %eax,%edx
  801016:	8b 45 0c             	mov    0xc(%ebp),%eax
  801019:	01 d0                	add    %edx,%eax
  80101b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80101e:	83 c2 30             	add    $0x30,%edx
  801021:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801023:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801026:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80102b:	f7 e9                	imul   %ecx
  80102d:	c1 fa 02             	sar    $0x2,%edx
  801030:	89 c8                	mov    %ecx,%eax
  801032:	c1 f8 1f             	sar    $0x1f,%eax
  801035:	29 c2                	sub    %eax,%edx
  801037:	89 d0                	mov    %edx,%eax
  801039:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80103c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80103f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801044:	f7 e9                	imul   %ecx
  801046:	c1 fa 02             	sar    $0x2,%edx
  801049:	89 c8                	mov    %ecx,%eax
  80104b:	c1 f8 1f             	sar    $0x1f,%eax
  80104e:	29 c2                	sub    %eax,%edx
  801050:	89 d0                	mov    %edx,%eax
  801052:	c1 e0 02             	shl    $0x2,%eax
  801055:	01 d0                	add    %edx,%eax
  801057:	01 c0                	add    %eax,%eax
  801059:	29 c1                	sub    %eax,%ecx
  80105b:	89 ca                	mov    %ecx,%edx
  80105d:	85 d2                	test   %edx,%edx
  80105f:	75 9c                	jne    800ffd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801061:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801068:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106b:	48                   	dec    %eax
  80106c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80106f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801073:	74 3d                	je     8010b2 <ltostr+0xe2>
		start = 1 ;
  801075:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80107c:	eb 34                	jmp    8010b2 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80107e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801081:	8b 45 0c             	mov    0xc(%ebp),%eax
  801084:	01 d0                	add    %edx,%eax
  801086:	8a 00                	mov    (%eax),%al
  801088:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80108b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80108e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801091:	01 c2                	add    %eax,%edx
  801093:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801096:	8b 45 0c             	mov    0xc(%ebp),%eax
  801099:	01 c8                	add    %ecx,%eax
  80109b:	8a 00                	mov    (%eax),%al
  80109d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80109f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a5:	01 c2                	add    %eax,%edx
  8010a7:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010aa:	88 02                	mov    %al,(%edx)
		start++ ;
  8010ac:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010af:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010b5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010b8:	7c c4                	jl     80107e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010ba:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c0:	01 d0                	add    %edx,%eax
  8010c2:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010c5:	90                   	nop
  8010c6:	c9                   	leave  
  8010c7:	c3                   	ret    

008010c8 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010c8:	55                   	push   %ebp
  8010c9:	89 e5                	mov    %esp,%ebp
  8010cb:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010ce:	ff 75 08             	pushl  0x8(%ebp)
  8010d1:	e8 54 fa ff ff       	call   800b2a <strlen>
  8010d6:	83 c4 04             	add    $0x4,%esp
  8010d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010dc:	ff 75 0c             	pushl  0xc(%ebp)
  8010df:	e8 46 fa ff ff       	call   800b2a <strlen>
  8010e4:	83 c4 04             	add    $0x4,%esp
  8010e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010f1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010f8:	eb 17                	jmp    801111 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801100:	01 c2                	add    %eax,%edx
  801102:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801105:	8b 45 08             	mov    0x8(%ebp),%eax
  801108:	01 c8                	add    %ecx,%eax
  80110a:	8a 00                	mov    (%eax),%al
  80110c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80110e:	ff 45 fc             	incl   -0x4(%ebp)
  801111:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801114:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801117:	7c e1                	jl     8010fa <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801119:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801120:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801127:	eb 1f                	jmp    801148 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801129:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112c:	8d 50 01             	lea    0x1(%eax),%edx
  80112f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801132:	89 c2                	mov    %eax,%edx
  801134:	8b 45 10             	mov    0x10(%ebp),%eax
  801137:	01 c2                	add    %eax,%edx
  801139:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80113c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113f:	01 c8                	add    %ecx,%eax
  801141:	8a 00                	mov    (%eax),%al
  801143:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801145:	ff 45 f8             	incl   -0x8(%ebp)
  801148:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80114b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80114e:	7c d9                	jl     801129 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801150:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801153:	8b 45 10             	mov    0x10(%ebp),%eax
  801156:	01 d0                	add    %edx,%eax
  801158:	c6 00 00             	movb   $0x0,(%eax)
}
  80115b:	90                   	nop
  80115c:	c9                   	leave  
  80115d:	c3                   	ret    

0080115e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80115e:	55                   	push   %ebp
  80115f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801161:	8b 45 14             	mov    0x14(%ebp),%eax
  801164:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80116a:	8b 45 14             	mov    0x14(%ebp),%eax
  80116d:	8b 00                	mov    (%eax),%eax
  80116f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801176:	8b 45 10             	mov    0x10(%ebp),%eax
  801179:	01 d0                	add    %edx,%eax
  80117b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801181:	eb 0c                	jmp    80118f <strsplit+0x31>
			*string++ = 0;
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	8d 50 01             	lea    0x1(%eax),%edx
  801189:	89 55 08             	mov    %edx,0x8(%ebp)
  80118c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80118f:	8b 45 08             	mov    0x8(%ebp),%eax
  801192:	8a 00                	mov    (%eax),%al
  801194:	84 c0                	test   %al,%al
  801196:	74 18                	je     8011b0 <strsplit+0x52>
  801198:	8b 45 08             	mov    0x8(%ebp),%eax
  80119b:	8a 00                	mov    (%eax),%al
  80119d:	0f be c0             	movsbl %al,%eax
  8011a0:	50                   	push   %eax
  8011a1:	ff 75 0c             	pushl  0xc(%ebp)
  8011a4:	e8 13 fb ff ff       	call   800cbc <strchr>
  8011a9:	83 c4 08             	add    $0x8,%esp
  8011ac:	85 c0                	test   %eax,%eax
  8011ae:	75 d3                	jne    801183 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b3:	8a 00                	mov    (%eax),%al
  8011b5:	84 c0                	test   %al,%al
  8011b7:	74 5a                	je     801213 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011bc:	8b 00                	mov    (%eax),%eax
  8011be:	83 f8 0f             	cmp    $0xf,%eax
  8011c1:	75 07                	jne    8011ca <strsplit+0x6c>
		{
			return 0;
  8011c3:	b8 00 00 00 00       	mov    $0x0,%eax
  8011c8:	eb 66                	jmp    801230 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cd:	8b 00                	mov    (%eax),%eax
  8011cf:	8d 48 01             	lea    0x1(%eax),%ecx
  8011d2:	8b 55 14             	mov    0x14(%ebp),%edx
  8011d5:	89 0a                	mov    %ecx,(%edx)
  8011d7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011de:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e1:	01 c2                	add    %eax,%edx
  8011e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011e8:	eb 03                	jmp    8011ed <strsplit+0x8f>
			string++;
  8011ea:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	8a 00                	mov    (%eax),%al
  8011f2:	84 c0                	test   %al,%al
  8011f4:	74 8b                	je     801181 <strsplit+0x23>
  8011f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f9:	8a 00                	mov    (%eax),%al
  8011fb:	0f be c0             	movsbl %al,%eax
  8011fe:	50                   	push   %eax
  8011ff:	ff 75 0c             	pushl  0xc(%ebp)
  801202:	e8 b5 fa ff ff       	call   800cbc <strchr>
  801207:	83 c4 08             	add    $0x8,%esp
  80120a:	85 c0                	test   %eax,%eax
  80120c:	74 dc                	je     8011ea <strsplit+0x8c>
			string++;
	}
  80120e:	e9 6e ff ff ff       	jmp    801181 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801213:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801214:	8b 45 14             	mov    0x14(%ebp),%eax
  801217:	8b 00                	mov    (%eax),%eax
  801219:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801220:	8b 45 10             	mov    0x10(%ebp),%eax
  801223:	01 d0                	add    %edx,%eax
  801225:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80122b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801230:	c9                   	leave  
  801231:	c3                   	ret    

00801232 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801232:	55                   	push   %ebp
  801233:	89 e5                	mov    %esp,%ebp
  801235:	57                   	push   %edi
  801236:	56                   	push   %esi
  801237:	53                   	push   %ebx
  801238:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
  80123e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801241:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801244:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801247:	8b 7d 18             	mov    0x18(%ebp),%edi
  80124a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80124d:	cd 30                	int    $0x30
  80124f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801252:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801255:	83 c4 10             	add    $0x10,%esp
  801258:	5b                   	pop    %ebx
  801259:	5e                   	pop    %esi
  80125a:	5f                   	pop    %edi
  80125b:	5d                   	pop    %ebp
  80125c:	c3                   	ret    

0080125d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80125d:	55                   	push   %ebp
  80125e:	89 e5                	mov    %esp,%ebp
  801260:	83 ec 04             	sub    $0x4,%esp
  801263:	8b 45 10             	mov    0x10(%ebp),%eax
  801266:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801269:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	6a 00                	push   $0x0
  801272:	6a 00                	push   $0x0
  801274:	52                   	push   %edx
  801275:	ff 75 0c             	pushl  0xc(%ebp)
  801278:	50                   	push   %eax
  801279:	6a 00                	push   $0x0
  80127b:	e8 b2 ff ff ff       	call   801232 <syscall>
  801280:	83 c4 18             	add    $0x18,%esp
}
  801283:	90                   	nop
  801284:	c9                   	leave  
  801285:	c3                   	ret    

00801286 <sys_cgetc>:

int
sys_cgetc(void)
{
  801286:	55                   	push   %ebp
  801287:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	6a 01                	push   $0x1
  801295:	e8 98 ff ff ff       	call   801232 <syscall>
  80129a:	83 c4 18             	add    $0x18,%esp
}
  80129d:	c9                   	leave  
  80129e:	c3                   	ret    

0080129f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80129f:	55                   	push   %ebp
  8012a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	50                   	push   %eax
  8012ae:	6a 05                	push   $0x5
  8012b0:	e8 7d ff ff ff       	call   801232 <syscall>
  8012b5:	83 c4 18             	add    $0x18,%esp
}
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 02                	push   $0x2
  8012c9:	e8 64 ff ff ff       	call   801232 <syscall>
  8012ce:	83 c4 18             	add    $0x18,%esp
}
  8012d1:	c9                   	leave  
  8012d2:	c3                   	ret    

008012d3 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012d3:	55                   	push   %ebp
  8012d4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 00                	push   $0x0
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 03                	push   $0x3
  8012e2:	e8 4b ff ff ff       	call   801232 <syscall>
  8012e7:	83 c4 18             	add    $0x18,%esp
}
  8012ea:	c9                   	leave  
  8012eb:	c3                   	ret    

008012ec <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 00                	push   $0x0
  8012f7:	6a 00                	push   $0x0
  8012f9:	6a 04                	push   $0x4
  8012fb:	e8 32 ff ff ff       	call   801232 <syscall>
  801300:	83 c4 18             	add    $0x18,%esp
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <sys_env_exit>:


void sys_env_exit(void)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801308:	6a 00                	push   $0x0
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	6a 06                	push   $0x6
  801314:	e8 19 ff ff ff       	call   801232 <syscall>
  801319:	83 c4 18             	add    $0x18,%esp
}
  80131c:	90                   	nop
  80131d:	c9                   	leave  
  80131e:	c3                   	ret    

0080131f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80131f:	55                   	push   %ebp
  801320:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801322:	8b 55 0c             	mov    0xc(%ebp),%edx
  801325:	8b 45 08             	mov    0x8(%ebp),%eax
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	52                   	push   %edx
  80132f:	50                   	push   %eax
  801330:	6a 07                	push   $0x7
  801332:	e8 fb fe ff ff       	call   801232 <syscall>
  801337:	83 c4 18             	add    $0x18,%esp
}
  80133a:	c9                   	leave  
  80133b:	c3                   	ret    

0080133c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80133c:	55                   	push   %ebp
  80133d:	89 e5                	mov    %esp,%ebp
  80133f:	56                   	push   %esi
  801340:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801341:	8b 75 18             	mov    0x18(%ebp),%esi
  801344:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801347:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80134a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134d:	8b 45 08             	mov    0x8(%ebp),%eax
  801350:	56                   	push   %esi
  801351:	53                   	push   %ebx
  801352:	51                   	push   %ecx
  801353:	52                   	push   %edx
  801354:	50                   	push   %eax
  801355:	6a 08                	push   $0x8
  801357:	e8 d6 fe ff ff       	call   801232 <syscall>
  80135c:	83 c4 18             	add    $0x18,%esp
}
  80135f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801362:	5b                   	pop    %ebx
  801363:	5e                   	pop    %esi
  801364:	5d                   	pop    %ebp
  801365:	c3                   	ret    

00801366 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801366:	55                   	push   %ebp
  801367:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801369:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	52                   	push   %edx
  801376:	50                   	push   %eax
  801377:	6a 09                	push   $0x9
  801379:	e8 b4 fe ff ff       	call   801232 <syscall>
  80137e:	83 c4 18             	add    $0x18,%esp
}
  801381:	c9                   	leave  
  801382:	c3                   	ret    

00801383 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801383:	55                   	push   %ebp
  801384:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801386:	6a 00                	push   $0x0
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	ff 75 0c             	pushl  0xc(%ebp)
  80138f:	ff 75 08             	pushl  0x8(%ebp)
  801392:	6a 0a                	push   $0xa
  801394:	e8 99 fe ff ff       	call   801232 <syscall>
  801399:	83 c4 18             	add    $0x18,%esp
}
  80139c:	c9                   	leave  
  80139d:	c3                   	ret    

0080139e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80139e:	55                   	push   %ebp
  80139f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 0b                	push   $0xb
  8013ad:	e8 80 fe ff ff       	call   801232 <syscall>
  8013b2:	83 c4 18             	add    $0x18,%esp
}
  8013b5:	c9                   	leave  
  8013b6:	c3                   	ret    

008013b7 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013b7:	55                   	push   %ebp
  8013b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 0c                	push   $0xc
  8013c6:	e8 67 fe ff ff       	call   801232 <syscall>
  8013cb:	83 c4 18             	add    $0x18,%esp
}
  8013ce:	c9                   	leave  
  8013cf:	c3                   	ret    

008013d0 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013d0:	55                   	push   %ebp
  8013d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 00                	push   $0x0
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 0d                	push   $0xd
  8013df:	e8 4e fe ff ff       	call   801232 <syscall>
  8013e4:	83 c4 18             	add    $0x18,%esp
}
  8013e7:	c9                   	leave  
  8013e8:	c3                   	ret    

008013e9 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	ff 75 0c             	pushl  0xc(%ebp)
  8013f5:	ff 75 08             	pushl  0x8(%ebp)
  8013f8:	6a 11                	push   $0x11
  8013fa:	e8 33 fe ff ff       	call   801232 <syscall>
  8013ff:	83 c4 18             	add    $0x18,%esp
	return;
  801402:	90                   	nop
}
  801403:	c9                   	leave  
  801404:	c3                   	ret    

00801405 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801405:	55                   	push   %ebp
  801406:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	ff 75 0c             	pushl  0xc(%ebp)
  801411:	ff 75 08             	pushl  0x8(%ebp)
  801414:	6a 12                	push   $0x12
  801416:	e8 17 fe ff ff       	call   801232 <syscall>
  80141b:	83 c4 18             	add    $0x18,%esp
	return ;
  80141e:	90                   	nop
}
  80141f:	c9                   	leave  
  801420:	c3                   	ret    

00801421 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 0e                	push   $0xe
  801430:	e8 fd fd ff ff       	call   801232 <syscall>
  801435:	83 c4 18             	add    $0x18,%esp
}
  801438:	c9                   	leave  
  801439:	c3                   	ret    

0080143a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80143a:	55                   	push   %ebp
  80143b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	ff 75 08             	pushl  0x8(%ebp)
  801448:	6a 0f                	push   $0xf
  80144a:	e8 e3 fd ff ff       	call   801232 <syscall>
  80144f:	83 c4 18             	add    $0x18,%esp
}
  801452:	c9                   	leave  
  801453:	c3                   	ret    

00801454 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801454:	55                   	push   %ebp
  801455:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801457:	6a 00                	push   $0x0
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	6a 10                	push   $0x10
  801463:	e8 ca fd ff ff       	call   801232 <syscall>
  801468:	83 c4 18             	add    $0x18,%esp
}
  80146b:	90                   	nop
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 14                	push   $0x14
  80147d:	e8 b0 fd ff ff       	call   801232 <syscall>
  801482:	83 c4 18             	add    $0x18,%esp
}
  801485:	90                   	nop
  801486:	c9                   	leave  
  801487:	c3                   	ret    

00801488 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801488:	55                   	push   %ebp
  801489:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 15                	push   $0x15
  801497:	e8 96 fd ff ff       	call   801232 <syscall>
  80149c:	83 c4 18             	add    $0x18,%esp
}
  80149f:	90                   	nop
  8014a0:	c9                   	leave  
  8014a1:	c3                   	ret    

008014a2 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014a2:	55                   	push   %ebp
  8014a3:	89 e5                	mov    %esp,%ebp
  8014a5:	83 ec 04             	sub    $0x4,%esp
  8014a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ab:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014ae:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	50                   	push   %eax
  8014bb:	6a 16                	push   $0x16
  8014bd:	e8 70 fd ff ff       	call   801232 <syscall>
  8014c2:	83 c4 18             	add    $0x18,%esp
}
  8014c5:	90                   	nop
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 17                	push   $0x17
  8014d7:	e8 56 fd ff ff       	call   801232 <syscall>
  8014dc:	83 c4 18             	add    $0x18,%esp
}
  8014df:	90                   	nop
  8014e0:	c9                   	leave  
  8014e1:	c3                   	ret    

008014e2 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014e2:	55                   	push   %ebp
  8014e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	ff 75 0c             	pushl  0xc(%ebp)
  8014f1:	50                   	push   %eax
  8014f2:	6a 18                	push   $0x18
  8014f4:	e8 39 fd ff ff       	call   801232 <syscall>
  8014f9:	83 c4 18             	add    $0x18,%esp
}
  8014fc:	c9                   	leave  
  8014fd:	c3                   	ret    

008014fe <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8014fe:	55                   	push   %ebp
  8014ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801501:	8b 55 0c             	mov    0xc(%ebp),%edx
  801504:	8b 45 08             	mov    0x8(%ebp),%eax
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	52                   	push   %edx
  80150e:	50                   	push   %eax
  80150f:	6a 1b                	push   $0x1b
  801511:	e8 1c fd ff ff       	call   801232 <syscall>
  801516:	83 c4 18             	add    $0x18,%esp
}
  801519:	c9                   	leave  
  80151a:	c3                   	ret    

0080151b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80151b:	55                   	push   %ebp
  80151c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80151e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801521:	8b 45 08             	mov    0x8(%ebp),%eax
  801524:	6a 00                	push   $0x0
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	52                   	push   %edx
  80152b:	50                   	push   %eax
  80152c:	6a 19                	push   $0x19
  80152e:	e8 ff fc ff ff       	call   801232 <syscall>
  801533:	83 c4 18             	add    $0x18,%esp
}
  801536:	90                   	nop
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80153c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	52                   	push   %edx
  801549:	50                   	push   %eax
  80154a:	6a 1a                	push   $0x1a
  80154c:	e8 e1 fc ff ff       	call   801232 <syscall>
  801551:	83 c4 18             	add    $0x18,%esp
}
  801554:	90                   	nop
  801555:	c9                   	leave  
  801556:	c3                   	ret    

00801557 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801557:	55                   	push   %ebp
  801558:	89 e5                	mov    %esp,%ebp
  80155a:	83 ec 04             	sub    $0x4,%esp
  80155d:	8b 45 10             	mov    0x10(%ebp),%eax
  801560:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801563:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801566:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80156a:	8b 45 08             	mov    0x8(%ebp),%eax
  80156d:	6a 00                	push   $0x0
  80156f:	51                   	push   %ecx
  801570:	52                   	push   %edx
  801571:	ff 75 0c             	pushl  0xc(%ebp)
  801574:	50                   	push   %eax
  801575:	6a 1c                	push   $0x1c
  801577:	e8 b6 fc ff ff       	call   801232 <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801584:	8b 55 0c             	mov    0xc(%ebp),%edx
  801587:	8b 45 08             	mov    0x8(%ebp),%eax
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	52                   	push   %edx
  801591:	50                   	push   %eax
  801592:	6a 1d                	push   $0x1d
  801594:	e8 99 fc ff ff       	call   801232 <syscall>
  801599:	83 c4 18             	add    $0x18,%esp
}
  80159c:	c9                   	leave  
  80159d:	c3                   	ret    

0080159e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80159e:	55                   	push   %ebp
  80159f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015a1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	51                   	push   %ecx
  8015af:	52                   	push   %edx
  8015b0:	50                   	push   %eax
  8015b1:	6a 1e                	push   $0x1e
  8015b3:	e8 7a fc ff ff       	call   801232 <syscall>
  8015b8:	83 c4 18             	add    $0x18,%esp
}
  8015bb:	c9                   	leave  
  8015bc:	c3                   	ret    

008015bd <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	52                   	push   %edx
  8015cd:	50                   	push   %eax
  8015ce:	6a 1f                	push   $0x1f
  8015d0:	e8 5d fc ff ff       	call   801232 <syscall>
  8015d5:	83 c4 18             	add    $0x18,%esp
}
  8015d8:	c9                   	leave  
  8015d9:	c3                   	ret    

008015da <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 20                	push   $0x20
  8015e9:	e8 44 fc ff ff       	call   801232 <syscall>
  8015ee:	83 c4 18             	add    $0x18,%esp
}
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8015f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f9:	6a 00                	push   $0x0
  8015fb:	ff 75 14             	pushl  0x14(%ebp)
  8015fe:	ff 75 10             	pushl  0x10(%ebp)
  801601:	ff 75 0c             	pushl  0xc(%ebp)
  801604:	50                   	push   %eax
  801605:	6a 21                	push   $0x21
  801607:	e8 26 fc ff ff       	call   801232 <syscall>
  80160c:	83 c4 18             	add    $0x18,%esp
}
  80160f:	c9                   	leave  
  801610:	c3                   	ret    

00801611 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	50                   	push   %eax
  801620:	6a 22                	push   $0x22
  801622:	e8 0b fc ff ff       	call   801232 <syscall>
  801627:	83 c4 18             	add    $0x18,%esp
}
  80162a:	90                   	nop
  80162b:	c9                   	leave  
  80162c:	c3                   	ret    

0080162d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80162d:	55                   	push   %ebp
  80162e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801630:	8b 45 08             	mov    0x8(%ebp),%eax
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	50                   	push   %eax
  80163c:	6a 23                	push   $0x23
  80163e:	e8 ef fb ff ff       	call   801232 <syscall>
  801643:	83 c4 18             	add    $0x18,%esp
}
  801646:	90                   	nop
  801647:	c9                   	leave  
  801648:	c3                   	ret    

00801649 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801649:	55                   	push   %ebp
  80164a:	89 e5                	mov    %esp,%ebp
  80164c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80164f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801652:	8d 50 04             	lea    0x4(%eax),%edx
  801655:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	52                   	push   %edx
  80165f:	50                   	push   %eax
  801660:	6a 24                	push   $0x24
  801662:	e8 cb fb ff ff       	call   801232 <syscall>
  801667:	83 c4 18             	add    $0x18,%esp
	return result;
  80166a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80166d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801670:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801673:	89 01                	mov    %eax,(%ecx)
  801675:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801678:	8b 45 08             	mov    0x8(%ebp),%eax
  80167b:	c9                   	leave  
  80167c:	c2 04 00             	ret    $0x4

0080167f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	ff 75 10             	pushl  0x10(%ebp)
  801689:	ff 75 0c             	pushl  0xc(%ebp)
  80168c:	ff 75 08             	pushl  0x8(%ebp)
  80168f:	6a 13                	push   $0x13
  801691:	e8 9c fb ff ff       	call   801232 <syscall>
  801696:	83 c4 18             	add    $0x18,%esp
	return ;
  801699:	90                   	nop
}
  80169a:	c9                   	leave  
  80169b:	c3                   	ret    

0080169c <sys_rcr2>:
uint32 sys_rcr2()
{
  80169c:	55                   	push   %ebp
  80169d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 25                	push   $0x25
  8016ab:	e8 82 fb ff ff       	call   801232 <syscall>
  8016b0:	83 c4 18             	add    $0x18,%esp
}
  8016b3:	c9                   	leave  
  8016b4:	c3                   	ret    

008016b5 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016b5:	55                   	push   %ebp
  8016b6:	89 e5                	mov    %esp,%ebp
  8016b8:	83 ec 04             	sub    $0x4,%esp
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016c1:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	50                   	push   %eax
  8016ce:	6a 26                	push   $0x26
  8016d0:	e8 5d fb ff ff       	call   801232 <syscall>
  8016d5:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d8:	90                   	nop
}
  8016d9:	c9                   	leave  
  8016da:	c3                   	ret    

008016db <rsttst>:
void rsttst()
{
  8016db:	55                   	push   %ebp
  8016dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 28                	push   $0x28
  8016ea:	e8 43 fb ff ff       	call   801232 <syscall>
  8016ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f2:	90                   	nop
}
  8016f3:	c9                   	leave  
  8016f4:	c3                   	ret    

008016f5 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8016f5:	55                   	push   %ebp
  8016f6:	89 e5                	mov    %esp,%ebp
  8016f8:	83 ec 04             	sub    $0x4,%esp
  8016fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8016fe:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801701:	8b 55 18             	mov    0x18(%ebp),%edx
  801704:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801708:	52                   	push   %edx
  801709:	50                   	push   %eax
  80170a:	ff 75 10             	pushl  0x10(%ebp)
  80170d:	ff 75 0c             	pushl  0xc(%ebp)
  801710:	ff 75 08             	pushl  0x8(%ebp)
  801713:	6a 27                	push   $0x27
  801715:	e8 18 fb ff ff       	call   801232 <syscall>
  80171a:	83 c4 18             	add    $0x18,%esp
	return ;
  80171d:	90                   	nop
}
  80171e:	c9                   	leave  
  80171f:	c3                   	ret    

00801720 <chktst>:
void chktst(uint32 n)
{
  801720:	55                   	push   %ebp
  801721:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	ff 75 08             	pushl  0x8(%ebp)
  80172e:	6a 29                	push   $0x29
  801730:	e8 fd fa ff ff       	call   801232 <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
	return ;
  801738:	90                   	nop
}
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <inctst>:

void inctst()
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 2a                	push   $0x2a
  80174a:	e8 e3 fa ff ff       	call   801232 <syscall>
  80174f:	83 c4 18             	add    $0x18,%esp
	return ;
  801752:	90                   	nop
}
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <gettst>:
uint32 gettst()
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 2b                	push   $0x2b
  801764:	e8 c9 fa ff ff       	call   801232 <syscall>
  801769:	83 c4 18             	add    $0x18,%esp
}
  80176c:	c9                   	leave  
  80176d:	c3                   	ret    

0080176e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80176e:	55                   	push   %ebp
  80176f:	89 e5                	mov    %esp,%ebp
  801771:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 2c                	push   $0x2c
  801780:	e8 ad fa ff ff       	call   801232 <syscall>
  801785:	83 c4 18             	add    $0x18,%esp
  801788:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80178b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80178f:	75 07                	jne    801798 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801791:	b8 01 00 00 00       	mov    $0x1,%eax
  801796:	eb 05                	jmp    80179d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801798:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80179d:	c9                   	leave  
  80179e:	c3                   	ret    

0080179f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80179f:	55                   	push   %ebp
  8017a0:	89 e5                	mov    %esp,%ebp
  8017a2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 2c                	push   $0x2c
  8017b1:	e8 7c fa ff ff       	call   801232 <syscall>
  8017b6:	83 c4 18             	add    $0x18,%esp
  8017b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017bc:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017c0:	75 07                	jne    8017c9 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8017c7:	eb 05                	jmp    8017ce <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017ce:	c9                   	leave  
  8017cf:	c3                   	ret    

008017d0 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017d0:	55                   	push   %ebp
  8017d1:	89 e5                	mov    %esp,%ebp
  8017d3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 2c                	push   $0x2c
  8017e2:	e8 4b fa ff ff       	call   801232 <syscall>
  8017e7:	83 c4 18             	add    $0x18,%esp
  8017ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017ed:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017f1:	75 07                	jne    8017fa <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8017f3:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f8:	eb 05                	jmp    8017ff <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8017fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017ff:	c9                   	leave  
  801800:	c3                   	ret    

00801801 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801801:	55                   	push   %ebp
  801802:	89 e5                	mov    %esp,%ebp
  801804:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 2c                	push   $0x2c
  801813:	e8 1a fa ff ff       	call   801232 <syscall>
  801818:	83 c4 18             	add    $0x18,%esp
  80181b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80181e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801822:	75 07                	jne    80182b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801824:	b8 01 00 00 00       	mov    $0x1,%eax
  801829:	eb 05                	jmp    801830 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80182b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801830:	c9                   	leave  
  801831:	c3                   	ret    

00801832 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801832:	55                   	push   %ebp
  801833:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	ff 75 08             	pushl  0x8(%ebp)
  801840:	6a 2d                	push   $0x2d
  801842:	e8 eb f9 ff ff       	call   801232 <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
	return ;
  80184a:	90                   	nop
}
  80184b:	c9                   	leave  
  80184c:	c3                   	ret    

0080184d <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80184d:	55                   	push   %ebp
  80184e:	89 e5                	mov    %esp,%ebp
  801850:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801851:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801854:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801857:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185a:	8b 45 08             	mov    0x8(%ebp),%eax
  80185d:	6a 00                	push   $0x0
  80185f:	53                   	push   %ebx
  801860:	51                   	push   %ecx
  801861:	52                   	push   %edx
  801862:	50                   	push   %eax
  801863:	6a 2e                	push   $0x2e
  801865:	e8 c8 f9 ff ff       	call   801232 <syscall>
  80186a:	83 c4 18             	add    $0x18,%esp
}
  80186d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801870:	c9                   	leave  
  801871:	c3                   	ret    

00801872 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801872:	55                   	push   %ebp
  801873:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801875:	8b 55 0c             	mov    0xc(%ebp),%edx
  801878:	8b 45 08             	mov    0x8(%ebp),%eax
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	52                   	push   %edx
  801882:	50                   	push   %eax
  801883:	6a 2f                	push   $0x2f
  801885:	e8 a8 f9 ff ff       	call   801232 <syscall>
  80188a:	83 c4 18             	add    $0x18,%esp
}
  80188d:	c9                   	leave  
  80188e:	c3                   	ret    

0080188f <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  80188f:	55                   	push   %ebp
  801890:	89 e5                	mov    %esp,%ebp
  801892:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801895:	8b 55 08             	mov    0x8(%ebp),%edx
  801898:	89 d0                	mov    %edx,%eax
  80189a:	c1 e0 02             	shl    $0x2,%eax
  80189d:	01 d0                	add    %edx,%eax
  80189f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018a6:	01 d0                	add    %edx,%eax
  8018a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018af:	01 d0                	add    %edx,%eax
  8018b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018b8:	01 d0                	add    %edx,%eax
  8018ba:	c1 e0 04             	shl    $0x4,%eax
  8018bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8018c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8018c7:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8018ca:	83 ec 0c             	sub    $0xc,%esp
  8018cd:	50                   	push   %eax
  8018ce:	e8 76 fd ff ff       	call   801649 <sys_get_virtual_time>
  8018d3:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8018d6:	eb 41                	jmp    801919 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8018d8:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8018db:	83 ec 0c             	sub    $0xc,%esp
  8018de:	50                   	push   %eax
  8018df:	e8 65 fd ff ff       	call   801649 <sys_get_virtual_time>
  8018e4:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8018e7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8018ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018ed:	29 c2                	sub    %eax,%edx
  8018ef:	89 d0                	mov    %edx,%eax
  8018f1:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8018f4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8018f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8018fa:	89 d1                	mov    %edx,%ecx
  8018fc:	29 c1                	sub    %eax,%ecx
  8018fe:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801901:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801904:	39 c2                	cmp    %eax,%edx
  801906:	0f 97 c0             	seta   %al
  801909:	0f b6 c0             	movzbl %al,%eax
  80190c:	29 c1                	sub    %eax,%ecx
  80190e:	89 c8                	mov    %ecx,%eax
  801910:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801913:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801916:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801919:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80191c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80191f:	72 b7                	jb     8018d8 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801921:	90                   	nop
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
  801927:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80192a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801931:	eb 03                	jmp    801936 <busy_wait+0x12>
  801933:	ff 45 fc             	incl   -0x4(%ebp)
  801936:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801939:	3b 45 08             	cmp    0x8(%ebp),%eax
  80193c:	72 f5                	jb     801933 <busy_wait+0xf>
	return i;
  80193e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801941:	c9                   	leave  
  801942:	c3                   	ret    
  801943:	90                   	nop

00801944 <__udivdi3>:
  801944:	55                   	push   %ebp
  801945:	57                   	push   %edi
  801946:	56                   	push   %esi
  801947:	53                   	push   %ebx
  801948:	83 ec 1c             	sub    $0x1c,%esp
  80194b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80194f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801953:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801957:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80195b:	89 ca                	mov    %ecx,%edx
  80195d:	89 f8                	mov    %edi,%eax
  80195f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801963:	85 f6                	test   %esi,%esi
  801965:	75 2d                	jne    801994 <__udivdi3+0x50>
  801967:	39 cf                	cmp    %ecx,%edi
  801969:	77 65                	ja     8019d0 <__udivdi3+0x8c>
  80196b:	89 fd                	mov    %edi,%ebp
  80196d:	85 ff                	test   %edi,%edi
  80196f:	75 0b                	jne    80197c <__udivdi3+0x38>
  801971:	b8 01 00 00 00       	mov    $0x1,%eax
  801976:	31 d2                	xor    %edx,%edx
  801978:	f7 f7                	div    %edi
  80197a:	89 c5                	mov    %eax,%ebp
  80197c:	31 d2                	xor    %edx,%edx
  80197e:	89 c8                	mov    %ecx,%eax
  801980:	f7 f5                	div    %ebp
  801982:	89 c1                	mov    %eax,%ecx
  801984:	89 d8                	mov    %ebx,%eax
  801986:	f7 f5                	div    %ebp
  801988:	89 cf                	mov    %ecx,%edi
  80198a:	89 fa                	mov    %edi,%edx
  80198c:	83 c4 1c             	add    $0x1c,%esp
  80198f:	5b                   	pop    %ebx
  801990:	5e                   	pop    %esi
  801991:	5f                   	pop    %edi
  801992:	5d                   	pop    %ebp
  801993:	c3                   	ret    
  801994:	39 ce                	cmp    %ecx,%esi
  801996:	77 28                	ja     8019c0 <__udivdi3+0x7c>
  801998:	0f bd fe             	bsr    %esi,%edi
  80199b:	83 f7 1f             	xor    $0x1f,%edi
  80199e:	75 40                	jne    8019e0 <__udivdi3+0x9c>
  8019a0:	39 ce                	cmp    %ecx,%esi
  8019a2:	72 0a                	jb     8019ae <__udivdi3+0x6a>
  8019a4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019a8:	0f 87 9e 00 00 00    	ja     801a4c <__udivdi3+0x108>
  8019ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8019b3:	89 fa                	mov    %edi,%edx
  8019b5:	83 c4 1c             	add    $0x1c,%esp
  8019b8:	5b                   	pop    %ebx
  8019b9:	5e                   	pop    %esi
  8019ba:	5f                   	pop    %edi
  8019bb:	5d                   	pop    %ebp
  8019bc:	c3                   	ret    
  8019bd:	8d 76 00             	lea    0x0(%esi),%esi
  8019c0:	31 ff                	xor    %edi,%edi
  8019c2:	31 c0                	xor    %eax,%eax
  8019c4:	89 fa                	mov    %edi,%edx
  8019c6:	83 c4 1c             	add    $0x1c,%esp
  8019c9:	5b                   	pop    %ebx
  8019ca:	5e                   	pop    %esi
  8019cb:	5f                   	pop    %edi
  8019cc:	5d                   	pop    %ebp
  8019cd:	c3                   	ret    
  8019ce:	66 90                	xchg   %ax,%ax
  8019d0:	89 d8                	mov    %ebx,%eax
  8019d2:	f7 f7                	div    %edi
  8019d4:	31 ff                	xor    %edi,%edi
  8019d6:	89 fa                	mov    %edi,%edx
  8019d8:	83 c4 1c             	add    $0x1c,%esp
  8019db:	5b                   	pop    %ebx
  8019dc:	5e                   	pop    %esi
  8019dd:	5f                   	pop    %edi
  8019de:	5d                   	pop    %ebp
  8019df:	c3                   	ret    
  8019e0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019e5:	89 eb                	mov    %ebp,%ebx
  8019e7:	29 fb                	sub    %edi,%ebx
  8019e9:	89 f9                	mov    %edi,%ecx
  8019eb:	d3 e6                	shl    %cl,%esi
  8019ed:	89 c5                	mov    %eax,%ebp
  8019ef:	88 d9                	mov    %bl,%cl
  8019f1:	d3 ed                	shr    %cl,%ebp
  8019f3:	89 e9                	mov    %ebp,%ecx
  8019f5:	09 f1                	or     %esi,%ecx
  8019f7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019fb:	89 f9                	mov    %edi,%ecx
  8019fd:	d3 e0                	shl    %cl,%eax
  8019ff:	89 c5                	mov    %eax,%ebp
  801a01:	89 d6                	mov    %edx,%esi
  801a03:	88 d9                	mov    %bl,%cl
  801a05:	d3 ee                	shr    %cl,%esi
  801a07:	89 f9                	mov    %edi,%ecx
  801a09:	d3 e2                	shl    %cl,%edx
  801a0b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a0f:	88 d9                	mov    %bl,%cl
  801a11:	d3 e8                	shr    %cl,%eax
  801a13:	09 c2                	or     %eax,%edx
  801a15:	89 d0                	mov    %edx,%eax
  801a17:	89 f2                	mov    %esi,%edx
  801a19:	f7 74 24 0c          	divl   0xc(%esp)
  801a1d:	89 d6                	mov    %edx,%esi
  801a1f:	89 c3                	mov    %eax,%ebx
  801a21:	f7 e5                	mul    %ebp
  801a23:	39 d6                	cmp    %edx,%esi
  801a25:	72 19                	jb     801a40 <__udivdi3+0xfc>
  801a27:	74 0b                	je     801a34 <__udivdi3+0xf0>
  801a29:	89 d8                	mov    %ebx,%eax
  801a2b:	31 ff                	xor    %edi,%edi
  801a2d:	e9 58 ff ff ff       	jmp    80198a <__udivdi3+0x46>
  801a32:	66 90                	xchg   %ax,%ax
  801a34:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a38:	89 f9                	mov    %edi,%ecx
  801a3a:	d3 e2                	shl    %cl,%edx
  801a3c:	39 c2                	cmp    %eax,%edx
  801a3e:	73 e9                	jae    801a29 <__udivdi3+0xe5>
  801a40:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a43:	31 ff                	xor    %edi,%edi
  801a45:	e9 40 ff ff ff       	jmp    80198a <__udivdi3+0x46>
  801a4a:	66 90                	xchg   %ax,%ax
  801a4c:	31 c0                	xor    %eax,%eax
  801a4e:	e9 37 ff ff ff       	jmp    80198a <__udivdi3+0x46>
  801a53:	90                   	nop

00801a54 <__umoddi3>:
  801a54:	55                   	push   %ebp
  801a55:	57                   	push   %edi
  801a56:	56                   	push   %esi
  801a57:	53                   	push   %ebx
  801a58:	83 ec 1c             	sub    $0x1c,%esp
  801a5b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a5f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a63:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a67:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a6b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a6f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a73:	89 f3                	mov    %esi,%ebx
  801a75:	89 fa                	mov    %edi,%edx
  801a77:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a7b:	89 34 24             	mov    %esi,(%esp)
  801a7e:	85 c0                	test   %eax,%eax
  801a80:	75 1a                	jne    801a9c <__umoddi3+0x48>
  801a82:	39 f7                	cmp    %esi,%edi
  801a84:	0f 86 a2 00 00 00    	jbe    801b2c <__umoddi3+0xd8>
  801a8a:	89 c8                	mov    %ecx,%eax
  801a8c:	89 f2                	mov    %esi,%edx
  801a8e:	f7 f7                	div    %edi
  801a90:	89 d0                	mov    %edx,%eax
  801a92:	31 d2                	xor    %edx,%edx
  801a94:	83 c4 1c             	add    $0x1c,%esp
  801a97:	5b                   	pop    %ebx
  801a98:	5e                   	pop    %esi
  801a99:	5f                   	pop    %edi
  801a9a:	5d                   	pop    %ebp
  801a9b:	c3                   	ret    
  801a9c:	39 f0                	cmp    %esi,%eax
  801a9e:	0f 87 ac 00 00 00    	ja     801b50 <__umoddi3+0xfc>
  801aa4:	0f bd e8             	bsr    %eax,%ebp
  801aa7:	83 f5 1f             	xor    $0x1f,%ebp
  801aaa:	0f 84 ac 00 00 00    	je     801b5c <__umoddi3+0x108>
  801ab0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ab5:	29 ef                	sub    %ebp,%edi
  801ab7:	89 fe                	mov    %edi,%esi
  801ab9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801abd:	89 e9                	mov    %ebp,%ecx
  801abf:	d3 e0                	shl    %cl,%eax
  801ac1:	89 d7                	mov    %edx,%edi
  801ac3:	89 f1                	mov    %esi,%ecx
  801ac5:	d3 ef                	shr    %cl,%edi
  801ac7:	09 c7                	or     %eax,%edi
  801ac9:	89 e9                	mov    %ebp,%ecx
  801acb:	d3 e2                	shl    %cl,%edx
  801acd:	89 14 24             	mov    %edx,(%esp)
  801ad0:	89 d8                	mov    %ebx,%eax
  801ad2:	d3 e0                	shl    %cl,%eax
  801ad4:	89 c2                	mov    %eax,%edx
  801ad6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ada:	d3 e0                	shl    %cl,%eax
  801adc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ae0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ae4:	89 f1                	mov    %esi,%ecx
  801ae6:	d3 e8                	shr    %cl,%eax
  801ae8:	09 d0                	or     %edx,%eax
  801aea:	d3 eb                	shr    %cl,%ebx
  801aec:	89 da                	mov    %ebx,%edx
  801aee:	f7 f7                	div    %edi
  801af0:	89 d3                	mov    %edx,%ebx
  801af2:	f7 24 24             	mull   (%esp)
  801af5:	89 c6                	mov    %eax,%esi
  801af7:	89 d1                	mov    %edx,%ecx
  801af9:	39 d3                	cmp    %edx,%ebx
  801afb:	0f 82 87 00 00 00    	jb     801b88 <__umoddi3+0x134>
  801b01:	0f 84 91 00 00 00    	je     801b98 <__umoddi3+0x144>
  801b07:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b0b:	29 f2                	sub    %esi,%edx
  801b0d:	19 cb                	sbb    %ecx,%ebx
  801b0f:	89 d8                	mov    %ebx,%eax
  801b11:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b15:	d3 e0                	shl    %cl,%eax
  801b17:	89 e9                	mov    %ebp,%ecx
  801b19:	d3 ea                	shr    %cl,%edx
  801b1b:	09 d0                	or     %edx,%eax
  801b1d:	89 e9                	mov    %ebp,%ecx
  801b1f:	d3 eb                	shr    %cl,%ebx
  801b21:	89 da                	mov    %ebx,%edx
  801b23:	83 c4 1c             	add    $0x1c,%esp
  801b26:	5b                   	pop    %ebx
  801b27:	5e                   	pop    %esi
  801b28:	5f                   	pop    %edi
  801b29:	5d                   	pop    %ebp
  801b2a:	c3                   	ret    
  801b2b:	90                   	nop
  801b2c:	89 fd                	mov    %edi,%ebp
  801b2e:	85 ff                	test   %edi,%edi
  801b30:	75 0b                	jne    801b3d <__umoddi3+0xe9>
  801b32:	b8 01 00 00 00       	mov    $0x1,%eax
  801b37:	31 d2                	xor    %edx,%edx
  801b39:	f7 f7                	div    %edi
  801b3b:	89 c5                	mov    %eax,%ebp
  801b3d:	89 f0                	mov    %esi,%eax
  801b3f:	31 d2                	xor    %edx,%edx
  801b41:	f7 f5                	div    %ebp
  801b43:	89 c8                	mov    %ecx,%eax
  801b45:	f7 f5                	div    %ebp
  801b47:	89 d0                	mov    %edx,%eax
  801b49:	e9 44 ff ff ff       	jmp    801a92 <__umoddi3+0x3e>
  801b4e:	66 90                	xchg   %ax,%ax
  801b50:	89 c8                	mov    %ecx,%eax
  801b52:	89 f2                	mov    %esi,%edx
  801b54:	83 c4 1c             	add    $0x1c,%esp
  801b57:	5b                   	pop    %ebx
  801b58:	5e                   	pop    %esi
  801b59:	5f                   	pop    %edi
  801b5a:	5d                   	pop    %ebp
  801b5b:	c3                   	ret    
  801b5c:	3b 04 24             	cmp    (%esp),%eax
  801b5f:	72 06                	jb     801b67 <__umoddi3+0x113>
  801b61:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b65:	77 0f                	ja     801b76 <__umoddi3+0x122>
  801b67:	89 f2                	mov    %esi,%edx
  801b69:	29 f9                	sub    %edi,%ecx
  801b6b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b6f:	89 14 24             	mov    %edx,(%esp)
  801b72:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b76:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b7a:	8b 14 24             	mov    (%esp),%edx
  801b7d:	83 c4 1c             	add    $0x1c,%esp
  801b80:	5b                   	pop    %ebx
  801b81:	5e                   	pop    %esi
  801b82:	5f                   	pop    %edi
  801b83:	5d                   	pop    %ebp
  801b84:	c3                   	ret    
  801b85:	8d 76 00             	lea    0x0(%esi),%esi
  801b88:	2b 04 24             	sub    (%esp),%eax
  801b8b:	19 fa                	sbb    %edi,%edx
  801b8d:	89 d1                	mov    %edx,%ecx
  801b8f:	89 c6                	mov    %eax,%esi
  801b91:	e9 71 ff ff ff       	jmp    801b07 <__umoddi3+0xb3>
  801b96:	66 90                	xchg   %ax,%ax
  801b98:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b9c:	72 ea                	jb     801b88 <__umoddi3+0x134>
  801b9e:	89 d9                	mov    %ebx,%ecx
  801ba0:	e9 62 ff ff ff       	jmp    801b07 <__umoddi3+0xb3>

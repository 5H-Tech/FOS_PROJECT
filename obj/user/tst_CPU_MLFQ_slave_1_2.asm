
obj/user/tst_CPU_MLFQ_slave_1_2:     file format elf32-i386


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
  800031:	e8 98 00 00 00       	call   8000ce <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 5e                	jmp    8000a5 <_main+0x6d>
	{
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
  80006a:	68 c0 1b 80 00       	push   $0x801bc0
  80006f:	e8 8c 15 00 00       	call   801600 <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if (ID == E_ENV_CREATION_ERROR)
  80007a:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  80007e:	75 14                	jne    800094 <_main+0x5c>
			panic("RUNNING OUT OF ENV!! terminating...");
  800080:	83 ec 04             	sub    $0x4,%esp
  800083:	68 d0 1b 80 00       	push   $0x801bd0
  800088:	6a 0b                	push   $0xb
  80008a:	68 f4 1b 80 00       	push   $0x801bf4
  80008f:	e8 7f 01 00 00       	call   800213 <_panic>
		sys_run_env(ID);
  800094:	83 ec 0c             	sub    $0xc,%esp
  800097:	ff 75 f0             	pushl  -0x10(%ebp)
  80009a:	e8 7f 15 00 00       	call   80161e <sys_run_env>
  80009f:	83 c4 10             	add    $0x10,%esp

void _main(void)
{
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  8000a2:	ff 45 f4             	incl   -0xc(%ebp)
  8000a5:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  8000a9:	7e 9c                	jle    800047 <_main+0xf>
		if (ID == E_ENV_CREATION_ERROR)
			panic("RUNNING OUT OF ENV!! terminating...");
		sys_run_env(ID);
	}

	env_sleep(100000);
  8000ab:	83 ec 0c             	sub    $0xc,%esp
  8000ae:	68 a0 86 01 00       	push   $0x186a0
  8000b3:	e8 e4 17 00 00       	call   80189c <env_sleep>
  8000b8:	83 c4 10             	add    $0x10,%esp
	// To ensure that the slave environments completed successfully
	cprintf("Congratulations!! test CPU SCHEDULING using MLFQ is completed successfully.\n");
  8000bb:	83 ec 0c             	sub    $0xc,%esp
  8000be:	68 14 1c 80 00       	push   $0x801c14
  8000c3:	e8 ed 03 00 00       	call   8004b5 <cprintf>
  8000c8:	83 c4 10             	add    $0x10,%esp

	return;
  8000cb:	90                   	nop
}
  8000cc:	c9                   	leave  
  8000cd:	c3                   	ret    

008000ce <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000ce:	55                   	push   %ebp
  8000cf:	89 e5                	mov    %esp,%ebp
  8000d1:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000d4:	e8 07 12 00 00       	call   8012e0 <sys_getenvindex>
  8000d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000df:	89 d0                	mov    %edx,%eax
  8000e1:	c1 e0 03             	shl    $0x3,%eax
  8000e4:	01 d0                	add    %edx,%eax
  8000e6:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000ed:	01 c8                	add    %ecx,%eax
  8000ef:	01 c0                	add    %eax,%eax
  8000f1:	01 d0                	add    %edx,%eax
  8000f3:	01 c0                	add    %eax,%eax
  8000f5:	01 d0                	add    %edx,%eax
  8000f7:	89 c2                	mov    %eax,%edx
  8000f9:	c1 e2 05             	shl    $0x5,%edx
  8000fc:	29 c2                	sub    %eax,%edx
  8000fe:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800105:	89 c2                	mov    %eax,%edx
  800107:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80010d:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800112:	a1 20 30 80 00       	mov    0x803020,%eax
  800117:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80011d:	84 c0                	test   %al,%al
  80011f:	74 0f                	je     800130 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800121:	a1 20 30 80 00       	mov    0x803020,%eax
  800126:	05 40 3c 01 00       	add    $0x13c40,%eax
  80012b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800130:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800134:	7e 0a                	jle    800140 <libmain+0x72>
		binaryname = argv[0];
  800136:	8b 45 0c             	mov    0xc(%ebp),%eax
  800139:	8b 00                	mov    (%eax),%eax
  80013b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800140:	83 ec 08             	sub    $0x8,%esp
  800143:	ff 75 0c             	pushl  0xc(%ebp)
  800146:	ff 75 08             	pushl  0x8(%ebp)
  800149:	e8 ea fe ff ff       	call   800038 <_main>
  80014e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800151:	e8 25 13 00 00       	call   80147b <sys_disable_interrupt>
	cprintf("**************************************\n");
  800156:	83 ec 0c             	sub    $0xc,%esp
  800159:	68 7c 1c 80 00       	push   $0x801c7c
  80015e:	e8 52 03 00 00       	call   8004b5 <cprintf>
  800163:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800166:	a1 20 30 80 00       	mov    0x803020,%eax
  80016b:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800171:	a1 20 30 80 00       	mov    0x803020,%eax
  800176:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80017c:	83 ec 04             	sub    $0x4,%esp
  80017f:	52                   	push   %edx
  800180:	50                   	push   %eax
  800181:	68 a4 1c 80 00       	push   $0x801ca4
  800186:	e8 2a 03 00 00       	call   8004b5 <cprintf>
  80018b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80018e:	a1 20 30 80 00       	mov    0x803020,%eax
  800193:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800199:	a1 20 30 80 00       	mov    0x803020,%eax
  80019e:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8001a4:	83 ec 04             	sub    $0x4,%esp
  8001a7:	52                   	push   %edx
  8001a8:	50                   	push   %eax
  8001a9:	68 cc 1c 80 00       	push   $0x801ccc
  8001ae:	e8 02 03 00 00       	call   8004b5 <cprintf>
  8001b3:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bb:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8001c1:	83 ec 08             	sub    $0x8,%esp
  8001c4:	50                   	push   %eax
  8001c5:	68 0d 1d 80 00       	push   $0x801d0d
  8001ca:	e8 e6 02 00 00       	call   8004b5 <cprintf>
  8001cf:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 7c 1c 80 00       	push   $0x801c7c
  8001da:	e8 d6 02 00 00       	call   8004b5 <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001e2:	e8 ae 12 00 00       	call   801495 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001e7:	e8 19 00 00 00       	call   800205 <exit>
}
  8001ec:	90                   	nop
  8001ed:	c9                   	leave  
  8001ee:	c3                   	ret    

008001ef <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001ef:	55                   	push   %ebp
  8001f0:	89 e5                	mov    %esp,%ebp
  8001f2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	6a 00                	push   $0x0
  8001fa:	e8 ad 10 00 00       	call   8012ac <sys_env_destroy>
  8001ff:	83 c4 10             	add    $0x10,%esp
}
  800202:	90                   	nop
  800203:	c9                   	leave  
  800204:	c3                   	ret    

00800205 <exit>:

void
exit(void)
{
  800205:	55                   	push   %ebp
  800206:	89 e5                	mov    %esp,%ebp
  800208:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80020b:	e8 02 11 00 00       	call   801312 <sys_env_exit>
}
  800210:	90                   	nop
  800211:	c9                   	leave  
  800212:	c3                   	ret    

00800213 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800213:	55                   	push   %ebp
  800214:	89 e5                	mov    %esp,%ebp
  800216:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800219:	8d 45 10             	lea    0x10(%ebp),%eax
  80021c:	83 c0 04             	add    $0x4,%eax
  80021f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800222:	a1 18 31 80 00       	mov    0x803118,%eax
  800227:	85 c0                	test   %eax,%eax
  800229:	74 16                	je     800241 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80022b:	a1 18 31 80 00       	mov    0x803118,%eax
  800230:	83 ec 08             	sub    $0x8,%esp
  800233:	50                   	push   %eax
  800234:	68 24 1d 80 00       	push   $0x801d24
  800239:	e8 77 02 00 00       	call   8004b5 <cprintf>
  80023e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800241:	a1 00 30 80 00       	mov    0x803000,%eax
  800246:	ff 75 0c             	pushl  0xc(%ebp)
  800249:	ff 75 08             	pushl  0x8(%ebp)
  80024c:	50                   	push   %eax
  80024d:	68 29 1d 80 00       	push   $0x801d29
  800252:	e8 5e 02 00 00       	call   8004b5 <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80025a:	8b 45 10             	mov    0x10(%ebp),%eax
  80025d:	83 ec 08             	sub    $0x8,%esp
  800260:	ff 75 f4             	pushl  -0xc(%ebp)
  800263:	50                   	push   %eax
  800264:	e8 e1 01 00 00       	call   80044a <vcprintf>
  800269:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80026c:	83 ec 08             	sub    $0x8,%esp
  80026f:	6a 00                	push   $0x0
  800271:	68 45 1d 80 00       	push   $0x801d45
  800276:	e8 cf 01 00 00       	call   80044a <vcprintf>
  80027b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80027e:	e8 82 ff ff ff       	call   800205 <exit>

	// should not return here
	while (1) ;
  800283:	eb fe                	jmp    800283 <_panic+0x70>

00800285 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800285:	55                   	push   %ebp
  800286:	89 e5                	mov    %esp,%ebp
  800288:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80028b:	a1 20 30 80 00       	mov    0x803020,%eax
  800290:	8b 50 74             	mov    0x74(%eax),%edx
  800293:	8b 45 0c             	mov    0xc(%ebp),%eax
  800296:	39 c2                	cmp    %eax,%edx
  800298:	74 14                	je     8002ae <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80029a:	83 ec 04             	sub    $0x4,%esp
  80029d:	68 48 1d 80 00       	push   $0x801d48
  8002a2:	6a 26                	push   $0x26
  8002a4:	68 94 1d 80 00       	push   $0x801d94
  8002a9:	e8 65 ff ff ff       	call   800213 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002bc:	e9 b6 00 00 00       	jmp    800377 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8002c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ce:	01 d0                	add    %edx,%eax
  8002d0:	8b 00                	mov    (%eax),%eax
  8002d2:	85 c0                	test   %eax,%eax
  8002d4:	75 08                	jne    8002de <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8002d6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8002d9:	e9 96 00 00 00       	jmp    800374 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8002de:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002e5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002ec:	eb 5d                	jmp    80034b <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8002ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002f9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002fc:	c1 e2 04             	shl    $0x4,%edx
  8002ff:	01 d0                	add    %edx,%eax
  800301:	8a 40 04             	mov    0x4(%eax),%al
  800304:	84 c0                	test   %al,%al
  800306:	75 40                	jne    800348 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800308:	a1 20 30 80 00       	mov    0x803020,%eax
  80030d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800313:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800316:	c1 e2 04             	shl    $0x4,%edx
  800319:	01 d0                	add    %edx,%eax
  80031b:	8b 00                	mov    (%eax),%eax
  80031d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800320:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800323:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800328:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80032a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80032d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800334:	8b 45 08             	mov    0x8(%ebp),%eax
  800337:	01 c8                	add    %ecx,%eax
  800339:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80033b:	39 c2                	cmp    %eax,%edx
  80033d:	75 09                	jne    800348 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80033f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800346:	eb 12                	jmp    80035a <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800348:	ff 45 e8             	incl   -0x18(%ebp)
  80034b:	a1 20 30 80 00       	mov    0x803020,%eax
  800350:	8b 50 74             	mov    0x74(%eax),%edx
  800353:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800356:	39 c2                	cmp    %eax,%edx
  800358:	77 94                	ja     8002ee <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80035a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80035e:	75 14                	jne    800374 <CheckWSWithoutLastIndex+0xef>
			panic(
  800360:	83 ec 04             	sub    $0x4,%esp
  800363:	68 a0 1d 80 00       	push   $0x801da0
  800368:	6a 3a                	push   $0x3a
  80036a:	68 94 1d 80 00       	push   $0x801d94
  80036f:	e8 9f fe ff ff       	call   800213 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800374:	ff 45 f0             	incl   -0x10(%ebp)
  800377:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80037d:	0f 8c 3e ff ff ff    	jl     8002c1 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800383:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80038a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800391:	eb 20                	jmp    8003b3 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800393:	a1 20 30 80 00       	mov    0x803020,%eax
  800398:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80039e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003a1:	c1 e2 04             	shl    $0x4,%edx
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8a 40 04             	mov    0x4(%eax),%al
  8003a9:	3c 01                	cmp    $0x1,%al
  8003ab:	75 03                	jne    8003b0 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8003ad:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003b0:	ff 45 e0             	incl   -0x20(%ebp)
  8003b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b8:	8b 50 74             	mov    0x74(%eax),%edx
  8003bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003be:	39 c2                	cmp    %eax,%edx
  8003c0:	77 d1                	ja     800393 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003c5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8003c8:	74 14                	je     8003de <CheckWSWithoutLastIndex+0x159>
		panic(
  8003ca:	83 ec 04             	sub    $0x4,%esp
  8003cd:	68 f4 1d 80 00       	push   $0x801df4
  8003d2:	6a 44                	push   $0x44
  8003d4:	68 94 1d 80 00       	push   $0x801d94
  8003d9:	e8 35 fe ff ff       	call   800213 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8003de:	90                   	nop
  8003df:	c9                   	leave  
  8003e0:	c3                   	ret    

008003e1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8003e1:	55                   	push   %ebp
  8003e2:	89 e5                	mov    %esp,%ebp
  8003e4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8003e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ea:	8b 00                	mov    (%eax),%eax
  8003ec:	8d 48 01             	lea    0x1(%eax),%ecx
  8003ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003f2:	89 0a                	mov    %ecx,(%edx)
  8003f4:	8b 55 08             	mov    0x8(%ebp),%edx
  8003f7:	88 d1                	mov    %dl,%cl
  8003f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003fc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800400:	8b 45 0c             	mov    0xc(%ebp),%eax
  800403:	8b 00                	mov    (%eax),%eax
  800405:	3d ff 00 00 00       	cmp    $0xff,%eax
  80040a:	75 2c                	jne    800438 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80040c:	a0 24 30 80 00       	mov    0x803024,%al
  800411:	0f b6 c0             	movzbl %al,%eax
  800414:	8b 55 0c             	mov    0xc(%ebp),%edx
  800417:	8b 12                	mov    (%edx),%edx
  800419:	89 d1                	mov    %edx,%ecx
  80041b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80041e:	83 c2 08             	add    $0x8,%edx
  800421:	83 ec 04             	sub    $0x4,%esp
  800424:	50                   	push   %eax
  800425:	51                   	push   %ecx
  800426:	52                   	push   %edx
  800427:	e8 3e 0e 00 00       	call   80126a <sys_cputs>
  80042c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80042f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800432:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800438:	8b 45 0c             	mov    0xc(%ebp),%eax
  80043b:	8b 40 04             	mov    0x4(%eax),%eax
  80043e:	8d 50 01             	lea    0x1(%eax),%edx
  800441:	8b 45 0c             	mov    0xc(%ebp),%eax
  800444:	89 50 04             	mov    %edx,0x4(%eax)
}
  800447:	90                   	nop
  800448:	c9                   	leave  
  800449:	c3                   	ret    

0080044a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80044a:	55                   	push   %ebp
  80044b:	89 e5                	mov    %esp,%ebp
  80044d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800453:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80045a:	00 00 00 
	b.cnt = 0;
  80045d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800464:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800467:	ff 75 0c             	pushl  0xc(%ebp)
  80046a:	ff 75 08             	pushl  0x8(%ebp)
  80046d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800473:	50                   	push   %eax
  800474:	68 e1 03 80 00       	push   $0x8003e1
  800479:	e8 11 02 00 00       	call   80068f <vprintfmt>
  80047e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800481:	a0 24 30 80 00       	mov    0x803024,%al
  800486:	0f b6 c0             	movzbl %al,%eax
  800489:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80048f:	83 ec 04             	sub    $0x4,%esp
  800492:	50                   	push   %eax
  800493:	52                   	push   %edx
  800494:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80049a:	83 c0 08             	add    $0x8,%eax
  80049d:	50                   	push   %eax
  80049e:	e8 c7 0d 00 00       	call   80126a <sys_cputs>
  8004a3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004a6:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8004ad:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004b3:	c9                   	leave  
  8004b4:	c3                   	ret    

008004b5 <cprintf>:

int cprintf(const char *fmt, ...) {
  8004b5:	55                   	push   %ebp
  8004b6:	89 e5                	mov    %esp,%ebp
  8004b8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004bb:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8004c2:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cb:	83 ec 08             	sub    $0x8,%esp
  8004ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8004d1:	50                   	push   %eax
  8004d2:	e8 73 ff ff ff       	call   80044a <vcprintf>
  8004d7:	83 c4 10             	add    $0x10,%esp
  8004da:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8004dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004e0:	c9                   	leave  
  8004e1:	c3                   	ret    

008004e2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8004e2:	55                   	push   %ebp
  8004e3:	89 e5                	mov    %esp,%ebp
  8004e5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8004e8:	e8 8e 0f 00 00       	call   80147b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8004ed:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f6:	83 ec 08             	sub    $0x8,%esp
  8004f9:	ff 75 f4             	pushl  -0xc(%ebp)
  8004fc:	50                   	push   %eax
  8004fd:	e8 48 ff ff ff       	call   80044a <vcprintf>
  800502:	83 c4 10             	add    $0x10,%esp
  800505:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800508:	e8 88 0f 00 00       	call   801495 <sys_enable_interrupt>
	return cnt;
  80050d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800510:	c9                   	leave  
  800511:	c3                   	ret    

00800512 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800512:	55                   	push   %ebp
  800513:	89 e5                	mov    %esp,%ebp
  800515:	53                   	push   %ebx
  800516:	83 ec 14             	sub    $0x14,%esp
  800519:	8b 45 10             	mov    0x10(%ebp),%eax
  80051c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80051f:	8b 45 14             	mov    0x14(%ebp),%eax
  800522:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800525:	8b 45 18             	mov    0x18(%ebp),%eax
  800528:	ba 00 00 00 00       	mov    $0x0,%edx
  80052d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800530:	77 55                	ja     800587 <printnum+0x75>
  800532:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800535:	72 05                	jb     80053c <printnum+0x2a>
  800537:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80053a:	77 4b                	ja     800587 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80053c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80053f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800542:	8b 45 18             	mov    0x18(%ebp),%eax
  800545:	ba 00 00 00 00       	mov    $0x0,%edx
  80054a:	52                   	push   %edx
  80054b:	50                   	push   %eax
  80054c:	ff 75 f4             	pushl  -0xc(%ebp)
  80054f:	ff 75 f0             	pushl  -0x10(%ebp)
  800552:	e8 f9 13 00 00       	call   801950 <__udivdi3>
  800557:	83 c4 10             	add    $0x10,%esp
  80055a:	83 ec 04             	sub    $0x4,%esp
  80055d:	ff 75 20             	pushl  0x20(%ebp)
  800560:	53                   	push   %ebx
  800561:	ff 75 18             	pushl  0x18(%ebp)
  800564:	52                   	push   %edx
  800565:	50                   	push   %eax
  800566:	ff 75 0c             	pushl  0xc(%ebp)
  800569:	ff 75 08             	pushl  0x8(%ebp)
  80056c:	e8 a1 ff ff ff       	call   800512 <printnum>
  800571:	83 c4 20             	add    $0x20,%esp
  800574:	eb 1a                	jmp    800590 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800576:	83 ec 08             	sub    $0x8,%esp
  800579:	ff 75 0c             	pushl  0xc(%ebp)
  80057c:	ff 75 20             	pushl  0x20(%ebp)
  80057f:	8b 45 08             	mov    0x8(%ebp),%eax
  800582:	ff d0                	call   *%eax
  800584:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800587:	ff 4d 1c             	decl   0x1c(%ebp)
  80058a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80058e:	7f e6                	jg     800576 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800590:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800593:	bb 00 00 00 00       	mov    $0x0,%ebx
  800598:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80059b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80059e:	53                   	push   %ebx
  80059f:	51                   	push   %ecx
  8005a0:	52                   	push   %edx
  8005a1:	50                   	push   %eax
  8005a2:	e8 b9 14 00 00       	call   801a60 <__umoddi3>
  8005a7:	83 c4 10             	add    $0x10,%esp
  8005aa:	05 54 20 80 00       	add    $0x802054,%eax
  8005af:	8a 00                	mov    (%eax),%al
  8005b1:	0f be c0             	movsbl %al,%eax
  8005b4:	83 ec 08             	sub    $0x8,%esp
  8005b7:	ff 75 0c             	pushl  0xc(%ebp)
  8005ba:	50                   	push   %eax
  8005bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005be:	ff d0                	call   *%eax
  8005c0:	83 c4 10             	add    $0x10,%esp
}
  8005c3:	90                   	nop
  8005c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005c7:	c9                   	leave  
  8005c8:	c3                   	ret    

008005c9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8005c9:	55                   	push   %ebp
  8005ca:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005cc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005d0:	7e 1c                	jle    8005ee <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8005d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d5:	8b 00                	mov    (%eax),%eax
  8005d7:	8d 50 08             	lea    0x8(%eax),%edx
  8005da:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dd:	89 10                	mov    %edx,(%eax)
  8005df:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e2:	8b 00                	mov    (%eax),%eax
  8005e4:	83 e8 08             	sub    $0x8,%eax
  8005e7:	8b 50 04             	mov    0x4(%eax),%edx
  8005ea:	8b 00                	mov    (%eax),%eax
  8005ec:	eb 40                	jmp    80062e <getuint+0x65>
	else if (lflag)
  8005ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005f2:	74 1e                	je     800612 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	8b 00                	mov    (%eax),%eax
  8005f9:	8d 50 04             	lea    0x4(%eax),%edx
  8005fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ff:	89 10                	mov    %edx,(%eax)
  800601:	8b 45 08             	mov    0x8(%ebp),%eax
  800604:	8b 00                	mov    (%eax),%eax
  800606:	83 e8 04             	sub    $0x4,%eax
  800609:	8b 00                	mov    (%eax),%eax
  80060b:	ba 00 00 00 00       	mov    $0x0,%edx
  800610:	eb 1c                	jmp    80062e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800612:	8b 45 08             	mov    0x8(%ebp),%eax
  800615:	8b 00                	mov    (%eax),%eax
  800617:	8d 50 04             	lea    0x4(%eax),%edx
  80061a:	8b 45 08             	mov    0x8(%ebp),%eax
  80061d:	89 10                	mov    %edx,(%eax)
  80061f:	8b 45 08             	mov    0x8(%ebp),%eax
  800622:	8b 00                	mov    (%eax),%eax
  800624:	83 e8 04             	sub    $0x4,%eax
  800627:	8b 00                	mov    (%eax),%eax
  800629:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80062e:	5d                   	pop    %ebp
  80062f:	c3                   	ret    

00800630 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800630:	55                   	push   %ebp
  800631:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800633:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800637:	7e 1c                	jle    800655 <getint+0x25>
		return va_arg(*ap, long long);
  800639:	8b 45 08             	mov    0x8(%ebp),%eax
  80063c:	8b 00                	mov    (%eax),%eax
  80063e:	8d 50 08             	lea    0x8(%eax),%edx
  800641:	8b 45 08             	mov    0x8(%ebp),%eax
  800644:	89 10                	mov    %edx,(%eax)
  800646:	8b 45 08             	mov    0x8(%ebp),%eax
  800649:	8b 00                	mov    (%eax),%eax
  80064b:	83 e8 08             	sub    $0x8,%eax
  80064e:	8b 50 04             	mov    0x4(%eax),%edx
  800651:	8b 00                	mov    (%eax),%eax
  800653:	eb 38                	jmp    80068d <getint+0x5d>
	else if (lflag)
  800655:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800659:	74 1a                	je     800675 <getint+0x45>
		return va_arg(*ap, long);
  80065b:	8b 45 08             	mov    0x8(%ebp),%eax
  80065e:	8b 00                	mov    (%eax),%eax
  800660:	8d 50 04             	lea    0x4(%eax),%edx
  800663:	8b 45 08             	mov    0x8(%ebp),%eax
  800666:	89 10                	mov    %edx,(%eax)
  800668:	8b 45 08             	mov    0x8(%ebp),%eax
  80066b:	8b 00                	mov    (%eax),%eax
  80066d:	83 e8 04             	sub    $0x4,%eax
  800670:	8b 00                	mov    (%eax),%eax
  800672:	99                   	cltd   
  800673:	eb 18                	jmp    80068d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800675:	8b 45 08             	mov    0x8(%ebp),%eax
  800678:	8b 00                	mov    (%eax),%eax
  80067a:	8d 50 04             	lea    0x4(%eax),%edx
  80067d:	8b 45 08             	mov    0x8(%ebp),%eax
  800680:	89 10                	mov    %edx,(%eax)
  800682:	8b 45 08             	mov    0x8(%ebp),%eax
  800685:	8b 00                	mov    (%eax),%eax
  800687:	83 e8 04             	sub    $0x4,%eax
  80068a:	8b 00                	mov    (%eax),%eax
  80068c:	99                   	cltd   
}
  80068d:	5d                   	pop    %ebp
  80068e:	c3                   	ret    

0080068f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80068f:	55                   	push   %ebp
  800690:	89 e5                	mov    %esp,%ebp
  800692:	56                   	push   %esi
  800693:	53                   	push   %ebx
  800694:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800697:	eb 17                	jmp    8006b0 <vprintfmt+0x21>
			if (ch == '\0')
  800699:	85 db                	test   %ebx,%ebx
  80069b:	0f 84 af 03 00 00    	je     800a50 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006a1:	83 ec 08             	sub    $0x8,%esp
  8006a4:	ff 75 0c             	pushl  0xc(%ebp)
  8006a7:	53                   	push   %ebx
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	ff d0                	call   *%eax
  8006ad:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8006b3:	8d 50 01             	lea    0x1(%eax),%edx
  8006b6:	89 55 10             	mov    %edx,0x10(%ebp)
  8006b9:	8a 00                	mov    (%eax),%al
  8006bb:	0f b6 d8             	movzbl %al,%ebx
  8006be:	83 fb 25             	cmp    $0x25,%ebx
  8006c1:	75 d6                	jne    800699 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006c3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8006c7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8006ce:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8006d5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8006dc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8006e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e6:	8d 50 01             	lea    0x1(%eax),%edx
  8006e9:	89 55 10             	mov    %edx,0x10(%ebp)
  8006ec:	8a 00                	mov    (%eax),%al
  8006ee:	0f b6 d8             	movzbl %al,%ebx
  8006f1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006f4:	83 f8 55             	cmp    $0x55,%eax
  8006f7:	0f 87 2b 03 00 00    	ja     800a28 <vprintfmt+0x399>
  8006fd:	8b 04 85 78 20 80 00 	mov    0x802078(,%eax,4),%eax
  800704:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800706:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80070a:	eb d7                	jmp    8006e3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80070c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800710:	eb d1                	jmp    8006e3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800712:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800719:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80071c:	89 d0                	mov    %edx,%eax
  80071e:	c1 e0 02             	shl    $0x2,%eax
  800721:	01 d0                	add    %edx,%eax
  800723:	01 c0                	add    %eax,%eax
  800725:	01 d8                	add    %ebx,%eax
  800727:	83 e8 30             	sub    $0x30,%eax
  80072a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80072d:	8b 45 10             	mov    0x10(%ebp),%eax
  800730:	8a 00                	mov    (%eax),%al
  800732:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800735:	83 fb 2f             	cmp    $0x2f,%ebx
  800738:	7e 3e                	jle    800778 <vprintfmt+0xe9>
  80073a:	83 fb 39             	cmp    $0x39,%ebx
  80073d:	7f 39                	jg     800778 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80073f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800742:	eb d5                	jmp    800719 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800744:	8b 45 14             	mov    0x14(%ebp),%eax
  800747:	83 c0 04             	add    $0x4,%eax
  80074a:	89 45 14             	mov    %eax,0x14(%ebp)
  80074d:	8b 45 14             	mov    0x14(%ebp),%eax
  800750:	83 e8 04             	sub    $0x4,%eax
  800753:	8b 00                	mov    (%eax),%eax
  800755:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800758:	eb 1f                	jmp    800779 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80075a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80075e:	79 83                	jns    8006e3 <vprintfmt+0x54>
				width = 0;
  800760:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800767:	e9 77 ff ff ff       	jmp    8006e3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80076c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800773:	e9 6b ff ff ff       	jmp    8006e3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800778:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800779:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80077d:	0f 89 60 ff ff ff    	jns    8006e3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800783:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800786:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800789:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800790:	e9 4e ff ff ff       	jmp    8006e3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800795:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800798:	e9 46 ff ff ff       	jmp    8006e3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80079d:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a0:	83 c0 04             	add    $0x4,%eax
  8007a3:	89 45 14             	mov    %eax,0x14(%ebp)
  8007a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a9:	83 e8 04             	sub    $0x4,%eax
  8007ac:	8b 00                	mov    (%eax),%eax
  8007ae:	83 ec 08             	sub    $0x8,%esp
  8007b1:	ff 75 0c             	pushl  0xc(%ebp)
  8007b4:	50                   	push   %eax
  8007b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b8:	ff d0                	call   *%eax
  8007ba:	83 c4 10             	add    $0x10,%esp
			break;
  8007bd:	e9 89 02 00 00       	jmp    800a4b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c5:	83 c0 04             	add    $0x4,%eax
  8007c8:	89 45 14             	mov    %eax,0x14(%ebp)
  8007cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ce:	83 e8 04             	sub    $0x4,%eax
  8007d1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8007d3:	85 db                	test   %ebx,%ebx
  8007d5:	79 02                	jns    8007d9 <vprintfmt+0x14a>
				err = -err;
  8007d7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8007d9:	83 fb 64             	cmp    $0x64,%ebx
  8007dc:	7f 0b                	jg     8007e9 <vprintfmt+0x15a>
  8007de:	8b 34 9d c0 1e 80 00 	mov    0x801ec0(,%ebx,4),%esi
  8007e5:	85 f6                	test   %esi,%esi
  8007e7:	75 19                	jne    800802 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8007e9:	53                   	push   %ebx
  8007ea:	68 65 20 80 00       	push   $0x802065
  8007ef:	ff 75 0c             	pushl  0xc(%ebp)
  8007f2:	ff 75 08             	pushl  0x8(%ebp)
  8007f5:	e8 5e 02 00 00       	call   800a58 <printfmt>
  8007fa:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007fd:	e9 49 02 00 00       	jmp    800a4b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800802:	56                   	push   %esi
  800803:	68 6e 20 80 00       	push   $0x80206e
  800808:	ff 75 0c             	pushl  0xc(%ebp)
  80080b:	ff 75 08             	pushl  0x8(%ebp)
  80080e:	e8 45 02 00 00       	call   800a58 <printfmt>
  800813:	83 c4 10             	add    $0x10,%esp
			break;
  800816:	e9 30 02 00 00       	jmp    800a4b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80081b:	8b 45 14             	mov    0x14(%ebp),%eax
  80081e:	83 c0 04             	add    $0x4,%eax
  800821:	89 45 14             	mov    %eax,0x14(%ebp)
  800824:	8b 45 14             	mov    0x14(%ebp),%eax
  800827:	83 e8 04             	sub    $0x4,%eax
  80082a:	8b 30                	mov    (%eax),%esi
  80082c:	85 f6                	test   %esi,%esi
  80082e:	75 05                	jne    800835 <vprintfmt+0x1a6>
				p = "(null)";
  800830:	be 71 20 80 00       	mov    $0x802071,%esi
			if (width > 0 && padc != '-')
  800835:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800839:	7e 6d                	jle    8008a8 <vprintfmt+0x219>
  80083b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80083f:	74 67                	je     8008a8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800841:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800844:	83 ec 08             	sub    $0x8,%esp
  800847:	50                   	push   %eax
  800848:	56                   	push   %esi
  800849:	e8 0c 03 00 00       	call   800b5a <strnlen>
  80084e:	83 c4 10             	add    $0x10,%esp
  800851:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800854:	eb 16                	jmp    80086c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800856:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80085a:	83 ec 08             	sub    $0x8,%esp
  80085d:	ff 75 0c             	pushl  0xc(%ebp)
  800860:	50                   	push   %eax
  800861:	8b 45 08             	mov    0x8(%ebp),%eax
  800864:	ff d0                	call   *%eax
  800866:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800869:	ff 4d e4             	decl   -0x1c(%ebp)
  80086c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800870:	7f e4                	jg     800856 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800872:	eb 34                	jmp    8008a8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800874:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800878:	74 1c                	je     800896 <vprintfmt+0x207>
  80087a:	83 fb 1f             	cmp    $0x1f,%ebx
  80087d:	7e 05                	jle    800884 <vprintfmt+0x1f5>
  80087f:	83 fb 7e             	cmp    $0x7e,%ebx
  800882:	7e 12                	jle    800896 <vprintfmt+0x207>
					putch('?', putdat);
  800884:	83 ec 08             	sub    $0x8,%esp
  800887:	ff 75 0c             	pushl  0xc(%ebp)
  80088a:	6a 3f                	push   $0x3f
  80088c:	8b 45 08             	mov    0x8(%ebp),%eax
  80088f:	ff d0                	call   *%eax
  800891:	83 c4 10             	add    $0x10,%esp
  800894:	eb 0f                	jmp    8008a5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800896:	83 ec 08             	sub    $0x8,%esp
  800899:	ff 75 0c             	pushl  0xc(%ebp)
  80089c:	53                   	push   %ebx
  80089d:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a0:	ff d0                	call   *%eax
  8008a2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008a5:	ff 4d e4             	decl   -0x1c(%ebp)
  8008a8:	89 f0                	mov    %esi,%eax
  8008aa:	8d 70 01             	lea    0x1(%eax),%esi
  8008ad:	8a 00                	mov    (%eax),%al
  8008af:	0f be d8             	movsbl %al,%ebx
  8008b2:	85 db                	test   %ebx,%ebx
  8008b4:	74 24                	je     8008da <vprintfmt+0x24b>
  8008b6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008ba:	78 b8                	js     800874 <vprintfmt+0x1e5>
  8008bc:	ff 4d e0             	decl   -0x20(%ebp)
  8008bf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008c3:	79 af                	jns    800874 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008c5:	eb 13                	jmp    8008da <vprintfmt+0x24b>
				putch(' ', putdat);
  8008c7:	83 ec 08             	sub    $0x8,%esp
  8008ca:	ff 75 0c             	pushl  0xc(%ebp)
  8008cd:	6a 20                	push   $0x20
  8008cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d2:	ff d0                	call   *%eax
  8008d4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008d7:	ff 4d e4             	decl   -0x1c(%ebp)
  8008da:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008de:	7f e7                	jg     8008c7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8008e0:	e9 66 01 00 00       	jmp    800a4b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8008e5:	83 ec 08             	sub    $0x8,%esp
  8008e8:	ff 75 e8             	pushl  -0x18(%ebp)
  8008eb:	8d 45 14             	lea    0x14(%ebp),%eax
  8008ee:	50                   	push   %eax
  8008ef:	e8 3c fd ff ff       	call   800630 <getint>
  8008f4:	83 c4 10             	add    $0x10,%esp
  8008f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800900:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800903:	85 d2                	test   %edx,%edx
  800905:	79 23                	jns    80092a <vprintfmt+0x29b>
				putch('-', putdat);
  800907:	83 ec 08             	sub    $0x8,%esp
  80090a:	ff 75 0c             	pushl  0xc(%ebp)
  80090d:	6a 2d                	push   $0x2d
  80090f:	8b 45 08             	mov    0x8(%ebp),%eax
  800912:	ff d0                	call   *%eax
  800914:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800917:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80091a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80091d:	f7 d8                	neg    %eax
  80091f:	83 d2 00             	adc    $0x0,%edx
  800922:	f7 da                	neg    %edx
  800924:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800927:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80092a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800931:	e9 bc 00 00 00       	jmp    8009f2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800936:	83 ec 08             	sub    $0x8,%esp
  800939:	ff 75 e8             	pushl  -0x18(%ebp)
  80093c:	8d 45 14             	lea    0x14(%ebp),%eax
  80093f:	50                   	push   %eax
  800940:	e8 84 fc ff ff       	call   8005c9 <getuint>
  800945:	83 c4 10             	add    $0x10,%esp
  800948:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80094b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80094e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800955:	e9 98 00 00 00       	jmp    8009f2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80095a:	83 ec 08             	sub    $0x8,%esp
  80095d:	ff 75 0c             	pushl  0xc(%ebp)
  800960:	6a 58                	push   $0x58
  800962:	8b 45 08             	mov    0x8(%ebp),%eax
  800965:	ff d0                	call   *%eax
  800967:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80096a:	83 ec 08             	sub    $0x8,%esp
  80096d:	ff 75 0c             	pushl  0xc(%ebp)
  800970:	6a 58                	push   $0x58
  800972:	8b 45 08             	mov    0x8(%ebp),%eax
  800975:	ff d0                	call   *%eax
  800977:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80097a:	83 ec 08             	sub    $0x8,%esp
  80097d:	ff 75 0c             	pushl  0xc(%ebp)
  800980:	6a 58                	push   $0x58
  800982:	8b 45 08             	mov    0x8(%ebp),%eax
  800985:	ff d0                	call   *%eax
  800987:	83 c4 10             	add    $0x10,%esp
			break;
  80098a:	e9 bc 00 00 00       	jmp    800a4b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80098f:	83 ec 08             	sub    $0x8,%esp
  800992:	ff 75 0c             	pushl  0xc(%ebp)
  800995:	6a 30                	push   $0x30
  800997:	8b 45 08             	mov    0x8(%ebp),%eax
  80099a:	ff d0                	call   *%eax
  80099c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80099f:	83 ec 08             	sub    $0x8,%esp
  8009a2:	ff 75 0c             	pushl  0xc(%ebp)
  8009a5:	6a 78                	push   $0x78
  8009a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009aa:	ff d0                	call   *%eax
  8009ac:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009af:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b2:	83 c0 04             	add    $0x4,%eax
  8009b5:	89 45 14             	mov    %eax,0x14(%ebp)
  8009b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009bb:	83 e8 04             	sub    $0x4,%eax
  8009be:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8009ca:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8009d1:	eb 1f                	jmp    8009f2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8009d3:	83 ec 08             	sub    $0x8,%esp
  8009d6:	ff 75 e8             	pushl  -0x18(%ebp)
  8009d9:	8d 45 14             	lea    0x14(%ebp),%eax
  8009dc:	50                   	push   %eax
  8009dd:	e8 e7 fb ff ff       	call   8005c9 <getuint>
  8009e2:	83 c4 10             	add    $0x10,%esp
  8009e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8009eb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009f2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009f9:	83 ec 04             	sub    $0x4,%esp
  8009fc:	52                   	push   %edx
  8009fd:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a00:	50                   	push   %eax
  800a01:	ff 75 f4             	pushl  -0xc(%ebp)
  800a04:	ff 75 f0             	pushl  -0x10(%ebp)
  800a07:	ff 75 0c             	pushl  0xc(%ebp)
  800a0a:	ff 75 08             	pushl  0x8(%ebp)
  800a0d:	e8 00 fb ff ff       	call   800512 <printnum>
  800a12:	83 c4 20             	add    $0x20,%esp
			break;
  800a15:	eb 34                	jmp    800a4b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a17:	83 ec 08             	sub    $0x8,%esp
  800a1a:	ff 75 0c             	pushl  0xc(%ebp)
  800a1d:	53                   	push   %ebx
  800a1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a21:	ff d0                	call   *%eax
  800a23:	83 c4 10             	add    $0x10,%esp
			break;
  800a26:	eb 23                	jmp    800a4b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a28:	83 ec 08             	sub    $0x8,%esp
  800a2b:	ff 75 0c             	pushl  0xc(%ebp)
  800a2e:	6a 25                	push   $0x25
  800a30:	8b 45 08             	mov    0x8(%ebp),%eax
  800a33:	ff d0                	call   *%eax
  800a35:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a38:	ff 4d 10             	decl   0x10(%ebp)
  800a3b:	eb 03                	jmp    800a40 <vprintfmt+0x3b1>
  800a3d:	ff 4d 10             	decl   0x10(%ebp)
  800a40:	8b 45 10             	mov    0x10(%ebp),%eax
  800a43:	48                   	dec    %eax
  800a44:	8a 00                	mov    (%eax),%al
  800a46:	3c 25                	cmp    $0x25,%al
  800a48:	75 f3                	jne    800a3d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a4a:	90                   	nop
		}
	}
  800a4b:	e9 47 fc ff ff       	jmp    800697 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a50:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a51:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a54:	5b                   	pop    %ebx
  800a55:	5e                   	pop    %esi
  800a56:	5d                   	pop    %ebp
  800a57:	c3                   	ret    

00800a58 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a58:	55                   	push   %ebp
  800a59:	89 e5                	mov    %esp,%ebp
  800a5b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a5e:	8d 45 10             	lea    0x10(%ebp),%eax
  800a61:	83 c0 04             	add    $0x4,%eax
  800a64:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a67:	8b 45 10             	mov    0x10(%ebp),%eax
  800a6a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a6d:	50                   	push   %eax
  800a6e:	ff 75 0c             	pushl  0xc(%ebp)
  800a71:	ff 75 08             	pushl  0x8(%ebp)
  800a74:	e8 16 fc ff ff       	call   80068f <vprintfmt>
  800a79:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a7c:	90                   	nop
  800a7d:	c9                   	leave  
  800a7e:	c3                   	ret    

00800a7f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a7f:	55                   	push   %ebp
  800a80:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a85:	8b 40 08             	mov    0x8(%eax),%eax
  800a88:	8d 50 01             	lea    0x1(%eax),%edx
  800a8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a94:	8b 10                	mov    (%eax),%edx
  800a96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a99:	8b 40 04             	mov    0x4(%eax),%eax
  800a9c:	39 c2                	cmp    %eax,%edx
  800a9e:	73 12                	jae    800ab2 <sprintputch+0x33>
		*b->buf++ = ch;
  800aa0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa3:	8b 00                	mov    (%eax),%eax
  800aa5:	8d 48 01             	lea    0x1(%eax),%ecx
  800aa8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aab:	89 0a                	mov    %ecx,(%edx)
  800aad:	8b 55 08             	mov    0x8(%ebp),%edx
  800ab0:	88 10                	mov    %dl,(%eax)
}
  800ab2:	90                   	nop
  800ab3:	5d                   	pop    %ebp
  800ab4:	c3                   	ret    

00800ab5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ab5:	55                   	push   %ebp
  800ab6:	89 e5                	mov    %esp,%ebp
  800ab8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800abb:	8b 45 08             	mov    0x8(%ebp),%eax
  800abe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ac1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	01 d0                	add    %edx,%eax
  800acc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800acf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ad6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ada:	74 06                	je     800ae2 <vsnprintf+0x2d>
  800adc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ae0:	7f 07                	jg     800ae9 <vsnprintf+0x34>
		return -E_INVAL;
  800ae2:	b8 03 00 00 00       	mov    $0x3,%eax
  800ae7:	eb 20                	jmp    800b09 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ae9:	ff 75 14             	pushl  0x14(%ebp)
  800aec:	ff 75 10             	pushl  0x10(%ebp)
  800aef:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800af2:	50                   	push   %eax
  800af3:	68 7f 0a 80 00       	push   $0x800a7f
  800af8:	e8 92 fb ff ff       	call   80068f <vprintfmt>
  800afd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b00:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b03:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b09:	c9                   	leave  
  800b0a:	c3                   	ret    

00800b0b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b0b:	55                   	push   %ebp
  800b0c:	89 e5                	mov    %esp,%ebp
  800b0e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b11:	8d 45 10             	lea    0x10(%ebp),%eax
  800b14:	83 c0 04             	add    $0x4,%eax
  800b17:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1d:	ff 75 f4             	pushl  -0xc(%ebp)
  800b20:	50                   	push   %eax
  800b21:	ff 75 0c             	pushl  0xc(%ebp)
  800b24:	ff 75 08             	pushl  0x8(%ebp)
  800b27:	e8 89 ff ff ff       	call   800ab5 <vsnprintf>
  800b2c:	83 c4 10             	add    $0x10,%esp
  800b2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b32:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b35:	c9                   	leave  
  800b36:	c3                   	ret    

00800b37 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b37:	55                   	push   %ebp
  800b38:	89 e5                	mov    %esp,%ebp
  800b3a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b3d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b44:	eb 06                	jmp    800b4c <strlen+0x15>
		n++;
  800b46:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b49:	ff 45 08             	incl   0x8(%ebp)
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	8a 00                	mov    (%eax),%al
  800b51:	84 c0                	test   %al,%al
  800b53:	75 f1                	jne    800b46 <strlen+0xf>
		n++;
	return n;
  800b55:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b58:	c9                   	leave  
  800b59:	c3                   	ret    

00800b5a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b5a:	55                   	push   %ebp
  800b5b:	89 e5                	mov    %esp,%ebp
  800b5d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b67:	eb 09                	jmp    800b72 <strnlen+0x18>
		n++;
  800b69:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b6c:	ff 45 08             	incl   0x8(%ebp)
  800b6f:	ff 4d 0c             	decl   0xc(%ebp)
  800b72:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b76:	74 09                	je     800b81 <strnlen+0x27>
  800b78:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7b:	8a 00                	mov    (%eax),%al
  800b7d:	84 c0                	test   %al,%al
  800b7f:	75 e8                	jne    800b69 <strnlen+0xf>
		n++;
	return n;
  800b81:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b84:	c9                   	leave  
  800b85:	c3                   	ret    

00800b86 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b86:	55                   	push   %ebp
  800b87:	89 e5                	mov    %esp,%ebp
  800b89:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b92:	90                   	nop
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	8d 50 01             	lea    0x1(%eax),%edx
  800b99:	89 55 08             	mov    %edx,0x8(%ebp)
  800b9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b9f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ba2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ba5:	8a 12                	mov    (%edx),%dl
  800ba7:	88 10                	mov    %dl,(%eax)
  800ba9:	8a 00                	mov    (%eax),%al
  800bab:	84 c0                	test   %al,%al
  800bad:	75 e4                	jne    800b93 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800baf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bb2:	c9                   	leave  
  800bb3:	c3                   	ret    

00800bb4 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bb4:	55                   	push   %ebp
  800bb5:	89 e5                	mov    %esp,%ebp
  800bb7:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bba:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bc0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bc7:	eb 1f                	jmp    800be8 <strncpy+0x34>
		*dst++ = *src;
  800bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcc:	8d 50 01             	lea    0x1(%eax),%edx
  800bcf:	89 55 08             	mov    %edx,0x8(%ebp)
  800bd2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bd5:	8a 12                	mov    (%edx),%dl
  800bd7:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdc:	8a 00                	mov    (%eax),%al
  800bde:	84 c0                	test   %al,%al
  800be0:	74 03                	je     800be5 <strncpy+0x31>
			src++;
  800be2:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800be5:	ff 45 fc             	incl   -0x4(%ebp)
  800be8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800beb:	3b 45 10             	cmp    0x10(%ebp),%eax
  800bee:	72 d9                	jb     800bc9 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800bf0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800bf3:	c9                   	leave  
  800bf4:	c3                   	ret    

00800bf5 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800bf5:	55                   	push   %ebp
  800bf6:	89 e5                	mov    %esp,%ebp
  800bf8:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c05:	74 30                	je     800c37 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c07:	eb 16                	jmp    800c1f <strlcpy+0x2a>
			*dst++ = *src++;
  800c09:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0c:	8d 50 01             	lea    0x1(%eax),%edx
  800c0f:	89 55 08             	mov    %edx,0x8(%ebp)
  800c12:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c15:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c18:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c1b:	8a 12                	mov    (%edx),%dl
  800c1d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c1f:	ff 4d 10             	decl   0x10(%ebp)
  800c22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c26:	74 09                	je     800c31 <strlcpy+0x3c>
  800c28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2b:	8a 00                	mov    (%eax),%al
  800c2d:	84 c0                	test   %al,%al
  800c2f:	75 d8                	jne    800c09 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c31:	8b 45 08             	mov    0x8(%ebp),%eax
  800c34:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c37:	8b 55 08             	mov    0x8(%ebp),%edx
  800c3a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c3d:	29 c2                	sub    %eax,%edx
  800c3f:	89 d0                	mov    %edx,%eax
}
  800c41:	c9                   	leave  
  800c42:	c3                   	ret    

00800c43 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c43:	55                   	push   %ebp
  800c44:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c46:	eb 06                	jmp    800c4e <strcmp+0xb>
		p++, q++;
  800c48:	ff 45 08             	incl   0x8(%ebp)
  800c4b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c51:	8a 00                	mov    (%eax),%al
  800c53:	84 c0                	test   %al,%al
  800c55:	74 0e                	je     800c65 <strcmp+0x22>
  800c57:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5a:	8a 10                	mov    (%eax),%dl
  800c5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5f:	8a 00                	mov    (%eax),%al
  800c61:	38 c2                	cmp    %al,%dl
  800c63:	74 e3                	je     800c48 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c65:	8b 45 08             	mov    0x8(%ebp),%eax
  800c68:	8a 00                	mov    (%eax),%al
  800c6a:	0f b6 d0             	movzbl %al,%edx
  800c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c70:	8a 00                	mov    (%eax),%al
  800c72:	0f b6 c0             	movzbl %al,%eax
  800c75:	29 c2                	sub    %eax,%edx
  800c77:	89 d0                	mov    %edx,%eax
}
  800c79:	5d                   	pop    %ebp
  800c7a:	c3                   	ret    

00800c7b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c7b:	55                   	push   %ebp
  800c7c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c7e:	eb 09                	jmp    800c89 <strncmp+0xe>
		n--, p++, q++;
  800c80:	ff 4d 10             	decl   0x10(%ebp)
  800c83:	ff 45 08             	incl   0x8(%ebp)
  800c86:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c89:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c8d:	74 17                	je     800ca6 <strncmp+0x2b>
  800c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c92:	8a 00                	mov    (%eax),%al
  800c94:	84 c0                	test   %al,%al
  800c96:	74 0e                	je     800ca6 <strncmp+0x2b>
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9b:	8a 10                	mov    (%eax),%dl
  800c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	38 c2                	cmp    %al,%dl
  800ca4:	74 da                	je     800c80 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ca6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800caa:	75 07                	jne    800cb3 <strncmp+0x38>
		return 0;
  800cac:	b8 00 00 00 00       	mov    $0x0,%eax
  800cb1:	eb 14                	jmp    800cc7 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb6:	8a 00                	mov    (%eax),%al
  800cb8:	0f b6 d0             	movzbl %al,%edx
  800cbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbe:	8a 00                	mov    (%eax),%al
  800cc0:	0f b6 c0             	movzbl %al,%eax
  800cc3:	29 c2                	sub    %eax,%edx
  800cc5:	89 d0                	mov    %edx,%eax
}
  800cc7:	5d                   	pop    %ebp
  800cc8:	c3                   	ret    

00800cc9 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cc9:	55                   	push   %ebp
  800cca:	89 e5                	mov    %esp,%ebp
  800ccc:	83 ec 04             	sub    $0x4,%esp
  800ccf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cd5:	eb 12                	jmp    800ce9 <strchr+0x20>
		if (*s == c)
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	8a 00                	mov    (%eax),%al
  800cdc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cdf:	75 05                	jne    800ce6 <strchr+0x1d>
			return (char *) s;
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	eb 11                	jmp    800cf7 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ce6:	ff 45 08             	incl   0x8(%ebp)
  800ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cec:	8a 00                	mov    (%eax),%al
  800cee:	84 c0                	test   %al,%al
  800cf0:	75 e5                	jne    800cd7 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800cf2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cf7:	c9                   	leave  
  800cf8:	c3                   	ret    

00800cf9 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800cf9:	55                   	push   %ebp
  800cfa:	89 e5                	mov    %esp,%ebp
  800cfc:	83 ec 04             	sub    $0x4,%esp
  800cff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d02:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d05:	eb 0d                	jmp    800d14 <strfind+0x1b>
		if (*s == c)
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d0f:	74 0e                	je     800d1f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d11:	ff 45 08             	incl   0x8(%ebp)
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	8a 00                	mov    (%eax),%al
  800d19:	84 c0                	test   %al,%al
  800d1b:	75 ea                	jne    800d07 <strfind+0xe>
  800d1d:	eb 01                	jmp    800d20 <strfind+0x27>
		if (*s == c)
			break;
  800d1f:	90                   	nop
	return (char *) s;
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d23:	c9                   	leave  
  800d24:	c3                   	ret    

00800d25 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d25:	55                   	push   %ebp
  800d26:	89 e5                	mov    %esp,%ebp
  800d28:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d31:	8b 45 10             	mov    0x10(%ebp),%eax
  800d34:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d37:	eb 0e                	jmp    800d47 <memset+0x22>
		*p++ = c;
  800d39:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d3c:	8d 50 01             	lea    0x1(%eax),%edx
  800d3f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d42:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d45:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d47:	ff 4d f8             	decl   -0x8(%ebp)
  800d4a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d4e:	79 e9                	jns    800d39 <memset+0x14>
		*p++ = c;

	return v;
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d53:	c9                   	leave  
  800d54:	c3                   	ret    

00800d55 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d55:	55                   	push   %ebp
  800d56:	89 e5                	mov    %esp,%ebp
  800d58:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d67:	eb 16                	jmp    800d7f <memcpy+0x2a>
		*d++ = *s++;
  800d69:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d6c:	8d 50 01             	lea    0x1(%eax),%edx
  800d6f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d72:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d75:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d78:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d7b:	8a 12                	mov    (%edx),%dl
  800d7d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d82:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d85:	89 55 10             	mov    %edx,0x10(%ebp)
  800d88:	85 c0                	test   %eax,%eax
  800d8a:	75 dd                	jne    800d69 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d8f:	c9                   	leave  
  800d90:	c3                   	ret    

00800d91 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d91:	55                   	push   %ebp
  800d92:	89 e5                	mov    %esp,%ebp
  800d94:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800da0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800da3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800da6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800da9:	73 50                	jae    800dfb <memmove+0x6a>
  800dab:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dae:	8b 45 10             	mov    0x10(%ebp),%eax
  800db1:	01 d0                	add    %edx,%eax
  800db3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800db6:	76 43                	jbe    800dfb <memmove+0x6a>
		s += n;
  800db8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbb:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc1:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dc4:	eb 10                	jmp    800dd6 <memmove+0x45>
			*--d = *--s;
  800dc6:	ff 4d f8             	decl   -0x8(%ebp)
  800dc9:	ff 4d fc             	decl   -0x4(%ebp)
  800dcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dcf:	8a 10                	mov    (%eax),%dl
  800dd1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dd6:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ddc:	89 55 10             	mov    %edx,0x10(%ebp)
  800ddf:	85 c0                	test   %eax,%eax
  800de1:	75 e3                	jne    800dc6 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800de3:	eb 23                	jmp    800e08 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800de5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de8:	8d 50 01             	lea    0x1(%eax),%edx
  800deb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800df7:	8a 12                	mov    (%edx),%dl
  800df9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800dfb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfe:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e01:	89 55 10             	mov    %edx,0x10(%ebp)
  800e04:	85 c0                	test   %eax,%eax
  800e06:	75 dd                	jne    800de5 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e0b:	c9                   	leave  
  800e0c:	c3                   	ret    

00800e0d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e0d:	55                   	push   %ebp
  800e0e:	89 e5                	mov    %esp,%ebp
  800e10:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e1f:	eb 2a                	jmp    800e4b <memcmp+0x3e>
		if (*s1 != *s2)
  800e21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e24:	8a 10                	mov    (%eax),%dl
  800e26:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e29:	8a 00                	mov    (%eax),%al
  800e2b:	38 c2                	cmp    %al,%dl
  800e2d:	74 16                	je     800e45 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e32:	8a 00                	mov    (%eax),%al
  800e34:	0f b6 d0             	movzbl %al,%edx
  800e37:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3a:	8a 00                	mov    (%eax),%al
  800e3c:	0f b6 c0             	movzbl %al,%eax
  800e3f:	29 c2                	sub    %eax,%edx
  800e41:	89 d0                	mov    %edx,%eax
  800e43:	eb 18                	jmp    800e5d <memcmp+0x50>
		s1++, s2++;
  800e45:	ff 45 fc             	incl   -0x4(%ebp)
  800e48:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e51:	89 55 10             	mov    %edx,0x10(%ebp)
  800e54:	85 c0                	test   %eax,%eax
  800e56:	75 c9                	jne    800e21 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e58:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e5d:	c9                   	leave  
  800e5e:	c3                   	ret    

00800e5f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e5f:	55                   	push   %ebp
  800e60:	89 e5                	mov    %esp,%ebp
  800e62:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e65:	8b 55 08             	mov    0x8(%ebp),%edx
  800e68:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6b:	01 d0                	add    %edx,%eax
  800e6d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e70:	eb 15                	jmp    800e87 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	8a 00                	mov    (%eax),%al
  800e77:	0f b6 d0             	movzbl %al,%edx
  800e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7d:	0f b6 c0             	movzbl %al,%eax
  800e80:	39 c2                	cmp    %eax,%edx
  800e82:	74 0d                	je     800e91 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e84:	ff 45 08             	incl   0x8(%ebp)
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e8d:	72 e3                	jb     800e72 <memfind+0x13>
  800e8f:	eb 01                	jmp    800e92 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e91:	90                   	nop
	return (void *) s;
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e95:	c9                   	leave  
  800e96:	c3                   	ret    

00800e97 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e97:	55                   	push   %ebp
  800e98:	89 e5                	mov    %esp,%ebp
  800e9a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e9d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ea4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eab:	eb 03                	jmp    800eb0 <strtol+0x19>
		s++;
  800ead:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb3:	8a 00                	mov    (%eax),%al
  800eb5:	3c 20                	cmp    $0x20,%al
  800eb7:	74 f4                	je     800ead <strtol+0x16>
  800eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebc:	8a 00                	mov    (%eax),%al
  800ebe:	3c 09                	cmp    $0x9,%al
  800ec0:	74 eb                	je     800ead <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	8a 00                	mov    (%eax),%al
  800ec7:	3c 2b                	cmp    $0x2b,%al
  800ec9:	75 05                	jne    800ed0 <strtol+0x39>
		s++;
  800ecb:	ff 45 08             	incl   0x8(%ebp)
  800ece:	eb 13                	jmp    800ee3 <strtol+0x4c>
	else if (*s == '-')
  800ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed3:	8a 00                	mov    (%eax),%al
  800ed5:	3c 2d                	cmp    $0x2d,%al
  800ed7:	75 0a                	jne    800ee3 <strtol+0x4c>
		s++, neg = 1;
  800ed9:	ff 45 08             	incl   0x8(%ebp)
  800edc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ee3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee7:	74 06                	je     800eef <strtol+0x58>
  800ee9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800eed:	75 20                	jne    800f0f <strtol+0x78>
  800eef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef2:	8a 00                	mov    (%eax),%al
  800ef4:	3c 30                	cmp    $0x30,%al
  800ef6:	75 17                	jne    800f0f <strtol+0x78>
  800ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  800efb:	40                   	inc    %eax
  800efc:	8a 00                	mov    (%eax),%al
  800efe:	3c 78                	cmp    $0x78,%al
  800f00:	75 0d                	jne    800f0f <strtol+0x78>
		s += 2, base = 16;
  800f02:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f06:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f0d:	eb 28                	jmp    800f37 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f0f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f13:	75 15                	jne    800f2a <strtol+0x93>
  800f15:	8b 45 08             	mov    0x8(%ebp),%eax
  800f18:	8a 00                	mov    (%eax),%al
  800f1a:	3c 30                	cmp    $0x30,%al
  800f1c:	75 0c                	jne    800f2a <strtol+0x93>
		s++, base = 8;
  800f1e:	ff 45 08             	incl   0x8(%ebp)
  800f21:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f28:	eb 0d                	jmp    800f37 <strtol+0xa0>
	else if (base == 0)
  800f2a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2e:	75 07                	jne    800f37 <strtol+0xa0>
		base = 10;
  800f30:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	8a 00                	mov    (%eax),%al
  800f3c:	3c 2f                	cmp    $0x2f,%al
  800f3e:	7e 19                	jle    800f59 <strtol+0xc2>
  800f40:	8b 45 08             	mov    0x8(%ebp),%eax
  800f43:	8a 00                	mov    (%eax),%al
  800f45:	3c 39                	cmp    $0x39,%al
  800f47:	7f 10                	jg     800f59 <strtol+0xc2>
			dig = *s - '0';
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4c:	8a 00                	mov    (%eax),%al
  800f4e:	0f be c0             	movsbl %al,%eax
  800f51:	83 e8 30             	sub    $0x30,%eax
  800f54:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f57:	eb 42                	jmp    800f9b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	8a 00                	mov    (%eax),%al
  800f5e:	3c 60                	cmp    $0x60,%al
  800f60:	7e 19                	jle    800f7b <strtol+0xe4>
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	3c 7a                	cmp    $0x7a,%al
  800f69:	7f 10                	jg     800f7b <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	8a 00                	mov    (%eax),%al
  800f70:	0f be c0             	movsbl %al,%eax
  800f73:	83 e8 57             	sub    $0x57,%eax
  800f76:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f79:	eb 20                	jmp    800f9b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7e:	8a 00                	mov    (%eax),%al
  800f80:	3c 40                	cmp    $0x40,%al
  800f82:	7e 39                	jle    800fbd <strtol+0x126>
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	3c 5a                	cmp    $0x5a,%al
  800f8b:	7f 30                	jg     800fbd <strtol+0x126>
			dig = *s - 'A' + 10;
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	0f be c0             	movsbl %al,%eax
  800f95:	83 e8 37             	sub    $0x37,%eax
  800f98:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f9e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fa1:	7d 19                	jge    800fbc <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fa3:	ff 45 08             	incl   0x8(%ebp)
  800fa6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa9:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fad:	89 c2                	mov    %eax,%edx
  800faf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fb2:	01 d0                	add    %edx,%eax
  800fb4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fb7:	e9 7b ff ff ff       	jmp    800f37 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fbc:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fbd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fc1:	74 08                	je     800fcb <strtol+0x134>
		*endptr = (char *) s;
  800fc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc6:	8b 55 08             	mov    0x8(%ebp),%edx
  800fc9:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fcb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fcf:	74 07                	je     800fd8 <strtol+0x141>
  800fd1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd4:	f7 d8                	neg    %eax
  800fd6:	eb 03                	jmp    800fdb <strtol+0x144>
  800fd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fdb:	c9                   	leave  
  800fdc:	c3                   	ret    

00800fdd <ltostr>:

void
ltostr(long value, char *str)
{
  800fdd:	55                   	push   %ebp
  800fde:	89 e5                	mov    %esp,%ebp
  800fe0:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fe3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fea:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800ff1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ff5:	79 13                	jns    80100a <ltostr+0x2d>
	{
		neg = 1;
  800ff7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ffe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801001:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801004:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801007:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80100a:	8b 45 08             	mov    0x8(%ebp),%eax
  80100d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801012:	99                   	cltd   
  801013:	f7 f9                	idiv   %ecx
  801015:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801018:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101b:	8d 50 01             	lea    0x1(%eax),%edx
  80101e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801021:	89 c2                	mov    %eax,%edx
  801023:	8b 45 0c             	mov    0xc(%ebp),%eax
  801026:	01 d0                	add    %edx,%eax
  801028:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80102b:	83 c2 30             	add    $0x30,%edx
  80102e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801030:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801033:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801038:	f7 e9                	imul   %ecx
  80103a:	c1 fa 02             	sar    $0x2,%edx
  80103d:	89 c8                	mov    %ecx,%eax
  80103f:	c1 f8 1f             	sar    $0x1f,%eax
  801042:	29 c2                	sub    %eax,%edx
  801044:	89 d0                	mov    %edx,%eax
  801046:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801049:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80104c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801051:	f7 e9                	imul   %ecx
  801053:	c1 fa 02             	sar    $0x2,%edx
  801056:	89 c8                	mov    %ecx,%eax
  801058:	c1 f8 1f             	sar    $0x1f,%eax
  80105b:	29 c2                	sub    %eax,%edx
  80105d:	89 d0                	mov    %edx,%eax
  80105f:	c1 e0 02             	shl    $0x2,%eax
  801062:	01 d0                	add    %edx,%eax
  801064:	01 c0                	add    %eax,%eax
  801066:	29 c1                	sub    %eax,%ecx
  801068:	89 ca                	mov    %ecx,%edx
  80106a:	85 d2                	test   %edx,%edx
  80106c:	75 9c                	jne    80100a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80106e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801075:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801078:	48                   	dec    %eax
  801079:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80107c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801080:	74 3d                	je     8010bf <ltostr+0xe2>
		start = 1 ;
  801082:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801089:	eb 34                	jmp    8010bf <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80108b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80108e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801091:	01 d0                	add    %edx,%eax
  801093:	8a 00                	mov    (%eax),%al
  801095:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801098:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80109b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109e:	01 c2                	add    %eax,%edx
  8010a0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a6:	01 c8                	add    %ecx,%eax
  8010a8:	8a 00                	mov    (%eax),%al
  8010aa:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010ac:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b2:	01 c2                	add    %eax,%edx
  8010b4:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010b7:	88 02                	mov    %al,(%edx)
		start++ ;
  8010b9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010bc:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010c5:	7c c4                	jl     80108b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010c7:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cd:	01 d0                	add    %edx,%eax
  8010cf:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010d2:	90                   	nop
  8010d3:	c9                   	leave  
  8010d4:	c3                   	ret    

008010d5 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010d5:	55                   	push   %ebp
  8010d6:	89 e5                	mov    %esp,%ebp
  8010d8:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010db:	ff 75 08             	pushl  0x8(%ebp)
  8010de:	e8 54 fa ff ff       	call   800b37 <strlen>
  8010e3:	83 c4 04             	add    $0x4,%esp
  8010e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010e9:	ff 75 0c             	pushl  0xc(%ebp)
  8010ec:	e8 46 fa ff ff       	call   800b37 <strlen>
  8010f1:	83 c4 04             	add    $0x4,%esp
  8010f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801105:	eb 17                	jmp    80111e <strcconcat+0x49>
		final[s] = str1[s] ;
  801107:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80110a:	8b 45 10             	mov    0x10(%ebp),%eax
  80110d:	01 c2                	add    %eax,%edx
  80110f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801112:	8b 45 08             	mov    0x8(%ebp),%eax
  801115:	01 c8                	add    %ecx,%eax
  801117:	8a 00                	mov    (%eax),%al
  801119:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80111b:	ff 45 fc             	incl   -0x4(%ebp)
  80111e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801121:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801124:	7c e1                	jl     801107 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801126:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80112d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801134:	eb 1f                	jmp    801155 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801136:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801139:	8d 50 01             	lea    0x1(%eax),%edx
  80113c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80113f:	89 c2                	mov    %eax,%edx
  801141:	8b 45 10             	mov    0x10(%ebp),%eax
  801144:	01 c2                	add    %eax,%edx
  801146:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801149:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114c:	01 c8                	add    %ecx,%eax
  80114e:	8a 00                	mov    (%eax),%al
  801150:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801152:	ff 45 f8             	incl   -0x8(%ebp)
  801155:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801158:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80115b:	7c d9                	jl     801136 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80115d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801160:	8b 45 10             	mov    0x10(%ebp),%eax
  801163:	01 d0                	add    %edx,%eax
  801165:	c6 00 00             	movb   $0x0,(%eax)
}
  801168:	90                   	nop
  801169:	c9                   	leave  
  80116a:	c3                   	ret    

0080116b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80116b:	55                   	push   %ebp
  80116c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80116e:	8b 45 14             	mov    0x14(%ebp),%eax
  801171:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801177:	8b 45 14             	mov    0x14(%ebp),%eax
  80117a:	8b 00                	mov    (%eax),%eax
  80117c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801183:	8b 45 10             	mov    0x10(%ebp),%eax
  801186:	01 d0                	add    %edx,%eax
  801188:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80118e:	eb 0c                	jmp    80119c <strsplit+0x31>
			*string++ = 0;
  801190:	8b 45 08             	mov    0x8(%ebp),%eax
  801193:	8d 50 01             	lea    0x1(%eax),%edx
  801196:	89 55 08             	mov    %edx,0x8(%ebp)
  801199:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80119c:	8b 45 08             	mov    0x8(%ebp),%eax
  80119f:	8a 00                	mov    (%eax),%al
  8011a1:	84 c0                	test   %al,%al
  8011a3:	74 18                	je     8011bd <strsplit+0x52>
  8011a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	0f be c0             	movsbl %al,%eax
  8011ad:	50                   	push   %eax
  8011ae:	ff 75 0c             	pushl  0xc(%ebp)
  8011b1:	e8 13 fb ff ff       	call   800cc9 <strchr>
  8011b6:	83 c4 08             	add    $0x8,%esp
  8011b9:	85 c0                	test   %eax,%eax
  8011bb:	75 d3                	jne    801190 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	8a 00                	mov    (%eax),%al
  8011c2:	84 c0                	test   %al,%al
  8011c4:	74 5a                	je     801220 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c9:	8b 00                	mov    (%eax),%eax
  8011cb:	83 f8 0f             	cmp    $0xf,%eax
  8011ce:	75 07                	jne    8011d7 <strsplit+0x6c>
		{
			return 0;
  8011d0:	b8 00 00 00 00       	mov    $0x0,%eax
  8011d5:	eb 66                	jmp    80123d <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8011da:	8b 00                	mov    (%eax),%eax
  8011dc:	8d 48 01             	lea    0x1(%eax),%ecx
  8011df:	8b 55 14             	mov    0x14(%ebp),%edx
  8011e2:	89 0a                	mov    %ecx,(%edx)
  8011e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ee:	01 c2                	add    %eax,%edx
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f3:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011f5:	eb 03                	jmp    8011fa <strsplit+0x8f>
			string++;
  8011f7:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	8a 00                	mov    (%eax),%al
  8011ff:	84 c0                	test   %al,%al
  801201:	74 8b                	je     80118e <strsplit+0x23>
  801203:	8b 45 08             	mov    0x8(%ebp),%eax
  801206:	8a 00                	mov    (%eax),%al
  801208:	0f be c0             	movsbl %al,%eax
  80120b:	50                   	push   %eax
  80120c:	ff 75 0c             	pushl  0xc(%ebp)
  80120f:	e8 b5 fa ff ff       	call   800cc9 <strchr>
  801214:	83 c4 08             	add    $0x8,%esp
  801217:	85 c0                	test   %eax,%eax
  801219:	74 dc                	je     8011f7 <strsplit+0x8c>
			string++;
	}
  80121b:	e9 6e ff ff ff       	jmp    80118e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801220:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801221:	8b 45 14             	mov    0x14(%ebp),%eax
  801224:	8b 00                	mov    (%eax),%eax
  801226:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80122d:	8b 45 10             	mov    0x10(%ebp),%eax
  801230:	01 d0                	add    %edx,%eax
  801232:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801238:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80123d:	c9                   	leave  
  80123e:	c3                   	ret    

0080123f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80123f:	55                   	push   %ebp
  801240:	89 e5                	mov    %esp,%ebp
  801242:	57                   	push   %edi
  801243:	56                   	push   %esi
  801244:	53                   	push   %ebx
  801245:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801248:	8b 45 08             	mov    0x8(%ebp),%eax
  80124b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80124e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801251:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801254:	8b 7d 18             	mov    0x18(%ebp),%edi
  801257:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80125a:	cd 30                	int    $0x30
  80125c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80125f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801262:	83 c4 10             	add    $0x10,%esp
  801265:	5b                   	pop    %ebx
  801266:	5e                   	pop    %esi
  801267:	5f                   	pop    %edi
  801268:	5d                   	pop    %ebp
  801269:	c3                   	ret    

0080126a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80126a:	55                   	push   %ebp
  80126b:	89 e5                	mov    %esp,%ebp
  80126d:	83 ec 04             	sub    $0x4,%esp
  801270:	8b 45 10             	mov    0x10(%ebp),%eax
  801273:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801276:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80127a:	8b 45 08             	mov    0x8(%ebp),%eax
  80127d:	6a 00                	push   $0x0
  80127f:	6a 00                	push   $0x0
  801281:	52                   	push   %edx
  801282:	ff 75 0c             	pushl  0xc(%ebp)
  801285:	50                   	push   %eax
  801286:	6a 00                	push   $0x0
  801288:	e8 b2 ff ff ff       	call   80123f <syscall>
  80128d:	83 c4 18             	add    $0x18,%esp
}
  801290:	90                   	nop
  801291:	c9                   	leave  
  801292:	c3                   	ret    

00801293 <sys_cgetc>:

int
sys_cgetc(void)
{
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801296:	6a 00                	push   $0x0
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 01                	push   $0x1
  8012a2:	e8 98 ff ff ff       	call   80123f <syscall>
  8012a7:	83 c4 18             	add    $0x18,%esp
}
  8012aa:	c9                   	leave  
  8012ab:	c3                   	ret    

008012ac <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012ac:	55                   	push   %ebp
  8012ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012af:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	50                   	push   %eax
  8012bb:	6a 05                	push   $0x5
  8012bd:	e8 7d ff ff ff       	call   80123f <syscall>
  8012c2:	83 c4 18             	add    $0x18,%esp
}
  8012c5:	c9                   	leave  
  8012c6:	c3                   	ret    

008012c7 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012c7:	55                   	push   %ebp
  8012c8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012ca:	6a 00                	push   $0x0
  8012cc:	6a 00                	push   $0x0
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 02                	push   $0x2
  8012d6:	e8 64 ff ff ff       	call   80123f <syscall>
  8012db:	83 c4 18             	add    $0x18,%esp
}
  8012de:	c9                   	leave  
  8012df:	c3                   	ret    

008012e0 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 03                	push   $0x3
  8012ef:	e8 4b ff ff ff       	call   80123f <syscall>
  8012f4:	83 c4 18             	add    $0x18,%esp
}
  8012f7:	c9                   	leave  
  8012f8:	c3                   	ret    

008012f9 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012f9:	55                   	push   %ebp
  8012fa:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	6a 00                	push   $0x0
  801306:	6a 04                	push   $0x4
  801308:	e8 32 ff ff ff       	call   80123f <syscall>
  80130d:	83 c4 18             	add    $0x18,%esp
}
  801310:	c9                   	leave  
  801311:	c3                   	ret    

00801312 <sys_env_exit>:


void sys_env_exit(void)
{
  801312:	55                   	push   %ebp
  801313:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	6a 06                	push   $0x6
  801321:	e8 19 ff ff ff       	call   80123f <syscall>
  801326:	83 c4 18             	add    $0x18,%esp
}
  801329:	90                   	nop
  80132a:	c9                   	leave  
  80132b:	c3                   	ret    

0080132c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80132f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801332:	8b 45 08             	mov    0x8(%ebp),%eax
  801335:	6a 00                	push   $0x0
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	52                   	push   %edx
  80133c:	50                   	push   %eax
  80133d:	6a 07                	push   $0x7
  80133f:	e8 fb fe ff ff       	call   80123f <syscall>
  801344:	83 c4 18             	add    $0x18,%esp
}
  801347:	c9                   	leave  
  801348:	c3                   	ret    

00801349 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801349:	55                   	push   %ebp
  80134a:	89 e5                	mov    %esp,%ebp
  80134c:	56                   	push   %esi
  80134d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80134e:	8b 75 18             	mov    0x18(%ebp),%esi
  801351:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801354:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801357:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135a:	8b 45 08             	mov    0x8(%ebp),%eax
  80135d:	56                   	push   %esi
  80135e:	53                   	push   %ebx
  80135f:	51                   	push   %ecx
  801360:	52                   	push   %edx
  801361:	50                   	push   %eax
  801362:	6a 08                	push   $0x8
  801364:	e8 d6 fe ff ff       	call   80123f <syscall>
  801369:	83 c4 18             	add    $0x18,%esp
}
  80136c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80136f:	5b                   	pop    %ebx
  801370:	5e                   	pop    %esi
  801371:	5d                   	pop    %ebp
  801372:	c3                   	ret    

00801373 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801373:	55                   	push   %ebp
  801374:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801376:	8b 55 0c             	mov    0xc(%ebp),%edx
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	52                   	push   %edx
  801383:	50                   	push   %eax
  801384:	6a 09                	push   $0x9
  801386:	e8 b4 fe ff ff       	call   80123f <syscall>
  80138b:	83 c4 18             	add    $0x18,%esp
}
  80138e:	c9                   	leave  
  80138f:	c3                   	ret    

00801390 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801390:	55                   	push   %ebp
  801391:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801393:	6a 00                	push   $0x0
  801395:	6a 00                	push   $0x0
  801397:	6a 00                	push   $0x0
  801399:	ff 75 0c             	pushl  0xc(%ebp)
  80139c:	ff 75 08             	pushl  0x8(%ebp)
  80139f:	6a 0a                	push   $0xa
  8013a1:	e8 99 fe ff ff       	call   80123f <syscall>
  8013a6:	83 c4 18             	add    $0x18,%esp
}
  8013a9:	c9                   	leave  
  8013aa:	c3                   	ret    

008013ab <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013ae:	6a 00                	push   $0x0
  8013b0:	6a 00                	push   $0x0
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 0b                	push   $0xb
  8013ba:	e8 80 fe ff ff       	call   80123f <syscall>
  8013bf:	83 c4 18             	add    $0x18,%esp
}
  8013c2:	c9                   	leave  
  8013c3:	c3                   	ret    

008013c4 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013c4:	55                   	push   %ebp
  8013c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 0c                	push   $0xc
  8013d3:	e8 67 fe ff ff       	call   80123f <syscall>
  8013d8:	83 c4 18             	add    $0x18,%esp
}
  8013db:	c9                   	leave  
  8013dc:	c3                   	ret    

008013dd <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013dd:	55                   	push   %ebp
  8013de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 0d                	push   $0xd
  8013ec:	e8 4e fe ff ff       	call   80123f <syscall>
  8013f1:	83 c4 18             	add    $0x18,%esp
}
  8013f4:	c9                   	leave  
  8013f5:	c3                   	ret    

008013f6 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013f6:	55                   	push   %ebp
  8013f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	ff 75 0c             	pushl  0xc(%ebp)
  801402:	ff 75 08             	pushl  0x8(%ebp)
  801405:	6a 11                	push   $0x11
  801407:	e8 33 fe ff ff       	call   80123f <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
	return;
  80140f:	90                   	nop
}
  801410:	c9                   	leave  
  801411:	c3                   	ret    

00801412 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801412:	55                   	push   %ebp
  801413:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	ff 75 0c             	pushl  0xc(%ebp)
  80141e:	ff 75 08             	pushl  0x8(%ebp)
  801421:	6a 12                	push   $0x12
  801423:	e8 17 fe ff ff       	call   80123f <syscall>
  801428:	83 c4 18             	add    $0x18,%esp
	return ;
  80142b:	90                   	nop
}
  80142c:	c9                   	leave  
  80142d:	c3                   	ret    

0080142e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80142e:	55                   	push   %ebp
  80142f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 0e                	push   $0xe
  80143d:	e8 fd fd ff ff       	call   80123f <syscall>
  801442:	83 c4 18             	add    $0x18,%esp
}
  801445:	c9                   	leave  
  801446:	c3                   	ret    

00801447 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801447:	55                   	push   %ebp
  801448:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	6a 00                	push   $0x0
  801452:	ff 75 08             	pushl  0x8(%ebp)
  801455:	6a 0f                	push   $0xf
  801457:	e8 e3 fd ff ff       	call   80123f <syscall>
  80145c:	83 c4 18             	add    $0x18,%esp
}
  80145f:	c9                   	leave  
  801460:	c3                   	ret    

00801461 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801461:	55                   	push   %ebp
  801462:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	6a 10                	push   $0x10
  801470:	e8 ca fd ff ff       	call   80123f <syscall>
  801475:	83 c4 18             	add    $0x18,%esp
}
  801478:	90                   	nop
  801479:	c9                   	leave  
  80147a:	c3                   	ret    

0080147b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80147b:	55                   	push   %ebp
  80147c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 14                	push   $0x14
  80148a:	e8 b0 fd ff ff       	call   80123f <syscall>
  80148f:	83 c4 18             	add    $0x18,%esp
}
  801492:	90                   	nop
  801493:	c9                   	leave  
  801494:	c3                   	ret    

00801495 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801495:	55                   	push   %ebp
  801496:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 15                	push   $0x15
  8014a4:	e8 96 fd ff ff       	call   80123f <syscall>
  8014a9:	83 c4 18             	add    $0x18,%esp
}
  8014ac:	90                   	nop
  8014ad:	c9                   	leave  
  8014ae:	c3                   	ret    

008014af <sys_cputc>:


void
sys_cputc(const char c)
{
  8014af:	55                   	push   %ebp
  8014b0:	89 e5                	mov    %esp,%ebp
  8014b2:	83 ec 04             	sub    $0x4,%esp
  8014b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014bb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	50                   	push   %eax
  8014c8:	6a 16                	push   $0x16
  8014ca:	e8 70 fd ff ff       	call   80123f <syscall>
  8014cf:	83 c4 18             	add    $0x18,%esp
}
  8014d2:	90                   	nop
  8014d3:	c9                   	leave  
  8014d4:	c3                   	ret    

008014d5 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014d5:	55                   	push   %ebp
  8014d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 17                	push   $0x17
  8014e4:	e8 56 fd ff ff       	call   80123f <syscall>
  8014e9:	83 c4 18             	add    $0x18,%esp
}
  8014ec:	90                   	nop
  8014ed:	c9                   	leave  
  8014ee:	c3                   	ret    

008014ef <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014ef:	55                   	push   %ebp
  8014f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	ff 75 0c             	pushl  0xc(%ebp)
  8014fe:	50                   	push   %eax
  8014ff:	6a 18                	push   $0x18
  801501:	e8 39 fd ff ff       	call   80123f <syscall>
  801506:	83 c4 18             	add    $0x18,%esp
}
  801509:	c9                   	leave  
  80150a:	c3                   	ret    

0080150b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80150b:	55                   	push   %ebp
  80150c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80150e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801511:	8b 45 08             	mov    0x8(%ebp),%eax
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	52                   	push   %edx
  80151b:	50                   	push   %eax
  80151c:	6a 1b                	push   $0x1b
  80151e:	e8 1c fd ff ff       	call   80123f <syscall>
  801523:	83 c4 18             	add    $0x18,%esp
}
  801526:	c9                   	leave  
  801527:	c3                   	ret    

00801528 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801528:	55                   	push   %ebp
  801529:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80152b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80152e:	8b 45 08             	mov    0x8(%ebp),%eax
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	52                   	push   %edx
  801538:	50                   	push   %eax
  801539:	6a 19                	push   $0x19
  80153b:	e8 ff fc ff ff       	call   80123f <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
}
  801543:	90                   	nop
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801549:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	52                   	push   %edx
  801556:	50                   	push   %eax
  801557:	6a 1a                	push   $0x1a
  801559:	e8 e1 fc ff ff       	call   80123f <syscall>
  80155e:	83 c4 18             	add    $0x18,%esp
}
  801561:	90                   	nop
  801562:	c9                   	leave  
  801563:	c3                   	ret    

00801564 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
  801567:	83 ec 04             	sub    $0x4,%esp
  80156a:	8b 45 10             	mov    0x10(%ebp),%eax
  80156d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801570:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801573:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801577:	8b 45 08             	mov    0x8(%ebp),%eax
  80157a:	6a 00                	push   $0x0
  80157c:	51                   	push   %ecx
  80157d:	52                   	push   %edx
  80157e:	ff 75 0c             	pushl  0xc(%ebp)
  801581:	50                   	push   %eax
  801582:	6a 1c                	push   $0x1c
  801584:	e8 b6 fc ff ff       	call   80123f <syscall>
  801589:	83 c4 18             	add    $0x18,%esp
}
  80158c:	c9                   	leave  
  80158d:	c3                   	ret    

0080158e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80158e:	55                   	push   %ebp
  80158f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801591:	8b 55 0c             	mov    0xc(%ebp),%edx
  801594:	8b 45 08             	mov    0x8(%ebp),%eax
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	52                   	push   %edx
  80159e:	50                   	push   %eax
  80159f:	6a 1d                	push   $0x1d
  8015a1:	e8 99 fc ff ff       	call   80123f <syscall>
  8015a6:	83 c4 18             	add    $0x18,%esp
}
  8015a9:	c9                   	leave  
  8015aa:	c3                   	ret    

008015ab <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015ab:	55                   	push   %ebp
  8015ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015ae:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	51                   	push   %ecx
  8015bc:	52                   	push   %edx
  8015bd:	50                   	push   %eax
  8015be:	6a 1e                	push   $0x1e
  8015c0:	e8 7a fc ff ff       	call   80123f <syscall>
  8015c5:	83 c4 18             	add    $0x18,%esp
}
  8015c8:	c9                   	leave  
  8015c9:	c3                   	ret    

008015ca <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015ca:	55                   	push   %ebp
  8015cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	52                   	push   %edx
  8015da:	50                   	push   %eax
  8015db:	6a 1f                	push   $0x1f
  8015dd:	e8 5d fc ff ff       	call   80123f <syscall>
  8015e2:	83 c4 18             	add    $0x18,%esp
}
  8015e5:	c9                   	leave  
  8015e6:	c3                   	ret    

008015e7 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015e7:	55                   	push   %ebp
  8015e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 20                	push   $0x20
  8015f6:	e8 44 fc ff ff       	call   80123f <syscall>
  8015fb:	83 c4 18             	add    $0x18,%esp
}
  8015fe:	c9                   	leave  
  8015ff:	c3                   	ret    

00801600 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801600:	55                   	push   %ebp
  801601:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801603:	8b 45 08             	mov    0x8(%ebp),%eax
  801606:	6a 00                	push   $0x0
  801608:	ff 75 14             	pushl  0x14(%ebp)
  80160b:	ff 75 10             	pushl  0x10(%ebp)
  80160e:	ff 75 0c             	pushl  0xc(%ebp)
  801611:	50                   	push   %eax
  801612:	6a 21                	push   $0x21
  801614:	e8 26 fc ff ff       	call   80123f <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
}
  80161c:	c9                   	leave  
  80161d:	c3                   	ret    

0080161e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80161e:	55                   	push   %ebp
  80161f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801621:	8b 45 08             	mov    0x8(%ebp),%eax
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	50                   	push   %eax
  80162d:	6a 22                	push   $0x22
  80162f:	e8 0b fc ff ff       	call   80123f <syscall>
  801634:	83 c4 18             	add    $0x18,%esp
}
  801637:	90                   	nop
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80163d:	8b 45 08             	mov    0x8(%ebp),%eax
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	50                   	push   %eax
  801649:	6a 23                	push   $0x23
  80164b:	e8 ef fb ff ff       	call   80123f <syscall>
  801650:	83 c4 18             	add    $0x18,%esp
}
  801653:	90                   	nop
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
  801659:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80165c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80165f:	8d 50 04             	lea    0x4(%eax),%edx
  801662:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	52                   	push   %edx
  80166c:	50                   	push   %eax
  80166d:	6a 24                	push   $0x24
  80166f:	e8 cb fb ff ff       	call   80123f <syscall>
  801674:	83 c4 18             	add    $0x18,%esp
	return result;
  801677:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80167a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80167d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801680:	89 01                	mov    %eax,(%ecx)
  801682:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801685:	8b 45 08             	mov    0x8(%ebp),%eax
  801688:	c9                   	leave  
  801689:	c2 04 00             	ret    $0x4

0080168c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80168c:	55                   	push   %ebp
  80168d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	ff 75 10             	pushl  0x10(%ebp)
  801696:	ff 75 0c             	pushl  0xc(%ebp)
  801699:	ff 75 08             	pushl  0x8(%ebp)
  80169c:	6a 13                	push   $0x13
  80169e:	e8 9c fb ff ff       	call   80123f <syscall>
  8016a3:	83 c4 18             	add    $0x18,%esp
	return ;
  8016a6:	90                   	nop
}
  8016a7:	c9                   	leave  
  8016a8:	c3                   	ret    

008016a9 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016a9:	55                   	push   %ebp
  8016aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 25                	push   $0x25
  8016b8:	e8 82 fb ff ff       	call   80123f <syscall>
  8016bd:	83 c4 18             	add    $0x18,%esp
}
  8016c0:	c9                   	leave  
  8016c1:	c3                   	ret    

008016c2 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016c2:	55                   	push   %ebp
  8016c3:	89 e5                	mov    %esp,%ebp
  8016c5:	83 ec 04             	sub    $0x4,%esp
  8016c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016ce:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	50                   	push   %eax
  8016db:	6a 26                	push   $0x26
  8016dd:	e8 5d fb ff ff       	call   80123f <syscall>
  8016e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8016e5:	90                   	nop
}
  8016e6:	c9                   	leave  
  8016e7:	c3                   	ret    

008016e8 <rsttst>:
void rsttst()
{
  8016e8:	55                   	push   %ebp
  8016e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 28                	push   $0x28
  8016f7:	e8 43 fb ff ff       	call   80123f <syscall>
  8016fc:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ff:	90                   	nop
}
  801700:	c9                   	leave  
  801701:	c3                   	ret    

00801702 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801702:	55                   	push   %ebp
  801703:	89 e5                	mov    %esp,%ebp
  801705:	83 ec 04             	sub    $0x4,%esp
  801708:	8b 45 14             	mov    0x14(%ebp),%eax
  80170b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80170e:	8b 55 18             	mov    0x18(%ebp),%edx
  801711:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801715:	52                   	push   %edx
  801716:	50                   	push   %eax
  801717:	ff 75 10             	pushl  0x10(%ebp)
  80171a:	ff 75 0c             	pushl  0xc(%ebp)
  80171d:	ff 75 08             	pushl  0x8(%ebp)
  801720:	6a 27                	push   $0x27
  801722:	e8 18 fb ff ff       	call   80123f <syscall>
  801727:	83 c4 18             	add    $0x18,%esp
	return ;
  80172a:	90                   	nop
}
  80172b:	c9                   	leave  
  80172c:	c3                   	ret    

0080172d <chktst>:
void chktst(uint32 n)
{
  80172d:	55                   	push   %ebp
  80172e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	ff 75 08             	pushl  0x8(%ebp)
  80173b:	6a 29                	push   $0x29
  80173d:	e8 fd fa ff ff       	call   80123f <syscall>
  801742:	83 c4 18             	add    $0x18,%esp
	return ;
  801745:	90                   	nop
}
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <inctst>:

void inctst()
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 2a                	push   $0x2a
  801757:	e8 e3 fa ff ff       	call   80123f <syscall>
  80175c:	83 c4 18             	add    $0x18,%esp
	return ;
  80175f:	90                   	nop
}
  801760:	c9                   	leave  
  801761:	c3                   	ret    

00801762 <gettst>:
uint32 gettst()
{
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 2b                	push   $0x2b
  801771:	e8 c9 fa ff ff       	call   80123f <syscall>
  801776:	83 c4 18             	add    $0x18,%esp
}
  801779:	c9                   	leave  
  80177a:	c3                   	ret    

0080177b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80177b:	55                   	push   %ebp
  80177c:	89 e5                	mov    %esp,%ebp
  80177e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 2c                	push   $0x2c
  80178d:	e8 ad fa ff ff       	call   80123f <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
  801795:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801798:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80179c:	75 07                	jne    8017a5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80179e:	b8 01 00 00 00       	mov    $0x1,%eax
  8017a3:	eb 05                	jmp    8017aa <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017aa:	c9                   	leave  
  8017ab:	c3                   	ret    

008017ac <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017ac:	55                   	push   %ebp
  8017ad:	89 e5                	mov    %esp,%ebp
  8017af:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 2c                	push   $0x2c
  8017be:	e8 7c fa ff ff       	call   80123f <syscall>
  8017c3:	83 c4 18             	add    $0x18,%esp
  8017c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017c9:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017cd:	75 07                	jne    8017d6 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017cf:	b8 01 00 00 00       	mov    $0x1,%eax
  8017d4:	eb 05                	jmp    8017db <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017d6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017db:	c9                   	leave  
  8017dc:	c3                   	ret    

008017dd <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
  8017e0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 2c                	push   $0x2c
  8017ef:	e8 4b fa ff ff       	call   80123f <syscall>
  8017f4:	83 c4 18             	add    $0x18,%esp
  8017f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017fa:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017fe:	75 07                	jne    801807 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801800:	b8 01 00 00 00       	mov    $0x1,%eax
  801805:	eb 05                	jmp    80180c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801807:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 2c                	push   $0x2c
  801820:	e8 1a fa ff ff       	call   80123f <syscall>
  801825:	83 c4 18             	add    $0x18,%esp
  801828:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80182b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80182f:	75 07                	jne    801838 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801831:	b8 01 00 00 00       	mov    $0x1,%eax
  801836:	eb 05                	jmp    80183d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801838:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80183d:	c9                   	leave  
  80183e:	c3                   	ret    

0080183f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80183f:	55                   	push   %ebp
  801840:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	ff 75 08             	pushl  0x8(%ebp)
  80184d:	6a 2d                	push   $0x2d
  80184f:	e8 eb f9 ff ff       	call   80123f <syscall>
  801854:	83 c4 18             	add    $0x18,%esp
	return ;
  801857:	90                   	nop
}
  801858:	c9                   	leave  
  801859:	c3                   	ret    

0080185a <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80185a:	55                   	push   %ebp
  80185b:	89 e5                	mov    %esp,%ebp
  80185d:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80185e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801861:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801864:	8b 55 0c             	mov    0xc(%ebp),%edx
  801867:	8b 45 08             	mov    0x8(%ebp),%eax
  80186a:	6a 00                	push   $0x0
  80186c:	53                   	push   %ebx
  80186d:	51                   	push   %ecx
  80186e:	52                   	push   %edx
  80186f:	50                   	push   %eax
  801870:	6a 2e                	push   $0x2e
  801872:	e8 c8 f9 ff ff       	call   80123f <syscall>
  801877:	83 c4 18             	add    $0x18,%esp
}
  80187a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80187d:	c9                   	leave  
  80187e:	c3                   	ret    

0080187f <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80187f:	55                   	push   %ebp
  801880:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801882:	8b 55 0c             	mov    0xc(%ebp),%edx
  801885:	8b 45 08             	mov    0x8(%ebp),%eax
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	52                   	push   %edx
  80188f:	50                   	push   %eax
  801890:	6a 2f                	push   $0x2f
  801892:	e8 a8 f9 ff ff       	call   80123f <syscall>
  801897:	83 c4 18             	add    $0x18,%esp
}
  80189a:	c9                   	leave  
  80189b:	c3                   	ret    

0080189c <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  80189c:	55                   	push   %ebp
  80189d:	89 e5                	mov    %esp,%ebp
  80189f:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018a2:	8b 55 08             	mov    0x8(%ebp),%edx
  8018a5:	89 d0                	mov    %edx,%eax
  8018a7:	c1 e0 02             	shl    $0x2,%eax
  8018aa:	01 d0                	add    %edx,%eax
  8018ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018b3:	01 d0                	add    %edx,%eax
  8018b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018bc:	01 d0                	add    %edx,%eax
  8018be:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c5:	01 d0                	add    %edx,%eax
  8018c7:	c1 e0 04             	shl    $0x4,%eax
  8018ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8018cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8018d4:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8018d7:	83 ec 0c             	sub    $0xc,%esp
  8018da:	50                   	push   %eax
  8018db:	e8 76 fd ff ff       	call   801656 <sys_get_virtual_time>
  8018e0:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8018e3:	eb 41                	jmp    801926 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8018e5:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8018e8:	83 ec 0c             	sub    $0xc,%esp
  8018eb:	50                   	push   %eax
  8018ec:	e8 65 fd ff ff       	call   801656 <sys_get_virtual_time>
  8018f1:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8018f4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8018f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018fa:	29 c2                	sub    %eax,%edx
  8018fc:	89 d0                	mov    %edx,%eax
  8018fe:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801901:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801904:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801907:	89 d1                	mov    %edx,%ecx
  801909:	29 c1                	sub    %eax,%ecx
  80190b:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80190e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801911:	39 c2                	cmp    %eax,%edx
  801913:	0f 97 c0             	seta   %al
  801916:	0f b6 c0             	movzbl %al,%eax
  801919:	29 c1                	sub    %eax,%ecx
  80191b:	89 c8                	mov    %ecx,%eax
  80191d:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801920:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801923:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801926:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801929:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80192c:	72 b7                	jb     8018e5 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80192e:	90                   	nop
  80192f:	c9                   	leave  
  801930:	c3                   	ret    

00801931 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801931:	55                   	push   %ebp
  801932:	89 e5                	mov    %esp,%ebp
  801934:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801937:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80193e:	eb 03                	jmp    801943 <busy_wait+0x12>
  801940:	ff 45 fc             	incl   -0x4(%ebp)
  801943:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801946:	3b 45 08             	cmp    0x8(%ebp),%eax
  801949:	72 f5                	jb     801940 <busy_wait+0xf>
	return i;
  80194b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80194e:	c9                   	leave  
  80194f:	c3                   	ret    

00801950 <__udivdi3>:
  801950:	55                   	push   %ebp
  801951:	57                   	push   %edi
  801952:	56                   	push   %esi
  801953:	53                   	push   %ebx
  801954:	83 ec 1c             	sub    $0x1c,%esp
  801957:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80195b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80195f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801963:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801967:	89 ca                	mov    %ecx,%edx
  801969:	89 f8                	mov    %edi,%eax
  80196b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80196f:	85 f6                	test   %esi,%esi
  801971:	75 2d                	jne    8019a0 <__udivdi3+0x50>
  801973:	39 cf                	cmp    %ecx,%edi
  801975:	77 65                	ja     8019dc <__udivdi3+0x8c>
  801977:	89 fd                	mov    %edi,%ebp
  801979:	85 ff                	test   %edi,%edi
  80197b:	75 0b                	jne    801988 <__udivdi3+0x38>
  80197d:	b8 01 00 00 00       	mov    $0x1,%eax
  801982:	31 d2                	xor    %edx,%edx
  801984:	f7 f7                	div    %edi
  801986:	89 c5                	mov    %eax,%ebp
  801988:	31 d2                	xor    %edx,%edx
  80198a:	89 c8                	mov    %ecx,%eax
  80198c:	f7 f5                	div    %ebp
  80198e:	89 c1                	mov    %eax,%ecx
  801990:	89 d8                	mov    %ebx,%eax
  801992:	f7 f5                	div    %ebp
  801994:	89 cf                	mov    %ecx,%edi
  801996:	89 fa                	mov    %edi,%edx
  801998:	83 c4 1c             	add    $0x1c,%esp
  80199b:	5b                   	pop    %ebx
  80199c:	5e                   	pop    %esi
  80199d:	5f                   	pop    %edi
  80199e:	5d                   	pop    %ebp
  80199f:	c3                   	ret    
  8019a0:	39 ce                	cmp    %ecx,%esi
  8019a2:	77 28                	ja     8019cc <__udivdi3+0x7c>
  8019a4:	0f bd fe             	bsr    %esi,%edi
  8019a7:	83 f7 1f             	xor    $0x1f,%edi
  8019aa:	75 40                	jne    8019ec <__udivdi3+0x9c>
  8019ac:	39 ce                	cmp    %ecx,%esi
  8019ae:	72 0a                	jb     8019ba <__udivdi3+0x6a>
  8019b0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019b4:	0f 87 9e 00 00 00    	ja     801a58 <__udivdi3+0x108>
  8019ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8019bf:	89 fa                	mov    %edi,%edx
  8019c1:	83 c4 1c             	add    $0x1c,%esp
  8019c4:	5b                   	pop    %ebx
  8019c5:	5e                   	pop    %esi
  8019c6:	5f                   	pop    %edi
  8019c7:	5d                   	pop    %ebp
  8019c8:	c3                   	ret    
  8019c9:	8d 76 00             	lea    0x0(%esi),%esi
  8019cc:	31 ff                	xor    %edi,%edi
  8019ce:	31 c0                	xor    %eax,%eax
  8019d0:	89 fa                	mov    %edi,%edx
  8019d2:	83 c4 1c             	add    $0x1c,%esp
  8019d5:	5b                   	pop    %ebx
  8019d6:	5e                   	pop    %esi
  8019d7:	5f                   	pop    %edi
  8019d8:	5d                   	pop    %ebp
  8019d9:	c3                   	ret    
  8019da:	66 90                	xchg   %ax,%ax
  8019dc:	89 d8                	mov    %ebx,%eax
  8019de:	f7 f7                	div    %edi
  8019e0:	31 ff                	xor    %edi,%edi
  8019e2:	89 fa                	mov    %edi,%edx
  8019e4:	83 c4 1c             	add    $0x1c,%esp
  8019e7:	5b                   	pop    %ebx
  8019e8:	5e                   	pop    %esi
  8019e9:	5f                   	pop    %edi
  8019ea:	5d                   	pop    %ebp
  8019eb:	c3                   	ret    
  8019ec:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019f1:	89 eb                	mov    %ebp,%ebx
  8019f3:	29 fb                	sub    %edi,%ebx
  8019f5:	89 f9                	mov    %edi,%ecx
  8019f7:	d3 e6                	shl    %cl,%esi
  8019f9:	89 c5                	mov    %eax,%ebp
  8019fb:	88 d9                	mov    %bl,%cl
  8019fd:	d3 ed                	shr    %cl,%ebp
  8019ff:	89 e9                	mov    %ebp,%ecx
  801a01:	09 f1                	or     %esi,%ecx
  801a03:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a07:	89 f9                	mov    %edi,%ecx
  801a09:	d3 e0                	shl    %cl,%eax
  801a0b:	89 c5                	mov    %eax,%ebp
  801a0d:	89 d6                	mov    %edx,%esi
  801a0f:	88 d9                	mov    %bl,%cl
  801a11:	d3 ee                	shr    %cl,%esi
  801a13:	89 f9                	mov    %edi,%ecx
  801a15:	d3 e2                	shl    %cl,%edx
  801a17:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a1b:	88 d9                	mov    %bl,%cl
  801a1d:	d3 e8                	shr    %cl,%eax
  801a1f:	09 c2                	or     %eax,%edx
  801a21:	89 d0                	mov    %edx,%eax
  801a23:	89 f2                	mov    %esi,%edx
  801a25:	f7 74 24 0c          	divl   0xc(%esp)
  801a29:	89 d6                	mov    %edx,%esi
  801a2b:	89 c3                	mov    %eax,%ebx
  801a2d:	f7 e5                	mul    %ebp
  801a2f:	39 d6                	cmp    %edx,%esi
  801a31:	72 19                	jb     801a4c <__udivdi3+0xfc>
  801a33:	74 0b                	je     801a40 <__udivdi3+0xf0>
  801a35:	89 d8                	mov    %ebx,%eax
  801a37:	31 ff                	xor    %edi,%edi
  801a39:	e9 58 ff ff ff       	jmp    801996 <__udivdi3+0x46>
  801a3e:	66 90                	xchg   %ax,%ax
  801a40:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a44:	89 f9                	mov    %edi,%ecx
  801a46:	d3 e2                	shl    %cl,%edx
  801a48:	39 c2                	cmp    %eax,%edx
  801a4a:	73 e9                	jae    801a35 <__udivdi3+0xe5>
  801a4c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a4f:	31 ff                	xor    %edi,%edi
  801a51:	e9 40 ff ff ff       	jmp    801996 <__udivdi3+0x46>
  801a56:	66 90                	xchg   %ax,%ax
  801a58:	31 c0                	xor    %eax,%eax
  801a5a:	e9 37 ff ff ff       	jmp    801996 <__udivdi3+0x46>
  801a5f:	90                   	nop

00801a60 <__umoddi3>:
  801a60:	55                   	push   %ebp
  801a61:	57                   	push   %edi
  801a62:	56                   	push   %esi
  801a63:	53                   	push   %ebx
  801a64:	83 ec 1c             	sub    $0x1c,%esp
  801a67:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a6b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a6f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a73:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a77:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a7b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a7f:	89 f3                	mov    %esi,%ebx
  801a81:	89 fa                	mov    %edi,%edx
  801a83:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a87:	89 34 24             	mov    %esi,(%esp)
  801a8a:	85 c0                	test   %eax,%eax
  801a8c:	75 1a                	jne    801aa8 <__umoddi3+0x48>
  801a8e:	39 f7                	cmp    %esi,%edi
  801a90:	0f 86 a2 00 00 00    	jbe    801b38 <__umoddi3+0xd8>
  801a96:	89 c8                	mov    %ecx,%eax
  801a98:	89 f2                	mov    %esi,%edx
  801a9a:	f7 f7                	div    %edi
  801a9c:	89 d0                	mov    %edx,%eax
  801a9e:	31 d2                	xor    %edx,%edx
  801aa0:	83 c4 1c             	add    $0x1c,%esp
  801aa3:	5b                   	pop    %ebx
  801aa4:	5e                   	pop    %esi
  801aa5:	5f                   	pop    %edi
  801aa6:	5d                   	pop    %ebp
  801aa7:	c3                   	ret    
  801aa8:	39 f0                	cmp    %esi,%eax
  801aaa:	0f 87 ac 00 00 00    	ja     801b5c <__umoddi3+0xfc>
  801ab0:	0f bd e8             	bsr    %eax,%ebp
  801ab3:	83 f5 1f             	xor    $0x1f,%ebp
  801ab6:	0f 84 ac 00 00 00    	je     801b68 <__umoddi3+0x108>
  801abc:	bf 20 00 00 00       	mov    $0x20,%edi
  801ac1:	29 ef                	sub    %ebp,%edi
  801ac3:	89 fe                	mov    %edi,%esi
  801ac5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ac9:	89 e9                	mov    %ebp,%ecx
  801acb:	d3 e0                	shl    %cl,%eax
  801acd:	89 d7                	mov    %edx,%edi
  801acf:	89 f1                	mov    %esi,%ecx
  801ad1:	d3 ef                	shr    %cl,%edi
  801ad3:	09 c7                	or     %eax,%edi
  801ad5:	89 e9                	mov    %ebp,%ecx
  801ad7:	d3 e2                	shl    %cl,%edx
  801ad9:	89 14 24             	mov    %edx,(%esp)
  801adc:	89 d8                	mov    %ebx,%eax
  801ade:	d3 e0                	shl    %cl,%eax
  801ae0:	89 c2                	mov    %eax,%edx
  801ae2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ae6:	d3 e0                	shl    %cl,%eax
  801ae8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801aec:	8b 44 24 08          	mov    0x8(%esp),%eax
  801af0:	89 f1                	mov    %esi,%ecx
  801af2:	d3 e8                	shr    %cl,%eax
  801af4:	09 d0                	or     %edx,%eax
  801af6:	d3 eb                	shr    %cl,%ebx
  801af8:	89 da                	mov    %ebx,%edx
  801afa:	f7 f7                	div    %edi
  801afc:	89 d3                	mov    %edx,%ebx
  801afe:	f7 24 24             	mull   (%esp)
  801b01:	89 c6                	mov    %eax,%esi
  801b03:	89 d1                	mov    %edx,%ecx
  801b05:	39 d3                	cmp    %edx,%ebx
  801b07:	0f 82 87 00 00 00    	jb     801b94 <__umoddi3+0x134>
  801b0d:	0f 84 91 00 00 00    	je     801ba4 <__umoddi3+0x144>
  801b13:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b17:	29 f2                	sub    %esi,%edx
  801b19:	19 cb                	sbb    %ecx,%ebx
  801b1b:	89 d8                	mov    %ebx,%eax
  801b1d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b21:	d3 e0                	shl    %cl,%eax
  801b23:	89 e9                	mov    %ebp,%ecx
  801b25:	d3 ea                	shr    %cl,%edx
  801b27:	09 d0                	or     %edx,%eax
  801b29:	89 e9                	mov    %ebp,%ecx
  801b2b:	d3 eb                	shr    %cl,%ebx
  801b2d:	89 da                	mov    %ebx,%edx
  801b2f:	83 c4 1c             	add    $0x1c,%esp
  801b32:	5b                   	pop    %ebx
  801b33:	5e                   	pop    %esi
  801b34:	5f                   	pop    %edi
  801b35:	5d                   	pop    %ebp
  801b36:	c3                   	ret    
  801b37:	90                   	nop
  801b38:	89 fd                	mov    %edi,%ebp
  801b3a:	85 ff                	test   %edi,%edi
  801b3c:	75 0b                	jne    801b49 <__umoddi3+0xe9>
  801b3e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b43:	31 d2                	xor    %edx,%edx
  801b45:	f7 f7                	div    %edi
  801b47:	89 c5                	mov    %eax,%ebp
  801b49:	89 f0                	mov    %esi,%eax
  801b4b:	31 d2                	xor    %edx,%edx
  801b4d:	f7 f5                	div    %ebp
  801b4f:	89 c8                	mov    %ecx,%eax
  801b51:	f7 f5                	div    %ebp
  801b53:	89 d0                	mov    %edx,%eax
  801b55:	e9 44 ff ff ff       	jmp    801a9e <__umoddi3+0x3e>
  801b5a:	66 90                	xchg   %ax,%ax
  801b5c:	89 c8                	mov    %ecx,%eax
  801b5e:	89 f2                	mov    %esi,%edx
  801b60:	83 c4 1c             	add    $0x1c,%esp
  801b63:	5b                   	pop    %ebx
  801b64:	5e                   	pop    %esi
  801b65:	5f                   	pop    %edi
  801b66:	5d                   	pop    %ebp
  801b67:	c3                   	ret    
  801b68:	3b 04 24             	cmp    (%esp),%eax
  801b6b:	72 06                	jb     801b73 <__umoddi3+0x113>
  801b6d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b71:	77 0f                	ja     801b82 <__umoddi3+0x122>
  801b73:	89 f2                	mov    %esi,%edx
  801b75:	29 f9                	sub    %edi,%ecx
  801b77:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b7b:	89 14 24             	mov    %edx,(%esp)
  801b7e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b82:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b86:	8b 14 24             	mov    (%esp),%edx
  801b89:	83 c4 1c             	add    $0x1c,%esp
  801b8c:	5b                   	pop    %ebx
  801b8d:	5e                   	pop    %esi
  801b8e:	5f                   	pop    %edi
  801b8f:	5d                   	pop    %ebp
  801b90:	c3                   	ret    
  801b91:	8d 76 00             	lea    0x0(%esi),%esi
  801b94:	2b 04 24             	sub    (%esp),%eax
  801b97:	19 fa                	sbb    %edi,%edx
  801b99:	89 d1                	mov    %edx,%ecx
  801b9b:	89 c6                	mov    %eax,%esi
  801b9d:	e9 71 ff ff ff       	jmp    801b13 <__umoddi3+0xb3>
  801ba2:	66 90                	xchg   %ax,%ax
  801ba4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ba8:	72 ea                	jb     801b94 <__umoddi3+0x134>
  801baa:	89 d9                	mov    %ebx,%ecx
  801bac:	e9 62 ff ff ff       	jmp    801b13 <__umoddi3+0xb3>

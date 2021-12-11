
obj/user/sc_CPU_MLFQ_slave_1_1:     file format elf32-i386


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
  800031:	e8 80 01 00 00       	call   8001b6 <libmain>
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
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
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
  80006a:	68 a0 1c 80 00       	push   $0x801ca0
  80006f:	e8 74 16 00 00       	call   8016e8 <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (ID == E_ENV_CREATION_ERROR)
  80007a:	83 7d ec ef          	cmpl   $0xffffffef,-0x14(%ebp)
  80007e:	75 14                	jne    800094 <_main+0x5c>
				panic("RUNNING OUT OF ENV!! terminating...");
  800080:	83 ec 04             	sub    $0x4,%esp
  800083:	68 a8 1c 80 00       	push   $0x801ca8
  800088:	6a 0a                	push   $0xa
  80008a:	68 cc 1c 80 00       	push   $0x801ccc
  80008f:	e8 67 02 00 00       	call   8002fb <_panic>

			sys_run_env(ID);
  800094:	83 ec 0c             	sub    $0xc,%esp
  800097:	ff 75 ec             	pushl  -0x14(%ebp)
  80009a:	e8 67 16 00 00       	call   801706 <sys_run_env>
  80009f:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 5; ++i) {
  8000a2:	ff 45 f4             	incl   -0xc(%ebp)
  8000a5:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
  8000a9:	7e 9c                	jle    800047 <_main+0xf>

			sys_run_env(ID);
		}
	//cprintf("done\n");
	//env_sleep(5000);
	int x = busy_wait(1000000);
  8000ab:	83 ec 0c             	sub    $0xc,%esp
  8000ae:	68 40 42 0f 00       	push   $0xf4240
  8000b3:	e8 61 19 00 00       	call   801a19 <busy_wait>
  8000b8:	83 c4 10             	add    $0x10,%esp
  8000bb:	89 45 e8             	mov    %eax,-0x18(%ebp)

	for (int i = 0; i < 5; ++i) {
  8000be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000c5:	e9 cc 00 00 00       	jmp    800196 <_main+0x15e>
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8000cf:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000d5:	a1 20 30 80 00       	mov    0x803020,%eax
  8000da:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000e0:	89 c1                	mov    %eax,%ecx
  8000e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e7:	8b 40 74             	mov    0x74(%eax),%eax
  8000ea:	52                   	push   %edx
  8000eb:	51                   	push   %ecx
  8000ec:	50                   	push   %eax
  8000ed:	68 a0 1c 80 00       	push   $0x801ca0
  8000f2:	e8 f1 15 00 00       	call   8016e8 <sys_create_env>
  8000f7:	83 c4 10             	add    $0x10,%esp
  8000fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (ID == E_ENV_CREATION_ERROR)
  8000fd:	83 7d ec ef          	cmpl   $0xffffffef,-0x14(%ebp)
  800101:	75 14                	jne    800117 <_main+0xdf>
				panic("RUNNING OUT OF ENV!! terminating...");
  800103:	83 ec 04             	sub    $0x4,%esp
  800106:	68 a8 1c 80 00       	push   $0x801ca8
  80010b:	6a 15                	push   $0x15
  80010d:	68 cc 1c 80 00       	push   $0x801ccc
  800112:	e8 e4 01 00 00       	call   8002fb <_panic>
			sys_run_env(ID);
  800117:	83 ec 0c             	sub    $0xc,%esp
  80011a:	ff 75 ec             	pushl  -0x14(%ebp)
  80011d:	e8 e4 15 00 00       	call   801706 <sys_run_env>
  800122:	83 c4 10             	add    $0x10,%esp
			x = busy_wait(10000);
  800125:	83 ec 0c             	sub    $0xc,%esp
  800128:	68 10 27 00 00       	push   $0x2710
  80012d:	e8 e7 18 00 00       	call   801a19 <busy_wait>
  800132:	83 c4 10             	add    $0x10,%esp
  800135:	89 45 e8             	mov    %eax,-0x18(%ebp)
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  800138:	a1 20 30 80 00       	mov    0x803020,%eax
  80013d:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800143:	a1 20 30 80 00       	mov    0x803020,%eax
  800148:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80014e:	89 c1                	mov    %eax,%ecx
  800150:	a1 20 30 80 00       	mov    0x803020,%eax
  800155:	8b 40 74             	mov    0x74(%eax),%eax
  800158:	52                   	push   %edx
  800159:	51                   	push   %ecx
  80015a:	50                   	push   %eax
  80015b:	68 a0 1c 80 00       	push   $0x801ca0
  800160:	e8 83 15 00 00       	call   8016e8 <sys_create_env>
  800165:	83 c4 10             	add    $0x10,%esp
  800168:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (ID == E_ENV_CREATION_ERROR)
  80016b:	83 7d ec ef          	cmpl   $0xffffffef,-0x14(%ebp)
  80016f:	75 14                	jne    800185 <_main+0x14d>
				panic("RUNNING OUT OF ENV!! terminating...");
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 a8 1c 80 00       	push   $0x801ca8
  800179:	6a 1a                	push   $0x1a
  80017b:	68 cc 1c 80 00       	push   $0x801ccc
  800180:	e8 76 01 00 00       	call   8002fb <_panic>
			sys_run_env(ID);
  800185:	83 ec 0c             	sub    $0xc,%esp
  800188:	ff 75 ec             	pushl  -0x14(%ebp)
  80018b:	e8 76 15 00 00       	call   801706 <sys_run_env>
  800190:	83 c4 10             	add    $0x10,%esp
		}
	//cprintf("done\n");
	//env_sleep(5000);
	int x = busy_wait(1000000);

	for (int i = 0; i < 5; ++i) {
  800193:	ff 45 f0             	incl   -0x10(%ebp)
  800196:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  80019a:	0f 8e 2a ff ff ff    	jle    8000ca <_main+0x92>
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
			if (ID == E_ENV_CREATION_ERROR)
				panic("RUNNING OUT OF ENV!! terminating...");
			sys_run_env(ID);
		}
	x = busy_wait(1000000);
  8001a0:	83 ec 0c             	sub    $0xc,%esp
  8001a3:	68 40 42 0f 00       	push   $0xf4240
  8001a8:	e8 6c 18 00 00       	call   801a19 <busy_wait>
  8001ad:	83 c4 10             	add    $0x10,%esp
  8001b0:	89 45 e8             	mov    %eax,-0x18(%ebp)

}
  8001b3:	90                   	nop
  8001b4:	c9                   	leave  
  8001b5:	c3                   	ret    

008001b6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001b6:	55                   	push   %ebp
  8001b7:	89 e5                	mov    %esp,%ebp
  8001b9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001bc:	e8 07 12 00 00       	call   8013c8 <sys_getenvindex>
  8001c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001c7:	89 d0                	mov    %edx,%eax
  8001c9:	c1 e0 03             	shl    $0x3,%eax
  8001cc:	01 d0                	add    %edx,%eax
  8001ce:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001d5:	01 c8                	add    %ecx,%eax
  8001d7:	01 c0                	add    %eax,%eax
  8001d9:	01 d0                	add    %edx,%eax
  8001db:	01 c0                	add    %eax,%eax
  8001dd:	01 d0                	add    %edx,%eax
  8001df:	89 c2                	mov    %eax,%edx
  8001e1:	c1 e2 05             	shl    $0x5,%edx
  8001e4:	29 c2                	sub    %eax,%edx
  8001e6:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001ed:	89 c2                	mov    %eax,%edx
  8001ef:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001f5:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ff:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800205:	84 c0                	test   %al,%al
  800207:	74 0f                	je     800218 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800209:	a1 20 30 80 00       	mov    0x803020,%eax
  80020e:	05 40 3c 01 00       	add    $0x13c40,%eax
  800213:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800218:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80021c:	7e 0a                	jle    800228 <libmain+0x72>
		binaryname = argv[0];
  80021e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800221:	8b 00                	mov    (%eax),%eax
  800223:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800228:	83 ec 08             	sub    $0x8,%esp
  80022b:	ff 75 0c             	pushl  0xc(%ebp)
  80022e:	ff 75 08             	pushl  0x8(%ebp)
  800231:	e8 02 fe ff ff       	call   800038 <_main>
  800236:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800239:	e8 25 13 00 00       	call   801563 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80023e:	83 ec 0c             	sub    $0xc,%esp
  800241:	68 04 1d 80 00       	push   $0x801d04
  800246:	e8 52 03 00 00       	call   80059d <cprintf>
  80024b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80024e:	a1 20 30 80 00       	mov    0x803020,%eax
  800253:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800259:	a1 20 30 80 00       	mov    0x803020,%eax
  80025e:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800264:	83 ec 04             	sub    $0x4,%esp
  800267:	52                   	push   %edx
  800268:	50                   	push   %eax
  800269:	68 2c 1d 80 00       	push   $0x801d2c
  80026e:	e8 2a 03 00 00       	call   80059d <cprintf>
  800273:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800276:	a1 20 30 80 00       	mov    0x803020,%eax
  80027b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800281:	a1 20 30 80 00       	mov    0x803020,%eax
  800286:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80028c:	83 ec 04             	sub    $0x4,%esp
  80028f:	52                   	push   %edx
  800290:	50                   	push   %eax
  800291:	68 54 1d 80 00       	push   $0x801d54
  800296:	e8 02 03 00 00       	call   80059d <cprintf>
  80029b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80029e:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a3:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002a9:	83 ec 08             	sub    $0x8,%esp
  8002ac:	50                   	push   %eax
  8002ad:	68 95 1d 80 00       	push   $0x801d95
  8002b2:	e8 e6 02 00 00       	call   80059d <cprintf>
  8002b7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002ba:	83 ec 0c             	sub    $0xc,%esp
  8002bd:	68 04 1d 80 00       	push   $0x801d04
  8002c2:	e8 d6 02 00 00       	call   80059d <cprintf>
  8002c7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002ca:	e8 ae 12 00 00       	call   80157d <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002cf:	e8 19 00 00 00       	call   8002ed <exit>
}
  8002d4:	90                   	nop
  8002d5:	c9                   	leave  
  8002d6:	c3                   	ret    

008002d7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002d7:	55                   	push   %ebp
  8002d8:	89 e5                	mov    %esp,%ebp
  8002da:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002dd:	83 ec 0c             	sub    $0xc,%esp
  8002e0:	6a 00                	push   $0x0
  8002e2:	e8 ad 10 00 00       	call   801394 <sys_env_destroy>
  8002e7:	83 c4 10             	add    $0x10,%esp
}
  8002ea:	90                   	nop
  8002eb:	c9                   	leave  
  8002ec:	c3                   	ret    

008002ed <exit>:

void
exit(void)
{
  8002ed:	55                   	push   %ebp
  8002ee:	89 e5                	mov    %esp,%ebp
  8002f0:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002f3:	e8 02 11 00 00       	call   8013fa <sys_env_exit>
}
  8002f8:	90                   	nop
  8002f9:	c9                   	leave  
  8002fa:	c3                   	ret    

008002fb <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002fb:	55                   	push   %ebp
  8002fc:	89 e5                	mov    %esp,%ebp
  8002fe:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800301:	8d 45 10             	lea    0x10(%ebp),%eax
  800304:	83 c0 04             	add    $0x4,%eax
  800307:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80030a:	a1 18 31 80 00       	mov    0x803118,%eax
  80030f:	85 c0                	test   %eax,%eax
  800311:	74 16                	je     800329 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800313:	a1 18 31 80 00       	mov    0x803118,%eax
  800318:	83 ec 08             	sub    $0x8,%esp
  80031b:	50                   	push   %eax
  80031c:	68 ac 1d 80 00       	push   $0x801dac
  800321:	e8 77 02 00 00       	call   80059d <cprintf>
  800326:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800329:	a1 00 30 80 00       	mov    0x803000,%eax
  80032e:	ff 75 0c             	pushl  0xc(%ebp)
  800331:	ff 75 08             	pushl  0x8(%ebp)
  800334:	50                   	push   %eax
  800335:	68 b1 1d 80 00       	push   $0x801db1
  80033a:	e8 5e 02 00 00       	call   80059d <cprintf>
  80033f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800342:	8b 45 10             	mov    0x10(%ebp),%eax
  800345:	83 ec 08             	sub    $0x8,%esp
  800348:	ff 75 f4             	pushl  -0xc(%ebp)
  80034b:	50                   	push   %eax
  80034c:	e8 e1 01 00 00       	call   800532 <vcprintf>
  800351:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800354:	83 ec 08             	sub    $0x8,%esp
  800357:	6a 00                	push   $0x0
  800359:	68 cd 1d 80 00       	push   $0x801dcd
  80035e:	e8 cf 01 00 00       	call   800532 <vcprintf>
  800363:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800366:	e8 82 ff ff ff       	call   8002ed <exit>

	// should not return here
	while (1) ;
  80036b:	eb fe                	jmp    80036b <_panic+0x70>

0080036d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80036d:	55                   	push   %ebp
  80036e:	89 e5                	mov    %esp,%ebp
  800370:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800373:	a1 20 30 80 00       	mov    0x803020,%eax
  800378:	8b 50 74             	mov    0x74(%eax),%edx
  80037b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80037e:	39 c2                	cmp    %eax,%edx
  800380:	74 14                	je     800396 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800382:	83 ec 04             	sub    $0x4,%esp
  800385:	68 d0 1d 80 00       	push   $0x801dd0
  80038a:	6a 26                	push   $0x26
  80038c:	68 1c 1e 80 00       	push   $0x801e1c
  800391:	e8 65 ff ff ff       	call   8002fb <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800396:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80039d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003a4:	e9 b6 00 00 00       	jmp    80045f <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8003a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b6:	01 d0                	add    %edx,%eax
  8003b8:	8b 00                	mov    (%eax),%eax
  8003ba:	85 c0                	test   %eax,%eax
  8003bc:	75 08                	jne    8003c6 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003be:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003c1:	e9 96 00 00 00       	jmp    80045c <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003c6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003cd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003d4:	eb 5d                	jmp    800433 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003db:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003e1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003e4:	c1 e2 04             	shl    $0x4,%edx
  8003e7:	01 d0                	add    %edx,%eax
  8003e9:	8a 40 04             	mov    0x4(%eax),%al
  8003ec:	84 c0                	test   %al,%al
  8003ee:	75 40                	jne    800430 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003fb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003fe:	c1 e2 04             	shl    $0x4,%edx
  800401:	01 d0                	add    %edx,%eax
  800403:	8b 00                	mov    (%eax),%eax
  800405:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800408:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80040b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800410:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800412:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800415:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80041c:	8b 45 08             	mov    0x8(%ebp),%eax
  80041f:	01 c8                	add    %ecx,%eax
  800421:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800423:	39 c2                	cmp    %eax,%edx
  800425:	75 09                	jne    800430 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800427:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80042e:	eb 12                	jmp    800442 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800430:	ff 45 e8             	incl   -0x18(%ebp)
  800433:	a1 20 30 80 00       	mov    0x803020,%eax
  800438:	8b 50 74             	mov    0x74(%eax),%edx
  80043b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80043e:	39 c2                	cmp    %eax,%edx
  800440:	77 94                	ja     8003d6 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800442:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800446:	75 14                	jne    80045c <CheckWSWithoutLastIndex+0xef>
			panic(
  800448:	83 ec 04             	sub    $0x4,%esp
  80044b:	68 28 1e 80 00       	push   $0x801e28
  800450:	6a 3a                	push   $0x3a
  800452:	68 1c 1e 80 00       	push   $0x801e1c
  800457:	e8 9f fe ff ff       	call   8002fb <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80045c:	ff 45 f0             	incl   -0x10(%ebp)
  80045f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800462:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800465:	0f 8c 3e ff ff ff    	jl     8003a9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80046b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800472:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800479:	eb 20                	jmp    80049b <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80047b:	a1 20 30 80 00       	mov    0x803020,%eax
  800480:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800486:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800489:	c1 e2 04             	shl    $0x4,%edx
  80048c:	01 d0                	add    %edx,%eax
  80048e:	8a 40 04             	mov    0x4(%eax),%al
  800491:	3c 01                	cmp    $0x1,%al
  800493:	75 03                	jne    800498 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800495:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800498:	ff 45 e0             	incl   -0x20(%ebp)
  80049b:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a0:	8b 50 74             	mov    0x74(%eax),%edx
  8004a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004a6:	39 c2                	cmp    %eax,%edx
  8004a8:	77 d1                	ja     80047b <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004ad:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004b0:	74 14                	je     8004c6 <CheckWSWithoutLastIndex+0x159>
		panic(
  8004b2:	83 ec 04             	sub    $0x4,%esp
  8004b5:	68 7c 1e 80 00       	push   $0x801e7c
  8004ba:	6a 44                	push   $0x44
  8004bc:	68 1c 1e 80 00       	push   $0x801e1c
  8004c1:	e8 35 fe ff ff       	call   8002fb <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004c6:	90                   	nop
  8004c7:	c9                   	leave  
  8004c8:	c3                   	ret    

008004c9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004c9:	55                   	push   %ebp
  8004ca:	89 e5                	mov    %esp,%ebp
  8004cc:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d2:	8b 00                	mov    (%eax),%eax
  8004d4:	8d 48 01             	lea    0x1(%eax),%ecx
  8004d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004da:	89 0a                	mov    %ecx,(%edx)
  8004dc:	8b 55 08             	mov    0x8(%ebp),%edx
  8004df:	88 d1                	mov    %dl,%cl
  8004e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004e4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004eb:	8b 00                	mov    (%eax),%eax
  8004ed:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004f2:	75 2c                	jne    800520 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004f4:	a0 24 30 80 00       	mov    0x803024,%al
  8004f9:	0f b6 c0             	movzbl %al,%eax
  8004fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004ff:	8b 12                	mov    (%edx),%edx
  800501:	89 d1                	mov    %edx,%ecx
  800503:	8b 55 0c             	mov    0xc(%ebp),%edx
  800506:	83 c2 08             	add    $0x8,%edx
  800509:	83 ec 04             	sub    $0x4,%esp
  80050c:	50                   	push   %eax
  80050d:	51                   	push   %ecx
  80050e:	52                   	push   %edx
  80050f:	e8 3e 0e 00 00       	call   801352 <sys_cputs>
  800514:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800517:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800520:	8b 45 0c             	mov    0xc(%ebp),%eax
  800523:	8b 40 04             	mov    0x4(%eax),%eax
  800526:	8d 50 01             	lea    0x1(%eax),%edx
  800529:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80052f:	90                   	nop
  800530:	c9                   	leave  
  800531:	c3                   	ret    

00800532 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800532:	55                   	push   %ebp
  800533:	89 e5                	mov    %esp,%ebp
  800535:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80053b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800542:	00 00 00 
	b.cnt = 0;
  800545:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80054c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80054f:	ff 75 0c             	pushl  0xc(%ebp)
  800552:	ff 75 08             	pushl  0x8(%ebp)
  800555:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80055b:	50                   	push   %eax
  80055c:	68 c9 04 80 00       	push   $0x8004c9
  800561:	e8 11 02 00 00       	call   800777 <vprintfmt>
  800566:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800569:	a0 24 30 80 00       	mov    0x803024,%al
  80056e:	0f b6 c0             	movzbl %al,%eax
  800571:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800577:	83 ec 04             	sub    $0x4,%esp
  80057a:	50                   	push   %eax
  80057b:	52                   	push   %edx
  80057c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800582:	83 c0 08             	add    $0x8,%eax
  800585:	50                   	push   %eax
  800586:	e8 c7 0d 00 00       	call   801352 <sys_cputs>
  80058b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80058e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800595:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80059b:	c9                   	leave  
  80059c:	c3                   	ret    

0080059d <cprintf>:

int cprintf(const char *fmt, ...) {
  80059d:	55                   	push   %ebp
  80059e:	89 e5                	mov    %esp,%ebp
  8005a0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005a3:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005aa:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b3:	83 ec 08             	sub    $0x8,%esp
  8005b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8005b9:	50                   	push   %eax
  8005ba:	e8 73 ff ff ff       	call   800532 <vcprintf>
  8005bf:	83 c4 10             	add    $0x10,%esp
  8005c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005c8:	c9                   	leave  
  8005c9:	c3                   	ret    

008005ca <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005ca:	55                   	push   %ebp
  8005cb:	89 e5                	mov    %esp,%ebp
  8005cd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005d0:	e8 8e 0f 00 00       	call   801563 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005d5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005db:	8b 45 08             	mov    0x8(%ebp),%eax
  8005de:	83 ec 08             	sub    $0x8,%esp
  8005e1:	ff 75 f4             	pushl  -0xc(%ebp)
  8005e4:	50                   	push   %eax
  8005e5:	e8 48 ff ff ff       	call   800532 <vcprintf>
  8005ea:	83 c4 10             	add    $0x10,%esp
  8005ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005f0:	e8 88 0f 00 00       	call   80157d <sys_enable_interrupt>
	return cnt;
  8005f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005f8:	c9                   	leave  
  8005f9:	c3                   	ret    

008005fa <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005fa:	55                   	push   %ebp
  8005fb:	89 e5                	mov    %esp,%ebp
  8005fd:	53                   	push   %ebx
  8005fe:	83 ec 14             	sub    $0x14,%esp
  800601:	8b 45 10             	mov    0x10(%ebp),%eax
  800604:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800607:	8b 45 14             	mov    0x14(%ebp),%eax
  80060a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80060d:	8b 45 18             	mov    0x18(%ebp),%eax
  800610:	ba 00 00 00 00       	mov    $0x0,%edx
  800615:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800618:	77 55                	ja     80066f <printnum+0x75>
  80061a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80061d:	72 05                	jb     800624 <printnum+0x2a>
  80061f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800622:	77 4b                	ja     80066f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800624:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800627:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80062a:	8b 45 18             	mov    0x18(%ebp),%eax
  80062d:	ba 00 00 00 00       	mov    $0x0,%edx
  800632:	52                   	push   %edx
  800633:	50                   	push   %eax
  800634:	ff 75 f4             	pushl  -0xc(%ebp)
  800637:	ff 75 f0             	pushl  -0x10(%ebp)
  80063a:	e8 f9 13 00 00       	call   801a38 <__udivdi3>
  80063f:	83 c4 10             	add    $0x10,%esp
  800642:	83 ec 04             	sub    $0x4,%esp
  800645:	ff 75 20             	pushl  0x20(%ebp)
  800648:	53                   	push   %ebx
  800649:	ff 75 18             	pushl  0x18(%ebp)
  80064c:	52                   	push   %edx
  80064d:	50                   	push   %eax
  80064e:	ff 75 0c             	pushl  0xc(%ebp)
  800651:	ff 75 08             	pushl  0x8(%ebp)
  800654:	e8 a1 ff ff ff       	call   8005fa <printnum>
  800659:	83 c4 20             	add    $0x20,%esp
  80065c:	eb 1a                	jmp    800678 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80065e:	83 ec 08             	sub    $0x8,%esp
  800661:	ff 75 0c             	pushl  0xc(%ebp)
  800664:	ff 75 20             	pushl  0x20(%ebp)
  800667:	8b 45 08             	mov    0x8(%ebp),%eax
  80066a:	ff d0                	call   *%eax
  80066c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80066f:	ff 4d 1c             	decl   0x1c(%ebp)
  800672:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800676:	7f e6                	jg     80065e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800678:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80067b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800680:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800683:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800686:	53                   	push   %ebx
  800687:	51                   	push   %ecx
  800688:	52                   	push   %edx
  800689:	50                   	push   %eax
  80068a:	e8 b9 14 00 00       	call   801b48 <__umoddi3>
  80068f:	83 c4 10             	add    $0x10,%esp
  800692:	05 f4 20 80 00       	add    $0x8020f4,%eax
  800697:	8a 00                	mov    (%eax),%al
  800699:	0f be c0             	movsbl %al,%eax
  80069c:	83 ec 08             	sub    $0x8,%esp
  80069f:	ff 75 0c             	pushl  0xc(%ebp)
  8006a2:	50                   	push   %eax
  8006a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a6:	ff d0                	call   *%eax
  8006a8:	83 c4 10             	add    $0x10,%esp
}
  8006ab:	90                   	nop
  8006ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006af:	c9                   	leave  
  8006b0:	c3                   	ret    

008006b1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006b1:	55                   	push   %ebp
  8006b2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006b4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006b8:	7e 1c                	jle    8006d6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bd:	8b 00                	mov    (%eax),%eax
  8006bf:	8d 50 08             	lea    0x8(%eax),%edx
  8006c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c5:	89 10                	mov    %edx,(%eax)
  8006c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ca:	8b 00                	mov    (%eax),%eax
  8006cc:	83 e8 08             	sub    $0x8,%eax
  8006cf:	8b 50 04             	mov    0x4(%eax),%edx
  8006d2:	8b 00                	mov    (%eax),%eax
  8006d4:	eb 40                	jmp    800716 <getuint+0x65>
	else if (lflag)
  8006d6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006da:	74 1e                	je     8006fa <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006df:	8b 00                	mov    (%eax),%eax
  8006e1:	8d 50 04             	lea    0x4(%eax),%edx
  8006e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e7:	89 10                	mov    %edx,(%eax)
  8006e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ec:	8b 00                	mov    (%eax),%eax
  8006ee:	83 e8 04             	sub    $0x4,%eax
  8006f1:	8b 00                	mov    (%eax),%eax
  8006f3:	ba 00 00 00 00       	mov    $0x0,%edx
  8006f8:	eb 1c                	jmp    800716 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fd:	8b 00                	mov    (%eax),%eax
  8006ff:	8d 50 04             	lea    0x4(%eax),%edx
  800702:	8b 45 08             	mov    0x8(%ebp),%eax
  800705:	89 10                	mov    %edx,(%eax)
  800707:	8b 45 08             	mov    0x8(%ebp),%eax
  80070a:	8b 00                	mov    (%eax),%eax
  80070c:	83 e8 04             	sub    $0x4,%eax
  80070f:	8b 00                	mov    (%eax),%eax
  800711:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800716:	5d                   	pop    %ebp
  800717:	c3                   	ret    

00800718 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800718:	55                   	push   %ebp
  800719:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80071b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80071f:	7e 1c                	jle    80073d <getint+0x25>
		return va_arg(*ap, long long);
  800721:	8b 45 08             	mov    0x8(%ebp),%eax
  800724:	8b 00                	mov    (%eax),%eax
  800726:	8d 50 08             	lea    0x8(%eax),%edx
  800729:	8b 45 08             	mov    0x8(%ebp),%eax
  80072c:	89 10                	mov    %edx,(%eax)
  80072e:	8b 45 08             	mov    0x8(%ebp),%eax
  800731:	8b 00                	mov    (%eax),%eax
  800733:	83 e8 08             	sub    $0x8,%eax
  800736:	8b 50 04             	mov    0x4(%eax),%edx
  800739:	8b 00                	mov    (%eax),%eax
  80073b:	eb 38                	jmp    800775 <getint+0x5d>
	else if (lflag)
  80073d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800741:	74 1a                	je     80075d <getint+0x45>
		return va_arg(*ap, long);
  800743:	8b 45 08             	mov    0x8(%ebp),%eax
  800746:	8b 00                	mov    (%eax),%eax
  800748:	8d 50 04             	lea    0x4(%eax),%edx
  80074b:	8b 45 08             	mov    0x8(%ebp),%eax
  80074e:	89 10                	mov    %edx,(%eax)
  800750:	8b 45 08             	mov    0x8(%ebp),%eax
  800753:	8b 00                	mov    (%eax),%eax
  800755:	83 e8 04             	sub    $0x4,%eax
  800758:	8b 00                	mov    (%eax),%eax
  80075a:	99                   	cltd   
  80075b:	eb 18                	jmp    800775 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80075d:	8b 45 08             	mov    0x8(%ebp),%eax
  800760:	8b 00                	mov    (%eax),%eax
  800762:	8d 50 04             	lea    0x4(%eax),%edx
  800765:	8b 45 08             	mov    0x8(%ebp),%eax
  800768:	89 10                	mov    %edx,(%eax)
  80076a:	8b 45 08             	mov    0x8(%ebp),%eax
  80076d:	8b 00                	mov    (%eax),%eax
  80076f:	83 e8 04             	sub    $0x4,%eax
  800772:	8b 00                	mov    (%eax),%eax
  800774:	99                   	cltd   
}
  800775:	5d                   	pop    %ebp
  800776:	c3                   	ret    

00800777 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800777:	55                   	push   %ebp
  800778:	89 e5                	mov    %esp,%ebp
  80077a:	56                   	push   %esi
  80077b:	53                   	push   %ebx
  80077c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80077f:	eb 17                	jmp    800798 <vprintfmt+0x21>
			if (ch == '\0')
  800781:	85 db                	test   %ebx,%ebx
  800783:	0f 84 af 03 00 00    	je     800b38 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800789:	83 ec 08             	sub    $0x8,%esp
  80078c:	ff 75 0c             	pushl  0xc(%ebp)
  80078f:	53                   	push   %ebx
  800790:	8b 45 08             	mov    0x8(%ebp),%eax
  800793:	ff d0                	call   *%eax
  800795:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800798:	8b 45 10             	mov    0x10(%ebp),%eax
  80079b:	8d 50 01             	lea    0x1(%eax),%edx
  80079e:	89 55 10             	mov    %edx,0x10(%ebp)
  8007a1:	8a 00                	mov    (%eax),%al
  8007a3:	0f b6 d8             	movzbl %al,%ebx
  8007a6:	83 fb 25             	cmp    $0x25,%ebx
  8007a9:	75 d6                	jne    800781 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007ab:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007af:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007b6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007bd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007c4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ce:	8d 50 01             	lea    0x1(%eax),%edx
  8007d1:	89 55 10             	mov    %edx,0x10(%ebp)
  8007d4:	8a 00                	mov    (%eax),%al
  8007d6:	0f b6 d8             	movzbl %al,%ebx
  8007d9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007dc:	83 f8 55             	cmp    $0x55,%eax
  8007df:	0f 87 2b 03 00 00    	ja     800b10 <vprintfmt+0x399>
  8007e5:	8b 04 85 18 21 80 00 	mov    0x802118(,%eax,4),%eax
  8007ec:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007ee:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007f2:	eb d7                	jmp    8007cb <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007f4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007f8:	eb d1                	jmp    8007cb <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007fa:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800801:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800804:	89 d0                	mov    %edx,%eax
  800806:	c1 e0 02             	shl    $0x2,%eax
  800809:	01 d0                	add    %edx,%eax
  80080b:	01 c0                	add    %eax,%eax
  80080d:	01 d8                	add    %ebx,%eax
  80080f:	83 e8 30             	sub    $0x30,%eax
  800812:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800815:	8b 45 10             	mov    0x10(%ebp),%eax
  800818:	8a 00                	mov    (%eax),%al
  80081a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80081d:	83 fb 2f             	cmp    $0x2f,%ebx
  800820:	7e 3e                	jle    800860 <vprintfmt+0xe9>
  800822:	83 fb 39             	cmp    $0x39,%ebx
  800825:	7f 39                	jg     800860 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800827:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80082a:	eb d5                	jmp    800801 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80082c:	8b 45 14             	mov    0x14(%ebp),%eax
  80082f:	83 c0 04             	add    $0x4,%eax
  800832:	89 45 14             	mov    %eax,0x14(%ebp)
  800835:	8b 45 14             	mov    0x14(%ebp),%eax
  800838:	83 e8 04             	sub    $0x4,%eax
  80083b:	8b 00                	mov    (%eax),%eax
  80083d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800840:	eb 1f                	jmp    800861 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800842:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800846:	79 83                	jns    8007cb <vprintfmt+0x54>
				width = 0;
  800848:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80084f:	e9 77 ff ff ff       	jmp    8007cb <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800854:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80085b:	e9 6b ff ff ff       	jmp    8007cb <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800860:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800861:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800865:	0f 89 60 ff ff ff    	jns    8007cb <vprintfmt+0x54>
				width = precision, precision = -1;
  80086b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80086e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800871:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800878:	e9 4e ff ff ff       	jmp    8007cb <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80087d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800880:	e9 46 ff ff ff       	jmp    8007cb <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800885:	8b 45 14             	mov    0x14(%ebp),%eax
  800888:	83 c0 04             	add    $0x4,%eax
  80088b:	89 45 14             	mov    %eax,0x14(%ebp)
  80088e:	8b 45 14             	mov    0x14(%ebp),%eax
  800891:	83 e8 04             	sub    $0x4,%eax
  800894:	8b 00                	mov    (%eax),%eax
  800896:	83 ec 08             	sub    $0x8,%esp
  800899:	ff 75 0c             	pushl  0xc(%ebp)
  80089c:	50                   	push   %eax
  80089d:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a0:	ff d0                	call   *%eax
  8008a2:	83 c4 10             	add    $0x10,%esp
			break;
  8008a5:	e9 89 02 00 00       	jmp    800b33 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ad:	83 c0 04             	add    $0x4,%eax
  8008b0:	89 45 14             	mov    %eax,0x14(%ebp)
  8008b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b6:	83 e8 04             	sub    $0x4,%eax
  8008b9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008bb:	85 db                	test   %ebx,%ebx
  8008bd:	79 02                	jns    8008c1 <vprintfmt+0x14a>
				err = -err;
  8008bf:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008c1:	83 fb 64             	cmp    $0x64,%ebx
  8008c4:	7f 0b                	jg     8008d1 <vprintfmt+0x15a>
  8008c6:	8b 34 9d 60 1f 80 00 	mov    0x801f60(,%ebx,4),%esi
  8008cd:	85 f6                	test   %esi,%esi
  8008cf:	75 19                	jne    8008ea <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008d1:	53                   	push   %ebx
  8008d2:	68 05 21 80 00       	push   $0x802105
  8008d7:	ff 75 0c             	pushl  0xc(%ebp)
  8008da:	ff 75 08             	pushl  0x8(%ebp)
  8008dd:	e8 5e 02 00 00       	call   800b40 <printfmt>
  8008e2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008e5:	e9 49 02 00 00       	jmp    800b33 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008ea:	56                   	push   %esi
  8008eb:	68 0e 21 80 00       	push   $0x80210e
  8008f0:	ff 75 0c             	pushl  0xc(%ebp)
  8008f3:	ff 75 08             	pushl  0x8(%ebp)
  8008f6:	e8 45 02 00 00       	call   800b40 <printfmt>
  8008fb:	83 c4 10             	add    $0x10,%esp
			break;
  8008fe:	e9 30 02 00 00       	jmp    800b33 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800903:	8b 45 14             	mov    0x14(%ebp),%eax
  800906:	83 c0 04             	add    $0x4,%eax
  800909:	89 45 14             	mov    %eax,0x14(%ebp)
  80090c:	8b 45 14             	mov    0x14(%ebp),%eax
  80090f:	83 e8 04             	sub    $0x4,%eax
  800912:	8b 30                	mov    (%eax),%esi
  800914:	85 f6                	test   %esi,%esi
  800916:	75 05                	jne    80091d <vprintfmt+0x1a6>
				p = "(null)";
  800918:	be 11 21 80 00       	mov    $0x802111,%esi
			if (width > 0 && padc != '-')
  80091d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800921:	7e 6d                	jle    800990 <vprintfmt+0x219>
  800923:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800927:	74 67                	je     800990 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800929:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80092c:	83 ec 08             	sub    $0x8,%esp
  80092f:	50                   	push   %eax
  800930:	56                   	push   %esi
  800931:	e8 0c 03 00 00       	call   800c42 <strnlen>
  800936:	83 c4 10             	add    $0x10,%esp
  800939:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80093c:	eb 16                	jmp    800954 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80093e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800942:	83 ec 08             	sub    $0x8,%esp
  800945:	ff 75 0c             	pushl  0xc(%ebp)
  800948:	50                   	push   %eax
  800949:	8b 45 08             	mov    0x8(%ebp),%eax
  80094c:	ff d0                	call   *%eax
  80094e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800951:	ff 4d e4             	decl   -0x1c(%ebp)
  800954:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800958:	7f e4                	jg     80093e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80095a:	eb 34                	jmp    800990 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80095c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800960:	74 1c                	je     80097e <vprintfmt+0x207>
  800962:	83 fb 1f             	cmp    $0x1f,%ebx
  800965:	7e 05                	jle    80096c <vprintfmt+0x1f5>
  800967:	83 fb 7e             	cmp    $0x7e,%ebx
  80096a:	7e 12                	jle    80097e <vprintfmt+0x207>
					putch('?', putdat);
  80096c:	83 ec 08             	sub    $0x8,%esp
  80096f:	ff 75 0c             	pushl  0xc(%ebp)
  800972:	6a 3f                	push   $0x3f
  800974:	8b 45 08             	mov    0x8(%ebp),%eax
  800977:	ff d0                	call   *%eax
  800979:	83 c4 10             	add    $0x10,%esp
  80097c:	eb 0f                	jmp    80098d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80097e:	83 ec 08             	sub    $0x8,%esp
  800981:	ff 75 0c             	pushl  0xc(%ebp)
  800984:	53                   	push   %ebx
  800985:	8b 45 08             	mov    0x8(%ebp),%eax
  800988:	ff d0                	call   *%eax
  80098a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80098d:	ff 4d e4             	decl   -0x1c(%ebp)
  800990:	89 f0                	mov    %esi,%eax
  800992:	8d 70 01             	lea    0x1(%eax),%esi
  800995:	8a 00                	mov    (%eax),%al
  800997:	0f be d8             	movsbl %al,%ebx
  80099a:	85 db                	test   %ebx,%ebx
  80099c:	74 24                	je     8009c2 <vprintfmt+0x24b>
  80099e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009a2:	78 b8                	js     80095c <vprintfmt+0x1e5>
  8009a4:	ff 4d e0             	decl   -0x20(%ebp)
  8009a7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009ab:	79 af                	jns    80095c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009ad:	eb 13                	jmp    8009c2 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009af:	83 ec 08             	sub    $0x8,%esp
  8009b2:	ff 75 0c             	pushl  0xc(%ebp)
  8009b5:	6a 20                	push   $0x20
  8009b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ba:	ff d0                	call   *%eax
  8009bc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009bf:	ff 4d e4             	decl   -0x1c(%ebp)
  8009c2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009c6:	7f e7                	jg     8009af <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009c8:	e9 66 01 00 00       	jmp    800b33 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009cd:	83 ec 08             	sub    $0x8,%esp
  8009d0:	ff 75 e8             	pushl  -0x18(%ebp)
  8009d3:	8d 45 14             	lea    0x14(%ebp),%eax
  8009d6:	50                   	push   %eax
  8009d7:	e8 3c fd ff ff       	call   800718 <getint>
  8009dc:	83 c4 10             	add    $0x10,%esp
  8009df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009eb:	85 d2                	test   %edx,%edx
  8009ed:	79 23                	jns    800a12 <vprintfmt+0x29b>
				putch('-', putdat);
  8009ef:	83 ec 08             	sub    $0x8,%esp
  8009f2:	ff 75 0c             	pushl  0xc(%ebp)
  8009f5:	6a 2d                	push   $0x2d
  8009f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fa:	ff d0                	call   *%eax
  8009fc:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a02:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a05:	f7 d8                	neg    %eax
  800a07:	83 d2 00             	adc    $0x0,%edx
  800a0a:	f7 da                	neg    %edx
  800a0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a0f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a12:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a19:	e9 bc 00 00 00       	jmp    800ada <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a1e:	83 ec 08             	sub    $0x8,%esp
  800a21:	ff 75 e8             	pushl  -0x18(%ebp)
  800a24:	8d 45 14             	lea    0x14(%ebp),%eax
  800a27:	50                   	push   %eax
  800a28:	e8 84 fc ff ff       	call   8006b1 <getuint>
  800a2d:	83 c4 10             	add    $0x10,%esp
  800a30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a33:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a36:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a3d:	e9 98 00 00 00       	jmp    800ada <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a42:	83 ec 08             	sub    $0x8,%esp
  800a45:	ff 75 0c             	pushl  0xc(%ebp)
  800a48:	6a 58                	push   $0x58
  800a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4d:	ff d0                	call   *%eax
  800a4f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a52:	83 ec 08             	sub    $0x8,%esp
  800a55:	ff 75 0c             	pushl  0xc(%ebp)
  800a58:	6a 58                	push   $0x58
  800a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5d:	ff d0                	call   *%eax
  800a5f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a62:	83 ec 08             	sub    $0x8,%esp
  800a65:	ff 75 0c             	pushl  0xc(%ebp)
  800a68:	6a 58                	push   $0x58
  800a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6d:	ff d0                	call   *%eax
  800a6f:	83 c4 10             	add    $0x10,%esp
			break;
  800a72:	e9 bc 00 00 00       	jmp    800b33 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a77:	83 ec 08             	sub    $0x8,%esp
  800a7a:	ff 75 0c             	pushl  0xc(%ebp)
  800a7d:	6a 30                	push   $0x30
  800a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a82:	ff d0                	call   *%eax
  800a84:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a87:	83 ec 08             	sub    $0x8,%esp
  800a8a:	ff 75 0c             	pushl  0xc(%ebp)
  800a8d:	6a 78                	push   $0x78
  800a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a92:	ff d0                	call   *%eax
  800a94:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a97:	8b 45 14             	mov    0x14(%ebp),%eax
  800a9a:	83 c0 04             	add    $0x4,%eax
  800a9d:	89 45 14             	mov    %eax,0x14(%ebp)
  800aa0:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa3:	83 e8 04             	sub    $0x4,%eax
  800aa6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800aa8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ab2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ab9:	eb 1f                	jmp    800ada <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800abb:	83 ec 08             	sub    $0x8,%esp
  800abe:	ff 75 e8             	pushl  -0x18(%ebp)
  800ac1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ac4:	50                   	push   %eax
  800ac5:	e8 e7 fb ff ff       	call   8006b1 <getuint>
  800aca:	83 c4 10             	add    $0x10,%esp
  800acd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ad3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ada:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ade:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ae1:	83 ec 04             	sub    $0x4,%esp
  800ae4:	52                   	push   %edx
  800ae5:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ae8:	50                   	push   %eax
  800ae9:	ff 75 f4             	pushl  -0xc(%ebp)
  800aec:	ff 75 f0             	pushl  -0x10(%ebp)
  800aef:	ff 75 0c             	pushl  0xc(%ebp)
  800af2:	ff 75 08             	pushl  0x8(%ebp)
  800af5:	e8 00 fb ff ff       	call   8005fa <printnum>
  800afa:	83 c4 20             	add    $0x20,%esp
			break;
  800afd:	eb 34                	jmp    800b33 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800aff:	83 ec 08             	sub    $0x8,%esp
  800b02:	ff 75 0c             	pushl  0xc(%ebp)
  800b05:	53                   	push   %ebx
  800b06:	8b 45 08             	mov    0x8(%ebp),%eax
  800b09:	ff d0                	call   *%eax
  800b0b:	83 c4 10             	add    $0x10,%esp
			break;
  800b0e:	eb 23                	jmp    800b33 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b10:	83 ec 08             	sub    $0x8,%esp
  800b13:	ff 75 0c             	pushl  0xc(%ebp)
  800b16:	6a 25                	push   $0x25
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	ff d0                	call   *%eax
  800b1d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b20:	ff 4d 10             	decl   0x10(%ebp)
  800b23:	eb 03                	jmp    800b28 <vprintfmt+0x3b1>
  800b25:	ff 4d 10             	decl   0x10(%ebp)
  800b28:	8b 45 10             	mov    0x10(%ebp),%eax
  800b2b:	48                   	dec    %eax
  800b2c:	8a 00                	mov    (%eax),%al
  800b2e:	3c 25                	cmp    $0x25,%al
  800b30:	75 f3                	jne    800b25 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b32:	90                   	nop
		}
	}
  800b33:	e9 47 fc ff ff       	jmp    80077f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b38:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b39:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b3c:	5b                   	pop    %ebx
  800b3d:	5e                   	pop    %esi
  800b3e:	5d                   	pop    %ebp
  800b3f:	c3                   	ret    

00800b40 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b40:	55                   	push   %ebp
  800b41:	89 e5                	mov    %esp,%ebp
  800b43:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b46:	8d 45 10             	lea    0x10(%ebp),%eax
  800b49:	83 c0 04             	add    $0x4,%eax
  800b4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b52:	ff 75 f4             	pushl  -0xc(%ebp)
  800b55:	50                   	push   %eax
  800b56:	ff 75 0c             	pushl  0xc(%ebp)
  800b59:	ff 75 08             	pushl  0x8(%ebp)
  800b5c:	e8 16 fc ff ff       	call   800777 <vprintfmt>
  800b61:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b64:	90                   	nop
  800b65:	c9                   	leave  
  800b66:	c3                   	ret    

00800b67 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b67:	55                   	push   %ebp
  800b68:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6d:	8b 40 08             	mov    0x8(%eax),%eax
  800b70:	8d 50 01             	lea    0x1(%eax),%edx
  800b73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b76:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7c:	8b 10                	mov    (%eax),%edx
  800b7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b81:	8b 40 04             	mov    0x4(%eax),%eax
  800b84:	39 c2                	cmp    %eax,%edx
  800b86:	73 12                	jae    800b9a <sprintputch+0x33>
		*b->buf++ = ch;
  800b88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8b:	8b 00                	mov    (%eax),%eax
  800b8d:	8d 48 01             	lea    0x1(%eax),%ecx
  800b90:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b93:	89 0a                	mov    %ecx,(%edx)
  800b95:	8b 55 08             	mov    0x8(%ebp),%edx
  800b98:	88 10                	mov    %dl,(%eax)
}
  800b9a:	90                   	nop
  800b9b:	5d                   	pop    %ebp
  800b9c:	c3                   	ret    

00800b9d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b9d:	55                   	push   %ebp
  800b9e:	89 e5                	mov    %esp,%ebp
  800ba0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ba9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bac:	8d 50 ff             	lea    -0x1(%eax),%edx
  800baf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb2:	01 d0                	add    %edx,%eax
  800bb4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bbe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bc2:	74 06                	je     800bca <vsnprintf+0x2d>
  800bc4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc8:	7f 07                	jg     800bd1 <vsnprintf+0x34>
		return -E_INVAL;
  800bca:	b8 03 00 00 00       	mov    $0x3,%eax
  800bcf:	eb 20                	jmp    800bf1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bd1:	ff 75 14             	pushl  0x14(%ebp)
  800bd4:	ff 75 10             	pushl  0x10(%ebp)
  800bd7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bda:	50                   	push   %eax
  800bdb:	68 67 0b 80 00       	push   $0x800b67
  800be0:	e8 92 fb ff ff       	call   800777 <vprintfmt>
  800be5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800be8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800beb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bee:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bf1:	c9                   	leave  
  800bf2:	c3                   	ret    

00800bf3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bf3:	55                   	push   %ebp
  800bf4:	89 e5                	mov    %esp,%ebp
  800bf6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bf9:	8d 45 10             	lea    0x10(%ebp),%eax
  800bfc:	83 c0 04             	add    $0x4,%eax
  800bff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c02:	8b 45 10             	mov    0x10(%ebp),%eax
  800c05:	ff 75 f4             	pushl  -0xc(%ebp)
  800c08:	50                   	push   %eax
  800c09:	ff 75 0c             	pushl  0xc(%ebp)
  800c0c:	ff 75 08             	pushl  0x8(%ebp)
  800c0f:	e8 89 ff ff ff       	call   800b9d <vsnprintf>
  800c14:	83 c4 10             	add    $0x10,%esp
  800c17:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c1d:	c9                   	leave  
  800c1e:	c3                   	ret    

00800c1f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c1f:	55                   	push   %ebp
  800c20:	89 e5                	mov    %esp,%ebp
  800c22:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c2c:	eb 06                	jmp    800c34 <strlen+0x15>
		n++;
  800c2e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c31:	ff 45 08             	incl   0x8(%ebp)
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
  800c37:	8a 00                	mov    (%eax),%al
  800c39:	84 c0                	test   %al,%al
  800c3b:	75 f1                	jne    800c2e <strlen+0xf>
		n++;
	return n;
  800c3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c40:	c9                   	leave  
  800c41:	c3                   	ret    

00800c42 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c42:	55                   	push   %ebp
  800c43:	89 e5                	mov    %esp,%ebp
  800c45:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c4f:	eb 09                	jmp    800c5a <strnlen+0x18>
		n++;
  800c51:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c54:	ff 45 08             	incl   0x8(%ebp)
  800c57:	ff 4d 0c             	decl   0xc(%ebp)
  800c5a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c5e:	74 09                	je     800c69 <strnlen+0x27>
  800c60:	8b 45 08             	mov    0x8(%ebp),%eax
  800c63:	8a 00                	mov    (%eax),%al
  800c65:	84 c0                	test   %al,%al
  800c67:	75 e8                	jne    800c51 <strnlen+0xf>
		n++;
	return n;
  800c69:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c6c:	c9                   	leave  
  800c6d:	c3                   	ret    

00800c6e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
  800c71:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c74:	8b 45 08             	mov    0x8(%ebp),%eax
  800c77:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c7a:	90                   	nop
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	8d 50 01             	lea    0x1(%eax),%edx
  800c81:	89 55 08             	mov    %edx,0x8(%ebp)
  800c84:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c87:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c8a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c8d:	8a 12                	mov    (%edx),%dl
  800c8f:	88 10                	mov    %dl,(%eax)
  800c91:	8a 00                	mov    (%eax),%al
  800c93:	84 c0                	test   %al,%al
  800c95:	75 e4                	jne    800c7b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c97:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c9a:	c9                   	leave  
  800c9b:	c3                   	ret    

00800c9c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c9c:	55                   	push   %ebp
  800c9d:	89 e5                	mov    %esp,%ebp
  800c9f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ca8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800caf:	eb 1f                	jmp    800cd0 <strncpy+0x34>
		*dst++ = *src;
  800cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb4:	8d 50 01             	lea    0x1(%eax),%edx
  800cb7:	89 55 08             	mov    %edx,0x8(%ebp)
  800cba:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cbd:	8a 12                	mov    (%edx),%dl
  800cbf:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc4:	8a 00                	mov    (%eax),%al
  800cc6:	84 c0                	test   %al,%al
  800cc8:	74 03                	je     800ccd <strncpy+0x31>
			src++;
  800cca:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ccd:	ff 45 fc             	incl   -0x4(%ebp)
  800cd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cd3:	3b 45 10             	cmp    0x10(%ebp),%eax
  800cd6:	72 d9                	jb     800cb1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800cd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cdb:	c9                   	leave  
  800cdc:	c3                   	ret    

00800cdd <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800cdd:	55                   	push   %ebp
  800cde:	89 e5                	mov    %esp,%ebp
  800ce0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ce9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ced:	74 30                	je     800d1f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800cef:	eb 16                	jmp    800d07 <strlcpy+0x2a>
			*dst++ = *src++;
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	8d 50 01             	lea    0x1(%eax),%edx
  800cf7:	89 55 08             	mov    %edx,0x8(%ebp)
  800cfa:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cfd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d00:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d03:	8a 12                	mov    (%edx),%dl
  800d05:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d07:	ff 4d 10             	decl   0x10(%ebp)
  800d0a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0e:	74 09                	je     800d19 <strlcpy+0x3c>
  800d10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	84 c0                	test   %al,%al
  800d17:	75 d8                	jne    800cf1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d1f:	8b 55 08             	mov    0x8(%ebp),%edx
  800d22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d25:	29 c2                	sub    %eax,%edx
  800d27:	89 d0                	mov    %edx,%eax
}
  800d29:	c9                   	leave  
  800d2a:	c3                   	ret    

00800d2b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d2b:	55                   	push   %ebp
  800d2c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d2e:	eb 06                	jmp    800d36 <strcmp+0xb>
		p++, q++;
  800d30:	ff 45 08             	incl   0x8(%ebp)
  800d33:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8a 00                	mov    (%eax),%al
  800d3b:	84 c0                	test   %al,%al
  800d3d:	74 0e                	je     800d4d <strcmp+0x22>
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	8a 10                	mov    (%eax),%dl
  800d44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d47:	8a 00                	mov    (%eax),%al
  800d49:	38 c2                	cmp    %al,%dl
  800d4b:	74 e3                	je     800d30 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	8a 00                	mov    (%eax),%al
  800d52:	0f b6 d0             	movzbl %al,%edx
  800d55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d58:	8a 00                	mov    (%eax),%al
  800d5a:	0f b6 c0             	movzbl %al,%eax
  800d5d:	29 c2                	sub    %eax,%edx
  800d5f:	89 d0                	mov    %edx,%eax
}
  800d61:	5d                   	pop    %ebp
  800d62:	c3                   	ret    

00800d63 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d63:	55                   	push   %ebp
  800d64:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d66:	eb 09                	jmp    800d71 <strncmp+0xe>
		n--, p++, q++;
  800d68:	ff 4d 10             	decl   0x10(%ebp)
  800d6b:	ff 45 08             	incl   0x8(%ebp)
  800d6e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d71:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d75:	74 17                	je     800d8e <strncmp+0x2b>
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	8a 00                	mov    (%eax),%al
  800d7c:	84 c0                	test   %al,%al
  800d7e:	74 0e                	je     800d8e <strncmp+0x2b>
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
  800d83:	8a 10                	mov    (%eax),%dl
  800d85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d88:	8a 00                	mov    (%eax),%al
  800d8a:	38 c2                	cmp    %al,%dl
  800d8c:	74 da                	je     800d68 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d92:	75 07                	jne    800d9b <strncmp+0x38>
		return 0;
  800d94:	b8 00 00 00 00       	mov    $0x0,%eax
  800d99:	eb 14                	jmp    800daf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9e:	8a 00                	mov    (%eax),%al
  800da0:	0f b6 d0             	movzbl %al,%edx
  800da3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da6:	8a 00                	mov    (%eax),%al
  800da8:	0f b6 c0             	movzbl %al,%eax
  800dab:	29 c2                	sub    %eax,%edx
  800dad:	89 d0                	mov    %edx,%eax
}
  800daf:	5d                   	pop    %ebp
  800db0:	c3                   	ret    

00800db1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800db1:	55                   	push   %ebp
  800db2:	89 e5                	mov    %esp,%ebp
  800db4:	83 ec 04             	sub    $0x4,%esp
  800db7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dba:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dbd:	eb 12                	jmp    800dd1 <strchr+0x20>
		if (*s == c)
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	8a 00                	mov    (%eax),%al
  800dc4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dc7:	75 05                	jne    800dce <strchr+0x1d>
			return (char *) s;
  800dc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcc:	eb 11                	jmp    800ddf <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dce:	ff 45 08             	incl   0x8(%ebp)
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd4:	8a 00                	mov    (%eax),%al
  800dd6:	84 c0                	test   %al,%al
  800dd8:	75 e5                	jne    800dbf <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800dda:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ddf:	c9                   	leave  
  800de0:	c3                   	ret    

00800de1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800de1:	55                   	push   %ebp
  800de2:	89 e5                	mov    %esp,%ebp
  800de4:	83 ec 04             	sub    $0x4,%esp
  800de7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dea:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ded:	eb 0d                	jmp    800dfc <strfind+0x1b>
		if (*s == c)
  800def:	8b 45 08             	mov    0x8(%ebp),%eax
  800df2:	8a 00                	mov    (%eax),%al
  800df4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800df7:	74 0e                	je     800e07 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800df9:	ff 45 08             	incl   0x8(%ebp)
  800dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dff:	8a 00                	mov    (%eax),%al
  800e01:	84 c0                	test   %al,%al
  800e03:	75 ea                	jne    800def <strfind+0xe>
  800e05:	eb 01                	jmp    800e08 <strfind+0x27>
		if (*s == c)
			break;
  800e07:	90                   	nop
	return (char *) s;
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e0b:	c9                   	leave  
  800e0c:	c3                   	ret    

00800e0d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e0d:	55                   	push   %ebp
  800e0e:	89 e5                	mov    %esp,%ebp
  800e10:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e19:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e1f:	eb 0e                	jmp    800e2f <memset+0x22>
		*p++ = c;
  800e21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e24:	8d 50 01             	lea    0x1(%eax),%edx
  800e27:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e2d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e2f:	ff 4d f8             	decl   -0x8(%ebp)
  800e32:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e36:	79 e9                	jns    800e21 <memset+0x14>
		*p++ = c;

	return v;
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e3b:	c9                   	leave  
  800e3c:	c3                   	ret    

00800e3d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e3d:	55                   	push   %ebp
  800e3e:	89 e5                	mov    %esp,%ebp
  800e40:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e4f:	eb 16                	jmp    800e67 <memcpy+0x2a>
		*d++ = *s++;
  800e51:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e54:	8d 50 01             	lea    0x1(%eax),%edx
  800e57:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e5a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e5d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e60:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e63:	8a 12                	mov    (%edx),%dl
  800e65:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e67:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e6d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e70:	85 c0                	test   %eax,%eax
  800e72:	75 dd                	jne    800e51 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e77:	c9                   	leave  
  800e78:	c3                   	ret    

00800e79 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e79:	55                   	push   %ebp
  800e7a:	89 e5                	mov    %esp,%ebp
  800e7c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e8e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e91:	73 50                	jae    800ee3 <memmove+0x6a>
  800e93:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e96:	8b 45 10             	mov    0x10(%ebp),%eax
  800e99:	01 d0                	add    %edx,%eax
  800e9b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e9e:	76 43                	jbe    800ee3 <memmove+0x6a>
		s += n;
  800ea0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ea6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800eac:	eb 10                	jmp    800ebe <memmove+0x45>
			*--d = *--s;
  800eae:	ff 4d f8             	decl   -0x8(%ebp)
  800eb1:	ff 4d fc             	decl   -0x4(%ebp)
  800eb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb7:	8a 10                	mov    (%eax),%dl
  800eb9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ebc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ebe:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec4:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec7:	85 c0                	test   %eax,%eax
  800ec9:	75 e3                	jne    800eae <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ecb:	eb 23                	jmp    800ef0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ecd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed0:	8d 50 01             	lea    0x1(%eax),%edx
  800ed3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ed6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ed9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800edc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800edf:	8a 12                	mov    (%edx),%dl
  800ee1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ee3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ee9:	89 55 10             	mov    %edx,0x10(%ebp)
  800eec:	85 c0                	test   %eax,%eax
  800eee:	75 dd                	jne    800ecd <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ef3:	c9                   	leave  
  800ef4:	c3                   	ret    

00800ef5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ef5:	55                   	push   %ebp
  800ef6:	89 e5                	mov    %esp,%ebp
  800ef8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800efb:	8b 45 08             	mov    0x8(%ebp),%eax
  800efe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f04:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f07:	eb 2a                	jmp    800f33 <memcmp+0x3e>
		if (*s1 != *s2)
  800f09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f0c:	8a 10                	mov    (%eax),%dl
  800f0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	38 c2                	cmp    %al,%dl
  800f15:	74 16                	je     800f2d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	0f b6 d0             	movzbl %al,%edx
  800f1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f22:	8a 00                	mov    (%eax),%al
  800f24:	0f b6 c0             	movzbl %al,%eax
  800f27:	29 c2                	sub    %eax,%edx
  800f29:	89 d0                	mov    %edx,%eax
  800f2b:	eb 18                	jmp    800f45 <memcmp+0x50>
		s1++, s2++;
  800f2d:	ff 45 fc             	incl   -0x4(%ebp)
  800f30:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f33:	8b 45 10             	mov    0x10(%ebp),%eax
  800f36:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f39:	89 55 10             	mov    %edx,0x10(%ebp)
  800f3c:	85 c0                	test   %eax,%eax
  800f3e:	75 c9                	jne    800f09 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f40:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f45:	c9                   	leave  
  800f46:	c3                   	ret    

00800f47 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f47:	55                   	push   %ebp
  800f48:	89 e5                	mov    %esp,%ebp
  800f4a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f4d:	8b 55 08             	mov    0x8(%ebp),%edx
  800f50:	8b 45 10             	mov    0x10(%ebp),%eax
  800f53:	01 d0                	add    %edx,%eax
  800f55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f58:	eb 15                	jmp    800f6f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5d:	8a 00                	mov    (%eax),%al
  800f5f:	0f b6 d0             	movzbl %al,%edx
  800f62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f65:	0f b6 c0             	movzbl %al,%eax
  800f68:	39 c2                	cmp    %eax,%edx
  800f6a:	74 0d                	je     800f79 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f6c:	ff 45 08             	incl   0x8(%ebp)
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f72:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f75:	72 e3                	jb     800f5a <memfind+0x13>
  800f77:	eb 01                	jmp    800f7a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f79:	90                   	nop
	return (void *) s;
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f7d:	c9                   	leave  
  800f7e:	c3                   	ret    

00800f7f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f7f:	55                   	push   %ebp
  800f80:	89 e5                	mov    %esp,%ebp
  800f82:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f8c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f93:	eb 03                	jmp    800f98 <strtol+0x19>
		s++;
  800f95:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	8a 00                	mov    (%eax),%al
  800f9d:	3c 20                	cmp    $0x20,%al
  800f9f:	74 f4                	je     800f95 <strtol+0x16>
  800fa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa4:	8a 00                	mov    (%eax),%al
  800fa6:	3c 09                	cmp    $0x9,%al
  800fa8:	74 eb                	je     800f95 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800faa:	8b 45 08             	mov    0x8(%ebp),%eax
  800fad:	8a 00                	mov    (%eax),%al
  800faf:	3c 2b                	cmp    $0x2b,%al
  800fb1:	75 05                	jne    800fb8 <strtol+0x39>
		s++;
  800fb3:	ff 45 08             	incl   0x8(%ebp)
  800fb6:	eb 13                	jmp    800fcb <strtol+0x4c>
	else if (*s == '-')
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	3c 2d                	cmp    $0x2d,%al
  800fbf:	75 0a                	jne    800fcb <strtol+0x4c>
		s++, neg = 1;
  800fc1:	ff 45 08             	incl   0x8(%ebp)
  800fc4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fcb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fcf:	74 06                	je     800fd7 <strtol+0x58>
  800fd1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fd5:	75 20                	jne    800ff7 <strtol+0x78>
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	3c 30                	cmp    $0x30,%al
  800fde:	75 17                	jne    800ff7 <strtol+0x78>
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	40                   	inc    %eax
  800fe4:	8a 00                	mov    (%eax),%al
  800fe6:	3c 78                	cmp    $0x78,%al
  800fe8:	75 0d                	jne    800ff7 <strtol+0x78>
		s += 2, base = 16;
  800fea:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fee:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ff5:	eb 28                	jmp    80101f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ff7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ffb:	75 15                	jne    801012 <strtol+0x93>
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	3c 30                	cmp    $0x30,%al
  801004:	75 0c                	jne    801012 <strtol+0x93>
		s++, base = 8;
  801006:	ff 45 08             	incl   0x8(%ebp)
  801009:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801010:	eb 0d                	jmp    80101f <strtol+0xa0>
	else if (base == 0)
  801012:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801016:	75 07                	jne    80101f <strtol+0xa0>
		base = 10;
  801018:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	8a 00                	mov    (%eax),%al
  801024:	3c 2f                	cmp    $0x2f,%al
  801026:	7e 19                	jle    801041 <strtol+0xc2>
  801028:	8b 45 08             	mov    0x8(%ebp),%eax
  80102b:	8a 00                	mov    (%eax),%al
  80102d:	3c 39                	cmp    $0x39,%al
  80102f:	7f 10                	jg     801041 <strtol+0xc2>
			dig = *s - '0';
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	8a 00                	mov    (%eax),%al
  801036:	0f be c0             	movsbl %al,%eax
  801039:	83 e8 30             	sub    $0x30,%eax
  80103c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80103f:	eb 42                	jmp    801083 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801041:	8b 45 08             	mov    0x8(%ebp),%eax
  801044:	8a 00                	mov    (%eax),%al
  801046:	3c 60                	cmp    $0x60,%al
  801048:	7e 19                	jle    801063 <strtol+0xe4>
  80104a:	8b 45 08             	mov    0x8(%ebp),%eax
  80104d:	8a 00                	mov    (%eax),%al
  80104f:	3c 7a                	cmp    $0x7a,%al
  801051:	7f 10                	jg     801063 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8a 00                	mov    (%eax),%al
  801058:	0f be c0             	movsbl %al,%eax
  80105b:	83 e8 57             	sub    $0x57,%eax
  80105e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801061:	eb 20                	jmp    801083 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
  801066:	8a 00                	mov    (%eax),%al
  801068:	3c 40                	cmp    $0x40,%al
  80106a:	7e 39                	jle    8010a5 <strtol+0x126>
  80106c:	8b 45 08             	mov    0x8(%ebp),%eax
  80106f:	8a 00                	mov    (%eax),%al
  801071:	3c 5a                	cmp    $0x5a,%al
  801073:	7f 30                	jg     8010a5 <strtol+0x126>
			dig = *s - 'A' + 10;
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	8a 00                	mov    (%eax),%al
  80107a:	0f be c0             	movsbl %al,%eax
  80107d:	83 e8 37             	sub    $0x37,%eax
  801080:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801083:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801086:	3b 45 10             	cmp    0x10(%ebp),%eax
  801089:	7d 19                	jge    8010a4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80108b:	ff 45 08             	incl   0x8(%ebp)
  80108e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801091:	0f af 45 10          	imul   0x10(%ebp),%eax
  801095:	89 c2                	mov    %eax,%edx
  801097:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80109a:	01 d0                	add    %edx,%eax
  80109c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80109f:	e9 7b ff ff ff       	jmp    80101f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010a4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010a5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010a9:	74 08                	je     8010b3 <strtol+0x134>
		*endptr = (char *) s;
  8010ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ae:	8b 55 08             	mov    0x8(%ebp),%edx
  8010b1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010b3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010b7:	74 07                	je     8010c0 <strtol+0x141>
  8010b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010bc:	f7 d8                	neg    %eax
  8010be:	eb 03                	jmp    8010c3 <strtol+0x144>
  8010c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010c3:	c9                   	leave  
  8010c4:	c3                   	ret    

008010c5 <ltostr>:

void
ltostr(long value, char *str)
{
  8010c5:	55                   	push   %ebp
  8010c6:	89 e5                	mov    %esp,%ebp
  8010c8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010d2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010d9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010dd:	79 13                	jns    8010f2 <ltostr+0x2d>
	{
		neg = 1;
  8010df:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010ec:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010ef:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010fa:	99                   	cltd   
  8010fb:	f7 f9                	idiv   %ecx
  8010fd:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801100:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801103:	8d 50 01             	lea    0x1(%eax),%edx
  801106:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801109:	89 c2                	mov    %eax,%edx
  80110b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110e:	01 d0                	add    %edx,%eax
  801110:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801113:	83 c2 30             	add    $0x30,%edx
  801116:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801118:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80111b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801120:	f7 e9                	imul   %ecx
  801122:	c1 fa 02             	sar    $0x2,%edx
  801125:	89 c8                	mov    %ecx,%eax
  801127:	c1 f8 1f             	sar    $0x1f,%eax
  80112a:	29 c2                	sub    %eax,%edx
  80112c:	89 d0                	mov    %edx,%eax
  80112e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801131:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801134:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801139:	f7 e9                	imul   %ecx
  80113b:	c1 fa 02             	sar    $0x2,%edx
  80113e:	89 c8                	mov    %ecx,%eax
  801140:	c1 f8 1f             	sar    $0x1f,%eax
  801143:	29 c2                	sub    %eax,%edx
  801145:	89 d0                	mov    %edx,%eax
  801147:	c1 e0 02             	shl    $0x2,%eax
  80114a:	01 d0                	add    %edx,%eax
  80114c:	01 c0                	add    %eax,%eax
  80114e:	29 c1                	sub    %eax,%ecx
  801150:	89 ca                	mov    %ecx,%edx
  801152:	85 d2                	test   %edx,%edx
  801154:	75 9c                	jne    8010f2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801156:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80115d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801160:	48                   	dec    %eax
  801161:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801164:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801168:	74 3d                	je     8011a7 <ltostr+0xe2>
		start = 1 ;
  80116a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801171:	eb 34                	jmp    8011a7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801173:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801176:	8b 45 0c             	mov    0xc(%ebp),%eax
  801179:	01 d0                	add    %edx,%eax
  80117b:	8a 00                	mov    (%eax),%al
  80117d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801180:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801183:	8b 45 0c             	mov    0xc(%ebp),%eax
  801186:	01 c2                	add    %eax,%edx
  801188:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80118b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118e:	01 c8                	add    %ecx,%eax
  801190:	8a 00                	mov    (%eax),%al
  801192:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801194:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801197:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119a:	01 c2                	add    %eax,%edx
  80119c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80119f:	88 02                	mov    %al,(%edx)
		start++ ;
  8011a1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011a4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011ad:	7c c4                	jl     801173 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011af:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b5:	01 d0                	add    %edx,%eax
  8011b7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011ba:	90                   	nop
  8011bb:	c9                   	leave  
  8011bc:	c3                   	ret    

008011bd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011bd:	55                   	push   %ebp
  8011be:	89 e5                	mov    %esp,%ebp
  8011c0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011c3:	ff 75 08             	pushl  0x8(%ebp)
  8011c6:	e8 54 fa ff ff       	call   800c1f <strlen>
  8011cb:	83 c4 04             	add    $0x4,%esp
  8011ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011d1:	ff 75 0c             	pushl  0xc(%ebp)
  8011d4:	e8 46 fa ff ff       	call   800c1f <strlen>
  8011d9:	83 c4 04             	add    $0x4,%esp
  8011dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011ed:	eb 17                	jmp    801206 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f5:	01 c2                	add    %eax,%edx
  8011f7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	01 c8                	add    %ecx,%eax
  8011ff:	8a 00                	mov    (%eax),%al
  801201:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801203:	ff 45 fc             	incl   -0x4(%ebp)
  801206:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801209:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80120c:	7c e1                	jl     8011ef <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80120e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801215:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80121c:	eb 1f                	jmp    80123d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80121e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801221:	8d 50 01             	lea    0x1(%eax),%edx
  801224:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801227:	89 c2                	mov    %eax,%edx
  801229:	8b 45 10             	mov    0x10(%ebp),%eax
  80122c:	01 c2                	add    %eax,%edx
  80122e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801231:	8b 45 0c             	mov    0xc(%ebp),%eax
  801234:	01 c8                	add    %ecx,%eax
  801236:	8a 00                	mov    (%eax),%al
  801238:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80123a:	ff 45 f8             	incl   -0x8(%ebp)
  80123d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801240:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801243:	7c d9                	jl     80121e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801245:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801248:	8b 45 10             	mov    0x10(%ebp),%eax
  80124b:	01 d0                	add    %edx,%eax
  80124d:	c6 00 00             	movb   $0x0,(%eax)
}
  801250:	90                   	nop
  801251:	c9                   	leave  
  801252:	c3                   	ret    

00801253 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801253:	55                   	push   %ebp
  801254:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801256:	8b 45 14             	mov    0x14(%ebp),%eax
  801259:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80125f:	8b 45 14             	mov    0x14(%ebp),%eax
  801262:	8b 00                	mov    (%eax),%eax
  801264:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80126b:	8b 45 10             	mov    0x10(%ebp),%eax
  80126e:	01 d0                	add    %edx,%eax
  801270:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801276:	eb 0c                	jmp    801284 <strsplit+0x31>
			*string++ = 0;
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	8d 50 01             	lea    0x1(%eax),%edx
  80127e:	89 55 08             	mov    %edx,0x8(%ebp)
  801281:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801284:	8b 45 08             	mov    0x8(%ebp),%eax
  801287:	8a 00                	mov    (%eax),%al
  801289:	84 c0                	test   %al,%al
  80128b:	74 18                	je     8012a5 <strsplit+0x52>
  80128d:	8b 45 08             	mov    0x8(%ebp),%eax
  801290:	8a 00                	mov    (%eax),%al
  801292:	0f be c0             	movsbl %al,%eax
  801295:	50                   	push   %eax
  801296:	ff 75 0c             	pushl  0xc(%ebp)
  801299:	e8 13 fb ff ff       	call   800db1 <strchr>
  80129e:	83 c4 08             	add    $0x8,%esp
  8012a1:	85 c0                	test   %eax,%eax
  8012a3:	75 d3                	jne    801278 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a8:	8a 00                	mov    (%eax),%al
  8012aa:	84 c0                	test   %al,%al
  8012ac:	74 5a                	je     801308 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8012ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b1:	8b 00                	mov    (%eax),%eax
  8012b3:	83 f8 0f             	cmp    $0xf,%eax
  8012b6:	75 07                	jne    8012bf <strsplit+0x6c>
		{
			return 0;
  8012b8:	b8 00 00 00 00       	mov    $0x0,%eax
  8012bd:	eb 66                	jmp    801325 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c2:	8b 00                	mov    (%eax),%eax
  8012c4:	8d 48 01             	lea    0x1(%eax),%ecx
  8012c7:	8b 55 14             	mov    0x14(%ebp),%edx
  8012ca:	89 0a                	mov    %ecx,(%edx)
  8012cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d6:	01 c2                	add    %eax,%edx
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012dd:	eb 03                	jmp    8012e2 <strsplit+0x8f>
			string++;
  8012df:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e5:	8a 00                	mov    (%eax),%al
  8012e7:	84 c0                	test   %al,%al
  8012e9:	74 8b                	je     801276 <strsplit+0x23>
  8012eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ee:	8a 00                	mov    (%eax),%al
  8012f0:	0f be c0             	movsbl %al,%eax
  8012f3:	50                   	push   %eax
  8012f4:	ff 75 0c             	pushl  0xc(%ebp)
  8012f7:	e8 b5 fa ff ff       	call   800db1 <strchr>
  8012fc:	83 c4 08             	add    $0x8,%esp
  8012ff:	85 c0                	test   %eax,%eax
  801301:	74 dc                	je     8012df <strsplit+0x8c>
			string++;
	}
  801303:	e9 6e ff ff ff       	jmp    801276 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801308:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801309:	8b 45 14             	mov    0x14(%ebp),%eax
  80130c:	8b 00                	mov    (%eax),%eax
  80130e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801315:	8b 45 10             	mov    0x10(%ebp),%eax
  801318:	01 d0                	add    %edx,%eax
  80131a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801320:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801325:	c9                   	leave  
  801326:	c3                   	ret    

00801327 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
  80132a:	57                   	push   %edi
  80132b:	56                   	push   %esi
  80132c:	53                   	push   %ebx
  80132d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	8b 55 0c             	mov    0xc(%ebp),%edx
  801336:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801339:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80133c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80133f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801342:	cd 30                	int    $0x30
  801344:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801347:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80134a:	83 c4 10             	add    $0x10,%esp
  80134d:	5b                   	pop    %ebx
  80134e:	5e                   	pop    %esi
  80134f:	5f                   	pop    %edi
  801350:	5d                   	pop    %ebp
  801351:	c3                   	ret    

00801352 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801352:	55                   	push   %ebp
  801353:	89 e5                	mov    %esp,%ebp
  801355:	83 ec 04             	sub    $0x4,%esp
  801358:	8b 45 10             	mov    0x10(%ebp),%eax
  80135b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80135e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	52                   	push   %edx
  80136a:	ff 75 0c             	pushl  0xc(%ebp)
  80136d:	50                   	push   %eax
  80136e:	6a 00                	push   $0x0
  801370:	e8 b2 ff ff ff       	call   801327 <syscall>
  801375:	83 c4 18             	add    $0x18,%esp
}
  801378:	90                   	nop
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <sys_cgetc>:

int
sys_cgetc(void)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	6a 01                	push   $0x1
  80138a:	e8 98 ff ff ff       	call   801327 <syscall>
  80138f:	83 c4 18             	add    $0x18,%esp
}
  801392:	c9                   	leave  
  801393:	c3                   	ret    

00801394 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 00                	push   $0x0
  8013a2:	50                   	push   %eax
  8013a3:	6a 05                	push   $0x5
  8013a5:	e8 7d ff ff ff       	call   801327 <syscall>
  8013aa:	83 c4 18             	add    $0x18,%esp
}
  8013ad:	c9                   	leave  
  8013ae:	c3                   	ret    

008013af <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013af:	55                   	push   %ebp
  8013b0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 02                	push   $0x2
  8013be:	e8 64 ff ff ff       	call   801327 <syscall>
  8013c3:	83 c4 18             	add    $0x18,%esp
}
  8013c6:	c9                   	leave  
  8013c7:	c3                   	ret    

008013c8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013c8:	55                   	push   %ebp
  8013c9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 03                	push   $0x3
  8013d7:	e8 4b ff ff ff       	call   801327 <syscall>
  8013dc:	83 c4 18             	add    $0x18,%esp
}
  8013df:	c9                   	leave  
  8013e0:	c3                   	ret    

008013e1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013e1:	55                   	push   %ebp
  8013e2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 04                	push   $0x4
  8013f0:	e8 32 ff ff ff       	call   801327 <syscall>
  8013f5:	83 c4 18             	add    $0x18,%esp
}
  8013f8:	c9                   	leave  
  8013f9:	c3                   	ret    

008013fa <sys_env_exit>:


void sys_env_exit(void)
{
  8013fa:	55                   	push   %ebp
  8013fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 06                	push   $0x6
  801409:	e8 19 ff ff ff       	call   801327 <syscall>
  80140e:	83 c4 18             	add    $0x18,%esp
}
  801411:	90                   	nop
  801412:	c9                   	leave  
  801413:	c3                   	ret    

00801414 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801417:	8b 55 0c             	mov    0xc(%ebp),%edx
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	52                   	push   %edx
  801424:	50                   	push   %eax
  801425:	6a 07                	push   $0x7
  801427:	e8 fb fe ff ff       	call   801327 <syscall>
  80142c:	83 c4 18             	add    $0x18,%esp
}
  80142f:	c9                   	leave  
  801430:	c3                   	ret    

00801431 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801431:	55                   	push   %ebp
  801432:	89 e5                	mov    %esp,%ebp
  801434:	56                   	push   %esi
  801435:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801436:	8b 75 18             	mov    0x18(%ebp),%esi
  801439:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80143c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80143f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	56                   	push   %esi
  801446:	53                   	push   %ebx
  801447:	51                   	push   %ecx
  801448:	52                   	push   %edx
  801449:	50                   	push   %eax
  80144a:	6a 08                	push   $0x8
  80144c:	e8 d6 fe ff ff       	call   801327 <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801457:	5b                   	pop    %ebx
  801458:	5e                   	pop    %esi
  801459:	5d                   	pop    %ebp
  80145a:	c3                   	ret    

0080145b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80145b:	55                   	push   %ebp
  80145c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80145e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	52                   	push   %edx
  80146b:	50                   	push   %eax
  80146c:	6a 09                	push   $0x9
  80146e:	e8 b4 fe ff ff       	call   801327 <syscall>
  801473:	83 c4 18             	add    $0x18,%esp
}
  801476:	c9                   	leave  
  801477:	c3                   	ret    

00801478 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	ff 75 0c             	pushl  0xc(%ebp)
  801484:	ff 75 08             	pushl  0x8(%ebp)
  801487:	6a 0a                	push   $0xa
  801489:	e8 99 fe ff ff       	call   801327 <syscall>
  80148e:	83 c4 18             	add    $0x18,%esp
}
  801491:	c9                   	leave  
  801492:	c3                   	ret    

00801493 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801493:	55                   	push   %ebp
  801494:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 0b                	push   $0xb
  8014a2:	e8 80 fe ff ff       	call   801327 <syscall>
  8014a7:	83 c4 18             	add    $0x18,%esp
}
  8014aa:	c9                   	leave  
  8014ab:	c3                   	ret    

008014ac <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014ac:	55                   	push   %ebp
  8014ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 0c                	push   $0xc
  8014bb:	e8 67 fe ff ff       	call   801327 <syscall>
  8014c0:	83 c4 18             	add    $0x18,%esp
}
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 0d                	push   $0xd
  8014d4:	e8 4e fe ff ff       	call   801327 <syscall>
  8014d9:	83 c4 18             	add    $0x18,%esp
}
  8014dc:	c9                   	leave  
  8014dd:	c3                   	ret    

008014de <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014de:	55                   	push   %ebp
  8014df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	ff 75 0c             	pushl  0xc(%ebp)
  8014ea:	ff 75 08             	pushl  0x8(%ebp)
  8014ed:	6a 11                	push   $0x11
  8014ef:	e8 33 fe ff ff       	call   801327 <syscall>
  8014f4:	83 c4 18             	add    $0x18,%esp
	return;
  8014f7:	90                   	nop
}
  8014f8:	c9                   	leave  
  8014f9:	c3                   	ret    

008014fa <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	ff 75 0c             	pushl  0xc(%ebp)
  801506:	ff 75 08             	pushl  0x8(%ebp)
  801509:	6a 12                	push   $0x12
  80150b:	e8 17 fe ff ff       	call   801327 <syscall>
  801510:	83 c4 18             	add    $0x18,%esp
	return ;
  801513:	90                   	nop
}
  801514:	c9                   	leave  
  801515:	c3                   	ret    

00801516 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801516:	55                   	push   %ebp
  801517:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 00                	push   $0x0
  801523:	6a 0e                	push   $0xe
  801525:	e8 fd fd ff ff       	call   801327 <syscall>
  80152a:	83 c4 18             	add    $0x18,%esp
}
  80152d:	c9                   	leave  
  80152e:	c3                   	ret    

0080152f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80152f:	55                   	push   %ebp
  801530:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	ff 75 08             	pushl  0x8(%ebp)
  80153d:	6a 0f                	push   $0xf
  80153f:	e8 e3 fd ff ff       	call   801327 <syscall>
  801544:	83 c4 18             	add    $0x18,%esp
}
  801547:	c9                   	leave  
  801548:	c3                   	ret    

00801549 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801549:	55                   	push   %ebp
  80154a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 10                	push   $0x10
  801558:	e8 ca fd ff ff       	call   801327 <syscall>
  80155d:	83 c4 18             	add    $0x18,%esp
}
  801560:	90                   	nop
  801561:	c9                   	leave  
  801562:	c3                   	ret    

00801563 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801563:	55                   	push   %ebp
  801564:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 14                	push   $0x14
  801572:	e8 b0 fd ff ff       	call   801327 <syscall>
  801577:	83 c4 18             	add    $0x18,%esp
}
  80157a:	90                   	nop
  80157b:	c9                   	leave  
  80157c:	c3                   	ret    

0080157d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80157d:	55                   	push   %ebp
  80157e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	6a 15                	push   $0x15
  80158c:	e8 96 fd ff ff       	call   801327 <syscall>
  801591:	83 c4 18             	add    $0x18,%esp
}
  801594:	90                   	nop
  801595:	c9                   	leave  
  801596:	c3                   	ret    

00801597 <sys_cputc>:


void
sys_cputc(const char c)
{
  801597:	55                   	push   %ebp
  801598:	89 e5                	mov    %esp,%ebp
  80159a:	83 ec 04             	sub    $0x4,%esp
  80159d:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015a3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	50                   	push   %eax
  8015b0:	6a 16                	push   $0x16
  8015b2:	e8 70 fd ff ff       	call   801327 <syscall>
  8015b7:	83 c4 18             	add    $0x18,%esp
}
  8015ba:	90                   	nop
  8015bb:	c9                   	leave  
  8015bc:	c3                   	ret    

008015bd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 17                	push   $0x17
  8015cc:	e8 56 fd ff ff       	call   801327 <syscall>
  8015d1:	83 c4 18             	add    $0x18,%esp
}
  8015d4:	90                   	nop
  8015d5:	c9                   	leave  
  8015d6:	c3                   	ret    

008015d7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015da:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	ff 75 0c             	pushl  0xc(%ebp)
  8015e6:	50                   	push   %eax
  8015e7:	6a 18                	push   $0x18
  8015e9:	e8 39 fd ff ff       	call   801327 <syscall>
  8015ee:	83 c4 18             	add    $0x18,%esp
}
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	52                   	push   %edx
  801603:	50                   	push   %eax
  801604:	6a 1b                	push   $0x1b
  801606:	e8 1c fd ff ff       	call   801327 <syscall>
  80160b:	83 c4 18             	add    $0x18,%esp
}
  80160e:	c9                   	leave  
  80160f:	c3                   	ret    

00801610 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801610:	55                   	push   %ebp
  801611:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801613:	8b 55 0c             	mov    0xc(%ebp),%edx
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	52                   	push   %edx
  801620:	50                   	push   %eax
  801621:	6a 19                	push   $0x19
  801623:	e8 ff fc ff ff       	call   801327 <syscall>
  801628:	83 c4 18             	add    $0x18,%esp
}
  80162b:	90                   	nop
  80162c:	c9                   	leave  
  80162d:	c3                   	ret    

0080162e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801631:	8b 55 0c             	mov    0xc(%ebp),%edx
  801634:	8b 45 08             	mov    0x8(%ebp),%eax
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	52                   	push   %edx
  80163e:	50                   	push   %eax
  80163f:	6a 1a                	push   $0x1a
  801641:	e8 e1 fc ff ff       	call   801327 <syscall>
  801646:	83 c4 18             	add    $0x18,%esp
}
  801649:	90                   	nop
  80164a:	c9                   	leave  
  80164b:	c3                   	ret    

0080164c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80164c:	55                   	push   %ebp
  80164d:	89 e5                	mov    %esp,%ebp
  80164f:	83 ec 04             	sub    $0x4,%esp
  801652:	8b 45 10             	mov    0x10(%ebp),%eax
  801655:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801658:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80165b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	6a 00                	push   $0x0
  801664:	51                   	push   %ecx
  801665:	52                   	push   %edx
  801666:	ff 75 0c             	pushl  0xc(%ebp)
  801669:	50                   	push   %eax
  80166a:	6a 1c                	push   $0x1c
  80166c:	e8 b6 fc ff ff       	call   801327 <syscall>
  801671:	83 c4 18             	add    $0x18,%esp
}
  801674:	c9                   	leave  
  801675:	c3                   	ret    

00801676 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801676:	55                   	push   %ebp
  801677:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801679:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167c:	8b 45 08             	mov    0x8(%ebp),%eax
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	52                   	push   %edx
  801686:	50                   	push   %eax
  801687:	6a 1d                	push   $0x1d
  801689:	e8 99 fc ff ff       	call   801327 <syscall>
  80168e:	83 c4 18             	add    $0x18,%esp
}
  801691:	c9                   	leave  
  801692:	c3                   	ret    

00801693 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801693:	55                   	push   %ebp
  801694:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801696:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801699:	8b 55 0c             	mov    0xc(%ebp),%edx
  80169c:	8b 45 08             	mov    0x8(%ebp),%eax
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	51                   	push   %ecx
  8016a4:	52                   	push   %edx
  8016a5:	50                   	push   %eax
  8016a6:	6a 1e                	push   $0x1e
  8016a8:	e8 7a fc ff ff       	call   801327 <syscall>
  8016ad:	83 c4 18             	add    $0x18,%esp
}
  8016b0:	c9                   	leave  
  8016b1:	c3                   	ret    

008016b2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016b2:	55                   	push   %ebp
  8016b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	52                   	push   %edx
  8016c2:	50                   	push   %eax
  8016c3:	6a 1f                	push   $0x1f
  8016c5:	e8 5d fc ff ff       	call   801327 <syscall>
  8016ca:	83 c4 18             	add    $0x18,%esp
}
  8016cd:	c9                   	leave  
  8016ce:	c3                   	ret    

008016cf <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 20                	push   $0x20
  8016de:	e8 44 fc ff ff       	call   801327 <syscall>
  8016e3:	83 c4 18             	add    $0x18,%esp
}
  8016e6:	c9                   	leave  
  8016e7:	c3                   	ret    

008016e8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016e8:	55                   	push   %ebp
  8016e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8016eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ee:	6a 00                	push   $0x0
  8016f0:	ff 75 14             	pushl  0x14(%ebp)
  8016f3:	ff 75 10             	pushl  0x10(%ebp)
  8016f6:	ff 75 0c             	pushl  0xc(%ebp)
  8016f9:	50                   	push   %eax
  8016fa:	6a 21                	push   $0x21
  8016fc:	e8 26 fc ff ff       	call   801327 <syscall>
  801701:	83 c4 18             	add    $0x18,%esp
}
  801704:	c9                   	leave  
  801705:	c3                   	ret    

00801706 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801706:	55                   	push   %ebp
  801707:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801709:	8b 45 08             	mov    0x8(%ebp),%eax
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	50                   	push   %eax
  801715:	6a 22                	push   $0x22
  801717:	e8 0b fc ff ff       	call   801327 <syscall>
  80171c:	83 c4 18             	add    $0x18,%esp
}
  80171f:	90                   	nop
  801720:	c9                   	leave  
  801721:	c3                   	ret    

00801722 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801722:	55                   	push   %ebp
  801723:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	50                   	push   %eax
  801731:	6a 23                	push   $0x23
  801733:	e8 ef fb ff ff       	call   801327 <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
}
  80173b:	90                   	nop
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
  801741:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801744:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801747:	8d 50 04             	lea    0x4(%eax),%edx
  80174a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	52                   	push   %edx
  801754:	50                   	push   %eax
  801755:	6a 24                	push   $0x24
  801757:	e8 cb fb ff ff       	call   801327 <syscall>
  80175c:	83 c4 18             	add    $0x18,%esp
	return result;
  80175f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801762:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801765:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801768:	89 01                	mov    %eax,(%ecx)
  80176a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	c9                   	leave  
  801771:	c2 04 00             	ret    $0x4

00801774 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801774:	55                   	push   %ebp
  801775:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	ff 75 10             	pushl  0x10(%ebp)
  80177e:	ff 75 0c             	pushl  0xc(%ebp)
  801781:	ff 75 08             	pushl  0x8(%ebp)
  801784:	6a 13                	push   $0x13
  801786:	e8 9c fb ff ff       	call   801327 <syscall>
  80178b:	83 c4 18             	add    $0x18,%esp
	return ;
  80178e:	90                   	nop
}
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <sys_rcr2>:
uint32 sys_rcr2()
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 25                	push   $0x25
  8017a0:	e8 82 fb ff ff       	call   801327 <syscall>
  8017a5:	83 c4 18             	add    $0x18,%esp
}
  8017a8:	c9                   	leave  
  8017a9:	c3                   	ret    

008017aa <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017aa:	55                   	push   %ebp
  8017ab:	89 e5                	mov    %esp,%ebp
  8017ad:	83 ec 04             	sub    $0x4,%esp
  8017b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017b6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	50                   	push   %eax
  8017c3:	6a 26                	push   $0x26
  8017c5:	e8 5d fb ff ff       	call   801327 <syscall>
  8017ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8017cd:	90                   	nop
}
  8017ce:	c9                   	leave  
  8017cf:	c3                   	ret    

008017d0 <rsttst>:
void rsttst()
{
  8017d0:	55                   	push   %ebp
  8017d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 28                	push   $0x28
  8017df:	e8 43 fb ff ff       	call   801327 <syscall>
  8017e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e7:	90                   	nop
}
  8017e8:	c9                   	leave  
  8017e9:	c3                   	ret    

008017ea <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017ea:	55                   	push   %ebp
  8017eb:	89 e5                	mov    %esp,%ebp
  8017ed:	83 ec 04             	sub    $0x4,%esp
  8017f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8017f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8017f6:	8b 55 18             	mov    0x18(%ebp),%edx
  8017f9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017fd:	52                   	push   %edx
  8017fe:	50                   	push   %eax
  8017ff:	ff 75 10             	pushl  0x10(%ebp)
  801802:	ff 75 0c             	pushl  0xc(%ebp)
  801805:	ff 75 08             	pushl  0x8(%ebp)
  801808:	6a 27                	push   $0x27
  80180a:	e8 18 fb ff ff       	call   801327 <syscall>
  80180f:	83 c4 18             	add    $0x18,%esp
	return ;
  801812:	90                   	nop
}
  801813:	c9                   	leave  
  801814:	c3                   	ret    

00801815 <chktst>:
void chktst(uint32 n)
{
  801815:	55                   	push   %ebp
  801816:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	ff 75 08             	pushl  0x8(%ebp)
  801823:	6a 29                	push   $0x29
  801825:	e8 fd fa ff ff       	call   801327 <syscall>
  80182a:	83 c4 18             	add    $0x18,%esp
	return ;
  80182d:	90                   	nop
}
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <inctst>:

void inctst()
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 2a                	push   $0x2a
  80183f:	e8 e3 fa ff ff       	call   801327 <syscall>
  801844:	83 c4 18             	add    $0x18,%esp
	return ;
  801847:	90                   	nop
}
  801848:	c9                   	leave  
  801849:	c3                   	ret    

0080184a <gettst>:
uint32 gettst()
{
  80184a:	55                   	push   %ebp
  80184b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 2b                	push   $0x2b
  801859:	e8 c9 fa ff ff       	call   801327 <syscall>
  80185e:	83 c4 18             	add    $0x18,%esp
}
  801861:	c9                   	leave  
  801862:	c3                   	ret    

00801863 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801863:	55                   	push   %ebp
  801864:	89 e5                	mov    %esp,%ebp
  801866:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 2c                	push   $0x2c
  801875:	e8 ad fa ff ff       	call   801327 <syscall>
  80187a:	83 c4 18             	add    $0x18,%esp
  80187d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801880:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801884:	75 07                	jne    80188d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801886:	b8 01 00 00 00       	mov    $0x1,%eax
  80188b:	eb 05                	jmp    801892 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80188d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801892:	c9                   	leave  
  801893:	c3                   	ret    

00801894 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801894:	55                   	push   %ebp
  801895:	89 e5                	mov    %esp,%ebp
  801897:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 2c                	push   $0x2c
  8018a6:	e8 7c fa ff ff       	call   801327 <syscall>
  8018ab:	83 c4 18             	add    $0x18,%esp
  8018ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018b1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018b5:	75 07                	jne    8018be <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018b7:	b8 01 00 00 00       	mov    $0x1,%eax
  8018bc:	eb 05                	jmp    8018c3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018be:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018c3:	c9                   	leave  
  8018c4:	c3                   	ret    

008018c5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
  8018c8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 2c                	push   $0x2c
  8018d7:	e8 4b fa ff ff       	call   801327 <syscall>
  8018dc:	83 c4 18             	add    $0x18,%esp
  8018df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018e2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018e6:	75 07                	jne    8018ef <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018e8:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ed:	eb 05                	jmp    8018f4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018f4:	c9                   	leave  
  8018f5:	c3                   	ret    

008018f6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8018f6:	55                   	push   %ebp
  8018f7:	89 e5                	mov    %esp,%ebp
  8018f9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 2c                	push   $0x2c
  801908:	e8 1a fa ff ff       	call   801327 <syscall>
  80190d:	83 c4 18             	add    $0x18,%esp
  801910:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801913:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801917:	75 07                	jne    801920 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801919:	b8 01 00 00 00       	mov    $0x1,%eax
  80191e:	eb 05                	jmp    801925 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801920:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801925:	c9                   	leave  
  801926:	c3                   	ret    

00801927 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	ff 75 08             	pushl  0x8(%ebp)
  801935:	6a 2d                	push   $0x2d
  801937:	e8 eb f9 ff ff       	call   801327 <syscall>
  80193c:	83 c4 18             	add    $0x18,%esp
	return ;
  80193f:	90                   	nop
}
  801940:	c9                   	leave  
  801941:	c3                   	ret    

00801942 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801942:	55                   	push   %ebp
  801943:	89 e5                	mov    %esp,%ebp
  801945:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801946:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801949:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80194c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80194f:	8b 45 08             	mov    0x8(%ebp),%eax
  801952:	6a 00                	push   $0x0
  801954:	53                   	push   %ebx
  801955:	51                   	push   %ecx
  801956:	52                   	push   %edx
  801957:	50                   	push   %eax
  801958:	6a 2e                	push   $0x2e
  80195a:	e8 c8 f9 ff ff       	call   801327 <syscall>
  80195f:	83 c4 18             	add    $0x18,%esp
}
  801962:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801965:	c9                   	leave  
  801966:	c3                   	ret    

00801967 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801967:	55                   	push   %ebp
  801968:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80196a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80196d:	8b 45 08             	mov    0x8(%ebp),%eax
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	52                   	push   %edx
  801977:	50                   	push   %eax
  801978:	6a 2f                	push   $0x2f
  80197a:	e8 a8 f9 ff ff       	call   801327 <syscall>
  80197f:	83 c4 18             	add    $0x18,%esp
}
  801982:	c9                   	leave  
  801983:	c3                   	ret    

00801984 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801984:	55                   	push   %ebp
  801985:	89 e5                	mov    %esp,%ebp
  801987:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80198a:	8b 55 08             	mov    0x8(%ebp),%edx
  80198d:	89 d0                	mov    %edx,%eax
  80198f:	c1 e0 02             	shl    $0x2,%eax
  801992:	01 d0                	add    %edx,%eax
  801994:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80199b:	01 d0                	add    %edx,%eax
  80199d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a4:	01 d0                	add    %edx,%eax
  8019a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019ad:	01 d0                	add    %edx,%eax
  8019af:	c1 e0 04             	shl    $0x4,%eax
  8019b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8019b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8019bc:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8019bf:	83 ec 0c             	sub    $0xc,%esp
  8019c2:	50                   	push   %eax
  8019c3:	e8 76 fd ff ff       	call   80173e <sys_get_virtual_time>
  8019c8:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8019cb:	eb 41                	jmp    801a0e <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8019cd:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8019d0:	83 ec 0c             	sub    $0xc,%esp
  8019d3:	50                   	push   %eax
  8019d4:	e8 65 fd ff ff       	call   80173e <sys_get_virtual_time>
  8019d9:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8019dc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019df:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019e2:	29 c2                	sub    %eax,%edx
  8019e4:	89 d0                	mov    %edx,%eax
  8019e6:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8019e9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8019ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019ef:	89 d1                	mov    %edx,%ecx
  8019f1:	29 c1                	sub    %eax,%ecx
  8019f3:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8019f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019f9:	39 c2                	cmp    %eax,%edx
  8019fb:	0f 97 c0             	seta   %al
  8019fe:	0f b6 c0             	movzbl %al,%eax
  801a01:	29 c1                	sub    %eax,%ecx
  801a03:	89 c8                	mov    %ecx,%eax
  801a05:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801a08:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a11:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a14:	72 b7                	jb     8019cd <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a16:	90                   	nop
  801a17:	c9                   	leave  
  801a18:	c3                   	ret    

00801a19 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
  801a1c:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801a1f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801a26:	eb 03                	jmp    801a2b <busy_wait+0x12>
  801a28:	ff 45 fc             	incl   -0x4(%ebp)
  801a2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a2e:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a31:	72 f5                	jb     801a28 <busy_wait+0xf>
	return i;
  801a33:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801a36:	c9                   	leave  
  801a37:	c3                   	ret    

00801a38 <__udivdi3>:
  801a38:	55                   	push   %ebp
  801a39:	57                   	push   %edi
  801a3a:	56                   	push   %esi
  801a3b:	53                   	push   %ebx
  801a3c:	83 ec 1c             	sub    $0x1c,%esp
  801a3f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a43:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a47:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a4b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a4f:	89 ca                	mov    %ecx,%edx
  801a51:	89 f8                	mov    %edi,%eax
  801a53:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a57:	85 f6                	test   %esi,%esi
  801a59:	75 2d                	jne    801a88 <__udivdi3+0x50>
  801a5b:	39 cf                	cmp    %ecx,%edi
  801a5d:	77 65                	ja     801ac4 <__udivdi3+0x8c>
  801a5f:	89 fd                	mov    %edi,%ebp
  801a61:	85 ff                	test   %edi,%edi
  801a63:	75 0b                	jne    801a70 <__udivdi3+0x38>
  801a65:	b8 01 00 00 00       	mov    $0x1,%eax
  801a6a:	31 d2                	xor    %edx,%edx
  801a6c:	f7 f7                	div    %edi
  801a6e:	89 c5                	mov    %eax,%ebp
  801a70:	31 d2                	xor    %edx,%edx
  801a72:	89 c8                	mov    %ecx,%eax
  801a74:	f7 f5                	div    %ebp
  801a76:	89 c1                	mov    %eax,%ecx
  801a78:	89 d8                	mov    %ebx,%eax
  801a7a:	f7 f5                	div    %ebp
  801a7c:	89 cf                	mov    %ecx,%edi
  801a7e:	89 fa                	mov    %edi,%edx
  801a80:	83 c4 1c             	add    $0x1c,%esp
  801a83:	5b                   	pop    %ebx
  801a84:	5e                   	pop    %esi
  801a85:	5f                   	pop    %edi
  801a86:	5d                   	pop    %ebp
  801a87:	c3                   	ret    
  801a88:	39 ce                	cmp    %ecx,%esi
  801a8a:	77 28                	ja     801ab4 <__udivdi3+0x7c>
  801a8c:	0f bd fe             	bsr    %esi,%edi
  801a8f:	83 f7 1f             	xor    $0x1f,%edi
  801a92:	75 40                	jne    801ad4 <__udivdi3+0x9c>
  801a94:	39 ce                	cmp    %ecx,%esi
  801a96:	72 0a                	jb     801aa2 <__udivdi3+0x6a>
  801a98:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a9c:	0f 87 9e 00 00 00    	ja     801b40 <__udivdi3+0x108>
  801aa2:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa7:	89 fa                	mov    %edi,%edx
  801aa9:	83 c4 1c             	add    $0x1c,%esp
  801aac:	5b                   	pop    %ebx
  801aad:	5e                   	pop    %esi
  801aae:	5f                   	pop    %edi
  801aaf:	5d                   	pop    %ebp
  801ab0:	c3                   	ret    
  801ab1:	8d 76 00             	lea    0x0(%esi),%esi
  801ab4:	31 ff                	xor    %edi,%edi
  801ab6:	31 c0                	xor    %eax,%eax
  801ab8:	89 fa                	mov    %edi,%edx
  801aba:	83 c4 1c             	add    $0x1c,%esp
  801abd:	5b                   	pop    %ebx
  801abe:	5e                   	pop    %esi
  801abf:	5f                   	pop    %edi
  801ac0:	5d                   	pop    %ebp
  801ac1:	c3                   	ret    
  801ac2:	66 90                	xchg   %ax,%ax
  801ac4:	89 d8                	mov    %ebx,%eax
  801ac6:	f7 f7                	div    %edi
  801ac8:	31 ff                	xor    %edi,%edi
  801aca:	89 fa                	mov    %edi,%edx
  801acc:	83 c4 1c             	add    $0x1c,%esp
  801acf:	5b                   	pop    %ebx
  801ad0:	5e                   	pop    %esi
  801ad1:	5f                   	pop    %edi
  801ad2:	5d                   	pop    %ebp
  801ad3:	c3                   	ret    
  801ad4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ad9:	89 eb                	mov    %ebp,%ebx
  801adb:	29 fb                	sub    %edi,%ebx
  801add:	89 f9                	mov    %edi,%ecx
  801adf:	d3 e6                	shl    %cl,%esi
  801ae1:	89 c5                	mov    %eax,%ebp
  801ae3:	88 d9                	mov    %bl,%cl
  801ae5:	d3 ed                	shr    %cl,%ebp
  801ae7:	89 e9                	mov    %ebp,%ecx
  801ae9:	09 f1                	or     %esi,%ecx
  801aeb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801aef:	89 f9                	mov    %edi,%ecx
  801af1:	d3 e0                	shl    %cl,%eax
  801af3:	89 c5                	mov    %eax,%ebp
  801af5:	89 d6                	mov    %edx,%esi
  801af7:	88 d9                	mov    %bl,%cl
  801af9:	d3 ee                	shr    %cl,%esi
  801afb:	89 f9                	mov    %edi,%ecx
  801afd:	d3 e2                	shl    %cl,%edx
  801aff:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b03:	88 d9                	mov    %bl,%cl
  801b05:	d3 e8                	shr    %cl,%eax
  801b07:	09 c2                	or     %eax,%edx
  801b09:	89 d0                	mov    %edx,%eax
  801b0b:	89 f2                	mov    %esi,%edx
  801b0d:	f7 74 24 0c          	divl   0xc(%esp)
  801b11:	89 d6                	mov    %edx,%esi
  801b13:	89 c3                	mov    %eax,%ebx
  801b15:	f7 e5                	mul    %ebp
  801b17:	39 d6                	cmp    %edx,%esi
  801b19:	72 19                	jb     801b34 <__udivdi3+0xfc>
  801b1b:	74 0b                	je     801b28 <__udivdi3+0xf0>
  801b1d:	89 d8                	mov    %ebx,%eax
  801b1f:	31 ff                	xor    %edi,%edi
  801b21:	e9 58 ff ff ff       	jmp    801a7e <__udivdi3+0x46>
  801b26:	66 90                	xchg   %ax,%ax
  801b28:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b2c:	89 f9                	mov    %edi,%ecx
  801b2e:	d3 e2                	shl    %cl,%edx
  801b30:	39 c2                	cmp    %eax,%edx
  801b32:	73 e9                	jae    801b1d <__udivdi3+0xe5>
  801b34:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b37:	31 ff                	xor    %edi,%edi
  801b39:	e9 40 ff ff ff       	jmp    801a7e <__udivdi3+0x46>
  801b3e:	66 90                	xchg   %ax,%ax
  801b40:	31 c0                	xor    %eax,%eax
  801b42:	e9 37 ff ff ff       	jmp    801a7e <__udivdi3+0x46>
  801b47:	90                   	nop

00801b48 <__umoddi3>:
  801b48:	55                   	push   %ebp
  801b49:	57                   	push   %edi
  801b4a:	56                   	push   %esi
  801b4b:	53                   	push   %ebx
  801b4c:	83 ec 1c             	sub    $0x1c,%esp
  801b4f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b53:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b57:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b5b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b5f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b63:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b67:	89 f3                	mov    %esi,%ebx
  801b69:	89 fa                	mov    %edi,%edx
  801b6b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b6f:	89 34 24             	mov    %esi,(%esp)
  801b72:	85 c0                	test   %eax,%eax
  801b74:	75 1a                	jne    801b90 <__umoddi3+0x48>
  801b76:	39 f7                	cmp    %esi,%edi
  801b78:	0f 86 a2 00 00 00    	jbe    801c20 <__umoddi3+0xd8>
  801b7e:	89 c8                	mov    %ecx,%eax
  801b80:	89 f2                	mov    %esi,%edx
  801b82:	f7 f7                	div    %edi
  801b84:	89 d0                	mov    %edx,%eax
  801b86:	31 d2                	xor    %edx,%edx
  801b88:	83 c4 1c             	add    $0x1c,%esp
  801b8b:	5b                   	pop    %ebx
  801b8c:	5e                   	pop    %esi
  801b8d:	5f                   	pop    %edi
  801b8e:	5d                   	pop    %ebp
  801b8f:	c3                   	ret    
  801b90:	39 f0                	cmp    %esi,%eax
  801b92:	0f 87 ac 00 00 00    	ja     801c44 <__umoddi3+0xfc>
  801b98:	0f bd e8             	bsr    %eax,%ebp
  801b9b:	83 f5 1f             	xor    $0x1f,%ebp
  801b9e:	0f 84 ac 00 00 00    	je     801c50 <__umoddi3+0x108>
  801ba4:	bf 20 00 00 00       	mov    $0x20,%edi
  801ba9:	29 ef                	sub    %ebp,%edi
  801bab:	89 fe                	mov    %edi,%esi
  801bad:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bb1:	89 e9                	mov    %ebp,%ecx
  801bb3:	d3 e0                	shl    %cl,%eax
  801bb5:	89 d7                	mov    %edx,%edi
  801bb7:	89 f1                	mov    %esi,%ecx
  801bb9:	d3 ef                	shr    %cl,%edi
  801bbb:	09 c7                	or     %eax,%edi
  801bbd:	89 e9                	mov    %ebp,%ecx
  801bbf:	d3 e2                	shl    %cl,%edx
  801bc1:	89 14 24             	mov    %edx,(%esp)
  801bc4:	89 d8                	mov    %ebx,%eax
  801bc6:	d3 e0                	shl    %cl,%eax
  801bc8:	89 c2                	mov    %eax,%edx
  801bca:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bce:	d3 e0                	shl    %cl,%eax
  801bd0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bd4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bd8:	89 f1                	mov    %esi,%ecx
  801bda:	d3 e8                	shr    %cl,%eax
  801bdc:	09 d0                	or     %edx,%eax
  801bde:	d3 eb                	shr    %cl,%ebx
  801be0:	89 da                	mov    %ebx,%edx
  801be2:	f7 f7                	div    %edi
  801be4:	89 d3                	mov    %edx,%ebx
  801be6:	f7 24 24             	mull   (%esp)
  801be9:	89 c6                	mov    %eax,%esi
  801beb:	89 d1                	mov    %edx,%ecx
  801bed:	39 d3                	cmp    %edx,%ebx
  801bef:	0f 82 87 00 00 00    	jb     801c7c <__umoddi3+0x134>
  801bf5:	0f 84 91 00 00 00    	je     801c8c <__umoddi3+0x144>
  801bfb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bff:	29 f2                	sub    %esi,%edx
  801c01:	19 cb                	sbb    %ecx,%ebx
  801c03:	89 d8                	mov    %ebx,%eax
  801c05:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c09:	d3 e0                	shl    %cl,%eax
  801c0b:	89 e9                	mov    %ebp,%ecx
  801c0d:	d3 ea                	shr    %cl,%edx
  801c0f:	09 d0                	or     %edx,%eax
  801c11:	89 e9                	mov    %ebp,%ecx
  801c13:	d3 eb                	shr    %cl,%ebx
  801c15:	89 da                	mov    %ebx,%edx
  801c17:	83 c4 1c             	add    $0x1c,%esp
  801c1a:	5b                   	pop    %ebx
  801c1b:	5e                   	pop    %esi
  801c1c:	5f                   	pop    %edi
  801c1d:	5d                   	pop    %ebp
  801c1e:	c3                   	ret    
  801c1f:	90                   	nop
  801c20:	89 fd                	mov    %edi,%ebp
  801c22:	85 ff                	test   %edi,%edi
  801c24:	75 0b                	jne    801c31 <__umoddi3+0xe9>
  801c26:	b8 01 00 00 00       	mov    $0x1,%eax
  801c2b:	31 d2                	xor    %edx,%edx
  801c2d:	f7 f7                	div    %edi
  801c2f:	89 c5                	mov    %eax,%ebp
  801c31:	89 f0                	mov    %esi,%eax
  801c33:	31 d2                	xor    %edx,%edx
  801c35:	f7 f5                	div    %ebp
  801c37:	89 c8                	mov    %ecx,%eax
  801c39:	f7 f5                	div    %ebp
  801c3b:	89 d0                	mov    %edx,%eax
  801c3d:	e9 44 ff ff ff       	jmp    801b86 <__umoddi3+0x3e>
  801c42:	66 90                	xchg   %ax,%ax
  801c44:	89 c8                	mov    %ecx,%eax
  801c46:	89 f2                	mov    %esi,%edx
  801c48:	83 c4 1c             	add    $0x1c,%esp
  801c4b:	5b                   	pop    %ebx
  801c4c:	5e                   	pop    %esi
  801c4d:	5f                   	pop    %edi
  801c4e:	5d                   	pop    %ebp
  801c4f:	c3                   	ret    
  801c50:	3b 04 24             	cmp    (%esp),%eax
  801c53:	72 06                	jb     801c5b <__umoddi3+0x113>
  801c55:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c59:	77 0f                	ja     801c6a <__umoddi3+0x122>
  801c5b:	89 f2                	mov    %esi,%edx
  801c5d:	29 f9                	sub    %edi,%ecx
  801c5f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c63:	89 14 24             	mov    %edx,(%esp)
  801c66:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c6a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c6e:	8b 14 24             	mov    (%esp),%edx
  801c71:	83 c4 1c             	add    $0x1c,%esp
  801c74:	5b                   	pop    %ebx
  801c75:	5e                   	pop    %esi
  801c76:	5f                   	pop    %edi
  801c77:	5d                   	pop    %ebp
  801c78:	c3                   	ret    
  801c79:	8d 76 00             	lea    0x0(%esi),%esi
  801c7c:	2b 04 24             	sub    (%esp),%eax
  801c7f:	19 fa                	sbb    %edi,%edx
  801c81:	89 d1                	mov    %edx,%ecx
  801c83:	89 c6                	mov    %eax,%esi
  801c85:	e9 71 ff ff ff       	jmp    801bfb <__umoddi3+0xb3>
  801c8a:	66 90                	xchg   %ax,%ax
  801c8c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c90:	72 ea                	jb     801c7c <__umoddi3+0x134>
  801c92:	89 d9                	mov    %ebx,%ecx
  801c94:	e9 62 ff ff ff       	jmp    801bfb <__umoddi3+0xb3>

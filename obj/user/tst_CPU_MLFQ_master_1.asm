
obj/user/tst_CPU_MLFQ_master_1:     file format elf32-i386


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
  800031:	e8 8a 01 00 00       	call   8001c0 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	// For EXIT
	int ID = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800049:	a1 20 30 80 00       	mov    0x803020,%eax
  80004e:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800054:	89 c1                	mov    %eax,%ecx
  800056:	a1 20 30 80 00       	mov    0x803020,%eax
  80005b:	8b 40 74             	mov    0x74(%eax),%eax
  80005e:	52                   	push   %edx
  80005f:	51                   	push   %ecx
  800060:	50                   	push   %eax
  800061:	68 c0 1c 80 00       	push   $0x801cc0
  800066:	e8 87 16 00 00       	call   8016f2 <sys_create_env>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 f0             	pushl  -0x10(%ebp)
  800077:	e8 94 16 00 00       	call   801710 <sys_run_env>
  80007c:	83 c4 10             	add    $0x10,%esp
	ID = sys_create_env("fos_add", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  80007f:	a1 20 30 80 00       	mov    0x803020,%eax
  800084:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80008a:	a1 20 30 80 00       	mov    0x803020,%eax
  80008f:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800095:	89 c1                	mov    %eax,%ecx
  800097:	a1 20 30 80 00       	mov    0x803020,%eax
  80009c:	8b 40 74             	mov    0x74(%eax),%eax
  80009f:	52                   	push   %edx
  8000a0:	51                   	push   %ecx
  8000a1:	50                   	push   %eax
  8000a2:	68 cf 1c 80 00       	push   $0x801ccf
  8000a7:	e8 46 16 00 00       	call   8016f2 <sys_create_env>
  8000ac:	83 c4 10             	add    $0x10,%esp
  8000af:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b8:	e8 53 16 00 00       	call   801710 <sys_run_env>
  8000bd:	83 c4 10             	add    $0x10,%esp
	//============

	for (int i = 0; i < 3; ++i) {
  8000c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000c7:	eb 5e                	jmp    800127 <_main+0xef>
			ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ce:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d9:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000df:	89 c1                	mov    %eax,%ecx
  8000e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e6:	8b 40 74             	mov    0x74(%eax),%eax
  8000e9:	52                   	push   %edx
  8000ea:	51                   	push   %ecx
  8000eb:	50                   	push   %eax
  8000ec:	68 d7 1c 80 00       	push   $0x801cd7
  8000f1:	e8 fc 15 00 00       	call   8016f2 <sys_create_env>
  8000f6:	83 c4 10             	add    $0x10,%esp
  8000f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
			if (ID == E_ENV_CREATION_ERROR)
  8000fc:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  800100:	75 14                	jne    800116 <_main+0xde>
				panic("RUNNING OUT OF ENV!! terminating...");
  800102:	83 ec 04             	sub    $0x4,%esp
  800105:	68 e8 1c 80 00       	push   $0x801ce8
  80010a:	6a 0f                	push   $0xf
  80010c:	68 0c 1d 80 00       	push   $0x801d0c
  800111:	e8 ef 01 00 00       	call   800305 <_panic>
			sys_run_env(ID);
  800116:	83 ec 0c             	sub    $0xc,%esp
  800119:	ff 75 f0             	pushl  -0x10(%ebp)
  80011c:	e8 ef 15 00 00       	call   801710 <sys_run_env>
  800121:	83 c4 10             	add    $0x10,%esp
	sys_run_env(ID);
	ID = sys_create_env("fos_add", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(ID);
	//============

	for (int i = 0; i < 3; ++i) {
  800124:	ff 45 f4             	incl   -0xc(%ebp)
  800127:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  80012b:	7e 9c                	jle    8000c9 <_main+0x91>
			ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
			if (ID == E_ENV_CREATION_ERROR)
				panic("RUNNING OUT OF ENV!! terminating...");
			sys_run_env(ID);
		}
	env_sleep(10000);
  80012d:	83 ec 0c             	sub    $0xc,%esp
  800130:	68 10 27 00 00       	push   $0x2710
  800135:	e8 54 18 00 00       	call   80198e <env_sleep>
  80013a:	83 c4 10             	add    $0x10,%esp

	ID = sys_create_env("cpuMLFQ1Slave_1", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  80013d:	a1 20 30 80 00       	mov    0x803020,%eax
  800142:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800148:	a1 20 30 80 00       	mov    0x803020,%eax
  80014d:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800153:	89 c1                	mov    %eax,%ecx
  800155:	a1 20 30 80 00       	mov    0x803020,%eax
  80015a:	8b 40 74             	mov    0x74(%eax),%eax
  80015d:	52                   	push   %edx
  80015e:	51                   	push   %ecx
  80015f:	50                   	push   %eax
  800160:	68 29 1d 80 00       	push   $0x801d29
  800165:	e8 88 15 00 00       	call   8016f2 <sys_create_env>
  80016a:	83 c4 10             	add    $0x10,%esp
  80016d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (ID == E_ENV_CREATION_ERROR)
  800170:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  800174:	75 14                	jne    80018a <_main+0x152>
		panic("RUNNING OUT OF ENV!! terminating...");
  800176:	83 ec 04             	sub    $0x4,%esp
  800179:	68 e8 1c 80 00       	push   $0x801ce8
  80017e:	6a 16                	push   $0x16
  800180:	68 0c 1d 80 00       	push   $0x801d0c
  800185:	e8 7b 01 00 00       	call   800305 <_panic>
	sys_run_env(ID);
  80018a:	83 ec 0c             	sub    $0xc,%esp
  80018d:	ff 75 f0             	pushl  -0x10(%ebp)
  800190:	e8 7b 15 00 00       	call   801710 <sys_run_env>
  800195:	83 c4 10             	add    $0x10,%esp

	// To wait till other queues filled with other processes
	env_sleep(10000);
  800198:	83 ec 0c             	sub    $0xc,%esp
  80019b:	68 10 27 00 00       	push   $0x2710
  8001a0:	e8 e9 17 00 00       	call   80198e <env_sleep>
  8001a5:	83 c4 10             	add    $0x10,%esp


	// To check that the slave environments completed successfully
	rsttst();
  8001a8:	e8 2d 16 00 00       	call   8017da <rsttst>

	env_sleep(200);
  8001ad:	83 ec 0c             	sub    $0xc,%esp
  8001b0:	68 c8 00 00 00       	push   $0xc8
  8001b5:	e8 d4 17 00 00       	call   80198e <env_sleep>
  8001ba:	83 c4 10             	add    $0x10,%esp
}
  8001bd:	90                   	nop
  8001be:	c9                   	leave  
  8001bf:	c3                   	ret    

008001c0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001c0:	55                   	push   %ebp
  8001c1:	89 e5                	mov    %esp,%ebp
  8001c3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001c6:	e8 07 12 00 00       	call   8013d2 <sys_getenvindex>
  8001cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001d1:	89 d0                	mov    %edx,%eax
  8001d3:	c1 e0 03             	shl    $0x3,%eax
  8001d6:	01 d0                	add    %edx,%eax
  8001d8:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001df:	01 c8                	add    %ecx,%eax
  8001e1:	01 c0                	add    %eax,%eax
  8001e3:	01 d0                	add    %edx,%eax
  8001e5:	01 c0                	add    %eax,%eax
  8001e7:	01 d0                	add    %edx,%eax
  8001e9:	89 c2                	mov    %eax,%edx
  8001eb:	c1 e2 05             	shl    $0x5,%edx
  8001ee:	29 c2                	sub    %eax,%edx
  8001f0:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001f7:	89 c2                	mov    %eax,%edx
  8001f9:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001ff:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800204:	a1 20 30 80 00       	mov    0x803020,%eax
  800209:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80020f:	84 c0                	test   %al,%al
  800211:	74 0f                	je     800222 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800213:	a1 20 30 80 00       	mov    0x803020,%eax
  800218:	05 40 3c 01 00       	add    $0x13c40,%eax
  80021d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800222:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800226:	7e 0a                	jle    800232 <libmain+0x72>
		binaryname = argv[0];
  800228:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022b:	8b 00                	mov    (%eax),%eax
  80022d:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800232:	83 ec 08             	sub    $0x8,%esp
  800235:	ff 75 0c             	pushl  0xc(%ebp)
  800238:	ff 75 08             	pushl  0x8(%ebp)
  80023b:	e8 f8 fd ff ff       	call   800038 <_main>
  800240:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800243:	e8 25 13 00 00       	call   80156d <sys_disable_interrupt>
	cprintf("**************************************\n");
  800248:	83 ec 0c             	sub    $0xc,%esp
  80024b:	68 54 1d 80 00       	push   $0x801d54
  800250:	e8 52 03 00 00       	call   8005a7 <cprintf>
  800255:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800258:	a1 20 30 80 00       	mov    0x803020,%eax
  80025d:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800263:	a1 20 30 80 00       	mov    0x803020,%eax
  800268:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80026e:	83 ec 04             	sub    $0x4,%esp
  800271:	52                   	push   %edx
  800272:	50                   	push   %eax
  800273:	68 7c 1d 80 00       	push   $0x801d7c
  800278:	e8 2a 03 00 00       	call   8005a7 <cprintf>
  80027d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800280:	a1 20 30 80 00       	mov    0x803020,%eax
  800285:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80028b:	a1 20 30 80 00       	mov    0x803020,%eax
  800290:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800296:	83 ec 04             	sub    $0x4,%esp
  800299:	52                   	push   %edx
  80029a:	50                   	push   %eax
  80029b:	68 a4 1d 80 00       	push   $0x801da4
  8002a0:	e8 02 03 00 00       	call   8005a7 <cprintf>
  8002a5:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ad:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002b3:	83 ec 08             	sub    $0x8,%esp
  8002b6:	50                   	push   %eax
  8002b7:	68 e5 1d 80 00       	push   $0x801de5
  8002bc:	e8 e6 02 00 00       	call   8005a7 <cprintf>
  8002c1:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002c4:	83 ec 0c             	sub    $0xc,%esp
  8002c7:	68 54 1d 80 00       	push   $0x801d54
  8002cc:	e8 d6 02 00 00       	call   8005a7 <cprintf>
  8002d1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002d4:	e8 ae 12 00 00       	call   801587 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002d9:	e8 19 00 00 00       	call   8002f7 <exit>
}
  8002de:	90                   	nop
  8002df:	c9                   	leave  
  8002e0:	c3                   	ret    

008002e1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002e1:	55                   	push   %ebp
  8002e2:	89 e5                	mov    %esp,%ebp
  8002e4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002e7:	83 ec 0c             	sub    $0xc,%esp
  8002ea:	6a 00                	push   $0x0
  8002ec:	e8 ad 10 00 00       	call   80139e <sys_env_destroy>
  8002f1:	83 c4 10             	add    $0x10,%esp
}
  8002f4:	90                   	nop
  8002f5:	c9                   	leave  
  8002f6:	c3                   	ret    

008002f7 <exit>:

void
exit(void)
{
  8002f7:	55                   	push   %ebp
  8002f8:	89 e5                	mov    %esp,%ebp
  8002fa:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002fd:	e8 02 11 00 00       	call   801404 <sys_env_exit>
}
  800302:	90                   	nop
  800303:	c9                   	leave  
  800304:	c3                   	ret    

00800305 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800305:	55                   	push   %ebp
  800306:	89 e5                	mov    %esp,%ebp
  800308:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80030b:	8d 45 10             	lea    0x10(%ebp),%eax
  80030e:	83 c0 04             	add    $0x4,%eax
  800311:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800314:	a1 18 31 80 00       	mov    0x803118,%eax
  800319:	85 c0                	test   %eax,%eax
  80031b:	74 16                	je     800333 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80031d:	a1 18 31 80 00       	mov    0x803118,%eax
  800322:	83 ec 08             	sub    $0x8,%esp
  800325:	50                   	push   %eax
  800326:	68 fc 1d 80 00       	push   $0x801dfc
  80032b:	e8 77 02 00 00       	call   8005a7 <cprintf>
  800330:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800333:	a1 00 30 80 00       	mov    0x803000,%eax
  800338:	ff 75 0c             	pushl  0xc(%ebp)
  80033b:	ff 75 08             	pushl  0x8(%ebp)
  80033e:	50                   	push   %eax
  80033f:	68 01 1e 80 00       	push   $0x801e01
  800344:	e8 5e 02 00 00       	call   8005a7 <cprintf>
  800349:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80034c:	8b 45 10             	mov    0x10(%ebp),%eax
  80034f:	83 ec 08             	sub    $0x8,%esp
  800352:	ff 75 f4             	pushl  -0xc(%ebp)
  800355:	50                   	push   %eax
  800356:	e8 e1 01 00 00       	call   80053c <vcprintf>
  80035b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80035e:	83 ec 08             	sub    $0x8,%esp
  800361:	6a 00                	push   $0x0
  800363:	68 1d 1e 80 00       	push   $0x801e1d
  800368:	e8 cf 01 00 00       	call   80053c <vcprintf>
  80036d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800370:	e8 82 ff ff ff       	call   8002f7 <exit>

	// should not return here
	while (1) ;
  800375:	eb fe                	jmp    800375 <_panic+0x70>

00800377 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800377:	55                   	push   %ebp
  800378:	89 e5                	mov    %esp,%ebp
  80037a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80037d:	a1 20 30 80 00       	mov    0x803020,%eax
  800382:	8b 50 74             	mov    0x74(%eax),%edx
  800385:	8b 45 0c             	mov    0xc(%ebp),%eax
  800388:	39 c2                	cmp    %eax,%edx
  80038a:	74 14                	je     8003a0 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80038c:	83 ec 04             	sub    $0x4,%esp
  80038f:	68 20 1e 80 00       	push   $0x801e20
  800394:	6a 26                	push   $0x26
  800396:	68 6c 1e 80 00       	push   $0x801e6c
  80039b:	e8 65 ff ff ff       	call   800305 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003a7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003ae:	e9 b6 00 00 00       	jmp    800469 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8003b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c0:	01 d0                	add    %edx,%eax
  8003c2:	8b 00                	mov    (%eax),%eax
  8003c4:	85 c0                	test   %eax,%eax
  8003c6:	75 08                	jne    8003d0 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003c8:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003cb:	e9 96 00 00 00       	jmp    800466 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003d0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003d7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003de:	eb 5d                	jmp    80043d <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003eb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003ee:	c1 e2 04             	shl    $0x4,%edx
  8003f1:	01 d0                	add    %edx,%eax
  8003f3:	8a 40 04             	mov    0x4(%eax),%al
  8003f6:	84 c0                	test   %al,%al
  8003f8:	75 40                	jne    80043a <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ff:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800405:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800408:	c1 e2 04             	shl    $0x4,%edx
  80040b:	01 d0                	add    %edx,%eax
  80040d:	8b 00                	mov    (%eax),%eax
  80040f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800412:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800415:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80041a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80041c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80041f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	01 c8                	add    %ecx,%eax
  80042b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80042d:	39 c2                	cmp    %eax,%edx
  80042f:	75 09                	jne    80043a <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800431:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800438:	eb 12                	jmp    80044c <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80043a:	ff 45 e8             	incl   -0x18(%ebp)
  80043d:	a1 20 30 80 00       	mov    0x803020,%eax
  800442:	8b 50 74             	mov    0x74(%eax),%edx
  800445:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800448:	39 c2                	cmp    %eax,%edx
  80044a:	77 94                	ja     8003e0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80044c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800450:	75 14                	jne    800466 <CheckWSWithoutLastIndex+0xef>
			panic(
  800452:	83 ec 04             	sub    $0x4,%esp
  800455:	68 78 1e 80 00       	push   $0x801e78
  80045a:	6a 3a                	push   $0x3a
  80045c:	68 6c 1e 80 00       	push   $0x801e6c
  800461:	e8 9f fe ff ff       	call   800305 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800466:	ff 45 f0             	incl   -0x10(%ebp)
  800469:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80046c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80046f:	0f 8c 3e ff ff ff    	jl     8003b3 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800475:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80047c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800483:	eb 20                	jmp    8004a5 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800485:	a1 20 30 80 00       	mov    0x803020,%eax
  80048a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800490:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800493:	c1 e2 04             	shl    $0x4,%edx
  800496:	01 d0                	add    %edx,%eax
  800498:	8a 40 04             	mov    0x4(%eax),%al
  80049b:	3c 01                	cmp    $0x1,%al
  80049d:	75 03                	jne    8004a2 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80049f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004a2:	ff 45 e0             	incl   -0x20(%ebp)
  8004a5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004aa:	8b 50 74             	mov    0x74(%eax),%edx
  8004ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004b0:	39 c2                	cmp    %eax,%edx
  8004b2:	77 d1                	ja     800485 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004b7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004ba:	74 14                	je     8004d0 <CheckWSWithoutLastIndex+0x159>
		panic(
  8004bc:	83 ec 04             	sub    $0x4,%esp
  8004bf:	68 cc 1e 80 00       	push   $0x801ecc
  8004c4:	6a 44                	push   $0x44
  8004c6:	68 6c 1e 80 00       	push   $0x801e6c
  8004cb:	e8 35 fe ff ff       	call   800305 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004d0:	90                   	nop
  8004d1:	c9                   	leave  
  8004d2:	c3                   	ret    

008004d3 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004d3:	55                   	push   %ebp
  8004d4:	89 e5                	mov    %esp,%ebp
  8004d6:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004dc:	8b 00                	mov    (%eax),%eax
  8004de:	8d 48 01             	lea    0x1(%eax),%ecx
  8004e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004e4:	89 0a                	mov    %ecx,(%edx)
  8004e6:	8b 55 08             	mov    0x8(%ebp),%edx
  8004e9:	88 d1                	mov    %dl,%cl
  8004eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004ee:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f5:	8b 00                	mov    (%eax),%eax
  8004f7:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004fc:	75 2c                	jne    80052a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004fe:	a0 24 30 80 00       	mov    0x803024,%al
  800503:	0f b6 c0             	movzbl %al,%eax
  800506:	8b 55 0c             	mov    0xc(%ebp),%edx
  800509:	8b 12                	mov    (%edx),%edx
  80050b:	89 d1                	mov    %edx,%ecx
  80050d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800510:	83 c2 08             	add    $0x8,%edx
  800513:	83 ec 04             	sub    $0x4,%esp
  800516:	50                   	push   %eax
  800517:	51                   	push   %ecx
  800518:	52                   	push   %edx
  800519:	e8 3e 0e 00 00       	call   80135c <sys_cputs>
  80051e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800521:	8b 45 0c             	mov    0xc(%ebp),%eax
  800524:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80052a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052d:	8b 40 04             	mov    0x4(%eax),%eax
  800530:	8d 50 01             	lea    0x1(%eax),%edx
  800533:	8b 45 0c             	mov    0xc(%ebp),%eax
  800536:	89 50 04             	mov    %edx,0x4(%eax)
}
  800539:	90                   	nop
  80053a:	c9                   	leave  
  80053b:	c3                   	ret    

0080053c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80053c:	55                   	push   %ebp
  80053d:	89 e5                	mov    %esp,%ebp
  80053f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800545:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80054c:	00 00 00 
	b.cnt = 0;
  80054f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800556:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800559:	ff 75 0c             	pushl  0xc(%ebp)
  80055c:	ff 75 08             	pushl  0x8(%ebp)
  80055f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800565:	50                   	push   %eax
  800566:	68 d3 04 80 00       	push   $0x8004d3
  80056b:	e8 11 02 00 00       	call   800781 <vprintfmt>
  800570:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800573:	a0 24 30 80 00       	mov    0x803024,%al
  800578:	0f b6 c0             	movzbl %al,%eax
  80057b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800581:	83 ec 04             	sub    $0x4,%esp
  800584:	50                   	push   %eax
  800585:	52                   	push   %edx
  800586:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80058c:	83 c0 08             	add    $0x8,%eax
  80058f:	50                   	push   %eax
  800590:	e8 c7 0d 00 00       	call   80135c <sys_cputs>
  800595:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800598:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80059f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005a5:	c9                   	leave  
  8005a6:	c3                   	ret    

008005a7 <cprintf>:

int cprintf(const char *fmt, ...) {
  8005a7:	55                   	push   %ebp
  8005a8:	89 e5                	mov    %esp,%ebp
  8005aa:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005ad:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005b4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bd:	83 ec 08             	sub    $0x8,%esp
  8005c0:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c3:	50                   	push   %eax
  8005c4:	e8 73 ff ff ff       	call   80053c <vcprintf>
  8005c9:	83 c4 10             	add    $0x10,%esp
  8005cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005d2:	c9                   	leave  
  8005d3:	c3                   	ret    

008005d4 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005d4:	55                   	push   %ebp
  8005d5:	89 e5                	mov    %esp,%ebp
  8005d7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005da:	e8 8e 0f 00 00       	call   80156d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005df:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e8:	83 ec 08             	sub    $0x8,%esp
  8005eb:	ff 75 f4             	pushl  -0xc(%ebp)
  8005ee:	50                   	push   %eax
  8005ef:	e8 48 ff ff ff       	call   80053c <vcprintf>
  8005f4:	83 c4 10             	add    $0x10,%esp
  8005f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005fa:	e8 88 0f 00 00       	call   801587 <sys_enable_interrupt>
	return cnt;
  8005ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800602:	c9                   	leave  
  800603:	c3                   	ret    

00800604 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800604:	55                   	push   %ebp
  800605:	89 e5                	mov    %esp,%ebp
  800607:	53                   	push   %ebx
  800608:	83 ec 14             	sub    $0x14,%esp
  80060b:	8b 45 10             	mov    0x10(%ebp),%eax
  80060e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800611:	8b 45 14             	mov    0x14(%ebp),%eax
  800614:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800617:	8b 45 18             	mov    0x18(%ebp),%eax
  80061a:	ba 00 00 00 00       	mov    $0x0,%edx
  80061f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800622:	77 55                	ja     800679 <printnum+0x75>
  800624:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800627:	72 05                	jb     80062e <printnum+0x2a>
  800629:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80062c:	77 4b                	ja     800679 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80062e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800631:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800634:	8b 45 18             	mov    0x18(%ebp),%eax
  800637:	ba 00 00 00 00       	mov    $0x0,%edx
  80063c:	52                   	push   %edx
  80063d:	50                   	push   %eax
  80063e:	ff 75 f4             	pushl  -0xc(%ebp)
  800641:	ff 75 f0             	pushl  -0x10(%ebp)
  800644:	e8 fb 13 00 00       	call   801a44 <__udivdi3>
  800649:	83 c4 10             	add    $0x10,%esp
  80064c:	83 ec 04             	sub    $0x4,%esp
  80064f:	ff 75 20             	pushl  0x20(%ebp)
  800652:	53                   	push   %ebx
  800653:	ff 75 18             	pushl  0x18(%ebp)
  800656:	52                   	push   %edx
  800657:	50                   	push   %eax
  800658:	ff 75 0c             	pushl  0xc(%ebp)
  80065b:	ff 75 08             	pushl  0x8(%ebp)
  80065e:	e8 a1 ff ff ff       	call   800604 <printnum>
  800663:	83 c4 20             	add    $0x20,%esp
  800666:	eb 1a                	jmp    800682 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800668:	83 ec 08             	sub    $0x8,%esp
  80066b:	ff 75 0c             	pushl  0xc(%ebp)
  80066e:	ff 75 20             	pushl  0x20(%ebp)
  800671:	8b 45 08             	mov    0x8(%ebp),%eax
  800674:	ff d0                	call   *%eax
  800676:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800679:	ff 4d 1c             	decl   0x1c(%ebp)
  80067c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800680:	7f e6                	jg     800668 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800682:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800685:	bb 00 00 00 00       	mov    $0x0,%ebx
  80068a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80068d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800690:	53                   	push   %ebx
  800691:	51                   	push   %ecx
  800692:	52                   	push   %edx
  800693:	50                   	push   %eax
  800694:	e8 bb 14 00 00       	call   801b54 <__umoddi3>
  800699:	83 c4 10             	add    $0x10,%esp
  80069c:	05 34 21 80 00       	add    $0x802134,%eax
  8006a1:	8a 00                	mov    (%eax),%al
  8006a3:	0f be c0             	movsbl %al,%eax
  8006a6:	83 ec 08             	sub    $0x8,%esp
  8006a9:	ff 75 0c             	pushl  0xc(%ebp)
  8006ac:	50                   	push   %eax
  8006ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b0:	ff d0                	call   *%eax
  8006b2:	83 c4 10             	add    $0x10,%esp
}
  8006b5:	90                   	nop
  8006b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006b9:	c9                   	leave  
  8006ba:	c3                   	ret    

008006bb <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006bb:	55                   	push   %ebp
  8006bc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006be:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006c2:	7e 1c                	jle    8006e0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c7:	8b 00                	mov    (%eax),%eax
  8006c9:	8d 50 08             	lea    0x8(%eax),%edx
  8006cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cf:	89 10                	mov    %edx,(%eax)
  8006d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d4:	8b 00                	mov    (%eax),%eax
  8006d6:	83 e8 08             	sub    $0x8,%eax
  8006d9:	8b 50 04             	mov    0x4(%eax),%edx
  8006dc:	8b 00                	mov    (%eax),%eax
  8006de:	eb 40                	jmp    800720 <getuint+0x65>
	else if (lflag)
  8006e0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006e4:	74 1e                	je     800704 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e9:	8b 00                	mov    (%eax),%eax
  8006eb:	8d 50 04             	lea    0x4(%eax),%edx
  8006ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f1:	89 10                	mov    %edx,(%eax)
  8006f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f6:	8b 00                	mov    (%eax),%eax
  8006f8:	83 e8 04             	sub    $0x4,%eax
  8006fb:	8b 00                	mov    (%eax),%eax
  8006fd:	ba 00 00 00 00       	mov    $0x0,%edx
  800702:	eb 1c                	jmp    800720 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800704:	8b 45 08             	mov    0x8(%ebp),%eax
  800707:	8b 00                	mov    (%eax),%eax
  800709:	8d 50 04             	lea    0x4(%eax),%edx
  80070c:	8b 45 08             	mov    0x8(%ebp),%eax
  80070f:	89 10                	mov    %edx,(%eax)
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	8b 00                	mov    (%eax),%eax
  800716:	83 e8 04             	sub    $0x4,%eax
  800719:	8b 00                	mov    (%eax),%eax
  80071b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800720:	5d                   	pop    %ebp
  800721:	c3                   	ret    

00800722 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800722:	55                   	push   %ebp
  800723:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800725:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800729:	7e 1c                	jle    800747 <getint+0x25>
		return va_arg(*ap, long long);
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	8b 00                	mov    (%eax),%eax
  800730:	8d 50 08             	lea    0x8(%eax),%edx
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	89 10                	mov    %edx,(%eax)
  800738:	8b 45 08             	mov    0x8(%ebp),%eax
  80073b:	8b 00                	mov    (%eax),%eax
  80073d:	83 e8 08             	sub    $0x8,%eax
  800740:	8b 50 04             	mov    0x4(%eax),%edx
  800743:	8b 00                	mov    (%eax),%eax
  800745:	eb 38                	jmp    80077f <getint+0x5d>
	else if (lflag)
  800747:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80074b:	74 1a                	je     800767 <getint+0x45>
		return va_arg(*ap, long);
  80074d:	8b 45 08             	mov    0x8(%ebp),%eax
  800750:	8b 00                	mov    (%eax),%eax
  800752:	8d 50 04             	lea    0x4(%eax),%edx
  800755:	8b 45 08             	mov    0x8(%ebp),%eax
  800758:	89 10                	mov    %edx,(%eax)
  80075a:	8b 45 08             	mov    0x8(%ebp),%eax
  80075d:	8b 00                	mov    (%eax),%eax
  80075f:	83 e8 04             	sub    $0x4,%eax
  800762:	8b 00                	mov    (%eax),%eax
  800764:	99                   	cltd   
  800765:	eb 18                	jmp    80077f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800767:	8b 45 08             	mov    0x8(%ebp),%eax
  80076a:	8b 00                	mov    (%eax),%eax
  80076c:	8d 50 04             	lea    0x4(%eax),%edx
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	89 10                	mov    %edx,(%eax)
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	8b 00                	mov    (%eax),%eax
  800779:	83 e8 04             	sub    $0x4,%eax
  80077c:	8b 00                	mov    (%eax),%eax
  80077e:	99                   	cltd   
}
  80077f:	5d                   	pop    %ebp
  800780:	c3                   	ret    

00800781 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800781:	55                   	push   %ebp
  800782:	89 e5                	mov    %esp,%ebp
  800784:	56                   	push   %esi
  800785:	53                   	push   %ebx
  800786:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800789:	eb 17                	jmp    8007a2 <vprintfmt+0x21>
			if (ch == '\0')
  80078b:	85 db                	test   %ebx,%ebx
  80078d:	0f 84 af 03 00 00    	je     800b42 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800793:	83 ec 08             	sub    $0x8,%esp
  800796:	ff 75 0c             	pushl  0xc(%ebp)
  800799:	53                   	push   %ebx
  80079a:	8b 45 08             	mov    0x8(%ebp),%eax
  80079d:	ff d0                	call   *%eax
  80079f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a5:	8d 50 01             	lea    0x1(%eax),%edx
  8007a8:	89 55 10             	mov    %edx,0x10(%ebp)
  8007ab:	8a 00                	mov    (%eax),%al
  8007ad:	0f b6 d8             	movzbl %al,%ebx
  8007b0:	83 fb 25             	cmp    $0x25,%ebx
  8007b3:	75 d6                	jne    80078b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007b5:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007b9:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007c0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007c7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007ce:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8007d8:	8d 50 01             	lea    0x1(%eax),%edx
  8007db:	89 55 10             	mov    %edx,0x10(%ebp)
  8007de:	8a 00                	mov    (%eax),%al
  8007e0:	0f b6 d8             	movzbl %al,%ebx
  8007e3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007e6:	83 f8 55             	cmp    $0x55,%eax
  8007e9:	0f 87 2b 03 00 00    	ja     800b1a <vprintfmt+0x399>
  8007ef:	8b 04 85 58 21 80 00 	mov    0x802158(,%eax,4),%eax
  8007f6:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007f8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007fc:	eb d7                	jmp    8007d5 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007fe:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800802:	eb d1                	jmp    8007d5 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800804:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80080b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80080e:	89 d0                	mov    %edx,%eax
  800810:	c1 e0 02             	shl    $0x2,%eax
  800813:	01 d0                	add    %edx,%eax
  800815:	01 c0                	add    %eax,%eax
  800817:	01 d8                	add    %ebx,%eax
  800819:	83 e8 30             	sub    $0x30,%eax
  80081c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80081f:	8b 45 10             	mov    0x10(%ebp),%eax
  800822:	8a 00                	mov    (%eax),%al
  800824:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800827:	83 fb 2f             	cmp    $0x2f,%ebx
  80082a:	7e 3e                	jle    80086a <vprintfmt+0xe9>
  80082c:	83 fb 39             	cmp    $0x39,%ebx
  80082f:	7f 39                	jg     80086a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800831:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800834:	eb d5                	jmp    80080b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800836:	8b 45 14             	mov    0x14(%ebp),%eax
  800839:	83 c0 04             	add    $0x4,%eax
  80083c:	89 45 14             	mov    %eax,0x14(%ebp)
  80083f:	8b 45 14             	mov    0x14(%ebp),%eax
  800842:	83 e8 04             	sub    $0x4,%eax
  800845:	8b 00                	mov    (%eax),%eax
  800847:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80084a:	eb 1f                	jmp    80086b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80084c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800850:	79 83                	jns    8007d5 <vprintfmt+0x54>
				width = 0;
  800852:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800859:	e9 77 ff ff ff       	jmp    8007d5 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80085e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800865:	e9 6b ff ff ff       	jmp    8007d5 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80086a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80086b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80086f:	0f 89 60 ff ff ff    	jns    8007d5 <vprintfmt+0x54>
				width = precision, precision = -1;
  800875:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800878:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80087b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800882:	e9 4e ff ff ff       	jmp    8007d5 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800887:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80088a:	e9 46 ff ff ff       	jmp    8007d5 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80088f:	8b 45 14             	mov    0x14(%ebp),%eax
  800892:	83 c0 04             	add    $0x4,%eax
  800895:	89 45 14             	mov    %eax,0x14(%ebp)
  800898:	8b 45 14             	mov    0x14(%ebp),%eax
  80089b:	83 e8 04             	sub    $0x4,%eax
  80089e:	8b 00                	mov    (%eax),%eax
  8008a0:	83 ec 08             	sub    $0x8,%esp
  8008a3:	ff 75 0c             	pushl  0xc(%ebp)
  8008a6:	50                   	push   %eax
  8008a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008aa:	ff d0                	call   *%eax
  8008ac:	83 c4 10             	add    $0x10,%esp
			break;
  8008af:	e9 89 02 00 00       	jmp    800b3d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b7:	83 c0 04             	add    $0x4,%eax
  8008ba:	89 45 14             	mov    %eax,0x14(%ebp)
  8008bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c0:	83 e8 04             	sub    $0x4,%eax
  8008c3:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008c5:	85 db                	test   %ebx,%ebx
  8008c7:	79 02                	jns    8008cb <vprintfmt+0x14a>
				err = -err;
  8008c9:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008cb:	83 fb 64             	cmp    $0x64,%ebx
  8008ce:	7f 0b                	jg     8008db <vprintfmt+0x15a>
  8008d0:	8b 34 9d a0 1f 80 00 	mov    0x801fa0(,%ebx,4),%esi
  8008d7:	85 f6                	test   %esi,%esi
  8008d9:	75 19                	jne    8008f4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008db:	53                   	push   %ebx
  8008dc:	68 45 21 80 00       	push   $0x802145
  8008e1:	ff 75 0c             	pushl  0xc(%ebp)
  8008e4:	ff 75 08             	pushl  0x8(%ebp)
  8008e7:	e8 5e 02 00 00       	call   800b4a <printfmt>
  8008ec:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008ef:	e9 49 02 00 00       	jmp    800b3d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008f4:	56                   	push   %esi
  8008f5:	68 4e 21 80 00       	push   $0x80214e
  8008fa:	ff 75 0c             	pushl  0xc(%ebp)
  8008fd:	ff 75 08             	pushl  0x8(%ebp)
  800900:	e8 45 02 00 00       	call   800b4a <printfmt>
  800905:	83 c4 10             	add    $0x10,%esp
			break;
  800908:	e9 30 02 00 00       	jmp    800b3d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80090d:	8b 45 14             	mov    0x14(%ebp),%eax
  800910:	83 c0 04             	add    $0x4,%eax
  800913:	89 45 14             	mov    %eax,0x14(%ebp)
  800916:	8b 45 14             	mov    0x14(%ebp),%eax
  800919:	83 e8 04             	sub    $0x4,%eax
  80091c:	8b 30                	mov    (%eax),%esi
  80091e:	85 f6                	test   %esi,%esi
  800920:	75 05                	jne    800927 <vprintfmt+0x1a6>
				p = "(null)";
  800922:	be 51 21 80 00       	mov    $0x802151,%esi
			if (width > 0 && padc != '-')
  800927:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80092b:	7e 6d                	jle    80099a <vprintfmt+0x219>
  80092d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800931:	74 67                	je     80099a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800933:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800936:	83 ec 08             	sub    $0x8,%esp
  800939:	50                   	push   %eax
  80093a:	56                   	push   %esi
  80093b:	e8 0c 03 00 00       	call   800c4c <strnlen>
  800940:	83 c4 10             	add    $0x10,%esp
  800943:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800946:	eb 16                	jmp    80095e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800948:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80094c:	83 ec 08             	sub    $0x8,%esp
  80094f:	ff 75 0c             	pushl  0xc(%ebp)
  800952:	50                   	push   %eax
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	ff d0                	call   *%eax
  800958:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80095b:	ff 4d e4             	decl   -0x1c(%ebp)
  80095e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800962:	7f e4                	jg     800948 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800964:	eb 34                	jmp    80099a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800966:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80096a:	74 1c                	je     800988 <vprintfmt+0x207>
  80096c:	83 fb 1f             	cmp    $0x1f,%ebx
  80096f:	7e 05                	jle    800976 <vprintfmt+0x1f5>
  800971:	83 fb 7e             	cmp    $0x7e,%ebx
  800974:	7e 12                	jle    800988 <vprintfmt+0x207>
					putch('?', putdat);
  800976:	83 ec 08             	sub    $0x8,%esp
  800979:	ff 75 0c             	pushl  0xc(%ebp)
  80097c:	6a 3f                	push   $0x3f
  80097e:	8b 45 08             	mov    0x8(%ebp),%eax
  800981:	ff d0                	call   *%eax
  800983:	83 c4 10             	add    $0x10,%esp
  800986:	eb 0f                	jmp    800997 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800988:	83 ec 08             	sub    $0x8,%esp
  80098b:	ff 75 0c             	pushl  0xc(%ebp)
  80098e:	53                   	push   %ebx
  80098f:	8b 45 08             	mov    0x8(%ebp),%eax
  800992:	ff d0                	call   *%eax
  800994:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800997:	ff 4d e4             	decl   -0x1c(%ebp)
  80099a:	89 f0                	mov    %esi,%eax
  80099c:	8d 70 01             	lea    0x1(%eax),%esi
  80099f:	8a 00                	mov    (%eax),%al
  8009a1:	0f be d8             	movsbl %al,%ebx
  8009a4:	85 db                	test   %ebx,%ebx
  8009a6:	74 24                	je     8009cc <vprintfmt+0x24b>
  8009a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009ac:	78 b8                	js     800966 <vprintfmt+0x1e5>
  8009ae:	ff 4d e0             	decl   -0x20(%ebp)
  8009b1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009b5:	79 af                	jns    800966 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009b7:	eb 13                	jmp    8009cc <vprintfmt+0x24b>
				putch(' ', putdat);
  8009b9:	83 ec 08             	sub    $0x8,%esp
  8009bc:	ff 75 0c             	pushl  0xc(%ebp)
  8009bf:	6a 20                	push   $0x20
  8009c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c4:	ff d0                	call   *%eax
  8009c6:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009c9:	ff 4d e4             	decl   -0x1c(%ebp)
  8009cc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009d0:	7f e7                	jg     8009b9 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009d2:	e9 66 01 00 00       	jmp    800b3d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009d7:	83 ec 08             	sub    $0x8,%esp
  8009da:	ff 75 e8             	pushl  -0x18(%ebp)
  8009dd:	8d 45 14             	lea    0x14(%ebp),%eax
  8009e0:	50                   	push   %eax
  8009e1:	e8 3c fd ff ff       	call   800722 <getint>
  8009e6:	83 c4 10             	add    $0x10,%esp
  8009e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ec:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009f5:	85 d2                	test   %edx,%edx
  8009f7:	79 23                	jns    800a1c <vprintfmt+0x29b>
				putch('-', putdat);
  8009f9:	83 ec 08             	sub    $0x8,%esp
  8009fc:	ff 75 0c             	pushl  0xc(%ebp)
  8009ff:	6a 2d                	push   $0x2d
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	ff d0                	call   *%eax
  800a06:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a0f:	f7 d8                	neg    %eax
  800a11:	83 d2 00             	adc    $0x0,%edx
  800a14:	f7 da                	neg    %edx
  800a16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a19:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a1c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a23:	e9 bc 00 00 00       	jmp    800ae4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a28:	83 ec 08             	sub    $0x8,%esp
  800a2b:	ff 75 e8             	pushl  -0x18(%ebp)
  800a2e:	8d 45 14             	lea    0x14(%ebp),%eax
  800a31:	50                   	push   %eax
  800a32:	e8 84 fc ff ff       	call   8006bb <getuint>
  800a37:	83 c4 10             	add    $0x10,%esp
  800a3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a40:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a47:	e9 98 00 00 00       	jmp    800ae4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a4c:	83 ec 08             	sub    $0x8,%esp
  800a4f:	ff 75 0c             	pushl  0xc(%ebp)
  800a52:	6a 58                	push   $0x58
  800a54:	8b 45 08             	mov    0x8(%ebp),%eax
  800a57:	ff d0                	call   *%eax
  800a59:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a5c:	83 ec 08             	sub    $0x8,%esp
  800a5f:	ff 75 0c             	pushl  0xc(%ebp)
  800a62:	6a 58                	push   $0x58
  800a64:	8b 45 08             	mov    0x8(%ebp),%eax
  800a67:	ff d0                	call   *%eax
  800a69:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a6c:	83 ec 08             	sub    $0x8,%esp
  800a6f:	ff 75 0c             	pushl  0xc(%ebp)
  800a72:	6a 58                	push   $0x58
  800a74:	8b 45 08             	mov    0x8(%ebp),%eax
  800a77:	ff d0                	call   *%eax
  800a79:	83 c4 10             	add    $0x10,%esp
			break;
  800a7c:	e9 bc 00 00 00       	jmp    800b3d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a81:	83 ec 08             	sub    $0x8,%esp
  800a84:	ff 75 0c             	pushl  0xc(%ebp)
  800a87:	6a 30                	push   $0x30
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	ff d0                	call   *%eax
  800a8e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a91:	83 ec 08             	sub    $0x8,%esp
  800a94:	ff 75 0c             	pushl  0xc(%ebp)
  800a97:	6a 78                	push   $0x78
  800a99:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9c:	ff d0                	call   *%eax
  800a9e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800aa1:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa4:	83 c0 04             	add    $0x4,%eax
  800aa7:	89 45 14             	mov    %eax,0x14(%ebp)
  800aaa:	8b 45 14             	mov    0x14(%ebp),%eax
  800aad:	83 e8 04             	sub    $0x4,%eax
  800ab0:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ab2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ab5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800abc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ac3:	eb 1f                	jmp    800ae4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ac5:	83 ec 08             	sub    $0x8,%esp
  800ac8:	ff 75 e8             	pushl  -0x18(%ebp)
  800acb:	8d 45 14             	lea    0x14(%ebp),%eax
  800ace:	50                   	push   %eax
  800acf:	e8 e7 fb ff ff       	call   8006bb <getuint>
  800ad4:	83 c4 10             	add    $0x10,%esp
  800ad7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ada:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800add:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ae4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ae8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800aeb:	83 ec 04             	sub    $0x4,%esp
  800aee:	52                   	push   %edx
  800aef:	ff 75 e4             	pushl  -0x1c(%ebp)
  800af2:	50                   	push   %eax
  800af3:	ff 75 f4             	pushl  -0xc(%ebp)
  800af6:	ff 75 f0             	pushl  -0x10(%ebp)
  800af9:	ff 75 0c             	pushl  0xc(%ebp)
  800afc:	ff 75 08             	pushl  0x8(%ebp)
  800aff:	e8 00 fb ff ff       	call   800604 <printnum>
  800b04:	83 c4 20             	add    $0x20,%esp
			break;
  800b07:	eb 34                	jmp    800b3d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b09:	83 ec 08             	sub    $0x8,%esp
  800b0c:	ff 75 0c             	pushl  0xc(%ebp)
  800b0f:	53                   	push   %ebx
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	ff d0                	call   *%eax
  800b15:	83 c4 10             	add    $0x10,%esp
			break;
  800b18:	eb 23                	jmp    800b3d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b1a:	83 ec 08             	sub    $0x8,%esp
  800b1d:	ff 75 0c             	pushl  0xc(%ebp)
  800b20:	6a 25                	push   $0x25
  800b22:	8b 45 08             	mov    0x8(%ebp),%eax
  800b25:	ff d0                	call   *%eax
  800b27:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b2a:	ff 4d 10             	decl   0x10(%ebp)
  800b2d:	eb 03                	jmp    800b32 <vprintfmt+0x3b1>
  800b2f:	ff 4d 10             	decl   0x10(%ebp)
  800b32:	8b 45 10             	mov    0x10(%ebp),%eax
  800b35:	48                   	dec    %eax
  800b36:	8a 00                	mov    (%eax),%al
  800b38:	3c 25                	cmp    $0x25,%al
  800b3a:	75 f3                	jne    800b2f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b3c:	90                   	nop
		}
	}
  800b3d:	e9 47 fc ff ff       	jmp    800789 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b42:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b43:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b46:	5b                   	pop    %ebx
  800b47:	5e                   	pop    %esi
  800b48:	5d                   	pop    %ebp
  800b49:	c3                   	ret    

00800b4a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b4a:	55                   	push   %ebp
  800b4b:	89 e5                	mov    %esp,%ebp
  800b4d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b50:	8d 45 10             	lea    0x10(%ebp),%eax
  800b53:	83 c0 04             	add    $0x4,%eax
  800b56:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b59:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5c:	ff 75 f4             	pushl  -0xc(%ebp)
  800b5f:	50                   	push   %eax
  800b60:	ff 75 0c             	pushl  0xc(%ebp)
  800b63:	ff 75 08             	pushl  0x8(%ebp)
  800b66:	e8 16 fc ff ff       	call   800781 <vprintfmt>
  800b6b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b6e:	90                   	nop
  800b6f:	c9                   	leave  
  800b70:	c3                   	ret    

00800b71 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b71:	55                   	push   %ebp
  800b72:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b77:	8b 40 08             	mov    0x8(%eax),%eax
  800b7a:	8d 50 01             	lea    0x1(%eax),%edx
  800b7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b80:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b86:	8b 10                	mov    (%eax),%edx
  800b88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8b:	8b 40 04             	mov    0x4(%eax),%eax
  800b8e:	39 c2                	cmp    %eax,%edx
  800b90:	73 12                	jae    800ba4 <sprintputch+0x33>
		*b->buf++ = ch;
  800b92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b95:	8b 00                	mov    (%eax),%eax
  800b97:	8d 48 01             	lea    0x1(%eax),%ecx
  800b9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b9d:	89 0a                	mov    %ecx,(%edx)
  800b9f:	8b 55 08             	mov    0x8(%ebp),%edx
  800ba2:	88 10                	mov    %dl,(%eax)
}
  800ba4:	90                   	nop
  800ba5:	5d                   	pop    %ebp
  800ba6:	c3                   	ret    

00800ba7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ba7:	55                   	push   %ebp
  800ba8:	89 e5                	mov    %esp,%ebp
  800baa:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bad:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800bb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	01 d0                	add    %edx,%eax
  800bbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bc1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bc8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bcc:	74 06                	je     800bd4 <vsnprintf+0x2d>
  800bce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bd2:	7f 07                	jg     800bdb <vsnprintf+0x34>
		return -E_INVAL;
  800bd4:	b8 03 00 00 00       	mov    $0x3,%eax
  800bd9:	eb 20                	jmp    800bfb <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bdb:	ff 75 14             	pushl  0x14(%ebp)
  800bde:	ff 75 10             	pushl  0x10(%ebp)
  800be1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800be4:	50                   	push   %eax
  800be5:	68 71 0b 80 00       	push   $0x800b71
  800bea:	e8 92 fb ff ff       	call   800781 <vprintfmt>
  800bef:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bf2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bf5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bfb:	c9                   	leave  
  800bfc:	c3                   	ret    

00800bfd <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bfd:	55                   	push   %ebp
  800bfe:	89 e5                	mov    %esp,%ebp
  800c00:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c03:	8d 45 10             	lea    0x10(%ebp),%eax
  800c06:	83 c0 04             	add    $0x4,%eax
  800c09:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c0c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0f:	ff 75 f4             	pushl  -0xc(%ebp)
  800c12:	50                   	push   %eax
  800c13:	ff 75 0c             	pushl  0xc(%ebp)
  800c16:	ff 75 08             	pushl  0x8(%ebp)
  800c19:	e8 89 ff ff ff       	call   800ba7 <vsnprintf>
  800c1e:	83 c4 10             	add    $0x10,%esp
  800c21:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c24:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c27:	c9                   	leave  
  800c28:	c3                   	ret    

00800c29 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c29:	55                   	push   %ebp
  800c2a:	89 e5                	mov    %esp,%ebp
  800c2c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c2f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c36:	eb 06                	jmp    800c3e <strlen+0x15>
		n++;
  800c38:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c3b:	ff 45 08             	incl   0x8(%ebp)
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	8a 00                	mov    (%eax),%al
  800c43:	84 c0                	test   %al,%al
  800c45:	75 f1                	jne    800c38 <strlen+0xf>
		n++;
	return n;
  800c47:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c4a:	c9                   	leave  
  800c4b:	c3                   	ret    

00800c4c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c4c:	55                   	push   %ebp
  800c4d:	89 e5                	mov    %esp,%ebp
  800c4f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c52:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c59:	eb 09                	jmp    800c64 <strnlen+0x18>
		n++;
  800c5b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c5e:	ff 45 08             	incl   0x8(%ebp)
  800c61:	ff 4d 0c             	decl   0xc(%ebp)
  800c64:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c68:	74 09                	je     800c73 <strnlen+0x27>
  800c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6d:	8a 00                	mov    (%eax),%al
  800c6f:	84 c0                	test   %al,%al
  800c71:	75 e8                	jne    800c5b <strnlen+0xf>
		n++;
	return n;
  800c73:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c76:	c9                   	leave  
  800c77:	c3                   	ret    

00800c78 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c78:	55                   	push   %ebp
  800c79:	89 e5                	mov    %esp,%ebp
  800c7b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c84:	90                   	nop
  800c85:	8b 45 08             	mov    0x8(%ebp),%eax
  800c88:	8d 50 01             	lea    0x1(%eax),%edx
  800c8b:	89 55 08             	mov    %edx,0x8(%ebp)
  800c8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c91:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c94:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c97:	8a 12                	mov    (%edx),%dl
  800c99:	88 10                	mov    %dl,(%eax)
  800c9b:	8a 00                	mov    (%eax),%al
  800c9d:	84 c0                	test   %al,%al
  800c9f:	75 e4                	jne    800c85 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ca1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ca4:	c9                   	leave  
  800ca5:	c3                   	ret    

00800ca6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ca6:	55                   	push   %ebp
  800ca7:	89 e5                	mov    %esp,%ebp
  800ca9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cb2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cb9:	eb 1f                	jmp    800cda <strncpy+0x34>
		*dst++ = *src;
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	8d 50 01             	lea    0x1(%eax),%edx
  800cc1:	89 55 08             	mov    %edx,0x8(%ebp)
  800cc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cc7:	8a 12                	mov    (%edx),%dl
  800cc9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cce:	8a 00                	mov    (%eax),%al
  800cd0:	84 c0                	test   %al,%al
  800cd2:	74 03                	je     800cd7 <strncpy+0x31>
			src++;
  800cd4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800cd7:	ff 45 fc             	incl   -0x4(%ebp)
  800cda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cdd:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ce0:	72 d9                	jb     800cbb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ce2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ce5:	c9                   	leave  
  800ce6:	c3                   	ret    

00800ce7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ce7:	55                   	push   %ebp
  800ce8:	89 e5                	mov    %esp,%ebp
  800cea:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cf3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf7:	74 30                	je     800d29 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800cf9:	eb 16                	jmp    800d11 <strlcpy+0x2a>
			*dst++ = *src++;
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	8d 50 01             	lea    0x1(%eax),%edx
  800d01:	89 55 08             	mov    %edx,0x8(%ebp)
  800d04:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d07:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d0a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d0d:	8a 12                	mov    (%edx),%dl
  800d0f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d11:	ff 4d 10             	decl   0x10(%ebp)
  800d14:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d18:	74 09                	je     800d23 <strlcpy+0x3c>
  800d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1d:	8a 00                	mov    (%eax),%al
  800d1f:	84 c0                	test   %al,%al
  800d21:	75 d8                	jne    800cfb <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d29:	8b 55 08             	mov    0x8(%ebp),%edx
  800d2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d2f:	29 c2                	sub    %eax,%edx
  800d31:	89 d0                	mov    %edx,%eax
}
  800d33:	c9                   	leave  
  800d34:	c3                   	ret    

00800d35 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d35:	55                   	push   %ebp
  800d36:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d38:	eb 06                	jmp    800d40 <strcmp+0xb>
		p++, q++;
  800d3a:	ff 45 08             	incl   0x8(%ebp)
  800d3d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d40:	8b 45 08             	mov    0x8(%ebp),%eax
  800d43:	8a 00                	mov    (%eax),%al
  800d45:	84 c0                	test   %al,%al
  800d47:	74 0e                	je     800d57 <strcmp+0x22>
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	8a 10                	mov    (%eax),%dl
  800d4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d51:	8a 00                	mov    (%eax),%al
  800d53:	38 c2                	cmp    %al,%dl
  800d55:	74 e3                	je     800d3a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	8a 00                	mov    (%eax),%al
  800d5c:	0f b6 d0             	movzbl %al,%edx
  800d5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	0f b6 c0             	movzbl %al,%eax
  800d67:	29 c2                	sub    %eax,%edx
  800d69:	89 d0                	mov    %edx,%eax
}
  800d6b:	5d                   	pop    %ebp
  800d6c:	c3                   	ret    

00800d6d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d6d:	55                   	push   %ebp
  800d6e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d70:	eb 09                	jmp    800d7b <strncmp+0xe>
		n--, p++, q++;
  800d72:	ff 4d 10             	decl   0x10(%ebp)
  800d75:	ff 45 08             	incl   0x8(%ebp)
  800d78:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d7b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d7f:	74 17                	je     800d98 <strncmp+0x2b>
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	8a 00                	mov    (%eax),%al
  800d86:	84 c0                	test   %al,%al
  800d88:	74 0e                	je     800d98 <strncmp+0x2b>
  800d8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8d:	8a 10                	mov    (%eax),%dl
  800d8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d92:	8a 00                	mov    (%eax),%al
  800d94:	38 c2                	cmp    %al,%dl
  800d96:	74 da                	je     800d72 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d98:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d9c:	75 07                	jne    800da5 <strncmp+0x38>
		return 0;
  800d9e:	b8 00 00 00 00       	mov    $0x0,%eax
  800da3:	eb 14                	jmp    800db9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	8a 00                	mov    (%eax),%al
  800daa:	0f b6 d0             	movzbl %al,%edx
  800dad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db0:	8a 00                	mov    (%eax),%al
  800db2:	0f b6 c0             	movzbl %al,%eax
  800db5:	29 c2                	sub    %eax,%edx
  800db7:	89 d0                	mov    %edx,%eax
}
  800db9:	5d                   	pop    %ebp
  800dba:	c3                   	ret    

00800dbb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800dbb:	55                   	push   %ebp
  800dbc:	89 e5                	mov    %esp,%ebp
  800dbe:	83 ec 04             	sub    $0x4,%esp
  800dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dc7:	eb 12                	jmp    800ddb <strchr+0x20>
		if (*s == c)
  800dc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcc:	8a 00                	mov    (%eax),%al
  800dce:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dd1:	75 05                	jne    800dd8 <strchr+0x1d>
			return (char *) s;
  800dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd6:	eb 11                	jmp    800de9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dd8:	ff 45 08             	incl   0x8(%ebp)
  800ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dde:	8a 00                	mov    (%eax),%al
  800de0:	84 c0                	test   %al,%al
  800de2:	75 e5                	jne    800dc9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800de4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800de9:	c9                   	leave  
  800dea:	c3                   	ret    

00800deb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800deb:	55                   	push   %ebp
  800dec:	89 e5                	mov    %esp,%ebp
  800dee:	83 ec 04             	sub    $0x4,%esp
  800df1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800df7:	eb 0d                	jmp    800e06 <strfind+0x1b>
		if (*s == c)
  800df9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfc:	8a 00                	mov    (%eax),%al
  800dfe:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e01:	74 0e                	je     800e11 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e03:	ff 45 08             	incl   0x8(%ebp)
  800e06:	8b 45 08             	mov    0x8(%ebp),%eax
  800e09:	8a 00                	mov    (%eax),%al
  800e0b:	84 c0                	test   %al,%al
  800e0d:	75 ea                	jne    800df9 <strfind+0xe>
  800e0f:	eb 01                	jmp    800e12 <strfind+0x27>
		if (*s == c)
			break;
  800e11:	90                   	nop
	return (char *) s;
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e15:	c9                   	leave  
  800e16:	c3                   	ret    

00800e17 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e17:	55                   	push   %ebp
  800e18:	89 e5                	mov    %esp,%ebp
  800e1a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e23:	8b 45 10             	mov    0x10(%ebp),%eax
  800e26:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e29:	eb 0e                	jmp    800e39 <memset+0x22>
		*p++ = c;
  800e2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e2e:	8d 50 01             	lea    0x1(%eax),%edx
  800e31:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e34:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e37:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e39:	ff 4d f8             	decl   -0x8(%ebp)
  800e3c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e40:	79 e9                	jns    800e2b <memset+0x14>
		*p++ = c;

	return v;
  800e42:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e45:	c9                   	leave  
  800e46:	c3                   	ret    

00800e47 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e47:	55                   	push   %ebp
  800e48:	89 e5                	mov    %esp,%ebp
  800e4a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e50:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
  800e56:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e59:	eb 16                	jmp    800e71 <memcpy+0x2a>
		*d++ = *s++;
  800e5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5e:	8d 50 01             	lea    0x1(%eax),%edx
  800e61:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e64:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e67:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e6a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e6d:	8a 12                	mov    (%edx),%dl
  800e6f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e71:	8b 45 10             	mov    0x10(%ebp),%eax
  800e74:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e77:	89 55 10             	mov    %edx,0x10(%ebp)
  800e7a:	85 c0                	test   %eax,%eax
  800e7c:	75 dd                	jne    800e5b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e81:	c9                   	leave  
  800e82:	c3                   	ret    

00800e83 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e83:	55                   	push   %ebp
  800e84:	89 e5                	mov    %esp,%ebp
  800e86:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e95:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e98:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e9b:	73 50                	jae    800eed <memmove+0x6a>
  800e9d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ea0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea3:	01 d0                	add    %edx,%eax
  800ea5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ea8:	76 43                	jbe    800eed <memmove+0x6a>
		s += n;
  800eaa:	8b 45 10             	mov    0x10(%ebp),%eax
  800ead:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800eb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800eb6:	eb 10                	jmp    800ec8 <memmove+0x45>
			*--d = *--s;
  800eb8:	ff 4d f8             	decl   -0x8(%ebp)
  800ebb:	ff 4d fc             	decl   -0x4(%ebp)
  800ebe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec1:	8a 10                	mov    (%eax),%dl
  800ec3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ec8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ecb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ece:	89 55 10             	mov    %edx,0x10(%ebp)
  800ed1:	85 c0                	test   %eax,%eax
  800ed3:	75 e3                	jne    800eb8 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ed5:	eb 23                	jmp    800efa <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ed7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eda:	8d 50 01             	lea    0x1(%eax),%edx
  800edd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ee0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ee3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ee6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ee9:	8a 12                	mov    (%edx),%dl
  800eeb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800eed:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ef3:	89 55 10             	mov    %edx,0x10(%ebp)
  800ef6:	85 c0                	test   %eax,%eax
  800ef8:	75 dd                	jne    800ed7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800efd:	c9                   	leave  
  800efe:	c3                   	ret    

00800eff <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800eff:	55                   	push   %ebp
  800f00:	89 e5                	mov    %esp,%ebp
  800f02:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f11:	eb 2a                	jmp    800f3d <memcmp+0x3e>
		if (*s1 != *s2)
  800f13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f16:	8a 10                	mov    (%eax),%dl
  800f18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	38 c2                	cmp    %al,%dl
  800f1f:	74 16                	je     800f37 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f24:	8a 00                	mov    (%eax),%al
  800f26:	0f b6 d0             	movzbl %al,%edx
  800f29:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f2c:	8a 00                	mov    (%eax),%al
  800f2e:	0f b6 c0             	movzbl %al,%eax
  800f31:	29 c2                	sub    %eax,%edx
  800f33:	89 d0                	mov    %edx,%eax
  800f35:	eb 18                	jmp    800f4f <memcmp+0x50>
		s1++, s2++;
  800f37:	ff 45 fc             	incl   -0x4(%ebp)
  800f3a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f40:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f43:	89 55 10             	mov    %edx,0x10(%ebp)
  800f46:	85 c0                	test   %eax,%eax
  800f48:	75 c9                	jne    800f13 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f4a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f4f:	c9                   	leave  
  800f50:	c3                   	ret    

00800f51 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f51:	55                   	push   %ebp
  800f52:	89 e5                	mov    %esp,%ebp
  800f54:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f57:	8b 55 08             	mov    0x8(%ebp),%edx
  800f5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5d:	01 d0                	add    %edx,%eax
  800f5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f62:	eb 15                	jmp    800f79 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	8a 00                	mov    (%eax),%al
  800f69:	0f b6 d0             	movzbl %al,%edx
  800f6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6f:	0f b6 c0             	movzbl %al,%eax
  800f72:	39 c2                	cmp    %eax,%edx
  800f74:	74 0d                	je     800f83 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f76:	ff 45 08             	incl   0x8(%ebp)
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f7f:	72 e3                	jb     800f64 <memfind+0x13>
  800f81:	eb 01                	jmp    800f84 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f83:	90                   	nop
	return (void *) s;
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f87:	c9                   	leave  
  800f88:	c3                   	ret    

00800f89 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f89:	55                   	push   %ebp
  800f8a:	89 e5                	mov    %esp,%ebp
  800f8c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f8f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f96:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f9d:	eb 03                	jmp    800fa2 <strtol+0x19>
		s++;
  800f9f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	8a 00                	mov    (%eax),%al
  800fa7:	3c 20                	cmp    $0x20,%al
  800fa9:	74 f4                	je     800f9f <strtol+0x16>
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	8a 00                	mov    (%eax),%al
  800fb0:	3c 09                	cmp    $0x9,%al
  800fb2:	74 eb                	je     800f9f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	8a 00                	mov    (%eax),%al
  800fb9:	3c 2b                	cmp    $0x2b,%al
  800fbb:	75 05                	jne    800fc2 <strtol+0x39>
		s++;
  800fbd:	ff 45 08             	incl   0x8(%ebp)
  800fc0:	eb 13                	jmp    800fd5 <strtol+0x4c>
	else if (*s == '-')
  800fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc5:	8a 00                	mov    (%eax),%al
  800fc7:	3c 2d                	cmp    $0x2d,%al
  800fc9:	75 0a                	jne    800fd5 <strtol+0x4c>
		s++, neg = 1;
  800fcb:	ff 45 08             	incl   0x8(%ebp)
  800fce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fd5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fd9:	74 06                	je     800fe1 <strtol+0x58>
  800fdb:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fdf:	75 20                	jne    801001 <strtol+0x78>
  800fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe4:	8a 00                	mov    (%eax),%al
  800fe6:	3c 30                	cmp    $0x30,%al
  800fe8:	75 17                	jne    801001 <strtol+0x78>
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
  800fed:	40                   	inc    %eax
  800fee:	8a 00                	mov    (%eax),%al
  800ff0:	3c 78                	cmp    $0x78,%al
  800ff2:	75 0d                	jne    801001 <strtol+0x78>
		s += 2, base = 16;
  800ff4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ff8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fff:	eb 28                	jmp    801029 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801001:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801005:	75 15                	jne    80101c <strtol+0x93>
  801007:	8b 45 08             	mov    0x8(%ebp),%eax
  80100a:	8a 00                	mov    (%eax),%al
  80100c:	3c 30                	cmp    $0x30,%al
  80100e:	75 0c                	jne    80101c <strtol+0x93>
		s++, base = 8;
  801010:	ff 45 08             	incl   0x8(%ebp)
  801013:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80101a:	eb 0d                	jmp    801029 <strtol+0xa0>
	else if (base == 0)
  80101c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801020:	75 07                	jne    801029 <strtol+0xa0>
		base = 10;
  801022:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	8a 00                	mov    (%eax),%al
  80102e:	3c 2f                	cmp    $0x2f,%al
  801030:	7e 19                	jle    80104b <strtol+0xc2>
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	8a 00                	mov    (%eax),%al
  801037:	3c 39                	cmp    $0x39,%al
  801039:	7f 10                	jg     80104b <strtol+0xc2>
			dig = *s - '0';
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
  80103e:	8a 00                	mov    (%eax),%al
  801040:	0f be c0             	movsbl %al,%eax
  801043:	83 e8 30             	sub    $0x30,%eax
  801046:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801049:	eb 42                	jmp    80108d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	8a 00                	mov    (%eax),%al
  801050:	3c 60                	cmp    $0x60,%al
  801052:	7e 19                	jle    80106d <strtol+0xe4>
  801054:	8b 45 08             	mov    0x8(%ebp),%eax
  801057:	8a 00                	mov    (%eax),%al
  801059:	3c 7a                	cmp    $0x7a,%al
  80105b:	7f 10                	jg     80106d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	8a 00                	mov    (%eax),%al
  801062:	0f be c0             	movsbl %al,%eax
  801065:	83 e8 57             	sub    $0x57,%eax
  801068:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80106b:	eb 20                	jmp    80108d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	8a 00                	mov    (%eax),%al
  801072:	3c 40                	cmp    $0x40,%al
  801074:	7e 39                	jle    8010af <strtol+0x126>
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	8a 00                	mov    (%eax),%al
  80107b:	3c 5a                	cmp    $0x5a,%al
  80107d:	7f 30                	jg     8010af <strtol+0x126>
			dig = *s - 'A' + 10;
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8a 00                	mov    (%eax),%al
  801084:	0f be c0             	movsbl %al,%eax
  801087:	83 e8 37             	sub    $0x37,%eax
  80108a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80108d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801090:	3b 45 10             	cmp    0x10(%ebp),%eax
  801093:	7d 19                	jge    8010ae <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801095:	ff 45 08             	incl   0x8(%ebp)
  801098:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80109f:	89 c2                	mov    %eax,%edx
  8010a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010a4:	01 d0                	add    %edx,%eax
  8010a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010a9:	e9 7b ff ff ff       	jmp    801029 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010ae:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010b3:	74 08                	je     8010bd <strtol+0x134>
		*endptr = (char *) s;
  8010b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8010bb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010bd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010c1:	74 07                	je     8010ca <strtol+0x141>
  8010c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c6:	f7 d8                	neg    %eax
  8010c8:	eb 03                	jmp    8010cd <strtol+0x144>
  8010ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010cd:	c9                   	leave  
  8010ce:	c3                   	ret    

008010cf <ltostr>:

void
ltostr(long value, char *str)
{
  8010cf:	55                   	push   %ebp
  8010d0:	89 e5                	mov    %esp,%ebp
  8010d2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010e7:	79 13                	jns    8010fc <ltostr+0x2d>
	{
		neg = 1;
  8010e9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010f6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010f9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801104:	99                   	cltd   
  801105:	f7 f9                	idiv   %ecx
  801107:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80110a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110d:	8d 50 01             	lea    0x1(%eax),%edx
  801110:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801113:	89 c2                	mov    %eax,%edx
  801115:	8b 45 0c             	mov    0xc(%ebp),%eax
  801118:	01 d0                	add    %edx,%eax
  80111a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80111d:	83 c2 30             	add    $0x30,%edx
  801120:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801122:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801125:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80112a:	f7 e9                	imul   %ecx
  80112c:	c1 fa 02             	sar    $0x2,%edx
  80112f:	89 c8                	mov    %ecx,%eax
  801131:	c1 f8 1f             	sar    $0x1f,%eax
  801134:	29 c2                	sub    %eax,%edx
  801136:	89 d0                	mov    %edx,%eax
  801138:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80113b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80113e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801143:	f7 e9                	imul   %ecx
  801145:	c1 fa 02             	sar    $0x2,%edx
  801148:	89 c8                	mov    %ecx,%eax
  80114a:	c1 f8 1f             	sar    $0x1f,%eax
  80114d:	29 c2                	sub    %eax,%edx
  80114f:	89 d0                	mov    %edx,%eax
  801151:	c1 e0 02             	shl    $0x2,%eax
  801154:	01 d0                	add    %edx,%eax
  801156:	01 c0                	add    %eax,%eax
  801158:	29 c1                	sub    %eax,%ecx
  80115a:	89 ca                	mov    %ecx,%edx
  80115c:	85 d2                	test   %edx,%edx
  80115e:	75 9c                	jne    8010fc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801160:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801167:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80116a:	48                   	dec    %eax
  80116b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80116e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801172:	74 3d                	je     8011b1 <ltostr+0xe2>
		start = 1 ;
  801174:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80117b:	eb 34                	jmp    8011b1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80117d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801180:	8b 45 0c             	mov    0xc(%ebp),%eax
  801183:	01 d0                	add    %edx,%eax
  801185:	8a 00                	mov    (%eax),%al
  801187:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80118a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80118d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801190:	01 c2                	add    %eax,%edx
  801192:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801195:	8b 45 0c             	mov    0xc(%ebp),%eax
  801198:	01 c8                	add    %ecx,%eax
  80119a:	8a 00                	mov    (%eax),%al
  80119c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80119e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a4:	01 c2                	add    %eax,%edx
  8011a6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011a9:	88 02                	mov    %al,(%edx)
		start++ ;
  8011ab:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011ae:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011b4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011b7:	7c c4                	jl     80117d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011b9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bf:	01 d0                	add    %edx,%eax
  8011c1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011c4:	90                   	nop
  8011c5:	c9                   	leave  
  8011c6:	c3                   	ret    

008011c7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011c7:	55                   	push   %ebp
  8011c8:	89 e5                	mov    %esp,%ebp
  8011ca:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011cd:	ff 75 08             	pushl  0x8(%ebp)
  8011d0:	e8 54 fa ff ff       	call   800c29 <strlen>
  8011d5:	83 c4 04             	add    $0x4,%esp
  8011d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011db:	ff 75 0c             	pushl  0xc(%ebp)
  8011de:	e8 46 fa ff ff       	call   800c29 <strlen>
  8011e3:	83 c4 04             	add    $0x4,%esp
  8011e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011f7:	eb 17                	jmp    801210 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ff:	01 c2                	add    %eax,%edx
  801201:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801204:	8b 45 08             	mov    0x8(%ebp),%eax
  801207:	01 c8                	add    %ecx,%eax
  801209:	8a 00                	mov    (%eax),%al
  80120b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80120d:	ff 45 fc             	incl   -0x4(%ebp)
  801210:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801213:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801216:	7c e1                	jl     8011f9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801218:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80121f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801226:	eb 1f                	jmp    801247 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801228:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80122b:	8d 50 01             	lea    0x1(%eax),%edx
  80122e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801231:	89 c2                	mov    %eax,%edx
  801233:	8b 45 10             	mov    0x10(%ebp),%eax
  801236:	01 c2                	add    %eax,%edx
  801238:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80123b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123e:	01 c8                	add    %ecx,%eax
  801240:	8a 00                	mov    (%eax),%al
  801242:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801244:	ff 45 f8             	incl   -0x8(%ebp)
  801247:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80124d:	7c d9                	jl     801228 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80124f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801252:	8b 45 10             	mov    0x10(%ebp),%eax
  801255:	01 d0                	add    %edx,%eax
  801257:	c6 00 00             	movb   $0x0,(%eax)
}
  80125a:	90                   	nop
  80125b:	c9                   	leave  
  80125c:	c3                   	ret    

0080125d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80125d:	55                   	push   %ebp
  80125e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801260:	8b 45 14             	mov    0x14(%ebp),%eax
  801263:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801269:	8b 45 14             	mov    0x14(%ebp),%eax
  80126c:	8b 00                	mov    (%eax),%eax
  80126e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801275:	8b 45 10             	mov    0x10(%ebp),%eax
  801278:	01 d0                	add    %edx,%eax
  80127a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801280:	eb 0c                	jmp    80128e <strsplit+0x31>
			*string++ = 0;
  801282:	8b 45 08             	mov    0x8(%ebp),%eax
  801285:	8d 50 01             	lea    0x1(%eax),%edx
  801288:	89 55 08             	mov    %edx,0x8(%ebp)
  80128b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80128e:	8b 45 08             	mov    0x8(%ebp),%eax
  801291:	8a 00                	mov    (%eax),%al
  801293:	84 c0                	test   %al,%al
  801295:	74 18                	je     8012af <strsplit+0x52>
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	8a 00                	mov    (%eax),%al
  80129c:	0f be c0             	movsbl %al,%eax
  80129f:	50                   	push   %eax
  8012a0:	ff 75 0c             	pushl  0xc(%ebp)
  8012a3:	e8 13 fb ff ff       	call   800dbb <strchr>
  8012a8:	83 c4 08             	add    $0x8,%esp
  8012ab:	85 c0                	test   %eax,%eax
  8012ad:	75 d3                	jne    801282 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8012af:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b2:	8a 00                	mov    (%eax),%al
  8012b4:	84 c0                	test   %al,%al
  8012b6:	74 5a                	je     801312 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8012b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8012bb:	8b 00                	mov    (%eax),%eax
  8012bd:	83 f8 0f             	cmp    $0xf,%eax
  8012c0:	75 07                	jne    8012c9 <strsplit+0x6c>
		{
			return 0;
  8012c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8012c7:	eb 66                	jmp    80132f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8012cc:	8b 00                	mov    (%eax),%eax
  8012ce:	8d 48 01             	lea    0x1(%eax),%ecx
  8012d1:	8b 55 14             	mov    0x14(%ebp),%edx
  8012d4:	89 0a                	mov    %ecx,(%edx)
  8012d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e0:	01 c2                	add    %eax,%edx
  8012e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012e7:	eb 03                	jmp    8012ec <strsplit+0x8f>
			string++;
  8012e9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ef:	8a 00                	mov    (%eax),%al
  8012f1:	84 c0                	test   %al,%al
  8012f3:	74 8b                	je     801280 <strsplit+0x23>
  8012f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f8:	8a 00                	mov    (%eax),%al
  8012fa:	0f be c0             	movsbl %al,%eax
  8012fd:	50                   	push   %eax
  8012fe:	ff 75 0c             	pushl  0xc(%ebp)
  801301:	e8 b5 fa ff ff       	call   800dbb <strchr>
  801306:	83 c4 08             	add    $0x8,%esp
  801309:	85 c0                	test   %eax,%eax
  80130b:	74 dc                	je     8012e9 <strsplit+0x8c>
			string++;
	}
  80130d:	e9 6e ff ff ff       	jmp    801280 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801312:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801313:	8b 45 14             	mov    0x14(%ebp),%eax
  801316:	8b 00                	mov    (%eax),%eax
  801318:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80131f:	8b 45 10             	mov    0x10(%ebp),%eax
  801322:	01 d0                	add    %edx,%eax
  801324:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80132a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80132f:	c9                   	leave  
  801330:	c3                   	ret    

00801331 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801331:	55                   	push   %ebp
  801332:	89 e5                	mov    %esp,%ebp
  801334:	57                   	push   %edi
  801335:	56                   	push   %esi
  801336:	53                   	push   %ebx
  801337:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801340:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801343:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801346:	8b 7d 18             	mov    0x18(%ebp),%edi
  801349:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80134c:	cd 30                	int    $0x30
  80134e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801351:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801354:	83 c4 10             	add    $0x10,%esp
  801357:	5b                   	pop    %ebx
  801358:	5e                   	pop    %esi
  801359:	5f                   	pop    %edi
  80135a:	5d                   	pop    %ebp
  80135b:	c3                   	ret    

0080135c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80135c:	55                   	push   %ebp
  80135d:	89 e5                	mov    %esp,%ebp
  80135f:	83 ec 04             	sub    $0x4,%esp
  801362:	8b 45 10             	mov    0x10(%ebp),%eax
  801365:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801368:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	52                   	push   %edx
  801374:	ff 75 0c             	pushl  0xc(%ebp)
  801377:	50                   	push   %eax
  801378:	6a 00                	push   $0x0
  80137a:	e8 b2 ff ff ff       	call   801331 <syscall>
  80137f:	83 c4 18             	add    $0x18,%esp
}
  801382:	90                   	nop
  801383:	c9                   	leave  
  801384:	c3                   	ret    

00801385 <sys_cgetc>:

int
sys_cgetc(void)
{
  801385:	55                   	push   %ebp
  801386:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	6a 01                	push   $0x1
  801394:	e8 98 ff ff ff       	call   801331 <syscall>
  801399:	83 c4 18             	add    $0x18,%esp
}
  80139c:	c9                   	leave  
  80139d:	c3                   	ret    

0080139e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80139e:	55                   	push   %ebp
  80139f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8013a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 00                	push   $0x0
  8013ac:	50                   	push   %eax
  8013ad:	6a 05                	push   $0x5
  8013af:	e8 7d ff ff ff       	call   801331 <syscall>
  8013b4:	83 c4 18             	add    $0x18,%esp
}
  8013b7:	c9                   	leave  
  8013b8:	c3                   	ret    

008013b9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013b9:	55                   	push   %ebp
  8013ba:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 00                	push   $0x0
  8013c6:	6a 02                	push   $0x2
  8013c8:	e8 64 ff ff ff       	call   801331 <syscall>
  8013cd:	83 c4 18             	add    $0x18,%esp
}
  8013d0:	c9                   	leave  
  8013d1:	c3                   	ret    

008013d2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013d2:	55                   	push   %ebp
  8013d3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 00                	push   $0x0
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 03                	push   $0x3
  8013e1:	e8 4b ff ff ff       	call   801331 <syscall>
  8013e6:	83 c4 18             	add    $0x18,%esp
}
  8013e9:	c9                   	leave  
  8013ea:	c3                   	ret    

008013eb <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013eb:	55                   	push   %ebp
  8013ec:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 04                	push   $0x4
  8013fa:	e8 32 ff ff ff       	call   801331 <syscall>
  8013ff:	83 c4 18             	add    $0x18,%esp
}
  801402:	c9                   	leave  
  801403:	c3                   	ret    

00801404 <sys_env_exit>:


void sys_env_exit(void)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	6a 06                	push   $0x6
  801413:	e8 19 ff ff ff       	call   801331 <syscall>
  801418:	83 c4 18             	add    $0x18,%esp
}
  80141b:	90                   	nop
  80141c:	c9                   	leave  
  80141d:	c3                   	ret    

0080141e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80141e:	55                   	push   %ebp
  80141f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801421:	8b 55 0c             	mov    0xc(%ebp),%edx
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	52                   	push   %edx
  80142e:	50                   	push   %eax
  80142f:	6a 07                	push   $0x7
  801431:	e8 fb fe ff ff       	call   801331 <syscall>
  801436:	83 c4 18             	add    $0x18,%esp
}
  801439:	c9                   	leave  
  80143a:	c3                   	ret    

0080143b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80143b:	55                   	push   %ebp
  80143c:	89 e5                	mov    %esp,%ebp
  80143e:	56                   	push   %esi
  80143f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801440:	8b 75 18             	mov    0x18(%ebp),%esi
  801443:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801446:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801449:	8b 55 0c             	mov    0xc(%ebp),%edx
  80144c:	8b 45 08             	mov    0x8(%ebp),%eax
  80144f:	56                   	push   %esi
  801450:	53                   	push   %ebx
  801451:	51                   	push   %ecx
  801452:	52                   	push   %edx
  801453:	50                   	push   %eax
  801454:	6a 08                	push   $0x8
  801456:	e8 d6 fe ff ff       	call   801331 <syscall>
  80145b:	83 c4 18             	add    $0x18,%esp
}
  80145e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801461:	5b                   	pop    %ebx
  801462:	5e                   	pop    %esi
  801463:	5d                   	pop    %ebp
  801464:	c3                   	ret    

00801465 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801468:	8b 55 0c             	mov    0xc(%ebp),%edx
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	52                   	push   %edx
  801475:	50                   	push   %eax
  801476:	6a 09                	push   $0x9
  801478:	e8 b4 fe ff ff       	call   801331 <syscall>
  80147d:	83 c4 18             	add    $0x18,%esp
}
  801480:	c9                   	leave  
  801481:	c3                   	ret    

00801482 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801482:	55                   	push   %ebp
  801483:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801485:	6a 00                	push   $0x0
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	ff 75 0c             	pushl  0xc(%ebp)
  80148e:	ff 75 08             	pushl  0x8(%ebp)
  801491:	6a 0a                	push   $0xa
  801493:	e8 99 fe ff ff       	call   801331 <syscall>
  801498:	83 c4 18             	add    $0x18,%esp
}
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 0b                	push   $0xb
  8014ac:	e8 80 fe ff ff       	call   801331 <syscall>
  8014b1:	83 c4 18             	add    $0x18,%esp
}
  8014b4:	c9                   	leave  
  8014b5:	c3                   	ret    

008014b6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014b6:	55                   	push   %ebp
  8014b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 0c                	push   $0xc
  8014c5:	e8 67 fe ff ff       	call   801331 <syscall>
  8014ca:	83 c4 18             	add    $0x18,%esp
}
  8014cd:	c9                   	leave  
  8014ce:	c3                   	ret    

008014cf <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 0d                	push   $0xd
  8014de:	e8 4e fe ff ff       	call   801331 <syscall>
  8014e3:	83 c4 18             	add    $0x18,%esp
}
  8014e6:	c9                   	leave  
  8014e7:	c3                   	ret    

008014e8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014e8:	55                   	push   %ebp
  8014e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	ff 75 0c             	pushl  0xc(%ebp)
  8014f4:	ff 75 08             	pushl  0x8(%ebp)
  8014f7:	6a 11                	push   $0x11
  8014f9:	e8 33 fe ff ff       	call   801331 <syscall>
  8014fe:	83 c4 18             	add    $0x18,%esp
	return;
  801501:	90                   	nop
}
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	ff 75 0c             	pushl  0xc(%ebp)
  801510:	ff 75 08             	pushl  0x8(%ebp)
  801513:	6a 12                	push   $0x12
  801515:	e8 17 fe ff ff       	call   801331 <syscall>
  80151a:	83 c4 18             	add    $0x18,%esp
	return ;
  80151d:	90                   	nop
}
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 0e                	push   $0xe
  80152f:	e8 fd fd ff ff       	call   801331 <syscall>
  801534:	83 c4 18             	add    $0x18,%esp
}
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	ff 75 08             	pushl  0x8(%ebp)
  801547:	6a 0f                	push   $0xf
  801549:	e8 e3 fd ff ff       	call   801331 <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 10                	push   $0x10
  801562:	e8 ca fd ff ff       	call   801331 <syscall>
  801567:	83 c4 18             	add    $0x18,%esp
}
  80156a:	90                   	nop
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 14                	push   $0x14
  80157c:	e8 b0 fd ff ff       	call   801331 <syscall>
  801581:	83 c4 18             	add    $0x18,%esp
}
  801584:	90                   	nop
  801585:	c9                   	leave  
  801586:	c3                   	ret    

00801587 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801587:	55                   	push   %ebp
  801588:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 15                	push   $0x15
  801596:	e8 96 fd ff ff       	call   801331 <syscall>
  80159b:	83 c4 18             	add    $0x18,%esp
}
  80159e:	90                   	nop
  80159f:	c9                   	leave  
  8015a0:	c3                   	ret    

008015a1 <sys_cputc>:


void
sys_cputc(const char c)
{
  8015a1:	55                   	push   %ebp
  8015a2:	89 e5                	mov    %esp,%ebp
  8015a4:	83 ec 04             	sub    $0x4,%esp
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015ad:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	50                   	push   %eax
  8015ba:	6a 16                	push   $0x16
  8015bc:	e8 70 fd ff ff       	call   801331 <syscall>
  8015c1:	83 c4 18             	add    $0x18,%esp
}
  8015c4:	90                   	nop
  8015c5:	c9                   	leave  
  8015c6:	c3                   	ret    

008015c7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 17                	push   $0x17
  8015d6:	e8 56 fd ff ff       	call   801331 <syscall>
  8015db:	83 c4 18             	add    $0x18,%esp
}
  8015de:	90                   	nop
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	ff 75 0c             	pushl  0xc(%ebp)
  8015f0:	50                   	push   %eax
  8015f1:	6a 18                	push   $0x18
  8015f3:	e8 39 fd ff ff       	call   801331 <syscall>
  8015f8:	83 c4 18             	add    $0x18,%esp
}
  8015fb:	c9                   	leave  
  8015fc:	c3                   	ret    

008015fd <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015fd:	55                   	push   %ebp
  8015fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801600:	8b 55 0c             	mov    0xc(%ebp),%edx
  801603:	8b 45 08             	mov    0x8(%ebp),%eax
  801606:	6a 00                	push   $0x0
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	52                   	push   %edx
  80160d:	50                   	push   %eax
  80160e:	6a 1b                	push   $0x1b
  801610:	e8 1c fd ff ff       	call   801331 <syscall>
  801615:	83 c4 18             	add    $0x18,%esp
}
  801618:	c9                   	leave  
  801619:	c3                   	ret    

0080161a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80161a:	55                   	push   %ebp
  80161b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80161d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	52                   	push   %edx
  80162a:	50                   	push   %eax
  80162b:	6a 19                	push   $0x19
  80162d:	e8 ff fc ff ff       	call   801331 <syscall>
  801632:	83 c4 18             	add    $0x18,%esp
}
  801635:	90                   	nop
  801636:	c9                   	leave  
  801637:	c3                   	ret    

00801638 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80163b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	52                   	push   %edx
  801648:	50                   	push   %eax
  801649:	6a 1a                	push   $0x1a
  80164b:	e8 e1 fc ff ff       	call   801331 <syscall>
  801650:	83 c4 18             	add    $0x18,%esp
}
  801653:	90                   	nop
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
  801659:	83 ec 04             	sub    $0x4,%esp
  80165c:	8b 45 10             	mov    0x10(%ebp),%eax
  80165f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801662:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801665:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	6a 00                	push   $0x0
  80166e:	51                   	push   %ecx
  80166f:	52                   	push   %edx
  801670:	ff 75 0c             	pushl  0xc(%ebp)
  801673:	50                   	push   %eax
  801674:	6a 1c                	push   $0x1c
  801676:	e8 b6 fc ff ff       	call   801331 <syscall>
  80167b:	83 c4 18             	add    $0x18,%esp
}
  80167e:	c9                   	leave  
  80167f:	c3                   	ret    

00801680 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801683:	8b 55 0c             	mov    0xc(%ebp),%edx
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	52                   	push   %edx
  801690:	50                   	push   %eax
  801691:	6a 1d                	push   $0x1d
  801693:	e8 99 fc ff ff       	call   801331 <syscall>
  801698:	83 c4 18             	add    $0x18,%esp
}
  80169b:	c9                   	leave  
  80169c:	c3                   	ret    

0080169d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8016a0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	51                   	push   %ecx
  8016ae:	52                   	push   %edx
  8016af:	50                   	push   %eax
  8016b0:	6a 1e                	push   $0x1e
  8016b2:	e8 7a fc ff ff       	call   801331 <syscall>
  8016b7:	83 c4 18             	add    $0x18,%esp
}
  8016ba:	c9                   	leave  
  8016bb:	c3                   	ret    

008016bc <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	52                   	push   %edx
  8016cc:	50                   	push   %eax
  8016cd:	6a 1f                	push   $0x1f
  8016cf:	e8 5d fc ff ff       	call   801331 <syscall>
  8016d4:	83 c4 18             	add    $0x18,%esp
}
  8016d7:	c9                   	leave  
  8016d8:	c3                   	ret    

008016d9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 20                	push   $0x20
  8016e8:	e8 44 fc ff ff       	call   801331 <syscall>
  8016ed:	83 c4 18             	add    $0x18,%esp
}
  8016f0:	c9                   	leave  
  8016f1:	c3                   	ret    

008016f2 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016f2:	55                   	push   %ebp
  8016f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8016f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f8:	6a 00                	push   $0x0
  8016fa:	ff 75 14             	pushl  0x14(%ebp)
  8016fd:	ff 75 10             	pushl  0x10(%ebp)
  801700:	ff 75 0c             	pushl  0xc(%ebp)
  801703:	50                   	push   %eax
  801704:	6a 21                	push   $0x21
  801706:	e8 26 fc ff ff       	call   801331 <syscall>
  80170b:	83 c4 18             	add    $0x18,%esp
}
  80170e:	c9                   	leave  
  80170f:	c3                   	ret    

00801710 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801710:	55                   	push   %ebp
  801711:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801713:	8b 45 08             	mov    0x8(%ebp),%eax
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	50                   	push   %eax
  80171f:	6a 22                	push   $0x22
  801721:	e8 0b fc ff ff       	call   801331 <syscall>
  801726:	83 c4 18             	add    $0x18,%esp
}
  801729:	90                   	nop
  80172a:	c9                   	leave  
  80172b:	c3                   	ret    

0080172c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80172c:	55                   	push   %ebp
  80172d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80172f:	8b 45 08             	mov    0x8(%ebp),%eax
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	50                   	push   %eax
  80173b:	6a 23                	push   $0x23
  80173d:	e8 ef fb ff ff       	call   801331 <syscall>
  801742:	83 c4 18             	add    $0x18,%esp
}
  801745:	90                   	nop
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
  80174b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80174e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801751:	8d 50 04             	lea    0x4(%eax),%edx
  801754:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	52                   	push   %edx
  80175e:	50                   	push   %eax
  80175f:	6a 24                	push   $0x24
  801761:	e8 cb fb ff ff       	call   801331 <syscall>
  801766:	83 c4 18             	add    $0x18,%esp
	return result;
  801769:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80176c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80176f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801772:	89 01                	mov    %eax,(%ecx)
  801774:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801777:	8b 45 08             	mov    0x8(%ebp),%eax
  80177a:	c9                   	leave  
  80177b:	c2 04 00             	ret    $0x4

0080177e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	ff 75 10             	pushl  0x10(%ebp)
  801788:	ff 75 0c             	pushl  0xc(%ebp)
  80178b:	ff 75 08             	pushl  0x8(%ebp)
  80178e:	6a 13                	push   $0x13
  801790:	e8 9c fb ff ff       	call   801331 <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
	return ;
  801798:	90                   	nop
}
  801799:	c9                   	leave  
  80179a:	c3                   	ret    

0080179b <sys_rcr2>:
uint32 sys_rcr2()
{
  80179b:	55                   	push   %ebp
  80179c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 25                	push   $0x25
  8017aa:	e8 82 fb ff ff       	call   801331 <syscall>
  8017af:	83 c4 18             	add    $0x18,%esp
}
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
  8017b7:	83 ec 04             	sub    $0x4,%esp
  8017ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017c0:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	50                   	push   %eax
  8017cd:	6a 26                	push   $0x26
  8017cf:	e8 5d fb ff ff       	call   801331 <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d7:	90                   	nop
}
  8017d8:	c9                   	leave  
  8017d9:	c3                   	ret    

008017da <rsttst>:
void rsttst()
{
  8017da:	55                   	push   %ebp
  8017db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 28                	push   $0x28
  8017e9:	e8 43 fb ff ff       	call   801331 <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8017f1:	90                   	nop
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
  8017f7:	83 ec 04             	sub    $0x4,%esp
  8017fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8017fd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801800:	8b 55 18             	mov    0x18(%ebp),%edx
  801803:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801807:	52                   	push   %edx
  801808:	50                   	push   %eax
  801809:	ff 75 10             	pushl  0x10(%ebp)
  80180c:	ff 75 0c             	pushl  0xc(%ebp)
  80180f:	ff 75 08             	pushl  0x8(%ebp)
  801812:	6a 27                	push   $0x27
  801814:	e8 18 fb ff ff       	call   801331 <syscall>
  801819:	83 c4 18             	add    $0x18,%esp
	return ;
  80181c:	90                   	nop
}
  80181d:	c9                   	leave  
  80181e:	c3                   	ret    

0080181f <chktst>:
void chktst(uint32 n)
{
  80181f:	55                   	push   %ebp
  801820:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	ff 75 08             	pushl  0x8(%ebp)
  80182d:	6a 29                	push   $0x29
  80182f:	e8 fd fa ff ff       	call   801331 <syscall>
  801834:	83 c4 18             	add    $0x18,%esp
	return ;
  801837:	90                   	nop
}
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <inctst>:

void inctst()
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 2a                	push   $0x2a
  801849:	e8 e3 fa ff ff       	call   801331 <syscall>
  80184e:	83 c4 18             	add    $0x18,%esp
	return ;
  801851:	90                   	nop
}
  801852:	c9                   	leave  
  801853:	c3                   	ret    

00801854 <gettst>:
uint32 gettst()
{
  801854:	55                   	push   %ebp
  801855:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 2b                	push   $0x2b
  801863:	e8 c9 fa ff ff       	call   801331 <syscall>
  801868:	83 c4 18             	add    $0x18,%esp
}
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
  801870:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 2c                	push   $0x2c
  80187f:	e8 ad fa ff ff       	call   801331 <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
  801887:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80188a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80188e:	75 07                	jne    801897 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801890:	b8 01 00 00 00       	mov    $0x1,%eax
  801895:	eb 05                	jmp    80189c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801897:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80189c:	c9                   	leave  
  80189d:	c3                   	ret    

0080189e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80189e:	55                   	push   %ebp
  80189f:	89 e5                	mov    %esp,%ebp
  8018a1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 2c                	push   $0x2c
  8018b0:	e8 7c fa ff ff       	call   801331 <syscall>
  8018b5:	83 c4 18             	add    $0x18,%esp
  8018b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018bb:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018bf:	75 07                	jne    8018c8 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018c1:	b8 01 00 00 00       	mov    $0x1,%eax
  8018c6:	eb 05                	jmp    8018cd <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
  8018d2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 2c                	push   $0x2c
  8018e1:	e8 4b fa ff ff       	call   801331 <syscall>
  8018e6:	83 c4 18             	add    $0x18,%esp
  8018e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018ec:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018f0:	75 07                	jne    8018f9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018f2:	b8 01 00 00 00       	mov    $0x1,%eax
  8018f7:	eb 05                	jmp    8018fe <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018f9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018fe:	c9                   	leave  
  8018ff:	c3                   	ret    

00801900 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801900:	55                   	push   %ebp
  801901:	89 e5                	mov    %esp,%ebp
  801903:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 2c                	push   $0x2c
  801912:	e8 1a fa ff ff       	call   801331 <syscall>
  801917:	83 c4 18             	add    $0x18,%esp
  80191a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80191d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801921:	75 07                	jne    80192a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801923:	b8 01 00 00 00       	mov    $0x1,%eax
  801928:	eb 05                	jmp    80192f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80192a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80192f:	c9                   	leave  
  801930:	c3                   	ret    

00801931 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801931:	55                   	push   %ebp
  801932:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	ff 75 08             	pushl  0x8(%ebp)
  80193f:	6a 2d                	push   $0x2d
  801941:	e8 eb f9 ff ff       	call   801331 <syscall>
  801946:	83 c4 18             	add    $0x18,%esp
	return ;
  801949:	90                   	nop
}
  80194a:	c9                   	leave  
  80194b:	c3                   	ret    

0080194c <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80194c:	55                   	push   %ebp
  80194d:	89 e5                	mov    %esp,%ebp
  80194f:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801950:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801953:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801956:	8b 55 0c             	mov    0xc(%ebp),%edx
  801959:	8b 45 08             	mov    0x8(%ebp),%eax
  80195c:	6a 00                	push   $0x0
  80195e:	53                   	push   %ebx
  80195f:	51                   	push   %ecx
  801960:	52                   	push   %edx
  801961:	50                   	push   %eax
  801962:	6a 2e                	push   $0x2e
  801964:	e8 c8 f9 ff ff       	call   801331 <syscall>
  801969:	83 c4 18             	add    $0x18,%esp
}
  80196c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80196f:	c9                   	leave  
  801970:	c3                   	ret    

00801971 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801971:	55                   	push   %ebp
  801972:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801974:	8b 55 0c             	mov    0xc(%ebp),%edx
  801977:	8b 45 08             	mov    0x8(%ebp),%eax
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	52                   	push   %edx
  801981:	50                   	push   %eax
  801982:	6a 2f                	push   $0x2f
  801984:	e8 a8 f9 ff ff       	call   801331 <syscall>
  801989:	83 c4 18             	add    $0x18,%esp
}
  80198c:	c9                   	leave  
  80198d:	c3                   	ret    

0080198e <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  80198e:	55                   	push   %ebp
  80198f:	89 e5                	mov    %esp,%ebp
  801991:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801994:	8b 55 08             	mov    0x8(%ebp),%edx
  801997:	89 d0                	mov    %edx,%eax
  801999:	c1 e0 02             	shl    $0x2,%eax
  80199c:	01 d0                	add    %edx,%eax
  80199e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a5:	01 d0                	add    %edx,%eax
  8019a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019ae:	01 d0                	add    %edx,%eax
  8019b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019b7:	01 d0                	add    %edx,%eax
  8019b9:	c1 e0 04             	shl    $0x4,%eax
  8019bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8019bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8019c6:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8019c9:	83 ec 0c             	sub    $0xc,%esp
  8019cc:	50                   	push   %eax
  8019cd:	e8 76 fd ff ff       	call   801748 <sys_get_virtual_time>
  8019d2:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8019d5:	eb 41                	jmp    801a18 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8019d7:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8019da:	83 ec 0c             	sub    $0xc,%esp
  8019dd:	50                   	push   %eax
  8019de:	e8 65 fd ff ff       	call   801748 <sys_get_virtual_time>
  8019e3:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8019e6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019ec:	29 c2                	sub    %eax,%edx
  8019ee:	89 d0                	mov    %edx,%eax
  8019f0:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8019f3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8019f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019f9:	89 d1                	mov    %edx,%ecx
  8019fb:	29 c1                	sub    %eax,%ecx
  8019fd:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a00:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a03:	39 c2                	cmp    %eax,%edx
  801a05:	0f 97 c0             	seta   %al
  801a08:	0f b6 c0             	movzbl %al,%eax
  801a0b:	29 c1                	sub    %eax,%ecx
  801a0d:	89 c8                	mov    %ecx,%eax
  801a0f:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801a12:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a15:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a1b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a1e:	72 b7                	jb     8019d7 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a20:	90                   	nop
  801a21:	c9                   	leave  
  801a22:	c3                   	ret    

00801a23 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a23:	55                   	push   %ebp
  801a24:	89 e5                	mov    %esp,%ebp
  801a26:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801a29:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801a30:	eb 03                	jmp    801a35 <busy_wait+0x12>
  801a32:	ff 45 fc             	incl   -0x4(%ebp)
  801a35:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a38:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a3b:	72 f5                	jb     801a32 <busy_wait+0xf>
	return i;
  801a3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801a40:	c9                   	leave  
  801a41:	c3                   	ret    
  801a42:	66 90                	xchg   %ax,%ax

00801a44 <__udivdi3>:
  801a44:	55                   	push   %ebp
  801a45:	57                   	push   %edi
  801a46:	56                   	push   %esi
  801a47:	53                   	push   %ebx
  801a48:	83 ec 1c             	sub    $0x1c,%esp
  801a4b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a4f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a53:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a57:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a5b:	89 ca                	mov    %ecx,%edx
  801a5d:	89 f8                	mov    %edi,%eax
  801a5f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a63:	85 f6                	test   %esi,%esi
  801a65:	75 2d                	jne    801a94 <__udivdi3+0x50>
  801a67:	39 cf                	cmp    %ecx,%edi
  801a69:	77 65                	ja     801ad0 <__udivdi3+0x8c>
  801a6b:	89 fd                	mov    %edi,%ebp
  801a6d:	85 ff                	test   %edi,%edi
  801a6f:	75 0b                	jne    801a7c <__udivdi3+0x38>
  801a71:	b8 01 00 00 00       	mov    $0x1,%eax
  801a76:	31 d2                	xor    %edx,%edx
  801a78:	f7 f7                	div    %edi
  801a7a:	89 c5                	mov    %eax,%ebp
  801a7c:	31 d2                	xor    %edx,%edx
  801a7e:	89 c8                	mov    %ecx,%eax
  801a80:	f7 f5                	div    %ebp
  801a82:	89 c1                	mov    %eax,%ecx
  801a84:	89 d8                	mov    %ebx,%eax
  801a86:	f7 f5                	div    %ebp
  801a88:	89 cf                	mov    %ecx,%edi
  801a8a:	89 fa                	mov    %edi,%edx
  801a8c:	83 c4 1c             	add    $0x1c,%esp
  801a8f:	5b                   	pop    %ebx
  801a90:	5e                   	pop    %esi
  801a91:	5f                   	pop    %edi
  801a92:	5d                   	pop    %ebp
  801a93:	c3                   	ret    
  801a94:	39 ce                	cmp    %ecx,%esi
  801a96:	77 28                	ja     801ac0 <__udivdi3+0x7c>
  801a98:	0f bd fe             	bsr    %esi,%edi
  801a9b:	83 f7 1f             	xor    $0x1f,%edi
  801a9e:	75 40                	jne    801ae0 <__udivdi3+0x9c>
  801aa0:	39 ce                	cmp    %ecx,%esi
  801aa2:	72 0a                	jb     801aae <__udivdi3+0x6a>
  801aa4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801aa8:	0f 87 9e 00 00 00    	ja     801b4c <__udivdi3+0x108>
  801aae:	b8 01 00 00 00       	mov    $0x1,%eax
  801ab3:	89 fa                	mov    %edi,%edx
  801ab5:	83 c4 1c             	add    $0x1c,%esp
  801ab8:	5b                   	pop    %ebx
  801ab9:	5e                   	pop    %esi
  801aba:	5f                   	pop    %edi
  801abb:	5d                   	pop    %ebp
  801abc:	c3                   	ret    
  801abd:	8d 76 00             	lea    0x0(%esi),%esi
  801ac0:	31 ff                	xor    %edi,%edi
  801ac2:	31 c0                	xor    %eax,%eax
  801ac4:	89 fa                	mov    %edi,%edx
  801ac6:	83 c4 1c             	add    $0x1c,%esp
  801ac9:	5b                   	pop    %ebx
  801aca:	5e                   	pop    %esi
  801acb:	5f                   	pop    %edi
  801acc:	5d                   	pop    %ebp
  801acd:	c3                   	ret    
  801ace:	66 90                	xchg   %ax,%ax
  801ad0:	89 d8                	mov    %ebx,%eax
  801ad2:	f7 f7                	div    %edi
  801ad4:	31 ff                	xor    %edi,%edi
  801ad6:	89 fa                	mov    %edi,%edx
  801ad8:	83 c4 1c             	add    $0x1c,%esp
  801adb:	5b                   	pop    %ebx
  801adc:	5e                   	pop    %esi
  801add:	5f                   	pop    %edi
  801ade:	5d                   	pop    %ebp
  801adf:	c3                   	ret    
  801ae0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ae5:	89 eb                	mov    %ebp,%ebx
  801ae7:	29 fb                	sub    %edi,%ebx
  801ae9:	89 f9                	mov    %edi,%ecx
  801aeb:	d3 e6                	shl    %cl,%esi
  801aed:	89 c5                	mov    %eax,%ebp
  801aef:	88 d9                	mov    %bl,%cl
  801af1:	d3 ed                	shr    %cl,%ebp
  801af3:	89 e9                	mov    %ebp,%ecx
  801af5:	09 f1                	or     %esi,%ecx
  801af7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801afb:	89 f9                	mov    %edi,%ecx
  801afd:	d3 e0                	shl    %cl,%eax
  801aff:	89 c5                	mov    %eax,%ebp
  801b01:	89 d6                	mov    %edx,%esi
  801b03:	88 d9                	mov    %bl,%cl
  801b05:	d3 ee                	shr    %cl,%esi
  801b07:	89 f9                	mov    %edi,%ecx
  801b09:	d3 e2                	shl    %cl,%edx
  801b0b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b0f:	88 d9                	mov    %bl,%cl
  801b11:	d3 e8                	shr    %cl,%eax
  801b13:	09 c2                	or     %eax,%edx
  801b15:	89 d0                	mov    %edx,%eax
  801b17:	89 f2                	mov    %esi,%edx
  801b19:	f7 74 24 0c          	divl   0xc(%esp)
  801b1d:	89 d6                	mov    %edx,%esi
  801b1f:	89 c3                	mov    %eax,%ebx
  801b21:	f7 e5                	mul    %ebp
  801b23:	39 d6                	cmp    %edx,%esi
  801b25:	72 19                	jb     801b40 <__udivdi3+0xfc>
  801b27:	74 0b                	je     801b34 <__udivdi3+0xf0>
  801b29:	89 d8                	mov    %ebx,%eax
  801b2b:	31 ff                	xor    %edi,%edi
  801b2d:	e9 58 ff ff ff       	jmp    801a8a <__udivdi3+0x46>
  801b32:	66 90                	xchg   %ax,%ax
  801b34:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b38:	89 f9                	mov    %edi,%ecx
  801b3a:	d3 e2                	shl    %cl,%edx
  801b3c:	39 c2                	cmp    %eax,%edx
  801b3e:	73 e9                	jae    801b29 <__udivdi3+0xe5>
  801b40:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b43:	31 ff                	xor    %edi,%edi
  801b45:	e9 40 ff ff ff       	jmp    801a8a <__udivdi3+0x46>
  801b4a:	66 90                	xchg   %ax,%ax
  801b4c:	31 c0                	xor    %eax,%eax
  801b4e:	e9 37 ff ff ff       	jmp    801a8a <__udivdi3+0x46>
  801b53:	90                   	nop

00801b54 <__umoddi3>:
  801b54:	55                   	push   %ebp
  801b55:	57                   	push   %edi
  801b56:	56                   	push   %esi
  801b57:	53                   	push   %ebx
  801b58:	83 ec 1c             	sub    $0x1c,%esp
  801b5b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b5f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b63:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b67:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b6b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b6f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b73:	89 f3                	mov    %esi,%ebx
  801b75:	89 fa                	mov    %edi,%edx
  801b77:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b7b:	89 34 24             	mov    %esi,(%esp)
  801b7e:	85 c0                	test   %eax,%eax
  801b80:	75 1a                	jne    801b9c <__umoddi3+0x48>
  801b82:	39 f7                	cmp    %esi,%edi
  801b84:	0f 86 a2 00 00 00    	jbe    801c2c <__umoddi3+0xd8>
  801b8a:	89 c8                	mov    %ecx,%eax
  801b8c:	89 f2                	mov    %esi,%edx
  801b8e:	f7 f7                	div    %edi
  801b90:	89 d0                	mov    %edx,%eax
  801b92:	31 d2                	xor    %edx,%edx
  801b94:	83 c4 1c             	add    $0x1c,%esp
  801b97:	5b                   	pop    %ebx
  801b98:	5e                   	pop    %esi
  801b99:	5f                   	pop    %edi
  801b9a:	5d                   	pop    %ebp
  801b9b:	c3                   	ret    
  801b9c:	39 f0                	cmp    %esi,%eax
  801b9e:	0f 87 ac 00 00 00    	ja     801c50 <__umoddi3+0xfc>
  801ba4:	0f bd e8             	bsr    %eax,%ebp
  801ba7:	83 f5 1f             	xor    $0x1f,%ebp
  801baa:	0f 84 ac 00 00 00    	je     801c5c <__umoddi3+0x108>
  801bb0:	bf 20 00 00 00       	mov    $0x20,%edi
  801bb5:	29 ef                	sub    %ebp,%edi
  801bb7:	89 fe                	mov    %edi,%esi
  801bb9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bbd:	89 e9                	mov    %ebp,%ecx
  801bbf:	d3 e0                	shl    %cl,%eax
  801bc1:	89 d7                	mov    %edx,%edi
  801bc3:	89 f1                	mov    %esi,%ecx
  801bc5:	d3 ef                	shr    %cl,%edi
  801bc7:	09 c7                	or     %eax,%edi
  801bc9:	89 e9                	mov    %ebp,%ecx
  801bcb:	d3 e2                	shl    %cl,%edx
  801bcd:	89 14 24             	mov    %edx,(%esp)
  801bd0:	89 d8                	mov    %ebx,%eax
  801bd2:	d3 e0                	shl    %cl,%eax
  801bd4:	89 c2                	mov    %eax,%edx
  801bd6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bda:	d3 e0                	shl    %cl,%eax
  801bdc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801be0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801be4:	89 f1                	mov    %esi,%ecx
  801be6:	d3 e8                	shr    %cl,%eax
  801be8:	09 d0                	or     %edx,%eax
  801bea:	d3 eb                	shr    %cl,%ebx
  801bec:	89 da                	mov    %ebx,%edx
  801bee:	f7 f7                	div    %edi
  801bf0:	89 d3                	mov    %edx,%ebx
  801bf2:	f7 24 24             	mull   (%esp)
  801bf5:	89 c6                	mov    %eax,%esi
  801bf7:	89 d1                	mov    %edx,%ecx
  801bf9:	39 d3                	cmp    %edx,%ebx
  801bfb:	0f 82 87 00 00 00    	jb     801c88 <__umoddi3+0x134>
  801c01:	0f 84 91 00 00 00    	je     801c98 <__umoddi3+0x144>
  801c07:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c0b:	29 f2                	sub    %esi,%edx
  801c0d:	19 cb                	sbb    %ecx,%ebx
  801c0f:	89 d8                	mov    %ebx,%eax
  801c11:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c15:	d3 e0                	shl    %cl,%eax
  801c17:	89 e9                	mov    %ebp,%ecx
  801c19:	d3 ea                	shr    %cl,%edx
  801c1b:	09 d0                	or     %edx,%eax
  801c1d:	89 e9                	mov    %ebp,%ecx
  801c1f:	d3 eb                	shr    %cl,%ebx
  801c21:	89 da                	mov    %ebx,%edx
  801c23:	83 c4 1c             	add    $0x1c,%esp
  801c26:	5b                   	pop    %ebx
  801c27:	5e                   	pop    %esi
  801c28:	5f                   	pop    %edi
  801c29:	5d                   	pop    %ebp
  801c2a:	c3                   	ret    
  801c2b:	90                   	nop
  801c2c:	89 fd                	mov    %edi,%ebp
  801c2e:	85 ff                	test   %edi,%edi
  801c30:	75 0b                	jne    801c3d <__umoddi3+0xe9>
  801c32:	b8 01 00 00 00       	mov    $0x1,%eax
  801c37:	31 d2                	xor    %edx,%edx
  801c39:	f7 f7                	div    %edi
  801c3b:	89 c5                	mov    %eax,%ebp
  801c3d:	89 f0                	mov    %esi,%eax
  801c3f:	31 d2                	xor    %edx,%edx
  801c41:	f7 f5                	div    %ebp
  801c43:	89 c8                	mov    %ecx,%eax
  801c45:	f7 f5                	div    %ebp
  801c47:	89 d0                	mov    %edx,%eax
  801c49:	e9 44 ff ff ff       	jmp    801b92 <__umoddi3+0x3e>
  801c4e:	66 90                	xchg   %ax,%ax
  801c50:	89 c8                	mov    %ecx,%eax
  801c52:	89 f2                	mov    %esi,%edx
  801c54:	83 c4 1c             	add    $0x1c,%esp
  801c57:	5b                   	pop    %ebx
  801c58:	5e                   	pop    %esi
  801c59:	5f                   	pop    %edi
  801c5a:	5d                   	pop    %ebp
  801c5b:	c3                   	ret    
  801c5c:	3b 04 24             	cmp    (%esp),%eax
  801c5f:	72 06                	jb     801c67 <__umoddi3+0x113>
  801c61:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c65:	77 0f                	ja     801c76 <__umoddi3+0x122>
  801c67:	89 f2                	mov    %esi,%edx
  801c69:	29 f9                	sub    %edi,%ecx
  801c6b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c6f:	89 14 24             	mov    %edx,(%esp)
  801c72:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c76:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c7a:	8b 14 24             	mov    (%esp),%edx
  801c7d:	83 c4 1c             	add    $0x1c,%esp
  801c80:	5b                   	pop    %ebx
  801c81:	5e                   	pop    %esi
  801c82:	5f                   	pop    %edi
  801c83:	5d                   	pop    %ebp
  801c84:	c3                   	ret    
  801c85:	8d 76 00             	lea    0x0(%esi),%esi
  801c88:	2b 04 24             	sub    (%esp),%eax
  801c8b:	19 fa                	sbb    %edi,%edx
  801c8d:	89 d1                	mov    %edx,%ecx
  801c8f:	89 c6                	mov    %eax,%esi
  801c91:	e9 71 ff ff ff       	jmp    801c07 <__umoddi3+0xb3>
  801c96:	66 90                	xchg   %ax,%ax
  801c98:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c9c:	72 ea                	jb     801c88 <__umoddi3+0x134>
  801c9e:	89 d9                	mov    %ebx,%ecx
  801ca0:	e9 62 ff ff ff       	jmp    801c07 <__umoddi3+0xb3>

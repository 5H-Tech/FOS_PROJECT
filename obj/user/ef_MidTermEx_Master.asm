
obj/user/ef_MidTermEx_Master:     file format elf32-i386


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
  800031:	e8 b4 01 00 00       	call   8001ea <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests the usage of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	/*[1] CREATE SHARED VARIABLE & INITIALIZE IT*/
	int *X = smalloc("X", sizeof(int) , 1) ;
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	6a 01                	push   $0x1
  800043:	6a 04                	push   $0x4
  800045:	68 80 1f 80 00       	push   $0x801f80
  80004a:	e8 dc 14 00 00       	call   80152b <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*X = 5 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 05 00 00 00    	movl   $0x5,(%eax)

	/*[2] SPECIFY WHETHER TO USE SEMAPHORE OR NOT*/
	//cprintf("Do you want to use semaphore (y/n)? ") ;
	//char select = getchar() ;
	char select = 'y';
  80005e:	c6 45 f3 79          	movb   $0x79,-0xd(%ebp)
	//cputchar(select);
	//cputchar('\n');

	/*[3] SHARE THIS SELECTION WITH OTHER PROCESSES*/
	int *useSem = smalloc("useSem", sizeof(int) , 0) ;
  800062:	83 ec 04             	sub    $0x4,%esp
  800065:	6a 00                	push   $0x0
  800067:	6a 04                	push   $0x4
  800069:	68 82 1f 80 00       	push   $0x801f82
  80006e:	e8 b8 14 00 00       	call   80152b <smalloc>
  800073:	83 c4 10             	add    $0x10,%esp
  800076:	89 45 ec             	mov    %eax,-0x14(%ebp)
	*useSem = 0 ;
  800079:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80007c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	if (select == 'Y' || select == 'y')
  800082:	80 7d f3 59          	cmpb   $0x59,-0xd(%ebp)
  800086:	74 06                	je     80008e <_main+0x56>
  800088:	80 7d f3 79          	cmpb   $0x79,-0xd(%ebp)
  80008c:	75 09                	jne    800097 <_main+0x5f>
		*useSem = 1 ;
  80008e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800091:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

	if (*useSem == 1)
  800097:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80009a:	8b 00                	mov    (%eax),%eax
  80009c:	83 f8 01             	cmp    $0x1,%eax
  80009f:	75 12                	jne    8000b3 <_main+0x7b>
	{
		sys_createSemaphore("T", 0);
  8000a1:	83 ec 08             	sub    $0x8,%esp
  8000a4:	6a 00                	push   $0x0
  8000a6:	68 89 1f 80 00       	push   $0x801f89
  8000ab:	e8 fc 17 00 00       	call   8018ac <sys_createSemaphore>
  8000b0:	83 c4 10             	add    $0x10,%esp
	}

	/*[4] CREATE AND RUN ProcessA & ProcessB*/

	//Create the check-finishing counter
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  8000b3:	83 ec 04             	sub    $0x4,%esp
  8000b6:	6a 01                	push   $0x1
  8000b8:	6a 04                	push   $0x4
  8000ba:	68 8b 1f 80 00       	push   $0x801f8b
  8000bf:	e8 67 14 00 00       	call   80152b <smalloc>
  8000c4:	83 c4 10             	add    $0x10,%esp
  8000c7:	89 45 e8             	mov    %eax,-0x18(%ebp)
	*numOfFinished = 0 ;
  8000ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000cd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	//Create the 2 processes
	int32 envIdProcessA = sys_create_env("midterm_a", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  8000d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d8:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000de:	89 c2                	mov    %eax,%edx
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	8b 40 74             	mov    0x74(%eax),%eax
  8000e8:	6a 32                	push   $0x32
  8000ea:	52                   	push   %edx
  8000eb:	50                   	push   %eax
  8000ec:	68 99 1f 80 00       	push   $0x801f99
  8000f1:	e8 c7 18 00 00       	call   8019bd <sys_create_env>
  8000f6:	83 c4 10             	add    $0x10,%esp
  8000f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int32 envIdProcessB = sys_create_env("midterm_b", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  8000fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800101:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800107:	89 c2                	mov    %eax,%edx
  800109:	a1 20 30 80 00       	mov    0x803020,%eax
  80010e:	8b 40 74             	mov    0x74(%eax),%eax
  800111:	6a 32                	push   $0x32
  800113:	52                   	push   %edx
  800114:	50                   	push   %eax
  800115:	68 a3 1f 80 00       	push   $0x801fa3
  80011a:	e8 9e 18 00 00       	call   8019bd <sys_create_env>
  80011f:	83 c4 10             	add    $0x10,%esp
  800122:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (envIdProcessA == E_ENV_CREATION_ERROR || envIdProcessB == E_ENV_CREATION_ERROR)
  800125:	83 7d e4 ef          	cmpl   $0xffffffef,-0x1c(%ebp)
  800129:	74 06                	je     800131 <_main+0xf9>
  80012b:	83 7d e0 ef          	cmpl   $0xffffffef,-0x20(%ebp)
  80012f:	75 14                	jne    800145 <_main+0x10d>
		panic("NO AVAILABLE ENVs...");
  800131:	83 ec 04             	sub    $0x4,%esp
  800134:	68 ad 1f 80 00       	push   $0x801fad
  800139:	6a 27                	push   $0x27
  80013b:	68 c2 1f 80 00       	push   $0x801fc2
  800140:	e8 ea 01 00 00       	call   80032f <_panic>

	//Run the 2 processes
	sys_run_env(envIdProcessA);
  800145:	83 ec 0c             	sub    $0xc,%esp
  800148:	ff 75 e4             	pushl  -0x1c(%ebp)
  80014b:	e8 8b 18 00 00       	call   8019db <sys_run_env>
  800150:	83 c4 10             	add    $0x10,%esp
	env_sleep(10000);
  800153:	83 ec 0c             	sub    $0xc,%esp
  800156:	68 10 27 00 00       	push   $0x2710
  80015b:	e8 f9 1a 00 00       	call   801c59 <env_sleep>
  800160:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  800163:	83 ec 0c             	sub    $0xc,%esp
  800166:	ff 75 e0             	pushl  -0x20(%ebp)
  800169:	e8 6d 18 00 00       	call   8019db <sys_run_env>
  80016e:	83 c4 10             	add    $0x10,%esp

	/*[5] BUSY-WAIT TILL FINISHING BOTH PROCESSES*/
	while (*numOfFinished != 2) ;
  800171:	90                   	nop
  800172:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800175:	8b 00                	mov    (%eax),%eax
  800177:	83 f8 02             	cmp    $0x2,%eax
  80017a:	75 f6                	jne    800172 <_main+0x13a>

	/*[6] PRINT X*/
	cprintf("Final value of X = %d\n", *X);
  80017c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80017f:	8b 00                	mov    (%eax),%eax
  800181:	83 ec 08             	sub    $0x8,%esp
  800184:	50                   	push   %eax
  800185:	68 dd 1f 80 00       	push   $0x801fdd
  80018a:	e8 42 04 00 00       	call   8005d1 <cprintf>
  80018f:	83 c4 10             	add    $0x10,%esp

	int32 parentenvID = sys_getparentenvid();
  800192:	e8 1f 15 00 00       	call   8016b6 <sys_getparentenvid>
  800197:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if(parentenvID > 0)
  80019a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80019e:	7e 47                	jle    8001e7 <_main+0x1af>
	{
		//Get the check-finishing counter
		int *AllFinish = NULL;
  8001a0:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		AllFinish = sget(parentenvID, "finishedCount") ;
  8001a7:	83 ec 08             	sub    $0x8,%esp
  8001aa:	68 8b 1f 80 00       	push   $0x801f8b
  8001af:	ff 75 dc             	pushl  -0x24(%ebp)
  8001b2:	e8 97 13 00 00       	call   80154e <sget>
  8001b7:	83 c4 10             	add    $0x10,%esp
  8001ba:	89 45 d8             	mov    %eax,-0x28(%ebp)
		sys_free_env(envIdProcessA);
  8001bd:	83 ec 0c             	sub    $0xc,%esp
  8001c0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001c3:	e8 2f 18 00 00       	call   8019f7 <sys_free_env>
  8001c8:	83 c4 10             	add    $0x10,%esp
		sys_free_env(envIdProcessB);
  8001cb:	83 ec 0c             	sub    $0xc,%esp
  8001ce:	ff 75 e0             	pushl  -0x20(%ebp)
  8001d1:	e8 21 18 00 00       	call   8019f7 <sys_free_env>
  8001d6:	83 c4 10             	add    $0x10,%esp
		(*AllFinish)++ ;
  8001d9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001dc:	8b 00                	mov    (%eax),%eax
  8001de:	8d 50 01             	lea    0x1(%eax),%edx
  8001e1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001e4:	89 10                	mov    %edx,(%eax)
	}

	return;
  8001e6:	90                   	nop
  8001e7:	90                   	nop
}
  8001e8:	c9                   	leave  
  8001e9:	c3                   	ret    

008001ea <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001ea:	55                   	push   %ebp
  8001eb:	89 e5                	mov    %esp,%ebp
  8001ed:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001f0:	e8 a8 14 00 00       	call   80169d <sys_getenvindex>
  8001f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001fb:	89 d0                	mov    %edx,%eax
  8001fd:	c1 e0 03             	shl    $0x3,%eax
  800200:	01 d0                	add    %edx,%eax
  800202:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800209:	01 c8                	add    %ecx,%eax
  80020b:	01 c0                	add    %eax,%eax
  80020d:	01 d0                	add    %edx,%eax
  80020f:	01 c0                	add    %eax,%eax
  800211:	01 d0                	add    %edx,%eax
  800213:	89 c2                	mov    %eax,%edx
  800215:	c1 e2 05             	shl    $0x5,%edx
  800218:	29 c2                	sub    %eax,%edx
  80021a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800221:	89 c2                	mov    %eax,%edx
  800223:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800229:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80022e:	a1 20 30 80 00       	mov    0x803020,%eax
  800233:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800239:	84 c0                	test   %al,%al
  80023b:	74 0f                	je     80024c <libmain+0x62>
		binaryname = myEnv->prog_name;
  80023d:	a1 20 30 80 00       	mov    0x803020,%eax
  800242:	05 40 3c 01 00       	add    $0x13c40,%eax
  800247:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80024c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800250:	7e 0a                	jle    80025c <libmain+0x72>
		binaryname = argv[0];
  800252:	8b 45 0c             	mov    0xc(%ebp),%eax
  800255:	8b 00                	mov    (%eax),%eax
  800257:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80025c:	83 ec 08             	sub    $0x8,%esp
  80025f:	ff 75 0c             	pushl  0xc(%ebp)
  800262:	ff 75 08             	pushl  0x8(%ebp)
  800265:	e8 ce fd ff ff       	call   800038 <_main>
  80026a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80026d:	e8 c6 15 00 00       	call   801838 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 0c 20 80 00       	push   $0x80200c
  80027a:	e8 52 03 00 00       	call   8005d1 <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800282:	a1 20 30 80 00       	mov    0x803020,%eax
  800287:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800298:	83 ec 04             	sub    $0x4,%esp
  80029b:	52                   	push   %edx
  80029c:	50                   	push   %eax
  80029d:	68 34 20 80 00       	push   $0x802034
  8002a2:	e8 2a 03 00 00       	call   8005d1 <cprintf>
  8002a7:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8002aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8002af:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8002b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ba:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8002c0:	83 ec 04             	sub    $0x4,%esp
  8002c3:	52                   	push   %edx
  8002c4:	50                   	push   %eax
  8002c5:	68 5c 20 80 00       	push   $0x80205c
  8002ca:	e8 02 03 00 00       	call   8005d1 <cprintf>
  8002cf:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d7:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002dd:	83 ec 08             	sub    $0x8,%esp
  8002e0:	50                   	push   %eax
  8002e1:	68 9d 20 80 00       	push   $0x80209d
  8002e6:	e8 e6 02 00 00       	call   8005d1 <cprintf>
  8002eb:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002ee:	83 ec 0c             	sub    $0xc,%esp
  8002f1:	68 0c 20 80 00       	push   $0x80200c
  8002f6:	e8 d6 02 00 00       	call   8005d1 <cprintf>
  8002fb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002fe:	e8 4f 15 00 00       	call   801852 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800303:	e8 19 00 00 00       	call   800321 <exit>
}
  800308:	90                   	nop
  800309:	c9                   	leave  
  80030a:	c3                   	ret    

0080030b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80030b:	55                   	push   %ebp
  80030c:	89 e5                	mov    %esp,%ebp
  80030e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800311:	83 ec 0c             	sub    $0xc,%esp
  800314:	6a 00                	push   $0x0
  800316:	e8 4e 13 00 00       	call   801669 <sys_env_destroy>
  80031b:	83 c4 10             	add    $0x10,%esp
}
  80031e:	90                   	nop
  80031f:	c9                   	leave  
  800320:	c3                   	ret    

00800321 <exit>:

void
exit(void)
{
  800321:	55                   	push   %ebp
  800322:	89 e5                	mov    %esp,%ebp
  800324:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800327:	e8 a3 13 00 00       	call   8016cf <sys_env_exit>
}
  80032c:	90                   	nop
  80032d:	c9                   	leave  
  80032e:	c3                   	ret    

0080032f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80032f:	55                   	push   %ebp
  800330:	89 e5                	mov    %esp,%ebp
  800332:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800335:	8d 45 10             	lea    0x10(%ebp),%eax
  800338:	83 c0 04             	add    $0x4,%eax
  80033b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80033e:	a1 18 31 80 00       	mov    0x803118,%eax
  800343:	85 c0                	test   %eax,%eax
  800345:	74 16                	je     80035d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800347:	a1 18 31 80 00       	mov    0x803118,%eax
  80034c:	83 ec 08             	sub    $0x8,%esp
  80034f:	50                   	push   %eax
  800350:	68 b4 20 80 00       	push   $0x8020b4
  800355:	e8 77 02 00 00       	call   8005d1 <cprintf>
  80035a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80035d:	a1 00 30 80 00       	mov    0x803000,%eax
  800362:	ff 75 0c             	pushl  0xc(%ebp)
  800365:	ff 75 08             	pushl  0x8(%ebp)
  800368:	50                   	push   %eax
  800369:	68 b9 20 80 00       	push   $0x8020b9
  80036e:	e8 5e 02 00 00       	call   8005d1 <cprintf>
  800373:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800376:	8b 45 10             	mov    0x10(%ebp),%eax
  800379:	83 ec 08             	sub    $0x8,%esp
  80037c:	ff 75 f4             	pushl  -0xc(%ebp)
  80037f:	50                   	push   %eax
  800380:	e8 e1 01 00 00       	call   800566 <vcprintf>
  800385:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800388:	83 ec 08             	sub    $0x8,%esp
  80038b:	6a 00                	push   $0x0
  80038d:	68 d5 20 80 00       	push   $0x8020d5
  800392:	e8 cf 01 00 00       	call   800566 <vcprintf>
  800397:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80039a:	e8 82 ff ff ff       	call   800321 <exit>

	// should not return here
	while (1) ;
  80039f:	eb fe                	jmp    80039f <_panic+0x70>

008003a1 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8003a1:	55                   	push   %ebp
  8003a2:	89 e5                	mov    %esp,%ebp
  8003a4:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ac:	8b 50 74             	mov    0x74(%eax),%edx
  8003af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b2:	39 c2                	cmp    %eax,%edx
  8003b4:	74 14                	je     8003ca <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003b6:	83 ec 04             	sub    $0x4,%esp
  8003b9:	68 d8 20 80 00       	push   $0x8020d8
  8003be:	6a 26                	push   $0x26
  8003c0:	68 24 21 80 00       	push   $0x802124
  8003c5:	e8 65 ff ff ff       	call   80032f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003d8:	e9 b6 00 00 00       	jmp    800493 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8003dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	01 d0                	add    %edx,%eax
  8003ec:	8b 00                	mov    (%eax),%eax
  8003ee:	85 c0                	test   %eax,%eax
  8003f0:	75 08                	jne    8003fa <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003f2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003f5:	e9 96 00 00 00       	jmp    800490 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800401:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800408:	eb 5d                	jmp    800467 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80040a:	a1 20 30 80 00       	mov    0x803020,%eax
  80040f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800415:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800418:	c1 e2 04             	shl    $0x4,%edx
  80041b:	01 d0                	add    %edx,%eax
  80041d:	8a 40 04             	mov    0x4(%eax),%al
  800420:	84 c0                	test   %al,%al
  800422:	75 40                	jne    800464 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800424:	a1 20 30 80 00       	mov    0x803020,%eax
  800429:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80042f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800432:	c1 e2 04             	shl    $0x4,%edx
  800435:	01 d0                	add    %edx,%eax
  800437:	8b 00                	mov    (%eax),%eax
  800439:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80043c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80043f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800444:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800446:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800449:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800450:	8b 45 08             	mov    0x8(%ebp),%eax
  800453:	01 c8                	add    %ecx,%eax
  800455:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800457:	39 c2                	cmp    %eax,%edx
  800459:	75 09                	jne    800464 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80045b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800462:	eb 12                	jmp    800476 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800464:	ff 45 e8             	incl   -0x18(%ebp)
  800467:	a1 20 30 80 00       	mov    0x803020,%eax
  80046c:	8b 50 74             	mov    0x74(%eax),%edx
  80046f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800472:	39 c2                	cmp    %eax,%edx
  800474:	77 94                	ja     80040a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800476:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80047a:	75 14                	jne    800490 <CheckWSWithoutLastIndex+0xef>
			panic(
  80047c:	83 ec 04             	sub    $0x4,%esp
  80047f:	68 30 21 80 00       	push   $0x802130
  800484:	6a 3a                	push   $0x3a
  800486:	68 24 21 80 00       	push   $0x802124
  80048b:	e8 9f fe ff ff       	call   80032f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800490:	ff 45 f0             	incl   -0x10(%ebp)
  800493:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800496:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800499:	0f 8c 3e ff ff ff    	jl     8003dd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80049f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004a6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004ad:	eb 20                	jmp    8004cf <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004af:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004ba:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004bd:	c1 e2 04             	shl    $0x4,%edx
  8004c0:	01 d0                	add    %edx,%eax
  8004c2:	8a 40 04             	mov    0x4(%eax),%al
  8004c5:	3c 01                	cmp    $0x1,%al
  8004c7:	75 03                	jne    8004cc <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8004c9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004cc:	ff 45 e0             	incl   -0x20(%ebp)
  8004cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d4:	8b 50 74             	mov    0x74(%eax),%edx
  8004d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004da:	39 c2                	cmp    %eax,%edx
  8004dc:	77 d1                	ja     8004af <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004e4:	74 14                	je     8004fa <CheckWSWithoutLastIndex+0x159>
		panic(
  8004e6:	83 ec 04             	sub    $0x4,%esp
  8004e9:	68 84 21 80 00       	push   $0x802184
  8004ee:	6a 44                	push   $0x44
  8004f0:	68 24 21 80 00       	push   $0x802124
  8004f5:	e8 35 fe ff ff       	call   80032f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004fa:	90                   	nop
  8004fb:	c9                   	leave  
  8004fc:	c3                   	ret    

008004fd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004fd:	55                   	push   %ebp
  8004fe:	89 e5                	mov    %esp,%ebp
  800500:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800503:	8b 45 0c             	mov    0xc(%ebp),%eax
  800506:	8b 00                	mov    (%eax),%eax
  800508:	8d 48 01             	lea    0x1(%eax),%ecx
  80050b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80050e:	89 0a                	mov    %ecx,(%edx)
  800510:	8b 55 08             	mov    0x8(%ebp),%edx
  800513:	88 d1                	mov    %dl,%cl
  800515:	8b 55 0c             	mov    0xc(%ebp),%edx
  800518:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80051c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051f:	8b 00                	mov    (%eax),%eax
  800521:	3d ff 00 00 00       	cmp    $0xff,%eax
  800526:	75 2c                	jne    800554 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800528:	a0 24 30 80 00       	mov    0x803024,%al
  80052d:	0f b6 c0             	movzbl %al,%eax
  800530:	8b 55 0c             	mov    0xc(%ebp),%edx
  800533:	8b 12                	mov    (%edx),%edx
  800535:	89 d1                	mov    %edx,%ecx
  800537:	8b 55 0c             	mov    0xc(%ebp),%edx
  80053a:	83 c2 08             	add    $0x8,%edx
  80053d:	83 ec 04             	sub    $0x4,%esp
  800540:	50                   	push   %eax
  800541:	51                   	push   %ecx
  800542:	52                   	push   %edx
  800543:	e8 df 10 00 00       	call   801627 <sys_cputs>
  800548:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80054b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80054e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800554:	8b 45 0c             	mov    0xc(%ebp),%eax
  800557:	8b 40 04             	mov    0x4(%eax),%eax
  80055a:	8d 50 01             	lea    0x1(%eax),%edx
  80055d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800560:	89 50 04             	mov    %edx,0x4(%eax)
}
  800563:	90                   	nop
  800564:	c9                   	leave  
  800565:	c3                   	ret    

00800566 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800566:	55                   	push   %ebp
  800567:	89 e5                	mov    %esp,%ebp
  800569:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80056f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800576:	00 00 00 
	b.cnt = 0;
  800579:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800580:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800583:	ff 75 0c             	pushl  0xc(%ebp)
  800586:	ff 75 08             	pushl  0x8(%ebp)
  800589:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80058f:	50                   	push   %eax
  800590:	68 fd 04 80 00       	push   $0x8004fd
  800595:	e8 11 02 00 00       	call   8007ab <vprintfmt>
  80059a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80059d:	a0 24 30 80 00       	mov    0x803024,%al
  8005a2:	0f b6 c0             	movzbl %al,%eax
  8005a5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005ab:	83 ec 04             	sub    $0x4,%esp
  8005ae:	50                   	push   %eax
  8005af:	52                   	push   %edx
  8005b0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005b6:	83 c0 08             	add    $0x8,%eax
  8005b9:	50                   	push   %eax
  8005ba:	e8 68 10 00 00       	call   801627 <sys_cputs>
  8005bf:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005c2:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005c9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005cf:	c9                   	leave  
  8005d0:	c3                   	ret    

008005d1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8005d1:	55                   	push   %ebp
  8005d2:	89 e5                	mov    %esp,%ebp
  8005d4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005d7:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005de:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e7:	83 ec 08             	sub    $0x8,%esp
  8005ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8005ed:	50                   	push   %eax
  8005ee:	e8 73 ff ff ff       	call   800566 <vcprintf>
  8005f3:	83 c4 10             	add    $0x10,%esp
  8005f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005fc:	c9                   	leave  
  8005fd:	c3                   	ret    

008005fe <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005fe:	55                   	push   %ebp
  8005ff:	89 e5                	mov    %esp,%ebp
  800601:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800604:	e8 2f 12 00 00       	call   801838 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800609:	8d 45 0c             	lea    0xc(%ebp),%eax
  80060c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80060f:	8b 45 08             	mov    0x8(%ebp),%eax
  800612:	83 ec 08             	sub    $0x8,%esp
  800615:	ff 75 f4             	pushl  -0xc(%ebp)
  800618:	50                   	push   %eax
  800619:	e8 48 ff ff ff       	call   800566 <vcprintf>
  80061e:	83 c4 10             	add    $0x10,%esp
  800621:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800624:	e8 29 12 00 00       	call   801852 <sys_enable_interrupt>
	return cnt;
  800629:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80062c:	c9                   	leave  
  80062d:	c3                   	ret    

0080062e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80062e:	55                   	push   %ebp
  80062f:	89 e5                	mov    %esp,%ebp
  800631:	53                   	push   %ebx
  800632:	83 ec 14             	sub    $0x14,%esp
  800635:	8b 45 10             	mov    0x10(%ebp),%eax
  800638:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80063b:	8b 45 14             	mov    0x14(%ebp),%eax
  80063e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800641:	8b 45 18             	mov    0x18(%ebp),%eax
  800644:	ba 00 00 00 00       	mov    $0x0,%edx
  800649:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80064c:	77 55                	ja     8006a3 <printnum+0x75>
  80064e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800651:	72 05                	jb     800658 <printnum+0x2a>
  800653:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800656:	77 4b                	ja     8006a3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800658:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80065b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80065e:	8b 45 18             	mov    0x18(%ebp),%eax
  800661:	ba 00 00 00 00       	mov    $0x0,%edx
  800666:	52                   	push   %edx
  800667:	50                   	push   %eax
  800668:	ff 75 f4             	pushl  -0xc(%ebp)
  80066b:	ff 75 f0             	pushl  -0x10(%ebp)
  80066e:	e8 9d 16 00 00       	call   801d10 <__udivdi3>
  800673:	83 c4 10             	add    $0x10,%esp
  800676:	83 ec 04             	sub    $0x4,%esp
  800679:	ff 75 20             	pushl  0x20(%ebp)
  80067c:	53                   	push   %ebx
  80067d:	ff 75 18             	pushl  0x18(%ebp)
  800680:	52                   	push   %edx
  800681:	50                   	push   %eax
  800682:	ff 75 0c             	pushl  0xc(%ebp)
  800685:	ff 75 08             	pushl  0x8(%ebp)
  800688:	e8 a1 ff ff ff       	call   80062e <printnum>
  80068d:	83 c4 20             	add    $0x20,%esp
  800690:	eb 1a                	jmp    8006ac <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800692:	83 ec 08             	sub    $0x8,%esp
  800695:	ff 75 0c             	pushl  0xc(%ebp)
  800698:	ff 75 20             	pushl  0x20(%ebp)
  80069b:	8b 45 08             	mov    0x8(%ebp),%eax
  80069e:	ff d0                	call   *%eax
  8006a0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006a3:	ff 4d 1c             	decl   0x1c(%ebp)
  8006a6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006aa:	7f e6                	jg     800692 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006ac:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006af:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ba:	53                   	push   %ebx
  8006bb:	51                   	push   %ecx
  8006bc:	52                   	push   %edx
  8006bd:	50                   	push   %eax
  8006be:	e8 5d 17 00 00       	call   801e20 <__umoddi3>
  8006c3:	83 c4 10             	add    $0x10,%esp
  8006c6:	05 f4 23 80 00       	add    $0x8023f4,%eax
  8006cb:	8a 00                	mov    (%eax),%al
  8006cd:	0f be c0             	movsbl %al,%eax
  8006d0:	83 ec 08             	sub    $0x8,%esp
  8006d3:	ff 75 0c             	pushl  0xc(%ebp)
  8006d6:	50                   	push   %eax
  8006d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006da:	ff d0                	call   *%eax
  8006dc:	83 c4 10             	add    $0x10,%esp
}
  8006df:	90                   	nop
  8006e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006e3:	c9                   	leave  
  8006e4:	c3                   	ret    

008006e5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006e5:	55                   	push   %ebp
  8006e6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006e8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006ec:	7e 1c                	jle    80070a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f1:	8b 00                	mov    (%eax),%eax
  8006f3:	8d 50 08             	lea    0x8(%eax),%edx
  8006f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f9:	89 10                	mov    %edx,(%eax)
  8006fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fe:	8b 00                	mov    (%eax),%eax
  800700:	83 e8 08             	sub    $0x8,%eax
  800703:	8b 50 04             	mov    0x4(%eax),%edx
  800706:	8b 00                	mov    (%eax),%eax
  800708:	eb 40                	jmp    80074a <getuint+0x65>
	else if (lflag)
  80070a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80070e:	74 1e                	je     80072e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800710:	8b 45 08             	mov    0x8(%ebp),%eax
  800713:	8b 00                	mov    (%eax),%eax
  800715:	8d 50 04             	lea    0x4(%eax),%edx
  800718:	8b 45 08             	mov    0x8(%ebp),%eax
  80071b:	89 10                	mov    %edx,(%eax)
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	8b 00                	mov    (%eax),%eax
  800722:	83 e8 04             	sub    $0x4,%eax
  800725:	8b 00                	mov    (%eax),%eax
  800727:	ba 00 00 00 00       	mov    $0x0,%edx
  80072c:	eb 1c                	jmp    80074a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80072e:	8b 45 08             	mov    0x8(%ebp),%eax
  800731:	8b 00                	mov    (%eax),%eax
  800733:	8d 50 04             	lea    0x4(%eax),%edx
  800736:	8b 45 08             	mov    0x8(%ebp),%eax
  800739:	89 10                	mov    %edx,(%eax)
  80073b:	8b 45 08             	mov    0x8(%ebp),%eax
  80073e:	8b 00                	mov    (%eax),%eax
  800740:	83 e8 04             	sub    $0x4,%eax
  800743:	8b 00                	mov    (%eax),%eax
  800745:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80074a:	5d                   	pop    %ebp
  80074b:	c3                   	ret    

0080074c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80074c:	55                   	push   %ebp
  80074d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80074f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800753:	7e 1c                	jle    800771 <getint+0x25>
		return va_arg(*ap, long long);
  800755:	8b 45 08             	mov    0x8(%ebp),%eax
  800758:	8b 00                	mov    (%eax),%eax
  80075a:	8d 50 08             	lea    0x8(%eax),%edx
  80075d:	8b 45 08             	mov    0x8(%ebp),%eax
  800760:	89 10                	mov    %edx,(%eax)
  800762:	8b 45 08             	mov    0x8(%ebp),%eax
  800765:	8b 00                	mov    (%eax),%eax
  800767:	83 e8 08             	sub    $0x8,%eax
  80076a:	8b 50 04             	mov    0x4(%eax),%edx
  80076d:	8b 00                	mov    (%eax),%eax
  80076f:	eb 38                	jmp    8007a9 <getint+0x5d>
	else if (lflag)
  800771:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800775:	74 1a                	je     800791 <getint+0x45>
		return va_arg(*ap, long);
  800777:	8b 45 08             	mov    0x8(%ebp),%eax
  80077a:	8b 00                	mov    (%eax),%eax
  80077c:	8d 50 04             	lea    0x4(%eax),%edx
  80077f:	8b 45 08             	mov    0x8(%ebp),%eax
  800782:	89 10                	mov    %edx,(%eax)
  800784:	8b 45 08             	mov    0x8(%ebp),%eax
  800787:	8b 00                	mov    (%eax),%eax
  800789:	83 e8 04             	sub    $0x4,%eax
  80078c:	8b 00                	mov    (%eax),%eax
  80078e:	99                   	cltd   
  80078f:	eb 18                	jmp    8007a9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800791:	8b 45 08             	mov    0x8(%ebp),%eax
  800794:	8b 00                	mov    (%eax),%eax
  800796:	8d 50 04             	lea    0x4(%eax),%edx
  800799:	8b 45 08             	mov    0x8(%ebp),%eax
  80079c:	89 10                	mov    %edx,(%eax)
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	8b 00                	mov    (%eax),%eax
  8007a3:	83 e8 04             	sub    $0x4,%eax
  8007a6:	8b 00                	mov    (%eax),%eax
  8007a8:	99                   	cltd   
}
  8007a9:	5d                   	pop    %ebp
  8007aa:	c3                   	ret    

008007ab <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007ab:	55                   	push   %ebp
  8007ac:	89 e5                	mov    %esp,%ebp
  8007ae:	56                   	push   %esi
  8007af:	53                   	push   %ebx
  8007b0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007b3:	eb 17                	jmp    8007cc <vprintfmt+0x21>
			if (ch == '\0')
  8007b5:	85 db                	test   %ebx,%ebx
  8007b7:	0f 84 af 03 00 00    	je     800b6c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007bd:	83 ec 08             	sub    $0x8,%esp
  8007c0:	ff 75 0c             	pushl  0xc(%ebp)
  8007c3:	53                   	push   %ebx
  8007c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c7:	ff d0                	call   *%eax
  8007c9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8007cf:	8d 50 01             	lea    0x1(%eax),%edx
  8007d2:	89 55 10             	mov    %edx,0x10(%ebp)
  8007d5:	8a 00                	mov    (%eax),%al
  8007d7:	0f b6 d8             	movzbl %al,%ebx
  8007da:	83 fb 25             	cmp    $0x25,%ebx
  8007dd:	75 d6                	jne    8007b5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007df:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007e3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007ea:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007f1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007f8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007ff:	8b 45 10             	mov    0x10(%ebp),%eax
  800802:	8d 50 01             	lea    0x1(%eax),%edx
  800805:	89 55 10             	mov    %edx,0x10(%ebp)
  800808:	8a 00                	mov    (%eax),%al
  80080a:	0f b6 d8             	movzbl %al,%ebx
  80080d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800810:	83 f8 55             	cmp    $0x55,%eax
  800813:	0f 87 2b 03 00 00    	ja     800b44 <vprintfmt+0x399>
  800819:	8b 04 85 18 24 80 00 	mov    0x802418(,%eax,4),%eax
  800820:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800822:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800826:	eb d7                	jmp    8007ff <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800828:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80082c:	eb d1                	jmp    8007ff <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80082e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800835:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800838:	89 d0                	mov    %edx,%eax
  80083a:	c1 e0 02             	shl    $0x2,%eax
  80083d:	01 d0                	add    %edx,%eax
  80083f:	01 c0                	add    %eax,%eax
  800841:	01 d8                	add    %ebx,%eax
  800843:	83 e8 30             	sub    $0x30,%eax
  800846:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800849:	8b 45 10             	mov    0x10(%ebp),%eax
  80084c:	8a 00                	mov    (%eax),%al
  80084e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800851:	83 fb 2f             	cmp    $0x2f,%ebx
  800854:	7e 3e                	jle    800894 <vprintfmt+0xe9>
  800856:	83 fb 39             	cmp    $0x39,%ebx
  800859:	7f 39                	jg     800894 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80085b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80085e:	eb d5                	jmp    800835 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800860:	8b 45 14             	mov    0x14(%ebp),%eax
  800863:	83 c0 04             	add    $0x4,%eax
  800866:	89 45 14             	mov    %eax,0x14(%ebp)
  800869:	8b 45 14             	mov    0x14(%ebp),%eax
  80086c:	83 e8 04             	sub    $0x4,%eax
  80086f:	8b 00                	mov    (%eax),%eax
  800871:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800874:	eb 1f                	jmp    800895 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800876:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80087a:	79 83                	jns    8007ff <vprintfmt+0x54>
				width = 0;
  80087c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800883:	e9 77 ff ff ff       	jmp    8007ff <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800888:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80088f:	e9 6b ff ff ff       	jmp    8007ff <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800894:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800895:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800899:	0f 89 60 ff ff ff    	jns    8007ff <vprintfmt+0x54>
				width = precision, precision = -1;
  80089f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008a5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008ac:	e9 4e ff ff ff       	jmp    8007ff <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008b1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008b4:	e9 46 ff ff ff       	jmp    8007ff <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8008bc:	83 c0 04             	add    $0x4,%eax
  8008bf:	89 45 14             	mov    %eax,0x14(%ebp)
  8008c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c5:	83 e8 04             	sub    $0x4,%eax
  8008c8:	8b 00                	mov    (%eax),%eax
  8008ca:	83 ec 08             	sub    $0x8,%esp
  8008cd:	ff 75 0c             	pushl  0xc(%ebp)
  8008d0:	50                   	push   %eax
  8008d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d4:	ff d0                	call   *%eax
  8008d6:	83 c4 10             	add    $0x10,%esp
			break;
  8008d9:	e9 89 02 00 00       	jmp    800b67 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008de:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e1:	83 c0 04             	add    $0x4,%eax
  8008e4:	89 45 14             	mov    %eax,0x14(%ebp)
  8008e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ea:	83 e8 04             	sub    $0x4,%eax
  8008ed:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008ef:	85 db                	test   %ebx,%ebx
  8008f1:	79 02                	jns    8008f5 <vprintfmt+0x14a>
				err = -err;
  8008f3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008f5:	83 fb 64             	cmp    $0x64,%ebx
  8008f8:	7f 0b                	jg     800905 <vprintfmt+0x15a>
  8008fa:	8b 34 9d 60 22 80 00 	mov    0x802260(,%ebx,4),%esi
  800901:	85 f6                	test   %esi,%esi
  800903:	75 19                	jne    80091e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800905:	53                   	push   %ebx
  800906:	68 05 24 80 00       	push   $0x802405
  80090b:	ff 75 0c             	pushl  0xc(%ebp)
  80090e:	ff 75 08             	pushl  0x8(%ebp)
  800911:	e8 5e 02 00 00       	call   800b74 <printfmt>
  800916:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800919:	e9 49 02 00 00       	jmp    800b67 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80091e:	56                   	push   %esi
  80091f:	68 0e 24 80 00       	push   $0x80240e
  800924:	ff 75 0c             	pushl  0xc(%ebp)
  800927:	ff 75 08             	pushl  0x8(%ebp)
  80092a:	e8 45 02 00 00       	call   800b74 <printfmt>
  80092f:	83 c4 10             	add    $0x10,%esp
			break;
  800932:	e9 30 02 00 00       	jmp    800b67 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800937:	8b 45 14             	mov    0x14(%ebp),%eax
  80093a:	83 c0 04             	add    $0x4,%eax
  80093d:	89 45 14             	mov    %eax,0x14(%ebp)
  800940:	8b 45 14             	mov    0x14(%ebp),%eax
  800943:	83 e8 04             	sub    $0x4,%eax
  800946:	8b 30                	mov    (%eax),%esi
  800948:	85 f6                	test   %esi,%esi
  80094a:	75 05                	jne    800951 <vprintfmt+0x1a6>
				p = "(null)";
  80094c:	be 11 24 80 00       	mov    $0x802411,%esi
			if (width > 0 && padc != '-')
  800951:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800955:	7e 6d                	jle    8009c4 <vprintfmt+0x219>
  800957:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80095b:	74 67                	je     8009c4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80095d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800960:	83 ec 08             	sub    $0x8,%esp
  800963:	50                   	push   %eax
  800964:	56                   	push   %esi
  800965:	e8 0c 03 00 00       	call   800c76 <strnlen>
  80096a:	83 c4 10             	add    $0x10,%esp
  80096d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800970:	eb 16                	jmp    800988 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800972:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800976:	83 ec 08             	sub    $0x8,%esp
  800979:	ff 75 0c             	pushl  0xc(%ebp)
  80097c:	50                   	push   %eax
  80097d:	8b 45 08             	mov    0x8(%ebp),%eax
  800980:	ff d0                	call   *%eax
  800982:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800985:	ff 4d e4             	decl   -0x1c(%ebp)
  800988:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80098c:	7f e4                	jg     800972 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80098e:	eb 34                	jmp    8009c4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800990:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800994:	74 1c                	je     8009b2 <vprintfmt+0x207>
  800996:	83 fb 1f             	cmp    $0x1f,%ebx
  800999:	7e 05                	jle    8009a0 <vprintfmt+0x1f5>
  80099b:	83 fb 7e             	cmp    $0x7e,%ebx
  80099e:	7e 12                	jle    8009b2 <vprintfmt+0x207>
					putch('?', putdat);
  8009a0:	83 ec 08             	sub    $0x8,%esp
  8009a3:	ff 75 0c             	pushl  0xc(%ebp)
  8009a6:	6a 3f                	push   $0x3f
  8009a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ab:	ff d0                	call   *%eax
  8009ad:	83 c4 10             	add    $0x10,%esp
  8009b0:	eb 0f                	jmp    8009c1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009b2:	83 ec 08             	sub    $0x8,%esp
  8009b5:	ff 75 0c             	pushl  0xc(%ebp)
  8009b8:	53                   	push   %ebx
  8009b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bc:	ff d0                	call   *%eax
  8009be:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009c1:	ff 4d e4             	decl   -0x1c(%ebp)
  8009c4:	89 f0                	mov    %esi,%eax
  8009c6:	8d 70 01             	lea    0x1(%eax),%esi
  8009c9:	8a 00                	mov    (%eax),%al
  8009cb:	0f be d8             	movsbl %al,%ebx
  8009ce:	85 db                	test   %ebx,%ebx
  8009d0:	74 24                	je     8009f6 <vprintfmt+0x24b>
  8009d2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009d6:	78 b8                	js     800990 <vprintfmt+0x1e5>
  8009d8:	ff 4d e0             	decl   -0x20(%ebp)
  8009db:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009df:	79 af                	jns    800990 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009e1:	eb 13                	jmp    8009f6 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009e3:	83 ec 08             	sub    $0x8,%esp
  8009e6:	ff 75 0c             	pushl  0xc(%ebp)
  8009e9:	6a 20                	push   $0x20
  8009eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ee:	ff d0                	call   *%eax
  8009f0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009f3:	ff 4d e4             	decl   -0x1c(%ebp)
  8009f6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009fa:	7f e7                	jg     8009e3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009fc:	e9 66 01 00 00       	jmp    800b67 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a01:	83 ec 08             	sub    $0x8,%esp
  800a04:	ff 75 e8             	pushl  -0x18(%ebp)
  800a07:	8d 45 14             	lea    0x14(%ebp),%eax
  800a0a:	50                   	push   %eax
  800a0b:	e8 3c fd ff ff       	call   80074c <getint>
  800a10:	83 c4 10             	add    $0x10,%esp
  800a13:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a16:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a1f:	85 d2                	test   %edx,%edx
  800a21:	79 23                	jns    800a46 <vprintfmt+0x29b>
				putch('-', putdat);
  800a23:	83 ec 08             	sub    $0x8,%esp
  800a26:	ff 75 0c             	pushl  0xc(%ebp)
  800a29:	6a 2d                	push   $0x2d
  800a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2e:	ff d0                	call   *%eax
  800a30:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a33:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a36:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a39:	f7 d8                	neg    %eax
  800a3b:	83 d2 00             	adc    $0x0,%edx
  800a3e:	f7 da                	neg    %edx
  800a40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a43:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a46:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a4d:	e9 bc 00 00 00       	jmp    800b0e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a52:	83 ec 08             	sub    $0x8,%esp
  800a55:	ff 75 e8             	pushl  -0x18(%ebp)
  800a58:	8d 45 14             	lea    0x14(%ebp),%eax
  800a5b:	50                   	push   %eax
  800a5c:	e8 84 fc ff ff       	call   8006e5 <getuint>
  800a61:	83 c4 10             	add    $0x10,%esp
  800a64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a67:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a6a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a71:	e9 98 00 00 00       	jmp    800b0e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a76:	83 ec 08             	sub    $0x8,%esp
  800a79:	ff 75 0c             	pushl  0xc(%ebp)
  800a7c:	6a 58                	push   $0x58
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	ff d0                	call   *%eax
  800a83:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a86:	83 ec 08             	sub    $0x8,%esp
  800a89:	ff 75 0c             	pushl  0xc(%ebp)
  800a8c:	6a 58                	push   $0x58
  800a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a91:	ff d0                	call   *%eax
  800a93:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a96:	83 ec 08             	sub    $0x8,%esp
  800a99:	ff 75 0c             	pushl  0xc(%ebp)
  800a9c:	6a 58                	push   $0x58
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	ff d0                	call   *%eax
  800aa3:	83 c4 10             	add    $0x10,%esp
			break;
  800aa6:	e9 bc 00 00 00       	jmp    800b67 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800aab:	83 ec 08             	sub    $0x8,%esp
  800aae:	ff 75 0c             	pushl  0xc(%ebp)
  800ab1:	6a 30                	push   $0x30
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	ff d0                	call   *%eax
  800ab8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800abb:	83 ec 08             	sub    $0x8,%esp
  800abe:	ff 75 0c             	pushl  0xc(%ebp)
  800ac1:	6a 78                	push   $0x78
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	ff d0                	call   *%eax
  800ac8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800acb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ace:	83 c0 04             	add    $0x4,%eax
  800ad1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ad4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad7:	83 e8 04             	sub    $0x4,%eax
  800ada:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800adc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800adf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ae6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800aed:	eb 1f                	jmp    800b0e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800aef:	83 ec 08             	sub    $0x8,%esp
  800af2:	ff 75 e8             	pushl  -0x18(%ebp)
  800af5:	8d 45 14             	lea    0x14(%ebp),%eax
  800af8:	50                   	push   %eax
  800af9:	e8 e7 fb ff ff       	call   8006e5 <getuint>
  800afe:	83 c4 10             	add    $0x10,%esp
  800b01:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b04:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b07:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b0e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b15:	83 ec 04             	sub    $0x4,%esp
  800b18:	52                   	push   %edx
  800b19:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b1c:	50                   	push   %eax
  800b1d:	ff 75 f4             	pushl  -0xc(%ebp)
  800b20:	ff 75 f0             	pushl  -0x10(%ebp)
  800b23:	ff 75 0c             	pushl  0xc(%ebp)
  800b26:	ff 75 08             	pushl  0x8(%ebp)
  800b29:	e8 00 fb ff ff       	call   80062e <printnum>
  800b2e:	83 c4 20             	add    $0x20,%esp
			break;
  800b31:	eb 34                	jmp    800b67 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b33:	83 ec 08             	sub    $0x8,%esp
  800b36:	ff 75 0c             	pushl  0xc(%ebp)
  800b39:	53                   	push   %ebx
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3d:	ff d0                	call   *%eax
  800b3f:	83 c4 10             	add    $0x10,%esp
			break;
  800b42:	eb 23                	jmp    800b67 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b44:	83 ec 08             	sub    $0x8,%esp
  800b47:	ff 75 0c             	pushl  0xc(%ebp)
  800b4a:	6a 25                	push   $0x25
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	ff d0                	call   *%eax
  800b51:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b54:	ff 4d 10             	decl   0x10(%ebp)
  800b57:	eb 03                	jmp    800b5c <vprintfmt+0x3b1>
  800b59:	ff 4d 10             	decl   0x10(%ebp)
  800b5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5f:	48                   	dec    %eax
  800b60:	8a 00                	mov    (%eax),%al
  800b62:	3c 25                	cmp    $0x25,%al
  800b64:	75 f3                	jne    800b59 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b66:	90                   	nop
		}
	}
  800b67:	e9 47 fc ff ff       	jmp    8007b3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b6c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b6d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b70:	5b                   	pop    %ebx
  800b71:	5e                   	pop    %esi
  800b72:	5d                   	pop    %ebp
  800b73:	c3                   	ret    

00800b74 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b74:	55                   	push   %ebp
  800b75:	89 e5                	mov    %esp,%ebp
  800b77:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b7a:	8d 45 10             	lea    0x10(%ebp),%eax
  800b7d:	83 c0 04             	add    $0x4,%eax
  800b80:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b83:	8b 45 10             	mov    0x10(%ebp),%eax
  800b86:	ff 75 f4             	pushl  -0xc(%ebp)
  800b89:	50                   	push   %eax
  800b8a:	ff 75 0c             	pushl  0xc(%ebp)
  800b8d:	ff 75 08             	pushl  0x8(%ebp)
  800b90:	e8 16 fc ff ff       	call   8007ab <vprintfmt>
  800b95:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b98:	90                   	nop
  800b99:	c9                   	leave  
  800b9a:	c3                   	ret    

00800b9b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b9b:	55                   	push   %ebp
  800b9c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba1:	8b 40 08             	mov    0x8(%eax),%eax
  800ba4:	8d 50 01             	lea    0x1(%eax),%edx
  800ba7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800baa:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb0:	8b 10                	mov    (%eax),%edx
  800bb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb5:	8b 40 04             	mov    0x4(%eax),%eax
  800bb8:	39 c2                	cmp    %eax,%edx
  800bba:	73 12                	jae    800bce <sprintputch+0x33>
		*b->buf++ = ch;
  800bbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbf:	8b 00                	mov    (%eax),%eax
  800bc1:	8d 48 01             	lea    0x1(%eax),%ecx
  800bc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc7:	89 0a                	mov    %ecx,(%edx)
  800bc9:	8b 55 08             	mov    0x8(%ebp),%edx
  800bcc:	88 10                	mov    %dl,(%eax)
}
  800bce:	90                   	nop
  800bcf:	5d                   	pop    %ebp
  800bd0:	c3                   	ret    

00800bd1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bd1:	55                   	push   %ebp
  800bd2:	89 e5                	mov    %esp,%ebp
  800bd4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800bdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be3:	8b 45 08             	mov    0x8(%ebp),%eax
  800be6:	01 d0                	add    %edx,%eax
  800be8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800beb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bf2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bf6:	74 06                	je     800bfe <vsnprintf+0x2d>
  800bf8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bfc:	7f 07                	jg     800c05 <vsnprintf+0x34>
		return -E_INVAL;
  800bfe:	b8 03 00 00 00       	mov    $0x3,%eax
  800c03:	eb 20                	jmp    800c25 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c05:	ff 75 14             	pushl  0x14(%ebp)
  800c08:	ff 75 10             	pushl  0x10(%ebp)
  800c0b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c0e:	50                   	push   %eax
  800c0f:	68 9b 0b 80 00       	push   $0x800b9b
  800c14:	e8 92 fb ff ff       	call   8007ab <vprintfmt>
  800c19:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c1f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c22:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c25:	c9                   	leave  
  800c26:	c3                   	ret    

00800c27 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c27:	55                   	push   %ebp
  800c28:	89 e5                	mov    %esp,%ebp
  800c2a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c2d:	8d 45 10             	lea    0x10(%ebp),%eax
  800c30:	83 c0 04             	add    $0x4,%eax
  800c33:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c36:	8b 45 10             	mov    0x10(%ebp),%eax
  800c39:	ff 75 f4             	pushl  -0xc(%ebp)
  800c3c:	50                   	push   %eax
  800c3d:	ff 75 0c             	pushl  0xc(%ebp)
  800c40:	ff 75 08             	pushl  0x8(%ebp)
  800c43:	e8 89 ff ff ff       	call   800bd1 <vsnprintf>
  800c48:	83 c4 10             	add    $0x10,%esp
  800c4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c51:	c9                   	leave  
  800c52:	c3                   	ret    

00800c53 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c53:	55                   	push   %ebp
  800c54:	89 e5                	mov    %esp,%ebp
  800c56:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c59:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c60:	eb 06                	jmp    800c68 <strlen+0x15>
		n++;
  800c62:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c65:	ff 45 08             	incl   0x8(%ebp)
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	8a 00                	mov    (%eax),%al
  800c6d:	84 c0                	test   %al,%al
  800c6f:	75 f1                	jne    800c62 <strlen+0xf>
		n++;
	return n;
  800c71:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c74:	c9                   	leave  
  800c75:	c3                   	ret    

00800c76 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c76:	55                   	push   %ebp
  800c77:	89 e5                	mov    %esp,%ebp
  800c79:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c83:	eb 09                	jmp    800c8e <strnlen+0x18>
		n++;
  800c85:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c88:	ff 45 08             	incl   0x8(%ebp)
  800c8b:	ff 4d 0c             	decl   0xc(%ebp)
  800c8e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c92:	74 09                	je     800c9d <strnlen+0x27>
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	8a 00                	mov    (%eax),%al
  800c99:	84 c0                	test   %al,%al
  800c9b:	75 e8                	jne    800c85 <strnlen+0xf>
		n++;
	return n;
  800c9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ca0:	c9                   	leave  
  800ca1:	c3                   	ret    

00800ca2 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ca2:	55                   	push   %ebp
  800ca3:	89 e5                	mov    %esp,%ebp
  800ca5:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cae:	90                   	nop
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8d 50 01             	lea    0x1(%eax),%edx
  800cb5:	89 55 08             	mov    %edx,0x8(%ebp)
  800cb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cbb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cbe:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cc1:	8a 12                	mov    (%edx),%dl
  800cc3:	88 10                	mov    %dl,(%eax)
  800cc5:	8a 00                	mov    (%eax),%al
  800cc7:	84 c0                	test   %al,%al
  800cc9:	75 e4                	jne    800caf <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ccb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cce:	c9                   	leave  
  800ccf:	c3                   	ret    

00800cd0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cd0:	55                   	push   %ebp
  800cd1:	89 e5                	mov    %esp,%ebp
  800cd3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cdc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ce3:	eb 1f                	jmp    800d04 <strncpy+0x34>
		*dst++ = *src;
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8d 50 01             	lea    0x1(%eax),%edx
  800ceb:	89 55 08             	mov    %edx,0x8(%ebp)
  800cee:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf1:	8a 12                	mov    (%edx),%dl
  800cf3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cf5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf8:	8a 00                	mov    (%eax),%al
  800cfa:	84 c0                	test   %al,%al
  800cfc:	74 03                	je     800d01 <strncpy+0x31>
			src++;
  800cfe:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d01:	ff 45 fc             	incl   -0x4(%ebp)
  800d04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d07:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d0a:	72 d9                	jb     800ce5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d0f:	c9                   	leave  
  800d10:	c3                   	ret    

00800d11 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d11:	55                   	push   %ebp
  800d12:	89 e5                	mov    %esp,%ebp
  800d14:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d17:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d21:	74 30                	je     800d53 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d23:	eb 16                	jmp    800d3b <strlcpy+0x2a>
			*dst++ = *src++;
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	8d 50 01             	lea    0x1(%eax),%edx
  800d2b:	89 55 08             	mov    %edx,0x8(%ebp)
  800d2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d31:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d34:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d37:	8a 12                	mov    (%edx),%dl
  800d39:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d3b:	ff 4d 10             	decl   0x10(%ebp)
  800d3e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d42:	74 09                	je     800d4d <strlcpy+0x3c>
  800d44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d47:	8a 00                	mov    (%eax),%al
  800d49:	84 c0                	test   %al,%al
  800d4b:	75 d8                	jne    800d25 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d53:	8b 55 08             	mov    0x8(%ebp),%edx
  800d56:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d59:	29 c2                	sub    %eax,%edx
  800d5b:	89 d0                	mov    %edx,%eax
}
  800d5d:	c9                   	leave  
  800d5e:	c3                   	ret    

00800d5f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d5f:	55                   	push   %ebp
  800d60:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d62:	eb 06                	jmp    800d6a <strcmp+0xb>
		p++, q++;
  800d64:	ff 45 08             	incl   0x8(%ebp)
  800d67:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	8a 00                	mov    (%eax),%al
  800d6f:	84 c0                	test   %al,%al
  800d71:	74 0e                	je     800d81 <strcmp+0x22>
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
  800d76:	8a 10                	mov    (%eax),%dl
  800d78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7b:	8a 00                	mov    (%eax),%al
  800d7d:	38 c2                	cmp    %al,%dl
  800d7f:	74 e3                	je     800d64 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	8a 00                	mov    (%eax),%al
  800d86:	0f b6 d0             	movzbl %al,%edx
  800d89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8c:	8a 00                	mov    (%eax),%al
  800d8e:	0f b6 c0             	movzbl %al,%eax
  800d91:	29 c2                	sub    %eax,%edx
  800d93:	89 d0                	mov    %edx,%eax
}
  800d95:	5d                   	pop    %ebp
  800d96:	c3                   	ret    

00800d97 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d97:	55                   	push   %ebp
  800d98:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d9a:	eb 09                	jmp    800da5 <strncmp+0xe>
		n--, p++, q++;
  800d9c:	ff 4d 10             	decl   0x10(%ebp)
  800d9f:	ff 45 08             	incl   0x8(%ebp)
  800da2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800da5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800da9:	74 17                	je     800dc2 <strncmp+0x2b>
  800dab:	8b 45 08             	mov    0x8(%ebp),%eax
  800dae:	8a 00                	mov    (%eax),%al
  800db0:	84 c0                	test   %al,%al
  800db2:	74 0e                	je     800dc2 <strncmp+0x2b>
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	8a 10                	mov    (%eax),%dl
  800db9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbc:	8a 00                	mov    (%eax),%al
  800dbe:	38 c2                	cmp    %al,%dl
  800dc0:	74 da                	je     800d9c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dc6:	75 07                	jne    800dcf <strncmp+0x38>
		return 0;
  800dc8:	b8 00 00 00 00       	mov    $0x0,%eax
  800dcd:	eb 14                	jmp    800de3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	8a 00                	mov    (%eax),%al
  800dd4:	0f b6 d0             	movzbl %al,%edx
  800dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dda:	8a 00                	mov    (%eax),%al
  800ddc:	0f b6 c0             	movzbl %al,%eax
  800ddf:	29 c2                	sub    %eax,%edx
  800de1:	89 d0                	mov    %edx,%eax
}
  800de3:	5d                   	pop    %ebp
  800de4:	c3                   	ret    

00800de5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800de5:	55                   	push   %ebp
  800de6:	89 e5                	mov    %esp,%ebp
  800de8:	83 ec 04             	sub    $0x4,%esp
  800deb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dee:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800df1:	eb 12                	jmp    800e05 <strchr+0x20>
		if (*s == c)
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	8a 00                	mov    (%eax),%al
  800df8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dfb:	75 05                	jne    800e02 <strchr+0x1d>
			return (char *) s;
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800e00:	eb 11                	jmp    800e13 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e02:	ff 45 08             	incl   0x8(%ebp)
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	8a 00                	mov    (%eax),%al
  800e0a:	84 c0                	test   %al,%al
  800e0c:	75 e5                	jne    800df3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e0e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e13:	c9                   	leave  
  800e14:	c3                   	ret    

00800e15 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e15:	55                   	push   %ebp
  800e16:	89 e5                	mov    %esp,%ebp
  800e18:	83 ec 04             	sub    $0x4,%esp
  800e1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e21:	eb 0d                	jmp    800e30 <strfind+0x1b>
		if (*s == c)
  800e23:	8b 45 08             	mov    0x8(%ebp),%eax
  800e26:	8a 00                	mov    (%eax),%al
  800e28:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e2b:	74 0e                	je     800e3b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e2d:	ff 45 08             	incl   0x8(%ebp)
  800e30:	8b 45 08             	mov    0x8(%ebp),%eax
  800e33:	8a 00                	mov    (%eax),%al
  800e35:	84 c0                	test   %al,%al
  800e37:	75 ea                	jne    800e23 <strfind+0xe>
  800e39:	eb 01                	jmp    800e3c <strfind+0x27>
		if (*s == c)
			break;
  800e3b:	90                   	nop
	return (char *) s;
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e3f:	c9                   	leave  
  800e40:	c3                   	ret    

00800e41 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e41:	55                   	push   %ebp
  800e42:	89 e5                	mov    %esp,%ebp
  800e44:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e50:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e53:	eb 0e                	jmp    800e63 <memset+0x22>
		*p++ = c;
  800e55:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e58:	8d 50 01             	lea    0x1(%eax),%edx
  800e5b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e61:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e63:	ff 4d f8             	decl   -0x8(%ebp)
  800e66:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e6a:	79 e9                	jns    800e55 <memset+0x14>
		*p++ = c;

	return v;
  800e6c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e6f:	c9                   	leave  
  800e70:	c3                   	ret    

00800e71 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e71:	55                   	push   %ebp
  800e72:	89 e5                	mov    %esp,%ebp
  800e74:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e83:	eb 16                	jmp    800e9b <memcpy+0x2a>
		*d++ = *s++;
  800e85:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e88:	8d 50 01             	lea    0x1(%eax),%edx
  800e8b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e8e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e91:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e94:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e97:	8a 12                	mov    (%edx),%dl
  800e99:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea1:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea4:	85 c0                	test   %eax,%eax
  800ea6:	75 dd                	jne    800e85 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ea8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eab:	c9                   	leave  
  800eac:	c3                   	ret    

00800ead <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ead:	55                   	push   %ebp
  800eae:	89 e5                	mov    %esp,%ebp
  800eb0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800eb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ebf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ec5:	73 50                	jae    800f17 <memmove+0x6a>
  800ec7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eca:	8b 45 10             	mov    0x10(%ebp),%eax
  800ecd:	01 d0                	add    %edx,%eax
  800ecf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ed2:	76 43                	jbe    800f17 <memmove+0x6a>
		s += n;
  800ed4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800eda:	8b 45 10             	mov    0x10(%ebp),%eax
  800edd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ee0:	eb 10                	jmp    800ef2 <memmove+0x45>
			*--d = *--s;
  800ee2:	ff 4d f8             	decl   -0x8(%ebp)
  800ee5:	ff 4d fc             	decl   -0x4(%ebp)
  800ee8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eeb:	8a 10                	mov    (%eax),%dl
  800eed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ef2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ef8:	89 55 10             	mov    %edx,0x10(%ebp)
  800efb:	85 c0                	test   %eax,%eax
  800efd:	75 e3                	jne    800ee2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800eff:	eb 23                	jmp    800f24 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f04:	8d 50 01             	lea    0x1(%eax),%edx
  800f07:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f0a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f0d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f10:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f13:	8a 12                	mov    (%edx),%dl
  800f15:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f17:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f1d:	89 55 10             	mov    %edx,0x10(%ebp)
  800f20:	85 c0                	test   %eax,%eax
  800f22:	75 dd                	jne    800f01 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f24:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f27:	c9                   	leave  
  800f28:	c3                   	ret    

00800f29 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f29:	55                   	push   %ebp
  800f2a:	89 e5                	mov    %esp,%ebp
  800f2c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f32:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f38:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f3b:	eb 2a                	jmp    800f67 <memcmp+0x3e>
		if (*s1 != *s2)
  800f3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f40:	8a 10                	mov    (%eax),%dl
  800f42:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f45:	8a 00                	mov    (%eax),%al
  800f47:	38 c2                	cmp    %al,%dl
  800f49:	74 16                	je     800f61 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f4e:	8a 00                	mov    (%eax),%al
  800f50:	0f b6 d0             	movzbl %al,%edx
  800f53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	0f b6 c0             	movzbl %al,%eax
  800f5b:	29 c2                	sub    %eax,%edx
  800f5d:	89 d0                	mov    %edx,%eax
  800f5f:	eb 18                	jmp    800f79 <memcmp+0x50>
		s1++, s2++;
  800f61:	ff 45 fc             	incl   -0x4(%ebp)
  800f64:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f67:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f6d:	89 55 10             	mov    %edx,0x10(%ebp)
  800f70:	85 c0                	test   %eax,%eax
  800f72:	75 c9                	jne    800f3d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f74:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f79:	c9                   	leave  
  800f7a:	c3                   	ret    

00800f7b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f7b:	55                   	push   %ebp
  800f7c:	89 e5                	mov    %esp,%ebp
  800f7e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f81:	8b 55 08             	mov    0x8(%ebp),%edx
  800f84:	8b 45 10             	mov    0x10(%ebp),%eax
  800f87:	01 d0                	add    %edx,%eax
  800f89:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f8c:	eb 15                	jmp    800fa3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	8a 00                	mov    (%eax),%al
  800f93:	0f b6 d0             	movzbl %al,%edx
  800f96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f99:	0f b6 c0             	movzbl %al,%eax
  800f9c:	39 c2                	cmp    %eax,%edx
  800f9e:	74 0d                	je     800fad <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fa0:	ff 45 08             	incl   0x8(%ebp)
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fa9:	72 e3                	jb     800f8e <memfind+0x13>
  800fab:	eb 01                	jmp    800fae <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fad:	90                   	nop
	return (void *) s;
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fb1:	c9                   	leave  
  800fb2:	c3                   	ret    

00800fb3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fb3:	55                   	push   %ebp
  800fb4:	89 e5                	mov    %esp,%ebp
  800fb6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fb9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fc0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fc7:	eb 03                	jmp    800fcc <strtol+0x19>
		s++;
  800fc9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	3c 20                	cmp    $0x20,%al
  800fd3:	74 f4                	je     800fc9 <strtol+0x16>
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	8a 00                	mov    (%eax),%al
  800fda:	3c 09                	cmp    $0x9,%al
  800fdc:	74 eb                	je     800fc9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	8a 00                	mov    (%eax),%al
  800fe3:	3c 2b                	cmp    $0x2b,%al
  800fe5:	75 05                	jne    800fec <strtol+0x39>
		s++;
  800fe7:	ff 45 08             	incl   0x8(%ebp)
  800fea:	eb 13                	jmp    800fff <strtol+0x4c>
	else if (*s == '-')
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	3c 2d                	cmp    $0x2d,%al
  800ff3:	75 0a                	jne    800fff <strtol+0x4c>
		s++, neg = 1;
  800ff5:	ff 45 08             	incl   0x8(%ebp)
  800ff8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801003:	74 06                	je     80100b <strtol+0x58>
  801005:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801009:	75 20                	jne    80102b <strtol+0x78>
  80100b:	8b 45 08             	mov    0x8(%ebp),%eax
  80100e:	8a 00                	mov    (%eax),%al
  801010:	3c 30                	cmp    $0x30,%al
  801012:	75 17                	jne    80102b <strtol+0x78>
  801014:	8b 45 08             	mov    0x8(%ebp),%eax
  801017:	40                   	inc    %eax
  801018:	8a 00                	mov    (%eax),%al
  80101a:	3c 78                	cmp    $0x78,%al
  80101c:	75 0d                	jne    80102b <strtol+0x78>
		s += 2, base = 16;
  80101e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801022:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801029:	eb 28                	jmp    801053 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80102b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80102f:	75 15                	jne    801046 <strtol+0x93>
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	8a 00                	mov    (%eax),%al
  801036:	3c 30                	cmp    $0x30,%al
  801038:	75 0c                	jne    801046 <strtol+0x93>
		s++, base = 8;
  80103a:	ff 45 08             	incl   0x8(%ebp)
  80103d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801044:	eb 0d                	jmp    801053 <strtol+0xa0>
	else if (base == 0)
  801046:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80104a:	75 07                	jne    801053 <strtol+0xa0>
		base = 10;
  80104c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8a 00                	mov    (%eax),%al
  801058:	3c 2f                	cmp    $0x2f,%al
  80105a:	7e 19                	jle    801075 <strtol+0xc2>
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	8a 00                	mov    (%eax),%al
  801061:	3c 39                	cmp    $0x39,%al
  801063:	7f 10                	jg     801075 <strtol+0xc2>
			dig = *s - '0';
  801065:	8b 45 08             	mov    0x8(%ebp),%eax
  801068:	8a 00                	mov    (%eax),%al
  80106a:	0f be c0             	movsbl %al,%eax
  80106d:	83 e8 30             	sub    $0x30,%eax
  801070:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801073:	eb 42                	jmp    8010b7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	8a 00                	mov    (%eax),%al
  80107a:	3c 60                	cmp    $0x60,%al
  80107c:	7e 19                	jle    801097 <strtol+0xe4>
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	8a 00                	mov    (%eax),%al
  801083:	3c 7a                	cmp    $0x7a,%al
  801085:	7f 10                	jg     801097 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	8a 00                	mov    (%eax),%al
  80108c:	0f be c0             	movsbl %al,%eax
  80108f:	83 e8 57             	sub    $0x57,%eax
  801092:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801095:	eb 20                	jmp    8010b7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801097:	8b 45 08             	mov    0x8(%ebp),%eax
  80109a:	8a 00                	mov    (%eax),%al
  80109c:	3c 40                	cmp    $0x40,%al
  80109e:	7e 39                	jle    8010d9 <strtol+0x126>
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a3:	8a 00                	mov    (%eax),%al
  8010a5:	3c 5a                	cmp    $0x5a,%al
  8010a7:	7f 30                	jg     8010d9 <strtol+0x126>
			dig = *s - 'A' + 10;
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	8a 00                	mov    (%eax),%al
  8010ae:	0f be c0             	movsbl %al,%eax
  8010b1:	83 e8 37             	sub    $0x37,%eax
  8010b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010ba:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010bd:	7d 19                	jge    8010d8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010bf:	ff 45 08             	incl   0x8(%ebp)
  8010c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c5:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010c9:	89 c2                	mov    %eax,%edx
  8010cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010ce:	01 d0                	add    %edx,%eax
  8010d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010d3:	e9 7b ff ff ff       	jmp    801053 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010d8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010dd:	74 08                	je     8010e7 <strtol+0x134>
		*endptr = (char *) s;
  8010df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e2:	8b 55 08             	mov    0x8(%ebp),%edx
  8010e5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010e7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010eb:	74 07                	je     8010f4 <strtol+0x141>
  8010ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f0:	f7 d8                	neg    %eax
  8010f2:	eb 03                	jmp    8010f7 <strtol+0x144>
  8010f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010f7:	c9                   	leave  
  8010f8:	c3                   	ret    

008010f9 <ltostr>:

void
ltostr(long value, char *str)
{
  8010f9:	55                   	push   %ebp
  8010fa:	89 e5                	mov    %esp,%ebp
  8010fc:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801106:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80110d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801111:	79 13                	jns    801126 <ltostr+0x2d>
	{
		neg = 1;
  801113:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80111a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801120:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801123:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80112e:	99                   	cltd   
  80112f:	f7 f9                	idiv   %ecx
  801131:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801134:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801137:	8d 50 01             	lea    0x1(%eax),%edx
  80113a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80113d:	89 c2                	mov    %eax,%edx
  80113f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801142:	01 d0                	add    %edx,%eax
  801144:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801147:	83 c2 30             	add    $0x30,%edx
  80114a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80114c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80114f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801154:	f7 e9                	imul   %ecx
  801156:	c1 fa 02             	sar    $0x2,%edx
  801159:	89 c8                	mov    %ecx,%eax
  80115b:	c1 f8 1f             	sar    $0x1f,%eax
  80115e:	29 c2                	sub    %eax,%edx
  801160:	89 d0                	mov    %edx,%eax
  801162:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801165:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801168:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80116d:	f7 e9                	imul   %ecx
  80116f:	c1 fa 02             	sar    $0x2,%edx
  801172:	89 c8                	mov    %ecx,%eax
  801174:	c1 f8 1f             	sar    $0x1f,%eax
  801177:	29 c2                	sub    %eax,%edx
  801179:	89 d0                	mov    %edx,%eax
  80117b:	c1 e0 02             	shl    $0x2,%eax
  80117e:	01 d0                	add    %edx,%eax
  801180:	01 c0                	add    %eax,%eax
  801182:	29 c1                	sub    %eax,%ecx
  801184:	89 ca                	mov    %ecx,%edx
  801186:	85 d2                	test   %edx,%edx
  801188:	75 9c                	jne    801126 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80118a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801191:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801194:	48                   	dec    %eax
  801195:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801198:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80119c:	74 3d                	je     8011db <ltostr+0xe2>
		start = 1 ;
  80119e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011a5:	eb 34                	jmp    8011db <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ad:	01 d0                	add    %edx,%eax
  8011af:	8a 00                	mov    (%eax),%al
  8011b1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ba:	01 c2                	add    %eax,%edx
  8011bc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c2:	01 c8                	add    %ecx,%eax
  8011c4:	8a 00                	mov    (%eax),%al
  8011c6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ce:	01 c2                	add    %eax,%edx
  8011d0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011d3:	88 02                	mov    %al,(%edx)
		start++ ;
  8011d5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011d8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011e1:	7c c4                	jl     8011a7 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e9:	01 d0                	add    %edx,%eax
  8011eb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011ee:	90                   	nop
  8011ef:	c9                   	leave  
  8011f0:	c3                   	ret    

008011f1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011f1:	55                   	push   %ebp
  8011f2:	89 e5                	mov    %esp,%ebp
  8011f4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011f7:	ff 75 08             	pushl  0x8(%ebp)
  8011fa:	e8 54 fa ff ff       	call   800c53 <strlen>
  8011ff:	83 c4 04             	add    $0x4,%esp
  801202:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801205:	ff 75 0c             	pushl  0xc(%ebp)
  801208:	e8 46 fa ff ff       	call   800c53 <strlen>
  80120d:	83 c4 04             	add    $0x4,%esp
  801210:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801213:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80121a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801221:	eb 17                	jmp    80123a <strcconcat+0x49>
		final[s] = str1[s] ;
  801223:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801226:	8b 45 10             	mov    0x10(%ebp),%eax
  801229:	01 c2                	add    %eax,%edx
  80122b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	01 c8                	add    %ecx,%eax
  801233:	8a 00                	mov    (%eax),%al
  801235:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801237:	ff 45 fc             	incl   -0x4(%ebp)
  80123a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80123d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801240:	7c e1                	jl     801223 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801242:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801249:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801250:	eb 1f                	jmp    801271 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801252:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801255:	8d 50 01             	lea    0x1(%eax),%edx
  801258:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80125b:	89 c2                	mov    %eax,%edx
  80125d:	8b 45 10             	mov    0x10(%ebp),%eax
  801260:	01 c2                	add    %eax,%edx
  801262:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801265:	8b 45 0c             	mov    0xc(%ebp),%eax
  801268:	01 c8                	add    %ecx,%eax
  80126a:	8a 00                	mov    (%eax),%al
  80126c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80126e:	ff 45 f8             	incl   -0x8(%ebp)
  801271:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801274:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801277:	7c d9                	jl     801252 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801279:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80127c:	8b 45 10             	mov    0x10(%ebp),%eax
  80127f:	01 d0                	add    %edx,%eax
  801281:	c6 00 00             	movb   $0x0,(%eax)
}
  801284:	90                   	nop
  801285:	c9                   	leave  
  801286:	c3                   	ret    

00801287 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801287:	55                   	push   %ebp
  801288:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80128a:	8b 45 14             	mov    0x14(%ebp),%eax
  80128d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801293:	8b 45 14             	mov    0x14(%ebp),%eax
  801296:	8b 00                	mov    (%eax),%eax
  801298:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80129f:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a2:	01 d0                	add    %edx,%eax
  8012a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012aa:	eb 0c                	jmp    8012b8 <strsplit+0x31>
			*string++ = 0;
  8012ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8012af:	8d 50 01             	lea    0x1(%eax),%edx
  8012b2:	89 55 08             	mov    %edx,0x8(%ebp)
  8012b5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bb:	8a 00                	mov    (%eax),%al
  8012bd:	84 c0                	test   %al,%al
  8012bf:	74 18                	je     8012d9 <strsplit+0x52>
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	8a 00                	mov    (%eax),%al
  8012c6:	0f be c0             	movsbl %al,%eax
  8012c9:	50                   	push   %eax
  8012ca:	ff 75 0c             	pushl  0xc(%ebp)
  8012cd:	e8 13 fb ff ff       	call   800de5 <strchr>
  8012d2:	83 c4 08             	add    $0x8,%esp
  8012d5:	85 c0                	test   %eax,%eax
  8012d7:	75 d3                	jne    8012ac <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	8a 00                	mov    (%eax),%al
  8012de:	84 c0                	test   %al,%al
  8012e0:	74 5a                	je     80133c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8012e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8012e5:	8b 00                	mov    (%eax),%eax
  8012e7:	83 f8 0f             	cmp    $0xf,%eax
  8012ea:	75 07                	jne    8012f3 <strsplit+0x6c>
		{
			return 0;
  8012ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8012f1:	eb 66                	jmp    801359 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8012f6:	8b 00                	mov    (%eax),%eax
  8012f8:	8d 48 01             	lea    0x1(%eax),%ecx
  8012fb:	8b 55 14             	mov    0x14(%ebp),%edx
  8012fe:	89 0a                	mov    %ecx,(%edx)
  801300:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801307:	8b 45 10             	mov    0x10(%ebp),%eax
  80130a:	01 c2                	add    %eax,%edx
  80130c:	8b 45 08             	mov    0x8(%ebp),%eax
  80130f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801311:	eb 03                	jmp    801316 <strsplit+0x8f>
			string++;
  801313:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801316:	8b 45 08             	mov    0x8(%ebp),%eax
  801319:	8a 00                	mov    (%eax),%al
  80131b:	84 c0                	test   %al,%al
  80131d:	74 8b                	je     8012aa <strsplit+0x23>
  80131f:	8b 45 08             	mov    0x8(%ebp),%eax
  801322:	8a 00                	mov    (%eax),%al
  801324:	0f be c0             	movsbl %al,%eax
  801327:	50                   	push   %eax
  801328:	ff 75 0c             	pushl  0xc(%ebp)
  80132b:	e8 b5 fa ff ff       	call   800de5 <strchr>
  801330:	83 c4 08             	add    $0x8,%esp
  801333:	85 c0                	test   %eax,%eax
  801335:	74 dc                	je     801313 <strsplit+0x8c>
			string++;
	}
  801337:	e9 6e ff ff ff       	jmp    8012aa <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80133c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80133d:	8b 45 14             	mov    0x14(%ebp),%eax
  801340:	8b 00                	mov    (%eax),%eax
  801342:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801349:	8b 45 10             	mov    0x10(%ebp),%eax
  80134c:	01 d0                	add    %edx,%eax
  80134e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801354:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801359:	c9                   	leave  
  80135a:	c3                   	ret    

0080135b <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  80135b:	55                   	push   %ebp
  80135c:	89 e5                	mov    %esp,%ebp
  80135e:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	c1 e8 0c             	shr    $0xc,%eax
  801367:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	25 ff 0f 00 00       	and    $0xfff,%eax
  801372:	85 c0                	test   %eax,%eax
  801374:	74 03                	je     801379 <malloc+0x1e>
			num++;
  801376:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801379:	a1 04 30 80 00       	mov    0x803004,%eax
  80137e:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801383:	75 64                	jne    8013e9 <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801385:	83 ec 08             	sub    $0x8,%esp
  801388:	ff 75 08             	pushl  0x8(%ebp)
  80138b:	68 00 00 00 80       	push   $0x80000000
  801390:	e8 3a 04 00 00       	call   8017cf <sys_allocateMem>
  801395:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801398:	a1 04 30 80 00       	mov    0x803004,%eax
  80139d:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8013a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013a3:	c1 e0 0c             	shl    $0xc,%eax
  8013a6:	89 c2                	mov    %eax,%edx
  8013a8:	a1 04 30 80 00       	mov    0x803004,%eax
  8013ad:	01 d0                	add    %edx,%eax
  8013af:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  8013b4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013b9:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8013bf:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8013c6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013cb:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  8013d2:	01 00 00 00 
			sizeofarray++;
  8013d6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013db:	40                   	inc    %eax
  8013dc:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  8013e1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8013e4:	e9 26 01 00 00       	jmp    80150f <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  8013e9:	a1 28 30 80 00       	mov    0x803028,%eax
  8013ee:	85 c0                	test   %eax,%eax
  8013f0:	75 62                	jne    801454 <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  8013f2:	a1 04 30 80 00       	mov    0x803004,%eax
  8013f7:	83 ec 08             	sub    $0x8,%esp
  8013fa:	ff 75 08             	pushl  0x8(%ebp)
  8013fd:	50                   	push   %eax
  8013fe:	e8 cc 03 00 00       	call   8017cf <sys_allocateMem>
  801403:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801406:	a1 04 30 80 00       	mov    0x803004,%eax
  80140b:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  80140e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801411:	c1 e0 0c             	shl    $0xc,%eax
  801414:	89 c2                	mov    %eax,%edx
  801416:	a1 04 30 80 00       	mov    0x803004,%eax
  80141b:	01 d0                	add    %edx,%eax
  80141d:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  801422:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801427:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80142a:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801431:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801436:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  80143d:	01 00 00 00 
				sizeofarray++;
  801441:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801446:	40                   	inc    %eax
  801447:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  80144c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80144f:	e9 bb 00 00 00       	jmp    80150f <malloc+0x1b4>
			}
			else{
				int count=0;
  801454:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  80145b:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801462:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801469:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801470:	eb 7c                	jmp    8014ee <malloc+0x193>
				{
					uint32 *pg=NULL;
  801472:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801479:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801480:	eb 1a                	jmp    80149c <malloc+0x141>
					{
						if(addresses[j]==i)
  801482:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801485:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80148c:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80148f:	75 08                	jne    801499 <malloc+0x13e>
						{
							index=j;
  801491:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801494:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801497:	eb 0d                	jmp    8014a6 <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801499:	ff 45 dc             	incl   -0x24(%ebp)
  80149c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014a1:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8014a4:	7c dc                	jl     801482 <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  8014a6:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8014aa:	75 05                	jne    8014b1 <malloc+0x156>
					{
						count++;
  8014ac:	ff 45 f0             	incl   -0x10(%ebp)
  8014af:	eb 36                	jmp    8014e7 <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  8014b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014b4:	8b 04 85 c0 32 80 00 	mov    0x8032c0(,%eax,4),%eax
  8014bb:	85 c0                	test   %eax,%eax
  8014bd:	75 05                	jne    8014c4 <malloc+0x169>
						{
							count++;
  8014bf:	ff 45 f0             	incl   -0x10(%ebp)
  8014c2:	eb 23                	jmp    8014e7 <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  8014c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014c7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8014ca:	7d 14                	jge    8014e0 <malloc+0x185>
  8014cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014d2:	7c 0c                	jl     8014e0 <malloc+0x185>
							{
								min=count;
  8014d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8014da:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8014e0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8014e7:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8014ee:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8014f5:	0f 86 77 ff ff ff    	jbe    801472 <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  8014fb:	83 ec 08             	sub    $0x8,%esp
  8014fe:	ff 75 08             	pushl  0x8(%ebp)
  801501:	ff 75 e4             	pushl  -0x1c(%ebp)
  801504:	e8 c6 02 00 00       	call   8017cf <sys_allocateMem>
  801509:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  80150c:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  80150f:	c9                   	leave  
  801510:	c3                   	ret    

00801511 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801511:	55                   	push   %ebp
  801512:	89 e5                	mov    %esp,%ebp
  801514:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801517:	83 ec 04             	sub    $0x4,%esp
  80151a:	68 70 25 80 00       	push   $0x802570
  80151f:	6a 7b                	push   $0x7b
  801521:	68 93 25 80 00       	push   $0x802593
  801526:	e8 04 ee ff ff       	call   80032f <_panic>

0080152b <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
  80152e:	83 ec 18             	sub    $0x18,%esp
  801531:	8b 45 10             	mov    0x10(%ebp),%eax
  801534:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801537:	83 ec 04             	sub    $0x4,%esp
  80153a:	68 a0 25 80 00       	push   $0x8025a0
  80153f:	68 88 00 00 00       	push   $0x88
  801544:	68 93 25 80 00       	push   $0x802593
  801549:	e8 e1 ed ff ff       	call   80032f <_panic>

0080154e <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
  801551:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801554:	83 ec 04             	sub    $0x4,%esp
  801557:	68 a0 25 80 00       	push   $0x8025a0
  80155c:	68 8e 00 00 00       	push   $0x8e
  801561:	68 93 25 80 00       	push   $0x802593
  801566:	e8 c4 ed ff ff       	call   80032f <_panic>

0080156b <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80156b:	55                   	push   %ebp
  80156c:	89 e5                	mov    %esp,%ebp
  80156e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801571:	83 ec 04             	sub    $0x4,%esp
  801574:	68 a0 25 80 00       	push   $0x8025a0
  801579:	68 94 00 00 00       	push   $0x94
  80157e:	68 93 25 80 00       	push   $0x802593
  801583:	e8 a7 ed ff ff       	call   80032f <_panic>

00801588 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801588:	55                   	push   %ebp
  801589:	89 e5                	mov    %esp,%ebp
  80158b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80158e:	83 ec 04             	sub    $0x4,%esp
  801591:	68 a0 25 80 00       	push   $0x8025a0
  801596:	68 99 00 00 00       	push   $0x99
  80159b:	68 93 25 80 00       	push   $0x802593
  8015a0:	e8 8a ed ff ff       	call   80032f <_panic>

008015a5 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8015a5:	55                   	push   %ebp
  8015a6:	89 e5                	mov    %esp,%ebp
  8015a8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015ab:	83 ec 04             	sub    $0x4,%esp
  8015ae:	68 a0 25 80 00       	push   $0x8025a0
  8015b3:	68 9f 00 00 00       	push   $0x9f
  8015b8:	68 93 25 80 00       	push   $0x802593
  8015bd:	e8 6d ed ff ff       	call   80032f <_panic>

008015c2 <shrink>:
}
void shrink(uint32 newSize)
{
  8015c2:	55                   	push   %ebp
  8015c3:	89 e5                	mov    %esp,%ebp
  8015c5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015c8:	83 ec 04             	sub    $0x4,%esp
  8015cb:	68 a0 25 80 00       	push   $0x8025a0
  8015d0:	68 a3 00 00 00       	push   $0xa3
  8015d5:	68 93 25 80 00       	push   $0x802593
  8015da:	e8 50 ed ff ff       	call   80032f <_panic>

008015df <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8015df:	55                   	push   %ebp
  8015e0:	89 e5                	mov    %esp,%ebp
  8015e2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015e5:	83 ec 04             	sub    $0x4,%esp
  8015e8:	68 a0 25 80 00       	push   $0x8025a0
  8015ed:	68 a8 00 00 00       	push   $0xa8
  8015f2:	68 93 25 80 00       	push   $0x802593
  8015f7:	e8 33 ed ff ff       	call   80032f <_panic>

008015fc <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015fc:	55                   	push   %ebp
  8015fd:	89 e5                	mov    %esp,%ebp
  8015ff:	57                   	push   %edi
  801600:	56                   	push   %esi
  801601:	53                   	push   %ebx
  801602:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801605:	8b 45 08             	mov    0x8(%ebp),%eax
  801608:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80160e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801611:	8b 7d 18             	mov    0x18(%ebp),%edi
  801614:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801617:	cd 30                	int    $0x30
  801619:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80161c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80161f:	83 c4 10             	add    $0x10,%esp
  801622:	5b                   	pop    %ebx
  801623:	5e                   	pop    %esi
  801624:	5f                   	pop    %edi
  801625:	5d                   	pop    %ebp
  801626:	c3                   	ret    

00801627 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801627:	55                   	push   %ebp
  801628:	89 e5                	mov    %esp,%ebp
  80162a:	83 ec 04             	sub    $0x4,%esp
  80162d:	8b 45 10             	mov    0x10(%ebp),%eax
  801630:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801633:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	52                   	push   %edx
  80163f:	ff 75 0c             	pushl  0xc(%ebp)
  801642:	50                   	push   %eax
  801643:	6a 00                	push   $0x0
  801645:	e8 b2 ff ff ff       	call   8015fc <syscall>
  80164a:	83 c4 18             	add    $0x18,%esp
}
  80164d:	90                   	nop
  80164e:	c9                   	leave  
  80164f:	c3                   	ret    

00801650 <sys_cgetc>:

int
sys_cgetc(void)
{
  801650:	55                   	push   %ebp
  801651:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 01                	push   $0x1
  80165f:	e8 98 ff ff ff       	call   8015fc <syscall>
  801664:	83 c4 18             	add    $0x18,%esp
}
  801667:	c9                   	leave  
  801668:	c3                   	ret    

00801669 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801669:	55                   	push   %ebp
  80166a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	50                   	push   %eax
  801678:	6a 05                	push   $0x5
  80167a:	e8 7d ff ff ff       	call   8015fc <syscall>
  80167f:	83 c4 18             	add    $0x18,%esp
}
  801682:	c9                   	leave  
  801683:	c3                   	ret    

00801684 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801684:	55                   	push   %ebp
  801685:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 02                	push   $0x2
  801693:	e8 64 ff ff ff       	call   8015fc <syscall>
  801698:	83 c4 18             	add    $0x18,%esp
}
  80169b:	c9                   	leave  
  80169c:	c3                   	ret    

0080169d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 03                	push   $0x3
  8016ac:	e8 4b ff ff ff       	call   8015fc <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
}
  8016b4:	c9                   	leave  
  8016b5:	c3                   	ret    

008016b6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8016b6:	55                   	push   %ebp
  8016b7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 04                	push   $0x4
  8016c5:	e8 32 ff ff ff       	call   8015fc <syscall>
  8016ca:	83 c4 18             	add    $0x18,%esp
}
  8016cd:	c9                   	leave  
  8016ce:	c3                   	ret    

008016cf <sys_env_exit>:


void sys_env_exit(void)
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 06                	push   $0x6
  8016de:	e8 19 ff ff ff       	call   8015fc <syscall>
  8016e3:	83 c4 18             	add    $0x18,%esp
}
  8016e6:	90                   	nop
  8016e7:	c9                   	leave  
  8016e8:	c3                   	ret    

008016e9 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016e9:	55                   	push   %ebp
  8016ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	52                   	push   %edx
  8016f9:	50                   	push   %eax
  8016fa:	6a 07                	push   $0x7
  8016fc:	e8 fb fe ff ff       	call   8015fc <syscall>
  801701:	83 c4 18             	add    $0x18,%esp
}
  801704:	c9                   	leave  
  801705:	c3                   	ret    

00801706 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801706:	55                   	push   %ebp
  801707:	89 e5                	mov    %esp,%ebp
  801709:	56                   	push   %esi
  80170a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80170b:	8b 75 18             	mov    0x18(%ebp),%esi
  80170e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801711:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801714:	8b 55 0c             	mov    0xc(%ebp),%edx
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	56                   	push   %esi
  80171b:	53                   	push   %ebx
  80171c:	51                   	push   %ecx
  80171d:	52                   	push   %edx
  80171e:	50                   	push   %eax
  80171f:	6a 08                	push   $0x8
  801721:	e8 d6 fe ff ff       	call   8015fc <syscall>
  801726:	83 c4 18             	add    $0x18,%esp
}
  801729:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80172c:	5b                   	pop    %ebx
  80172d:	5e                   	pop    %esi
  80172e:	5d                   	pop    %ebp
  80172f:	c3                   	ret    

00801730 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801733:	8b 55 0c             	mov    0xc(%ebp),%edx
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	52                   	push   %edx
  801740:	50                   	push   %eax
  801741:	6a 09                	push   $0x9
  801743:	e8 b4 fe ff ff       	call   8015fc <syscall>
  801748:	83 c4 18             	add    $0x18,%esp
}
  80174b:	c9                   	leave  
  80174c:	c3                   	ret    

0080174d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80174d:	55                   	push   %ebp
  80174e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	ff 75 0c             	pushl  0xc(%ebp)
  801759:	ff 75 08             	pushl  0x8(%ebp)
  80175c:	6a 0a                	push   $0xa
  80175e:	e8 99 fe ff ff       	call   8015fc <syscall>
  801763:	83 c4 18             	add    $0x18,%esp
}
  801766:	c9                   	leave  
  801767:	c3                   	ret    

00801768 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801768:	55                   	push   %ebp
  801769:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 0b                	push   $0xb
  801777:	e8 80 fe ff ff       	call   8015fc <syscall>
  80177c:	83 c4 18             	add    $0x18,%esp
}
  80177f:	c9                   	leave  
  801780:	c3                   	ret    

00801781 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801781:	55                   	push   %ebp
  801782:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 0c                	push   $0xc
  801790:	e8 67 fe ff ff       	call   8015fc <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
}
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 0d                	push   $0xd
  8017a9:	e8 4e fe ff ff       	call   8015fc <syscall>
  8017ae:	83 c4 18             	add    $0x18,%esp
}
  8017b1:	c9                   	leave  
  8017b2:	c3                   	ret    

008017b3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8017b3:	55                   	push   %ebp
  8017b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	ff 75 0c             	pushl  0xc(%ebp)
  8017bf:	ff 75 08             	pushl  0x8(%ebp)
  8017c2:	6a 11                	push   $0x11
  8017c4:	e8 33 fe ff ff       	call   8015fc <syscall>
  8017c9:	83 c4 18             	add    $0x18,%esp
	return;
  8017cc:	90                   	nop
}
  8017cd:	c9                   	leave  
  8017ce:	c3                   	ret    

008017cf <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8017cf:	55                   	push   %ebp
  8017d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	ff 75 0c             	pushl  0xc(%ebp)
  8017db:	ff 75 08             	pushl  0x8(%ebp)
  8017de:	6a 12                	push   $0x12
  8017e0:	e8 17 fe ff ff       	call   8015fc <syscall>
  8017e5:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e8:	90                   	nop
}
  8017e9:	c9                   	leave  
  8017ea:	c3                   	ret    

008017eb <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017eb:	55                   	push   %ebp
  8017ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 0e                	push   $0xe
  8017fa:	e8 fd fd ff ff       	call   8015fc <syscall>
  8017ff:	83 c4 18             	add    $0x18,%esp
}
  801802:	c9                   	leave  
  801803:	c3                   	ret    

00801804 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801804:	55                   	push   %ebp
  801805:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	ff 75 08             	pushl  0x8(%ebp)
  801812:	6a 0f                	push   $0xf
  801814:	e8 e3 fd ff ff       	call   8015fc <syscall>
  801819:	83 c4 18             	add    $0x18,%esp
}
  80181c:	c9                   	leave  
  80181d:	c3                   	ret    

0080181e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80181e:	55                   	push   %ebp
  80181f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	6a 00                	push   $0x0
  80182b:	6a 10                	push   $0x10
  80182d:	e8 ca fd ff ff       	call   8015fc <syscall>
  801832:	83 c4 18             	add    $0x18,%esp
}
  801835:	90                   	nop
  801836:	c9                   	leave  
  801837:	c3                   	ret    

00801838 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801838:	55                   	push   %ebp
  801839:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 14                	push   $0x14
  801847:	e8 b0 fd ff ff       	call   8015fc <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
}
  80184f:	90                   	nop
  801850:	c9                   	leave  
  801851:	c3                   	ret    

00801852 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801852:	55                   	push   %ebp
  801853:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 15                	push   $0x15
  801861:	e8 96 fd ff ff       	call   8015fc <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
}
  801869:	90                   	nop
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <sys_cputc>:


void
sys_cputc(const char c)
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
  80186f:	83 ec 04             	sub    $0x4,%esp
  801872:	8b 45 08             	mov    0x8(%ebp),%eax
  801875:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801878:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	50                   	push   %eax
  801885:	6a 16                	push   $0x16
  801887:	e8 70 fd ff ff       	call   8015fc <syscall>
  80188c:	83 c4 18             	add    $0x18,%esp
}
  80188f:	90                   	nop
  801890:	c9                   	leave  
  801891:	c3                   	ret    

00801892 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801892:	55                   	push   %ebp
  801893:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 17                	push   $0x17
  8018a1:	e8 56 fd ff ff       	call   8015fc <syscall>
  8018a6:	83 c4 18             	add    $0x18,%esp
}
  8018a9:	90                   	nop
  8018aa:	c9                   	leave  
  8018ab:	c3                   	ret    

008018ac <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8018ac:	55                   	push   %ebp
  8018ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8018af:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	ff 75 0c             	pushl  0xc(%ebp)
  8018bb:	50                   	push   %eax
  8018bc:	6a 18                	push   $0x18
  8018be:	e8 39 fd ff ff       	call   8015fc <syscall>
  8018c3:	83 c4 18             	add    $0x18,%esp
}
  8018c6:	c9                   	leave  
  8018c7:	c3                   	ret    

008018c8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8018c8:	55                   	push   %ebp
  8018c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	52                   	push   %edx
  8018d8:	50                   	push   %eax
  8018d9:	6a 1b                	push   $0x1b
  8018db:	e8 1c fd ff ff       	call   8015fc <syscall>
  8018e0:	83 c4 18             	add    $0x18,%esp
}
  8018e3:	c9                   	leave  
  8018e4:	c3                   	ret    

008018e5 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018e5:	55                   	push   %ebp
  8018e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	52                   	push   %edx
  8018f5:	50                   	push   %eax
  8018f6:	6a 19                	push   $0x19
  8018f8:	e8 ff fc ff ff       	call   8015fc <syscall>
  8018fd:	83 c4 18             	add    $0x18,%esp
}
  801900:	90                   	nop
  801901:	c9                   	leave  
  801902:	c3                   	ret    

00801903 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801903:	55                   	push   %ebp
  801904:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801906:	8b 55 0c             	mov    0xc(%ebp),%edx
  801909:	8b 45 08             	mov    0x8(%ebp),%eax
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	52                   	push   %edx
  801913:	50                   	push   %eax
  801914:	6a 1a                	push   $0x1a
  801916:	e8 e1 fc ff ff       	call   8015fc <syscall>
  80191b:	83 c4 18             	add    $0x18,%esp
}
  80191e:	90                   	nop
  80191f:	c9                   	leave  
  801920:	c3                   	ret    

00801921 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801921:	55                   	push   %ebp
  801922:	89 e5                	mov    %esp,%ebp
  801924:	83 ec 04             	sub    $0x4,%esp
  801927:	8b 45 10             	mov    0x10(%ebp),%eax
  80192a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80192d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801930:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801934:	8b 45 08             	mov    0x8(%ebp),%eax
  801937:	6a 00                	push   $0x0
  801939:	51                   	push   %ecx
  80193a:	52                   	push   %edx
  80193b:	ff 75 0c             	pushl  0xc(%ebp)
  80193e:	50                   	push   %eax
  80193f:	6a 1c                	push   $0x1c
  801941:	e8 b6 fc ff ff       	call   8015fc <syscall>
  801946:	83 c4 18             	add    $0x18,%esp
}
  801949:	c9                   	leave  
  80194a:	c3                   	ret    

0080194b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80194b:	55                   	push   %ebp
  80194c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80194e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801951:	8b 45 08             	mov    0x8(%ebp),%eax
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	52                   	push   %edx
  80195b:	50                   	push   %eax
  80195c:	6a 1d                	push   $0x1d
  80195e:	e8 99 fc ff ff       	call   8015fc <syscall>
  801963:	83 c4 18             	add    $0x18,%esp
}
  801966:	c9                   	leave  
  801967:	c3                   	ret    

00801968 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801968:	55                   	push   %ebp
  801969:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80196b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80196e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801971:	8b 45 08             	mov    0x8(%ebp),%eax
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	51                   	push   %ecx
  801979:	52                   	push   %edx
  80197a:	50                   	push   %eax
  80197b:	6a 1e                	push   $0x1e
  80197d:	e8 7a fc ff ff       	call   8015fc <syscall>
  801982:	83 c4 18             	add    $0x18,%esp
}
  801985:	c9                   	leave  
  801986:	c3                   	ret    

00801987 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801987:	55                   	push   %ebp
  801988:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80198a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80198d:	8b 45 08             	mov    0x8(%ebp),%eax
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	52                   	push   %edx
  801997:	50                   	push   %eax
  801998:	6a 1f                	push   $0x1f
  80199a:	e8 5d fc ff ff       	call   8015fc <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
}
  8019a2:	c9                   	leave  
  8019a3:	c3                   	ret    

008019a4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8019a4:	55                   	push   %ebp
  8019a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 20                	push   $0x20
  8019b3:	e8 44 fc ff ff       	call   8015fc <syscall>
  8019b8:	83 c4 18             	add    $0x18,%esp
}
  8019bb:	c9                   	leave  
  8019bc:	c3                   	ret    

008019bd <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8019bd:	55                   	push   %ebp
  8019be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8019c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c3:	6a 00                	push   $0x0
  8019c5:	ff 75 14             	pushl  0x14(%ebp)
  8019c8:	ff 75 10             	pushl  0x10(%ebp)
  8019cb:	ff 75 0c             	pushl  0xc(%ebp)
  8019ce:	50                   	push   %eax
  8019cf:	6a 21                	push   $0x21
  8019d1:	e8 26 fc ff ff       	call   8015fc <syscall>
  8019d6:	83 c4 18             	add    $0x18,%esp
}
  8019d9:	c9                   	leave  
  8019da:	c3                   	ret    

008019db <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8019db:	55                   	push   %ebp
  8019dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019de:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	50                   	push   %eax
  8019ea:	6a 22                	push   $0x22
  8019ec:	e8 0b fc ff ff       	call   8015fc <syscall>
  8019f1:	83 c4 18             	add    $0x18,%esp
}
  8019f4:	90                   	nop
  8019f5:	c9                   	leave  
  8019f6:	c3                   	ret    

008019f7 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8019f7:	55                   	push   %ebp
  8019f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8019fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	50                   	push   %eax
  801a06:	6a 23                	push   $0x23
  801a08:	e8 ef fb ff ff       	call   8015fc <syscall>
  801a0d:	83 c4 18             	add    $0x18,%esp
}
  801a10:	90                   	nop
  801a11:	c9                   	leave  
  801a12:	c3                   	ret    

00801a13 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a13:	55                   	push   %ebp
  801a14:	89 e5                	mov    %esp,%ebp
  801a16:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a19:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a1c:	8d 50 04             	lea    0x4(%eax),%edx
  801a1f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	52                   	push   %edx
  801a29:	50                   	push   %eax
  801a2a:	6a 24                	push   $0x24
  801a2c:	e8 cb fb ff ff       	call   8015fc <syscall>
  801a31:	83 c4 18             	add    $0x18,%esp
	return result;
  801a34:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a37:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a3a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a3d:	89 01                	mov    %eax,(%ecx)
  801a3f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a42:	8b 45 08             	mov    0x8(%ebp),%eax
  801a45:	c9                   	leave  
  801a46:	c2 04 00             	ret    $0x4

00801a49 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a49:	55                   	push   %ebp
  801a4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	ff 75 10             	pushl  0x10(%ebp)
  801a53:	ff 75 0c             	pushl  0xc(%ebp)
  801a56:	ff 75 08             	pushl  0x8(%ebp)
  801a59:	6a 13                	push   $0x13
  801a5b:	e8 9c fb ff ff       	call   8015fc <syscall>
  801a60:	83 c4 18             	add    $0x18,%esp
	return ;
  801a63:	90                   	nop
}
  801a64:	c9                   	leave  
  801a65:	c3                   	ret    

00801a66 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a66:	55                   	push   %ebp
  801a67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 25                	push   $0x25
  801a75:	e8 82 fb ff ff       	call   8015fc <syscall>
  801a7a:	83 c4 18             	add    $0x18,%esp
}
  801a7d:	c9                   	leave  
  801a7e:	c3                   	ret    

00801a7f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a7f:	55                   	push   %ebp
  801a80:	89 e5                	mov    %esp,%ebp
  801a82:	83 ec 04             	sub    $0x4,%esp
  801a85:	8b 45 08             	mov    0x8(%ebp),%eax
  801a88:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a8b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	50                   	push   %eax
  801a98:	6a 26                	push   $0x26
  801a9a:	e8 5d fb ff ff       	call   8015fc <syscall>
  801a9f:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa2:	90                   	nop
}
  801aa3:	c9                   	leave  
  801aa4:	c3                   	ret    

00801aa5 <rsttst>:
void rsttst()
{
  801aa5:	55                   	push   %ebp
  801aa6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 28                	push   $0x28
  801ab4:	e8 43 fb ff ff       	call   8015fc <syscall>
  801ab9:	83 c4 18             	add    $0x18,%esp
	return ;
  801abc:	90                   	nop
}
  801abd:	c9                   	leave  
  801abe:	c3                   	ret    

00801abf <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801abf:	55                   	push   %ebp
  801ac0:	89 e5                	mov    %esp,%ebp
  801ac2:	83 ec 04             	sub    $0x4,%esp
  801ac5:	8b 45 14             	mov    0x14(%ebp),%eax
  801ac8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801acb:	8b 55 18             	mov    0x18(%ebp),%edx
  801ace:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ad2:	52                   	push   %edx
  801ad3:	50                   	push   %eax
  801ad4:	ff 75 10             	pushl  0x10(%ebp)
  801ad7:	ff 75 0c             	pushl  0xc(%ebp)
  801ada:	ff 75 08             	pushl  0x8(%ebp)
  801add:	6a 27                	push   $0x27
  801adf:	e8 18 fb ff ff       	call   8015fc <syscall>
  801ae4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ae7:	90                   	nop
}
  801ae8:	c9                   	leave  
  801ae9:	c3                   	ret    

00801aea <chktst>:
void chktst(uint32 n)
{
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	ff 75 08             	pushl  0x8(%ebp)
  801af8:	6a 29                	push   $0x29
  801afa:	e8 fd fa ff ff       	call   8015fc <syscall>
  801aff:	83 c4 18             	add    $0x18,%esp
	return ;
  801b02:	90                   	nop
}
  801b03:	c9                   	leave  
  801b04:	c3                   	ret    

00801b05 <inctst>:

void inctst()
{
  801b05:	55                   	push   %ebp
  801b06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 2a                	push   $0x2a
  801b14:	e8 e3 fa ff ff       	call   8015fc <syscall>
  801b19:	83 c4 18             	add    $0x18,%esp
	return ;
  801b1c:	90                   	nop
}
  801b1d:	c9                   	leave  
  801b1e:	c3                   	ret    

00801b1f <gettst>:
uint32 gettst()
{
  801b1f:	55                   	push   %ebp
  801b20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 2b                	push   $0x2b
  801b2e:	e8 c9 fa ff ff       	call   8015fc <syscall>
  801b33:	83 c4 18             	add    $0x18,%esp
}
  801b36:	c9                   	leave  
  801b37:	c3                   	ret    

00801b38 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b38:	55                   	push   %ebp
  801b39:	89 e5                	mov    %esp,%ebp
  801b3b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 2c                	push   $0x2c
  801b4a:	e8 ad fa ff ff       	call   8015fc <syscall>
  801b4f:	83 c4 18             	add    $0x18,%esp
  801b52:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b55:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b59:	75 07                	jne    801b62 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b5b:	b8 01 00 00 00       	mov    $0x1,%eax
  801b60:	eb 05                	jmp    801b67 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b62:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b67:	c9                   	leave  
  801b68:	c3                   	ret    

00801b69 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b69:	55                   	push   %ebp
  801b6a:	89 e5                	mov    %esp,%ebp
  801b6c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 2c                	push   $0x2c
  801b7b:	e8 7c fa ff ff       	call   8015fc <syscall>
  801b80:	83 c4 18             	add    $0x18,%esp
  801b83:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b86:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b8a:	75 07                	jne    801b93 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b8c:	b8 01 00 00 00       	mov    $0x1,%eax
  801b91:	eb 05                	jmp    801b98 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b93:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b98:	c9                   	leave  
  801b99:	c3                   	ret    

00801b9a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b9a:	55                   	push   %ebp
  801b9b:	89 e5                	mov    %esp,%ebp
  801b9d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 2c                	push   $0x2c
  801bac:	e8 4b fa ff ff       	call   8015fc <syscall>
  801bb1:	83 c4 18             	add    $0x18,%esp
  801bb4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801bb7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801bbb:	75 07                	jne    801bc4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801bbd:	b8 01 00 00 00       	mov    $0x1,%eax
  801bc2:	eb 05                	jmp    801bc9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801bc4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bc9:	c9                   	leave  
  801bca:	c3                   	ret    

00801bcb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801bcb:	55                   	push   %ebp
  801bcc:	89 e5                	mov    %esp,%ebp
  801bce:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 2c                	push   $0x2c
  801bdd:	e8 1a fa ff ff       	call   8015fc <syscall>
  801be2:	83 c4 18             	add    $0x18,%esp
  801be5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801be8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bec:	75 07                	jne    801bf5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bee:	b8 01 00 00 00       	mov    $0x1,%eax
  801bf3:	eb 05                	jmp    801bfa <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bf5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bfa:	c9                   	leave  
  801bfb:	c3                   	ret    

00801bfc <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801bfc:	55                   	push   %ebp
  801bfd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	ff 75 08             	pushl  0x8(%ebp)
  801c0a:	6a 2d                	push   $0x2d
  801c0c:	e8 eb f9 ff ff       	call   8015fc <syscall>
  801c11:	83 c4 18             	add    $0x18,%esp
	return ;
  801c14:	90                   	nop
}
  801c15:	c9                   	leave  
  801c16:	c3                   	ret    

00801c17 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801c17:	55                   	push   %ebp
  801c18:	89 e5                	mov    %esp,%ebp
  801c1a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801c1b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c1e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c21:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c24:	8b 45 08             	mov    0x8(%ebp),%eax
  801c27:	6a 00                	push   $0x0
  801c29:	53                   	push   %ebx
  801c2a:	51                   	push   %ecx
  801c2b:	52                   	push   %edx
  801c2c:	50                   	push   %eax
  801c2d:	6a 2e                	push   $0x2e
  801c2f:	e8 c8 f9 ff ff       	call   8015fc <syscall>
  801c34:	83 c4 18             	add    $0x18,%esp
}
  801c37:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801c3a:	c9                   	leave  
  801c3b:	c3                   	ret    

00801c3c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801c3c:	55                   	push   %ebp
  801c3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801c3f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c42:	8b 45 08             	mov    0x8(%ebp),%eax
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	52                   	push   %edx
  801c4c:	50                   	push   %eax
  801c4d:	6a 2f                	push   $0x2f
  801c4f:	e8 a8 f9 ff ff       	call   8015fc <syscall>
  801c54:	83 c4 18             	add    $0x18,%esp
}
  801c57:	c9                   	leave  
  801c58:	c3                   	ret    

00801c59 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801c59:	55                   	push   %ebp
  801c5a:	89 e5                	mov    %esp,%ebp
  801c5c:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801c5f:	8b 55 08             	mov    0x8(%ebp),%edx
  801c62:	89 d0                	mov    %edx,%eax
  801c64:	c1 e0 02             	shl    $0x2,%eax
  801c67:	01 d0                	add    %edx,%eax
  801c69:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c70:	01 d0                	add    %edx,%eax
  801c72:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c79:	01 d0                	add    %edx,%eax
  801c7b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c82:	01 d0                	add    %edx,%eax
  801c84:	c1 e0 04             	shl    $0x4,%eax
  801c87:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801c8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801c91:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801c94:	83 ec 0c             	sub    $0xc,%esp
  801c97:	50                   	push   %eax
  801c98:	e8 76 fd ff ff       	call   801a13 <sys_get_virtual_time>
  801c9d:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801ca0:	eb 41                	jmp    801ce3 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801ca2:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801ca5:	83 ec 0c             	sub    $0xc,%esp
  801ca8:	50                   	push   %eax
  801ca9:	e8 65 fd ff ff       	call   801a13 <sys_get_virtual_time>
  801cae:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801cb1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801cb4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cb7:	29 c2                	sub    %eax,%edx
  801cb9:	89 d0                	mov    %edx,%eax
  801cbb:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801cbe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801cc1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801cc4:	89 d1                	mov    %edx,%ecx
  801cc6:	29 c1                	sub    %eax,%ecx
  801cc8:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801ccb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801cce:	39 c2                	cmp    %eax,%edx
  801cd0:	0f 97 c0             	seta   %al
  801cd3:	0f b6 c0             	movzbl %al,%eax
  801cd6:	29 c1                	sub    %eax,%ecx
  801cd8:	89 c8                	mov    %ecx,%eax
  801cda:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801cdd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801ce0:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801ce3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ce6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ce9:	72 b7                	jb     801ca2 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801ceb:	90                   	nop
  801cec:	c9                   	leave  
  801ced:	c3                   	ret    

00801cee <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801cee:	55                   	push   %ebp
  801cef:	89 e5                	mov    %esp,%ebp
  801cf1:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801cf4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801cfb:	eb 03                	jmp    801d00 <busy_wait+0x12>
  801cfd:	ff 45 fc             	incl   -0x4(%ebp)
  801d00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d03:	3b 45 08             	cmp    0x8(%ebp),%eax
  801d06:	72 f5                	jb     801cfd <busy_wait+0xf>
	return i;
  801d08:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801d0b:	c9                   	leave  
  801d0c:	c3                   	ret    
  801d0d:	66 90                	xchg   %ax,%ax
  801d0f:	90                   	nop

00801d10 <__udivdi3>:
  801d10:	55                   	push   %ebp
  801d11:	57                   	push   %edi
  801d12:	56                   	push   %esi
  801d13:	53                   	push   %ebx
  801d14:	83 ec 1c             	sub    $0x1c,%esp
  801d17:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d1b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d1f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d23:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d27:	89 ca                	mov    %ecx,%edx
  801d29:	89 f8                	mov    %edi,%eax
  801d2b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d2f:	85 f6                	test   %esi,%esi
  801d31:	75 2d                	jne    801d60 <__udivdi3+0x50>
  801d33:	39 cf                	cmp    %ecx,%edi
  801d35:	77 65                	ja     801d9c <__udivdi3+0x8c>
  801d37:	89 fd                	mov    %edi,%ebp
  801d39:	85 ff                	test   %edi,%edi
  801d3b:	75 0b                	jne    801d48 <__udivdi3+0x38>
  801d3d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d42:	31 d2                	xor    %edx,%edx
  801d44:	f7 f7                	div    %edi
  801d46:	89 c5                	mov    %eax,%ebp
  801d48:	31 d2                	xor    %edx,%edx
  801d4a:	89 c8                	mov    %ecx,%eax
  801d4c:	f7 f5                	div    %ebp
  801d4e:	89 c1                	mov    %eax,%ecx
  801d50:	89 d8                	mov    %ebx,%eax
  801d52:	f7 f5                	div    %ebp
  801d54:	89 cf                	mov    %ecx,%edi
  801d56:	89 fa                	mov    %edi,%edx
  801d58:	83 c4 1c             	add    $0x1c,%esp
  801d5b:	5b                   	pop    %ebx
  801d5c:	5e                   	pop    %esi
  801d5d:	5f                   	pop    %edi
  801d5e:	5d                   	pop    %ebp
  801d5f:	c3                   	ret    
  801d60:	39 ce                	cmp    %ecx,%esi
  801d62:	77 28                	ja     801d8c <__udivdi3+0x7c>
  801d64:	0f bd fe             	bsr    %esi,%edi
  801d67:	83 f7 1f             	xor    $0x1f,%edi
  801d6a:	75 40                	jne    801dac <__udivdi3+0x9c>
  801d6c:	39 ce                	cmp    %ecx,%esi
  801d6e:	72 0a                	jb     801d7a <__udivdi3+0x6a>
  801d70:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d74:	0f 87 9e 00 00 00    	ja     801e18 <__udivdi3+0x108>
  801d7a:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7f:	89 fa                	mov    %edi,%edx
  801d81:	83 c4 1c             	add    $0x1c,%esp
  801d84:	5b                   	pop    %ebx
  801d85:	5e                   	pop    %esi
  801d86:	5f                   	pop    %edi
  801d87:	5d                   	pop    %ebp
  801d88:	c3                   	ret    
  801d89:	8d 76 00             	lea    0x0(%esi),%esi
  801d8c:	31 ff                	xor    %edi,%edi
  801d8e:	31 c0                	xor    %eax,%eax
  801d90:	89 fa                	mov    %edi,%edx
  801d92:	83 c4 1c             	add    $0x1c,%esp
  801d95:	5b                   	pop    %ebx
  801d96:	5e                   	pop    %esi
  801d97:	5f                   	pop    %edi
  801d98:	5d                   	pop    %ebp
  801d99:	c3                   	ret    
  801d9a:	66 90                	xchg   %ax,%ax
  801d9c:	89 d8                	mov    %ebx,%eax
  801d9e:	f7 f7                	div    %edi
  801da0:	31 ff                	xor    %edi,%edi
  801da2:	89 fa                	mov    %edi,%edx
  801da4:	83 c4 1c             	add    $0x1c,%esp
  801da7:	5b                   	pop    %ebx
  801da8:	5e                   	pop    %esi
  801da9:	5f                   	pop    %edi
  801daa:	5d                   	pop    %ebp
  801dab:	c3                   	ret    
  801dac:	bd 20 00 00 00       	mov    $0x20,%ebp
  801db1:	89 eb                	mov    %ebp,%ebx
  801db3:	29 fb                	sub    %edi,%ebx
  801db5:	89 f9                	mov    %edi,%ecx
  801db7:	d3 e6                	shl    %cl,%esi
  801db9:	89 c5                	mov    %eax,%ebp
  801dbb:	88 d9                	mov    %bl,%cl
  801dbd:	d3 ed                	shr    %cl,%ebp
  801dbf:	89 e9                	mov    %ebp,%ecx
  801dc1:	09 f1                	or     %esi,%ecx
  801dc3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801dc7:	89 f9                	mov    %edi,%ecx
  801dc9:	d3 e0                	shl    %cl,%eax
  801dcb:	89 c5                	mov    %eax,%ebp
  801dcd:	89 d6                	mov    %edx,%esi
  801dcf:	88 d9                	mov    %bl,%cl
  801dd1:	d3 ee                	shr    %cl,%esi
  801dd3:	89 f9                	mov    %edi,%ecx
  801dd5:	d3 e2                	shl    %cl,%edx
  801dd7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ddb:	88 d9                	mov    %bl,%cl
  801ddd:	d3 e8                	shr    %cl,%eax
  801ddf:	09 c2                	or     %eax,%edx
  801de1:	89 d0                	mov    %edx,%eax
  801de3:	89 f2                	mov    %esi,%edx
  801de5:	f7 74 24 0c          	divl   0xc(%esp)
  801de9:	89 d6                	mov    %edx,%esi
  801deb:	89 c3                	mov    %eax,%ebx
  801ded:	f7 e5                	mul    %ebp
  801def:	39 d6                	cmp    %edx,%esi
  801df1:	72 19                	jb     801e0c <__udivdi3+0xfc>
  801df3:	74 0b                	je     801e00 <__udivdi3+0xf0>
  801df5:	89 d8                	mov    %ebx,%eax
  801df7:	31 ff                	xor    %edi,%edi
  801df9:	e9 58 ff ff ff       	jmp    801d56 <__udivdi3+0x46>
  801dfe:	66 90                	xchg   %ax,%ax
  801e00:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e04:	89 f9                	mov    %edi,%ecx
  801e06:	d3 e2                	shl    %cl,%edx
  801e08:	39 c2                	cmp    %eax,%edx
  801e0a:	73 e9                	jae    801df5 <__udivdi3+0xe5>
  801e0c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e0f:	31 ff                	xor    %edi,%edi
  801e11:	e9 40 ff ff ff       	jmp    801d56 <__udivdi3+0x46>
  801e16:	66 90                	xchg   %ax,%ax
  801e18:	31 c0                	xor    %eax,%eax
  801e1a:	e9 37 ff ff ff       	jmp    801d56 <__udivdi3+0x46>
  801e1f:	90                   	nop

00801e20 <__umoddi3>:
  801e20:	55                   	push   %ebp
  801e21:	57                   	push   %edi
  801e22:	56                   	push   %esi
  801e23:	53                   	push   %ebx
  801e24:	83 ec 1c             	sub    $0x1c,%esp
  801e27:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e2b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e33:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e3b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e3f:	89 f3                	mov    %esi,%ebx
  801e41:	89 fa                	mov    %edi,%edx
  801e43:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e47:	89 34 24             	mov    %esi,(%esp)
  801e4a:	85 c0                	test   %eax,%eax
  801e4c:	75 1a                	jne    801e68 <__umoddi3+0x48>
  801e4e:	39 f7                	cmp    %esi,%edi
  801e50:	0f 86 a2 00 00 00    	jbe    801ef8 <__umoddi3+0xd8>
  801e56:	89 c8                	mov    %ecx,%eax
  801e58:	89 f2                	mov    %esi,%edx
  801e5a:	f7 f7                	div    %edi
  801e5c:	89 d0                	mov    %edx,%eax
  801e5e:	31 d2                	xor    %edx,%edx
  801e60:	83 c4 1c             	add    $0x1c,%esp
  801e63:	5b                   	pop    %ebx
  801e64:	5e                   	pop    %esi
  801e65:	5f                   	pop    %edi
  801e66:	5d                   	pop    %ebp
  801e67:	c3                   	ret    
  801e68:	39 f0                	cmp    %esi,%eax
  801e6a:	0f 87 ac 00 00 00    	ja     801f1c <__umoddi3+0xfc>
  801e70:	0f bd e8             	bsr    %eax,%ebp
  801e73:	83 f5 1f             	xor    $0x1f,%ebp
  801e76:	0f 84 ac 00 00 00    	je     801f28 <__umoddi3+0x108>
  801e7c:	bf 20 00 00 00       	mov    $0x20,%edi
  801e81:	29 ef                	sub    %ebp,%edi
  801e83:	89 fe                	mov    %edi,%esi
  801e85:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e89:	89 e9                	mov    %ebp,%ecx
  801e8b:	d3 e0                	shl    %cl,%eax
  801e8d:	89 d7                	mov    %edx,%edi
  801e8f:	89 f1                	mov    %esi,%ecx
  801e91:	d3 ef                	shr    %cl,%edi
  801e93:	09 c7                	or     %eax,%edi
  801e95:	89 e9                	mov    %ebp,%ecx
  801e97:	d3 e2                	shl    %cl,%edx
  801e99:	89 14 24             	mov    %edx,(%esp)
  801e9c:	89 d8                	mov    %ebx,%eax
  801e9e:	d3 e0                	shl    %cl,%eax
  801ea0:	89 c2                	mov    %eax,%edx
  801ea2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ea6:	d3 e0                	shl    %cl,%eax
  801ea8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801eac:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eb0:	89 f1                	mov    %esi,%ecx
  801eb2:	d3 e8                	shr    %cl,%eax
  801eb4:	09 d0                	or     %edx,%eax
  801eb6:	d3 eb                	shr    %cl,%ebx
  801eb8:	89 da                	mov    %ebx,%edx
  801eba:	f7 f7                	div    %edi
  801ebc:	89 d3                	mov    %edx,%ebx
  801ebe:	f7 24 24             	mull   (%esp)
  801ec1:	89 c6                	mov    %eax,%esi
  801ec3:	89 d1                	mov    %edx,%ecx
  801ec5:	39 d3                	cmp    %edx,%ebx
  801ec7:	0f 82 87 00 00 00    	jb     801f54 <__umoddi3+0x134>
  801ecd:	0f 84 91 00 00 00    	je     801f64 <__umoddi3+0x144>
  801ed3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ed7:	29 f2                	sub    %esi,%edx
  801ed9:	19 cb                	sbb    %ecx,%ebx
  801edb:	89 d8                	mov    %ebx,%eax
  801edd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ee1:	d3 e0                	shl    %cl,%eax
  801ee3:	89 e9                	mov    %ebp,%ecx
  801ee5:	d3 ea                	shr    %cl,%edx
  801ee7:	09 d0                	or     %edx,%eax
  801ee9:	89 e9                	mov    %ebp,%ecx
  801eeb:	d3 eb                	shr    %cl,%ebx
  801eed:	89 da                	mov    %ebx,%edx
  801eef:	83 c4 1c             	add    $0x1c,%esp
  801ef2:	5b                   	pop    %ebx
  801ef3:	5e                   	pop    %esi
  801ef4:	5f                   	pop    %edi
  801ef5:	5d                   	pop    %ebp
  801ef6:	c3                   	ret    
  801ef7:	90                   	nop
  801ef8:	89 fd                	mov    %edi,%ebp
  801efa:	85 ff                	test   %edi,%edi
  801efc:	75 0b                	jne    801f09 <__umoddi3+0xe9>
  801efe:	b8 01 00 00 00       	mov    $0x1,%eax
  801f03:	31 d2                	xor    %edx,%edx
  801f05:	f7 f7                	div    %edi
  801f07:	89 c5                	mov    %eax,%ebp
  801f09:	89 f0                	mov    %esi,%eax
  801f0b:	31 d2                	xor    %edx,%edx
  801f0d:	f7 f5                	div    %ebp
  801f0f:	89 c8                	mov    %ecx,%eax
  801f11:	f7 f5                	div    %ebp
  801f13:	89 d0                	mov    %edx,%eax
  801f15:	e9 44 ff ff ff       	jmp    801e5e <__umoddi3+0x3e>
  801f1a:	66 90                	xchg   %ax,%ax
  801f1c:	89 c8                	mov    %ecx,%eax
  801f1e:	89 f2                	mov    %esi,%edx
  801f20:	83 c4 1c             	add    $0x1c,%esp
  801f23:	5b                   	pop    %ebx
  801f24:	5e                   	pop    %esi
  801f25:	5f                   	pop    %edi
  801f26:	5d                   	pop    %ebp
  801f27:	c3                   	ret    
  801f28:	3b 04 24             	cmp    (%esp),%eax
  801f2b:	72 06                	jb     801f33 <__umoddi3+0x113>
  801f2d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f31:	77 0f                	ja     801f42 <__umoddi3+0x122>
  801f33:	89 f2                	mov    %esi,%edx
  801f35:	29 f9                	sub    %edi,%ecx
  801f37:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f3b:	89 14 24             	mov    %edx,(%esp)
  801f3e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f42:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f46:	8b 14 24             	mov    (%esp),%edx
  801f49:	83 c4 1c             	add    $0x1c,%esp
  801f4c:	5b                   	pop    %ebx
  801f4d:	5e                   	pop    %esi
  801f4e:	5f                   	pop    %edi
  801f4f:	5d                   	pop    %ebp
  801f50:	c3                   	ret    
  801f51:	8d 76 00             	lea    0x0(%esi),%esi
  801f54:	2b 04 24             	sub    (%esp),%eax
  801f57:	19 fa                	sbb    %edi,%edx
  801f59:	89 d1                	mov    %edx,%ecx
  801f5b:	89 c6                	mov    %eax,%esi
  801f5d:	e9 71 ff ff ff       	jmp    801ed3 <__umoddi3+0xb3>
  801f62:	66 90                	xchg   %ax,%ax
  801f64:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f68:	72 ea                	jb     801f54 <__umoddi3+0x134>
  801f6a:	89 d9                	mov    %ebx,%ecx
  801f6c:	e9 62 ff ff ff       	jmp    801ed3 <__umoddi3+0xb3>

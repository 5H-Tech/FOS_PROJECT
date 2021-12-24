
obj/user/MidTermEx_Master:     file format elf32-i386


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
  800031:	e8 14 02 00 00       	call   80024a <libmain>
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
  800045:	68 e0 1f 80 00       	push   $0x801fe0
  80004a:	e8 16 14 00 00       	call   801465 <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*X = 5 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 05 00 00 00    	movl   $0x5,(%eax)

	/*[2] SPECIFY WHETHER TO USE SEMAPHORE OR NOT*/
	cprintf("Do you want to use semaphore (y/n)? ") ;
  80005e:	83 ec 0c             	sub    $0xc,%esp
  800061:	68 e4 1f 80 00       	push   $0x801fe4
  800066:	e8 f8 03 00 00       	call   800463 <cprintf>
  80006b:	83 c4 10             	add    $0x10,%esp
	char select = getchar() ;
  80006e:	e8 7f 01 00 00       	call   8001f2 <getchar>
  800073:	88 45 f3             	mov    %al,-0xd(%ebp)
	cputchar(select);
  800076:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  80007a:	83 ec 0c             	sub    $0xc,%esp
  80007d:	50                   	push   %eax
  80007e:	e8 27 01 00 00       	call   8001aa <cputchar>
  800083:	83 c4 10             	add    $0x10,%esp
	cputchar('\n');
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	6a 0a                	push   $0xa
  80008b:	e8 1a 01 00 00       	call   8001aa <cputchar>
  800090:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THIS SELECTION WITH OTHER PROCESSES*/
	int *useSem = smalloc("useSem", sizeof(int) , 0) ;
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	6a 00                	push   $0x0
  800098:	6a 04                	push   $0x4
  80009a:	68 09 20 80 00       	push   $0x802009
  80009f:	e8 c1 13 00 00       	call   801465 <smalloc>
  8000a4:	83 c4 10             	add    $0x10,%esp
  8000a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
	*useSem = 0 ;
  8000aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	if (select == 'Y' || select == 'y')
  8000b3:	80 7d f3 59          	cmpb   $0x59,-0xd(%ebp)
  8000b7:	74 06                	je     8000bf <_main+0x87>
  8000b9:	80 7d f3 79          	cmpb   $0x79,-0xd(%ebp)
  8000bd:	75 09                	jne    8000c8 <_main+0x90>
		*useSem = 1 ;
  8000bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000c2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

	if (*useSem == 1)
  8000c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000cb:	8b 00                	mov    (%eax),%eax
  8000cd:	83 f8 01             	cmp    $0x1,%eax
  8000d0:	75 12                	jne    8000e4 <_main+0xac>
	{
		sys_createSemaphore("T", 0);
  8000d2:	83 ec 08             	sub    $0x8,%esp
  8000d5:	6a 00                	push   $0x0
  8000d7:	68 10 20 80 00       	push   $0x802010
  8000dc:	e8 05 17 00 00       	call   8017e6 <sys_createSemaphore>
  8000e1:	83 c4 10             	add    $0x10,%esp
	}

	/*[4] CREATE AND RUN ProcessA & ProcessB*/

	//Create the check-finishing counter
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  8000e4:	83 ec 04             	sub    $0x4,%esp
  8000e7:	6a 01                	push   $0x1
  8000e9:	6a 04                	push   $0x4
  8000eb:	68 12 20 80 00       	push   $0x802012
  8000f0:	e8 70 13 00 00       	call   801465 <smalloc>
  8000f5:	83 c4 10             	add    $0x10,%esp
  8000f8:	89 45 e8             	mov    %eax,-0x18(%ebp)
	*numOfFinished = 0 ;
  8000fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	//Create the 2 processes
	int32 envIdProcessA = sys_create_env("midterm_a", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800104:	a1 20 30 80 00       	mov    0x803020,%eax
  800109:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80010f:	a1 20 30 80 00       	mov    0x803020,%eax
  800114:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80011a:	89 c1                	mov    %eax,%ecx
  80011c:	a1 20 30 80 00       	mov    0x803020,%eax
  800121:	8b 40 74             	mov    0x74(%eax),%eax
  800124:	52                   	push   %edx
  800125:	51                   	push   %ecx
  800126:	50                   	push   %eax
  800127:	68 20 20 80 00       	push   $0x802020
  80012c:	e8 c6 17 00 00       	call   8018f7 <sys_create_env>
  800131:	83 c4 10             	add    $0x10,%esp
  800134:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int32 envIdProcessB = sys_create_env("midterm_b", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  800137:	a1 20 30 80 00       	mov    0x803020,%eax
  80013c:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800142:	a1 20 30 80 00       	mov    0x803020,%eax
  800147:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80014d:	89 c1                	mov    %eax,%ecx
  80014f:	a1 20 30 80 00       	mov    0x803020,%eax
  800154:	8b 40 74             	mov    0x74(%eax),%eax
  800157:	52                   	push   %edx
  800158:	51                   	push   %ecx
  800159:	50                   	push   %eax
  80015a:	68 2a 20 80 00       	push   $0x80202a
  80015f:	e8 93 17 00 00       	call   8018f7 <sys_create_env>
  800164:	83 c4 10             	add    $0x10,%esp
  800167:	89 45 e0             	mov    %eax,-0x20(%ebp)

	//Run the 2 processes
	sys_run_env(envIdProcessA);
  80016a:	83 ec 0c             	sub    $0xc,%esp
  80016d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800170:	e8 a0 17 00 00       	call   801915 <sys_run_env>
  800175:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  800178:	83 ec 0c             	sub    $0xc,%esp
  80017b:	ff 75 e0             	pushl  -0x20(%ebp)
  80017e:	e8 92 17 00 00       	call   801915 <sys_run_env>
  800183:	83 c4 10             	add    $0x10,%esp

	/*[5] BUSY-WAIT TILL FINISHING BOTH PROCESSES*/
	while (*numOfFinished != 2) ;
  800186:	90                   	nop
  800187:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80018a:	8b 00                	mov    (%eax),%eax
  80018c:	83 f8 02             	cmp    $0x2,%eax
  80018f:	75 f6                	jne    800187 <_main+0x14f>

	/*[6] PRINT X*/
	cprintf("Final value of X = %d\n", *X);
  800191:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800194:	8b 00                	mov    (%eax),%eax
  800196:	83 ec 08             	sub    $0x8,%esp
  800199:	50                   	push   %eax
  80019a:	68 34 20 80 00       	push   $0x802034
  80019f:	e8 bf 02 00 00       	call   800463 <cprintf>
  8001a4:	83 c4 10             	add    $0x10,%esp

	return;
  8001a7:	90                   	nop
}
  8001a8:	c9                   	leave  
  8001a9:	c3                   	ret    

008001aa <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8001aa:	55                   	push   %ebp
  8001ab:	89 e5                	mov    %esp,%ebp
  8001ad:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8001b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8001b3:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8001b6:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8001ba:	83 ec 0c             	sub    $0xc,%esp
  8001bd:	50                   	push   %eax
  8001be:	e8 e3 15 00 00       	call   8017a6 <sys_cputc>
  8001c3:	83 c4 10             	add    $0x10,%esp
}
  8001c6:	90                   	nop
  8001c7:	c9                   	leave  
  8001c8:	c3                   	ret    

008001c9 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8001c9:	55                   	push   %ebp
  8001ca:	89 e5                	mov    %esp,%ebp
  8001cc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8001cf:	e8 9e 15 00 00       	call   801772 <sys_disable_interrupt>
	char c = ch;
  8001d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8001d7:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8001da:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8001de:	83 ec 0c             	sub    $0xc,%esp
  8001e1:	50                   	push   %eax
  8001e2:	e8 bf 15 00 00       	call   8017a6 <sys_cputc>
  8001e7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001ea:	e8 9d 15 00 00       	call   80178c <sys_enable_interrupt>
}
  8001ef:	90                   	nop
  8001f0:	c9                   	leave  
  8001f1:	c3                   	ret    

008001f2 <getchar>:

int
getchar(void)
{
  8001f2:	55                   	push   %ebp
  8001f3:	89 e5                	mov    %esp,%ebp
  8001f5:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8001f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8001ff:	eb 08                	jmp    800209 <getchar+0x17>
	{
		c = sys_cgetc();
  800201:	e8 84 13 00 00       	call   80158a <sys_cgetc>
  800206:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800209:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80020d:	74 f2                	je     800201 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80020f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800212:	c9                   	leave  
  800213:	c3                   	ret    

00800214 <atomic_getchar>:

int
atomic_getchar(void)
{
  800214:	55                   	push   %ebp
  800215:	89 e5                	mov    %esp,%ebp
  800217:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80021a:	e8 53 15 00 00       	call   801772 <sys_disable_interrupt>
	int c=0;
  80021f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800226:	eb 08                	jmp    800230 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800228:	e8 5d 13 00 00       	call   80158a <sys_cgetc>
  80022d:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800230:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800234:	74 f2                	je     800228 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800236:	e8 51 15 00 00       	call   80178c <sys_enable_interrupt>
	return c;
  80023b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80023e:	c9                   	leave  
  80023f:	c3                   	ret    

00800240 <iscons>:

int iscons(int fdnum)
{
  800240:	55                   	push   %ebp
  800241:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800243:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800248:	5d                   	pop    %ebp
  800249:	c3                   	ret    

0080024a <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80024a:	55                   	push   %ebp
  80024b:	89 e5                	mov    %esp,%ebp
  80024d:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800250:	e8 82 13 00 00       	call   8015d7 <sys_getenvindex>
  800255:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800258:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80025b:	89 d0                	mov    %edx,%eax
  80025d:	c1 e0 03             	shl    $0x3,%eax
  800260:	01 d0                	add    %edx,%eax
  800262:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800269:	01 c8                	add    %ecx,%eax
  80026b:	01 c0                	add    %eax,%eax
  80026d:	01 d0                	add    %edx,%eax
  80026f:	01 c0                	add    %eax,%eax
  800271:	01 d0                	add    %edx,%eax
  800273:	89 c2                	mov    %eax,%edx
  800275:	c1 e2 05             	shl    $0x5,%edx
  800278:	29 c2                	sub    %eax,%edx
  80027a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800281:	89 c2                	mov    %eax,%edx
  800283:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800289:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80028e:	a1 20 30 80 00       	mov    0x803020,%eax
  800293:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800299:	84 c0                	test   %al,%al
  80029b:	74 0f                	je     8002ac <libmain+0x62>
		binaryname = myEnv->prog_name;
  80029d:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a2:	05 40 3c 01 00       	add    $0x13c40,%eax
  8002a7:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002ac:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002b0:	7e 0a                	jle    8002bc <libmain+0x72>
		binaryname = argv[0];
  8002b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b5:	8b 00                	mov    (%eax),%eax
  8002b7:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8002bc:	83 ec 08             	sub    $0x8,%esp
  8002bf:	ff 75 0c             	pushl  0xc(%ebp)
  8002c2:	ff 75 08             	pushl  0x8(%ebp)
  8002c5:	e8 6e fd ff ff       	call   800038 <_main>
  8002ca:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8002cd:	e8 a0 14 00 00       	call   801772 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8002d2:	83 ec 0c             	sub    $0xc,%esp
  8002d5:	68 64 20 80 00       	push   $0x802064
  8002da:	e8 84 01 00 00       	call   800463 <cprintf>
  8002df:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e7:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8002ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f2:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8002f8:	83 ec 04             	sub    $0x4,%esp
  8002fb:	52                   	push   %edx
  8002fc:	50                   	push   %eax
  8002fd:	68 8c 20 80 00       	push   $0x80208c
  800302:	e8 5c 01 00 00       	call   800463 <cprintf>
  800307:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80030a:	a1 20 30 80 00       	mov    0x803020,%eax
  80030f:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800315:	a1 20 30 80 00       	mov    0x803020,%eax
  80031a:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800320:	83 ec 04             	sub    $0x4,%esp
  800323:	52                   	push   %edx
  800324:	50                   	push   %eax
  800325:	68 b4 20 80 00       	push   $0x8020b4
  80032a:	e8 34 01 00 00       	call   800463 <cprintf>
  80032f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800332:	a1 20 30 80 00       	mov    0x803020,%eax
  800337:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80033d:	83 ec 08             	sub    $0x8,%esp
  800340:	50                   	push   %eax
  800341:	68 f5 20 80 00       	push   $0x8020f5
  800346:	e8 18 01 00 00       	call   800463 <cprintf>
  80034b:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80034e:	83 ec 0c             	sub    $0xc,%esp
  800351:	68 64 20 80 00       	push   $0x802064
  800356:	e8 08 01 00 00       	call   800463 <cprintf>
  80035b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80035e:	e8 29 14 00 00       	call   80178c <sys_enable_interrupt>

	// exit gracefully
	exit();
  800363:	e8 19 00 00 00       	call   800381 <exit>
}
  800368:	90                   	nop
  800369:	c9                   	leave  
  80036a:	c3                   	ret    

0080036b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80036b:	55                   	push   %ebp
  80036c:	89 e5                	mov    %esp,%ebp
  80036e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800371:	83 ec 0c             	sub    $0xc,%esp
  800374:	6a 00                	push   $0x0
  800376:	e8 28 12 00 00       	call   8015a3 <sys_env_destroy>
  80037b:	83 c4 10             	add    $0x10,%esp
}
  80037e:	90                   	nop
  80037f:	c9                   	leave  
  800380:	c3                   	ret    

00800381 <exit>:

void
exit(void)
{
  800381:	55                   	push   %ebp
  800382:	89 e5                	mov    %esp,%ebp
  800384:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800387:	e8 7d 12 00 00       	call   801609 <sys_env_exit>
}
  80038c:	90                   	nop
  80038d:	c9                   	leave  
  80038e:	c3                   	ret    

0080038f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80038f:	55                   	push   %ebp
  800390:	89 e5                	mov    %esp,%ebp
  800392:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800395:	8b 45 0c             	mov    0xc(%ebp),%eax
  800398:	8b 00                	mov    (%eax),%eax
  80039a:	8d 48 01             	lea    0x1(%eax),%ecx
  80039d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003a0:	89 0a                	mov    %ecx,(%edx)
  8003a2:	8b 55 08             	mov    0x8(%ebp),%edx
  8003a5:	88 d1                	mov    %dl,%cl
  8003a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003aa:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8003ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b1:	8b 00                	mov    (%eax),%eax
  8003b3:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003b8:	75 2c                	jne    8003e6 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8003ba:	a0 24 30 80 00       	mov    0x803024,%al
  8003bf:	0f b6 c0             	movzbl %al,%eax
  8003c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003c5:	8b 12                	mov    (%edx),%edx
  8003c7:	89 d1                	mov    %edx,%ecx
  8003c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003cc:	83 c2 08             	add    $0x8,%edx
  8003cf:	83 ec 04             	sub    $0x4,%esp
  8003d2:	50                   	push   %eax
  8003d3:	51                   	push   %ecx
  8003d4:	52                   	push   %edx
  8003d5:	e8 87 11 00 00       	call   801561 <sys_cputs>
  8003da:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e9:	8b 40 04             	mov    0x4(%eax),%eax
  8003ec:	8d 50 01             	lea    0x1(%eax),%edx
  8003ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f2:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003f5:	90                   	nop
  8003f6:	c9                   	leave  
  8003f7:	c3                   	ret    

008003f8 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003f8:	55                   	push   %ebp
  8003f9:	89 e5                	mov    %esp,%ebp
  8003fb:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800401:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800408:	00 00 00 
	b.cnt = 0;
  80040b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800412:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800415:	ff 75 0c             	pushl  0xc(%ebp)
  800418:	ff 75 08             	pushl  0x8(%ebp)
  80041b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800421:	50                   	push   %eax
  800422:	68 8f 03 80 00       	push   $0x80038f
  800427:	e8 11 02 00 00       	call   80063d <vprintfmt>
  80042c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80042f:	a0 24 30 80 00       	mov    0x803024,%al
  800434:	0f b6 c0             	movzbl %al,%eax
  800437:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80043d:	83 ec 04             	sub    $0x4,%esp
  800440:	50                   	push   %eax
  800441:	52                   	push   %edx
  800442:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800448:	83 c0 08             	add    $0x8,%eax
  80044b:	50                   	push   %eax
  80044c:	e8 10 11 00 00       	call   801561 <sys_cputs>
  800451:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800454:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80045b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800461:	c9                   	leave  
  800462:	c3                   	ret    

00800463 <cprintf>:

int cprintf(const char *fmt, ...) {
  800463:	55                   	push   %ebp
  800464:	89 e5                	mov    %esp,%ebp
  800466:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800469:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800470:	8d 45 0c             	lea    0xc(%ebp),%eax
  800473:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800476:	8b 45 08             	mov    0x8(%ebp),%eax
  800479:	83 ec 08             	sub    $0x8,%esp
  80047c:	ff 75 f4             	pushl  -0xc(%ebp)
  80047f:	50                   	push   %eax
  800480:	e8 73 ff ff ff       	call   8003f8 <vcprintf>
  800485:	83 c4 10             	add    $0x10,%esp
  800488:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80048b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80048e:	c9                   	leave  
  80048f:	c3                   	ret    

00800490 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800490:	55                   	push   %ebp
  800491:	89 e5                	mov    %esp,%ebp
  800493:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800496:	e8 d7 12 00 00       	call   801772 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80049b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80049e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a4:	83 ec 08             	sub    $0x8,%esp
  8004a7:	ff 75 f4             	pushl  -0xc(%ebp)
  8004aa:	50                   	push   %eax
  8004ab:	e8 48 ff ff ff       	call   8003f8 <vcprintf>
  8004b0:	83 c4 10             	add    $0x10,%esp
  8004b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8004b6:	e8 d1 12 00 00       	call   80178c <sys_enable_interrupt>
	return cnt;
  8004bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004be:	c9                   	leave  
  8004bf:	c3                   	ret    

008004c0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004c0:	55                   	push   %ebp
  8004c1:	89 e5                	mov    %esp,%ebp
  8004c3:	53                   	push   %ebx
  8004c4:	83 ec 14             	sub    $0x14,%esp
  8004c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004d3:	8b 45 18             	mov    0x18(%ebp),%eax
  8004d6:	ba 00 00 00 00       	mov    $0x0,%edx
  8004db:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004de:	77 55                	ja     800535 <printnum+0x75>
  8004e0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004e3:	72 05                	jb     8004ea <printnum+0x2a>
  8004e5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004e8:	77 4b                	ja     800535 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004ea:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004ed:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004f0:	8b 45 18             	mov    0x18(%ebp),%eax
  8004f3:	ba 00 00 00 00       	mov    $0x0,%edx
  8004f8:	52                   	push   %edx
  8004f9:	50                   	push   %eax
  8004fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8004fd:	ff 75 f0             	pushl  -0x10(%ebp)
  800500:	e8 5f 18 00 00       	call   801d64 <__udivdi3>
  800505:	83 c4 10             	add    $0x10,%esp
  800508:	83 ec 04             	sub    $0x4,%esp
  80050b:	ff 75 20             	pushl  0x20(%ebp)
  80050e:	53                   	push   %ebx
  80050f:	ff 75 18             	pushl  0x18(%ebp)
  800512:	52                   	push   %edx
  800513:	50                   	push   %eax
  800514:	ff 75 0c             	pushl  0xc(%ebp)
  800517:	ff 75 08             	pushl  0x8(%ebp)
  80051a:	e8 a1 ff ff ff       	call   8004c0 <printnum>
  80051f:	83 c4 20             	add    $0x20,%esp
  800522:	eb 1a                	jmp    80053e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800524:	83 ec 08             	sub    $0x8,%esp
  800527:	ff 75 0c             	pushl  0xc(%ebp)
  80052a:	ff 75 20             	pushl  0x20(%ebp)
  80052d:	8b 45 08             	mov    0x8(%ebp),%eax
  800530:	ff d0                	call   *%eax
  800532:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800535:	ff 4d 1c             	decl   0x1c(%ebp)
  800538:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80053c:	7f e6                	jg     800524 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80053e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800541:	bb 00 00 00 00       	mov    $0x0,%ebx
  800546:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800549:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80054c:	53                   	push   %ebx
  80054d:	51                   	push   %ecx
  80054e:	52                   	push   %edx
  80054f:	50                   	push   %eax
  800550:	e8 1f 19 00 00       	call   801e74 <__umoddi3>
  800555:	83 c4 10             	add    $0x10,%esp
  800558:	05 34 23 80 00       	add    $0x802334,%eax
  80055d:	8a 00                	mov    (%eax),%al
  80055f:	0f be c0             	movsbl %al,%eax
  800562:	83 ec 08             	sub    $0x8,%esp
  800565:	ff 75 0c             	pushl  0xc(%ebp)
  800568:	50                   	push   %eax
  800569:	8b 45 08             	mov    0x8(%ebp),%eax
  80056c:	ff d0                	call   *%eax
  80056e:	83 c4 10             	add    $0x10,%esp
}
  800571:	90                   	nop
  800572:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800575:	c9                   	leave  
  800576:	c3                   	ret    

00800577 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800577:	55                   	push   %ebp
  800578:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80057a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80057e:	7e 1c                	jle    80059c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800580:	8b 45 08             	mov    0x8(%ebp),%eax
  800583:	8b 00                	mov    (%eax),%eax
  800585:	8d 50 08             	lea    0x8(%eax),%edx
  800588:	8b 45 08             	mov    0x8(%ebp),%eax
  80058b:	89 10                	mov    %edx,(%eax)
  80058d:	8b 45 08             	mov    0x8(%ebp),%eax
  800590:	8b 00                	mov    (%eax),%eax
  800592:	83 e8 08             	sub    $0x8,%eax
  800595:	8b 50 04             	mov    0x4(%eax),%edx
  800598:	8b 00                	mov    (%eax),%eax
  80059a:	eb 40                	jmp    8005dc <getuint+0x65>
	else if (lflag)
  80059c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005a0:	74 1e                	je     8005c0 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a5:	8b 00                	mov    (%eax),%eax
  8005a7:	8d 50 04             	lea    0x4(%eax),%edx
  8005aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ad:	89 10                	mov    %edx,(%eax)
  8005af:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b2:	8b 00                	mov    (%eax),%eax
  8005b4:	83 e8 04             	sub    $0x4,%eax
  8005b7:	8b 00                	mov    (%eax),%eax
  8005b9:	ba 00 00 00 00       	mov    $0x0,%edx
  8005be:	eb 1c                	jmp    8005dc <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c3:	8b 00                	mov    (%eax),%eax
  8005c5:	8d 50 04             	lea    0x4(%eax),%edx
  8005c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cb:	89 10                	mov    %edx,(%eax)
  8005cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d0:	8b 00                	mov    (%eax),%eax
  8005d2:	83 e8 04             	sub    $0x4,%eax
  8005d5:	8b 00                	mov    (%eax),%eax
  8005d7:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005dc:	5d                   	pop    %ebp
  8005dd:	c3                   	ret    

008005de <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005de:	55                   	push   %ebp
  8005df:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005e1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005e5:	7e 1c                	jle    800603 <getint+0x25>
		return va_arg(*ap, long long);
  8005e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ea:	8b 00                	mov    (%eax),%eax
  8005ec:	8d 50 08             	lea    0x8(%eax),%edx
  8005ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f2:	89 10                	mov    %edx,(%eax)
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	8b 00                	mov    (%eax),%eax
  8005f9:	83 e8 08             	sub    $0x8,%eax
  8005fc:	8b 50 04             	mov    0x4(%eax),%edx
  8005ff:	8b 00                	mov    (%eax),%eax
  800601:	eb 38                	jmp    80063b <getint+0x5d>
	else if (lflag)
  800603:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800607:	74 1a                	je     800623 <getint+0x45>
		return va_arg(*ap, long);
  800609:	8b 45 08             	mov    0x8(%ebp),%eax
  80060c:	8b 00                	mov    (%eax),%eax
  80060e:	8d 50 04             	lea    0x4(%eax),%edx
  800611:	8b 45 08             	mov    0x8(%ebp),%eax
  800614:	89 10                	mov    %edx,(%eax)
  800616:	8b 45 08             	mov    0x8(%ebp),%eax
  800619:	8b 00                	mov    (%eax),%eax
  80061b:	83 e8 04             	sub    $0x4,%eax
  80061e:	8b 00                	mov    (%eax),%eax
  800620:	99                   	cltd   
  800621:	eb 18                	jmp    80063b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800623:	8b 45 08             	mov    0x8(%ebp),%eax
  800626:	8b 00                	mov    (%eax),%eax
  800628:	8d 50 04             	lea    0x4(%eax),%edx
  80062b:	8b 45 08             	mov    0x8(%ebp),%eax
  80062e:	89 10                	mov    %edx,(%eax)
  800630:	8b 45 08             	mov    0x8(%ebp),%eax
  800633:	8b 00                	mov    (%eax),%eax
  800635:	83 e8 04             	sub    $0x4,%eax
  800638:	8b 00                	mov    (%eax),%eax
  80063a:	99                   	cltd   
}
  80063b:	5d                   	pop    %ebp
  80063c:	c3                   	ret    

0080063d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80063d:	55                   	push   %ebp
  80063e:	89 e5                	mov    %esp,%ebp
  800640:	56                   	push   %esi
  800641:	53                   	push   %ebx
  800642:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800645:	eb 17                	jmp    80065e <vprintfmt+0x21>
			if (ch == '\0')
  800647:	85 db                	test   %ebx,%ebx
  800649:	0f 84 af 03 00 00    	je     8009fe <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80064f:	83 ec 08             	sub    $0x8,%esp
  800652:	ff 75 0c             	pushl  0xc(%ebp)
  800655:	53                   	push   %ebx
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	ff d0                	call   *%eax
  80065b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80065e:	8b 45 10             	mov    0x10(%ebp),%eax
  800661:	8d 50 01             	lea    0x1(%eax),%edx
  800664:	89 55 10             	mov    %edx,0x10(%ebp)
  800667:	8a 00                	mov    (%eax),%al
  800669:	0f b6 d8             	movzbl %al,%ebx
  80066c:	83 fb 25             	cmp    $0x25,%ebx
  80066f:	75 d6                	jne    800647 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800671:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800675:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80067c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800683:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80068a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800691:	8b 45 10             	mov    0x10(%ebp),%eax
  800694:	8d 50 01             	lea    0x1(%eax),%edx
  800697:	89 55 10             	mov    %edx,0x10(%ebp)
  80069a:	8a 00                	mov    (%eax),%al
  80069c:	0f b6 d8             	movzbl %al,%ebx
  80069f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006a2:	83 f8 55             	cmp    $0x55,%eax
  8006a5:	0f 87 2b 03 00 00    	ja     8009d6 <vprintfmt+0x399>
  8006ab:	8b 04 85 58 23 80 00 	mov    0x802358(,%eax,4),%eax
  8006b2:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006b4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006b8:	eb d7                	jmp    800691 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006ba:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006be:	eb d1                	jmp    800691 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006c0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006c7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006ca:	89 d0                	mov    %edx,%eax
  8006cc:	c1 e0 02             	shl    $0x2,%eax
  8006cf:	01 d0                	add    %edx,%eax
  8006d1:	01 c0                	add    %eax,%eax
  8006d3:	01 d8                	add    %ebx,%eax
  8006d5:	83 e8 30             	sub    $0x30,%eax
  8006d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006db:	8b 45 10             	mov    0x10(%ebp),%eax
  8006de:	8a 00                	mov    (%eax),%al
  8006e0:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006e3:	83 fb 2f             	cmp    $0x2f,%ebx
  8006e6:	7e 3e                	jle    800726 <vprintfmt+0xe9>
  8006e8:	83 fb 39             	cmp    $0x39,%ebx
  8006eb:	7f 39                	jg     800726 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006ed:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006f0:	eb d5                	jmp    8006c7 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f5:	83 c0 04             	add    $0x4,%eax
  8006f8:	89 45 14             	mov    %eax,0x14(%ebp)
  8006fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8006fe:	83 e8 04             	sub    $0x4,%eax
  800701:	8b 00                	mov    (%eax),%eax
  800703:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800706:	eb 1f                	jmp    800727 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800708:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80070c:	79 83                	jns    800691 <vprintfmt+0x54>
				width = 0;
  80070e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800715:	e9 77 ff ff ff       	jmp    800691 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80071a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800721:	e9 6b ff ff ff       	jmp    800691 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800726:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800727:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80072b:	0f 89 60 ff ff ff    	jns    800691 <vprintfmt+0x54>
				width = precision, precision = -1;
  800731:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800737:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80073e:	e9 4e ff ff ff       	jmp    800691 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800743:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800746:	e9 46 ff ff ff       	jmp    800691 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80074b:	8b 45 14             	mov    0x14(%ebp),%eax
  80074e:	83 c0 04             	add    $0x4,%eax
  800751:	89 45 14             	mov    %eax,0x14(%ebp)
  800754:	8b 45 14             	mov    0x14(%ebp),%eax
  800757:	83 e8 04             	sub    $0x4,%eax
  80075a:	8b 00                	mov    (%eax),%eax
  80075c:	83 ec 08             	sub    $0x8,%esp
  80075f:	ff 75 0c             	pushl  0xc(%ebp)
  800762:	50                   	push   %eax
  800763:	8b 45 08             	mov    0x8(%ebp),%eax
  800766:	ff d0                	call   *%eax
  800768:	83 c4 10             	add    $0x10,%esp
			break;
  80076b:	e9 89 02 00 00       	jmp    8009f9 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800770:	8b 45 14             	mov    0x14(%ebp),%eax
  800773:	83 c0 04             	add    $0x4,%eax
  800776:	89 45 14             	mov    %eax,0x14(%ebp)
  800779:	8b 45 14             	mov    0x14(%ebp),%eax
  80077c:	83 e8 04             	sub    $0x4,%eax
  80077f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800781:	85 db                	test   %ebx,%ebx
  800783:	79 02                	jns    800787 <vprintfmt+0x14a>
				err = -err;
  800785:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800787:	83 fb 64             	cmp    $0x64,%ebx
  80078a:	7f 0b                	jg     800797 <vprintfmt+0x15a>
  80078c:	8b 34 9d a0 21 80 00 	mov    0x8021a0(,%ebx,4),%esi
  800793:	85 f6                	test   %esi,%esi
  800795:	75 19                	jne    8007b0 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800797:	53                   	push   %ebx
  800798:	68 45 23 80 00       	push   $0x802345
  80079d:	ff 75 0c             	pushl  0xc(%ebp)
  8007a0:	ff 75 08             	pushl  0x8(%ebp)
  8007a3:	e8 5e 02 00 00       	call   800a06 <printfmt>
  8007a8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007ab:	e9 49 02 00 00       	jmp    8009f9 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007b0:	56                   	push   %esi
  8007b1:	68 4e 23 80 00       	push   $0x80234e
  8007b6:	ff 75 0c             	pushl  0xc(%ebp)
  8007b9:	ff 75 08             	pushl  0x8(%ebp)
  8007bc:	e8 45 02 00 00       	call   800a06 <printfmt>
  8007c1:	83 c4 10             	add    $0x10,%esp
			break;
  8007c4:	e9 30 02 00 00       	jmp    8009f9 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007cc:	83 c0 04             	add    $0x4,%eax
  8007cf:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d5:	83 e8 04             	sub    $0x4,%eax
  8007d8:	8b 30                	mov    (%eax),%esi
  8007da:	85 f6                	test   %esi,%esi
  8007dc:	75 05                	jne    8007e3 <vprintfmt+0x1a6>
				p = "(null)";
  8007de:	be 51 23 80 00       	mov    $0x802351,%esi
			if (width > 0 && padc != '-')
  8007e3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007e7:	7e 6d                	jle    800856 <vprintfmt+0x219>
  8007e9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007ed:	74 67                	je     800856 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007f2:	83 ec 08             	sub    $0x8,%esp
  8007f5:	50                   	push   %eax
  8007f6:	56                   	push   %esi
  8007f7:	e8 0c 03 00 00       	call   800b08 <strnlen>
  8007fc:	83 c4 10             	add    $0x10,%esp
  8007ff:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800802:	eb 16                	jmp    80081a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800804:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800808:	83 ec 08             	sub    $0x8,%esp
  80080b:	ff 75 0c             	pushl  0xc(%ebp)
  80080e:	50                   	push   %eax
  80080f:	8b 45 08             	mov    0x8(%ebp),%eax
  800812:	ff d0                	call   *%eax
  800814:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800817:	ff 4d e4             	decl   -0x1c(%ebp)
  80081a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80081e:	7f e4                	jg     800804 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800820:	eb 34                	jmp    800856 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800822:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800826:	74 1c                	je     800844 <vprintfmt+0x207>
  800828:	83 fb 1f             	cmp    $0x1f,%ebx
  80082b:	7e 05                	jle    800832 <vprintfmt+0x1f5>
  80082d:	83 fb 7e             	cmp    $0x7e,%ebx
  800830:	7e 12                	jle    800844 <vprintfmt+0x207>
					putch('?', putdat);
  800832:	83 ec 08             	sub    $0x8,%esp
  800835:	ff 75 0c             	pushl  0xc(%ebp)
  800838:	6a 3f                	push   $0x3f
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	ff d0                	call   *%eax
  80083f:	83 c4 10             	add    $0x10,%esp
  800842:	eb 0f                	jmp    800853 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800844:	83 ec 08             	sub    $0x8,%esp
  800847:	ff 75 0c             	pushl  0xc(%ebp)
  80084a:	53                   	push   %ebx
  80084b:	8b 45 08             	mov    0x8(%ebp),%eax
  80084e:	ff d0                	call   *%eax
  800850:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800853:	ff 4d e4             	decl   -0x1c(%ebp)
  800856:	89 f0                	mov    %esi,%eax
  800858:	8d 70 01             	lea    0x1(%eax),%esi
  80085b:	8a 00                	mov    (%eax),%al
  80085d:	0f be d8             	movsbl %al,%ebx
  800860:	85 db                	test   %ebx,%ebx
  800862:	74 24                	je     800888 <vprintfmt+0x24b>
  800864:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800868:	78 b8                	js     800822 <vprintfmt+0x1e5>
  80086a:	ff 4d e0             	decl   -0x20(%ebp)
  80086d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800871:	79 af                	jns    800822 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800873:	eb 13                	jmp    800888 <vprintfmt+0x24b>
				putch(' ', putdat);
  800875:	83 ec 08             	sub    $0x8,%esp
  800878:	ff 75 0c             	pushl  0xc(%ebp)
  80087b:	6a 20                	push   $0x20
  80087d:	8b 45 08             	mov    0x8(%ebp),%eax
  800880:	ff d0                	call   *%eax
  800882:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800885:	ff 4d e4             	decl   -0x1c(%ebp)
  800888:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80088c:	7f e7                	jg     800875 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80088e:	e9 66 01 00 00       	jmp    8009f9 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800893:	83 ec 08             	sub    $0x8,%esp
  800896:	ff 75 e8             	pushl  -0x18(%ebp)
  800899:	8d 45 14             	lea    0x14(%ebp),%eax
  80089c:	50                   	push   %eax
  80089d:	e8 3c fd ff ff       	call   8005de <getint>
  8008a2:	83 c4 10             	add    $0x10,%esp
  8008a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008b1:	85 d2                	test   %edx,%edx
  8008b3:	79 23                	jns    8008d8 <vprintfmt+0x29b>
				putch('-', putdat);
  8008b5:	83 ec 08             	sub    $0x8,%esp
  8008b8:	ff 75 0c             	pushl  0xc(%ebp)
  8008bb:	6a 2d                	push   $0x2d
  8008bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c0:	ff d0                	call   *%eax
  8008c2:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008cb:	f7 d8                	neg    %eax
  8008cd:	83 d2 00             	adc    $0x0,%edx
  8008d0:	f7 da                	neg    %edx
  8008d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008d8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008df:	e9 bc 00 00 00       	jmp    8009a0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008e4:	83 ec 08             	sub    $0x8,%esp
  8008e7:	ff 75 e8             	pushl  -0x18(%ebp)
  8008ea:	8d 45 14             	lea    0x14(%ebp),%eax
  8008ed:	50                   	push   %eax
  8008ee:	e8 84 fc ff ff       	call   800577 <getuint>
  8008f3:	83 c4 10             	add    $0x10,%esp
  8008f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008f9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008fc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800903:	e9 98 00 00 00       	jmp    8009a0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800908:	83 ec 08             	sub    $0x8,%esp
  80090b:	ff 75 0c             	pushl  0xc(%ebp)
  80090e:	6a 58                	push   $0x58
  800910:	8b 45 08             	mov    0x8(%ebp),%eax
  800913:	ff d0                	call   *%eax
  800915:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800918:	83 ec 08             	sub    $0x8,%esp
  80091b:	ff 75 0c             	pushl  0xc(%ebp)
  80091e:	6a 58                	push   $0x58
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	ff d0                	call   *%eax
  800925:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800928:	83 ec 08             	sub    $0x8,%esp
  80092b:	ff 75 0c             	pushl  0xc(%ebp)
  80092e:	6a 58                	push   $0x58
  800930:	8b 45 08             	mov    0x8(%ebp),%eax
  800933:	ff d0                	call   *%eax
  800935:	83 c4 10             	add    $0x10,%esp
			break;
  800938:	e9 bc 00 00 00       	jmp    8009f9 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80093d:	83 ec 08             	sub    $0x8,%esp
  800940:	ff 75 0c             	pushl  0xc(%ebp)
  800943:	6a 30                	push   $0x30
  800945:	8b 45 08             	mov    0x8(%ebp),%eax
  800948:	ff d0                	call   *%eax
  80094a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80094d:	83 ec 08             	sub    $0x8,%esp
  800950:	ff 75 0c             	pushl  0xc(%ebp)
  800953:	6a 78                	push   $0x78
  800955:	8b 45 08             	mov    0x8(%ebp),%eax
  800958:	ff d0                	call   *%eax
  80095a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80095d:	8b 45 14             	mov    0x14(%ebp),%eax
  800960:	83 c0 04             	add    $0x4,%eax
  800963:	89 45 14             	mov    %eax,0x14(%ebp)
  800966:	8b 45 14             	mov    0x14(%ebp),%eax
  800969:	83 e8 04             	sub    $0x4,%eax
  80096c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80096e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800971:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800978:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80097f:	eb 1f                	jmp    8009a0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800981:	83 ec 08             	sub    $0x8,%esp
  800984:	ff 75 e8             	pushl  -0x18(%ebp)
  800987:	8d 45 14             	lea    0x14(%ebp),%eax
  80098a:	50                   	push   %eax
  80098b:	e8 e7 fb ff ff       	call   800577 <getuint>
  800990:	83 c4 10             	add    $0x10,%esp
  800993:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800996:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800999:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009a0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009a7:	83 ec 04             	sub    $0x4,%esp
  8009aa:	52                   	push   %edx
  8009ab:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009ae:	50                   	push   %eax
  8009af:	ff 75 f4             	pushl  -0xc(%ebp)
  8009b2:	ff 75 f0             	pushl  -0x10(%ebp)
  8009b5:	ff 75 0c             	pushl  0xc(%ebp)
  8009b8:	ff 75 08             	pushl  0x8(%ebp)
  8009bb:	e8 00 fb ff ff       	call   8004c0 <printnum>
  8009c0:	83 c4 20             	add    $0x20,%esp
			break;
  8009c3:	eb 34                	jmp    8009f9 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009c5:	83 ec 08             	sub    $0x8,%esp
  8009c8:	ff 75 0c             	pushl  0xc(%ebp)
  8009cb:	53                   	push   %ebx
  8009cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cf:	ff d0                	call   *%eax
  8009d1:	83 c4 10             	add    $0x10,%esp
			break;
  8009d4:	eb 23                	jmp    8009f9 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009d6:	83 ec 08             	sub    $0x8,%esp
  8009d9:	ff 75 0c             	pushl  0xc(%ebp)
  8009dc:	6a 25                	push   $0x25
  8009de:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e1:	ff d0                	call   *%eax
  8009e3:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009e6:	ff 4d 10             	decl   0x10(%ebp)
  8009e9:	eb 03                	jmp    8009ee <vprintfmt+0x3b1>
  8009eb:	ff 4d 10             	decl   0x10(%ebp)
  8009ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f1:	48                   	dec    %eax
  8009f2:	8a 00                	mov    (%eax),%al
  8009f4:	3c 25                	cmp    $0x25,%al
  8009f6:	75 f3                	jne    8009eb <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8009f8:	90                   	nop
		}
	}
  8009f9:	e9 47 fc ff ff       	jmp    800645 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8009fe:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8009ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a02:	5b                   	pop    %ebx
  800a03:	5e                   	pop    %esi
  800a04:	5d                   	pop    %ebp
  800a05:	c3                   	ret    

00800a06 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a06:	55                   	push   %ebp
  800a07:	89 e5                	mov    %esp,%ebp
  800a09:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a0c:	8d 45 10             	lea    0x10(%ebp),%eax
  800a0f:	83 c0 04             	add    $0x4,%eax
  800a12:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a15:	8b 45 10             	mov    0x10(%ebp),%eax
  800a18:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1b:	50                   	push   %eax
  800a1c:	ff 75 0c             	pushl  0xc(%ebp)
  800a1f:	ff 75 08             	pushl  0x8(%ebp)
  800a22:	e8 16 fc ff ff       	call   80063d <vprintfmt>
  800a27:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a2a:	90                   	nop
  800a2b:	c9                   	leave  
  800a2c:	c3                   	ret    

00800a2d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a2d:	55                   	push   %ebp
  800a2e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a33:	8b 40 08             	mov    0x8(%eax),%eax
  800a36:	8d 50 01             	lea    0x1(%eax),%edx
  800a39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a42:	8b 10                	mov    (%eax),%edx
  800a44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a47:	8b 40 04             	mov    0x4(%eax),%eax
  800a4a:	39 c2                	cmp    %eax,%edx
  800a4c:	73 12                	jae    800a60 <sprintputch+0x33>
		*b->buf++ = ch;
  800a4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a51:	8b 00                	mov    (%eax),%eax
  800a53:	8d 48 01             	lea    0x1(%eax),%ecx
  800a56:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a59:	89 0a                	mov    %ecx,(%edx)
  800a5b:	8b 55 08             	mov    0x8(%ebp),%edx
  800a5e:	88 10                	mov    %dl,(%eax)
}
  800a60:	90                   	nop
  800a61:	5d                   	pop    %ebp
  800a62:	c3                   	ret    

00800a63 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a63:	55                   	push   %ebp
  800a64:	89 e5                	mov    %esp,%ebp
  800a66:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a69:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a72:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a75:	8b 45 08             	mov    0x8(%ebp),%eax
  800a78:	01 d0                	add    %edx,%eax
  800a7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a84:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a88:	74 06                	je     800a90 <vsnprintf+0x2d>
  800a8a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a8e:	7f 07                	jg     800a97 <vsnprintf+0x34>
		return -E_INVAL;
  800a90:	b8 03 00 00 00       	mov    $0x3,%eax
  800a95:	eb 20                	jmp    800ab7 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a97:	ff 75 14             	pushl  0x14(%ebp)
  800a9a:	ff 75 10             	pushl  0x10(%ebp)
  800a9d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800aa0:	50                   	push   %eax
  800aa1:	68 2d 0a 80 00       	push   $0x800a2d
  800aa6:	e8 92 fb ff ff       	call   80063d <vprintfmt>
  800aab:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800aae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ab1:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ab7:	c9                   	leave  
  800ab8:	c3                   	ret    

00800ab9 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ab9:	55                   	push   %ebp
  800aba:	89 e5                	mov    %esp,%ebp
  800abc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800abf:	8d 45 10             	lea    0x10(%ebp),%eax
  800ac2:	83 c0 04             	add    $0x4,%eax
  800ac5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ac8:	8b 45 10             	mov    0x10(%ebp),%eax
  800acb:	ff 75 f4             	pushl  -0xc(%ebp)
  800ace:	50                   	push   %eax
  800acf:	ff 75 0c             	pushl  0xc(%ebp)
  800ad2:	ff 75 08             	pushl  0x8(%ebp)
  800ad5:	e8 89 ff ff ff       	call   800a63 <vsnprintf>
  800ada:	83 c4 10             	add    $0x10,%esp
  800add:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ae0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ae3:	c9                   	leave  
  800ae4:	c3                   	ret    

00800ae5 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ae5:	55                   	push   %ebp
  800ae6:	89 e5                	mov    %esp,%ebp
  800ae8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800aeb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800af2:	eb 06                	jmp    800afa <strlen+0x15>
		n++;
  800af4:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800af7:	ff 45 08             	incl   0x8(%ebp)
  800afa:	8b 45 08             	mov    0x8(%ebp),%eax
  800afd:	8a 00                	mov    (%eax),%al
  800aff:	84 c0                	test   %al,%al
  800b01:	75 f1                	jne    800af4 <strlen+0xf>
		n++;
	return n;
  800b03:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b06:	c9                   	leave  
  800b07:	c3                   	ret    

00800b08 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b08:	55                   	push   %ebp
  800b09:	89 e5                	mov    %esp,%ebp
  800b0b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b0e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b15:	eb 09                	jmp    800b20 <strnlen+0x18>
		n++;
  800b17:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b1a:	ff 45 08             	incl   0x8(%ebp)
  800b1d:	ff 4d 0c             	decl   0xc(%ebp)
  800b20:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b24:	74 09                	je     800b2f <strnlen+0x27>
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	8a 00                	mov    (%eax),%al
  800b2b:	84 c0                	test   %al,%al
  800b2d:	75 e8                	jne    800b17 <strnlen+0xf>
		n++;
	return n;
  800b2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b32:	c9                   	leave  
  800b33:	c3                   	ret    

00800b34 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b34:	55                   	push   %ebp
  800b35:	89 e5                	mov    %esp,%ebp
  800b37:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b40:	90                   	nop
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	8d 50 01             	lea    0x1(%eax),%edx
  800b47:	89 55 08             	mov    %edx,0x8(%ebp)
  800b4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b4d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b50:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b53:	8a 12                	mov    (%edx),%dl
  800b55:	88 10                	mov    %dl,(%eax)
  800b57:	8a 00                	mov    (%eax),%al
  800b59:	84 c0                	test   %al,%al
  800b5b:	75 e4                	jne    800b41 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b60:	c9                   	leave  
  800b61:	c3                   	ret    

00800b62 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b62:	55                   	push   %ebp
  800b63:	89 e5                	mov    %esp,%ebp
  800b65:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b6e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b75:	eb 1f                	jmp    800b96 <strncpy+0x34>
		*dst++ = *src;
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	8d 50 01             	lea    0x1(%eax),%edx
  800b7d:	89 55 08             	mov    %edx,0x8(%ebp)
  800b80:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b83:	8a 12                	mov    (%edx),%dl
  800b85:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8a:	8a 00                	mov    (%eax),%al
  800b8c:	84 c0                	test   %al,%al
  800b8e:	74 03                	je     800b93 <strncpy+0x31>
			src++;
  800b90:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b93:	ff 45 fc             	incl   -0x4(%ebp)
  800b96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b99:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b9c:	72 d9                	jb     800b77 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ba1:	c9                   	leave  
  800ba2:	c3                   	ret    

00800ba3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ba3:	55                   	push   %ebp
  800ba4:	89 e5                	mov    %esp,%ebp
  800ba6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800baf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bb3:	74 30                	je     800be5 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bb5:	eb 16                	jmp    800bcd <strlcpy+0x2a>
			*dst++ = *src++;
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	8d 50 01             	lea    0x1(%eax),%edx
  800bbd:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bc9:	8a 12                	mov    (%edx),%dl
  800bcb:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bcd:	ff 4d 10             	decl   0x10(%ebp)
  800bd0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bd4:	74 09                	je     800bdf <strlcpy+0x3c>
  800bd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd9:	8a 00                	mov    (%eax),%al
  800bdb:	84 c0                	test   %al,%al
  800bdd:	75 d8                	jne    800bb7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800be5:	8b 55 08             	mov    0x8(%ebp),%edx
  800be8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800beb:	29 c2                	sub    %eax,%edx
  800bed:	89 d0                	mov    %edx,%eax
}
  800bef:	c9                   	leave  
  800bf0:	c3                   	ret    

00800bf1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800bf1:	55                   	push   %ebp
  800bf2:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bf4:	eb 06                	jmp    800bfc <strcmp+0xb>
		p++, q++;
  800bf6:	ff 45 08             	incl   0x8(%ebp)
  800bf9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	8a 00                	mov    (%eax),%al
  800c01:	84 c0                	test   %al,%al
  800c03:	74 0e                	je     800c13 <strcmp+0x22>
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	8a 10                	mov    (%eax),%dl
  800c0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0d:	8a 00                	mov    (%eax),%al
  800c0f:	38 c2                	cmp    %al,%dl
  800c11:	74 e3                	je     800bf6 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	8a 00                	mov    (%eax),%al
  800c18:	0f b6 d0             	movzbl %al,%edx
  800c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1e:	8a 00                	mov    (%eax),%al
  800c20:	0f b6 c0             	movzbl %al,%eax
  800c23:	29 c2                	sub    %eax,%edx
  800c25:	89 d0                	mov    %edx,%eax
}
  800c27:	5d                   	pop    %ebp
  800c28:	c3                   	ret    

00800c29 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c29:	55                   	push   %ebp
  800c2a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c2c:	eb 09                	jmp    800c37 <strncmp+0xe>
		n--, p++, q++;
  800c2e:	ff 4d 10             	decl   0x10(%ebp)
  800c31:	ff 45 08             	incl   0x8(%ebp)
  800c34:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c37:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c3b:	74 17                	je     800c54 <strncmp+0x2b>
  800c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c40:	8a 00                	mov    (%eax),%al
  800c42:	84 c0                	test   %al,%al
  800c44:	74 0e                	je     800c54 <strncmp+0x2b>
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	8a 10                	mov    (%eax),%dl
  800c4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4e:	8a 00                	mov    (%eax),%al
  800c50:	38 c2                	cmp    %al,%dl
  800c52:	74 da                	je     800c2e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c58:	75 07                	jne    800c61 <strncmp+0x38>
		return 0;
  800c5a:	b8 00 00 00 00       	mov    $0x0,%eax
  800c5f:	eb 14                	jmp    800c75 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	8a 00                	mov    (%eax),%al
  800c66:	0f b6 d0             	movzbl %al,%edx
  800c69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6c:	8a 00                	mov    (%eax),%al
  800c6e:	0f b6 c0             	movzbl %al,%eax
  800c71:	29 c2                	sub    %eax,%edx
  800c73:	89 d0                	mov    %edx,%eax
}
  800c75:	5d                   	pop    %ebp
  800c76:	c3                   	ret    

00800c77 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c77:	55                   	push   %ebp
  800c78:	89 e5                	mov    %esp,%ebp
  800c7a:	83 ec 04             	sub    $0x4,%esp
  800c7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c80:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c83:	eb 12                	jmp    800c97 <strchr+0x20>
		if (*s == c)
  800c85:	8b 45 08             	mov    0x8(%ebp),%eax
  800c88:	8a 00                	mov    (%eax),%al
  800c8a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c8d:	75 05                	jne    800c94 <strchr+0x1d>
			return (char *) s;
  800c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c92:	eb 11                	jmp    800ca5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c94:	ff 45 08             	incl   0x8(%ebp)
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	8a 00                	mov    (%eax),%al
  800c9c:	84 c0                	test   %al,%al
  800c9e:	75 e5                	jne    800c85 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ca0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ca5:	c9                   	leave  
  800ca6:	c3                   	ret    

00800ca7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ca7:	55                   	push   %ebp
  800ca8:	89 e5                	mov    %esp,%ebp
  800caa:	83 ec 04             	sub    $0x4,%esp
  800cad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cb3:	eb 0d                	jmp    800cc2 <strfind+0x1b>
		if (*s == c)
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	8a 00                	mov    (%eax),%al
  800cba:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cbd:	74 0e                	je     800ccd <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cbf:	ff 45 08             	incl   0x8(%ebp)
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	8a 00                	mov    (%eax),%al
  800cc7:	84 c0                	test   %al,%al
  800cc9:	75 ea                	jne    800cb5 <strfind+0xe>
  800ccb:	eb 01                	jmp    800cce <strfind+0x27>
		if (*s == c)
			break;
  800ccd:	90                   	nop
	return (char *) s;
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cd1:	c9                   	leave  
  800cd2:	c3                   	ret    

00800cd3 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800cd3:	55                   	push   %ebp
  800cd4:	89 e5                	mov    %esp,%ebp
  800cd6:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800cdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ce5:	eb 0e                	jmp    800cf5 <memset+0x22>
		*p++ = c;
  800ce7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cea:	8d 50 01             	lea    0x1(%eax),%edx
  800ced:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800cf0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf3:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800cf5:	ff 4d f8             	decl   -0x8(%ebp)
  800cf8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800cfc:	79 e9                	jns    800ce7 <memset+0x14>
		*p++ = c;

	return v;
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d01:	c9                   	leave  
  800d02:	c3                   	ret    

00800d03 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d03:	55                   	push   %ebp
  800d04:	89 e5                	mov    %esp,%ebp
  800d06:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d15:	eb 16                	jmp    800d2d <memcpy+0x2a>
		*d++ = *s++;
  800d17:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d1a:	8d 50 01             	lea    0x1(%eax),%edx
  800d1d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d20:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d23:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d26:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d29:	8a 12                	mov    (%edx),%dl
  800d2b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d30:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d33:	89 55 10             	mov    %edx,0x10(%ebp)
  800d36:	85 c0                	test   %eax,%eax
  800d38:	75 dd                	jne    800d17 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d3d:	c9                   	leave  
  800d3e:	c3                   	ret    

00800d3f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d3f:	55                   	push   %ebp
  800d40:	89 e5                	mov    %esp,%ebp
  800d42:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d48:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d54:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d57:	73 50                	jae    800da9 <memmove+0x6a>
  800d59:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5f:	01 d0                	add    %edx,%eax
  800d61:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d64:	76 43                	jbe    800da9 <memmove+0x6a>
		s += n;
  800d66:	8b 45 10             	mov    0x10(%ebp),%eax
  800d69:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800d6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d72:	eb 10                	jmp    800d84 <memmove+0x45>
			*--d = *--s;
  800d74:	ff 4d f8             	decl   -0x8(%ebp)
  800d77:	ff 4d fc             	decl   -0x4(%ebp)
  800d7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d7d:	8a 10                	mov    (%eax),%dl
  800d7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d82:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800d84:	8b 45 10             	mov    0x10(%ebp),%eax
  800d87:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d8a:	89 55 10             	mov    %edx,0x10(%ebp)
  800d8d:	85 c0                	test   %eax,%eax
  800d8f:	75 e3                	jne    800d74 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800d91:	eb 23                	jmp    800db6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800d93:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d96:	8d 50 01             	lea    0x1(%eax),%edx
  800d99:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d9c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d9f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800da2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800da5:	8a 12                	mov    (%edx),%dl
  800da7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800da9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dac:	8d 50 ff             	lea    -0x1(%eax),%edx
  800daf:	89 55 10             	mov    %edx,0x10(%ebp)
  800db2:	85 c0                	test   %eax,%eax
  800db4:	75 dd                	jne    800d93 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800db6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800db9:	c9                   	leave  
  800dba:	c3                   	ret    

00800dbb <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800dbb:	55                   	push   %ebp
  800dbc:	89 e5                	mov    %esp,%ebp
  800dbe:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800dc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dca:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800dcd:	eb 2a                	jmp    800df9 <memcmp+0x3e>
		if (*s1 != *s2)
  800dcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd2:	8a 10                	mov    (%eax),%dl
  800dd4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd7:	8a 00                	mov    (%eax),%al
  800dd9:	38 c2                	cmp    %al,%dl
  800ddb:	74 16                	je     800df3 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ddd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de0:	8a 00                	mov    (%eax),%al
  800de2:	0f b6 d0             	movzbl %al,%edx
  800de5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de8:	8a 00                	mov    (%eax),%al
  800dea:	0f b6 c0             	movzbl %al,%eax
  800ded:	29 c2                	sub    %eax,%edx
  800def:	89 d0                	mov    %edx,%eax
  800df1:	eb 18                	jmp    800e0b <memcmp+0x50>
		s1++, s2++;
  800df3:	ff 45 fc             	incl   -0x4(%ebp)
  800df6:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800df9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dff:	89 55 10             	mov    %edx,0x10(%ebp)
  800e02:	85 c0                	test   %eax,%eax
  800e04:	75 c9                	jne    800dcf <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e06:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e0b:	c9                   	leave  
  800e0c:	c3                   	ret    

00800e0d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e0d:	55                   	push   %ebp
  800e0e:	89 e5                	mov    %esp,%ebp
  800e10:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e13:	8b 55 08             	mov    0x8(%ebp),%edx
  800e16:	8b 45 10             	mov    0x10(%ebp),%eax
  800e19:	01 d0                	add    %edx,%eax
  800e1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e1e:	eb 15                	jmp    800e35 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
  800e23:	8a 00                	mov    (%eax),%al
  800e25:	0f b6 d0             	movzbl %al,%edx
  800e28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2b:	0f b6 c0             	movzbl %al,%eax
  800e2e:	39 c2                	cmp    %eax,%edx
  800e30:	74 0d                	je     800e3f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e32:	ff 45 08             	incl   0x8(%ebp)
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e3b:	72 e3                	jb     800e20 <memfind+0x13>
  800e3d:	eb 01                	jmp    800e40 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e3f:	90                   	nop
	return (void *) s;
  800e40:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e43:	c9                   	leave  
  800e44:	c3                   	ret    

00800e45 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e45:	55                   	push   %ebp
  800e46:	89 e5                	mov    %esp,%ebp
  800e48:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e4b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e52:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e59:	eb 03                	jmp    800e5e <strtol+0x19>
		s++;
  800e5b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	8a 00                	mov    (%eax),%al
  800e63:	3c 20                	cmp    $0x20,%al
  800e65:	74 f4                	je     800e5b <strtol+0x16>
  800e67:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6a:	8a 00                	mov    (%eax),%al
  800e6c:	3c 09                	cmp    $0x9,%al
  800e6e:	74 eb                	je     800e5b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800e70:	8b 45 08             	mov    0x8(%ebp),%eax
  800e73:	8a 00                	mov    (%eax),%al
  800e75:	3c 2b                	cmp    $0x2b,%al
  800e77:	75 05                	jne    800e7e <strtol+0x39>
		s++;
  800e79:	ff 45 08             	incl   0x8(%ebp)
  800e7c:	eb 13                	jmp    800e91 <strtol+0x4c>
	else if (*s == '-')
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	8a 00                	mov    (%eax),%al
  800e83:	3c 2d                	cmp    $0x2d,%al
  800e85:	75 0a                	jne    800e91 <strtol+0x4c>
		s++, neg = 1;
  800e87:	ff 45 08             	incl   0x8(%ebp)
  800e8a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800e91:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e95:	74 06                	je     800e9d <strtol+0x58>
  800e97:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800e9b:	75 20                	jne    800ebd <strtol+0x78>
  800e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea0:	8a 00                	mov    (%eax),%al
  800ea2:	3c 30                	cmp    $0x30,%al
  800ea4:	75 17                	jne    800ebd <strtol+0x78>
  800ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea9:	40                   	inc    %eax
  800eaa:	8a 00                	mov    (%eax),%al
  800eac:	3c 78                	cmp    $0x78,%al
  800eae:	75 0d                	jne    800ebd <strtol+0x78>
		s += 2, base = 16;
  800eb0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800eb4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ebb:	eb 28                	jmp    800ee5 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ebd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec1:	75 15                	jne    800ed8 <strtol+0x93>
  800ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec6:	8a 00                	mov    (%eax),%al
  800ec8:	3c 30                	cmp    $0x30,%al
  800eca:	75 0c                	jne    800ed8 <strtol+0x93>
		s++, base = 8;
  800ecc:	ff 45 08             	incl   0x8(%ebp)
  800ecf:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800ed6:	eb 0d                	jmp    800ee5 <strtol+0xa0>
	else if (base == 0)
  800ed8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800edc:	75 07                	jne    800ee5 <strtol+0xa0>
		base = 10;
  800ede:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee8:	8a 00                	mov    (%eax),%al
  800eea:	3c 2f                	cmp    $0x2f,%al
  800eec:	7e 19                	jle    800f07 <strtol+0xc2>
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	3c 39                	cmp    $0x39,%al
  800ef5:	7f 10                	jg     800f07 <strtol+0xc2>
			dig = *s - '0';
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	8a 00                	mov    (%eax),%al
  800efc:	0f be c0             	movsbl %al,%eax
  800eff:	83 e8 30             	sub    $0x30,%eax
  800f02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f05:	eb 42                	jmp    800f49 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	8a 00                	mov    (%eax),%al
  800f0c:	3c 60                	cmp    $0x60,%al
  800f0e:	7e 19                	jle    800f29 <strtol+0xe4>
  800f10:	8b 45 08             	mov    0x8(%ebp),%eax
  800f13:	8a 00                	mov    (%eax),%al
  800f15:	3c 7a                	cmp    $0x7a,%al
  800f17:	7f 10                	jg     800f29 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	8a 00                	mov    (%eax),%al
  800f1e:	0f be c0             	movsbl %al,%eax
  800f21:	83 e8 57             	sub    $0x57,%eax
  800f24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f27:	eb 20                	jmp    800f49 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f29:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2c:	8a 00                	mov    (%eax),%al
  800f2e:	3c 40                	cmp    $0x40,%al
  800f30:	7e 39                	jle    800f6b <strtol+0x126>
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	8a 00                	mov    (%eax),%al
  800f37:	3c 5a                	cmp    $0x5a,%al
  800f39:	7f 30                	jg     800f6b <strtol+0x126>
			dig = *s - 'A' + 10;
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3e:	8a 00                	mov    (%eax),%al
  800f40:	0f be c0             	movsbl %al,%eax
  800f43:	83 e8 37             	sub    $0x37,%eax
  800f46:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f49:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f4c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f4f:	7d 19                	jge    800f6a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f51:	ff 45 08             	incl   0x8(%ebp)
  800f54:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f57:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f5b:	89 c2                	mov    %eax,%edx
  800f5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f60:	01 d0                	add    %edx,%eax
  800f62:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f65:	e9 7b ff ff ff       	jmp    800ee5 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800f6a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800f6b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f6f:	74 08                	je     800f79 <strtol+0x134>
		*endptr = (char *) s;
  800f71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f74:	8b 55 08             	mov    0x8(%ebp),%edx
  800f77:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800f79:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f7d:	74 07                	je     800f86 <strtol+0x141>
  800f7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f82:	f7 d8                	neg    %eax
  800f84:	eb 03                	jmp    800f89 <strtol+0x144>
  800f86:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f89:	c9                   	leave  
  800f8a:	c3                   	ret    

00800f8b <ltostr>:

void
ltostr(long value, char *str)
{
  800f8b:	55                   	push   %ebp
  800f8c:	89 e5                	mov    %esp,%ebp
  800f8e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800f91:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800f98:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800f9f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fa3:	79 13                	jns    800fb8 <ltostr+0x2d>
	{
		neg = 1;
  800fa5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800fac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800faf:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800fb2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800fb5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800fc0:	99                   	cltd   
  800fc1:	f7 f9                	idiv   %ecx
  800fc3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800fc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc9:	8d 50 01             	lea    0x1(%eax),%edx
  800fcc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fcf:	89 c2                	mov    %eax,%edx
  800fd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd4:	01 d0                	add    %edx,%eax
  800fd6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800fd9:	83 c2 30             	add    $0x30,%edx
  800fdc:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800fde:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800fe1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fe6:	f7 e9                	imul   %ecx
  800fe8:	c1 fa 02             	sar    $0x2,%edx
  800feb:	89 c8                	mov    %ecx,%eax
  800fed:	c1 f8 1f             	sar    $0x1f,%eax
  800ff0:	29 c2                	sub    %eax,%edx
  800ff2:	89 d0                	mov    %edx,%eax
  800ff4:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ff7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ffa:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fff:	f7 e9                	imul   %ecx
  801001:	c1 fa 02             	sar    $0x2,%edx
  801004:	89 c8                	mov    %ecx,%eax
  801006:	c1 f8 1f             	sar    $0x1f,%eax
  801009:	29 c2                	sub    %eax,%edx
  80100b:	89 d0                	mov    %edx,%eax
  80100d:	c1 e0 02             	shl    $0x2,%eax
  801010:	01 d0                	add    %edx,%eax
  801012:	01 c0                	add    %eax,%eax
  801014:	29 c1                	sub    %eax,%ecx
  801016:	89 ca                	mov    %ecx,%edx
  801018:	85 d2                	test   %edx,%edx
  80101a:	75 9c                	jne    800fb8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80101c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801023:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801026:	48                   	dec    %eax
  801027:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80102a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80102e:	74 3d                	je     80106d <ltostr+0xe2>
		start = 1 ;
  801030:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801037:	eb 34                	jmp    80106d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801039:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80103c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103f:	01 d0                	add    %edx,%eax
  801041:	8a 00                	mov    (%eax),%al
  801043:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801046:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801049:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104c:	01 c2                	add    %eax,%edx
  80104e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801051:	8b 45 0c             	mov    0xc(%ebp),%eax
  801054:	01 c8                	add    %ecx,%eax
  801056:	8a 00                	mov    (%eax),%al
  801058:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80105a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80105d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801060:	01 c2                	add    %eax,%edx
  801062:	8a 45 eb             	mov    -0x15(%ebp),%al
  801065:	88 02                	mov    %al,(%edx)
		start++ ;
  801067:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80106a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80106d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801070:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801073:	7c c4                	jl     801039 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801075:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801078:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107b:	01 d0                	add    %edx,%eax
  80107d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801080:	90                   	nop
  801081:	c9                   	leave  
  801082:	c3                   	ret    

00801083 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801083:	55                   	push   %ebp
  801084:	89 e5                	mov    %esp,%ebp
  801086:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801089:	ff 75 08             	pushl  0x8(%ebp)
  80108c:	e8 54 fa ff ff       	call   800ae5 <strlen>
  801091:	83 c4 04             	add    $0x4,%esp
  801094:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801097:	ff 75 0c             	pushl  0xc(%ebp)
  80109a:	e8 46 fa ff ff       	call   800ae5 <strlen>
  80109f:	83 c4 04             	add    $0x4,%esp
  8010a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010b3:	eb 17                	jmp    8010cc <strcconcat+0x49>
		final[s] = str1[s] ;
  8010b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010bb:	01 c2                	add    %eax,%edx
  8010bd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c3:	01 c8                	add    %ecx,%eax
  8010c5:	8a 00                	mov    (%eax),%al
  8010c7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010c9:	ff 45 fc             	incl   -0x4(%ebp)
  8010cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010d2:	7c e1                	jl     8010b5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8010d4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8010db:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010e2:	eb 1f                	jmp    801103 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8010e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e7:	8d 50 01             	lea    0x1(%eax),%edx
  8010ea:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010ed:	89 c2                	mov    %eax,%edx
  8010ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f2:	01 c2                	add    %eax,%edx
  8010f4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8010f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fa:	01 c8                	add    %ecx,%eax
  8010fc:	8a 00                	mov    (%eax),%al
  8010fe:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801100:	ff 45 f8             	incl   -0x8(%ebp)
  801103:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801106:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801109:	7c d9                	jl     8010e4 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80110b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80110e:	8b 45 10             	mov    0x10(%ebp),%eax
  801111:	01 d0                	add    %edx,%eax
  801113:	c6 00 00             	movb   $0x0,(%eax)
}
  801116:	90                   	nop
  801117:	c9                   	leave  
  801118:	c3                   	ret    

00801119 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801119:	55                   	push   %ebp
  80111a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80111c:	8b 45 14             	mov    0x14(%ebp),%eax
  80111f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801125:	8b 45 14             	mov    0x14(%ebp),%eax
  801128:	8b 00                	mov    (%eax),%eax
  80112a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801131:	8b 45 10             	mov    0x10(%ebp),%eax
  801134:	01 d0                	add    %edx,%eax
  801136:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80113c:	eb 0c                	jmp    80114a <strsplit+0x31>
			*string++ = 0;
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	8d 50 01             	lea    0x1(%eax),%edx
  801144:	89 55 08             	mov    %edx,0x8(%ebp)
  801147:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80114a:	8b 45 08             	mov    0x8(%ebp),%eax
  80114d:	8a 00                	mov    (%eax),%al
  80114f:	84 c0                	test   %al,%al
  801151:	74 18                	je     80116b <strsplit+0x52>
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
  801156:	8a 00                	mov    (%eax),%al
  801158:	0f be c0             	movsbl %al,%eax
  80115b:	50                   	push   %eax
  80115c:	ff 75 0c             	pushl  0xc(%ebp)
  80115f:	e8 13 fb ff ff       	call   800c77 <strchr>
  801164:	83 c4 08             	add    $0x8,%esp
  801167:	85 c0                	test   %eax,%eax
  801169:	75 d3                	jne    80113e <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	84 c0                	test   %al,%al
  801172:	74 5a                	je     8011ce <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801174:	8b 45 14             	mov    0x14(%ebp),%eax
  801177:	8b 00                	mov    (%eax),%eax
  801179:	83 f8 0f             	cmp    $0xf,%eax
  80117c:	75 07                	jne    801185 <strsplit+0x6c>
		{
			return 0;
  80117e:	b8 00 00 00 00       	mov    $0x0,%eax
  801183:	eb 66                	jmp    8011eb <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801185:	8b 45 14             	mov    0x14(%ebp),%eax
  801188:	8b 00                	mov    (%eax),%eax
  80118a:	8d 48 01             	lea    0x1(%eax),%ecx
  80118d:	8b 55 14             	mov    0x14(%ebp),%edx
  801190:	89 0a                	mov    %ecx,(%edx)
  801192:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801199:	8b 45 10             	mov    0x10(%ebp),%eax
  80119c:	01 c2                	add    %eax,%edx
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011a3:	eb 03                	jmp    8011a8 <strsplit+0x8f>
			string++;
  8011a5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ab:	8a 00                	mov    (%eax),%al
  8011ad:	84 c0                	test   %al,%al
  8011af:	74 8b                	je     80113c <strsplit+0x23>
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	0f be c0             	movsbl %al,%eax
  8011b9:	50                   	push   %eax
  8011ba:	ff 75 0c             	pushl  0xc(%ebp)
  8011bd:	e8 b5 fa ff ff       	call   800c77 <strchr>
  8011c2:	83 c4 08             	add    $0x8,%esp
  8011c5:	85 c0                	test   %eax,%eax
  8011c7:	74 dc                	je     8011a5 <strsplit+0x8c>
			string++;
	}
  8011c9:	e9 6e ff ff ff       	jmp    80113c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011ce:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d2:	8b 00                	mov    (%eax),%eax
  8011d4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011db:	8b 45 10             	mov    0x10(%ebp),%eax
  8011de:	01 d0                	add    %edx,%eax
  8011e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8011e6:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8011eb:	c9                   	leave  
  8011ec:	c3                   	ret    

008011ed <malloc>:
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size) {
  8011ed:	55                   	push   %ebp
  8011ee:	89 e5                	mov    %esp,%ebp
  8011f0:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  8011f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f6:	c1 e8 0c             	shr    $0xc,%eax
  8011f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	//sizeofarray++;
	if (size % PAGE_SIZE != 0)
  8011fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ff:	25 ff 0f 00 00       	and    $0xfff,%eax
  801204:	85 c0                	test   %eax,%eax
  801206:	74 03                	je     80120b <malloc+0x1e>
		num++;
  801208:	ff 45 f4             	incl   -0xc(%ebp)
//		addresses[sizeofarray] = last_addres;
//		changed[sizeofarray] = 1;
//		sizeofarray++;
//		return (void*) return_addres;
	//} else {
	if (changes == 0) {
  80120b:	a1 28 30 80 00       	mov    0x803028,%eax
  801210:	85 c0                	test   %eax,%eax
  801212:	75 71                	jne    801285 <malloc+0x98>
		sys_allocateMem(last_addres, size);
  801214:	a1 04 30 80 00       	mov    0x803004,%eax
  801219:	83 ec 08             	sub    $0x8,%esp
  80121c:	ff 75 08             	pushl  0x8(%ebp)
  80121f:	50                   	push   %eax
  801220:	e8 e4 04 00 00       	call   801709 <sys_allocateMem>
  801225:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801228:	a1 04 30 80 00       	mov    0x803004,%eax
  80122d:	89 45 d8             	mov    %eax,-0x28(%ebp)
		last_addres += num * PAGE_SIZE;
  801230:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801233:	c1 e0 0c             	shl    $0xc,%eax
  801236:	89 c2                	mov    %eax,%edx
  801238:	a1 04 30 80 00       	mov    0x803004,%eax
  80123d:	01 d0                	add    %edx,%eax
  80123f:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801244:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801249:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80124c:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801253:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801258:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80125b:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  801262:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801267:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80126e:	01 00 00 00 
		sizeofarray++;
  801272:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801277:	40                   	inc    %eax
  801278:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  80127d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801280:	e9 f7 00 00 00       	jmp    80137c <malloc+0x18f>
	} else {
		int count = 0;
  801285:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 1000;
  80128c:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
		int index = -1;
  801293:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  80129a:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8012a1:	eb 7c                	jmp    80131f <malloc+0x132>
		{
			uint32 *pg = NULL;
  8012a3:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
			for (int j = 0; j < sizeofarray; j++) {
  8012aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8012b1:	eb 1a                	jmp    8012cd <malloc+0xe0>
				if (addresses[j] == i) {
  8012b3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8012b6:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8012bd:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8012c0:	75 08                	jne    8012ca <malloc+0xdd>
					index = j;
  8012c2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8012c5:	89 45 e8             	mov    %eax,-0x18(%ebp)
					break;
  8012c8:	eb 0d                	jmp    8012d7 <malloc+0xea>
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
		{
			uint32 *pg = NULL;
			for (int j = 0; j < sizeofarray; j++) {
  8012ca:	ff 45 dc             	incl   -0x24(%ebp)
  8012cd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8012d2:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8012d5:	7c dc                	jl     8012b3 <malloc+0xc6>
					index = j;
					break;
				}
			}

			if (index == -1) {
  8012d7:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8012db:	75 05                	jne    8012e2 <malloc+0xf5>
				count++;
  8012dd:	ff 45 f0             	incl   -0x10(%ebp)
  8012e0:	eb 36                	jmp    801318 <malloc+0x12b>
			} else {
				if (changed[index] == 0) {
  8012e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8012e5:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8012ec:	85 c0                	test   %eax,%eax
  8012ee:	75 05                	jne    8012f5 <malloc+0x108>
					count++;
  8012f0:	ff 45 f0             	incl   -0x10(%ebp)
  8012f3:	eb 23                	jmp    801318 <malloc+0x12b>
				} else {
					if (count < min && count >= num) {
  8012f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012f8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8012fb:	7d 14                	jge    801311 <malloc+0x124>
  8012fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801300:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801303:	7c 0c                	jl     801311 <malloc+0x124>
						min = count;
  801305:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801308:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss = i;
  80130b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80130e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
					}
					count = 0;
  801311:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	} else {
		int count = 0;
		int min = 1000;
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  801318:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  80131f:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801326:	0f 86 77 ff ff ff    	jbe    8012a3 <malloc+0xb6>

			}

		}

		sys_allocateMem(min_addresss, size);
  80132c:	83 ec 08             	sub    $0x8,%esp
  80132f:	ff 75 08             	pushl  0x8(%ebp)
  801332:	ff 75 e4             	pushl  -0x1c(%ebp)
  801335:	e8 cf 03 00 00       	call   801709 <sys_allocateMem>
  80133a:	83 c4 10             	add    $0x10,%esp
		numOfPages[sizeofarray] = num;
  80133d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801342:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801345:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = last_addres;
  80134c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801351:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801357:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  80135e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801363:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80136a:	01 00 00 00 
		sizeofarray++;
  80136e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801373:	40                   	inc    %eax
  801374:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) min_addresss;
  801379:	8b 45 e4             	mov    -0x1c(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  80137c:	c9                   	leave  
  80137d:	c3                   	ret    

0080137e <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80137e:	55                   	push   %ebp
  80137f:	89 e5                	mov    %esp,%ebp
  801381:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  80138a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801391:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801398:	eb 30                	jmp    8013ca <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  80139a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80139d:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8013a4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8013a7:	75 1e                	jne    8013c7 <free+0x49>
  8013a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013ac:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8013b3:	83 f8 01             	cmp    $0x1,%eax
  8013b6:	75 0f                	jne    8013c7 <free+0x49>
			is_found = 1;
  8013b8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  8013bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  8013c5:	eb 0d                	jmp    8013d4 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8013c7:	ff 45 ec             	incl   -0x14(%ebp)
  8013ca:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013cf:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8013d2:	7c c6                	jl     80139a <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  8013d4:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8013d8:	75 4f                	jne    801429 <free+0xab>
		size = numOfPages[index] * PAGE_SIZE;
  8013da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013dd:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8013e4:	c1 e0 0c             	shl    $0xc,%eax
  8013e7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  8013ea:	83 ec 08             	sub    $0x8,%esp
  8013ed:	ff 75 e4             	pushl  -0x1c(%ebp)
  8013f0:	68 b0 24 80 00       	push   $0x8024b0
  8013f5:	e8 69 f0 ff ff       	call   800463 <cprintf>
  8013fa:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  8013fd:	83 ec 08             	sub    $0x8,%esp
  801400:	ff 75 e4             	pushl  -0x1c(%ebp)
  801403:	ff 75 e8             	pushl  -0x18(%ebp)
  801406:	e8 e2 02 00 00       	call   8016ed <sys_freeMem>
  80140b:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  80140e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801411:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801418:	00 00 00 00 
		changes++;
  80141c:	a1 28 30 80 00       	mov    0x803028,%eax
  801421:	40                   	inc    %eax
  801422:	a3 28 30 80 00       	mov    %eax,0x803028
		sys_freeMem(va, size);
		changed[index] = 0;
	}

	//refer to the project presentation and documentation for details
}
  801427:	eb 39                	jmp    801462 <free+0xe4>
		cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	} else {
		size = 513 * PAGE_SIZE;
  801429:	c7 45 e4 00 10 20 00 	movl   $0x201000,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801430:	83 ec 08             	sub    $0x8,%esp
  801433:	ff 75 e4             	pushl  -0x1c(%ebp)
  801436:	68 b0 24 80 00       	push   $0x8024b0
  80143b:	e8 23 f0 ff ff       	call   800463 <cprintf>
  801440:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801443:	83 ec 08             	sub    $0x8,%esp
  801446:	ff 75 e4             	pushl  -0x1c(%ebp)
  801449:	ff 75 e8             	pushl  -0x18(%ebp)
  80144c:	e8 9c 02 00 00       	call   8016ed <sys_freeMem>
  801451:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801454:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801457:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  80145e:	00 00 00 00 
	}

	//refer to the project presentation and documentation for details
}
  801462:	90                   	nop
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
  801468:	83 ec 18             	sub    $0x18,%esp
  80146b:	8b 45 10             	mov    0x10(%ebp),%eax
  80146e:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801471:	83 ec 04             	sub    $0x4,%esp
  801474:	68 d0 24 80 00       	push   $0x8024d0
  801479:	68 9d 00 00 00       	push   $0x9d
  80147e:	68 f3 24 80 00       	push   $0x8024f3
  801483:	e8 0b 07 00 00       	call   801b93 <_panic>

00801488 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801488:	55                   	push   %ebp
  801489:	89 e5                	mov    %esp,%ebp
  80148b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80148e:	83 ec 04             	sub    $0x4,%esp
  801491:	68 d0 24 80 00       	push   $0x8024d0
  801496:	68 a2 00 00 00       	push   $0xa2
  80149b:	68 f3 24 80 00       	push   $0x8024f3
  8014a0:	e8 ee 06 00 00       	call   801b93 <_panic>

008014a5 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  8014a5:	55                   	push   %ebp
  8014a6:	89 e5                	mov    %esp,%ebp
  8014a8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014ab:	83 ec 04             	sub    $0x4,%esp
  8014ae:	68 d0 24 80 00       	push   $0x8024d0
  8014b3:	68 a7 00 00 00       	push   $0xa7
  8014b8:	68 f3 24 80 00       	push   $0x8024f3
  8014bd:	e8 d1 06 00 00       	call   801b93 <_panic>

008014c2 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  8014c2:	55                   	push   %ebp
  8014c3:	89 e5                	mov    %esp,%ebp
  8014c5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014c8:	83 ec 04             	sub    $0x4,%esp
  8014cb:	68 d0 24 80 00       	push   $0x8024d0
  8014d0:	68 ab 00 00 00       	push   $0xab
  8014d5:	68 f3 24 80 00       	push   $0x8024f3
  8014da:	e8 b4 06 00 00       	call   801b93 <_panic>

008014df <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8014df:	55                   	push   %ebp
  8014e0:	89 e5                	mov    %esp,%ebp
  8014e2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014e5:	83 ec 04             	sub    $0x4,%esp
  8014e8:	68 d0 24 80 00       	push   $0x8024d0
  8014ed:	68 b0 00 00 00       	push   $0xb0
  8014f2:	68 f3 24 80 00       	push   $0x8024f3
  8014f7:	e8 97 06 00 00       	call   801b93 <_panic>

008014fc <shrink>:
}
void shrink(uint32 newSize) {
  8014fc:	55                   	push   %ebp
  8014fd:	89 e5                	mov    %esp,%ebp
  8014ff:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801502:	83 ec 04             	sub    $0x4,%esp
  801505:	68 d0 24 80 00       	push   $0x8024d0
  80150a:	68 b3 00 00 00       	push   $0xb3
  80150f:	68 f3 24 80 00       	push   $0x8024f3
  801514:	e8 7a 06 00 00       	call   801b93 <_panic>

00801519 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801519:	55                   	push   %ebp
  80151a:	89 e5                	mov    %esp,%ebp
  80151c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80151f:	83 ec 04             	sub    $0x4,%esp
  801522:	68 d0 24 80 00       	push   $0x8024d0
  801527:	68 b7 00 00 00       	push   $0xb7
  80152c:	68 f3 24 80 00       	push   $0x8024f3
  801531:	e8 5d 06 00 00       	call   801b93 <_panic>

00801536 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801536:	55                   	push   %ebp
  801537:	89 e5                	mov    %esp,%ebp
  801539:	57                   	push   %edi
  80153a:	56                   	push   %esi
  80153b:	53                   	push   %ebx
  80153c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	8b 55 0c             	mov    0xc(%ebp),%edx
  801545:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801548:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80154b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80154e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801551:	cd 30                	int    $0x30
  801553:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801556:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801559:	83 c4 10             	add    $0x10,%esp
  80155c:	5b                   	pop    %ebx
  80155d:	5e                   	pop    %esi
  80155e:	5f                   	pop    %edi
  80155f:	5d                   	pop    %ebp
  801560:	c3                   	ret    

00801561 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801561:	55                   	push   %ebp
  801562:	89 e5                	mov    %esp,%ebp
  801564:	83 ec 04             	sub    $0x4,%esp
  801567:	8b 45 10             	mov    0x10(%ebp),%eax
  80156a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80156d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	52                   	push   %edx
  801579:	ff 75 0c             	pushl  0xc(%ebp)
  80157c:	50                   	push   %eax
  80157d:	6a 00                	push   $0x0
  80157f:	e8 b2 ff ff ff       	call   801536 <syscall>
  801584:	83 c4 18             	add    $0x18,%esp
}
  801587:	90                   	nop
  801588:	c9                   	leave  
  801589:	c3                   	ret    

0080158a <sys_cgetc>:

int
sys_cgetc(void)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 01                	push   $0x1
  801599:	e8 98 ff ff ff       	call   801536 <syscall>
  80159e:	83 c4 18             	add    $0x18,%esp
}
  8015a1:	c9                   	leave  
  8015a2:	c3                   	ret    

008015a3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8015a3:	55                   	push   %ebp
  8015a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8015a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	50                   	push   %eax
  8015b2:	6a 05                	push   $0x5
  8015b4:	e8 7d ff ff ff       	call   801536 <syscall>
  8015b9:	83 c4 18             	add    $0x18,%esp
}
  8015bc:	c9                   	leave  
  8015bd:	c3                   	ret    

008015be <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015be:	55                   	push   %ebp
  8015bf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 02                	push   $0x2
  8015cd:	e8 64 ff ff ff       	call   801536 <syscall>
  8015d2:	83 c4 18             	add    $0x18,%esp
}
  8015d5:	c9                   	leave  
  8015d6:	c3                   	ret    

008015d7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 03                	push   $0x3
  8015e6:	e8 4b ff ff ff       	call   801536 <syscall>
  8015eb:	83 c4 18             	add    $0x18,%esp
}
  8015ee:	c9                   	leave  
  8015ef:	c3                   	ret    

008015f0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015f0:	55                   	push   %ebp
  8015f1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 04                	push   $0x4
  8015ff:	e8 32 ff ff ff       	call   801536 <syscall>
  801604:	83 c4 18             	add    $0x18,%esp
}
  801607:	c9                   	leave  
  801608:	c3                   	ret    

00801609 <sys_env_exit>:


void sys_env_exit(void)
{
  801609:	55                   	push   %ebp
  80160a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 06                	push   $0x6
  801618:	e8 19 ff ff ff       	call   801536 <syscall>
  80161d:	83 c4 18             	add    $0x18,%esp
}
  801620:	90                   	nop
  801621:	c9                   	leave  
  801622:	c3                   	ret    

00801623 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801623:	55                   	push   %ebp
  801624:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801626:	8b 55 0c             	mov    0xc(%ebp),%edx
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	52                   	push   %edx
  801633:	50                   	push   %eax
  801634:	6a 07                	push   $0x7
  801636:	e8 fb fe ff ff       	call   801536 <syscall>
  80163b:	83 c4 18             	add    $0x18,%esp
}
  80163e:	c9                   	leave  
  80163f:	c3                   	ret    

00801640 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
  801643:	56                   	push   %esi
  801644:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801645:	8b 75 18             	mov    0x18(%ebp),%esi
  801648:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80164b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80164e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801651:	8b 45 08             	mov    0x8(%ebp),%eax
  801654:	56                   	push   %esi
  801655:	53                   	push   %ebx
  801656:	51                   	push   %ecx
  801657:	52                   	push   %edx
  801658:	50                   	push   %eax
  801659:	6a 08                	push   $0x8
  80165b:	e8 d6 fe ff ff       	call   801536 <syscall>
  801660:	83 c4 18             	add    $0x18,%esp
}
  801663:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801666:	5b                   	pop    %ebx
  801667:	5e                   	pop    %esi
  801668:	5d                   	pop    %ebp
  801669:	c3                   	ret    

0080166a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80166a:	55                   	push   %ebp
  80166b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80166d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	52                   	push   %edx
  80167a:	50                   	push   %eax
  80167b:	6a 09                	push   $0x9
  80167d:	e8 b4 fe ff ff       	call   801536 <syscall>
  801682:	83 c4 18             	add    $0x18,%esp
}
  801685:	c9                   	leave  
  801686:	c3                   	ret    

00801687 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801687:	55                   	push   %ebp
  801688:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	ff 75 0c             	pushl  0xc(%ebp)
  801693:	ff 75 08             	pushl  0x8(%ebp)
  801696:	6a 0a                	push   $0xa
  801698:	e8 99 fe ff ff       	call   801536 <syscall>
  80169d:	83 c4 18             	add    $0x18,%esp
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 0b                	push   $0xb
  8016b1:	e8 80 fe ff ff       	call   801536 <syscall>
  8016b6:	83 c4 18             	add    $0x18,%esp
}
  8016b9:	c9                   	leave  
  8016ba:	c3                   	ret    

008016bb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016bb:	55                   	push   %ebp
  8016bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 0c                	push   $0xc
  8016ca:	e8 67 fe ff ff       	call   801536 <syscall>
  8016cf:	83 c4 18             	add    $0x18,%esp
}
  8016d2:	c9                   	leave  
  8016d3:	c3                   	ret    

008016d4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016d4:	55                   	push   %ebp
  8016d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 0d                	push   $0xd
  8016e3:	e8 4e fe ff ff       	call   801536 <syscall>
  8016e8:	83 c4 18             	add    $0x18,%esp
}
  8016eb:	c9                   	leave  
  8016ec:	c3                   	ret    

008016ed <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016ed:	55                   	push   %ebp
  8016ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	ff 75 0c             	pushl  0xc(%ebp)
  8016f9:	ff 75 08             	pushl  0x8(%ebp)
  8016fc:	6a 11                	push   $0x11
  8016fe:	e8 33 fe ff ff       	call   801536 <syscall>
  801703:	83 c4 18             	add    $0x18,%esp
	return;
  801706:	90                   	nop
}
  801707:	c9                   	leave  
  801708:	c3                   	ret    

00801709 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801709:	55                   	push   %ebp
  80170a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	ff 75 0c             	pushl  0xc(%ebp)
  801715:	ff 75 08             	pushl  0x8(%ebp)
  801718:	6a 12                	push   $0x12
  80171a:	e8 17 fe ff ff       	call   801536 <syscall>
  80171f:	83 c4 18             	add    $0x18,%esp
	return ;
  801722:	90                   	nop
}
  801723:	c9                   	leave  
  801724:	c3                   	ret    

00801725 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801725:	55                   	push   %ebp
  801726:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 0e                	push   $0xe
  801734:	e8 fd fd ff ff       	call   801536 <syscall>
  801739:	83 c4 18             	add    $0x18,%esp
}
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	ff 75 08             	pushl  0x8(%ebp)
  80174c:	6a 0f                	push   $0xf
  80174e:	e8 e3 fd ff ff       	call   801536 <syscall>
  801753:	83 c4 18             	add    $0x18,%esp
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 10                	push   $0x10
  801767:	e8 ca fd ff ff       	call   801536 <syscall>
  80176c:	83 c4 18             	add    $0x18,%esp
}
  80176f:	90                   	nop
  801770:	c9                   	leave  
  801771:	c3                   	ret    

00801772 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801772:	55                   	push   %ebp
  801773:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 14                	push   $0x14
  801781:	e8 b0 fd ff ff       	call   801536 <syscall>
  801786:	83 c4 18             	add    $0x18,%esp
}
  801789:	90                   	nop
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 15                	push   $0x15
  80179b:	e8 96 fd ff ff       	call   801536 <syscall>
  8017a0:	83 c4 18             	add    $0x18,%esp
}
  8017a3:	90                   	nop
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    

008017a6 <sys_cputc>:


void
sys_cputc(const char c)
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
  8017a9:	83 ec 04             	sub    $0x4,%esp
  8017ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8017af:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017b2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	50                   	push   %eax
  8017bf:	6a 16                	push   $0x16
  8017c1:	e8 70 fd ff ff       	call   801536 <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
}
  8017c9:	90                   	nop
  8017ca:	c9                   	leave  
  8017cb:	c3                   	ret    

008017cc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017cc:	55                   	push   %ebp
  8017cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 17                	push   $0x17
  8017db:	e8 56 fd ff ff       	call   801536 <syscall>
  8017e0:	83 c4 18             	add    $0x18,%esp
}
  8017e3:	90                   	nop
  8017e4:	c9                   	leave  
  8017e5:	c3                   	ret    

008017e6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017e6:	55                   	push   %ebp
  8017e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	ff 75 0c             	pushl  0xc(%ebp)
  8017f5:	50                   	push   %eax
  8017f6:	6a 18                	push   $0x18
  8017f8:	e8 39 fd ff ff       	call   801536 <syscall>
  8017fd:	83 c4 18             	add    $0x18,%esp
}
  801800:	c9                   	leave  
  801801:	c3                   	ret    

00801802 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801802:	55                   	push   %ebp
  801803:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801805:	8b 55 0c             	mov    0xc(%ebp),%edx
  801808:	8b 45 08             	mov    0x8(%ebp),%eax
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	52                   	push   %edx
  801812:	50                   	push   %eax
  801813:	6a 1b                	push   $0x1b
  801815:	e8 1c fd ff ff       	call   801536 <syscall>
  80181a:	83 c4 18             	add    $0x18,%esp
}
  80181d:	c9                   	leave  
  80181e:	c3                   	ret    

0080181f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80181f:	55                   	push   %ebp
  801820:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801822:	8b 55 0c             	mov    0xc(%ebp),%edx
  801825:	8b 45 08             	mov    0x8(%ebp),%eax
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	52                   	push   %edx
  80182f:	50                   	push   %eax
  801830:	6a 19                	push   $0x19
  801832:	e8 ff fc ff ff       	call   801536 <syscall>
  801837:	83 c4 18             	add    $0x18,%esp
}
  80183a:	90                   	nop
  80183b:	c9                   	leave  
  80183c:	c3                   	ret    

0080183d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80183d:	55                   	push   %ebp
  80183e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801840:	8b 55 0c             	mov    0xc(%ebp),%edx
  801843:	8b 45 08             	mov    0x8(%ebp),%eax
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	52                   	push   %edx
  80184d:	50                   	push   %eax
  80184e:	6a 1a                	push   $0x1a
  801850:	e8 e1 fc ff ff       	call   801536 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
}
  801858:	90                   	nop
  801859:	c9                   	leave  
  80185a:	c3                   	ret    

0080185b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80185b:	55                   	push   %ebp
  80185c:	89 e5                	mov    %esp,%ebp
  80185e:	83 ec 04             	sub    $0x4,%esp
  801861:	8b 45 10             	mov    0x10(%ebp),%eax
  801864:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801867:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80186a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80186e:	8b 45 08             	mov    0x8(%ebp),%eax
  801871:	6a 00                	push   $0x0
  801873:	51                   	push   %ecx
  801874:	52                   	push   %edx
  801875:	ff 75 0c             	pushl  0xc(%ebp)
  801878:	50                   	push   %eax
  801879:	6a 1c                	push   $0x1c
  80187b:	e8 b6 fc ff ff       	call   801536 <syscall>
  801880:	83 c4 18             	add    $0x18,%esp
}
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801888:	8b 55 0c             	mov    0xc(%ebp),%edx
  80188b:	8b 45 08             	mov    0x8(%ebp),%eax
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	52                   	push   %edx
  801895:	50                   	push   %eax
  801896:	6a 1d                	push   $0x1d
  801898:	e8 99 fc ff ff       	call   801536 <syscall>
  80189d:	83 c4 18             	add    $0x18,%esp
}
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8018a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	51                   	push   %ecx
  8018b3:	52                   	push   %edx
  8018b4:	50                   	push   %eax
  8018b5:	6a 1e                	push   $0x1e
  8018b7:	e8 7a fc ff ff       	call   801536 <syscall>
  8018bc:	83 c4 18             	add    $0x18,%esp
}
  8018bf:	c9                   	leave  
  8018c0:	c3                   	ret    

008018c1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8018c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	52                   	push   %edx
  8018d1:	50                   	push   %eax
  8018d2:	6a 1f                	push   $0x1f
  8018d4:	e8 5d fc ff ff       	call   801536 <syscall>
  8018d9:	83 c4 18             	add    $0x18,%esp
}
  8018dc:	c9                   	leave  
  8018dd:	c3                   	ret    

008018de <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018de:	55                   	push   %ebp
  8018df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 20                	push   $0x20
  8018ed:	e8 44 fc ff ff       	call   801536 <syscall>
  8018f2:	83 c4 18             	add    $0x18,%esp
}
  8018f5:	c9                   	leave  
  8018f6:	c3                   	ret    

008018f7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8018f7:	55                   	push   %ebp
  8018f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8018fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fd:	6a 00                	push   $0x0
  8018ff:	ff 75 14             	pushl  0x14(%ebp)
  801902:	ff 75 10             	pushl  0x10(%ebp)
  801905:	ff 75 0c             	pushl  0xc(%ebp)
  801908:	50                   	push   %eax
  801909:	6a 21                	push   $0x21
  80190b:	e8 26 fc ff ff       	call   801536 <syscall>
  801910:	83 c4 18             	add    $0x18,%esp
}
  801913:	c9                   	leave  
  801914:	c3                   	ret    

00801915 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801915:	55                   	push   %ebp
  801916:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	50                   	push   %eax
  801924:	6a 22                	push   $0x22
  801926:	e8 0b fc ff ff       	call   801536 <syscall>
  80192b:	83 c4 18             	add    $0x18,%esp
}
  80192e:	90                   	nop
  80192f:	c9                   	leave  
  801930:	c3                   	ret    

00801931 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801931:	55                   	push   %ebp
  801932:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801934:	8b 45 08             	mov    0x8(%ebp),%eax
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	50                   	push   %eax
  801940:	6a 23                	push   $0x23
  801942:	e8 ef fb ff ff       	call   801536 <syscall>
  801947:	83 c4 18             	add    $0x18,%esp
}
  80194a:	90                   	nop
  80194b:	c9                   	leave  
  80194c:	c3                   	ret    

0080194d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80194d:	55                   	push   %ebp
  80194e:	89 e5                	mov    %esp,%ebp
  801950:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801953:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801956:	8d 50 04             	lea    0x4(%eax),%edx
  801959:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	52                   	push   %edx
  801963:	50                   	push   %eax
  801964:	6a 24                	push   $0x24
  801966:	e8 cb fb ff ff       	call   801536 <syscall>
  80196b:	83 c4 18             	add    $0x18,%esp
	return result;
  80196e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801971:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801974:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801977:	89 01                	mov    %eax,(%ecx)
  801979:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80197c:	8b 45 08             	mov    0x8(%ebp),%eax
  80197f:	c9                   	leave  
  801980:	c2 04 00             	ret    $0x4

00801983 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801983:	55                   	push   %ebp
  801984:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	ff 75 10             	pushl  0x10(%ebp)
  80198d:	ff 75 0c             	pushl  0xc(%ebp)
  801990:	ff 75 08             	pushl  0x8(%ebp)
  801993:	6a 13                	push   $0x13
  801995:	e8 9c fb ff ff       	call   801536 <syscall>
  80199a:	83 c4 18             	add    $0x18,%esp
	return ;
  80199d:	90                   	nop
}
  80199e:	c9                   	leave  
  80199f:	c3                   	ret    

008019a0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 25                	push   $0x25
  8019af:	e8 82 fb ff ff       	call   801536 <syscall>
  8019b4:	83 c4 18             	add    $0x18,%esp
}
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    

008019b9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
  8019bc:	83 ec 04             	sub    $0x4,%esp
  8019bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019c5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	50                   	push   %eax
  8019d2:	6a 26                	push   $0x26
  8019d4:	e8 5d fb ff ff       	call   801536 <syscall>
  8019d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8019dc:	90                   	nop
}
  8019dd:	c9                   	leave  
  8019de:	c3                   	ret    

008019df <rsttst>:
void rsttst()
{
  8019df:	55                   	push   %ebp
  8019e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 28                	push   $0x28
  8019ee:	e8 43 fb ff ff       	call   801536 <syscall>
  8019f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f6:	90                   	nop
}
  8019f7:	c9                   	leave  
  8019f8:	c3                   	ret    

008019f9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019f9:	55                   	push   %ebp
  8019fa:	89 e5                	mov    %esp,%ebp
  8019fc:	83 ec 04             	sub    $0x4,%esp
  8019ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801a02:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a05:	8b 55 18             	mov    0x18(%ebp),%edx
  801a08:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a0c:	52                   	push   %edx
  801a0d:	50                   	push   %eax
  801a0e:	ff 75 10             	pushl  0x10(%ebp)
  801a11:	ff 75 0c             	pushl  0xc(%ebp)
  801a14:	ff 75 08             	pushl  0x8(%ebp)
  801a17:	6a 27                	push   $0x27
  801a19:	e8 18 fb ff ff       	call   801536 <syscall>
  801a1e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a21:	90                   	nop
}
  801a22:	c9                   	leave  
  801a23:	c3                   	ret    

00801a24 <chktst>:
void chktst(uint32 n)
{
  801a24:	55                   	push   %ebp
  801a25:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a27:	6a 00                	push   $0x0
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	ff 75 08             	pushl  0x8(%ebp)
  801a32:	6a 29                	push   $0x29
  801a34:	e8 fd fa ff ff       	call   801536 <syscall>
  801a39:	83 c4 18             	add    $0x18,%esp
	return ;
  801a3c:	90                   	nop
}
  801a3d:	c9                   	leave  
  801a3e:	c3                   	ret    

00801a3f <inctst>:

void inctst()
{
  801a3f:	55                   	push   %ebp
  801a40:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a42:	6a 00                	push   $0x0
  801a44:	6a 00                	push   $0x0
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 2a                	push   $0x2a
  801a4e:	e8 e3 fa ff ff       	call   801536 <syscall>
  801a53:	83 c4 18             	add    $0x18,%esp
	return ;
  801a56:	90                   	nop
}
  801a57:	c9                   	leave  
  801a58:	c3                   	ret    

00801a59 <gettst>:
uint32 gettst()
{
  801a59:	55                   	push   %ebp
  801a5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 2b                	push   $0x2b
  801a68:	e8 c9 fa ff ff       	call   801536 <syscall>
  801a6d:	83 c4 18             	add    $0x18,%esp
}
  801a70:	c9                   	leave  
  801a71:	c3                   	ret    

00801a72 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a72:	55                   	push   %ebp
  801a73:	89 e5                	mov    %esp,%ebp
  801a75:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 2c                	push   $0x2c
  801a84:	e8 ad fa ff ff       	call   801536 <syscall>
  801a89:	83 c4 18             	add    $0x18,%esp
  801a8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a8f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a93:	75 07                	jne    801a9c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a95:	b8 01 00 00 00       	mov    $0x1,%eax
  801a9a:	eb 05                	jmp    801aa1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a9c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aa1:	c9                   	leave  
  801aa2:	c3                   	ret    

00801aa3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801aa3:	55                   	push   %ebp
  801aa4:	89 e5                	mov    %esp,%ebp
  801aa6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801aa9:	6a 00                	push   $0x0
  801aab:	6a 00                	push   $0x0
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 2c                	push   $0x2c
  801ab5:	e8 7c fa ff ff       	call   801536 <syscall>
  801aba:	83 c4 18             	add    $0x18,%esp
  801abd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ac0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ac4:	75 07                	jne    801acd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ac6:	b8 01 00 00 00       	mov    $0x1,%eax
  801acb:	eb 05                	jmp    801ad2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801acd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ad2:	c9                   	leave  
  801ad3:	c3                   	ret    

00801ad4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ad4:	55                   	push   %ebp
  801ad5:	89 e5                	mov    %esp,%ebp
  801ad7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ada:	6a 00                	push   $0x0
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 2c                	push   $0x2c
  801ae6:	e8 4b fa ff ff       	call   801536 <syscall>
  801aeb:	83 c4 18             	add    $0x18,%esp
  801aee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801af1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801af5:	75 07                	jne    801afe <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801af7:	b8 01 00 00 00       	mov    $0x1,%eax
  801afc:	eb 05                	jmp    801b03 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801afe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b03:	c9                   	leave  
  801b04:	c3                   	ret    

00801b05 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b05:	55                   	push   %ebp
  801b06:	89 e5                	mov    %esp,%ebp
  801b08:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 2c                	push   $0x2c
  801b17:	e8 1a fa ff ff       	call   801536 <syscall>
  801b1c:	83 c4 18             	add    $0x18,%esp
  801b1f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b22:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b26:	75 07                	jne    801b2f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b28:	b8 01 00 00 00       	mov    $0x1,%eax
  801b2d:	eb 05                	jmp    801b34 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b2f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b34:	c9                   	leave  
  801b35:	c3                   	ret    

00801b36 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b36:	55                   	push   %ebp
  801b37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	ff 75 08             	pushl  0x8(%ebp)
  801b44:	6a 2d                	push   $0x2d
  801b46:	e8 eb f9 ff ff       	call   801536 <syscall>
  801b4b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b4e:	90                   	nop
}
  801b4f:	c9                   	leave  
  801b50:	c3                   	ret    

00801b51 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b51:	55                   	push   %ebp
  801b52:	89 e5                	mov    %esp,%ebp
  801b54:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b55:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b58:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b61:	6a 00                	push   $0x0
  801b63:	53                   	push   %ebx
  801b64:	51                   	push   %ecx
  801b65:	52                   	push   %edx
  801b66:	50                   	push   %eax
  801b67:	6a 2e                	push   $0x2e
  801b69:	e8 c8 f9 ff ff       	call   801536 <syscall>
  801b6e:	83 c4 18             	add    $0x18,%esp
}
  801b71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b74:	c9                   	leave  
  801b75:	c3                   	ret    

00801b76 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b76:	55                   	push   %ebp
  801b77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b79:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	6a 00                	push   $0x0
  801b85:	52                   	push   %edx
  801b86:	50                   	push   %eax
  801b87:	6a 2f                	push   $0x2f
  801b89:	e8 a8 f9 ff ff       	call   801536 <syscall>
  801b8e:	83 c4 18             	add    $0x18,%esp
}
  801b91:	c9                   	leave  
  801b92:	c3                   	ret    

00801b93 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801b93:	55                   	push   %ebp
  801b94:	89 e5                	mov    %esp,%ebp
  801b96:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801b99:	8d 45 10             	lea    0x10(%ebp),%eax
  801b9c:	83 c0 04             	add    $0x4,%eax
  801b9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801ba2:	a1 a0 80 92 00       	mov    0x9280a0,%eax
  801ba7:	85 c0                	test   %eax,%eax
  801ba9:	74 16                	je     801bc1 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801bab:	a1 a0 80 92 00       	mov    0x9280a0,%eax
  801bb0:	83 ec 08             	sub    $0x8,%esp
  801bb3:	50                   	push   %eax
  801bb4:	68 00 25 80 00       	push   $0x802500
  801bb9:	e8 a5 e8 ff ff       	call   800463 <cprintf>
  801bbe:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801bc1:	a1 00 30 80 00       	mov    0x803000,%eax
  801bc6:	ff 75 0c             	pushl  0xc(%ebp)
  801bc9:	ff 75 08             	pushl  0x8(%ebp)
  801bcc:	50                   	push   %eax
  801bcd:	68 05 25 80 00       	push   $0x802505
  801bd2:	e8 8c e8 ff ff       	call   800463 <cprintf>
  801bd7:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801bda:	8b 45 10             	mov    0x10(%ebp),%eax
  801bdd:	83 ec 08             	sub    $0x8,%esp
  801be0:	ff 75 f4             	pushl  -0xc(%ebp)
  801be3:	50                   	push   %eax
  801be4:	e8 0f e8 ff ff       	call   8003f8 <vcprintf>
  801be9:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801bec:	83 ec 08             	sub    $0x8,%esp
  801bef:	6a 00                	push   $0x0
  801bf1:	68 21 25 80 00       	push   $0x802521
  801bf6:	e8 fd e7 ff ff       	call   8003f8 <vcprintf>
  801bfb:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801bfe:	e8 7e e7 ff ff       	call   800381 <exit>

	// should not return here
	while (1) ;
  801c03:	eb fe                	jmp    801c03 <_panic+0x70>

00801c05 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
  801c08:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801c0b:	a1 20 30 80 00       	mov    0x803020,%eax
  801c10:	8b 50 74             	mov    0x74(%eax),%edx
  801c13:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c16:	39 c2                	cmp    %eax,%edx
  801c18:	74 14                	je     801c2e <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801c1a:	83 ec 04             	sub    $0x4,%esp
  801c1d:	68 24 25 80 00       	push   $0x802524
  801c22:	6a 26                	push   $0x26
  801c24:	68 70 25 80 00       	push   $0x802570
  801c29:	e8 65 ff ff ff       	call   801b93 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801c2e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801c35:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c3c:	e9 b6 00 00 00       	jmp    801cf7 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801c41:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c44:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4e:	01 d0                	add    %edx,%eax
  801c50:	8b 00                	mov    (%eax),%eax
  801c52:	85 c0                	test   %eax,%eax
  801c54:	75 08                	jne    801c5e <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801c56:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801c59:	e9 96 00 00 00       	jmp    801cf4 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801c5e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c65:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801c6c:	eb 5d                	jmp    801ccb <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801c6e:	a1 20 30 80 00       	mov    0x803020,%eax
  801c73:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801c79:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c7c:	c1 e2 04             	shl    $0x4,%edx
  801c7f:	01 d0                	add    %edx,%eax
  801c81:	8a 40 04             	mov    0x4(%eax),%al
  801c84:	84 c0                	test   %al,%al
  801c86:	75 40                	jne    801cc8 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c88:	a1 20 30 80 00       	mov    0x803020,%eax
  801c8d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801c93:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c96:	c1 e2 04             	shl    $0x4,%edx
  801c99:	01 d0                	add    %edx,%eax
  801c9b:	8b 00                	mov    (%eax),%eax
  801c9d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801ca0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801ca3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801ca8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801caa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cad:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb7:	01 c8                	add    %ecx,%eax
  801cb9:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801cbb:	39 c2                	cmp    %eax,%edx
  801cbd:	75 09                	jne    801cc8 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801cbf:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801cc6:	eb 12                	jmp    801cda <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801cc8:	ff 45 e8             	incl   -0x18(%ebp)
  801ccb:	a1 20 30 80 00       	mov    0x803020,%eax
  801cd0:	8b 50 74             	mov    0x74(%eax),%edx
  801cd3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cd6:	39 c2                	cmp    %eax,%edx
  801cd8:	77 94                	ja     801c6e <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801cda:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801cde:	75 14                	jne    801cf4 <CheckWSWithoutLastIndex+0xef>
			panic(
  801ce0:	83 ec 04             	sub    $0x4,%esp
  801ce3:	68 7c 25 80 00       	push   $0x80257c
  801ce8:	6a 3a                	push   $0x3a
  801cea:	68 70 25 80 00       	push   $0x802570
  801cef:	e8 9f fe ff ff       	call   801b93 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801cf4:	ff 45 f0             	incl   -0x10(%ebp)
  801cf7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cfa:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801cfd:	0f 8c 3e ff ff ff    	jl     801c41 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801d03:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d0a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801d11:	eb 20                	jmp    801d33 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801d13:	a1 20 30 80 00       	mov    0x803020,%eax
  801d18:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801d1e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d21:	c1 e2 04             	shl    $0x4,%edx
  801d24:	01 d0                	add    %edx,%eax
  801d26:	8a 40 04             	mov    0x4(%eax),%al
  801d29:	3c 01                	cmp    $0x1,%al
  801d2b:	75 03                	jne    801d30 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801d2d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d30:	ff 45 e0             	incl   -0x20(%ebp)
  801d33:	a1 20 30 80 00       	mov    0x803020,%eax
  801d38:	8b 50 74             	mov    0x74(%eax),%edx
  801d3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d3e:	39 c2                	cmp    %eax,%edx
  801d40:	77 d1                	ja     801d13 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801d42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d45:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d48:	74 14                	je     801d5e <CheckWSWithoutLastIndex+0x159>
		panic(
  801d4a:	83 ec 04             	sub    $0x4,%esp
  801d4d:	68 d0 25 80 00       	push   $0x8025d0
  801d52:	6a 44                	push   $0x44
  801d54:	68 70 25 80 00       	push   $0x802570
  801d59:	e8 35 fe ff ff       	call   801b93 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801d5e:	90                   	nop
  801d5f:	c9                   	leave  
  801d60:	c3                   	ret    
  801d61:	66 90                	xchg   %ax,%ax
  801d63:	90                   	nop

00801d64 <__udivdi3>:
  801d64:	55                   	push   %ebp
  801d65:	57                   	push   %edi
  801d66:	56                   	push   %esi
  801d67:	53                   	push   %ebx
  801d68:	83 ec 1c             	sub    $0x1c,%esp
  801d6b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d6f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d73:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d77:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d7b:	89 ca                	mov    %ecx,%edx
  801d7d:	89 f8                	mov    %edi,%eax
  801d7f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d83:	85 f6                	test   %esi,%esi
  801d85:	75 2d                	jne    801db4 <__udivdi3+0x50>
  801d87:	39 cf                	cmp    %ecx,%edi
  801d89:	77 65                	ja     801df0 <__udivdi3+0x8c>
  801d8b:	89 fd                	mov    %edi,%ebp
  801d8d:	85 ff                	test   %edi,%edi
  801d8f:	75 0b                	jne    801d9c <__udivdi3+0x38>
  801d91:	b8 01 00 00 00       	mov    $0x1,%eax
  801d96:	31 d2                	xor    %edx,%edx
  801d98:	f7 f7                	div    %edi
  801d9a:	89 c5                	mov    %eax,%ebp
  801d9c:	31 d2                	xor    %edx,%edx
  801d9e:	89 c8                	mov    %ecx,%eax
  801da0:	f7 f5                	div    %ebp
  801da2:	89 c1                	mov    %eax,%ecx
  801da4:	89 d8                	mov    %ebx,%eax
  801da6:	f7 f5                	div    %ebp
  801da8:	89 cf                	mov    %ecx,%edi
  801daa:	89 fa                	mov    %edi,%edx
  801dac:	83 c4 1c             	add    $0x1c,%esp
  801daf:	5b                   	pop    %ebx
  801db0:	5e                   	pop    %esi
  801db1:	5f                   	pop    %edi
  801db2:	5d                   	pop    %ebp
  801db3:	c3                   	ret    
  801db4:	39 ce                	cmp    %ecx,%esi
  801db6:	77 28                	ja     801de0 <__udivdi3+0x7c>
  801db8:	0f bd fe             	bsr    %esi,%edi
  801dbb:	83 f7 1f             	xor    $0x1f,%edi
  801dbe:	75 40                	jne    801e00 <__udivdi3+0x9c>
  801dc0:	39 ce                	cmp    %ecx,%esi
  801dc2:	72 0a                	jb     801dce <__udivdi3+0x6a>
  801dc4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801dc8:	0f 87 9e 00 00 00    	ja     801e6c <__udivdi3+0x108>
  801dce:	b8 01 00 00 00       	mov    $0x1,%eax
  801dd3:	89 fa                	mov    %edi,%edx
  801dd5:	83 c4 1c             	add    $0x1c,%esp
  801dd8:	5b                   	pop    %ebx
  801dd9:	5e                   	pop    %esi
  801dda:	5f                   	pop    %edi
  801ddb:	5d                   	pop    %ebp
  801ddc:	c3                   	ret    
  801ddd:	8d 76 00             	lea    0x0(%esi),%esi
  801de0:	31 ff                	xor    %edi,%edi
  801de2:	31 c0                	xor    %eax,%eax
  801de4:	89 fa                	mov    %edi,%edx
  801de6:	83 c4 1c             	add    $0x1c,%esp
  801de9:	5b                   	pop    %ebx
  801dea:	5e                   	pop    %esi
  801deb:	5f                   	pop    %edi
  801dec:	5d                   	pop    %ebp
  801ded:	c3                   	ret    
  801dee:	66 90                	xchg   %ax,%ax
  801df0:	89 d8                	mov    %ebx,%eax
  801df2:	f7 f7                	div    %edi
  801df4:	31 ff                	xor    %edi,%edi
  801df6:	89 fa                	mov    %edi,%edx
  801df8:	83 c4 1c             	add    $0x1c,%esp
  801dfb:	5b                   	pop    %ebx
  801dfc:	5e                   	pop    %esi
  801dfd:	5f                   	pop    %edi
  801dfe:	5d                   	pop    %ebp
  801dff:	c3                   	ret    
  801e00:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e05:	89 eb                	mov    %ebp,%ebx
  801e07:	29 fb                	sub    %edi,%ebx
  801e09:	89 f9                	mov    %edi,%ecx
  801e0b:	d3 e6                	shl    %cl,%esi
  801e0d:	89 c5                	mov    %eax,%ebp
  801e0f:	88 d9                	mov    %bl,%cl
  801e11:	d3 ed                	shr    %cl,%ebp
  801e13:	89 e9                	mov    %ebp,%ecx
  801e15:	09 f1                	or     %esi,%ecx
  801e17:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e1b:	89 f9                	mov    %edi,%ecx
  801e1d:	d3 e0                	shl    %cl,%eax
  801e1f:	89 c5                	mov    %eax,%ebp
  801e21:	89 d6                	mov    %edx,%esi
  801e23:	88 d9                	mov    %bl,%cl
  801e25:	d3 ee                	shr    %cl,%esi
  801e27:	89 f9                	mov    %edi,%ecx
  801e29:	d3 e2                	shl    %cl,%edx
  801e2b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e2f:	88 d9                	mov    %bl,%cl
  801e31:	d3 e8                	shr    %cl,%eax
  801e33:	09 c2                	or     %eax,%edx
  801e35:	89 d0                	mov    %edx,%eax
  801e37:	89 f2                	mov    %esi,%edx
  801e39:	f7 74 24 0c          	divl   0xc(%esp)
  801e3d:	89 d6                	mov    %edx,%esi
  801e3f:	89 c3                	mov    %eax,%ebx
  801e41:	f7 e5                	mul    %ebp
  801e43:	39 d6                	cmp    %edx,%esi
  801e45:	72 19                	jb     801e60 <__udivdi3+0xfc>
  801e47:	74 0b                	je     801e54 <__udivdi3+0xf0>
  801e49:	89 d8                	mov    %ebx,%eax
  801e4b:	31 ff                	xor    %edi,%edi
  801e4d:	e9 58 ff ff ff       	jmp    801daa <__udivdi3+0x46>
  801e52:	66 90                	xchg   %ax,%ax
  801e54:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e58:	89 f9                	mov    %edi,%ecx
  801e5a:	d3 e2                	shl    %cl,%edx
  801e5c:	39 c2                	cmp    %eax,%edx
  801e5e:	73 e9                	jae    801e49 <__udivdi3+0xe5>
  801e60:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e63:	31 ff                	xor    %edi,%edi
  801e65:	e9 40 ff ff ff       	jmp    801daa <__udivdi3+0x46>
  801e6a:	66 90                	xchg   %ax,%ax
  801e6c:	31 c0                	xor    %eax,%eax
  801e6e:	e9 37 ff ff ff       	jmp    801daa <__udivdi3+0x46>
  801e73:	90                   	nop

00801e74 <__umoddi3>:
  801e74:	55                   	push   %ebp
  801e75:	57                   	push   %edi
  801e76:	56                   	push   %esi
  801e77:	53                   	push   %ebx
  801e78:	83 ec 1c             	sub    $0x1c,%esp
  801e7b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e7f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e83:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e87:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e8b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e8f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e93:	89 f3                	mov    %esi,%ebx
  801e95:	89 fa                	mov    %edi,%edx
  801e97:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e9b:	89 34 24             	mov    %esi,(%esp)
  801e9e:	85 c0                	test   %eax,%eax
  801ea0:	75 1a                	jne    801ebc <__umoddi3+0x48>
  801ea2:	39 f7                	cmp    %esi,%edi
  801ea4:	0f 86 a2 00 00 00    	jbe    801f4c <__umoddi3+0xd8>
  801eaa:	89 c8                	mov    %ecx,%eax
  801eac:	89 f2                	mov    %esi,%edx
  801eae:	f7 f7                	div    %edi
  801eb0:	89 d0                	mov    %edx,%eax
  801eb2:	31 d2                	xor    %edx,%edx
  801eb4:	83 c4 1c             	add    $0x1c,%esp
  801eb7:	5b                   	pop    %ebx
  801eb8:	5e                   	pop    %esi
  801eb9:	5f                   	pop    %edi
  801eba:	5d                   	pop    %ebp
  801ebb:	c3                   	ret    
  801ebc:	39 f0                	cmp    %esi,%eax
  801ebe:	0f 87 ac 00 00 00    	ja     801f70 <__umoddi3+0xfc>
  801ec4:	0f bd e8             	bsr    %eax,%ebp
  801ec7:	83 f5 1f             	xor    $0x1f,%ebp
  801eca:	0f 84 ac 00 00 00    	je     801f7c <__umoddi3+0x108>
  801ed0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ed5:	29 ef                	sub    %ebp,%edi
  801ed7:	89 fe                	mov    %edi,%esi
  801ed9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801edd:	89 e9                	mov    %ebp,%ecx
  801edf:	d3 e0                	shl    %cl,%eax
  801ee1:	89 d7                	mov    %edx,%edi
  801ee3:	89 f1                	mov    %esi,%ecx
  801ee5:	d3 ef                	shr    %cl,%edi
  801ee7:	09 c7                	or     %eax,%edi
  801ee9:	89 e9                	mov    %ebp,%ecx
  801eeb:	d3 e2                	shl    %cl,%edx
  801eed:	89 14 24             	mov    %edx,(%esp)
  801ef0:	89 d8                	mov    %ebx,%eax
  801ef2:	d3 e0                	shl    %cl,%eax
  801ef4:	89 c2                	mov    %eax,%edx
  801ef6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801efa:	d3 e0                	shl    %cl,%eax
  801efc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f00:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f04:	89 f1                	mov    %esi,%ecx
  801f06:	d3 e8                	shr    %cl,%eax
  801f08:	09 d0                	or     %edx,%eax
  801f0a:	d3 eb                	shr    %cl,%ebx
  801f0c:	89 da                	mov    %ebx,%edx
  801f0e:	f7 f7                	div    %edi
  801f10:	89 d3                	mov    %edx,%ebx
  801f12:	f7 24 24             	mull   (%esp)
  801f15:	89 c6                	mov    %eax,%esi
  801f17:	89 d1                	mov    %edx,%ecx
  801f19:	39 d3                	cmp    %edx,%ebx
  801f1b:	0f 82 87 00 00 00    	jb     801fa8 <__umoddi3+0x134>
  801f21:	0f 84 91 00 00 00    	je     801fb8 <__umoddi3+0x144>
  801f27:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f2b:	29 f2                	sub    %esi,%edx
  801f2d:	19 cb                	sbb    %ecx,%ebx
  801f2f:	89 d8                	mov    %ebx,%eax
  801f31:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f35:	d3 e0                	shl    %cl,%eax
  801f37:	89 e9                	mov    %ebp,%ecx
  801f39:	d3 ea                	shr    %cl,%edx
  801f3b:	09 d0                	or     %edx,%eax
  801f3d:	89 e9                	mov    %ebp,%ecx
  801f3f:	d3 eb                	shr    %cl,%ebx
  801f41:	89 da                	mov    %ebx,%edx
  801f43:	83 c4 1c             	add    $0x1c,%esp
  801f46:	5b                   	pop    %ebx
  801f47:	5e                   	pop    %esi
  801f48:	5f                   	pop    %edi
  801f49:	5d                   	pop    %ebp
  801f4a:	c3                   	ret    
  801f4b:	90                   	nop
  801f4c:	89 fd                	mov    %edi,%ebp
  801f4e:	85 ff                	test   %edi,%edi
  801f50:	75 0b                	jne    801f5d <__umoddi3+0xe9>
  801f52:	b8 01 00 00 00       	mov    $0x1,%eax
  801f57:	31 d2                	xor    %edx,%edx
  801f59:	f7 f7                	div    %edi
  801f5b:	89 c5                	mov    %eax,%ebp
  801f5d:	89 f0                	mov    %esi,%eax
  801f5f:	31 d2                	xor    %edx,%edx
  801f61:	f7 f5                	div    %ebp
  801f63:	89 c8                	mov    %ecx,%eax
  801f65:	f7 f5                	div    %ebp
  801f67:	89 d0                	mov    %edx,%eax
  801f69:	e9 44 ff ff ff       	jmp    801eb2 <__umoddi3+0x3e>
  801f6e:	66 90                	xchg   %ax,%ax
  801f70:	89 c8                	mov    %ecx,%eax
  801f72:	89 f2                	mov    %esi,%edx
  801f74:	83 c4 1c             	add    $0x1c,%esp
  801f77:	5b                   	pop    %ebx
  801f78:	5e                   	pop    %esi
  801f79:	5f                   	pop    %edi
  801f7a:	5d                   	pop    %ebp
  801f7b:	c3                   	ret    
  801f7c:	3b 04 24             	cmp    (%esp),%eax
  801f7f:	72 06                	jb     801f87 <__umoddi3+0x113>
  801f81:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f85:	77 0f                	ja     801f96 <__umoddi3+0x122>
  801f87:	89 f2                	mov    %esi,%edx
  801f89:	29 f9                	sub    %edi,%ecx
  801f8b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f8f:	89 14 24             	mov    %edx,(%esp)
  801f92:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f96:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f9a:	8b 14 24             	mov    (%esp),%edx
  801f9d:	83 c4 1c             	add    $0x1c,%esp
  801fa0:	5b                   	pop    %ebx
  801fa1:	5e                   	pop    %esi
  801fa2:	5f                   	pop    %edi
  801fa3:	5d                   	pop    %ebp
  801fa4:	c3                   	ret    
  801fa5:	8d 76 00             	lea    0x0(%esi),%esi
  801fa8:	2b 04 24             	sub    (%esp),%eax
  801fab:	19 fa                	sbb    %edi,%edx
  801fad:	89 d1                	mov    %edx,%ecx
  801faf:	89 c6                	mov    %eax,%esi
  801fb1:	e9 71 ff ff ff       	jmp    801f27 <__umoddi3+0xb3>
  801fb6:	66 90                	xchg   %ax,%ax
  801fb8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801fbc:	72 ea                	jb     801fa8 <__umoddi3+0x134>
  801fbe:	89 d9                	mov    %ebx,%ecx
  801fc0:	e9 62 ff ff ff       	jmp    801f27 <__umoddi3+0xb3>


obj/user/MidTermEx_ProcessA:     file format elf32-i386


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
  800031:	e8 36 01 00 00       	call   80016c <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 38             	sub    $0x38,%esp
	int32 parentenvID = sys_getparentenvid();
  80003e:	e8 27 14 00 00       	call   80146a <sys_getparentenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int delay;

	/*[1] GET SHARED VARIABLE, SEMAPHORE SEL, check-finishing counter*/
	int *X = sget(parentenvID, "X") ;
  800046:	83 ec 08             	sub    $0x8,%esp
  800049:	68 00 1f 80 00       	push   $0x801f00
  80004e:	ff 75 f4             	pushl  -0xc(%ebp)
  800051:	e8 ac 12 00 00       	call   801302 <sget>
  800056:	83 c4 10             	add    $0x10,%esp
  800059:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int *useSem = sget(parentenvID, "useSem") ;
  80005c:	83 ec 08             	sub    $0x8,%esp
  80005f:	68 02 1f 80 00       	push   $0x801f02
  800064:	ff 75 f4             	pushl  -0xc(%ebp)
  800067:	e8 96 12 00 00       	call   801302 <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int *finishedCount = sget(parentenvID, "finishedCount") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 09 1f 80 00       	push   $0x801f09
  80007a:	ff 75 f4             	pushl  -0xc(%ebp)
  80007d:	e8 80 12 00 00       	call   801302 <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	/*[2] DO THE JOB*/
	int Y ;
	//random delay
	delay = RAND(2000, 10000);
  800088:	8d 45 c8             	lea    -0x38(%ebp),%eax
  80008b:	83 ec 0c             	sub    $0xc,%esp
  80008e:	50                   	push   %eax
  80008f:	e8 33 17 00 00       	call   8017c7 <sys_get_virtual_time>
  800094:	83 c4 0c             	add    $0xc,%esp
  800097:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80009a:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  80009f:	ba 00 00 00 00       	mov    $0x0,%edx
  8000a4:	f7 f1                	div    %ecx
  8000a6:	89 d0                	mov    %edx,%eax
  8000a8:	05 d0 07 00 00       	add    $0x7d0,%eax
  8000ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  8000b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000b3:	83 ec 0c             	sub    $0xc,%esp
  8000b6:	50                   	push   %eax
  8000b7:	e8 51 19 00 00       	call   801a0d <env_sleep>
  8000bc:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	Y = (*X) * 2 ;
  8000bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c2:	8b 00                	mov    (%eax),%eax
  8000c4:	01 c0                	add    %eax,%eax
  8000c6:	89 45 e0             	mov    %eax,-0x20(%ebp)

	//random delay
	delay = RAND(2000, 10000);
  8000c9:	8d 45 d0             	lea    -0x30(%ebp),%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 f2 16 00 00       	call   8017c7 <sys_get_virtual_time>
  8000d5:	83 c4 0c             	add    $0xc,%esp
  8000d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000db:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  8000e0:	ba 00 00 00 00       	mov    $0x0,%edx
  8000e5:	f7 f1                	div    %ecx
  8000e7:	89 d0                	mov    %edx,%eax
  8000e9:	05 d0 07 00 00       	add    $0x7d0,%eax
  8000ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	83 ec 0c             	sub    $0xc,%esp
  8000f7:	50                   	push   %eax
  8000f8:	e8 10 19 00 00       	call   801a0d <env_sleep>
  8000fd:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	(*X) = Y ;
  800100:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800103:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800106:	89 10                	mov    %edx,(%eax)

	//random delay
	delay = RAND(2000, 10000);
  800108:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	50                   	push   %eax
  80010f:	e8 b3 16 00 00       	call   8017c7 <sys_get_virtual_time>
  800114:	83 c4 0c             	add    $0xc,%esp
  800117:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80011a:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  80011f:	ba 00 00 00 00       	mov    $0x0,%edx
  800124:	f7 f1                	div    %ecx
  800126:	89 d0                	mov    %edx,%eax
  800128:	05 d0 07 00 00       	add    $0x7d0,%eax
  80012d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  800130:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800133:	83 ec 0c             	sub    $0xc,%esp
  800136:	50                   	push   %eax
  800137:	e8 d1 18 00 00       	call   801a0d <env_sleep>
  80013c:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	if (*useSem == 1)
  80013f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800142:	8b 00                	mov    (%eax),%eax
  800144:	83 f8 01             	cmp    $0x1,%eax
  800147:	75 13                	jne    80015c <_main+0x124>
	{
		sys_signalSemaphore(parentenvID, "T") ;
  800149:	83 ec 08             	sub    $0x8,%esp
  80014c:	68 17 1f 80 00       	push   $0x801f17
  800151:	ff 75 f4             	pushl  -0xc(%ebp)
  800154:	e8 5e 15 00 00       	call   8016b7 <sys_signalSemaphore>
  800159:	83 c4 10             	add    $0x10,%esp
	}

	/*[3] DECLARE FINISHING*/
	(*finishedCount)++ ;
  80015c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80015f:	8b 00                	mov    (%eax),%eax
  800161:	8d 50 01             	lea    0x1(%eax),%edx
  800164:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800167:	89 10                	mov    %edx,(%eax)

}
  800169:	90                   	nop
  80016a:	c9                   	leave  
  80016b:	c3                   	ret    

0080016c <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80016c:	55                   	push   %ebp
  80016d:	89 e5                	mov    %esp,%ebp
  80016f:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800172:	e8 da 12 00 00       	call   801451 <sys_getenvindex>
  800177:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80017a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80017d:	89 d0                	mov    %edx,%eax
  80017f:	c1 e0 03             	shl    $0x3,%eax
  800182:	01 d0                	add    %edx,%eax
  800184:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80018b:	01 c8                	add    %ecx,%eax
  80018d:	01 c0                	add    %eax,%eax
  80018f:	01 d0                	add    %edx,%eax
  800191:	01 c0                	add    %eax,%eax
  800193:	01 d0                	add    %edx,%eax
  800195:	89 c2                	mov    %eax,%edx
  800197:	c1 e2 05             	shl    $0x5,%edx
  80019a:	29 c2                	sub    %eax,%edx
  80019c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001a3:	89 c2                	mov    %eax,%edx
  8001a5:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001ab:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b5:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001bb:	84 c0                	test   %al,%al
  8001bd:	74 0f                	je     8001ce <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c4:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001c9:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001ce:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001d2:	7e 0a                	jle    8001de <libmain+0x72>
		binaryname = argv[0];
  8001d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d7:	8b 00                	mov    (%eax),%eax
  8001d9:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001de:	83 ec 08             	sub    $0x8,%esp
  8001e1:	ff 75 0c             	pushl  0xc(%ebp)
  8001e4:	ff 75 08             	pushl  0x8(%ebp)
  8001e7:	e8 4c fe ff ff       	call   800038 <_main>
  8001ec:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001ef:	e8 f8 13 00 00       	call   8015ec <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001f4:	83 ec 0c             	sub    $0xc,%esp
  8001f7:	68 34 1f 80 00       	push   $0x801f34
  8001fc:	e8 84 01 00 00       	call   800385 <cprintf>
  800201:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800204:	a1 20 30 80 00       	mov    0x803020,%eax
  800209:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80020f:	a1 20 30 80 00       	mov    0x803020,%eax
  800214:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80021a:	83 ec 04             	sub    $0x4,%esp
  80021d:	52                   	push   %edx
  80021e:	50                   	push   %eax
  80021f:	68 5c 1f 80 00       	push   $0x801f5c
  800224:	e8 5c 01 00 00       	call   800385 <cprintf>
  800229:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80022c:	a1 20 30 80 00       	mov    0x803020,%eax
  800231:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800237:	a1 20 30 80 00       	mov    0x803020,%eax
  80023c:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800242:	83 ec 04             	sub    $0x4,%esp
  800245:	52                   	push   %edx
  800246:	50                   	push   %eax
  800247:	68 84 1f 80 00       	push   $0x801f84
  80024c:	e8 34 01 00 00       	call   800385 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800254:	a1 20 30 80 00       	mov    0x803020,%eax
  800259:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80025f:	83 ec 08             	sub    $0x8,%esp
  800262:	50                   	push   %eax
  800263:	68 c5 1f 80 00       	push   $0x801fc5
  800268:	e8 18 01 00 00       	call   800385 <cprintf>
  80026d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800270:	83 ec 0c             	sub    $0xc,%esp
  800273:	68 34 1f 80 00       	push   $0x801f34
  800278:	e8 08 01 00 00       	call   800385 <cprintf>
  80027d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800280:	e8 81 13 00 00       	call   801606 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800285:	e8 19 00 00 00       	call   8002a3 <exit>
}
  80028a:	90                   	nop
  80028b:	c9                   	leave  
  80028c:	c3                   	ret    

0080028d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80028d:	55                   	push   %ebp
  80028e:	89 e5                	mov    %esp,%ebp
  800290:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800293:	83 ec 0c             	sub    $0xc,%esp
  800296:	6a 00                	push   $0x0
  800298:	e8 80 11 00 00       	call   80141d <sys_env_destroy>
  80029d:	83 c4 10             	add    $0x10,%esp
}
  8002a0:	90                   	nop
  8002a1:	c9                   	leave  
  8002a2:	c3                   	ret    

008002a3 <exit>:

void
exit(void)
{
  8002a3:	55                   	push   %ebp
  8002a4:	89 e5                	mov    %esp,%ebp
  8002a6:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002a9:	e8 d5 11 00 00       	call   801483 <sys_env_exit>
}
  8002ae:	90                   	nop
  8002af:	c9                   	leave  
  8002b0:	c3                   	ret    

008002b1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8002b1:	55                   	push   %ebp
  8002b2:	89 e5                	mov    %esp,%ebp
  8002b4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8002b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ba:	8b 00                	mov    (%eax),%eax
  8002bc:	8d 48 01             	lea    0x1(%eax),%ecx
  8002bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002c2:	89 0a                	mov    %ecx,(%edx)
  8002c4:	8b 55 08             	mov    0x8(%ebp),%edx
  8002c7:	88 d1                	mov    %dl,%cl
  8002c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002cc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d3:	8b 00                	mov    (%eax),%eax
  8002d5:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002da:	75 2c                	jne    800308 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8002dc:	a0 24 30 80 00       	mov    0x803024,%al
  8002e1:	0f b6 c0             	movzbl %al,%eax
  8002e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002e7:	8b 12                	mov    (%edx),%edx
  8002e9:	89 d1                	mov    %edx,%ecx
  8002eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002ee:	83 c2 08             	add    $0x8,%edx
  8002f1:	83 ec 04             	sub    $0x4,%esp
  8002f4:	50                   	push   %eax
  8002f5:	51                   	push   %ecx
  8002f6:	52                   	push   %edx
  8002f7:	e8 df 10 00 00       	call   8013db <sys_cputs>
  8002fc:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800302:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800308:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030b:	8b 40 04             	mov    0x4(%eax),%eax
  80030e:	8d 50 01             	lea    0x1(%eax),%edx
  800311:	8b 45 0c             	mov    0xc(%ebp),%eax
  800314:	89 50 04             	mov    %edx,0x4(%eax)
}
  800317:	90                   	nop
  800318:	c9                   	leave  
  800319:	c3                   	ret    

0080031a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80031a:	55                   	push   %ebp
  80031b:	89 e5                	mov    %esp,%ebp
  80031d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800323:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80032a:	00 00 00 
	b.cnt = 0;
  80032d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800334:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800337:	ff 75 0c             	pushl  0xc(%ebp)
  80033a:	ff 75 08             	pushl  0x8(%ebp)
  80033d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800343:	50                   	push   %eax
  800344:	68 b1 02 80 00       	push   $0x8002b1
  800349:	e8 11 02 00 00       	call   80055f <vprintfmt>
  80034e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800351:	a0 24 30 80 00       	mov    0x803024,%al
  800356:	0f b6 c0             	movzbl %al,%eax
  800359:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	50                   	push   %eax
  800363:	52                   	push   %edx
  800364:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80036a:	83 c0 08             	add    $0x8,%eax
  80036d:	50                   	push   %eax
  80036e:	e8 68 10 00 00       	call   8013db <sys_cputs>
  800373:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800376:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80037d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800383:	c9                   	leave  
  800384:	c3                   	ret    

00800385 <cprintf>:

int cprintf(const char *fmt, ...) {
  800385:	55                   	push   %ebp
  800386:	89 e5                	mov    %esp,%ebp
  800388:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80038b:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800392:	8d 45 0c             	lea    0xc(%ebp),%eax
  800395:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800398:	8b 45 08             	mov    0x8(%ebp),%eax
  80039b:	83 ec 08             	sub    $0x8,%esp
  80039e:	ff 75 f4             	pushl  -0xc(%ebp)
  8003a1:	50                   	push   %eax
  8003a2:	e8 73 ff ff ff       	call   80031a <vcprintf>
  8003a7:	83 c4 10             	add    $0x10,%esp
  8003aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003b0:	c9                   	leave  
  8003b1:	c3                   	ret    

008003b2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8003b2:	55                   	push   %ebp
  8003b3:	89 e5                	mov    %esp,%ebp
  8003b5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8003b8:	e8 2f 12 00 00       	call   8015ec <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8003bd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c6:	83 ec 08             	sub    $0x8,%esp
  8003c9:	ff 75 f4             	pushl  -0xc(%ebp)
  8003cc:	50                   	push   %eax
  8003cd:	e8 48 ff ff ff       	call   80031a <vcprintf>
  8003d2:	83 c4 10             	add    $0x10,%esp
  8003d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8003d8:	e8 29 12 00 00       	call   801606 <sys_enable_interrupt>
	return cnt;
  8003dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003e0:	c9                   	leave  
  8003e1:	c3                   	ret    

008003e2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	53                   	push   %ebx
  8003e6:	83 ec 14             	sub    $0x14,%esp
  8003e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8003ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8003ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8003f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003f5:	8b 45 18             	mov    0x18(%ebp),%eax
  8003f8:	ba 00 00 00 00       	mov    $0x0,%edx
  8003fd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800400:	77 55                	ja     800457 <printnum+0x75>
  800402:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800405:	72 05                	jb     80040c <printnum+0x2a>
  800407:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80040a:	77 4b                	ja     800457 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80040c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80040f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800412:	8b 45 18             	mov    0x18(%ebp),%eax
  800415:	ba 00 00 00 00       	mov    $0x0,%edx
  80041a:	52                   	push   %edx
  80041b:	50                   	push   %eax
  80041c:	ff 75 f4             	pushl  -0xc(%ebp)
  80041f:	ff 75 f0             	pushl  -0x10(%ebp)
  800422:	e8 69 18 00 00       	call   801c90 <__udivdi3>
  800427:	83 c4 10             	add    $0x10,%esp
  80042a:	83 ec 04             	sub    $0x4,%esp
  80042d:	ff 75 20             	pushl  0x20(%ebp)
  800430:	53                   	push   %ebx
  800431:	ff 75 18             	pushl  0x18(%ebp)
  800434:	52                   	push   %edx
  800435:	50                   	push   %eax
  800436:	ff 75 0c             	pushl  0xc(%ebp)
  800439:	ff 75 08             	pushl  0x8(%ebp)
  80043c:	e8 a1 ff ff ff       	call   8003e2 <printnum>
  800441:	83 c4 20             	add    $0x20,%esp
  800444:	eb 1a                	jmp    800460 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800446:	83 ec 08             	sub    $0x8,%esp
  800449:	ff 75 0c             	pushl  0xc(%ebp)
  80044c:	ff 75 20             	pushl  0x20(%ebp)
  80044f:	8b 45 08             	mov    0x8(%ebp),%eax
  800452:	ff d0                	call   *%eax
  800454:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800457:	ff 4d 1c             	decl   0x1c(%ebp)
  80045a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80045e:	7f e6                	jg     800446 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800460:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800463:	bb 00 00 00 00       	mov    $0x0,%ebx
  800468:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80046b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80046e:	53                   	push   %ebx
  80046f:	51                   	push   %ecx
  800470:	52                   	push   %edx
  800471:	50                   	push   %eax
  800472:	e8 29 19 00 00       	call   801da0 <__umoddi3>
  800477:	83 c4 10             	add    $0x10,%esp
  80047a:	05 f4 21 80 00       	add    $0x8021f4,%eax
  80047f:	8a 00                	mov    (%eax),%al
  800481:	0f be c0             	movsbl %al,%eax
  800484:	83 ec 08             	sub    $0x8,%esp
  800487:	ff 75 0c             	pushl  0xc(%ebp)
  80048a:	50                   	push   %eax
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	ff d0                	call   *%eax
  800490:	83 c4 10             	add    $0x10,%esp
}
  800493:	90                   	nop
  800494:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800497:	c9                   	leave  
  800498:	c3                   	ret    

00800499 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800499:	55                   	push   %ebp
  80049a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80049c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004a0:	7e 1c                	jle    8004be <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8004a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a5:	8b 00                	mov    (%eax),%eax
  8004a7:	8d 50 08             	lea    0x8(%eax),%edx
  8004aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ad:	89 10                	mov    %edx,(%eax)
  8004af:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b2:	8b 00                	mov    (%eax),%eax
  8004b4:	83 e8 08             	sub    $0x8,%eax
  8004b7:	8b 50 04             	mov    0x4(%eax),%edx
  8004ba:	8b 00                	mov    (%eax),%eax
  8004bc:	eb 40                	jmp    8004fe <getuint+0x65>
	else if (lflag)
  8004be:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004c2:	74 1e                	je     8004e2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8004c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c7:	8b 00                	mov    (%eax),%eax
  8004c9:	8d 50 04             	lea    0x4(%eax),%edx
  8004cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cf:	89 10                	mov    %edx,(%eax)
  8004d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d4:	8b 00                	mov    (%eax),%eax
  8004d6:	83 e8 04             	sub    $0x4,%eax
  8004d9:	8b 00                	mov    (%eax),%eax
  8004db:	ba 00 00 00 00       	mov    $0x0,%edx
  8004e0:	eb 1c                	jmp    8004fe <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8004e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e5:	8b 00                	mov    (%eax),%eax
  8004e7:	8d 50 04             	lea    0x4(%eax),%edx
  8004ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ed:	89 10                	mov    %edx,(%eax)
  8004ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f2:	8b 00                	mov    (%eax),%eax
  8004f4:	83 e8 04             	sub    $0x4,%eax
  8004f7:	8b 00                	mov    (%eax),%eax
  8004f9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004fe:	5d                   	pop    %ebp
  8004ff:	c3                   	ret    

00800500 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800500:	55                   	push   %ebp
  800501:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800503:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800507:	7e 1c                	jle    800525 <getint+0x25>
		return va_arg(*ap, long long);
  800509:	8b 45 08             	mov    0x8(%ebp),%eax
  80050c:	8b 00                	mov    (%eax),%eax
  80050e:	8d 50 08             	lea    0x8(%eax),%edx
  800511:	8b 45 08             	mov    0x8(%ebp),%eax
  800514:	89 10                	mov    %edx,(%eax)
  800516:	8b 45 08             	mov    0x8(%ebp),%eax
  800519:	8b 00                	mov    (%eax),%eax
  80051b:	83 e8 08             	sub    $0x8,%eax
  80051e:	8b 50 04             	mov    0x4(%eax),%edx
  800521:	8b 00                	mov    (%eax),%eax
  800523:	eb 38                	jmp    80055d <getint+0x5d>
	else if (lflag)
  800525:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800529:	74 1a                	je     800545 <getint+0x45>
		return va_arg(*ap, long);
  80052b:	8b 45 08             	mov    0x8(%ebp),%eax
  80052e:	8b 00                	mov    (%eax),%eax
  800530:	8d 50 04             	lea    0x4(%eax),%edx
  800533:	8b 45 08             	mov    0x8(%ebp),%eax
  800536:	89 10                	mov    %edx,(%eax)
  800538:	8b 45 08             	mov    0x8(%ebp),%eax
  80053b:	8b 00                	mov    (%eax),%eax
  80053d:	83 e8 04             	sub    $0x4,%eax
  800540:	8b 00                	mov    (%eax),%eax
  800542:	99                   	cltd   
  800543:	eb 18                	jmp    80055d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800545:	8b 45 08             	mov    0x8(%ebp),%eax
  800548:	8b 00                	mov    (%eax),%eax
  80054a:	8d 50 04             	lea    0x4(%eax),%edx
  80054d:	8b 45 08             	mov    0x8(%ebp),%eax
  800550:	89 10                	mov    %edx,(%eax)
  800552:	8b 45 08             	mov    0x8(%ebp),%eax
  800555:	8b 00                	mov    (%eax),%eax
  800557:	83 e8 04             	sub    $0x4,%eax
  80055a:	8b 00                	mov    (%eax),%eax
  80055c:	99                   	cltd   
}
  80055d:	5d                   	pop    %ebp
  80055e:	c3                   	ret    

0080055f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80055f:	55                   	push   %ebp
  800560:	89 e5                	mov    %esp,%ebp
  800562:	56                   	push   %esi
  800563:	53                   	push   %ebx
  800564:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800567:	eb 17                	jmp    800580 <vprintfmt+0x21>
			if (ch == '\0')
  800569:	85 db                	test   %ebx,%ebx
  80056b:	0f 84 af 03 00 00    	je     800920 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800571:	83 ec 08             	sub    $0x8,%esp
  800574:	ff 75 0c             	pushl  0xc(%ebp)
  800577:	53                   	push   %ebx
  800578:	8b 45 08             	mov    0x8(%ebp),%eax
  80057b:	ff d0                	call   *%eax
  80057d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800580:	8b 45 10             	mov    0x10(%ebp),%eax
  800583:	8d 50 01             	lea    0x1(%eax),%edx
  800586:	89 55 10             	mov    %edx,0x10(%ebp)
  800589:	8a 00                	mov    (%eax),%al
  80058b:	0f b6 d8             	movzbl %al,%ebx
  80058e:	83 fb 25             	cmp    $0x25,%ebx
  800591:	75 d6                	jne    800569 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800593:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800597:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80059e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8005a5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8005ac:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8005b6:	8d 50 01             	lea    0x1(%eax),%edx
  8005b9:	89 55 10             	mov    %edx,0x10(%ebp)
  8005bc:	8a 00                	mov    (%eax),%al
  8005be:	0f b6 d8             	movzbl %al,%ebx
  8005c1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8005c4:	83 f8 55             	cmp    $0x55,%eax
  8005c7:	0f 87 2b 03 00 00    	ja     8008f8 <vprintfmt+0x399>
  8005cd:	8b 04 85 18 22 80 00 	mov    0x802218(,%eax,4),%eax
  8005d4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8005d6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8005da:	eb d7                	jmp    8005b3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8005dc:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8005e0:	eb d1                	jmp    8005b3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005e2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8005e9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005ec:	89 d0                	mov    %edx,%eax
  8005ee:	c1 e0 02             	shl    $0x2,%eax
  8005f1:	01 d0                	add    %edx,%eax
  8005f3:	01 c0                	add    %eax,%eax
  8005f5:	01 d8                	add    %ebx,%eax
  8005f7:	83 e8 30             	sub    $0x30,%eax
  8005fa:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800600:	8a 00                	mov    (%eax),%al
  800602:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800605:	83 fb 2f             	cmp    $0x2f,%ebx
  800608:	7e 3e                	jle    800648 <vprintfmt+0xe9>
  80060a:	83 fb 39             	cmp    $0x39,%ebx
  80060d:	7f 39                	jg     800648 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80060f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800612:	eb d5                	jmp    8005e9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800614:	8b 45 14             	mov    0x14(%ebp),%eax
  800617:	83 c0 04             	add    $0x4,%eax
  80061a:	89 45 14             	mov    %eax,0x14(%ebp)
  80061d:	8b 45 14             	mov    0x14(%ebp),%eax
  800620:	83 e8 04             	sub    $0x4,%eax
  800623:	8b 00                	mov    (%eax),%eax
  800625:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800628:	eb 1f                	jmp    800649 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80062a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80062e:	79 83                	jns    8005b3 <vprintfmt+0x54>
				width = 0;
  800630:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800637:	e9 77 ff ff ff       	jmp    8005b3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80063c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800643:	e9 6b ff ff ff       	jmp    8005b3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800648:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800649:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80064d:	0f 89 60 ff ff ff    	jns    8005b3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800653:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800656:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800659:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800660:	e9 4e ff ff ff       	jmp    8005b3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800665:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800668:	e9 46 ff ff ff       	jmp    8005b3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80066d:	8b 45 14             	mov    0x14(%ebp),%eax
  800670:	83 c0 04             	add    $0x4,%eax
  800673:	89 45 14             	mov    %eax,0x14(%ebp)
  800676:	8b 45 14             	mov    0x14(%ebp),%eax
  800679:	83 e8 04             	sub    $0x4,%eax
  80067c:	8b 00                	mov    (%eax),%eax
  80067e:	83 ec 08             	sub    $0x8,%esp
  800681:	ff 75 0c             	pushl  0xc(%ebp)
  800684:	50                   	push   %eax
  800685:	8b 45 08             	mov    0x8(%ebp),%eax
  800688:	ff d0                	call   *%eax
  80068a:	83 c4 10             	add    $0x10,%esp
			break;
  80068d:	e9 89 02 00 00       	jmp    80091b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800692:	8b 45 14             	mov    0x14(%ebp),%eax
  800695:	83 c0 04             	add    $0x4,%eax
  800698:	89 45 14             	mov    %eax,0x14(%ebp)
  80069b:	8b 45 14             	mov    0x14(%ebp),%eax
  80069e:	83 e8 04             	sub    $0x4,%eax
  8006a1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8006a3:	85 db                	test   %ebx,%ebx
  8006a5:	79 02                	jns    8006a9 <vprintfmt+0x14a>
				err = -err;
  8006a7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8006a9:	83 fb 64             	cmp    $0x64,%ebx
  8006ac:	7f 0b                	jg     8006b9 <vprintfmt+0x15a>
  8006ae:	8b 34 9d 60 20 80 00 	mov    0x802060(,%ebx,4),%esi
  8006b5:	85 f6                	test   %esi,%esi
  8006b7:	75 19                	jne    8006d2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8006b9:	53                   	push   %ebx
  8006ba:	68 05 22 80 00       	push   $0x802205
  8006bf:	ff 75 0c             	pushl  0xc(%ebp)
  8006c2:	ff 75 08             	pushl  0x8(%ebp)
  8006c5:	e8 5e 02 00 00       	call   800928 <printfmt>
  8006ca:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8006cd:	e9 49 02 00 00       	jmp    80091b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8006d2:	56                   	push   %esi
  8006d3:	68 0e 22 80 00       	push   $0x80220e
  8006d8:	ff 75 0c             	pushl  0xc(%ebp)
  8006db:	ff 75 08             	pushl  0x8(%ebp)
  8006de:	e8 45 02 00 00       	call   800928 <printfmt>
  8006e3:	83 c4 10             	add    $0x10,%esp
			break;
  8006e6:	e9 30 02 00 00       	jmp    80091b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8006eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ee:	83 c0 04             	add    $0x4,%eax
  8006f1:	89 45 14             	mov    %eax,0x14(%ebp)
  8006f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f7:	83 e8 04             	sub    $0x4,%eax
  8006fa:	8b 30                	mov    (%eax),%esi
  8006fc:	85 f6                	test   %esi,%esi
  8006fe:	75 05                	jne    800705 <vprintfmt+0x1a6>
				p = "(null)";
  800700:	be 11 22 80 00       	mov    $0x802211,%esi
			if (width > 0 && padc != '-')
  800705:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800709:	7e 6d                	jle    800778 <vprintfmt+0x219>
  80070b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80070f:	74 67                	je     800778 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800711:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800714:	83 ec 08             	sub    $0x8,%esp
  800717:	50                   	push   %eax
  800718:	56                   	push   %esi
  800719:	e8 0c 03 00 00       	call   800a2a <strnlen>
  80071e:	83 c4 10             	add    $0x10,%esp
  800721:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800724:	eb 16                	jmp    80073c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800726:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80072a:	83 ec 08             	sub    $0x8,%esp
  80072d:	ff 75 0c             	pushl  0xc(%ebp)
  800730:	50                   	push   %eax
  800731:	8b 45 08             	mov    0x8(%ebp),%eax
  800734:	ff d0                	call   *%eax
  800736:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800739:	ff 4d e4             	decl   -0x1c(%ebp)
  80073c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800740:	7f e4                	jg     800726 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800742:	eb 34                	jmp    800778 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800744:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800748:	74 1c                	je     800766 <vprintfmt+0x207>
  80074a:	83 fb 1f             	cmp    $0x1f,%ebx
  80074d:	7e 05                	jle    800754 <vprintfmt+0x1f5>
  80074f:	83 fb 7e             	cmp    $0x7e,%ebx
  800752:	7e 12                	jle    800766 <vprintfmt+0x207>
					putch('?', putdat);
  800754:	83 ec 08             	sub    $0x8,%esp
  800757:	ff 75 0c             	pushl  0xc(%ebp)
  80075a:	6a 3f                	push   $0x3f
  80075c:	8b 45 08             	mov    0x8(%ebp),%eax
  80075f:	ff d0                	call   *%eax
  800761:	83 c4 10             	add    $0x10,%esp
  800764:	eb 0f                	jmp    800775 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800766:	83 ec 08             	sub    $0x8,%esp
  800769:	ff 75 0c             	pushl  0xc(%ebp)
  80076c:	53                   	push   %ebx
  80076d:	8b 45 08             	mov    0x8(%ebp),%eax
  800770:	ff d0                	call   *%eax
  800772:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800775:	ff 4d e4             	decl   -0x1c(%ebp)
  800778:	89 f0                	mov    %esi,%eax
  80077a:	8d 70 01             	lea    0x1(%eax),%esi
  80077d:	8a 00                	mov    (%eax),%al
  80077f:	0f be d8             	movsbl %al,%ebx
  800782:	85 db                	test   %ebx,%ebx
  800784:	74 24                	je     8007aa <vprintfmt+0x24b>
  800786:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80078a:	78 b8                	js     800744 <vprintfmt+0x1e5>
  80078c:	ff 4d e0             	decl   -0x20(%ebp)
  80078f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800793:	79 af                	jns    800744 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800795:	eb 13                	jmp    8007aa <vprintfmt+0x24b>
				putch(' ', putdat);
  800797:	83 ec 08             	sub    $0x8,%esp
  80079a:	ff 75 0c             	pushl  0xc(%ebp)
  80079d:	6a 20                	push   $0x20
  80079f:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a2:	ff d0                	call   *%eax
  8007a4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007a7:	ff 4d e4             	decl   -0x1c(%ebp)
  8007aa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ae:	7f e7                	jg     800797 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8007b0:	e9 66 01 00 00       	jmp    80091b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8007b5:	83 ec 08             	sub    $0x8,%esp
  8007b8:	ff 75 e8             	pushl  -0x18(%ebp)
  8007bb:	8d 45 14             	lea    0x14(%ebp),%eax
  8007be:	50                   	push   %eax
  8007bf:	e8 3c fd ff ff       	call   800500 <getint>
  8007c4:	83 c4 10             	add    $0x10,%esp
  8007c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8007cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007d3:	85 d2                	test   %edx,%edx
  8007d5:	79 23                	jns    8007fa <vprintfmt+0x29b>
				putch('-', putdat);
  8007d7:	83 ec 08             	sub    $0x8,%esp
  8007da:	ff 75 0c             	pushl  0xc(%ebp)
  8007dd:	6a 2d                	push   $0x2d
  8007df:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e2:	ff d0                	call   *%eax
  8007e4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8007e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ed:	f7 d8                	neg    %eax
  8007ef:	83 d2 00             	adc    $0x0,%edx
  8007f2:	f7 da                	neg    %edx
  8007f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007fa:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800801:	e9 bc 00 00 00       	jmp    8008c2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800806:	83 ec 08             	sub    $0x8,%esp
  800809:	ff 75 e8             	pushl  -0x18(%ebp)
  80080c:	8d 45 14             	lea    0x14(%ebp),%eax
  80080f:	50                   	push   %eax
  800810:	e8 84 fc ff ff       	call   800499 <getuint>
  800815:	83 c4 10             	add    $0x10,%esp
  800818:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80081b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80081e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800825:	e9 98 00 00 00       	jmp    8008c2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80082a:	83 ec 08             	sub    $0x8,%esp
  80082d:	ff 75 0c             	pushl  0xc(%ebp)
  800830:	6a 58                	push   $0x58
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	ff d0                	call   *%eax
  800837:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80083a:	83 ec 08             	sub    $0x8,%esp
  80083d:	ff 75 0c             	pushl  0xc(%ebp)
  800840:	6a 58                	push   $0x58
  800842:	8b 45 08             	mov    0x8(%ebp),%eax
  800845:	ff d0                	call   *%eax
  800847:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80084a:	83 ec 08             	sub    $0x8,%esp
  80084d:	ff 75 0c             	pushl  0xc(%ebp)
  800850:	6a 58                	push   $0x58
  800852:	8b 45 08             	mov    0x8(%ebp),%eax
  800855:	ff d0                	call   *%eax
  800857:	83 c4 10             	add    $0x10,%esp
			break;
  80085a:	e9 bc 00 00 00       	jmp    80091b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80085f:	83 ec 08             	sub    $0x8,%esp
  800862:	ff 75 0c             	pushl  0xc(%ebp)
  800865:	6a 30                	push   $0x30
  800867:	8b 45 08             	mov    0x8(%ebp),%eax
  80086a:	ff d0                	call   *%eax
  80086c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80086f:	83 ec 08             	sub    $0x8,%esp
  800872:	ff 75 0c             	pushl  0xc(%ebp)
  800875:	6a 78                	push   $0x78
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	ff d0                	call   *%eax
  80087c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80087f:	8b 45 14             	mov    0x14(%ebp),%eax
  800882:	83 c0 04             	add    $0x4,%eax
  800885:	89 45 14             	mov    %eax,0x14(%ebp)
  800888:	8b 45 14             	mov    0x14(%ebp),%eax
  80088b:	83 e8 04             	sub    $0x4,%eax
  80088e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800890:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800893:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80089a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8008a1:	eb 1f                	jmp    8008c2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8008a3:	83 ec 08             	sub    $0x8,%esp
  8008a6:	ff 75 e8             	pushl  -0x18(%ebp)
  8008a9:	8d 45 14             	lea    0x14(%ebp),%eax
  8008ac:	50                   	push   %eax
  8008ad:	e8 e7 fb ff ff       	call   800499 <getuint>
  8008b2:	83 c4 10             	add    $0x10,%esp
  8008b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8008bb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8008c2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8008c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008c9:	83 ec 04             	sub    $0x4,%esp
  8008cc:	52                   	push   %edx
  8008cd:	ff 75 e4             	pushl  -0x1c(%ebp)
  8008d0:	50                   	push   %eax
  8008d1:	ff 75 f4             	pushl  -0xc(%ebp)
  8008d4:	ff 75 f0             	pushl  -0x10(%ebp)
  8008d7:	ff 75 0c             	pushl  0xc(%ebp)
  8008da:	ff 75 08             	pushl  0x8(%ebp)
  8008dd:	e8 00 fb ff ff       	call   8003e2 <printnum>
  8008e2:	83 c4 20             	add    $0x20,%esp
			break;
  8008e5:	eb 34                	jmp    80091b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8008e7:	83 ec 08             	sub    $0x8,%esp
  8008ea:	ff 75 0c             	pushl  0xc(%ebp)
  8008ed:	53                   	push   %ebx
  8008ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f1:	ff d0                	call   *%eax
  8008f3:	83 c4 10             	add    $0x10,%esp
			break;
  8008f6:	eb 23                	jmp    80091b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008f8:	83 ec 08             	sub    $0x8,%esp
  8008fb:	ff 75 0c             	pushl  0xc(%ebp)
  8008fe:	6a 25                	push   $0x25
  800900:	8b 45 08             	mov    0x8(%ebp),%eax
  800903:	ff d0                	call   *%eax
  800905:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800908:	ff 4d 10             	decl   0x10(%ebp)
  80090b:	eb 03                	jmp    800910 <vprintfmt+0x3b1>
  80090d:	ff 4d 10             	decl   0x10(%ebp)
  800910:	8b 45 10             	mov    0x10(%ebp),%eax
  800913:	48                   	dec    %eax
  800914:	8a 00                	mov    (%eax),%al
  800916:	3c 25                	cmp    $0x25,%al
  800918:	75 f3                	jne    80090d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80091a:	90                   	nop
		}
	}
  80091b:	e9 47 fc ff ff       	jmp    800567 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800920:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800921:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800924:	5b                   	pop    %ebx
  800925:	5e                   	pop    %esi
  800926:	5d                   	pop    %ebp
  800927:	c3                   	ret    

00800928 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800928:	55                   	push   %ebp
  800929:	89 e5                	mov    %esp,%ebp
  80092b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80092e:	8d 45 10             	lea    0x10(%ebp),%eax
  800931:	83 c0 04             	add    $0x4,%eax
  800934:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800937:	8b 45 10             	mov    0x10(%ebp),%eax
  80093a:	ff 75 f4             	pushl  -0xc(%ebp)
  80093d:	50                   	push   %eax
  80093e:	ff 75 0c             	pushl  0xc(%ebp)
  800941:	ff 75 08             	pushl  0x8(%ebp)
  800944:	e8 16 fc ff ff       	call   80055f <vprintfmt>
  800949:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80094c:	90                   	nop
  80094d:	c9                   	leave  
  80094e:	c3                   	ret    

0080094f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80094f:	55                   	push   %ebp
  800950:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800952:	8b 45 0c             	mov    0xc(%ebp),%eax
  800955:	8b 40 08             	mov    0x8(%eax),%eax
  800958:	8d 50 01             	lea    0x1(%eax),%edx
  80095b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800961:	8b 45 0c             	mov    0xc(%ebp),%eax
  800964:	8b 10                	mov    (%eax),%edx
  800966:	8b 45 0c             	mov    0xc(%ebp),%eax
  800969:	8b 40 04             	mov    0x4(%eax),%eax
  80096c:	39 c2                	cmp    %eax,%edx
  80096e:	73 12                	jae    800982 <sprintputch+0x33>
		*b->buf++ = ch;
  800970:	8b 45 0c             	mov    0xc(%ebp),%eax
  800973:	8b 00                	mov    (%eax),%eax
  800975:	8d 48 01             	lea    0x1(%eax),%ecx
  800978:	8b 55 0c             	mov    0xc(%ebp),%edx
  80097b:	89 0a                	mov    %ecx,(%edx)
  80097d:	8b 55 08             	mov    0x8(%ebp),%edx
  800980:	88 10                	mov    %dl,(%eax)
}
  800982:	90                   	nop
  800983:	5d                   	pop    %ebp
  800984:	c3                   	ret    

00800985 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800985:	55                   	push   %ebp
  800986:	89 e5                	mov    %esp,%ebp
  800988:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80098b:	8b 45 08             	mov    0x8(%ebp),%eax
  80098e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800991:	8b 45 0c             	mov    0xc(%ebp),%eax
  800994:	8d 50 ff             	lea    -0x1(%eax),%edx
  800997:	8b 45 08             	mov    0x8(%ebp),%eax
  80099a:	01 d0                	add    %edx,%eax
  80099c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8009a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8009aa:	74 06                	je     8009b2 <vsnprintf+0x2d>
  8009ac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009b0:	7f 07                	jg     8009b9 <vsnprintf+0x34>
		return -E_INVAL;
  8009b2:	b8 03 00 00 00       	mov    $0x3,%eax
  8009b7:	eb 20                	jmp    8009d9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8009b9:	ff 75 14             	pushl  0x14(%ebp)
  8009bc:	ff 75 10             	pushl  0x10(%ebp)
  8009bf:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8009c2:	50                   	push   %eax
  8009c3:	68 4f 09 80 00       	push   $0x80094f
  8009c8:	e8 92 fb ff ff       	call   80055f <vprintfmt>
  8009cd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8009d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009d3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8009d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8009d9:	c9                   	leave  
  8009da:	c3                   	ret    

008009db <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8009db:	55                   	push   %ebp
  8009dc:	89 e5                	mov    %esp,%ebp
  8009de:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8009e1:	8d 45 10             	lea    0x10(%ebp),%eax
  8009e4:	83 c0 04             	add    $0x4,%eax
  8009e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8009ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f0:	50                   	push   %eax
  8009f1:	ff 75 0c             	pushl  0xc(%ebp)
  8009f4:	ff 75 08             	pushl  0x8(%ebp)
  8009f7:	e8 89 ff ff ff       	call   800985 <vsnprintf>
  8009fc:	83 c4 10             	add    $0x10,%esp
  8009ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a02:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a05:	c9                   	leave  
  800a06:	c3                   	ret    

00800a07 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a07:	55                   	push   %ebp
  800a08:	89 e5                	mov    %esp,%ebp
  800a0a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a0d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a14:	eb 06                	jmp    800a1c <strlen+0x15>
		n++;
  800a16:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a19:	ff 45 08             	incl   0x8(%ebp)
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	8a 00                	mov    (%eax),%al
  800a21:	84 c0                	test   %al,%al
  800a23:	75 f1                	jne    800a16 <strlen+0xf>
		n++;
	return n;
  800a25:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a28:	c9                   	leave  
  800a29:	c3                   	ret    

00800a2a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a2a:	55                   	push   %ebp
  800a2b:	89 e5                	mov    %esp,%ebp
  800a2d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a30:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a37:	eb 09                	jmp    800a42 <strnlen+0x18>
		n++;
  800a39:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a3c:	ff 45 08             	incl   0x8(%ebp)
  800a3f:	ff 4d 0c             	decl   0xc(%ebp)
  800a42:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a46:	74 09                	je     800a51 <strnlen+0x27>
  800a48:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4b:	8a 00                	mov    (%eax),%al
  800a4d:	84 c0                	test   %al,%al
  800a4f:	75 e8                	jne    800a39 <strnlen+0xf>
		n++;
	return n;
  800a51:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a54:	c9                   	leave  
  800a55:	c3                   	ret    

00800a56 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a56:	55                   	push   %ebp
  800a57:	89 e5                	mov    %esp,%ebp
  800a59:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a62:	90                   	nop
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	8d 50 01             	lea    0x1(%eax),%edx
  800a69:	89 55 08             	mov    %edx,0x8(%ebp)
  800a6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a6f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a72:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a75:	8a 12                	mov    (%edx),%dl
  800a77:	88 10                	mov    %dl,(%eax)
  800a79:	8a 00                	mov    (%eax),%al
  800a7b:	84 c0                	test   %al,%al
  800a7d:	75 e4                	jne    800a63 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a82:	c9                   	leave  
  800a83:	c3                   	ret    

00800a84 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a84:	55                   	push   %ebp
  800a85:	89 e5                	mov    %esp,%ebp
  800a87:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a90:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a97:	eb 1f                	jmp    800ab8 <strncpy+0x34>
		*dst++ = *src;
  800a99:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9c:	8d 50 01             	lea    0x1(%eax),%edx
  800a9f:	89 55 08             	mov    %edx,0x8(%ebp)
  800aa2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aa5:	8a 12                	mov    (%edx),%dl
  800aa7:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800aa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aac:	8a 00                	mov    (%eax),%al
  800aae:	84 c0                	test   %al,%al
  800ab0:	74 03                	je     800ab5 <strncpy+0x31>
			src++;
  800ab2:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ab5:	ff 45 fc             	incl   -0x4(%ebp)
  800ab8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800abb:	3b 45 10             	cmp    0x10(%ebp),%eax
  800abe:	72 d9                	jb     800a99 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ac0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ac3:	c9                   	leave  
  800ac4:	c3                   	ret    

00800ac5 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ac5:	55                   	push   %ebp
  800ac6:	89 e5                	mov    %esp,%ebp
  800ac8:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ad1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ad5:	74 30                	je     800b07 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ad7:	eb 16                	jmp    800aef <strlcpy+0x2a>
			*dst++ = *src++;
  800ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  800adc:	8d 50 01             	lea    0x1(%eax),%edx
  800adf:	89 55 08             	mov    %edx,0x8(%ebp)
  800ae2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ae8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800aeb:	8a 12                	mov    (%edx),%dl
  800aed:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800aef:	ff 4d 10             	decl   0x10(%ebp)
  800af2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800af6:	74 09                	je     800b01 <strlcpy+0x3c>
  800af8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afb:	8a 00                	mov    (%eax),%al
  800afd:	84 c0                	test   %al,%al
  800aff:	75 d8                	jne    800ad9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
  800b04:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b07:	8b 55 08             	mov    0x8(%ebp),%edx
  800b0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b0d:	29 c2                	sub    %eax,%edx
  800b0f:	89 d0                	mov    %edx,%eax
}
  800b11:	c9                   	leave  
  800b12:	c3                   	ret    

00800b13 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b13:	55                   	push   %ebp
  800b14:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b16:	eb 06                	jmp    800b1e <strcmp+0xb>
		p++, q++;
  800b18:	ff 45 08             	incl   0x8(%ebp)
  800b1b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	8a 00                	mov    (%eax),%al
  800b23:	84 c0                	test   %al,%al
  800b25:	74 0e                	je     800b35 <strcmp+0x22>
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	8a 10                	mov    (%eax),%dl
  800b2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2f:	8a 00                	mov    (%eax),%al
  800b31:	38 c2                	cmp    %al,%dl
  800b33:	74 e3                	je     800b18 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b35:	8b 45 08             	mov    0x8(%ebp),%eax
  800b38:	8a 00                	mov    (%eax),%al
  800b3a:	0f b6 d0             	movzbl %al,%edx
  800b3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b40:	8a 00                	mov    (%eax),%al
  800b42:	0f b6 c0             	movzbl %al,%eax
  800b45:	29 c2                	sub    %eax,%edx
  800b47:	89 d0                	mov    %edx,%eax
}
  800b49:	5d                   	pop    %ebp
  800b4a:	c3                   	ret    

00800b4b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800b4b:	55                   	push   %ebp
  800b4c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800b4e:	eb 09                	jmp    800b59 <strncmp+0xe>
		n--, p++, q++;
  800b50:	ff 4d 10             	decl   0x10(%ebp)
  800b53:	ff 45 08             	incl   0x8(%ebp)
  800b56:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b59:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b5d:	74 17                	je     800b76 <strncmp+0x2b>
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	8a 00                	mov    (%eax),%al
  800b64:	84 c0                	test   %al,%al
  800b66:	74 0e                	je     800b76 <strncmp+0x2b>
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	8a 10                	mov    (%eax),%dl
  800b6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b70:	8a 00                	mov    (%eax),%al
  800b72:	38 c2                	cmp    %al,%dl
  800b74:	74 da                	je     800b50 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b76:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b7a:	75 07                	jne    800b83 <strncmp+0x38>
		return 0;
  800b7c:	b8 00 00 00 00       	mov    $0x0,%eax
  800b81:	eb 14                	jmp    800b97 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b83:	8b 45 08             	mov    0x8(%ebp),%eax
  800b86:	8a 00                	mov    (%eax),%al
  800b88:	0f b6 d0             	movzbl %al,%edx
  800b8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8e:	8a 00                	mov    (%eax),%al
  800b90:	0f b6 c0             	movzbl %al,%eax
  800b93:	29 c2                	sub    %eax,%edx
  800b95:	89 d0                	mov    %edx,%eax
}
  800b97:	5d                   	pop    %ebp
  800b98:	c3                   	ret    

00800b99 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b99:	55                   	push   %ebp
  800b9a:	89 e5                	mov    %esp,%ebp
  800b9c:	83 ec 04             	sub    $0x4,%esp
  800b9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ba5:	eb 12                	jmp    800bb9 <strchr+0x20>
		if (*s == c)
  800ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  800baa:	8a 00                	mov    (%eax),%al
  800bac:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800baf:	75 05                	jne    800bb6 <strchr+0x1d>
			return (char *) s;
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	eb 11                	jmp    800bc7 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800bb6:	ff 45 08             	incl   0x8(%ebp)
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	8a 00                	mov    (%eax),%al
  800bbe:	84 c0                	test   %al,%al
  800bc0:	75 e5                	jne    800ba7 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800bc2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bc7:	c9                   	leave  
  800bc8:	c3                   	ret    

00800bc9 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800bc9:	55                   	push   %ebp
  800bca:	89 e5                	mov    %esp,%ebp
  800bcc:	83 ec 04             	sub    $0x4,%esp
  800bcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800bd5:	eb 0d                	jmp    800be4 <strfind+0x1b>
		if (*s == c)
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	8a 00                	mov    (%eax),%al
  800bdc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800bdf:	74 0e                	je     800bef <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800be1:	ff 45 08             	incl   0x8(%ebp)
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	8a 00                	mov    (%eax),%al
  800be9:	84 c0                	test   %al,%al
  800beb:	75 ea                	jne    800bd7 <strfind+0xe>
  800bed:	eb 01                	jmp    800bf0 <strfind+0x27>
		if (*s == c)
			break;
  800bef:	90                   	nop
	return (char *) s;
  800bf0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bf3:	c9                   	leave  
  800bf4:	c3                   	ret    

00800bf5 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800bf5:	55                   	push   %ebp
  800bf6:	89 e5                	mov    %esp,%ebp
  800bf8:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800c01:	8b 45 10             	mov    0x10(%ebp),%eax
  800c04:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800c07:	eb 0e                	jmp    800c17 <memset+0x22>
		*p++ = c;
  800c09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0c:	8d 50 01             	lea    0x1(%eax),%edx
  800c0f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800c12:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c15:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800c17:	ff 4d f8             	decl   -0x8(%ebp)
  800c1a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800c1e:	79 e9                	jns    800c09 <memset+0x14>
		*p++ = c;

	return v;
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c23:	c9                   	leave  
  800c24:	c3                   	ret    

00800c25 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800c25:	55                   	push   %ebp
  800c26:	89 e5                	mov    %esp,%ebp
  800c28:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c31:	8b 45 08             	mov    0x8(%ebp),%eax
  800c34:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800c37:	eb 16                	jmp    800c4f <memcpy+0x2a>
		*d++ = *s++;
  800c39:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c3c:	8d 50 01             	lea    0x1(%eax),%edx
  800c3f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c42:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c45:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c48:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c4b:	8a 12                	mov    (%edx),%dl
  800c4d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c52:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c55:	89 55 10             	mov    %edx,0x10(%ebp)
  800c58:	85 c0                	test   %eax,%eax
  800c5a:	75 dd                	jne    800c39 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c5f:	c9                   	leave  
  800c60:	c3                   	ret    

00800c61 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c61:	55                   	push   %ebp
  800c62:	89 e5                	mov    %esp,%ebp
  800c64:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c73:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c76:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c79:	73 50                	jae    800ccb <memmove+0x6a>
  800c7b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c81:	01 d0                	add    %edx,%eax
  800c83:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c86:	76 43                	jbe    800ccb <memmove+0x6a>
		s += n;
  800c88:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c8e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c91:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c94:	eb 10                	jmp    800ca6 <memmove+0x45>
			*--d = *--s;
  800c96:	ff 4d f8             	decl   -0x8(%ebp)
  800c99:	ff 4d fc             	decl   -0x4(%ebp)
  800c9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c9f:	8a 10                	mov    (%eax),%dl
  800ca1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ca4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ca6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cac:	89 55 10             	mov    %edx,0x10(%ebp)
  800caf:	85 c0                	test   %eax,%eax
  800cb1:	75 e3                	jne    800c96 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800cb3:	eb 23                	jmp    800cd8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800cb5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cb8:	8d 50 01             	lea    0x1(%eax),%edx
  800cbb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800cbe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800cc1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cc4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800cc7:	8a 12                	mov    (%edx),%dl
  800cc9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ccb:	8b 45 10             	mov    0x10(%ebp),%eax
  800cce:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cd1:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd4:	85 c0                	test   %eax,%eax
  800cd6:	75 dd                	jne    800cb5 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cdb:	c9                   	leave  
  800cdc:	c3                   	ret    

00800cdd <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800cdd:	55                   	push   %ebp
  800cde:	89 e5                	mov    %esp,%ebp
  800ce0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cec:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800cef:	eb 2a                	jmp    800d1b <memcmp+0x3e>
		if (*s1 != *s2)
  800cf1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf4:	8a 10                	mov    (%eax),%dl
  800cf6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cf9:	8a 00                	mov    (%eax),%al
  800cfb:	38 c2                	cmp    %al,%dl
  800cfd:	74 16                	je     800d15 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d02:	8a 00                	mov    (%eax),%al
  800d04:	0f b6 d0             	movzbl %al,%edx
  800d07:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	0f b6 c0             	movzbl %al,%eax
  800d0f:	29 c2                	sub    %eax,%edx
  800d11:	89 d0                	mov    %edx,%eax
  800d13:	eb 18                	jmp    800d2d <memcmp+0x50>
		s1++, s2++;
  800d15:	ff 45 fc             	incl   -0x4(%ebp)
  800d18:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800d1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d1e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d21:	89 55 10             	mov    %edx,0x10(%ebp)
  800d24:	85 c0                	test   %eax,%eax
  800d26:	75 c9                	jne    800cf1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800d28:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d2d:	c9                   	leave  
  800d2e:	c3                   	ret    

00800d2f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800d2f:	55                   	push   %ebp
  800d30:	89 e5                	mov    %esp,%ebp
  800d32:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800d35:	8b 55 08             	mov    0x8(%ebp),%edx
  800d38:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3b:	01 d0                	add    %edx,%eax
  800d3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800d40:	eb 15                	jmp    800d57 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	8a 00                	mov    (%eax),%al
  800d47:	0f b6 d0             	movzbl %al,%edx
  800d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4d:	0f b6 c0             	movzbl %al,%eax
  800d50:	39 c2                	cmp    %eax,%edx
  800d52:	74 0d                	je     800d61 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d54:	ff 45 08             	incl   0x8(%ebp)
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d5d:	72 e3                	jb     800d42 <memfind+0x13>
  800d5f:	eb 01                	jmp    800d62 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d61:	90                   	nop
	return (void *) s;
  800d62:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d65:	c9                   	leave  
  800d66:	c3                   	ret    

00800d67 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d67:	55                   	push   %ebp
  800d68:	89 e5                	mov    %esp,%ebp
  800d6a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d6d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d74:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d7b:	eb 03                	jmp    800d80 <strtol+0x19>
		s++;
  800d7d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
  800d83:	8a 00                	mov    (%eax),%al
  800d85:	3c 20                	cmp    $0x20,%al
  800d87:	74 f4                	je     800d7d <strtol+0x16>
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	8a 00                	mov    (%eax),%al
  800d8e:	3c 09                	cmp    $0x9,%al
  800d90:	74 eb                	je     800d7d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d92:	8b 45 08             	mov    0x8(%ebp),%eax
  800d95:	8a 00                	mov    (%eax),%al
  800d97:	3c 2b                	cmp    $0x2b,%al
  800d99:	75 05                	jne    800da0 <strtol+0x39>
		s++;
  800d9b:	ff 45 08             	incl   0x8(%ebp)
  800d9e:	eb 13                	jmp    800db3 <strtol+0x4c>
	else if (*s == '-')
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8a 00                	mov    (%eax),%al
  800da5:	3c 2d                	cmp    $0x2d,%al
  800da7:	75 0a                	jne    800db3 <strtol+0x4c>
		s++, neg = 1;
  800da9:	ff 45 08             	incl   0x8(%ebp)
  800dac:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800db3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db7:	74 06                	je     800dbf <strtol+0x58>
  800db9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800dbd:	75 20                	jne    800ddf <strtol+0x78>
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	8a 00                	mov    (%eax),%al
  800dc4:	3c 30                	cmp    $0x30,%al
  800dc6:	75 17                	jne    800ddf <strtol+0x78>
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	40                   	inc    %eax
  800dcc:	8a 00                	mov    (%eax),%al
  800dce:	3c 78                	cmp    $0x78,%al
  800dd0:	75 0d                	jne    800ddf <strtol+0x78>
		s += 2, base = 16;
  800dd2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800dd6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ddd:	eb 28                	jmp    800e07 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ddf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800de3:	75 15                	jne    800dfa <strtol+0x93>
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	8a 00                	mov    (%eax),%al
  800dea:	3c 30                	cmp    $0x30,%al
  800dec:	75 0c                	jne    800dfa <strtol+0x93>
		s++, base = 8;
  800dee:	ff 45 08             	incl   0x8(%ebp)
  800df1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800df8:	eb 0d                	jmp    800e07 <strtol+0xa0>
	else if (base == 0)
  800dfa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dfe:	75 07                	jne    800e07 <strtol+0xa0>
		base = 10;
  800e00:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	8a 00                	mov    (%eax),%al
  800e0c:	3c 2f                	cmp    $0x2f,%al
  800e0e:	7e 19                	jle    800e29 <strtol+0xc2>
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	8a 00                	mov    (%eax),%al
  800e15:	3c 39                	cmp    $0x39,%al
  800e17:	7f 10                	jg     800e29 <strtol+0xc2>
			dig = *s - '0';
  800e19:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1c:	8a 00                	mov    (%eax),%al
  800e1e:	0f be c0             	movsbl %al,%eax
  800e21:	83 e8 30             	sub    $0x30,%eax
  800e24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e27:	eb 42                	jmp    800e6b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800e29:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2c:	8a 00                	mov    (%eax),%al
  800e2e:	3c 60                	cmp    $0x60,%al
  800e30:	7e 19                	jle    800e4b <strtol+0xe4>
  800e32:	8b 45 08             	mov    0x8(%ebp),%eax
  800e35:	8a 00                	mov    (%eax),%al
  800e37:	3c 7a                	cmp    $0x7a,%al
  800e39:	7f 10                	jg     800e4b <strtol+0xe4>
			dig = *s - 'a' + 10;
  800e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3e:	8a 00                	mov    (%eax),%al
  800e40:	0f be c0             	movsbl %al,%eax
  800e43:	83 e8 57             	sub    $0x57,%eax
  800e46:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e49:	eb 20                	jmp    800e6b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	8a 00                	mov    (%eax),%al
  800e50:	3c 40                	cmp    $0x40,%al
  800e52:	7e 39                	jle    800e8d <strtol+0x126>
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	8a 00                	mov    (%eax),%al
  800e59:	3c 5a                	cmp    $0x5a,%al
  800e5b:	7f 30                	jg     800e8d <strtol+0x126>
			dig = *s - 'A' + 10;
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	8a 00                	mov    (%eax),%al
  800e62:	0f be c0             	movsbl %al,%eax
  800e65:	83 e8 37             	sub    $0x37,%eax
  800e68:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e6e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e71:	7d 19                	jge    800e8c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e73:	ff 45 08             	incl   0x8(%ebp)
  800e76:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e79:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e7d:	89 c2                	mov    %eax,%edx
  800e7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e82:	01 d0                	add    %edx,%eax
  800e84:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e87:	e9 7b ff ff ff       	jmp    800e07 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e8c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e8d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e91:	74 08                	je     800e9b <strtol+0x134>
		*endptr = (char *) s;
  800e93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e96:	8b 55 08             	mov    0x8(%ebp),%edx
  800e99:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e9b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e9f:	74 07                	je     800ea8 <strtol+0x141>
  800ea1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea4:	f7 d8                	neg    %eax
  800ea6:	eb 03                	jmp    800eab <strtol+0x144>
  800ea8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800eab:	c9                   	leave  
  800eac:	c3                   	ret    

00800ead <ltostr>:

void
ltostr(long value, char *str)
{
  800ead:	55                   	push   %ebp
  800eae:	89 e5                	mov    %esp,%ebp
  800eb0:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800eb3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800eba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800ec1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ec5:	79 13                	jns    800eda <ltostr+0x2d>
	{
		neg = 1;
  800ec7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ece:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800ed4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800ed7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ee2:	99                   	cltd   
  800ee3:	f7 f9                	idiv   %ecx
  800ee5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ee8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eeb:	8d 50 01             	lea    0x1(%eax),%edx
  800eee:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ef1:	89 c2                	mov    %eax,%edx
  800ef3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef6:	01 d0                	add    %edx,%eax
  800ef8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800efb:	83 c2 30             	add    $0x30,%edx
  800efe:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800f00:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f03:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f08:	f7 e9                	imul   %ecx
  800f0a:	c1 fa 02             	sar    $0x2,%edx
  800f0d:	89 c8                	mov    %ecx,%eax
  800f0f:	c1 f8 1f             	sar    $0x1f,%eax
  800f12:	29 c2                	sub    %eax,%edx
  800f14:	89 d0                	mov    %edx,%eax
  800f16:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800f19:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f1c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f21:	f7 e9                	imul   %ecx
  800f23:	c1 fa 02             	sar    $0x2,%edx
  800f26:	89 c8                	mov    %ecx,%eax
  800f28:	c1 f8 1f             	sar    $0x1f,%eax
  800f2b:	29 c2                	sub    %eax,%edx
  800f2d:	89 d0                	mov    %edx,%eax
  800f2f:	c1 e0 02             	shl    $0x2,%eax
  800f32:	01 d0                	add    %edx,%eax
  800f34:	01 c0                	add    %eax,%eax
  800f36:	29 c1                	sub    %eax,%ecx
  800f38:	89 ca                	mov    %ecx,%edx
  800f3a:	85 d2                	test   %edx,%edx
  800f3c:	75 9c                	jne    800eda <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800f3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800f45:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f48:	48                   	dec    %eax
  800f49:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800f4c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f50:	74 3d                	je     800f8f <ltostr+0xe2>
		start = 1 ;
  800f52:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f59:	eb 34                	jmp    800f8f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f5b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f61:	01 d0                	add    %edx,%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6e:	01 c2                	add    %eax,%edx
  800f70:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f76:	01 c8                	add    %ecx,%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f7c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f82:	01 c2                	add    %eax,%edx
  800f84:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f87:	88 02                	mov    %al,(%edx)
		start++ ;
  800f89:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f8c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f92:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f95:	7c c4                	jl     800f5b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f97:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9d:	01 d0                	add    %edx,%eax
  800f9f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800fa2:	90                   	nop
  800fa3:	c9                   	leave  
  800fa4:	c3                   	ret    

00800fa5 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800fa5:	55                   	push   %ebp
  800fa6:	89 e5                	mov    %esp,%ebp
  800fa8:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800fab:	ff 75 08             	pushl  0x8(%ebp)
  800fae:	e8 54 fa ff ff       	call   800a07 <strlen>
  800fb3:	83 c4 04             	add    $0x4,%esp
  800fb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800fb9:	ff 75 0c             	pushl  0xc(%ebp)
  800fbc:	e8 46 fa ff ff       	call   800a07 <strlen>
  800fc1:	83 c4 04             	add    $0x4,%esp
  800fc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800fc7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800fce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fd5:	eb 17                	jmp    800fee <strcconcat+0x49>
		final[s] = str1[s] ;
  800fd7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fda:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdd:	01 c2                	add    %eax,%edx
  800fdf:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	01 c8                	add    %ecx,%eax
  800fe7:	8a 00                	mov    (%eax),%al
  800fe9:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800feb:	ff 45 fc             	incl   -0x4(%ebp)
  800fee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ff4:	7c e1                	jl     800fd7 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ff6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ffd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801004:	eb 1f                	jmp    801025 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801006:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801009:	8d 50 01             	lea    0x1(%eax),%edx
  80100c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80100f:	89 c2                	mov    %eax,%edx
  801011:	8b 45 10             	mov    0x10(%ebp),%eax
  801014:	01 c2                	add    %eax,%edx
  801016:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801019:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101c:	01 c8                	add    %ecx,%eax
  80101e:	8a 00                	mov    (%eax),%al
  801020:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801022:	ff 45 f8             	incl   -0x8(%ebp)
  801025:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801028:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80102b:	7c d9                	jl     801006 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80102d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801030:	8b 45 10             	mov    0x10(%ebp),%eax
  801033:	01 d0                	add    %edx,%eax
  801035:	c6 00 00             	movb   $0x0,(%eax)
}
  801038:	90                   	nop
  801039:	c9                   	leave  
  80103a:	c3                   	ret    

0080103b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80103b:	55                   	push   %ebp
  80103c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80103e:	8b 45 14             	mov    0x14(%ebp),%eax
  801041:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801047:	8b 45 14             	mov    0x14(%ebp),%eax
  80104a:	8b 00                	mov    (%eax),%eax
  80104c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801053:	8b 45 10             	mov    0x10(%ebp),%eax
  801056:	01 d0                	add    %edx,%eax
  801058:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80105e:	eb 0c                	jmp    80106c <strsplit+0x31>
			*string++ = 0;
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	8d 50 01             	lea    0x1(%eax),%edx
  801066:	89 55 08             	mov    %edx,0x8(%ebp)
  801069:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80106c:	8b 45 08             	mov    0x8(%ebp),%eax
  80106f:	8a 00                	mov    (%eax),%al
  801071:	84 c0                	test   %al,%al
  801073:	74 18                	je     80108d <strsplit+0x52>
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	8a 00                	mov    (%eax),%al
  80107a:	0f be c0             	movsbl %al,%eax
  80107d:	50                   	push   %eax
  80107e:	ff 75 0c             	pushl  0xc(%ebp)
  801081:	e8 13 fb ff ff       	call   800b99 <strchr>
  801086:	83 c4 08             	add    $0x8,%esp
  801089:	85 c0                	test   %eax,%eax
  80108b:	75 d3                	jne    801060 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80108d:	8b 45 08             	mov    0x8(%ebp),%eax
  801090:	8a 00                	mov    (%eax),%al
  801092:	84 c0                	test   %al,%al
  801094:	74 5a                	je     8010f0 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801096:	8b 45 14             	mov    0x14(%ebp),%eax
  801099:	8b 00                	mov    (%eax),%eax
  80109b:	83 f8 0f             	cmp    $0xf,%eax
  80109e:	75 07                	jne    8010a7 <strsplit+0x6c>
		{
			return 0;
  8010a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8010a5:	eb 66                	jmp    80110d <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8010a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8010aa:	8b 00                	mov    (%eax),%eax
  8010ac:	8d 48 01             	lea    0x1(%eax),%ecx
  8010af:	8b 55 14             	mov    0x14(%ebp),%edx
  8010b2:	89 0a                	mov    %ecx,(%edx)
  8010b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8010be:	01 c2                	add    %eax,%edx
  8010c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c3:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010c5:	eb 03                	jmp    8010ca <strsplit+0x8f>
			string++;
  8010c7:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	8a 00                	mov    (%eax),%al
  8010cf:	84 c0                	test   %al,%al
  8010d1:	74 8b                	je     80105e <strsplit+0x23>
  8010d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d6:	8a 00                	mov    (%eax),%al
  8010d8:	0f be c0             	movsbl %al,%eax
  8010db:	50                   	push   %eax
  8010dc:	ff 75 0c             	pushl  0xc(%ebp)
  8010df:	e8 b5 fa ff ff       	call   800b99 <strchr>
  8010e4:	83 c4 08             	add    $0x8,%esp
  8010e7:	85 c0                	test   %eax,%eax
  8010e9:	74 dc                	je     8010c7 <strsplit+0x8c>
			string++;
	}
  8010eb:	e9 6e ff ff ff       	jmp    80105e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8010f0:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8010f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8010f4:	8b 00                	mov    (%eax),%eax
  8010f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801100:	01 d0                	add    %edx,%eax
  801102:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801108:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80110d:	c9                   	leave  
  80110e:	c3                   	ret    

0080110f <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  80110f:	55                   	push   %ebp
  801110:	89 e5                	mov    %esp,%ebp
  801112:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	c1 e8 0c             	shr    $0xc,%eax
  80111b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  80111e:	8b 45 08             	mov    0x8(%ebp),%eax
  801121:	25 ff 0f 00 00       	and    $0xfff,%eax
  801126:	85 c0                	test   %eax,%eax
  801128:	74 03                	je     80112d <malloc+0x1e>
			num++;
  80112a:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80112d:	a1 04 30 80 00       	mov    0x803004,%eax
  801132:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801137:	75 64                	jne    80119d <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801139:	83 ec 08             	sub    $0x8,%esp
  80113c:	ff 75 08             	pushl  0x8(%ebp)
  80113f:	68 00 00 00 80       	push   $0x80000000
  801144:	e8 3a 04 00 00       	call   801583 <sys_allocateMem>
  801149:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  80114c:	a1 04 30 80 00       	mov    0x803004,%eax
  801151:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801154:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801157:	c1 e0 0c             	shl    $0xc,%eax
  80115a:	89 c2                	mov    %eax,%edx
  80115c:	a1 04 30 80 00       	mov    0x803004,%eax
  801161:	01 d0                	add    %edx,%eax
  801163:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  801168:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80116d:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801173:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  80117a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80117f:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  801186:	01 00 00 00 
			sizeofarray++;
  80118a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80118f:	40                   	inc    %eax
  801190:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  801195:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801198:	e9 26 01 00 00       	jmp    8012c3 <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  80119d:	a1 28 30 80 00       	mov    0x803028,%eax
  8011a2:	85 c0                	test   %eax,%eax
  8011a4:	75 62                	jne    801208 <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  8011a6:	a1 04 30 80 00       	mov    0x803004,%eax
  8011ab:	83 ec 08             	sub    $0x8,%esp
  8011ae:	ff 75 08             	pushl  0x8(%ebp)
  8011b1:	50                   	push   %eax
  8011b2:	e8 cc 03 00 00       	call   801583 <sys_allocateMem>
  8011b7:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8011ba:	a1 04 30 80 00       	mov    0x803004,%eax
  8011bf:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8011c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011c5:	c1 e0 0c             	shl    $0xc,%eax
  8011c8:	89 c2                	mov    %eax,%edx
  8011ca:	a1 04 30 80 00       	mov    0x803004,%eax
  8011cf:	01 d0                	add    %edx,%eax
  8011d1:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  8011d6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8011db:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8011de:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8011e5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8011ea:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  8011f1:	01 00 00 00 
				sizeofarray++;
  8011f5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8011fa:	40                   	inc    %eax
  8011fb:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801200:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801203:	e9 bb 00 00 00       	jmp    8012c3 <malloc+0x1b4>
			}
			else{
				int count=0;
  801208:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  80120f:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801216:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80121d:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801224:	eb 7c                	jmp    8012a2 <malloc+0x193>
				{
					uint32 *pg=NULL;
  801226:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  80122d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801234:	eb 1a                	jmp    801250 <malloc+0x141>
					{
						if(addresses[j]==i)
  801236:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801239:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801240:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801243:	75 08                	jne    80124d <malloc+0x13e>
						{
							index=j;
  801245:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801248:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  80124b:	eb 0d                	jmp    80125a <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  80124d:	ff 45 dc             	incl   -0x24(%ebp)
  801250:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801255:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801258:	7c dc                	jl     801236 <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  80125a:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  80125e:	75 05                	jne    801265 <malloc+0x156>
					{
						count++;
  801260:	ff 45 f0             	incl   -0x10(%ebp)
  801263:	eb 36                	jmp    80129b <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  801265:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801268:	8b 04 85 c0 32 80 00 	mov    0x8032c0(,%eax,4),%eax
  80126f:	85 c0                	test   %eax,%eax
  801271:	75 05                	jne    801278 <malloc+0x169>
						{
							count++;
  801273:	ff 45 f0             	incl   -0x10(%ebp)
  801276:	eb 23                	jmp    80129b <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  801278:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80127b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80127e:	7d 14                	jge    801294 <malloc+0x185>
  801280:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801283:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801286:	7c 0c                	jl     801294 <malloc+0x185>
							{
								min=count;
  801288:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80128b:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  80128e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801291:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801294:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80129b:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8012a2:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8012a9:	0f 86 77 ff ff ff    	jbe    801226 <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  8012af:	83 ec 08             	sub    $0x8,%esp
  8012b2:	ff 75 08             	pushl  0x8(%ebp)
  8012b5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8012b8:	e8 c6 02 00 00       	call   801583 <sys_allocateMem>
  8012bd:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  8012c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8012c3:	c9                   	leave  
  8012c4:	c3                   	ret    

008012c5 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8012c5:	55                   	push   %ebp
  8012c6:	89 e5                	mov    %esp,%ebp
  8012c8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8012cb:	83 ec 04             	sub    $0x4,%esp
  8012ce:	68 70 23 80 00       	push   $0x802370
  8012d3:	6a 7b                	push   $0x7b
  8012d5:	68 93 23 80 00       	push   $0x802393
  8012da:	e8 e2 07 00 00       	call   801ac1 <_panic>

008012df <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8012df:	55                   	push   %ebp
  8012e0:	89 e5                	mov    %esp,%ebp
  8012e2:	83 ec 18             	sub    $0x18,%esp
  8012e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e8:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8012eb:	83 ec 04             	sub    $0x4,%esp
  8012ee:	68 a0 23 80 00       	push   $0x8023a0
  8012f3:	68 88 00 00 00       	push   $0x88
  8012f8:	68 93 23 80 00       	push   $0x802393
  8012fd:	e8 bf 07 00 00       	call   801ac1 <_panic>

00801302 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
  801305:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801308:	83 ec 04             	sub    $0x4,%esp
  80130b:	68 a0 23 80 00       	push   $0x8023a0
  801310:	68 8e 00 00 00       	push   $0x8e
  801315:	68 93 23 80 00       	push   $0x802393
  80131a:	e8 a2 07 00 00       	call   801ac1 <_panic>

0080131f <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80131f:	55                   	push   %ebp
  801320:	89 e5                	mov    %esp,%ebp
  801322:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801325:	83 ec 04             	sub    $0x4,%esp
  801328:	68 a0 23 80 00       	push   $0x8023a0
  80132d:	68 94 00 00 00       	push   $0x94
  801332:	68 93 23 80 00       	push   $0x802393
  801337:	e8 85 07 00 00       	call   801ac1 <_panic>

0080133c <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80133c:	55                   	push   %ebp
  80133d:	89 e5                	mov    %esp,%ebp
  80133f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801342:	83 ec 04             	sub    $0x4,%esp
  801345:	68 a0 23 80 00       	push   $0x8023a0
  80134a:	68 99 00 00 00       	push   $0x99
  80134f:	68 93 23 80 00       	push   $0x802393
  801354:	e8 68 07 00 00       	call   801ac1 <_panic>

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
  801362:	68 a0 23 80 00       	push   $0x8023a0
  801367:	68 9f 00 00 00       	push   $0x9f
  80136c:	68 93 23 80 00       	push   $0x802393
  801371:	e8 4b 07 00 00       	call   801ac1 <_panic>

00801376 <shrink>:
}
void shrink(uint32 newSize)
{
  801376:	55                   	push   %ebp
  801377:	89 e5                	mov    %esp,%ebp
  801379:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80137c:	83 ec 04             	sub    $0x4,%esp
  80137f:	68 a0 23 80 00       	push   $0x8023a0
  801384:	68 a3 00 00 00       	push   $0xa3
  801389:	68 93 23 80 00       	push   $0x802393
  80138e:	e8 2e 07 00 00       	call   801ac1 <_panic>

00801393 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801393:	55                   	push   %ebp
  801394:	89 e5                	mov    %esp,%ebp
  801396:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801399:	83 ec 04             	sub    $0x4,%esp
  80139c:	68 a0 23 80 00       	push   $0x8023a0
  8013a1:	68 a8 00 00 00       	push   $0xa8
  8013a6:	68 93 23 80 00       	push   $0x802393
  8013ab:	e8 11 07 00 00       	call   801ac1 <_panic>

008013b0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8013b0:	55                   	push   %ebp
  8013b1:	89 e5                	mov    %esp,%ebp
  8013b3:	57                   	push   %edi
  8013b4:	56                   	push   %esi
  8013b5:	53                   	push   %ebx
  8013b6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013bf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013c2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013c5:	8b 7d 18             	mov    0x18(%ebp),%edi
  8013c8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8013cb:	cd 30                	int    $0x30
  8013cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8013d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8013d3:	83 c4 10             	add    $0x10,%esp
  8013d6:	5b                   	pop    %ebx
  8013d7:	5e                   	pop    %esi
  8013d8:	5f                   	pop    %edi
  8013d9:	5d                   	pop    %ebp
  8013da:	c3                   	ret    

008013db <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8013db:	55                   	push   %ebp
  8013dc:	89 e5                	mov    %esp,%ebp
  8013de:	83 ec 04             	sub    $0x4,%esp
  8013e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8013e7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8013eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	52                   	push   %edx
  8013f3:	ff 75 0c             	pushl  0xc(%ebp)
  8013f6:	50                   	push   %eax
  8013f7:	6a 00                	push   $0x0
  8013f9:	e8 b2 ff ff ff       	call   8013b0 <syscall>
  8013fe:	83 c4 18             	add    $0x18,%esp
}
  801401:	90                   	nop
  801402:	c9                   	leave  
  801403:	c3                   	ret    

00801404 <sys_cgetc>:

int
sys_cgetc(void)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	6a 01                	push   $0x1
  801413:	e8 98 ff ff ff       	call   8013b0 <syscall>
  801418:	83 c4 18             	add    $0x18,%esp
}
  80141b:	c9                   	leave  
  80141c:	c3                   	ret    

0080141d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80141d:	55                   	push   %ebp
  80141e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801420:	8b 45 08             	mov    0x8(%ebp),%eax
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	50                   	push   %eax
  80142c:	6a 05                	push   $0x5
  80142e:	e8 7d ff ff ff       	call   8013b0 <syscall>
  801433:	83 c4 18             	add    $0x18,%esp
}
  801436:	c9                   	leave  
  801437:	c3                   	ret    

00801438 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801438:	55                   	push   %ebp
  801439:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 02                	push   $0x2
  801447:	e8 64 ff ff ff       	call   8013b0 <syscall>
  80144c:	83 c4 18             	add    $0x18,%esp
}
  80144f:	c9                   	leave  
  801450:	c3                   	ret    

00801451 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801451:	55                   	push   %ebp
  801452:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801454:	6a 00                	push   $0x0
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 03                	push   $0x3
  801460:	e8 4b ff ff ff       	call   8013b0 <syscall>
  801465:	83 c4 18             	add    $0x18,%esp
}
  801468:	c9                   	leave  
  801469:	c3                   	ret    

0080146a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80146a:	55                   	push   %ebp
  80146b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 04                	push   $0x4
  801479:	e8 32 ff ff ff       	call   8013b0 <syscall>
  80147e:	83 c4 18             	add    $0x18,%esp
}
  801481:	c9                   	leave  
  801482:	c3                   	ret    

00801483 <sys_env_exit>:


void sys_env_exit(void)
{
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 06                	push   $0x6
  801492:	e8 19 ff ff ff       	call   8013b0 <syscall>
  801497:	83 c4 18             	add    $0x18,%esp
}
  80149a:	90                   	nop
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8014a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	52                   	push   %edx
  8014ad:	50                   	push   %eax
  8014ae:	6a 07                	push   $0x7
  8014b0:	e8 fb fe ff ff       	call   8013b0 <syscall>
  8014b5:	83 c4 18             	add    $0x18,%esp
}
  8014b8:	c9                   	leave  
  8014b9:	c3                   	ret    

008014ba <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8014ba:	55                   	push   %ebp
  8014bb:	89 e5                	mov    %esp,%ebp
  8014bd:	56                   	push   %esi
  8014be:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8014bf:	8b 75 18             	mov    0x18(%ebp),%esi
  8014c2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014c5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ce:	56                   	push   %esi
  8014cf:	53                   	push   %ebx
  8014d0:	51                   	push   %ecx
  8014d1:	52                   	push   %edx
  8014d2:	50                   	push   %eax
  8014d3:	6a 08                	push   $0x8
  8014d5:	e8 d6 fe ff ff       	call   8013b0 <syscall>
  8014da:	83 c4 18             	add    $0x18,%esp
}
  8014dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8014e0:	5b                   	pop    %ebx
  8014e1:	5e                   	pop    %esi
  8014e2:	5d                   	pop    %ebp
  8014e3:	c3                   	ret    

008014e4 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8014e4:	55                   	push   %ebp
  8014e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8014e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	52                   	push   %edx
  8014f4:	50                   	push   %eax
  8014f5:	6a 09                	push   $0x9
  8014f7:	e8 b4 fe ff ff       	call   8013b0 <syscall>
  8014fc:	83 c4 18             	add    $0x18,%esp
}
  8014ff:	c9                   	leave  
  801500:	c3                   	ret    

00801501 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801501:	55                   	push   %ebp
  801502:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	ff 75 0c             	pushl  0xc(%ebp)
  80150d:	ff 75 08             	pushl  0x8(%ebp)
  801510:	6a 0a                	push   $0xa
  801512:	e8 99 fe ff ff       	call   8013b0 <syscall>
  801517:	83 c4 18             	add    $0x18,%esp
}
  80151a:	c9                   	leave  
  80151b:	c3                   	ret    

0080151c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80151c:	55                   	push   %ebp
  80151d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80151f:	6a 00                	push   $0x0
  801521:	6a 00                	push   $0x0
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 0b                	push   $0xb
  80152b:	e8 80 fe ff ff       	call   8013b0 <syscall>
  801530:	83 c4 18             	add    $0x18,%esp
}
  801533:	c9                   	leave  
  801534:	c3                   	ret    

00801535 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801535:	55                   	push   %ebp
  801536:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	6a 0c                	push   $0xc
  801544:	e8 67 fe ff ff       	call   8013b0 <syscall>
  801549:	83 c4 18             	add    $0x18,%esp
}
  80154c:	c9                   	leave  
  80154d:	c3                   	ret    

0080154e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 0d                	push   $0xd
  80155d:	e8 4e fe ff ff       	call   8013b0 <syscall>
  801562:	83 c4 18             	add    $0x18,%esp
}
  801565:	c9                   	leave  
  801566:	c3                   	ret    

00801567 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801567:	55                   	push   %ebp
  801568:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	ff 75 0c             	pushl  0xc(%ebp)
  801573:	ff 75 08             	pushl  0x8(%ebp)
  801576:	6a 11                	push   $0x11
  801578:	e8 33 fe ff ff       	call   8013b0 <syscall>
  80157d:	83 c4 18             	add    $0x18,%esp
	return;
  801580:	90                   	nop
}
  801581:	c9                   	leave  
  801582:	c3                   	ret    

00801583 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801583:	55                   	push   %ebp
  801584:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	ff 75 0c             	pushl  0xc(%ebp)
  80158f:	ff 75 08             	pushl  0x8(%ebp)
  801592:	6a 12                	push   $0x12
  801594:	e8 17 fe ff ff       	call   8013b0 <syscall>
  801599:	83 c4 18             	add    $0x18,%esp
	return ;
  80159c:	90                   	nop
}
  80159d:	c9                   	leave  
  80159e:	c3                   	ret    

0080159f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80159f:	55                   	push   %ebp
  8015a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 0e                	push   $0xe
  8015ae:	e8 fd fd ff ff       	call   8013b0 <syscall>
  8015b3:	83 c4 18             	add    $0x18,%esp
}
  8015b6:	c9                   	leave  
  8015b7:	c3                   	ret    

008015b8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8015b8:	55                   	push   %ebp
  8015b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	ff 75 08             	pushl  0x8(%ebp)
  8015c6:	6a 0f                	push   $0xf
  8015c8:	e8 e3 fd ff ff       	call   8013b0 <syscall>
  8015cd:	83 c4 18             	add    $0x18,%esp
}
  8015d0:	c9                   	leave  
  8015d1:	c3                   	ret    

008015d2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8015d2:	55                   	push   %ebp
  8015d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 10                	push   $0x10
  8015e1:	e8 ca fd ff ff       	call   8013b0 <syscall>
  8015e6:	83 c4 18             	add    $0x18,%esp
}
  8015e9:	90                   	nop
  8015ea:	c9                   	leave  
  8015eb:	c3                   	ret    

008015ec <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8015ec:	55                   	push   %ebp
  8015ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 14                	push   $0x14
  8015fb:	e8 b0 fd ff ff       	call   8013b0 <syscall>
  801600:	83 c4 18             	add    $0x18,%esp
}
  801603:	90                   	nop
  801604:	c9                   	leave  
  801605:	c3                   	ret    

00801606 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801606:	55                   	push   %ebp
  801607:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 15                	push   $0x15
  801615:	e8 96 fd ff ff       	call   8013b0 <syscall>
  80161a:	83 c4 18             	add    $0x18,%esp
}
  80161d:	90                   	nop
  80161e:	c9                   	leave  
  80161f:	c3                   	ret    

00801620 <sys_cputc>:


void
sys_cputc(const char c)
{
  801620:	55                   	push   %ebp
  801621:	89 e5                	mov    %esp,%ebp
  801623:	83 ec 04             	sub    $0x4,%esp
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80162c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	50                   	push   %eax
  801639:	6a 16                	push   $0x16
  80163b:	e8 70 fd ff ff       	call   8013b0 <syscall>
  801640:	83 c4 18             	add    $0x18,%esp
}
  801643:	90                   	nop
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 17                	push   $0x17
  801655:	e8 56 fd ff ff       	call   8013b0 <syscall>
  80165a:	83 c4 18             	add    $0x18,%esp
}
  80165d:	90                   	nop
  80165e:	c9                   	leave  
  80165f:	c3                   	ret    

00801660 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801660:	55                   	push   %ebp
  801661:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	ff 75 0c             	pushl  0xc(%ebp)
  80166f:	50                   	push   %eax
  801670:	6a 18                	push   $0x18
  801672:	e8 39 fd ff ff       	call   8013b0 <syscall>
  801677:	83 c4 18             	add    $0x18,%esp
}
  80167a:	c9                   	leave  
  80167b:	c3                   	ret    

0080167c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80167c:	55                   	push   %ebp
  80167d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80167f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801682:	8b 45 08             	mov    0x8(%ebp),%eax
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	52                   	push   %edx
  80168c:	50                   	push   %eax
  80168d:	6a 1b                	push   $0x1b
  80168f:	e8 1c fd ff ff       	call   8013b0 <syscall>
  801694:	83 c4 18             	add    $0x18,%esp
}
  801697:	c9                   	leave  
  801698:	c3                   	ret    

00801699 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801699:	55                   	push   %ebp
  80169a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80169c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80169f:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	52                   	push   %edx
  8016a9:	50                   	push   %eax
  8016aa:	6a 19                	push   $0x19
  8016ac:	e8 ff fc ff ff       	call   8013b0 <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
}
  8016b4:	90                   	nop
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	52                   	push   %edx
  8016c7:	50                   	push   %eax
  8016c8:	6a 1a                	push   $0x1a
  8016ca:	e8 e1 fc ff ff       	call   8013b0 <syscall>
  8016cf:	83 c4 18             	add    $0x18,%esp
}
  8016d2:	90                   	nop
  8016d3:	c9                   	leave  
  8016d4:	c3                   	ret    

008016d5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
  8016d8:	83 ec 04             	sub    $0x4,%esp
  8016db:	8b 45 10             	mov    0x10(%ebp),%eax
  8016de:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8016e1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016e4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016eb:	6a 00                	push   $0x0
  8016ed:	51                   	push   %ecx
  8016ee:	52                   	push   %edx
  8016ef:	ff 75 0c             	pushl  0xc(%ebp)
  8016f2:	50                   	push   %eax
  8016f3:	6a 1c                	push   $0x1c
  8016f5:	e8 b6 fc ff ff       	call   8013b0 <syscall>
  8016fa:	83 c4 18             	add    $0x18,%esp
}
  8016fd:	c9                   	leave  
  8016fe:	c3                   	ret    

008016ff <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801702:	8b 55 0c             	mov    0xc(%ebp),%edx
  801705:	8b 45 08             	mov    0x8(%ebp),%eax
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	52                   	push   %edx
  80170f:	50                   	push   %eax
  801710:	6a 1d                	push   $0x1d
  801712:	e8 99 fc ff ff       	call   8013b0 <syscall>
  801717:	83 c4 18             	add    $0x18,%esp
}
  80171a:	c9                   	leave  
  80171b:	c3                   	ret    

0080171c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80171c:	55                   	push   %ebp
  80171d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80171f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801722:	8b 55 0c             	mov    0xc(%ebp),%edx
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	51                   	push   %ecx
  80172d:	52                   	push   %edx
  80172e:	50                   	push   %eax
  80172f:	6a 1e                	push   $0x1e
  801731:	e8 7a fc ff ff       	call   8013b0 <syscall>
  801736:	83 c4 18             	add    $0x18,%esp
}
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80173e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801741:	8b 45 08             	mov    0x8(%ebp),%eax
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	52                   	push   %edx
  80174b:	50                   	push   %eax
  80174c:	6a 1f                	push   $0x1f
  80174e:	e8 5d fc ff ff       	call   8013b0 <syscall>
  801753:	83 c4 18             	add    $0x18,%esp
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 20                	push   $0x20
  801767:	e8 44 fc ff ff       	call   8013b0 <syscall>
  80176c:	83 c4 18             	add    $0x18,%esp
}
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801774:	8b 45 08             	mov    0x8(%ebp),%eax
  801777:	6a 00                	push   $0x0
  801779:	ff 75 14             	pushl  0x14(%ebp)
  80177c:	ff 75 10             	pushl  0x10(%ebp)
  80177f:	ff 75 0c             	pushl  0xc(%ebp)
  801782:	50                   	push   %eax
  801783:	6a 21                	push   $0x21
  801785:	e8 26 fc ff ff       	call   8013b0 <syscall>
  80178a:	83 c4 18             	add    $0x18,%esp
}
  80178d:	c9                   	leave  
  80178e:	c3                   	ret    

0080178f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80178f:	55                   	push   %ebp
  801790:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801792:	8b 45 08             	mov    0x8(%ebp),%eax
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	50                   	push   %eax
  80179e:	6a 22                	push   $0x22
  8017a0:	e8 0b fc ff ff       	call   8013b0 <syscall>
  8017a5:	83 c4 18             	add    $0x18,%esp
}
  8017a8:	90                   	nop
  8017a9:	c9                   	leave  
  8017aa:	c3                   	ret    

008017ab <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8017ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	50                   	push   %eax
  8017ba:	6a 23                	push   $0x23
  8017bc:	e8 ef fb ff ff       	call   8013b0 <syscall>
  8017c1:	83 c4 18             	add    $0x18,%esp
}
  8017c4:	90                   	nop
  8017c5:	c9                   	leave  
  8017c6:	c3                   	ret    

008017c7 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8017c7:	55                   	push   %ebp
  8017c8:	89 e5                	mov    %esp,%ebp
  8017ca:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8017cd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8017d0:	8d 50 04             	lea    0x4(%eax),%edx
  8017d3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	52                   	push   %edx
  8017dd:	50                   	push   %eax
  8017de:	6a 24                	push   $0x24
  8017e0:	e8 cb fb ff ff       	call   8013b0 <syscall>
  8017e5:	83 c4 18             	add    $0x18,%esp
	return result;
  8017e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017f1:	89 01                	mov    %eax,(%ecx)
  8017f3:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8017f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f9:	c9                   	leave  
  8017fa:	c2 04 00             	ret    $0x4

008017fd <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	ff 75 10             	pushl  0x10(%ebp)
  801807:	ff 75 0c             	pushl  0xc(%ebp)
  80180a:	ff 75 08             	pushl  0x8(%ebp)
  80180d:	6a 13                	push   $0x13
  80180f:	e8 9c fb ff ff       	call   8013b0 <syscall>
  801814:	83 c4 18             	add    $0x18,%esp
	return ;
  801817:	90                   	nop
}
  801818:	c9                   	leave  
  801819:	c3                   	ret    

0080181a <sys_rcr2>:
uint32 sys_rcr2()
{
  80181a:	55                   	push   %ebp
  80181b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 25                	push   $0x25
  801829:	e8 82 fb ff ff       	call   8013b0 <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
  801836:	83 ec 04             	sub    $0x4,%esp
  801839:	8b 45 08             	mov    0x8(%ebp),%eax
  80183c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80183f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	50                   	push   %eax
  80184c:	6a 26                	push   $0x26
  80184e:	e8 5d fb ff ff       	call   8013b0 <syscall>
  801853:	83 c4 18             	add    $0x18,%esp
	return ;
  801856:	90                   	nop
}
  801857:	c9                   	leave  
  801858:	c3                   	ret    

00801859 <rsttst>:
void rsttst()
{
  801859:	55                   	push   %ebp
  80185a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 28                	push   $0x28
  801868:	e8 43 fb ff ff       	call   8013b0 <syscall>
  80186d:	83 c4 18             	add    $0x18,%esp
	return ;
  801870:	90                   	nop
}
  801871:	c9                   	leave  
  801872:	c3                   	ret    

00801873 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
  801876:	83 ec 04             	sub    $0x4,%esp
  801879:	8b 45 14             	mov    0x14(%ebp),%eax
  80187c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80187f:	8b 55 18             	mov    0x18(%ebp),%edx
  801882:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801886:	52                   	push   %edx
  801887:	50                   	push   %eax
  801888:	ff 75 10             	pushl  0x10(%ebp)
  80188b:	ff 75 0c             	pushl  0xc(%ebp)
  80188e:	ff 75 08             	pushl  0x8(%ebp)
  801891:	6a 27                	push   $0x27
  801893:	e8 18 fb ff ff       	call   8013b0 <syscall>
  801898:	83 c4 18             	add    $0x18,%esp
	return ;
  80189b:	90                   	nop
}
  80189c:	c9                   	leave  
  80189d:	c3                   	ret    

0080189e <chktst>:
void chktst(uint32 n)
{
  80189e:	55                   	push   %ebp
  80189f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	ff 75 08             	pushl  0x8(%ebp)
  8018ac:	6a 29                	push   $0x29
  8018ae:	e8 fd fa ff ff       	call   8013b0 <syscall>
  8018b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8018b6:	90                   	nop
}
  8018b7:	c9                   	leave  
  8018b8:	c3                   	ret    

008018b9 <inctst>:

void inctst()
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 2a                	push   $0x2a
  8018c8:	e8 e3 fa ff ff       	call   8013b0 <syscall>
  8018cd:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d0:	90                   	nop
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <gettst>:
uint32 gettst()
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 2b                	push   $0x2b
  8018e2:	e8 c9 fa ff ff       	call   8013b0 <syscall>
  8018e7:	83 c4 18             	add    $0x18,%esp
}
  8018ea:	c9                   	leave  
  8018eb:	c3                   	ret    

008018ec <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8018ec:	55                   	push   %ebp
  8018ed:	89 e5                	mov    %esp,%ebp
  8018ef:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 2c                	push   $0x2c
  8018fe:	e8 ad fa ff ff       	call   8013b0 <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
  801906:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801909:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80190d:	75 07                	jne    801916 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80190f:	b8 01 00 00 00       	mov    $0x1,%eax
  801914:	eb 05                	jmp    80191b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801916:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80191b:	c9                   	leave  
  80191c:	c3                   	ret    

0080191d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80191d:	55                   	push   %ebp
  80191e:	89 e5                	mov    %esp,%ebp
  801920:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 2c                	push   $0x2c
  80192f:	e8 7c fa ff ff       	call   8013b0 <syscall>
  801934:	83 c4 18             	add    $0x18,%esp
  801937:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80193a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80193e:	75 07                	jne    801947 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801940:	b8 01 00 00 00       	mov    $0x1,%eax
  801945:	eb 05                	jmp    80194c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801947:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80194c:	c9                   	leave  
  80194d:	c3                   	ret    

0080194e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80194e:	55                   	push   %ebp
  80194f:	89 e5                	mov    %esp,%ebp
  801951:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 2c                	push   $0x2c
  801960:	e8 4b fa ff ff       	call   8013b0 <syscall>
  801965:	83 c4 18             	add    $0x18,%esp
  801968:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80196b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80196f:	75 07                	jne    801978 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801971:	b8 01 00 00 00       	mov    $0x1,%eax
  801976:	eb 05                	jmp    80197d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801978:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
  801982:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 2c                	push   $0x2c
  801991:	e8 1a fa ff ff       	call   8013b0 <syscall>
  801996:	83 c4 18             	add    $0x18,%esp
  801999:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80199c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8019a0:	75 07                	jne    8019a9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8019a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8019a7:	eb 05                	jmp    8019ae <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8019a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019ae:	c9                   	leave  
  8019af:	c3                   	ret    

008019b0 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8019b0:	55                   	push   %ebp
  8019b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	ff 75 08             	pushl  0x8(%ebp)
  8019be:	6a 2d                	push   $0x2d
  8019c0:	e8 eb f9 ff ff       	call   8013b0 <syscall>
  8019c5:	83 c4 18             	add    $0x18,%esp
	return ;
  8019c8:	90                   	nop
}
  8019c9:	c9                   	leave  
  8019ca:	c3                   	ret    

008019cb <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8019cb:	55                   	push   %ebp
  8019cc:	89 e5                	mov    %esp,%ebp
  8019ce:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8019cf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019d2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019db:	6a 00                	push   $0x0
  8019dd:	53                   	push   %ebx
  8019de:	51                   	push   %ecx
  8019df:	52                   	push   %edx
  8019e0:	50                   	push   %eax
  8019e1:	6a 2e                	push   $0x2e
  8019e3:	e8 c8 f9 ff ff       	call   8013b0 <syscall>
  8019e8:	83 c4 18             	add    $0x18,%esp
}
  8019eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8019ee:	c9                   	leave  
  8019ef:	c3                   	ret    

008019f0 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8019f0:	55                   	push   %ebp
  8019f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8019f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	52                   	push   %edx
  801a00:	50                   	push   %eax
  801a01:	6a 2f                	push   $0x2f
  801a03:	e8 a8 f9 ff ff       	call   8013b0 <syscall>
  801a08:	83 c4 18             	add    $0x18,%esp
}
  801a0b:	c9                   	leave  
  801a0c:	c3                   	ret    

00801a0d <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
  801a10:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801a13:	8b 55 08             	mov    0x8(%ebp),%edx
  801a16:	89 d0                	mov    %edx,%eax
  801a18:	c1 e0 02             	shl    $0x2,%eax
  801a1b:	01 d0                	add    %edx,%eax
  801a1d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a24:	01 d0                	add    %edx,%eax
  801a26:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a2d:	01 d0                	add    %edx,%eax
  801a2f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a36:	01 d0                	add    %edx,%eax
  801a38:	c1 e0 04             	shl    $0x4,%eax
  801a3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801a3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801a45:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801a48:	83 ec 0c             	sub    $0xc,%esp
  801a4b:	50                   	push   %eax
  801a4c:	e8 76 fd ff ff       	call   8017c7 <sys_get_virtual_time>
  801a51:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801a54:	eb 41                	jmp    801a97 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801a56:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801a59:	83 ec 0c             	sub    $0xc,%esp
  801a5c:	50                   	push   %eax
  801a5d:	e8 65 fd ff ff       	call   8017c7 <sys_get_virtual_time>
  801a62:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801a65:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a68:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a6b:	29 c2                	sub    %eax,%edx
  801a6d:	89 d0                	mov    %edx,%eax
  801a6f:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801a72:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a75:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a78:	89 d1                	mov    %edx,%ecx
  801a7a:	29 c1                	sub    %eax,%ecx
  801a7c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a7f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a82:	39 c2                	cmp    %eax,%edx
  801a84:	0f 97 c0             	seta   %al
  801a87:	0f b6 c0             	movzbl %al,%eax
  801a8a:	29 c1                	sub    %eax,%ecx
  801a8c:	89 c8                	mov    %ecx,%eax
  801a8e:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801a91:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a94:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a97:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a9a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a9d:	72 b7                	jb     801a56 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a9f:	90                   	nop
  801aa0:	c9                   	leave  
  801aa1:	c3                   	ret    

00801aa2 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801aa2:	55                   	push   %ebp
  801aa3:	89 e5                	mov    %esp,%ebp
  801aa5:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801aa8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801aaf:	eb 03                	jmp    801ab4 <busy_wait+0x12>
  801ab1:	ff 45 fc             	incl   -0x4(%ebp)
  801ab4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ab7:	3b 45 08             	cmp    0x8(%ebp),%eax
  801aba:	72 f5                	jb     801ab1 <busy_wait+0xf>
	return i;
  801abc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801abf:	c9                   	leave  
  801ac0:	c3                   	ret    

00801ac1 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801ac1:	55                   	push   %ebp
  801ac2:	89 e5                	mov    %esp,%ebp
  801ac4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801ac7:	8d 45 10             	lea    0x10(%ebp),%eax
  801aca:	83 c0 04             	add    $0x4,%eax
  801acd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801ad0:	a1 50 34 80 00       	mov    0x803450,%eax
  801ad5:	85 c0                	test   %eax,%eax
  801ad7:	74 16                	je     801aef <_panic+0x2e>
		cprintf("%s: ", argv0);
  801ad9:	a1 50 34 80 00       	mov    0x803450,%eax
  801ade:	83 ec 08             	sub    $0x8,%esp
  801ae1:	50                   	push   %eax
  801ae2:	68 c4 23 80 00       	push   $0x8023c4
  801ae7:	e8 99 e8 ff ff       	call   800385 <cprintf>
  801aec:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801aef:	a1 00 30 80 00       	mov    0x803000,%eax
  801af4:	ff 75 0c             	pushl  0xc(%ebp)
  801af7:	ff 75 08             	pushl  0x8(%ebp)
  801afa:	50                   	push   %eax
  801afb:	68 c9 23 80 00       	push   $0x8023c9
  801b00:	e8 80 e8 ff ff       	call   800385 <cprintf>
  801b05:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801b08:	8b 45 10             	mov    0x10(%ebp),%eax
  801b0b:	83 ec 08             	sub    $0x8,%esp
  801b0e:	ff 75 f4             	pushl  -0xc(%ebp)
  801b11:	50                   	push   %eax
  801b12:	e8 03 e8 ff ff       	call   80031a <vcprintf>
  801b17:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801b1a:	83 ec 08             	sub    $0x8,%esp
  801b1d:	6a 00                	push   $0x0
  801b1f:	68 e5 23 80 00       	push   $0x8023e5
  801b24:	e8 f1 e7 ff ff       	call   80031a <vcprintf>
  801b29:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801b2c:	e8 72 e7 ff ff       	call   8002a3 <exit>

	// should not return here
	while (1) ;
  801b31:	eb fe                	jmp    801b31 <_panic+0x70>

00801b33 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801b33:	55                   	push   %ebp
  801b34:	89 e5                	mov    %esp,%ebp
  801b36:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801b39:	a1 20 30 80 00       	mov    0x803020,%eax
  801b3e:	8b 50 74             	mov    0x74(%eax),%edx
  801b41:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b44:	39 c2                	cmp    %eax,%edx
  801b46:	74 14                	je     801b5c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801b48:	83 ec 04             	sub    $0x4,%esp
  801b4b:	68 e8 23 80 00       	push   $0x8023e8
  801b50:	6a 26                	push   $0x26
  801b52:	68 34 24 80 00       	push   $0x802434
  801b57:	e8 65 ff ff ff       	call   801ac1 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801b5c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801b63:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b6a:	e9 b6 00 00 00       	jmp    801c25 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801b6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b72:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b79:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7c:	01 d0                	add    %edx,%eax
  801b7e:	8b 00                	mov    (%eax),%eax
  801b80:	85 c0                	test   %eax,%eax
  801b82:	75 08                	jne    801b8c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801b84:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801b87:	e9 96 00 00 00       	jmp    801c22 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801b8c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b93:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801b9a:	eb 5d                	jmp    801bf9 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801b9c:	a1 20 30 80 00       	mov    0x803020,%eax
  801ba1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801ba7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801baa:	c1 e2 04             	shl    $0x4,%edx
  801bad:	01 d0                	add    %edx,%eax
  801baf:	8a 40 04             	mov    0x4(%eax),%al
  801bb2:	84 c0                	test   %al,%al
  801bb4:	75 40                	jne    801bf6 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801bb6:	a1 20 30 80 00       	mov    0x803020,%eax
  801bbb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801bc1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801bc4:	c1 e2 04             	shl    $0x4,%edx
  801bc7:	01 d0                	add    %edx,%eax
  801bc9:	8b 00                	mov    (%eax),%eax
  801bcb:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801bce:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801bd1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801bd6:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bdb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801be2:	8b 45 08             	mov    0x8(%ebp),%eax
  801be5:	01 c8                	add    %ecx,%eax
  801be7:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801be9:	39 c2                	cmp    %eax,%edx
  801beb:	75 09                	jne    801bf6 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801bed:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801bf4:	eb 12                	jmp    801c08 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bf6:	ff 45 e8             	incl   -0x18(%ebp)
  801bf9:	a1 20 30 80 00       	mov    0x803020,%eax
  801bfe:	8b 50 74             	mov    0x74(%eax),%edx
  801c01:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c04:	39 c2                	cmp    %eax,%edx
  801c06:	77 94                	ja     801b9c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801c08:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801c0c:	75 14                	jne    801c22 <CheckWSWithoutLastIndex+0xef>
			panic(
  801c0e:	83 ec 04             	sub    $0x4,%esp
  801c11:	68 40 24 80 00       	push   $0x802440
  801c16:	6a 3a                	push   $0x3a
  801c18:	68 34 24 80 00       	push   $0x802434
  801c1d:	e8 9f fe ff ff       	call   801ac1 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801c22:	ff 45 f0             	incl   -0x10(%ebp)
  801c25:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c28:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801c2b:	0f 8c 3e ff ff ff    	jl     801b6f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801c31:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c38:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801c3f:	eb 20                	jmp    801c61 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801c41:	a1 20 30 80 00       	mov    0x803020,%eax
  801c46:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801c4c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c4f:	c1 e2 04             	shl    $0x4,%edx
  801c52:	01 d0                	add    %edx,%eax
  801c54:	8a 40 04             	mov    0x4(%eax),%al
  801c57:	3c 01                	cmp    $0x1,%al
  801c59:	75 03                	jne    801c5e <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801c5b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c5e:	ff 45 e0             	incl   -0x20(%ebp)
  801c61:	a1 20 30 80 00       	mov    0x803020,%eax
  801c66:	8b 50 74             	mov    0x74(%eax),%edx
  801c69:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c6c:	39 c2                	cmp    %eax,%edx
  801c6e:	77 d1                	ja     801c41 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801c70:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c73:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801c76:	74 14                	je     801c8c <CheckWSWithoutLastIndex+0x159>
		panic(
  801c78:	83 ec 04             	sub    $0x4,%esp
  801c7b:	68 94 24 80 00       	push   $0x802494
  801c80:	6a 44                	push   $0x44
  801c82:	68 34 24 80 00       	push   $0x802434
  801c87:	e8 35 fe ff ff       	call   801ac1 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801c8c:	90                   	nop
  801c8d:	c9                   	leave  
  801c8e:	c3                   	ret    
  801c8f:	90                   	nop

00801c90 <__udivdi3>:
  801c90:	55                   	push   %ebp
  801c91:	57                   	push   %edi
  801c92:	56                   	push   %esi
  801c93:	53                   	push   %ebx
  801c94:	83 ec 1c             	sub    $0x1c,%esp
  801c97:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c9b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c9f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ca3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ca7:	89 ca                	mov    %ecx,%edx
  801ca9:	89 f8                	mov    %edi,%eax
  801cab:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801caf:	85 f6                	test   %esi,%esi
  801cb1:	75 2d                	jne    801ce0 <__udivdi3+0x50>
  801cb3:	39 cf                	cmp    %ecx,%edi
  801cb5:	77 65                	ja     801d1c <__udivdi3+0x8c>
  801cb7:	89 fd                	mov    %edi,%ebp
  801cb9:	85 ff                	test   %edi,%edi
  801cbb:	75 0b                	jne    801cc8 <__udivdi3+0x38>
  801cbd:	b8 01 00 00 00       	mov    $0x1,%eax
  801cc2:	31 d2                	xor    %edx,%edx
  801cc4:	f7 f7                	div    %edi
  801cc6:	89 c5                	mov    %eax,%ebp
  801cc8:	31 d2                	xor    %edx,%edx
  801cca:	89 c8                	mov    %ecx,%eax
  801ccc:	f7 f5                	div    %ebp
  801cce:	89 c1                	mov    %eax,%ecx
  801cd0:	89 d8                	mov    %ebx,%eax
  801cd2:	f7 f5                	div    %ebp
  801cd4:	89 cf                	mov    %ecx,%edi
  801cd6:	89 fa                	mov    %edi,%edx
  801cd8:	83 c4 1c             	add    $0x1c,%esp
  801cdb:	5b                   	pop    %ebx
  801cdc:	5e                   	pop    %esi
  801cdd:	5f                   	pop    %edi
  801cde:	5d                   	pop    %ebp
  801cdf:	c3                   	ret    
  801ce0:	39 ce                	cmp    %ecx,%esi
  801ce2:	77 28                	ja     801d0c <__udivdi3+0x7c>
  801ce4:	0f bd fe             	bsr    %esi,%edi
  801ce7:	83 f7 1f             	xor    $0x1f,%edi
  801cea:	75 40                	jne    801d2c <__udivdi3+0x9c>
  801cec:	39 ce                	cmp    %ecx,%esi
  801cee:	72 0a                	jb     801cfa <__udivdi3+0x6a>
  801cf0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801cf4:	0f 87 9e 00 00 00    	ja     801d98 <__udivdi3+0x108>
  801cfa:	b8 01 00 00 00       	mov    $0x1,%eax
  801cff:	89 fa                	mov    %edi,%edx
  801d01:	83 c4 1c             	add    $0x1c,%esp
  801d04:	5b                   	pop    %ebx
  801d05:	5e                   	pop    %esi
  801d06:	5f                   	pop    %edi
  801d07:	5d                   	pop    %ebp
  801d08:	c3                   	ret    
  801d09:	8d 76 00             	lea    0x0(%esi),%esi
  801d0c:	31 ff                	xor    %edi,%edi
  801d0e:	31 c0                	xor    %eax,%eax
  801d10:	89 fa                	mov    %edi,%edx
  801d12:	83 c4 1c             	add    $0x1c,%esp
  801d15:	5b                   	pop    %ebx
  801d16:	5e                   	pop    %esi
  801d17:	5f                   	pop    %edi
  801d18:	5d                   	pop    %ebp
  801d19:	c3                   	ret    
  801d1a:	66 90                	xchg   %ax,%ax
  801d1c:	89 d8                	mov    %ebx,%eax
  801d1e:	f7 f7                	div    %edi
  801d20:	31 ff                	xor    %edi,%edi
  801d22:	89 fa                	mov    %edi,%edx
  801d24:	83 c4 1c             	add    $0x1c,%esp
  801d27:	5b                   	pop    %ebx
  801d28:	5e                   	pop    %esi
  801d29:	5f                   	pop    %edi
  801d2a:	5d                   	pop    %ebp
  801d2b:	c3                   	ret    
  801d2c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d31:	89 eb                	mov    %ebp,%ebx
  801d33:	29 fb                	sub    %edi,%ebx
  801d35:	89 f9                	mov    %edi,%ecx
  801d37:	d3 e6                	shl    %cl,%esi
  801d39:	89 c5                	mov    %eax,%ebp
  801d3b:	88 d9                	mov    %bl,%cl
  801d3d:	d3 ed                	shr    %cl,%ebp
  801d3f:	89 e9                	mov    %ebp,%ecx
  801d41:	09 f1                	or     %esi,%ecx
  801d43:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d47:	89 f9                	mov    %edi,%ecx
  801d49:	d3 e0                	shl    %cl,%eax
  801d4b:	89 c5                	mov    %eax,%ebp
  801d4d:	89 d6                	mov    %edx,%esi
  801d4f:	88 d9                	mov    %bl,%cl
  801d51:	d3 ee                	shr    %cl,%esi
  801d53:	89 f9                	mov    %edi,%ecx
  801d55:	d3 e2                	shl    %cl,%edx
  801d57:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d5b:	88 d9                	mov    %bl,%cl
  801d5d:	d3 e8                	shr    %cl,%eax
  801d5f:	09 c2                	or     %eax,%edx
  801d61:	89 d0                	mov    %edx,%eax
  801d63:	89 f2                	mov    %esi,%edx
  801d65:	f7 74 24 0c          	divl   0xc(%esp)
  801d69:	89 d6                	mov    %edx,%esi
  801d6b:	89 c3                	mov    %eax,%ebx
  801d6d:	f7 e5                	mul    %ebp
  801d6f:	39 d6                	cmp    %edx,%esi
  801d71:	72 19                	jb     801d8c <__udivdi3+0xfc>
  801d73:	74 0b                	je     801d80 <__udivdi3+0xf0>
  801d75:	89 d8                	mov    %ebx,%eax
  801d77:	31 ff                	xor    %edi,%edi
  801d79:	e9 58 ff ff ff       	jmp    801cd6 <__udivdi3+0x46>
  801d7e:	66 90                	xchg   %ax,%ax
  801d80:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d84:	89 f9                	mov    %edi,%ecx
  801d86:	d3 e2                	shl    %cl,%edx
  801d88:	39 c2                	cmp    %eax,%edx
  801d8a:	73 e9                	jae    801d75 <__udivdi3+0xe5>
  801d8c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d8f:	31 ff                	xor    %edi,%edi
  801d91:	e9 40 ff ff ff       	jmp    801cd6 <__udivdi3+0x46>
  801d96:	66 90                	xchg   %ax,%ax
  801d98:	31 c0                	xor    %eax,%eax
  801d9a:	e9 37 ff ff ff       	jmp    801cd6 <__udivdi3+0x46>
  801d9f:	90                   	nop

00801da0 <__umoddi3>:
  801da0:	55                   	push   %ebp
  801da1:	57                   	push   %edi
  801da2:	56                   	push   %esi
  801da3:	53                   	push   %ebx
  801da4:	83 ec 1c             	sub    $0x1c,%esp
  801da7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801dab:	8b 74 24 34          	mov    0x34(%esp),%esi
  801daf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801db3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801db7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801dbb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801dbf:	89 f3                	mov    %esi,%ebx
  801dc1:	89 fa                	mov    %edi,%edx
  801dc3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801dc7:	89 34 24             	mov    %esi,(%esp)
  801dca:	85 c0                	test   %eax,%eax
  801dcc:	75 1a                	jne    801de8 <__umoddi3+0x48>
  801dce:	39 f7                	cmp    %esi,%edi
  801dd0:	0f 86 a2 00 00 00    	jbe    801e78 <__umoddi3+0xd8>
  801dd6:	89 c8                	mov    %ecx,%eax
  801dd8:	89 f2                	mov    %esi,%edx
  801dda:	f7 f7                	div    %edi
  801ddc:	89 d0                	mov    %edx,%eax
  801dde:	31 d2                	xor    %edx,%edx
  801de0:	83 c4 1c             	add    $0x1c,%esp
  801de3:	5b                   	pop    %ebx
  801de4:	5e                   	pop    %esi
  801de5:	5f                   	pop    %edi
  801de6:	5d                   	pop    %ebp
  801de7:	c3                   	ret    
  801de8:	39 f0                	cmp    %esi,%eax
  801dea:	0f 87 ac 00 00 00    	ja     801e9c <__umoddi3+0xfc>
  801df0:	0f bd e8             	bsr    %eax,%ebp
  801df3:	83 f5 1f             	xor    $0x1f,%ebp
  801df6:	0f 84 ac 00 00 00    	je     801ea8 <__umoddi3+0x108>
  801dfc:	bf 20 00 00 00       	mov    $0x20,%edi
  801e01:	29 ef                	sub    %ebp,%edi
  801e03:	89 fe                	mov    %edi,%esi
  801e05:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e09:	89 e9                	mov    %ebp,%ecx
  801e0b:	d3 e0                	shl    %cl,%eax
  801e0d:	89 d7                	mov    %edx,%edi
  801e0f:	89 f1                	mov    %esi,%ecx
  801e11:	d3 ef                	shr    %cl,%edi
  801e13:	09 c7                	or     %eax,%edi
  801e15:	89 e9                	mov    %ebp,%ecx
  801e17:	d3 e2                	shl    %cl,%edx
  801e19:	89 14 24             	mov    %edx,(%esp)
  801e1c:	89 d8                	mov    %ebx,%eax
  801e1e:	d3 e0                	shl    %cl,%eax
  801e20:	89 c2                	mov    %eax,%edx
  801e22:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e26:	d3 e0                	shl    %cl,%eax
  801e28:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e2c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e30:	89 f1                	mov    %esi,%ecx
  801e32:	d3 e8                	shr    %cl,%eax
  801e34:	09 d0                	or     %edx,%eax
  801e36:	d3 eb                	shr    %cl,%ebx
  801e38:	89 da                	mov    %ebx,%edx
  801e3a:	f7 f7                	div    %edi
  801e3c:	89 d3                	mov    %edx,%ebx
  801e3e:	f7 24 24             	mull   (%esp)
  801e41:	89 c6                	mov    %eax,%esi
  801e43:	89 d1                	mov    %edx,%ecx
  801e45:	39 d3                	cmp    %edx,%ebx
  801e47:	0f 82 87 00 00 00    	jb     801ed4 <__umoddi3+0x134>
  801e4d:	0f 84 91 00 00 00    	je     801ee4 <__umoddi3+0x144>
  801e53:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e57:	29 f2                	sub    %esi,%edx
  801e59:	19 cb                	sbb    %ecx,%ebx
  801e5b:	89 d8                	mov    %ebx,%eax
  801e5d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e61:	d3 e0                	shl    %cl,%eax
  801e63:	89 e9                	mov    %ebp,%ecx
  801e65:	d3 ea                	shr    %cl,%edx
  801e67:	09 d0                	or     %edx,%eax
  801e69:	89 e9                	mov    %ebp,%ecx
  801e6b:	d3 eb                	shr    %cl,%ebx
  801e6d:	89 da                	mov    %ebx,%edx
  801e6f:	83 c4 1c             	add    $0x1c,%esp
  801e72:	5b                   	pop    %ebx
  801e73:	5e                   	pop    %esi
  801e74:	5f                   	pop    %edi
  801e75:	5d                   	pop    %ebp
  801e76:	c3                   	ret    
  801e77:	90                   	nop
  801e78:	89 fd                	mov    %edi,%ebp
  801e7a:	85 ff                	test   %edi,%edi
  801e7c:	75 0b                	jne    801e89 <__umoddi3+0xe9>
  801e7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e83:	31 d2                	xor    %edx,%edx
  801e85:	f7 f7                	div    %edi
  801e87:	89 c5                	mov    %eax,%ebp
  801e89:	89 f0                	mov    %esi,%eax
  801e8b:	31 d2                	xor    %edx,%edx
  801e8d:	f7 f5                	div    %ebp
  801e8f:	89 c8                	mov    %ecx,%eax
  801e91:	f7 f5                	div    %ebp
  801e93:	89 d0                	mov    %edx,%eax
  801e95:	e9 44 ff ff ff       	jmp    801dde <__umoddi3+0x3e>
  801e9a:	66 90                	xchg   %ax,%ax
  801e9c:	89 c8                	mov    %ecx,%eax
  801e9e:	89 f2                	mov    %esi,%edx
  801ea0:	83 c4 1c             	add    $0x1c,%esp
  801ea3:	5b                   	pop    %ebx
  801ea4:	5e                   	pop    %esi
  801ea5:	5f                   	pop    %edi
  801ea6:	5d                   	pop    %ebp
  801ea7:	c3                   	ret    
  801ea8:	3b 04 24             	cmp    (%esp),%eax
  801eab:	72 06                	jb     801eb3 <__umoddi3+0x113>
  801ead:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801eb1:	77 0f                	ja     801ec2 <__umoddi3+0x122>
  801eb3:	89 f2                	mov    %esi,%edx
  801eb5:	29 f9                	sub    %edi,%ecx
  801eb7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ebb:	89 14 24             	mov    %edx,(%esp)
  801ebe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ec2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ec6:	8b 14 24             	mov    (%esp),%edx
  801ec9:	83 c4 1c             	add    $0x1c,%esp
  801ecc:	5b                   	pop    %ebx
  801ecd:	5e                   	pop    %esi
  801ece:	5f                   	pop    %edi
  801ecf:	5d                   	pop    %ebp
  801ed0:	c3                   	ret    
  801ed1:	8d 76 00             	lea    0x0(%esi),%esi
  801ed4:	2b 04 24             	sub    (%esp),%eax
  801ed7:	19 fa                	sbb    %edi,%edx
  801ed9:	89 d1                	mov    %edx,%ecx
  801edb:	89 c6                	mov    %eax,%esi
  801edd:	e9 71 ff ff ff       	jmp    801e53 <__umoddi3+0xb3>
  801ee2:	66 90                	xchg   %ax,%ax
  801ee4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ee8:	72 ea                	jb     801ed4 <__umoddi3+0x134>
  801eea:	89 d9                	mov    %ebx,%ecx
  801eec:	e9 62 ff ff ff       	jmp    801e53 <__umoddi3+0xb3>

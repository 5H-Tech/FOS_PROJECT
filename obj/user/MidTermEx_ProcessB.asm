
obj/user/MidTermEx_ProcessB:     file format elf32-i386


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
  800031:	e8 35 01 00 00       	call   80016b <libmain>
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
  80003e:	e8 b7 15 00 00       	call   8015fa <sys_getparentenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int delay;

	/*[1] GET SHARED VARIABLE, SEMAPHORE SEL, check-finishing counter*/
	int *X = sget(parentenvID, "X") ;
  800046:	83 ec 08             	sub    $0x8,%esp
  800049:	68 a0 20 80 00       	push   $0x8020a0
  80004e:	ff 75 f4             	pushl  -0xc(%ebp)
  800051:	e8 3c 14 00 00       	call   801492 <sget>
  800056:	83 c4 10             	add    $0x10,%esp
  800059:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int *useSem = sget(parentenvID, "useSem") ;
  80005c:	83 ec 08             	sub    $0x8,%esp
  80005f:	68 a2 20 80 00       	push   $0x8020a2
  800064:	ff 75 f4             	pushl  -0xc(%ebp)
  800067:	e8 26 14 00 00       	call   801492 <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int *finishedCount = sget(parentenvID, "finishedCount") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 a9 20 80 00       	push   $0x8020a9
  80007a:	ff 75 f4             	pushl  -0xc(%ebp)
  80007d:	e8 10 14 00 00       	call   801492 <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	/*[2] DO THE JOB*/
	int Z ;
	if (*useSem == 1)
  800088:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80008b:	8b 00                	mov    (%eax),%eax
  80008d:	83 f8 01             	cmp    $0x1,%eax
  800090:	75 13                	jne    8000a5 <_main+0x6d>
	{
		sys_waitSemaphore(parentenvID, "T") ;
  800092:	83 ec 08             	sub    $0x8,%esp
  800095:	68 b7 20 80 00       	push   $0x8020b7
  80009a:	ff 75 f4             	pushl  -0xc(%ebp)
  80009d:	e8 87 17 00 00       	call   801829 <sys_waitSemaphore>
  8000a2:	83 c4 10             	add    $0x10,%esp
	}

	//random delay
	delay = RAND(2000, 10000);
  8000a5:	8d 45 c8             	lea    -0x38(%ebp),%eax
  8000a8:	83 ec 0c             	sub    $0xc,%esp
  8000ab:	50                   	push   %eax
  8000ac:	e8 a6 18 00 00       	call   801957 <sys_get_virtual_time>
  8000b1:	83 c4 0c             	add    $0xc,%esp
  8000b4:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8000b7:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  8000bc:	ba 00 00 00 00       	mov    $0x0,%edx
  8000c1:	f7 f1                	div    %ecx
  8000c3:	89 d0                	mov    %edx,%eax
  8000c5:	05 d0 07 00 00       	add    $0x7d0,%eax
  8000ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  8000cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	50                   	push   %eax
  8000d4:	e8 c4 1a 00 00       	call   801b9d <env_sleep>
  8000d9:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	Z = (*X) + 1 ;
  8000dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000df:	8b 00                	mov    (%eax),%eax
  8000e1:	40                   	inc    %eax
  8000e2:	89 45 e0             	mov    %eax,-0x20(%ebp)

	//random delay
	delay = RAND(2000, 10000);
  8000e5:	8d 45 d0             	lea    -0x30(%ebp),%eax
  8000e8:	83 ec 0c             	sub    $0xc,%esp
  8000eb:	50                   	push   %eax
  8000ec:	e8 66 18 00 00       	call   801957 <sys_get_virtual_time>
  8000f1:	83 c4 0c             	add    $0xc,%esp
  8000f4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f7:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  8000fc:	ba 00 00 00 00       	mov    $0x0,%edx
  800101:	f7 f1                	div    %ecx
  800103:	89 d0                	mov    %edx,%eax
  800105:	05 d0 07 00 00       	add    $0x7d0,%eax
  80010a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  80010d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800110:	83 ec 0c             	sub    $0xc,%esp
  800113:	50                   	push   %eax
  800114:	e8 84 1a 00 00       	call   801b9d <env_sleep>
  800119:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	(*X) = Z ;
  80011c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80011f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800122:	89 10                	mov    %edx,(%eax)

	//random delay
	delay = RAND(2000, 10000);
  800124:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800127:	83 ec 0c             	sub    $0xc,%esp
  80012a:	50                   	push   %eax
  80012b:	e8 27 18 00 00       	call   801957 <sys_get_virtual_time>
  800130:	83 c4 0c             	add    $0xc,%esp
  800133:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800136:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  80013b:	ba 00 00 00 00       	mov    $0x0,%edx
  800140:	f7 f1                	div    %ecx
  800142:	89 d0                	mov    %edx,%eax
  800144:	05 d0 07 00 00       	add    $0x7d0,%eax
  800149:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  80014c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80014f:	83 ec 0c             	sub    $0xc,%esp
  800152:	50                   	push   %eax
  800153:	e8 45 1a 00 00       	call   801b9d <env_sleep>
  800158:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	/*[3] DECLARE FINISHING*/
	(*finishedCount)++ ;
  80015b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80015e:	8b 00                	mov    (%eax),%eax
  800160:	8d 50 01             	lea    0x1(%eax),%edx
  800163:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800166:	89 10                	mov    %edx,(%eax)

}
  800168:	90                   	nop
  800169:	c9                   	leave  
  80016a:	c3                   	ret    

0080016b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80016b:	55                   	push   %ebp
  80016c:	89 e5                	mov    %esp,%ebp
  80016e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800171:	e8 6b 14 00 00       	call   8015e1 <sys_getenvindex>
  800176:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800179:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80017c:	89 d0                	mov    %edx,%eax
  80017e:	c1 e0 03             	shl    $0x3,%eax
  800181:	01 d0                	add    %edx,%eax
  800183:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80018a:	01 c8                	add    %ecx,%eax
  80018c:	01 c0                	add    %eax,%eax
  80018e:	01 d0                	add    %edx,%eax
  800190:	01 c0                	add    %eax,%eax
  800192:	01 d0                	add    %edx,%eax
  800194:	89 c2                	mov    %eax,%edx
  800196:	c1 e2 05             	shl    $0x5,%edx
  800199:	29 c2                	sub    %eax,%edx
  80019b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001a2:	89 c2                	mov    %eax,%edx
  8001a4:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001aa:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001af:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b4:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001ba:	84 c0                	test   %al,%al
  8001bc:	74 0f                	je     8001cd <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001be:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c3:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001c8:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001cd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001d1:	7e 0a                	jle    8001dd <libmain+0x72>
		binaryname = argv[0];
  8001d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d6:	8b 00                	mov    (%eax),%eax
  8001d8:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001dd:	83 ec 08             	sub    $0x8,%esp
  8001e0:	ff 75 0c             	pushl  0xc(%ebp)
  8001e3:	ff 75 08             	pushl  0x8(%ebp)
  8001e6:	e8 4d fe ff ff       	call   800038 <_main>
  8001eb:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001ee:	e8 89 15 00 00       	call   80177c <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001f3:	83 ec 0c             	sub    $0xc,%esp
  8001f6:	68 d4 20 80 00       	push   $0x8020d4
  8001fb:	e8 84 01 00 00       	call   800384 <cprintf>
  800200:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800203:	a1 20 30 80 00       	mov    0x803020,%eax
  800208:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80020e:	a1 20 30 80 00       	mov    0x803020,%eax
  800213:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800219:	83 ec 04             	sub    $0x4,%esp
  80021c:	52                   	push   %edx
  80021d:	50                   	push   %eax
  80021e:	68 fc 20 80 00       	push   $0x8020fc
  800223:	e8 5c 01 00 00       	call   800384 <cprintf>
  800228:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80022b:	a1 20 30 80 00       	mov    0x803020,%eax
  800230:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800236:	a1 20 30 80 00       	mov    0x803020,%eax
  80023b:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800241:	83 ec 04             	sub    $0x4,%esp
  800244:	52                   	push   %edx
  800245:	50                   	push   %eax
  800246:	68 24 21 80 00       	push   $0x802124
  80024b:	e8 34 01 00 00       	call   800384 <cprintf>
  800250:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800253:	a1 20 30 80 00       	mov    0x803020,%eax
  800258:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80025e:	83 ec 08             	sub    $0x8,%esp
  800261:	50                   	push   %eax
  800262:	68 65 21 80 00       	push   $0x802165
  800267:	e8 18 01 00 00       	call   800384 <cprintf>
  80026c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80026f:	83 ec 0c             	sub    $0xc,%esp
  800272:	68 d4 20 80 00       	push   $0x8020d4
  800277:	e8 08 01 00 00       	call   800384 <cprintf>
  80027c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80027f:	e8 12 15 00 00       	call   801796 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800284:	e8 19 00 00 00       	call   8002a2 <exit>
}
  800289:	90                   	nop
  80028a:	c9                   	leave  
  80028b:	c3                   	ret    

0080028c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80028c:	55                   	push   %ebp
  80028d:	89 e5                	mov    %esp,%ebp
  80028f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800292:	83 ec 0c             	sub    $0xc,%esp
  800295:	6a 00                	push   $0x0
  800297:	e8 11 13 00 00       	call   8015ad <sys_env_destroy>
  80029c:	83 c4 10             	add    $0x10,%esp
}
  80029f:	90                   	nop
  8002a0:	c9                   	leave  
  8002a1:	c3                   	ret    

008002a2 <exit>:

void
exit(void)
{
  8002a2:	55                   	push   %ebp
  8002a3:	89 e5                	mov    %esp,%ebp
  8002a5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002a8:	e8 66 13 00 00       	call   801613 <sys_env_exit>
}
  8002ad:	90                   	nop
  8002ae:	c9                   	leave  
  8002af:	c3                   	ret    

008002b0 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8002b0:	55                   	push   %ebp
  8002b1:	89 e5                	mov    %esp,%ebp
  8002b3:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8002b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b9:	8b 00                	mov    (%eax),%eax
  8002bb:	8d 48 01             	lea    0x1(%eax),%ecx
  8002be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002c1:	89 0a                	mov    %ecx,(%edx)
  8002c3:	8b 55 08             	mov    0x8(%ebp),%edx
  8002c6:	88 d1                	mov    %dl,%cl
  8002c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002cb:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d2:	8b 00                	mov    (%eax),%eax
  8002d4:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002d9:	75 2c                	jne    800307 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8002db:	a0 24 30 80 00       	mov    0x803024,%al
  8002e0:	0f b6 c0             	movzbl %al,%eax
  8002e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002e6:	8b 12                	mov    (%edx),%edx
  8002e8:	89 d1                	mov    %edx,%ecx
  8002ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002ed:	83 c2 08             	add    $0x8,%edx
  8002f0:	83 ec 04             	sub    $0x4,%esp
  8002f3:	50                   	push   %eax
  8002f4:	51                   	push   %ecx
  8002f5:	52                   	push   %edx
  8002f6:	e8 70 12 00 00       	call   80156b <sys_cputs>
  8002fb:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800301:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800307:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030a:	8b 40 04             	mov    0x4(%eax),%eax
  80030d:	8d 50 01             	lea    0x1(%eax),%edx
  800310:	8b 45 0c             	mov    0xc(%ebp),%eax
  800313:	89 50 04             	mov    %edx,0x4(%eax)
}
  800316:	90                   	nop
  800317:	c9                   	leave  
  800318:	c3                   	ret    

00800319 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800319:	55                   	push   %ebp
  80031a:	89 e5                	mov    %esp,%ebp
  80031c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800322:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800329:	00 00 00 
	b.cnt = 0;
  80032c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800333:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800336:	ff 75 0c             	pushl  0xc(%ebp)
  800339:	ff 75 08             	pushl  0x8(%ebp)
  80033c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800342:	50                   	push   %eax
  800343:	68 b0 02 80 00       	push   $0x8002b0
  800348:	e8 11 02 00 00       	call   80055e <vprintfmt>
  80034d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800350:	a0 24 30 80 00       	mov    0x803024,%al
  800355:	0f b6 c0             	movzbl %al,%eax
  800358:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80035e:	83 ec 04             	sub    $0x4,%esp
  800361:	50                   	push   %eax
  800362:	52                   	push   %edx
  800363:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800369:	83 c0 08             	add    $0x8,%eax
  80036c:	50                   	push   %eax
  80036d:	e8 f9 11 00 00       	call   80156b <sys_cputs>
  800372:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800375:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80037c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800382:	c9                   	leave  
  800383:	c3                   	ret    

00800384 <cprintf>:

int cprintf(const char *fmt, ...) {
  800384:	55                   	push   %ebp
  800385:	89 e5                	mov    %esp,%ebp
  800387:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80038a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800391:	8d 45 0c             	lea    0xc(%ebp),%eax
  800394:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800397:	8b 45 08             	mov    0x8(%ebp),%eax
  80039a:	83 ec 08             	sub    $0x8,%esp
  80039d:	ff 75 f4             	pushl  -0xc(%ebp)
  8003a0:	50                   	push   %eax
  8003a1:	e8 73 ff ff ff       	call   800319 <vcprintf>
  8003a6:	83 c4 10             	add    $0x10,%esp
  8003a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003af:	c9                   	leave  
  8003b0:	c3                   	ret    

008003b1 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8003b1:	55                   	push   %ebp
  8003b2:	89 e5                	mov    %esp,%ebp
  8003b4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8003b7:	e8 c0 13 00 00       	call   80177c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8003bc:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c5:	83 ec 08             	sub    $0x8,%esp
  8003c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8003cb:	50                   	push   %eax
  8003cc:	e8 48 ff ff ff       	call   800319 <vcprintf>
  8003d1:	83 c4 10             	add    $0x10,%esp
  8003d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8003d7:	e8 ba 13 00 00       	call   801796 <sys_enable_interrupt>
	return cnt;
  8003dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003df:	c9                   	leave  
  8003e0:	c3                   	ret    

008003e1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8003e1:	55                   	push   %ebp
  8003e2:	89 e5                	mov    %esp,%ebp
  8003e4:	53                   	push   %ebx
  8003e5:	83 ec 14             	sub    $0x14,%esp
  8003e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8003eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8003ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8003f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003f4:	8b 45 18             	mov    0x18(%ebp),%eax
  8003f7:	ba 00 00 00 00       	mov    $0x0,%edx
  8003fc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003ff:	77 55                	ja     800456 <printnum+0x75>
  800401:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800404:	72 05                	jb     80040b <printnum+0x2a>
  800406:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800409:	77 4b                	ja     800456 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80040b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80040e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800411:	8b 45 18             	mov    0x18(%ebp),%eax
  800414:	ba 00 00 00 00       	mov    $0x0,%edx
  800419:	52                   	push   %edx
  80041a:	50                   	push   %eax
  80041b:	ff 75 f4             	pushl  -0xc(%ebp)
  80041e:	ff 75 f0             	pushl  -0x10(%ebp)
  800421:	e8 fa 19 00 00       	call   801e20 <__udivdi3>
  800426:	83 c4 10             	add    $0x10,%esp
  800429:	83 ec 04             	sub    $0x4,%esp
  80042c:	ff 75 20             	pushl  0x20(%ebp)
  80042f:	53                   	push   %ebx
  800430:	ff 75 18             	pushl  0x18(%ebp)
  800433:	52                   	push   %edx
  800434:	50                   	push   %eax
  800435:	ff 75 0c             	pushl  0xc(%ebp)
  800438:	ff 75 08             	pushl  0x8(%ebp)
  80043b:	e8 a1 ff ff ff       	call   8003e1 <printnum>
  800440:	83 c4 20             	add    $0x20,%esp
  800443:	eb 1a                	jmp    80045f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800445:	83 ec 08             	sub    $0x8,%esp
  800448:	ff 75 0c             	pushl  0xc(%ebp)
  80044b:	ff 75 20             	pushl  0x20(%ebp)
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	ff d0                	call   *%eax
  800453:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800456:	ff 4d 1c             	decl   0x1c(%ebp)
  800459:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80045d:	7f e6                	jg     800445 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80045f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800462:	bb 00 00 00 00       	mov    $0x0,%ebx
  800467:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80046a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80046d:	53                   	push   %ebx
  80046e:	51                   	push   %ecx
  80046f:	52                   	push   %edx
  800470:	50                   	push   %eax
  800471:	e8 ba 1a 00 00       	call   801f30 <__umoddi3>
  800476:	83 c4 10             	add    $0x10,%esp
  800479:	05 94 23 80 00       	add    $0x802394,%eax
  80047e:	8a 00                	mov    (%eax),%al
  800480:	0f be c0             	movsbl %al,%eax
  800483:	83 ec 08             	sub    $0x8,%esp
  800486:	ff 75 0c             	pushl  0xc(%ebp)
  800489:	50                   	push   %eax
  80048a:	8b 45 08             	mov    0x8(%ebp),%eax
  80048d:	ff d0                	call   *%eax
  80048f:	83 c4 10             	add    $0x10,%esp
}
  800492:	90                   	nop
  800493:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800496:	c9                   	leave  
  800497:	c3                   	ret    

00800498 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800498:	55                   	push   %ebp
  800499:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80049b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80049f:	7e 1c                	jle    8004bd <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8004a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a4:	8b 00                	mov    (%eax),%eax
  8004a6:	8d 50 08             	lea    0x8(%eax),%edx
  8004a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ac:	89 10                	mov    %edx,(%eax)
  8004ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b1:	8b 00                	mov    (%eax),%eax
  8004b3:	83 e8 08             	sub    $0x8,%eax
  8004b6:	8b 50 04             	mov    0x4(%eax),%edx
  8004b9:	8b 00                	mov    (%eax),%eax
  8004bb:	eb 40                	jmp    8004fd <getuint+0x65>
	else if (lflag)
  8004bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004c1:	74 1e                	je     8004e1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8004c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c6:	8b 00                	mov    (%eax),%eax
  8004c8:	8d 50 04             	lea    0x4(%eax),%edx
  8004cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ce:	89 10                	mov    %edx,(%eax)
  8004d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d3:	8b 00                	mov    (%eax),%eax
  8004d5:	83 e8 04             	sub    $0x4,%eax
  8004d8:	8b 00                	mov    (%eax),%eax
  8004da:	ba 00 00 00 00       	mov    $0x0,%edx
  8004df:	eb 1c                	jmp    8004fd <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8004e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e4:	8b 00                	mov    (%eax),%eax
  8004e6:	8d 50 04             	lea    0x4(%eax),%edx
  8004e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ec:	89 10                	mov    %edx,(%eax)
  8004ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f1:	8b 00                	mov    (%eax),%eax
  8004f3:	83 e8 04             	sub    $0x4,%eax
  8004f6:	8b 00                	mov    (%eax),%eax
  8004f8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004fd:	5d                   	pop    %ebp
  8004fe:	c3                   	ret    

008004ff <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004ff:	55                   	push   %ebp
  800500:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800502:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800506:	7e 1c                	jle    800524 <getint+0x25>
		return va_arg(*ap, long long);
  800508:	8b 45 08             	mov    0x8(%ebp),%eax
  80050b:	8b 00                	mov    (%eax),%eax
  80050d:	8d 50 08             	lea    0x8(%eax),%edx
  800510:	8b 45 08             	mov    0x8(%ebp),%eax
  800513:	89 10                	mov    %edx,(%eax)
  800515:	8b 45 08             	mov    0x8(%ebp),%eax
  800518:	8b 00                	mov    (%eax),%eax
  80051a:	83 e8 08             	sub    $0x8,%eax
  80051d:	8b 50 04             	mov    0x4(%eax),%edx
  800520:	8b 00                	mov    (%eax),%eax
  800522:	eb 38                	jmp    80055c <getint+0x5d>
	else if (lflag)
  800524:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800528:	74 1a                	je     800544 <getint+0x45>
		return va_arg(*ap, long);
  80052a:	8b 45 08             	mov    0x8(%ebp),%eax
  80052d:	8b 00                	mov    (%eax),%eax
  80052f:	8d 50 04             	lea    0x4(%eax),%edx
  800532:	8b 45 08             	mov    0x8(%ebp),%eax
  800535:	89 10                	mov    %edx,(%eax)
  800537:	8b 45 08             	mov    0x8(%ebp),%eax
  80053a:	8b 00                	mov    (%eax),%eax
  80053c:	83 e8 04             	sub    $0x4,%eax
  80053f:	8b 00                	mov    (%eax),%eax
  800541:	99                   	cltd   
  800542:	eb 18                	jmp    80055c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800544:	8b 45 08             	mov    0x8(%ebp),%eax
  800547:	8b 00                	mov    (%eax),%eax
  800549:	8d 50 04             	lea    0x4(%eax),%edx
  80054c:	8b 45 08             	mov    0x8(%ebp),%eax
  80054f:	89 10                	mov    %edx,(%eax)
  800551:	8b 45 08             	mov    0x8(%ebp),%eax
  800554:	8b 00                	mov    (%eax),%eax
  800556:	83 e8 04             	sub    $0x4,%eax
  800559:	8b 00                	mov    (%eax),%eax
  80055b:	99                   	cltd   
}
  80055c:	5d                   	pop    %ebp
  80055d:	c3                   	ret    

0080055e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80055e:	55                   	push   %ebp
  80055f:	89 e5                	mov    %esp,%ebp
  800561:	56                   	push   %esi
  800562:	53                   	push   %ebx
  800563:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800566:	eb 17                	jmp    80057f <vprintfmt+0x21>
			if (ch == '\0')
  800568:	85 db                	test   %ebx,%ebx
  80056a:	0f 84 af 03 00 00    	je     80091f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800570:	83 ec 08             	sub    $0x8,%esp
  800573:	ff 75 0c             	pushl  0xc(%ebp)
  800576:	53                   	push   %ebx
  800577:	8b 45 08             	mov    0x8(%ebp),%eax
  80057a:	ff d0                	call   *%eax
  80057c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80057f:	8b 45 10             	mov    0x10(%ebp),%eax
  800582:	8d 50 01             	lea    0x1(%eax),%edx
  800585:	89 55 10             	mov    %edx,0x10(%ebp)
  800588:	8a 00                	mov    (%eax),%al
  80058a:	0f b6 d8             	movzbl %al,%ebx
  80058d:	83 fb 25             	cmp    $0x25,%ebx
  800590:	75 d6                	jne    800568 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800592:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800596:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80059d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8005a4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8005ab:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8005b5:	8d 50 01             	lea    0x1(%eax),%edx
  8005b8:	89 55 10             	mov    %edx,0x10(%ebp)
  8005bb:	8a 00                	mov    (%eax),%al
  8005bd:	0f b6 d8             	movzbl %al,%ebx
  8005c0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8005c3:	83 f8 55             	cmp    $0x55,%eax
  8005c6:	0f 87 2b 03 00 00    	ja     8008f7 <vprintfmt+0x399>
  8005cc:	8b 04 85 b8 23 80 00 	mov    0x8023b8(,%eax,4),%eax
  8005d3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8005d5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8005d9:	eb d7                	jmp    8005b2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8005db:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8005df:	eb d1                	jmp    8005b2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005e1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8005e8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005eb:	89 d0                	mov    %edx,%eax
  8005ed:	c1 e0 02             	shl    $0x2,%eax
  8005f0:	01 d0                	add    %edx,%eax
  8005f2:	01 c0                	add    %eax,%eax
  8005f4:	01 d8                	add    %ebx,%eax
  8005f6:	83 e8 30             	sub    $0x30,%eax
  8005f9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8005ff:	8a 00                	mov    (%eax),%al
  800601:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800604:	83 fb 2f             	cmp    $0x2f,%ebx
  800607:	7e 3e                	jle    800647 <vprintfmt+0xe9>
  800609:	83 fb 39             	cmp    $0x39,%ebx
  80060c:	7f 39                	jg     800647 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80060e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800611:	eb d5                	jmp    8005e8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800613:	8b 45 14             	mov    0x14(%ebp),%eax
  800616:	83 c0 04             	add    $0x4,%eax
  800619:	89 45 14             	mov    %eax,0x14(%ebp)
  80061c:	8b 45 14             	mov    0x14(%ebp),%eax
  80061f:	83 e8 04             	sub    $0x4,%eax
  800622:	8b 00                	mov    (%eax),%eax
  800624:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800627:	eb 1f                	jmp    800648 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800629:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80062d:	79 83                	jns    8005b2 <vprintfmt+0x54>
				width = 0;
  80062f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800636:	e9 77 ff ff ff       	jmp    8005b2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80063b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800642:	e9 6b ff ff ff       	jmp    8005b2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800647:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800648:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80064c:	0f 89 60 ff ff ff    	jns    8005b2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800652:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800655:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800658:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80065f:	e9 4e ff ff ff       	jmp    8005b2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800664:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800667:	e9 46 ff ff ff       	jmp    8005b2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80066c:	8b 45 14             	mov    0x14(%ebp),%eax
  80066f:	83 c0 04             	add    $0x4,%eax
  800672:	89 45 14             	mov    %eax,0x14(%ebp)
  800675:	8b 45 14             	mov    0x14(%ebp),%eax
  800678:	83 e8 04             	sub    $0x4,%eax
  80067b:	8b 00                	mov    (%eax),%eax
  80067d:	83 ec 08             	sub    $0x8,%esp
  800680:	ff 75 0c             	pushl  0xc(%ebp)
  800683:	50                   	push   %eax
  800684:	8b 45 08             	mov    0x8(%ebp),%eax
  800687:	ff d0                	call   *%eax
  800689:	83 c4 10             	add    $0x10,%esp
			break;
  80068c:	e9 89 02 00 00       	jmp    80091a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800691:	8b 45 14             	mov    0x14(%ebp),%eax
  800694:	83 c0 04             	add    $0x4,%eax
  800697:	89 45 14             	mov    %eax,0x14(%ebp)
  80069a:	8b 45 14             	mov    0x14(%ebp),%eax
  80069d:	83 e8 04             	sub    $0x4,%eax
  8006a0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8006a2:	85 db                	test   %ebx,%ebx
  8006a4:	79 02                	jns    8006a8 <vprintfmt+0x14a>
				err = -err;
  8006a6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8006a8:	83 fb 64             	cmp    $0x64,%ebx
  8006ab:	7f 0b                	jg     8006b8 <vprintfmt+0x15a>
  8006ad:	8b 34 9d 00 22 80 00 	mov    0x802200(,%ebx,4),%esi
  8006b4:	85 f6                	test   %esi,%esi
  8006b6:	75 19                	jne    8006d1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8006b8:	53                   	push   %ebx
  8006b9:	68 a5 23 80 00       	push   $0x8023a5
  8006be:	ff 75 0c             	pushl  0xc(%ebp)
  8006c1:	ff 75 08             	pushl  0x8(%ebp)
  8006c4:	e8 5e 02 00 00       	call   800927 <printfmt>
  8006c9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8006cc:	e9 49 02 00 00       	jmp    80091a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8006d1:	56                   	push   %esi
  8006d2:	68 ae 23 80 00       	push   $0x8023ae
  8006d7:	ff 75 0c             	pushl  0xc(%ebp)
  8006da:	ff 75 08             	pushl  0x8(%ebp)
  8006dd:	e8 45 02 00 00       	call   800927 <printfmt>
  8006e2:	83 c4 10             	add    $0x10,%esp
			break;
  8006e5:	e9 30 02 00 00       	jmp    80091a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8006ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ed:	83 c0 04             	add    $0x4,%eax
  8006f0:	89 45 14             	mov    %eax,0x14(%ebp)
  8006f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f6:	83 e8 04             	sub    $0x4,%eax
  8006f9:	8b 30                	mov    (%eax),%esi
  8006fb:	85 f6                	test   %esi,%esi
  8006fd:	75 05                	jne    800704 <vprintfmt+0x1a6>
				p = "(null)";
  8006ff:	be b1 23 80 00       	mov    $0x8023b1,%esi
			if (width > 0 && padc != '-')
  800704:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800708:	7e 6d                	jle    800777 <vprintfmt+0x219>
  80070a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80070e:	74 67                	je     800777 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800710:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800713:	83 ec 08             	sub    $0x8,%esp
  800716:	50                   	push   %eax
  800717:	56                   	push   %esi
  800718:	e8 0c 03 00 00       	call   800a29 <strnlen>
  80071d:	83 c4 10             	add    $0x10,%esp
  800720:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800723:	eb 16                	jmp    80073b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800725:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800729:	83 ec 08             	sub    $0x8,%esp
  80072c:	ff 75 0c             	pushl  0xc(%ebp)
  80072f:	50                   	push   %eax
  800730:	8b 45 08             	mov    0x8(%ebp),%eax
  800733:	ff d0                	call   *%eax
  800735:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800738:	ff 4d e4             	decl   -0x1c(%ebp)
  80073b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80073f:	7f e4                	jg     800725 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800741:	eb 34                	jmp    800777 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800743:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800747:	74 1c                	je     800765 <vprintfmt+0x207>
  800749:	83 fb 1f             	cmp    $0x1f,%ebx
  80074c:	7e 05                	jle    800753 <vprintfmt+0x1f5>
  80074e:	83 fb 7e             	cmp    $0x7e,%ebx
  800751:	7e 12                	jle    800765 <vprintfmt+0x207>
					putch('?', putdat);
  800753:	83 ec 08             	sub    $0x8,%esp
  800756:	ff 75 0c             	pushl  0xc(%ebp)
  800759:	6a 3f                	push   $0x3f
  80075b:	8b 45 08             	mov    0x8(%ebp),%eax
  80075e:	ff d0                	call   *%eax
  800760:	83 c4 10             	add    $0x10,%esp
  800763:	eb 0f                	jmp    800774 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800765:	83 ec 08             	sub    $0x8,%esp
  800768:	ff 75 0c             	pushl  0xc(%ebp)
  80076b:	53                   	push   %ebx
  80076c:	8b 45 08             	mov    0x8(%ebp),%eax
  80076f:	ff d0                	call   *%eax
  800771:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800774:	ff 4d e4             	decl   -0x1c(%ebp)
  800777:	89 f0                	mov    %esi,%eax
  800779:	8d 70 01             	lea    0x1(%eax),%esi
  80077c:	8a 00                	mov    (%eax),%al
  80077e:	0f be d8             	movsbl %al,%ebx
  800781:	85 db                	test   %ebx,%ebx
  800783:	74 24                	je     8007a9 <vprintfmt+0x24b>
  800785:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800789:	78 b8                	js     800743 <vprintfmt+0x1e5>
  80078b:	ff 4d e0             	decl   -0x20(%ebp)
  80078e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800792:	79 af                	jns    800743 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800794:	eb 13                	jmp    8007a9 <vprintfmt+0x24b>
				putch(' ', putdat);
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	6a 20                	push   $0x20
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	ff d0                	call   *%eax
  8007a3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007a6:	ff 4d e4             	decl   -0x1c(%ebp)
  8007a9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ad:	7f e7                	jg     800796 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8007af:	e9 66 01 00 00       	jmp    80091a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8007b4:	83 ec 08             	sub    $0x8,%esp
  8007b7:	ff 75 e8             	pushl  -0x18(%ebp)
  8007ba:	8d 45 14             	lea    0x14(%ebp),%eax
  8007bd:	50                   	push   %eax
  8007be:	e8 3c fd ff ff       	call   8004ff <getint>
  8007c3:	83 c4 10             	add    $0x10,%esp
  8007c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8007cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007d2:	85 d2                	test   %edx,%edx
  8007d4:	79 23                	jns    8007f9 <vprintfmt+0x29b>
				putch('-', putdat);
  8007d6:	83 ec 08             	sub    $0x8,%esp
  8007d9:	ff 75 0c             	pushl  0xc(%ebp)
  8007dc:	6a 2d                	push   $0x2d
  8007de:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e1:	ff d0                	call   *%eax
  8007e3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8007e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ec:	f7 d8                	neg    %eax
  8007ee:	83 d2 00             	adc    $0x0,%edx
  8007f1:	f7 da                	neg    %edx
  8007f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007f9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800800:	e9 bc 00 00 00       	jmp    8008c1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	ff 75 e8             	pushl  -0x18(%ebp)
  80080b:	8d 45 14             	lea    0x14(%ebp),%eax
  80080e:	50                   	push   %eax
  80080f:	e8 84 fc ff ff       	call   800498 <getuint>
  800814:	83 c4 10             	add    $0x10,%esp
  800817:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80081a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80081d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800824:	e9 98 00 00 00       	jmp    8008c1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800829:	83 ec 08             	sub    $0x8,%esp
  80082c:	ff 75 0c             	pushl  0xc(%ebp)
  80082f:	6a 58                	push   $0x58
  800831:	8b 45 08             	mov    0x8(%ebp),%eax
  800834:	ff d0                	call   *%eax
  800836:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800839:	83 ec 08             	sub    $0x8,%esp
  80083c:	ff 75 0c             	pushl  0xc(%ebp)
  80083f:	6a 58                	push   $0x58
  800841:	8b 45 08             	mov    0x8(%ebp),%eax
  800844:	ff d0                	call   *%eax
  800846:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800849:	83 ec 08             	sub    $0x8,%esp
  80084c:	ff 75 0c             	pushl  0xc(%ebp)
  80084f:	6a 58                	push   $0x58
  800851:	8b 45 08             	mov    0x8(%ebp),%eax
  800854:	ff d0                	call   *%eax
  800856:	83 c4 10             	add    $0x10,%esp
			break;
  800859:	e9 bc 00 00 00       	jmp    80091a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80085e:	83 ec 08             	sub    $0x8,%esp
  800861:	ff 75 0c             	pushl  0xc(%ebp)
  800864:	6a 30                	push   $0x30
  800866:	8b 45 08             	mov    0x8(%ebp),%eax
  800869:	ff d0                	call   *%eax
  80086b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80086e:	83 ec 08             	sub    $0x8,%esp
  800871:	ff 75 0c             	pushl  0xc(%ebp)
  800874:	6a 78                	push   $0x78
  800876:	8b 45 08             	mov    0x8(%ebp),%eax
  800879:	ff d0                	call   *%eax
  80087b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80087e:	8b 45 14             	mov    0x14(%ebp),%eax
  800881:	83 c0 04             	add    $0x4,%eax
  800884:	89 45 14             	mov    %eax,0x14(%ebp)
  800887:	8b 45 14             	mov    0x14(%ebp),%eax
  80088a:	83 e8 04             	sub    $0x4,%eax
  80088d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80088f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800892:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800899:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8008a0:	eb 1f                	jmp    8008c1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8008a2:	83 ec 08             	sub    $0x8,%esp
  8008a5:	ff 75 e8             	pushl  -0x18(%ebp)
  8008a8:	8d 45 14             	lea    0x14(%ebp),%eax
  8008ab:	50                   	push   %eax
  8008ac:	e8 e7 fb ff ff       	call   800498 <getuint>
  8008b1:	83 c4 10             	add    $0x10,%esp
  8008b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8008ba:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8008c1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8008c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008c8:	83 ec 04             	sub    $0x4,%esp
  8008cb:	52                   	push   %edx
  8008cc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8008cf:	50                   	push   %eax
  8008d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8008d3:	ff 75 f0             	pushl  -0x10(%ebp)
  8008d6:	ff 75 0c             	pushl  0xc(%ebp)
  8008d9:	ff 75 08             	pushl  0x8(%ebp)
  8008dc:	e8 00 fb ff ff       	call   8003e1 <printnum>
  8008e1:	83 c4 20             	add    $0x20,%esp
			break;
  8008e4:	eb 34                	jmp    80091a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8008e6:	83 ec 08             	sub    $0x8,%esp
  8008e9:	ff 75 0c             	pushl  0xc(%ebp)
  8008ec:	53                   	push   %ebx
  8008ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f0:	ff d0                	call   *%eax
  8008f2:	83 c4 10             	add    $0x10,%esp
			break;
  8008f5:	eb 23                	jmp    80091a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008f7:	83 ec 08             	sub    $0x8,%esp
  8008fa:	ff 75 0c             	pushl  0xc(%ebp)
  8008fd:	6a 25                	push   $0x25
  8008ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800902:	ff d0                	call   *%eax
  800904:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800907:	ff 4d 10             	decl   0x10(%ebp)
  80090a:	eb 03                	jmp    80090f <vprintfmt+0x3b1>
  80090c:	ff 4d 10             	decl   0x10(%ebp)
  80090f:	8b 45 10             	mov    0x10(%ebp),%eax
  800912:	48                   	dec    %eax
  800913:	8a 00                	mov    (%eax),%al
  800915:	3c 25                	cmp    $0x25,%al
  800917:	75 f3                	jne    80090c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800919:	90                   	nop
		}
	}
  80091a:	e9 47 fc ff ff       	jmp    800566 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80091f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800920:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800923:	5b                   	pop    %ebx
  800924:	5e                   	pop    %esi
  800925:	5d                   	pop    %ebp
  800926:	c3                   	ret    

00800927 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800927:	55                   	push   %ebp
  800928:	89 e5                	mov    %esp,%ebp
  80092a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80092d:	8d 45 10             	lea    0x10(%ebp),%eax
  800930:	83 c0 04             	add    $0x4,%eax
  800933:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800936:	8b 45 10             	mov    0x10(%ebp),%eax
  800939:	ff 75 f4             	pushl  -0xc(%ebp)
  80093c:	50                   	push   %eax
  80093d:	ff 75 0c             	pushl  0xc(%ebp)
  800940:	ff 75 08             	pushl  0x8(%ebp)
  800943:	e8 16 fc ff ff       	call   80055e <vprintfmt>
  800948:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80094b:	90                   	nop
  80094c:	c9                   	leave  
  80094d:	c3                   	ret    

0080094e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80094e:	55                   	push   %ebp
  80094f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800951:	8b 45 0c             	mov    0xc(%ebp),%eax
  800954:	8b 40 08             	mov    0x8(%eax),%eax
  800957:	8d 50 01             	lea    0x1(%eax),%edx
  80095a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800960:	8b 45 0c             	mov    0xc(%ebp),%eax
  800963:	8b 10                	mov    (%eax),%edx
  800965:	8b 45 0c             	mov    0xc(%ebp),%eax
  800968:	8b 40 04             	mov    0x4(%eax),%eax
  80096b:	39 c2                	cmp    %eax,%edx
  80096d:	73 12                	jae    800981 <sprintputch+0x33>
		*b->buf++ = ch;
  80096f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800972:	8b 00                	mov    (%eax),%eax
  800974:	8d 48 01             	lea    0x1(%eax),%ecx
  800977:	8b 55 0c             	mov    0xc(%ebp),%edx
  80097a:	89 0a                	mov    %ecx,(%edx)
  80097c:	8b 55 08             	mov    0x8(%ebp),%edx
  80097f:	88 10                	mov    %dl,(%eax)
}
  800981:	90                   	nop
  800982:	5d                   	pop    %ebp
  800983:	c3                   	ret    

00800984 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800984:	55                   	push   %ebp
  800985:	89 e5                	mov    %esp,%ebp
  800987:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800990:	8b 45 0c             	mov    0xc(%ebp),%eax
  800993:	8d 50 ff             	lea    -0x1(%eax),%edx
  800996:	8b 45 08             	mov    0x8(%ebp),%eax
  800999:	01 d0                	add    %edx,%eax
  80099b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8009a5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8009a9:	74 06                	je     8009b1 <vsnprintf+0x2d>
  8009ab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009af:	7f 07                	jg     8009b8 <vsnprintf+0x34>
		return -E_INVAL;
  8009b1:	b8 03 00 00 00       	mov    $0x3,%eax
  8009b6:	eb 20                	jmp    8009d8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8009b8:	ff 75 14             	pushl  0x14(%ebp)
  8009bb:	ff 75 10             	pushl  0x10(%ebp)
  8009be:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8009c1:	50                   	push   %eax
  8009c2:	68 4e 09 80 00       	push   $0x80094e
  8009c7:	e8 92 fb ff ff       	call   80055e <vprintfmt>
  8009cc:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8009cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009d2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8009d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8009d8:	c9                   	leave  
  8009d9:	c3                   	ret    

008009da <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8009da:	55                   	push   %ebp
  8009db:	89 e5                	mov    %esp,%ebp
  8009dd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8009e0:	8d 45 10             	lea    0x10(%ebp),%eax
  8009e3:	83 c0 04             	add    $0x4,%eax
  8009e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8009e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ef:	50                   	push   %eax
  8009f0:	ff 75 0c             	pushl  0xc(%ebp)
  8009f3:	ff 75 08             	pushl  0x8(%ebp)
  8009f6:	e8 89 ff ff ff       	call   800984 <vsnprintf>
  8009fb:	83 c4 10             	add    $0x10,%esp
  8009fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a01:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a04:	c9                   	leave  
  800a05:	c3                   	ret    

00800a06 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a06:	55                   	push   %ebp
  800a07:	89 e5                	mov    %esp,%ebp
  800a09:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a0c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a13:	eb 06                	jmp    800a1b <strlen+0x15>
		n++;
  800a15:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a18:	ff 45 08             	incl   0x8(%ebp)
  800a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1e:	8a 00                	mov    (%eax),%al
  800a20:	84 c0                	test   %al,%al
  800a22:	75 f1                	jne    800a15 <strlen+0xf>
		n++;
	return n;
  800a24:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a27:	c9                   	leave  
  800a28:	c3                   	ret    

00800a29 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a29:	55                   	push   %ebp
  800a2a:	89 e5                	mov    %esp,%ebp
  800a2c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a2f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a36:	eb 09                	jmp    800a41 <strnlen+0x18>
		n++;
  800a38:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a3b:	ff 45 08             	incl   0x8(%ebp)
  800a3e:	ff 4d 0c             	decl   0xc(%ebp)
  800a41:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a45:	74 09                	je     800a50 <strnlen+0x27>
  800a47:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4a:	8a 00                	mov    (%eax),%al
  800a4c:	84 c0                	test   %al,%al
  800a4e:	75 e8                	jne    800a38 <strnlen+0xf>
		n++;
	return n;
  800a50:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a53:	c9                   	leave  
  800a54:	c3                   	ret    

00800a55 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a55:	55                   	push   %ebp
  800a56:	89 e5                	mov    %esp,%ebp
  800a58:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a61:	90                   	nop
  800a62:	8b 45 08             	mov    0x8(%ebp),%eax
  800a65:	8d 50 01             	lea    0x1(%eax),%edx
  800a68:	89 55 08             	mov    %edx,0x8(%ebp)
  800a6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a6e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a71:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a74:	8a 12                	mov    (%edx),%dl
  800a76:	88 10                	mov    %dl,(%eax)
  800a78:	8a 00                	mov    (%eax),%al
  800a7a:	84 c0                	test   %al,%al
  800a7c:	75 e4                	jne    800a62 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a81:	c9                   	leave  
  800a82:	c3                   	ret    

00800a83 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a83:	55                   	push   %ebp
  800a84:	89 e5                	mov    %esp,%ebp
  800a86:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a8f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a96:	eb 1f                	jmp    800ab7 <strncpy+0x34>
		*dst++ = *src;
  800a98:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9b:	8d 50 01             	lea    0x1(%eax),%edx
  800a9e:	89 55 08             	mov    %edx,0x8(%ebp)
  800aa1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aa4:	8a 12                	mov    (%edx),%dl
  800aa6:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800aa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aab:	8a 00                	mov    (%eax),%al
  800aad:	84 c0                	test   %al,%al
  800aaf:	74 03                	je     800ab4 <strncpy+0x31>
			src++;
  800ab1:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ab4:	ff 45 fc             	incl   -0x4(%ebp)
  800ab7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800aba:	3b 45 10             	cmp    0x10(%ebp),%eax
  800abd:	72 d9                	jb     800a98 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800abf:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ac2:	c9                   	leave  
  800ac3:	c3                   	ret    

00800ac4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ac4:	55                   	push   %ebp
  800ac5:	89 e5                	mov    %esp,%ebp
  800ac7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ad0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ad4:	74 30                	je     800b06 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ad6:	eb 16                	jmp    800aee <strlcpy+0x2a>
			*dst++ = *src++;
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8d 50 01             	lea    0x1(%eax),%edx
  800ade:	89 55 08             	mov    %edx,0x8(%ebp)
  800ae1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ae7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800aea:	8a 12                	mov    (%edx),%dl
  800aec:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800aee:	ff 4d 10             	decl   0x10(%ebp)
  800af1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800af5:	74 09                	je     800b00 <strlcpy+0x3c>
  800af7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afa:	8a 00                	mov    (%eax),%al
  800afc:	84 c0                	test   %al,%al
  800afe:	75 d8                	jne    800ad8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b06:	8b 55 08             	mov    0x8(%ebp),%edx
  800b09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b0c:	29 c2                	sub    %eax,%edx
  800b0e:	89 d0                	mov    %edx,%eax
}
  800b10:	c9                   	leave  
  800b11:	c3                   	ret    

00800b12 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b12:	55                   	push   %ebp
  800b13:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b15:	eb 06                	jmp    800b1d <strcmp+0xb>
		p++, q++;
  800b17:	ff 45 08             	incl   0x8(%ebp)
  800b1a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	8a 00                	mov    (%eax),%al
  800b22:	84 c0                	test   %al,%al
  800b24:	74 0e                	je     800b34 <strcmp+0x22>
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	8a 10                	mov    (%eax),%dl
  800b2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2e:	8a 00                	mov    (%eax),%al
  800b30:	38 c2                	cmp    %al,%dl
  800b32:	74 e3                	je     800b17 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	8a 00                	mov    (%eax),%al
  800b39:	0f b6 d0             	movzbl %al,%edx
  800b3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3f:	8a 00                	mov    (%eax),%al
  800b41:	0f b6 c0             	movzbl %al,%eax
  800b44:	29 c2                	sub    %eax,%edx
  800b46:	89 d0                	mov    %edx,%eax
}
  800b48:	5d                   	pop    %ebp
  800b49:	c3                   	ret    

00800b4a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800b4a:	55                   	push   %ebp
  800b4b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800b4d:	eb 09                	jmp    800b58 <strncmp+0xe>
		n--, p++, q++;
  800b4f:	ff 4d 10             	decl   0x10(%ebp)
  800b52:	ff 45 08             	incl   0x8(%ebp)
  800b55:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b58:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b5c:	74 17                	je     800b75 <strncmp+0x2b>
  800b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b61:	8a 00                	mov    (%eax),%al
  800b63:	84 c0                	test   %al,%al
  800b65:	74 0e                	je     800b75 <strncmp+0x2b>
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	8a 10                	mov    (%eax),%dl
  800b6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6f:	8a 00                	mov    (%eax),%al
  800b71:	38 c2                	cmp    %al,%dl
  800b73:	74 da                	je     800b4f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b75:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b79:	75 07                	jne    800b82 <strncmp+0x38>
		return 0;
  800b7b:	b8 00 00 00 00       	mov    $0x0,%eax
  800b80:	eb 14                	jmp    800b96 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	8a 00                	mov    (%eax),%al
  800b87:	0f b6 d0             	movzbl %al,%edx
  800b8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8d:	8a 00                	mov    (%eax),%al
  800b8f:	0f b6 c0             	movzbl %al,%eax
  800b92:	29 c2                	sub    %eax,%edx
  800b94:	89 d0                	mov    %edx,%eax
}
  800b96:	5d                   	pop    %ebp
  800b97:	c3                   	ret    

00800b98 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b98:	55                   	push   %ebp
  800b99:	89 e5                	mov    %esp,%ebp
  800b9b:	83 ec 04             	sub    $0x4,%esp
  800b9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ba4:	eb 12                	jmp    800bb8 <strchr+0x20>
		if (*s == c)
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba9:	8a 00                	mov    (%eax),%al
  800bab:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800bae:	75 05                	jne    800bb5 <strchr+0x1d>
			return (char *) s;
  800bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb3:	eb 11                	jmp    800bc6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800bb5:	ff 45 08             	incl   0x8(%ebp)
  800bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbb:	8a 00                	mov    (%eax),%al
  800bbd:	84 c0                	test   %al,%al
  800bbf:	75 e5                	jne    800ba6 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800bc1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bc6:	c9                   	leave  
  800bc7:	c3                   	ret    

00800bc8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800bc8:	55                   	push   %ebp
  800bc9:	89 e5                	mov    %esp,%ebp
  800bcb:	83 ec 04             	sub    $0x4,%esp
  800bce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800bd4:	eb 0d                	jmp    800be3 <strfind+0x1b>
		if (*s == c)
  800bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd9:	8a 00                	mov    (%eax),%al
  800bdb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800bde:	74 0e                	je     800bee <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800be0:	ff 45 08             	incl   0x8(%ebp)
  800be3:	8b 45 08             	mov    0x8(%ebp),%eax
  800be6:	8a 00                	mov    (%eax),%al
  800be8:	84 c0                	test   %al,%al
  800bea:	75 ea                	jne    800bd6 <strfind+0xe>
  800bec:	eb 01                	jmp    800bef <strfind+0x27>
		if (*s == c)
			break;
  800bee:	90                   	nop
	return (char *) s;
  800bef:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bf2:	c9                   	leave  
  800bf3:	c3                   	ret    

00800bf4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800bf4:	55                   	push   %ebp
  800bf5:	89 e5                	mov    %esp,%ebp
  800bf7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800c00:	8b 45 10             	mov    0x10(%ebp),%eax
  800c03:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800c06:	eb 0e                	jmp    800c16 <memset+0x22>
		*p++ = c;
  800c08:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0b:	8d 50 01             	lea    0x1(%eax),%edx
  800c0e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800c11:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c14:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800c16:	ff 4d f8             	decl   -0x8(%ebp)
  800c19:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800c1d:	79 e9                	jns    800c08 <memset+0x14>
		*p++ = c;

	return v;
  800c1f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c22:	c9                   	leave  
  800c23:	c3                   	ret    

00800c24 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800c24:	55                   	push   %ebp
  800c25:	89 e5                	mov    %esp,%ebp
  800c27:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c30:	8b 45 08             	mov    0x8(%ebp),%eax
  800c33:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800c36:	eb 16                	jmp    800c4e <memcpy+0x2a>
		*d++ = *s++;
  800c38:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c3b:	8d 50 01             	lea    0x1(%eax),%edx
  800c3e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c41:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c44:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c47:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c4a:	8a 12                	mov    (%edx),%dl
  800c4c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c51:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c54:	89 55 10             	mov    %edx,0x10(%ebp)
  800c57:	85 c0                	test   %eax,%eax
  800c59:	75 dd                	jne    800c38 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c5e:	c9                   	leave  
  800c5f:	c3                   	ret    

00800c60 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c60:	55                   	push   %ebp
  800c61:	89 e5                	mov    %esp,%ebp
  800c63:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c69:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c72:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c75:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c78:	73 50                	jae    800cca <memmove+0x6a>
  800c7a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c80:	01 d0                	add    %edx,%eax
  800c82:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c85:	76 43                	jbe    800cca <memmove+0x6a>
		s += n;
  800c87:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c90:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c93:	eb 10                	jmp    800ca5 <memmove+0x45>
			*--d = *--s;
  800c95:	ff 4d f8             	decl   -0x8(%ebp)
  800c98:	ff 4d fc             	decl   -0x4(%ebp)
  800c9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c9e:	8a 10                	mov    (%eax),%dl
  800ca0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ca3:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ca5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cab:	89 55 10             	mov    %edx,0x10(%ebp)
  800cae:	85 c0                	test   %eax,%eax
  800cb0:	75 e3                	jne    800c95 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800cb2:	eb 23                	jmp    800cd7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800cb4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cb7:	8d 50 01             	lea    0x1(%eax),%edx
  800cba:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800cbd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800cc0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cc3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800cc6:	8a 12                	mov    (%edx),%dl
  800cc8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800cca:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cd0:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd3:	85 c0                	test   %eax,%eax
  800cd5:	75 dd                	jne    800cb4 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cda:	c9                   	leave  
  800cdb:	c3                   	ret    

00800cdc <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800cdc:	55                   	push   %ebp
  800cdd:	89 e5                	mov    %esp,%ebp
  800cdf:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ce8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ceb:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800cee:	eb 2a                	jmp    800d1a <memcmp+0x3e>
		if (*s1 != *s2)
  800cf0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf3:	8a 10                	mov    (%eax),%dl
  800cf5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cf8:	8a 00                	mov    (%eax),%al
  800cfa:	38 c2                	cmp    %al,%dl
  800cfc:	74 16                	je     800d14 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d01:	8a 00                	mov    (%eax),%al
  800d03:	0f b6 d0             	movzbl %al,%edx
  800d06:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	0f b6 c0             	movzbl %al,%eax
  800d0e:	29 c2                	sub    %eax,%edx
  800d10:	89 d0                	mov    %edx,%eax
  800d12:	eb 18                	jmp    800d2c <memcmp+0x50>
		s1++, s2++;
  800d14:	ff 45 fc             	incl   -0x4(%ebp)
  800d17:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800d1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d1d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d20:	89 55 10             	mov    %edx,0x10(%ebp)
  800d23:	85 c0                	test   %eax,%eax
  800d25:	75 c9                	jne    800cf0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800d27:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d2c:	c9                   	leave  
  800d2d:	c3                   	ret    

00800d2e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800d2e:	55                   	push   %ebp
  800d2f:	89 e5                	mov    %esp,%ebp
  800d31:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800d34:	8b 55 08             	mov    0x8(%ebp),%edx
  800d37:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3a:	01 d0                	add    %edx,%eax
  800d3c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800d3f:	eb 15                	jmp    800d56 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800d41:	8b 45 08             	mov    0x8(%ebp),%eax
  800d44:	8a 00                	mov    (%eax),%al
  800d46:	0f b6 d0             	movzbl %al,%edx
  800d49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4c:	0f b6 c0             	movzbl %al,%eax
  800d4f:	39 c2                	cmp    %eax,%edx
  800d51:	74 0d                	je     800d60 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d53:	ff 45 08             	incl   0x8(%ebp)
  800d56:	8b 45 08             	mov    0x8(%ebp),%eax
  800d59:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d5c:	72 e3                	jb     800d41 <memfind+0x13>
  800d5e:	eb 01                	jmp    800d61 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d60:	90                   	nop
	return (void *) s;
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d64:	c9                   	leave  
  800d65:	c3                   	ret    

00800d66 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d66:	55                   	push   %ebp
  800d67:	89 e5                	mov    %esp,%ebp
  800d69:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d6c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d73:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d7a:	eb 03                	jmp    800d7f <strtol+0x19>
		s++;
  800d7c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	8a 00                	mov    (%eax),%al
  800d84:	3c 20                	cmp    $0x20,%al
  800d86:	74 f4                	je     800d7c <strtol+0x16>
  800d88:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8b:	8a 00                	mov    (%eax),%al
  800d8d:	3c 09                	cmp    $0x9,%al
  800d8f:	74 eb                	je     800d7c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	8a 00                	mov    (%eax),%al
  800d96:	3c 2b                	cmp    $0x2b,%al
  800d98:	75 05                	jne    800d9f <strtol+0x39>
		s++;
  800d9a:	ff 45 08             	incl   0x8(%ebp)
  800d9d:	eb 13                	jmp    800db2 <strtol+0x4c>
	else if (*s == '-')
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	8a 00                	mov    (%eax),%al
  800da4:	3c 2d                	cmp    $0x2d,%al
  800da6:	75 0a                	jne    800db2 <strtol+0x4c>
		s++, neg = 1;
  800da8:	ff 45 08             	incl   0x8(%ebp)
  800dab:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800db2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db6:	74 06                	je     800dbe <strtol+0x58>
  800db8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800dbc:	75 20                	jne    800dde <strtol+0x78>
  800dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc1:	8a 00                	mov    (%eax),%al
  800dc3:	3c 30                	cmp    $0x30,%al
  800dc5:	75 17                	jne    800dde <strtol+0x78>
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	40                   	inc    %eax
  800dcb:	8a 00                	mov    (%eax),%al
  800dcd:	3c 78                	cmp    $0x78,%al
  800dcf:	75 0d                	jne    800dde <strtol+0x78>
		s += 2, base = 16;
  800dd1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800dd5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ddc:	eb 28                	jmp    800e06 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800dde:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800de2:	75 15                	jne    800df9 <strtol+0x93>
  800de4:	8b 45 08             	mov    0x8(%ebp),%eax
  800de7:	8a 00                	mov    (%eax),%al
  800de9:	3c 30                	cmp    $0x30,%al
  800deb:	75 0c                	jne    800df9 <strtol+0x93>
		s++, base = 8;
  800ded:	ff 45 08             	incl   0x8(%ebp)
  800df0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800df7:	eb 0d                	jmp    800e06 <strtol+0xa0>
	else if (base == 0)
  800df9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dfd:	75 07                	jne    800e06 <strtol+0xa0>
		base = 10;
  800dff:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800e06:	8b 45 08             	mov    0x8(%ebp),%eax
  800e09:	8a 00                	mov    (%eax),%al
  800e0b:	3c 2f                	cmp    $0x2f,%al
  800e0d:	7e 19                	jle    800e28 <strtol+0xc2>
  800e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e12:	8a 00                	mov    (%eax),%al
  800e14:	3c 39                	cmp    $0x39,%al
  800e16:	7f 10                	jg     800e28 <strtol+0xc2>
			dig = *s - '0';
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	8a 00                	mov    (%eax),%al
  800e1d:	0f be c0             	movsbl %al,%eax
  800e20:	83 e8 30             	sub    $0x30,%eax
  800e23:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e26:	eb 42                	jmp    800e6a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	8a 00                	mov    (%eax),%al
  800e2d:	3c 60                	cmp    $0x60,%al
  800e2f:	7e 19                	jle    800e4a <strtol+0xe4>
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	8a 00                	mov    (%eax),%al
  800e36:	3c 7a                	cmp    $0x7a,%al
  800e38:	7f 10                	jg     800e4a <strtol+0xe4>
			dig = *s - 'a' + 10;
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3d:	8a 00                	mov    (%eax),%al
  800e3f:	0f be c0             	movsbl %al,%eax
  800e42:	83 e8 57             	sub    $0x57,%eax
  800e45:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e48:	eb 20                	jmp    800e6a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4d:	8a 00                	mov    (%eax),%al
  800e4f:	3c 40                	cmp    $0x40,%al
  800e51:	7e 39                	jle    800e8c <strtol+0x126>
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
  800e56:	8a 00                	mov    (%eax),%al
  800e58:	3c 5a                	cmp    $0x5a,%al
  800e5a:	7f 30                	jg     800e8c <strtol+0x126>
			dig = *s - 'A' + 10;
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	8a 00                	mov    (%eax),%al
  800e61:	0f be c0             	movsbl %al,%eax
  800e64:	83 e8 37             	sub    $0x37,%eax
  800e67:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e6d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e70:	7d 19                	jge    800e8b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e72:	ff 45 08             	incl   0x8(%ebp)
  800e75:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e78:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e7c:	89 c2                	mov    %eax,%edx
  800e7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e81:	01 d0                	add    %edx,%eax
  800e83:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e86:	e9 7b ff ff ff       	jmp    800e06 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e8b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e8c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e90:	74 08                	je     800e9a <strtol+0x134>
		*endptr = (char *) s;
  800e92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e95:	8b 55 08             	mov    0x8(%ebp),%edx
  800e98:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e9a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e9e:	74 07                	je     800ea7 <strtol+0x141>
  800ea0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea3:	f7 d8                	neg    %eax
  800ea5:	eb 03                	jmp    800eaa <strtol+0x144>
  800ea7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800eaa:	c9                   	leave  
  800eab:	c3                   	ret    

00800eac <ltostr>:

void
ltostr(long value, char *str)
{
  800eac:	55                   	push   %ebp
  800ead:	89 e5                	mov    %esp,%ebp
  800eaf:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800eb2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800eb9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800ec0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ec4:	79 13                	jns    800ed9 <ltostr+0x2d>
	{
		neg = 1;
  800ec6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ecd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800ed3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800ed6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ee1:	99                   	cltd   
  800ee2:	f7 f9                	idiv   %ecx
  800ee4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ee7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eea:	8d 50 01             	lea    0x1(%eax),%edx
  800eed:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ef0:	89 c2                	mov    %eax,%edx
  800ef2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef5:	01 d0                	add    %edx,%eax
  800ef7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800efa:	83 c2 30             	add    $0x30,%edx
  800efd:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800eff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f02:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f07:	f7 e9                	imul   %ecx
  800f09:	c1 fa 02             	sar    $0x2,%edx
  800f0c:	89 c8                	mov    %ecx,%eax
  800f0e:	c1 f8 1f             	sar    $0x1f,%eax
  800f11:	29 c2                	sub    %eax,%edx
  800f13:	89 d0                	mov    %edx,%eax
  800f15:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800f18:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f1b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f20:	f7 e9                	imul   %ecx
  800f22:	c1 fa 02             	sar    $0x2,%edx
  800f25:	89 c8                	mov    %ecx,%eax
  800f27:	c1 f8 1f             	sar    $0x1f,%eax
  800f2a:	29 c2                	sub    %eax,%edx
  800f2c:	89 d0                	mov    %edx,%eax
  800f2e:	c1 e0 02             	shl    $0x2,%eax
  800f31:	01 d0                	add    %edx,%eax
  800f33:	01 c0                	add    %eax,%eax
  800f35:	29 c1                	sub    %eax,%ecx
  800f37:	89 ca                	mov    %ecx,%edx
  800f39:	85 d2                	test   %edx,%edx
  800f3b:	75 9c                	jne    800ed9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800f3d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800f44:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f47:	48                   	dec    %eax
  800f48:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800f4b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f4f:	74 3d                	je     800f8e <ltostr+0xe2>
		start = 1 ;
  800f51:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f58:	eb 34                	jmp    800f8e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f60:	01 d0                	add    %edx,%eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f67:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6d:	01 c2                	add    %eax,%edx
  800f6f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f75:	01 c8                	add    %ecx,%eax
  800f77:	8a 00                	mov    (%eax),%al
  800f79:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f7b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f81:	01 c2                	add    %eax,%edx
  800f83:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f86:	88 02                	mov    %al,(%edx)
		start++ ;
  800f88:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f8b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f91:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f94:	7c c4                	jl     800f5a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f96:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9c:	01 d0                	add    %edx,%eax
  800f9e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800fa1:	90                   	nop
  800fa2:	c9                   	leave  
  800fa3:	c3                   	ret    

00800fa4 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800fa4:	55                   	push   %ebp
  800fa5:	89 e5                	mov    %esp,%ebp
  800fa7:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800faa:	ff 75 08             	pushl  0x8(%ebp)
  800fad:	e8 54 fa ff ff       	call   800a06 <strlen>
  800fb2:	83 c4 04             	add    $0x4,%esp
  800fb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800fb8:	ff 75 0c             	pushl  0xc(%ebp)
  800fbb:	e8 46 fa ff ff       	call   800a06 <strlen>
  800fc0:	83 c4 04             	add    $0x4,%esp
  800fc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800fc6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800fcd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fd4:	eb 17                	jmp    800fed <strcconcat+0x49>
		final[s] = str1[s] ;
  800fd6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdc:	01 c2                	add    %eax,%edx
  800fde:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe4:	01 c8                	add    %ecx,%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800fea:	ff 45 fc             	incl   -0x4(%ebp)
  800fed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ff3:	7c e1                	jl     800fd6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ff5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ffc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801003:	eb 1f                	jmp    801024 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801005:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801008:	8d 50 01             	lea    0x1(%eax),%edx
  80100b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80100e:	89 c2                	mov    %eax,%edx
  801010:	8b 45 10             	mov    0x10(%ebp),%eax
  801013:	01 c2                	add    %eax,%edx
  801015:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801018:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101b:	01 c8                	add    %ecx,%eax
  80101d:	8a 00                	mov    (%eax),%al
  80101f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801021:	ff 45 f8             	incl   -0x8(%ebp)
  801024:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801027:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80102a:	7c d9                	jl     801005 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80102c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80102f:	8b 45 10             	mov    0x10(%ebp),%eax
  801032:	01 d0                	add    %edx,%eax
  801034:	c6 00 00             	movb   $0x0,(%eax)
}
  801037:	90                   	nop
  801038:	c9                   	leave  
  801039:	c3                   	ret    

0080103a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80103a:	55                   	push   %ebp
  80103b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80103d:	8b 45 14             	mov    0x14(%ebp),%eax
  801040:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801046:	8b 45 14             	mov    0x14(%ebp),%eax
  801049:	8b 00                	mov    (%eax),%eax
  80104b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801052:	8b 45 10             	mov    0x10(%ebp),%eax
  801055:	01 d0                	add    %edx,%eax
  801057:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80105d:	eb 0c                	jmp    80106b <strsplit+0x31>
			*string++ = 0;
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
  801062:	8d 50 01             	lea    0x1(%eax),%edx
  801065:	89 55 08             	mov    %edx,0x8(%ebp)
  801068:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	8a 00                	mov    (%eax),%al
  801070:	84 c0                	test   %al,%al
  801072:	74 18                	je     80108c <strsplit+0x52>
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	8a 00                	mov    (%eax),%al
  801079:	0f be c0             	movsbl %al,%eax
  80107c:	50                   	push   %eax
  80107d:	ff 75 0c             	pushl  0xc(%ebp)
  801080:	e8 13 fb ff ff       	call   800b98 <strchr>
  801085:	83 c4 08             	add    $0x8,%esp
  801088:	85 c0                	test   %eax,%eax
  80108a:	75 d3                	jne    80105f <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	8a 00                	mov    (%eax),%al
  801091:	84 c0                	test   %al,%al
  801093:	74 5a                	je     8010ef <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801095:	8b 45 14             	mov    0x14(%ebp),%eax
  801098:	8b 00                	mov    (%eax),%eax
  80109a:	83 f8 0f             	cmp    $0xf,%eax
  80109d:	75 07                	jne    8010a6 <strsplit+0x6c>
		{
			return 0;
  80109f:	b8 00 00 00 00       	mov    $0x0,%eax
  8010a4:	eb 66                	jmp    80110c <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8010a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a9:	8b 00                	mov    (%eax),%eax
  8010ab:	8d 48 01             	lea    0x1(%eax),%ecx
  8010ae:	8b 55 14             	mov    0x14(%ebp),%edx
  8010b1:	89 0a                	mov    %ecx,(%edx)
  8010b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8010bd:	01 c2                	add    %eax,%edx
  8010bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010c4:	eb 03                	jmp    8010c9 <strsplit+0x8f>
			string++;
  8010c6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cc:	8a 00                	mov    (%eax),%al
  8010ce:	84 c0                	test   %al,%al
  8010d0:	74 8b                	je     80105d <strsplit+0x23>
  8010d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d5:	8a 00                	mov    (%eax),%al
  8010d7:	0f be c0             	movsbl %al,%eax
  8010da:	50                   	push   %eax
  8010db:	ff 75 0c             	pushl  0xc(%ebp)
  8010de:	e8 b5 fa ff ff       	call   800b98 <strchr>
  8010e3:	83 c4 08             	add    $0x8,%esp
  8010e6:	85 c0                	test   %eax,%eax
  8010e8:	74 dc                	je     8010c6 <strsplit+0x8c>
			string++;
	}
  8010ea:	e9 6e ff ff ff       	jmp    80105d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8010ef:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8010f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8010f3:	8b 00                	mov    (%eax),%eax
  8010f5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ff:	01 d0                	add    %edx,%eax
  801101:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801107:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80110c:	c9                   	leave  
  80110d:	c3                   	ret    

0080110e <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  80110e:	55                   	push   %ebp
  80110f:	89 e5                	mov    %esp,%ebp
  801111:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801114:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  80111b:	76 0a                	jbe    801127 <malloc+0x19>
		return NULL;
  80111d:	b8 00 00 00 00       	mov    $0x0,%eax
  801122:	e9 ad 02 00 00       	jmp    8013d4 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	c1 e8 0c             	shr    $0xc,%eax
  80112d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	25 ff 0f 00 00       	and    $0xfff,%eax
  801138:	85 c0                	test   %eax,%eax
  80113a:	74 03                	je     80113f <malloc+0x31>
		num++;
  80113c:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  80113f:	a1 28 30 80 00       	mov    0x803028,%eax
  801144:	85 c0                	test   %eax,%eax
  801146:	75 71                	jne    8011b9 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801148:	a1 04 30 80 00       	mov    0x803004,%eax
  80114d:	83 ec 08             	sub    $0x8,%esp
  801150:	ff 75 08             	pushl  0x8(%ebp)
  801153:	50                   	push   %eax
  801154:	e8 ba 05 00 00       	call   801713 <sys_allocateMem>
  801159:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  80115c:	a1 04 30 80 00       	mov    0x803004,%eax
  801161:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  801164:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801167:	c1 e0 0c             	shl    $0xc,%eax
  80116a:	89 c2                	mov    %eax,%edx
  80116c:	a1 04 30 80 00       	mov    0x803004,%eax
  801171:	01 d0                	add    %edx,%eax
  801173:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801178:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80117d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801180:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801187:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80118c:	8b 55 c8             	mov    -0x38(%ebp),%edx
  80118f:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  801196:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80119b:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8011a2:	01 00 00 00 
		sizeofarray++;
  8011a6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8011ab:	40                   	inc    %eax
  8011ac:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  8011b1:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8011b4:	e9 1b 02 00 00       	jmp    8013d4 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  8011b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  8011c0:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  8011c7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  8011ce:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  8011d5:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  8011dc:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8011e3:	eb 72                	jmp    801257 <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  8011e5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8011e8:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8011ef:	85 c0                	test   %eax,%eax
  8011f1:	75 12                	jne    801205 <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  8011f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8011f6:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8011fd:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801200:	ff 45 dc             	incl   -0x24(%ebp)
  801203:	eb 4f                	jmp    801254 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801205:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801208:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80120b:	7d 39                	jge    801246 <malloc+0x138>
  80120d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801210:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801213:	7c 31                	jl     801246 <malloc+0x138>
					{
						min=count;
  801215:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801218:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  80121b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80121e:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801225:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801228:	c1 e2 0c             	shl    $0xc,%edx
  80122b:	29 d0                	sub    %edx,%eax
  80122d:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801230:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801233:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801236:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801239:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801240:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801243:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801246:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  80124d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801254:	ff 45 d4             	incl   -0x2c(%ebp)
  801257:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80125c:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  80125f:	7c 84                	jl     8011e5 <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801261:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801265:	0f 85 e3 00 00 00    	jne    80134e <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  80126b:	83 ec 08             	sub    $0x8,%esp
  80126e:	ff 75 08             	pushl  0x8(%ebp)
  801271:	ff 75 e0             	pushl  -0x20(%ebp)
  801274:	e8 9a 04 00 00       	call   801713 <sys_allocateMem>
  801279:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  80127c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801281:	40                   	inc    %eax
  801282:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  801287:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80128c:	48                   	dec    %eax
  80128d:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801290:	eb 42                	jmp    8012d4 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801292:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801295:	48                   	dec    %eax
  801296:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  80129d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8012a0:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  8012a7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8012aa:	48                   	dec    %eax
  8012ab:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  8012b2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8012b5:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  8012bc:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8012bf:	48                   	dec    %eax
  8012c0:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  8012c7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8012ca:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  8012d1:	ff 4d d0             	decl   -0x30(%ebp)
  8012d4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8012d7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8012da:	7f b6                	jg     801292 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  8012dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8012df:	40                   	inc    %eax
  8012e0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  8012e3:	8b 55 08             	mov    0x8(%ebp),%edx
  8012e6:	01 ca                	add    %ecx,%edx
  8012e8:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  8012ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8012f2:	8d 50 01             	lea    0x1(%eax),%edx
  8012f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8012f8:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8012ff:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801302:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801309:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80130c:	40                   	inc    %eax
  80130d:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801314:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801318:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80131b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80131e:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801325:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801328:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80132b:	eb 11                	jmp    80133e <malloc+0x230>
				{
					changed[index] = 1;
  80132d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801330:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801337:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  80133b:	ff 45 cc             	incl   -0x34(%ebp)
  80133e:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801341:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801344:	7c e7                	jl     80132d <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801346:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801349:	e9 86 00 00 00       	jmp    8013d4 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  80134e:	a1 04 30 80 00       	mov    0x803004,%eax
  801353:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801358:	29 c2                	sub    %eax,%edx
  80135a:	89 d0                	mov    %edx,%eax
  80135c:	3b 45 08             	cmp    0x8(%ebp),%eax
  80135f:	73 07                	jae    801368 <malloc+0x25a>
						return NULL;
  801361:	b8 00 00 00 00       	mov    $0x0,%eax
  801366:	eb 6c                	jmp    8013d4 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801368:	a1 04 30 80 00       	mov    0x803004,%eax
  80136d:	83 ec 08             	sub    $0x8,%esp
  801370:	ff 75 08             	pushl  0x8(%ebp)
  801373:	50                   	push   %eax
  801374:	e8 9a 03 00 00       	call   801713 <sys_allocateMem>
  801379:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  80137c:	a1 04 30 80 00       	mov    0x803004,%eax
  801381:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801384:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801387:	c1 e0 0c             	shl    $0xc,%eax
  80138a:	89 c2                	mov    %eax,%edx
  80138c:	a1 04 30 80 00       	mov    0x803004,%eax
  801391:	01 d0                	add    %edx,%eax
  801393:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801398:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80139d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013a0:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  8013a7:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013ac:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8013af:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  8013b6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013bb:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8013c2:	01 00 00 00 
					sizeofarray++;
  8013c6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013cb:	40                   	inc    %eax
  8013cc:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  8013d1:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  8013d4:	c9                   	leave  
  8013d5:	c3                   	ret    

008013d6 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
  8013d9:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  8013e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8013e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8013f0:	eb 30                	jmp    801422 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  8013f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013f5:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8013fc:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8013ff:	75 1e                	jne    80141f <free+0x49>
  801401:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801404:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  80140b:	83 f8 01             	cmp    $0x1,%eax
  80140e:	75 0f                	jne    80141f <free+0x49>
			is_found = 1;
  801410:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801417:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80141a:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  80141d:	eb 0d                	jmp    80142c <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  80141f:	ff 45 ec             	incl   -0x14(%ebp)
  801422:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801427:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  80142a:	7c c6                	jl     8013f2 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  80142c:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801430:	75 3a                	jne    80146c <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801432:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801435:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  80143c:	c1 e0 0c             	shl    $0xc,%eax
  80143f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801442:	83 ec 08             	sub    $0x8,%esp
  801445:	ff 75 e4             	pushl  -0x1c(%ebp)
  801448:	ff 75 e8             	pushl  -0x18(%ebp)
  80144b:	e8 a7 02 00 00       	call   8016f7 <sys_freeMem>
  801450:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801453:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801456:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  80145d:	00 00 00 00 
		changes++;
  801461:	a1 28 30 80 00       	mov    0x803028,%eax
  801466:	40                   	inc    %eax
  801467:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  80146c:	90                   	nop
  80146d:	c9                   	leave  
  80146e:	c3                   	ret    

0080146f <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  80146f:	55                   	push   %ebp
  801470:	89 e5                	mov    %esp,%ebp
  801472:	83 ec 18             	sub    $0x18,%esp
  801475:	8b 45 10             	mov    0x10(%ebp),%eax
  801478:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80147b:	83 ec 04             	sub    $0x4,%esp
  80147e:	68 10 25 80 00       	push   $0x802510
  801483:	68 b6 00 00 00       	push   $0xb6
  801488:	68 33 25 80 00       	push   $0x802533
  80148d:	e8 bf 07 00 00       	call   801c51 <_panic>

00801492 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801492:	55                   	push   %ebp
  801493:	89 e5                	mov    %esp,%ebp
  801495:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801498:	83 ec 04             	sub    $0x4,%esp
  80149b:	68 10 25 80 00       	push   $0x802510
  8014a0:	68 bb 00 00 00       	push   $0xbb
  8014a5:	68 33 25 80 00       	push   $0x802533
  8014aa:	e8 a2 07 00 00       	call   801c51 <_panic>

008014af <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  8014af:	55                   	push   %ebp
  8014b0:	89 e5                	mov    %esp,%ebp
  8014b2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014b5:	83 ec 04             	sub    $0x4,%esp
  8014b8:	68 10 25 80 00       	push   $0x802510
  8014bd:	68 c0 00 00 00       	push   $0xc0
  8014c2:	68 33 25 80 00       	push   $0x802533
  8014c7:	e8 85 07 00 00       	call   801c51 <_panic>

008014cc <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  8014cc:	55                   	push   %ebp
  8014cd:	89 e5                	mov    %esp,%ebp
  8014cf:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014d2:	83 ec 04             	sub    $0x4,%esp
  8014d5:	68 10 25 80 00       	push   $0x802510
  8014da:	68 c4 00 00 00       	push   $0xc4
  8014df:	68 33 25 80 00       	push   $0x802533
  8014e4:	e8 68 07 00 00       	call   801c51 <_panic>

008014e9 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014ef:	83 ec 04             	sub    $0x4,%esp
  8014f2:	68 10 25 80 00       	push   $0x802510
  8014f7:	68 c9 00 00 00       	push   $0xc9
  8014fc:	68 33 25 80 00       	push   $0x802533
  801501:	e8 4b 07 00 00       	call   801c51 <_panic>

00801506 <shrink>:
}
void shrink(uint32 newSize) {
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
  801509:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80150c:	83 ec 04             	sub    $0x4,%esp
  80150f:	68 10 25 80 00       	push   $0x802510
  801514:	68 cc 00 00 00       	push   $0xcc
  801519:	68 33 25 80 00       	push   $0x802533
  80151e:	e8 2e 07 00 00       	call   801c51 <_panic>

00801523 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801523:	55                   	push   %ebp
  801524:	89 e5                	mov    %esp,%ebp
  801526:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801529:	83 ec 04             	sub    $0x4,%esp
  80152c:	68 10 25 80 00       	push   $0x802510
  801531:	68 d0 00 00 00       	push   $0xd0
  801536:	68 33 25 80 00       	push   $0x802533
  80153b:	e8 11 07 00 00       	call   801c51 <_panic>

00801540 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801540:	55                   	push   %ebp
  801541:	89 e5                	mov    %esp,%ebp
  801543:	57                   	push   %edi
  801544:	56                   	push   %esi
  801545:	53                   	push   %ebx
  801546:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801549:	8b 45 08             	mov    0x8(%ebp),%eax
  80154c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801552:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801555:	8b 7d 18             	mov    0x18(%ebp),%edi
  801558:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80155b:	cd 30                	int    $0x30
  80155d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801560:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801563:	83 c4 10             	add    $0x10,%esp
  801566:	5b                   	pop    %ebx
  801567:	5e                   	pop    %esi
  801568:	5f                   	pop    %edi
  801569:	5d                   	pop    %ebp
  80156a:	c3                   	ret    

0080156b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80156b:	55                   	push   %ebp
  80156c:	89 e5                	mov    %esp,%ebp
  80156e:	83 ec 04             	sub    $0x4,%esp
  801571:	8b 45 10             	mov    0x10(%ebp),%eax
  801574:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801577:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80157b:	8b 45 08             	mov    0x8(%ebp),%eax
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	52                   	push   %edx
  801583:	ff 75 0c             	pushl  0xc(%ebp)
  801586:	50                   	push   %eax
  801587:	6a 00                	push   $0x0
  801589:	e8 b2 ff ff ff       	call   801540 <syscall>
  80158e:	83 c4 18             	add    $0x18,%esp
}
  801591:	90                   	nop
  801592:	c9                   	leave  
  801593:	c3                   	ret    

00801594 <sys_cgetc>:

int
sys_cgetc(void)
{
  801594:	55                   	push   %ebp
  801595:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 01                	push   $0x1
  8015a3:	e8 98 ff ff ff       	call   801540 <syscall>
  8015a8:	83 c4 18             	add    $0x18,%esp
}
  8015ab:	c9                   	leave  
  8015ac:	c3                   	ret    

008015ad <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8015ad:	55                   	push   %ebp
  8015ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8015b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	50                   	push   %eax
  8015bc:	6a 05                	push   $0x5
  8015be:	e8 7d ff ff ff       	call   801540 <syscall>
  8015c3:	83 c4 18             	add    $0x18,%esp
}
  8015c6:	c9                   	leave  
  8015c7:	c3                   	ret    

008015c8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015c8:	55                   	push   %ebp
  8015c9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 02                	push   $0x2
  8015d7:	e8 64 ff ff ff       	call   801540 <syscall>
  8015dc:	83 c4 18             	add    $0x18,%esp
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 03                	push   $0x3
  8015f0:	e8 4b ff ff ff       	call   801540 <syscall>
  8015f5:	83 c4 18             	add    $0x18,%esp
}
  8015f8:	c9                   	leave  
  8015f9:	c3                   	ret    

008015fa <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015fa:	55                   	push   %ebp
  8015fb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	6a 04                	push   $0x4
  801609:	e8 32 ff ff ff       	call   801540 <syscall>
  80160e:	83 c4 18             	add    $0x18,%esp
}
  801611:	c9                   	leave  
  801612:	c3                   	ret    

00801613 <sys_env_exit>:


void sys_env_exit(void)
{
  801613:	55                   	push   %ebp
  801614:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 06                	push   $0x6
  801622:	e8 19 ff ff ff       	call   801540 <syscall>
  801627:	83 c4 18             	add    $0x18,%esp
}
  80162a:	90                   	nop
  80162b:	c9                   	leave  
  80162c:	c3                   	ret    

0080162d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80162d:	55                   	push   %ebp
  80162e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801630:	8b 55 0c             	mov    0xc(%ebp),%edx
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	52                   	push   %edx
  80163d:	50                   	push   %eax
  80163e:	6a 07                	push   $0x7
  801640:	e8 fb fe ff ff       	call   801540 <syscall>
  801645:	83 c4 18             	add    $0x18,%esp
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
  80164d:	56                   	push   %esi
  80164e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80164f:	8b 75 18             	mov    0x18(%ebp),%esi
  801652:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801655:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801658:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	56                   	push   %esi
  80165f:	53                   	push   %ebx
  801660:	51                   	push   %ecx
  801661:	52                   	push   %edx
  801662:	50                   	push   %eax
  801663:	6a 08                	push   $0x8
  801665:	e8 d6 fe ff ff       	call   801540 <syscall>
  80166a:	83 c4 18             	add    $0x18,%esp
}
  80166d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801670:	5b                   	pop    %ebx
  801671:	5e                   	pop    %esi
  801672:	5d                   	pop    %ebp
  801673:	c3                   	ret    

00801674 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801677:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	52                   	push   %edx
  801684:	50                   	push   %eax
  801685:	6a 09                	push   $0x9
  801687:	e8 b4 fe ff ff       	call   801540 <syscall>
  80168c:	83 c4 18             	add    $0x18,%esp
}
  80168f:	c9                   	leave  
  801690:	c3                   	ret    

00801691 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801691:	55                   	push   %ebp
  801692:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	ff 75 0c             	pushl  0xc(%ebp)
  80169d:	ff 75 08             	pushl  0x8(%ebp)
  8016a0:	6a 0a                	push   $0xa
  8016a2:	e8 99 fe ff ff       	call   801540 <syscall>
  8016a7:	83 c4 18             	add    $0x18,%esp
}
  8016aa:	c9                   	leave  
  8016ab:	c3                   	ret    

008016ac <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 0b                	push   $0xb
  8016bb:	e8 80 fe ff ff       	call   801540 <syscall>
  8016c0:	83 c4 18             	add    $0x18,%esp
}
  8016c3:	c9                   	leave  
  8016c4:	c3                   	ret    

008016c5 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016c5:	55                   	push   %ebp
  8016c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 0c                	push   $0xc
  8016d4:	e8 67 fe ff ff       	call   801540 <syscall>
  8016d9:	83 c4 18             	add    $0x18,%esp
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 0d                	push   $0xd
  8016ed:	e8 4e fe ff ff       	call   801540 <syscall>
  8016f2:	83 c4 18             	add    $0x18,%esp
}
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	ff 75 0c             	pushl  0xc(%ebp)
  801703:	ff 75 08             	pushl  0x8(%ebp)
  801706:	6a 11                	push   $0x11
  801708:	e8 33 fe ff ff       	call   801540 <syscall>
  80170d:	83 c4 18             	add    $0x18,%esp
	return;
  801710:	90                   	nop
}
  801711:	c9                   	leave  
  801712:	c3                   	ret    

00801713 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801713:	55                   	push   %ebp
  801714:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	ff 75 0c             	pushl  0xc(%ebp)
  80171f:	ff 75 08             	pushl  0x8(%ebp)
  801722:	6a 12                	push   $0x12
  801724:	e8 17 fe ff ff       	call   801540 <syscall>
  801729:	83 c4 18             	add    $0x18,%esp
	return ;
  80172c:	90                   	nop
}
  80172d:	c9                   	leave  
  80172e:	c3                   	ret    

0080172f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80172f:	55                   	push   %ebp
  801730:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 0e                	push   $0xe
  80173e:	e8 fd fd ff ff       	call   801540 <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
}
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	ff 75 08             	pushl  0x8(%ebp)
  801756:	6a 0f                	push   $0xf
  801758:	e8 e3 fd ff ff       	call   801540 <syscall>
  80175d:	83 c4 18             	add    $0x18,%esp
}
  801760:	c9                   	leave  
  801761:	c3                   	ret    

00801762 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 10                	push   $0x10
  801771:	e8 ca fd ff ff       	call   801540 <syscall>
  801776:	83 c4 18             	add    $0x18,%esp
}
  801779:	90                   	nop
  80177a:	c9                   	leave  
  80177b:	c3                   	ret    

0080177c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80177c:	55                   	push   %ebp
  80177d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 14                	push   $0x14
  80178b:	e8 b0 fd ff ff       	call   801540 <syscall>
  801790:	83 c4 18             	add    $0x18,%esp
}
  801793:	90                   	nop
  801794:	c9                   	leave  
  801795:	c3                   	ret    

00801796 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801796:	55                   	push   %ebp
  801797:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 15                	push   $0x15
  8017a5:	e8 96 fd ff ff       	call   801540 <syscall>
  8017aa:	83 c4 18             	add    $0x18,%esp
}
  8017ad:	90                   	nop
  8017ae:	c9                   	leave  
  8017af:	c3                   	ret    

008017b0 <sys_cputc>:


void
sys_cputc(const char c)
{
  8017b0:	55                   	push   %ebp
  8017b1:	89 e5                	mov    %esp,%ebp
  8017b3:	83 ec 04             	sub    $0x4,%esp
  8017b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017bc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	50                   	push   %eax
  8017c9:	6a 16                	push   $0x16
  8017cb:	e8 70 fd ff ff       	call   801540 <syscall>
  8017d0:	83 c4 18             	add    $0x18,%esp
}
  8017d3:	90                   	nop
  8017d4:	c9                   	leave  
  8017d5:	c3                   	ret    

008017d6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 17                	push   $0x17
  8017e5:	e8 56 fd ff ff       	call   801540 <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	90                   	nop
  8017ee:	c9                   	leave  
  8017ef:	c3                   	ret    

008017f0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017f0:	55                   	push   %ebp
  8017f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	ff 75 0c             	pushl  0xc(%ebp)
  8017ff:	50                   	push   %eax
  801800:	6a 18                	push   $0x18
  801802:	e8 39 fd ff ff       	call   801540 <syscall>
  801807:	83 c4 18             	add    $0x18,%esp
}
  80180a:	c9                   	leave  
  80180b:	c3                   	ret    

0080180c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80180c:	55                   	push   %ebp
  80180d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80180f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801812:	8b 45 08             	mov    0x8(%ebp),%eax
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	52                   	push   %edx
  80181c:	50                   	push   %eax
  80181d:	6a 1b                	push   $0x1b
  80181f:	e8 1c fd ff ff       	call   801540 <syscall>
  801824:	83 c4 18             	add    $0x18,%esp
}
  801827:	c9                   	leave  
  801828:	c3                   	ret    

00801829 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80182c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182f:	8b 45 08             	mov    0x8(%ebp),%eax
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	52                   	push   %edx
  801839:	50                   	push   %eax
  80183a:	6a 19                	push   $0x19
  80183c:	e8 ff fc ff ff       	call   801540 <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
}
  801844:	90                   	nop
  801845:	c9                   	leave  
  801846:	c3                   	ret    

00801847 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801847:	55                   	push   %ebp
  801848:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80184a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80184d:	8b 45 08             	mov    0x8(%ebp),%eax
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	52                   	push   %edx
  801857:	50                   	push   %eax
  801858:	6a 1a                	push   $0x1a
  80185a:	e8 e1 fc ff ff       	call   801540 <syscall>
  80185f:	83 c4 18             	add    $0x18,%esp
}
  801862:	90                   	nop
  801863:	c9                   	leave  
  801864:	c3                   	ret    

00801865 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801865:	55                   	push   %ebp
  801866:	89 e5                	mov    %esp,%ebp
  801868:	83 ec 04             	sub    $0x4,%esp
  80186b:	8b 45 10             	mov    0x10(%ebp),%eax
  80186e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801871:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801874:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801878:	8b 45 08             	mov    0x8(%ebp),%eax
  80187b:	6a 00                	push   $0x0
  80187d:	51                   	push   %ecx
  80187e:	52                   	push   %edx
  80187f:	ff 75 0c             	pushl  0xc(%ebp)
  801882:	50                   	push   %eax
  801883:	6a 1c                	push   $0x1c
  801885:	e8 b6 fc ff ff       	call   801540 <syscall>
  80188a:	83 c4 18             	add    $0x18,%esp
}
  80188d:	c9                   	leave  
  80188e:	c3                   	ret    

0080188f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80188f:	55                   	push   %ebp
  801890:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801892:	8b 55 0c             	mov    0xc(%ebp),%edx
  801895:	8b 45 08             	mov    0x8(%ebp),%eax
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	52                   	push   %edx
  80189f:	50                   	push   %eax
  8018a0:	6a 1d                	push   $0x1d
  8018a2:	e8 99 fc ff ff       	call   801540 <syscall>
  8018a7:	83 c4 18             	add    $0x18,%esp
}
  8018aa:	c9                   	leave  
  8018ab:	c3                   	ret    

008018ac <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8018ac:	55                   	push   %ebp
  8018ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8018af:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	51                   	push   %ecx
  8018bd:	52                   	push   %edx
  8018be:	50                   	push   %eax
  8018bf:	6a 1e                	push   $0x1e
  8018c1:	e8 7a fc ff ff       	call   801540 <syscall>
  8018c6:	83 c4 18             	add    $0x18,%esp
}
  8018c9:	c9                   	leave  
  8018ca:	c3                   	ret    

008018cb <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8018cb:	55                   	push   %ebp
  8018cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8018ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	52                   	push   %edx
  8018db:	50                   	push   %eax
  8018dc:	6a 1f                	push   $0x1f
  8018de:	e8 5d fc ff ff       	call   801540 <syscall>
  8018e3:	83 c4 18             	add    $0x18,%esp
}
  8018e6:	c9                   	leave  
  8018e7:	c3                   	ret    

008018e8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018e8:	55                   	push   %ebp
  8018e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 20                	push   $0x20
  8018f7:	e8 44 fc ff ff       	call   801540 <syscall>
  8018fc:	83 c4 18             	add    $0x18,%esp
}
  8018ff:	c9                   	leave  
  801900:	c3                   	ret    

00801901 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801901:	55                   	push   %ebp
  801902:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801904:	8b 45 08             	mov    0x8(%ebp),%eax
  801907:	6a 00                	push   $0x0
  801909:	ff 75 14             	pushl  0x14(%ebp)
  80190c:	ff 75 10             	pushl  0x10(%ebp)
  80190f:	ff 75 0c             	pushl  0xc(%ebp)
  801912:	50                   	push   %eax
  801913:	6a 21                	push   $0x21
  801915:	e8 26 fc ff ff       	call   801540 <syscall>
  80191a:	83 c4 18             	add    $0x18,%esp
}
  80191d:	c9                   	leave  
  80191e:	c3                   	ret    

0080191f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80191f:	55                   	push   %ebp
  801920:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801922:	8b 45 08             	mov    0x8(%ebp),%eax
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	50                   	push   %eax
  80192e:	6a 22                	push   $0x22
  801930:	e8 0b fc ff ff       	call   801540 <syscall>
  801935:	83 c4 18             	add    $0x18,%esp
}
  801938:	90                   	nop
  801939:	c9                   	leave  
  80193a:	c3                   	ret    

0080193b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80193b:	55                   	push   %ebp
  80193c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80193e:	8b 45 08             	mov    0x8(%ebp),%eax
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	50                   	push   %eax
  80194a:	6a 23                	push   $0x23
  80194c:	e8 ef fb ff ff       	call   801540 <syscall>
  801951:	83 c4 18             	add    $0x18,%esp
}
  801954:	90                   	nop
  801955:	c9                   	leave  
  801956:	c3                   	ret    

00801957 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801957:	55                   	push   %ebp
  801958:	89 e5                	mov    %esp,%ebp
  80195a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80195d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801960:	8d 50 04             	lea    0x4(%eax),%edx
  801963:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	52                   	push   %edx
  80196d:	50                   	push   %eax
  80196e:	6a 24                	push   $0x24
  801970:	e8 cb fb ff ff       	call   801540 <syscall>
  801975:	83 c4 18             	add    $0x18,%esp
	return result;
  801978:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80197b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80197e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801981:	89 01                	mov    %eax,(%ecx)
  801983:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801986:	8b 45 08             	mov    0x8(%ebp),%eax
  801989:	c9                   	leave  
  80198a:	c2 04 00             	ret    $0x4

0080198d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80198d:	55                   	push   %ebp
  80198e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	ff 75 10             	pushl  0x10(%ebp)
  801997:	ff 75 0c             	pushl  0xc(%ebp)
  80199a:	ff 75 08             	pushl  0x8(%ebp)
  80199d:	6a 13                	push   $0x13
  80199f:	e8 9c fb ff ff       	call   801540 <syscall>
  8019a4:	83 c4 18             	add    $0x18,%esp
	return ;
  8019a7:	90                   	nop
}
  8019a8:	c9                   	leave  
  8019a9:	c3                   	ret    

008019aa <sys_rcr2>:
uint32 sys_rcr2()
{
  8019aa:	55                   	push   %ebp
  8019ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 25                	push   $0x25
  8019b9:	e8 82 fb ff ff       	call   801540 <syscall>
  8019be:	83 c4 18             	add    $0x18,%esp
}
  8019c1:	c9                   	leave  
  8019c2:	c3                   	ret    

008019c3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8019c3:	55                   	push   %ebp
  8019c4:	89 e5                	mov    %esp,%ebp
  8019c6:	83 ec 04             	sub    $0x4,%esp
  8019c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019cf:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	50                   	push   %eax
  8019dc:	6a 26                	push   $0x26
  8019de:	e8 5d fb ff ff       	call   801540 <syscall>
  8019e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e6:	90                   	nop
}
  8019e7:	c9                   	leave  
  8019e8:	c3                   	ret    

008019e9 <rsttst>:
void rsttst()
{
  8019e9:	55                   	push   %ebp
  8019ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 28                	push   $0x28
  8019f8:	e8 43 fb ff ff       	call   801540 <syscall>
  8019fd:	83 c4 18             	add    $0x18,%esp
	return ;
  801a00:	90                   	nop
}
  801a01:	c9                   	leave  
  801a02:	c3                   	ret    

00801a03 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a03:	55                   	push   %ebp
  801a04:	89 e5                	mov    %esp,%ebp
  801a06:	83 ec 04             	sub    $0x4,%esp
  801a09:	8b 45 14             	mov    0x14(%ebp),%eax
  801a0c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a0f:	8b 55 18             	mov    0x18(%ebp),%edx
  801a12:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a16:	52                   	push   %edx
  801a17:	50                   	push   %eax
  801a18:	ff 75 10             	pushl  0x10(%ebp)
  801a1b:	ff 75 0c             	pushl  0xc(%ebp)
  801a1e:	ff 75 08             	pushl  0x8(%ebp)
  801a21:	6a 27                	push   $0x27
  801a23:	e8 18 fb ff ff       	call   801540 <syscall>
  801a28:	83 c4 18             	add    $0x18,%esp
	return ;
  801a2b:	90                   	nop
}
  801a2c:	c9                   	leave  
  801a2d:	c3                   	ret    

00801a2e <chktst>:
void chktst(uint32 n)
{
  801a2e:	55                   	push   %ebp
  801a2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a31:	6a 00                	push   $0x0
  801a33:	6a 00                	push   $0x0
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	ff 75 08             	pushl  0x8(%ebp)
  801a3c:	6a 29                	push   $0x29
  801a3e:	e8 fd fa ff ff       	call   801540 <syscall>
  801a43:	83 c4 18             	add    $0x18,%esp
	return ;
  801a46:	90                   	nop
}
  801a47:	c9                   	leave  
  801a48:	c3                   	ret    

00801a49 <inctst>:

void inctst()
{
  801a49:	55                   	push   %ebp
  801a4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 2a                	push   $0x2a
  801a58:	e8 e3 fa ff ff       	call   801540 <syscall>
  801a5d:	83 c4 18             	add    $0x18,%esp
	return ;
  801a60:	90                   	nop
}
  801a61:	c9                   	leave  
  801a62:	c3                   	ret    

00801a63 <gettst>:
uint32 gettst()
{
  801a63:	55                   	push   %ebp
  801a64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	6a 00                	push   $0x0
  801a6c:	6a 00                	push   $0x0
  801a6e:	6a 00                	push   $0x0
  801a70:	6a 2b                	push   $0x2b
  801a72:	e8 c9 fa ff ff       	call   801540 <syscall>
  801a77:	83 c4 18             	add    $0x18,%esp
}
  801a7a:	c9                   	leave  
  801a7b:	c3                   	ret    

00801a7c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a7c:	55                   	push   %ebp
  801a7d:	89 e5                	mov    %esp,%ebp
  801a7f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 2c                	push   $0x2c
  801a8e:	e8 ad fa ff ff       	call   801540 <syscall>
  801a93:	83 c4 18             	add    $0x18,%esp
  801a96:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a99:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a9d:	75 07                	jne    801aa6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a9f:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa4:	eb 05                	jmp    801aab <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801aa6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aab:	c9                   	leave  
  801aac:	c3                   	ret    

00801aad <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801aad:	55                   	push   %ebp
  801aae:	89 e5                	mov    %esp,%ebp
  801ab0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 2c                	push   $0x2c
  801abf:	e8 7c fa ff ff       	call   801540 <syscall>
  801ac4:	83 c4 18             	add    $0x18,%esp
  801ac7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801aca:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ace:	75 07                	jne    801ad7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ad0:	b8 01 00 00 00       	mov    $0x1,%eax
  801ad5:	eb 05                	jmp    801adc <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ad7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801adc:	c9                   	leave  
  801add:	c3                   	ret    

00801ade <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
  801ae1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 2c                	push   $0x2c
  801af0:	e8 4b fa ff ff       	call   801540 <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
  801af8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801afb:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801aff:	75 07                	jne    801b08 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b01:	b8 01 00 00 00       	mov    $0x1,%eax
  801b06:	eb 05                	jmp    801b0d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b08:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b0d:	c9                   	leave  
  801b0e:	c3                   	ret    

00801b0f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b0f:	55                   	push   %ebp
  801b10:	89 e5                	mov    %esp,%ebp
  801b12:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 2c                	push   $0x2c
  801b21:	e8 1a fa ff ff       	call   801540 <syscall>
  801b26:	83 c4 18             	add    $0x18,%esp
  801b29:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b2c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b30:	75 07                	jne    801b39 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b32:	b8 01 00 00 00       	mov    $0x1,%eax
  801b37:	eb 05                	jmp    801b3e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b39:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b3e:	c9                   	leave  
  801b3f:	c3                   	ret    

00801b40 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b40:	55                   	push   %ebp
  801b41:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	6a 00                	push   $0x0
  801b4b:	ff 75 08             	pushl  0x8(%ebp)
  801b4e:	6a 2d                	push   $0x2d
  801b50:	e8 eb f9 ff ff       	call   801540 <syscall>
  801b55:	83 c4 18             	add    $0x18,%esp
	return ;
  801b58:	90                   	nop
}
  801b59:	c9                   	leave  
  801b5a:	c3                   	ret    

00801b5b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b5b:	55                   	push   %ebp
  801b5c:	89 e5                	mov    %esp,%ebp
  801b5e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b5f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b62:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b65:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b68:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6b:	6a 00                	push   $0x0
  801b6d:	53                   	push   %ebx
  801b6e:	51                   	push   %ecx
  801b6f:	52                   	push   %edx
  801b70:	50                   	push   %eax
  801b71:	6a 2e                	push   $0x2e
  801b73:	e8 c8 f9 ff ff       	call   801540 <syscall>
  801b78:	83 c4 18             	add    $0x18,%esp
}
  801b7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b7e:	c9                   	leave  
  801b7f:	c3                   	ret    

00801b80 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b80:	55                   	push   %ebp
  801b81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b83:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b86:	8b 45 08             	mov    0x8(%ebp),%eax
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 00                	push   $0x0
  801b8f:	52                   	push   %edx
  801b90:	50                   	push   %eax
  801b91:	6a 2f                	push   $0x2f
  801b93:	e8 a8 f9 ff ff       	call   801540 <syscall>
  801b98:	83 c4 18             	add    $0x18,%esp
}
  801b9b:	c9                   	leave  
  801b9c:	c3                   	ret    

00801b9d <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801b9d:	55                   	push   %ebp
  801b9e:	89 e5                	mov    %esp,%ebp
  801ba0:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801ba3:	8b 55 08             	mov    0x8(%ebp),%edx
  801ba6:	89 d0                	mov    %edx,%eax
  801ba8:	c1 e0 02             	shl    $0x2,%eax
  801bab:	01 d0                	add    %edx,%eax
  801bad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bb4:	01 d0                	add    %edx,%eax
  801bb6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bbd:	01 d0                	add    %edx,%eax
  801bbf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bc6:	01 d0                	add    %edx,%eax
  801bc8:	c1 e0 04             	shl    $0x4,%eax
  801bcb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801bce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801bd5:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801bd8:	83 ec 0c             	sub    $0xc,%esp
  801bdb:	50                   	push   %eax
  801bdc:	e8 76 fd ff ff       	call   801957 <sys_get_virtual_time>
  801be1:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801be4:	eb 41                	jmp    801c27 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801be6:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801be9:	83 ec 0c             	sub    $0xc,%esp
  801bec:	50                   	push   %eax
  801bed:	e8 65 fd ff ff       	call   801957 <sys_get_virtual_time>
  801bf2:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801bf5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801bf8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801bfb:	29 c2                	sub    %eax,%edx
  801bfd:	89 d0                	mov    %edx,%eax
  801bff:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801c02:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c05:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c08:	89 d1                	mov    %edx,%ecx
  801c0a:	29 c1                	sub    %eax,%ecx
  801c0c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801c0f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c12:	39 c2                	cmp    %eax,%edx
  801c14:	0f 97 c0             	seta   %al
  801c17:	0f b6 c0             	movzbl %al,%eax
  801c1a:	29 c1                	sub    %eax,%ecx
  801c1c:	89 c8                	mov    %ecx,%eax
  801c1e:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801c21:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801c24:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c27:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c2a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c2d:	72 b7                	jb     801be6 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801c2f:	90                   	nop
  801c30:	c9                   	leave  
  801c31:	c3                   	ret    

00801c32 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801c32:	55                   	push   %ebp
  801c33:	89 e5                	mov    %esp,%ebp
  801c35:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801c38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801c3f:	eb 03                	jmp    801c44 <busy_wait+0x12>
  801c41:	ff 45 fc             	incl   -0x4(%ebp)
  801c44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c47:	3b 45 08             	cmp    0x8(%ebp),%eax
  801c4a:	72 f5                	jb     801c41 <busy_wait+0xf>
	return i;
  801c4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801c4f:	c9                   	leave  
  801c50:	c3                   	ret    

00801c51 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801c51:	55                   	push   %ebp
  801c52:	89 e5                	mov    %esp,%ebp
  801c54:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801c57:	8d 45 10             	lea    0x10(%ebp),%eax
  801c5a:	83 c0 04             	add    $0x4,%eax
  801c5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801c60:	a1 20 9b 98 00       	mov    0x989b20,%eax
  801c65:	85 c0                	test   %eax,%eax
  801c67:	74 16                	je     801c7f <_panic+0x2e>
		cprintf("%s: ", argv0);
  801c69:	a1 20 9b 98 00       	mov    0x989b20,%eax
  801c6e:	83 ec 08             	sub    $0x8,%esp
  801c71:	50                   	push   %eax
  801c72:	68 40 25 80 00       	push   $0x802540
  801c77:	e8 08 e7 ff ff       	call   800384 <cprintf>
  801c7c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801c7f:	a1 00 30 80 00       	mov    0x803000,%eax
  801c84:	ff 75 0c             	pushl  0xc(%ebp)
  801c87:	ff 75 08             	pushl  0x8(%ebp)
  801c8a:	50                   	push   %eax
  801c8b:	68 45 25 80 00       	push   $0x802545
  801c90:	e8 ef e6 ff ff       	call   800384 <cprintf>
  801c95:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801c98:	8b 45 10             	mov    0x10(%ebp),%eax
  801c9b:	83 ec 08             	sub    $0x8,%esp
  801c9e:	ff 75 f4             	pushl  -0xc(%ebp)
  801ca1:	50                   	push   %eax
  801ca2:	e8 72 e6 ff ff       	call   800319 <vcprintf>
  801ca7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801caa:	83 ec 08             	sub    $0x8,%esp
  801cad:	6a 00                	push   $0x0
  801caf:	68 61 25 80 00       	push   $0x802561
  801cb4:	e8 60 e6 ff ff       	call   800319 <vcprintf>
  801cb9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801cbc:	e8 e1 e5 ff ff       	call   8002a2 <exit>

	// should not return here
	while (1) ;
  801cc1:	eb fe                	jmp    801cc1 <_panic+0x70>

00801cc3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801cc3:	55                   	push   %ebp
  801cc4:	89 e5                	mov    %esp,%ebp
  801cc6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801cc9:	a1 20 30 80 00       	mov    0x803020,%eax
  801cce:	8b 50 74             	mov    0x74(%eax),%edx
  801cd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cd4:	39 c2                	cmp    %eax,%edx
  801cd6:	74 14                	je     801cec <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801cd8:	83 ec 04             	sub    $0x4,%esp
  801cdb:	68 64 25 80 00       	push   $0x802564
  801ce0:	6a 26                	push   $0x26
  801ce2:	68 b0 25 80 00       	push   $0x8025b0
  801ce7:	e8 65 ff ff ff       	call   801c51 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801cec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801cf3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801cfa:	e9 b6 00 00 00       	jmp    801db5 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801cff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d02:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d09:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0c:	01 d0                	add    %edx,%eax
  801d0e:	8b 00                	mov    (%eax),%eax
  801d10:	85 c0                	test   %eax,%eax
  801d12:	75 08                	jne    801d1c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801d14:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801d17:	e9 96 00 00 00       	jmp    801db2 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801d1c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d23:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801d2a:	eb 5d                	jmp    801d89 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801d2c:	a1 20 30 80 00       	mov    0x803020,%eax
  801d31:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801d37:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d3a:	c1 e2 04             	shl    $0x4,%edx
  801d3d:	01 d0                	add    %edx,%eax
  801d3f:	8a 40 04             	mov    0x4(%eax),%al
  801d42:	84 c0                	test   %al,%al
  801d44:	75 40                	jne    801d86 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d46:	a1 20 30 80 00       	mov    0x803020,%eax
  801d4b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801d51:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d54:	c1 e2 04             	shl    $0x4,%edx
  801d57:	01 d0                	add    %edx,%eax
  801d59:	8b 00                	mov    (%eax),%eax
  801d5b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801d5e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d61:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801d66:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801d68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d6b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801d72:	8b 45 08             	mov    0x8(%ebp),%eax
  801d75:	01 c8                	add    %ecx,%eax
  801d77:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d79:	39 c2                	cmp    %eax,%edx
  801d7b:	75 09                	jne    801d86 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801d7d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801d84:	eb 12                	jmp    801d98 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d86:	ff 45 e8             	incl   -0x18(%ebp)
  801d89:	a1 20 30 80 00       	mov    0x803020,%eax
  801d8e:	8b 50 74             	mov    0x74(%eax),%edx
  801d91:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d94:	39 c2                	cmp    %eax,%edx
  801d96:	77 94                	ja     801d2c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801d98:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801d9c:	75 14                	jne    801db2 <CheckWSWithoutLastIndex+0xef>
			panic(
  801d9e:	83 ec 04             	sub    $0x4,%esp
  801da1:	68 bc 25 80 00       	push   $0x8025bc
  801da6:	6a 3a                	push   $0x3a
  801da8:	68 b0 25 80 00       	push   $0x8025b0
  801dad:	e8 9f fe ff ff       	call   801c51 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801db2:	ff 45 f0             	incl   -0x10(%ebp)
  801db5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801db8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801dbb:	0f 8c 3e ff ff ff    	jl     801cff <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801dc1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801dc8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801dcf:	eb 20                	jmp    801df1 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801dd1:	a1 20 30 80 00       	mov    0x803020,%eax
  801dd6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801ddc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ddf:	c1 e2 04             	shl    $0x4,%edx
  801de2:	01 d0                	add    %edx,%eax
  801de4:	8a 40 04             	mov    0x4(%eax),%al
  801de7:	3c 01                	cmp    $0x1,%al
  801de9:	75 03                	jne    801dee <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801deb:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801dee:	ff 45 e0             	incl   -0x20(%ebp)
  801df1:	a1 20 30 80 00       	mov    0x803020,%eax
  801df6:	8b 50 74             	mov    0x74(%eax),%edx
  801df9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801dfc:	39 c2                	cmp    %eax,%edx
  801dfe:	77 d1                	ja     801dd1 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801e00:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e03:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801e06:	74 14                	je     801e1c <CheckWSWithoutLastIndex+0x159>
		panic(
  801e08:	83 ec 04             	sub    $0x4,%esp
  801e0b:	68 10 26 80 00       	push   $0x802610
  801e10:	6a 44                	push   $0x44
  801e12:	68 b0 25 80 00       	push   $0x8025b0
  801e17:	e8 35 fe ff ff       	call   801c51 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801e1c:	90                   	nop
  801e1d:	c9                   	leave  
  801e1e:	c3                   	ret    
  801e1f:	90                   	nop

00801e20 <__udivdi3>:
  801e20:	55                   	push   %ebp
  801e21:	57                   	push   %edi
  801e22:	56                   	push   %esi
  801e23:	53                   	push   %ebx
  801e24:	83 ec 1c             	sub    $0x1c,%esp
  801e27:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e2b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e33:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e37:	89 ca                	mov    %ecx,%edx
  801e39:	89 f8                	mov    %edi,%eax
  801e3b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e3f:	85 f6                	test   %esi,%esi
  801e41:	75 2d                	jne    801e70 <__udivdi3+0x50>
  801e43:	39 cf                	cmp    %ecx,%edi
  801e45:	77 65                	ja     801eac <__udivdi3+0x8c>
  801e47:	89 fd                	mov    %edi,%ebp
  801e49:	85 ff                	test   %edi,%edi
  801e4b:	75 0b                	jne    801e58 <__udivdi3+0x38>
  801e4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801e52:	31 d2                	xor    %edx,%edx
  801e54:	f7 f7                	div    %edi
  801e56:	89 c5                	mov    %eax,%ebp
  801e58:	31 d2                	xor    %edx,%edx
  801e5a:	89 c8                	mov    %ecx,%eax
  801e5c:	f7 f5                	div    %ebp
  801e5e:	89 c1                	mov    %eax,%ecx
  801e60:	89 d8                	mov    %ebx,%eax
  801e62:	f7 f5                	div    %ebp
  801e64:	89 cf                	mov    %ecx,%edi
  801e66:	89 fa                	mov    %edi,%edx
  801e68:	83 c4 1c             	add    $0x1c,%esp
  801e6b:	5b                   	pop    %ebx
  801e6c:	5e                   	pop    %esi
  801e6d:	5f                   	pop    %edi
  801e6e:	5d                   	pop    %ebp
  801e6f:	c3                   	ret    
  801e70:	39 ce                	cmp    %ecx,%esi
  801e72:	77 28                	ja     801e9c <__udivdi3+0x7c>
  801e74:	0f bd fe             	bsr    %esi,%edi
  801e77:	83 f7 1f             	xor    $0x1f,%edi
  801e7a:	75 40                	jne    801ebc <__udivdi3+0x9c>
  801e7c:	39 ce                	cmp    %ecx,%esi
  801e7e:	72 0a                	jb     801e8a <__udivdi3+0x6a>
  801e80:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e84:	0f 87 9e 00 00 00    	ja     801f28 <__udivdi3+0x108>
  801e8a:	b8 01 00 00 00       	mov    $0x1,%eax
  801e8f:	89 fa                	mov    %edi,%edx
  801e91:	83 c4 1c             	add    $0x1c,%esp
  801e94:	5b                   	pop    %ebx
  801e95:	5e                   	pop    %esi
  801e96:	5f                   	pop    %edi
  801e97:	5d                   	pop    %ebp
  801e98:	c3                   	ret    
  801e99:	8d 76 00             	lea    0x0(%esi),%esi
  801e9c:	31 ff                	xor    %edi,%edi
  801e9e:	31 c0                	xor    %eax,%eax
  801ea0:	89 fa                	mov    %edi,%edx
  801ea2:	83 c4 1c             	add    $0x1c,%esp
  801ea5:	5b                   	pop    %ebx
  801ea6:	5e                   	pop    %esi
  801ea7:	5f                   	pop    %edi
  801ea8:	5d                   	pop    %ebp
  801ea9:	c3                   	ret    
  801eaa:	66 90                	xchg   %ax,%ax
  801eac:	89 d8                	mov    %ebx,%eax
  801eae:	f7 f7                	div    %edi
  801eb0:	31 ff                	xor    %edi,%edi
  801eb2:	89 fa                	mov    %edi,%edx
  801eb4:	83 c4 1c             	add    $0x1c,%esp
  801eb7:	5b                   	pop    %ebx
  801eb8:	5e                   	pop    %esi
  801eb9:	5f                   	pop    %edi
  801eba:	5d                   	pop    %ebp
  801ebb:	c3                   	ret    
  801ebc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ec1:	89 eb                	mov    %ebp,%ebx
  801ec3:	29 fb                	sub    %edi,%ebx
  801ec5:	89 f9                	mov    %edi,%ecx
  801ec7:	d3 e6                	shl    %cl,%esi
  801ec9:	89 c5                	mov    %eax,%ebp
  801ecb:	88 d9                	mov    %bl,%cl
  801ecd:	d3 ed                	shr    %cl,%ebp
  801ecf:	89 e9                	mov    %ebp,%ecx
  801ed1:	09 f1                	or     %esi,%ecx
  801ed3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ed7:	89 f9                	mov    %edi,%ecx
  801ed9:	d3 e0                	shl    %cl,%eax
  801edb:	89 c5                	mov    %eax,%ebp
  801edd:	89 d6                	mov    %edx,%esi
  801edf:	88 d9                	mov    %bl,%cl
  801ee1:	d3 ee                	shr    %cl,%esi
  801ee3:	89 f9                	mov    %edi,%ecx
  801ee5:	d3 e2                	shl    %cl,%edx
  801ee7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eeb:	88 d9                	mov    %bl,%cl
  801eed:	d3 e8                	shr    %cl,%eax
  801eef:	09 c2                	or     %eax,%edx
  801ef1:	89 d0                	mov    %edx,%eax
  801ef3:	89 f2                	mov    %esi,%edx
  801ef5:	f7 74 24 0c          	divl   0xc(%esp)
  801ef9:	89 d6                	mov    %edx,%esi
  801efb:	89 c3                	mov    %eax,%ebx
  801efd:	f7 e5                	mul    %ebp
  801eff:	39 d6                	cmp    %edx,%esi
  801f01:	72 19                	jb     801f1c <__udivdi3+0xfc>
  801f03:	74 0b                	je     801f10 <__udivdi3+0xf0>
  801f05:	89 d8                	mov    %ebx,%eax
  801f07:	31 ff                	xor    %edi,%edi
  801f09:	e9 58 ff ff ff       	jmp    801e66 <__udivdi3+0x46>
  801f0e:	66 90                	xchg   %ax,%ax
  801f10:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f14:	89 f9                	mov    %edi,%ecx
  801f16:	d3 e2                	shl    %cl,%edx
  801f18:	39 c2                	cmp    %eax,%edx
  801f1a:	73 e9                	jae    801f05 <__udivdi3+0xe5>
  801f1c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f1f:	31 ff                	xor    %edi,%edi
  801f21:	e9 40 ff ff ff       	jmp    801e66 <__udivdi3+0x46>
  801f26:	66 90                	xchg   %ax,%ax
  801f28:	31 c0                	xor    %eax,%eax
  801f2a:	e9 37 ff ff ff       	jmp    801e66 <__udivdi3+0x46>
  801f2f:	90                   	nop

00801f30 <__umoddi3>:
  801f30:	55                   	push   %ebp
  801f31:	57                   	push   %edi
  801f32:	56                   	push   %esi
  801f33:	53                   	push   %ebx
  801f34:	83 ec 1c             	sub    $0x1c,%esp
  801f37:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f3b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f3f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f43:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f47:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f4b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f4f:	89 f3                	mov    %esi,%ebx
  801f51:	89 fa                	mov    %edi,%edx
  801f53:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f57:	89 34 24             	mov    %esi,(%esp)
  801f5a:	85 c0                	test   %eax,%eax
  801f5c:	75 1a                	jne    801f78 <__umoddi3+0x48>
  801f5e:	39 f7                	cmp    %esi,%edi
  801f60:	0f 86 a2 00 00 00    	jbe    802008 <__umoddi3+0xd8>
  801f66:	89 c8                	mov    %ecx,%eax
  801f68:	89 f2                	mov    %esi,%edx
  801f6a:	f7 f7                	div    %edi
  801f6c:	89 d0                	mov    %edx,%eax
  801f6e:	31 d2                	xor    %edx,%edx
  801f70:	83 c4 1c             	add    $0x1c,%esp
  801f73:	5b                   	pop    %ebx
  801f74:	5e                   	pop    %esi
  801f75:	5f                   	pop    %edi
  801f76:	5d                   	pop    %ebp
  801f77:	c3                   	ret    
  801f78:	39 f0                	cmp    %esi,%eax
  801f7a:	0f 87 ac 00 00 00    	ja     80202c <__umoddi3+0xfc>
  801f80:	0f bd e8             	bsr    %eax,%ebp
  801f83:	83 f5 1f             	xor    $0x1f,%ebp
  801f86:	0f 84 ac 00 00 00    	je     802038 <__umoddi3+0x108>
  801f8c:	bf 20 00 00 00       	mov    $0x20,%edi
  801f91:	29 ef                	sub    %ebp,%edi
  801f93:	89 fe                	mov    %edi,%esi
  801f95:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f99:	89 e9                	mov    %ebp,%ecx
  801f9b:	d3 e0                	shl    %cl,%eax
  801f9d:	89 d7                	mov    %edx,%edi
  801f9f:	89 f1                	mov    %esi,%ecx
  801fa1:	d3 ef                	shr    %cl,%edi
  801fa3:	09 c7                	or     %eax,%edi
  801fa5:	89 e9                	mov    %ebp,%ecx
  801fa7:	d3 e2                	shl    %cl,%edx
  801fa9:	89 14 24             	mov    %edx,(%esp)
  801fac:	89 d8                	mov    %ebx,%eax
  801fae:	d3 e0                	shl    %cl,%eax
  801fb0:	89 c2                	mov    %eax,%edx
  801fb2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fb6:	d3 e0                	shl    %cl,%eax
  801fb8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fbc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fc0:	89 f1                	mov    %esi,%ecx
  801fc2:	d3 e8                	shr    %cl,%eax
  801fc4:	09 d0                	or     %edx,%eax
  801fc6:	d3 eb                	shr    %cl,%ebx
  801fc8:	89 da                	mov    %ebx,%edx
  801fca:	f7 f7                	div    %edi
  801fcc:	89 d3                	mov    %edx,%ebx
  801fce:	f7 24 24             	mull   (%esp)
  801fd1:	89 c6                	mov    %eax,%esi
  801fd3:	89 d1                	mov    %edx,%ecx
  801fd5:	39 d3                	cmp    %edx,%ebx
  801fd7:	0f 82 87 00 00 00    	jb     802064 <__umoddi3+0x134>
  801fdd:	0f 84 91 00 00 00    	je     802074 <__umoddi3+0x144>
  801fe3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801fe7:	29 f2                	sub    %esi,%edx
  801fe9:	19 cb                	sbb    %ecx,%ebx
  801feb:	89 d8                	mov    %ebx,%eax
  801fed:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ff1:	d3 e0                	shl    %cl,%eax
  801ff3:	89 e9                	mov    %ebp,%ecx
  801ff5:	d3 ea                	shr    %cl,%edx
  801ff7:	09 d0                	or     %edx,%eax
  801ff9:	89 e9                	mov    %ebp,%ecx
  801ffb:	d3 eb                	shr    %cl,%ebx
  801ffd:	89 da                	mov    %ebx,%edx
  801fff:	83 c4 1c             	add    $0x1c,%esp
  802002:	5b                   	pop    %ebx
  802003:	5e                   	pop    %esi
  802004:	5f                   	pop    %edi
  802005:	5d                   	pop    %ebp
  802006:	c3                   	ret    
  802007:	90                   	nop
  802008:	89 fd                	mov    %edi,%ebp
  80200a:	85 ff                	test   %edi,%edi
  80200c:	75 0b                	jne    802019 <__umoddi3+0xe9>
  80200e:	b8 01 00 00 00       	mov    $0x1,%eax
  802013:	31 d2                	xor    %edx,%edx
  802015:	f7 f7                	div    %edi
  802017:	89 c5                	mov    %eax,%ebp
  802019:	89 f0                	mov    %esi,%eax
  80201b:	31 d2                	xor    %edx,%edx
  80201d:	f7 f5                	div    %ebp
  80201f:	89 c8                	mov    %ecx,%eax
  802021:	f7 f5                	div    %ebp
  802023:	89 d0                	mov    %edx,%eax
  802025:	e9 44 ff ff ff       	jmp    801f6e <__umoddi3+0x3e>
  80202a:	66 90                	xchg   %ax,%ax
  80202c:	89 c8                	mov    %ecx,%eax
  80202e:	89 f2                	mov    %esi,%edx
  802030:	83 c4 1c             	add    $0x1c,%esp
  802033:	5b                   	pop    %ebx
  802034:	5e                   	pop    %esi
  802035:	5f                   	pop    %edi
  802036:	5d                   	pop    %ebp
  802037:	c3                   	ret    
  802038:	3b 04 24             	cmp    (%esp),%eax
  80203b:	72 06                	jb     802043 <__umoddi3+0x113>
  80203d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802041:	77 0f                	ja     802052 <__umoddi3+0x122>
  802043:	89 f2                	mov    %esi,%edx
  802045:	29 f9                	sub    %edi,%ecx
  802047:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80204b:	89 14 24             	mov    %edx,(%esp)
  80204e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802052:	8b 44 24 04          	mov    0x4(%esp),%eax
  802056:	8b 14 24             	mov    (%esp),%edx
  802059:	83 c4 1c             	add    $0x1c,%esp
  80205c:	5b                   	pop    %ebx
  80205d:	5e                   	pop    %esi
  80205e:	5f                   	pop    %edi
  80205f:	5d                   	pop    %ebp
  802060:	c3                   	ret    
  802061:	8d 76 00             	lea    0x0(%esi),%esi
  802064:	2b 04 24             	sub    (%esp),%eax
  802067:	19 fa                	sbb    %edi,%edx
  802069:	89 d1                	mov    %edx,%ecx
  80206b:	89 c6                	mov    %eax,%esi
  80206d:	e9 71 ff ff ff       	jmp    801fe3 <__umoddi3+0xb3>
  802072:	66 90                	xchg   %ax,%ax
  802074:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802078:	72 ea                	jb     802064 <__umoddi3+0x134>
  80207a:	89 d9                	mov    %ebx,%ecx
  80207c:	e9 62 ff ff ff       	jmp    801fe3 <__umoddi3+0xb3>


obj/user/tst_semaphore_1master:     file format elf32-i386


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
  800031:	e8 8d 01 00 00       	call   8001c3 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: create the semaphores, run slaves and wait them to finish
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int envID = sys_getenvid();
  80003e:	e8 ab 11 00 00       	call   8011ee <sys_getenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)

	sys_createSemaphore("cs1", 1);
  800046:	83 ec 08             	sub    $0x8,%esp
  800049:	6a 01                	push   $0x1
  80004b:	68 40 1a 80 00       	push   $0x801a40
  800050:	e8 c1 13 00 00       	call   801416 <sys_createSemaphore>
  800055:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore("depend1", 0);
  800058:	83 ec 08             	sub    $0x8,%esp
  80005b:	6a 00                	push   $0x0
  80005d:	68 44 1a 80 00       	push   $0x801a44
  800062:	e8 af 13 00 00       	call   801416 <sys_createSemaphore>
  800067:	83 c4 10             	add    $0x10,%esp

	int id1, id2, id3;
	id1 = sys_create_env("sem1Slave", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80006a:	a1 20 20 80 00       	mov    0x802020,%eax
  80006f:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800075:	a1 20 20 80 00       	mov    0x802020,%eax
  80007a:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800080:	89 c1                	mov    %eax,%ecx
  800082:	a1 20 20 80 00       	mov    0x802020,%eax
  800087:	8b 40 74             	mov    0x74(%eax),%eax
  80008a:	52                   	push   %edx
  80008b:	51                   	push   %ecx
  80008c:	50                   	push   %eax
  80008d:	68 4c 1a 80 00       	push   $0x801a4c
  800092:	e8 90 14 00 00       	call   801527 <sys_create_env>
  800097:	83 c4 10             	add    $0x10,%esp
  80009a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	id2 = sys_create_env("sem1Slave", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  80009d:	a1 20 20 80 00       	mov    0x802020,%eax
  8000a2:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000a8:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ad:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000b3:	89 c1                	mov    %eax,%ecx
  8000b5:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ba:	8b 40 74             	mov    0x74(%eax),%eax
  8000bd:	52                   	push   %edx
  8000be:	51                   	push   %ecx
  8000bf:	50                   	push   %eax
  8000c0:	68 4c 1a 80 00       	push   $0x801a4c
  8000c5:	e8 5d 14 00 00       	call   801527 <sys_create_env>
  8000ca:	83 c4 10             	add    $0x10,%esp
  8000cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
	id3 = sys_create_env("sem1Slave", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000d0:	a1 20 20 80 00       	mov    0x802020,%eax
  8000d5:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000db:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e0:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000e6:	89 c1                	mov    %eax,%ecx
  8000e8:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ed:	8b 40 74             	mov    0x74(%eax),%eax
  8000f0:	52                   	push   %edx
  8000f1:	51                   	push   %ecx
  8000f2:	50                   	push   %eax
  8000f3:	68 4c 1a 80 00       	push   $0x801a4c
  8000f8:	e8 2a 14 00 00       	call   801527 <sys_create_env>
  8000fd:	83 c4 10             	add    $0x10,%esp
  800100:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_run_env(id1);
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	ff 75 f0             	pushl  -0x10(%ebp)
  800109:	e8 37 14 00 00       	call   801545 <sys_run_env>
  80010e:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id2);
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	ff 75 ec             	pushl  -0x14(%ebp)
  800117:	e8 29 14 00 00       	call   801545 <sys_run_env>
  80011c:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id3);
  80011f:	83 ec 0c             	sub    $0xc,%esp
  800122:	ff 75 e8             	pushl  -0x18(%ebp)
  800125:	e8 1b 14 00 00       	call   801545 <sys_run_env>
  80012a:	83 c4 10             	add    $0x10,%esp

	sys_waitSemaphore(envID, "depend1") ;
  80012d:	83 ec 08             	sub    $0x8,%esp
  800130:	68 44 1a 80 00       	push   $0x801a44
  800135:	ff 75 f4             	pushl  -0xc(%ebp)
  800138:	e8 12 13 00 00       	call   80144f <sys_waitSemaphore>
  80013d:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(envID, "depend1") ;
  800140:	83 ec 08             	sub    $0x8,%esp
  800143:	68 44 1a 80 00       	push   $0x801a44
  800148:	ff 75 f4             	pushl  -0xc(%ebp)
  80014b:	e8 ff 12 00 00       	call   80144f <sys_waitSemaphore>
  800150:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(envID, "depend1") ;
  800153:	83 ec 08             	sub    $0x8,%esp
  800156:	68 44 1a 80 00       	push   $0x801a44
  80015b:	ff 75 f4             	pushl  -0xc(%ebp)
  80015e:	e8 ec 12 00 00       	call   80144f <sys_waitSemaphore>
  800163:	83 c4 10             	add    $0x10,%esp

	int sem1val = sys_getSemaphoreValue(envID, "cs1");
  800166:	83 ec 08             	sub    $0x8,%esp
  800169:	68 40 1a 80 00       	push   $0x801a40
  80016e:	ff 75 f4             	pushl  -0xc(%ebp)
  800171:	e8 bc 12 00 00       	call   801432 <sys_getSemaphoreValue>
  800176:	83 c4 10             	add    $0x10,%esp
  800179:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int sem2val = sys_getSemaphoreValue(envID, "depend1");
  80017c:	83 ec 08             	sub    $0x8,%esp
  80017f:	68 44 1a 80 00       	push   $0x801a44
  800184:	ff 75 f4             	pushl  -0xc(%ebp)
  800187:	e8 a6 12 00 00       	call   801432 <sys_getSemaphoreValue>
  80018c:	83 c4 10             	add    $0x10,%esp
  80018f:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (sem2val == 0 && sem1val == 1)
  800192:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800196:	75 18                	jne    8001b0 <_main+0x178>
  800198:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  80019c:	75 12                	jne    8001b0 <_main+0x178>
		cprintf("Congratulations!! Test of Semaphores [1] completed successfully!!\n\n\n");
  80019e:	83 ec 0c             	sub    $0xc,%esp
  8001a1:	68 58 1a 80 00       	push   $0x801a58
  8001a6:	e8 31 02 00 00       	call   8003dc <cprintf>
  8001ab:	83 c4 10             	add    $0x10,%esp
  8001ae:	eb 10                	jmp    8001c0 <_main+0x188>
	else
		cprintf("Error: wrong semaphore value... please review your semaphore code again...");
  8001b0:	83 ec 0c             	sub    $0xc,%esp
  8001b3:	68 a0 1a 80 00       	push   $0x801aa0
  8001b8:	e8 1f 02 00 00       	call   8003dc <cprintf>
  8001bd:	83 c4 10             	add    $0x10,%esp

	return;
  8001c0:	90                   	nop
}
  8001c1:	c9                   	leave  
  8001c2:	c3                   	ret    

008001c3 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001c3:	55                   	push   %ebp
  8001c4:	89 e5                	mov    %esp,%ebp
  8001c6:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001c9:	e8 39 10 00 00       	call   801207 <sys_getenvindex>
  8001ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001d4:	89 d0                	mov    %edx,%eax
  8001d6:	c1 e0 03             	shl    $0x3,%eax
  8001d9:	01 d0                	add    %edx,%eax
  8001db:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001e2:	01 c8                	add    %ecx,%eax
  8001e4:	01 c0                	add    %eax,%eax
  8001e6:	01 d0                	add    %edx,%eax
  8001e8:	01 c0                	add    %eax,%eax
  8001ea:	01 d0                	add    %edx,%eax
  8001ec:	89 c2                	mov    %eax,%edx
  8001ee:	c1 e2 05             	shl    $0x5,%edx
  8001f1:	29 c2                	sub    %eax,%edx
  8001f3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001fa:	89 c2                	mov    %eax,%edx
  8001fc:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800202:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800207:	a1 20 20 80 00       	mov    0x802020,%eax
  80020c:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800212:	84 c0                	test   %al,%al
  800214:	74 0f                	je     800225 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800216:	a1 20 20 80 00       	mov    0x802020,%eax
  80021b:	05 40 3c 01 00       	add    $0x13c40,%eax
  800220:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800225:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800229:	7e 0a                	jle    800235 <libmain+0x72>
		binaryname = argv[0];
  80022b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022e:	8b 00                	mov    (%eax),%eax
  800230:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800235:	83 ec 08             	sub    $0x8,%esp
  800238:	ff 75 0c             	pushl  0xc(%ebp)
  80023b:	ff 75 08             	pushl  0x8(%ebp)
  80023e:	e8 f5 fd ff ff       	call   800038 <_main>
  800243:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800246:	e8 57 11 00 00       	call   8013a2 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80024b:	83 ec 0c             	sub    $0xc,%esp
  80024e:	68 04 1b 80 00       	push   $0x801b04
  800253:	e8 84 01 00 00       	call   8003dc <cprintf>
  800258:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80025b:	a1 20 20 80 00       	mov    0x802020,%eax
  800260:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800266:	a1 20 20 80 00       	mov    0x802020,%eax
  80026b:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800271:	83 ec 04             	sub    $0x4,%esp
  800274:	52                   	push   %edx
  800275:	50                   	push   %eax
  800276:	68 2c 1b 80 00       	push   $0x801b2c
  80027b:	e8 5c 01 00 00       	call   8003dc <cprintf>
  800280:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800283:	a1 20 20 80 00       	mov    0x802020,%eax
  800288:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80028e:	a1 20 20 80 00       	mov    0x802020,%eax
  800293:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800299:	83 ec 04             	sub    $0x4,%esp
  80029c:	52                   	push   %edx
  80029d:	50                   	push   %eax
  80029e:	68 54 1b 80 00       	push   $0x801b54
  8002a3:	e8 34 01 00 00       	call   8003dc <cprintf>
  8002a8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002ab:	a1 20 20 80 00       	mov    0x802020,%eax
  8002b0:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002b6:	83 ec 08             	sub    $0x8,%esp
  8002b9:	50                   	push   %eax
  8002ba:	68 95 1b 80 00       	push   $0x801b95
  8002bf:	e8 18 01 00 00       	call   8003dc <cprintf>
  8002c4:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002c7:	83 ec 0c             	sub    $0xc,%esp
  8002ca:	68 04 1b 80 00       	push   $0x801b04
  8002cf:	e8 08 01 00 00       	call   8003dc <cprintf>
  8002d4:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002d7:	e8 e0 10 00 00       	call   8013bc <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002dc:	e8 19 00 00 00       	call   8002fa <exit>
}
  8002e1:	90                   	nop
  8002e2:	c9                   	leave  
  8002e3:	c3                   	ret    

008002e4 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002e4:	55                   	push   %ebp
  8002e5:	89 e5                	mov    %esp,%ebp
  8002e7:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002ea:	83 ec 0c             	sub    $0xc,%esp
  8002ed:	6a 00                	push   $0x0
  8002ef:	e8 df 0e 00 00       	call   8011d3 <sys_env_destroy>
  8002f4:	83 c4 10             	add    $0x10,%esp
}
  8002f7:	90                   	nop
  8002f8:	c9                   	leave  
  8002f9:	c3                   	ret    

008002fa <exit>:

void
exit(void)
{
  8002fa:	55                   	push   %ebp
  8002fb:	89 e5                	mov    %esp,%ebp
  8002fd:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800300:	e8 34 0f 00 00       	call   801239 <sys_env_exit>
}
  800305:	90                   	nop
  800306:	c9                   	leave  
  800307:	c3                   	ret    

00800308 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800308:	55                   	push   %ebp
  800309:	89 e5                	mov    %esp,%ebp
  80030b:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80030e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800311:	8b 00                	mov    (%eax),%eax
  800313:	8d 48 01             	lea    0x1(%eax),%ecx
  800316:	8b 55 0c             	mov    0xc(%ebp),%edx
  800319:	89 0a                	mov    %ecx,(%edx)
  80031b:	8b 55 08             	mov    0x8(%ebp),%edx
  80031e:	88 d1                	mov    %dl,%cl
  800320:	8b 55 0c             	mov    0xc(%ebp),%edx
  800323:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800327:	8b 45 0c             	mov    0xc(%ebp),%eax
  80032a:	8b 00                	mov    (%eax),%eax
  80032c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800331:	75 2c                	jne    80035f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800333:	a0 24 20 80 00       	mov    0x802024,%al
  800338:	0f b6 c0             	movzbl %al,%eax
  80033b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80033e:	8b 12                	mov    (%edx),%edx
  800340:	89 d1                	mov    %edx,%ecx
  800342:	8b 55 0c             	mov    0xc(%ebp),%edx
  800345:	83 c2 08             	add    $0x8,%edx
  800348:	83 ec 04             	sub    $0x4,%esp
  80034b:	50                   	push   %eax
  80034c:	51                   	push   %ecx
  80034d:	52                   	push   %edx
  80034e:	e8 3e 0e 00 00       	call   801191 <sys_cputs>
  800353:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800356:	8b 45 0c             	mov    0xc(%ebp),%eax
  800359:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80035f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800362:	8b 40 04             	mov    0x4(%eax),%eax
  800365:	8d 50 01             	lea    0x1(%eax),%edx
  800368:	8b 45 0c             	mov    0xc(%ebp),%eax
  80036b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80036e:	90                   	nop
  80036f:	c9                   	leave  
  800370:	c3                   	ret    

00800371 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800371:	55                   	push   %ebp
  800372:	89 e5                	mov    %esp,%ebp
  800374:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80037a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800381:	00 00 00 
	b.cnt = 0;
  800384:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80038b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80038e:	ff 75 0c             	pushl  0xc(%ebp)
  800391:	ff 75 08             	pushl  0x8(%ebp)
  800394:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80039a:	50                   	push   %eax
  80039b:	68 08 03 80 00       	push   $0x800308
  8003a0:	e8 11 02 00 00       	call   8005b6 <vprintfmt>
  8003a5:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8003a8:	a0 24 20 80 00       	mov    0x802024,%al
  8003ad:	0f b6 c0             	movzbl %al,%eax
  8003b0:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8003b6:	83 ec 04             	sub    $0x4,%esp
  8003b9:	50                   	push   %eax
  8003ba:	52                   	push   %edx
  8003bb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003c1:	83 c0 08             	add    $0x8,%eax
  8003c4:	50                   	push   %eax
  8003c5:	e8 c7 0d 00 00       	call   801191 <sys_cputs>
  8003ca:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8003cd:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8003d4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8003da:	c9                   	leave  
  8003db:	c3                   	ret    

008003dc <cprintf>:

int cprintf(const char *fmt, ...) {
  8003dc:	55                   	push   %ebp
  8003dd:	89 e5                	mov    %esp,%ebp
  8003df:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003e2:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8003e9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f2:	83 ec 08             	sub    $0x8,%esp
  8003f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8003f8:	50                   	push   %eax
  8003f9:	e8 73 ff ff ff       	call   800371 <vcprintf>
  8003fe:	83 c4 10             	add    $0x10,%esp
  800401:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800404:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800407:	c9                   	leave  
  800408:	c3                   	ret    

00800409 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800409:	55                   	push   %ebp
  80040a:	89 e5                	mov    %esp,%ebp
  80040c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80040f:	e8 8e 0f 00 00       	call   8013a2 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800414:	8d 45 0c             	lea    0xc(%ebp),%eax
  800417:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	83 ec 08             	sub    $0x8,%esp
  800420:	ff 75 f4             	pushl  -0xc(%ebp)
  800423:	50                   	push   %eax
  800424:	e8 48 ff ff ff       	call   800371 <vcprintf>
  800429:	83 c4 10             	add    $0x10,%esp
  80042c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80042f:	e8 88 0f 00 00       	call   8013bc <sys_enable_interrupt>
	return cnt;
  800434:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800437:	c9                   	leave  
  800438:	c3                   	ret    

00800439 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800439:	55                   	push   %ebp
  80043a:	89 e5                	mov    %esp,%ebp
  80043c:	53                   	push   %ebx
  80043d:	83 ec 14             	sub    $0x14,%esp
  800440:	8b 45 10             	mov    0x10(%ebp),%eax
  800443:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800446:	8b 45 14             	mov    0x14(%ebp),%eax
  800449:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80044c:	8b 45 18             	mov    0x18(%ebp),%eax
  80044f:	ba 00 00 00 00       	mov    $0x0,%edx
  800454:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800457:	77 55                	ja     8004ae <printnum+0x75>
  800459:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80045c:	72 05                	jb     800463 <printnum+0x2a>
  80045e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800461:	77 4b                	ja     8004ae <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800463:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800466:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800469:	8b 45 18             	mov    0x18(%ebp),%eax
  80046c:	ba 00 00 00 00       	mov    $0x0,%edx
  800471:	52                   	push   %edx
  800472:	50                   	push   %eax
  800473:	ff 75 f4             	pushl  -0xc(%ebp)
  800476:	ff 75 f0             	pushl  -0x10(%ebp)
  800479:	e8 46 13 00 00       	call   8017c4 <__udivdi3>
  80047e:	83 c4 10             	add    $0x10,%esp
  800481:	83 ec 04             	sub    $0x4,%esp
  800484:	ff 75 20             	pushl  0x20(%ebp)
  800487:	53                   	push   %ebx
  800488:	ff 75 18             	pushl  0x18(%ebp)
  80048b:	52                   	push   %edx
  80048c:	50                   	push   %eax
  80048d:	ff 75 0c             	pushl  0xc(%ebp)
  800490:	ff 75 08             	pushl  0x8(%ebp)
  800493:	e8 a1 ff ff ff       	call   800439 <printnum>
  800498:	83 c4 20             	add    $0x20,%esp
  80049b:	eb 1a                	jmp    8004b7 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80049d:	83 ec 08             	sub    $0x8,%esp
  8004a0:	ff 75 0c             	pushl  0xc(%ebp)
  8004a3:	ff 75 20             	pushl  0x20(%ebp)
  8004a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a9:	ff d0                	call   *%eax
  8004ab:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8004ae:	ff 4d 1c             	decl   0x1c(%ebp)
  8004b1:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8004b5:	7f e6                	jg     80049d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8004b7:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8004ba:	bb 00 00 00 00       	mov    $0x0,%ebx
  8004bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004c5:	53                   	push   %ebx
  8004c6:	51                   	push   %ecx
  8004c7:	52                   	push   %edx
  8004c8:	50                   	push   %eax
  8004c9:	e8 06 14 00 00       	call   8018d4 <__umoddi3>
  8004ce:	83 c4 10             	add    $0x10,%esp
  8004d1:	05 d4 1d 80 00       	add    $0x801dd4,%eax
  8004d6:	8a 00                	mov    (%eax),%al
  8004d8:	0f be c0             	movsbl %al,%eax
  8004db:	83 ec 08             	sub    $0x8,%esp
  8004de:	ff 75 0c             	pushl  0xc(%ebp)
  8004e1:	50                   	push   %eax
  8004e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e5:	ff d0                	call   *%eax
  8004e7:	83 c4 10             	add    $0x10,%esp
}
  8004ea:	90                   	nop
  8004eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004ee:	c9                   	leave  
  8004ef:	c3                   	ret    

008004f0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8004f0:	55                   	push   %ebp
  8004f1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004f3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004f7:	7e 1c                	jle    800515 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8004f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fc:	8b 00                	mov    (%eax),%eax
  8004fe:	8d 50 08             	lea    0x8(%eax),%edx
  800501:	8b 45 08             	mov    0x8(%ebp),%eax
  800504:	89 10                	mov    %edx,(%eax)
  800506:	8b 45 08             	mov    0x8(%ebp),%eax
  800509:	8b 00                	mov    (%eax),%eax
  80050b:	83 e8 08             	sub    $0x8,%eax
  80050e:	8b 50 04             	mov    0x4(%eax),%edx
  800511:	8b 00                	mov    (%eax),%eax
  800513:	eb 40                	jmp    800555 <getuint+0x65>
	else if (lflag)
  800515:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800519:	74 1e                	je     800539 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80051b:	8b 45 08             	mov    0x8(%ebp),%eax
  80051e:	8b 00                	mov    (%eax),%eax
  800520:	8d 50 04             	lea    0x4(%eax),%edx
  800523:	8b 45 08             	mov    0x8(%ebp),%eax
  800526:	89 10                	mov    %edx,(%eax)
  800528:	8b 45 08             	mov    0x8(%ebp),%eax
  80052b:	8b 00                	mov    (%eax),%eax
  80052d:	83 e8 04             	sub    $0x4,%eax
  800530:	8b 00                	mov    (%eax),%eax
  800532:	ba 00 00 00 00       	mov    $0x0,%edx
  800537:	eb 1c                	jmp    800555 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800539:	8b 45 08             	mov    0x8(%ebp),%eax
  80053c:	8b 00                	mov    (%eax),%eax
  80053e:	8d 50 04             	lea    0x4(%eax),%edx
  800541:	8b 45 08             	mov    0x8(%ebp),%eax
  800544:	89 10                	mov    %edx,(%eax)
  800546:	8b 45 08             	mov    0x8(%ebp),%eax
  800549:	8b 00                	mov    (%eax),%eax
  80054b:	83 e8 04             	sub    $0x4,%eax
  80054e:	8b 00                	mov    (%eax),%eax
  800550:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800555:	5d                   	pop    %ebp
  800556:	c3                   	ret    

00800557 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800557:	55                   	push   %ebp
  800558:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80055a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80055e:	7e 1c                	jle    80057c <getint+0x25>
		return va_arg(*ap, long long);
  800560:	8b 45 08             	mov    0x8(%ebp),%eax
  800563:	8b 00                	mov    (%eax),%eax
  800565:	8d 50 08             	lea    0x8(%eax),%edx
  800568:	8b 45 08             	mov    0x8(%ebp),%eax
  80056b:	89 10                	mov    %edx,(%eax)
  80056d:	8b 45 08             	mov    0x8(%ebp),%eax
  800570:	8b 00                	mov    (%eax),%eax
  800572:	83 e8 08             	sub    $0x8,%eax
  800575:	8b 50 04             	mov    0x4(%eax),%edx
  800578:	8b 00                	mov    (%eax),%eax
  80057a:	eb 38                	jmp    8005b4 <getint+0x5d>
	else if (lflag)
  80057c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800580:	74 1a                	je     80059c <getint+0x45>
		return va_arg(*ap, long);
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	8b 00                	mov    (%eax),%eax
  800587:	8d 50 04             	lea    0x4(%eax),%edx
  80058a:	8b 45 08             	mov    0x8(%ebp),%eax
  80058d:	89 10                	mov    %edx,(%eax)
  80058f:	8b 45 08             	mov    0x8(%ebp),%eax
  800592:	8b 00                	mov    (%eax),%eax
  800594:	83 e8 04             	sub    $0x4,%eax
  800597:	8b 00                	mov    (%eax),%eax
  800599:	99                   	cltd   
  80059a:	eb 18                	jmp    8005b4 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80059c:	8b 45 08             	mov    0x8(%ebp),%eax
  80059f:	8b 00                	mov    (%eax),%eax
  8005a1:	8d 50 04             	lea    0x4(%eax),%edx
  8005a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a7:	89 10                	mov    %edx,(%eax)
  8005a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ac:	8b 00                	mov    (%eax),%eax
  8005ae:	83 e8 04             	sub    $0x4,%eax
  8005b1:	8b 00                	mov    (%eax),%eax
  8005b3:	99                   	cltd   
}
  8005b4:	5d                   	pop    %ebp
  8005b5:	c3                   	ret    

008005b6 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8005b6:	55                   	push   %ebp
  8005b7:	89 e5                	mov    %esp,%ebp
  8005b9:	56                   	push   %esi
  8005ba:	53                   	push   %ebx
  8005bb:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005be:	eb 17                	jmp    8005d7 <vprintfmt+0x21>
			if (ch == '\0')
  8005c0:	85 db                	test   %ebx,%ebx
  8005c2:	0f 84 af 03 00 00    	je     800977 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8005c8:	83 ec 08             	sub    $0x8,%esp
  8005cb:	ff 75 0c             	pushl  0xc(%ebp)
  8005ce:	53                   	push   %ebx
  8005cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d2:	ff d0                	call   *%eax
  8005d4:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8005da:	8d 50 01             	lea    0x1(%eax),%edx
  8005dd:	89 55 10             	mov    %edx,0x10(%ebp)
  8005e0:	8a 00                	mov    (%eax),%al
  8005e2:	0f b6 d8             	movzbl %al,%ebx
  8005e5:	83 fb 25             	cmp    $0x25,%ebx
  8005e8:	75 d6                	jne    8005c0 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8005ea:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8005ee:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8005f5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8005fc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800603:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80060a:	8b 45 10             	mov    0x10(%ebp),%eax
  80060d:	8d 50 01             	lea    0x1(%eax),%edx
  800610:	89 55 10             	mov    %edx,0x10(%ebp)
  800613:	8a 00                	mov    (%eax),%al
  800615:	0f b6 d8             	movzbl %al,%ebx
  800618:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80061b:	83 f8 55             	cmp    $0x55,%eax
  80061e:	0f 87 2b 03 00 00    	ja     80094f <vprintfmt+0x399>
  800624:	8b 04 85 f8 1d 80 00 	mov    0x801df8(,%eax,4),%eax
  80062b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80062d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800631:	eb d7                	jmp    80060a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800633:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800637:	eb d1                	jmp    80060a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800639:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800640:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800643:	89 d0                	mov    %edx,%eax
  800645:	c1 e0 02             	shl    $0x2,%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	01 c0                	add    %eax,%eax
  80064c:	01 d8                	add    %ebx,%eax
  80064e:	83 e8 30             	sub    $0x30,%eax
  800651:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800654:	8b 45 10             	mov    0x10(%ebp),%eax
  800657:	8a 00                	mov    (%eax),%al
  800659:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80065c:	83 fb 2f             	cmp    $0x2f,%ebx
  80065f:	7e 3e                	jle    80069f <vprintfmt+0xe9>
  800661:	83 fb 39             	cmp    $0x39,%ebx
  800664:	7f 39                	jg     80069f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800666:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800669:	eb d5                	jmp    800640 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80066b:	8b 45 14             	mov    0x14(%ebp),%eax
  80066e:	83 c0 04             	add    $0x4,%eax
  800671:	89 45 14             	mov    %eax,0x14(%ebp)
  800674:	8b 45 14             	mov    0x14(%ebp),%eax
  800677:	83 e8 04             	sub    $0x4,%eax
  80067a:	8b 00                	mov    (%eax),%eax
  80067c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80067f:	eb 1f                	jmp    8006a0 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800681:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800685:	79 83                	jns    80060a <vprintfmt+0x54>
				width = 0;
  800687:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80068e:	e9 77 ff ff ff       	jmp    80060a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800693:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80069a:	e9 6b ff ff ff       	jmp    80060a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80069f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8006a0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006a4:	0f 89 60 ff ff ff    	jns    80060a <vprintfmt+0x54>
				width = precision, precision = -1;
  8006aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8006b0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8006b7:	e9 4e ff ff ff       	jmp    80060a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8006bc:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8006bf:	e9 46 ff ff ff       	jmp    80060a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8006c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8006c7:	83 c0 04             	add    $0x4,%eax
  8006ca:	89 45 14             	mov    %eax,0x14(%ebp)
  8006cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8006d0:	83 e8 04             	sub    $0x4,%eax
  8006d3:	8b 00                	mov    (%eax),%eax
  8006d5:	83 ec 08             	sub    $0x8,%esp
  8006d8:	ff 75 0c             	pushl  0xc(%ebp)
  8006db:	50                   	push   %eax
  8006dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006df:	ff d0                	call   *%eax
  8006e1:	83 c4 10             	add    $0x10,%esp
			break;
  8006e4:	e9 89 02 00 00       	jmp    800972 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8006e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ec:	83 c0 04             	add    $0x4,%eax
  8006ef:	89 45 14             	mov    %eax,0x14(%ebp)
  8006f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f5:	83 e8 04             	sub    $0x4,%eax
  8006f8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8006fa:	85 db                	test   %ebx,%ebx
  8006fc:	79 02                	jns    800700 <vprintfmt+0x14a>
				err = -err;
  8006fe:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800700:	83 fb 64             	cmp    $0x64,%ebx
  800703:	7f 0b                	jg     800710 <vprintfmt+0x15a>
  800705:	8b 34 9d 40 1c 80 00 	mov    0x801c40(,%ebx,4),%esi
  80070c:	85 f6                	test   %esi,%esi
  80070e:	75 19                	jne    800729 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800710:	53                   	push   %ebx
  800711:	68 e5 1d 80 00       	push   $0x801de5
  800716:	ff 75 0c             	pushl  0xc(%ebp)
  800719:	ff 75 08             	pushl  0x8(%ebp)
  80071c:	e8 5e 02 00 00       	call   80097f <printfmt>
  800721:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800724:	e9 49 02 00 00       	jmp    800972 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800729:	56                   	push   %esi
  80072a:	68 ee 1d 80 00       	push   $0x801dee
  80072f:	ff 75 0c             	pushl  0xc(%ebp)
  800732:	ff 75 08             	pushl  0x8(%ebp)
  800735:	e8 45 02 00 00       	call   80097f <printfmt>
  80073a:	83 c4 10             	add    $0x10,%esp
			break;
  80073d:	e9 30 02 00 00       	jmp    800972 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800742:	8b 45 14             	mov    0x14(%ebp),%eax
  800745:	83 c0 04             	add    $0x4,%eax
  800748:	89 45 14             	mov    %eax,0x14(%ebp)
  80074b:	8b 45 14             	mov    0x14(%ebp),%eax
  80074e:	83 e8 04             	sub    $0x4,%eax
  800751:	8b 30                	mov    (%eax),%esi
  800753:	85 f6                	test   %esi,%esi
  800755:	75 05                	jne    80075c <vprintfmt+0x1a6>
				p = "(null)";
  800757:	be f1 1d 80 00       	mov    $0x801df1,%esi
			if (width > 0 && padc != '-')
  80075c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800760:	7e 6d                	jle    8007cf <vprintfmt+0x219>
  800762:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800766:	74 67                	je     8007cf <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800768:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80076b:	83 ec 08             	sub    $0x8,%esp
  80076e:	50                   	push   %eax
  80076f:	56                   	push   %esi
  800770:	e8 0c 03 00 00       	call   800a81 <strnlen>
  800775:	83 c4 10             	add    $0x10,%esp
  800778:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80077b:	eb 16                	jmp    800793 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80077d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800781:	83 ec 08             	sub    $0x8,%esp
  800784:	ff 75 0c             	pushl  0xc(%ebp)
  800787:	50                   	push   %eax
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	ff d0                	call   *%eax
  80078d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800790:	ff 4d e4             	decl   -0x1c(%ebp)
  800793:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800797:	7f e4                	jg     80077d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800799:	eb 34                	jmp    8007cf <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80079b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80079f:	74 1c                	je     8007bd <vprintfmt+0x207>
  8007a1:	83 fb 1f             	cmp    $0x1f,%ebx
  8007a4:	7e 05                	jle    8007ab <vprintfmt+0x1f5>
  8007a6:	83 fb 7e             	cmp    $0x7e,%ebx
  8007a9:	7e 12                	jle    8007bd <vprintfmt+0x207>
					putch('?', putdat);
  8007ab:	83 ec 08             	sub    $0x8,%esp
  8007ae:	ff 75 0c             	pushl  0xc(%ebp)
  8007b1:	6a 3f                	push   $0x3f
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	ff d0                	call   *%eax
  8007b8:	83 c4 10             	add    $0x10,%esp
  8007bb:	eb 0f                	jmp    8007cc <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8007bd:	83 ec 08             	sub    $0x8,%esp
  8007c0:	ff 75 0c             	pushl  0xc(%ebp)
  8007c3:	53                   	push   %ebx
  8007c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c7:	ff d0                	call   *%eax
  8007c9:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007cc:	ff 4d e4             	decl   -0x1c(%ebp)
  8007cf:	89 f0                	mov    %esi,%eax
  8007d1:	8d 70 01             	lea    0x1(%eax),%esi
  8007d4:	8a 00                	mov    (%eax),%al
  8007d6:	0f be d8             	movsbl %al,%ebx
  8007d9:	85 db                	test   %ebx,%ebx
  8007db:	74 24                	je     800801 <vprintfmt+0x24b>
  8007dd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007e1:	78 b8                	js     80079b <vprintfmt+0x1e5>
  8007e3:	ff 4d e0             	decl   -0x20(%ebp)
  8007e6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007ea:	79 af                	jns    80079b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007ec:	eb 13                	jmp    800801 <vprintfmt+0x24b>
				putch(' ', putdat);
  8007ee:	83 ec 08             	sub    $0x8,%esp
  8007f1:	ff 75 0c             	pushl  0xc(%ebp)
  8007f4:	6a 20                	push   $0x20
  8007f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f9:	ff d0                	call   *%eax
  8007fb:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007fe:	ff 4d e4             	decl   -0x1c(%ebp)
  800801:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800805:	7f e7                	jg     8007ee <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800807:	e9 66 01 00 00       	jmp    800972 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80080c:	83 ec 08             	sub    $0x8,%esp
  80080f:	ff 75 e8             	pushl  -0x18(%ebp)
  800812:	8d 45 14             	lea    0x14(%ebp),%eax
  800815:	50                   	push   %eax
  800816:	e8 3c fd ff ff       	call   800557 <getint>
  80081b:	83 c4 10             	add    $0x10,%esp
  80081e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800821:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800824:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800827:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80082a:	85 d2                	test   %edx,%edx
  80082c:	79 23                	jns    800851 <vprintfmt+0x29b>
				putch('-', putdat);
  80082e:	83 ec 08             	sub    $0x8,%esp
  800831:	ff 75 0c             	pushl  0xc(%ebp)
  800834:	6a 2d                	push   $0x2d
  800836:	8b 45 08             	mov    0x8(%ebp),%eax
  800839:	ff d0                	call   *%eax
  80083b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80083e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800841:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800844:	f7 d8                	neg    %eax
  800846:	83 d2 00             	adc    $0x0,%edx
  800849:	f7 da                	neg    %edx
  80084b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80084e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800851:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800858:	e9 bc 00 00 00       	jmp    800919 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80085d:	83 ec 08             	sub    $0x8,%esp
  800860:	ff 75 e8             	pushl  -0x18(%ebp)
  800863:	8d 45 14             	lea    0x14(%ebp),%eax
  800866:	50                   	push   %eax
  800867:	e8 84 fc ff ff       	call   8004f0 <getuint>
  80086c:	83 c4 10             	add    $0x10,%esp
  80086f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800872:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800875:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80087c:	e9 98 00 00 00       	jmp    800919 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800881:	83 ec 08             	sub    $0x8,%esp
  800884:	ff 75 0c             	pushl  0xc(%ebp)
  800887:	6a 58                	push   $0x58
  800889:	8b 45 08             	mov    0x8(%ebp),%eax
  80088c:	ff d0                	call   *%eax
  80088e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800891:	83 ec 08             	sub    $0x8,%esp
  800894:	ff 75 0c             	pushl  0xc(%ebp)
  800897:	6a 58                	push   $0x58
  800899:	8b 45 08             	mov    0x8(%ebp),%eax
  80089c:	ff d0                	call   *%eax
  80089e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008a1:	83 ec 08             	sub    $0x8,%esp
  8008a4:	ff 75 0c             	pushl  0xc(%ebp)
  8008a7:	6a 58                	push   $0x58
  8008a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ac:	ff d0                	call   *%eax
  8008ae:	83 c4 10             	add    $0x10,%esp
			break;
  8008b1:	e9 bc 00 00 00       	jmp    800972 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8008b6:	83 ec 08             	sub    $0x8,%esp
  8008b9:	ff 75 0c             	pushl  0xc(%ebp)
  8008bc:	6a 30                	push   $0x30
  8008be:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c1:	ff d0                	call   *%eax
  8008c3:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8008c6:	83 ec 08             	sub    $0x8,%esp
  8008c9:	ff 75 0c             	pushl  0xc(%ebp)
  8008cc:	6a 78                	push   $0x78
  8008ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d1:	ff d0                	call   *%eax
  8008d3:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8008d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d9:	83 c0 04             	add    $0x4,%eax
  8008dc:	89 45 14             	mov    %eax,0x14(%ebp)
  8008df:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e2:	83 e8 04             	sub    $0x4,%eax
  8008e5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8008e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8008f1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8008f8:	eb 1f                	jmp    800919 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8008fa:	83 ec 08             	sub    $0x8,%esp
  8008fd:	ff 75 e8             	pushl  -0x18(%ebp)
  800900:	8d 45 14             	lea    0x14(%ebp),%eax
  800903:	50                   	push   %eax
  800904:	e8 e7 fb ff ff       	call   8004f0 <getuint>
  800909:	83 c4 10             	add    $0x10,%esp
  80090c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80090f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800912:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800919:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80091d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800920:	83 ec 04             	sub    $0x4,%esp
  800923:	52                   	push   %edx
  800924:	ff 75 e4             	pushl  -0x1c(%ebp)
  800927:	50                   	push   %eax
  800928:	ff 75 f4             	pushl  -0xc(%ebp)
  80092b:	ff 75 f0             	pushl  -0x10(%ebp)
  80092e:	ff 75 0c             	pushl  0xc(%ebp)
  800931:	ff 75 08             	pushl  0x8(%ebp)
  800934:	e8 00 fb ff ff       	call   800439 <printnum>
  800939:	83 c4 20             	add    $0x20,%esp
			break;
  80093c:	eb 34                	jmp    800972 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80093e:	83 ec 08             	sub    $0x8,%esp
  800941:	ff 75 0c             	pushl  0xc(%ebp)
  800944:	53                   	push   %ebx
  800945:	8b 45 08             	mov    0x8(%ebp),%eax
  800948:	ff d0                	call   *%eax
  80094a:	83 c4 10             	add    $0x10,%esp
			break;
  80094d:	eb 23                	jmp    800972 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80094f:	83 ec 08             	sub    $0x8,%esp
  800952:	ff 75 0c             	pushl  0xc(%ebp)
  800955:	6a 25                	push   $0x25
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	ff d0                	call   *%eax
  80095c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80095f:	ff 4d 10             	decl   0x10(%ebp)
  800962:	eb 03                	jmp    800967 <vprintfmt+0x3b1>
  800964:	ff 4d 10             	decl   0x10(%ebp)
  800967:	8b 45 10             	mov    0x10(%ebp),%eax
  80096a:	48                   	dec    %eax
  80096b:	8a 00                	mov    (%eax),%al
  80096d:	3c 25                	cmp    $0x25,%al
  80096f:	75 f3                	jne    800964 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800971:	90                   	nop
		}
	}
  800972:	e9 47 fc ff ff       	jmp    8005be <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800977:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800978:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80097b:	5b                   	pop    %ebx
  80097c:	5e                   	pop    %esi
  80097d:	5d                   	pop    %ebp
  80097e:	c3                   	ret    

0080097f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80097f:	55                   	push   %ebp
  800980:	89 e5                	mov    %esp,%ebp
  800982:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800985:	8d 45 10             	lea    0x10(%ebp),%eax
  800988:	83 c0 04             	add    $0x4,%eax
  80098b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80098e:	8b 45 10             	mov    0x10(%ebp),%eax
  800991:	ff 75 f4             	pushl  -0xc(%ebp)
  800994:	50                   	push   %eax
  800995:	ff 75 0c             	pushl  0xc(%ebp)
  800998:	ff 75 08             	pushl  0x8(%ebp)
  80099b:	e8 16 fc ff ff       	call   8005b6 <vprintfmt>
  8009a0:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8009a3:	90                   	nop
  8009a4:	c9                   	leave  
  8009a5:	c3                   	ret    

008009a6 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8009a6:	55                   	push   %ebp
  8009a7:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8009a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ac:	8b 40 08             	mov    0x8(%eax),%eax
  8009af:	8d 50 01             	lea    0x1(%eax),%edx
  8009b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b5:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8009b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009bb:	8b 10                	mov    (%eax),%edx
  8009bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c0:	8b 40 04             	mov    0x4(%eax),%eax
  8009c3:	39 c2                	cmp    %eax,%edx
  8009c5:	73 12                	jae    8009d9 <sprintputch+0x33>
		*b->buf++ = ch;
  8009c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ca:	8b 00                	mov    (%eax),%eax
  8009cc:	8d 48 01             	lea    0x1(%eax),%ecx
  8009cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d2:	89 0a                	mov    %ecx,(%edx)
  8009d4:	8b 55 08             	mov    0x8(%ebp),%edx
  8009d7:	88 10                	mov    %dl,(%eax)
}
  8009d9:	90                   	nop
  8009da:	5d                   	pop    %ebp
  8009db:	c3                   	ret    

008009dc <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8009dc:	55                   	push   %ebp
  8009dd:	89 e5                	mov    %esp,%ebp
  8009df:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8009e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009eb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8009ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f1:	01 d0                	add    %edx,%eax
  8009f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8009fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a01:	74 06                	je     800a09 <vsnprintf+0x2d>
  800a03:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a07:	7f 07                	jg     800a10 <vsnprintf+0x34>
		return -E_INVAL;
  800a09:	b8 03 00 00 00       	mov    $0x3,%eax
  800a0e:	eb 20                	jmp    800a30 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a10:	ff 75 14             	pushl  0x14(%ebp)
  800a13:	ff 75 10             	pushl  0x10(%ebp)
  800a16:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a19:	50                   	push   %eax
  800a1a:	68 a6 09 80 00       	push   $0x8009a6
  800a1f:	e8 92 fb ff ff       	call   8005b6 <vprintfmt>
  800a24:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a27:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a2a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a30:	c9                   	leave  
  800a31:	c3                   	ret    

00800a32 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a32:	55                   	push   %ebp
  800a33:	89 e5                	mov    %esp,%ebp
  800a35:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a38:	8d 45 10             	lea    0x10(%ebp),%eax
  800a3b:	83 c0 04             	add    $0x4,%eax
  800a3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a41:	8b 45 10             	mov    0x10(%ebp),%eax
  800a44:	ff 75 f4             	pushl  -0xc(%ebp)
  800a47:	50                   	push   %eax
  800a48:	ff 75 0c             	pushl  0xc(%ebp)
  800a4b:	ff 75 08             	pushl  0x8(%ebp)
  800a4e:	e8 89 ff ff ff       	call   8009dc <vsnprintf>
  800a53:	83 c4 10             	add    $0x10,%esp
  800a56:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a59:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a5c:	c9                   	leave  
  800a5d:	c3                   	ret    

00800a5e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a5e:	55                   	push   %ebp
  800a5f:	89 e5                	mov    %esp,%ebp
  800a61:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a6b:	eb 06                	jmp    800a73 <strlen+0x15>
		n++;
  800a6d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a70:	ff 45 08             	incl   0x8(%ebp)
  800a73:	8b 45 08             	mov    0x8(%ebp),%eax
  800a76:	8a 00                	mov    (%eax),%al
  800a78:	84 c0                	test   %al,%al
  800a7a:	75 f1                	jne    800a6d <strlen+0xf>
		n++;
	return n;
  800a7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a7f:	c9                   	leave  
  800a80:	c3                   	ret    

00800a81 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a81:	55                   	push   %ebp
  800a82:	89 e5                	mov    %esp,%ebp
  800a84:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a87:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a8e:	eb 09                	jmp    800a99 <strnlen+0x18>
		n++;
  800a90:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a93:	ff 45 08             	incl   0x8(%ebp)
  800a96:	ff 4d 0c             	decl   0xc(%ebp)
  800a99:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a9d:	74 09                	je     800aa8 <strnlen+0x27>
  800a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa2:	8a 00                	mov    (%eax),%al
  800aa4:	84 c0                	test   %al,%al
  800aa6:	75 e8                	jne    800a90 <strnlen+0xf>
		n++;
	return n;
  800aa8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800aab:	c9                   	leave  
  800aac:	c3                   	ret    

00800aad <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800aad:	55                   	push   %ebp
  800aae:	89 e5                	mov    %esp,%ebp
  800ab0:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ab9:	90                   	nop
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	8d 50 01             	lea    0x1(%eax),%edx
  800ac0:	89 55 08             	mov    %edx,0x8(%ebp)
  800ac3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ac9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800acc:	8a 12                	mov    (%edx),%dl
  800ace:	88 10                	mov    %dl,(%eax)
  800ad0:	8a 00                	mov    (%eax),%al
  800ad2:	84 c0                	test   %al,%al
  800ad4:	75 e4                	jne    800aba <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ad6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ad9:	c9                   	leave  
  800ada:	c3                   	ret    

00800adb <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800adb:	55                   	push   %ebp
  800adc:	89 e5                	mov    %esp,%ebp
  800ade:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ae7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800aee:	eb 1f                	jmp    800b0f <strncpy+0x34>
		*dst++ = *src;
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	8d 50 01             	lea    0x1(%eax),%edx
  800af6:	89 55 08             	mov    %edx,0x8(%ebp)
  800af9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800afc:	8a 12                	mov    (%edx),%dl
  800afe:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b03:	8a 00                	mov    (%eax),%al
  800b05:	84 c0                	test   %al,%al
  800b07:	74 03                	je     800b0c <strncpy+0x31>
			src++;
  800b09:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b0c:	ff 45 fc             	incl   -0x4(%ebp)
  800b0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b12:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b15:	72 d9                	jb     800af0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b17:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b1a:	c9                   	leave  
  800b1b:	c3                   	ret    

00800b1c <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b1c:	55                   	push   %ebp
  800b1d:	89 e5                	mov    %esp,%ebp
  800b1f:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b22:	8b 45 08             	mov    0x8(%ebp),%eax
  800b25:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b28:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b2c:	74 30                	je     800b5e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b2e:	eb 16                	jmp    800b46 <strlcpy+0x2a>
			*dst++ = *src++;
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	8d 50 01             	lea    0x1(%eax),%edx
  800b36:	89 55 08             	mov    %edx,0x8(%ebp)
  800b39:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b3c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b3f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b42:	8a 12                	mov    (%edx),%dl
  800b44:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b46:	ff 4d 10             	decl   0x10(%ebp)
  800b49:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b4d:	74 09                	je     800b58 <strlcpy+0x3c>
  800b4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b52:	8a 00                	mov    (%eax),%al
  800b54:	84 c0                	test   %al,%al
  800b56:	75 d8                	jne    800b30 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b5e:	8b 55 08             	mov    0x8(%ebp),%edx
  800b61:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b64:	29 c2                	sub    %eax,%edx
  800b66:	89 d0                	mov    %edx,%eax
}
  800b68:	c9                   	leave  
  800b69:	c3                   	ret    

00800b6a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b6a:	55                   	push   %ebp
  800b6b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b6d:	eb 06                	jmp    800b75 <strcmp+0xb>
		p++, q++;
  800b6f:	ff 45 08             	incl   0x8(%ebp)
  800b72:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	8a 00                	mov    (%eax),%al
  800b7a:	84 c0                	test   %al,%al
  800b7c:	74 0e                	je     800b8c <strcmp+0x22>
  800b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b81:	8a 10                	mov    (%eax),%dl
  800b83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b86:	8a 00                	mov    (%eax),%al
  800b88:	38 c2                	cmp    %al,%dl
  800b8a:	74 e3                	je     800b6f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	8a 00                	mov    (%eax),%al
  800b91:	0f b6 d0             	movzbl %al,%edx
  800b94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b97:	8a 00                	mov    (%eax),%al
  800b99:	0f b6 c0             	movzbl %al,%eax
  800b9c:	29 c2                	sub    %eax,%edx
  800b9e:	89 d0                	mov    %edx,%eax
}
  800ba0:	5d                   	pop    %ebp
  800ba1:	c3                   	ret    

00800ba2 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ba2:	55                   	push   %ebp
  800ba3:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ba5:	eb 09                	jmp    800bb0 <strncmp+0xe>
		n--, p++, q++;
  800ba7:	ff 4d 10             	decl   0x10(%ebp)
  800baa:	ff 45 08             	incl   0x8(%ebp)
  800bad:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800bb0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bb4:	74 17                	je     800bcd <strncmp+0x2b>
  800bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb9:	8a 00                	mov    (%eax),%al
  800bbb:	84 c0                	test   %al,%al
  800bbd:	74 0e                	je     800bcd <strncmp+0x2b>
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc2:	8a 10                	mov    (%eax),%dl
  800bc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc7:	8a 00                	mov    (%eax),%al
  800bc9:	38 c2                	cmp    %al,%dl
  800bcb:	74 da                	je     800ba7 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800bcd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bd1:	75 07                	jne    800bda <strncmp+0x38>
		return 0;
  800bd3:	b8 00 00 00 00       	mov    $0x0,%eax
  800bd8:	eb 14                	jmp    800bee <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800bda:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdd:	8a 00                	mov    (%eax),%al
  800bdf:	0f b6 d0             	movzbl %al,%edx
  800be2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be5:	8a 00                	mov    (%eax),%al
  800be7:	0f b6 c0             	movzbl %al,%eax
  800bea:	29 c2                	sub    %eax,%edx
  800bec:	89 d0                	mov    %edx,%eax
}
  800bee:	5d                   	pop    %ebp
  800bef:	c3                   	ret    

00800bf0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800bf0:	55                   	push   %ebp
  800bf1:	89 e5                	mov    %esp,%ebp
  800bf3:	83 ec 04             	sub    $0x4,%esp
  800bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800bfc:	eb 12                	jmp    800c10 <strchr+0x20>
		if (*s == c)
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	8a 00                	mov    (%eax),%al
  800c03:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c06:	75 05                	jne    800c0d <strchr+0x1d>
			return (char *) s;
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	eb 11                	jmp    800c1e <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c0d:	ff 45 08             	incl   0x8(%ebp)
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	8a 00                	mov    (%eax),%al
  800c15:	84 c0                	test   %al,%al
  800c17:	75 e5                	jne    800bfe <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c19:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c1e:	c9                   	leave  
  800c1f:	c3                   	ret    

00800c20 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c20:	55                   	push   %ebp
  800c21:	89 e5                	mov    %esp,%ebp
  800c23:	83 ec 04             	sub    $0x4,%esp
  800c26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c29:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c2c:	eb 0d                	jmp    800c3b <strfind+0x1b>
		if (*s == c)
  800c2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c31:	8a 00                	mov    (%eax),%al
  800c33:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c36:	74 0e                	je     800c46 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c38:	ff 45 08             	incl   0x8(%ebp)
  800c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3e:	8a 00                	mov    (%eax),%al
  800c40:	84 c0                	test   %al,%al
  800c42:	75 ea                	jne    800c2e <strfind+0xe>
  800c44:	eb 01                	jmp    800c47 <strfind+0x27>
		if (*s == c)
			break;
  800c46:	90                   	nop
	return (char *) s;
  800c47:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c4a:	c9                   	leave  
  800c4b:	c3                   	ret    

00800c4c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800c4c:	55                   	push   %ebp
  800c4d:	89 e5                	mov    %esp,%ebp
  800c4f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800c58:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800c5e:	eb 0e                	jmp    800c6e <memset+0x22>
		*p++ = c;
  800c60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c63:	8d 50 01             	lea    0x1(%eax),%edx
  800c66:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800c69:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c6c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800c6e:	ff 4d f8             	decl   -0x8(%ebp)
  800c71:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800c75:	79 e9                	jns    800c60 <memset+0x14>
		*p++ = c;

	return v;
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c7a:	c9                   	leave  
  800c7b:	c3                   	ret    

00800c7c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800c7c:	55                   	push   %ebp
  800c7d:	89 e5                	mov    %esp,%ebp
  800c7f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800c8e:	eb 16                	jmp    800ca6 <memcpy+0x2a>
		*d++ = *s++;
  800c90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c93:	8d 50 01             	lea    0x1(%eax),%edx
  800c96:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c99:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c9c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c9f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ca2:	8a 12                	mov    (%edx),%dl
  800ca4:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ca6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cac:	89 55 10             	mov    %edx,0x10(%ebp)
  800caf:	85 c0                	test   %eax,%eax
  800cb1:	75 dd                	jne    800c90 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800cb3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cb6:	c9                   	leave  
  800cb7:	c3                   	ret    

00800cb8 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800cb8:	55                   	push   %ebp
  800cb9:	89 e5                	mov    %esp,%ebp
  800cbb:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800cbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800cca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ccd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800cd0:	73 50                	jae    800d22 <memmove+0x6a>
  800cd2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800cd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd8:	01 d0                	add    %edx,%eax
  800cda:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800cdd:	76 43                	jbe    800d22 <memmove+0x6a>
		s += n;
  800cdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ce5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ceb:	eb 10                	jmp    800cfd <memmove+0x45>
			*--d = *--s;
  800ced:	ff 4d f8             	decl   -0x8(%ebp)
  800cf0:	ff 4d fc             	decl   -0x4(%ebp)
  800cf3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf6:	8a 10                	mov    (%eax),%dl
  800cf8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cfb:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800cfd:	8b 45 10             	mov    0x10(%ebp),%eax
  800d00:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d03:	89 55 10             	mov    %edx,0x10(%ebp)
  800d06:	85 c0                	test   %eax,%eax
  800d08:	75 e3                	jne    800ced <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800d0a:	eb 23                	jmp    800d2f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800d0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d0f:	8d 50 01             	lea    0x1(%eax),%edx
  800d12:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d15:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d18:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d1b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d1e:	8a 12                	mov    (%edx),%dl
  800d20:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800d22:	8b 45 10             	mov    0x10(%ebp),%eax
  800d25:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d28:	89 55 10             	mov    %edx,0x10(%ebp)
  800d2b:	85 c0                	test   %eax,%eax
  800d2d:	75 dd                	jne    800d0c <memmove+0x54>
			*d++ = *s++;

	return dst;
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d32:	c9                   	leave  
  800d33:	c3                   	ret    

00800d34 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800d34:	55                   	push   %ebp
  800d35:	89 e5                	mov    %esp,%ebp
  800d37:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800d40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d43:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800d46:	eb 2a                	jmp    800d72 <memcmp+0x3e>
		if (*s1 != *s2)
  800d48:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d4b:	8a 10                	mov    (%eax),%dl
  800d4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d50:	8a 00                	mov    (%eax),%al
  800d52:	38 c2                	cmp    %al,%dl
  800d54:	74 16                	je     800d6c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800d56:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d59:	8a 00                	mov    (%eax),%al
  800d5b:	0f b6 d0             	movzbl %al,%edx
  800d5e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	0f b6 c0             	movzbl %al,%eax
  800d66:	29 c2                	sub    %eax,%edx
  800d68:	89 d0                	mov    %edx,%eax
  800d6a:	eb 18                	jmp    800d84 <memcmp+0x50>
		s1++, s2++;
  800d6c:	ff 45 fc             	incl   -0x4(%ebp)
  800d6f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800d72:	8b 45 10             	mov    0x10(%ebp),%eax
  800d75:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d78:	89 55 10             	mov    %edx,0x10(%ebp)
  800d7b:	85 c0                	test   %eax,%eax
  800d7d:	75 c9                	jne    800d48 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800d7f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d84:	c9                   	leave  
  800d85:	c3                   	ret    

00800d86 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800d86:	55                   	push   %ebp
  800d87:	89 e5                	mov    %esp,%ebp
  800d89:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800d8c:	8b 55 08             	mov    0x8(%ebp),%edx
  800d8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d92:	01 d0                	add    %edx,%eax
  800d94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800d97:	eb 15                	jmp    800dae <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	8a 00                	mov    (%eax),%al
  800d9e:	0f b6 d0             	movzbl %al,%edx
  800da1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da4:	0f b6 c0             	movzbl %al,%eax
  800da7:	39 c2                	cmp    %eax,%edx
  800da9:	74 0d                	je     800db8 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800dab:	ff 45 08             	incl   0x8(%ebp)
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800db4:	72 e3                	jb     800d99 <memfind+0x13>
  800db6:	eb 01                	jmp    800db9 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800db8:	90                   	nop
	return (void *) s;
  800db9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dbc:	c9                   	leave  
  800dbd:	c3                   	ret    

00800dbe <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800dbe:	55                   	push   %ebp
  800dbf:	89 e5                	mov    %esp,%ebp
  800dc1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800dc4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800dcb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800dd2:	eb 03                	jmp    800dd7 <strtol+0x19>
		s++;
  800dd4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dda:	8a 00                	mov    (%eax),%al
  800ddc:	3c 20                	cmp    $0x20,%al
  800dde:	74 f4                	je     800dd4 <strtol+0x16>
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	8a 00                	mov    (%eax),%al
  800de5:	3c 09                	cmp    $0x9,%al
  800de7:	74 eb                	je     800dd4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800de9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dec:	8a 00                	mov    (%eax),%al
  800dee:	3c 2b                	cmp    $0x2b,%al
  800df0:	75 05                	jne    800df7 <strtol+0x39>
		s++;
  800df2:	ff 45 08             	incl   0x8(%ebp)
  800df5:	eb 13                	jmp    800e0a <strtol+0x4c>
	else if (*s == '-')
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	8a 00                	mov    (%eax),%al
  800dfc:	3c 2d                	cmp    $0x2d,%al
  800dfe:	75 0a                	jne    800e0a <strtol+0x4c>
		s++, neg = 1;
  800e00:	ff 45 08             	incl   0x8(%ebp)
  800e03:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800e0a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e0e:	74 06                	je     800e16 <strtol+0x58>
  800e10:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800e14:	75 20                	jne    800e36 <strtol+0x78>
  800e16:	8b 45 08             	mov    0x8(%ebp),%eax
  800e19:	8a 00                	mov    (%eax),%al
  800e1b:	3c 30                	cmp    $0x30,%al
  800e1d:	75 17                	jne    800e36 <strtol+0x78>
  800e1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e22:	40                   	inc    %eax
  800e23:	8a 00                	mov    (%eax),%al
  800e25:	3c 78                	cmp    $0x78,%al
  800e27:	75 0d                	jne    800e36 <strtol+0x78>
		s += 2, base = 16;
  800e29:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800e2d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800e34:	eb 28                	jmp    800e5e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800e36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e3a:	75 15                	jne    800e51 <strtol+0x93>
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3f:	8a 00                	mov    (%eax),%al
  800e41:	3c 30                	cmp    $0x30,%al
  800e43:	75 0c                	jne    800e51 <strtol+0x93>
		s++, base = 8;
  800e45:	ff 45 08             	incl   0x8(%ebp)
  800e48:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800e4f:	eb 0d                	jmp    800e5e <strtol+0xa0>
	else if (base == 0)
  800e51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e55:	75 07                	jne    800e5e <strtol+0xa0>
		base = 10;
  800e57:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	8a 00                	mov    (%eax),%al
  800e63:	3c 2f                	cmp    $0x2f,%al
  800e65:	7e 19                	jle    800e80 <strtol+0xc2>
  800e67:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6a:	8a 00                	mov    (%eax),%al
  800e6c:	3c 39                	cmp    $0x39,%al
  800e6e:	7f 10                	jg     800e80 <strtol+0xc2>
			dig = *s - '0';
  800e70:	8b 45 08             	mov    0x8(%ebp),%eax
  800e73:	8a 00                	mov    (%eax),%al
  800e75:	0f be c0             	movsbl %al,%eax
  800e78:	83 e8 30             	sub    $0x30,%eax
  800e7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e7e:	eb 42                	jmp    800ec2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800e80:	8b 45 08             	mov    0x8(%ebp),%eax
  800e83:	8a 00                	mov    (%eax),%al
  800e85:	3c 60                	cmp    $0x60,%al
  800e87:	7e 19                	jle    800ea2 <strtol+0xe4>
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	8a 00                	mov    (%eax),%al
  800e8e:	3c 7a                	cmp    $0x7a,%al
  800e90:	7f 10                	jg     800ea2 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
  800e95:	8a 00                	mov    (%eax),%al
  800e97:	0f be c0             	movsbl %al,%eax
  800e9a:	83 e8 57             	sub    $0x57,%eax
  800e9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ea0:	eb 20                	jmp    800ec2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	8a 00                	mov    (%eax),%al
  800ea7:	3c 40                	cmp    $0x40,%al
  800ea9:	7e 39                	jle    800ee4 <strtol+0x126>
  800eab:	8b 45 08             	mov    0x8(%ebp),%eax
  800eae:	8a 00                	mov    (%eax),%al
  800eb0:	3c 5a                	cmp    $0x5a,%al
  800eb2:	7f 30                	jg     800ee4 <strtol+0x126>
			dig = *s - 'A' + 10;
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb7:	8a 00                	mov    (%eax),%al
  800eb9:	0f be c0             	movsbl %al,%eax
  800ebc:	83 e8 37             	sub    $0x37,%eax
  800ebf:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800ec2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ec5:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ec8:	7d 19                	jge    800ee3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800eca:	ff 45 08             	incl   0x8(%ebp)
  800ecd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed0:	0f af 45 10          	imul   0x10(%ebp),%eax
  800ed4:	89 c2                	mov    %eax,%edx
  800ed6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ed9:	01 d0                	add    %edx,%eax
  800edb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800ede:	e9 7b ff ff ff       	jmp    800e5e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800ee3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800ee4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ee8:	74 08                	je     800ef2 <strtol+0x134>
		*endptr = (char *) s;
  800eea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eed:	8b 55 08             	mov    0x8(%ebp),%edx
  800ef0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800ef2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ef6:	74 07                	je     800eff <strtol+0x141>
  800ef8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800efb:	f7 d8                	neg    %eax
  800efd:	eb 03                	jmp    800f02 <strtol+0x144>
  800eff:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f02:	c9                   	leave  
  800f03:	c3                   	ret    

00800f04 <ltostr>:

void
ltostr(long value, char *str)
{
  800f04:	55                   	push   %ebp
  800f05:	89 e5                	mov    %esp,%ebp
  800f07:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800f0a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800f11:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800f18:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f1c:	79 13                	jns    800f31 <ltostr+0x2d>
	{
		neg = 1;
  800f1e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800f25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f28:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800f2b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800f2e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800f39:	99                   	cltd   
  800f3a:	f7 f9                	idiv   %ecx
  800f3c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800f3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f42:	8d 50 01             	lea    0x1(%eax),%edx
  800f45:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f48:	89 c2                	mov    %eax,%edx
  800f4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4d:	01 d0                	add    %edx,%eax
  800f4f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800f52:	83 c2 30             	add    $0x30,%edx
  800f55:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800f57:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f5a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f5f:	f7 e9                	imul   %ecx
  800f61:	c1 fa 02             	sar    $0x2,%edx
  800f64:	89 c8                	mov    %ecx,%eax
  800f66:	c1 f8 1f             	sar    $0x1f,%eax
  800f69:	29 c2                	sub    %eax,%edx
  800f6b:	89 d0                	mov    %edx,%eax
  800f6d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800f70:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f73:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f78:	f7 e9                	imul   %ecx
  800f7a:	c1 fa 02             	sar    $0x2,%edx
  800f7d:	89 c8                	mov    %ecx,%eax
  800f7f:	c1 f8 1f             	sar    $0x1f,%eax
  800f82:	29 c2                	sub    %eax,%edx
  800f84:	89 d0                	mov    %edx,%eax
  800f86:	c1 e0 02             	shl    $0x2,%eax
  800f89:	01 d0                	add    %edx,%eax
  800f8b:	01 c0                	add    %eax,%eax
  800f8d:	29 c1                	sub    %eax,%ecx
  800f8f:	89 ca                	mov    %ecx,%edx
  800f91:	85 d2                	test   %edx,%edx
  800f93:	75 9c                	jne    800f31 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800f95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800f9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9f:	48                   	dec    %eax
  800fa0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800fa3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fa7:	74 3d                	je     800fe6 <ltostr+0xe2>
		start = 1 ;
  800fa9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800fb0:	eb 34                	jmp    800fe6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800fb2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb8:	01 d0                	add    %edx,%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800fbf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc5:	01 c2                	add    %eax,%edx
  800fc7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800fca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcd:	01 c8                	add    %ecx,%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800fd3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800fd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd9:	01 c2                	add    %eax,%edx
  800fdb:	8a 45 eb             	mov    -0x15(%ebp),%al
  800fde:	88 02                	mov    %al,(%edx)
		start++ ;
  800fe0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800fe3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800fe6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fe9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fec:	7c c4                	jl     800fb2 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800fee:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ff1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff4:	01 d0                	add    %edx,%eax
  800ff6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ff9:	90                   	nop
  800ffa:	c9                   	leave  
  800ffb:	c3                   	ret    

00800ffc <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ffc:	55                   	push   %ebp
  800ffd:	89 e5                	mov    %esp,%ebp
  800fff:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801002:	ff 75 08             	pushl  0x8(%ebp)
  801005:	e8 54 fa ff ff       	call   800a5e <strlen>
  80100a:	83 c4 04             	add    $0x4,%esp
  80100d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801010:	ff 75 0c             	pushl  0xc(%ebp)
  801013:	e8 46 fa ff ff       	call   800a5e <strlen>
  801018:	83 c4 04             	add    $0x4,%esp
  80101b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80101e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801025:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80102c:	eb 17                	jmp    801045 <strcconcat+0x49>
		final[s] = str1[s] ;
  80102e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801031:	8b 45 10             	mov    0x10(%ebp),%eax
  801034:	01 c2                	add    %eax,%edx
  801036:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
  80103c:	01 c8                	add    %ecx,%eax
  80103e:	8a 00                	mov    (%eax),%al
  801040:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801042:	ff 45 fc             	incl   -0x4(%ebp)
  801045:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801048:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80104b:	7c e1                	jl     80102e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80104d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801054:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80105b:	eb 1f                	jmp    80107c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80105d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801060:	8d 50 01             	lea    0x1(%eax),%edx
  801063:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801066:	89 c2                	mov    %eax,%edx
  801068:	8b 45 10             	mov    0x10(%ebp),%eax
  80106b:	01 c2                	add    %eax,%edx
  80106d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801070:	8b 45 0c             	mov    0xc(%ebp),%eax
  801073:	01 c8                	add    %ecx,%eax
  801075:	8a 00                	mov    (%eax),%al
  801077:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801079:	ff 45 f8             	incl   -0x8(%ebp)
  80107c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80107f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801082:	7c d9                	jl     80105d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801084:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801087:	8b 45 10             	mov    0x10(%ebp),%eax
  80108a:	01 d0                	add    %edx,%eax
  80108c:	c6 00 00             	movb   $0x0,(%eax)
}
  80108f:	90                   	nop
  801090:	c9                   	leave  
  801091:	c3                   	ret    

00801092 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801092:	55                   	push   %ebp
  801093:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801095:	8b 45 14             	mov    0x14(%ebp),%eax
  801098:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80109e:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a1:	8b 00                	mov    (%eax),%eax
  8010a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ad:	01 d0                	add    %edx,%eax
  8010af:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8010b5:	eb 0c                	jmp    8010c3 <strsplit+0x31>
			*string++ = 0;
  8010b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ba:	8d 50 01             	lea    0x1(%eax),%edx
  8010bd:	89 55 08             	mov    %edx,0x8(%ebp)
  8010c0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8010c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c6:	8a 00                	mov    (%eax),%al
  8010c8:	84 c0                	test   %al,%al
  8010ca:	74 18                	je     8010e4 <strsplit+0x52>
  8010cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cf:	8a 00                	mov    (%eax),%al
  8010d1:	0f be c0             	movsbl %al,%eax
  8010d4:	50                   	push   %eax
  8010d5:	ff 75 0c             	pushl  0xc(%ebp)
  8010d8:	e8 13 fb ff ff       	call   800bf0 <strchr>
  8010dd:	83 c4 08             	add    $0x8,%esp
  8010e0:	85 c0                	test   %eax,%eax
  8010e2:	75 d3                	jne    8010b7 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8010e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e7:	8a 00                	mov    (%eax),%al
  8010e9:	84 c0                	test   %al,%al
  8010eb:	74 5a                	je     801147 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8010ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8010f0:	8b 00                	mov    (%eax),%eax
  8010f2:	83 f8 0f             	cmp    $0xf,%eax
  8010f5:	75 07                	jne    8010fe <strsplit+0x6c>
		{
			return 0;
  8010f7:	b8 00 00 00 00       	mov    $0x0,%eax
  8010fc:	eb 66                	jmp    801164 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8010fe:	8b 45 14             	mov    0x14(%ebp),%eax
  801101:	8b 00                	mov    (%eax),%eax
  801103:	8d 48 01             	lea    0x1(%eax),%ecx
  801106:	8b 55 14             	mov    0x14(%ebp),%edx
  801109:	89 0a                	mov    %ecx,(%edx)
  80110b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801112:	8b 45 10             	mov    0x10(%ebp),%eax
  801115:	01 c2                	add    %eax,%edx
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80111c:	eb 03                	jmp    801121 <strsplit+0x8f>
			string++;
  80111e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801121:	8b 45 08             	mov    0x8(%ebp),%eax
  801124:	8a 00                	mov    (%eax),%al
  801126:	84 c0                	test   %al,%al
  801128:	74 8b                	je     8010b5 <strsplit+0x23>
  80112a:	8b 45 08             	mov    0x8(%ebp),%eax
  80112d:	8a 00                	mov    (%eax),%al
  80112f:	0f be c0             	movsbl %al,%eax
  801132:	50                   	push   %eax
  801133:	ff 75 0c             	pushl  0xc(%ebp)
  801136:	e8 b5 fa ff ff       	call   800bf0 <strchr>
  80113b:	83 c4 08             	add    $0x8,%esp
  80113e:	85 c0                	test   %eax,%eax
  801140:	74 dc                	je     80111e <strsplit+0x8c>
			string++;
	}
  801142:	e9 6e ff ff ff       	jmp    8010b5 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801147:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801148:	8b 45 14             	mov    0x14(%ebp),%eax
  80114b:	8b 00                	mov    (%eax),%eax
  80114d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801154:	8b 45 10             	mov    0x10(%ebp),%eax
  801157:	01 d0                	add    %edx,%eax
  801159:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80115f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801164:	c9                   	leave  
  801165:	c3                   	ret    

00801166 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801166:	55                   	push   %ebp
  801167:	89 e5                	mov    %esp,%ebp
  801169:	57                   	push   %edi
  80116a:	56                   	push   %esi
  80116b:	53                   	push   %ebx
  80116c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80116f:	8b 45 08             	mov    0x8(%ebp),%eax
  801172:	8b 55 0c             	mov    0xc(%ebp),%edx
  801175:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801178:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80117b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80117e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801181:	cd 30                	int    $0x30
  801183:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801186:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801189:	83 c4 10             	add    $0x10,%esp
  80118c:	5b                   	pop    %ebx
  80118d:	5e                   	pop    %esi
  80118e:	5f                   	pop    %edi
  80118f:	5d                   	pop    %ebp
  801190:	c3                   	ret    

00801191 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801191:	55                   	push   %ebp
  801192:	89 e5                	mov    %esp,%ebp
  801194:	83 ec 04             	sub    $0x4,%esp
  801197:	8b 45 10             	mov    0x10(%ebp),%eax
  80119a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80119d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8011a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	52                   	push   %edx
  8011a9:	ff 75 0c             	pushl  0xc(%ebp)
  8011ac:	50                   	push   %eax
  8011ad:	6a 00                	push   $0x0
  8011af:	e8 b2 ff ff ff       	call   801166 <syscall>
  8011b4:	83 c4 18             	add    $0x18,%esp
}
  8011b7:	90                   	nop
  8011b8:	c9                   	leave  
  8011b9:	c3                   	ret    

008011ba <sys_cgetc>:

int
sys_cgetc(void)
{
  8011ba:	55                   	push   %ebp
  8011bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 01                	push   $0x1
  8011c9:	e8 98 ff ff ff       	call   801166 <syscall>
  8011ce:	83 c4 18             	add    $0x18,%esp
}
  8011d1:	c9                   	leave  
  8011d2:	c3                   	ret    

008011d3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8011d3:	55                   	push   %ebp
  8011d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	6a 00                	push   $0x0
  8011db:	6a 00                	push   $0x0
  8011dd:	6a 00                	push   $0x0
  8011df:	6a 00                	push   $0x0
  8011e1:	50                   	push   %eax
  8011e2:	6a 05                	push   $0x5
  8011e4:	e8 7d ff ff ff       	call   801166 <syscall>
  8011e9:	83 c4 18             	add    $0x18,%esp
}
  8011ec:	c9                   	leave  
  8011ed:	c3                   	ret    

008011ee <sys_getenvid>:

int32 sys_getenvid(void)
{
  8011ee:	55                   	push   %ebp
  8011ef:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8011f1:	6a 00                	push   $0x0
  8011f3:	6a 00                	push   $0x0
  8011f5:	6a 00                	push   $0x0
  8011f7:	6a 00                	push   $0x0
  8011f9:	6a 00                	push   $0x0
  8011fb:	6a 02                	push   $0x2
  8011fd:	e8 64 ff ff ff       	call   801166 <syscall>
  801202:	83 c4 18             	add    $0x18,%esp
}
  801205:	c9                   	leave  
  801206:	c3                   	ret    

00801207 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801207:	55                   	push   %ebp
  801208:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	6a 00                	push   $0x0
  801210:	6a 00                	push   $0x0
  801212:	6a 00                	push   $0x0
  801214:	6a 03                	push   $0x3
  801216:	e8 4b ff ff ff       	call   801166 <syscall>
  80121b:	83 c4 18             	add    $0x18,%esp
}
  80121e:	c9                   	leave  
  80121f:	c3                   	ret    

00801220 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801220:	55                   	push   %ebp
  801221:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801223:	6a 00                	push   $0x0
  801225:	6a 00                	push   $0x0
  801227:	6a 00                	push   $0x0
  801229:	6a 00                	push   $0x0
  80122b:	6a 00                	push   $0x0
  80122d:	6a 04                	push   $0x4
  80122f:	e8 32 ff ff ff       	call   801166 <syscall>
  801234:	83 c4 18             	add    $0x18,%esp
}
  801237:	c9                   	leave  
  801238:	c3                   	ret    

00801239 <sys_env_exit>:


void sys_env_exit(void)
{
  801239:	55                   	push   %ebp
  80123a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80123c:	6a 00                	push   $0x0
  80123e:	6a 00                	push   $0x0
  801240:	6a 00                	push   $0x0
  801242:	6a 00                	push   $0x0
  801244:	6a 00                	push   $0x0
  801246:	6a 06                	push   $0x6
  801248:	e8 19 ff ff ff       	call   801166 <syscall>
  80124d:	83 c4 18             	add    $0x18,%esp
}
  801250:	90                   	nop
  801251:	c9                   	leave  
  801252:	c3                   	ret    

00801253 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801253:	55                   	push   %ebp
  801254:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801256:	8b 55 0c             	mov    0xc(%ebp),%edx
  801259:	8b 45 08             	mov    0x8(%ebp),%eax
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	52                   	push   %edx
  801263:	50                   	push   %eax
  801264:	6a 07                	push   $0x7
  801266:	e8 fb fe ff ff       	call   801166 <syscall>
  80126b:	83 c4 18             	add    $0x18,%esp
}
  80126e:	c9                   	leave  
  80126f:	c3                   	ret    

00801270 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801270:	55                   	push   %ebp
  801271:	89 e5                	mov    %esp,%ebp
  801273:	56                   	push   %esi
  801274:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801275:	8b 75 18             	mov    0x18(%ebp),%esi
  801278:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80127b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80127e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	56                   	push   %esi
  801285:	53                   	push   %ebx
  801286:	51                   	push   %ecx
  801287:	52                   	push   %edx
  801288:	50                   	push   %eax
  801289:	6a 08                	push   $0x8
  80128b:	e8 d6 fe ff ff       	call   801166 <syscall>
  801290:	83 c4 18             	add    $0x18,%esp
}
  801293:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801296:	5b                   	pop    %ebx
  801297:	5e                   	pop    %esi
  801298:	5d                   	pop    %ebp
  801299:	c3                   	ret    

0080129a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80129a:	55                   	push   %ebp
  80129b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80129d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	52                   	push   %edx
  8012aa:	50                   	push   %eax
  8012ab:	6a 09                	push   $0x9
  8012ad:	e8 b4 fe ff ff       	call   801166 <syscall>
  8012b2:	83 c4 18             	add    $0x18,%esp
}
  8012b5:	c9                   	leave  
  8012b6:	c3                   	ret    

008012b7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8012b7:	55                   	push   %ebp
  8012b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	ff 75 0c             	pushl  0xc(%ebp)
  8012c3:	ff 75 08             	pushl  0x8(%ebp)
  8012c6:	6a 0a                	push   $0xa
  8012c8:	e8 99 fe ff ff       	call   801166 <syscall>
  8012cd:	83 c4 18             	add    $0x18,%esp
}
  8012d0:	c9                   	leave  
  8012d1:	c3                   	ret    

008012d2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8012d2:	55                   	push   %ebp
  8012d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8012d5:	6a 00                	push   $0x0
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 0b                	push   $0xb
  8012e1:	e8 80 fe ff ff       	call   801166 <syscall>
  8012e6:	83 c4 18             	add    $0x18,%esp
}
  8012e9:	c9                   	leave  
  8012ea:	c3                   	ret    

008012eb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 0c                	push   $0xc
  8012fa:	e8 67 fe ff ff       	call   801166 <syscall>
  8012ff:	83 c4 18             	add    $0x18,%esp
}
  801302:	c9                   	leave  
  801303:	c3                   	ret    

00801304 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801304:	55                   	push   %ebp
  801305:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 00                	push   $0x0
  801311:	6a 0d                	push   $0xd
  801313:	e8 4e fe ff ff       	call   801166 <syscall>
  801318:	83 c4 18             	add    $0x18,%esp
}
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801320:	6a 00                	push   $0x0
  801322:	6a 00                	push   $0x0
  801324:	6a 00                	push   $0x0
  801326:	ff 75 0c             	pushl  0xc(%ebp)
  801329:	ff 75 08             	pushl  0x8(%ebp)
  80132c:	6a 11                	push   $0x11
  80132e:	e8 33 fe ff ff       	call   801166 <syscall>
  801333:	83 c4 18             	add    $0x18,%esp
	return;
  801336:	90                   	nop
}
  801337:	c9                   	leave  
  801338:	c3                   	ret    

00801339 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801339:	55                   	push   %ebp
  80133a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80133c:	6a 00                	push   $0x0
  80133e:	6a 00                	push   $0x0
  801340:	6a 00                	push   $0x0
  801342:	ff 75 0c             	pushl  0xc(%ebp)
  801345:	ff 75 08             	pushl  0x8(%ebp)
  801348:	6a 12                	push   $0x12
  80134a:	e8 17 fe ff ff       	call   801166 <syscall>
  80134f:	83 c4 18             	add    $0x18,%esp
	return ;
  801352:	90                   	nop
}
  801353:	c9                   	leave  
  801354:	c3                   	ret    

00801355 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801355:	55                   	push   %ebp
  801356:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801358:	6a 00                	push   $0x0
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	6a 00                	push   $0x0
  801362:	6a 0e                	push   $0xe
  801364:	e8 fd fd ff ff       	call   801166 <syscall>
  801369:	83 c4 18             	add    $0x18,%esp
}
  80136c:	c9                   	leave  
  80136d:	c3                   	ret    

0080136e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80136e:	55                   	push   %ebp
  80136f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	6a 00                	push   $0x0
  801377:	6a 00                	push   $0x0
  801379:	ff 75 08             	pushl  0x8(%ebp)
  80137c:	6a 0f                	push   $0xf
  80137e:	e8 e3 fd ff ff       	call   801166 <syscall>
  801383:	83 c4 18             	add    $0x18,%esp
}
  801386:	c9                   	leave  
  801387:	c3                   	ret    

00801388 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801388:	55                   	push   %ebp
  801389:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80138b:	6a 00                	push   $0x0
  80138d:	6a 00                	push   $0x0
  80138f:	6a 00                	push   $0x0
  801391:	6a 00                	push   $0x0
  801393:	6a 00                	push   $0x0
  801395:	6a 10                	push   $0x10
  801397:	e8 ca fd ff ff       	call   801166 <syscall>
  80139c:	83 c4 18             	add    $0x18,%esp
}
  80139f:	90                   	nop
  8013a0:	c9                   	leave  
  8013a1:	c3                   	ret    

008013a2 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8013a2:	55                   	push   %ebp
  8013a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 00                	push   $0x0
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 14                	push   $0x14
  8013b1:	e8 b0 fd ff ff       	call   801166 <syscall>
  8013b6:	83 c4 18             	add    $0x18,%esp
}
  8013b9:	90                   	nop
  8013ba:	c9                   	leave  
  8013bb:	c3                   	ret    

008013bc <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8013bc:	55                   	push   %ebp
  8013bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 15                	push   $0x15
  8013cb:	e8 96 fd ff ff       	call   801166 <syscall>
  8013d0:	83 c4 18             	add    $0x18,%esp
}
  8013d3:	90                   	nop
  8013d4:	c9                   	leave  
  8013d5:	c3                   	ret    

008013d6 <sys_cputc>:


void
sys_cputc(const char c)
{
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
  8013d9:	83 ec 04             	sub    $0x4,%esp
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8013e2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	50                   	push   %eax
  8013ef:	6a 16                	push   $0x16
  8013f1:	e8 70 fd ff ff       	call   801166 <syscall>
  8013f6:	83 c4 18             	add    $0x18,%esp
}
  8013f9:	90                   	nop
  8013fa:	c9                   	leave  
  8013fb:	c3                   	ret    

008013fc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8013fc:	55                   	push   %ebp
  8013fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 17                	push   $0x17
  80140b:	e8 56 fd ff ff       	call   801166 <syscall>
  801410:	83 c4 18             	add    $0x18,%esp
}
  801413:	90                   	nop
  801414:	c9                   	leave  
  801415:	c3                   	ret    

00801416 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	ff 75 0c             	pushl  0xc(%ebp)
  801425:	50                   	push   %eax
  801426:	6a 18                	push   $0x18
  801428:	e8 39 fd ff ff       	call   801166 <syscall>
  80142d:	83 c4 18             	add    $0x18,%esp
}
  801430:	c9                   	leave  
  801431:	c3                   	ret    

00801432 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801435:	8b 55 0c             	mov    0xc(%ebp),%edx
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	52                   	push   %edx
  801442:	50                   	push   %eax
  801443:	6a 1b                	push   $0x1b
  801445:	e8 1c fd ff ff       	call   801166 <syscall>
  80144a:	83 c4 18             	add    $0x18,%esp
}
  80144d:	c9                   	leave  
  80144e:	c3                   	ret    

0080144f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80144f:	55                   	push   %ebp
  801450:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801452:	8b 55 0c             	mov    0xc(%ebp),%edx
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	52                   	push   %edx
  80145f:	50                   	push   %eax
  801460:	6a 19                	push   $0x19
  801462:	e8 ff fc ff ff       	call   801166 <syscall>
  801467:	83 c4 18             	add    $0x18,%esp
}
  80146a:	90                   	nop
  80146b:	c9                   	leave  
  80146c:	c3                   	ret    

0080146d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80146d:	55                   	push   %ebp
  80146e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801470:	8b 55 0c             	mov    0xc(%ebp),%edx
  801473:	8b 45 08             	mov    0x8(%ebp),%eax
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	52                   	push   %edx
  80147d:	50                   	push   %eax
  80147e:	6a 1a                	push   $0x1a
  801480:	e8 e1 fc ff ff       	call   801166 <syscall>
  801485:	83 c4 18             	add    $0x18,%esp
}
  801488:	90                   	nop
  801489:	c9                   	leave  
  80148a:	c3                   	ret    

0080148b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80148b:	55                   	push   %ebp
  80148c:	89 e5                	mov    %esp,%ebp
  80148e:	83 ec 04             	sub    $0x4,%esp
  801491:	8b 45 10             	mov    0x10(%ebp),%eax
  801494:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801497:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80149a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80149e:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a1:	6a 00                	push   $0x0
  8014a3:	51                   	push   %ecx
  8014a4:	52                   	push   %edx
  8014a5:	ff 75 0c             	pushl  0xc(%ebp)
  8014a8:	50                   	push   %eax
  8014a9:	6a 1c                	push   $0x1c
  8014ab:	e8 b6 fc ff ff       	call   801166 <syscall>
  8014b0:	83 c4 18             	add    $0x18,%esp
}
  8014b3:	c9                   	leave  
  8014b4:	c3                   	ret    

008014b5 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8014b5:	55                   	push   %ebp
  8014b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8014b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	52                   	push   %edx
  8014c5:	50                   	push   %eax
  8014c6:	6a 1d                	push   $0x1d
  8014c8:	e8 99 fc ff ff       	call   801166 <syscall>
  8014cd:	83 c4 18             	add    $0x18,%esp
}
  8014d0:	c9                   	leave  
  8014d1:	c3                   	ret    

008014d2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8014d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014db:	8b 45 08             	mov    0x8(%ebp),%eax
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	51                   	push   %ecx
  8014e3:	52                   	push   %edx
  8014e4:	50                   	push   %eax
  8014e5:	6a 1e                	push   $0x1e
  8014e7:	e8 7a fc ff ff       	call   801166 <syscall>
  8014ec:	83 c4 18             	add    $0x18,%esp
}
  8014ef:	c9                   	leave  
  8014f0:	c3                   	ret    

008014f1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8014f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	52                   	push   %edx
  801501:	50                   	push   %eax
  801502:	6a 1f                	push   $0x1f
  801504:	e8 5d fc ff ff       	call   801166 <syscall>
  801509:	83 c4 18             	add    $0x18,%esp
}
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 20                	push   $0x20
  80151d:	e8 44 fc ff ff       	call   801166 <syscall>
  801522:	83 c4 18             	add    $0x18,%esp
}
  801525:	c9                   	leave  
  801526:	c3                   	ret    

00801527 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801527:	55                   	push   %ebp
  801528:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	6a 00                	push   $0x0
  80152f:	ff 75 14             	pushl  0x14(%ebp)
  801532:	ff 75 10             	pushl  0x10(%ebp)
  801535:	ff 75 0c             	pushl  0xc(%ebp)
  801538:	50                   	push   %eax
  801539:	6a 21                	push   $0x21
  80153b:	e8 26 fc ff ff       	call   801166 <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
}
  801543:	c9                   	leave  
  801544:	c3                   	ret    

00801545 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801548:	8b 45 08             	mov    0x8(%ebp),%eax
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	50                   	push   %eax
  801554:	6a 22                	push   $0x22
  801556:	e8 0b fc ff ff       	call   801166 <syscall>
  80155b:	83 c4 18             	add    $0x18,%esp
}
  80155e:	90                   	nop
  80155f:	c9                   	leave  
  801560:	c3                   	ret    

00801561 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801561:	55                   	push   %ebp
  801562:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801564:	8b 45 08             	mov    0x8(%ebp),%eax
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	50                   	push   %eax
  801570:	6a 23                	push   $0x23
  801572:	e8 ef fb ff ff       	call   801166 <syscall>
  801577:	83 c4 18             	add    $0x18,%esp
}
  80157a:	90                   	nop
  80157b:	c9                   	leave  
  80157c:	c3                   	ret    

0080157d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80157d:	55                   	push   %ebp
  80157e:	89 e5                	mov    %esp,%ebp
  801580:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801583:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801586:	8d 50 04             	lea    0x4(%eax),%edx
  801589:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	52                   	push   %edx
  801593:	50                   	push   %eax
  801594:	6a 24                	push   $0x24
  801596:	e8 cb fb ff ff       	call   801166 <syscall>
  80159b:	83 c4 18             	add    $0x18,%esp
	return result;
  80159e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8015a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a7:	89 01                	mov    %eax,(%ecx)
  8015a9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8015ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8015af:	c9                   	leave  
  8015b0:	c2 04 00             	ret    $0x4

008015b3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	ff 75 10             	pushl  0x10(%ebp)
  8015bd:	ff 75 0c             	pushl  0xc(%ebp)
  8015c0:	ff 75 08             	pushl  0x8(%ebp)
  8015c3:	6a 13                	push   $0x13
  8015c5:	e8 9c fb ff ff       	call   801166 <syscall>
  8015ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8015cd:	90                   	nop
}
  8015ce:	c9                   	leave  
  8015cf:	c3                   	ret    

008015d0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8015d0:	55                   	push   %ebp
  8015d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 25                	push   $0x25
  8015df:	e8 82 fb ff ff       	call   801166 <syscall>
  8015e4:	83 c4 18             	add    $0x18,%esp
}
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
  8015ec:	83 ec 04             	sub    $0x4,%esp
  8015ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8015f5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	50                   	push   %eax
  801602:	6a 26                	push   $0x26
  801604:	e8 5d fb ff ff       	call   801166 <syscall>
  801609:	83 c4 18             	add    $0x18,%esp
	return ;
  80160c:	90                   	nop
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <rsttst>:
void rsttst()
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 28                	push   $0x28
  80161e:	e8 43 fb ff ff       	call   801166 <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
	return ;
  801626:	90                   	nop
}
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
  80162c:	83 ec 04             	sub    $0x4,%esp
  80162f:	8b 45 14             	mov    0x14(%ebp),%eax
  801632:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801635:	8b 55 18             	mov    0x18(%ebp),%edx
  801638:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80163c:	52                   	push   %edx
  80163d:	50                   	push   %eax
  80163e:	ff 75 10             	pushl  0x10(%ebp)
  801641:	ff 75 0c             	pushl  0xc(%ebp)
  801644:	ff 75 08             	pushl  0x8(%ebp)
  801647:	6a 27                	push   $0x27
  801649:	e8 18 fb ff ff       	call   801166 <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
	return ;
  801651:	90                   	nop
}
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <chktst>:
void chktst(uint32 n)
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	ff 75 08             	pushl  0x8(%ebp)
  801662:	6a 29                	push   $0x29
  801664:	e8 fd fa ff ff       	call   801166 <syscall>
  801669:	83 c4 18             	add    $0x18,%esp
	return ;
  80166c:	90                   	nop
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <inctst>:

void inctst()
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 2a                	push   $0x2a
  80167e:	e8 e3 fa ff ff       	call   801166 <syscall>
  801683:	83 c4 18             	add    $0x18,%esp
	return ;
  801686:	90                   	nop
}
  801687:	c9                   	leave  
  801688:	c3                   	ret    

00801689 <gettst>:
uint32 gettst()
{
  801689:	55                   	push   %ebp
  80168a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 2b                	push   $0x2b
  801698:	e8 c9 fa ff ff       	call   801166 <syscall>
  80169d:	83 c4 18             	add    $0x18,%esp
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
  8016a5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 2c                	push   $0x2c
  8016b4:	e8 ad fa ff ff       	call   801166 <syscall>
  8016b9:	83 c4 18             	add    $0x18,%esp
  8016bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8016bf:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8016c3:	75 07                	jne    8016cc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8016c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8016ca:	eb 05                	jmp    8016d1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8016cc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016d1:	c9                   	leave  
  8016d2:	c3                   	ret    

008016d3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8016d3:	55                   	push   %ebp
  8016d4:	89 e5                	mov    %esp,%ebp
  8016d6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 2c                	push   $0x2c
  8016e5:	e8 7c fa ff ff       	call   801166 <syscall>
  8016ea:	83 c4 18             	add    $0x18,%esp
  8016ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8016f0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8016f4:	75 07                	jne    8016fd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8016f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8016fb:	eb 05                	jmp    801702 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8016fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801702:	c9                   	leave  
  801703:	c3                   	ret    

00801704 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
  801707:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 2c                	push   $0x2c
  801716:	e8 4b fa ff ff       	call   801166 <syscall>
  80171b:	83 c4 18             	add    $0x18,%esp
  80171e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801721:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801725:	75 07                	jne    80172e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801727:	b8 01 00 00 00       	mov    $0x1,%eax
  80172c:	eb 05                	jmp    801733 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80172e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801733:	c9                   	leave  
  801734:	c3                   	ret    

00801735 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801735:	55                   	push   %ebp
  801736:	89 e5                	mov    %esp,%ebp
  801738:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 2c                	push   $0x2c
  801747:	e8 1a fa ff ff       	call   801166 <syscall>
  80174c:	83 c4 18             	add    $0x18,%esp
  80174f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801752:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801756:	75 07                	jne    80175f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801758:	b8 01 00 00 00       	mov    $0x1,%eax
  80175d:	eb 05                	jmp    801764 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80175f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801764:	c9                   	leave  
  801765:	c3                   	ret    

00801766 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801766:	55                   	push   %ebp
  801767:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	ff 75 08             	pushl  0x8(%ebp)
  801774:	6a 2d                	push   $0x2d
  801776:	e8 eb f9 ff ff       	call   801166 <syscall>
  80177b:	83 c4 18             	add    $0x18,%esp
	return ;
  80177e:	90                   	nop
}
  80177f:	c9                   	leave  
  801780:	c3                   	ret    

00801781 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801781:	55                   	push   %ebp
  801782:	89 e5                	mov    %esp,%ebp
  801784:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801785:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801788:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80178b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178e:	8b 45 08             	mov    0x8(%ebp),%eax
  801791:	6a 00                	push   $0x0
  801793:	53                   	push   %ebx
  801794:	51                   	push   %ecx
  801795:	52                   	push   %edx
  801796:	50                   	push   %eax
  801797:	6a 2e                	push   $0x2e
  801799:	e8 c8 f9 ff ff       	call   801166 <syscall>
  80179e:	83 c4 18             	add    $0x18,%esp
}
  8017a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    

008017a6 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8017a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	52                   	push   %edx
  8017b6:	50                   	push   %eax
  8017b7:	6a 2f                	push   $0x2f
  8017b9:	e8 a8 f9 ff ff       	call   801166 <syscall>
  8017be:	83 c4 18             	add    $0x18,%esp
}
  8017c1:	c9                   	leave  
  8017c2:	c3                   	ret    
  8017c3:	90                   	nop

008017c4 <__udivdi3>:
  8017c4:	55                   	push   %ebp
  8017c5:	57                   	push   %edi
  8017c6:	56                   	push   %esi
  8017c7:	53                   	push   %ebx
  8017c8:	83 ec 1c             	sub    $0x1c,%esp
  8017cb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8017cf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8017d3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017d7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8017db:	89 ca                	mov    %ecx,%edx
  8017dd:	89 f8                	mov    %edi,%eax
  8017df:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8017e3:	85 f6                	test   %esi,%esi
  8017e5:	75 2d                	jne    801814 <__udivdi3+0x50>
  8017e7:	39 cf                	cmp    %ecx,%edi
  8017e9:	77 65                	ja     801850 <__udivdi3+0x8c>
  8017eb:	89 fd                	mov    %edi,%ebp
  8017ed:	85 ff                	test   %edi,%edi
  8017ef:	75 0b                	jne    8017fc <__udivdi3+0x38>
  8017f1:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f6:	31 d2                	xor    %edx,%edx
  8017f8:	f7 f7                	div    %edi
  8017fa:	89 c5                	mov    %eax,%ebp
  8017fc:	31 d2                	xor    %edx,%edx
  8017fe:	89 c8                	mov    %ecx,%eax
  801800:	f7 f5                	div    %ebp
  801802:	89 c1                	mov    %eax,%ecx
  801804:	89 d8                	mov    %ebx,%eax
  801806:	f7 f5                	div    %ebp
  801808:	89 cf                	mov    %ecx,%edi
  80180a:	89 fa                	mov    %edi,%edx
  80180c:	83 c4 1c             	add    $0x1c,%esp
  80180f:	5b                   	pop    %ebx
  801810:	5e                   	pop    %esi
  801811:	5f                   	pop    %edi
  801812:	5d                   	pop    %ebp
  801813:	c3                   	ret    
  801814:	39 ce                	cmp    %ecx,%esi
  801816:	77 28                	ja     801840 <__udivdi3+0x7c>
  801818:	0f bd fe             	bsr    %esi,%edi
  80181b:	83 f7 1f             	xor    $0x1f,%edi
  80181e:	75 40                	jne    801860 <__udivdi3+0x9c>
  801820:	39 ce                	cmp    %ecx,%esi
  801822:	72 0a                	jb     80182e <__udivdi3+0x6a>
  801824:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801828:	0f 87 9e 00 00 00    	ja     8018cc <__udivdi3+0x108>
  80182e:	b8 01 00 00 00       	mov    $0x1,%eax
  801833:	89 fa                	mov    %edi,%edx
  801835:	83 c4 1c             	add    $0x1c,%esp
  801838:	5b                   	pop    %ebx
  801839:	5e                   	pop    %esi
  80183a:	5f                   	pop    %edi
  80183b:	5d                   	pop    %ebp
  80183c:	c3                   	ret    
  80183d:	8d 76 00             	lea    0x0(%esi),%esi
  801840:	31 ff                	xor    %edi,%edi
  801842:	31 c0                	xor    %eax,%eax
  801844:	89 fa                	mov    %edi,%edx
  801846:	83 c4 1c             	add    $0x1c,%esp
  801849:	5b                   	pop    %ebx
  80184a:	5e                   	pop    %esi
  80184b:	5f                   	pop    %edi
  80184c:	5d                   	pop    %ebp
  80184d:	c3                   	ret    
  80184e:	66 90                	xchg   %ax,%ax
  801850:	89 d8                	mov    %ebx,%eax
  801852:	f7 f7                	div    %edi
  801854:	31 ff                	xor    %edi,%edi
  801856:	89 fa                	mov    %edi,%edx
  801858:	83 c4 1c             	add    $0x1c,%esp
  80185b:	5b                   	pop    %ebx
  80185c:	5e                   	pop    %esi
  80185d:	5f                   	pop    %edi
  80185e:	5d                   	pop    %ebp
  80185f:	c3                   	ret    
  801860:	bd 20 00 00 00       	mov    $0x20,%ebp
  801865:	89 eb                	mov    %ebp,%ebx
  801867:	29 fb                	sub    %edi,%ebx
  801869:	89 f9                	mov    %edi,%ecx
  80186b:	d3 e6                	shl    %cl,%esi
  80186d:	89 c5                	mov    %eax,%ebp
  80186f:	88 d9                	mov    %bl,%cl
  801871:	d3 ed                	shr    %cl,%ebp
  801873:	89 e9                	mov    %ebp,%ecx
  801875:	09 f1                	or     %esi,%ecx
  801877:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80187b:	89 f9                	mov    %edi,%ecx
  80187d:	d3 e0                	shl    %cl,%eax
  80187f:	89 c5                	mov    %eax,%ebp
  801881:	89 d6                	mov    %edx,%esi
  801883:	88 d9                	mov    %bl,%cl
  801885:	d3 ee                	shr    %cl,%esi
  801887:	89 f9                	mov    %edi,%ecx
  801889:	d3 e2                	shl    %cl,%edx
  80188b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80188f:	88 d9                	mov    %bl,%cl
  801891:	d3 e8                	shr    %cl,%eax
  801893:	09 c2                	or     %eax,%edx
  801895:	89 d0                	mov    %edx,%eax
  801897:	89 f2                	mov    %esi,%edx
  801899:	f7 74 24 0c          	divl   0xc(%esp)
  80189d:	89 d6                	mov    %edx,%esi
  80189f:	89 c3                	mov    %eax,%ebx
  8018a1:	f7 e5                	mul    %ebp
  8018a3:	39 d6                	cmp    %edx,%esi
  8018a5:	72 19                	jb     8018c0 <__udivdi3+0xfc>
  8018a7:	74 0b                	je     8018b4 <__udivdi3+0xf0>
  8018a9:	89 d8                	mov    %ebx,%eax
  8018ab:	31 ff                	xor    %edi,%edi
  8018ad:	e9 58 ff ff ff       	jmp    80180a <__udivdi3+0x46>
  8018b2:	66 90                	xchg   %ax,%ax
  8018b4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8018b8:	89 f9                	mov    %edi,%ecx
  8018ba:	d3 e2                	shl    %cl,%edx
  8018bc:	39 c2                	cmp    %eax,%edx
  8018be:	73 e9                	jae    8018a9 <__udivdi3+0xe5>
  8018c0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8018c3:	31 ff                	xor    %edi,%edi
  8018c5:	e9 40 ff ff ff       	jmp    80180a <__udivdi3+0x46>
  8018ca:	66 90                	xchg   %ax,%ax
  8018cc:	31 c0                	xor    %eax,%eax
  8018ce:	e9 37 ff ff ff       	jmp    80180a <__udivdi3+0x46>
  8018d3:	90                   	nop

008018d4 <__umoddi3>:
  8018d4:	55                   	push   %ebp
  8018d5:	57                   	push   %edi
  8018d6:	56                   	push   %esi
  8018d7:	53                   	push   %ebx
  8018d8:	83 ec 1c             	sub    $0x1c,%esp
  8018db:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8018df:	8b 74 24 34          	mov    0x34(%esp),%esi
  8018e3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8018e7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8018eb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8018ef:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8018f3:	89 f3                	mov    %esi,%ebx
  8018f5:	89 fa                	mov    %edi,%edx
  8018f7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018fb:	89 34 24             	mov    %esi,(%esp)
  8018fe:	85 c0                	test   %eax,%eax
  801900:	75 1a                	jne    80191c <__umoddi3+0x48>
  801902:	39 f7                	cmp    %esi,%edi
  801904:	0f 86 a2 00 00 00    	jbe    8019ac <__umoddi3+0xd8>
  80190a:	89 c8                	mov    %ecx,%eax
  80190c:	89 f2                	mov    %esi,%edx
  80190e:	f7 f7                	div    %edi
  801910:	89 d0                	mov    %edx,%eax
  801912:	31 d2                	xor    %edx,%edx
  801914:	83 c4 1c             	add    $0x1c,%esp
  801917:	5b                   	pop    %ebx
  801918:	5e                   	pop    %esi
  801919:	5f                   	pop    %edi
  80191a:	5d                   	pop    %ebp
  80191b:	c3                   	ret    
  80191c:	39 f0                	cmp    %esi,%eax
  80191e:	0f 87 ac 00 00 00    	ja     8019d0 <__umoddi3+0xfc>
  801924:	0f bd e8             	bsr    %eax,%ebp
  801927:	83 f5 1f             	xor    $0x1f,%ebp
  80192a:	0f 84 ac 00 00 00    	je     8019dc <__umoddi3+0x108>
  801930:	bf 20 00 00 00       	mov    $0x20,%edi
  801935:	29 ef                	sub    %ebp,%edi
  801937:	89 fe                	mov    %edi,%esi
  801939:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80193d:	89 e9                	mov    %ebp,%ecx
  80193f:	d3 e0                	shl    %cl,%eax
  801941:	89 d7                	mov    %edx,%edi
  801943:	89 f1                	mov    %esi,%ecx
  801945:	d3 ef                	shr    %cl,%edi
  801947:	09 c7                	or     %eax,%edi
  801949:	89 e9                	mov    %ebp,%ecx
  80194b:	d3 e2                	shl    %cl,%edx
  80194d:	89 14 24             	mov    %edx,(%esp)
  801950:	89 d8                	mov    %ebx,%eax
  801952:	d3 e0                	shl    %cl,%eax
  801954:	89 c2                	mov    %eax,%edx
  801956:	8b 44 24 08          	mov    0x8(%esp),%eax
  80195a:	d3 e0                	shl    %cl,%eax
  80195c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801960:	8b 44 24 08          	mov    0x8(%esp),%eax
  801964:	89 f1                	mov    %esi,%ecx
  801966:	d3 e8                	shr    %cl,%eax
  801968:	09 d0                	or     %edx,%eax
  80196a:	d3 eb                	shr    %cl,%ebx
  80196c:	89 da                	mov    %ebx,%edx
  80196e:	f7 f7                	div    %edi
  801970:	89 d3                	mov    %edx,%ebx
  801972:	f7 24 24             	mull   (%esp)
  801975:	89 c6                	mov    %eax,%esi
  801977:	89 d1                	mov    %edx,%ecx
  801979:	39 d3                	cmp    %edx,%ebx
  80197b:	0f 82 87 00 00 00    	jb     801a08 <__umoddi3+0x134>
  801981:	0f 84 91 00 00 00    	je     801a18 <__umoddi3+0x144>
  801987:	8b 54 24 04          	mov    0x4(%esp),%edx
  80198b:	29 f2                	sub    %esi,%edx
  80198d:	19 cb                	sbb    %ecx,%ebx
  80198f:	89 d8                	mov    %ebx,%eax
  801991:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801995:	d3 e0                	shl    %cl,%eax
  801997:	89 e9                	mov    %ebp,%ecx
  801999:	d3 ea                	shr    %cl,%edx
  80199b:	09 d0                	or     %edx,%eax
  80199d:	89 e9                	mov    %ebp,%ecx
  80199f:	d3 eb                	shr    %cl,%ebx
  8019a1:	89 da                	mov    %ebx,%edx
  8019a3:	83 c4 1c             	add    $0x1c,%esp
  8019a6:	5b                   	pop    %ebx
  8019a7:	5e                   	pop    %esi
  8019a8:	5f                   	pop    %edi
  8019a9:	5d                   	pop    %ebp
  8019aa:	c3                   	ret    
  8019ab:	90                   	nop
  8019ac:	89 fd                	mov    %edi,%ebp
  8019ae:	85 ff                	test   %edi,%edi
  8019b0:	75 0b                	jne    8019bd <__umoddi3+0xe9>
  8019b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8019b7:	31 d2                	xor    %edx,%edx
  8019b9:	f7 f7                	div    %edi
  8019bb:	89 c5                	mov    %eax,%ebp
  8019bd:	89 f0                	mov    %esi,%eax
  8019bf:	31 d2                	xor    %edx,%edx
  8019c1:	f7 f5                	div    %ebp
  8019c3:	89 c8                	mov    %ecx,%eax
  8019c5:	f7 f5                	div    %ebp
  8019c7:	89 d0                	mov    %edx,%eax
  8019c9:	e9 44 ff ff ff       	jmp    801912 <__umoddi3+0x3e>
  8019ce:	66 90                	xchg   %ax,%ax
  8019d0:	89 c8                	mov    %ecx,%eax
  8019d2:	89 f2                	mov    %esi,%edx
  8019d4:	83 c4 1c             	add    $0x1c,%esp
  8019d7:	5b                   	pop    %ebx
  8019d8:	5e                   	pop    %esi
  8019d9:	5f                   	pop    %edi
  8019da:	5d                   	pop    %ebp
  8019db:	c3                   	ret    
  8019dc:	3b 04 24             	cmp    (%esp),%eax
  8019df:	72 06                	jb     8019e7 <__umoddi3+0x113>
  8019e1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8019e5:	77 0f                	ja     8019f6 <__umoddi3+0x122>
  8019e7:	89 f2                	mov    %esi,%edx
  8019e9:	29 f9                	sub    %edi,%ecx
  8019eb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8019ef:	89 14 24             	mov    %edx,(%esp)
  8019f2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8019f6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8019fa:	8b 14 24             	mov    (%esp),%edx
  8019fd:	83 c4 1c             	add    $0x1c,%esp
  801a00:	5b                   	pop    %ebx
  801a01:	5e                   	pop    %esi
  801a02:	5f                   	pop    %edi
  801a03:	5d                   	pop    %ebp
  801a04:	c3                   	ret    
  801a05:	8d 76 00             	lea    0x0(%esi),%esi
  801a08:	2b 04 24             	sub    (%esp),%eax
  801a0b:	19 fa                	sbb    %edi,%edx
  801a0d:	89 d1                	mov    %edx,%ecx
  801a0f:	89 c6                	mov    %eax,%esi
  801a11:	e9 71 ff ff ff       	jmp    801987 <__umoddi3+0xb3>
  801a16:	66 90                	xchg   %ax,%ax
  801a18:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801a1c:	72 ea                	jb     801a08 <__umoddi3+0x134>
  801a1e:	89 d9                	mov    %ebx,%ecx
  801a20:	e9 62 ff ff ff       	jmp    801987 <__umoddi3+0xb3>

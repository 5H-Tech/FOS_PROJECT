
obj/user/tst_sharing_5_slave:     file format elf32-i386


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
  800031:	e8 e3 00 00 00       	call   800119 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the free of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003e:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800042:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800049:	eb 23                	jmp    80006e <_main+0x36>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004b:	a1 20 30 80 00       	mov    0x803020,%eax
  800050:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800056:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800059:	c1 e2 04             	shl    $0x4,%edx
  80005c:	01 d0                	add    %edx,%eax
  80005e:	8a 40 04             	mov    0x4(%eax),%al
  800061:	84 c0                	test   %al,%al
  800063:	74 06                	je     80006b <_main+0x33>
			{
				fullWS = 0;
  800065:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800069:	eb 12                	jmp    80007d <_main+0x45>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006b:	ff 45 f0             	incl   -0x10(%ebp)
  80006e:	a1 20 30 80 00       	mov    0x803020,%eax
  800073:	8b 50 74             	mov    0x74(%eax),%edx
  800076:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800079:	39 c2                	cmp    %eax,%edx
  80007b:	77 ce                	ja     80004b <_main+0x13>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80007d:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800081:	74 14                	je     800097 <_main+0x5f>
  800083:	83 ec 04             	sub    $0x4,%esp
  800086:	68 e0 1e 80 00       	push   $0x801ee0
  80008b:	6a 12                	push   $0x12
  80008d:	68 fc 1e 80 00       	push   $0x801efc
  800092:	e8 c7 01 00 00       	call   80025e <_panic>
	}

	uint32 *x;
	x = sget(sys_getparentenvid(),"x");
  800097:	e8 23 16 00 00       	call   8016bf <sys_getparentenvid>
  80009c:	83 ec 08             	sub    $0x8,%esp
  80009f:	68 17 1f 80 00       	push   $0x801f17
  8000a4:	50                   	push   %eax
  8000a5:	e8 ad 14 00 00       	call   801557 <sget>
  8000aa:	83 c4 10             	add    $0x10,%esp
  8000ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int freeFrames = sys_calculate_free_frames() ;
  8000b0:	e8 bc 16 00 00       	call   801771 <sys_calculate_free_frames>
  8000b5:	89 45 e8             	mov    %eax,-0x18(%ebp)

	cprintf("Slave env used x (getSharedObject)\n");
  8000b8:	83 ec 0c             	sub    $0xc,%esp
  8000bb:	68 1c 1f 80 00       	push   $0x801f1c
  8000c0:	e8 3b 04 00 00       	call   800500 <cprintf>
  8000c5:	83 c4 10             	add    $0x10,%esp

	sfree(x);
  8000c8:	83 ec 0c             	sub    $0xc,%esp
  8000cb:	ff 75 ec             	pushl  -0x14(%ebp)
  8000ce:	e8 a1 14 00 00       	call   801574 <sfree>
  8000d3:	83 c4 10             	add    $0x10,%esp
	cprintf("Slave env removed x\n");
  8000d6:	83 ec 0c             	sub    $0xc,%esp
  8000d9:	68 40 1f 80 00       	push   $0x801f40
  8000de:	e8 1d 04 00 00       	call   800500 <cprintf>
  8000e3:	83 c4 10             	add    $0x10,%esp

	int diff = (sys_calculate_free_frames() - freeFrames);
  8000e6:	e8 86 16 00 00       	call   801771 <sys_calculate_free_frames>
  8000eb:	89 c2                	mov    %eax,%edx
  8000ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f0:	29 c2                	sub    %eax,%edx
  8000f2:	89 d0                	mov    %edx,%eax
  8000f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	if (diff != 1) panic("wrong free: frames removed not equal 1 !, correct frames to be removed is 1:\nfrom the env: 1 table for x\nframes_storage: not cleared yet\n");
  8000f7:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  8000fb:	74 14                	je     800111 <_main+0xd9>
  8000fd:	83 ec 04             	sub    $0x4,%esp
  800100:	68 58 1f 80 00       	push   $0x801f58
  800105:	6a 1f                	push   $0x1f
  800107:	68 fc 1e 80 00       	push   $0x801efc
  80010c:	e8 4d 01 00 00       	call   80025e <_panic>

	//to ensure that this environment is completed successfully
	inctst();
  800111:	e8 f8 19 00 00       	call   801b0e <inctst>

	return;
  800116:	90                   	nop
}
  800117:	c9                   	leave  
  800118:	c3                   	ret    

00800119 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800119:	55                   	push   %ebp
  80011a:	89 e5                	mov    %esp,%ebp
  80011c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80011f:	e8 82 15 00 00       	call   8016a6 <sys_getenvindex>
  800124:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800127:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80012a:	89 d0                	mov    %edx,%eax
  80012c:	c1 e0 03             	shl    $0x3,%eax
  80012f:	01 d0                	add    %edx,%eax
  800131:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800138:	01 c8                	add    %ecx,%eax
  80013a:	01 c0                	add    %eax,%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	01 c0                	add    %eax,%eax
  800140:	01 d0                	add    %edx,%eax
  800142:	89 c2                	mov    %eax,%edx
  800144:	c1 e2 05             	shl    $0x5,%edx
  800147:	29 c2                	sub    %eax,%edx
  800149:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800150:	89 c2                	mov    %eax,%edx
  800152:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800158:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80015d:	a1 20 30 80 00       	mov    0x803020,%eax
  800162:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800168:	84 c0                	test   %al,%al
  80016a:	74 0f                	je     80017b <libmain+0x62>
		binaryname = myEnv->prog_name;
  80016c:	a1 20 30 80 00       	mov    0x803020,%eax
  800171:	05 40 3c 01 00       	add    $0x13c40,%eax
  800176:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80017b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80017f:	7e 0a                	jle    80018b <libmain+0x72>
		binaryname = argv[0];
  800181:	8b 45 0c             	mov    0xc(%ebp),%eax
  800184:	8b 00                	mov    (%eax),%eax
  800186:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80018b:	83 ec 08             	sub    $0x8,%esp
  80018e:	ff 75 0c             	pushl  0xc(%ebp)
  800191:	ff 75 08             	pushl  0x8(%ebp)
  800194:	e8 9f fe ff ff       	call   800038 <_main>
  800199:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80019c:	e8 a0 16 00 00       	call   801841 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001a1:	83 ec 0c             	sub    $0xc,%esp
  8001a4:	68 fc 1f 80 00       	push   $0x801ffc
  8001a9:	e8 52 03 00 00       	call   800500 <cprintf>
  8001ae:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b6:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001bc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c1:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001c7:	83 ec 04             	sub    $0x4,%esp
  8001ca:	52                   	push   %edx
  8001cb:	50                   	push   %eax
  8001cc:	68 24 20 80 00       	push   $0x802024
  8001d1:	e8 2a 03 00 00       	call   800500 <cprintf>
  8001d6:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8001d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001de:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8001e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e9:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8001ef:	83 ec 04             	sub    $0x4,%esp
  8001f2:	52                   	push   %edx
  8001f3:	50                   	push   %eax
  8001f4:	68 4c 20 80 00       	push   $0x80204c
  8001f9:	e8 02 03 00 00       	call   800500 <cprintf>
  8001fe:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800201:	a1 20 30 80 00       	mov    0x803020,%eax
  800206:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80020c:	83 ec 08             	sub    $0x8,%esp
  80020f:	50                   	push   %eax
  800210:	68 8d 20 80 00       	push   $0x80208d
  800215:	e8 e6 02 00 00       	call   800500 <cprintf>
  80021a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80021d:	83 ec 0c             	sub    $0xc,%esp
  800220:	68 fc 1f 80 00       	push   $0x801ffc
  800225:	e8 d6 02 00 00       	call   800500 <cprintf>
  80022a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80022d:	e8 29 16 00 00       	call   80185b <sys_enable_interrupt>

	// exit gracefully
	exit();
  800232:	e8 19 00 00 00       	call   800250 <exit>
}
  800237:	90                   	nop
  800238:	c9                   	leave  
  800239:	c3                   	ret    

0080023a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80023a:	55                   	push   %ebp
  80023b:	89 e5                	mov    %esp,%ebp
  80023d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	6a 00                	push   $0x0
  800245:	e8 28 14 00 00       	call   801672 <sys_env_destroy>
  80024a:	83 c4 10             	add    $0x10,%esp
}
  80024d:	90                   	nop
  80024e:	c9                   	leave  
  80024f:	c3                   	ret    

00800250 <exit>:

void
exit(void)
{
  800250:	55                   	push   %ebp
  800251:	89 e5                	mov    %esp,%ebp
  800253:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800256:	e8 7d 14 00 00       	call   8016d8 <sys_env_exit>
}
  80025b:	90                   	nop
  80025c:	c9                   	leave  
  80025d:	c3                   	ret    

0080025e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80025e:	55                   	push   %ebp
  80025f:	89 e5                	mov    %esp,%ebp
  800261:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800264:	8d 45 10             	lea    0x10(%ebp),%eax
  800267:	83 c0 04             	add    $0x4,%eax
  80026a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80026d:	a1 18 31 80 00       	mov    0x803118,%eax
  800272:	85 c0                	test   %eax,%eax
  800274:	74 16                	je     80028c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800276:	a1 18 31 80 00       	mov    0x803118,%eax
  80027b:	83 ec 08             	sub    $0x8,%esp
  80027e:	50                   	push   %eax
  80027f:	68 a4 20 80 00       	push   $0x8020a4
  800284:	e8 77 02 00 00       	call   800500 <cprintf>
  800289:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80028c:	a1 00 30 80 00       	mov    0x803000,%eax
  800291:	ff 75 0c             	pushl  0xc(%ebp)
  800294:	ff 75 08             	pushl  0x8(%ebp)
  800297:	50                   	push   %eax
  800298:	68 a9 20 80 00       	push   $0x8020a9
  80029d:	e8 5e 02 00 00       	call   800500 <cprintf>
  8002a2:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a8:	83 ec 08             	sub    $0x8,%esp
  8002ab:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ae:	50                   	push   %eax
  8002af:	e8 e1 01 00 00       	call   800495 <vcprintf>
  8002b4:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002b7:	83 ec 08             	sub    $0x8,%esp
  8002ba:	6a 00                	push   $0x0
  8002bc:	68 c5 20 80 00       	push   $0x8020c5
  8002c1:	e8 cf 01 00 00       	call   800495 <vcprintf>
  8002c6:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002c9:	e8 82 ff ff ff       	call   800250 <exit>

	// should not return here
	while (1) ;
  8002ce:	eb fe                	jmp    8002ce <_panic+0x70>

008002d0 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002d0:	55                   	push   %ebp
  8002d1:	89 e5                	mov    %esp,%ebp
  8002d3:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002db:	8b 50 74             	mov    0x74(%eax),%edx
  8002de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002e1:	39 c2                	cmp    %eax,%edx
  8002e3:	74 14                	je     8002f9 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002e5:	83 ec 04             	sub    $0x4,%esp
  8002e8:	68 c8 20 80 00       	push   $0x8020c8
  8002ed:	6a 26                	push   $0x26
  8002ef:	68 14 21 80 00       	push   $0x802114
  8002f4:	e8 65 ff ff ff       	call   80025e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800300:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800307:	e9 b6 00 00 00       	jmp    8003c2 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80030c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80030f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800316:	8b 45 08             	mov    0x8(%ebp),%eax
  800319:	01 d0                	add    %edx,%eax
  80031b:	8b 00                	mov    (%eax),%eax
  80031d:	85 c0                	test   %eax,%eax
  80031f:	75 08                	jne    800329 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800321:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800324:	e9 96 00 00 00       	jmp    8003bf <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800329:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800330:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800337:	eb 5d                	jmp    800396 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800339:	a1 20 30 80 00       	mov    0x803020,%eax
  80033e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800344:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800347:	c1 e2 04             	shl    $0x4,%edx
  80034a:	01 d0                	add    %edx,%eax
  80034c:	8a 40 04             	mov    0x4(%eax),%al
  80034f:	84 c0                	test   %al,%al
  800351:	75 40                	jne    800393 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800353:	a1 20 30 80 00       	mov    0x803020,%eax
  800358:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80035e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800361:	c1 e2 04             	shl    $0x4,%edx
  800364:	01 d0                	add    %edx,%eax
  800366:	8b 00                	mov    (%eax),%eax
  800368:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80036b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80036e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800373:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800375:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800378:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80037f:	8b 45 08             	mov    0x8(%ebp),%eax
  800382:	01 c8                	add    %ecx,%eax
  800384:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800386:	39 c2                	cmp    %eax,%edx
  800388:	75 09                	jne    800393 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80038a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800391:	eb 12                	jmp    8003a5 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800393:	ff 45 e8             	incl   -0x18(%ebp)
  800396:	a1 20 30 80 00       	mov    0x803020,%eax
  80039b:	8b 50 74             	mov    0x74(%eax),%edx
  80039e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003a1:	39 c2                	cmp    %eax,%edx
  8003a3:	77 94                	ja     800339 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003a5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003a9:	75 14                	jne    8003bf <CheckWSWithoutLastIndex+0xef>
			panic(
  8003ab:	83 ec 04             	sub    $0x4,%esp
  8003ae:	68 20 21 80 00       	push   $0x802120
  8003b3:	6a 3a                	push   $0x3a
  8003b5:	68 14 21 80 00       	push   $0x802114
  8003ba:	e8 9f fe ff ff       	call   80025e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003bf:	ff 45 f0             	incl   -0x10(%ebp)
  8003c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003c8:	0f 8c 3e ff ff ff    	jl     80030c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003ce:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003d5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003dc:	eb 20                	jmp    8003fe <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003de:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003e9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003ec:	c1 e2 04             	shl    $0x4,%edx
  8003ef:	01 d0                	add    %edx,%eax
  8003f1:	8a 40 04             	mov    0x4(%eax),%al
  8003f4:	3c 01                	cmp    $0x1,%al
  8003f6:	75 03                	jne    8003fb <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8003f8:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003fb:	ff 45 e0             	incl   -0x20(%ebp)
  8003fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800403:	8b 50 74             	mov    0x74(%eax),%edx
  800406:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800409:	39 c2                	cmp    %eax,%edx
  80040b:	77 d1                	ja     8003de <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80040d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800410:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800413:	74 14                	je     800429 <CheckWSWithoutLastIndex+0x159>
		panic(
  800415:	83 ec 04             	sub    $0x4,%esp
  800418:	68 74 21 80 00       	push   $0x802174
  80041d:	6a 44                	push   $0x44
  80041f:	68 14 21 80 00       	push   $0x802114
  800424:	e8 35 fe ff ff       	call   80025e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800429:	90                   	nop
  80042a:	c9                   	leave  
  80042b:	c3                   	ret    

0080042c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80042c:	55                   	push   %ebp
  80042d:	89 e5                	mov    %esp,%ebp
  80042f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800432:	8b 45 0c             	mov    0xc(%ebp),%eax
  800435:	8b 00                	mov    (%eax),%eax
  800437:	8d 48 01             	lea    0x1(%eax),%ecx
  80043a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80043d:	89 0a                	mov    %ecx,(%edx)
  80043f:	8b 55 08             	mov    0x8(%ebp),%edx
  800442:	88 d1                	mov    %dl,%cl
  800444:	8b 55 0c             	mov    0xc(%ebp),%edx
  800447:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80044b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80044e:	8b 00                	mov    (%eax),%eax
  800450:	3d ff 00 00 00       	cmp    $0xff,%eax
  800455:	75 2c                	jne    800483 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800457:	a0 24 30 80 00       	mov    0x803024,%al
  80045c:	0f b6 c0             	movzbl %al,%eax
  80045f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800462:	8b 12                	mov    (%edx),%edx
  800464:	89 d1                	mov    %edx,%ecx
  800466:	8b 55 0c             	mov    0xc(%ebp),%edx
  800469:	83 c2 08             	add    $0x8,%edx
  80046c:	83 ec 04             	sub    $0x4,%esp
  80046f:	50                   	push   %eax
  800470:	51                   	push   %ecx
  800471:	52                   	push   %edx
  800472:	e8 b9 11 00 00       	call   801630 <sys_cputs>
  800477:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80047a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800483:	8b 45 0c             	mov    0xc(%ebp),%eax
  800486:	8b 40 04             	mov    0x4(%eax),%eax
  800489:	8d 50 01             	lea    0x1(%eax),%edx
  80048c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80048f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800492:	90                   	nop
  800493:	c9                   	leave  
  800494:	c3                   	ret    

00800495 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800495:	55                   	push   %ebp
  800496:	89 e5                	mov    %esp,%ebp
  800498:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80049e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004a5:	00 00 00 
	b.cnt = 0;
  8004a8:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004af:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004b2:	ff 75 0c             	pushl  0xc(%ebp)
  8004b5:	ff 75 08             	pushl  0x8(%ebp)
  8004b8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004be:	50                   	push   %eax
  8004bf:	68 2c 04 80 00       	push   $0x80042c
  8004c4:	e8 11 02 00 00       	call   8006da <vprintfmt>
  8004c9:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004cc:	a0 24 30 80 00       	mov    0x803024,%al
  8004d1:	0f b6 c0             	movzbl %al,%eax
  8004d4:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004da:	83 ec 04             	sub    $0x4,%esp
  8004dd:	50                   	push   %eax
  8004de:	52                   	push   %edx
  8004df:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004e5:	83 c0 08             	add    $0x8,%eax
  8004e8:	50                   	push   %eax
  8004e9:	e8 42 11 00 00       	call   801630 <sys_cputs>
  8004ee:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004f1:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8004f8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004fe:	c9                   	leave  
  8004ff:	c3                   	ret    

00800500 <cprintf>:

int cprintf(const char *fmt, ...) {
  800500:	55                   	push   %ebp
  800501:	89 e5                	mov    %esp,%ebp
  800503:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800506:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80050d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800510:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800513:	8b 45 08             	mov    0x8(%ebp),%eax
  800516:	83 ec 08             	sub    $0x8,%esp
  800519:	ff 75 f4             	pushl  -0xc(%ebp)
  80051c:	50                   	push   %eax
  80051d:	e8 73 ff ff ff       	call   800495 <vcprintf>
  800522:	83 c4 10             	add    $0x10,%esp
  800525:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800528:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80052b:	c9                   	leave  
  80052c:	c3                   	ret    

0080052d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80052d:	55                   	push   %ebp
  80052e:	89 e5                	mov    %esp,%ebp
  800530:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800533:	e8 09 13 00 00       	call   801841 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800538:	8d 45 0c             	lea    0xc(%ebp),%eax
  80053b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80053e:	8b 45 08             	mov    0x8(%ebp),%eax
  800541:	83 ec 08             	sub    $0x8,%esp
  800544:	ff 75 f4             	pushl  -0xc(%ebp)
  800547:	50                   	push   %eax
  800548:	e8 48 ff ff ff       	call   800495 <vcprintf>
  80054d:	83 c4 10             	add    $0x10,%esp
  800550:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800553:	e8 03 13 00 00       	call   80185b <sys_enable_interrupt>
	return cnt;
  800558:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80055b:	c9                   	leave  
  80055c:	c3                   	ret    

0080055d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80055d:	55                   	push   %ebp
  80055e:	89 e5                	mov    %esp,%ebp
  800560:	53                   	push   %ebx
  800561:	83 ec 14             	sub    $0x14,%esp
  800564:	8b 45 10             	mov    0x10(%ebp),%eax
  800567:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80056a:	8b 45 14             	mov    0x14(%ebp),%eax
  80056d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800570:	8b 45 18             	mov    0x18(%ebp),%eax
  800573:	ba 00 00 00 00       	mov    $0x0,%edx
  800578:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80057b:	77 55                	ja     8005d2 <printnum+0x75>
  80057d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800580:	72 05                	jb     800587 <printnum+0x2a>
  800582:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800585:	77 4b                	ja     8005d2 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800587:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80058a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80058d:	8b 45 18             	mov    0x18(%ebp),%eax
  800590:	ba 00 00 00 00       	mov    $0x0,%edx
  800595:	52                   	push   %edx
  800596:	50                   	push   %eax
  800597:	ff 75 f4             	pushl  -0xc(%ebp)
  80059a:	ff 75 f0             	pushl  -0x10(%ebp)
  80059d:	e8 c2 16 00 00       	call   801c64 <__udivdi3>
  8005a2:	83 c4 10             	add    $0x10,%esp
  8005a5:	83 ec 04             	sub    $0x4,%esp
  8005a8:	ff 75 20             	pushl  0x20(%ebp)
  8005ab:	53                   	push   %ebx
  8005ac:	ff 75 18             	pushl  0x18(%ebp)
  8005af:	52                   	push   %edx
  8005b0:	50                   	push   %eax
  8005b1:	ff 75 0c             	pushl  0xc(%ebp)
  8005b4:	ff 75 08             	pushl  0x8(%ebp)
  8005b7:	e8 a1 ff ff ff       	call   80055d <printnum>
  8005bc:	83 c4 20             	add    $0x20,%esp
  8005bf:	eb 1a                	jmp    8005db <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005c1:	83 ec 08             	sub    $0x8,%esp
  8005c4:	ff 75 0c             	pushl  0xc(%ebp)
  8005c7:	ff 75 20             	pushl  0x20(%ebp)
  8005ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cd:	ff d0                	call   *%eax
  8005cf:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005d2:	ff 4d 1c             	decl   0x1c(%ebp)
  8005d5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005d9:	7f e6                	jg     8005c1 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005db:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005de:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005e9:	53                   	push   %ebx
  8005ea:	51                   	push   %ecx
  8005eb:	52                   	push   %edx
  8005ec:	50                   	push   %eax
  8005ed:	e8 82 17 00 00       	call   801d74 <__umoddi3>
  8005f2:	83 c4 10             	add    $0x10,%esp
  8005f5:	05 d4 23 80 00       	add    $0x8023d4,%eax
  8005fa:	8a 00                	mov    (%eax),%al
  8005fc:	0f be c0             	movsbl %al,%eax
  8005ff:	83 ec 08             	sub    $0x8,%esp
  800602:	ff 75 0c             	pushl  0xc(%ebp)
  800605:	50                   	push   %eax
  800606:	8b 45 08             	mov    0x8(%ebp),%eax
  800609:	ff d0                	call   *%eax
  80060b:	83 c4 10             	add    $0x10,%esp
}
  80060e:	90                   	nop
  80060f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800612:	c9                   	leave  
  800613:	c3                   	ret    

00800614 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800614:	55                   	push   %ebp
  800615:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800617:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80061b:	7e 1c                	jle    800639 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80061d:	8b 45 08             	mov    0x8(%ebp),%eax
  800620:	8b 00                	mov    (%eax),%eax
  800622:	8d 50 08             	lea    0x8(%eax),%edx
  800625:	8b 45 08             	mov    0x8(%ebp),%eax
  800628:	89 10                	mov    %edx,(%eax)
  80062a:	8b 45 08             	mov    0x8(%ebp),%eax
  80062d:	8b 00                	mov    (%eax),%eax
  80062f:	83 e8 08             	sub    $0x8,%eax
  800632:	8b 50 04             	mov    0x4(%eax),%edx
  800635:	8b 00                	mov    (%eax),%eax
  800637:	eb 40                	jmp    800679 <getuint+0x65>
	else if (lflag)
  800639:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80063d:	74 1e                	je     80065d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80063f:	8b 45 08             	mov    0x8(%ebp),%eax
  800642:	8b 00                	mov    (%eax),%eax
  800644:	8d 50 04             	lea    0x4(%eax),%edx
  800647:	8b 45 08             	mov    0x8(%ebp),%eax
  80064a:	89 10                	mov    %edx,(%eax)
  80064c:	8b 45 08             	mov    0x8(%ebp),%eax
  80064f:	8b 00                	mov    (%eax),%eax
  800651:	83 e8 04             	sub    $0x4,%eax
  800654:	8b 00                	mov    (%eax),%eax
  800656:	ba 00 00 00 00       	mov    $0x0,%edx
  80065b:	eb 1c                	jmp    800679 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80065d:	8b 45 08             	mov    0x8(%ebp),%eax
  800660:	8b 00                	mov    (%eax),%eax
  800662:	8d 50 04             	lea    0x4(%eax),%edx
  800665:	8b 45 08             	mov    0x8(%ebp),%eax
  800668:	89 10                	mov    %edx,(%eax)
  80066a:	8b 45 08             	mov    0x8(%ebp),%eax
  80066d:	8b 00                	mov    (%eax),%eax
  80066f:	83 e8 04             	sub    $0x4,%eax
  800672:	8b 00                	mov    (%eax),%eax
  800674:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800679:	5d                   	pop    %ebp
  80067a:	c3                   	ret    

0080067b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80067b:	55                   	push   %ebp
  80067c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80067e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800682:	7e 1c                	jle    8006a0 <getint+0x25>
		return va_arg(*ap, long long);
  800684:	8b 45 08             	mov    0x8(%ebp),%eax
  800687:	8b 00                	mov    (%eax),%eax
  800689:	8d 50 08             	lea    0x8(%eax),%edx
  80068c:	8b 45 08             	mov    0x8(%ebp),%eax
  80068f:	89 10                	mov    %edx,(%eax)
  800691:	8b 45 08             	mov    0x8(%ebp),%eax
  800694:	8b 00                	mov    (%eax),%eax
  800696:	83 e8 08             	sub    $0x8,%eax
  800699:	8b 50 04             	mov    0x4(%eax),%edx
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	eb 38                	jmp    8006d8 <getint+0x5d>
	else if (lflag)
  8006a0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006a4:	74 1a                	je     8006c0 <getint+0x45>
		return va_arg(*ap, long);
  8006a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a9:	8b 00                	mov    (%eax),%eax
  8006ab:	8d 50 04             	lea    0x4(%eax),%edx
  8006ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b1:	89 10                	mov    %edx,(%eax)
  8006b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b6:	8b 00                	mov    (%eax),%eax
  8006b8:	83 e8 04             	sub    $0x4,%eax
  8006bb:	8b 00                	mov    (%eax),%eax
  8006bd:	99                   	cltd   
  8006be:	eb 18                	jmp    8006d8 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	8d 50 04             	lea    0x4(%eax),%edx
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	89 10                	mov    %edx,(%eax)
  8006cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d0:	8b 00                	mov    (%eax),%eax
  8006d2:	83 e8 04             	sub    $0x4,%eax
  8006d5:	8b 00                	mov    (%eax),%eax
  8006d7:	99                   	cltd   
}
  8006d8:	5d                   	pop    %ebp
  8006d9:	c3                   	ret    

008006da <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006da:	55                   	push   %ebp
  8006db:	89 e5                	mov    %esp,%ebp
  8006dd:	56                   	push   %esi
  8006de:	53                   	push   %ebx
  8006df:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006e2:	eb 17                	jmp    8006fb <vprintfmt+0x21>
			if (ch == '\0')
  8006e4:	85 db                	test   %ebx,%ebx
  8006e6:	0f 84 af 03 00 00    	je     800a9b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006ec:	83 ec 08             	sub    $0x8,%esp
  8006ef:	ff 75 0c             	pushl  0xc(%ebp)
  8006f2:	53                   	push   %ebx
  8006f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f6:	ff d0                	call   *%eax
  8006f8:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8006fe:	8d 50 01             	lea    0x1(%eax),%edx
  800701:	89 55 10             	mov    %edx,0x10(%ebp)
  800704:	8a 00                	mov    (%eax),%al
  800706:	0f b6 d8             	movzbl %al,%ebx
  800709:	83 fb 25             	cmp    $0x25,%ebx
  80070c:	75 d6                	jne    8006e4 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80070e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800712:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800719:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800720:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800727:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80072e:	8b 45 10             	mov    0x10(%ebp),%eax
  800731:	8d 50 01             	lea    0x1(%eax),%edx
  800734:	89 55 10             	mov    %edx,0x10(%ebp)
  800737:	8a 00                	mov    (%eax),%al
  800739:	0f b6 d8             	movzbl %al,%ebx
  80073c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80073f:	83 f8 55             	cmp    $0x55,%eax
  800742:	0f 87 2b 03 00 00    	ja     800a73 <vprintfmt+0x399>
  800748:	8b 04 85 f8 23 80 00 	mov    0x8023f8(,%eax,4),%eax
  80074f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800751:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800755:	eb d7                	jmp    80072e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800757:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80075b:	eb d1                	jmp    80072e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80075d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800764:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800767:	89 d0                	mov    %edx,%eax
  800769:	c1 e0 02             	shl    $0x2,%eax
  80076c:	01 d0                	add    %edx,%eax
  80076e:	01 c0                	add    %eax,%eax
  800770:	01 d8                	add    %ebx,%eax
  800772:	83 e8 30             	sub    $0x30,%eax
  800775:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800778:	8b 45 10             	mov    0x10(%ebp),%eax
  80077b:	8a 00                	mov    (%eax),%al
  80077d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800780:	83 fb 2f             	cmp    $0x2f,%ebx
  800783:	7e 3e                	jle    8007c3 <vprintfmt+0xe9>
  800785:	83 fb 39             	cmp    $0x39,%ebx
  800788:	7f 39                	jg     8007c3 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80078a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80078d:	eb d5                	jmp    800764 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80078f:	8b 45 14             	mov    0x14(%ebp),%eax
  800792:	83 c0 04             	add    $0x4,%eax
  800795:	89 45 14             	mov    %eax,0x14(%ebp)
  800798:	8b 45 14             	mov    0x14(%ebp),%eax
  80079b:	83 e8 04             	sub    $0x4,%eax
  80079e:	8b 00                	mov    (%eax),%eax
  8007a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007a3:	eb 1f                	jmp    8007c4 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007a5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007a9:	79 83                	jns    80072e <vprintfmt+0x54>
				width = 0;
  8007ab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007b2:	e9 77 ff ff ff       	jmp    80072e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007b7:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007be:	e9 6b ff ff ff       	jmp    80072e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007c3:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007c4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007c8:	0f 89 60 ff ff ff    	jns    80072e <vprintfmt+0x54>
				width = precision, precision = -1;
  8007ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007d4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007db:	e9 4e ff ff ff       	jmp    80072e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007e0:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007e3:	e9 46 ff ff ff       	jmp    80072e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007eb:	83 c0 04             	add    $0x4,%eax
  8007ee:	89 45 14             	mov    %eax,0x14(%ebp)
  8007f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f4:	83 e8 04             	sub    $0x4,%eax
  8007f7:	8b 00                	mov    (%eax),%eax
  8007f9:	83 ec 08             	sub    $0x8,%esp
  8007fc:	ff 75 0c             	pushl  0xc(%ebp)
  8007ff:	50                   	push   %eax
  800800:	8b 45 08             	mov    0x8(%ebp),%eax
  800803:	ff d0                	call   *%eax
  800805:	83 c4 10             	add    $0x10,%esp
			break;
  800808:	e9 89 02 00 00       	jmp    800a96 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80080d:	8b 45 14             	mov    0x14(%ebp),%eax
  800810:	83 c0 04             	add    $0x4,%eax
  800813:	89 45 14             	mov    %eax,0x14(%ebp)
  800816:	8b 45 14             	mov    0x14(%ebp),%eax
  800819:	83 e8 04             	sub    $0x4,%eax
  80081c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80081e:	85 db                	test   %ebx,%ebx
  800820:	79 02                	jns    800824 <vprintfmt+0x14a>
				err = -err;
  800822:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800824:	83 fb 64             	cmp    $0x64,%ebx
  800827:	7f 0b                	jg     800834 <vprintfmt+0x15a>
  800829:	8b 34 9d 40 22 80 00 	mov    0x802240(,%ebx,4),%esi
  800830:	85 f6                	test   %esi,%esi
  800832:	75 19                	jne    80084d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800834:	53                   	push   %ebx
  800835:	68 e5 23 80 00       	push   $0x8023e5
  80083a:	ff 75 0c             	pushl  0xc(%ebp)
  80083d:	ff 75 08             	pushl  0x8(%ebp)
  800840:	e8 5e 02 00 00       	call   800aa3 <printfmt>
  800845:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800848:	e9 49 02 00 00       	jmp    800a96 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80084d:	56                   	push   %esi
  80084e:	68 ee 23 80 00       	push   $0x8023ee
  800853:	ff 75 0c             	pushl  0xc(%ebp)
  800856:	ff 75 08             	pushl  0x8(%ebp)
  800859:	e8 45 02 00 00       	call   800aa3 <printfmt>
  80085e:	83 c4 10             	add    $0x10,%esp
			break;
  800861:	e9 30 02 00 00       	jmp    800a96 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800866:	8b 45 14             	mov    0x14(%ebp),%eax
  800869:	83 c0 04             	add    $0x4,%eax
  80086c:	89 45 14             	mov    %eax,0x14(%ebp)
  80086f:	8b 45 14             	mov    0x14(%ebp),%eax
  800872:	83 e8 04             	sub    $0x4,%eax
  800875:	8b 30                	mov    (%eax),%esi
  800877:	85 f6                	test   %esi,%esi
  800879:	75 05                	jne    800880 <vprintfmt+0x1a6>
				p = "(null)";
  80087b:	be f1 23 80 00       	mov    $0x8023f1,%esi
			if (width > 0 && padc != '-')
  800880:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800884:	7e 6d                	jle    8008f3 <vprintfmt+0x219>
  800886:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80088a:	74 67                	je     8008f3 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80088c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80088f:	83 ec 08             	sub    $0x8,%esp
  800892:	50                   	push   %eax
  800893:	56                   	push   %esi
  800894:	e8 0c 03 00 00       	call   800ba5 <strnlen>
  800899:	83 c4 10             	add    $0x10,%esp
  80089c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80089f:	eb 16                	jmp    8008b7 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008a1:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008a5:	83 ec 08             	sub    $0x8,%esp
  8008a8:	ff 75 0c             	pushl  0xc(%ebp)
  8008ab:	50                   	push   %eax
  8008ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8008af:	ff d0                	call   *%eax
  8008b1:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b4:	ff 4d e4             	decl   -0x1c(%ebp)
  8008b7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008bb:	7f e4                	jg     8008a1 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008bd:	eb 34                	jmp    8008f3 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008bf:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008c3:	74 1c                	je     8008e1 <vprintfmt+0x207>
  8008c5:	83 fb 1f             	cmp    $0x1f,%ebx
  8008c8:	7e 05                	jle    8008cf <vprintfmt+0x1f5>
  8008ca:	83 fb 7e             	cmp    $0x7e,%ebx
  8008cd:	7e 12                	jle    8008e1 <vprintfmt+0x207>
					putch('?', putdat);
  8008cf:	83 ec 08             	sub    $0x8,%esp
  8008d2:	ff 75 0c             	pushl  0xc(%ebp)
  8008d5:	6a 3f                	push   $0x3f
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	ff d0                	call   *%eax
  8008dc:	83 c4 10             	add    $0x10,%esp
  8008df:	eb 0f                	jmp    8008f0 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008e1:	83 ec 08             	sub    $0x8,%esp
  8008e4:	ff 75 0c             	pushl  0xc(%ebp)
  8008e7:	53                   	push   %ebx
  8008e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008eb:	ff d0                	call   *%eax
  8008ed:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008f0:	ff 4d e4             	decl   -0x1c(%ebp)
  8008f3:	89 f0                	mov    %esi,%eax
  8008f5:	8d 70 01             	lea    0x1(%eax),%esi
  8008f8:	8a 00                	mov    (%eax),%al
  8008fa:	0f be d8             	movsbl %al,%ebx
  8008fd:	85 db                	test   %ebx,%ebx
  8008ff:	74 24                	je     800925 <vprintfmt+0x24b>
  800901:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800905:	78 b8                	js     8008bf <vprintfmt+0x1e5>
  800907:	ff 4d e0             	decl   -0x20(%ebp)
  80090a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80090e:	79 af                	jns    8008bf <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800910:	eb 13                	jmp    800925 <vprintfmt+0x24b>
				putch(' ', putdat);
  800912:	83 ec 08             	sub    $0x8,%esp
  800915:	ff 75 0c             	pushl  0xc(%ebp)
  800918:	6a 20                	push   $0x20
  80091a:	8b 45 08             	mov    0x8(%ebp),%eax
  80091d:	ff d0                	call   *%eax
  80091f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800922:	ff 4d e4             	decl   -0x1c(%ebp)
  800925:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800929:	7f e7                	jg     800912 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80092b:	e9 66 01 00 00       	jmp    800a96 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800930:	83 ec 08             	sub    $0x8,%esp
  800933:	ff 75 e8             	pushl  -0x18(%ebp)
  800936:	8d 45 14             	lea    0x14(%ebp),%eax
  800939:	50                   	push   %eax
  80093a:	e8 3c fd ff ff       	call   80067b <getint>
  80093f:	83 c4 10             	add    $0x10,%esp
  800942:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800945:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800948:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80094b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80094e:	85 d2                	test   %edx,%edx
  800950:	79 23                	jns    800975 <vprintfmt+0x29b>
				putch('-', putdat);
  800952:	83 ec 08             	sub    $0x8,%esp
  800955:	ff 75 0c             	pushl  0xc(%ebp)
  800958:	6a 2d                	push   $0x2d
  80095a:	8b 45 08             	mov    0x8(%ebp),%eax
  80095d:	ff d0                	call   *%eax
  80095f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800962:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800965:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800968:	f7 d8                	neg    %eax
  80096a:	83 d2 00             	adc    $0x0,%edx
  80096d:	f7 da                	neg    %edx
  80096f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800972:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800975:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80097c:	e9 bc 00 00 00       	jmp    800a3d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800981:	83 ec 08             	sub    $0x8,%esp
  800984:	ff 75 e8             	pushl  -0x18(%ebp)
  800987:	8d 45 14             	lea    0x14(%ebp),%eax
  80098a:	50                   	push   %eax
  80098b:	e8 84 fc ff ff       	call   800614 <getuint>
  800990:	83 c4 10             	add    $0x10,%esp
  800993:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800996:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800999:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a0:	e9 98 00 00 00       	jmp    800a3d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009a5:	83 ec 08             	sub    $0x8,%esp
  8009a8:	ff 75 0c             	pushl  0xc(%ebp)
  8009ab:	6a 58                	push   $0x58
  8009ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b0:	ff d0                	call   *%eax
  8009b2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009b5:	83 ec 08             	sub    $0x8,%esp
  8009b8:	ff 75 0c             	pushl  0xc(%ebp)
  8009bb:	6a 58                	push   $0x58
  8009bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c0:	ff d0                	call   *%eax
  8009c2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009c5:	83 ec 08             	sub    $0x8,%esp
  8009c8:	ff 75 0c             	pushl  0xc(%ebp)
  8009cb:	6a 58                	push   $0x58
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	ff d0                	call   *%eax
  8009d2:	83 c4 10             	add    $0x10,%esp
			break;
  8009d5:	e9 bc 00 00 00       	jmp    800a96 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009da:	83 ec 08             	sub    $0x8,%esp
  8009dd:	ff 75 0c             	pushl  0xc(%ebp)
  8009e0:	6a 30                	push   $0x30
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	ff d0                	call   *%eax
  8009e7:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009ea:	83 ec 08             	sub    $0x8,%esp
  8009ed:	ff 75 0c             	pushl  0xc(%ebp)
  8009f0:	6a 78                	push   $0x78
  8009f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f5:	ff d0                	call   *%eax
  8009f7:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fd:	83 c0 04             	add    $0x4,%eax
  800a00:	89 45 14             	mov    %eax,0x14(%ebp)
  800a03:	8b 45 14             	mov    0x14(%ebp),%eax
  800a06:	83 e8 04             	sub    $0x4,%eax
  800a09:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a0e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a15:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a1c:	eb 1f                	jmp    800a3d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a1e:	83 ec 08             	sub    $0x8,%esp
  800a21:	ff 75 e8             	pushl  -0x18(%ebp)
  800a24:	8d 45 14             	lea    0x14(%ebp),%eax
  800a27:	50                   	push   %eax
  800a28:	e8 e7 fb ff ff       	call   800614 <getuint>
  800a2d:	83 c4 10             	add    $0x10,%esp
  800a30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a33:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a36:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a3d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a41:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a44:	83 ec 04             	sub    $0x4,%esp
  800a47:	52                   	push   %edx
  800a48:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a4b:	50                   	push   %eax
  800a4c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4f:	ff 75 f0             	pushl  -0x10(%ebp)
  800a52:	ff 75 0c             	pushl  0xc(%ebp)
  800a55:	ff 75 08             	pushl  0x8(%ebp)
  800a58:	e8 00 fb ff ff       	call   80055d <printnum>
  800a5d:	83 c4 20             	add    $0x20,%esp
			break;
  800a60:	eb 34                	jmp    800a96 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a62:	83 ec 08             	sub    $0x8,%esp
  800a65:	ff 75 0c             	pushl  0xc(%ebp)
  800a68:	53                   	push   %ebx
  800a69:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6c:	ff d0                	call   *%eax
  800a6e:	83 c4 10             	add    $0x10,%esp
			break;
  800a71:	eb 23                	jmp    800a96 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a73:	83 ec 08             	sub    $0x8,%esp
  800a76:	ff 75 0c             	pushl  0xc(%ebp)
  800a79:	6a 25                	push   $0x25
  800a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7e:	ff d0                	call   *%eax
  800a80:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a83:	ff 4d 10             	decl   0x10(%ebp)
  800a86:	eb 03                	jmp    800a8b <vprintfmt+0x3b1>
  800a88:	ff 4d 10             	decl   0x10(%ebp)
  800a8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a8e:	48                   	dec    %eax
  800a8f:	8a 00                	mov    (%eax),%al
  800a91:	3c 25                	cmp    $0x25,%al
  800a93:	75 f3                	jne    800a88 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a95:	90                   	nop
		}
	}
  800a96:	e9 47 fc ff ff       	jmp    8006e2 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a9b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a9c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a9f:	5b                   	pop    %ebx
  800aa0:	5e                   	pop    %esi
  800aa1:	5d                   	pop    %ebp
  800aa2:	c3                   	ret    

00800aa3 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800aa3:	55                   	push   %ebp
  800aa4:	89 e5                	mov    %esp,%ebp
  800aa6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800aa9:	8d 45 10             	lea    0x10(%ebp),%eax
  800aac:	83 c0 04             	add    $0x4,%eax
  800aaf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ab2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab5:	ff 75 f4             	pushl  -0xc(%ebp)
  800ab8:	50                   	push   %eax
  800ab9:	ff 75 0c             	pushl  0xc(%ebp)
  800abc:	ff 75 08             	pushl  0x8(%ebp)
  800abf:	e8 16 fc ff ff       	call   8006da <vprintfmt>
  800ac4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ac7:	90                   	nop
  800ac8:	c9                   	leave  
  800ac9:	c3                   	ret    

00800aca <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800aca:	55                   	push   %ebp
  800acb:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800acd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad0:	8b 40 08             	mov    0x8(%eax),%eax
  800ad3:	8d 50 01             	lea    0x1(%eax),%edx
  800ad6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad9:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800adc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adf:	8b 10                	mov    (%eax),%edx
  800ae1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae4:	8b 40 04             	mov    0x4(%eax),%eax
  800ae7:	39 c2                	cmp    %eax,%edx
  800ae9:	73 12                	jae    800afd <sprintputch+0x33>
		*b->buf++ = ch;
  800aeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aee:	8b 00                	mov    (%eax),%eax
  800af0:	8d 48 01             	lea    0x1(%eax),%ecx
  800af3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af6:	89 0a                	mov    %ecx,(%edx)
  800af8:	8b 55 08             	mov    0x8(%ebp),%edx
  800afb:	88 10                	mov    %dl,(%eax)
}
  800afd:	90                   	nop
  800afe:	5d                   	pop    %ebp
  800aff:	c3                   	ret    

00800b00 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b00:	55                   	push   %ebp
  800b01:	89 e5                	mov    %esp,%ebp
  800b03:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b06:	8b 45 08             	mov    0x8(%ebp),%eax
  800b09:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	01 d0                	add    %edx,%eax
  800b17:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b21:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b25:	74 06                	je     800b2d <vsnprintf+0x2d>
  800b27:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b2b:	7f 07                	jg     800b34 <vsnprintf+0x34>
		return -E_INVAL;
  800b2d:	b8 03 00 00 00       	mov    $0x3,%eax
  800b32:	eb 20                	jmp    800b54 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b34:	ff 75 14             	pushl  0x14(%ebp)
  800b37:	ff 75 10             	pushl  0x10(%ebp)
  800b3a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b3d:	50                   	push   %eax
  800b3e:	68 ca 0a 80 00       	push   $0x800aca
  800b43:	e8 92 fb ff ff       	call   8006da <vprintfmt>
  800b48:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b4e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b51:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b54:	c9                   	leave  
  800b55:	c3                   	ret    

00800b56 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b56:	55                   	push   %ebp
  800b57:	89 e5                	mov    %esp,%ebp
  800b59:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b5c:	8d 45 10             	lea    0x10(%ebp),%eax
  800b5f:	83 c0 04             	add    $0x4,%eax
  800b62:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b65:	8b 45 10             	mov    0x10(%ebp),%eax
  800b68:	ff 75 f4             	pushl  -0xc(%ebp)
  800b6b:	50                   	push   %eax
  800b6c:	ff 75 0c             	pushl  0xc(%ebp)
  800b6f:	ff 75 08             	pushl  0x8(%ebp)
  800b72:	e8 89 ff ff ff       	call   800b00 <vsnprintf>
  800b77:	83 c4 10             	add    $0x10,%esp
  800b7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b80:	c9                   	leave  
  800b81:	c3                   	ret    

00800b82 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b82:	55                   	push   %ebp
  800b83:	89 e5                	mov    %esp,%ebp
  800b85:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b88:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b8f:	eb 06                	jmp    800b97 <strlen+0x15>
		n++;
  800b91:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b94:	ff 45 08             	incl   0x8(%ebp)
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9a:	8a 00                	mov    (%eax),%al
  800b9c:	84 c0                	test   %al,%al
  800b9e:	75 f1                	jne    800b91 <strlen+0xf>
		n++;
	return n;
  800ba0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba3:	c9                   	leave  
  800ba4:	c3                   	ret    

00800ba5 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ba5:	55                   	push   %ebp
  800ba6:	89 e5                	mov    %esp,%ebp
  800ba8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bb2:	eb 09                	jmp    800bbd <strnlen+0x18>
		n++;
  800bb4:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bb7:	ff 45 08             	incl   0x8(%ebp)
  800bba:	ff 4d 0c             	decl   0xc(%ebp)
  800bbd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc1:	74 09                	je     800bcc <strnlen+0x27>
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	8a 00                	mov    (%eax),%al
  800bc8:	84 c0                	test   %al,%al
  800bca:	75 e8                	jne    800bb4 <strnlen+0xf>
		n++;
	return n;
  800bcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bcf:	c9                   	leave  
  800bd0:	c3                   	ret    

00800bd1 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bd1:	55                   	push   %ebp
  800bd2:	89 e5                	mov    %esp,%ebp
  800bd4:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bdd:	90                   	nop
  800bde:	8b 45 08             	mov    0x8(%ebp),%eax
  800be1:	8d 50 01             	lea    0x1(%eax),%edx
  800be4:	89 55 08             	mov    %edx,0x8(%ebp)
  800be7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bea:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bed:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bf0:	8a 12                	mov    (%edx),%dl
  800bf2:	88 10                	mov    %dl,(%eax)
  800bf4:	8a 00                	mov    (%eax),%al
  800bf6:	84 c0                	test   %al,%al
  800bf8:	75 e4                	jne    800bde <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bfa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bfd:	c9                   	leave  
  800bfe:	c3                   	ret    

00800bff <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bff:	55                   	push   %ebp
  800c00:	89 e5                	mov    %esp,%ebp
  800c02:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c0b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c12:	eb 1f                	jmp    800c33 <strncpy+0x34>
		*dst++ = *src;
  800c14:	8b 45 08             	mov    0x8(%ebp),%eax
  800c17:	8d 50 01             	lea    0x1(%eax),%edx
  800c1a:	89 55 08             	mov    %edx,0x8(%ebp)
  800c1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c20:	8a 12                	mov    (%edx),%dl
  800c22:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c27:	8a 00                	mov    (%eax),%al
  800c29:	84 c0                	test   %al,%al
  800c2b:	74 03                	je     800c30 <strncpy+0x31>
			src++;
  800c2d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c30:	ff 45 fc             	incl   -0x4(%ebp)
  800c33:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c36:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c39:	72 d9                	jb     800c14 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c3e:	c9                   	leave  
  800c3f:	c3                   	ret    

00800c40 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c40:	55                   	push   %ebp
  800c41:	89 e5                	mov    %esp,%ebp
  800c43:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c4c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c50:	74 30                	je     800c82 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c52:	eb 16                	jmp    800c6a <strlcpy+0x2a>
			*dst++ = *src++;
  800c54:	8b 45 08             	mov    0x8(%ebp),%eax
  800c57:	8d 50 01             	lea    0x1(%eax),%edx
  800c5a:	89 55 08             	mov    %edx,0x8(%ebp)
  800c5d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c60:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c63:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c66:	8a 12                	mov    (%edx),%dl
  800c68:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c6a:	ff 4d 10             	decl   0x10(%ebp)
  800c6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c71:	74 09                	je     800c7c <strlcpy+0x3c>
  800c73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c76:	8a 00                	mov    (%eax),%al
  800c78:	84 c0                	test   %al,%al
  800c7a:	75 d8                	jne    800c54 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c82:	8b 55 08             	mov    0x8(%ebp),%edx
  800c85:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c88:	29 c2                	sub    %eax,%edx
  800c8a:	89 d0                	mov    %edx,%eax
}
  800c8c:	c9                   	leave  
  800c8d:	c3                   	ret    

00800c8e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c8e:	55                   	push   %ebp
  800c8f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c91:	eb 06                	jmp    800c99 <strcmp+0xb>
		p++, q++;
  800c93:	ff 45 08             	incl   0x8(%ebp)
  800c96:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	8a 00                	mov    (%eax),%al
  800c9e:	84 c0                	test   %al,%al
  800ca0:	74 0e                	je     800cb0 <strcmp+0x22>
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	8a 10                	mov    (%eax),%dl
  800ca7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800caa:	8a 00                	mov    (%eax),%al
  800cac:	38 c2                	cmp    %al,%dl
  800cae:	74 e3                	je     800c93 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb3:	8a 00                	mov    (%eax),%al
  800cb5:	0f b6 d0             	movzbl %al,%edx
  800cb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbb:	8a 00                	mov    (%eax),%al
  800cbd:	0f b6 c0             	movzbl %al,%eax
  800cc0:	29 c2                	sub    %eax,%edx
  800cc2:	89 d0                	mov    %edx,%eax
}
  800cc4:	5d                   	pop    %ebp
  800cc5:	c3                   	ret    

00800cc6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cc6:	55                   	push   %ebp
  800cc7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cc9:	eb 09                	jmp    800cd4 <strncmp+0xe>
		n--, p++, q++;
  800ccb:	ff 4d 10             	decl   0x10(%ebp)
  800cce:	ff 45 08             	incl   0x8(%ebp)
  800cd1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cd4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd8:	74 17                	je     800cf1 <strncmp+0x2b>
  800cda:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdd:	8a 00                	mov    (%eax),%al
  800cdf:	84 c0                	test   %al,%al
  800ce1:	74 0e                	je     800cf1 <strncmp+0x2b>
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	8a 10                	mov    (%eax),%dl
  800ce8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ceb:	8a 00                	mov    (%eax),%al
  800ced:	38 c2                	cmp    %al,%dl
  800cef:	74 da                	je     800ccb <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cf1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf5:	75 07                	jne    800cfe <strncmp+0x38>
		return 0;
  800cf7:	b8 00 00 00 00       	mov    $0x0,%eax
  800cfc:	eb 14                	jmp    800d12 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8a 00                	mov    (%eax),%al
  800d03:	0f b6 d0             	movzbl %al,%edx
  800d06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	0f b6 c0             	movzbl %al,%eax
  800d0e:	29 c2                	sub    %eax,%edx
  800d10:	89 d0                	mov    %edx,%eax
}
  800d12:	5d                   	pop    %ebp
  800d13:	c3                   	ret    

00800d14 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d14:	55                   	push   %ebp
  800d15:	89 e5                	mov    %esp,%ebp
  800d17:	83 ec 04             	sub    $0x4,%esp
  800d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d20:	eb 12                	jmp    800d34 <strchr+0x20>
		if (*s == c)
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	8a 00                	mov    (%eax),%al
  800d27:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d2a:	75 05                	jne    800d31 <strchr+0x1d>
			return (char *) s;
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	eb 11                	jmp    800d42 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d31:	ff 45 08             	incl   0x8(%ebp)
  800d34:	8b 45 08             	mov    0x8(%ebp),%eax
  800d37:	8a 00                	mov    (%eax),%al
  800d39:	84 c0                	test   %al,%al
  800d3b:	75 e5                	jne    800d22 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d3d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d42:	c9                   	leave  
  800d43:	c3                   	ret    

00800d44 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d44:	55                   	push   %ebp
  800d45:	89 e5                	mov    %esp,%ebp
  800d47:	83 ec 04             	sub    $0x4,%esp
  800d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d50:	eb 0d                	jmp    800d5f <strfind+0x1b>
		if (*s == c)
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8a 00                	mov    (%eax),%al
  800d57:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d5a:	74 0e                	je     800d6a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d5c:	ff 45 08             	incl   0x8(%ebp)
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	84 c0                	test   %al,%al
  800d66:	75 ea                	jne    800d52 <strfind+0xe>
  800d68:	eb 01                	jmp    800d6b <strfind+0x27>
		if (*s == c)
			break;
  800d6a:	90                   	nop
	return (char *) s;
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d6e:	c9                   	leave  
  800d6f:	c3                   	ret    

00800d70 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d70:	55                   	push   %ebp
  800d71:	89 e5                	mov    %esp,%ebp
  800d73:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d82:	eb 0e                	jmp    800d92 <memset+0x22>
		*p++ = c;
  800d84:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d87:	8d 50 01             	lea    0x1(%eax),%edx
  800d8a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d90:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d92:	ff 4d f8             	decl   -0x8(%ebp)
  800d95:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d99:	79 e9                	jns    800d84 <memset+0x14>
		*p++ = c;

	return v;
  800d9b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d9e:	c9                   	leave  
  800d9f:	c3                   	ret    

00800da0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800da0:	55                   	push   %ebp
  800da1:	89 e5                	mov    %esp,%ebp
  800da3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800da6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dac:	8b 45 08             	mov    0x8(%ebp),%eax
  800daf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800db2:	eb 16                	jmp    800dca <memcpy+0x2a>
		*d++ = *s++;
  800db4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db7:	8d 50 01             	lea    0x1(%eax),%edx
  800dba:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dbd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dc0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dc3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dc6:	8a 12                	mov    (%edx),%dl
  800dc8:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dca:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dd0:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd3:	85 c0                	test   %eax,%eax
  800dd5:	75 dd                	jne    800db4 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dd7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dda:	c9                   	leave  
  800ddb:	c3                   	ret    

00800ddc <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ddc:	55                   	push   %ebp
  800ddd:	89 e5                	mov    %esp,%ebp
  800ddf:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800de2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800de8:	8b 45 08             	mov    0x8(%ebp),%eax
  800deb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800df4:	73 50                	jae    800e46 <memmove+0x6a>
  800df6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfc:	01 d0                	add    %edx,%eax
  800dfe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e01:	76 43                	jbe    800e46 <memmove+0x6a>
		s += n;
  800e03:	8b 45 10             	mov    0x10(%ebp),%eax
  800e06:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e09:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e0f:	eb 10                	jmp    800e21 <memmove+0x45>
			*--d = *--s;
  800e11:	ff 4d f8             	decl   -0x8(%ebp)
  800e14:	ff 4d fc             	decl   -0x4(%ebp)
  800e17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1a:	8a 10                	mov    (%eax),%dl
  800e1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e21:	8b 45 10             	mov    0x10(%ebp),%eax
  800e24:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e27:	89 55 10             	mov    %edx,0x10(%ebp)
  800e2a:	85 c0                	test   %eax,%eax
  800e2c:	75 e3                	jne    800e11 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e2e:	eb 23                	jmp    800e53 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e30:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e33:	8d 50 01             	lea    0x1(%eax),%edx
  800e36:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e39:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e3c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e3f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e42:	8a 12                	mov    (%edx),%dl
  800e44:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e46:	8b 45 10             	mov    0x10(%ebp),%eax
  800e49:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e4c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e4f:	85 c0                	test   %eax,%eax
  800e51:	75 dd                	jne    800e30 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e56:	c9                   	leave  
  800e57:	c3                   	ret    

00800e58 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e58:	55                   	push   %ebp
  800e59:	89 e5                	mov    %esp,%ebp
  800e5b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e67:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e6a:	eb 2a                	jmp    800e96 <memcmp+0x3e>
		if (*s1 != *s2)
  800e6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6f:	8a 10                	mov    (%eax),%dl
  800e71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e74:	8a 00                	mov    (%eax),%al
  800e76:	38 c2                	cmp    %al,%dl
  800e78:	74 16                	je     800e90 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7d:	8a 00                	mov    (%eax),%al
  800e7f:	0f b6 d0             	movzbl %al,%edx
  800e82:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e85:	8a 00                	mov    (%eax),%al
  800e87:	0f b6 c0             	movzbl %al,%eax
  800e8a:	29 c2                	sub    %eax,%edx
  800e8c:	89 d0                	mov    %edx,%eax
  800e8e:	eb 18                	jmp    800ea8 <memcmp+0x50>
		s1++, s2++;
  800e90:	ff 45 fc             	incl   -0x4(%ebp)
  800e93:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e96:	8b 45 10             	mov    0x10(%ebp),%eax
  800e99:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e9c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e9f:	85 c0                	test   %eax,%eax
  800ea1:	75 c9                	jne    800e6c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ea3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ea8:	c9                   	leave  
  800ea9:	c3                   	ret    

00800eaa <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800eaa:	55                   	push   %ebp
  800eab:	89 e5                	mov    %esp,%ebp
  800ead:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800eb0:	8b 55 08             	mov    0x8(%ebp),%edx
  800eb3:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb6:	01 d0                	add    %edx,%eax
  800eb8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ebb:	eb 15                	jmp    800ed2 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ebd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec0:	8a 00                	mov    (%eax),%al
  800ec2:	0f b6 d0             	movzbl %al,%edx
  800ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec8:	0f b6 c0             	movzbl %al,%eax
  800ecb:	39 c2                	cmp    %eax,%edx
  800ecd:	74 0d                	je     800edc <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ecf:	ff 45 08             	incl   0x8(%ebp)
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ed8:	72 e3                	jb     800ebd <memfind+0x13>
  800eda:	eb 01                	jmp    800edd <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800edc:	90                   	nop
	return (void *) s;
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee0:	c9                   	leave  
  800ee1:	c3                   	ret    

00800ee2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ee2:	55                   	push   %ebp
  800ee3:	89 e5                	mov    %esp,%ebp
  800ee5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ee8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800eef:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ef6:	eb 03                	jmp    800efb <strtol+0x19>
		s++;
  800ef8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800efb:	8b 45 08             	mov    0x8(%ebp),%eax
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	3c 20                	cmp    $0x20,%al
  800f02:	74 f4                	je     800ef8 <strtol+0x16>
  800f04:	8b 45 08             	mov    0x8(%ebp),%eax
  800f07:	8a 00                	mov    (%eax),%al
  800f09:	3c 09                	cmp    $0x9,%al
  800f0b:	74 eb                	je     800ef8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	3c 2b                	cmp    $0x2b,%al
  800f14:	75 05                	jne    800f1b <strtol+0x39>
		s++;
  800f16:	ff 45 08             	incl   0x8(%ebp)
  800f19:	eb 13                	jmp    800f2e <strtol+0x4c>
	else if (*s == '-')
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1e:	8a 00                	mov    (%eax),%al
  800f20:	3c 2d                	cmp    $0x2d,%al
  800f22:	75 0a                	jne    800f2e <strtol+0x4c>
		s++, neg = 1;
  800f24:	ff 45 08             	incl   0x8(%ebp)
  800f27:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f2e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f32:	74 06                	je     800f3a <strtol+0x58>
  800f34:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f38:	75 20                	jne    800f5a <strtol+0x78>
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	3c 30                	cmp    $0x30,%al
  800f41:	75 17                	jne    800f5a <strtol+0x78>
  800f43:	8b 45 08             	mov    0x8(%ebp),%eax
  800f46:	40                   	inc    %eax
  800f47:	8a 00                	mov    (%eax),%al
  800f49:	3c 78                	cmp    $0x78,%al
  800f4b:	75 0d                	jne    800f5a <strtol+0x78>
		s += 2, base = 16;
  800f4d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f51:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f58:	eb 28                	jmp    800f82 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f5a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5e:	75 15                	jne    800f75 <strtol+0x93>
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	3c 30                	cmp    $0x30,%al
  800f67:	75 0c                	jne    800f75 <strtol+0x93>
		s++, base = 8;
  800f69:	ff 45 08             	incl   0x8(%ebp)
  800f6c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f73:	eb 0d                	jmp    800f82 <strtol+0xa0>
	else if (base == 0)
  800f75:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f79:	75 07                	jne    800f82 <strtol+0xa0>
		base = 10;
  800f7b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	3c 2f                	cmp    $0x2f,%al
  800f89:	7e 19                	jle    800fa4 <strtol+0xc2>
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	3c 39                	cmp    $0x39,%al
  800f92:	7f 10                	jg     800fa4 <strtol+0xc2>
			dig = *s - '0';
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	8a 00                	mov    (%eax),%al
  800f99:	0f be c0             	movsbl %al,%eax
  800f9c:	83 e8 30             	sub    $0x30,%eax
  800f9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa2:	eb 42                	jmp    800fe6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa7:	8a 00                	mov    (%eax),%al
  800fa9:	3c 60                	cmp    $0x60,%al
  800fab:	7e 19                	jle    800fc6 <strtol+0xe4>
  800fad:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb0:	8a 00                	mov    (%eax),%al
  800fb2:	3c 7a                	cmp    $0x7a,%al
  800fb4:	7f 10                	jg     800fc6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb9:	8a 00                	mov    (%eax),%al
  800fbb:	0f be c0             	movsbl %al,%eax
  800fbe:	83 e8 57             	sub    $0x57,%eax
  800fc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fc4:	eb 20                	jmp    800fe6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	8a 00                	mov    (%eax),%al
  800fcb:	3c 40                	cmp    $0x40,%al
  800fcd:	7e 39                	jle    801008 <strtol+0x126>
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	8a 00                	mov    (%eax),%al
  800fd4:	3c 5a                	cmp    $0x5a,%al
  800fd6:	7f 30                	jg     801008 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	8a 00                	mov    (%eax),%al
  800fdd:	0f be c0             	movsbl %al,%eax
  800fe0:	83 e8 37             	sub    $0x37,%eax
  800fe3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fe6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fe9:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fec:	7d 19                	jge    801007 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fee:	ff 45 08             	incl   0x8(%ebp)
  800ff1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff4:	0f af 45 10          	imul   0x10(%ebp),%eax
  800ff8:	89 c2                	mov    %eax,%edx
  800ffa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffd:	01 d0                	add    %edx,%eax
  800fff:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801002:	e9 7b ff ff ff       	jmp    800f82 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801007:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801008:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80100c:	74 08                	je     801016 <strtol+0x134>
		*endptr = (char *) s;
  80100e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801011:	8b 55 08             	mov    0x8(%ebp),%edx
  801014:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801016:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80101a:	74 07                	je     801023 <strtol+0x141>
  80101c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101f:	f7 d8                	neg    %eax
  801021:	eb 03                	jmp    801026 <strtol+0x144>
  801023:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801026:	c9                   	leave  
  801027:	c3                   	ret    

00801028 <ltostr>:

void
ltostr(long value, char *str)
{
  801028:	55                   	push   %ebp
  801029:	89 e5                	mov    %esp,%ebp
  80102b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80102e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801035:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80103c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801040:	79 13                	jns    801055 <ltostr+0x2d>
	{
		neg = 1;
  801042:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801049:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80104f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801052:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80105d:	99                   	cltd   
  80105e:	f7 f9                	idiv   %ecx
  801060:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801063:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801066:	8d 50 01             	lea    0x1(%eax),%edx
  801069:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80106c:	89 c2                	mov    %eax,%edx
  80106e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801071:	01 d0                	add    %edx,%eax
  801073:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801076:	83 c2 30             	add    $0x30,%edx
  801079:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80107b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80107e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801083:	f7 e9                	imul   %ecx
  801085:	c1 fa 02             	sar    $0x2,%edx
  801088:	89 c8                	mov    %ecx,%eax
  80108a:	c1 f8 1f             	sar    $0x1f,%eax
  80108d:	29 c2                	sub    %eax,%edx
  80108f:	89 d0                	mov    %edx,%eax
  801091:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801094:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801097:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80109c:	f7 e9                	imul   %ecx
  80109e:	c1 fa 02             	sar    $0x2,%edx
  8010a1:	89 c8                	mov    %ecx,%eax
  8010a3:	c1 f8 1f             	sar    $0x1f,%eax
  8010a6:	29 c2                	sub    %eax,%edx
  8010a8:	89 d0                	mov    %edx,%eax
  8010aa:	c1 e0 02             	shl    $0x2,%eax
  8010ad:	01 d0                	add    %edx,%eax
  8010af:	01 c0                	add    %eax,%eax
  8010b1:	29 c1                	sub    %eax,%ecx
  8010b3:	89 ca                	mov    %ecx,%edx
  8010b5:	85 d2                	test   %edx,%edx
  8010b7:	75 9c                	jne    801055 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c3:	48                   	dec    %eax
  8010c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010c7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010cb:	74 3d                	je     80110a <ltostr+0xe2>
		start = 1 ;
  8010cd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010d4:	eb 34                	jmp    80110a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010dc:	01 d0                	add    %edx,%eax
  8010de:	8a 00                	mov    (%eax),%al
  8010e0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e9:	01 c2                	add    %eax,%edx
  8010eb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f1:	01 c8                	add    %ecx,%eax
  8010f3:	8a 00                	mov    (%eax),%al
  8010f5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010f7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fd:	01 c2                	add    %eax,%edx
  8010ff:	8a 45 eb             	mov    -0x15(%ebp),%al
  801102:	88 02                	mov    %al,(%edx)
		start++ ;
  801104:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801107:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80110a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80110d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801110:	7c c4                	jl     8010d6 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801112:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801115:	8b 45 0c             	mov    0xc(%ebp),%eax
  801118:	01 d0                	add    %edx,%eax
  80111a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80111d:	90                   	nop
  80111e:	c9                   	leave  
  80111f:	c3                   	ret    

00801120 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801120:	55                   	push   %ebp
  801121:	89 e5                	mov    %esp,%ebp
  801123:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801126:	ff 75 08             	pushl  0x8(%ebp)
  801129:	e8 54 fa ff ff       	call   800b82 <strlen>
  80112e:	83 c4 04             	add    $0x4,%esp
  801131:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801134:	ff 75 0c             	pushl  0xc(%ebp)
  801137:	e8 46 fa ff ff       	call   800b82 <strlen>
  80113c:	83 c4 04             	add    $0x4,%esp
  80113f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801142:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801149:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801150:	eb 17                	jmp    801169 <strcconcat+0x49>
		final[s] = str1[s] ;
  801152:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801155:	8b 45 10             	mov    0x10(%ebp),%eax
  801158:	01 c2                	add    %eax,%edx
  80115a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80115d:	8b 45 08             	mov    0x8(%ebp),%eax
  801160:	01 c8                	add    %ecx,%eax
  801162:	8a 00                	mov    (%eax),%al
  801164:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801166:	ff 45 fc             	incl   -0x4(%ebp)
  801169:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80116c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80116f:	7c e1                	jl     801152 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801171:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801178:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80117f:	eb 1f                	jmp    8011a0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801181:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801184:	8d 50 01             	lea    0x1(%eax),%edx
  801187:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80118a:	89 c2                	mov    %eax,%edx
  80118c:	8b 45 10             	mov    0x10(%ebp),%eax
  80118f:	01 c2                	add    %eax,%edx
  801191:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801194:	8b 45 0c             	mov    0xc(%ebp),%eax
  801197:	01 c8                	add    %ecx,%eax
  801199:	8a 00                	mov    (%eax),%al
  80119b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80119d:	ff 45 f8             	incl   -0x8(%ebp)
  8011a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011a6:	7c d9                	jl     801181 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ae:	01 d0                	add    %edx,%eax
  8011b0:	c6 00 00             	movb   $0x0,(%eax)
}
  8011b3:	90                   	nop
  8011b4:	c9                   	leave  
  8011b5:	c3                   	ret    

008011b6 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011b6:	55                   	push   %ebp
  8011b7:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011bc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c5:	8b 00                	mov    (%eax),%eax
  8011c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d1:	01 d0                	add    %edx,%eax
  8011d3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011d9:	eb 0c                	jmp    8011e7 <strsplit+0x31>
			*string++ = 0;
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8d 50 01             	lea    0x1(%eax),%edx
  8011e1:	89 55 08             	mov    %edx,0x8(%ebp)
  8011e4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ea:	8a 00                	mov    (%eax),%al
  8011ec:	84 c0                	test   %al,%al
  8011ee:	74 18                	je     801208 <strsplit+0x52>
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f3:	8a 00                	mov    (%eax),%al
  8011f5:	0f be c0             	movsbl %al,%eax
  8011f8:	50                   	push   %eax
  8011f9:	ff 75 0c             	pushl  0xc(%ebp)
  8011fc:	e8 13 fb ff ff       	call   800d14 <strchr>
  801201:	83 c4 08             	add    $0x8,%esp
  801204:	85 c0                	test   %eax,%eax
  801206:	75 d3                	jne    8011db <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8a 00                	mov    (%eax),%al
  80120d:	84 c0                	test   %al,%al
  80120f:	74 5a                	je     80126b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801211:	8b 45 14             	mov    0x14(%ebp),%eax
  801214:	8b 00                	mov    (%eax),%eax
  801216:	83 f8 0f             	cmp    $0xf,%eax
  801219:	75 07                	jne    801222 <strsplit+0x6c>
		{
			return 0;
  80121b:	b8 00 00 00 00       	mov    $0x0,%eax
  801220:	eb 66                	jmp    801288 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801222:	8b 45 14             	mov    0x14(%ebp),%eax
  801225:	8b 00                	mov    (%eax),%eax
  801227:	8d 48 01             	lea    0x1(%eax),%ecx
  80122a:	8b 55 14             	mov    0x14(%ebp),%edx
  80122d:	89 0a                	mov    %ecx,(%edx)
  80122f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801236:	8b 45 10             	mov    0x10(%ebp),%eax
  801239:	01 c2                	add    %eax,%edx
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
  80123e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801240:	eb 03                	jmp    801245 <strsplit+0x8f>
			string++;
  801242:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801245:	8b 45 08             	mov    0x8(%ebp),%eax
  801248:	8a 00                	mov    (%eax),%al
  80124a:	84 c0                	test   %al,%al
  80124c:	74 8b                	je     8011d9 <strsplit+0x23>
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	8a 00                	mov    (%eax),%al
  801253:	0f be c0             	movsbl %al,%eax
  801256:	50                   	push   %eax
  801257:	ff 75 0c             	pushl  0xc(%ebp)
  80125a:	e8 b5 fa ff ff       	call   800d14 <strchr>
  80125f:	83 c4 08             	add    $0x8,%esp
  801262:	85 c0                	test   %eax,%eax
  801264:	74 dc                	je     801242 <strsplit+0x8c>
			string++;
	}
  801266:	e9 6e ff ff ff       	jmp    8011d9 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80126b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80126c:	8b 45 14             	mov    0x14(%ebp),%eax
  80126f:	8b 00                	mov    (%eax),%eax
  801271:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801278:	8b 45 10             	mov    0x10(%ebp),%eax
  80127b:	01 d0                	add    %edx,%eax
  80127d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801283:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801288:	c9                   	leave  
  801289:	c3                   	ret    

0080128a <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  80128a:	55                   	push   %ebp
  80128b:	89 e5                	mov    %esp,%ebp
  80128d:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801290:	8b 45 08             	mov    0x8(%ebp),%eax
  801293:	c1 e8 0c             	shr    $0xc,%eax
  801296:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801299:	8b 45 08             	mov    0x8(%ebp),%eax
  80129c:	25 ff 0f 00 00       	and    $0xfff,%eax
  8012a1:	85 c0                	test   %eax,%eax
  8012a3:	74 03                	je     8012a8 <malloc+0x1e>
			num++;
  8012a5:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8012a8:	a1 04 30 80 00       	mov    0x803004,%eax
  8012ad:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8012b2:	75 73                	jne    801327 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8012b4:	83 ec 08             	sub    $0x8,%esp
  8012b7:	ff 75 08             	pushl  0x8(%ebp)
  8012ba:	68 00 00 00 80       	push   $0x80000000
  8012bf:	e8 14 05 00 00       	call   8017d8 <sys_allocateMem>
  8012c4:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8012c7:	a1 04 30 80 00       	mov    0x803004,%eax
  8012cc:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8012cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012d2:	c1 e0 0c             	shl    $0xc,%eax
  8012d5:	89 c2                	mov    %eax,%edx
  8012d7:	a1 04 30 80 00       	mov    0x803004,%eax
  8012dc:	01 d0                	add    %edx,%eax
  8012de:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  8012e3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8012e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012eb:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  8012f2:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8012f7:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8012fd:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801304:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801309:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801310:	01 00 00 00 
			sizeofarray++;
  801314:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801319:	40                   	inc    %eax
  80131a:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  80131f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801322:	e9 71 01 00 00       	jmp    801498 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801327:	a1 28 30 80 00       	mov    0x803028,%eax
  80132c:	85 c0                	test   %eax,%eax
  80132e:	75 71                	jne    8013a1 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801330:	a1 04 30 80 00       	mov    0x803004,%eax
  801335:	83 ec 08             	sub    $0x8,%esp
  801338:	ff 75 08             	pushl  0x8(%ebp)
  80133b:	50                   	push   %eax
  80133c:	e8 97 04 00 00       	call   8017d8 <sys_allocateMem>
  801341:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801344:	a1 04 30 80 00       	mov    0x803004,%eax
  801349:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  80134c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80134f:	c1 e0 0c             	shl    $0xc,%eax
  801352:	89 c2                	mov    %eax,%edx
  801354:	a1 04 30 80 00       	mov    0x803004,%eax
  801359:	01 d0                	add    %edx,%eax
  80135b:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801360:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801365:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801368:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  80136f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801374:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801377:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  80137e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801383:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80138a:	01 00 00 00 
				sizeofarray++;
  80138e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801393:	40                   	inc    %eax
  801394:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801399:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80139c:	e9 f7 00 00 00       	jmp    801498 <malloc+0x20e>
			}
			else{
				int count=0;
  8013a1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8013a8:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8013af:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8013b6:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8013bd:	eb 7c                	jmp    80143b <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  8013bf:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8013c6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8013cd:	eb 1a                	jmp    8013e9 <malloc+0x15f>
					{
						if(addresses[j]==i)
  8013cf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8013d2:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8013d9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8013dc:	75 08                	jne    8013e6 <malloc+0x15c>
						{
							index=j;
  8013de:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8013e1:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8013e4:	eb 0d                	jmp    8013f3 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  8013e6:	ff 45 dc             	incl   -0x24(%ebp)
  8013e9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013ee:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8013f1:	7c dc                	jl     8013cf <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  8013f3:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8013f7:	75 05                	jne    8013fe <malloc+0x174>
					{
						count++;
  8013f9:	ff 45 f0             	incl   -0x10(%ebp)
  8013fc:	eb 36                	jmp    801434 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  8013fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801401:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801408:	85 c0                	test   %eax,%eax
  80140a:	75 05                	jne    801411 <malloc+0x187>
						{
							count++;
  80140c:	ff 45 f0             	incl   -0x10(%ebp)
  80140f:	eb 23                	jmp    801434 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801411:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801414:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801417:	7d 14                	jge    80142d <malloc+0x1a3>
  801419:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80141c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80141f:	7c 0c                	jl     80142d <malloc+0x1a3>
							{
								min=count;
  801421:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801424:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801427:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80142a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  80142d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801434:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  80143b:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801442:	0f 86 77 ff ff ff    	jbe    8013bf <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801448:	83 ec 08             	sub    $0x8,%esp
  80144b:	ff 75 08             	pushl  0x8(%ebp)
  80144e:	ff 75 e4             	pushl  -0x1c(%ebp)
  801451:	e8 82 03 00 00       	call   8017d8 <sys_allocateMem>
  801456:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801459:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80145e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801461:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801468:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80146d:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801473:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  80147a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80147f:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801486:	01 00 00 00 
				sizeofarray++;
  80148a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80148f:	40                   	inc    %eax
  801490:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  801495:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801498:	c9                   	leave  
  801499:	c3                   	ret    

0080149a <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
  80149d:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  8014a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  8014a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  8014ad:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8014b4:	eb 30                	jmp    8014e6 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  8014b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014b9:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8014c0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8014c3:	75 1e                	jne    8014e3 <free+0x49>
  8014c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014c8:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8014cf:	83 f8 01             	cmp    $0x1,%eax
  8014d2:	75 0f                	jne    8014e3 <free+0x49>
    		is_found=1;
  8014d4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  8014db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014de:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  8014e1:	eb 0d                	jmp    8014f0 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  8014e3:	ff 45 ec             	incl   -0x14(%ebp)
  8014e6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014eb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8014ee:	7c c6                	jl     8014b6 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  8014f0:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8014f4:	75 3b                	jne    801531 <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  8014f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014f9:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801500:	c1 e0 0c             	shl    $0xc,%eax
  801503:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  801506:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801509:	83 ec 08             	sub    $0x8,%esp
  80150c:	50                   	push   %eax
  80150d:	ff 75 e8             	pushl  -0x18(%ebp)
  801510:	e8 a7 02 00 00       	call   8017bc <sys_freeMem>
  801515:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  801518:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80151b:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801522:	00 00 00 00 
    	changes++;
  801526:	a1 28 30 80 00       	mov    0x803028,%eax
  80152b:	40                   	inc    %eax
  80152c:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  801531:	90                   	nop
  801532:	c9                   	leave  
  801533:	c3                   	ret    

00801534 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801534:	55                   	push   %ebp
  801535:	89 e5                	mov    %esp,%ebp
  801537:	83 ec 18             	sub    $0x18,%esp
  80153a:	8b 45 10             	mov    0x10(%ebp),%eax
  80153d:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801540:	83 ec 04             	sub    $0x4,%esp
  801543:	68 50 25 80 00       	push   $0x802550
  801548:	68 9f 00 00 00       	push   $0x9f
  80154d:	68 73 25 80 00       	push   $0x802573
  801552:	e8 07 ed ff ff       	call   80025e <_panic>

00801557 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801557:	55                   	push   %ebp
  801558:	89 e5                	mov    %esp,%ebp
  80155a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80155d:	83 ec 04             	sub    $0x4,%esp
  801560:	68 50 25 80 00       	push   $0x802550
  801565:	68 a5 00 00 00       	push   $0xa5
  80156a:	68 73 25 80 00       	push   $0x802573
  80156f:	e8 ea ec ff ff       	call   80025e <_panic>

00801574 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801574:	55                   	push   %ebp
  801575:	89 e5                	mov    %esp,%ebp
  801577:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80157a:	83 ec 04             	sub    $0x4,%esp
  80157d:	68 50 25 80 00       	push   $0x802550
  801582:	68 ab 00 00 00       	push   $0xab
  801587:	68 73 25 80 00       	push   $0x802573
  80158c:	e8 cd ec ff ff       	call   80025e <_panic>

00801591 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801591:	55                   	push   %ebp
  801592:	89 e5                	mov    %esp,%ebp
  801594:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801597:	83 ec 04             	sub    $0x4,%esp
  80159a:	68 50 25 80 00       	push   $0x802550
  80159f:	68 b0 00 00 00       	push   $0xb0
  8015a4:	68 73 25 80 00       	push   $0x802573
  8015a9:	e8 b0 ec ff ff       	call   80025e <_panic>

008015ae <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8015ae:	55                   	push   %ebp
  8015af:	89 e5                	mov    %esp,%ebp
  8015b1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015b4:	83 ec 04             	sub    $0x4,%esp
  8015b7:	68 50 25 80 00       	push   $0x802550
  8015bc:	68 b6 00 00 00       	push   $0xb6
  8015c1:	68 73 25 80 00       	push   $0x802573
  8015c6:	e8 93 ec ff ff       	call   80025e <_panic>

008015cb <shrink>:
}
void shrink(uint32 newSize)
{
  8015cb:	55                   	push   %ebp
  8015cc:	89 e5                	mov    %esp,%ebp
  8015ce:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015d1:	83 ec 04             	sub    $0x4,%esp
  8015d4:	68 50 25 80 00       	push   $0x802550
  8015d9:	68 ba 00 00 00       	push   $0xba
  8015de:	68 73 25 80 00       	push   $0x802573
  8015e3:	e8 76 ec ff ff       	call   80025e <_panic>

008015e8 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
  8015eb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015ee:	83 ec 04             	sub    $0x4,%esp
  8015f1:	68 50 25 80 00       	push   $0x802550
  8015f6:	68 bf 00 00 00       	push   $0xbf
  8015fb:	68 73 25 80 00       	push   $0x802573
  801600:	e8 59 ec ff ff       	call   80025e <_panic>

00801605 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801605:	55                   	push   %ebp
  801606:	89 e5                	mov    %esp,%ebp
  801608:	57                   	push   %edi
  801609:	56                   	push   %esi
  80160a:	53                   	push   %ebx
  80160b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80160e:	8b 45 08             	mov    0x8(%ebp),%eax
  801611:	8b 55 0c             	mov    0xc(%ebp),%edx
  801614:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801617:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80161a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80161d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801620:	cd 30                	int    $0x30
  801622:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801625:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801628:	83 c4 10             	add    $0x10,%esp
  80162b:	5b                   	pop    %ebx
  80162c:	5e                   	pop    %esi
  80162d:	5f                   	pop    %edi
  80162e:	5d                   	pop    %ebp
  80162f:	c3                   	ret    

00801630 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801630:	55                   	push   %ebp
  801631:	89 e5                	mov    %esp,%ebp
  801633:	83 ec 04             	sub    $0x4,%esp
  801636:	8b 45 10             	mov    0x10(%ebp),%eax
  801639:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80163c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801640:	8b 45 08             	mov    0x8(%ebp),%eax
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	52                   	push   %edx
  801648:	ff 75 0c             	pushl  0xc(%ebp)
  80164b:	50                   	push   %eax
  80164c:	6a 00                	push   $0x0
  80164e:	e8 b2 ff ff ff       	call   801605 <syscall>
  801653:	83 c4 18             	add    $0x18,%esp
}
  801656:	90                   	nop
  801657:	c9                   	leave  
  801658:	c3                   	ret    

00801659 <sys_cgetc>:

int
sys_cgetc(void)
{
  801659:	55                   	push   %ebp
  80165a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 01                	push   $0x1
  801668:	e8 98 ff ff ff       	call   801605 <syscall>
  80166d:	83 c4 18             	add    $0x18,%esp
}
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801675:	8b 45 08             	mov    0x8(%ebp),%eax
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	50                   	push   %eax
  801681:	6a 05                	push   $0x5
  801683:	e8 7d ff ff ff       	call   801605 <syscall>
  801688:	83 c4 18             	add    $0x18,%esp
}
  80168b:	c9                   	leave  
  80168c:	c3                   	ret    

0080168d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80168d:	55                   	push   %ebp
  80168e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 02                	push   $0x2
  80169c:	e8 64 ff ff ff       	call   801605 <syscall>
  8016a1:	83 c4 18             	add    $0x18,%esp
}
  8016a4:	c9                   	leave  
  8016a5:	c3                   	ret    

008016a6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8016a6:	55                   	push   %ebp
  8016a7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 03                	push   $0x3
  8016b5:	e8 4b ff ff ff       	call   801605 <syscall>
  8016ba:	83 c4 18             	add    $0x18,%esp
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 04                	push   $0x4
  8016ce:	e8 32 ff ff ff       	call   801605 <syscall>
  8016d3:	83 c4 18             	add    $0x18,%esp
}
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <sys_env_exit>:


void sys_env_exit(void)
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 06                	push   $0x6
  8016e7:	e8 19 ff ff ff       	call   801605 <syscall>
  8016ec:	83 c4 18             	add    $0x18,%esp
}
  8016ef:	90                   	nop
  8016f0:	c9                   	leave  
  8016f1:	c3                   	ret    

008016f2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016f2:	55                   	push   %ebp
  8016f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	52                   	push   %edx
  801702:	50                   	push   %eax
  801703:	6a 07                	push   $0x7
  801705:	e8 fb fe ff ff       	call   801605 <syscall>
  80170a:	83 c4 18             	add    $0x18,%esp
}
  80170d:	c9                   	leave  
  80170e:	c3                   	ret    

0080170f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80170f:	55                   	push   %ebp
  801710:	89 e5                	mov    %esp,%ebp
  801712:	56                   	push   %esi
  801713:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801714:	8b 75 18             	mov    0x18(%ebp),%esi
  801717:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80171a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80171d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801720:	8b 45 08             	mov    0x8(%ebp),%eax
  801723:	56                   	push   %esi
  801724:	53                   	push   %ebx
  801725:	51                   	push   %ecx
  801726:	52                   	push   %edx
  801727:	50                   	push   %eax
  801728:	6a 08                	push   $0x8
  80172a:	e8 d6 fe ff ff       	call   801605 <syscall>
  80172f:	83 c4 18             	add    $0x18,%esp
}
  801732:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801735:	5b                   	pop    %ebx
  801736:	5e                   	pop    %esi
  801737:	5d                   	pop    %ebp
  801738:	c3                   	ret    

00801739 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80173c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80173f:	8b 45 08             	mov    0x8(%ebp),%eax
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	52                   	push   %edx
  801749:	50                   	push   %eax
  80174a:	6a 09                	push   $0x9
  80174c:	e8 b4 fe ff ff       	call   801605 <syscall>
  801751:	83 c4 18             	add    $0x18,%esp
}
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	ff 75 0c             	pushl  0xc(%ebp)
  801762:	ff 75 08             	pushl  0x8(%ebp)
  801765:	6a 0a                	push   $0xa
  801767:	e8 99 fe ff ff       	call   801605 <syscall>
  80176c:	83 c4 18             	add    $0x18,%esp
}
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 0b                	push   $0xb
  801780:	e8 80 fe ff ff       	call   801605 <syscall>
  801785:	83 c4 18             	add    $0x18,%esp
}
  801788:	c9                   	leave  
  801789:	c3                   	ret    

0080178a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 0c                	push   $0xc
  801799:	e8 67 fe ff ff       	call   801605 <syscall>
  80179e:	83 c4 18             	add    $0x18,%esp
}
  8017a1:	c9                   	leave  
  8017a2:	c3                   	ret    

008017a3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017a3:	55                   	push   %ebp
  8017a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 0d                	push   $0xd
  8017b2:	e8 4e fe ff ff       	call   801605 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	ff 75 0c             	pushl  0xc(%ebp)
  8017c8:	ff 75 08             	pushl  0x8(%ebp)
  8017cb:	6a 11                	push   $0x11
  8017cd:	e8 33 fe ff ff       	call   801605 <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
	return;
  8017d5:	90                   	nop
}
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	ff 75 0c             	pushl  0xc(%ebp)
  8017e4:	ff 75 08             	pushl  0x8(%ebp)
  8017e7:	6a 12                	push   $0x12
  8017e9:	e8 17 fe ff ff       	call   801605 <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8017f1:	90                   	nop
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 0e                	push   $0xe
  801803:	e8 fd fd ff ff       	call   801605 <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
}
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	ff 75 08             	pushl  0x8(%ebp)
  80181b:	6a 0f                	push   $0xf
  80181d:	e8 e3 fd ff ff       	call   801605 <syscall>
  801822:	83 c4 18             	add    $0x18,%esp
}
  801825:	c9                   	leave  
  801826:	c3                   	ret    

00801827 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801827:	55                   	push   %ebp
  801828:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 10                	push   $0x10
  801836:	e8 ca fd ff ff       	call   801605 <syscall>
  80183b:	83 c4 18             	add    $0x18,%esp
}
  80183e:	90                   	nop
  80183f:	c9                   	leave  
  801840:	c3                   	ret    

00801841 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801841:	55                   	push   %ebp
  801842:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 14                	push   $0x14
  801850:	e8 b0 fd ff ff       	call   801605 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
}
  801858:	90                   	nop
  801859:	c9                   	leave  
  80185a:	c3                   	ret    

0080185b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80185b:	55                   	push   %ebp
  80185c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 15                	push   $0x15
  80186a:	e8 96 fd ff ff       	call   801605 <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
}
  801872:	90                   	nop
  801873:	c9                   	leave  
  801874:	c3                   	ret    

00801875 <sys_cputc>:


void
sys_cputc(const char c)
{
  801875:	55                   	push   %ebp
  801876:	89 e5                	mov    %esp,%ebp
  801878:	83 ec 04             	sub    $0x4,%esp
  80187b:	8b 45 08             	mov    0x8(%ebp),%eax
  80187e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801881:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	50                   	push   %eax
  80188e:	6a 16                	push   $0x16
  801890:	e8 70 fd ff ff       	call   801605 <syscall>
  801895:	83 c4 18             	add    $0x18,%esp
}
  801898:	90                   	nop
  801899:	c9                   	leave  
  80189a:	c3                   	ret    

0080189b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80189b:	55                   	push   %ebp
  80189c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 17                	push   $0x17
  8018aa:	e8 56 fd ff ff       	call   801605 <syscall>
  8018af:	83 c4 18             	add    $0x18,%esp
}
  8018b2:	90                   	nop
  8018b3:	c9                   	leave  
  8018b4:	c3                   	ret    

008018b5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8018b5:	55                   	push   %ebp
  8018b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8018b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	ff 75 0c             	pushl  0xc(%ebp)
  8018c4:	50                   	push   %eax
  8018c5:	6a 18                	push   $0x18
  8018c7:	e8 39 fd ff ff       	call   801605 <syscall>
  8018cc:	83 c4 18             	add    $0x18,%esp
}
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	52                   	push   %edx
  8018e1:	50                   	push   %eax
  8018e2:	6a 1b                	push   $0x1b
  8018e4:	e8 1c fd ff ff       	call   801605 <syscall>
  8018e9:	83 c4 18             	add    $0x18,%esp
}
  8018ec:	c9                   	leave  
  8018ed:	c3                   	ret    

008018ee <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018ee:	55                   	push   %ebp
  8018ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	52                   	push   %edx
  8018fe:	50                   	push   %eax
  8018ff:	6a 19                	push   $0x19
  801901:	e8 ff fc ff ff       	call   801605 <syscall>
  801906:	83 c4 18             	add    $0x18,%esp
}
  801909:	90                   	nop
  80190a:	c9                   	leave  
  80190b:	c3                   	ret    

0080190c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80190c:	55                   	push   %ebp
  80190d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80190f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	52                   	push   %edx
  80191c:	50                   	push   %eax
  80191d:	6a 1a                	push   $0x1a
  80191f:	e8 e1 fc ff ff       	call   801605 <syscall>
  801924:	83 c4 18             	add    $0x18,%esp
}
  801927:	90                   	nop
  801928:	c9                   	leave  
  801929:	c3                   	ret    

0080192a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80192a:	55                   	push   %ebp
  80192b:	89 e5                	mov    %esp,%ebp
  80192d:	83 ec 04             	sub    $0x4,%esp
  801930:	8b 45 10             	mov    0x10(%ebp),%eax
  801933:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801936:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801939:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80193d:	8b 45 08             	mov    0x8(%ebp),%eax
  801940:	6a 00                	push   $0x0
  801942:	51                   	push   %ecx
  801943:	52                   	push   %edx
  801944:	ff 75 0c             	pushl  0xc(%ebp)
  801947:	50                   	push   %eax
  801948:	6a 1c                	push   $0x1c
  80194a:	e8 b6 fc ff ff       	call   801605 <syscall>
  80194f:	83 c4 18             	add    $0x18,%esp
}
  801952:	c9                   	leave  
  801953:	c3                   	ret    

00801954 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801954:	55                   	push   %ebp
  801955:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801957:	8b 55 0c             	mov    0xc(%ebp),%edx
  80195a:	8b 45 08             	mov    0x8(%ebp),%eax
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	52                   	push   %edx
  801964:	50                   	push   %eax
  801965:	6a 1d                	push   $0x1d
  801967:	e8 99 fc ff ff       	call   801605 <syscall>
  80196c:	83 c4 18             	add    $0x18,%esp
}
  80196f:	c9                   	leave  
  801970:	c3                   	ret    

00801971 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801971:	55                   	push   %ebp
  801972:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801974:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801977:	8b 55 0c             	mov    0xc(%ebp),%edx
  80197a:	8b 45 08             	mov    0x8(%ebp),%eax
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	51                   	push   %ecx
  801982:	52                   	push   %edx
  801983:	50                   	push   %eax
  801984:	6a 1e                	push   $0x1e
  801986:	e8 7a fc ff ff       	call   801605 <syscall>
  80198b:	83 c4 18             	add    $0x18,%esp
}
  80198e:	c9                   	leave  
  80198f:	c3                   	ret    

00801990 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801990:	55                   	push   %ebp
  801991:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801993:	8b 55 0c             	mov    0xc(%ebp),%edx
  801996:	8b 45 08             	mov    0x8(%ebp),%eax
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	52                   	push   %edx
  8019a0:	50                   	push   %eax
  8019a1:	6a 1f                	push   $0x1f
  8019a3:	e8 5d fc ff ff       	call   801605 <syscall>
  8019a8:	83 c4 18             	add    $0x18,%esp
}
  8019ab:	c9                   	leave  
  8019ac:	c3                   	ret    

008019ad <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8019ad:	55                   	push   %ebp
  8019ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 20                	push   $0x20
  8019bc:	e8 44 fc ff ff       	call   801605 <syscall>
  8019c1:	83 c4 18             	add    $0x18,%esp
}
  8019c4:	c9                   	leave  
  8019c5:	c3                   	ret    

008019c6 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8019c6:	55                   	push   %ebp
  8019c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8019c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cc:	6a 00                	push   $0x0
  8019ce:	ff 75 14             	pushl  0x14(%ebp)
  8019d1:	ff 75 10             	pushl  0x10(%ebp)
  8019d4:	ff 75 0c             	pushl  0xc(%ebp)
  8019d7:	50                   	push   %eax
  8019d8:	6a 21                	push   $0x21
  8019da:	e8 26 fc ff ff       	call   801605 <syscall>
  8019df:	83 c4 18             	add    $0x18,%esp
}
  8019e2:	c9                   	leave  
  8019e3:	c3                   	ret    

008019e4 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8019e4:	55                   	push   %ebp
  8019e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	50                   	push   %eax
  8019f3:	6a 22                	push   $0x22
  8019f5:	e8 0b fc ff ff       	call   801605 <syscall>
  8019fa:	83 c4 18             	add    $0x18,%esp
}
  8019fd:	90                   	nop
  8019fe:	c9                   	leave  
  8019ff:	c3                   	ret    

00801a00 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a00:	55                   	push   %ebp
  801a01:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801a03:	8b 45 08             	mov    0x8(%ebp),%eax
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	50                   	push   %eax
  801a0f:	6a 23                	push   $0x23
  801a11:	e8 ef fb ff ff       	call   801605 <syscall>
  801a16:	83 c4 18             	add    $0x18,%esp
}
  801a19:	90                   	nop
  801a1a:	c9                   	leave  
  801a1b:	c3                   	ret    

00801a1c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a1c:	55                   	push   %ebp
  801a1d:	89 e5                	mov    %esp,%ebp
  801a1f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a22:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a25:	8d 50 04             	lea    0x4(%eax),%edx
  801a28:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	52                   	push   %edx
  801a32:	50                   	push   %eax
  801a33:	6a 24                	push   $0x24
  801a35:	e8 cb fb ff ff       	call   801605 <syscall>
  801a3a:	83 c4 18             	add    $0x18,%esp
	return result;
  801a3d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a40:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a43:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a46:	89 01                	mov    %eax,(%ecx)
  801a48:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4e:	c9                   	leave  
  801a4f:	c2 04 00             	ret    $0x4

00801a52 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	ff 75 10             	pushl  0x10(%ebp)
  801a5c:	ff 75 0c             	pushl  0xc(%ebp)
  801a5f:	ff 75 08             	pushl  0x8(%ebp)
  801a62:	6a 13                	push   $0x13
  801a64:	e8 9c fb ff ff       	call   801605 <syscall>
  801a69:	83 c4 18             	add    $0x18,%esp
	return ;
  801a6c:	90                   	nop
}
  801a6d:	c9                   	leave  
  801a6e:	c3                   	ret    

00801a6f <sys_rcr2>:
uint32 sys_rcr2()
{
  801a6f:	55                   	push   %ebp
  801a70:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 25                	push   $0x25
  801a7e:	e8 82 fb ff ff       	call   801605 <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
}
  801a86:	c9                   	leave  
  801a87:	c3                   	ret    

00801a88 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a88:	55                   	push   %ebp
  801a89:	89 e5                	mov    %esp,%ebp
  801a8b:	83 ec 04             	sub    $0x4,%esp
  801a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a91:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a94:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	50                   	push   %eax
  801aa1:	6a 26                	push   $0x26
  801aa3:	e8 5d fb ff ff       	call   801605 <syscall>
  801aa8:	83 c4 18             	add    $0x18,%esp
	return ;
  801aab:	90                   	nop
}
  801aac:	c9                   	leave  
  801aad:	c3                   	ret    

00801aae <rsttst>:
void rsttst()
{
  801aae:	55                   	push   %ebp
  801aaf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 28                	push   $0x28
  801abd:	e8 43 fb ff ff       	call   801605 <syscall>
  801ac2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ac5:	90                   	nop
}
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
  801acb:	83 ec 04             	sub    $0x4,%esp
  801ace:	8b 45 14             	mov    0x14(%ebp),%eax
  801ad1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ad4:	8b 55 18             	mov    0x18(%ebp),%edx
  801ad7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801adb:	52                   	push   %edx
  801adc:	50                   	push   %eax
  801add:	ff 75 10             	pushl  0x10(%ebp)
  801ae0:	ff 75 0c             	pushl  0xc(%ebp)
  801ae3:	ff 75 08             	pushl  0x8(%ebp)
  801ae6:	6a 27                	push   $0x27
  801ae8:	e8 18 fb ff ff       	call   801605 <syscall>
  801aed:	83 c4 18             	add    $0x18,%esp
	return ;
  801af0:	90                   	nop
}
  801af1:	c9                   	leave  
  801af2:	c3                   	ret    

00801af3 <chktst>:
void chktst(uint32 n)
{
  801af3:	55                   	push   %ebp
  801af4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	ff 75 08             	pushl  0x8(%ebp)
  801b01:	6a 29                	push   $0x29
  801b03:	e8 fd fa ff ff       	call   801605 <syscall>
  801b08:	83 c4 18             	add    $0x18,%esp
	return ;
  801b0b:	90                   	nop
}
  801b0c:	c9                   	leave  
  801b0d:	c3                   	ret    

00801b0e <inctst>:

void inctst()
{
  801b0e:	55                   	push   %ebp
  801b0f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 2a                	push   $0x2a
  801b1d:	e8 e3 fa ff ff       	call   801605 <syscall>
  801b22:	83 c4 18             	add    $0x18,%esp
	return ;
  801b25:	90                   	nop
}
  801b26:	c9                   	leave  
  801b27:	c3                   	ret    

00801b28 <gettst>:
uint32 gettst()
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 2b                	push   $0x2b
  801b37:	e8 c9 fa ff ff       	call   801605 <syscall>
  801b3c:	83 c4 18             	add    $0x18,%esp
}
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
  801b44:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b47:	6a 00                	push   $0x0
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 2c                	push   $0x2c
  801b53:	e8 ad fa ff ff       	call   801605 <syscall>
  801b58:	83 c4 18             	add    $0x18,%esp
  801b5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b5e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b62:	75 07                	jne    801b6b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b64:	b8 01 00 00 00       	mov    $0x1,%eax
  801b69:	eb 05                	jmp    801b70 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b6b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
  801b75:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 2c                	push   $0x2c
  801b84:	e8 7c fa ff ff       	call   801605 <syscall>
  801b89:	83 c4 18             	add    $0x18,%esp
  801b8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b8f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b93:	75 07                	jne    801b9c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b95:	b8 01 00 00 00       	mov    $0x1,%eax
  801b9a:	eb 05                	jmp    801ba1 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b9c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ba1:	c9                   	leave  
  801ba2:	c3                   	ret    

00801ba3 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ba3:	55                   	push   %ebp
  801ba4:	89 e5                	mov    %esp,%ebp
  801ba6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 2c                	push   $0x2c
  801bb5:	e8 4b fa ff ff       	call   801605 <syscall>
  801bba:	83 c4 18             	add    $0x18,%esp
  801bbd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801bc0:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801bc4:	75 07                	jne    801bcd <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801bc6:	b8 01 00 00 00       	mov    $0x1,%eax
  801bcb:	eb 05                	jmp    801bd2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801bcd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
  801bd7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 2c                	push   $0x2c
  801be6:	e8 1a fa ff ff       	call   801605 <syscall>
  801beb:	83 c4 18             	add    $0x18,%esp
  801bee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801bf1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bf5:	75 07                	jne    801bfe <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bf7:	b8 01 00 00 00       	mov    $0x1,%eax
  801bfc:	eb 05                	jmp    801c03 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bfe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c03:	c9                   	leave  
  801c04:	c3                   	ret    

00801c05 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	ff 75 08             	pushl  0x8(%ebp)
  801c13:	6a 2d                	push   $0x2d
  801c15:	e8 eb f9 ff ff       	call   801605 <syscall>
  801c1a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c1d:	90                   	nop
}
  801c1e:	c9                   	leave  
  801c1f:	c3                   	ret    

00801c20 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801c20:	55                   	push   %ebp
  801c21:	89 e5                	mov    %esp,%ebp
  801c23:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801c24:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c27:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c30:	6a 00                	push   $0x0
  801c32:	53                   	push   %ebx
  801c33:	51                   	push   %ecx
  801c34:	52                   	push   %edx
  801c35:	50                   	push   %eax
  801c36:	6a 2e                	push   $0x2e
  801c38:	e8 c8 f9 ff ff       	call   801605 <syscall>
  801c3d:	83 c4 18             	add    $0x18,%esp
}
  801c40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801c43:	c9                   	leave  
  801c44:	c3                   	ret    

00801c45 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801c45:	55                   	push   %ebp
  801c46:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801c48:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	52                   	push   %edx
  801c55:	50                   	push   %eax
  801c56:	6a 2f                	push   $0x2f
  801c58:	e8 a8 f9 ff ff       	call   801605 <syscall>
  801c5d:	83 c4 18             	add    $0x18,%esp
}
  801c60:	c9                   	leave  
  801c61:	c3                   	ret    
  801c62:	66 90                	xchg   %ax,%ax

00801c64 <__udivdi3>:
  801c64:	55                   	push   %ebp
  801c65:	57                   	push   %edi
  801c66:	56                   	push   %esi
  801c67:	53                   	push   %ebx
  801c68:	83 ec 1c             	sub    $0x1c,%esp
  801c6b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c6f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c73:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c77:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c7b:	89 ca                	mov    %ecx,%edx
  801c7d:	89 f8                	mov    %edi,%eax
  801c7f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c83:	85 f6                	test   %esi,%esi
  801c85:	75 2d                	jne    801cb4 <__udivdi3+0x50>
  801c87:	39 cf                	cmp    %ecx,%edi
  801c89:	77 65                	ja     801cf0 <__udivdi3+0x8c>
  801c8b:	89 fd                	mov    %edi,%ebp
  801c8d:	85 ff                	test   %edi,%edi
  801c8f:	75 0b                	jne    801c9c <__udivdi3+0x38>
  801c91:	b8 01 00 00 00       	mov    $0x1,%eax
  801c96:	31 d2                	xor    %edx,%edx
  801c98:	f7 f7                	div    %edi
  801c9a:	89 c5                	mov    %eax,%ebp
  801c9c:	31 d2                	xor    %edx,%edx
  801c9e:	89 c8                	mov    %ecx,%eax
  801ca0:	f7 f5                	div    %ebp
  801ca2:	89 c1                	mov    %eax,%ecx
  801ca4:	89 d8                	mov    %ebx,%eax
  801ca6:	f7 f5                	div    %ebp
  801ca8:	89 cf                	mov    %ecx,%edi
  801caa:	89 fa                	mov    %edi,%edx
  801cac:	83 c4 1c             	add    $0x1c,%esp
  801caf:	5b                   	pop    %ebx
  801cb0:	5e                   	pop    %esi
  801cb1:	5f                   	pop    %edi
  801cb2:	5d                   	pop    %ebp
  801cb3:	c3                   	ret    
  801cb4:	39 ce                	cmp    %ecx,%esi
  801cb6:	77 28                	ja     801ce0 <__udivdi3+0x7c>
  801cb8:	0f bd fe             	bsr    %esi,%edi
  801cbb:	83 f7 1f             	xor    $0x1f,%edi
  801cbe:	75 40                	jne    801d00 <__udivdi3+0x9c>
  801cc0:	39 ce                	cmp    %ecx,%esi
  801cc2:	72 0a                	jb     801cce <__udivdi3+0x6a>
  801cc4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801cc8:	0f 87 9e 00 00 00    	ja     801d6c <__udivdi3+0x108>
  801cce:	b8 01 00 00 00       	mov    $0x1,%eax
  801cd3:	89 fa                	mov    %edi,%edx
  801cd5:	83 c4 1c             	add    $0x1c,%esp
  801cd8:	5b                   	pop    %ebx
  801cd9:	5e                   	pop    %esi
  801cda:	5f                   	pop    %edi
  801cdb:	5d                   	pop    %ebp
  801cdc:	c3                   	ret    
  801cdd:	8d 76 00             	lea    0x0(%esi),%esi
  801ce0:	31 ff                	xor    %edi,%edi
  801ce2:	31 c0                	xor    %eax,%eax
  801ce4:	89 fa                	mov    %edi,%edx
  801ce6:	83 c4 1c             	add    $0x1c,%esp
  801ce9:	5b                   	pop    %ebx
  801cea:	5e                   	pop    %esi
  801ceb:	5f                   	pop    %edi
  801cec:	5d                   	pop    %ebp
  801ced:	c3                   	ret    
  801cee:	66 90                	xchg   %ax,%ax
  801cf0:	89 d8                	mov    %ebx,%eax
  801cf2:	f7 f7                	div    %edi
  801cf4:	31 ff                	xor    %edi,%edi
  801cf6:	89 fa                	mov    %edi,%edx
  801cf8:	83 c4 1c             	add    $0x1c,%esp
  801cfb:	5b                   	pop    %ebx
  801cfc:	5e                   	pop    %esi
  801cfd:	5f                   	pop    %edi
  801cfe:	5d                   	pop    %ebp
  801cff:	c3                   	ret    
  801d00:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d05:	89 eb                	mov    %ebp,%ebx
  801d07:	29 fb                	sub    %edi,%ebx
  801d09:	89 f9                	mov    %edi,%ecx
  801d0b:	d3 e6                	shl    %cl,%esi
  801d0d:	89 c5                	mov    %eax,%ebp
  801d0f:	88 d9                	mov    %bl,%cl
  801d11:	d3 ed                	shr    %cl,%ebp
  801d13:	89 e9                	mov    %ebp,%ecx
  801d15:	09 f1                	or     %esi,%ecx
  801d17:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d1b:	89 f9                	mov    %edi,%ecx
  801d1d:	d3 e0                	shl    %cl,%eax
  801d1f:	89 c5                	mov    %eax,%ebp
  801d21:	89 d6                	mov    %edx,%esi
  801d23:	88 d9                	mov    %bl,%cl
  801d25:	d3 ee                	shr    %cl,%esi
  801d27:	89 f9                	mov    %edi,%ecx
  801d29:	d3 e2                	shl    %cl,%edx
  801d2b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d2f:	88 d9                	mov    %bl,%cl
  801d31:	d3 e8                	shr    %cl,%eax
  801d33:	09 c2                	or     %eax,%edx
  801d35:	89 d0                	mov    %edx,%eax
  801d37:	89 f2                	mov    %esi,%edx
  801d39:	f7 74 24 0c          	divl   0xc(%esp)
  801d3d:	89 d6                	mov    %edx,%esi
  801d3f:	89 c3                	mov    %eax,%ebx
  801d41:	f7 e5                	mul    %ebp
  801d43:	39 d6                	cmp    %edx,%esi
  801d45:	72 19                	jb     801d60 <__udivdi3+0xfc>
  801d47:	74 0b                	je     801d54 <__udivdi3+0xf0>
  801d49:	89 d8                	mov    %ebx,%eax
  801d4b:	31 ff                	xor    %edi,%edi
  801d4d:	e9 58 ff ff ff       	jmp    801caa <__udivdi3+0x46>
  801d52:	66 90                	xchg   %ax,%ax
  801d54:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d58:	89 f9                	mov    %edi,%ecx
  801d5a:	d3 e2                	shl    %cl,%edx
  801d5c:	39 c2                	cmp    %eax,%edx
  801d5e:	73 e9                	jae    801d49 <__udivdi3+0xe5>
  801d60:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d63:	31 ff                	xor    %edi,%edi
  801d65:	e9 40 ff ff ff       	jmp    801caa <__udivdi3+0x46>
  801d6a:	66 90                	xchg   %ax,%ax
  801d6c:	31 c0                	xor    %eax,%eax
  801d6e:	e9 37 ff ff ff       	jmp    801caa <__udivdi3+0x46>
  801d73:	90                   	nop

00801d74 <__umoddi3>:
  801d74:	55                   	push   %ebp
  801d75:	57                   	push   %edi
  801d76:	56                   	push   %esi
  801d77:	53                   	push   %ebx
  801d78:	83 ec 1c             	sub    $0x1c,%esp
  801d7b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d7f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d83:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d87:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d8b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d8f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d93:	89 f3                	mov    %esi,%ebx
  801d95:	89 fa                	mov    %edi,%edx
  801d97:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d9b:	89 34 24             	mov    %esi,(%esp)
  801d9e:	85 c0                	test   %eax,%eax
  801da0:	75 1a                	jne    801dbc <__umoddi3+0x48>
  801da2:	39 f7                	cmp    %esi,%edi
  801da4:	0f 86 a2 00 00 00    	jbe    801e4c <__umoddi3+0xd8>
  801daa:	89 c8                	mov    %ecx,%eax
  801dac:	89 f2                	mov    %esi,%edx
  801dae:	f7 f7                	div    %edi
  801db0:	89 d0                	mov    %edx,%eax
  801db2:	31 d2                	xor    %edx,%edx
  801db4:	83 c4 1c             	add    $0x1c,%esp
  801db7:	5b                   	pop    %ebx
  801db8:	5e                   	pop    %esi
  801db9:	5f                   	pop    %edi
  801dba:	5d                   	pop    %ebp
  801dbb:	c3                   	ret    
  801dbc:	39 f0                	cmp    %esi,%eax
  801dbe:	0f 87 ac 00 00 00    	ja     801e70 <__umoddi3+0xfc>
  801dc4:	0f bd e8             	bsr    %eax,%ebp
  801dc7:	83 f5 1f             	xor    $0x1f,%ebp
  801dca:	0f 84 ac 00 00 00    	je     801e7c <__umoddi3+0x108>
  801dd0:	bf 20 00 00 00       	mov    $0x20,%edi
  801dd5:	29 ef                	sub    %ebp,%edi
  801dd7:	89 fe                	mov    %edi,%esi
  801dd9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ddd:	89 e9                	mov    %ebp,%ecx
  801ddf:	d3 e0                	shl    %cl,%eax
  801de1:	89 d7                	mov    %edx,%edi
  801de3:	89 f1                	mov    %esi,%ecx
  801de5:	d3 ef                	shr    %cl,%edi
  801de7:	09 c7                	or     %eax,%edi
  801de9:	89 e9                	mov    %ebp,%ecx
  801deb:	d3 e2                	shl    %cl,%edx
  801ded:	89 14 24             	mov    %edx,(%esp)
  801df0:	89 d8                	mov    %ebx,%eax
  801df2:	d3 e0                	shl    %cl,%eax
  801df4:	89 c2                	mov    %eax,%edx
  801df6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dfa:	d3 e0                	shl    %cl,%eax
  801dfc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e00:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e04:	89 f1                	mov    %esi,%ecx
  801e06:	d3 e8                	shr    %cl,%eax
  801e08:	09 d0                	or     %edx,%eax
  801e0a:	d3 eb                	shr    %cl,%ebx
  801e0c:	89 da                	mov    %ebx,%edx
  801e0e:	f7 f7                	div    %edi
  801e10:	89 d3                	mov    %edx,%ebx
  801e12:	f7 24 24             	mull   (%esp)
  801e15:	89 c6                	mov    %eax,%esi
  801e17:	89 d1                	mov    %edx,%ecx
  801e19:	39 d3                	cmp    %edx,%ebx
  801e1b:	0f 82 87 00 00 00    	jb     801ea8 <__umoddi3+0x134>
  801e21:	0f 84 91 00 00 00    	je     801eb8 <__umoddi3+0x144>
  801e27:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e2b:	29 f2                	sub    %esi,%edx
  801e2d:	19 cb                	sbb    %ecx,%ebx
  801e2f:	89 d8                	mov    %ebx,%eax
  801e31:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e35:	d3 e0                	shl    %cl,%eax
  801e37:	89 e9                	mov    %ebp,%ecx
  801e39:	d3 ea                	shr    %cl,%edx
  801e3b:	09 d0                	or     %edx,%eax
  801e3d:	89 e9                	mov    %ebp,%ecx
  801e3f:	d3 eb                	shr    %cl,%ebx
  801e41:	89 da                	mov    %ebx,%edx
  801e43:	83 c4 1c             	add    $0x1c,%esp
  801e46:	5b                   	pop    %ebx
  801e47:	5e                   	pop    %esi
  801e48:	5f                   	pop    %edi
  801e49:	5d                   	pop    %ebp
  801e4a:	c3                   	ret    
  801e4b:	90                   	nop
  801e4c:	89 fd                	mov    %edi,%ebp
  801e4e:	85 ff                	test   %edi,%edi
  801e50:	75 0b                	jne    801e5d <__umoddi3+0xe9>
  801e52:	b8 01 00 00 00       	mov    $0x1,%eax
  801e57:	31 d2                	xor    %edx,%edx
  801e59:	f7 f7                	div    %edi
  801e5b:	89 c5                	mov    %eax,%ebp
  801e5d:	89 f0                	mov    %esi,%eax
  801e5f:	31 d2                	xor    %edx,%edx
  801e61:	f7 f5                	div    %ebp
  801e63:	89 c8                	mov    %ecx,%eax
  801e65:	f7 f5                	div    %ebp
  801e67:	89 d0                	mov    %edx,%eax
  801e69:	e9 44 ff ff ff       	jmp    801db2 <__umoddi3+0x3e>
  801e6e:	66 90                	xchg   %ax,%ax
  801e70:	89 c8                	mov    %ecx,%eax
  801e72:	89 f2                	mov    %esi,%edx
  801e74:	83 c4 1c             	add    $0x1c,%esp
  801e77:	5b                   	pop    %ebx
  801e78:	5e                   	pop    %esi
  801e79:	5f                   	pop    %edi
  801e7a:	5d                   	pop    %ebp
  801e7b:	c3                   	ret    
  801e7c:	3b 04 24             	cmp    (%esp),%eax
  801e7f:	72 06                	jb     801e87 <__umoddi3+0x113>
  801e81:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e85:	77 0f                	ja     801e96 <__umoddi3+0x122>
  801e87:	89 f2                	mov    %esi,%edx
  801e89:	29 f9                	sub    %edi,%ecx
  801e8b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e8f:	89 14 24             	mov    %edx,(%esp)
  801e92:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e96:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e9a:	8b 14 24             	mov    (%esp),%edx
  801e9d:	83 c4 1c             	add    $0x1c,%esp
  801ea0:	5b                   	pop    %ebx
  801ea1:	5e                   	pop    %esi
  801ea2:	5f                   	pop    %edi
  801ea3:	5d                   	pop    %ebp
  801ea4:	c3                   	ret    
  801ea5:	8d 76 00             	lea    0x0(%esi),%esi
  801ea8:	2b 04 24             	sub    (%esp),%eax
  801eab:	19 fa                	sbb    %edi,%edx
  801ead:	89 d1                	mov    %edx,%ecx
  801eaf:	89 c6                	mov    %eax,%esi
  801eb1:	e9 71 ff ff ff       	jmp    801e27 <__umoddi3+0xb3>
  801eb6:	66 90                	xchg   %ax,%ax
  801eb8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ebc:	72 ea                	jb     801ea8 <__umoddi3+0x134>
  801ebe:	89 d9                	mov    %ebx,%ecx
  801ec0:	e9 62 ff ff ff       	jmp    801e27 <__umoddi3+0xb3>

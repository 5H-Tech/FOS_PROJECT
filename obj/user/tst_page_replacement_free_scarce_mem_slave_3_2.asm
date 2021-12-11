
obj/user/tst_page_replacement_free_scarce_mem_slave_3_2:     file format elf32-i386


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
  800031:	e8 0e 01 00 00       	call   800144 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 24 20 00 00    	sub    $0x2024,%esp
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800049:	eb 44                	jmp    80008f <_main+0x57>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80004b:	a1 20 30 80 00       	mov    0x803020,%eax
  800050:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800056:	a1 20 30 80 00       	mov    0x803020,%eax
  80005b:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800061:	89 c1                	mov    %eax,%ecx
  800063:	a1 20 30 80 00       	mov    0x803020,%eax
  800068:	8b 40 74             	mov    0x74(%eax),%eax
  80006b:	52                   	push   %edx
  80006c:	51                   	push   %ecx
  80006d:	50                   	push   %eax
  80006e:	68 40 1c 80 00       	push   $0x801c40
  800073:	e8 fe 15 00 00       	call   801676 <sys_create_env>
  800078:	83 c4 10             	add    $0x10,%esp
  80007b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		sys_run_env(ID);
  80007e:	83 ec 0c             	sub    $0xc,%esp
  800081:	ff 75 f0             	pushl  -0x10(%ebp)
  800084:	e8 0b 16 00 00       	call   801694 <sys_run_env>
  800089:	83 c4 10             	add    $0x10,%esp

void _main(void)
{
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  80008c:	ff 45 f4             	incl   -0xc(%ebp)
  80008f:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  800093:	7e b6                	jle    80004b <_main+0x13>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(ID);
	}

	sys_scarce_memory();
  800095:	e8 3d 14 00 00       	call   8014d7 <sys_scarce_memory>

	uint32 freePagesBefore = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  80009a:	e8 82 13 00 00       	call   801421 <sys_calculate_free_frames>
  80009f:	89 c3                	mov    %eax,%ebx
  8000a1:	e8 94 13 00 00       	call   80143a <sys_calculate_modified_frames>
  8000a6:	01 d8                	add    %ebx,%eax
  8000a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
	uint32 usedDiskPagesBefore = sys_pf_calculate_allocated_pages();
  8000ab:	e8 f4 13 00 00       	call   8014a4 <sys_pf_calculate_allocated_pages>
  8000b0:	89 45 e8             	mov    %eax,-0x18(%ebp)

	// Check the number of pages shall be deleted with the first fault after scarce the memory
	int pagesToBeDeletedCount = sys_calculate_pages_tobe_removed_ready_exit(1);
  8000b3:	83 ec 0c             	sub    $0xc,%esp
  8000b6:	6a 01                	push   $0x1
  8000b8:	e8 00 14 00 00       	call   8014bd <sys_calculate_pages_tobe_removed_ready_exit>
  8000bd:	83 c4 10             	add    $0x10,%esp
  8000c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	char arr[PAGE_SIZE*2];
	// Access the created array in STACK to FAULT and Free SCARCE MEM
	arr[1*PAGE_SIZE] = -1;
  8000c3:	c6 85 e0 ef ff ff ff 	movb   $0xff,-0x1020(%ebp)

	//cprintf("Checking Allocation in Mem & Page File... \n");
	//AFTER freeing MEMORY
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPagesBefore) !=  1) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  8000ca:	e8 d5 13 00 00       	call   8014a4 <sys_pf_calculate_allocated_pages>
  8000cf:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d2:	83 f8 01             	cmp    $0x1,%eax
  8000d5:	74 14                	je     8000eb <_main+0xb3>
  8000d7:	83 ec 04             	sub    $0x4,%esp
  8000da:	68 50 1c 80 00       	push   $0x801c50
  8000df:	6a 1c                	push   $0x1c
  8000e1:	68 bc 1c 80 00       	push   $0x801cbc
  8000e6:	e8 9e 01 00 00       	call   800289 <_panic>
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8000eb:	e8 31 13 00 00       	call   801421 <sys_calculate_free_frames>
  8000f0:	89 c3                	mov    %eax,%ebx
  8000f2:	e8 43 13 00 00       	call   80143a <sys_calculate_modified_frames>
  8000f7:	01 d8                	add    %ebx,%eax
  8000f9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		if( (freePagesBefore + pagesToBeDeletedCount - 1) != freePagesAfter )
  8000fc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8000ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800102:	01 d0                	add    %edx,%eax
  800104:	48                   	dec    %eax
  800105:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800108:	74 14                	je     80011e <_main+0xe6>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  80010a:	83 ec 04             	sub    $0x4,%esp
  80010d:	68 f4 1c 80 00       	push   $0x801cf4
  800112:	6a 1f                	push   $0x1f
  800114:	68 bc 1c 80 00       	push   $0x801cbc
  800119:	e8 6b 01 00 00       	call   800289 <_panic>
	}

	env_sleep(100000);
  80011e:	83 ec 0c             	sub    $0xc,%esp
  800121:	68 a0 86 01 00       	push   $0x186a0
  800126:	e8 e7 17 00 00       	call   801912 <env_sleep>
  80012b:	83 c4 10             	add    $0x10,%esp
	// To ensure that the slave environments completed successfully
	cprintf("Congratulations!! test PAGE replacement [FREEING SCARCE MEMORY 3] is completed successfully.\n");
  80012e:	83 ec 0c             	sub    $0xc,%esp
  800131:	68 70 1d 80 00       	push   $0x801d70
  800136:	e8 f0 03 00 00       	call   80052b <cprintf>
  80013b:	83 c4 10             	add    $0x10,%esp

	return;
  80013e:	90                   	nop
}
  80013f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800142:	c9                   	leave  
  800143:	c3                   	ret    

00800144 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800144:	55                   	push   %ebp
  800145:	89 e5                	mov    %esp,%ebp
  800147:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80014a:	e8 07 12 00 00       	call   801356 <sys_getenvindex>
  80014f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800152:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800155:	89 d0                	mov    %edx,%eax
  800157:	c1 e0 03             	shl    $0x3,%eax
  80015a:	01 d0                	add    %edx,%eax
  80015c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800163:	01 c8                	add    %ecx,%eax
  800165:	01 c0                	add    %eax,%eax
  800167:	01 d0                	add    %edx,%eax
  800169:	01 c0                	add    %eax,%eax
  80016b:	01 d0                	add    %edx,%eax
  80016d:	89 c2                	mov    %eax,%edx
  80016f:	c1 e2 05             	shl    $0x5,%edx
  800172:	29 c2                	sub    %eax,%edx
  800174:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80017b:	89 c2                	mov    %eax,%edx
  80017d:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800183:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800188:	a1 20 30 80 00       	mov    0x803020,%eax
  80018d:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800193:	84 c0                	test   %al,%al
  800195:	74 0f                	je     8001a6 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800197:	a1 20 30 80 00       	mov    0x803020,%eax
  80019c:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001a1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001aa:	7e 0a                	jle    8001b6 <libmain+0x72>
		binaryname = argv[0];
  8001ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001af:	8b 00                	mov    (%eax),%eax
  8001b1:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001b6:	83 ec 08             	sub    $0x8,%esp
  8001b9:	ff 75 0c             	pushl  0xc(%ebp)
  8001bc:	ff 75 08             	pushl  0x8(%ebp)
  8001bf:	e8 74 fe ff ff       	call   800038 <_main>
  8001c4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001c7:	e8 25 13 00 00       	call   8014f1 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001cc:	83 ec 0c             	sub    $0xc,%esp
  8001cf:	68 e8 1d 80 00       	push   $0x801de8
  8001d4:	e8 52 03 00 00       	call   80052b <cprintf>
  8001d9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e1:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ec:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001f2:	83 ec 04             	sub    $0x4,%esp
  8001f5:	52                   	push   %edx
  8001f6:	50                   	push   %eax
  8001f7:	68 10 1e 80 00       	push   $0x801e10
  8001fc:	e8 2a 03 00 00       	call   80052b <cprintf>
  800201:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800204:	a1 20 30 80 00       	mov    0x803020,%eax
  800209:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80020f:	a1 20 30 80 00       	mov    0x803020,%eax
  800214:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80021a:	83 ec 04             	sub    $0x4,%esp
  80021d:	52                   	push   %edx
  80021e:	50                   	push   %eax
  80021f:	68 38 1e 80 00       	push   $0x801e38
  800224:	e8 02 03 00 00       	call   80052b <cprintf>
  800229:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80022c:	a1 20 30 80 00       	mov    0x803020,%eax
  800231:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800237:	83 ec 08             	sub    $0x8,%esp
  80023a:	50                   	push   %eax
  80023b:	68 79 1e 80 00       	push   $0x801e79
  800240:	e8 e6 02 00 00       	call   80052b <cprintf>
  800245:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800248:	83 ec 0c             	sub    $0xc,%esp
  80024b:	68 e8 1d 80 00       	push   $0x801de8
  800250:	e8 d6 02 00 00       	call   80052b <cprintf>
  800255:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800258:	e8 ae 12 00 00       	call   80150b <sys_enable_interrupt>

	// exit gracefully
	exit();
  80025d:	e8 19 00 00 00       	call   80027b <exit>
}
  800262:	90                   	nop
  800263:	c9                   	leave  
  800264:	c3                   	ret    

00800265 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800265:	55                   	push   %ebp
  800266:	89 e5                	mov    %esp,%ebp
  800268:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	6a 00                	push   $0x0
  800270:	e8 ad 10 00 00       	call   801322 <sys_env_destroy>
  800275:	83 c4 10             	add    $0x10,%esp
}
  800278:	90                   	nop
  800279:	c9                   	leave  
  80027a:	c3                   	ret    

0080027b <exit>:

void
exit(void)
{
  80027b:	55                   	push   %ebp
  80027c:	89 e5                	mov    %esp,%ebp
  80027e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800281:	e8 02 11 00 00       	call   801388 <sys_env_exit>
}
  800286:	90                   	nop
  800287:	c9                   	leave  
  800288:	c3                   	ret    

00800289 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800289:	55                   	push   %ebp
  80028a:	89 e5                	mov    %esp,%ebp
  80028c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80028f:	8d 45 10             	lea    0x10(%ebp),%eax
  800292:	83 c0 04             	add    $0x4,%eax
  800295:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800298:	a1 18 31 80 00       	mov    0x803118,%eax
  80029d:	85 c0                	test   %eax,%eax
  80029f:	74 16                	je     8002b7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002a1:	a1 18 31 80 00       	mov    0x803118,%eax
  8002a6:	83 ec 08             	sub    $0x8,%esp
  8002a9:	50                   	push   %eax
  8002aa:	68 90 1e 80 00       	push   $0x801e90
  8002af:	e8 77 02 00 00       	call   80052b <cprintf>
  8002b4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002b7:	a1 00 30 80 00       	mov    0x803000,%eax
  8002bc:	ff 75 0c             	pushl  0xc(%ebp)
  8002bf:	ff 75 08             	pushl  0x8(%ebp)
  8002c2:	50                   	push   %eax
  8002c3:	68 95 1e 80 00       	push   $0x801e95
  8002c8:	e8 5e 02 00 00       	call   80052b <cprintf>
  8002cd:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d3:	83 ec 08             	sub    $0x8,%esp
  8002d6:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d9:	50                   	push   %eax
  8002da:	e8 e1 01 00 00       	call   8004c0 <vcprintf>
  8002df:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002e2:	83 ec 08             	sub    $0x8,%esp
  8002e5:	6a 00                	push   $0x0
  8002e7:	68 b1 1e 80 00       	push   $0x801eb1
  8002ec:	e8 cf 01 00 00       	call   8004c0 <vcprintf>
  8002f1:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002f4:	e8 82 ff ff ff       	call   80027b <exit>

	// should not return here
	while (1) ;
  8002f9:	eb fe                	jmp    8002f9 <_panic+0x70>

008002fb <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002fb:	55                   	push   %ebp
  8002fc:	89 e5                	mov    %esp,%ebp
  8002fe:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800301:	a1 20 30 80 00       	mov    0x803020,%eax
  800306:	8b 50 74             	mov    0x74(%eax),%edx
  800309:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030c:	39 c2                	cmp    %eax,%edx
  80030e:	74 14                	je     800324 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800310:	83 ec 04             	sub    $0x4,%esp
  800313:	68 b4 1e 80 00       	push   $0x801eb4
  800318:	6a 26                	push   $0x26
  80031a:	68 00 1f 80 00       	push   $0x801f00
  80031f:	e8 65 ff ff ff       	call   800289 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800324:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80032b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800332:	e9 b6 00 00 00       	jmp    8003ed <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800337:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800341:	8b 45 08             	mov    0x8(%ebp),%eax
  800344:	01 d0                	add    %edx,%eax
  800346:	8b 00                	mov    (%eax),%eax
  800348:	85 c0                	test   %eax,%eax
  80034a:	75 08                	jne    800354 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80034c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80034f:	e9 96 00 00 00       	jmp    8003ea <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800354:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80035b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800362:	eb 5d                	jmp    8003c1 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800364:	a1 20 30 80 00       	mov    0x803020,%eax
  800369:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80036f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800372:	c1 e2 04             	shl    $0x4,%edx
  800375:	01 d0                	add    %edx,%eax
  800377:	8a 40 04             	mov    0x4(%eax),%al
  80037a:	84 c0                	test   %al,%al
  80037c:	75 40                	jne    8003be <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80037e:	a1 20 30 80 00       	mov    0x803020,%eax
  800383:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800389:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80038c:	c1 e2 04             	shl    $0x4,%edx
  80038f:	01 d0                	add    %edx,%eax
  800391:	8b 00                	mov    (%eax),%eax
  800393:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800396:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800399:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80039e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ad:	01 c8                	add    %ecx,%eax
  8003af:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003b1:	39 c2                	cmp    %eax,%edx
  8003b3:	75 09                	jne    8003be <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8003b5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003bc:	eb 12                	jmp    8003d0 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003be:	ff 45 e8             	incl   -0x18(%ebp)
  8003c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c6:	8b 50 74             	mov    0x74(%eax),%edx
  8003c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003cc:	39 c2                	cmp    %eax,%edx
  8003ce:	77 94                	ja     800364 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003d4:	75 14                	jne    8003ea <CheckWSWithoutLastIndex+0xef>
			panic(
  8003d6:	83 ec 04             	sub    $0x4,%esp
  8003d9:	68 0c 1f 80 00       	push   $0x801f0c
  8003de:	6a 3a                	push   $0x3a
  8003e0:	68 00 1f 80 00       	push   $0x801f00
  8003e5:	e8 9f fe ff ff       	call   800289 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003ea:	ff 45 f0             	incl   -0x10(%ebp)
  8003ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003f3:	0f 8c 3e ff ff ff    	jl     800337 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003f9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800400:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800407:	eb 20                	jmp    800429 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800409:	a1 20 30 80 00       	mov    0x803020,%eax
  80040e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800414:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800417:	c1 e2 04             	shl    $0x4,%edx
  80041a:	01 d0                	add    %edx,%eax
  80041c:	8a 40 04             	mov    0x4(%eax),%al
  80041f:	3c 01                	cmp    $0x1,%al
  800421:	75 03                	jne    800426 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800423:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800426:	ff 45 e0             	incl   -0x20(%ebp)
  800429:	a1 20 30 80 00       	mov    0x803020,%eax
  80042e:	8b 50 74             	mov    0x74(%eax),%edx
  800431:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800434:	39 c2                	cmp    %eax,%edx
  800436:	77 d1                	ja     800409 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800438:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80043b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80043e:	74 14                	je     800454 <CheckWSWithoutLastIndex+0x159>
		panic(
  800440:	83 ec 04             	sub    $0x4,%esp
  800443:	68 60 1f 80 00       	push   $0x801f60
  800448:	6a 44                	push   $0x44
  80044a:	68 00 1f 80 00       	push   $0x801f00
  80044f:	e8 35 fe ff ff       	call   800289 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800454:	90                   	nop
  800455:	c9                   	leave  
  800456:	c3                   	ret    

00800457 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800457:	55                   	push   %ebp
  800458:	89 e5                	mov    %esp,%ebp
  80045a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80045d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800460:	8b 00                	mov    (%eax),%eax
  800462:	8d 48 01             	lea    0x1(%eax),%ecx
  800465:	8b 55 0c             	mov    0xc(%ebp),%edx
  800468:	89 0a                	mov    %ecx,(%edx)
  80046a:	8b 55 08             	mov    0x8(%ebp),%edx
  80046d:	88 d1                	mov    %dl,%cl
  80046f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800472:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800476:	8b 45 0c             	mov    0xc(%ebp),%eax
  800479:	8b 00                	mov    (%eax),%eax
  80047b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800480:	75 2c                	jne    8004ae <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800482:	a0 24 30 80 00       	mov    0x803024,%al
  800487:	0f b6 c0             	movzbl %al,%eax
  80048a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80048d:	8b 12                	mov    (%edx),%edx
  80048f:	89 d1                	mov    %edx,%ecx
  800491:	8b 55 0c             	mov    0xc(%ebp),%edx
  800494:	83 c2 08             	add    $0x8,%edx
  800497:	83 ec 04             	sub    $0x4,%esp
  80049a:	50                   	push   %eax
  80049b:	51                   	push   %ecx
  80049c:	52                   	push   %edx
  80049d:	e8 3e 0e 00 00       	call   8012e0 <sys_cputs>
  8004a2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b1:	8b 40 04             	mov    0x4(%eax),%eax
  8004b4:	8d 50 01             	lea    0x1(%eax),%edx
  8004b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ba:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004bd:	90                   	nop
  8004be:	c9                   	leave  
  8004bf:	c3                   	ret    

008004c0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004c0:	55                   	push   %ebp
  8004c1:	89 e5                	mov    %esp,%ebp
  8004c3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004c9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004d0:	00 00 00 
	b.cnt = 0;
  8004d3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004da:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004dd:	ff 75 0c             	pushl  0xc(%ebp)
  8004e0:	ff 75 08             	pushl  0x8(%ebp)
  8004e3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004e9:	50                   	push   %eax
  8004ea:	68 57 04 80 00       	push   $0x800457
  8004ef:	e8 11 02 00 00       	call   800705 <vprintfmt>
  8004f4:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004f7:	a0 24 30 80 00       	mov    0x803024,%al
  8004fc:	0f b6 c0             	movzbl %al,%eax
  8004ff:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800505:	83 ec 04             	sub    $0x4,%esp
  800508:	50                   	push   %eax
  800509:	52                   	push   %edx
  80050a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800510:	83 c0 08             	add    $0x8,%eax
  800513:	50                   	push   %eax
  800514:	e8 c7 0d 00 00       	call   8012e0 <sys_cputs>
  800519:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80051c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800523:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800529:	c9                   	leave  
  80052a:	c3                   	ret    

0080052b <cprintf>:

int cprintf(const char *fmt, ...) {
  80052b:	55                   	push   %ebp
  80052c:	89 e5                	mov    %esp,%ebp
  80052e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800531:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800538:	8d 45 0c             	lea    0xc(%ebp),%eax
  80053b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80053e:	8b 45 08             	mov    0x8(%ebp),%eax
  800541:	83 ec 08             	sub    $0x8,%esp
  800544:	ff 75 f4             	pushl  -0xc(%ebp)
  800547:	50                   	push   %eax
  800548:	e8 73 ff ff ff       	call   8004c0 <vcprintf>
  80054d:	83 c4 10             	add    $0x10,%esp
  800550:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800553:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800556:	c9                   	leave  
  800557:	c3                   	ret    

00800558 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800558:	55                   	push   %ebp
  800559:	89 e5                	mov    %esp,%ebp
  80055b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80055e:	e8 8e 0f 00 00       	call   8014f1 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800563:	8d 45 0c             	lea    0xc(%ebp),%eax
  800566:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800569:	8b 45 08             	mov    0x8(%ebp),%eax
  80056c:	83 ec 08             	sub    $0x8,%esp
  80056f:	ff 75 f4             	pushl  -0xc(%ebp)
  800572:	50                   	push   %eax
  800573:	e8 48 ff ff ff       	call   8004c0 <vcprintf>
  800578:	83 c4 10             	add    $0x10,%esp
  80057b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80057e:	e8 88 0f 00 00       	call   80150b <sys_enable_interrupt>
	return cnt;
  800583:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800586:	c9                   	leave  
  800587:	c3                   	ret    

00800588 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800588:	55                   	push   %ebp
  800589:	89 e5                	mov    %esp,%ebp
  80058b:	53                   	push   %ebx
  80058c:	83 ec 14             	sub    $0x14,%esp
  80058f:	8b 45 10             	mov    0x10(%ebp),%eax
  800592:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800595:	8b 45 14             	mov    0x14(%ebp),%eax
  800598:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80059b:	8b 45 18             	mov    0x18(%ebp),%eax
  80059e:	ba 00 00 00 00       	mov    $0x0,%edx
  8005a3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005a6:	77 55                	ja     8005fd <printnum+0x75>
  8005a8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005ab:	72 05                	jb     8005b2 <printnum+0x2a>
  8005ad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005b0:	77 4b                	ja     8005fd <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005b2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005b5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005b8:	8b 45 18             	mov    0x18(%ebp),%eax
  8005bb:	ba 00 00 00 00       	mov    $0x0,%edx
  8005c0:	52                   	push   %edx
  8005c1:	50                   	push   %eax
  8005c2:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c5:	ff 75 f0             	pushl  -0x10(%ebp)
  8005c8:	e8 fb 13 00 00       	call   8019c8 <__udivdi3>
  8005cd:	83 c4 10             	add    $0x10,%esp
  8005d0:	83 ec 04             	sub    $0x4,%esp
  8005d3:	ff 75 20             	pushl  0x20(%ebp)
  8005d6:	53                   	push   %ebx
  8005d7:	ff 75 18             	pushl  0x18(%ebp)
  8005da:	52                   	push   %edx
  8005db:	50                   	push   %eax
  8005dc:	ff 75 0c             	pushl  0xc(%ebp)
  8005df:	ff 75 08             	pushl  0x8(%ebp)
  8005e2:	e8 a1 ff ff ff       	call   800588 <printnum>
  8005e7:	83 c4 20             	add    $0x20,%esp
  8005ea:	eb 1a                	jmp    800606 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005ec:	83 ec 08             	sub    $0x8,%esp
  8005ef:	ff 75 0c             	pushl  0xc(%ebp)
  8005f2:	ff 75 20             	pushl  0x20(%ebp)
  8005f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f8:	ff d0                	call   *%eax
  8005fa:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005fd:	ff 4d 1c             	decl   0x1c(%ebp)
  800600:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800604:	7f e6                	jg     8005ec <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800606:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800609:	bb 00 00 00 00       	mov    $0x0,%ebx
  80060e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800611:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800614:	53                   	push   %ebx
  800615:	51                   	push   %ecx
  800616:	52                   	push   %edx
  800617:	50                   	push   %eax
  800618:	e8 bb 14 00 00       	call   801ad8 <__umoddi3>
  80061d:	83 c4 10             	add    $0x10,%esp
  800620:	05 d4 21 80 00       	add    $0x8021d4,%eax
  800625:	8a 00                	mov    (%eax),%al
  800627:	0f be c0             	movsbl %al,%eax
  80062a:	83 ec 08             	sub    $0x8,%esp
  80062d:	ff 75 0c             	pushl  0xc(%ebp)
  800630:	50                   	push   %eax
  800631:	8b 45 08             	mov    0x8(%ebp),%eax
  800634:	ff d0                	call   *%eax
  800636:	83 c4 10             	add    $0x10,%esp
}
  800639:	90                   	nop
  80063a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80063d:	c9                   	leave  
  80063e:	c3                   	ret    

0080063f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80063f:	55                   	push   %ebp
  800640:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800642:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800646:	7e 1c                	jle    800664 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800648:	8b 45 08             	mov    0x8(%ebp),%eax
  80064b:	8b 00                	mov    (%eax),%eax
  80064d:	8d 50 08             	lea    0x8(%eax),%edx
  800650:	8b 45 08             	mov    0x8(%ebp),%eax
  800653:	89 10                	mov    %edx,(%eax)
  800655:	8b 45 08             	mov    0x8(%ebp),%eax
  800658:	8b 00                	mov    (%eax),%eax
  80065a:	83 e8 08             	sub    $0x8,%eax
  80065d:	8b 50 04             	mov    0x4(%eax),%edx
  800660:	8b 00                	mov    (%eax),%eax
  800662:	eb 40                	jmp    8006a4 <getuint+0x65>
	else if (lflag)
  800664:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800668:	74 1e                	je     800688 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80066a:	8b 45 08             	mov    0x8(%ebp),%eax
  80066d:	8b 00                	mov    (%eax),%eax
  80066f:	8d 50 04             	lea    0x4(%eax),%edx
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	89 10                	mov    %edx,(%eax)
  800677:	8b 45 08             	mov    0x8(%ebp),%eax
  80067a:	8b 00                	mov    (%eax),%eax
  80067c:	83 e8 04             	sub    $0x4,%eax
  80067f:	8b 00                	mov    (%eax),%eax
  800681:	ba 00 00 00 00       	mov    $0x0,%edx
  800686:	eb 1c                	jmp    8006a4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800688:	8b 45 08             	mov    0x8(%ebp),%eax
  80068b:	8b 00                	mov    (%eax),%eax
  80068d:	8d 50 04             	lea    0x4(%eax),%edx
  800690:	8b 45 08             	mov    0x8(%ebp),%eax
  800693:	89 10                	mov    %edx,(%eax)
  800695:	8b 45 08             	mov    0x8(%ebp),%eax
  800698:	8b 00                	mov    (%eax),%eax
  80069a:	83 e8 04             	sub    $0x4,%eax
  80069d:	8b 00                	mov    (%eax),%eax
  80069f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006a4:	5d                   	pop    %ebp
  8006a5:	c3                   	ret    

008006a6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006a6:	55                   	push   %ebp
  8006a7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006a9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006ad:	7e 1c                	jle    8006cb <getint+0x25>
		return va_arg(*ap, long long);
  8006af:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b2:	8b 00                	mov    (%eax),%eax
  8006b4:	8d 50 08             	lea    0x8(%eax),%edx
  8006b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ba:	89 10                	mov    %edx,(%eax)
  8006bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bf:	8b 00                	mov    (%eax),%eax
  8006c1:	83 e8 08             	sub    $0x8,%eax
  8006c4:	8b 50 04             	mov    0x4(%eax),%edx
  8006c7:	8b 00                	mov    (%eax),%eax
  8006c9:	eb 38                	jmp    800703 <getint+0x5d>
	else if (lflag)
  8006cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006cf:	74 1a                	je     8006eb <getint+0x45>
		return va_arg(*ap, long);
  8006d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d4:	8b 00                	mov    (%eax),%eax
  8006d6:	8d 50 04             	lea    0x4(%eax),%edx
  8006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dc:	89 10                	mov    %edx,(%eax)
  8006de:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e1:	8b 00                	mov    (%eax),%eax
  8006e3:	83 e8 04             	sub    $0x4,%eax
  8006e6:	8b 00                	mov    (%eax),%eax
  8006e8:	99                   	cltd   
  8006e9:	eb 18                	jmp    800703 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ee:	8b 00                	mov    (%eax),%eax
  8006f0:	8d 50 04             	lea    0x4(%eax),%edx
  8006f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f6:	89 10                	mov    %edx,(%eax)
  8006f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fb:	8b 00                	mov    (%eax),%eax
  8006fd:	83 e8 04             	sub    $0x4,%eax
  800700:	8b 00                	mov    (%eax),%eax
  800702:	99                   	cltd   
}
  800703:	5d                   	pop    %ebp
  800704:	c3                   	ret    

00800705 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800705:	55                   	push   %ebp
  800706:	89 e5                	mov    %esp,%ebp
  800708:	56                   	push   %esi
  800709:	53                   	push   %ebx
  80070a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80070d:	eb 17                	jmp    800726 <vprintfmt+0x21>
			if (ch == '\0')
  80070f:	85 db                	test   %ebx,%ebx
  800711:	0f 84 af 03 00 00    	je     800ac6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800717:	83 ec 08             	sub    $0x8,%esp
  80071a:	ff 75 0c             	pushl  0xc(%ebp)
  80071d:	53                   	push   %ebx
  80071e:	8b 45 08             	mov    0x8(%ebp),%eax
  800721:	ff d0                	call   *%eax
  800723:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800726:	8b 45 10             	mov    0x10(%ebp),%eax
  800729:	8d 50 01             	lea    0x1(%eax),%edx
  80072c:	89 55 10             	mov    %edx,0x10(%ebp)
  80072f:	8a 00                	mov    (%eax),%al
  800731:	0f b6 d8             	movzbl %al,%ebx
  800734:	83 fb 25             	cmp    $0x25,%ebx
  800737:	75 d6                	jne    80070f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800739:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80073d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800744:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80074b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800752:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800759:	8b 45 10             	mov    0x10(%ebp),%eax
  80075c:	8d 50 01             	lea    0x1(%eax),%edx
  80075f:	89 55 10             	mov    %edx,0x10(%ebp)
  800762:	8a 00                	mov    (%eax),%al
  800764:	0f b6 d8             	movzbl %al,%ebx
  800767:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80076a:	83 f8 55             	cmp    $0x55,%eax
  80076d:	0f 87 2b 03 00 00    	ja     800a9e <vprintfmt+0x399>
  800773:	8b 04 85 f8 21 80 00 	mov    0x8021f8(,%eax,4),%eax
  80077a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80077c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800780:	eb d7                	jmp    800759 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800782:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800786:	eb d1                	jmp    800759 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800788:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80078f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800792:	89 d0                	mov    %edx,%eax
  800794:	c1 e0 02             	shl    $0x2,%eax
  800797:	01 d0                	add    %edx,%eax
  800799:	01 c0                	add    %eax,%eax
  80079b:	01 d8                	add    %ebx,%eax
  80079d:	83 e8 30             	sub    $0x30,%eax
  8007a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a6:	8a 00                	mov    (%eax),%al
  8007a8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007ab:	83 fb 2f             	cmp    $0x2f,%ebx
  8007ae:	7e 3e                	jle    8007ee <vprintfmt+0xe9>
  8007b0:	83 fb 39             	cmp    $0x39,%ebx
  8007b3:	7f 39                	jg     8007ee <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007b5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007b8:	eb d5                	jmp    80078f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8007bd:	83 c0 04             	add    $0x4,%eax
  8007c0:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c6:	83 e8 04             	sub    $0x4,%eax
  8007c9:	8b 00                	mov    (%eax),%eax
  8007cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007ce:	eb 1f                	jmp    8007ef <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d4:	79 83                	jns    800759 <vprintfmt+0x54>
				width = 0;
  8007d6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007dd:	e9 77 ff ff ff       	jmp    800759 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007e2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007e9:	e9 6b ff ff ff       	jmp    800759 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007ee:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007ef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007f3:	0f 89 60 ff ff ff    	jns    800759 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007ff:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800806:	e9 4e ff ff ff       	jmp    800759 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80080b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80080e:	e9 46 ff ff ff       	jmp    800759 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800813:	8b 45 14             	mov    0x14(%ebp),%eax
  800816:	83 c0 04             	add    $0x4,%eax
  800819:	89 45 14             	mov    %eax,0x14(%ebp)
  80081c:	8b 45 14             	mov    0x14(%ebp),%eax
  80081f:	83 e8 04             	sub    $0x4,%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	83 ec 08             	sub    $0x8,%esp
  800827:	ff 75 0c             	pushl  0xc(%ebp)
  80082a:	50                   	push   %eax
  80082b:	8b 45 08             	mov    0x8(%ebp),%eax
  80082e:	ff d0                	call   *%eax
  800830:	83 c4 10             	add    $0x10,%esp
			break;
  800833:	e9 89 02 00 00       	jmp    800ac1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800838:	8b 45 14             	mov    0x14(%ebp),%eax
  80083b:	83 c0 04             	add    $0x4,%eax
  80083e:	89 45 14             	mov    %eax,0x14(%ebp)
  800841:	8b 45 14             	mov    0x14(%ebp),%eax
  800844:	83 e8 04             	sub    $0x4,%eax
  800847:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800849:	85 db                	test   %ebx,%ebx
  80084b:	79 02                	jns    80084f <vprintfmt+0x14a>
				err = -err;
  80084d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80084f:	83 fb 64             	cmp    $0x64,%ebx
  800852:	7f 0b                	jg     80085f <vprintfmt+0x15a>
  800854:	8b 34 9d 40 20 80 00 	mov    0x802040(,%ebx,4),%esi
  80085b:	85 f6                	test   %esi,%esi
  80085d:	75 19                	jne    800878 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80085f:	53                   	push   %ebx
  800860:	68 e5 21 80 00       	push   $0x8021e5
  800865:	ff 75 0c             	pushl  0xc(%ebp)
  800868:	ff 75 08             	pushl  0x8(%ebp)
  80086b:	e8 5e 02 00 00       	call   800ace <printfmt>
  800870:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800873:	e9 49 02 00 00       	jmp    800ac1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800878:	56                   	push   %esi
  800879:	68 ee 21 80 00       	push   $0x8021ee
  80087e:	ff 75 0c             	pushl  0xc(%ebp)
  800881:	ff 75 08             	pushl  0x8(%ebp)
  800884:	e8 45 02 00 00       	call   800ace <printfmt>
  800889:	83 c4 10             	add    $0x10,%esp
			break;
  80088c:	e9 30 02 00 00       	jmp    800ac1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800891:	8b 45 14             	mov    0x14(%ebp),%eax
  800894:	83 c0 04             	add    $0x4,%eax
  800897:	89 45 14             	mov    %eax,0x14(%ebp)
  80089a:	8b 45 14             	mov    0x14(%ebp),%eax
  80089d:	83 e8 04             	sub    $0x4,%eax
  8008a0:	8b 30                	mov    (%eax),%esi
  8008a2:	85 f6                	test   %esi,%esi
  8008a4:	75 05                	jne    8008ab <vprintfmt+0x1a6>
				p = "(null)";
  8008a6:	be f1 21 80 00       	mov    $0x8021f1,%esi
			if (width > 0 && padc != '-')
  8008ab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008af:	7e 6d                	jle    80091e <vprintfmt+0x219>
  8008b1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008b5:	74 67                	je     80091e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008ba:	83 ec 08             	sub    $0x8,%esp
  8008bd:	50                   	push   %eax
  8008be:	56                   	push   %esi
  8008bf:	e8 0c 03 00 00       	call   800bd0 <strnlen>
  8008c4:	83 c4 10             	add    $0x10,%esp
  8008c7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008ca:	eb 16                	jmp    8008e2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008cc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008d0:	83 ec 08             	sub    $0x8,%esp
  8008d3:	ff 75 0c             	pushl  0xc(%ebp)
  8008d6:	50                   	push   %eax
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	ff d0                	call   *%eax
  8008dc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008df:	ff 4d e4             	decl   -0x1c(%ebp)
  8008e2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008e6:	7f e4                	jg     8008cc <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008e8:	eb 34                	jmp    80091e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008ea:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008ee:	74 1c                	je     80090c <vprintfmt+0x207>
  8008f0:	83 fb 1f             	cmp    $0x1f,%ebx
  8008f3:	7e 05                	jle    8008fa <vprintfmt+0x1f5>
  8008f5:	83 fb 7e             	cmp    $0x7e,%ebx
  8008f8:	7e 12                	jle    80090c <vprintfmt+0x207>
					putch('?', putdat);
  8008fa:	83 ec 08             	sub    $0x8,%esp
  8008fd:	ff 75 0c             	pushl  0xc(%ebp)
  800900:	6a 3f                	push   $0x3f
  800902:	8b 45 08             	mov    0x8(%ebp),%eax
  800905:	ff d0                	call   *%eax
  800907:	83 c4 10             	add    $0x10,%esp
  80090a:	eb 0f                	jmp    80091b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80090c:	83 ec 08             	sub    $0x8,%esp
  80090f:	ff 75 0c             	pushl  0xc(%ebp)
  800912:	53                   	push   %ebx
  800913:	8b 45 08             	mov    0x8(%ebp),%eax
  800916:	ff d0                	call   *%eax
  800918:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80091b:	ff 4d e4             	decl   -0x1c(%ebp)
  80091e:	89 f0                	mov    %esi,%eax
  800920:	8d 70 01             	lea    0x1(%eax),%esi
  800923:	8a 00                	mov    (%eax),%al
  800925:	0f be d8             	movsbl %al,%ebx
  800928:	85 db                	test   %ebx,%ebx
  80092a:	74 24                	je     800950 <vprintfmt+0x24b>
  80092c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800930:	78 b8                	js     8008ea <vprintfmt+0x1e5>
  800932:	ff 4d e0             	decl   -0x20(%ebp)
  800935:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800939:	79 af                	jns    8008ea <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80093b:	eb 13                	jmp    800950 <vprintfmt+0x24b>
				putch(' ', putdat);
  80093d:	83 ec 08             	sub    $0x8,%esp
  800940:	ff 75 0c             	pushl  0xc(%ebp)
  800943:	6a 20                	push   $0x20
  800945:	8b 45 08             	mov    0x8(%ebp),%eax
  800948:	ff d0                	call   *%eax
  80094a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80094d:	ff 4d e4             	decl   -0x1c(%ebp)
  800950:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800954:	7f e7                	jg     80093d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800956:	e9 66 01 00 00       	jmp    800ac1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80095b:	83 ec 08             	sub    $0x8,%esp
  80095e:	ff 75 e8             	pushl  -0x18(%ebp)
  800961:	8d 45 14             	lea    0x14(%ebp),%eax
  800964:	50                   	push   %eax
  800965:	e8 3c fd ff ff       	call   8006a6 <getint>
  80096a:	83 c4 10             	add    $0x10,%esp
  80096d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800970:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800973:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800976:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800979:	85 d2                	test   %edx,%edx
  80097b:	79 23                	jns    8009a0 <vprintfmt+0x29b>
				putch('-', putdat);
  80097d:	83 ec 08             	sub    $0x8,%esp
  800980:	ff 75 0c             	pushl  0xc(%ebp)
  800983:	6a 2d                	push   $0x2d
  800985:	8b 45 08             	mov    0x8(%ebp),%eax
  800988:	ff d0                	call   *%eax
  80098a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80098d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800990:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800993:	f7 d8                	neg    %eax
  800995:	83 d2 00             	adc    $0x0,%edx
  800998:	f7 da                	neg    %edx
  80099a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009a0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a7:	e9 bc 00 00 00       	jmp    800a68 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009ac:	83 ec 08             	sub    $0x8,%esp
  8009af:	ff 75 e8             	pushl  -0x18(%ebp)
  8009b2:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b5:	50                   	push   %eax
  8009b6:	e8 84 fc ff ff       	call   80063f <getuint>
  8009bb:	83 c4 10             	add    $0x10,%esp
  8009be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009c4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009cb:	e9 98 00 00 00       	jmp    800a68 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009d0:	83 ec 08             	sub    $0x8,%esp
  8009d3:	ff 75 0c             	pushl  0xc(%ebp)
  8009d6:	6a 58                	push   $0x58
  8009d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009db:	ff d0                	call   *%eax
  8009dd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009e0:	83 ec 08             	sub    $0x8,%esp
  8009e3:	ff 75 0c             	pushl  0xc(%ebp)
  8009e6:	6a 58                	push   $0x58
  8009e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009eb:	ff d0                	call   *%eax
  8009ed:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009f0:	83 ec 08             	sub    $0x8,%esp
  8009f3:	ff 75 0c             	pushl  0xc(%ebp)
  8009f6:	6a 58                	push   $0x58
  8009f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fb:	ff d0                	call   *%eax
  8009fd:	83 c4 10             	add    $0x10,%esp
			break;
  800a00:	e9 bc 00 00 00       	jmp    800ac1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a05:	83 ec 08             	sub    $0x8,%esp
  800a08:	ff 75 0c             	pushl  0xc(%ebp)
  800a0b:	6a 30                	push   $0x30
  800a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a10:	ff d0                	call   *%eax
  800a12:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a15:	83 ec 08             	sub    $0x8,%esp
  800a18:	ff 75 0c             	pushl  0xc(%ebp)
  800a1b:	6a 78                	push   $0x78
  800a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a20:	ff d0                	call   *%eax
  800a22:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a25:	8b 45 14             	mov    0x14(%ebp),%eax
  800a28:	83 c0 04             	add    $0x4,%eax
  800a2b:	89 45 14             	mov    %eax,0x14(%ebp)
  800a2e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a31:	83 e8 04             	sub    $0x4,%eax
  800a34:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a36:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a40:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a47:	eb 1f                	jmp    800a68 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a49:	83 ec 08             	sub    $0x8,%esp
  800a4c:	ff 75 e8             	pushl  -0x18(%ebp)
  800a4f:	8d 45 14             	lea    0x14(%ebp),%eax
  800a52:	50                   	push   %eax
  800a53:	e8 e7 fb ff ff       	call   80063f <getuint>
  800a58:	83 c4 10             	add    $0x10,%esp
  800a5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a61:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a68:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a6f:	83 ec 04             	sub    $0x4,%esp
  800a72:	52                   	push   %edx
  800a73:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a76:	50                   	push   %eax
  800a77:	ff 75 f4             	pushl  -0xc(%ebp)
  800a7a:	ff 75 f0             	pushl  -0x10(%ebp)
  800a7d:	ff 75 0c             	pushl  0xc(%ebp)
  800a80:	ff 75 08             	pushl  0x8(%ebp)
  800a83:	e8 00 fb ff ff       	call   800588 <printnum>
  800a88:	83 c4 20             	add    $0x20,%esp
			break;
  800a8b:	eb 34                	jmp    800ac1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a8d:	83 ec 08             	sub    $0x8,%esp
  800a90:	ff 75 0c             	pushl  0xc(%ebp)
  800a93:	53                   	push   %ebx
  800a94:	8b 45 08             	mov    0x8(%ebp),%eax
  800a97:	ff d0                	call   *%eax
  800a99:	83 c4 10             	add    $0x10,%esp
			break;
  800a9c:	eb 23                	jmp    800ac1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a9e:	83 ec 08             	sub    $0x8,%esp
  800aa1:	ff 75 0c             	pushl  0xc(%ebp)
  800aa4:	6a 25                	push   $0x25
  800aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa9:	ff d0                	call   *%eax
  800aab:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800aae:	ff 4d 10             	decl   0x10(%ebp)
  800ab1:	eb 03                	jmp    800ab6 <vprintfmt+0x3b1>
  800ab3:	ff 4d 10             	decl   0x10(%ebp)
  800ab6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab9:	48                   	dec    %eax
  800aba:	8a 00                	mov    (%eax),%al
  800abc:	3c 25                	cmp    $0x25,%al
  800abe:	75 f3                	jne    800ab3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ac0:	90                   	nop
		}
	}
  800ac1:	e9 47 fc ff ff       	jmp    80070d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ac6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ac7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800aca:	5b                   	pop    %ebx
  800acb:	5e                   	pop    %esi
  800acc:	5d                   	pop    %ebp
  800acd:	c3                   	ret    

00800ace <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ace:	55                   	push   %ebp
  800acf:	89 e5                	mov    %esp,%ebp
  800ad1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ad4:	8d 45 10             	lea    0x10(%ebp),%eax
  800ad7:	83 c0 04             	add    $0x4,%eax
  800ada:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800add:	8b 45 10             	mov    0x10(%ebp),%eax
  800ae0:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae3:	50                   	push   %eax
  800ae4:	ff 75 0c             	pushl  0xc(%ebp)
  800ae7:	ff 75 08             	pushl  0x8(%ebp)
  800aea:	e8 16 fc ff ff       	call   800705 <vprintfmt>
  800aef:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800af2:	90                   	nop
  800af3:	c9                   	leave  
  800af4:	c3                   	ret    

00800af5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800af5:	55                   	push   %ebp
  800af6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800af8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afb:	8b 40 08             	mov    0x8(%eax),%eax
  800afe:	8d 50 01             	lea    0x1(%eax),%edx
  800b01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b04:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0a:	8b 10                	mov    (%eax),%edx
  800b0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0f:	8b 40 04             	mov    0x4(%eax),%eax
  800b12:	39 c2                	cmp    %eax,%edx
  800b14:	73 12                	jae    800b28 <sprintputch+0x33>
		*b->buf++ = ch;
  800b16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b19:	8b 00                	mov    (%eax),%eax
  800b1b:	8d 48 01             	lea    0x1(%eax),%ecx
  800b1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b21:	89 0a                	mov    %ecx,(%edx)
  800b23:	8b 55 08             	mov    0x8(%ebp),%edx
  800b26:	88 10                	mov    %dl,(%eax)
}
  800b28:	90                   	nop
  800b29:	5d                   	pop    %ebp
  800b2a:	c3                   	ret    

00800b2b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b2b:	55                   	push   %ebp
  800b2c:	89 e5                	mov    %esp,%ebp
  800b2e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	01 d0                	add    %edx,%eax
  800b42:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b45:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b4c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b50:	74 06                	je     800b58 <vsnprintf+0x2d>
  800b52:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b56:	7f 07                	jg     800b5f <vsnprintf+0x34>
		return -E_INVAL;
  800b58:	b8 03 00 00 00       	mov    $0x3,%eax
  800b5d:	eb 20                	jmp    800b7f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b5f:	ff 75 14             	pushl  0x14(%ebp)
  800b62:	ff 75 10             	pushl  0x10(%ebp)
  800b65:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b68:	50                   	push   %eax
  800b69:	68 f5 0a 80 00       	push   $0x800af5
  800b6e:	e8 92 fb ff ff       	call   800705 <vprintfmt>
  800b73:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b76:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b79:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b7f:	c9                   	leave  
  800b80:	c3                   	ret    

00800b81 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b81:	55                   	push   %ebp
  800b82:	89 e5                	mov    %esp,%ebp
  800b84:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b87:	8d 45 10             	lea    0x10(%ebp),%eax
  800b8a:	83 c0 04             	add    $0x4,%eax
  800b8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b90:	8b 45 10             	mov    0x10(%ebp),%eax
  800b93:	ff 75 f4             	pushl  -0xc(%ebp)
  800b96:	50                   	push   %eax
  800b97:	ff 75 0c             	pushl  0xc(%ebp)
  800b9a:	ff 75 08             	pushl  0x8(%ebp)
  800b9d:	e8 89 ff ff ff       	call   800b2b <vsnprintf>
  800ba2:	83 c4 10             	add    $0x10,%esp
  800ba5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ba8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bab:	c9                   	leave  
  800bac:	c3                   	ret    

00800bad <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bad:	55                   	push   %ebp
  800bae:	89 e5                	mov    %esp,%ebp
  800bb0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bb3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bba:	eb 06                	jmp    800bc2 <strlen+0x15>
		n++;
  800bbc:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bbf:	ff 45 08             	incl   0x8(%ebp)
  800bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc5:	8a 00                	mov    (%eax),%al
  800bc7:	84 c0                	test   %al,%al
  800bc9:	75 f1                	jne    800bbc <strlen+0xf>
		n++;
	return n;
  800bcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bce:	c9                   	leave  
  800bcf:	c3                   	ret    

00800bd0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bd0:	55                   	push   %ebp
  800bd1:	89 e5                	mov    %esp,%ebp
  800bd3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bd6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bdd:	eb 09                	jmp    800be8 <strnlen+0x18>
		n++;
  800bdf:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800be2:	ff 45 08             	incl   0x8(%ebp)
  800be5:	ff 4d 0c             	decl   0xc(%ebp)
  800be8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bec:	74 09                	je     800bf7 <strnlen+0x27>
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf1:	8a 00                	mov    (%eax),%al
  800bf3:	84 c0                	test   %al,%al
  800bf5:	75 e8                	jne    800bdf <strnlen+0xf>
		n++;
	return n;
  800bf7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bfa:	c9                   	leave  
  800bfb:	c3                   	ret    

00800bfc <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bfc:	55                   	push   %ebp
  800bfd:	89 e5                	mov    %esp,%ebp
  800bff:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c02:	8b 45 08             	mov    0x8(%ebp),%eax
  800c05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c08:	90                   	nop
  800c09:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0c:	8d 50 01             	lea    0x1(%eax),%edx
  800c0f:	89 55 08             	mov    %edx,0x8(%ebp)
  800c12:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c15:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c18:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c1b:	8a 12                	mov    (%edx),%dl
  800c1d:	88 10                	mov    %dl,(%eax)
  800c1f:	8a 00                	mov    (%eax),%al
  800c21:	84 c0                	test   %al,%al
  800c23:	75 e4                	jne    800c09 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c25:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c28:	c9                   	leave  
  800c29:	c3                   	ret    

00800c2a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c2a:	55                   	push   %ebp
  800c2b:	89 e5                	mov    %esp,%ebp
  800c2d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c30:	8b 45 08             	mov    0x8(%ebp),%eax
  800c33:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c36:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c3d:	eb 1f                	jmp    800c5e <strncpy+0x34>
		*dst++ = *src;
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	8d 50 01             	lea    0x1(%eax),%edx
  800c45:	89 55 08             	mov    %edx,0x8(%ebp)
  800c48:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c4b:	8a 12                	mov    (%edx),%dl
  800c4d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c52:	8a 00                	mov    (%eax),%al
  800c54:	84 c0                	test   %al,%al
  800c56:	74 03                	je     800c5b <strncpy+0x31>
			src++;
  800c58:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c5b:	ff 45 fc             	incl   -0x4(%ebp)
  800c5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c61:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c64:	72 d9                	jb     800c3f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c66:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c69:	c9                   	leave  
  800c6a:	c3                   	ret    

00800c6b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c6b:	55                   	push   %ebp
  800c6c:	89 e5                	mov    %esp,%ebp
  800c6e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c71:	8b 45 08             	mov    0x8(%ebp),%eax
  800c74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7b:	74 30                	je     800cad <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c7d:	eb 16                	jmp    800c95 <strlcpy+0x2a>
			*dst++ = *src++;
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	8d 50 01             	lea    0x1(%eax),%edx
  800c85:	89 55 08             	mov    %edx,0x8(%ebp)
  800c88:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c8b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c8e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c91:	8a 12                	mov    (%edx),%dl
  800c93:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c95:	ff 4d 10             	decl   0x10(%ebp)
  800c98:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9c:	74 09                	je     800ca7 <strlcpy+0x3c>
  800c9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca1:	8a 00                	mov    (%eax),%al
  800ca3:	84 c0                	test   %al,%al
  800ca5:	75 d8                	jne    800c7f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cad:	8b 55 08             	mov    0x8(%ebp),%edx
  800cb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb3:	29 c2                	sub    %eax,%edx
  800cb5:	89 d0                	mov    %edx,%eax
}
  800cb7:	c9                   	leave  
  800cb8:	c3                   	ret    

00800cb9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cb9:	55                   	push   %ebp
  800cba:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cbc:	eb 06                	jmp    800cc4 <strcmp+0xb>
		p++, q++;
  800cbe:	ff 45 08             	incl   0x8(%ebp)
  800cc1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc7:	8a 00                	mov    (%eax),%al
  800cc9:	84 c0                	test   %al,%al
  800ccb:	74 0e                	je     800cdb <strcmp+0x22>
  800ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd0:	8a 10                	mov    (%eax),%dl
  800cd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd5:	8a 00                	mov    (%eax),%al
  800cd7:	38 c2                	cmp    %al,%dl
  800cd9:	74 e3                	je     800cbe <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	8a 00                	mov    (%eax),%al
  800ce0:	0f b6 d0             	movzbl %al,%edx
  800ce3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce6:	8a 00                	mov    (%eax),%al
  800ce8:	0f b6 c0             	movzbl %al,%eax
  800ceb:	29 c2                	sub    %eax,%edx
  800ced:	89 d0                	mov    %edx,%eax
}
  800cef:	5d                   	pop    %ebp
  800cf0:	c3                   	ret    

00800cf1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cf1:	55                   	push   %ebp
  800cf2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cf4:	eb 09                	jmp    800cff <strncmp+0xe>
		n--, p++, q++;
  800cf6:	ff 4d 10             	decl   0x10(%ebp)
  800cf9:	ff 45 08             	incl   0x8(%ebp)
  800cfc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d03:	74 17                	je     800d1c <strncmp+0x2b>
  800d05:	8b 45 08             	mov    0x8(%ebp),%eax
  800d08:	8a 00                	mov    (%eax),%al
  800d0a:	84 c0                	test   %al,%al
  800d0c:	74 0e                	je     800d1c <strncmp+0x2b>
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	8a 10                	mov    (%eax),%dl
  800d13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	38 c2                	cmp    %al,%dl
  800d1a:	74 da                	je     800cf6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d1c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d20:	75 07                	jne    800d29 <strncmp+0x38>
		return 0;
  800d22:	b8 00 00 00 00       	mov    $0x0,%eax
  800d27:	eb 14                	jmp    800d3d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	0f b6 d0             	movzbl %al,%edx
  800d31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d34:	8a 00                	mov    (%eax),%al
  800d36:	0f b6 c0             	movzbl %al,%eax
  800d39:	29 c2                	sub    %eax,%edx
  800d3b:	89 d0                	mov    %edx,%eax
}
  800d3d:	5d                   	pop    %ebp
  800d3e:	c3                   	ret    

00800d3f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d3f:	55                   	push   %ebp
  800d40:	89 e5                	mov    %esp,%ebp
  800d42:	83 ec 04             	sub    $0x4,%esp
  800d45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d48:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d4b:	eb 12                	jmp    800d5f <strchr+0x20>
		if (*s == c)
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	8a 00                	mov    (%eax),%al
  800d52:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d55:	75 05                	jne    800d5c <strchr+0x1d>
			return (char *) s;
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	eb 11                	jmp    800d6d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d5c:	ff 45 08             	incl   0x8(%ebp)
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	84 c0                	test   %al,%al
  800d66:	75 e5                	jne    800d4d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d68:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d6d:	c9                   	leave  
  800d6e:	c3                   	ret    

00800d6f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d6f:	55                   	push   %ebp
  800d70:	89 e5                	mov    %esp,%ebp
  800d72:	83 ec 04             	sub    $0x4,%esp
  800d75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d78:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d7b:	eb 0d                	jmp    800d8a <strfind+0x1b>
		if (*s == c)
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	8a 00                	mov    (%eax),%al
  800d82:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d85:	74 0e                	je     800d95 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d87:	ff 45 08             	incl   0x8(%ebp)
  800d8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8d:	8a 00                	mov    (%eax),%al
  800d8f:	84 c0                	test   %al,%al
  800d91:	75 ea                	jne    800d7d <strfind+0xe>
  800d93:	eb 01                	jmp    800d96 <strfind+0x27>
		if (*s == c)
			break;
  800d95:	90                   	nop
	return (char *) s;
  800d96:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d99:	c9                   	leave  
  800d9a:	c3                   	ret    

00800d9b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d9b:	55                   	push   %ebp
  800d9c:	89 e5                	mov    %esp,%ebp
  800d9e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800da1:	8b 45 08             	mov    0x8(%ebp),%eax
  800da4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800da7:	8b 45 10             	mov    0x10(%ebp),%eax
  800daa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dad:	eb 0e                	jmp    800dbd <memset+0x22>
		*p++ = c;
  800daf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db2:	8d 50 01             	lea    0x1(%eax),%edx
  800db5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800db8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dbb:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dbd:	ff 4d f8             	decl   -0x8(%ebp)
  800dc0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dc4:	79 e9                	jns    800daf <memset+0x14>
		*p++ = c;

	return v;
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dc9:	c9                   	leave  
  800dca:	c3                   	ret    

00800dcb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dcb:	55                   	push   %ebp
  800dcc:	89 e5                	mov    %esp,%ebp
  800dce:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dda:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ddd:	eb 16                	jmp    800df5 <memcpy+0x2a>
		*d++ = *s++;
  800ddf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de2:	8d 50 01             	lea    0x1(%eax),%edx
  800de5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800deb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dee:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800df1:	8a 12                	mov    (%edx),%dl
  800df3:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800df5:	8b 45 10             	mov    0x10(%ebp),%eax
  800df8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dfb:	89 55 10             	mov    %edx,0x10(%ebp)
  800dfe:	85 c0                	test   %eax,%eax
  800e00:	75 dd                	jne    800ddf <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e02:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e05:	c9                   	leave  
  800e06:	c3                   	ret    

00800e07 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e07:	55                   	push   %ebp
  800e08:	89 e5                	mov    %esp,%ebp
  800e0a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e10:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e19:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e1f:	73 50                	jae    800e71 <memmove+0x6a>
  800e21:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e24:	8b 45 10             	mov    0x10(%ebp),%eax
  800e27:	01 d0                	add    %edx,%eax
  800e29:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e2c:	76 43                	jbe    800e71 <memmove+0x6a>
		s += n;
  800e2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e31:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e34:	8b 45 10             	mov    0x10(%ebp),%eax
  800e37:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e3a:	eb 10                	jmp    800e4c <memmove+0x45>
			*--d = *--s;
  800e3c:	ff 4d f8             	decl   -0x8(%ebp)
  800e3f:	ff 4d fc             	decl   -0x4(%ebp)
  800e42:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e45:	8a 10                	mov    (%eax),%dl
  800e47:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e4a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e52:	89 55 10             	mov    %edx,0x10(%ebp)
  800e55:	85 c0                	test   %eax,%eax
  800e57:	75 e3                	jne    800e3c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e59:	eb 23                	jmp    800e7e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5e:	8d 50 01             	lea    0x1(%eax),%edx
  800e61:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e64:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e67:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e6a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e6d:	8a 12                	mov    (%edx),%dl
  800e6f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e71:	8b 45 10             	mov    0x10(%ebp),%eax
  800e74:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e77:	89 55 10             	mov    %edx,0x10(%ebp)
  800e7a:	85 c0                	test   %eax,%eax
  800e7c:	75 dd                	jne    800e5b <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e81:	c9                   	leave  
  800e82:	c3                   	ret    

00800e83 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e83:	55                   	push   %ebp
  800e84:	89 e5                	mov    %esp,%ebp
  800e86:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e92:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e95:	eb 2a                	jmp    800ec1 <memcmp+0x3e>
		if (*s1 != *s2)
  800e97:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e9a:	8a 10                	mov    (%eax),%dl
  800e9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9f:	8a 00                	mov    (%eax),%al
  800ea1:	38 c2                	cmp    %al,%dl
  800ea3:	74 16                	je     800ebb <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ea5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea8:	8a 00                	mov    (%eax),%al
  800eaa:	0f b6 d0             	movzbl %al,%edx
  800ead:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eb0:	8a 00                	mov    (%eax),%al
  800eb2:	0f b6 c0             	movzbl %al,%eax
  800eb5:	29 c2                	sub    %eax,%edx
  800eb7:	89 d0                	mov    %edx,%eax
  800eb9:	eb 18                	jmp    800ed3 <memcmp+0x50>
		s1++, s2++;
  800ebb:	ff 45 fc             	incl   -0x4(%ebp)
  800ebe:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ec1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec7:	89 55 10             	mov    %edx,0x10(%ebp)
  800eca:	85 c0                	test   %eax,%eax
  800ecc:	75 c9                	jne    800e97 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ece:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed3:	c9                   	leave  
  800ed4:	c3                   	ret    

00800ed5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ed5:	55                   	push   %ebp
  800ed6:	89 e5                	mov    %esp,%ebp
  800ed8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800edb:	8b 55 08             	mov    0x8(%ebp),%edx
  800ede:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee1:	01 d0                	add    %edx,%eax
  800ee3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ee6:	eb 15                	jmp    800efd <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eeb:	8a 00                	mov    (%eax),%al
  800eed:	0f b6 d0             	movzbl %al,%edx
  800ef0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef3:	0f b6 c0             	movzbl %al,%eax
  800ef6:	39 c2                	cmp    %eax,%edx
  800ef8:	74 0d                	je     800f07 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800efa:	ff 45 08             	incl   0x8(%ebp)
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f03:	72 e3                	jb     800ee8 <memfind+0x13>
  800f05:	eb 01                	jmp    800f08 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f07:	90                   	nop
	return (void *) s;
  800f08:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f0b:	c9                   	leave  
  800f0c:	c3                   	ret    

00800f0d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f0d:	55                   	push   %ebp
  800f0e:	89 e5                	mov    %esp,%ebp
  800f10:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f1a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f21:	eb 03                	jmp    800f26 <strtol+0x19>
		s++;
  800f23:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	8a 00                	mov    (%eax),%al
  800f2b:	3c 20                	cmp    $0x20,%al
  800f2d:	74 f4                	je     800f23 <strtol+0x16>
  800f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f32:	8a 00                	mov    (%eax),%al
  800f34:	3c 09                	cmp    $0x9,%al
  800f36:	74 eb                	je     800f23 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	8a 00                	mov    (%eax),%al
  800f3d:	3c 2b                	cmp    $0x2b,%al
  800f3f:	75 05                	jne    800f46 <strtol+0x39>
		s++;
  800f41:	ff 45 08             	incl   0x8(%ebp)
  800f44:	eb 13                	jmp    800f59 <strtol+0x4c>
	else if (*s == '-')
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	8a 00                	mov    (%eax),%al
  800f4b:	3c 2d                	cmp    $0x2d,%al
  800f4d:	75 0a                	jne    800f59 <strtol+0x4c>
		s++, neg = 1;
  800f4f:	ff 45 08             	incl   0x8(%ebp)
  800f52:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f59:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5d:	74 06                	je     800f65 <strtol+0x58>
  800f5f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f63:	75 20                	jne    800f85 <strtol+0x78>
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	3c 30                	cmp    $0x30,%al
  800f6c:	75 17                	jne    800f85 <strtol+0x78>
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	40                   	inc    %eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	3c 78                	cmp    $0x78,%al
  800f76:	75 0d                	jne    800f85 <strtol+0x78>
		s += 2, base = 16;
  800f78:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f7c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f83:	eb 28                	jmp    800fad <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f85:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f89:	75 15                	jne    800fa0 <strtol+0x93>
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	3c 30                	cmp    $0x30,%al
  800f92:	75 0c                	jne    800fa0 <strtol+0x93>
		s++, base = 8;
  800f94:	ff 45 08             	incl   0x8(%ebp)
  800f97:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f9e:	eb 0d                	jmp    800fad <strtol+0xa0>
	else if (base == 0)
  800fa0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa4:	75 07                	jne    800fad <strtol+0xa0>
		base = 10;
  800fa6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fad:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb0:	8a 00                	mov    (%eax),%al
  800fb2:	3c 2f                	cmp    $0x2f,%al
  800fb4:	7e 19                	jle    800fcf <strtol+0xc2>
  800fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb9:	8a 00                	mov    (%eax),%al
  800fbb:	3c 39                	cmp    $0x39,%al
  800fbd:	7f 10                	jg     800fcf <strtol+0xc2>
			dig = *s - '0';
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc2:	8a 00                	mov    (%eax),%al
  800fc4:	0f be c0             	movsbl %al,%eax
  800fc7:	83 e8 30             	sub    $0x30,%eax
  800fca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fcd:	eb 42                	jmp    801011 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	8a 00                	mov    (%eax),%al
  800fd4:	3c 60                	cmp    $0x60,%al
  800fd6:	7e 19                	jle    800ff1 <strtol+0xe4>
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	8a 00                	mov    (%eax),%al
  800fdd:	3c 7a                	cmp    $0x7a,%al
  800fdf:	7f 10                	jg     800ff1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe4:	8a 00                	mov    (%eax),%al
  800fe6:	0f be c0             	movsbl %al,%eax
  800fe9:	83 e8 57             	sub    $0x57,%eax
  800fec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fef:	eb 20                	jmp    801011 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff4:	8a 00                	mov    (%eax),%al
  800ff6:	3c 40                	cmp    $0x40,%al
  800ff8:	7e 39                	jle    801033 <strtol+0x126>
  800ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	3c 5a                	cmp    $0x5a,%al
  801001:	7f 30                	jg     801033 <strtol+0x126>
			dig = *s - 'A' + 10;
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	8a 00                	mov    (%eax),%al
  801008:	0f be c0             	movsbl %al,%eax
  80100b:	83 e8 37             	sub    $0x37,%eax
  80100e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801011:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801014:	3b 45 10             	cmp    0x10(%ebp),%eax
  801017:	7d 19                	jge    801032 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801019:	ff 45 08             	incl   0x8(%ebp)
  80101c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801023:	89 c2                	mov    %eax,%edx
  801025:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801028:	01 d0                	add    %edx,%eax
  80102a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80102d:	e9 7b ff ff ff       	jmp    800fad <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801032:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801033:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801037:	74 08                	je     801041 <strtol+0x134>
		*endptr = (char *) s;
  801039:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103c:	8b 55 08             	mov    0x8(%ebp),%edx
  80103f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801041:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801045:	74 07                	je     80104e <strtol+0x141>
  801047:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104a:	f7 d8                	neg    %eax
  80104c:	eb 03                	jmp    801051 <strtol+0x144>
  80104e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801051:	c9                   	leave  
  801052:	c3                   	ret    

00801053 <ltostr>:

void
ltostr(long value, char *str)
{
  801053:	55                   	push   %ebp
  801054:	89 e5                	mov    %esp,%ebp
  801056:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801059:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801060:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801067:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80106b:	79 13                	jns    801080 <ltostr+0x2d>
	{
		neg = 1;
  80106d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801074:	8b 45 0c             	mov    0xc(%ebp),%eax
  801077:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80107a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80107d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801088:	99                   	cltd   
  801089:	f7 f9                	idiv   %ecx
  80108b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80108e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801091:	8d 50 01             	lea    0x1(%eax),%edx
  801094:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801097:	89 c2                	mov    %eax,%edx
  801099:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109c:	01 d0                	add    %edx,%eax
  80109e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010a1:	83 c2 30             	add    $0x30,%edx
  8010a4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010a9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010ae:	f7 e9                	imul   %ecx
  8010b0:	c1 fa 02             	sar    $0x2,%edx
  8010b3:	89 c8                	mov    %ecx,%eax
  8010b5:	c1 f8 1f             	sar    $0x1f,%eax
  8010b8:	29 c2                	sub    %eax,%edx
  8010ba:	89 d0                	mov    %edx,%eax
  8010bc:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010c2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010c7:	f7 e9                	imul   %ecx
  8010c9:	c1 fa 02             	sar    $0x2,%edx
  8010cc:	89 c8                	mov    %ecx,%eax
  8010ce:	c1 f8 1f             	sar    $0x1f,%eax
  8010d1:	29 c2                	sub    %eax,%edx
  8010d3:	89 d0                	mov    %edx,%eax
  8010d5:	c1 e0 02             	shl    $0x2,%eax
  8010d8:	01 d0                	add    %edx,%eax
  8010da:	01 c0                	add    %eax,%eax
  8010dc:	29 c1                	sub    %eax,%ecx
  8010de:	89 ca                	mov    %ecx,%edx
  8010e0:	85 d2                	test   %edx,%edx
  8010e2:	75 9c                	jne    801080 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ee:	48                   	dec    %eax
  8010ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010f2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010f6:	74 3d                	je     801135 <ltostr+0xe2>
		start = 1 ;
  8010f8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010ff:	eb 34                	jmp    801135 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801101:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801104:	8b 45 0c             	mov    0xc(%ebp),%eax
  801107:	01 d0                	add    %edx,%eax
  801109:	8a 00                	mov    (%eax),%al
  80110b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80110e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801111:	8b 45 0c             	mov    0xc(%ebp),%eax
  801114:	01 c2                	add    %eax,%edx
  801116:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801119:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111c:	01 c8                	add    %ecx,%eax
  80111e:	8a 00                	mov    (%eax),%al
  801120:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801122:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801125:	8b 45 0c             	mov    0xc(%ebp),%eax
  801128:	01 c2                	add    %eax,%edx
  80112a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80112d:	88 02                	mov    %al,(%edx)
		start++ ;
  80112f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801132:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801135:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801138:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80113b:	7c c4                	jl     801101 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80113d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801140:	8b 45 0c             	mov    0xc(%ebp),%eax
  801143:	01 d0                	add    %edx,%eax
  801145:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801148:	90                   	nop
  801149:	c9                   	leave  
  80114a:	c3                   	ret    

0080114b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80114b:	55                   	push   %ebp
  80114c:	89 e5                	mov    %esp,%ebp
  80114e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801151:	ff 75 08             	pushl  0x8(%ebp)
  801154:	e8 54 fa ff ff       	call   800bad <strlen>
  801159:	83 c4 04             	add    $0x4,%esp
  80115c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80115f:	ff 75 0c             	pushl  0xc(%ebp)
  801162:	e8 46 fa ff ff       	call   800bad <strlen>
  801167:	83 c4 04             	add    $0x4,%esp
  80116a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80116d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801174:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80117b:	eb 17                	jmp    801194 <strcconcat+0x49>
		final[s] = str1[s] ;
  80117d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801180:	8b 45 10             	mov    0x10(%ebp),%eax
  801183:	01 c2                	add    %eax,%edx
  801185:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	01 c8                	add    %ecx,%eax
  80118d:	8a 00                	mov    (%eax),%al
  80118f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801191:	ff 45 fc             	incl   -0x4(%ebp)
  801194:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801197:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80119a:	7c e1                	jl     80117d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80119c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011a3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011aa:	eb 1f                	jmp    8011cb <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011af:	8d 50 01             	lea    0x1(%eax),%edx
  8011b2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011b5:	89 c2                	mov    %eax,%edx
  8011b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ba:	01 c2                	add    %eax,%edx
  8011bc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c2:	01 c8                	add    %ecx,%eax
  8011c4:	8a 00                	mov    (%eax),%al
  8011c6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011c8:	ff 45 f8             	incl   -0x8(%ebp)
  8011cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011d1:	7c d9                	jl     8011ac <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d9:	01 d0                	add    %edx,%eax
  8011db:	c6 00 00             	movb   $0x0,(%eax)
}
  8011de:	90                   	nop
  8011df:	c9                   	leave  
  8011e0:	c3                   	ret    

008011e1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011e1:	55                   	push   %ebp
  8011e2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f0:	8b 00                	mov    (%eax),%eax
  8011f2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fc:	01 d0                	add    %edx,%eax
  8011fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801204:	eb 0c                	jmp    801212 <strsplit+0x31>
			*string++ = 0;
  801206:	8b 45 08             	mov    0x8(%ebp),%eax
  801209:	8d 50 01             	lea    0x1(%eax),%edx
  80120c:	89 55 08             	mov    %edx,0x8(%ebp)
  80120f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801212:	8b 45 08             	mov    0x8(%ebp),%eax
  801215:	8a 00                	mov    (%eax),%al
  801217:	84 c0                	test   %al,%al
  801219:	74 18                	je     801233 <strsplit+0x52>
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	8a 00                	mov    (%eax),%al
  801220:	0f be c0             	movsbl %al,%eax
  801223:	50                   	push   %eax
  801224:	ff 75 0c             	pushl  0xc(%ebp)
  801227:	e8 13 fb ff ff       	call   800d3f <strchr>
  80122c:	83 c4 08             	add    $0x8,%esp
  80122f:	85 c0                	test   %eax,%eax
  801231:	75 d3                	jne    801206 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801233:	8b 45 08             	mov    0x8(%ebp),%eax
  801236:	8a 00                	mov    (%eax),%al
  801238:	84 c0                	test   %al,%al
  80123a:	74 5a                	je     801296 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80123c:	8b 45 14             	mov    0x14(%ebp),%eax
  80123f:	8b 00                	mov    (%eax),%eax
  801241:	83 f8 0f             	cmp    $0xf,%eax
  801244:	75 07                	jne    80124d <strsplit+0x6c>
		{
			return 0;
  801246:	b8 00 00 00 00       	mov    $0x0,%eax
  80124b:	eb 66                	jmp    8012b3 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80124d:	8b 45 14             	mov    0x14(%ebp),%eax
  801250:	8b 00                	mov    (%eax),%eax
  801252:	8d 48 01             	lea    0x1(%eax),%ecx
  801255:	8b 55 14             	mov    0x14(%ebp),%edx
  801258:	89 0a                	mov    %ecx,(%edx)
  80125a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801261:	8b 45 10             	mov    0x10(%ebp),%eax
  801264:	01 c2                	add    %eax,%edx
  801266:	8b 45 08             	mov    0x8(%ebp),%eax
  801269:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80126b:	eb 03                	jmp    801270 <strsplit+0x8f>
			string++;
  80126d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801270:	8b 45 08             	mov    0x8(%ebp),%eax
  801273:	8a 00                	mov    (%eax),%al
  801275:	84 c0                	test   %al,%al
  801277:	74 8b                	je     801204 <strsplit+0x23>
  801279:	8b 45 08             	mov    0x8(%ebp),%eax
  80127c:	8a 00                	mov    (%eax),%al
  80127e:	0f be c0             	movsbl %al,%eax
  801281:	50                   	push   %eax
  801282:	ff 75 0c             	pushl  0xc(%ebp)
  801285:	e8 b5 fa ff ff       	call   800d3f <strchr>
  80128a:	83 c4 08             	add    $0x8,%esp
  80128d:	85 c0                	test   %eax,%eax
  80128f:	74 dc                	je     80126d <strsplit+0x8c>
			string++;
	}
  801291:	e9 6e ff ff ff       	jmp    801204 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801296:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801297:	8b 45 14             	mov    0x14(%ebp),%eax
  80129a:	8b 00                	mov    (%eax),%eax
  80129c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a6:	01 d0                	add    %edx,%eax
  8012a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012ae:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012b3:	c9                   	leave  
  8012b4:	c3                   	ret    

008012b5 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012b5:	55                   	push   %ebp
  8012b6:	89 e5                	mov    %esp,%ebp
  8012b8:	57                   	push   %edi
  8012b9:	56                   	push   %esi
  8012ba:	53                   	push   %ebx
  8012bb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012be:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012c7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012ca:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012cd:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012d0:	cd 30                	int    $0x30
  8012d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012d8:	83 c4 10             	add    $0x10,%esp
  8012db:	5b                   	pop    %ebx
  8012dc:	5e                   	pop    %esi
  8012dd:	5f                   	pop    %edi
  8012de:	5d                   	pop    %ebp
  8012df:	c3                   	ret    

008012e0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
  8012e3:	83 ec 04             	sub    $0x4,%esp
  8012e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012ec:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 00                	push   $0x0
  8012f7:	52                   	push   %edx
  8012f8:	ff 75 0c             	pushl  0xc(%ebp)
  8012fb:	50                   	push   %eax
  8012fc:	6a 00                	push   $0x0
  8012fe:	e8 b2 ff ff ff       	call   8012b5 <syscall>
  801303:	83 c4 18             	add    $0x18,%esp
}
  801306:	90                   	nop
  801307:	c9                   	leave  
  801308:	c3                   	ret    

00801309 <sys_cgetc>:

int
sys_cgetc(void)
{
  801309:	55                   	push   %ebp
  80130a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	6a 00                	push   $0x0
  801314:	6a 00                	push   $0x0
  801316:	6a 01                	push   $0x1
  801318:	e8 98 ff ff ff       	call   8012b5 <syscall>
  80131d:	83 c4 18             	add    $0x18,%esp
}
  801320:	c9                   	leave  
  801321:	c3                   	ret    

00801322 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801322:	55                   	push   %ebp
  801323:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801325:	8b 45 08             	mov    0x8(%ebp),%eax
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	50                   	push   %eax
  801331:	6a 05                	push   $0x5
  801333:	e8 7d ff ff ff       	call   8012b5 <syscall>
  801338:	83 c4 18             	add    $0x18,%esp
}
  80133b:	c9                   	leave  
  80133c:	c3                   	ret    

0080133d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80133d:	55                   	push   %ebp
  80133e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801340:	6a 00                	push   $0x0
  801342:	6a 00                	push   $0x0
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	6a 00                	push   $0x0
  80134a:	6a 02                	push   $0x2
  80134c:	e8 64 ff ff ff       	call   8012b5 <syscall>
  801351:	83 c4 18             	add    $0x18,%esp
}
  801354:	c9                   	leave  
  801355:	c3                   	ret    

00801356 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801356:	55                   	push   %ebp
  801357:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801359:	6a 00                	push   $0x0
  80135b:	6a 00                	push   $0x0
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 03                	push   $0x3
  801365:	e8 4b ff ff ff       	call   8012b5 <syscall>
  80136a:	83 c4 18             	add    $0x18,%esp
}
  80136d:	c9                   	leave  
  80136e:	c3                   	ret    

0080136f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80136f:	55                   	push   %ebp
  801370:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801372:	6a 00                	push   $0x0
  801374:	6a 00                	push   $0x0
  801376:	6a 00                	push   $0x0
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	6a 04                	push   $0x4
  80137e:	e8 32 ff ff ff       	call   8012b5 <syscall>
  801383:	83 c4 18             	add    $0x18,%esp
}
  801386:	c9                   	leave  
  801387:	c3                   	ret    

00801388 <sys_env_exit>:


void sys_env_exit(void)
{
  801388:	55                   	push   %ebp
  801389:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80138b:	6a 00                	push   $0x0
  80138d:	6a 00                	push   $0x0
  80138f:	6a 00                	push   $0x0
  801391:	6a 00                	push   $0x0
  801393:	6a 00                	push   $0x0
  801395:	6a 06                	push   $0x6
  801397:	e8 19 ff ff ff       	call   8012b5 <syscall>
  80139c:	83 c4 18             	add    $0x18,%esp
}
  80139f:	90                   	nop
  8013a0:	c9                   	leave  
  8013a1:	c3                   	ret    

008013a2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8013a2:	55                   	push   %ebp
  8013a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8013a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ab:	6a 00                	push   $0x0
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	52                   	push   %edx
  8013b2:	50                   	push   %eax
  8013b3:	6a 07                	push   $0x7
  8013b5:	e8 fb fe ff ff       	call   8012b5 <syscall>
  8013ba:	83 c4 18             	add    $0x18,%esp
}
  8013bd:	c9                   	leave  
  8013be:	c3                   	ret    

008013bf <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013bf:	55                   	push   %ebp
  8013c0:	89 e5                	mov    %esp,%ebp
  8013c2:	56                   	push   %esi
  8013c3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013c4:	8b 75 18             	mov    0x18(%ebp),%esi
  8013c7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d3:	56                   	push   %esi
  8013d4:	53                   	push   %ebx
  8013d5:	51                   	push   %ecx
  8013d6:	52                   	push   %edx
  8013d7:	50                   	push   %eax
  8013d8:	6a 08                	push   $0x8
  8013da:	e8 d6 fe ff ff       	call   8012b5 <syscall>
  8013df:	83 c4 18             	add    $0x18,%esp
}
  8013e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013e5:	5b                   	pop    %ebx
  8013e6:	5e                   	pop    %esi
  8013e7:	5d                   	pop    %ebp
  8013e8:	c3                   	ret    

008013e9 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	52                   	push   %edx
  8013f9:	50                   	push   %eax
  8013fa:	6a 09                	push   $0x9
  8013fc:	e8 b4 fe ff ff       	call   8012b5 <syscall>
  801401:	83 c4 18             	add    $0x18,%esp
}
  801404:	c9                   	leave  
  801405:	c3                   	ret    

00801406 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801406:	55                   	push   %ebp
  801407:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	ff 75 0c             	pushl  0xc(%ebp)
  801412:	ff 75 08             	pushl  0x8(%ebp)
  801415:	6a 0a                	push   $0xa
  801417:	e8 99 fe ff ff       	call   8012b5 <syscall>
  80141c:	83 c4 18             	add    $0x18,%esp
}
  80141f:	c9                   	leave  
  801420:	c3                   	ret    

00801421 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 0b                	push   $0xb
  801430:	e8 80 fe ff ff       	call   8012b5 <syscall>
  801435:	83 c4 18             	add    $0x18,%esp
}
  801438:	c9                   	leave  
  801439:	c3                   	ret    

0080143a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80143a:	55                   	push   %ebp
  80143b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	6a 0c                	push   $0xc
  801449:	e8 67 fe ff ff       	call   8012b5 <syscall>
  80144e:	83 c4 18             	add    $0x18,%esp
}
  801451:	c9                   	leave  
  801452:	c3                   	ret    

00801453 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801453:	55                   	push   %ebp
  801454:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 0d                	push   $0xd
  801462:	e8 4e fe ff ff       	call   8012b5 <syscall>
  801467:	83 c4 18             	add    $0x18,%esp
}
  80146a:	c9                   	leave  
  80146b:	c3                   	ret    

0080146c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	ff 75 0c             	pushl  0xc(%ebp)
  801478:	ff 75 08             	pushl  0x8(%ebp)
  80147b:	6a 11                	push   $0x11
  80147d:	e8 33 fe ff ff       	call   8012b5 <syscall>
  801482:	83 c4 18             	add    $0x18,%esp
	return;
  801485:	90                   	nop
}
  801486:	c9                   	leave  
  801487:	c3                   	ret    

00801488 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801488:	55                   	push   %ebp
  801489:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	ff 75 0c             	pushl  0xc(%ebp)
  801494:	ff 75 08             	pushl  0x8(%ebp)
  801497:	6a 12                	push   $0x12
  801499:	e8 17 fe ff ff       	call   8012b5 <syscall>
  80149e:	83 c4 18             	add    $0x18,%esp
	return ;
  8014a1:	90                   	nop
}
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 0e                	push   $0xe
  8014b3:	e8 fd fd ff ff       	call   8012b5 <syscall>
  8014b8:	83 c4 18             	add    $0x18,%esp
}
  8014bb:	c9                   	leave  
  8014bc:	c3                   	ret    

008014bd <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8014bd:	55                   	push   %ebp
  8014be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	ff 75 08             	pushl  0x8(%ebp)
  8014cb:	6a 0f                	push   $0xf
  8014cd:	e8 e3 fd ff ff       	call   8012b5 <syscall>
  8014d2:	83 c4 18             	add    $0x18,%esp
}
  8014d5:	c9                   	leave  
  8014d6:	c3                   	ret    

008014d7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014d7:	55                   	push   %ebp
  8014d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 10                	push   $0x10
  8014e6:	e8 ca fd ff ff       	call   8012b5 <syscall>
  8014eb:	83 c4 18             	add    $0x18,%esp
}
  8014ee:	90                   	nop
  8014ef:	c9                   	leave  
  8014f0:	c3                   	ret    

008014f1 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 14                	push   $0x14
  801500:	e8 b0 fd ff ff       	call   8012b5 <syscall>
  801505:	83 c4 18             	add    $0x18,%esp
}
  801508:	90                   	nop
  801509:	c9                   	leave  
  80150a:	c3                   	ret    

0080150b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80150b:	55                   	push   %ebp
  80150c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 15                	push   $0x15
  80151a:	e8 96 fd ff ff       	call   8012b5 <syscall>
  80151f:	83 c4 18             	add    $0x18,%esp
}
  801522:	90                   	nop
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <sys_cputc>:


void
sys_cputc(const char c)
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
  801528:	83 ec 04             	sub    $0x4,%esp
  80152b:	8b 45 08             	mov    0x8(%ebp),%eax
  80152e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801531:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	50                   	push   %eax
  80153e:	6a 16                	push   $0x16
  801540:	e8 70 fd ff ff       	call   8012b5 <syscall>
  801545:	83 c4 18             	add    $0x18,%esp
}
  801548:	90                   	nop
  801549:	c9                   	leave  
  80154a:	c3                   	ret    

0080154b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80154b:	55                   	push   %ebp
  80154c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 17                	push   $0x17
  80155a:	e8 56 fd ff ff       	call   8012b5 <syscall>
  80155f:	83 c4 18             	add    $0x18,%esp
}
  801562:	90                   	nop
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	ff 75 0c             	pushl  0xc(%ebp)
  801574:	50                   	push   %eax
  801575:	6a 18                	push   $0x18
  801577:	e8 39 fd ff ff       	call   8012b5 <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801584:	8b 55 0c             	mov    0xc(%ebp),%edx
  801587:	8b 45 08             	mov    0x8(%ebp),%eax
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	52                   	push   %edx
  801591:	50                   	push   %eax
  801592:	6a 1b                	push   $0x1b
  801594:	e8 1c fd ff ff       	call   8012b5 <syscall>
  801599:	83 c4 18             	add    $0x18,%esp
}
  80159c:	c9                   	leave  
  80159d:	c3                   	ret    

0080159e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80159e:	55                   	push   %ebp
  80159f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	52                   	push   %edx
  8015ae:	50                   	push   %eax
  8015af:	6a 19                	push   $0x19
  8015b1:	e8 ff fc ff ff       	call   8012b5 <syscall>
  8015b6:	83 c4 18             	add    $0x18,%esp
}
  8015b9:	90                   	nop
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	52                   	push   %edx
  8015cc:	50                   	push   %eax
  8015cd:	6a 1a                	push   $0x1a
  8015cf:	e8 e1 fc ff ff       	call   8012b5 <syscall>
  8015d4:	83 c4 18             	add    $0x18,%esp
}
  8015d7:	90                   	nop
  8015d8:	c9                   	leave  
  8015d9:	c3                   	ret    

008015da <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
  8015dd:	83 ec 04             	sub    $0x4,%esp
  8015e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015e6:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015e9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	6a 00                	push   $0x0
  8015f2:	51                   	push   %ecx
  8015f3:	52                   	push   %edx
  8015f4:	ff 75 0c             	pushl  0xc(%ebp)
  8015f7:	50                   	push   %eax
  8015f8:	6a 1c                	push   $0x1c
  8015fa:	e8 b6 fc ff ff       	call   8012b5 <syscall>
  8015ff:	83 c4 18             	add    $0x18,%esp
}
  801602:	c9                   	leave  
  801603:	c3                   	ret    

00801604 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801604:	55                   	push   %ebp
  801605:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801607:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160a:	8b 45 08             	mov    0x8(%ebp),%eax
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	52                   	push   %edx
  801614:	50                   	push   %eax
  801615:	6a 1d                	push   $0x1d
  801617:	e8 99 fc ff ff       	call   8012b5 <syscall>
  80161c:	83 c4 18             	add    $0x18,%esp
}
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801624:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801627:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	51                   	push   %ecx
  801632:	52                   	push   %edx
  801633:	50                   	push   %eax
  801634:	6a 1e                	push   $0x1e
  801636:	e8 7a fc ff ff       	call   8012b5 <syscall>
  80163b:	83 c4 18             	add    $0x18,%esp
}
  80163e:	c9                   	leave  
  80163f:	c3                   	ret    

00801640 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801643:	8b 55 0c             	mov    0xc(%ebp),%edx
  801646:	8b 45 08             	mov    0x8(%ebp),%eax
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	52                   	push   %edx
  801650:	50                   	push   %eax
  801651:	6a 1f                	push   $0x1f
  801653:	e8 5d fc ff ff       	call   8012b5 <syscall>
  801658:	83 c4 18             	add    $0x18,%esp
}
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 20                	push   $0x20
  80166c:	e8 44 fc ff ff       	call   8012b5 <syscall>
  801671:	83 c4 18             	add    $0x18,%esp
}
  801674:	c9                   	leave  
  801675:	c3                   	ret    

00801676 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801676:	55                   	push   %ebp
  801677:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	6a 00                	push   $0x0
  80167e:	ff 75 14             	pushl  0x14(%ebp)
  801681:	ff 75 10             	pushl  0x10(%ebp)
  801684:	ff 75 0c             	pushl  0xc(%ebp)
  801687:	50                   	push   %eax
  801688:	6a 21                	push   $0x21
  80168a:	e8 26 fc ff ff       	call   8012b5 <syscall>
  80168f:	83 c4 18             	add    $0x18,%esp
}
  801692:	c9                   	leave  
  801693:	c3                   	ret    

00801694 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801694:	55                   	push   %ebp
  801695:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	50                   	push   %eax
  8016a3:	6a 22                	push   $0x22
  8016a5:	e8 0b fc ff ff       	call   8012b5 <syscall>
  8016aa:	83 c4 18             	add    $0x18,%esp
}
  8016ad:	90                   	nop
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8016b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	50                   	push   %eax
  8016bf:	6a 23                	push   $0x23
  8016c1:	e8 ef fb ff ff       	call   8012b5 <syscall>
  8016c6:	83 c4 18             	add    $0x18,%esp
}
  8016c9:	90                   	nop
  8016ca:	c9                   	leave  
  8016cb:	c3                   	ret    

008016cc <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016cc:	55                   	push   %ebp
  8016cd:	89 e5                	mov    %esp,%ebp
  8016cf:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016d2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016d5:	8d 50 04             	lea    0x4(%eax),%edx
  8016d8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	52                   	push   %edx
  8016e2:	50                   	push   %eax
  8016e3:	6a 24                	push   $0x24
  8016e5:	e8 cb fb ff ff       	call   8012b5 <syscall>
  8016ea:	83 c4 18             	add    $0x18,%esp
	return result;
  8016ed:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016f6:	89 01                	mov    %eax,(%ecx)
  8016f8:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fe:	c9                   	leave  
  8016ff:	c2 04 00             	ret    $0x4

00801702 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801702:	55                   	push   %ebp
  801703:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	ff 75 10             	pushl  0x10(%ebp)
  80170c:	ff 75 0c             	pushl  0xc(%ebp)
  80170f:	ff 75 08             	pushl  0x8(%ebp)
  801712:	6a 13                	push   $0x13
  801714:	e8 9c fb ff ff       	call   8012b5 <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
	return ;
  80171c:	90                   	nop
}
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <sys_rcr2>:
uint32 sys_rcr2()
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 25                	push   $0x25
  80172e:	e8 82 fb ff ff       	call   8012b5 <syscall>
  801733:	83 c4 18             	add    $0x18,%esp
}
  801736:	c9                   	leave  
  801737:	c3                   	ret    

00801738 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801738:	55                   	push   %ebp
  801739:	89 e5                	mov    %esp,%ebp
  80173b:	83 ec 04             	sub    $0x4,%esp
  80173e:	8b 45 08             	mov    0x8(%ebp),%eax
  801741:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801744:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	50                   	push   %eax
  801751:	6a 26                	push   $0x26
  801753:	e8 5d fb ff ff       	call   8012b5 <syscall>
  801758:	83 c4 18             	add    $0x18,%esp
	return ;
  80175b:	90                   	nop
}
  80175c:	c9                   	leave  
  80175d:	c3                   	ret    

0080175e <rsttst>:
void rsttst()
{
  80175e:	55                   	push   %ebp
  80175f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 28                	push   $0x28
  80176d:	e8 43 fb ff ff       	call   8012b5 <syscall>
  801772:	83 c4 18             	add    $0x18,%esp
	return ;
  801775:	90                   	nop
}
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
  80177b:	83 ec 04             	sub    $0x4,%esp
  80177e:	8b 45 14             	mov    0x14(%ebp),%eax
  801781:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801784:	8b 55 18             	mov    0x18(%ebp),%edx
  801787:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80178b:	52                   	push   %edx
  80178c:	50                   	push   %eax
  80178d:	ff 75 10             	pushl  0x10(%ebp)
  801790:	ff 75 0c             	pushl  0xc(%ebp)
  801793:	ff 75 08             	pushl  0x8(%ebp)
  801796:	6a 27                	push   $0x27
  801798:	e8 18 fb ff ff       	call   8012b5 <syscall>
  80179d:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a0:	90                   	nop
}
  8017a1:	c9                   	leave  
  8017a2:	c3                   	ret    

008017a3 <chktst>:
void chktst(uint32 n)
{
  8017a3:	55                   	push   %ebp
  8017a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	ff 75 08             	pushl  0x8(%ebp)
  8017b1:	6a 29                	push   $0x29
  8017b3:	e8 fd fa ff ff       	call   8012b5 <syscall>
  8017b8:	83 c4 18             	add    $0x18,%esp
	return ;
  8017bb:	90                   	nop
}
  8017bc:	c9                   	leave  
  8017bd:	c3                   	ret    

008017be <inctst>:

void inctst()
{
  8017be:	55                   	push   %ebp
  8017bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 2a                	push   $0x2a
  8017cd:	e8 e3 fa ff ff       	call   8012b5 <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d5:	90                   	nop
}
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <gettst>:
uint32 gettst()
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 2b                	push   $0x2b
  8017e7:	e8 c9 fa ff ff       	call   8012b5 <syscall>
  8017ec:	83 c4 18             	add    $0x18,%esp
}
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
  8017f4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 2c                	push   $0x2c
  801803:	e8 ad fa ff ff       	call   8012b5 <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
  80180b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80180e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801812:	75 07                	jne    80181b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801814:	b8 01 00 00 00       	mov    $0x1,%eax
  801819:	eb 05                	jmp    801820 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80181b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801820:	c9                   	leave  
  801821:	c3                   	ret    

00801822 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801822:	55                   	push   %ebp
  801823:	89 e5                	mov    %esp,%ebp
  801825:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 2c                	push   $0x2c
  801834:	e8 7c fa ff ff       	call   8012b5 <syscall>
  801839:	83 c4 18             	add    $0x18,%esp
  80183c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80183f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801843:	75 07                	jne    80184c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801845:	b8 01 00 00 00       	mov    $0x1,%eax
  80184a:	eb 05                	jmp    801851 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80184c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
  801856:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 2c                	push   $0x2c
  801865:	e8 4b fa ff ff       	call   8012b5 <syscall>
  80186a:	83 c4 18             	add    $0x18,%esp
  80186d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801870:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801874:	75 07                	jne    80187d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801876:	b8 01 00 00 00       	mov    $0x1,%eax
  80187b:	eb 05                	jmp    801882 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80187d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
  801887:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 2c                	push   $0x2c
  801896:	e8 1a fa ff ff       	call   8012b5 <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
  80189e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8018a1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8018a5:	75 07                	jne    8018ae <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8018a7:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ac:	eb 05                	jmp    8018b3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8018ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018b3:	c9                   	leave  
  8018b4:	c3                   	ret    

008018b5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018b5:	55                   	push   %ebp
  8018b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	ff 75 08             	pushl  0x8(%ebp)
  8018c3:	6a 2d                	push   $0x2d
  8018c5:	e8 eb f9 ff ff       	call   8012b5 <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8018cd:	90                   	nop
}
  8018ce:	c9                   	leave  
  8018cf:	c3                   	ret    

008018d0 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018d0:	55                   	push   %ebp
  8018d1:	89 e5                	mov    %esp,%ebp
  8018d3:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018d4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	6a 00                	push   $0x0
  8018e2:	53                   	push   %ebx
  8018e3:	51                   	push   %ecx
  8018e4:	52                   	push   %edx
  8018e5:	50                   	push   %eax
  8018e6:	6a 2e                	push   $0x2e
  8018e8:	e8 c8 f9 ff ff       	call   8012b5 <syscall>
  8018ed:	83 c4 18             	add    $0x18,%esp
}
  8018f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018f3:	c9                   	leave  
  8018f4:	c3                   	ret    

008018f5 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018f5:	55                   	push   %ebp
  8018f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	52                   	push   %edx
  801905:	50                   	push   %eax
  801906:	6a 2f                	push   $0x2f
  801908:	e8 a8 f9 ff ff       	call   8012b5 <syscall>
  80190d:	83 c4 18             	add    $0x18,%esp
}
  801910:	c9                   	leave  
  801911:	c3                   	ret    

00801912 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801912:	55                   	push   %ebp
  801913:	89 e5                	mov    %esp,%ebp
  801915:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801918:	8b 55 08             	mov    0x8(%ebp),%edx
  80191b:	89 d0                	mov    %edx,%eax
  80191d:	c1 e0 02             	shl    $0x2,%eax
  801920:	01 d0                	add    %edx,%eax
  801922:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801929:	01 d0                	add    %edx,%eax
  80192b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801932:	01 d0                	add    %edx,%eax
  801934:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80193b:	01 d0                	add    %edx,%eax
  80193d:	c1 e0 04             	shl    $0x4,%eax
  801940:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801943:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80194a:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80194d:	83 ec 0c             	sub    $0xc,%esp
  801950:	50                   	push   %eax
  801951:	e8 76 fd ff ff       	call   8016cc <sys_get_virtual_time>
  801956:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801959:	eb 41                	jmp    80199c <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80195b:	8d 45 e0             	lea    -0x20(%ebp),%eax
  80195e:	83 ec 0c             	sub    $0xc,%esp
  801961:	50                   	push   %eax
  801962:	e8 65 fd ff ff       	call   8016cc <sys_get_virtual_time>
  801967:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80196a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80196d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801970:	29 c2                	sub    %eax,%edx
  801972:	89 d0                	mov    %edx,%eax
  801974:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801977:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80197a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80197d:	89 d1                	mov    %edx,%ecx
  80197f:	29 c1                	sub    %eax,%ecx
  801981:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801984:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801987:	39 c2                	cmp    %eax,%edx
  801989:	0f 97 c0             	seta   %al
  80198c:	0f b6 c0             	movzbl %al,%eax
  80198f:	29 c1                	sub    %eax,%ecx
  801991:	89 c8                	mov    %ecx,%eax
  801993:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801996:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801999:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80199c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80199f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019a2:	72 b7                	jb     80195b <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  8019a4:	90                   	nop
  8019a5:	c9                   	leave  
  8019a6:	c3                   	ret    

008019a7 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
  8019aa:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8019ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8019b4:	eb 03                	jmp    8019b9 <busy_wait+0x12>
  8019b6:	ff 45 fc             	incl   -0x4(%ebp)
  8019b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019bc:	3b 45 08             	cmp    0x8(%ebp),%eax
  8019bf:	72 f5                	jb     8019b6 <busy_wait+0xf>
	return i;
  8019c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8019c4:	c9                   	leave  
  8019c5:	c3                   	ret    
  8019c6:	66 90                	xchg   %ax,%ax

008019c8 <__udivdi3>:
  8019c8:	55                   	push   %ebp
  8019c9:	57                   	push   %edi
  8019ca:	56                   	push   %esi
  8019cb:	53                   	push   %ebx
  8019cc:	83 ec 1c             	sub    $0x1c,%esp
  8019cf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019d3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019db:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019df:	89 ca                	mov    %ecx,%edx
  8019e1:	89 f8                	mov    %edi,%eax
  8019e3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019e7:	85 f6                	test   %esi,%esi
  8019e9:	75 2d                	jne    801a18 <__udivdi3+0x50>
  8019eb:	39 cf                	cmp    %ecx,%edi
  8019ed:	77 65                	ja     801a54 <__udivdi3+0x8c>
  8019ef:	89 fd                	mov    %edi,%ebp
  8019f1:	85 ff                	test   %edi,%edi
  8019f3:	75 0b                	jne    801a00 <__udivdi3+0x38>
  8019f5:	b8 01 00 00 00       	mov    $0x1,%eax
  8019fa:	31 d2                	xor    %edx,%edx
  8019fc:	f7 f7                	div    %edi
  8019fe:	89 c5                	mov    %eax,%ebp
  801a00:	31 d2                	xor    %edx,%edx
  801a02:	89 c8                	mov    %ecx,%eax
  801a04:	f7 f5                	div    %ebp
  801a06:	89 c1                	mov    %eax,%ecx
  801a08:	89 d8                	mov    %ebx,%eax
  801a0a:	f7 f5                	div    %ebp
  801a0c:	89 cf                	mov    %ecx,%edi
  801a0e:	89 fa                	mov    %edi,%edx
  801a10:	83 c4 1c             	add    $0x1c,%esp
  801a13:	5b                   	pop    %ebx
  801a14:	5e                   	pop    %esi
  801a15:	5f                   	pop    %edi
  801a16:	5d                   	pop    %ebp
  801a17:	c3                   	ret    
  801a18:	39 ce                	cmp    %ecx,%esi
  801a1a:	77 28                	ja     801a44 <__udivdi3+0x7c>
  801a1c:	0f bd fe             	bsr    %esi,%edi
  801a1f:	83 f7 1f             	xor    $0x1f,%edi
  801a22:	75 40                	jne    801a64 <__udivdi3+0x9c>
  801a24:	39 ce                	cmp    %ecx,%esi
  801a26:	72 0a                	jb     801a32 <__udivdi3+0x6a>
  801a28:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a2c:	0f 87 9e 00 00 00    	ja     801ad0 <__udivdi3+0x108>
  801a32:	b8 01 00 00 00       	mov    $0x1,%eax
  801a37:	89 fa                	mov    %edi,%edx
  801a39:	83 c4 1c             	add    $0x1c,%esp
  801a3c:	5b                   	pop    %ebx
  801a3d:	5e                   	pop    %esi
  801a3e:	5f                   	pop    %edi
  801a3f:	5d                   	pop    %ebp
  801a40:	c3                   	ret    
  801a41:	8d 76 00             	lea    0x0(%esi),%esi
  801a44:	31 ff                	xor    %edi,%edi
  801a46:	31 c0                	xor    %eax,%eax
  801a48:	89 fa                	mov    %edi,%edx
  801a4a:	83 c4 1c             	add    $0x1c,%esp
  801a4d:	5b                   	pop    %ebx
  801a4e:	5e                   	pop    %esi
  801a4f:	5f                   	pop    %edi
  801a50:	5d                   	pop    %ebp
  801a51:	c3                   	ret    
  801a52:	66 90                	xchg   %ax,%ax
  801a54:	89 d8                	mov    %ebx,%eax
  801a56:	f7 f7                	div    %edi
  801a58:	31 ff                	xor    %edi,%edi
  801a5a:	89 fa                	mov    %edi,%edx
  801a5c:	83 c4 1c             	add    $0x1c,%esp
  801a5f:	5b                   	pop    %ebx
  801a60:	5e                   	pop    %esi
  801a61:	5f                   	pop    %edi
  801a62:	5d                   	pop    %ebp
  801a63:	c3                   	ret    
  801a64:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a69:	89 eb                	mov    %ebp,%ebx
  801a6b:	29 fb                	sub    %edi,%ebx
  801a6d:	89 f9                	mov    %edi,%ecx
  801a6f:	d3 e6                	shl    %cl,%esi
  801a71:	89 c5                	mov    %eax,%ebp
  801a73:	88 d9                	mov    %bl,%cl
  801a75:	d3 ed                	shr    %cl,%ebp
  801a77:	89 e9                	mov    %ebp,%ecx
  801a79:	09 f1                	or     %esi,%ecx
  801a7b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a7f:	89 f9                	mov    %edi,%ecx
  801a81:	d3 e0                	shl    %cl,%eax
  801a83:	89 c5                	mov    %eax,%ebp
  801a85:	89 d6                	mov    %edx,%esi
  801a87:	88 d9                	mov    %bl,%cl
  801a89:	d3 ee                	shr    %cl,%esi
  801a8b:	89 f9                	mov    %edi,%ecx
  801a8d:	d3 e2                	shl    %cl,%edx
  801a8f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a93:	88 d9                	mov    %bl,%cl
  801a95:	d3 e8                	shr    %cl,%eax
  801a97:	09 c2                	or     %eax,%edx
  801a99:	89 d0                	mov    %edx,%eax
  801a9b:	89 f2                	mov    %esi,%edx
  801a9d:	f7 74 24 0c          	divl   0xc(%esp)
  801aa1:	89 d6                	mov    %edx,%esi
  801aa3:	89 c3                	mov    %eax,%ebx
  801aa5:	f7 e5                	mul    %ebp
  801aa7:	39 d6                	cmp    %edx,%esi
  801aa9:	72 19                	jb     801ac4 <__udivdi3+0xfc>
  801aab:	74 0b                	je     801ab8 <__udivdi3+0xf0>
  801aad:	89 d8                	mov    %ebx,%eax
  801aaf:	31 ff                	xor    %edi,%edi
  801ab1:	e9 58 ff ff ff       	jmp    801a0e <__udivdi3+0x46>
  801ab6:	66 90                	xchg   %ax,%ax
  801ab8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801abc:	89 f9                	mov    %edi,%ecx
  801abe:	d3 e2                	shl    %cl,%edx
  801ac0:	39 c2                	cmp    %eax,%edx
  801ac2:	73 e9                	jae    801aad <__udivdi3+0xe5>
  801ac4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ac7:	31 ff                	xor    %edi,%edi
  801ac9:	e9 40 ff ff ff       	jmp    801a0e <__udivdi3+0x46>
  801ace:	66 90                	xchg   %ax,%ax
  801ad0:	31 c0                	xor    %eax,%eax
  801ad2:	e9 37 ff ff ff       	jmp    801a0e <__udivdi3+0x46>
  801ad7:	90                   	nop

00801ad8 <__umoddi3>:
  801ad8:	55                   	push   %ebp
  801ad9:	57                   	push   %edi
  801ada:	56                   	push   %esi
  801adb:	53                   	push   %ebx
  801adc:	83 ec 1c             	sub    $0x1c,%esp
  801adf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ae3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ae7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801aeb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801aef:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801af3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801af7:	89 f3                	mov    %esi,%ebx
  801af9:	89 fa                	mov    %edi,%edx
  801afb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801aff:	89 34 24             	mov    %esi,(%esp)
  801b02:	85 c0                	test   %eax,%eax
  801b04:	75 1a                	jne    801b20 <__umoddi3+0x48>
  801b06:	39 f7                	cmp    %esi,%edi
  801b08:	0f 86 a2 00 00 00    	jbe    801bb0 <__umoddi3+0xd8>
  801b0e:	89 c8                	mov    %ecx,%eax
  801b10:	89 f2                	mov    %esi,%edx
  801b12:	f7 f7                	div    %edi
  801b14:	89 d0                	mov    %edx,%eax
  801b16:	31 d2                	xor    %edx,%edx
  801b18:	83 c4 1c             	add    $0x1c,%esp
  801b1b:	5b                   	pop    %ebx
  801b1c:	5e                   	pop    %esi
  801b1d:	5f                   	pop    %edi
  801b1e:	5d                   	pop    %ebp
  801b1f:	c3                   	ret    
  801b20:	39 f0                	cmp    %esi,%eax
  801b22:	0f 87 ac 00 00 00    	ja     801bd4 <__umoddi3+0xfc>
  801b28:	0f bd e8             	bsr    %eax,%ebp
  801b2b:	83 f5 1f             	xor    $0x1f,%ebp
  801b2e:	0f 84 ac 00 00 00    	je     801be0 <__umoddi3+0x108>
  801b34:	bf 20 00 00 00       	mov    $0x20,%edi
  801b39:	29 ef                	sub    %ebp,%edi
  801b3b:	89 fe                	mov    %edi,%esi
  801b3d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b41:	89 e9                	mov    %ebp,%ecx
  801b43:	d3 e0                	shl    %cl,%eax
  801b45:	89 d7                	mov    %edx,%edi
  801b47:	89 f1                	mov    %esi,%ecx
  801b49:	d3 ef                	shr    %cl,%edi
  801b4b:	09 c7                	or     %eax,%edi
  801b4d:	89 e9                	mov    %ebp,%ecx
  801b4f:	d3 e2                	shl    %cl,%edx
  801b51:	89 14 24             	mov    %edx,(%esp)
  801b54:	89 d8                	mov    %ebx,%eax
  801b56:	d3 e0                	shl    %cl,%eax
  801b58:	89 c2                	mov    %eax,%edx
  801b5a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b5e:	d3 e0                	shl    %cl,%eax
  801b60:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b64:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b68:	89 f1                	mov    %esi,%ecx
  801b6a:	d3 e8                	shr    %cl,%eax
  801b6c:	09 d0                	or     %edx,%eax
  801b6e:	d3 eb                	shr    %cl,%ebx
  801b70:	89 da                	mov    %ebx,%edx
  801b72:	f7 f7                	div    %edi
  801b74:	89 d3                	mov    %edx,%ebx
  801b76:	f7 24 24             	mull   (%esp)
  801b79:	89 c6                	mov    %eax,%esi
  801b7b:	89 d1                	mov    %edx,%ecx
  801b7d:	39 d3                	cmp    %edx,%ebx
  801b7f:	0f 82 87 00 00 00    	jb     801c0c <__umoddi3+0x134>
  801b85:	0f 84 91 00 00 00    	je     801c1c <__umoddi3+0x144>
  801b8b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b8f:	29 f2                	sub    %esi,%edx
  801b91:	19 cb                	sbb    %ecx,%ebx
  801b93:	89 d8                	mov    %ebx,%eax
  801b95:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b99:	d3 e0                	shl    %cl,%eax
  801b9b:	89 e9                	mov    %ebp,%ecx
  801b9d:	d3 ea                	shr    %cl,%edx
  801b9f:	09 d0                	or     %edx,%eax
  801ba1:	89 e9                	mov    %ebp,%ecx
  801ba3:	d3 eb                	shr    %cl,%ebx
  801ba5:	89 da                	mov    %ebx,%edx
  801ba7:	83 c4 1c             	add    $0x1c,%esp
  801baa:	5b                   	pop    %ebx
  801bab:	5e                   	pop    %esi
  801bac:	5f                   	pop    %edi
  801bad:	5d                   	pop    %ebp
  801bae:	c3                   	ret    
  801baf:	90                   	nop
  801bb0:	89 fd                	mov    %edi,%ebp
  801bb2:	85 ff                	test   %edi,%edi
  801bb4:	75 0b                	jne    801bc1 <__umoddi3+0xe9>
  801bb6:	b8 01 00 00 00       	mov    $0x1,%eax
  801bbb:	31 d2                	xor    %edx,%edx
  801bbd:	f7 f7                	div    %edi
  801bbf:	89 c5                	mov    %eax,%ebp
  801bc1:	89 f0                	mov    %esi,%eax
  801bc3:	31 d2                	xor    %edx,%edx
  801bc5:	f7 f5                	div    %ebp
  801bc7:	89 c8                	mov    %ecx,%eax
  801bc9:	f7 f5                	div    %ebp
  801bcb:	89 d0                	mov    %edx,%eax
  801bcd:	e9 44 ff ff ff       	jmp    801b16 <__umoddi3+0x3e>
  801bd2:	66 90                	xchg   %ax,%ax
  801bd4:	89 c8                	mov    %ecx,%eax
  801bd6:	89 f2                	mov    %esi,%edx
  801bd8:	83 c4 1c             	add    $0x1c,%esp
  801bdb:	5b                   	pop    %ebx
  801bdc:	5e                   	pop    %esi
  801bdd:	5f                   	pop    %edi
  801bde:	5d                   	pop    %ebp
  801bdf:	c3                   	ret    
  801be0:	3b 04 24             	cmp    (%esp),%eax
  801be3:	72 06                	jb     801beb <__umoddi3+0x113>
  801be5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801be9:	77 0f                	ja     801bfa <__umoddi3+0x122>
  801beb:	89 f2                	mov    %esi,%edx
  801bed:	29 f9                	sub    %edi,%ecx
  801bef:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801bf3:	89 14 24             	mov    %edx,(%esp)
  801bf6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bfa:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bfe:	8b 14 24             	mov    (%esp),%edx
  801c01:	83 c4 1c             	add    $0x1c,%esp
  801c04:	5b                   	pop    %ebx
  801c05:	5e                   	pop    %esi
  801c06:	5f                   	pop    %edi
  801c07:	5d                   	pop    %ebp
  801c08:	c3                   	ret    
  801c09:	8d 76 00             	lea    0x0(%esi),%esi
  801c0c:	2b 04 24             	sub    (%esp),%eax
  801c0f:	19 fa                	sbb    %edi,%edx
  801c11:	89 d1                	mov    %edx,%ecx
  801c13:	89 c6                	mov    %eax,%esi
  801c15:	e9 71 ff ff ff       	jmp    801b8b <__umoddi3+0xb3>
  801c1a:	66 90                	xchg   %ax,%ax
  801c1c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c20:	72 ea                	jb     801c0c <__umoddi3+0x134>
  801c22:	89 d9                	mov    %ebx,%ecx
  801c24:	e9 62 ff ff ff       	jmp    801b8b <__umoddi3+0xb3>

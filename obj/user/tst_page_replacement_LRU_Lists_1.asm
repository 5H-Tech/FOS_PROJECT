
obj/user/tst_page_replacement_LRU_Lists_1:     file format elf32-i386


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
  800031:	e8 b9 01 00 00       	call   8001ef <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 5c             	sub    $0x5c,%esp

//	cprintf("envID = %d\n",envID);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		uint32 actual_active_list[5] = {0x803000, 0x801000, 0x800000, 0xeebfd000, 0x203000};
  800041:	8d 45 b8             	lea    -0x48(%ebp),%eax
  800044:	bb 34 1e 80 00       	mov    $0x801e34,%ebx
  800049:	ba 05 00 00 00       	mov    $0x5,%edx
  80004e:	89 c7                	mov    %eax,%edi
  800050:	89 de                	mov    %ebx,%esi
  800052:	89 d1                	mov    %edx,%ecx
  800054:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		uint32 actual_second_list[5] = {0x202000, 0x201000, 0x200000, 0x802000, 0x205000};
  800056:	8d 45 a4             	lea    -0x5c(%ebp),%eax
  800059:	bb 48 1e 80 00       	mov    $0x801e48,%ebx
  80005e:	ba 05 00 00 00       	mov    $0x5,%edx
  800063:	89 c7                	mov    %eax,%edi
  800065:	89 de                	mov    %ebx,%esi
  800067:	89 d1                	mov    %edx,%ecx
  800069:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		int check = sys_check_LRU_lists(actual_active_list, actual_second_list, 5, 5);
  80006b:	6a 05                	push   $0x5
  80006d:	6a 05                	push   $0x5
  80006f:	8d 45 a4             	lea    -0x5c(%ebp),%eax
  800072:	50                   	push   %eax
  800073:	8d 45 b8             	lea    -0x48(%ebp),%eax
  800076:	50                   	push   %eax
  800077:	e8 ff 18 00 00       	call   80197b <sys_check_LRU_lists>
  80007c:	83 c4 10             	add    $0x10,%esp
  80007f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		if(check == 0)
  800082:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800086:	75 14                	jne    80009c <_main+0x64>
			panic("INITIAL PAGE LRU LISTs entry checking failed! Review size of the LRU lists..!!");
  800088:	83 ec 04             	sub    $0x4,%esp
  80008b:	68 40 1c 80 00       	push   $0x801c40
  800090:	6a 18                	push   $0x18
  800092:	68 90 1c 80 00       	push   $0x801c90
  800097:	e8 98 02 00 00       	call   800334 <_panic>
	}

	int freePages = sys_calculate_free_frames();
  80009c:	e8 2b 14 00 00       	call   8014cc <sys_calculate_free_frames>
  8000a1:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8000a4:	e8 a6 14 00 00       	call   80154f <sys_pf_calculate_allocated_pages>
  8000a9:	89 45 d8             	mov    %eax,-0x28(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8000ac:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8000b1:	88 45 d7             	mov    %al,-0x29(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8000b4:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8000b9:	88 45 d6             	mov    %al,-0x2a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000bc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8000c3:	eb 37                	jmp    8000fc <_main+0xc4>
	{
		arr[i] = -1 ;
  8000c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000c8:	05 40 30 80 00       	add    $0x803040,%eax
  8000cd:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8000d0:	a1 04 30 80 00       	mov    0x803004,%eax
  8000d5:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8000db:	8a 12                	mov    (%edx),%dl
  8000dd:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8000df:	a1 00 30 80 00       	mov    0x803000,%eax
  8000e4:	40                   	inc    %eax
  8000e5:	a3 00 30 80 00       	mov    %eax,0x803000
  8000ea:	a1 04 30 80 00       	mov    0x803004,%eax
  8000ef:	40                   	inc    %eax
  8000f0:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000f5:	81 45 e4 00 08 00 00 	addl   $0x800,-0x1c(%ebp)
  8000fc:	81 7d e4 ff 9f 00 00 	cmpl   $0x9fff,-0x1c(%ebp)
  800103:	7e c0                	jle    8000c5 <_main+0x8d>

	//===================

	//cprintf("Checking Allocation in Mem & Page File... \n");
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800105:	e8 45 14 00 00       	call   80154f <sys_pf_calculate_allocated_pages>
  80010a:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  80010d:	74 14                	je     800123 <_main+0xeb>
  80010f:	83 ec 04             	sub    $0x4,%esp
  800112:	68 b8 1c 80 00       	push   $0x801cb8
  800117:	6a 33                	push   $0x33
  800119:	68 90 1c 80 00       	push   $0x801c90
  80011e:	e8 11 02 00 00       	call   800334 <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800123:	e8 a4 13 00 00       	call   8014cc <sys_calculate_free_frames>
  800128:	89 c3                	mov    %eax,%ebx
  80012a:	e8 b6 13 00 00       	call   8014e5 <sys_calculate_modified_frames>
  80012f:	01 d8                	add    %ebx,%eax
  800131:	89 45 d0             	mov    %eax,-0x30(%ebp)
		if( (freePages - freePagesAfter) != 0 )
  800134:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800137:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  80013a:	74 14                	je     800150 <_main+0x118>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  80013c:	83 ec 04             	sub    $0x4,%esp
  80013f:	68 24 1d 80 00       	push   $0x801d24
  800144:	6a 37                	push   $0x37
  800146:	68 90 1c 80 00       	push   $0x801c90
  80014b:	e8 e4 01 00 00       	call   800334 <_panic>
	}

	//cprintf("Checking CONTENT in Mem ... \n");
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800150:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800157:	eb 29                	jmp    800182 <_main+0x14a>
			if( arr[i] != -1) panic("Modified page(s) not restored correctly");
  800159:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80015c:	05 40 30 80 00       	add    $0x803040,%eax
  800161:	8a 00                	mov    (%eax),%al
  800163:	3c ff                	cmp    $0xff,%al
  800165:	74 14                	je     80017b <_main+0x143>
  800167:	83 ec 04             	sub    $0x4,%esp
  80016a:	68 88 1d 80 00       	push   $0x801d88
  80016f:	6a 3d                	push   $0x3d
  800171:	68 90 1c 80 00       	push   $0x801c90
  800176:	e8 b9 01 00 00       	call   800334 <_panic>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
	}

	//cprintf("Checking CONTENT in Mem ... \n");
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  80017b:	81 45 e4 00 08 00 00 	addl   $0x800,-0x1c(%ebp)
  800182:	81 7d e4 ff 9f 00 00 	cmpl   $0x9fff,-0x1c(%ebp)
  800189:	7e ce                	jle    800159 <_main+0x121>
			if( arr[i] != -1) panic("Modified page(s) not restored correctly");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  80018b:	e8 bf 13 00 00       	call   80154f <sys_pf_calculate_allocated_pages>
  800190:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800193:	74 14                	je     8001a9 <_main+0x171>
  800195:	83 ec 04             	sub    $0x4,%esp
  800198:	68 b8 1c 80 00       	push   $0x801cb8
  80019d:	6a 3e                	push   $0x3e
  80019f:	68 90 1c 80 00       	push   $0x801c90
  8001a4:	e8 8b 01 00 00       	call   800334 <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8001a9:	e8 1e 13 00 00       	call   8014cc <sys_calculate_free_frames>
  8001ae:	89 c3                	mov    %eax,%ebx
  8001b0:	e8 30 13 00 00       	call   8014e5 <sys_calculate_modified_frames>
  8001b5:	01 d8                	add    %ebx,%eax
  8001b7:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if( (freePages - freePagesAfter) != 0 )
  8001ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001bd:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  8001c0:	74 14                	je     8001d6 <_main+0x19e>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  8001c2:	83 ec 04             	sub    $0x4,%esp
  8001c5:	68 24 1d 80 00       	push   $0x801d24
  8001ca:	6a 42                	push   $0x42
  8001cc:	68 90 1c 80 00       	push   $0x801c90
  8001d1:	e8 5e 01 00 00       	call   800334 <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [ALLOCATION] by REMOVING ONLY ONE PAGE using APRROXIMATED LRU is completed successfully.\n");
  8001d6:	83 ec 0c             	sub    $0xc,%esp
  8001d9:	68 b0 1d 80 00       	push   $0x801db0
  8001de:	e8 f3 03 00 00       	call   8005d6 <cprintf>
  8001e3:	83 c4 10             	add    $0x10,%esp
	return;
  8001e6:	90                   	nop
}
  8001e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8001ea:	5b                   	pop    %ebx
  8001eb:	5e                   	pop    %esi
  8001ec:	5f                   	pop    %edi
  8001ed:	5d                   	pop    %ebp
  8001ee:	c3                   	ret    

008001ef <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001ef:	55                   	push   %ebp
  8001f0:	89 e5                	mov    %esp,%ebp
  8001f2:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001f5:	e8 07 12 00 00       	call   801401 <sys_getenvindex>
  8001fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800200:	89 d0                	mov    %edx,%eax
  800202:	c1 e0 03             	shl    $0x3,%eax
  800205:	01 d0                	add    %edx,%eax
  800207:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80020e:	01 c8                	add    %ecx,%eax
  800210:	01 c0                	add    %eax,%eax
  800212:	01 d0                	add    %edx,%eax
  800214:	01 c0                	add    %eax,%eax
  800216:	01 d0                	add    %edx,%eax
  800218:	89 c2                	mov    %eax,%edx
  80021a:	c1 e2 05             	shl    $0x5,%edx
  80021d:	29 c2                	sub    %eax,%edx
  80021f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800226:	89 c2                	mov    %eax,%edx
  800228:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80022e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800233:	a1 20 30 80 00       	mov    0x803020,%eax
  800238:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80023e:	84 c0                	test   %al,%al
  800240:	74 0f                	je     800251 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800242:	a1 20 30 80 00       	mov    0x803020,%eax
  800247:	05 40 3c 01 00       	add    $0x13c40,%eax
  80024c:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800251:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800255:	7e 0a                	jle    800261 <libmain+0x72>
		binaryname = argv[0];
  800257:	8b 45 0c             	mov    0xc(%ebp),%eax
  80025a:	8b 00                	mov    (%eax),%eax
  80025c:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  800261:	83 ec 08             	sub    $0x8,%esp
  800264:	ff 75 0c             	pushl  0xc(%ebp)
  800267:	ff 75 08             	pushl  0x8(%ebp)
  80026a:	e8 c9 fd ff ff       	call   800038 <_main>
  80026f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800272:	e8 25 13 00 00       	call   80159c <sys_disable_interrupt>
	cprintf("**************************************\n");
  800277:	83 ec 0c             	sub    $0xc,%esp
  80027a:	68 74 1e 80 00       	push   $0x801e74
  80027f:	e8 52 03 00 00       	call   8005d6 <cprintf>
  800284:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800287:	a1 20 30 80 00       	mov    0x803020,%eax
  80028c:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800292:	a1 20 30 80 00       	mov    0x803020,%eax
  800297:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80029d:	83 ec 04             	sub    $0x4,%esp
  8002a0:	52                   	push   %edx
  8002a1:	50                   	push   %eax
  8002a2:	68 9c 1e 80 00       	push   $0x801e9c
  8002a7:	e8 2a 03 00 00       	call   8005d6 <cprintf>
  8002ac:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8002af:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b4:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8002ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8002bf:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8002c5:	83 ec 04             	sub    $0x4,%esp
  8002c8:	52                   	push   %edx
  8002c9:	50                   	push   %eax
  8002ca:	68 c4 1e 80 00       	push   $0x801ec4
  8002cf:	e8 02 03 00 00       	call   8005d6 <cprintf>
  8002d4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002dc:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002e2:	83 ec 08             	sub    $0x8,%esp
  8002e5:	50                   	push   %eax
  8002e6:	68 05 1f 80 00       	push   $0x801f05
  8002eb:	e8 e6 02 00 00       	call   8005d6 <cprintf>
  8002f0:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002f3:	83 ec 0c             	sub    $0xc,%esp
  8002f6:	68 74 1e 80 00       	push   $0x801e74
  8002fb:	e8 d6 02 00 00       	call   8005d6 <cprintf>
  800300:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800303:	e8 ae 12 00 00       	call   8015b6 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800308:	e8 19 00 00 00       	call   800326 <exit>
}
  80030d:	90                   	nop
  80030e:	c9                   	leave  
  80030f:	c3                   	ret    

00800310 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800310:	55                   	push   %ebp
  800311:	89 e5                	mov    %esp,%ebp
  800313:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800316:	83 ec 0c             	sub    $0xc,%esp
  800319:	6a 00                	push   $0x0
  80031b:	e8 ad 10 00 00       	call   8013cd <sys_env_destroy>
  800320:	83 c4 10             	add    $0x10,%esp
}
  800323:	90                   	nop
  800324:	c9                   	leave  
  800325:	c3                   	ret    

00800326 <exit>:

void
exit(void)
{
  800326:	55                   	push   %ebp
  800327:	89 e5                	mov    %esp,%ebp
  800329:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80032c:	e8 02 11 00 00       	call   801433 <sys_env_exit>
}
  800331:	90                   	nop
  800332:	c9                   	leave  
  800333:	c3                   	ret    

00800334 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800334:	55                   	push   %ebp
  800335:	89 e5                	mov    %esp,%ebp
  800337:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80033a:	8d 45 10             	lea    0x10(%ebp),%eax
  80033d:	83 c0 04             	add    $0x4,%eax
  800340:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800343:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800348:	85 c0                	test   %eax,%eax
  80034a:	74 16                	je     800362 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80034c:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800351:	83 ec 08             	sub    $0x8,%esp
  800354:	50                   	push   %eax
  800355:	68 1c 1f 80 00       	push   $0x801f1c
  80035a:	e8 77 02 00 00       	call   8005d6 <cprintf>
  80035f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800362:	a1 08 30 80 00       	mov    0x803008,%eax
  800367:	ff 75 0c             	pushl  0xc(%ebp)
  80036a:	ff 75 08             	pushl  0x8(%ebp)
  80036d:	50                   	push   %eax
  80036e:	68 21 1f 80 00       	push   $0x801f21
  800373:	e8 5e 02 00 00       	call   8005d6 <cprintf>
  800378:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80037b:	8b 45 10             	mov    0x10(%ebp),%eax
  80037e:	83 ec 08             	sub    $0x8,%esp
  800381:	ff 75 f4             	pushl  -0xc(%ebp)
  800384:	50                   	push   %eax
  800385:	e8 e1 01 00 00       	call   80056b <vcprintf>
  80038a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80038d:	83 ec 08             	sub    $0x8,%esp
  800390:	6a 00                	push   $0x0
  800392:	68 3d 1f 80 00       	push   $0x801f3d
  800397:	e8 cf 01 00 00       	call   80056b <vcprintf>
  80039c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80039f:	e8 82 ff ff ff       	call   800326 <exit>

	// should not return here
	while (1) ;
  8003a4:	eb fe                	jmp    8003a4 <_panic+0x70>

008003a6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8003a6:	55                   	push   %ebp
  8003a7:	89 e5                	mov    %esp,%ebp
  8003a9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b1:	8b 50 74             	mov    0x74(%eax),%edx
  8003b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b7:	39 c2                	cmp    %eax,%edx
  8003b9:	74 14                	je     8003cf <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003bb:	83 ec 04             	sub    $0x4,%esp
  8003be:	68 40 1f 80 00       	push   $0x801f40
  8003c3:	6a 26                	push   $0x26
  8003c5:	68 8c 1f 80 00       	push   $0x801f8c
  8003ca:	e8 65 ff ff ff       	call   800334 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003d6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003dd:	e9 b6 00 00 00       	jmp    800498 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8003e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ef:	01 d0                	add    %edx,%eax
  8003f1:	8b 00                	mov    (%eax),%eax
  8003f3:	85 c0                	test   %eax,%eax
  8003f5:	75 08                	jne    8003ff <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003f7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003fa:	e9 96 00 00 00       	jmp    800495 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003ff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800406:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80040d:	eb 5d                	jmp    80046c <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80040f:	a1 20 30 80 00       	mov    0x803020,%eax
  800414:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80041a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80041d:	c1 e2 04             	shl    $0x4,%edx
  800420:	01 d0                	add    %edx,%eax
  800422:	8a 40 04             	mov    0x4(%eax),%al
  800425:	84 c0                	test   %al,%al
  800427:	75 40                	jne    800469 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800429:	a1 20 30 80 00       	mov    0x803020,%eax
  80042e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800434:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800437:	c1 e2 04             	shl    $0x4,%edx
  80043a:	01 d0                	add    %edx,%eax
  80043c:	8b 00                	mov    (%eax),%eax
  80043e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800441:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800444:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800449:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80044b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80044e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800455:	8b 45 08             	mov    0x8(%ebp),%eax
  800458:	01 c8                	add    %ecx,%eax
  80045a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80045c:	39 c2                	cmp    %eax,%edx
  80045e:	75 09                	jne    800469 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800460:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800467:	eb 12                	jmp    80047b <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800469:	ff 45 e8             	incl   -0x18(%ebp)
  80046c:	a1 20 30 80 00       	mov    0x803020,%eax
  800471:	8b 50 74             	mov    0x74(%eax),%edx
  800474:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800477:	39 c2                	cmp    %eax,%edx
  800479:	77 94                	ja     80040f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80047b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80047f:	75 14                	jne    800495 <CheckWSWithoutLastIndex+0xef>
			panic(
  800481:	83 ec 04             	sub    $0x4,%esp
  800484:	68 98 1f 80 00       	push   $0x801f98
  800489:	6a 3a                	push   $0x3a
  80048b:	68 8c 1f 80 00       	push   $0x801f8c
  800490:	e8 9f fe ff ff       	call   800334 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800495:	ff 45 f0             	incl   -0x10(%ebp)
  800498:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80049b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80049e:	0f 8c 3e ff ff ff    	jl     8003e2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8004a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004ab:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004b2:	eb 20                	jmp    8004d4 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004bf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004c2:	c1 e2 04             	shl    $0x4,%edx
  8004c5:	01 d0                	add    %edx,%eax
  8004c7:	8a 40 04             	mov    0x4(%eax),%al
  8004ca:	3c 01                	cmp    $0x1,%al
  8004cc:	75 03                	jne    8004d1 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8004ce:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004d1:	ff 45 e0             	incl   -0x20(%ebp)
  8004d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d9:	8b 50 74             	mov    0x74(%eax),%edx
  8004dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004df:	39 c2                	cmp    %eax,%edx
  8004e1:	77 d1                	ja     8004b4 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004e9:	74 14                	je     8004ff <CheckWSWithoutLastIndex+0x159>
		panic(
  8004eb:	83 ec 04             	sub    $0x4,%esp
  8004ee:	68 ec 1f 80 00       	push   $0x801fec
  8004f3:	6a 44                	push   $0x44
  8004f5:	68 8c 1f 80 00       	push   $0x801f8c
  8004fa:	e8 35 fe ff ff       	call   800334 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004ff:	90                   	nop
  800500:	c9                   	leave  
  800501:	c3                   	ret    

00800502 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800502:	55                   	push   %ebp
  800503:	89 e5                	mov    %esp,%ebp
  800505:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800508:	8b 45 0c             	mov    0xc(%ebp),%eax
  80050b:	8b 00                	mov    (%eax),%eax
  80050d:	8d 48 01             	lea    0x1(%eax),%ecx
  800510:	8b 55 0c             	mov    0xc(%ebp),%edx
  800513:	89 0a                	mov    %ecx,(%edx)
  800515:	8b 55 08             	mov    0x8(%ebp),%edx
  800518:	88 d1                	mov    %dl,%cl
  80051a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80051d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800521:	8b 45 0c             	mov    0xc(%ebp),%eax
  800524:	8b 00                	mov    (%eax),%eax
  800526:	3d ff 00 00 00       	cmp    $0xff,%eax
  80052b:	75 2c                	jne    800559 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80052d:	a0 24 30 80 00       	mov    0x803024,%al
  800532:	0f b6 c0             	movzbl %al,%eax
  800535:	8b 55 0c             	mov    0xc(%ebp),%edx
  800538:	8b 12                	mov    (%edx),%edx
  80053a:	89 d1                	mov    %edx,%ecx
  80053c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80053f:	83 c2 08             	add    $0x8,%edx
  800542:	83 ec 04             	sub    $0x4,%esp
  800545:	50                   	push   %eax
  800546:	51                   	push   %ecx
  800547:	52                   	push   %edx
  800548:	e8 3e 0e 00 00       	call   80138b <sys_cputs>
  80054d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800550:	8b 45 0c             	mov    0xc(%ebp),%eax
  800553:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800559:	8b 45 0c             	mov    0xc(%ebp),%eax
  80055c:	8b 40 04             	mov    0x4(%eax),%eax
  80055f:	8d 50 01             	lea    0x1(%eax),%edx
  800562:	8b 45 0c             	mov    0xc(%ebp),%eax
  800565:	89 50 04             	mov    %edx,0x4(%eax)
}
  800568:	90                   	nop
  800569:	c9                   	leave  
  80056a:	c3                   	ret    

0080056b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80056b:	55                   	push   %ebp
  80056c:	89 e5                	mov    %esp,%ebp
  80056e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800574:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80057b:	00 00 00 
	b.cnt = 0;
  80057e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800585:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800588:	ff 75 0c             	pushl  0xc(%ebp)
  80058b:	ff 75 08             	pushl  0x8(%ebp)
  80058e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800594:	50                   	push   %eax
  800595:	68 02 05 80 00       	push   $0x800502
  80059a:	e8 11 02 00 00       	call   8007b0 <vprintfmt>
  80059f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005a2:	a0 24 30 80 00       	mov    0x803024,%al
  8005a7:	0f b6 c0             	movzbl %al,%eax
  8005aa:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005b0:	83 ec 04             	sub    $0x4,%esp
  8005b3:	50                   	push   %eax
  8005b4:	52                   	push   %edx
  8005b5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005bb:	83 c0 08             	add    $0x8,%eax
  8005be:	50                   	push   %eax
  8005bf:	e8 c7 0d 00 00       	call   80138b <sys_cputs>
  8005c4:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005c7:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005ce:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005d4:	c9                   	leave  
  8005d5:	c3                   	ret    

008005d6 <cprintf>:

int cprintf(const char *fmt, ...) {
  8005d6:	55                   	push   %ebp
  8005d7:	89 e5                	mov    %esp,%ebp
  8005d9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005dc:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005e3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ec:	83 ec 08             	sub    $0x8,%esp
  8005ef:	ff 75 f4             	pushl  -0xc(%ebp)
  8005f2:	50                   	push   %eax
  8005f3:	e8 73 ff ff ff       	call   80056b <vcprintf>
  8005f8:	83 c4 10             	add    $0x10,%esp
  8005fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800601:	c9                   	leave  
  800602:	c3                   	ret    

00800603 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800603:	55                   	push   %ebp
  800604:	89 e5                	mov    %esp,%ebp
  800606:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800609:	e8 8e 0f 00 00       	call   80159c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80060e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800611:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800614:	8b 45 08             	mov    0x8(%ebp),%eax
  800617:	83 ec 08             	sub    $0x8,%esp
  80061a:	ff 75 f4             	pushl  -0xc(%ebp)
  80061d:	50                   	push   %eax
  80061e:	e8 48 ff ff ff       	call   80056b <vcprintf>
  800623:	83 c4 10             	add    $0x10,%esp
  800626:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800629:	e8 88 0f 00 00       	call   8015b6 <sys_enable_interrupt>
	return cnt;
  80062e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800631:	c9                   	leave  
  800632:	c3                   	ret    

00800633 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800633:	55                   	push   %ebp
  800634:	89 e5                	mov    %esp,%ebp
  800636:	53                   	push   %ebx
  800637:	83 ec 14             	sub    $0x14,%esp
  80063a:	8b 45 10             	mov    0x10(%ebp),%eax
  80063d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800640:	8b 45 14             	mov    0x14(%ebp),%eax
  800643:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800646:	8b 45 18             	mov    0x18(%ebp),%eax
  800649:	ba 00 00 00 00       	mov    $0x0,%edx
  80064e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800651:	77 55                	ja     8006a8 <printnum+0x75>
  800653:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800656:	72 05                	jb     80065d <printnum+0x2a>
  800658:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80065b:	77 4b                	ja     8006a8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80065d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800660:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800663:	8b 45 18             	mov    0x18(%ebp),%eax
  800666:	ba 00 00 00 00       	mov    $0x0,%edx
  80066b:	52                   	push   %edx
  80066c:	50                   	push   %eax
  80066d:	ff 75 f4             	pushl  -0xc(%ebp)
  800670:	ff 75 f0             	pushl  -0x10(%ebp)
  800673:	e8 48 13 00 00       	call   8019c0 <__udivdi3>
  800678:	83 c4 10             	add    $0x10,%esp
  80067b:	83 ec 04             	sub    $0x4,%esp
  80067e:	ff 75 20             	pushl  0x20(%ebp)
  800681:	53                   	push   %ebx
  800682:	ff 75 18             	pushl  0x18(%ebp)
  800685:	52                   	push   %edx
  800686:	50                   	push   %eax
  800687:	ff 75 0c             	pushl  0xc(%ebp)
  80068a:	ff 75 08             	pushl  0x8(%ebp)
  80068d:	e8 a1 ff ff ff       	call   800633 <printnum>
  800692:	83 c4 20             	add    $0x20,%esp
  800695:	eb 1a                	jmp    8006b1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800697:	83 ec 08             	sub    $0x8,%esp
  80069a:	ff 75 0c             	pushl  0xc(%ebp)
  80069d:	ff 75 20             	pushl  0x20(%ebp)
  8006a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a3:	ff d0                	call   *%eax
  8006a5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006a8:	ff 4d 1c             	decl   0x1c(%ebp)
  8006ab:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006af:	7f e6                	jg     800697 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006b1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006b4:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006bf:	53                   	push   %ebx
  8006c0:	51                   	push   %ecx
  8006c1:	52                   	push   %edx
  8006c2:	50                   	push   %eax
  8006c3:	e8 08 14 00 00       	call   801ad0 <__umoddi3>
  8006c8:	83 c4 10             	add    $0x10,%esp
  8006cb:	05 54 22 80 00       	add    $0x802254,%eax
  8006d0:	8a 00                	mov    (%eax),%al
  8006d2:	0f be c0             	movsbl %al,%eax
  8006d5:	83 ec 08             	sub    $0x8,%esp
  8006d8:	ff 75 0c             	pushl  0xc(%ebp)
  8006db:	50                   	push   %eax
  8006dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006df:	ff d0                	call   *%eax
  8006e1:	83 c4 10             	add    $0x10,%esp
}
  8006e4:	90                   	nop
  8006e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006e8:	c9                   	leave  
  8006e9:	c3                   	ret    

008006ea <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006ea:	55                   	push   %ebp
  8006eb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006ed:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006f1:	7e 1c                	jle    80070f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f6:	8b 00                	mov    (%eax),%eax
  8006f8:	8d 50 08             	lea    0x8(%eax),%edx
  8006fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fe:	89 10                	mov    %edx,(%eax)
  800700:	8b 45 08             	mov    0x8(%ebp),%eax
  800703:	8b 00                	mov    (%eax),%eax
  800705:	83 e8 08             	sub    $0x8,%eax
  800708:	8b 50 04             	mov    0x4(%eax),%edx
  80070b:	8b 00                	mov    (%eax),%eax
  80070d:	eb 40                	jmp    80074f <getuint+0x65>
	else if (lflag)
  80070f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800713:	74 1e                	je     800733 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800715:	8b 45 08             	mov    0x8(%ebp),%eax
  800718:	8b 00                	mov    (%eax),%eax
  80071a:	8d 50 04             	lea    0x4(%eax),%edx
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	89 10                	mov    %edx,(%eax)
  800722:	8b 45 08             	mov    0x8(%ebp),%eax
  800725:	8b 00                	mov    (%eax),%eax
  800727:	83 e8 04             	sub    $0x4,%eax
  80072a:	8b 00                	mov    (%eax),%eax
  80072c:	ba 00 00 00 00       	mov    $0x0,%edx
  800731:	eb 1c                	jmp    80074f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	8b 00                	mov    (%eax),%eax
  800738:	8d 50 04             	lea    0x4(%eax),%edx
  80073b:	8b 45 08             	mov    0x8(%ebp),%eax
  80073e:	89 10                	mov    %edx,(%eax)
  800740:	8b 45 08             	mov    0x8(%ebp),%eax
  800743:	8b 00                	mov    (%eax),%eax
  800745:	83 e8 04             	sub    $0x4,%eax
  800748:	8b 00                	mov    (%eax),%eax
  80074a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80074f:	5d                   	pop    %ebp
  800750:	c3                   	ret    

00800751 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800751:	55                   	push   %ebp
  800752:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800754:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800758:	7e 1c                	jle    800776 <getint+0x25>
		return va_arg(*ap, long long);
  80075a:	8b 45 08             	mov    0x8(%ebp),%eax
  80075d:	8b 00                	mov    (%eax),%eax
  80075f:	8d 50 08             	lea    0x8(%eax),%edx
  800762:	8b 45 08             	mov    0x8(%ebp),%eax
  800765:	89 10                	mov    %edx,(%eax)
  800767:	8b 45 08             	mov    0x8(%ebp),%eax
  80076a:	8b 00                	mov    (%eax),%eax
  80076c:	83 e8 08             	sub    $0x8,%eax
  80076f:	8b 50 04             	mov    0x4(%eax),%edx
  800772:	8b 00                	mov    (%eax),%eax
  800774:	eb 38                	jmp    8007ae <getint+0x5d>
	else if (lflag)
  800776:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80077a:	74 1a                	je     800796 <getint+0x45>
		return va_arg(*ap, long);
  80077c:	8b 45 08             	mov    0x8(%ebp),%eax
  80077f:	8b 00                	mov    (%eax),%eax
  800781:	8d 50 04             	lea    0x4(%eax),%edx
  800784:	8b 45 08             	mov    0x8(%ebp),%eax
  800787:	89 10                	mov    %edx,(%eax)
  800789:	8b 45 08             	mov    0x8(%ebp),%eax
  80078c:	8b 00                	mov    (%eax),%eax
  80078e:	83 e8 04             	sub    $0x4,%eax
  800791:	8b 00                	mov    (%eax),%eax
  800793:	99                   	cltd   
  800794:	eb 18                	jmp    8007ae <getint+0x5d>
	else
		return va_arg(*ap, int);
  800796:	8b 45 08             	mov    0x8(%ebp),%eax
  800799:	8b 00                	mov    (%eax),%eax
  80079b:	8d 50 04             	lea    0x4(%eax),%edx
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	89 10                	mov    %edx,(%eax)
  8007a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a6:	8b 00                	mov    (%eax),%eax
  8007a8:	83 e8 04             	sub    $0x4,%eax
  8007ab:	8b 00                	mov    (%eax),%eax
  8007ad:	99                   	cltd   
}
  8007ae:	5d                   	pop    %ebp
  8007af:	c3                   	ret    

008007b0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007b0:	55                   	push   %ebp
  8007b1:	89 e5                	mov    %esp,%ebp
  8007b3:	56                   	push   %esi
  8007b4:	53                   	push   %ebx
  8007b5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007b8:	eb 17                	jmp    8007d1 <vprintfmt+0x21>
			if (ch == '\0')
  8007ba:	85 db                	test   %ebx,%ebx
  8007bc:	0f 84 af 03 00 00    	je     800b71 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007c2:	83 ec 08             	sub    $0x8,%esp
  8007c5:	ff 75 0c             	pushl  0xc(%ebp)
  8007c8:	53                   	push   %ebx
  8007c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cc:	ff d0                	call   *%eax
  8007ce:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8007d4:	8d 50 01             	lea    0x1(%eax),%edx
  8007d7:	89 55 10             	mov    %edx,0x10(%ebp)
  8007da:	8a 00                	mov    (%eax),%al
  8007dc:	0f b6 d8             	movzbl %al,%ebx
  8007df:	83 fb 25             	cmp    $0x25,%ebx
  8007e2:	75 d6                	jne    8007ba <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007e4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007e8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007ef:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007f6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007fd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800804:	8b 45 10             	mov    0x10(%ebp),%eax
  800807:	8d 50 01             	lea    0x1(%eax),%edx
  80080a:	89 55 10             	mov    %edx,0x10(%ebp)
  80080d:	8a 00                	mov    (%eax),%al
  80080f:	0f b6 d8             	movzbl %al,%ebx
  800812:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800815:	83 f8 55             	cmp    $0x55,%eax
  800818:	0f 87 2b 03 00 00    	ja     800b49 <vprintfmt+0x399>
  80081e:	8b 04 85 78 22 80 00 	mov    0x802278(,%eax,4),%eax
  800825:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800827:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80082b:	eb d7                	jmp    800804 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80082d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800831:	eb d1                	jmp    800804 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800833:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80083a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80083d:	89 d0                	mov    %edx,%eax
  80083f:	c1 e0 02             	shl    $0x2,%eax
  800842:	01 d0                	add    %edx,%eax
  800844:	01 c0                	add    %eax,%eax
  800846:	01 d8                	add    %ebx,%eax
  800848:	83 e8 30             	sub    $0x30,%eax
  80084b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80084e:	8b 45 10             	mov    0x10(%ebp),%eax
  800851:	8a 00                	mov    (%eax),%al
  800853:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800856:	83 fb 2f             	cmp    $0x2f,%ebx
  800859:	7e 3e                	jle    800899 <vprintfmt+0xe9>
  80085b:	83 fb 39             	cmp    $0x39,%ebx
  80085e:	7f 39                	jg     800899 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800860:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800863:	eb d5                	jmp    80083a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800865:	8b 45 14             	mov    0x14(%ebp),%eax
  800868:	83 c0 04             	add    $0x4,%eax
  80086b:	89 45 14             	mov    %eax,0x14(%ebp)
  80086e:	8b 45 14             	mov    0x14(%ebp),%eax
  800871:	83 e8 04             	sub    $0x4,%eax
  800874:	8b 00                	mov    (%eax),%eax
  800876:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800879:	eb 1f                	jmp    80089a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80087b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80087f:	79 83                	jns    800804 <vprintfmt+0x54>
				width = 0;
  800881:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800888:	e9 77 ff ff ff       	jmp    800804 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80088d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800894:	e9 6b ff ff ff       	jmp    800804 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800899:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80089a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80089e:	0f 89 60 ff ff ff    	jns    800804 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008aa:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008b1:	e9 4e ff ff ff       	jmp    800804 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008b6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008b9:	e9 46 ff ff ff       	jmp    800804 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008be:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c1:	83 c0 04             	add    $0x4,%eax
  8008c4:	89 45 14             	mov    %eax,0x14(%ebp)
  8008c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ca:	83 e8 04             	sub    $0x4,%eax
  8008cd:	8b 00                	mov    (%eax),%eax
  8008cf:	83 ec 08             	sub    $0x8,%esp
  8008d2:	ff 75 0c             	pushl  0xc(%ebp)
  8008d5:	50                   	push   %eax
  8008d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d9:	ff d0                	call   *%eax
  8008db:	83 c4 10             	add    $0x10,%esp
			break;
  8008de:	e9 89 02 00 00       	jmp    800b6c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e6:	83 c0 04             	add    $0x4,%eax
  8008e9:	89 45 14             	mov    %eax,0x14(%ebp)
  8008ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ef:	83 e8 04             	sub    $0x4,%eax
  8008f2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008f4:	85 db                	test   %ebx,%ebx
  8008f6:	79 02                	jns    8008fa <vprintfmt+0x14a>
				err = -err;
  8008f8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008fa:	83 fb 64             	cmp    $0x64,%ebx
  8008fd:	7f 0b                	jg     80090a <vprintfmt+0x15a>
  8008ff:	8b 34 9d c0 20 80 00 	mov    0x8020c0(,%ebx,4),%esi
  800906:	85 f6                	test   %esi,%esi
  800908:	75 19                	jne    800923 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80090a:	53                   	push   %ebx
  80090b:	68 65 22 80 00       	push   $0x802265
  800910:	ff 75 0c             	pushl  0xc(%ebp)
  800913:	ff 75 08             	pushl  0x8(%ebp)
  800916:	e8 5e 02 00 00       	call   800b79 <printfmt>
  80091b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80091e:	e9 49 02 00 00       	jmp    800b6c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800923:	56                   	push   %esi
  800924:	68 6e 22 80 00       	push   $0x80226e
  800929:	ff 75 0c             	pushl  0xc(%ebp)
  80092c:	ff 75 08             	pushl  0x8(%ebp)
  80092f:	e8 45 02 00 00       	call   800b79 <printfmt>
  800934:	83 c4 10             	add    $0x10,%esp
			break;
  800937:	e9 30 02 00 00       	jmp    800b6c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80093c:	8b 45 14             	mov    0x14(%ebp),%eax
  80093f:	83 c0 04             	add    $0x4,%eax
  800942:	89 45 14             	mov    %eax,0x14(%ebp)
  800945:	8b 45 14             	mov    0x14(%ebp),%eax
  800948:	83 e8 04             	sub    $0x4,%eax
  80094b:	8b 30                	mov    (%eax),%esi
  80094d:	85 f6                	test   %esi,%esi
  80094f:	75 05                	jne    800956 <vprintfmt+0x1a6>
				p = "(null)";
  800951:	be 71 22 80 00       	mov    $0x802271,%esi
			if (width > 0 && padc != '-')
  800956:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80095a:	7e 6d                	jle    8009c9 <vprintfmt+0x219>
  80095c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800960:	74 67                	je     8009c9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800962:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800965:	83 ec 08             	sub    $0x8,%esp
  800968:	50                   	push   %eax
  800969:	56                   	push   %esi
  80096a:	e8 0c 03 00 00       	call   800c7b <strnlen>
  80096f:	83 c4 10             	add    $0x10,%esp
  800972:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800975:	eb 16                	jmp    80098d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800977:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80097b:	83 ec 08             	sub    $0x8,%esp
  80097e:	ff 75 0c             	pushl  0xc(%ebp)
  800981:	50                   	push   %eax
  800982:	8b 45 08             	mov    0x8(%ebp),%eax
  800985:	ff d0                	call   *%eax
  800987:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80098a:	ff 4d e4             	decl   -0x1c(%ebp)
  80098d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800991:	7f e4                	jg     800977 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800993:	eb 34                	jmp    8009c9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800995:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800999:	74 1c                	je     8009b7 <vprintfmt+0x207>
  80099b:	83 fb 1f             	cmp    $0x1f,%ebx
  80099e:	7e 05                	jle    8009a5 <vprintfmt+0x1f5>
  8009a0:	83 fb 7e             	cmp    $0x7e,%ebx
  8009a3:	7e 12                	jle    8009b7 <vprintfmt+0x207>
					putch('?', putdat);
  8009a5:	83 ec 08             	sub    $0x8,%esp
  8009a8:	ff 75 0c             	pushl  0xc(%ebp)
  8009ab:	6a 3f                	push   $0x3f
  8009ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b0:	ff d0                	call   *%eax
  8009b2:	83 c4 10             	add    $0x10,%esp
  8009b5:	eb 0f                	jmp    8009c6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009b7:	83 ec 08             	sub    $0x8,%esp
  8009ba:	ff 75 0c             	pushl  0xc(%ebp)
  8009bd:	53                   	push   %ebx
  8009be:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c1:	ff d0                	call   *%eax
  8009c3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009c6:	ff 4d e4             	decl   -0x1c(%ebp)
  8009c9:	89 f0                	mov    %esi,%eax
  8009cb:	8d 70 01             	lea    0x1(%eax),%esi
  8009ce:	8a 00                	mov    (%eax),%al
  8009d0:	0f be d8             	movsbl %al,%ebx
  8009d3:	85 db                	test   %ebx,%ebx
  8009d5:	74 24                	je     8009fb <vprintfmt+0x24b>
  8009d7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009db:	78 b8                	js     800995 <vprintfmt+0x1e5>
  8009dd:	ff 4d e0             	decl   -0x20(%ebp)
  8009e0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009e4:	79 af                	jns    800995 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009e6:	eb 13                	jmp    8009fb <vprintfmt+0x24b>
				putch(' ', putdat);
  8009e8:	83 ec 08             	sub    $0x8,%esp
  8009eb:	ff 75 0c             	pushl  0xc(%ebp)
  8009ee:	6a 20                	push   $0x20
  8009f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f3:	ff d0                	call   *%eax
  8009f5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009f8:	ff 4d e4             	decl   -0x1c(%ebp)
  8009fb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ff:	7f e7                	jg     8009e8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a01:	e9 66 01 00 00       	jmp    800b6c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a06:	83 ec 08             	sub    $0x8,%esp
  800a09:	ff 75 e8             	pushl  -0x18(%ebp)
  800a0c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a0f:	50                   	push   %eax
  800a10:	e8 3c fd ff ff       	call   800751 <getint>
  800a15:	83 c4 10             	add    $0x10,%esp
  800a18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a1b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a21:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a24:	85 d2                	test   %edx,%edx
  800a26:	79 23                	jns    800a4b <vprintfmt+0x29b>
				putch('-', putdat);
  800a28:	83 ec 08             	sub    $0x8,%esp
  800a2b:	ff 75 0c             	pushl  0xc(%ebp)
  800a2e:	6a 2d                	push   $0x2d
  800a30:	8b 45 08             	mov    0x8(%ebp),%eax
  800a33:	ff d0                	call   *%eax
  800a35:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a38:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a3e:	f7 d8                	neg    %eax
  800a40:	83 d2 00             	adc    $0x0,%edx
  800a43:	f7 da                	neg    %edx
  800a45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a48:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a4b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a52:	e9 bc 00 00 00       	jmp    800b13 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a57:	83 ec 08             	sub    $0x8,%esp
  800a5a:	ff 75 e8             	pushl  -0x18(%ebp)
  800a5d:	8d 45 14             	lea    0x14(%ebp),%eax
  800a60:	50                   	push   %eax
  800a61:	e8 84 fc ff ff       	call   8006ea <getuint>
  800a66:	83 c4 10             	add    $0x10,%esp
  800a69:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a6f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a76:	e9 98 00 00 00       	jmp    800b13 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a7b:	83 ec 08             	sub    $0x8,%esp
  800a7e:	ff 75 0c             	pushl  0xc(%ebp)
  800a81:	6a 58                	push   $0x58
  800a83:	8b 45 08             	mov    0x8(%ebp),%eax
  800a86:	ff d0                	call   *%eax
  800a88:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a8b:	83 ec 08             	sub    $0x8,%esp
  800a8e:	ff 75 0c             	pushl  0xc(%ebp)
  800a91:	6a 58                	push   $0x58
  800a93:	8b 45 08             	mov    0x8(%ebp),%eax
  800a96:	ff d0                	call   *%eax
  800a98:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a9b:	83 ec 08             	sub    $0x8,%esp
  800a9e:	ff 75 0c             	pushl  0xc(%ebp)
  800aa1:	6a 58                	push   $0x58
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	ff d0                	call   *%eax
  800aa8:	83 c4 10             	add    $0x10,%esp
			break;
  800aab:	e9 bc 00 00 00       	jmp    800b6c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ab0:	83 ec 08             	sub    $0x8,%esp
  800ab3:	ff 75 0c             	pushl  0xc(%ebp)
  800ab6:	6a 30                	push   $0x30
  800ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  800abb:	ff d0                	call   *%eax
  800abd:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ac0:	83 ec 08             	sub    $0x8,%esp
  800ac3:	ff 75 0c             	pushl  0xc(%ebp)
  800ac6:	6a 78                	push   $0x78
  800ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  800acb:	ff d0                	call   *%eax
  800acd:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ad0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad3:	83 c0 04             	add    $0x4,%eax
  800ad6:	89 45 14             	mov    %eax,0x14(%ebp)
  800ad9:	8b 45 14             	mov    0x14(%ebp),%eax
  800adc:	83 e8 04             	sub    $0x4,%eax
  800adf:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ae1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ae4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800aeb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800af2:	eb 1f                	jmp    800b13 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800af4:	83 ec 08             	sub    $0x8,%esp
  800af7:	ff 75 e8             	pushl  -0x18(%ebp)
  800afa:	8d 45 14             	lea    0x14(%ebp),%eax
  800afd:	50                   	push   %eax
  800afe:	e8 e7 fb ff ff       	call   8006ea <getuint>
  800b03:	83 c4 10             	add    $0x10,%esp
  800b06:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b09:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b0c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b13:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b17:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b1a:	83 ec 04             	sub    $0x4,%esp
  800b1d:	52                   	push   %edx
  800b1e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b21:	50                   	push   %eax
  800b22:	ff 75 f4             	pushl  -0xc(%ebp)
  800b25:	ff 75 f0             	pushl  -0x10(%ebp)
  800b28:	ff 75 0c             	pushl  0xc(%ebp)
  800b2b:	ff 75 08             	pushl  0x8(%ebp)
  800b2e:	e8 00 fb ff ff       	call   800633 <printnum>
  800b33:	83 c4 20             	add    $0x20,%esp
			break;
  800b36:	eb 34                	jmp    800b6c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b38:	83 ec 08             	sub    $0x8,%esp
  800b3b:	ff 75 0c             	pushl  0xc(%ebp)
  800b3e:	53                   	push   %ebx
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	ff d0                	call   *%eax
  800b44:	83 c4 10             	add    $0x10,%esp
			break;
  800b47:	eb 23                	jmp    800b6c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b49:	83 ec 08             	sub    $0x8,%esp
  800b4c:	ff 75 0c             	pushl  0xc(%ebp)
  800b4f:	6a 25                	push   $0x25
  800b51:	8b 45 08             	mov    0x8(%ebp),%eax
  800b54:	ff d0                	call   *%eax
  800b56:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b59:	ff 4d 10             	decl   0x10(%ebp)
  800b5c:	eb 03                	jmp    800b61 <vprintfmt+0x3b1>
  800b5e:	ff 4d 10             	decl   0x10(%ebp)
  800b61:	8b 45 10             	mov    0x10(%ebp),%eax
  800b64:	48                   	dec    %eax
  800b65:	8a 00                	mov    (%eax),%al
  800b67:	3c 25                	cmp    $0x25,%al
  800b69:	75 f3                	jne    800b5e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b6b:	90                   	nop
		}
	}
  800b6c:	e9 47 fc ff ff       	jmp    8007b8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b71:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b72:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b75:	5b                   	pop    %ebx
  800b76:	5e                   	pop    %esi
  800b77:	5d                   	pop    %ebp
  800b78:	c3                   	ret    

00800b79 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b79:	55                   	push   %ebp
  800b7a:	89 e5                	mov    %esp,%ebp
  800b7c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b7f:	8d 45 10             	lea    0x10(%ebp),%eax
  800b82:	83 c0 04             	add    $0x4,%eax
  800b85:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b88:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b8e:	50                   	push   %eax
  800b8f:	ff 75 0c             	pushl  0xc(%ebp)
  800b92:	ff 75 08             	pushl  0x8(%ebp)
  800b95:	e8 16 fc ff ff       	call   8007b0 <vprintfmt>
  800b9a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b9d:	90                   	nop
  800b9e:	c9                   	leave  
  800b9f:	c3                   	ret    

00800ba0 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ba0:	55                   	push   %ebp
  800ba1:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ba3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba6:	8b 40 08             	mov    0x8(%eax),%eax
  800ba9:	8d 50 01             	lea    0x1(%eax),%edx
  800bac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800baf:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb5:	8b 10                	mov    (%eax),%edx
  800bb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bba:	8b 40 04             	mov    0x4(%eax),%eax
  800bbd:	39 c2                	cmp    %eax,%edx
  800bbf:	73 12                	jae    800bd3 <sprintputch+0x33>
		*b->buf++ = ch;
  800bc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc4:	8b 00                	mov    (%eax),%eax
  800bc6:	8d 48 01             	lea    0x1(%eax),%ecx
  800bc9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bcc:	89 0a                	mov    %ecx,(%edx)
  800bce:	8b 55 08             	mov    0x8(%ebp),%edx
  800bd1:	88 10                	mov    %dl,(%eax)
}
  800bd3:	90                   	nop
  800bd4:	5d                   	pop    %ebp
  800bd5:	c3                   	ret    

00800bd6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bd6:	55                   	push   %ebp
  800bd7:	89 e5                	mov    %esp,%ebp
  800bd9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800be2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be8:	8b 45 08             	mov    0x8(%ebp),%eax
  800beb:	01 d0                	add    %edx,%eax
  800bed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bf7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bfb:	74 06                	je     800c03 <vsnprintf+0x2d>
  800bfd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c01:	7f 07                	jg     800c0a <vsnprintf+0x34>
		return -E_INVAL;
  800c03:	b8 03 00 00 00       	mov    $0x3,%eax
  800c08:	eb 20                	jmp    800c2a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c0a:	ff 75 14             	pushl  0x14(%ebp)
  800c0d:	ff 75 10             	pushl  0x10(%ebp)
  800c10:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c13:	50                   	push   %eax
  800c14:	68 a0 0b 80 00       	push   $0x800ba0
  800c19:	e8 92 fb ff ff       	call   8007b0 <vprintfmt>
  800c1e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c21:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c24:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c27:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c2a:	c9                   	leave  
  800c2b:	c3                   	ret    

00800c2c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c2c:	55                   	push   %ebp
  800c2d:	89 e5                	mov    %esp,%ebp
  800c2f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c32:	8d 45 10             	lea    0x10(%ebp),%eax
  800c35:	83 c0 04             	add    $0x4,%eax
  800c38:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c41:	50                   	push   %eax
  800c42:	ff 75 0c             	pushl  0xc(%ebp)
  800c45:	ff 75 08             	pushl  0x8(%ebp)
  800c48:	e8 89 ff ff ff       	call   800bd6 <vsnprintf>
  800c4d:	83 c4 10             	add    $0x10,%esp
  800c50:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c53:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c56:	c9                   	leave  
  800c57:	c3                   	ret    

00800c58 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c58:	55                   	push   %ebp
  800c59:	89 e5                	mov    %esp,%ebp
  800c5b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c5e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c65:	eb 06                	jmp    800c6d <strlen+0x15>
		n++;
  800c67:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c6a:	ff 45 08             	incl   0x8(%ebp)
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	8a 00                	mov    (%eax),%al
  800c72:	84 c0                	test   %al,%al
  800c74:	75 f1                	jne    800c67 <strlen+0xf>
		n++;
	return n;
  800c76:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c79:	c9                   	leave  
  800c7a:	c3                   	ret    

00800c7b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c7b:	55                   	push   %ebp
  800c7c:	89 e5                	mov    %esp,%ebp
  800c7e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c81:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c88:	eb 09                	jmp    800c93 <strnlen+0x18>
		n++;
  800c8a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c8d:	ff 45 08             	incl   0x8(%ebp)
  800c90:	ff 4d 0c             	decl   0xc(%ebp)
  800c93:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c97:	74 09                	je     800ca2 <strnlen+0x27>
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	8a 00                	mov    (%eax),%al
  800c9e:	84 c0                	test   %al,%al
  800ca0:	75 e8                	jne    800c8a <strnlen+0xf>
		n++;
	return n;
  800ca2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ca5:	c9                   	leave  
  800ca6:	c3                   	ret    

00800ca7 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ca7:	55                   	push   %ebp
  800ca8:	89 e5                	mov    %esp,%ebp
  800caa:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cb3:	90                   	nop
  800cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb7:	8d 50 01             	lea    0x1(%eax),%edx
  800cba:	89 55 08             	mov    %edx,0x8(%ebp)
  800cbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cc0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cc3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cc6:	8a 12                	mov    (%edx),%dl
  800cc8:	88 10                	mov    %dl,(%eax)
  800cca:	8a 00                	mov    (%eax),%al
  800ccc:	84 c0                	test   %al,%al
  800cce:	75 e4                	jne    800cb4 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cd3:	c9                   	leave  
  800cd4:	c3                   	ret    

00800cd5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cd5:	55                   	push   %ebp
  800cd6:	89 e5                	mov    %esp,%ebp
  800cd8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ce1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ce8:	eb 1f                	jmp    800d09 <strncpy+0x34>
		*dst++ = *src;
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	8d 50 01             	lea    0x1(%eax),%edx
  800cf0:	89 55 08             	mov    %edx,0x8(%ebp)
  800cf3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf6:	8a 12                	mov    (%edx),%dl
  800cf8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cfa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfd:	8a 00                	mov    (%eax),%al
  800cff:	84 c0                	test   %al,%al
  800d01:	74 03                	je     800d06 <strncpy+0x31>
			src++;
  800d03:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d06:	ff 45 fc             	incl   -0x4(%ebp)
  800d09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d0c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d0f:	72 d9                	jb     800cea <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d11:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d14:	c9                   	leave  
  800d15:	c3                   	ret    

00800d16 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d16:	55                   	push   %ebp
  800d17:	89 e5                	mov    %esp,%ebp
  800d19:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d26:	74 30                	je     800d58 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d28:	eb 16                	jmp    800d40 <strlcpy+0x2a>
			*dst++ = *src++;
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8d 50 01             	lea    0x1(%eax),%edx
  800d30:	89 55 08             	mov    %edx,0x8(%ebp)
  800d33:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d36:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d39:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d3c:	8a 12                	mov    (%edx),%dl
  800d3e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d40:	ff 4d 10             	decl   0x10(%ebp)
  800d43:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d47:	74 09                	je     800d52 <strlcpy+0x3c>
  800d49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4c:	8a 00                	mov    (%eax),%al
  800d4e:	84 c0                	test   %al,%al
  800d50:	75 d8                	jne    800d2a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d58:	8b 55 08             	mov    0x8(%ebp),%edx
  800d5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5e:	29 c2                	sub    %eax,%edx
  800d60:	89 d0                	mov    %edx,%eax
}
  800d62:	c9                   	leave  
  800d63:	c3                   	ret    

00800d64 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d64:	55                   	push   %ebp
  800d65:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d67:	eb 06                	jmp    800d6f <strcmp+0xb>
		p++, q++;
  800d69:	ff 45 08             	incl   0x8(%ebp)
  800d6c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d72:	8a 00                	mov    (%eax),%al
  800d74:	84 c0                	test   %al,%al
  800d76:	74 0e                	je     800d86 <strcmp+0x22>
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	8a 10                	mov    (%eax),%dl
  800d7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d80:	8a 00                	mov    (%eax),%al
  800d82:	38 c2                	cmp    %al,%dl
  800d84:	74 e3                	je     800d69 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d86:	8b 45 08             	mov    0x8(%ebp),%eax
  800d89:	8a 00                	mov    (%eax),%al
  800d8b:	0f b6 d0             	movzbl %al,%edx
  800d8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d91:	8a 00                	mov    (%eax),%al
  800d93:	0f b6 c0             	movzbl %al,%eax
  800d96:	29 c2                	sub    %eax,%edx
  800d98:	89 d0                	mov    %edx,%eax
}
  800d9a:	5d                   	pop    %ebp
  800d9b:	c3                   	ret    

00800d9c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d9c:	55                   	push   %ebp
  800d9d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d9f:	eb 09                	jmp    800daa <strncmp+0xe>
		n--, p++, q++;
  800da1:	ff 4d 10             	decl   0x10(%ebp)
  800da4:	ff 45 08             	incl   0x8(%ebp)
  800da7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800daa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dae:	74 17                	je     800dc7 <strncmp+0x2b>
  800db0:	8b 45 08             	mov    0x8(%ebp),%eax
  800db3:	8a 00                	mov    (%eax),%al
  800db5:	84 c0                	test   %al,%al
  800db7:	74 0e                	je     800dc7 <strncmp+0x2b>
  800db9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbc:	8a 10                	mov    (%eax),%dl
  800dbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc1:	8a 00                	mov    (%eax),%al
  800dc3:	38 c2                	cmp    %al,%dl
  800dc5:	74 da                	je     800da1 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dc7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dcb:	75 07                	jne    800dd4 <strncmp+0x38>
		return 0;
  800dcd:	b8 00 00 00 00       	mov    $0x0,%eax
  800dd2:	eb 14                	jmp    800de8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	8a 00                	mov    (%eax),%al
  800dd9:	0f b6 d0             	movzbl %al,%edx
  800ddc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddf:	8a 00                	mov    (%eax),%al
  800de1:	0f b6 c0             	movzbl %al,%eax
  800de4:	29 c2                	sub    %eax,%edx
  800de6:	89 d0                	mov    %edx,%eax
}
  800de8:	5d                   	pop    %ebp
  800de9:	c3                   	ret    

00800dea <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800dea:	55                   	push   %ebp
  800deb:	89 e5                	mov    %esp,%ebp
  800ded:	83 ec 04             	sub    $0x4,%esp
  800df0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800df6:	eb 12                	jmp    800e0a <strchr+0x20>
		if (*s == c)
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	8a 00                	mov    (%eax),%al
  800dfd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e00:	75 05                	jne    800e07 <strchr+0x1d>
			return (char *) s;
  800e02:	8b 45 08             	mov    0x8(%ebp),%eax
  800e05:	eb 11                	jmp    800e18 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e07:	ff 45 08             	incl   0x8(%ebp)
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	8a 00                	mov    (%eax),%al
  800e0f:	84 c0                	test   %al,%al
  800e11:	75 e5                	jne    800df8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e13:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e18:	c9                   	leave  
  800e19:	c3                   	ret    

00800e1a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e1a:	55                   	push   %ebp
  800e1b:	89 e5                	mov    %esp,%ebp
  800e1d:	83 ec 04             	sub    $0x4,%esp
  800e20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e23:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e26:	eb 0d                	jmp    800e35 <strfind+0x1b>
		if (*s == c)
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	8a 00                	mov    (%eax),%al
  800e2d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e30:	74 0e                	je     800e40 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e32:	ff 45 08             	incl   0x8(%ebp)
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	8a 00                	mov    (%eax),%al
  800e3a:	84 c0                	test   %al,%al
  800e3c:	75 ea                	jne    800e28 <strfind+0xe>
  800e3e:	eb 01                	jmp    800e41 <strfind+0x27>
		if (*s == c)
			break;
  800e40:	90                   	nop
	return (char *) s;
  800e41:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e44:	c9                   	leave  
  800e45:	c3                   	ret    

00800e46 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e46:	55                   	push   %ebp
  800e47:	89 e5                	mov    %esp,%ebp
  800e49:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e52:	8b 45 10             	mov    0x10(%ebp),%eax
  800e55:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e58:	eb 0e                	jmp    800e68 <memset+0x22>
		*p++ = c;
  800e5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e5d:	8d 50 01             	lea    0x1(%eax),%edx
  800e60:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e63:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e66:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e68:	ff 4d f8             	decl   -0x8(%ebp)
  800e6b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e6f:	79 e9                	jns    800e5a <memset+0x14>
		*p++ = c;

	return v;
  800e71:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e74:	c9                   	leave  
  800e75:	c3                   	ret    

00800e76 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e76:	55                   	push   %ebp
  800e77:	89 e5                	mov    %esp,%ebp
  800e79:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e88:	eb 16                	jmp    800ea0 <memcpy+0x2a>
		*d++ = *s++;
  800e8a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e8d:	8d 50 01             	lea    0x1(%eax),%edx
  800e90:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e93:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e96:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e99:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e9c:	8a 12                	mov    (%edx),%dl
  800e9e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ea0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea6:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea9:	85 c0                	test   %eax,%eax
  800eab:	75 dd                	jne    800e8a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ead:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eb0:	c9                   	leave  
  800eb1:	c3                   	ret    

00800eb2 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800eb2:	55                   	push   %ebp
  800eb3:	89 e5                	mov    %esp,%ebp
  800eb5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800eb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ebe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ec4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800eca:	73 50                	jae    800f1c <memmove+0x6a>
  800ecc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ecf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed2:	01 d0                	add    %edx,%eax
  800ed4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ed7:	76 43                	jbe    800f1c <memmove+0x6a>
		s += n;
  800ed9:	8b 45 10             	mov    0x10(%ebp),%eax
  800edc:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800edf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ee5:	eb 10                	jmp    800ef7 <memmove+0x45>
			*--d = *--s;
  800ee7:	ff 4d f8             	decl   -0x8(%ebp)
  800eea:	ff 4d fc             	decl   -0x4(%ebp)
  800eed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef0:	8a 10                	mov    (%eax),%dl
  800ef2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ef7:	8b 45 10             	mov    0x10(%ebp),%eax
  800efa:	8d 50 ff             	lea    -0x1(%eax),%edx
  800efd:	89 55 10             	mov    %edx,0x10(%ebp)
  800f00:	85 c0                	test   %eax,%eax
  800f02:	75 e3                	jne    800ee7 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f04:	eb 23                	jmp    800f29 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f06:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f09:	8d 50 01             	lea    0x1(%eax),%edx
  800f0c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f0f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f12:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f15:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f18:	8a 12                	mov    (%edx),%dl
  800f1a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f1c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f22:	89 55 10             	mov    %edx,0x10(%ebp)
  800f25:	85 c0                	test   %eax,%eax
  800f27:	75 dd                	jne    800f06 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f29:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f2c:	c9                   	leave  
  800f2d:	c3                   	ret    

00800f2e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f2e:	55                   	push   %ebp
  800f2f:	89 e5                	mov    %esp,%ebp
  800f31:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f40:	eb 2a                	jmp    800f6c <memcmp+0x3e>
		if (*s1 != *s2)
  800f42:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f45:	8a 10                	mov    (%eax),%dl
  800f47:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f4a:	8a 00                	mov    (%eax),%al
  800f4c:	38 c2                	cmp    %al,%dl
  800f4e:	74 16                	je     800f66 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f50:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	0f b6 d0             	movzbl %al,%edx
  800f58:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f5b:	8a 00                	mov    (%eax),%al
  800f5d:	0f b6 c0             	movzbl %al,%eax
  800f60:	29 c2                	sub    %eax,%edx
  800f62:	89 d0                	mov    %edx,%eax
  800f64:	eb 18                	jmp    800f7e <memcmp+0x50>
		s1++, s2++;
  800f66:	ff 45 fc             	incl   -0x4(%ebp)
  800f69:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f72:	89 55 10             	mov    %edx,0x10(%ebp)
  800f75:	85 c0                	test   %eax,%eax
  800f77:	75 c9                	jne    800f42 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f79:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f7e:	c9                   	leave  
  800f7f:	c3                   	ret    

00800f80 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f80:	55                   	push   %ebp
  800f81:	89 e5                	mov    %esp,%ebp
  800f83:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f86:	8b 55 08             	mov    0x8(%ebp),%edx
  800f89:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8c:	01 d0                	add    %edx,%eax
  800f8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f91:	eb 15                	jmp    800fa8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	0f b6 d0             	movzbl %al,%edx
  800f9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9e:	0f b6 c0             	movzbl %al,%eax
  800fa1:	39 c2                	cmp    %eax,%edx
  800fa3:	74 0d                	je     800fb2 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fa5:	ff 45 08             	incl   0x8(%ebp)
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fae:	72 e3                	jb     800f93 <memfind+0x13>
  800fb0:	eb 01                	jmp    800fb3 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fb2:	90                   	nop
	return (void *) s;
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fb6:	c9                   	leave  
  800fb7:	c3                   	ret    

00800fb8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fb8:	55                   	push   %ebp
  800fb9:	89 e5                	mov    %esp,%ebp
  800fbb:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fbe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fc5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fcc:	eb 03                	jmp    800fd1 <strtol+0x19>
		s++;
  800fce:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	3c 20                	cmp    $0x20,%al
  800fd8:	74 f4                	je     800fce <strtol+0x16>
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	3c 09                	cmp    $0x9,%al
  800fe1:	74 eb                	je     800fce <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	3c 2b                	cmp    $0x2b,%al
  800fea:	75 05                	jne    800ff1 <strtol+0x39>
		s++;
  800fec:	ff 45 08             	incl   0x8(%ebp)
  800fef:	eb 13                	jmp    801004 <strtol+0x4c>
	else if (*s == '-')
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff4:	8a 00                	mov    (%eax),%al
  800ff6:	3c 2d                	cmp    $0x2d,%al
  800ff8:	75 0a                	jne    801004 <strtol+0x4c>
		s++, neg = 1;
  800ffa:	ff 45 08             	incl   0x8(%ebp)
  800ffd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801004:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801008:	74 06                	je     801010 <strtol+0x58>
  80100a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80100e:	75 20                	jne    801030 <strtol+0x78>
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	8a 00                	mov    (%eax),%al
  801015:	3c 30                	cmp    $0x30,%al
  801017:	75 17                	jne    801030 <strtol+0x78>
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
  80101c:	40                   	inc    %eax
  80101d:	8a 00                	mov    (%eax),%al
  80101f:	3c 78                	cmp    $0x78,%al
  801021:	75 0d                	jne    801030 <strtol+0x78>
		s += 2, base = 16;
  801023:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801027:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80102e:	eb 28                	jmp    801058 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801030:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801034:	75 15                	jne    80104b <strtol+0x93>
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	8a 00                	mov    (%eax),%al
  80103b:	3c 30                	cmp    $0x30,%al
  80103d:	75 0c                	jne    80104b <strtol+0x93>
		s++, base = 8;
  80103f:	ff 45 08             	incl   0x8(%ebp)
  801042:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801049:	eb 0d                	jmp    801058 <strtol+0xa0>
	else if (base == 0)
  80104b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80104f:	75 07                	jne    801058 <strtol+0xa0>
		base = 10;
  801051:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801058:	8b 45 08             	mov    0x8(%ebp),%eax
  80105b:	8a 00                	mov    (%eax),%al
  80105d:	3c 2f                	cmp    $0x2f,%al
  80105f:	7e 19                	jle    80107a <strtol+0xc2>
  801061:	8b 45 08             	mov    0x8(%ebp),%eax
  801064:	8a 00                	mov    (%eax),%al
  801066:	3c 39                	cmp    $0x39,%al
  801068:	7f 10                	jg     80107a <strtol+0xc2>
			dig = *s - '0';
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	0f be c0             	movsbl %al,%eax
  801072:	83 e8 30             	sub    $0x30,%eax
  801075:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801078:	eb 42                	jmp    8010bc <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80107a:	8b 45 08             	mov    0x8(%ebp),%eax
  80107d:	8a 00                	mov    (%eax),%al
  80107f:	3c 60                	cmp    $0x60,%al
  801081:	7e 19                	jle    80109c <strtol+0xe4>
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	8a 00                	mov    (%eax),%al
  801088:	3c 7a                	cmp    $0x7a,%al
  80108a:	7f 10                	jg     80109c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	8a 00                	mov    (%eax),%al
  801091:	0f be c0             	movsbl %al,%eax
  801094:	83 e8 57             	sub    $0x57,%eax
  801097:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80109a:	eb 20                	jmp    8010bc <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80109c:	8b 45 08             	mov    0x8(%ebp),%eax
  80109f:	8a 00                	mov    (%eax),%al
  8010a1:	3c 40                	cmp    $0x40,%al
  8010a3:	7e 39                	jle    8010de <strtol+0x126>
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	8a 00                	mov    (%eax),%al
  8010aa:	3c 5a                	cmp    $0x5a,%al
  8010ac:	7f 30                	jg     8010de <strtol+0x126>
			dig = *s - 'A' + 10;
  8010ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b1:	8a 00                	mov    (%eax),%al
  8010b3:	0f be c0             	movsbl %al,%eax
  8010b6:	83 e8 37             	sub    $0x37,%eax
  8010b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010bf:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010c2:	7d 19                	jge    8010dd <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010c4:	ff 45 08             	incl   0x8(%ebp)
  8010c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ca:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010ce:	89 c2                	mov    %eax,%edx
  8010d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010d3:	01 d0                	add    %edx,%eax
  8010d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010d8:	e9 7b ff ff ff       	jmp    801058 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010dd:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010e2:	74 08                	je     8010ec <strtol+0x134>
		*endptr = (char *) s;
  8010e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8010ea:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010ec:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010f0:	74 07                	je     8010f9 <strtol+0x141>
  8010f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f5:	f7 d8                	neg    %eax
  8010f7:	eb 03                	jmp    8010fc <strtol+0x144>
  8010f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010fc:	c9                   	leave  
  8010fd:	c3                   	ret    

008010fe <ltostr>:

void
ltostr(long value, char *str)
{
  8010fe:	55                   	push   %ebp
  8010ff:	89 e5                	mov    %esp,%ebp
  801101:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801104:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80110b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801112:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801116:	79 13                	jns    80112b <ltostr+0x2d>
	{
		neg = 1;
  801118:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80111f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801122:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801125:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801128:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
  80112e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801133:	99                   	cltd   
  801134:	f7 f9                	idiv   %ecx
  801136:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801139:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80113c:	8d 50 01             	lea    0x1(%eax),%edx
  80113f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801142:	89 c2                	mov    %eax,%edx
  801144:	8b 45 0c             	mov    0xc(%ebp),%eax
  801147:	01 d0                	add    %edx,%eax
  801149:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80114c:	83 c2 30             	add    $0x30,%edx
  80114f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801151:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801154:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801159:	f7 e9                	imul   %ecx
  80115b:	c1 fa 02             	sar    $0x2,%edx
  80115e:	89 c8                	mov    %ecx,%eax
  801160:	c1 f8 1f             	sar    $0x1f,%eax
  801163:	29 c2                	sub    %eax,%edx
  801165:	89 d0                	mov    %edx,%eax
  801167:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80116a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80116d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801172:	f7 e9                	imul   %ecx
  801174:	c1 fa 02             	sar    $0x2,%edx
  801177:	89 c8                	mov    %ecx,%eax
  801179:	c1 f8 1f             	sar    $0x1f,%eax
  80117c:	29 c2                	sub    %eax,%edx
  80117e:	89 d0                	mov    %edx,%eax
  801180:	c1 e0 02             	shl    $0x2,%eax
  801183:	01 d0                	add    %edx,%eax
  801185:	01 c0                	add    %eax,%eax
  801187:	29 c1                	sub    %eax,%ecx
  801189:	89 ca                	mov    %ecx,%edx
  80118b:	85 d2                	test   %edx,%edx
  80118d:	75 9c                	jne    80112b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80118f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801196:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801199:	48                   	dec    %eax
  80119a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80119d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011a1:	74 3d                	je     8011e0 <ltostr+0xe2>
		start = 1 ;
  8011a3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011aa:	eb 34                	jmp    8011e0 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b2:	01 d0                	add    %edx,%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bf:	01 c2                	add    %eax,%edx
  8011c1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c7:	01 c8                	add    %ecx,%eax
  8011c9:	8a 00                	mov    (%eax),%al
  8011cb:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011cd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d3:	01 c2                	add    %eax,%edx
  8011d5:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011d8:	88 02                	mov    %al,(%edx)
		start++ ;
  8011da:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011dd:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011e3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011e6:	7c c4                	jl     8011ac <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011e8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ee:	01 d0                	add    %edx,%eax
  8011f0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011f3:	90                   	nop
  8011f4:	c9                   	leave  
  8011f5:	c3                   	ret    

008011f6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011f6:	55                   	push   %ebp
  8011f7:	89 e5                	mov    %esp,%ebp
  8011f9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011fc:	ff 75 08             	pushl  0x8(%ebp)
  8011ff:	e8 54 fa ff ff       	call   800c58 <strlen>
  801204:	83 c4 04             	add    $0x4,%esp
  801207:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80120a:	ff 75 0c             	pushl  0xc(%ebp)
  80120d:	e8 46 fa ff ff       	call   800c58 <strlen>
  801212:	83 c4 04             	add    $0x4,%esp
  801215:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801218:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80121f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801226:	eb 17                	jmp    80123f <strcconcat+0x49>
		final[s] = str1[s] ;
  801228:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80122b:	8b 45 10             	mov    0x10(%ebp),%eax
  80122e:	01 c2                	add    %eax,%edx
  801230:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801233:	8b 45 08             	mov    0x8(%ebp),%eax
  801236:	01 c8                	add    %ecx,%eax
  801238:	8a 00                	mov    (%eax),%al
  80123a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80123c:	ff 45 fc             	incl   -0x4(%ebp)
  80123f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801242:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801245:	7c e1                	jl     801228 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801247:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80124e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801255:	eb 1f                	jmp    801276 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801257:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80125a:	8d 50 01             	lea    0x1(%eax),%edx
  80125d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801260:	89 c2                	mov    %eax,%edx
  801262:	8b 45 10             	mov    0x10(%ebp),%eax
  801265:	01 c2                	add    %eax,%edx
  801267:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80126a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126d:	01 c8                	add    %ecx,%eax
  80126f:	8a 00                	mov    (%eax),%al
  801271:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801273:	ff 45 f8             	incl   -0x8(%ebp)
  801276:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801279:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80127c:	7c d9                	jl     801257 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80127e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801281:	8b 45 10             	mov    0x10(%ebp),%eax
  801284:	01 d0                	add    %edx,%eax
  801286:	c6 00 00             	movb   $0x0,(%eax)
}
  801289:	90                   	nop
  80128a:	c9                   	leave  
  80128b:	c3                   	ret    

0080128c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80128c:	55                   	push   %ebp
  80128d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80128f:	8b 45 14             	mov    0x14(%ebp),%eax
  801292:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801298:	8b 45 14             	mov    0x14(%ebp),%eax
  80129b:	8b 00                	mov    (%eax),%eax
  80129d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a7:	01 d0                	add    %edx,%eax
  8012a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012af:	eb 0c                	jmp    8012bd <strsplit+0x31>
			*string++ = 0;
  8012b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b4:	8d 50 01             	lea    0x1(%eax),%edx
  8012b7:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ba:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	8a 00                	mov    (%eax),%al
  8012c2:	84 c0                	test   %al,%al
  8012c4:	74 18                	je     8012de <strsplit+0x52>
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c9:	8a 00                	mov    (%eax),%al
  8012cb:	0f be c0             	movsbl %al,%eax
  8012ce:	50                   	push   %eax
  8012cf:	ff 75 0c             	pushl  0xc(%ebp)
  8012d2:	e8 13 fb ff ff       	call   800dea <strchr>
  8012d7:	83 c4 08             	add    $0x8,%esp
  8012da:	85 c0                	test   %eax,%eax
  8012dc:	75 d3                	jne    8012b1 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8012de:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e1:	8a 00                	mov    (%eax),%al
  8012e3:	84 c0                	test   %al,%al
  8012e5:	74 5a                	je     801341 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8012e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ea:	8b 00                	mov    (%eax),%eax
  8012ec:	83 f8 0f             	cmp    $0xf,%eax
  8012ef:	75 07                	jne    8012f8 <strsplit+0x6c>
		{
			return 0;
  8012f1:	b8 00 00 00 00       	mov    $0x0,%eax
  8012f6:	eb 66                	jmp    80135e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8012fb:	8b 00                	mov    (%eax),%eax
  8012fd:	8d 48 01             	lea    0x1(%eax),%ecx
  801300:	8b 55 14             	mov    0x14(%ebp),%edx
  801303:	89 0a                	mov    %ecx,(%edx)
  801305:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80130c:	8b 45 10             	mov    0x10(%ebp),%eax
  80130f:	01 c2                	add    %eax,%edx
  801311:	8b 45 08             	mov    0x8(%ebp),%eax
  801314:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801316:	eb 03                	jmp    80131b <strsplit+0x8f>
			string++;
  801318:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80131b:	8b 45 08             	mov    0x8(%ebp),%eax
  80131e:	8a 00                	mov    (%eax),%al
  801320:	84 c0                	test   %al,%al
  801322:	74 8b                	je     8012af <strsplit+0x23>
  801324:	8b 45 08             	mov    0x8(%ebp),%eax
  801327:	8a 00                	mov    (%eax),%al
  801329:	0f be c0             	movsbl %al,%eax
  80132c:	50                   	push   %eax
  80132d:	ff 75 0c             	pushl  0xc(%ebp)
  801330:	e8 b5 fa ff ff       	call   800dea <strchr>
  801335:	83 c4 08             	add    $0x8,%esp
  801338:	85 c0                	test   %eax,%eax
  80133a:	74 dc                	je     801318 <strsplit+0x8c>
			string++;
	}
  80133c:	e9 6e ff ff ff       	jmp    8012af <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801341:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801342:	8b 45 14             	mov    0x14(%ebp),%eax
  801345:	8b 00                	mov    (%eax),%eax
  801347:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80134e:	8b 45 10             	mov    0x10(%ebp),%eax
  801351:	01 d0                	add    %edx,%eax
  801353:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801359:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80135e:	c9                   	leave  
  80135f:	c3                   	ret    

00801360 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801360:	55                   	push   %ebp
  801361:	89 e5                	mov    %esp,%ebp
  801363:	57                   	push   %edi
  801364:	56                   	push   %esi
  801365:	53                   	push   %ebx
  801366:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801369:	8b 45 08             	mov    0x8(%ebp),%eax
  80136c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801372:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801375:	8b 7d 18             	mov    0x18(%ebp),%edi
  801378:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80137b:	cd 30                	int    $0x30
  80137d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801380:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801383:	83 c4 10             	add    $0x10,%esp
  801386:	5b                   	pop    %ebx
  801387:	5e                   	pop    %esi
  801388:	5f                   	pop    %edi
  801389:	5d                   	pop    %ebp
  80138a:	c3                   	ret    

0080138b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80138b:	55                   	push   %ebp
  80138c:	89 e5                	mov    %esp,%ebp
  80138e:	83 ec 04             	sub    $0x4,%esp
  801391:	8b 45 10             	mov    0x10(%ebp),%eax
  801394:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801397:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 00                	push   $0x0
  8013a2:	52                   	push   %edx
  8013a3:	ff 75 0c             	pushl  0xc(%ebp)
  8013a6:	50                   	push   %eax
  8013a7:	6a 00                	push   $0x0
  8013a9:	e8 b2 ff ff ff       	call   801360 <syscall>
  8013ae:	83 c4 18             	add    $0x18,%esp
}
  8013b1:	90                   	nop
  8013b2:	c9                   	leave  
  8013b3:	c3                   	ret    

008013b4 <sys_cgetc>:

int
sys_cgetc(void)
{
  8013b4:	55                   	push   %ebp
  8013b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 01                	push   $0x1
  8013c3:	e8 98 ff ff ff       	call   801360 <syscall>
  8013c8:	83 c4 18             	add    $0x18,%esp
}
  8013cb:	c9                   	leave  
  8013cc:	c3                   	ret    

008013cd <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8013cd:	55                   	push   %ebp
  8013ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8013d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 00                	push   $0x0
  8013d9:	6a 00                	push   $0x0
  8013db:	50                   	push   %eax
  8013dc:	6a 05                	push   $0x5
  8013de:	e8 7d ff ff ff       	call   801360 <syscall>
  8013e3:	83 c4 18             	add    $0x18,%esp
}
  8013e6:	c9                   	leave  
  8013e7:	c3                   	ret    

008013e8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013e8:	55                   	push   %ebp
  8013e9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 02                	push   $0x2
  8013f7:	e8 64 ff ff ff       	call   801360 <syscall>
  8013fc:	83 c4 18             	add    $0x18,%esp
}
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	6a 03                	push   $0x3
  801410:	e8 4b ff ff ff       	call   801360 <syscall>
  801415:	83 c4 18             	add    $0x18,%esp
}
  801418:	c9                   	leave  
  801419:	c3                   	ret    

0080141a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80141a:	55                   	push   %ebp
  80141b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 04                	push   $0x4
  801429:	e8 32 ff ff ff       	call   801360 <syscall>
  80142e:	83 c4 18             	add    $0x18,%esp
}
  801431:	c9                   	leave  
  801432:	c3                   	ret    

00801433 <sys_env_exit>:


void sys_env_exit(void)
{
  801433:	55                   	push   %ebp
  801434:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 06                	push   $0x6
  801442:	e8 19 ff ff ff       	call   801360 <syscall>
  801447:	83 c4 18             	add    $0x18,%esp
}
  80144a:	90                   	nop
  80144b:	c9                   	leave  
  80144c:	c3                   	ret    

0080144d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80144d:	55                   	push   %ebp
  80144e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801450:	8b 55 0c             	mov    0xc(%ebp),%edx
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	52                   	push   %edx
  80145d:	50                   	push   %eax
  80145e:	6a 07                	push   $0x7
  801460:	e8 fb fe ff ff       	call   801360 <syscall>
  801465:	83 c4 18             	add    $0x18,%esp
}
  801468:	c9                   	leave  
  801469:	c3                   	ret    

0080146a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80146a:	55                   	push   %ebp
  80146b:	89 e5                	mov    %esp,%ebp
  80146d:	56                   	push   %esi
  80146e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80146f:	8b 75 18             	mov    0x18(%ebp),%esi
  801472:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801475:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801478:	8b 55 0c             	mov    0xc(%ebp),%edx
  80147b:	8b 45 08             	mov    0x8(%ebp),%eax
  80147e:	56                   	push   %esi
  80147f:	53                   	push   %ebx
  801480:	51                   	push   %ecx
  801481:	52                   	push   %edx
  801482:	50                   	push   %eax
  801483:	6a 08                	push   $0x8
  801485:	e8 d6 fe ff ff       	call   801360 <syscall>
  80148a:	83 c4 18             	add    $0x18,%esp
}
  80148d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801490:	5b                   	pop    %ebx
  801491:	5e                   	pop    %esi
  801492:	5d                   	pop    %ebp
  801493:	c3                   	ret    

00801494 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801497:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	52                   	push   %edx
  8014a4:	50                   	push   %eax
  8014a5:	6a 09                	push   $0x9
  8014a7:	e8 b4 fe ff ff       	call   801360 <syscall>
  8014ac:	83 c4 18             	add    $0x18,%esp
}
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	ff 75 0c             	pushl  0xc(%ebp)
  8014bd:	ff 75 08             	pushl  0x8(%ebp)
  8014c0:	6a 0a                	push   $0xa
  8014c2:	e8 99 fe ff ff       	call   801360 <syscall>
  8014c7:	83 c4 18             	add    $0x18,%esp
}
  8014ca:	c9                   	leave  
  8014cb:	c3                   	ret    

008014cc <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8014cc:	55                   	push   %ebp
  8014cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 0b                	push   $0xb
  8014db:	e8 80 fe ff ff       	call   801360 <syscall>
  8014e0:	83 c4 18             	add    $0x18,%esp
}
  8014e3:	c9                   	leave  
  8014e4:	c3                   	ret    

008014e5 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014e5:	55                   	push   %ebp
  8014e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 0c                	push   $0xc
  8014f4:	e8 67 fe ff ff       	call   801360 <syscall>
  8014f9:	83 c4 18             	add    $0x18,%esp
}
  8014fc:	c9                   	leave  
  8014fd:	c3                   	ret    

008014fe <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014fe:	55                   	push   %ebp
  8014ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 0d                	push   $0xd
  80150d:	e8 4e fe ff ff       	call   801360 <syscall>
  801512:	83 c4 18             	add    $0x18,%esp
}
  801515:	c9                   	leave  
  801516:	c3                   	ret    

00801517 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801517:	55                   	push   %ebp
  801518:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	ff 75 0c             	pushl  0xc(%ebp)
  801523:	ff 75 08             	pushl  0x8(%ebp)
  801526:	6a 11                	push   $0x11
  801528:	e8 33 fe ff ff       	call   801360 <syscall>
  80152d:	83 c4 18             	add    $0x18,%esp
	return;
  801530:	90                   	nop
}
  801531:	c9                   	leave  
  801532:	c3                   	ret    

00801533 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801533:	55                   	push   %ebp
  801534:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	ff 75 0c             	pushl  0xc(%ebp)
  80153f:	ff 75 08             	pushl  0x8(%ebp)
  801542:	6a 12                	push   $0x12
  801544:	e8 17 fe ff ff       	call   801360 <syscall>
  801549:	83 c4 18             	add    $0x18,%esp
	return ;
  80154c:	90                   	nop
}
  80154d:	c9                   	leave  
  80154e:	c3                   	ret    

0080154f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 0e                	push   $0xe
  80155e:	e8 fd fd ff ff       	call   801360 <syscall>
  801563:	83 c4 18             	add    $0x18,%esp
}
  801566:	c9                   	leave  
  801567:	c3                   	ret    

00801568 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801568:	55                   	push   %ebp
  801569:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	ff 75 08             	pushl  0x8(%ebp)
  801576:	6a 0f                	push   $0xf
  801578:	e8 e3 fd ff ff       	call   801360 <syscall>
  80157d:	83 c4 18             	add    $0x18,%esp
}
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 10                	push   $0x10
  801591:	e8 ca fd ff ff       	call   801360 <syscall>
  801596:	83 c4 18             	add    $0x18,%esp
}
  801599:	90                   	nop
  80159a:	c9                   	leave  
  80159b:	c3                   	ret    

0080159c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80159c:	55                   	push   %ebp
  80159d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 14                	push   $0x14
  8015ab:	e8 b0 fd ff ff       	call   801360 <syscall>
  8015b0:	83 c4 18             	add    $0x18,%esp
}
  8015b3:	90                   	nop
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 15                	push   $0x15
  8015c5:	e8 96 fd ff ff       	call   801360 <syscall>
  8015ca:	83 c4 18             	add    $0x18,%esp
}
  8015cd:	90                   	nop
  8015ce:	c9                   	leave  
  8015cf:	c3                   	ret    

008015d0 <sys_cputc>:


void
sys_cputc(const char c)
{
  8015d0:	55                   	push   %ebp
  8015d1:	89 e5                	mov    %esp,%ebp
  8015d3:	83 ec 04             	sub    $0x4,%esp
  8015d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015dc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	50                   	push   %eax
  8015e9:	6a 16                	push   $0x16
  8015eb:	e8 70 fd ff ff       	call   801360 <syscall>
  8015f0:	83 c4 18             	add    $0x18,%esp
}
  8015f3:	90                   	nop
  8015f4:	c9                   	leave  
  8015f5:	c3                   	ret    

008015f6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015f6:	55                   	push   %ebp
  8015f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 17                	push   $0x17
  801605:	e8 56 fd ff ff       	call   801360 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	90                   	nop
  80160e:	c9                   	leave  
  80160f:	c3                   	ret    

00801610 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801610:	55                   	push   %ebp
  801611:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801613:	8b 45 08             	mov    0x8(%ebp),%eax
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	ff 75 0c             	pushl  0xc(%ebp)
  80161f:	50                   	push   %eax
  801620:	6a 18                	push   $0x18
  801622:	e8 39 fd ff ff       	call   801360 <syscall>
  801627:	83 c4 18             	add    $0x18,%esp
}
  80162a:	c9                   	leave  
  80162b:	c3                   	ret    

0080162c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80162c:	55                   	push   %ebp
  80162d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80162f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	52                   	push   %edx
  80163c:	50                   	push   %eax
  80163d:	6a 1b                	push   $0x1b
  80163f:	e8 1c fd ff ff       	call   801360 <syscall>
  801644:	83 c4 18             	add    $0x18,%esp
}
  801647:	c9                   	leave  
  801648:	c3                   	ret    

00801649 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801649:	55                   	push   %ebp
  80164a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80164c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80164f:	8b 45 08             	mov    0x8(%ebp),%eax
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	52                   	push   %edx
  801659:	50                   	push   %eax
  80165a:	6a 19                	push   $0x19
  80165c:	e8 ff fc ff ff       	call   801360 <syscall>
  801661:	83 c4 18             	add    $0x18,%esp
}
  801664:	90                   	nop
  801665:	c9                   	leave  
  801666:	c3                   	ret    

00801667 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801667:	55                   	push   %ebp
  801668:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80166a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	52                   	push   %edx
  801677:	50                   	push   %eax
  801678:	6a 1a                	push   $0x1a
  80167a:	e8 e1 fc ff ff       	call   801360 <syscall>
  80167f:	83 c4 18             	add    $0x18,%esp
}
  801682:	90                   	nop
  801683:	c9                   	leave  
  801684:	c3                   	ret    

00801685 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801685:	55                   	push   %ebp
  801686:	89 e5                	mov    %esp,%ebp
  801688:	83 ec 04             	sub    $0x4,%esp
  80168b:	8b 45 10             	mov    0x10(%ebp),%eax
  80168e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801691:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801694:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
  80169b:	6a 00                	push   $0x0
  80169d:	51                   	push   %ecx
  80169e:	52                   	push   %edx
  80169f:	ff 75 0c             	pushl  0xc(%ebp)
  8016a2:	50                   	push   %eax
  8016a3:	6a 1c                	push   $0x1c
  8016a5:	e8 b6 fc ff ff       	call   801360 <syscall>
  8016aa:	83 c4 18             	add    $0x18,%esp
}
  8016ad:	c9                   	leave  
  8016ae:	c3                   	ret    

008016af <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8016af:	55                   	push   %ebp
  8016b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8016b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	52                   	push   %edx
  8016bf:	50                   	push   %eax
  8016c0:	6a 1d                	push   $0x1d
  8016c2:	e8 99 fc ff ff       	call   801360 <syscall>
  8016c7:	83 c4 18             	add    $0x18,%esp
}
  8016ca:	c9                   	leave  
  8016cb:	c3                   	ret    

008016cc <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8016cc:	55                   	push   %ebp
  8016cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8016cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	51                   	push   %ecx
  8016dd:	52                   	push   %edx
  8016de:	50                   	push   %eax
  8016df:	6a 1e                	push   $0x1e
  8016e1:	e8 7a fc ff ff       	call   801360 <syscall>
  8016e6:	83 c4 18             	add    $0x18,%esp
}
  8016e9:	c9                   	leave  
  8016ea:	c3                   	ret    

008016eb <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016eb:	55                   	push   %ebp
  8016ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	52                   	push   %edx
  8016fb:	50                   	push   %eax
  8016fc:	6a 1f                	push   $0x1f
  8016fe:	e8 5d fc ff ff       	call   801360 <syscall>
  801703:	83 c4 18             	add    $0x18,%esp
}
  801706:	c9                   	leave  
  801707:	c3                   	ret    

00801708 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801708:	55                   	push   %ebp
  801709:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 20                	push   $0x20
  801717:	e8 44 fc ff ff       	call   801360 <syscall>
  80171c:	83 c4 18             	add    $0x18,%esp
}
  80171f:	c9                   	leave  
  801720:	c3                   	ret    

00801721 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801721:	55                   	push   %ebp
  801722:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	6a 00                	push   $0x0
  801729:	ff 75 14             	pushl  0x14(%ebp)
  80172c:	ff 75 10             	pushl  0x10(%ebp)
  80172f:	ff 75 0c             	pushl  0xc(%ebp)
  801732:	50                   	push   %eax
  801733:	6a 21                	push   $0x21
  801735:	e8 26 fc ff ff       	call   801360 <syscall>
  80173a:	83 c4 18             	add    $0x18,%esp
}
  80173d:	c9                   	leave  
  80173e:	c3                   	ret    

0080173f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80173f:	55                   	push   %ebp
  801740:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	50                   	push   %eax
  80174e:	6a 22                	push   $0x22
  801750:	e8 0b fc ff ff       	call   801360 <syscall>
  801755:	83 c4 18             	add    $0x18,%esp
}
  801758:	90                   	nop
  801759:	c9                   	leave  
  80175a:	c3                   	ret    

0080175b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80175b:	55                   	push   %ebp
  80175c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80175e:	8b 45 08             	mov    0x8(%ebp),%eax
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	50                   	push   %eax
  80176a:	6a 23                	push   $0x23
  80176c:	e8 ef fb ff ff       	call   801360 <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
}
  801774:	90                   	nop
  801775:	c9                   	leave  
  801776:	c3                   	ret    

00801777 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801777:	55                   	push   %ebp
  801778:	89 e5                	mov    %esp,%ebp
  80177a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80177d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801780:	8d 50 04             	lea    0x4(%eax),%edx
  801783:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	52                   	push   %edx
  80178d:	50                   	push   %eax
  80178e:	6a 24                	push   $0x24
  801790:	e8 cb fb ff ff       	call   801360 <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
	return result;
  801798:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80179b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80179e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017a1:	89 01                	mov    %eax,(%ecx)
  8017a3:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8017a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a9:	c9                   	leave  
  8017aa:	c2 04 00             	ret    $0x4

008017ad <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	ff 75 10             	pushl  0x10(%ebp)
  8017b7:	ff 75 0c             	pushl  0xc(%ebp)
  8017ba:	ff 75 08             	pushl  0x8(%ebp)
  8017bd:	6a 13                	push   $0x13
  8017bf:	e8 9c fb ff ff       	call   801360 <syscall>
  8017c4:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c7:	90                   	nop
}
  8017c8:	c9                   	leave  
  8017c9:	c3                   	ret    

008017ca <sys_rcr2>:
uint32 sys_rcr2()
{
  8017ca:	55                   	push   %ebp
  8017cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 25                	push   $0x25
  8017d9:	e8 82 fb ff ff       	call   801360 <syscall>
  8017de:	83 c4 18             	add    $0x18,%esp
}
  8017e1:	c9                   	leave  
  8017e2:	c3                   	ret    

008017e3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017e3:	55                   	push   %ebp
  8017e4:	89 e5                	mov    %esp,%ebp
  8017e6:	83 ec 04             	sub    $0x4,%esp
  8017e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ec:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017ef:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	50                   	push   %eax
  8017fc:	6a 26                	push   $0x26
  8017fe:	e8 5d fb ff ff       	call   801360 <syscall>
  801803:	83 c4 18             	add    $0x18,%esp
	return ;
  801806:	90                   	nop
}
  801807:	c9                   	leave  
  801808:	c3                   	ret    

00801809 <rsttst>:
void rsttst()
{
  801809:	55                   	push   %ebp
  80180a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 28                	push   $0x28
  801818:	e8 43 fb ff ff       	call   801360 <syscall>
  80181d:	83 c4 18             	add    $0x18,%esp
	return ;
  801820:	90                   	nop
}
  801821:	c9                   	leave  
  801822:	c3                   	ret    

00801823 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801823:	55                   	push   %ebp
  801824:	89 e5                	mov    %esp,%ebp
  801826:	83 ec 04             	sub    $0x4,%esp
  801829:	8b 45 14             	mov    0x14(%ebp),%eax
  80182c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80182f:	8b 55 18             	mov    0x18(%ebp),%edx
  801832:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801836:	52                   	push   %edx
  801837:	50                   	push   %eax
  801838:	ff 75 10             	pushl  0x10(%ebp)
  80183b:	ff 75 0c             	pushl  0xc(%ebp)
  80183e:	ff 75 08             	pushl  0x8(%ebp)
  801841:	6a 27                	push   $0x27
  801843:	e8 18 fb ff ff       	call   801360 <syscall>
  801848:	83 c4 18             	add    $0x18,%esp
	return ;
  80184b:	90                   	nop
}
  80184c:	c9                   	leave  
  80184d:	c3                   	ret    

0080184e <chktst>:
void chktst(uint32 n)
{
  80184e:	55                   	push   %ebp
  80184f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	ff 75 08             	pushl  0x8(%ebp)
  80185c:	6a 29                	push   $0x29
  80185e:	e8 fd fa ff ff       	call   801360 <syscall>
  801863:	83 c4 18             	add    $0x18,%esp
	return ;
  801866:	90                   	nop
}
  801867:	c9                   	leave  
  801868:	c3                   	ret    

00801869 <inctst>:

void inctst()
{
  801869:	55                   	push   %ebp
  80186a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 2a                	push   $0x2a
  801878:	e8 e3 fa ff ff       	call   801360 <syscall>
  80187d:	83 c4 18             	add    $0x18,%esp
	return ;
  801880:	90                   	nop
}
  801881:	c9                   	leave  
  801882:	c3                   	ret    

00801883 <gettst>:
uint32 gettst()
{
  801883:	55                   	push   %ebp
  801884:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 2b                	push   $0x2b
  801892:	e8 c9 fa ff ff       	call   801360 <syscall>
  801897:	83 c4 18             	add    $0x18,%esp
}
  80189a:	c9                   	leave  
  80189b:	c3                   	ret    

0080189c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80189c:	55                   	push   %ebp
  80189d:	89 e5                	mov    %esp,%ebp
  80189f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 2c                	push   $0x2c
  8018ae:	e8 ad fa ff ff       	call   801360 <syscall>
  8018b3:	83 c4 18             	add    $0x18,%esp
  8018b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8018b9:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8018bd:	75 07                	jne    8018c6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8018bf:	b8 01 00 00 00       	mov    $0x1,%eax
  8018c4:	eb 05                	jmp    8018cb <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8018c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018cb:	c9                   	leave  
  8018cc:	c3                   	ret    

008018cd <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8018cd:	55                   	push   %ebp
  8018ce:	89 e5                	mov    %esp,%ebp
  8018d0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 2c                	push   $0x2c
  8018df:	e8 7c fa ff ff       	call   801360 <syscall>
  8018e4:	83 c4 18             	add    $0x18,%esp
  8018e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018ea:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018ee:	75 07                	jne    8018f7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018f0:	b8 01 00 00 00       	mov    $0x1,%eax
  8018f5:	eb 05                	jmp    8018fc <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018fc:	c9                   	leave  
  8018fd:	c3                   	ret    

008018fe <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018fe:	55                   	push   %ebp
  8018ff:	89 e5                	mov    %esp,%ebp
  801901:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801904:	6a 00                	push   $0x0
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 2c                	push   $0x2c
  801910:	e8 4b fa ff ff       	call   801360 <syscall>
  801915:	83 c4 18             	add    $0x18,%esp
  801918:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80191b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80191f:	75 07                	jne    801928 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801921:	b8 01 00 00 00       	mov    $0x1,%eax
  801926:	eb 05                	jmp    80192d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801928:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
  801932:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 2c                	push   $0x2c
  801941:	e8 1a fa ff ff       	call   801360 <syscall>
  801946:	83 c4 18             	add    $0x18,%esp
  801949:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80194c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801950:	75 07                	jne    801959 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801952:	b8 01 00 00 00       	mov    $0x1,%eax
  801957:	eb 05                	jmp    80195e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801959:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80195e:	c9                   	leave  
  80195f:	c3                   	ret    

00801960 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801960:	55                   	push   %ebp
  801961:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	ff 75 08             	pushl  0x8(%ebp)
  80196e:	6a 2d                	push   $0x2d
  801970:	e8 eb f9 ff ff       	call   801360 <syscall>
  801975:	83 c4 18             	add    $0x18,%esp
	return ;
  801978:	90                   	nop
}
  801979:	c9                   	leave  
  80197a:	c3                   	ret    

0080197b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80197b:	55                   	push   %ebp
  80197c:	89 e5                	mov    %esp,%ebp
  80197e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80197f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801982:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801985:	8b 55 0c             	mov    0xc(%ebp),%edx
  801988:	8b 45 08             	mov    0x8(%ebp),%eax
  80198b:	6a 00                	push   $0x0
  80198d:	53                   	push   %ebx
  80198e:	51                   	push   %ecx
  80198f:	52                   	push   %edx
  801990:	50                   	push   %eax
  801991:	6a 2e                	push   $0x2e
  801993:	e8 c8 f9 ff ff       	call   801360 <syscall>
  801998:	83 c4 18             	add    $0x18,%esp
}
  80199b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80199e:	c9                   	leave  
  80199f:	c3                   	ret    

008019a0 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8019a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	52                   	push   %edx
  8019b0:	50                   	push   %eax
  8019b1:	6a 2f                	push   $0x2f
  8019b3:	e8 a8 f9 ff ff       	call   801360 <syscall>
  8019b8:	83 c4 18             	add    $0x18,%esp
}
  8019bb:	c9                   	leave  
  8019bc:	c3                   	ret    
  8019bd:	66 90                	xchg   %ax,%ax
  8019bf:	90                   	nop

008019c0 <__udivdi3>:
  8019c0:	55                   	push   %ebp
  8019c1:	57                   	push   %edi
  8019c2:	56                   	push   %esi
  8019c3:	53                   	push   %ebx
  8019c4:	83 ec 1c             	sub    $0x1c,%esp
  8019c7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019cb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019cf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019d3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019d7:	89 ca                	mov    %ecx,%edx
  8019d9:	89 f8                	mov    %edi,%eax
  8019db:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019df:	85 f6                	test   %esi,%esi
  8019e1:	75 2d                	jne    801a10 <__udivdi3+0x50>
  8019e3:	39 cf                	cmp    %ecx,%edi
  8019e5:	77 65                	ja     801a4c <__udivdi3+0x8c>
  8019e7:	89 fd                	mov    %edi,%ebp
  8019e9:	85 ff                	test   %edi,%edi
  8019eb:	75 0b                	jne    8019f8 <__udivdi3+0x38>
  8019ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8019f2:	31 d2                	xor    %edx,%edx
  8019f4:	f7 f7                	div    %edi
  8019f6:	89 c5                	mov    %eax,%ebp
  8019f8:	31 d2                	xor    %edx,%edx
  8019fa:	89 c8                	mov    %ecx,%eax
  8019fc:	f7 f5                	div    %ebp
  8019fe:	89 c1                	mov    %eax,%ecx
  801a00:	89 d8                	mov    %ebx,%eax
  801a02:	f7 f5                	div    %ebp
  801a04:	89 cf                	mov    %ecx,%edi
  801a06:	89 fa                	mov    %edi,%edx
  801a08:	83 c4 1c             	add    $0x1c,%esp
  801a0b:	5b                   	pop    %ebx
  801a0c:	5e                   	pop    %esi
  801a0d:	5f                   	pop    %edi
  801a0e:	5d                   	pop    %ebp
  801a0f:	c3                   	ret    
  801a10:	39 ce                	cmp    %ecx,%esi
  801a12:	77 28                	ja     801a3c <__udivdi3+0x7c>
  801a14:	0f bd fe             	bsr    %esi,%edi
  801a17:	83 f7 1f             	xor    $0x1f,%edi
  801a1a:	75 40                	jne    801a5c <__udivdi3+0x9c>
  801a1c:	39 ce                	cmp    %ecx,%esi
  801a1e:	72 0a                	jb     801a2a <__udivdi3+0x6a>
  801a20:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a24:	0f 87 9e 00 00 00    	ja     801ac8 <__udivdi3+0x108>
  801a2a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2f:	89 fa                	mov    %edi,%edx
  801a31:	83 c4 1c             	add    $0x1c,%esp
  801a34:	5b                   	pop    %ebx
  801a35:	5e                   	pop    %esi
  801a36:	5f                   	pop    %edi
  801a37:	5d                   	pop    %ebp
  801a38:	c3                   	ret    
  801a39:	8d 76 00             	lea    0x0(%esi),%esi
  801a3c:	31 ff                	xor    %edi,%edi
  801a3e:	31 c0                	xor    %eax,%eax
  801a40:	89 fa                	mov    %edi,%edx
  801a42:	83 c4 1c             	add    $0x1c,%esp
  801a45:	5b                   	pop    %ebx
  801a46:	5e                   	pop    %esi
  801a47:	5f                   	pop    %edi
  801a48:	5d                   	pop    %ebp
  801a49:	c3                   	ret    
  801a4a:	66 90                	xchg   %ax,%ax
  801a4c:	89 d8                	mov    %ebx,%eax
  801a4e:	f7 f7                	div    %edi
  801a50:	31 ff                	xor    %edi,%edi
  801a52:	89 fa                	mov    %edi,%edx
  801a54:	83 c4 1c             	add    $0x1c,%esp
  801a57:	5b                   	pop    %ebx
  801a58:	5e                   	pop    %esi
  801a59:	5f                   	pop    %edi
  801a5a:	5d                   	pop    %ebp
  801a5b:	c3                   	ret    
  801a5c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a61:	89 eb                	mov    %ebp,%ebx
  801a63:	29 fb                	sub    %edi,%ebx
  801a65:	89 f9                	mov    %edi,%ecx
  801a67:	d3 e6                	shl    %cl,%esi
  801a69:	89 c5                	mov    %eax,%ebp
  801a6b:	88 d9                	mov    %bl,%cl
  801a6d:	d3 ed                	shr    %cl,%ebp
  801a6f:	89 e9                	mov    %ebp,%ecx
  801a71:	09 f1                	or     %esi,%ecx
  801a73:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a77:	89 f9                	mov    %edi,%ecx
  801a79:	d3 e0                	shl    %cl,%eax
  801a7b:	89 c5                	mov    %eax,%ebp
  801a7d:	89 d6                	mov    %edx,%esi
  801a7f:	88 d9                	mov    %bl,%cl
  801a81:	d3 ee                	shr    %cl,%esi
  801a83:	89 f9                	mov    %edi,%ecx
  801a85:	d3 e2                	shl    %cl,%edx
  801a87:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a8b:	88 d9                	mov    %bl,%cl
  801a8d:	d3 e8                	shr    %cl,%eax
  801a8f:	09 c2                	or     %eax,%edx
  801a91:	89 d0                	mov    %edx,%eax
  801a93:	89 f2                	mov    %esi,%edx
  801a95:	f7 74 24 0c          	divl   0xc(%esp)
  801a99:	89 d6                	mov    %edx,%esi
  801a9b:	89 c3                	mov    %eax,%ebx
  801a9d:	f7 e5                	mul    %ebp
  801a9f:	39 d6                	cmp    %edx,%esi
  801aa1:	72 19                	jb     801abc <__udivdi3+0xfc>
  801aa3:	74 0b                	je     801ab0 <__udivdi3+0xf0>
  801aa5:	89 d8                	mov    %ebx,%eax
  801aa7:	31 ff                	xor    %edi,%edi
  801aa9:	e9 58 ff ff ff       	jmp    801a06 <__udivdi3+0x46>
  801aae:	66 90                	xchg   %ax,%ax
  801ab0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ab4:	89 f9                	mov    %edi,%ecx
  801ab6:	d3 e2                	shl    %cl,%edx
  801ab8:	39 c2                	cmp    %eax,%edx
  801aba:	73 e9                	jae    801aa5 <__udivdi3+0xe5>
  801abc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801abf:	31 ff                	xor    %edi,%edi
  801ac1:	e9 40 ff ff ff       	jmp    801a06 <__udivdi3+0x46>
  801ac6:	66 90                	xchg   %ax,%ax
  801ac8:	31 c0                	xor    %eax,%eax
  801aca:	e9 37 ff ff ff       	jmp    801a06 <__udivdi3+0x46>
  801acf:	90                   	nop

00801ad0 <__umoddi3>:
  801ad0:	55                   	push   %ebp
  801ad1:	57                   	push   %edi
  801ad2:	56                   	push   %esi
  801ad3:	53                   	push   %ebx
  801ad4:	83 ec 1c             	sub    $0x1c,%esp
  801ad7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801adb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801adf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ae3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ae7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801aeb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801aef:	89 f3                	mov    %esi,%ebx
  801af1:	89 fa                	mov    %edi,%edx
  801af3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801af7:	89 34 24             	mov    %esi,(%esp)
  801afa:	85 c0                	test   %eax,%eax
  801afc:	75 1a                	jne    801b18 <__umoddi3+0x48>
  801afe:	39 f7                	cmp    %esi,%edi
  801b00:	0f 86 a2 00 00 00    	jbe    801ba8 <__umoddi3+0xd8>
  801b06:	89 c8                	mov    %ecx,%eax
  801b08:	89 f2                	mov    %esi,%edx
  801b0a:	f7 f7                	div    %edi
  801b0c:	89 d0                	mov    %edx,%eax
  801b0e:	31 d2                	xor    %edx,%edx
  801b10:	83 c4 1c             	add    $0x1c,%esp
  801b13:	5b                   	pop    %ebx
  801b14:	5e                   	pop    %esi
  801b15:	5f                   	pop    %edi
  801b16:	5d                   	pop    %ebp
  801b17:	c3                   	ret    
  801b18:	39 f0                	cmp    %esi,%eax
  801b1a:	0f 87 ac 00 00 00    	ja     801bcc <__umoddi3+0xfc>
  801b20:	0f bd e8             	bsr    %eax,%ebp
  801b23:	83 f5 1f             	xor    $0x1f,%ebp
  801b26:	0f 84 ac 00 00 00    	je     801bd8 <__umoddi3+0x108>
  801b2c:	bf 20 00 00 00       	mov    $0x20,%edi
  801b31:	29 ef                	sub    %ebp,%edi
  801b33:	89 fe                	mov    %edi,%esi
  801b35:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b39:	89 e9                	mov    %ebp,%ecx
  801b3b:	d3 e0                	shl    %cl,%eax
  801b3d:	89 d7                	mov    %edx,%edi
  801b3f:	89 f1                	mov    %esi,%ecx
  801b41:	d3 ef                	shr    %cl,%edi
  801b43:	09 c7                	or     %eax,%edi
  801b45:	89 e9                	mov    %ebp,%ecx
  801b47:	d3 e2                	shl    %cl,%edx
  801b49:	89 14 24             	mov    %edx,(%esp)
  801b4c:	89 d8                	mov    %ebx,%eax
  801b4e:	d3 e0                	shl    %cl,%eax
  801b50:	89 c2                	mov    %eax,%edx
  801b52:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b56:	d3 e0                	shl    %cl,%eax
  801b58:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b5c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b60:	89 f1                	mov    %esi,%ecx
  801b62:	d3 e8                	shr    %cl,%eax
  801b64:	09 d0                	or     %edx,%eax
  801b66:	d3 eb                	shr    %cl,%ebx
  801b68:	89 da                	mov    %ebx,%edx
  801b6a:	f7 f7                	div    %edi
  801b6c:	89 d3                	mov    %edx,%ebx
  801b6e:	f7 24 24             	mull   (%esp)
  801b71:	89 c6                	mov    %eax,%esi
  801b73:	89 d1                	mov    %edx,%ecx
  801b75:	39 d3                	cmp    %edx,%ebx
  801b77:	0f 82 87 00 00 00    	jb     801c04 <__umoddi3+0x134>
  801b7d:	0f 84 91 00 00 00    	je     801c14 <__umoddi3+0x144>
  801b83:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b87:	29 f2                	sub    %esi,%edx
  801b89:	19 cb                	sbb    %ecx,%ebx
  801b8b:	89 d8                	mov    %ebx,%eax
  801b8d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b91:	d3 e0                	shl    %cl,%eax
  801b93:	89 e9                	mov    %ebp,%ecx
  801b95:	d3 ea                	shr    %cl,%edx
  801b97:	09 d0                	or     %edx,%eax
  801b99:	89 e9                	mov    %ebp,%ecx
  801b9b:	d3 eb                	shr    %cl,%ebx
  801b9d:	89 da                	mov    %ebx,%edx
  801b9f:	83 c4 1c             	add    $0x1c,%esp
  801ba2:	5b                   	pop    %ebx
  801ba3:	5e                   	pop    %esi
  801ba4:	5f                   	pop    %edi
  801ba5:	5d                   	pop    %ebp
  801ba6:	c3                   	ret    
  801ba7:	90                   	nop
  801ba8:	89 fd                	mov    %edi,%ebp
  801baa:	85 ff                	test   %edi,%edi
  801bac:	75 0b                	jne    801bb9 <__umoddi3+0xe9>
  801bae:	b8 01 00 00 00       	mov    $0x1,%eax
  801bb3:	31 d2                	xor    %edx,%edx
  801bb5:	f7 f7                	div    %edi
  801bb7:	89 c5                	mov    %eax,%ebp
  801bb9:	89 f0                	mov    %esi,%eax
  801bbb:	31 d2                	xor    %edx,%edx
  801bbd:	f7 f5                	div    %ebp
  801bbf:	89 c8                	mov    %ecx,%eax
  801bc1:	f7 f5                	div    %ebp
  801bc3:	89 d0                	mov    %edx,%eax
  801bc5:	e9 44 ff ff ff       	jmp    801b0e <__umoddi3+0x3e>
  801bca:	66 90                	xchg   %ax,%ax
  801bcc:	89 c8                	mov    %ecx,%eax
  801bce:	89 f2                	mov    %esi,%edx
  801bd0:	83 c4 1c             	add    $0x1c,%esp
  801bd3:	5b                   	pop    %ebx
  801bd4:	5e                   	pop    %esi
  801bd5:	5f                   	pop    %edi
  801bd6:	5d                   	pop    %ebp
  801bd7:	c3                   	ret    
  801bd8:	3b 04 24             	cmp    (%esp),%eax
  801bdb:	72 06                	jb     801be3 <__umoddi3+0x113>
  801bdd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801be1:	77 0f                	ja     801bf2 <__umoddi3+0x122>
  801be3:	89 f2                	mov    %esi,%edx
  801be5:	29 f9                	sub    %edi,%ecx
  801be7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801beb:	89 14 24             	mov    %edx,(%esp)
  801bee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bf2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bf6:	8b 14 24             	mov    (%esp),%edx
  801bf9:	83 c4 1c             	add    $0x1c,%esp
  801bfc:	5b                   	pop    %ebx
  801bfd:	5e                   	pop    %esi
  801bfe:	5f                   	pop    %edi
  801bff:	5d                   	pop    %ebp
  801c00:	c3                   	ret    
  801c01:	8d 76 00             	lea    0x0(%esi),%esi
  801c04:	2b 04 24             	sub    (%esp),%eax
  801c07:	19 fa                	sbb    %edi,%edx
  801c09:	89 d1                	mov    %edx,%ecx
  801c0b:	89 c6                	mov    %eax,%esi
  801c0d:	e9 71 ff ff ff       	jmp    801b83 <__umoddi3+0xb3>
  801c12:	66 90                	xchg   %ax,%ax
  801c14:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c18:	72 ea                	jb     801c04 <__umoddi3+0x134>
  801c1a:	89 d9                	mov    %ebx,%ecx
  801c1c:	e9 62 ff ff ff       	jmp    801b83 <__umoddi3+0xb3>

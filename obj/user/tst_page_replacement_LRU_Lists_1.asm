
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
  800031:	e8 09 02 00 00       	call   80023f <libmain>
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

	cprintf("STEP 0: checking Initial WS entries ...\n");
  800041:	83 ec 0c             	sub    $0xc,%esp
  800044:	68 80 1c 80 00       	push   $0x801c80
  800049:	e8 d8 05 00 00       	call   800626 <cprintf>
  80004e:	83 c4 10             	add    $0x10,%esp
	{
		cprintf("i am here 1");
  800051:	83 ec 0c             	sub    $0xc,%esp
  800054:	68 a9 1c 80 00       	push   $0x801ca9
  800059:	e8 c8 05 00 00       	call   800626 <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp
		uint32 actual_active_list[5] = {0x803000, 0x801000, 0x800000, 0xeebfd000, 0x203000};
  800061:	8d 45 b8             	lea    -0x48(%ebp),%eax
  800064:	bb 04 1f 80 00       	mov    $0x801f04,%ebx
  800069:	ba 05 00 00 00       	mov    $0x5,%edx
  80006e:	89 c7                	mov    %eax,%edi
  800070:	89 de                	mov    %ebx,%esi
  800072:	89 d1                	mov    %edx,%ecx
  800074:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		uint32 actual_second_list[5] = {0x202000, 0x201000, 0x200000, 0x802000, 0x205000};
  800076:	8d 45 a4             	lea    -0x5c(%ebp),%eax
  800079:	bb 18 1f 80 00       	mov    $0x801f18,%ebx
  80007e:	ba 05 00 00 00       	mov    $0x5,%edx
  800083:	89 c7                	mov    %eax,%edi
  800085:	89 de                	mov    %ebx,%esi
  800087:	89 d1                	mov    %edx,%ecx
  800089:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		int check = sys_check_LRU_lists(actual_active_list, actual_second_list, 5, 5);
  80008b:	6a 05                	push   $0x5
  80008d:	6a 05                	push   $0x5
  80008f:	8d 45 a4             	lea    -0x5c(%ebp),%eax
  800092:	50                   	push   %eax
  800093:	8d 45 b8             	lea    -0x48(%ebp),%eax
  800096:	50                   	push   %eax
  800097:	e8 2f 19 00 00       	call   8019cb <sys_check_LRU_lists>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		if(check == 0)
  8000a2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8000a6:	75 14                	jne    8000bc <_main+0x84>
			panic("INITIAL PAGE LRU LISTs entry checking failed! Review size of the LRU lists..!!");
  8000a8:	83 ec 04             	sub    $0x4,%esp
  8000ab:	68 b8 1c 80 00       	push   $0x801cb8
  8000b0:	6a 19                	push   $0x19
  8000b2:	68 08 1d 80 00       	push   $0x801d08
  8000b7:	e8 c8 02 00 00       	call   800384 <_panic>

	}

	int freePages = sys_calculate_free_frames();
  8000bc:	e8 5b 14 00 00       	call   80151c <sys_calculate_free_frames>
  8000c1:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8000c4:	e8 d6 14 00 00       	call   80159f <sys_pf_calculate_allocated_pages>
  8000c9:	89 45 d8             	mov    %eax,-0x28(%ebp)
	cprintf("i am here 2");
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	68 30 1d 80 00       	push   $0x801d30
  8000d4:	e8 4d 05 00 00       	call   800626 <cprintf>
  8000d9:	83 c4 10             	add    $0x10,%esp
	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8000dc:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8000e1:	88 45 d7             	mov    %al,-0x29(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8000e4:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8000e9:	88 45 d6             	mov    %al,-0x2a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000ec:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8000f3:	eb 37                	jmp    80012c <_main+0xf4>
	{
		arr[i] = -1 ;
  8000f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f8:	05 40 30 80 00       	add    $0x803040,%eax
  8000fd:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  800100:	a1 04 30 80 00       	mov    0x803004,%eax
  800105:	8b 15 00 30 80 00    	mov    0x803000,%edx
  80010b:	8a 12                	mov    (%edx),%dl
  80010d:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  80010f:	a1 00 30 80 00       	mov    0x803000,%eax
  800114:	40                   	inc    %eax
  800115:	a3 00 30 80 00       	mov    %eax,0x803000
  80011a:	a1 04 30 80 00       	mov    0x803004,%eax
  80011f:	40                   	inc    %eax
  800120:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800125:	81 45 e4 00 08 00 00 	addl   $0x800,-0x1c(%ebp)
  80012c:	81 7d e4 ff 9f 00 00 	cmpl   $0x9fff,-0x1c(%ebp)
  800133:	7e c0                	jle    8000f5 <_main+0xbd>
		ptr++ ; ptr2++ ;
	}

	//===================

	cprintf("Checking Allocation in Mem & Page File... \n");
  800135:	83 ec 0c             	sub    $0xc,%esp
  800138:	68 3c 1d 80 00       	push   $0x801d3c
  80013d:	e8 e4 04 00 00       	call   800626 <cprintf>
  800142:	83 c4 10             	add    $0x10,%esp
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800145:	e8 55 14 00 00       	call   80159f <sys_pf_calculate_allocated_pages>
  80014a:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  80014d:	74 14                	je     800163 <_main+0x12b>
  80014f:	83 ec 04             	sub    $0x4,%esp
  800152:	68 68 1d 80 00       	push   $0x801d68
  800157:	6a 35                	push   $0x35
  800159:	68 08 1d 80 00       	push   $0x801d08
  80015e:	e8 21 02 00 00       	call   800384 <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800163:	e8 b4 13 00 00       	call   80151c <sys_calculate_free_frames>
  800168:	89 c3                	mov    %eax,%ebx
  80016a:	e8 c6 13 00 00       	call   801535 <sys_calculate_modified_frames>
  80016f:	01 d8                	add    %ebx,%eax
  800171:	89 45 d0             	mov    %eax,-0x30(%ebp)
		if( (freePages - freePagesAfter) != 0 )
  800174:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800177:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  80017a:	74 14                	je     800190 <_main+0x158>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  80017c:	83 ec 04             	sub    $0x4,%esp
  80017f:	68 d4 1d 80 00       	push   $0x801dd4
  800184:	6a 39                	push   $0x39
  800186:	68 08 1d 80 00       	push   $0x801d08
  80018b:	e8 f4 01 00 00       	call   800384 <_panic>
	}

	cprintf("Checking CONTENT in Mem ... \n");
  800190:	83 ec 0c             	sub    $0xc,%esp
  800193:	68 38 1e 80 00       	push   $0x801e38
  800198:	e8 89 04 00 00       	call   800626 <cprintf>
  80019d:	83 c4 10             	add    $0x10,%esp
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8001a0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8001a7:	eb 29                	jmp    8001d2 <_main+0x19a>
			if( arr[i] != -1) panic("Modified page(s) not restored correctly");
  8001a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001ac:	05 40 30 80 00       	add    $0x803040,%eax
  8001b1:	8a 00                	mov    (%eax),%al
  8001b3:	3c ff                	cmp    $0xff,%al
  8001b5:	74 14                	je     8001cb <_main+0x193>
  8001b7:	83 ec 04             	sub    $0x4,%esp
  8001ba:	68 58 1e 80 00       	push   $0x801e58
  8001bf:	6a 3f                	push   $0x3f
  8001c1:	68 08 1d 80 00       	push   $0x801d08
  8001c6:	e8 b9 01 00 00       	call   800384 <_panic>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
	}

	cprintf("Checking CONTENT in Mem ... \n");
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8001cb:	81 45 e4 00 08 00 00 	addl   $0x800,-0x1c(%ebp)
  8001d2:	81 7d e4 ff 9f 00 00 	cmpl   $0x9fff,-0x1c(%ebp)
  8001d9:	7e ce                	jle    8001a9 <_main+0x171>
			if( arr[i] != -1) panic("Modified page(s) not restored correctly");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  8001db:	e8 bf 13 00 00       	call   80159f <sys_pf_calculate_allocated_pages>
  8001e0:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8001e3:	74 14                	je     8001f9 <_main+0x1c1>
  8001e5:	83 ec 04             	sub    $0x4,%esp
  8001e8:	68 68 1d 80 00       	push   $0x801d68
  8001ed:	6a 40                	push   $0x40
  8001ef:	68 08 1d 80 00       	push   $0x801d08
  8001f4:	e8 8b 01 00 00       	call   800384 <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8001f9:	e8 1e 13 00 00       	call   80151c <sys_calculate_free_frames>
  8001fe:	89 c3                	mov    %eax,%ebx
  800200:	e8 30 13 00 00       	call   801535 <sys_calculate_modified_frames>
  800205:	01 d8                	add    %ebx,%eax
  800207:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if( (freePages - freePagesAfter) != 0 )
  80020a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80020d:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  800210:	74 14                	je     800226 <_main+0x1ee>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  800212:	83 ec 04             	sub    $0x4,%esp
  800215:	68 d4 1d 80 00       	push   $0x801dd4
  80021a:	6a 44                	push   $0x44
  80021c:	68 08 1d 80 00       	push   $0x801d08
  800221:	e8 5e 01 00 00       	call   800384 <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [ALLOCATION] by REMOVING ONLY ONE PAGE using APRROXIMATED LRU is completed successfully.\n");
  800226:	83 ec 0c             	sub    $0xc,%esp
  800229:	68 80 1e 80 00       	push   $0x801e80
  80022e:	e8 f3 03 00 00       	call   800626 <cprintf>
  800233:	83 c4 10             	add    $0x10,%esp
	return;
  800236:	90                   	nop
}
  800237:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80023a:	5b                   	pop    %ebx
  80023b:	5e                   	pop    %esi
  80023c:	5f                   	pop    %edi
  80023d:	5d                   	pop    %ebp
  80023e:	c3                   	ret    

0080023f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80023f:	55                   	push   %ebp
  800240:	89 e5                	mov    %esp,%ebp
  800242:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800245:	e8 07 12 00 00       	call   801451 <sys_getenvindex>
  80024a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80024d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800250:	89 d0                	mov    %edx,%eax
  800252:	c1 e0 03             	shl    $0x3,%eax
  800255:	01 d0                	add    %edx,%eax
  800257:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80025e:	01 c8                	add    %ecx,%eax
  800260:	01 c0                	add    %eax,%eax
  800262:	01 d0                	add    %edx,%eax
  800264:	01 c0                	add    %eax,%eax
  800266:	01 d0                	add    %edx,%eax
  800268:	89 c2                	mov    %eax,%edx
  80026a:	c1 e2 05             	shl    $0x5,%edx
  80026d:	29 c2                	sub    %eax,%edx
  80026f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800276:	89 c2                	mov    %eax,%edx
  800278:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80027e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800283:	a1 20 30 80 00       	mov    0x803020,%eax
  800288:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80028e:	84 c0                	test   %al,%al
  800290:	74 0f                	je     8002a1 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800292:	a1 20 30 80 00       	mov    0x803020,%eax
  800297:	05 40 3c 01 00       	add    $0x13c40,%eax
  80029c:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002a1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002a5:	7e 0a                	jle    8002b1 <libmain+0x72>
		binaryname = argv[0];
  8002a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002aa:	8b 00                	mov    (%eax),%eax
  8002ac:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8002b1:	83 ec 08             	sub    $0x8,%esp
  8002b4:	ff 75 0c             	pushl  0xc(%ebp)
  8002b7:	ff 75 08             	pushl  0x8(%ebp)
  8002ba:	e8 79 fd ff ff       	call   800038 <_main>
  8002bf:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8002c2:	e8 25 13 00 00       	call   8015ec <sys_disable_interrupt>
	cprintf("**************************************\n");
  8002c7:	83 ec 0c             	sub    $0xc,%esp
  8002ca:	68 44 1f 80 00       	push   $0x801f44
  8002cf:	e8 52 03 00 00       	call   800626 <cprintf>
  8002d4:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002dc:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8002e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e7:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8002ed:	83 ec 04             	sub    $0x4,%esp
  8002f0:	52                   	push   %edx
  8002f1:	50                   	push   %eax
  8002f2:	68 6c 1f 80 00       	push   $0x801f6c
  8002f7:	e8 2a 03 00 00       	call   800626 <cprintf>
  8002fc:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8002ff:	a1 20 30 80 00       	mov    0x803020,%eax
  800304:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80030a:	a1 20 30 80 00       	mov    0x803020,%eax
  80030f:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800315:	83 ec 04             	sub    $0x4,%esp
  800318:	52                   	push   %edx
  800319:	50                   	push   %eax
  80031a:	68 94 1f 80 00       	push   $0x801f94
  80031f:	e8 02 03 00 00       	call   800626 <cprintf>
  800324:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800327:	a1 20 30 80 00       	mov    0x803020,%eax
  80032c:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800332:	83 ec 08             	sub    $0x8,%esp
  800335:	50                   	push   %eax
  800336:	68 d5 1f 80 00       	push   $0x801fd5
  80033b:	e8 e6 02 00 00       	call   800626 <cprintf>
  800340:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800343:	83 ec 0c             	sub    $0xc,%esp
  800346:	68 44 1f 80 00       	push   $0x801f44
  80034b:	e8 d6 02 00 00       	call   800626 <cprintf>
  800350:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800353:	e8 ae 12 00 00       	call   801606 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800358:	e8 19 00 00 00       	call   800376 <exit>
}
  80035d:	90                   	nop
  80035e:	c9                   	leave  
  80035f:	c3                   	ret    

00800360 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800360:	55                   	push   %ebp
  800361:	89 e5                	mov    %esp,%ebp
  800363:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800366:	83 ec 0c             	sub    $0xc,%esp
  800369:	6a 00                	push   $0x0
  80036b:	e8 ad 10 00 00       	call   80141d <sys_env_destroy>
  800370:	83 c4 10             	add    $0x10,%esp
}
  800373:	90                   	nop
  800374:	c9                   	leave  
  800375:	c3                   	ret    

00800376 <exit>:

void
exit(void)
{
  800376:	55                   	push   %ebp
  800377:	89 e5                	mov    %esp,%ebp
  800379:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80037c:	e8 02 11 00 00       	call   801483 <sys_env_exit>
}
  800381:	90                   	nop
  800382:	c9                   	leave  
  800383:	c3                   	ret    

00800384 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800384:	55                   	push   %ebp
  800385:	89 e5                	mov    %esp,%ebp
  800387:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80038a:	8d 45 10             	lea    0x10(%ebp),%eax
  80038d:	83 c0 04             	add    $0x4,%eax
  800390:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800393:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800398:	85 c0                	test   %eax,%eax
  80039a:	74 16                	je     8003b2 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80039c:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8003a1:	83 ec 08             	sub    $0x8,%esp
  8003a4:	50                   	push   %eax
  8003a5:	68 ec 1f 80 00       	push   $0x801fec
  8003aa:	e8 77 02 00 00       	call   800626 <cprintf>
  8003af:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8003b2:	a1 08 30 80 00       	mov    0x803008,%eax
  8003b7:	ff 75 0c             	pushl  0xc(%ebp)
  8003ba:	ff 75 08             	pushl  0x8(%ebp)
  8003bd:	50                   	push   %eax
  8003be:	68 f1 1f 80 00       	push   $0x801ff1
  8003c3:	e8 5e 02 00 00       	call   800626 <cprintf>
  8003c8:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8003cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8003ce:	83 ec 08             	sub    $0x8,%esp
  8003d1:	ff 75 f4             	pushl  -0xc(%ebp)
  8003d4:	50                   	push   %eax
  8003d5:	e8 e1 01 00 00       	call   8005bb <vcprintf>
  8003da:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8003dd:	83 ec 08             	sub    $0x8,%esp
  8003e0:	6a 00                	push   $0x0
  8003e2:	68 0d 20 80 00       	push   $0x80200d
  8003e7:	e8 cf 01 00 00       	call   8005bb <vcprintf>
  8003ec:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8003ef:	e8 82 ff ff ff       	call   800376 <exit>

	// should not return here
	while (1) ;
  8003f4:	eb fe                	jmp    8003f4 <_panic+0x70>

008003f6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8003f6:	55                   	push   %ebp
  8003f7:	89 e5                	mov    %esp,%ebp
  8003f9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800401:	8b 50 74             	mov    0x74(%eax),%edx
  800404:	8b 45 0c             	mov    0xc(%ebp),%eax
  800407:	39 c2                	cmp    %eax,%edx
  800409:	74 14                	je     80041f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80040b:	83 ec 04             	sub    $0x4,%esp
  80040e:	68 10 20 80 00       	push   $0x802010
  800413:	6a 26                	push   $0x26
  800415:	68 5c 20 80 00       	push   $0x80205c
  80041a:	e8 65 ff ff ff       	call   800384 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80041f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800426:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80042d:	e9 b6 00 00 00       	jmp    8004e8 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800432:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800435:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043c:	8b 45 08             	mov    0x8(%ebp),%eax
  80043f:	01 d0                	add    %edx,%eax
  800441:	8b 00                	mov    (%eax),%eax
  800443:	85 c0                	test   %eax,%eax
  800445:	75 08                	jne    80044f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800447:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80044a:	e9 96 00 00 00       	jmp    8004e5 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80044f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800456:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80045d:	eb 5d                	jmp    8004bc <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80045f:	a1 20 30 80 00       	mov    0x803020,%eax
  800464:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80046a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80046d:	c1 e2 04             	shl    $0x4,%edx
  800470:	01 d0                	add    %edx,%eax
  800472:	8a 40 04             	mov    0x4(%eax),%al
  800475:	84 c0                	test   %al,%al
  800477:	75 40                	jne    8004b9 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800479:	a1 20 30 80 00       	mov    0x803020,%eax
  80047e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800484:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800487:	c1 e2 04             	shl    $0x4,%edx
  80048a:	01 d0                	add    %edx,%eax
  80048c:	8b 00                	mov    (%eax),%eax
  80048e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800491:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800494:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800499:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80049b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80049e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a8:	01 c8                	add    %ecx,%eax
  8004aa:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004ac:	39 c2                	cmp    %eax,%edx
  8004ae:	75 09                	jne    8004b9 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8004b0:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8004b7:	eb 12                	jmp    8004cb <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004b9:	ff 45 e8             	incl   -0x18(%ebp)
  8004bc:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c1:	8b 50 74             	mov    0x74(%eax),%edx
  8004c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004c7:	39 c2                	cmp    %eax,%edx
  8004c9:	77 94                	ja     80045f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8004cb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8004cf:	75 14                	jne    8004e5 <CheckWSWithoutLastIndex+0xef>
			panic(
  8004d1:	83 ec 04             	sub    $0x4,%esp
  8004d4:	68 68 20 80 00       	push   $0x802068
  8004d9:	6a 3a                	push   $0x3a
  8004db:	68 5c 20 80 00       	push   $0x80205c
  8004e0:	e8 9f fe ff ff       	call   800384 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8004e5:	ff 45 f0             	incl   -0x10(%ebp)
  8004e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004eb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004ee:	0f 8c 3e ff ff ff    	jl     800432 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8004f4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004fb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800502:	eb 20                	jmp    800524 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800504:	a1 20 30 80 00       	mov    0x803020,%eax
  800509:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80050f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800512:	c1 e2 04             	shl    $0x4,%edx
  800515:	01 d0                	add    %edx,%eax
  800517:	8a 40 04             	mov    0x4(%eax),%al
  80051a:	3c 01                	cmp    $0x1,%al
  80051c:	75 03                	jne    800521 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80051e:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800521:	ff 45 e0             	incl   -0x20(%ebp)
  800524:	a1 20 30 80 00       	mov    0x803020,%eax
  800529:	8b 50 74             	mov    0x74(%eax),%edx
  80052c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80052f:	39 c2                	cmp    %eax,%edx
  800531:	77 d1                	ja     800504 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800533:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800536:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800539:	74 14                	je     80054f <CheckWSWithoutLastIndex+0x159>
		panic(
  80053b:	83 ec 04             	sub    $0x4,%esp
  80053e:	68 bc 20 80 00       	push   $0x8020bc
  800543:	6a 44                	push   $0x44
  800545:	68 5c 20 80 00       	push   $0x80205c
  80054a:	e8 35 fe ff ff       	call   800384 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80054f:	90                   	nop
  800550:	c9                   	leave  
  800551:	c3                   	ret    

00800552 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800552:	55                   	push   %ebp
  800553:	89 e5                	mov    %esp,%ebp
  800555:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800558:	8b 45 0c             	mov    0xc(%ebp),%eax
  80055b:	8b 00                	mov    (%eax),%eax
  80055d:	8d 48 01             	lea    0x1(%eax),%ecx
  800560:	8b 55 0c             	mov    0xc(%ebp),%edx
  800563:	89 0a                	mov    %ecx,(%edx)
  800565:	8b 55 08             	mov    0x8(%ebp),%edx
  800568:	88 d1                	mov    %dl,%cl
  80056a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80056d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800571:	8b 45 0c             	mov    0xc(%ebp),%eax
  800574:	8b 00                	mov    (%eax),%eax
  800576:	3d ff 00 00 00       	cmp    $0xff,%eax
  80057b:	75 2c                	jne    8005a9 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80057d:	a0 24 30 80 00       	mov    0x803024,%al
  800582:	0f b6 c0             	movzbl %al,%eax
  800585:	8b 55 0c             	mov    0xc(%ebp),%edx
  800588:	8b 12                	mov    (%edx),%edx
  80058a:	89 d1                	mov    %edx,%ecx
  80058c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80058f:	83 c2 08             	add    $0x8,%edx
  800592:	83 ec 04             	sub    $0x4,%esp
  800595:	50                   	push   %eax
  800596:	51                   	push   %ecx
  800597:	52                   	push   %edx
  800598:	e8 3e 0e 00 00       	call   8013db <sys_cputs>
  80059d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ac:	8b 40 04             	mov    0x4(%eax),%eax
  8005af:	8d 50 01             	lea    0x1(%eax),%edx
  8005b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005b5:	89 50 04             	mov    %edx,0x4(%eax)
}
  8005b8:	90                   	nop
  8005b9:	c9                   	leave  
  8005ba:	c3                   	ret    

008005bb <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8005bb:	55                   	push   %ebp
  8005bc:	89 e5                	mov    %esp,%ebp
  8005be:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005c4:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8005cb:	00 00 00 
	b.cnt = 0;
  8005ce:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005d5:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8005d8:	ff 75 0c             	pushl  0xc(%ebp)
  8005db:	ff 75 08             	pushl  0x8(%ebp)
  8005de:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005e4:	50                   	push   %eax
  8005e5:	68 52 05 80 00       	push   $0x800552
  8005ea:	e8 11 02 00 00       	call   800800 <vprintfmt>
  8005ef:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005f2:	a0 24 30 80 00       	mov    0x803024,%al
  8005f7:	0f b6 c0             	movzbl %al,%eax
  8005fa:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800600:	83 ec 04             	sub    $0x4,%esp
  800603:	50                   	push   %eax
  800604:	52                   	push   %edx
  800605:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80060b:	83 c0 08             	add    $0x8,%eax
  80060e:	50                   	push   %eax
  80060f:	e8 c7 0d 00 00       	call   8013db <sys_cputs>
  800614:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800617:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80061e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800624:	c9                   	leave  
  800625:	c3                   	ret    

00800626 <cprintf>:

int cprintf(const char *fmt, ...) {
  800626:	55                   	push   %ebp
  800627:	89 e5                	mov    %esp,%ebp
  800629:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80062c:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800633:	8d 45 0c             	lea    0xc(%ebp),%eax
  800636:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800639:	8b 45 08             	mov    0x8(%ebp),%eax
  80063c:	83 ec 08             	sub    $0x8,%esp
  80063f:	ff 75 f4             	pushl  -0xc(%ebp)
  800642:	50                   	push   %eax
  800643:	e8 73 ff ff ff       	call   8005bb <vcprintf>
  800648:	83 c4 10             	add    $0x10,%esp
  80064b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80064e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800651:	c9                   	leave  
  800652:	c3                   	ret    

00800653 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800653:	55                   	push   %ebp
  800654:	89 e5                	mov    %esp,%ebp
  800656:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800659:	e8 8e 0f 00 00       	call   8015ec <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80065e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800661:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800664:	8b 45 08             	mov    0x8(%ebp),%eax
  800667:	83 ec 08             	sub    $0x8,%esp
  80066a:	ff 75 f4             	pushl  -0xc(%ebp)
  80066d:	50                   	push   %eax
  80066e:	e8 48 ff ff ff       	call   8005bb <vcprintf>
  800673:	83 c4 10             	add    $0x10,%esp
  800676:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800679:	e8 88 0f 00 00       	call   801606 <sys_enable_interrupt>
	return cnt;
  80067e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800681:	c9                   	leave  
  800682:	c3                   	ret    

00800683 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800683:	55                   	push   %ebp
  800684:	89 e5                	mov    %esp,%ebp
  800686:	53                   	push   %ebx
  800687:	83 ec 14             	sub    $0x14,%esp
  80068a:	8b 45 10             	mov    0x10(%ebp),%eax
  80068d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800690:	8b 45 14             	mov    0x14(%ebp),%eax
  800693:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800696:	8b 45 18             	mov    0x18(%ebp),%eax
  800699:	ba 00 00 00 00       	mov    $0x0,%edx
  80069e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006a1:	77 55                	ja     8006f8 <printnum+0x75>
  8006a3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006a6:	72 05                	jb     8006ad <printnum+0x2a>
  8006a8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006ab:	77 4b                	ja     8006f8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006ad:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006b0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006b3:	8b 45 18             	mov    0x18(%ebp),%eax
  8006b6:	ba 00 00 00 00       	mov    $0x0,%edx
  8006bb:	52                   	push   %edx
  8006bc:	50                   	push   %eax
  8006bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8006c0:	ff 75 f0             	pushl  -0x10(%ebp)
  8006c3:	e8 48 13 00 00       	call   801a10 <__udivdi3>
  8006c8:	83 c4 10             	add    $0x10,%esp
  8006cb:	83 ec 04             	sub    $0x4,%esp
  8006ce:	ff 75 20             	pushl  0x20(%ebp)
  8006d1:	53                   	push   %ebx
  8006d2:	ff 75 18             	pushl  0x18(%ebp)
  8006d5:	52                   	push   %edx
  8006d6:	50                   	push   %eax
  8006d7:	ff 75 0c             	pushl  0xc(%ebp)
  8006da:	ff 75 08             	pushl  0x8(%ebp)
  8006dd:	e8 a1 ff ff ff       	call   800683 <printnum>
  8006e2:	83 c4 20             	add    $0x20,%esp
  8006e5:	eb 1a                	jmp    800701 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006e7:	83 ec 08             	sub    $0x8,%esp
  8006ea:	ff 75 0c             	pushl  0xc(%ebp)
  8006ed:	ff 75 20             	pushl  0x20(%ebp)
  8006f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f3:	ff d0                	call   *%eax
  8006f5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006f8:	ff 4d 1c             	decl   0x1c(%ebp)
  8006fb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006ff:	7f e6                	jg     8006e7 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800701:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800704:	bb 00 00 00 00       	mov    $0x0,%ebx
  800709:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80070c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80070f:	53                   	push   %ebx
  800710:	51                   	push   %ecx
  800711:	52                   	push   %edx
  800712:	50                   	push   %eax
  800713:	e8 08 14 00 00       	call   801b20 <__umoddi3>
  800718:	83 c4 10             	add    $0x10,%esp
  80071b:	05 34 23 80 00       	add    $0x802334,%eax
  800720:	8a 00                	mov    (%eax),%al
  800722:	0f be c0             	movsbl %al,%eax
  800725:	83 ec 08             	sub    $0x8,%esp
  800728:	ff 75 0c             	pushl  0xc(%ebp)
  80072b:	50                   	push   %eax
  80072c:	8b 45 08             	mov    0x8(%ebp),%eax
  80072f:	ff d0                	call   *%eax
  800731:	83 c4 10             	add    $0x10,%esp
}
  800734:	90                   	nop
  800735:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800738:	c9                   	leave  
  800739:	c3                   	ret    

0080073a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80073a:	55                   	push   %ebp
  80073b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80073d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800741:	7e 1c                	jle    80075f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800743:	8b 45 08             	mov    0x8(%ebp),%eax
  800746:	8b 00                	mov    (%eax),%eax
  800748:	8d 50 08             	lea    0x8(%eax),%edx
  80074b:	8b 45 08             	mov    0x8(%ebp),%eax
  80074e:	89 10                	mov    %edx,(%eax)
  800750:	8b 45 08             	mov    0x8(%ebp),%eax
  800753:	8b 00                	mov    (%eax),%eax
  800755:	83 e8 08             	sub    $0x8,%eax
  800758:	8b 50 04             	mov    0x4(%eax),%edx
  80075b:	8b 00                	mov    (%eax),%eax
  80075d:	eb 40                	jmp    80079f <getuint+0x65>
	else if (lflag)
  80075f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800763:	74 1e                	je     800783 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800765:	8b 45 08             	mov    0x8(%ebp),%eax
  800768:	8b 00                	mov    (%eax),%eax
  80076a:	8d 50 04             	lea    0x4(%eax),%edx
  80076d:	8b 45 08             	mov    0x8(%ebp),%eax
  800770:	89 10                	mov    %edx,(%eax)
  800772:	8b 45 08             	mov    0x8(%ebp),%eax
  800775:	8b 00                	mov    (%eax),%eax
  800777:	83 e8 04             	sub    $0x4,%eax
  80077a:	8b 00                	mov    (%eax),%eax
  80077c:	ba 00 00 00 00       	mov    $0x0,%edx
  800781:	eb 1c                	jmp    80079f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800783:	8b 45 08             	mov    0x8(%ebp),%eax
  800786:	8b 00                	mov    (%eax),%eax
  800788:	8d 50 04             	lea    0x4(%eax),%edx
  80078b:	8b 45 08             	mov    0x8(%ebp),%eax
  80078e:	89 10                	mov    %edx,(%eax)
  800790:	8b 45 08             	mov    0x8(%ebp),%eax
  800793:	8b 00                	mov    (%eax),%eax
  800795:	83 e8 04             	sub    $0x4,%eax
  800798:	8b 00                	mov    (%eax),%eax
  80079a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80079f:	5d                   	pop    %ebp
  8007a0:	c3                   	ret    

008007a1 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007a1:	55                   	push   %ebp
  8007a2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007a4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007a8:	7e 1c                	jle    8007c6 <getint+0x25>
		return va_arg(*ap, long long);
  8007aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ad:	8b 00                	mov    (%eax),%eax
  8007af:	8d 50 08             	lea    0x8(%eax),%edx
  8007b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b5:	89 10                	mov    %edx,(%eax)
  8007b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ba:	8b 00                	mov    (%eax),%eax
  8007bc:	83 e8 08             	sub    $0x8,%eax
  8007bf:	8b 50 04             	mov    0x4(%eax),%edx
  8007c2:	8b 00                	mov    (%eax),%eax
  8007c4:	eb 38                	jmp    8007fe <getint+0x5d>
	else if (lflag)
  8007c6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007ca:	74 1a                	je     8007e6 <getint+0x45>
		return va_arg(*ap, long);
  8007cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cf:	8b 00                	mov    (%eax),%eax
  8007d1:	8d 50 04             	lea    0x4(%eax),%edx
  8007d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d7:	89 10                	mov    %edx,(%eax)
  8007d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dc:	8b 00                	mov    (%eax),%eax
  8007de:	83 e8 04             	sub    $0x4,%eax
  8007e1:	8b 00                	mov    (%eax),%eax
  8007e3:	99                   	cltd   
  8007e4:	eb 18                	jmp    8007fe <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e9:	8b 00                	mov    (%eax),%eax
  8007eb:	8d 50 04             	lea    0x4(%eax),%edx
  8007ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f1:	89 10                	mov    %edx,(%eax)
  8007f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f6:	8b 00                	mov    (%eax),%eax
  8007f8:	83 e8 04             	sub    $0x4,%eax
  8007fb:	8b 00                	mov    (%eax),%eax
  8007fd:	99                   	cltd   
}
  8007fe:	5d                   	pop    %ebp
  8007ff:	c3                   	ret    

00800800 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800800:	55                   	push   %ebp
  800801:	89 e5                	mov    %esp,%ebp
  800803:	56                   	push   %esi
  800804:	53                   	push   %ebx
  800805:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800808:	eb 17                	jmp    800821 <vprintfmt+0x21>
			if (ch == '\0')
  80080a:	85 db                	test   %ebx,%ebx
  80080c:	0f 84 af 03 00 00    	je     800bc1 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800812:	83 ec 08             	sub    $0x8,%esp
  800815:	ff 75 0c             	pushl  0xc(%ebp)
  800818:	53                   	push   %ebx
  800819:	8b 45 08             	mov    0x8(%ebp),%eax
  80081c:	ff d0                	call   *%eax
  80081e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800821:	8b 45 10             	mov    0x10(%ebp),%eax
  800824:	8d 50 01             	lea    0x1(%eax),%edx
  800827:	89 55 10             	mov    %edx,0x10(%ebp)
  80082a:	8a 00                	mov    (%eax),%al
  80082c:	0f b6 d8             	movzbl %al,%ebx
  80082f:	83 fb 25             	cmp    $0x25,%ebx
  800832:	75 d6                	jne    80080a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800834:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800838:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80083f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800846:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80084d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800854:	8b 45 10             	mov    0x10(%ebp),%eax
  800857:	8d 50 01             	lea    0x1(%eax),%edx
  80085a:	89 55 10             	mov    %edx,0x10(%ebp)
  80085d:	8a 00                	mov    (%eax),%al
  80085f:	0f b6 d8             	movzbl %al,%ebx
  800862:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800865:	83 f8 55             	cmp    $0x55,%eax
  800868:	0f 87 2b 03 00 00    	ja     800b99 <vprintfmt+0x399>
  80086e:	8b 04 85 58 23 80 00 	mov    0x802358(,%eax,4),%eax
  800875:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800877:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80087b:	eb d7                	jmp    800854 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80087d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800881:	eb d1                	jmp    800854 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800883:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80088a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80088d:	89 d0                	mov    %edx,%eax
  80088f:	c1 e0 02             	shl    $0x2,%eax
  800892:	01 d0                	add    %edx,%eax
  800894:	01 c0                	add    %eax,%eax
  800896:	01 d8                	add    %ebx,%eax
  800898:	83 e8 30             	sub    $0x30,%eax
  80089b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80089e:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a1:	8a 00                	mov    (%eax),%al
  8008a3:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008a6:	83 fb 2f             	cmp    $0x2f,%ebx
  8008a9:	7e 3e                	jle    8008e9 <vprintfmt+0xe9>
  8008ab:	83 fb 39             	cmp    $0x39,%ebx
  8008ae:	7f 39                	jg     8008e9 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008b0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008b3:	eb d5                	jmp    80088a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b8:	83 c0 04             	add    $0x4,%eax
  8008bb:	89 45 14             	mov    %eax,0x14(%ebp)
  8008be:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c1:	83 e8 04             	sub    $0x4,%eax
  8008c4:	8b 00                	mov    (%eax),%eax
  8008c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008c9:	eb 1f                	jmp    8008ea <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008cb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008cf:	79 83                	jns    800854 <vprintfmt+0x54>
				width = 0;
  8008d1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008d8:	e9 77 ff ff ff       	jmp    800854 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008dd:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008e4:	e9 6b ff ff ff       	jmp    800854 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008e9:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008ea:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ee:	0f 89 60 ff ff ff    	jns    800854 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008f7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008fa:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800901:	e9 4e ff ff ff       	jmp    800854 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800906:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800909:	e9 46 ff ff ff       	jmp    800854 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80090e:	8b 45 14             	mov    0x14(%ebp),%eax
  800911:	83 c0 04             	add    $0x4,%eax
  800914:	89 45 14             	mov    %eax,0x14(%ebp)
  800917:	8b 45 14             	mov    0x14(%ebp),%eax
  80091a:	83 e8 04             	sub    $0x4,%eax
  80091d:	8b 00                	mov    (%eax),%eax
  80091f:	83 ec 08             	sub    $0x8,%esp
  800922:	ff 75 0c             	pushl  0xc(%ebp)
  800925:	50                   	push   %eax
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	ff d0                	call   *%eax
  80092b:	83 c4 10             	add    $0x10,%esp
			break;
  80092e:	e9 89 02 00 00       	jmp    800bbc <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800933:	8b 45 14             	mov    0x14(%ebp),%eax
  800936:	83 c0 04             	add    $0x4,%eax
  800939:	89 45 14             	mov    %eax,0x14(%ebp)
  80093c:	8b 45 14             	mov    0x14(%ebp),%eax
  80093f:	83 e8 04             	sub    $0x4,%eax
  800942:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800944:	85 db                	test   %ebx,%ebx
  800946:	79 02                	jns    80094a <vprintfmt+0x14a>
				err = -err;
  800948:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80094a:	83 fb 64             	cmp    $0x64,%ebx
  80094d:	7f 0b                	jg     80095a <vprintfmt+0x15a>
  80094f:	8b 34 9d a0 21 80 00 	mov    0x8021a0(,%ebx,4),%esi
  800956:	85 f6                	test   %esi,%esi
  800958:	75 19                	jne    800973 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80095a:	53                   	push   %ebx
  80095b:	68 45 23 80 00       	push   $0x802345
  800960:	ff 75 0c             	pushl  0xc(%ebp)
  800963:	ff 75 08             	pushl  0x8(%ebp)
  800966:	e8 5e 02 00 00       	call   800bc9 <printfmt>
  80096b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80096e:	e9 49 02 00 00       	jmp    800bbc <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800973:	56                   	push   %esi
  800974:	68 4e 23 80 00       	push   $0x80234e
  800979:	ff 75 0c             	pushl  0xc(%ebp)
  80097c:	ff 75 08             	pushl  0x8(%ebp)
  80097f:	e8 45 02 00 00       	call   800bc9 <printfmt>
  800984:	83 c4 10             	add    $0x10,%esp
			break;
  800987:	e9 30 02 00 00       	jmp    800bbc <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80098c:	8b 45 14             	mov    0x14(%ebp),%eax
  80098f:	83 c0 04             	add    $0x4,%eax
  800992:	89 45 14             	mov    %eax,0x14(%ebp)
  800995:	8b 45 14             	mov    0x14(%ebp),%eax
  800998:	83 e8 04             	sub    $0x4,%eax
  80099b:	8b 30                	mov    (%eax),%esi
  80099d:	85 f6                	test   %esi,%esi
  80099f:	75 05                	jne    8009a6 <vprintfmt+0x1a6>
				p = "(null)";
  8009a1:	be 51 23 80 00       	mov    $0x802351,%esi
			if (width > 0 && padc != '-')
  8009a6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009aa:	7e 6d                	jle    800a19 <vprintfmt+0x219>
  8009ac:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009b0:	74 67                	je     800a19 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009b5:	83 ec 08             	sub    $0x8,%esp
  8009b8:	50                   	push   %eax
  8009b9:	56                   	push   %esi
  8009ba:	e8 0c 03 00 00       	call   800ccb <strnlen>
  8009bf:	83 c4 10             	add    $0x10,%esp
  8009c2:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009c5:	eb 16                	jmp    8009dd <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009c7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009cb:	83 ec 08             	sub    $0x8,%esp
  8009ce:	ff 75 0c             	pushl  0xc(%ebp)
  8009d1:	50                   	push   %eax
  8009d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d5:	ff d0                	call   *%eax
  8009d7:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009da:	ff 4d e4             	decl   -0x1c(%ebp)
  8009dd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e1:	7f e4                	jg     8009c7 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009e3:	eb 34                	jmp    800a19 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009e5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009e9:	74 1c                	je     800a07 <vprintfmt+0x207>
  8009eb:	83 fb 1f             	cmp    $0x1f,%ebx
  8009ee:	7e 05                	jle    8009f5 <vprintfmt+0x1f5>
  8009f0:	83 fb 7e             	cmp    $0x7e,%ebx
  8009f3:	7e 12                	jle    800a07 <vprintfmt+0x207>
					putch('?', putdat);
  8009f5:	83 ec 08             	sub    $0x8,%esp
  8009f8:	ff 75 0c             	pushl  0xc(%ebp)
  8009fb:	6a 3f                	push   $0x3f
  8009fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800a00:	ff d0                	call   *%eax
  800a02:	83 c4 10             	add    $0x10,%esp
  800a05:	eb 0f                	jmp    800a16 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a07:	83 ec 08             	sub    $0x8,%esp
  800a0a:	ff 75 0c             	pushl  0xc(%ebp)
  800a0d:	53                   	push   %ebx
  800a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a11:	ff d0                	call   *%eax
  800a13:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a16:	ff 4d e4             	decl   -0x1c(%ebp)
  800a19:	89 f0                	mov    %esi,%eax
  800a1b:	8d 70 01             	lea    0x1(%eax),%esi
  800a1e:	8a 00                	mov    (%eax),%al
  800a20:	0f be d8             	movsbl %al,%ebx
  800a23:	85 db                	test   %ebx,%ebx
  800a25:	74 24                	je     800a4b <vprintfmt+0x24b>
  800a27:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a2b:	78 b8                	js     8009e5 <vprintfmt+0x1e5>
  800a2d:	ff 4d e0             	decl   -0x20(%ebp)
  800a30:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a34:	79 af                	jns    8009e5 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a36:	eb 13                	jmp    800a4b <vprintfmt+0x24b>
				putch(' ', putdat);
  800a38:	83 ec 08             	sub    $0x8,%esp
  800a3b:	ff 75 0c             	pushl  0xc(%ebp)
  800a3e:	6a 20                	push   $0x20
  800a40:	8b 45 08             	mov    0x8(%ebp),%eax
  800a43:	ff d0                	call   *%eax
  800a45:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a48:	ff 4d e4             	decl   -0x1c(%ebp)
  800a4b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a4f:	7f e7                	jg     800a38 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a51:	e9 66 01 00 00       	jmp    800bbc <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a56:	83 ec 08             	sub    $0x8,%esp
  800a59:	ff 75 e8             	pushl  -0x18(%ebp)
  800a5c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a5f:	50                   	push   %eax
  800a60:	e8 3c fd ff ff       	call   8007a1 <getint>
  800a65:	83 c4 10             	add    $0x10,%esp
  800a68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a71:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a74:	85 d2                	test   %edx,%edx
  800a76:	79 23                	jns    800a9b <vprintfmt+0x29b>
				putch('-', putdat);
  800a78:	83 ec 08             	sub    $0x8,%esp
  800a7b:	ff 75 0c             	pushl  0xc(%ebp)
  800a7e:	6a 2d                	push   $0x2d
  800a80:	8b 45 08             	mov    0x8(%ebp),%eax
  800a83:	ff d0                	call   *%eax
  800a85:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a88:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a8b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a8e:	f7 d8                	neg    %eax
  800a90:	83 d2 00             	adc    $0x0,%edx
  800a93:	f7 da                	neg    %edx
  800a95:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a98:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a9b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aa2:	e9 bc 00 00 00       	jmp    800b63 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800aa7:	83 ec 08             	sub    $0x8,%esp
  800aaa:	ff 75 e8             	pushl  -0x18(%ebp)
  800aad:	8d 45 14             	lea    0x14(%ebp),%eax
  800ab0:	50                   	push   %eax
  800ab1:	e8 84 fc ff ff       	call   80073a <getuint>
  800ab6:	83 c4 10             	add    $0x10,%esp
  800ab9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800abc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800abf:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ac6:	e9 98 00 00 00       	jmp    800b63 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800acb:	83 ec 08             	sub    $0x8,%esp
  800ace:	ff 75 0c             	pushl  0xc(%ebp)
  800ad1:	6a 58                	push   $0x58
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	ff d0                	call   *%eax
  800ad8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800adb:	83 ec 08             	sub    $0x8,%esp
  800ade:	ff 75 0c             	pushl  0xc(%ebp)
  800ae1:	6a 58                	push   $0x58
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	ff d0                	call   *%eax
  800ae8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aeb:	83 ec 08             	sub    $0x8,%esp
  800aee:	ff 75 0c             	pushl  0xc(%ebp)
  800af1:	6a 58                	push   $0x58
  800af3:	8b 45 08             	mov    0x8(%ebp),%eax
  800af6:	ff d0                	call   *%eax
  800af8:	83 c4 10             	add    $0x10,%esp
			break;
  800afb:	e9 bc 00 00 00       	jmp    800bbc <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b00:	83 ec 08             	sub    $0x8,%esp
  800b03:	ff 75 0c             	pushl  0xc(%ebp)
  800b06:	6a 30                	push   $0x30
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	ff d0                	call   *%eax
  800b0d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b10:	83 ec 08             	sub    $0x8,%esp
  800b13:	ff 75 0c             	pushl  0xc(%ebp)
  800b16:	6a 78                	push   $0x78
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	ff d0                	call   *%eax
  800b1d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b20:	8b 45 14             	mov    0x14(%ebp),%eax
  800b23:	83 c0 04             	add    $0x4,%eax
  800b26:	89 45 14             	mov    %eax,0x14(%ebp)
  800b29:	8b 45 14             	mov    0x14(%ebp),%eax
  800b2c:	83 e8 04             	sub    $0x4,%eax
  800b2f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b31:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b3b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b42:	eb 1f                	jmp    800b63 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b44:	83 ec 08             	sub    $0x8,%esp
  800b47:	ff 75 e8             	pushl  -0x18(%ebp)
  800b4a:	8d 45 14             	lea    0x14(%ebp),%eax
  800b4d:	50                   	push   %eax
  800b4e:	e8 e7 fb ff ff       	call   80073a <getuint>
  800b53:	83 c4 10             	add    $0x10,%esp
  800b56:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b59:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b5c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b63:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b67:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b6a:	83 ec 04             	sub    $0x4,%esp
  800b6d:	52                   	push   %edx
  800b6e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b71:	50                   	push   %eax
  800b72:	ff 75 f4             	pushl  -0xc(%ebp)
  800b75:	ff 75 f0             	pushl  -0x10(%ebp)
  800b78:	ff 75 0c             	pushl  0xc(%ebp)
  800b7b:	ff 75 08             	pushl  0x8(%ebp)
  800b7e:	e8 00 fb ff ff       	call   800683 <printnum>
  800b83:	83 c4 20             	add    $0x20,%esp
			break;
  800b86:	eb 34                	jmp    800bbc <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b88:	83 ec 08             	sub    $0x8,%esp
  800b8b:	ff 75 0c             	pushl  0xc(%ebp)
  800b8e:	53                   	push   %ebx
  800b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b92:	ff d0                	call   *%eax
  800b94:	83 c4 10             	add    $0x10,%esp
			break;
  800b97:	eb 23                	jmp    800bbc <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b99:	83 ec 08             	sub    $0x8,%esp
  800b9c:	ff 75 0c             	pushl  0xc(%ebp)
  800b9f:	6a 25                	push   $0x25
  800ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba4:	ff d0                	call   *%eax
  800ba6:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ba9:	ff 4d 10             	decl   0x10(%ebp)
  800bac:	eb 03                	jmp    800bb1 <vprintfmt+0x3b1>
  800bae:	ff 4d 10             	decl   0x10(%ebp)
  800bb1:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb4:	48                   	dec    %eax
  800bb5:	8a 00                	mov    (%eax),%al
  800bb7:	3c 25                	cmp    $0x25,%al
  800bb9:	75 f3                	jne    800bae <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800bbb:	90                   	nop
		}
	}
  800bbc:	e9 47 fc ff ff       	jmp    800808 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800bc1:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800bc2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800bc5:	5b                   	pop    %ebx
  800bc6:	5e                   	pop    %esi
  800bc7:	5d                   	pop    %ebp
  800bc8:	c3                   	ret    

00800bc9 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800bc9:	55                   	push   %ebp
  800bca:	89 e5                	mov    %esp,%ebp
  800bcc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800bcf:	8d 45 10             	lea    0x10(%ebp),%eax
  800bd2:	83 c0 04             	add    $0x4,%eax
  800bd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800bd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdb:	ff 75 f4             	pushl  -0xc(%ebp)
  800bde:	50                   	push   %eax
  800bdf:	ff 75 0c             	pushl  0xc(%ebp)
  800be2:	ff 75 08             	pushl  0x8(%ebp)
  800be5:	e8 16 fc ff ff       	call   800800 <vprintfmt>
  800bea:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bed:	90                   	nop
  800bee:	c9                   	leave  
  800bef:	c3                   	ret    

00800bf0 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bf0:	55                   	push   %ebp
  800bf1:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bf3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf6:	8b 40 08             	mov    0x8(%eax),%eax
  800bf9:	8d 50 01             	lea    0x1(%eax),%edx
  800bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bff:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c05:	8b 10                	mov    (%eax),%edx
  800c07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0a:	8b 40 04             	mov    0x4(%eax),%eax
  800c0d:	39 c2                	cmp    %eax,%edx
  800c0f:	73 12                	jae    800c23 <sprintputch+0x33>
		*b->buf++ = ch;
  800c11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c14:	8b 00                	mov    (%eax),%eax
  800c16:	8d 48 01             	lea    0x1(%eax),%ecx
  800c19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c1c:	89 0a                	mov    %ecx,(%edx)
  800c1e:	8b 55 08             	mov    0x8(%ebp),%edx
  800c21:	88 10                	mov    %dl,(%eax)
}
  800c23:	90                   	nop
  800c24:	5d                   	pop    %ebp
  800c25:	c3                   	ret    

00800c26 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c26:	55                   	push   %ebp
  800c27:	89 e5                	mov    %esp,%ebp
  800c29:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c35:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c38:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3b:	01 d0                	add    %edx,%eax
  800c3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c47:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c4b:	74 06                	je     800c53 <vsnprintf+0x2d>
  800c4d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c51:	7f 07                	jg     800c5a <vsnprintf+0x34>
		return -E_INVAL;
  800c53:	b8 03 00 00 00       	mov    $0x3,%eax
  800c58:	eb 20                	jmp    800c7a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c5a:	ff 75 14             	pushl  0x14(%ebp)
  800c5d:	ff 75 10             	pushl  0x10(%ebp)
  800c60:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c63:	50                   	push   %eax
  800c64:	68 f0 0b 80 00       	push   $0x800bf0
  800c69:	e8 92 fb ff ff       	call   800800 <vprintfmt>
  800c6e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c71:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c74:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c77:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c7a:	c9                   	leave  
  800c7b:	c3                   	ret    

00800c7c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c7c:	55                   	push   %ebp
  800c7d:	89 e5                	mov    %esp,%ebp
  800c7f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c82:	8d 45 10             	lea    0x10(%ebp),%eax
  800c85:	83 c0 04             	add    $0x4,%eax
  800c88:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c91:	50                   	push   %eax
  800c92:	ff 75 0c             	pushl  0xc(%ebp)
  800c95:	ff 75 08             	pushl  0x8(%ebp)
  800c98:	e8 89 ff ff ff       	call   800c26 <vsnprintf>
  800c9d:	83 c4 10             	add    $0x10,%esp
  800ca0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ca3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ca6:	c9                   	leave  
  800ca7:	c3                   	ret    

00800ca8 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ca8:	55                   	push   %ebp
  800ca9:	89 e5                	mov    %esp,%ebp
  800cab:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cb5:	eb 06                	jmp    800cbd <strlen+0x15>
		n++;
  800cb7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800cba:	ff 45 08             	incl   0x8(%ebp)
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	8a 00                	mov    (%eax),%al
  800cc2:	84 c0                	test   %al,%al
  800cc4:	75 f1                	jne    800cb7 <strlen+0xf>
		n++;
	return n;
  800cc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cc9:	c9                   	leave  
  800cca:	c3                   	ret    

00800ccb <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ccb:	55                   	push   %ebp
  800ccc:	89 e5                	mov    %esp,%ebp
  800cce:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cd1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cd8:	eb 09                	jmp    800ce3 <strnlen+0x18>
		n++;
  800cda:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cdd:	ff 45 08             	incl   0x8(%ebp)
  800ce0:	ff 4d 0c             	decl   0xc(%ebp)
  800ce3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ce7:	74 09                	je     800cf2 <strnlen+0x27>
  800ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cec:	8a 00                	mov    (%eax),%al
  800cee:	84 c0                	test   %al,%al
  800cf0:	75 e8                	jne    800cda <strnlen+0xf>
		n++;
	return n;
  800cf2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cf5:	c9                   	leave  
  800cf6:	c3                   	ret    

00800cf7 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cf7:	55                   	push   %ebp
  800cf8:	89 e5                	mov    %esp,%ebp
  800cfa:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d03:	90                   	nop
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	8d 50 01             	lea    0x1(%eax),%edx
  800d0a:	89 55 08             	mov    %edx,0x8(%ebp)
  800d0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d10:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d13:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d16:	8a 12                	mov    (%edx),%dl
  800d18:	88 10                	mov    %dl,(%eax)
  800d1a:	8a 00                	mov    (%eax),%al
  800d1c:	84 c0                	test   %al,%al
  800d1e:	75 e4                	jne    800d04 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d20:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d23:	c9                   	leave  
  800d24:	c3                   	ret    

00800d25 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d25:	55                   	push   %ebp
  800d26:	89 e5                	mov    %esp,%ebp
  800d28:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d38:	eb 1f                	jmp    800d59 <strncpy+0x34>
		*dst++ = *src;
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8d 50 01             	lea    0x1(%eax),%edx
  800d40:	89 55 08             	mov    %edx,0x8(%ebp)
  800d43:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d46:	8a 12                	mov    (%edx),%dl
  800d48:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4d:	8a 00                	mov    (%eax),%al
  800d4f:	84 c0                	test   %al,%al
  800d51:	74 03                	je     800d56 <strncpy+0x31>
			src++;
  800d53:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d56:	ff 45 fc             	incl   -0x4(%ebp)
  800d59:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d5f:	72 d9                	jb     800d3a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d61:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d64:	c9                   	leave  
  800d65:	c3                   	ret    

00800d66 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d66:	55                   	push   %ebp
  800d67:	89 e5                	mov    %esp,%ebp
  800d69:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d72:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d76:	74 30                	je     800da8 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d78:	eb 16                	jmp    800d90 <strlcpy+0x2a>
			*dst++ = *src++;
  800d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7d:	8d 50 01             	lea    0x1(%eax),%edx
  800d80:	89 55 08             	mov    %edx,0x8(%ebp)
  800d83:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d86:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d89:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d8c:	8a 12                	mov    (%edx),%dl
  800d8e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d90:	ff 4d 10             	decl   0x10(%ebp)
  800d93:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d97:	74 09                	je     800da2 <strlcpy+0x3c>
  800d99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9c:	8a 00                	mov    (%eax),%al
  800d9e:	84 c0                	test   %al,%al
  800da0:	75 d8                	jne    800d7a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800da8:	8b 55 08             	mov    0x8(%ebp),%edx
  800dab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dae:	29 c2                	sub    %eax,%edx
  800db0:	89 d0                	mov    %edx,%eax
}
  800db2:	c9                   	leave  
  800db3:	c3                   	ret    

00800db4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800db4:	55                   	push   %ebp
  800db5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800db7:	eb 06                	jmp    800dbf <strcmp+0xb>
		p++, q++;
  800db9:	ff 45 08             	incl   0x8(%ebp)
  800dbc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	8a 00                	mov    (%eax),%al
  800dc4:	84 c0                	test   %al,%al
  800dc6:	74 0e                	je     800dd6 <strcmp+0x22>
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	8a 10                	mov    (%eax),%dl
  800dcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd0:	8a 00                	mov    (%eax),%al
  800dd2:	38 c2                	cmp    %al,%dl
  800dd4:	74 e3                	je     800db9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	8a 00                	mov    (%eax),%al
  800ddb:	0f b6 d0             	movzbl %al,%edx
  800dde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de1:	8a 00                	mov    (%eax),%al
  800de3:	0f b6 c0             	movzbl %al,%eax
  800de6:	29 c2                	sub    %eax,%edx
  800de8:	89 d0                	mov    %edx,%eax
}
  800dea:	5d                   	pop    %ebp
  800deb:	c3                   	ret    

00800dec <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800dec:	55                   	push   %ebp
  800ded:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800def:	eb 09                	jmp    800dfa <strncmp+0xe>
		n--, p++, q++;
  800df1:	ff 4d 10             	decl   0x10(%ebp)
  800df4:	ff 45 08             	incl   0x8(%ebp)
  800df7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dfa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dfe:	74 17                	je     800e17 <strncmp+0x2b>
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
  800e03:	8a 00                	mov    (%eax),%al
  800e05:	84 c0                	test   %al,%al
  800e07:	74 0e                	je     800e17 <strncmp+0x2b>
  800e09:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0c:	8a 10                	mov    (%eax),%dl
  800e0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e11:	8a 00                	mov    (%eax),%al
  800e13:	38 c2                	cmp    %al,%dl
  800e15:	74 da                	je     800df1 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e17:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e1b:	75 07                	jne    800e24 <strncmp+0x38>
		return 0;
  800e1d:	b8 00 00 00 00       	mov    $0x0,%eax
  800e22:	eb 14                	jmp    800e38 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
  800e27:	8a 00                	mov    (%eax),%al
  800e29:	0f b6 d0             	movzbl %al,%edx
  800e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2f:	8a 00                	mov    (%eax),%al
  800e31:	0f b6 c0             	movzbl %al,%eax
  800e34:	29 c2                	sub    %eax,%edx
  800e36:	89 d0                	mov    %edx,%eax
}
  800e38:	5d                   	pop    %ebp
  800e39:	c3                   	ret    

00800e3a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e3a:	55                   	push   %ebp
  800e3b:	89 e5                	mov    %esp,%ebp
  800e3d:	83 ec 04             	sub    $0x4,%esp
  800e40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e43:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e46:	eb 12                	jmp    800e5a <strchr+0x20>
		if (*s == c)
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	8a 00                	mov    (%eax),%al
  800e4d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e50:	75 05                	jne    800e57 <strchr+0x1d>
			return (char *) s;
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
  800e55:	eb 11                	jmp    800e68 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e57:	ff 45 08             	incl   0x8(%ebp)
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	8a 00                	mov    (%eax),%al
  800e5f:	84 c0                	test   %al,%al
  800e61:	75 e5                	jne    800e48 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e63:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e68:	c9                   	leave  
  800e69:	c3                   	ret    

00800e6a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e6a:	55                   	push   %ebp
  800e6b:	89 e5                	mov    %esp,%ebp
  800e6d:	83 ec 04             	sub    $0x4,%esp
  800e70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e73:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e76:	eb 0d                	jmp    800e85 <strfind+0x1b>
		if (*s == c)
  800e78:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7b:	8a 00                	mov    (%eax),%al
  800e7d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e80:	74 0e                	je     800e90 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e82:	ff 45 08             	incl   0x8(%ebp)
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	8a 00                	mov    (%eax),%al
  800e8a:	84 c0                	test   %al,%al
  800e8c:	75 ea                	jne    800e78 <strfind+0xe>
  800e8e:	eb 01                	jmp    800e91 <strfind+0x27>
		if (*s == c)
			break;
  800e90:	90                   	nop
	return (char *) s;
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e94:	c9                   	leave  
  800e95:	c3                   	ret    

00800e96 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e96:	55                   	push   %ebp
  800e97:	89 e5                	mov    %esp,%ebp
  800e99:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ea2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ea8:	eb 0e                	jmp    800eb8 <memset+0x22>
		*p++ = c;
  800eaa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ead:	8d 50 01             	lea    0x1(%eax),%edx
  800eb0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800eb3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eb6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800eb8:	ff 4d f8             	decl   -0x8(%ebp)
  800ebb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ebf:	79 e9                	jns    800eaa <memset+0x14>
		*p++ = c;

	return v;
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ec4:	c9                   	leave  
  800ec5:	c3                   	ret    

00800ec6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ec6:	55                   	push   %ebp
  800ec7:	89 e5                	mov    %esp,%ebp
  800ec9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ed8:	eb 16                	jmp    800ef0 <memcpy+0x2a>
		*d++ = *s++;
  800eda:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800edd:	8d 50 01             	lea    0x1(%eax),%edx
  800ee0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ee3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ee6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ee9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800eec:	8a 12                	mov    (%edx),%dl
  800eee:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ef0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ef6:	89 55 10             	mov    %edx,0x10(%ebp)
  800ef9:	85 c0                	test   %eax,%eax
  800efb:	75 dd                	jne    800eda <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f00:	c9                   	leave  
  800f01:	c3                   	ret    

00800f02 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f02:	55                   	push   %ebp
  800f03:	89 e5                	mov    %esp,%ebp
  800f05:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f17:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f1a:	73 50                	jae    800f6c <memmove+0x6a>
  800f1c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f22:	01 d0                	add    %edx,%eax
  800f24:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f27:	76 43                	jbe    800f6c <memmove+0x6a>
		s += n;
  800f29:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f32:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f35:	eb 10                	jmp    800f47 <memmove+0x45>
			*--d = *--s;
  800f37:	ff 4d f8             	decl   -0x8(%ebp)
  800f3a:	ff 4d fc             	decl   -0x4(%ebp)
  800f3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f40:	8a 10                	mov    (%eax),%dl
  800f42:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f45:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f47:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f4d:	89 55 10             	mov    %edx,0x10(%ebp)
  800f50:	85 c0                	test   %eax,%eax
  800f52:	75 e3                	jne    800f37 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f54:	eb 23                	jmp    800f79 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f56:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f59:	8d 50 01             	lea    0x1(%eax),%edx
  800f5c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f5f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f62:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f65:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f68:	8a 12                	mov    (%edx),%dl
  800f6a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f72:	89 55 10             	mov    %edx,0x10(%ebp)
  800f75:	85 c0                	test   %eax,%eax
  800f77:	75 dd                	jne    800f56 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f7c:	c9                   	leave  
  800f7d:	c3                   	ret    

00800f7e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f7e:	55                   	push   %ebp
  800f7f:	89 e5                	mov    %esp,%ebp
  800f81:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f90:	eb 2a                	jmp    800fbc <memcmp+0x3e>
		if (*s1 != *s2)
  800f92:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f95:	8a 10                	mov    (%eax),%dl
  800f97:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	38 c2                	cmp    %al,%dl
  800f9e:	74 16                	je     800fb6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800fa0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	0f b6 d0             	movzbl %al,%edx
  800fa8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fab:	8a 00                	mov    (%eax),%al
  800fad:	0f b6 c0             	movzbl %al,%eax
  800fb0:	29 c2                	sub    %eax,%edx
  800fb2:	89 d0                	mov    %edx,%eax
  800fb4:	eb 18                	jmp    800fce <memcmp+0x50>
		s1++, s2++;
  800fb6:	ff 45 fc             	incl   -0x4(%ebp)
  800fb9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800fbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc2:	89 55 10             	mov    %edx,0x10(%ebp)
  800fc5:	85 c0                	test   %eax,%eax
  800fc7:	75 c9                	jne    800f92 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800fc9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fce:	c9                   	leave  
  800fcf:	c3                   	ret    

00800fd0 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800fd0:	55                   	push   %ebp
  800fd1:	89 e5                	mov    %esp,%ebp
  800fd3:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800fd6:	8b 55 08             	mov    0x8(%ebp),%edx
  800fd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdc:	01 d0                	add    %edx,%eax
  800fde:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800fe1:	eb 15                	jmp    800ff8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	0f b6 d0             	movzbl %al,%edx
  800feb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fee:	0f b6 c0             	movzbl %al,%eax
  800ff1:	39 c2                	cmp    %eax,%edx
  800ff3:	74 0d                	je     801002 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ff5:	ff 45 08             	incl   0x8(%ebp)
  800ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ffe:	72 e3                	jb     800fe3 <memfind+0x13>
  801000:	eb 01                	jmp    801003 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801002:	90                   	nop
	return (void *) s;
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801006:	c9                   	leave  
  801007:	c3                   	ret    

00801008 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801008:	55                   	push   %ebp
  801009:	89 e5                	mov    %esp,%ebp
  80100b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80100e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801015:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80101c:	eb 03                	jmp    801021 <strtol+0x19>
		s++;
  80101e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
  801024:	8a 00                	mov    (%eax),%al
  801026:	3c 20                	cmp    $0x20,%al
  801028:	74 f4                	je     80101e <strtol+0x16>
  80102a:	8b 45 08             	mov    0x8(%ebp),%eax
  80102d:	8a 00                	mov    (%eax),%al
  80102f:	3c 09                	cmp    $0x9,%al
  801031:	74 eb                	je     80101e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801033:	8b 45 08             	mov    0x8(%ebp),%eax
  801036:	8a 00                	mov    (%eax),%al
  801038:	3c 2b                	cmp    $0x2b,%al
  80103a:	75 05                	jne    801041 <strtol+0x39>
		s++;
  80103c:	ff 45 08             	incl   0x8(%ebp)
  80103f:	eb 13                	jmp    801054 <strtol+0x4c>
	else if (*s == '-')
  801041:	8b 45 08             	mov    0x8(%ebp),%eax
  801044:	8a 00                	mov    (%eax),%al
  801046:	3c 2d                	cmp    $0x2d,%al
  801048:	75 0a                	jne    801054 <strtol+0x4c>
		s++, neg = 1;
  80104a:	ff 45 08             	incl   0x8(%ebp)
  80104d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801054:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801058:	74 06                	je     801060 <strtol+0x58>
  80105a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80105e:	75 20                	jne    801080 <strtol+0x78>
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	8a 00                	mov    (%eax),%al
  801065:	3c 30                	cmp    $0x30,%al
  801067:	75 17                	jne    801080 <strtol+0x78>
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	40                   	inc    %eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	3c 78                	cmp    $0x78,%al
  801071:	75 0d                	jne    801080 <strtol+0x78>
		s += 2, base = 16;
  801073:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801077:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80107e:	eb 28                	jmp    8010a8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801080:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801084:	75 15                	jne    80109b <strtol+0x93>
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	8a 00                	mov    (%eax),%al
  80108b:	3c 30                	cmp    $0x30,%al
  80108d:	75 0c                	jne    80109b <strtol+0x93>
		s++, base = 8;
  80108f:	ff 45 08             	incl   0x8(%ebp)
  801092:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801099:	eb 0d                	jmp    8010a8 <strtol+0xa0>
	else if (base == 0)
  80109b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80109f:	75 07                	jne    8010a8 <strtol+0xa0>
		base = 10;
  8010a1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8010a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ab:	8a 00                	mov    (%eax),%al
  8010ad:	3c 2f                	cmp    $0x2f,%al
  8010af:	7e 19                	jle    8010ca <strtol+0xc2>
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	8a 00                	mov    (%eax),%al
  8010b6:	3c 39                	cmp    $0x39,%al
  8010b8:	7f 10                	jg     8010ca <strtol+0xc2>
			dig = *s - '0';
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	8a 00                	mov    (%eax),%al
  8010bf:	0f be c0             	movsbl %al,%eax
  8010c2:	83 e8 30             	sub    $0x30,%eax
  8010c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010c8:	eb 42                	jmp    80110c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	8a 00                	mov    (%eax),%al
  8010cf:	3c 60                	cmp    $0x60,%al
  8010d1:	7e 19                	jle    8010ec <strtol+0xe4>
  8010d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d6:	8a 00                	mov    (%eax),%al
  8010d8:	3c 7a                	cmp    $0x7a,%al
  8010da:	7f 10                	jg     8010ec <strtol+0xe4>
			dig = *s - 'a' + 10;
  8010dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010df:	8a 00                	mov    (%eax),%al
  8010e1:	0f be c0             	movsbl %al,%eax
  8010e4:	83 e8 57             	sub    $0x57,%eax
  8010e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010ea:	eb 20                	jmp    80110c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	8a 00                	mov    (%eax),%al
  8010f1:	3c 40                	cmp    $0x40,%al
  8010f3:	7e 39                	jle    80112e <strtol+0x126>
  8010f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f8:	8a 00                	mov    (%eax),%al
  8010fa:	3c 5a                	cmp    $0x5a,%al
  8010fc:	7f 30                	jg     80112e <strtol+0x126>
			dig = *s - 'A' + 10;
  8010fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801101:	8a 00                	mov    (%eax),%al
  801103:	0f be c0             	movsbl %al,%eax
  801106:	83 e8 37             	sub    $0x37,%eax
  801109:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80110c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80110f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801112:	7d 19                	jge    80112d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801114:	ff 45 08             	incl   0x8(%ebp)
  801117:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80111a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80111e:	89 c2                	mov    %eax,%edx
  801120:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801123:	01 d0                	add    %edx,%eax
  801125:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801128:	e9 7b ff ff ff       	jmp    8010a8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80112d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80112e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801132:	74 08                	je     80113c <strtol+0x134>
		*endptr = (char *) s;
  801134:	8b 45 0c             	mov    0xc(%ebp),%eax
  801137:	8b 55 08             	mov    0x8(%ebp),%edx
  80113a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80113c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801140:	74 07                	je     801149 <strtol+0x141>
  801142:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801145:	f7 d8                	neg    %eax
  801147:	eb 03                	jmp    80114c <strtol+0x144>
  801149:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80114c:	c9                   	leave  
  80114d:	c3                   	ret    

0080114e <ltostr>:

void
ltostr(long value, char *str)
{
  80114e:	55                   	push   %ebp
  80114f:	89 e5                	mov    %esp,%ebp
  801151:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801154:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80115b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801162:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801166:	79 13                	jns    80117b <ltostr+0x2d>
	{
		neg = 1;
  801168:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80116f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801172:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801175:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801178:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
  80117e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801183:	99                   	cltd   
  801184:	f7 f9                	idiv   %ecx
  801186:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801189:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80118c:	8d 50 01             	lea    0x1(%eax),%edx
  80118f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801192:	89 c2                	mov    %eax,%edx
  801194:	8b 45 0c             	mov    0xc(%ebp),%eax
  801197:	01 d0                	add    %edx,%eax
  801199:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80119c:	83 c2 30             	add    $0x30,%edx
  80119f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011a4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011a9:	f7 e9                	imul   %ecx
  8011ab:	c1 fa 02             	sar    $0x2,%edx
  8011ae:	89 c8                	mov    %ecx,%eax
  8011b0:	c1 f8 1f             	sar    $0x1f,%eax
  8011b3:	29 c2                	sub    %eax,%edx
  8011b5:	89 d0                	mov    %edx,%eax
  8011b7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8011ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011bd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011c2:	f7 e9                	imul   %ecx
  8011c4:	c1 fa 02             	sar    $0x2,%edx
  8011c7:	89 c8                	mov    %ecx,%eax
  8011c9:	c1 f8 1f             	sar    $0x1f,%eax
  8011cc:	29 c2                	sub    %eax,%edx
  8011ce:	89 d0                	mov    %edx,%eax
  8011d0:	c1 e0 02             	shl    $0x2,%eax
  8011d3:	01 d0                	add    %edx,%eax
  8011d5:	01 c0                	add    %eax,%eax
  8011d7:	29 c1                	sub    %eax,%ecx
  8011d9:	89 ca                	mov    %ecx,%edx
  8011db:	85 d2                	test   %edx,%edx
  8011dd:	75 9c                	jne    80117b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8011df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8011e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e9:	48                   	dec    %eax
  8011ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011ed:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011f1:	74 3d                	je     801230 <ltostr+0xe2>
		start = 1 ;
  8011f3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011fa:	eb 34                	jmp    801230 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801202:	01 d0                	add    %edx,%eax
  801204:	8a 00                	mov    (%eax),%al
  801206:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801209:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80120c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120f:	01 c2                	add    %eax,%edx
  801211:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801214:	8b 45 0c             	mov    0xc(%ebp),%eax
  801217:	01 c8                	add    %ecx,%eax
  801219:	8a 00                	mov    (%eax),%al
  80121b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80121d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801220:	8b 45 0c             	mov    0xc(%ebp),%eax
  801223:	01 c2                	add    %eax,%edx
  801225:	8a 45 eb             	mov    -0x15(%ebp),%al
  801228:	88 02                	mov    %al,(%edx)
		start++ ;
  80122a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80122d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801230:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801233:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801236:	7c c4                	jl     8011fc <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801238:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80123b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123e:	01 d0                	add    %edx,%eax
  801240:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801243:	90                   	nop
  801244:	c9                   	leave  
  801245:	c3                   	ret    

00801246 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801246:	55                   	push   %ebp
  801247:	89 e5                	mov    %esp,%ebp
  801249:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80124c:	ff 75 08             	pushl  0x8(%ebp)
  80124f:	e8 54 fa ff ff       	call   800ca8 <strlen>
  801254:	83 c4 04             	add    $0x4,%esp
  801257:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80125a:	ff 75 0c             	pushl  0xc(%ebp)
  80125d:	e8 46 fa ff ff       	call   800ca8 <strlen>
  801262:	83 c4 04             	add    $0x4,%esp
  801265:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801268:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80126f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801276:	eb 17                	jmp    80128f <strcconcat+0x49>
		final[s] = str1[s] ;
  801278:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80127b:	8b 45 10             	mov    0x10(%ebp),%eax
  80127e:	01 c2                	add    %eax,%edx
  801280:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801283:	8b 45 08             	mov    0x8(%ebp),%eax
  801286:	01 c8                	add    %ecx,%eax
  801288:	8a 00                	mov    (%eax),%al
  80128a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80128c:	ff 45 fc             	incl   -0x4(%ebp)
  80128f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801292:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801295:	7c e1                	jl     801278 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801297:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80129e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012a5:	eb 1f                	jmp    8012c6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012aa:	8d 50 01             	lea    0x1(%eax),%edx
  8012ad:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012b0:	89 c2                	mov    %eax,%edx
  8012b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b5:	01 c2                	add    %eax,%edx
  8012b7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8012ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bd:	01 c8                	add    %ecx,%eax
  8012bf:	8a 00                	mov    (%eax),%al
  8012c1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8012c3:	ff 45 f8             	incl   -0x8(%ebp)
  8012c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012cc:	7c d9                	jl     8012a7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8012ce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d4:	01 d0                	add    %edx,%eax
  8012d6:	c6 00 00             	movb   $0x0,(%eax)
}
  8012d9:	90                   	nop
  8012da:	c9                   	leave  
  8012db:	c3                   	ret    

008012dc <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8012dc:	55                   	push   %ebp
  8012dd:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8012df:	8b 45 14             	mov    0x14(%ebp),%eax
  8012e2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8012eb:	8b 00                	mov    (%eax),%eax
  8012ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f7:	01 d0                	add    %edx,%eax
  8012f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012ff:	eb 0c                	jmp    80130d <strsplit+0x31>
			*string++ = 0;
  801301:	8b 45 08             	mov    0x8(%ebp),%eax
  801304:	8d 50 01             	lea    0x1(%eax),%edx
  801307:	89 55 08             	mov    %edx,0x8(%ebp)
  80130a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80130d:	8b 45 08             	mov    0x8(%ebp),%eax
  801310:	8a 00                	mov    (%eax),%al
  801312:	84 c0                	test   %al,%al
  801314:	74 18                	je     80132e <strsplit+0x52>
  801316:	8b 45 08             	mov    0x8(%ebp),%eax
  801319:	8a 00                	mov    (%eax),%al
  80131b:	0f be c0             	movsbl %al,%eax
  80131e:	50                   	push   %eax
  80131f:	ff 75 0c             	pushl  0xc(%ebp)
  801322:	e8 13 fb ff ff       	call   800e3a <strchr>
  801327:	83 c4 08             	add    $0x8,%esp
  80132a:	85 c0                	test   %eax,%eax
  80132c:	75 d3                	jne    801301 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80132e:	8b 45 08             	mov    0x8(%ebp),%eax
  801331:	8a 00                	mov    (%eax),%al
  801333:	84 c0                	test   %al,%al
  801335:	74 5a                	je     801391 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801337:	8b 45 14             	mov    0x14(%ebp),%eax
  80133a:	8b 00                	mov    (%eax),%eax
  80133c:	83 f8 0f             	cmp    $0xf,%eax
  80133f:	75 07                	jne    801348 <strsplit+0x6c>
		{
			return 0;
  801341:	b8 00 00 00 00       	mov    $0x0,%eax
  801346:	eb 66                	jmp    8013ae <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801348:	8b 45 14             	mov    0x14(%ebp),%eax
  80134b:	8b 00                	mov    (%eax),%eax
  80134d:	8d 48 01             	lea    0x1(%eax),%ecx
  801350:	8b 55 14             	mov    0x14(%ebp),%edx
  801353:	89 0a                	mov    %ecx,(%edx)
  801355:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80135c:	8b 45 10             	mov    0x10(%ebp),%eax
  80135f:	01 c2                	add    %eax,%edx
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801366:	eb 03                	jmp    80136b <strsplit+0x8f>
			string++;
  801368:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	8a 00                	mov    (%eax),%al
  801370:	84 c0                	test   %al,%al
  801372:	74 8b                	je     8012ff <strsplit+0x23>
  801374:	8b 45 08             	mov    0x8(%ebp),%eax
  801377:	8a 00                	mov    (%eax),%al
  801379:	0f be c0             	movsbl %al,%eax
  80137c:	50                   	push   %eax
  80137d:	ff 75 0c             	pushl  0xc(%ebp)
  801380:	e8 b5 fa ff ff       	call   800e3a <strchr>
  801385:	83 c4 08             	add    $0x8,%esp
  801388:	85 c0                	test   %eax,%eax
  80138a:	74 dc                	je     801368 <strsplit+0x8c>
			string++;
	}
  80138c:	e9 6e ff ff ff       	jmp    8012ff <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801391:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801392:	8b 45 14             	mov    0x14(%ebp),%eax
  801395:	8b 00                	mov    (%eax),%eax
  801397:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80139e:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a1:	01 d0                	add    %edx,%eax
  8013a3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013a9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8013ae:	c9                   	leave  
  8013af:	c3                   	ret    

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
  801a0d:	66 90                	xchg   %ax,%ax
  801a0f:	90                   	nop

00801a10 <__udivdi3>:
  801a10:	55                   	push   %ebp
  801a11:	57                   	push   %edi
  801a12:	56                   	push   %esi
  801a13:	53                   	push   %ebx
  801a14:	83 ec 1c             	sub    $0x1c,%esp
  801a17:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a1b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a1f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a23:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a27:	89 ca                	mov    %ecx,%edx
  801a29:	89 f8                	mov    %edi,%eax
  801a2b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a2f:	85 f6                	test   %esi,%esi
  801a31:	75 2d                	jne    801a60 <__udivdi3+0x50>
  801a33:	39 cf                	cmp    %ecx,%edi
  801a35:	77 65                	ja     801a9c <__udivdi3+0x8c>
  801a37:	89 fd                	mov    %edi,%ebp
  801a39:	85 ff                	test   %edi,%edi
  801a3b:	75 0b                	jne    801a48 <__udivdi3+0x38>
  801a3d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a42:	31 d2                	xor    %edx,%edx
  801a44:	f7 f7                	div    %edi
  801a46:	89 c5                	mov    %eax,%ebp
  801a48:	31 d2                	xor    %edx,%edx
  801a4a:	89 c8                	mov    %ecx,%eax
  801a4c:	f7 f5                	div    %ebp
  801a4e:	89 c1                	mov    %eax,%ecx
  801a50:	89 d8                	mov    %ebx,%eax
  801a52:	f7 f5                	div    %ebp
  801a54:	89 cf                	mov    %ecx,%edi
  801a56:	89 fa                	mov    %edi,%edx
  801a58:	83 c4 1c             	add    $0x1c,%esp
  801a5b:	5b                   	pop    %ebx
  801a5c:	5e                   	pop    %esi
  801a5d:	5f                   	pop    %edi
  801a5e:	5d                   	pop    %ebp
  801a5f:	c3                   	ret    
  801a60:	39 ce                	cmp    %ecx,%esi
  801a62:	77 28                	ja     801a8c <__udivdi3+0x7c>
  801a64:	0f bd fe             	bsr    %esi,%edi
  801a67:	83 f7 1f             	xor    $0x1f,%edi
  801a6a:	75 40                	jne    801aac <__udivdi3+0x9c>
  801a6c:	39 ce                	cmp    %ecx,%esi
  801a6e:	72 0a                	jb     801a7a <__udivdi3+0x6a>
  801a70:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a74:	0f 87 9e 00 00 00    	ja     801b18 <__udivdi3+0x108>
  801a7a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a7f:	89 fa                	mov    %edi,%edx
  801a81:	83 c4 1c             	add    $0x1c,%esp
  801a84:	5b                   	pop    %ebx
  801a85:	5e                   	pop    %esi
  801a86:	5f                   	pop    %edi
  801a87:	5d                   	pop    %ebp
  801a88:	c3                   	ret    
  801a89:	8d 76 00             	lea    0x0(%esi),%esi
  801a8c:	31 ff                	xor    %edi,%edi
  801a8e:	31 c0                	xor    %eax,%eax
  801a90:	89 fa                	mov    %edi,%edx
  801a92:	83 c4 1c             	add    $0x1c,%esp
  801a95:	5b                   	pop    %ebx
  801a96:	5e                   	pop    %esi
  801a97:	5f                   	pop    %edi
  801a98:	5d                   	pop    %ebp
  801a99:	c3                   	ret    
  801a9a:	66 90                	xchg   %ax,%ax
  801a9c:	89 d8                	mov    %ebx,%eax
  801a9e:	f7 f7                	div    %edi
  801aa0:	31 ff                	xor    %edi,%edi
  801aa2:	89 fa                	mov    %edi,%edx
  801aa4:	83 c4 1c             	add    $0x1c,%esp
  801aa7:	5b                   	pop    %ebx
  801aa8:	5e                   	pop    %esi
  801aa9:	5f                   	pop    %edi
  801aaa:	5d                   	pop    %ebp
  801aab:	c3                   	ret    
  801aac:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ab1:	89 eb                	mov    %ebp,%ebx
  801ab3:	29 fb                	sub    %edi,%ebx
  801ab5:	89 f9                	mov    %edi,%ecx
  801ab7:	d3 e6                	shl    %cl,%esi
  801ab9:	89 c5                	mov    %eax,%ebp
  801abb:	88 d9                	mov    %bl,%cl
  801abd:	d3 ed                	shr    %cl,%ebp
  801abf:	89 e9                	mov    %ebp,%ecx
  801ac1:	09 f1                	or     %esi,%ecx
  801ac3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ac7:	89 f9                	mov    %edi,%ecx
  801ac9:	d3 e0                	shl    %cl,%eax
  801acb:	89 c5                	mov    %eax,%ebp
  801acd:	89 d6                	mov    %edx,%esi
  801acf:	88 d9                	mov    %bl,%cl
  801ad1:	d3 ee                	shr    %cl,%esi
  801ad3:	89 f9                	mov    %edi,%ecx
  801ad5:	d3 e2                	shl    %cl,%edx
  801ad7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801adb:	88 d9                	mov    %bl,%cl
  801add:	d3 e8                	shr    %cl,%eax
  801adf:	09 c2                	or     %eax,%edx
  801ae1:	89 d0                	mov    %edx,%eax
  801ae3:	89 f2                	mov    %esi,%edx
  801ae5:	f7 74 24 0c          	divl   0xc(%esp)
  801ae9:	89 d6                	mov    %edx,%esi
  801aeb:	89 c3                	mov    %eax,%ebx
  801aed:	f7 e5                	mul    %ebp
  801aef:	39 d6                	cmp    %edx,%esi
  801af1:	72 19                	jb     801b0c <__udivdi3+0xfc>
  801af3:	74 0b                	je     801b00 <__udivdi3+0xf0>
  801af5:	89 d8                	mov    %ebx,%eax
  801af7:	31 ff                	xor    %edi,%edi
  801af9:	e9 58 ff ff ff       	jmp    801a56 <__udivdi3+0x46>
  801afe:	66 90                	xchg   %ax,%ax
  801b00:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b04:	89 f9                	mov    %edi,%ecx
  801b06:	d3 e2                	shl    %cl,%edx
  801b08:	39 c2                	cmp    %eax,%edx
  801b0a:	73 e9                	jae    801af5 <__udivdi3+0xe5>
  801b0c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b0f:	31 ff                	xor    %edi,%edi
  801b11:	e9 40 ff ff ff       	jmp    801a56 <__udivdi3+0x46>
  801b16:	66 90                	xchg   %ax,%ax
  801b18:	31 c0                	xor    %eax,%eax
  801b1a:	e9 37 ff ff ff       	jmp    801a56 <__udivdi3+0x46>
  801b1f:	90                   	nop

00801b20 <__umoddi3>:
  801b20:	55                   	push   %ebp
  801b21:	57                   	push   %edi
  801b22:	56                   	push   %esi
  801b23:	53                   	push   %ebx
  801b24:	83 ec 1c             	sub    $0x1c,%esp
  801b27:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b2b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b33:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b3b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b3f:	89 f3                	mov    %esi,%ebx
  801b41:	89 fa                	mov    %edi,%edx
  801b43:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b47:	89 34 24             	mov    %esi,(%esp)
  801b4a:	85 c0                	test   %eax,%eax
  801b4c:	75 1a                	jne    801b68 <__umoddi3+0x48>
  801b4e:	39 f7                	cmp    %esi,%edi
  801b50:	0f 86 a2 00 00 00    	jbe    801bf8 <__umoddi3+0xd8>
  801b56:	89 c8                	mov    %ecx,%eax
  801b58:	89 f2                	mov    %esi,%edx
  801b5a:	f7 f7                	div    %edi
  801b5c:	89 d0                	mov    %edx,%eax
  801b5e:	31 d2                	xor    %edx,%edx
  801b60:	83 c4 1c             	add    $0x1c,%esp
  801b63:	5b                   	pop    %ebx
  801b64:	5e                   	pop    %esi
  801b65:	5f                   	pop    %edi
  801b66:	5d                   	pop    %ebp
  801b67:	c3                   	ret    
  801b68:	39 f0                	cmp    %esi,%eax
  801b6a:	0f 87 ac 00 00 00    	ja     801c1c <__umoddi3+0xfc>
  801b70:	0f bd e8             	bsr    %eax,%ebp
  801b73:	83 f5 1f             	xor    $0x1f,%ebp
  801b76:	0f 84 ac 00 00 00    	je     801c28 <__umoddi3+0x108>
  801b7c:	bf 20 00 00 00       	mov    $0x20,%edi
  801b81:	29 ef                	sub    %ebp,%edi
  801b83:	89 fe                	mov    %edi,%esi
  801b85:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b89:	89 e9                	mov    %ebp,%ecx
  801b8b:	d3 e0                	shl    %cl,%eax
  801b8d:	89 d7                	mov    %edx,%edi
  801b8f:	89 f1                	mov    %esi,%ecx
  801b91:	d3 ef                	shr    %cl,%edi
  801b93:	09 c7                	or     %eax,%edi
  801b95:	89 e9                	mov    %ebp,%ecx
  801b97:	d3 e2                	shl    %cl,%edx
  801b99:	89 14 24             	mov    %edx,(%esp)
  801b9c:	89 d8                	mov    %ebx,%eax
  801b9e:	d3 e0                	shl    %cl,%eax
  801ba0:	89 c2                	mov    %eax,%edx
  801ba2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ba6:	d3 e0                	shl    %cl,%eax
  801ba8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bac:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bb0:	89 f1                	mov    %esi,%ecx
  801bb2:	d3 e8                	shr    %cl,%eax
  801bb4:	09 d0                	or     %edx,%eax
  801bb6:	d3 eb                	shr    %cl,%ebx
  801bb8:	89 da                	mov    %ebx,%edx
  801bba:	f7 f7                	div    %edi
  801bbc:	89 d3                	mov    %edx,%ebx
  801bbe:	f7 24 24             	mull   (%esp)
  801bc1:	89 c6                	mov    %eax,%esi
  801bc3:	89 d1                	mov    %edx,%ecx
  801bc5:	39 d3                	cmp    %edx,%ebx
  801bc7:	0f 82 87 00 00 00    	jb     801c54 <__umoddi3+0x134>
  801bcd:	0f 84 91 00 00 00    	je     801c64 <__umoddi3+0x144>
  801bd3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bd7:	29 f2                	sub    %esi,%edx
  801bd9:	19 cb                	sbb    %ecx,%ebx
  801bdb:	89 d8                	mov    %ebx,%eax
  801bdd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801be1:	d3 e0                	shl    %cl,%eax
  801be3:	89 e9                	mov    %ebp,%ecx
  801be5:	d3 ea                	shr    %cl,%edx
  801be7:	09 d0                	or     %edx,%eax
  801be9:	89 e9                	mov    %ebp,%ecx
  801beb:	d3 eb                	shr    %cl,%ebx
  801bed:	89 da                	mov    %ebx,%edx
  801bef:	83 c4 1c             	add    $0x1c,%esp
  801bf2:	5b                   	pop    %ebx
  801bf3:	5e                   	pop    %esi
  801bf4:	5f                   	pop    %edi
  801bf5:	5d                   	pop    %ebp
  801bf6:	c3                   	ret    
  801bf7:	90                   	nop
  801bf8:	89 fd                	mov    %edi,%ebp
  801bfa:	85 ff                	test   %edi,%edi
  801bfc:	75 0b                	jne    801c09 <__umoddi3+0xe9>
  801bfe:	b8 01 00 00 00       	mov    $0x1,%eax
  801c03:	31 d2                	xor    %edx,%edx
  801c05:	f7 f7                	div    %edi
  801c07:	89 c5                	mov    %eax,%ebp
  801c09:	89 f0                	mov    %esi,%eax
  801c0b:	31 d2                	xor    %edx,%edx
  801c0d:	f7 f5                	div    %ebp
  801c0f:	89 c8                	mov    %ecx,%eax
  801c11:	f7 f5                	div    %ebp
  801c13:	89 d0                	mov    %edx,%eax
  801c15:	e9 44 ff ff ff       	jmp    801b5e <__umoddi3+0x3e>
  801c1a:	66 90                	xchg   %ax,%ax
  801c1c:	89 c8                	mov    %ecx,%eax
  801c1e:	89 f2                	mov    %esi,%edx
  801c20:	83 c4 1c             	add    $0x1c,%esp
  801c23:	5b                   	pop    %ebx
  801c24:	5e                   	pop    %esi
  801c25:	5f                   	pop    %edi
  801c26:	5d                   	pop    %ebp
  801c27:	c3                   	ret    
  801c28:	3b 04 24             	cmp    (%esp),%eax
  801c2b:	72 06                	jb     801c33 <__umoddi3+0x113>
  801c2d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c31:	77 0f                	ja     801c42 <__umoddi3+0x122>
  801c33:	89 f2                	mov    %esi,%edx
  801c35:	29 f9                	sub    %edi,%ecx
  801c37:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c3b:	89 14 24             	mov    %edx,(%esp)
  801c3e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c42:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c46:	8b 14 24             	mov    (%esp),%edx
  801c49:	83 c4 1c             	add    $0x1c,%esp
  801c4c:	5b                   	pop    %ebx
  801c4d:	5e                   	pop    %esi
  801c4e:	5f                   	pop    %edi
  801c4f:	5d                   	pop    %ebp
  801c50:	c3                   	ret    
  801c51:	8d 76 00             	lea    0x0(%esi),%esi
  801c54:	2b 04 24             	sub    (%esp),%eax
  801c57:	19 fa                	sbb    %edi,%edx
  801c59:	89 d1                	mov    %edx,%ecx
  801c5b:	89 c6                	mov    %eax,%esi
  801c5d:	e9 71 ff ff ff       	jmp    801bd3 <__umoddi3+0xb3>
  801c62:	66 90                	xchg   %ax,%ax
  801c64:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c68:	72 ea                	jb     801c54 <__umoddi3+0x134>
  801c6a:	89 d9                	mov    %ebx,%ecx
  801c6c:	e9 62 ff ff ff       	jmp    801bd3 <__umoddi3+0xb3>

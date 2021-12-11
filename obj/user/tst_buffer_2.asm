
obj/user/tst_buffer_2:     file format elf32-i386


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
  800031:	e8 20 09 00 00       	call   800956 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/*SHOULD be on User DATA not on the STACK*/
char arr[PAGE_SIZE*1024*14 + PAGE_SIZE];
//=========================================

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 6c             	sub    $0x6c,%esp



	/*[1] CHECK INITIAL WORKING SET*/
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800041:	a1 20 30 80 00       	mov    0x803020,%eax
  800046:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80004c:	8b 00                	mov    (%eax),%eax
  80004e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800051:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800054:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800059:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005e:	74 14                	je     800074 <_main+0x3c>
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	68 40 24 80 00       	push   $0x802440
  800068:	6a 17                	push   $0x17
  80006a:	68 88 24 80 00       	push   $0x802488
  80006f:	e8 27 0a 00 00       	call   800a9b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800074:	a1 20 30 80 00       	mov    0x803020,%eax
  800079:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80007f:	83 c0 10             	add    $0x10,%eax
  800082:	8b 00                	mov    (%eax),%eax
  800084:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800087:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80008a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008f:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800094:	74 14                	je     8000aa <_main+0x72>
  800096:	83 ec 04             	sub    $0x4,%esp
  800099:	68 40 24 80 00       	push   $0x802440
  80009e:	6a 18                	push   $0x18
  8000a0:	68 88 24 80 00       	push   $0x802488
  8000a5:	e8 f1 09 00 00       	call   800a9b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8000af:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b5:	83 c0 20             	add    $0x20,%eax
  8000b8:	8b 00                	mov    (%eax),%eax
  8000ba:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c5:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 40 24 80 00       	push   $0x802440
  8000d4:	6a 19                	push   $0x19
  8000d6:	68 88 24 80 00       	push   $0x802488
  8000db:	e8 bb 09 00 00       	call   800a9b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000eb:	83 c0 30             	add    $0x30,%eax
  8000ee:	8b 00                	mov    (%eax),%eax
  8000f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fb:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800100:	74 14                	je     800116 <_main+0xde>
  800102:	83 ec 04             	sub    $0x4,%esp
  800105:	68 40 24 80 00       	push   $0x802440
  80010a:	6a 1a                	push   $0x1a
  80010c:	68 88 24 80 00       	push   $0x802488
  800111:	e8 85 09 00 00       	call   800a9b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800116:	a1 20 30 80 00       	mov    0x803020,%eax
  80011b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800121:	83 c0 40             	add    $0x40,%eax
  800124:	8b 00                	mov    (%eax),%eax
  800126:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800129:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80012c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800131:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800136:	74 14                	je     80014c <_main+0x114>
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 40 24 80 00       	push   $0x802440
  800140:	6a 1b                	push   $0x1b
  800142:	68 88 24 80 00       	push   $0x802488
  800147:	e8 4f 09 00 00       	call   800a9b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80014c:	a1 20 30 80 00       	mov    0x803020,%eax
  800151:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800157:	83 c0 50             	add    $0x50,%eax
  80015a:	8b 00                	mov    (%eax),%eax
  80015c:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80015f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800162:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800167:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016c:	74 14                	je     800182 <_main+0x14a>
  80016e:	83 ec 04             	sub    $0x4,%esp
  800171:	68 40 24 80 00       	push   $0x802440
  800176:	6a 1c                	push   $0x1c
  800178:	68 88 24 80 00       	push   $0x802488
  80017d:	e8 19 09 00 00       	call   800a9b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800182:	a1 20 30 80 00       	mov    0x803020,%eax
  800187:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80018d:	83 c0 60             	add    $0x60,%eax
  800190:	8b 00                	mov    (%eax),%eax
  800192:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800195:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800198:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019d:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a2:	74 14                	je     8001b8 <_main+0x180>
  8001a4:	83 ec 04             	sub    $0x4,%esp
  8001a7:	68 40 24 80 00       	push   $0x802440
  8001ac:	6a 1d                	push   $0x1d
  8001ae:	68 88 24 80 00       	push   $0x802488
  8001b3:	e8 e3 08 00 00       	call   800a9b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c3:	83 c0 70             	add    $0x70,%eax
  8001c6:	8b 00                	mov    (%eax),%eax
  8001c8:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001cb:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d3:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d8:	74 14                	je     8001ee <_main+0x1b6>
  8001da:	83 ec 04             	sub    $0x4,%esp
  8001dd:	68 40 24 80 00       	push   $0x802440
  8001e2:	6a 1e                	push   $0x1e
  8001e4:	68 88 24 80 00       	push   $0x802488
  8001e9:	e8 ad 08 00 00       	call   800a9b <_panic>
		//if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f9:	83 e8 80             	sub    $0xffffff80,%eax
  8001fc:	8b 00                	mov    (%eax),%eax
  8001fe:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800201:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800204:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800209:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020e:	74 14                	je     800224 <_main+0x1ec>
  800210:	83 ec 04             	sub    $0x4,%esp
  800213:	68 40 24 80 00       	push   $0x802440
  800218:	6a 20                	push   $0x20
  80021a:	68 88 24 80 00       	push   $0x802488
  80021f:	e8 77 08 00 00       	call   800a9b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800224:	a1 20 30 80 00       	mov    0x803020,%eax
  800229:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80022f:	05 90 00 00 00       	add    $0x90,%eax
  800234:	8b 00                	mov    (%eax),%eax
  800236:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800239:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80023c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800241:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800246:	74 14                	je     80025c <_main+0x224>
  800248:	83 ec 04             	sub    $0x4,%esp
  80024b:	68 40 24 80 00       	push   $0x802440
  800250:	6a 21                	push   $0x21
  800252:	68 88 24 80 00       	push   $0x802488
  800257:	e8 3f 08 00 00       	call   800a9b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80025c:	a1 20 30 80 00       	mov    0x803020,%eax
  800261:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800267:	05 a0 00 00 00       	add    $0xa0,%eax
  80026c:	8b 00                	mov    (%eax),%eax
  80026e:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800271:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800274:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800279:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027e:	74 14                	je     800294 <_main+0x25c>
  800280:	83 ec 04             	sub    $0x4,%esp
  800283:	68 40 24 80 00       	push   $0x802440
  800288:	6a 22                	push   $0x22
  80028a:	68 88 24 80 00       	push   $0x802488
  80028f:	e8 07 08 00 00       	call   800a9b <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  800294:	a1 20 30 80 00       	mov    0x803020,%eax
  800299:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80029f:	85 c0                	test   %eax,%eax
  8002a1:	74 14                	je     8002b7 <_main+0x27f>
  8002a3:	83 ec 04             	sub    $0x4,%esp
  8002a6:	68 9c 24 80 00       	push   $0x80249c
  8002ab:	6a 23                	push   $0x23
  8002ad:	68 88 24 80 00       	push   $0x802488
  8002b2:	e8 e4 07 00 00       	call   800a9b <_panic>

	/*[2] RUN THE SLAVE PROGRAM*/

	//****************************************************************************************************************
	//IMP: program name is placed statically on the stack to avoid PAGE FAULT on it during the sys call inside the Kernel
	char slaveProgName[10] = "tpb2slave";
  8002b7:	8d 45 92             	lea    -0x6e(%ebp),%eax
  8002ba:	bb 23 28 80 00       	mov    $0x802823,%ebx
  8002bf:	ba 0a 00 00 00       	mov    $0xa,%edx
  8002c4:	89 c7                	mov    %eax,%edi
  8002c6:	89 de                	mov    %ebx,%esi
  8002c8:	89 d1                	mov    %edx,%ecx
  8002ca:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	//****************************************************************************************************************

	int32 envIdSlave = sys_create_env(slaveProgName, (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8002cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d1:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8002d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002dc:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8002e2:	89 c1                	mov    %eax,%ecx
  8002e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e9:	8b 40 74             	mov    0x74(%eax),%eax
  8002ec:	52                   	push   %edx
  8002ed:	51                   	push   %ecx
  8002ee:	50                   	push   %eax
  8002ef:	8d 45 92             	lea    -0x6e(%ebp),%eax
  8002f2:	50                   	push   %eax
  8002f3:	e8 90 1b 00 00       	call   801e88 <sys_create_env>
  8002f8:	83 c4 10             	add    $0x10,%esp
  8002fb:	89 45 b0             	mov    %eax,-0x50(%ebp)
	int initModBufCnt = sys_calculate_modified_frames();
  8002fe:	e8 49 19 00 00       	call   801c4c <sys_calculate_modified_frames>
  800303:	89 45 ac             	mov    %eax,-0x54(%ebp)
	sys_run_env(envIdSlave);
  800306:	83 ec 0c             	sub    $0xc,%esp
  800309:	ff 75 b0             	pushl  -0x50(%ebp)
  80030c:	e8 95 1b 00 00       	call   801ea6 <sys_run_env>
  800311:	83 c4 10             	add    $0x10,%esp

	/*[3] BUSY-WAIT FOR A WHILE TILL FINISHING IT*/
	env_sleep(5000);
  800314:	83 ec 0c             	sub    $0xc,%esp
  800317:	68 88 13 00 00       	push   $0x1388
  80031c:	e8 03 1e 00 00       	call   802124 <env_sleep>
  800321:	83 c4 10             	add    $0x10,%esp


	//NOW: modified list contains 7 pages from the slave program
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames of the slave ... WRONG number of buffered pages in MODIFIED frame list");
  800324:	e8 23 19 00 00       	call   801c4c <sys_calculate_modified_frames>
  800329:	89 c2                	mov    %eax,%edx
  80032b:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80032e:	29 c2                	sub    %eax,%edx
  800330:	89 d0                	mov    %edx,%eax
  800332:	83 f8 07             	cmp    $0x7,%eax
  800335:	74 14                	je     80034b <_main+0x313>
  800337:	83 ec 04             	sub    $0x4,%esp
  80033a:	68 ec 24 80 00       	push   $0x8024ec
  80033f:	6a 36                	push   $0x36
  800341:	68 88 24 80 00       	push   $0x802488
  800346:	e8 50 07 00 00       	call   800a9b <_panic>


	/*START OF TST_BUFFER_2*/
	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80034b:	e8 66 19 00 00       	call   801cb6 <sys_pf_calculate_allocated_pages>
  800350:	89 45 a8             	mov    %eax,-0x58(%ebp)
	int freePages = sys_calculate_free_frames();
  800353:	e8 db 18 00 00       	call   801c33 <sys_calculate_free_frames>
  800358:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  80035b:	e8 ec 18 00 00       	call   801c4c <sys_calculate_modified_frames>
  800360:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int initFreeBufCnt = sys_calculate_notmod_frames();
  800363:	e8 fd 18 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800368:	89 45 a0             	mov    %eax,-0x60(%ebp)
	int dummy = 0;
  80036b:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%ebp)
	//Fault #1
	int i=0;
  800372:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for(;i<1;i++)
  800379:	eb 0e                	jmp    800389 <_main+0x351>
	{
		arr[i] = -1;
  80037b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80037e:	05 40 30 80 00       	add    $0x803040,%eax
  800383:	c6 00 ff             	movb   $0xff,(%eax)
	initModBufCnt = sys_calculate_modified_frames();
	int initFreeBufCnt = sys_calculate_notmod_frames();
	int dummy = 0;
	//Fault #1
	int i=0;
	for(;i<1;i++)
  800386:	ff 45 e4             	incl   -0x1c(%ebp)
  800389:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80038d:	7e ec                	jle    80037b <_main+0x343>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80038f:	e8 d1 18 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800394:	89 c2                	mov    %eax,%edx
  800396:	a1 20 30 80 00       	mov    0x803020,%eax
  80039b:	8b 40 4c             	mov    0x4c(%eax),%eax
  80039e:	01 d0                	add    %edx,%eax
  8003a0:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #2
	i=PAGE_SIZE*1024;
  8003a3:	c7 45 e4 00 00 40 00 	movl   $0x400000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024+1;i++)
  8003aa:	eb 0e                	jmp    8003ba <_main+0x382>
	{
		arr[i] = -1;
  8003ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003af:	05 40 30 80 00       	add    $0x803040,%eax
  8003b4:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #2
	i=PAGE_SIZE*1024;
	for(;i<PAGE_SIZE*1024+1;i++)
  8003b7:	ff 45 e4             	incl   -0x1c(%ebp)
  8003ba:	81 7d e4 00 00 40 00 	cmpl   $0x400000,-0x1c(%ebp)
  8003c1:	7e e9                	jle    8003ac <_main+0x374>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8003c3:	e8 9d 18 00 00       	call   801c65 <sys_calculate_notmod_frames>
  8003c8:	89 c2                	mov    %eax,%edx
  8003ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8003cf:	8b 40 4c             	mov    0x4c(%eax),%eax
  8003d2:	01 d0                	add    %edx,%eax
  8003d4:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #3
	i=PAGE_SIZE*1024*2;
  8003d7:	c7 45 e4 00 00 80 00 	movl   $0x800000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*2+1;i++)
  8003de:	eb 0e                	jmp    8003ee <_main+0x3b6>
	{
		arr[i] = -1;
  8003e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003e3:	05 40 30 80 00       	add    $0x803040,%eax
  8003e8:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #3
	i=PAGE_SIZE*1024*2;
	for(;i<PAGE_SIZE*1024*2+1;i++)
  8003eb:	ff 45 e4             	incl   -0x1c(%ebp)
  8003ee:	81 7d e4 00 00 80 00 	cmpl   $0x800000,-0x1c(%ebp)
  8003f5:	7e e9                	jle    8003e0 <_main+0x3a8>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8003f7:	e8 69 18 00 00       	call   801c65 <sys_calculate_notmod_frames>
  8003fc:	89 c2                	mov    %eax,%edx
  8003fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800403:	8b 40 4c             	mov    0x4c(%eax),%eax
  800406:	01 d0                	add    %edx,%eax
  800408:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #4
	i=PAGE_SIZE*1024*3;
  80040b:	c7 45 e4 00 00 c0 00 	movl   $0xc00000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*3+1;i++)
  800412:	eb 0e                	jmp    800422 <_main+0x3ea>
	{
		arr[i] = -1;
  800414:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800417:	05 40 30 80 00       	add    $0x803040,%eax
  80041c:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #4
	i=PAGE_SIZE*1024*3;
	for(;i<PAGE_SIZE*1024*3+1;i++)
  80041f:	ff 45 e4             	incl   -0x1c(%ebp)
  800422:	81 7d e4 00 00 c0 00 	cmpl   $0xc00000,-0x1c(%ebp)
  800429:	7e e9                	jle    800414 <_main+0x3dc>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80042b:	e8 35 18 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800430:	89 c2                	mov    %eax,%edx
  800432:	a1 20 30 80 00       	mov    0x803020,%eax
  800437:	8b 40 4c             	mov    0x4c(%eax),%eax
  80043a:	01 d0                	add    %edx,%eax
  80043c:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #5
	i=PAGE_SIZE*1024*4;
  80043f:	c7 45 e4 00 00 00 01 	movl   $0x1000000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*4+1;i++)
  800446:	eb 0e                	jmp    800456 <_main+0x41e>
	{
		arr[i] = -1;
  800448:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80044b:	05 40 30 80 00       	add    $0x803040,%eax
  800450:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #5
	i=PAGE_SIZE*1024*4;
	for(;i<PAGE_SIZE*1024*4+1;i++)
  800453:	ff 45 e4             	incl   -0x1c(%ebp)
  800456:	81 7d e4 00 00 00 01 	cmpl   $0x1000000,-0x1c(%ebp)
  80045d:	7e e9                	jle    800448 <_main+0x410>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80045f:	e8 01 18 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800464:	89 c2                	mov    %eax,%edx
  800466:	a1 20 30 80 00       	mov    0x803020,%eax
  80046b:	8b 40 4c             	mov    0x4c(%eax),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #6
	i=PAGE_SIZE*1024*5;
  800473:	c7 45 e4 00 00 40 01 	movl   $0x1400000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*5+1;i++)
  80047a:	eb 0e                	jmp    80048a <_main+0x452>
	{
		arr[i] = -1;
  80047c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80047f:	05 40 30 80 00       	add    $0x803040,%eax
  800484:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #6
	i=PAGE_SIZE*1024*5;
	for(;i<PAGE_SIZE*1024*5+1;i++)
  800487:	ff 45 e4             	incl   -0x1c(%ebp)
  80048a:	81 7d e4 00 00 40 01 	cmpl   $0x1400000,-0x1c(%ebp)
  800491:	7e e9                	jle    80047c <_main+0x444>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800493:	e8 cd 17 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800498:	89 c2                	mov    %eax,%edx
  80049a:	a1 20 30 80 00       	mov    0x803020,%eax
  80049f:	8b 40 4c             	mov    0x4c(%eax),%eax
  8004a2:	01 d0                	add    %edx,%eax
  8004a4:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #7
	i=PAGE_SIZE*1024*6;
  8004a7:	c7 45 e4 00 00 80 01 	movl   $0x1800000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*6+1;i++)
  8004ae:	eb 0e                	jmp    8004be <_main+0x486>
	{
		arr[i] = -1;
  8004b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004b3:	05 40 30 80 00       	add    $0x803040,%eax
  8004b8:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #7
	i=PAGE_SIZE*1024*6;
	for(;i<PAGE_SIZE*1024*6+1;i++)
  8004bb:	ff 45 e4             	incl   -0x1c(%ebp)
  8004be:	81 7d e4 00 00 80 01 	cmpl   $0x1800000,-0x1c(%ebp)
  8004c5:	7e e9                	jle    8004b0 <_main+0x478>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8004c7:	e8 99 17 00 00       	call   801c65 <sys_calculate_notmod_frames>
  8004cc:	89 c2                	mov    %eax,%edx
  8004ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d3:	8b 40 4c             	mov    0x4c(%eax),%eax
  8004d6:	01 d0                	add    %edx,%eax
  8004d8:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #8
	i=PAGE_SIZE*1024*7;
  8004db:	c7 45 e4 00 00 c0 01 	movl   $0x1c00000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*7+1;i++)
  8004e2:	eb 0e                	jmp    8004f2 <_main+0x4ba>
	{
		arr[i] = -1;
  8004e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004e7:	05 40 30 80 00       	add    $0x803040,%eax
  8004ec:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #8
	i=PAGE_SIZE*1024*7;
	for(;i<PAGE_SIZE*1024*7+1;i++)
  8004ef:	ff 45 e4             	incl   -0x1c(%ebp)
  8004f2:	81 7d e4 00 00 c0 01 	cmpl   $0x1c00000,-0x1c(%ebp)
  8004f9:	7e e9                	jle    8004e4 <_main+0x4ac>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8004fb:	e8 65 17 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800500:	89 c2                	mov    %eax,%edx
  800502:	a1 20 30 80 00       	mov    0x803020,%eax
  800507:	8b 40 4c             	mov    0x4c(%eax),%eax
  80050a:	01 d0                	add    %edx,%eax
  80050c:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//TILL NOW: 8 pages were brought into MEM and be modified (7 unmodified should be buffered)
	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)
  80050f:	e8 51 17 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800514:	89 c2                	mov    %eax,%edx
  800516:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800519:	29 c2                	sub    %eax,%edx
  80051b:	89 d0                	mov    %edx,%eax
  80051d:	83 f8 07             	cmp    $0x7,%eax
  800520:	74 31                	je     800553 <_main+0x51b>
	{
		sys_env_destroy(envIdSlave);
  800522:	83 ec 0c             	sub    $0xc,%esp
  800525:	ff 75 b0             	pushl  -0x50(%ebp)
  800528:	e8 07 16 00 00       	call   801b34 <sys_env_destroy>
  80052d:	83 c4 10             	add    $0x10,%esp
		panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list %d",sys_calculate_notmod_frames()  - initFreeBufCnt);
  800530:	e8 30 17 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800535:	89 c2                	mov    %eax,%edx
  800537:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80053a:	29 c2                	sub    %eax,%edx
  80053c:	89 d0                	mov    %edx,%eax
  80053e:	50                   	push   %eax
  80053f:	68 64 25 80 00       	push   $0x802564
  800544:	68 83 00 00 00       	push   $0x83
  800549:	68 88 24 80 00       	push   $0x802488
  80054e:	e8 48 05 00 00       	call   800a9b <_panic>
	}
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)
  800553:	e8 f4 16 00 00       	call   801c4c <sys_calculate_modified_frames>
  800558:	89 c2                	mov    %eax,%edx
  80055a:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80055d:	39 c2                	cmp    %eax,%edx
  80055f:	74 25                	je     800586 <_main+0x54e>
	{
		sys_env_destroy(envIdSlave);
  800561:	83 ec 0c             	sub    $0xc,%esp
  800564:	ff 75 b0             	pushl  -0x50(%ebp)
  800567:	e8 c8 15 00 00       	call   801b34 <sys_env_destroy>
  80056c:	83 c4 10             	add    $0x10,%esp
		panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  80056f:	83 ec 04             	sub    $0x4,%esp
  800572:	68 c8 25 80 00       	push   $0x8025c8
  800577:	68 88 00 00 00       	push   $0x88
  80057c:	68 88 24 80 00       	push   $0x802488
  800581:	e8 15 05 00 00       	call   800a9b <_panic>
	}

	initFreeBufCnt = sys_calculate_notmod_frames();
  800586:	e8 da 16 00 00       	call   801c65 <sys_calculate_notmod_frames>
  80058b:	89 45 a0             	mov    %eax,-0x60(%ebp)

	//The following 7 faults should victimize the 7 previously modified pages
	//(i.e. the modified list should be freed after 3 faults... then, two modified frames will be added to it again)
	//Fault #7
	i=PAGE_SIZE*1024*8;
  80058e:	c7 45 e4 00 00 00 02 	movl   $0x2000000,-0x1c(%ebp)
	int s = 0;
  800595:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(;i<PAGE_SIZE*1024*8+1;i++)
  80059c:	eb 13                	jmp    8005b1 <_main+0x579>
	{
		s += arr[i] ;
  80059e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005a1:	05 40 30 80 00       	add    $0x803040,%eax
  8005a6:	8a 00                	mov    (%eax),%al
  8005a8:	0f be c0             	movsbl %al,%eax
  8005ab:	01 45 e0             	add    %eax,-0x20(%ebp)
	//The following 7 faults should victimize the 7 previously modified pages
	//(i.e. the modified list should be freed after 3 faults... then, two modified frames will be added to it again)
	//Fault #7
	i=PAGE_SIZE*1024*8;
	int s = 0;
	for(;i<PAGE_SIZE*1024*8+1;i++)
  8005ae:	ff 45 e4             	incl   -0x1c(%ebp)
  8005b1:	81 7d e4 00 00 00 02 	cmpl   $0x2000000,-0x1c(%ebp)
  8005b8:	7e e4                	jle    80059e <_main+0x566>
	{
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8005ba:	e8 a6 16 00 00       	call   801c65 <sys_calculate_notmod_frames>
  8005bf:	89 c2                	mov    %eax,%edx
  8005c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8005c6:	8b 40 4c             	mov    0x4c(%eax),%eax
  8005c9:	01 d0                	add    %edx,%eax
  8005cb:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #8
	i=PAGE_SIZE*1024*9;
  8005ce:	c7 45 e4 00 00 40 02 	movl   $0x2400000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*9+1;i++)
  8005d5:	eb 13                	jmp    8005ea <_main+0x5b2>
	{
		s += arr[i] ;
  8005d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005da:	05 40 30 80 00       	add    $0x803040,%eax
  8005df:	8a 00                	mov    (%eax),%al
  8005e1:	0f be c0             	movsbl %al,%eax
  8005e4:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #8
	i=PAGE_SIZE*1024*9;
	for(;i<PAGE_SIZE*1024*9+1;i++)
  8005e7:	ff 45 e4             	incl   -0x1c(%ebp)
  8005ea:	81 7d e4 00 00 40 02 	cmpl   $0x2400000,-0x1c(%ebp)
  8005f1:	7e e4                	jle    8005d7 <_main+0x59f>
	{
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8005f3:	e8 6d 16 00 00       	call   801c65 <sys_calculate_notmod_frames>
  8005f8:	89 c2                	mov    %eax,%edx
  8005fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ff:	8b 40 4c             	mov    0x4c(%eax),%eax
  800602:	01 d0                	add    %edx,%eax
  800604:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #9
	i=PAGE_SIZE*1024*10;
  800607:	c7 45 e4 00 00 80 02 	movl   $0x2800000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*10+1;i++)
  80060e:	eb 13                	jmp    800623 <_main+0x5eb>
	{
		s += arr[i] ;
  800610:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800613:	05 40 30 80 00       	add    $0x803040,%eax
  800618:	8a 00                	mov    (%eax),%al
  80061a:	0f be c0             	movsbl %al,%eax
  80061d:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #9
	i=PAGE_SIZE*1024*10;
	for(;i<PAGE_SIZE*1024*10+1;i++)
  800620:	ff 45 e4             	incl   -0x1c(%ebp)
  800623:	81 7d e4 00 00 80 02 	cmpl   $0x2800000,-0x1c(%ebp)
  80062a:	7e e4                	jle    800610 <_main+0x5d8>
	{
		s += arr[i] ;
	}

	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80062c:	e8 34 16 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800631:	89 c2                	mov    %eax,%edx
  800633:	a1 20 30 80 00       	mov    0x803020,%eax
  800638:	8b 40 4c             	mov    0x4c(%eax),%eax
  80063b:	01 d0                	add    %edx,%eax
  80063d:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//HERE: modified list should be freed
	if (sys_calculate_modified_frames() != 0)
  800640:	e8 07 16 00 00       	call   801c4c <sys_calculate_modified_frames>
  800645:	85 c0                	test   %eax,%eax
  800647:	74 25                	je     80066e <_main+0x636>
	{
		sys_env_destroy(envIdSlave);
  800649:	83 ec 0c             	sub    $0xc,%esp
  80064c:	ff 75 b0             	pushl  -0x50(%ebp)
  80064f:	e8 e0 14 00 00       	call   801b34 <sys_env_destroy>
  800654:	83 c4 10             	add    $0x10,%esp
		panic("Modified frames not removed from list (or not updated) correctly when the modified list reaches MAX");
  800657:	83 ec 04             	sub    $0x4,%esp
  80065a:	68 34 26 80 00       	push   $0x802634
  80065f:	68 ad 00 00 00       	push   $0xad
  800664:	68 88 24 80 00       	push   $0x802488
  800669:	e8 2d 04 00 00       	call   800a9b <_panic>
	}
	if ((sys_calculate_notmod_frames() - initFreeBufCnt) != 10)
  80066e:	e8 f2 15 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800673:	89 c2                	mov    %eax,%edx
  800675:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800678:	29 c2                	sub    %eax,%edx
  80067a:	89 d0                	mov    %edx,%eax
  80067c:	83 f8 0a             	cmp    $0xa,%eax
  80067f:	74 25                	je     8006a6 <_main+0x66e>
	{
		sys_env_destroy(envIdSlave);
  800681:	83 ec 0c             	sub    $0xc,%esp
  800684:	ff 75 b0             	pushl  -0x50(%ebp)
  800687:	e8 a8 14 00 00       	call   801b34 <sys_env_destroy>
  80068c:	83 c4 10             	add    $0x10,%esp
		panic("Modified frames not added to free frame list as BUFFERED when the modified list reaches MAX");
  80068f:	83 ec 04             	sub    $0x4,%esp
  800692:	68 98 26 80 00       	push   $0x802698
  800697:	68 b2 00 00 00       	push   $0xb2
  80069c:	68 88 24 80 00       	push   $0x802488
  8006a1:	e8 f5 03 00 00       	call   800a9b <_panic>
	}

	//Three additional fault (i.e. three modified page will be added to modified list)
	//Fault #10
	i = PAGE_SIZE * 1024 * 11;
  8006a6:	c7 45 e4 00 00 c0 02 	movl   $0x2c00000,-0x1c(%ebp)
	for (; i < PAGE_SIZE * 1024*11 + 1; i++) {
  8006ad:	eb 13                	jmp    8006c2 <_main+0x68a>
		s += arr[i] ;
  8006af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006b2:	05 40 30 80 00       	add    $0x803040,%eax
  8006b7:	8a 00                	mov    (%eax),%al
  8006b9:	0f be c0             	movsbl %al,%eax
  8006bc:	01 45 e0             	add    %eax,-0x20(%ebp)
	}

	//Three additional fault (i.e. three modified page will be added to modified list)
	//Fault #10
	i = PAGE_SIZE * 1024 * 11;
	for (; i < PAGE_SIZE * 1024*11 + 1; i++) {
  8006bf:	ff 45 e4             	incl   -0x1c(%ebp)
  8006c2:	81 7d e4 00 00 c0 02 	cmpl   $0x2c00000,-0x1c(%ebp)
  8006c9:	7e e4                	jle    8006af <_main+0x677>
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8006cb:	e8 95 15 00 00       	call   801c65 <sys_calculate_notmod_frames>
  8006d0:	89 c2                	mov    %eax,%edx
  8006d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006d7:	8b 40 4c             	mov    0x4c(%eax),%eax
  8006da:	01 d0                	add    %edx,%eax
  8006dc:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #11
	i = PAGE_SIZE * 1024 * 12;
  8006df:	c7 45 e4 00 00 00 03 	movl   $0x3000000,-0x1c(%ebp)
	for (; i < PAGE_SIZE * 1024*12 + 1; i++) {
  8006e6:	eb 13                	jmp    8006fb <_main+0x6c3>
		s += arr[i] ;
  8006e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006eb:	05 40 30 80 00       	add    $0x803040,%eax
  8006f0:	8a 00                	mov    (%eax),%al
  8006f2:	0f be c0             	movsbl %al,%eax
  8006f5:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #11
	i = PAGE_SIZE * 1024 * 12;
	for (; i < PAGE_SIZE * 1024*12 + 1; i++) {
  8006f8:	ff 45 e4             	incl   -0x1c(%ebp)
  8006fb:	81 7d e4 00 00 00 03 	cmpl   $0x3000000,-0x1c(%ebp)
  800702:	7e e4                	jle    8006e8 <_main+0x6b0>
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800704:	e8 5c 15 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800709:	89 c2                	mov    %eax,%edx
  80070b:	a1 20 30 80 00       	mov    0x803020,%eax
  800710:	8b 40 4c             	mov    0x4c(%eax),%eax
  800713:	01 d0                	add    %edx,%eax
  800715:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #12
	i = PAGE_SIZE * 1024 * 13;
  800718:	c7 45 e4 00 00 40 03 	movl   $0x3400000,-0x1c(%ebp)
	for (; i < PAGE_SIZE * 1024*13 + 1; i++) {
  80071f:	eb 13                	jmp    800734 <_main+0x6fc>
		s += arr[i] ;
  800721:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800724:	05 40 30 80 00       	add    $0x803040,%eax
  800729:	8a 00                	mov    (%eax),%al
  80072b:	0f be c0             	movsbl %al,%eax
  80072e:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #12
	i = PAGE_SIZE * 1024 * 13;
	for (; i < PAGE_SIZE * 1024*13 + 1; i++) {
  800731:	ff 45 e4             	incl   -0x1c(%ebp)
  800734:	81 7d e4 00 00 40 03 	cmpl   $0x3400000,-0x1c(%ebp)
  80073b:	7e e4                	jle    800721 <_main+0x6e9>
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80073d:	e8 23 15 00 00       	call   801c65 <sys_calculate_notmod_frames>
  800742:	89 c2                	mov    %eax,%edx
  800744:	a1 20 30 80 00       	mov    0x803020,%eax
  800749:	8b 40 4c             	mov    0x4c(%eax),%eax
  80074c:	01 d0                	add    %edx,%eax
  80074e:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//cprintf("testing...\n");
	{
		if (sys_calculate_modified_frames() != 3)
  800751:	e8 f6 14 00 00       	call   801c4c <sys_calculate_modified_frames>
  800756:	83 f8 03             	cmp    $0x3,%eax
  800759:	74 25                	je     800780 <_main+0x748>
		{
			sys_env_destroy(envIdSlave);
  80075b:	83 ec 0c             	sub    $0xc,%esp
  80075e:	ff 75 b0             	pushl  -0x50(%ebp)
  800761:	e8 ce 13 00 00       	call   801b34 <sys_env_destroy>
  800766:	83 c4 10             	add    $0x10,%esp
			panic("Modified frames not removed from list (or not updated) correctly when the modified list reaches MAX");
  800769:	83 ec 04             	sub    $0x4,%esp
  80076c:	68 34 26 80 00       	push   $0x802634
  800771:	68 d0 00 00 00       	push   $0xd0
  800776:	68 88 24 80 00       	push   $0x802488
  80077b:	e8 1b 03 00 00       	call   800a9b <_panic>
		}

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0)
  800780:	e8 31 15 00 00       	call   801cb6 <sys_pf_calculate_allocated_pages>
  800785:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  800788:	74 25                	je     8007af <_main+0x777>
		{
			sys_env_destroy(envIdSlave);
  80078a:	83 ec 0c             	sub    $0xc,%esp
  80078d:	ff 75 b0             	pushl  -0x50(%ebp)
  800790:	e8 9f 13 00 00       	call   801b34 <sys_env_destroy>
  800795:	83 c4 10             	add    $0x10,%esp
			panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800798:	83 ec 04             	sub    $0x4,%esp
  80079b:	68 f4 26 80 00       	push   $0x8026f4
  8007a0:	68 d6 00 00 00       	push   $0xd6
  8007a5:	68 88 24 80 00       	push   $0x802488
  8007aa:	e8 ec 02 00 00       	call   800a9b <_panic>
		}

		if( arr[0] != -1) 						{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  8007af:	a0 40 30 80 00       	mov    0x803040,%al
  8007b4:	3c ff                	cmp    $0xff,%al
  8007b6:	74 25                	je     8007dd <_main+0x7a5>
  8007b8:	83 ec 0c             	sub    $0xc,%esp
  8007bb:	ff 75 b0             	pushl  -0x50(%ebp)
  8007be:	e8 71 13 00 00       	call   801b34 <sys_env_destroy>
  8007c3:	83 c4 10             	add    $0x10,%esp
  8007c6:	83 ec 04             	sub    $0x4,%esp
  8007c9:	68 60 27 80 00       	push   $0x802760
  8007ce:	68 d9 00 00 00       	push   $0xd9
  8007d3:	68 88 24 80 00       	push   $0x802488
  8007d8:	e8 be 02 00 00       	call   800a9b <_panic>
		if( arr[PAGE_SIZE * 1024 * 1] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  8007dd:	a0 40 30 c0 00       	mov    0xc03040,%al
  8007e2:	3c ff                	cmp    $0xff,%al
  8007e4:	74 25                	je     80080b <_main+0x7d3>
  8007e6:	83 ec 0c             	sub    $0xc,%esp
  8007e9:	ff 75 b0             	pushl  -0x50(%ebp)
  8007ec:	e8 43 13 00 00       	call   801b34 <sys_env_destroy>
  8007f1:	83 c4 10             	add    $0x10,%esp
  8007f4:	83 ec 04             	sub    $0x4,%esp
  8007f7:	68 60 27 80 00       	push   $0x802760
  8007fc:	68 da 00 00 00       	push   $0xda
  800801:	68 88 24 80 00       	push   $0x802488
  800806:	e8 90 02 00 00       	call   800a9b <_panic>
		if( arr[PAGE_SIZE * 1024 * 2] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  80080b:	a0 40 30 00 01       	mov    0x1003040,%al
  800810:	3c ff                	cmp    $0xff,%al
  800812:	74 25                	je     800839 <_main+0x801>
  800814:	83 ec 0c             	sub    $0xc,%esp
  800817:	ff 75 b0             	pushl  -0x50(%ebp)
  80081a:	e8 15 13 00 00       	call   801b34 <sys_env_destroy>
  80081f:	83 c4 10             	add    $0x10,%esp
  800822:	83 ec 04             	sub    $0x4,%esp
  800825:	68 60 27 80 00       	push   $0x802760
  80082a:	68 db 00 00 00       	push   $0xdb
  80082f:	68 88 24 80 00       	push   $0x802488
  800834:	e8 62 02 00 00       	call   800a9b <_panic>
		if( arr[PAGE_SIZE * 1024 * 3] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  800839:	a0 40 30 40 01       	mov    0x1403040,%al
  80083e:	3c ff                	cmp    $0xff,%al
  800840:	74 25                	je     800867 <_main+0x82f>
  800842:	83 ec 0c             	sub    $0xc,%esp
  800845:	ff 75 b0             	pushl  -0x50(%ebp)
  800848:	e8 e7 12 00 00       	call   801b34 <sys_env_destroy>
  80084d:	83 c4 10             	add    $0x10,%esp
  800850:	83 ec 04             	sub    $0x4,%esp
  800853:	68 60 27 80 00       	push   $0x802760
  800858:	68 dc 00 00 00       	push   $0xdc
  80085d:	68 88 24 80 00       	push   $0x802488
  800862:	e8 34 02 00 00       	call   800a9b <_panic>
		if( arr[PAGE_SIZE * 1024 * 4] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  800867:	a0 40 30 80 01       	mov    0x1803040,%al
  80086c:	3c ff                	cmp    $0xff,%al
  80086e:	74 25                	je     800895 <_main+0x85d>
  800870:	83 ec 0c             	sub    $0xc,%esp
  800873:	ff 75 b0             	pushl  -0x50(%ebp)
  800876:	e8 b9 12 00 00       	call   801b34 <sys_env_destroy>
  80087b:	83 c4 10             	add    $0x10,%esp
  80087e:	83 ec 04             	sub    $0x4,%esp
  800881:	68 60 27 80 00       	push   $0x802760
  800886:	68 dd 00 00 00       	push   $0xdd
  80088b:	68 88 24 80 00       	push   $0x802488
  800890:	e8 06 02 00 00       	call   800a9b <_panic>
		if( arr[PAGE_SIZE * 1024 * 5] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  800895:	a0 40 30 c0 01       	mov    0x1c03040,%al
  80089a:	3c ff                	cmp    $0xff,%al
  80089c:	74 25                	je     8008c3 <_main+0x88b>
  80089e:	83 ec 0c             	sub    $0xc,%esp
  8008a1:	ff 75 b0             	pushl  -0x50(%ebp)
  8008a4:	e8 8b 12 00 00       	call   801b34 <sys_env_destroy>
  8008a9:	83 c4 10             	add    $0x10,%esp
  8008ac:	83 ec 04             	sub    $0x4,%esp
  8008af:	68 60 27 80 00       	push   $0x802760
  8008b4:	68 de 00 00 00       	push   $0xde
  8008b9:	68 88 24 80 00       	push   $0x802488
  8008be:	e8 d8 01 00 00       	call   800a9b <_panic>
		if( arr[PAGE_SIZE * 1024 * 6] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  8008c3:	a0 40 30 00 02       	mov    0x2003040,%al
  8008c8:	3c ff                	cmp    $0xff,%al
  8008ca:	74 25                	je     8008f1 <_main+0x8b9>
  8008cc:	83 ec 0c             	sub    $0xc,%esp
  8008cf:	ff 75 b0             	pushl  -0x50(%ebp)
  8008d2:	e8 5d 12 00 00       	call   801b34 <sys_env_destroy>
  8008d7:	83 c4 10             	add    $0x10,%esp
  8008da:	83 ec 04             	sub    $0x4,%esp
  8008dd:	68 60 27 80 00       	push   $0x802760
  8008e2:	68 df 00 00 00       	push   $0xdf
  8008e7:	68 88 24 80 00       	push   $0x802488
  8008ec:	e8 aa 01 00 00       	call   800a9b <_panic>
		if( arr[PAGE_SIZE * 1024 * 7] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  8008f1:	a0 40 30 40 02       	mov    0x2403040,%al
  8008f6:	3c ff                	cmp    $0xff,%al
  8008f8:	74 25                	je     80091f <_main+0x8e7>
  8008fa:	83 ec 0c             	sub    $0xc,%esp
  8008fd:	ff 75 b0             	pushl  -0x50(%ebp)
  800900:	e8 2f 12 00 00       	call   801b34 <sys_env_destroy>
  800905:	83 c4 10             	add    $0x10,%esp
  800908:	83 ec 04             	sub    $0x4,%esp
  80090b:	68 60 27 80 00       	push   $0x802760
  800910:	68 e0 00 00 00       	push   $0xe0
  800915:	68 88 24 80 00       	push   $0x802488
  80091a:	e8 7c 01 00 00       	call   800a9b <_panic>

		if (sys_calculate_modified_frames() != 0) {sys_env_destroy(envIdSlave);panic("Modified frames not removed from list (or isModified/modified bit is not updated) correctly when the modified list reaches MAX");}
  80091f:	e8 28 13 00 00       	call   801c4c <sys_calculate_modified_frames>
  800924:	85 c0                	test   %eax,%eax
  800926:	74 25                	je     80094d <_main+0x915>
  800928:	83 ec 0c             	sub    $0xc,%esp
  80092b:	ff 75 b0             	pushl  -0x50(%ebp)
  80092e:	e8 01 12 00 00       	call   801b34 <sys_env_destroy>
  800933:	83 c4 10             	add    $0x10,%esp
  800936:	83 ec 04             	sub    $0x4,%esp
  800939:	68 a4 27 80 00       	push   $0x8027a4
  80093e:	68 e2 00 00 00       	push   $0xe2
  800943:	68 88 24 80 00       	push   $0x802488
  800948:	e8 4e 01 00 00       	call   800a9b <_panic>
	}

	return;
  80094d:	90                   	nop
}
  80094e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800951:	5b                   	pop    %ebx
  800952:	5e                   	pop    %esi
  800953:	5f                   	pop    %edi
  800954:	5d                   	pop    %ebp
  800955:	c3                   	ret    

00800956 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800956:	55                   	push   %ebp
  800957:	89 e5                	mov    %esp,%ebp
  800959:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80095c:	e8 07 12 00 00       	call   801b68 <sys_getenvindex>
  800961:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800964:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800967:	89 d0                	mov    %edx,%eax
  800969:	c1 e0 03             	shl    $0x3,%eax
  80096c:	01 d0                	add    %edx,%eax
  80096e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800975:	01 c8                	add    %ecx,%eax
  800977:	01 c0                	add    %eax,%eax
  800979:	01 d0                	add    %edx,%eax
  80097b:	01 c0                	add    %eax,%eax
  80097d:	01 d0                	add    %edx,%eax
  80097f:	89 c2                	mov    %eax,%edx
  800981:	c1 e2 05             	shl    $0x5,%edx
  800984:	29 c2                	sub    %eax,%edx
  800986:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80098d:	89 c2                	mov    %eax,%edx
  80098f:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800995:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80099a:	a1 20 30 80 00       	mov    0x803020,%eax
  80099f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8009a5:	84 c0                	test   %al,%al
  8009a7:	74 0f                	je     8009b8 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8009a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8009ae:	05 40 3c 01 00       	add    $0x13c40,%eax
  8009b3:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8009b8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8009bc:	7e 0a                	jle    8009c8 <libmain+0x72>
		binaryname = argv[0];
  8009be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c1:	8b 00                	mov    (%eax),%eax
  8009c3:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8009c8:	83 ec 08             	sub    $0x8,%esp
  8009cb:	ff 75 0c             	pushl  0xc(%ebp)
  8009ce:	ff 75 08             	pushl  0x8(%ebp)
  8009d1:	e8 62 f6 ff ff       	call   800038 <_main>
  8009d6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8009d9:	e8 25 13 00 00       	call   801d03 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8009de:	83 ec 0c             	sub    $0xc,%esp
  8009e1:	68 48 28 80 00       	push   $0x802848
  8009e6:	e8 52 03 00 00       	call   800d3d <cprintf>
  8009eb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8009ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8009f3:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8009f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8009fe:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800a04:	83 ec 04             	sub    $0x4,%esp
  800a07:	52                   	push   %edx
  800a08:	50                   	push   %eax
  800a09:	68 70 28 80 00       	push   $0x802870
  800a0e:	e8 2a 03 00 00       	call   800d3d <cprintf>
  800a13:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800a16:	a1 20 30 80 00       	mov    0x803020,%eax
  800a1b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800a21:	a1 20 30 80 00       	mov    0x803020,%eax
  800a26:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800a2c:	83 ec 04             	sub    $0x4,%esp
  800a2f:	52                   	push   %edx
  800a30:	50                   	push   %eax
  800a31:	68 98 28 80 00       	push   $0x802898
  800a36:	e8 02 03 00 00       	call   800d3d <cprintf>
  800a3b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800a3e:	a1 20 30 80 00       	mov    0x803020,%eax
  800a43:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800a49:	83 ec 08             	sub    $0x8,%esp
  800a4c:	50                   	push   %eax
  800a4d:	68 d9 28 80 00       	push   $0x8028d9
  800a52:	e8 e6 02 00 00       	call   800d3d <cprintf>
  800a57:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800a5a:	83 ec 0c             	sub    $0xc,%esp
  800a5d:	68 48 28 80 00       	push   $0x802848
  800a62:	e8 d6 02 00 00       	call   800d3d <cprintf>
  800a67:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800a6a:	e8 ae 12 00 00       	call   801d1d <sys_enable_interrupt>

	// exit gracefully
	exit();
  800a6f:	e8 19 00 00 00       	call   800a8d <exit>
}
  800a74:	90                   	nop
  800a75:	c9                   	leave  
  800a76:	c3                   	ret    

00800a77 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800a77:	55                   	push   %ebp
  800a78:	89 e5                	mov    %esp,%ebp
  800a7a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800a7d:	83 ec 0c             	sub    $0xc,%esp
  800a80:	6a 00                	push   $0x0
  800a82:	e8 ad 10 00 00       	call   801b34 <sys_env_destroy>
  800a87:	83 c4 10             	add    $0x10,%esp
}
  800a8a:	90                   	nop
  800a8b:	c9                   	leave  
  800a8c:	c3                   	ret    

00800a8d <exit>:

void
exit(void)
{
  800a8d:	55                   	push   %ebp
  800a8e:	89 e5                	mov    %esp,%ebp
  800a90:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800a93:	e8 02 11 00 00       	call   801b9a <sys_env_exit>
}
  800a98:	90                   	nop
  800a99:	c9                   	leave  
  800a9a:	c3                   	ret    

00800a9b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800a9b:	55                   	push   %ebp
  800a9c:	89 e5                	mov    %esp,%ebp
  800a9e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800aa1:	8d 45 10             	lea    0x10(%ebp),%eax
  800aa4:	83 c0 04             	add    $0x4,%eax
  800aa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800aaa:	a1 18 41 00 04       	mov    0x4004118,%eax
  800aaf:	85 c0                	test   %eax,%eax
  800ab1:	74 16                	je     800ac9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800ab3:	a1 18 41 00 04       	mov    0x4004118,%eax
  800ab8:	83 ec 08             	sub    $0x8,%esp
  800abb:	50                   	push   %eax
  800abc:	68 f0 28 80 00       	push   $0x8028f0
  800ac1:	e8 77 02 00 00       	call   800d3d <cprintf>
  800ac6:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800ac9:	a1 00 30 80 00       	mov    0x803000,%eax
  800ace:	ff 75 0c             	pushl  0xc(%ebp)
  800ad1:	ff 75 08             	pushl  0x8(%ebp)
  800ad4:	50                   	push   %eax
  800ad5:	68 f5 28 80 00       	push   $0x8028f5
  800ada:	e8 5e 02 00 00       	call   800d3d <cprintf>
  800adf:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800ae2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ae5:	83 ec 08             	sub    $0x8,%esp
  800ae8:	ff 75 f4             	pushl  -0xc(%ebp)
  800aeb:	50                   	push   %eax
  800aec:	e8 e1 01 00 00       	call   800cd2 <vcprintf>
  800af1:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800af4:	83 ec 08             	sub    $0x8,%esp
  800af7:	6a 00                	push   $0x0
  800af9:	68 11 29 80 00       	push   $0x802911
  800afe:	e8 cf 01 00 00       	call   800cd2 <vcprintf>
  800b03:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800b06:	e8 82 ff ff ff       	call   800a8d <exit>

	// should not return here
	while (1) ;
  800b0b:	eb fe                	jmp    800b0b <_panic+0x70>

00800b0d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800b0d:	55                   	push   %ebp
  800b0e:	89 e5                	mov    %esp,%ebp
  800b10:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800b13:	a1 20 30 80 00       	mov    0x803020,%eax
  800b18:	8b 50 74             	mov    0x74(%eax),%edx
  800b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1e:	39 c2                	cmp    %eax,%edx
  800b20:	74 14                	je     800b36 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800b22:	83 ec 04             	sub    $0x4,%esp
  800b25:	68 14 29 80 00       	push   $0x802914
  800b2a:	6a 26                	push   $0x26
  800b2c:	68 60 29 80 00       	push   $0x802960
  800b31:	e8 65 ff ff ff       	call   800a9b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800b36:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800b3d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800b44:	e9 b6 00 00 00       	jmp    800bff <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800b49:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b4c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
  800b56:	01 d0                	add    %edx,%eax
  800b58:	8b 00                	mov    (%eax),%eax
  800b5a:	85 c0                	test   %eax,%eax
  800b5c:	75 08                	jne    800b66 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800b5e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800b61:	e9 96 00 00 00       	jmp    800bfc <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800b66:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b6d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800b74:	eb 5d                	jmp    800bd3 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800b76:	a1 20 30 80 00       	mov    0x803020,%eax
  800b7b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b81:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b84:	c1 e2 04             	shl    $0x4,%edx
  800b87:	01 d0                	add    %edx,%eax
  800b89:	8a 40 04             	mov    0x4(%eax),%al
  800b8c:	84 c0                	test   %al,%al
  800b8e:	75 40                	jne    800bd0 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b90:	a1 20 30 80 00       	mov    0x803020,%eax
  800b95:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b9b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b9e:	c1 e2 04             	shl    $0x4,%edx
  800ba1:	01 d0                	add    %edx,%eax
  800ba3:	8b 00                	mov    (%eax),%eax
  800ba5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800ba8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800bab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bb0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800bb2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bb5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	01 c8                	add    %ecx,%eax
  800bc1:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800bc3:	39 c2                	cmp    %eax,%edx
  800bc5:	75 09                	jne    800bd0 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800bc7:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800bce:	eb 12                	jmp    800be2 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bd0:	ff 45 e8             	incl   -0x18(%ebp)
  800bd3:	a1 20 30 80 00       	mov    0x803020,%eax
  800bd8:	8b 50 74             	mov    0x74(%eax),%edx
  800bdb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800bde:	39 c2                	cmp    %eax,%edx
  800be0:	77 94                	ja     800b76 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800be2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800be6:	75 14                	jne    800bfc <CheckWSWithoutLastIndex+0xef>
			panic(
  800be8:	83 ec 04             	sub    $0x4,%esp
  800beb:	68 6c 29 80 00       	push   $0x80296c
  800bf0:	6a 3a                	push   $0x3a
  800bf2:	68 60 29 80 00       	push   $0x802960
  800bf7:	e8 9f fe ff ff       	call   800a9b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800bfc:	ff 45 f0             	incl   -0x10(%ebp)
  800bff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c02:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800c05:	0f 8c 3e ff ff ff    	jl     800b49 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800c0b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800c12:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800c19:	eb 20                	jmp    800c3b <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800c1b:	a1 20 30 80 00       	mov    0x803020,%eax
  800c20:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800c26:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c29:	c1 e2 04             	shl    $0x4,%edx
  800c2c:	01 d0                	add    %edx,%eax
  800c2e:	8a 40 04             	mov    0x4(%eax),%al
  800c31:	3c 01                	cmp    $0x1,%al
  800c33:	75 03                	jne    800c38 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800c35:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800c38:	ff 45 e0             	incl   -0x20(%ebp)
  800c3b:	a1 20 30 80 00       	mov    0x803020,%eax
  800c40:	8b 50 74             	mov    0x74(%eax),%edx
  800c43:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c46:	39 c2                	cmp    %eax,%edx
  800c48:	77 d1                	ja     800c1b <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800c4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c4d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800c50:	74 14                	je     800c66 <CheckWSWithoutLastIndex+0x159>
		panic(
  800c52:	83 ec 04             	sub    $0x4,%esp
  800c55:	68 c0 29 80 00       	push   $0x8029c0
  800c5a:	6a 44                	push   $0x44
  800c5c:	68 60 29 80 00       	push   $0x802960
  800c61:	e8 35 fe ff ff       	call   800a9b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800c66:	90                   	nop
  800c67:	c9                   	leave  
  800c68:	c3                   	ret    

00800c69 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800c69:	55                   	push   %ebp
  800c6a:	89 e5                	mov    %esp,%ebp
  800c6c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c72:	8b 00                	mov    (%eax),%eax
  800c74:	8d 48 01             	lea    0x1(%eax),%ecx
  800c77:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c7a:	89 0a                	mov    %ecx,(%edx)
  800c7c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c7f:	88 d1                	mov    %dl,%cl
  800c81:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c84:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800c88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8b:	8b 00                	mov    (%eax),%eax
  800c8d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800c92:	75 2c                	jne    800cc0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800c94:	a0 24 30 80 00       	mov    0x803024,%al
  800c99:	0f b6 c0             	movzbl %al,%eax
  800c9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c9f:	8b 12                	mov    (%edx),%edx
  800ca1:	89 d1                	mov    %edx,%ecx
  800ca3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ca6:	83 c2 08             	add    $0x8,%edx
  800ca9:	83 ec 04             	sub    $0x4,%esp
  800cac:	50                   	push   %eax
  800cad:	51                   	push   %ecx
  800cae:	52                   	push   %edx
  800caf:	e8 3e 0e 00 00       	call   801af2 <sys_cputs>
  800cb4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800cc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc3:	8b 40 04             	mov    0x4(%eax),%eax
  800cc6:	8d 50 01             	lea    0x1(%eax),%edx
  800cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ccc:	89 50 04             	mov    %edx,0x4(%eax)
}
  800ccf:	90                   	nop
  800cd0:	c9                   	leave  
  800cd1:	c3                   	ret    

00800cd2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800cd2:	55                   	push   %ebp
  800cd3:	89 e5                	mov    %esp,%ebp
  800cd5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800cdb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ce2:	00 00 00 
	b.cnt = 0;
  800ce5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800cec:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800cef:	ff 75 0c             	pushl  0xc(%ebp)
  800cf2:	ff 75 08             	pushl  0x8(%ebp)
  800cf5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800cfb:	50                   	push   %eax
  800cfc:	68 69 0c 80 00       	push   $0x800c69
  800d01:	e8 11 02 00 00       	call   800f17 <vprintfmt>
  800d06:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800d09:	a0 24 30 80 00       	mov    0x803024,%al
  800d0e:	0f b6 c0             	movzbl %al,%eax
  800d11:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800d17:	83 ec 04             	sub    $0x4,%esp
  800d1a:	50                   	push   %eax
  800d1b:	52                   	push   %edx
  800d1c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800d22:	83 c0 08             	add    $0x8,%eax
  800d25:	50                   	push   %eax
  800d26:	e8 c7 0d 00 00       	call   801af2 <sys_cputs>
  800d2b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800d2e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800d35:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800d3b:	c9                   	leave  
  800d3c:	c3                   	ret    

00800d3d <cprintf>:

int cprintf(const char *fmt, ...) {
  800d3d:	55                   	push   %ebp
  800d3e:	89 e5                	mov    %esp,%ebp
  800d40:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800d43:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800d4a:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	83 ec 08             	sub    $0x8,%esp
  800d56:	ff 75 f4             	pushl  -0xc(%ebp)
  800d59:	50                   	push   %eax
  800d5a:	e8 73 ff ff ff       	call   800cd2 <vcprintf>
  800d5f:	83 c4 10             	add    $0x10,%esp
  800d62:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800d65:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d68:	c9                   	leave  
  800d69:	c3                   	ret    

00800d6a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800d6a:	55                   	push   %ebp
  800d6b:	89 e5                	mov    %esp,%ebp
  800d6d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800d70:	e8 8e 0f 00 00       	call   801d03 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800d75:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d78:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7e:	83 ec 08             	sub    $0x8,%esp
  800d81:	ff 75 f4             	pushl  -0xc(%ebp)
  800d84:	50                   	push   %eax
  800d85:	e8 48 ff ff ff       	call   800cd2 <vcprintf>
  800d8a:	83 c4 10             	add    $0x10,%esp
  800d8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800d90:	e8 88 0f 00 00       	call   801d1d <sys_enable_interrupt>
	return cnt;
  800d95:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d98:	c9                   	leave  
  800d99:	c3                   	ret    

00800d9a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d9a:	55                   	push   %ebp
  800d9b:	89 e5                	mov    %esp,%ebp
  800d9d:	53                   	push   %ebx
  800d9e:	83 ec 14             	sub    $0x14,%esp
  800da1:	8b 45 10             	mov    0x10(%ebp),%eax
  800da4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800da7:	8b 45 14             	mov    0x14(%ebp),%eax
  800daa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800dad:	8b 45 18             	mov    0x18(%ebp),%eax
  800db0:	ba 00 00 00 00       	mov    $0x0,%edx
  800db5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800db8:	77 55                	ja     800e0f <printnum+0x75>
  800dba:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800dbd:	72 05                	jb     800dc4 <printnum+0x2a>
  800dbf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800dc2:	77 4b                	ja     800e0f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800dc4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800dc7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800dca:	8b 45 18             	mov    0x18(%ebp),%eax
  800dcd:	ba 00 00 00 00       	mov    $0x0,%edx
  800dd2:	52                   	push   %edx
  800dd3:	50                   	push   %eax
  800dd4:	ff 75 f4             	pushl  -0xc(%ebp)
  800dd7:	ff 75 f0             	pushl  -0x10(%ebp)
  800dda:	e8 f9 13 00 00       	call   8021d8 <__udivdi3>
  800ddf:	83 c4 10             	add    $0x10,%esp
  800de2:	83 ec 04             	sub    $0x4,%esp
  800de5:	ff 75 20             	pushl  0x20(%ebp)
  800de8:	53                   	push   %ebx
  800de9:	ff 75 18             	pushl  0x18(%ebp)
  800dec:	52                   	push   %edx
  800ded:	50                   	push   %eax
  800dee:	ff 75 0c             	pushl  0xc(%ebp)
  800df1:	ff 75 08             	pushl  0x8(%ebp)
  800df4:	e8 a1 ff ff ff       	call   800d9a <printnum>
  800df9:	83 c4 20             	add    $0x20,%esp
  800dfc:	eb 1a                	jmp    800e18 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800dfe:	83 ec 08             	sub    $0x8,%esp
  800e01:	ff 75 0c             	pushl  0xc(%ebp)
  800e04:	ff 75 20             	pushl  0x20(%ebp)
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	ff d0                	call   *%eax
  800e0c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800e0f:	ff 4d 1c             	decl   0x1c(%ebp)
  800e12:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800e16:	7f e6                	jg     800dfe <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800e18:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800e1b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800e20:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e23:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e26:	53                   	push   %ebx
  800e27:	51                   	push   %ecx
  800e28:	52                   	push   %edx
  800e29:	50                   	push   %eax
  800e2a:	e8 b9 14 00 00       	call   8022e8 <__umoddi3>
  800e2f:	83 c4 10             	add    $0x10,%esp
  800e32:	05 34 2c 80 00       	add    $0x802c34,%eax
  800e37:	8a 00                	mov    (%eax),%al
  800e39:	0f be c0             	movsbl %al,%eax
  800e3c:	83 ec 08             	sub    $0x8,%esp
  800e3f:	ff 75 0c             	pushl  0xc(%ebp)
  800e42:	50                   	push   %eax
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	ff d0                	call   *%eax
  800e48:	83 c4 10             	add    $0x10,%esp
}
  800e4b:	90                   	nop
  800e4c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800e4f:	c9                   	leave  
  800e50:	c3                   	ret    

00800e51 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800e51:	55                   	push   %ebp
  800e52:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e54:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e58:	7e 1c                	jle    800e76 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	8b 00                	mov    (%eax),%eax
  800e5f:	8d 50 08             	lea    0x8(%eax),%edx
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
  800e65:	89 10                	mov    %edx,(%eax)
  800e67:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6a:	8b 00                	mov    (%eax),%eax
  800e6c:	83 e8 08             	sub    $0x8,%eax
  800e6f:	8b 50 04             	mov    0x4(%eax),%edx
  800e72:	8b 00                	mov    (%eax),%eax
  800e74:	eb 40                	jmp    800eb6 <getuint+0x65>
	else if (lflag)
  800e76:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e7a:	74 1e                	je     800e9a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7f:	8b 00                	mov    (%eax),%eax
  800e81:	8d 50 04             	lea    0x4(%eax),%edx
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	89 10                	mov    %edx,(%eax)
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	8b 00                	mov    (%eax),%eax
  800e8e:	83 e8 04             	sub    $0x4,%eax
  800e91:	8b 00                	mov    (%eax),%eax
  800e93:	ba 00 00 00 00       	mov    $0x0,%edx
  800e98:	eb 1c                	jmp    800eb6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9d:	8b 00                	mov    (%eax),%eax
  800e9f:	8d 50 04             	lea    0x4(%eax),%edx
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	89 10                	mov    %edx,(%eax)
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaa:	8b 00                	mov    (%eax),%eax
  800eac:	83 e8 04             	sub    $0x4,%eax
  800eaf:	8b 00                	mov    (%eax),%eax
  800eb1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800eb6:	5d                   	pop    %ebp
  800eb7:	c3                   	ret    

00800eb8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800eb8:	55                   	push   %ebp
  800eb9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ebb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ebf:	7e 1c                	jle    800edd <getint+0x25>
		return va_arg(*ap, long long);
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	8b 00                	mov    (%eax),%eax
  800ec6:	8d 50 08             	lea    0x8(%eax),%edx
  800ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecc:	89 10                	mov    %edx,(%eax)
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	8b 00                	mov    (%eax),%eax
  800ed3:	83 e8 08             	sub    $0x8,%eax
  800ed6:	8b 50 04             	mov    0x4(%eax),%edx
  800ed9:	8b 00                	mov    (%eax),%eax
  800edb:	eb 38                	jmp    800f15 <getint+0x5d>
	else if (lflag)
  800edd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ee1:	74 1a                	je     800efd <getint+0x45>
		return va_arg(*ap, long);
  800ee3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee6:	8b 00                	mov    (%eax),%eax
  800ee8:	8d 50 04             	lea    0x4(%eax),%edx
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	89 10                	mov    %edx,(%eax)
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	8b 00                	mov    (%eax),%eax
  800ef5:	83 e8 04             	sub    $0x4,%eax
  800ef8:	8b 00                	mov    (%eax),%eax
  800efa:	99                   	cltd   
  800efb:	eb 18                	jmp    800f15 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	8b 00                	mov    (%eax),%eax
  800f02:	8d 50 04             	lea    0x4(%eax),%edx
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	89 10                	mov    %edx,(%eax)
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	8b 00                	mov    (%eax),%eax
  800f0f:	83 e8 04             	sub    $0x4,%eax
  800f12:	8b 00                	mov    (%eax),%eax
  800f14:	99                   	cltd   
}
  800f15:	5d                   	pop    %ebp
  800f16:	c3                   	ret    

00800f17 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800f17:	55                   	push   %ebp
  800f18:	89 e5                	mov    %esp,%ebp
  800f1a:	56                   	push   %esi
  800f1b:	53                   	push   %ebx
  800f1c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f1f:	eb 17                	jmp    800f38 <vprintfmt+0x21>
			if (ch == '\0')
  800f21:	85 db                	test   %ebx,%ebx
  800f23:	0f 84 af 03 00 00    	je     8012d8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800f29:	83 ec 08             	sub    $0x8,%esp
  800f2c:	ff 75 0c             	pushl  0xc(%ebp)
  800f2f:	53                   	push   %ebx
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	ff d0                	call   *%eax
  800f35:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f38:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3b:	8d 50 01             	lea    0x1(%eax),%edx
  800f3e:	89 55 10             	mov    %edx,0x10(%ebp)
  800f41:	8a 00                	mov    (%eax),%al
  800f43:	0f b6 d8             	movzbl %al,%ebx
  800f46:	83 fb 25             	cmp    $0x25,%ebx
  800f49:	75 d6                	jne    800f21 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800f4b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800f4f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800f56:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800f5d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800f64:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800f6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6e:	8d 50 01             	lea    0x1(%eax),%edx
  800f71:	89 55 10             	mov    %edx,0x10(%ebp)
  800f74:	8a 00                	mov    (%eax),%al
  800f76:	0f b6 d8             	movzbl %al,%ebx
  800f79:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800f7c:	83 f8 55             	cmp    $0x55,%eax
  800f7f:	0f 87 2b 03 00 00    	ja     8012b0 <vprintfmt+0x399>
  800f85:	8b 04 85 58 2c 80 00 	mov    0x802c58(,%eax,4),%eax
  800f8c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f8e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f92:	eb d7                	jmp    800f6b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f94:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f98:	eb d1                	jmp    800f6b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f9a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800fa1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800fa4:	89 d0                	mov    %edx,%eax
  800fa6:	c1 e0 02             	shl    $0x2,%eax
  800fa9:	01 d0                	add    %edx,%eax
  800fab:	01 c0                	add    %eax,%eax
  800fad:	01 d8                	add    %ebx,%eax
  800faf:	83 e8 30             	sub    $0x30,%eax
  800fb2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800fb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800fbd:	83 fb 2f             	cmp    $0x2f,%ebx
  800fc0:	7e 3e                	jle    801000 <vprintfmt+0xe9>
  800fc2:	83 fb 39             	cmp    $0x39,%ebx
  800fc5:	7f 39                	jg     801000 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800fc7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800fca:	eb d5                	jmp    800fa1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800fcc:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcf:	83 c0 04             	add    $0x4,%eax
  800fd2:	89 45 14             	mov    %eax,0x14(%ebp)
  800fd5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd8:	83 e8 04             	sub    $0x4,%eax
  800fdb:	8b 00                	mov    (%eax),%eax
  800fdd:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800fe0:	eb 1f                	jmp    801001 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800fe2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fe6:	79 83                	jns    800f6b <vprintfmt+0x54>
				width = 0;
  800fe8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800fef:	e9 77 ff ff ff       	jmp    800f6b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ff4:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ffb:	e9 6b ff ff ff       	jmp    800f6b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801000:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801001:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801005:	0f 89 60 ff ff ff    	jns    800f6b <vprintfmt+0x54>
				width = precision, precision = -1;
  80100b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80100e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801011:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801018:	e9 4e ff ff ff       	jmp    800f6b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80101d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801020:	e9 46 ff ff ff       	jmp    800f6b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801025:	8b 45 14             	mov    0x14(%ebp),%eax
  801028:	83 c0 04             	add    $0x4,%eax
  80102b:	89 45 14             	mov    %eax,0x14(%ebp)
  80102e:	8b 45 14             	mov    0x14(%ebp),%eax
  801031:	83 e8 04             	sub    $0x4,%eax
  801034:	8b 00                	mov    (%eax),%eax
  801036:	83 ec 08             	sub    $0x8,%esp
  801039:	ff 75 0c             	pushl  0xc(%ebp)
  80103c:	50                   	push   %eax
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
  801040:	ff d0                	call   *%eax
  801042:	83 c4 10             	add    $0x10,%esp
			break;
  801045:	e9 89 02 00 00       	jmp    8012d3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80104a:	8b 45 14             	mov    0x14(%ebp),%eax
  80104d:	83 c0 04             	add    $0x4,%eax
  801050:	89 45 14             	mov    %eax,0x14(%ebp)
  801053:	8b 45 14             	mov    0x14(%ebp),%eax
  801056:	83 e8 04             	sub    $0x4,%eax
  801059:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80105b:	85 db                	test   %ebx,%ebx
  80105d:	79 02                	jns    801061 <vprintfmt+0x14a>
				err = -err;
  80105f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801061:	83 fb 64             	cmp    $0x64,%ebx
  801064:	7f 0b                	jg     801071 <vprintfmt+0x15a>
  801066:	8b 34 9d a0 2a 80 00 	mov    0x802aa0(,%ebx,4),%esi
  80106d:	85 f6                	test   %esi,%esi
  80106f:	75 19                	jne    80108a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801071:	53                   	push   %ebx
  801072:	68 45 2c 80 00       	push   $0x802c45
  801077:	ff 75 0c             	pushl  0xc(%ebp)
  80107a:	ff 75 08             	pushl  0x8(%ebp)
  80107d:	e8 5e 02 00 00       	call   8012e0 <printfmt>
  801082:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801085:	e9 49 02 00 00       	jmp    8012d3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80108a:	56                   	push   %esi
  80108b:	68 4e 2c 80 00       	push   $0x802c4e
  801090:	ff 75 0c             	pushl  0xc(%ebp)
  801093:	ff 75 08             	pushl  0x8(%ebp)
  801096:	e8 45 02 00 00       	call   8012e0 <printfmt>
  80109b:	83 c4 10             	add    $0x10,%esp
			break;
  80109e:	e9 30 02 00 00       	jmp    8012d3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8010a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a6:	83 c0 04             	add    $0x4,%eax
  8010a9:	89 45 14             	mov    %eax,0x14(%ebp)
  8010ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8010af:	83 e8 04             	sub    $0x4,%eax
  8010b2:	8b 30                	mov    (%eax),%esi
  8010b4:	85 f6                	test   %esi,%esi
  8010b6:	75 05                	jne    8010bd <vprintfmt+0x1a6>
				p = "(null)";
  8010b8:	be 51 2c 80 00       	mov    $0x802c51,%esi
			if (width > 0 && padc != '-')
  8010bd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010c1:	7e 6d                	jle    801130 <vprintfmt+0x219>
  8010c3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8010c7:	74 67                	je     801130 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8010c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8010cc:	83 ec 08             	sub    $0x8,%esp
  8010cf:	50                   	push   %eax
  8010d0:	56                   	push   %esi
  8010d1:	e8 0c 03 00 00       	call   8013e2 <strnlen>
  8010d6:	83 c4 10             	add    $0x10,%esp
  8010d9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8010dc:	eb 16                	jmp    8010f4 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8010de:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8010e2:	83 ec 08             	sub    $0x8,%esp
  8010e5:	ff 75 0c             	pushl  0xc(%ebp)
  8010e8:	50                   	push   %eax
  8010e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ec:	ff d0                	call   *%eax
  8010ee:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8010f1:	ff 4d e4             	decl   -0x1c(%ebp)
  8010f4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010f8:	7f e4                	jg     8010de <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010fa:	eb 34                	jmp    801130 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8010fc:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801100:	74 1c                	je     80111e <vprintfmt+0x207>
  801102:	83 fb 1f             	cmp    $0x1f,%ebx
  801105:	7e 05                	jle    80110c <vprintfmt+0x1f5>
  801107:	83 fb 7e             	cmp    $0x7e,%ebx
  80110a:	7e 12                	jle    80111e <vprintfmt+0x207>
					putch('?', putdat);
  80110c:	83 ec 08             	sub    $0x8,%esp
  80110f:	ff 75 0c             	pushl  0xc(%ebp)
  801112:	6a 3f                	push   $0x3f
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	ff d0                	call   *%eax
  801119:	83 c4 10             	add    $0x10,%esp
  80111c:	eb 0f                	jmp    80112d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80111e:	83 ec 08             	sub    $0x8,%esp
  801121:	ff 75 0c             	pushl  0xc(%ebp)
  801124:	53                   	push   %ebx
  801125:	8b 45 08             	mov    0x8(%ebp),%eax
  801128:	ff d0                	call   *%eax
  80112a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80112d:	ff 4d e4             	decl   -0x1c(%ebp)
  801130:	89 f0                	mov    %esi,%eax
  801132:	8d 70 01             	lea    0x1(%eax),%esi
  801135:	8a 00                	mov    (%eax),%al
  801137:	0f be d8             	movsbl %al,%ebx
  80113a:	85 db                	test   %ebx,%ebx
  80113c:	74 24                	je     801162 <vprintfmt+0x24b>
  80113e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801142:	78 b8                	js     8010fc <vprintfmt+0x1e5>
  801144:	ff 4d e0             	decl   -0x20(%ebp)
  801147:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80114b:	79 af                	jns    8010fc <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80114d:	eb 13                	jmp    801162 <vprintfmt+0x24b>
				putch(' ', putdat);
  80114f:	83 ec 08             	sub    $0x8,%esp
  801152:	ff 75 0c             	pushl  0xc(%ebp)
  801155:	6a 20                	push   $0x20
  801157:	8b 45 08             	mov    0x8(%ebp),%eax
  80115a:	ff d0                	call   *%eax
  80115c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80115f:	ff 4d e4             	decl   -0x1c(%ebp)
  801162:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801166:	7f e7                	jg     80114f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801168:	e9 66 01 00 00       	jmp    8012d3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80116d:	83 ec 08             	sub    $0x8,%esp
  801170:	ff 75 e8             	pushl  -0x18(%ebp)
  801173:	8d 45 14             	lea    0x14(%ebp),%eax
  801176:	50                   	push   %eax
  801177:	e8 3c fd ff ff       	call   800eb8 <getint>
  80117c:	83 c4 10             	add    $0x10,%esp
  80117f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801182:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801185:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801188:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80118b:	85 d2                	test   %edx,%edx
  80118d:	79 23                	jns    8011b2 <vprintfmt+0x29b>
				putch('-', putdat);
  80118f:	83 ec 08             	sub    $0x8,%esp
  801192:	ff 75 0c             	pushl  0xc(%ebp)
  801195:	6a 2d                	push   $0x2d
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	ff d0                	call   *%eax
  80119c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80119f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011a5:	f7 d8                	neg    %eax
  8011a7:	83 d2 00             	adc    $0x0,%edx
  8011aa:	f7 da                	neg    %edx
  8011ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011af:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8011b2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8011b9:	e9 bc 00 00 00       	jmp    80127a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8011be:	83 ec 08             	sub    $0x8,%esp
  8011c1:	ff 75 e8             	pushl  -0x18(%ebp)
  8011c4:	8d 45 14             	lea    0x14(%ebp),%eax
  8011c7:	50                   	push   %eax
  8011c8:	e8 84 fc ff ff       	call   800e51 <getuint>
  8011cd:	83 c4 10             	add    $0x10,%esp
  8011d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011d3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8011d6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8011dd:	e9 98 00 00 00       	jmp    80127a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8011e2:	83 ec 08             	sub    $0x8,%esp
  8011e5:	ff 75 0c             	pushl  0xc(%ebp)
  8011e8:	6a 58                	push   $0x58
  8011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ed:	ff d0                	call   *%eax
  8011ef:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8011f2:	83 ec 08             	sub    $0x8,%esp
  8011f5:	ff 75 0c             	pushl  0xc(%ebp)
  8011f8:	6a 58                	push   $0x58
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	ff d0                	call   *%eax
  8011ff:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801202:	83 ec 08             	sub    $0x8,%esp
  801205:	ff 75 0c             	pushl  0xc(%ebp)
  801208:	6a 58                	push   $0x58
  80120a:	8b 45 08             	mov    0x8(%ebp),%eax
  80120d:	ff d0                	call   *%eax
  80120f:	83 c4 10             	add    $0x10,%esp
			break;
  801212:	e9 bc 00 00 00       	jmp    8012d3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801217:	83 ec 08             	sub    $0x8,%esp
  80121a:	ff 75 0c             	pushl  0xc(%ebp)
  80121d:	6a 30                	push   $0x30
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
  801222:	ff d0                	call   *%eax
  801224:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801227:	83 ec 08             	sub    $0x8,%esp
  80122a:	ff 75 0c             	pushl  0xc(%ebp)
  80122d:	6a 78                	push   $0x78
  80122f:	8b 45 08             	mov    0x8(%ebp),%eax
  801232:	ff d0                	call   *%eax
  801234:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801237:	8b 45 14             	mov    0x14(%ebp),%eax
  80123a:	83 c0 04             	add    $0x4,%eax
  80123d:	89 45 14             	mov    %eax,0x14(%ebp)
  801240:	8b 45 14             	mov    0x14(%ebp),%eax
  801243:	83 e8 04             	sub    $0x4,%eax
  801246:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801248:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80124b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801252:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801259:	eb 1f                	jmp    80127a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80125b:	83 ec 08             	sub    $0x8,%esp
  80125e:	ff 75 e8             	pushl  -0x18(%ebp)
  801261:	8d 45 14             	lea    0x14(%ebp),%eax
  801264:	50                   	push   %eax
  801265:	e8 e7 fb ff ff       	call   800e51 <getuint>
  80126a:	83 c4 10             	add    $0x10,%esp
  80126d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801270:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801273:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80127a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80127e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801281:	83 ec 04             	sub    $0x4,%esp
  801284:	52                   	push   %edx
  801285:	ff 75 e4             	pushl  -0x1c(%ebp)
  801288:	50                   	push   %eax
  801289:	ff 75 f4             	pushl  -0xc(%ebp)
  80128c:	ff 75 f0             	pushl  -0x10(%ebp)
  80128f:	ff 75 0c             	pushl  0xc(%ebp)
  801292:	ff 75 08             	pushl  0x8(%ebp)
  801295:	e8 00 fb ff ff       	call   800d9a <printnum>
  80129a:	83 c4 20             	add    $0x20,%esp
			break;
  80129d:	eb 34                	jmp    8012d3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80129f:	83 ec 08             	sub    $0x8,%esp
  8012a2:	ff 75 0c             	pushl  0xc(%ebp)
  8012a5:	53                   	push   %ebx
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	ff d0                	call   *%eax
  8012ab:	83 c4 10             	add    $0x10,%esp
			break;
  8012ae:	eb 23                	jmp    8012d3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8012b0:	83 ec 08             	sub    $0x8,%esp
  8012b3:	ff 75 0c             	pushl  0xc(%ebp)
  8012b6:	6a 25                	push   $0x25
  8012b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bb:	ff d0                	call   *%eax
  8012bd:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8012c0:	ff 4d 10             	decl   0x10(%ebp)
  8012c3:	eb 03                	jmp    8012c8 <vprintfmt+0x3b1>
  8012c5:	ff 4d 10             	decl   0x10(%ebp)
  8012c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cb:	48                   	dec    %eax
  8012cc:	8a 00                	mov    (%eax),%al
  8012ce:	3c 25                	cmp    $0x25,%al
  8012d0:	75 f3                	jne    8012c5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8012d2:	90                   	nop
		}
	}
  8012d3:	e9 47 fc ff ff       	jmp    800f1f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8012d8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8012d9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8012dc:	5b                   	pop    %ebx
  8012dd:	5e                   	pop    %esi
  8012de:	5d                   	pop    %ebp
  8012df:	c3                   	ret    

008012e0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
  8012e3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8012e6:	8d 45 10             	lea    0x10(%ebp),%eax
  8012e9:	83 c0 04             	add    $0x4,%eax
  8012ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8012ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8012f5:	50                   	push   %eax
  8012f6:	ff 75 0c             	pushl  0xc(%ebp)
  8012f9:	ff 75 08             	pushl  0x8(%ebp)
  8012fc:	e8 16 fc ff ff       	call   800f17 <vprintfmt>
  801301:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801304:	90                   	nop
  801305:	c9                   	leave  
  801306:	c3                   	ret    

00801307 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801307:	55                   	push   %ebp
  801308:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80130a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130d:	8b 40 08             	mov    0x8(%eax),%eax
  801310:	8d 50 01             	lea    0x1(%eax),%edx
  801313:	8b 45 0c             	mov    0xc(%ebp),%eax
  801316:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801319:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131c:	8b 10                	mov    (%eax),%edx
  80131e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801321:	8b 40 04             	mov    0x4(%eax),%eax
  801324:	39 c2                	cmp    %eax,%edx
  801326:	73 12                	jae    80133a <sprintputch+0x33>
		*b->buf++ = ch;
  801328:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132b:	8b 00                	mov    (%eax),%eax
  80132d:	8d 48 01             	lea    0x1(%eax),%ecx
  801330:	8b 55 0c             	mov    0xc(%ebp),%edx
  801333:	89 0a                	mov    %ecx,(%edx)
  801335:	8b 55 08             	mov    0x8(%ebp),%edx
  801338:	88 10                	mov    %dl,(%eax)
}
  80133a:	90                   	nop
  80133b:	5d                   	pop    %ebp
  80133c:	c3                   	ret    

0080133d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80133d:	55                   	push   %ebp
  80133e:	89 e5                	mov    %esp,%ebp
  801340:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801343:	8b 45 08             	mov    0x8(%ebp),%eax
  801346:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801349:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	01 d0                	add    %edx,%eax
  801354:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801357:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80135e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801362:	74 06                	je     80136a <vsnprintf+0x2d>
  801364:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801368:	7f 07                	jg     801371 <vsnprintf+0x34>
		return -E_INVAL;
  80136a:	b8 03 00 00 00       	mov    $0x3,%eax
  80136f:	eb 20                	jmp    801391 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801371:	ff 75 14             	pushl  0x14(%ebp)
  801374:	ff 75 10             	pushl  0x10(%ebp)
  801377:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80137a:	50                   	push   %eax
  80137b:	68 07 13 80 00       	push   $0x801307
  801380:	e8 92 fb ff ff       	call   800f17 <vprintfmt>
  801385:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801388:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80138b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80138e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801391:	c9                   	leave  
  801392:	c3                   	ret    

00801393 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801393:	55                   	push   %ebp
  801394:	89 e5                	mov    %esp,%ebp
  801396:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801399:	8d 45 10             	lea    0x10(%ebp),%eax
  80139c:	83 c0 04             	add    $0x4,%eax
  80139f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8013a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8013a8:	50                   	push   %eax
  8013a9:	ff 75 0c             	pushl  0xc(%ebp)
  8013ac:	ff 75 08             	pushl  0x8(%ebp)
  8013af:	e8 89 ff ff ff       	call   80133d <vsnprintf>
  8013b4:	83 c4 10             	add    $0x10,%esp
  8013b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8013ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8013bd:	c9                   	leave  
  8013be:	c3                   	ret    

008013bf <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8013bf:	55                   	push   %ebp
  8013c0:	89 e5                	mov    %esp,%ebp
  8013c2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8013c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013cc:	eb 06                	jmp    8013d4 <strlen+0x15>
		n++;
  8013ce:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8013d1:	ff 45 08             	incl   0x8(%ebp)
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	84 c0                	test   %al,%al
  8013db:	75 f1                	jne    8013ce <strlen+0xf>
		n++;
	return n;
  8013dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
  8013e5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8013e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013ef:	eb 09                	jmp    8013fa <strnlen+0x18>
		n++;
  8013f1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8013f4:	ff 45 08             	incl   0x8(%ebp)
  8013f7:	ff 4d 0c             	decl   0xc(%ebp)
  8013fa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013fe:	74 09                	je     801409 <strnlen+0x27>
  801400:	8b 45 08             	mov    0x8(%ebp),%eax
  801403:	8a 00                	mov    (%eax),%al
  801405:	84 c0                	test   %al,%al
  801407:	75 e8                	jne    8013f1 <strnlen+0xf>
		n++;
	return n;
  801409:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80140c:	c9                   	leave  
  80140d:	c3                   	ret    

0080140e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80140e:	55                   	push   %ebp
  80140f:	89 e5                	mov    %esp,%ebp
  801411:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80141a:	90                   	nop
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	8d 50 01             	lea    0x1(%eax),%edx
  801421:	89 55 08             	mov    %edx,0x8(%ebp)
  801424:	8b 55 0c             	mov    0xc(%ebp),%edx
  801427:	8d 4a 01             	lea    0x1(%edx),%ecx
  80142a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80142d:	8a 12                	mov    (%edx),%dl
  80142f:	88 10                	mov    %dl,(%eax)
  801431:	8a 00                	mov    (%eax),%al
  801433:	84 c0                	test   %al,%al
  801435:	75 e4                	jne    80141b <strcpy+0xd>
		/* do nothing */;
	return ret;
  801437:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80143a:	c9                   	leave  
  80143b:	c3                   	ret    

0080143c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80143c:	55                   	push   %ebp
  80143d:	89 e5                	mov    %esp,%ebp
  80143f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801448:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80144f:	eb 1f                	jmp    801470 <strncpy+0x34>
		*dst++ = *src;
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
  801454:	8d 50 01             	lea    0x1(%eax),%edx
  801457:	89 55 08             	mov    %edx,0x8(%ebp)
  80145a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145d:	8a 12                	mov    (%edx),%dl
  80145f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801461:	8b 45 0c             	mov    0xc(%ebp),%eax
  801464:	8a 00                	mov    (%eax),%al
  801466:	84 c0                	test   %al,%al
  801468:	74 03                	je     80146d <strncpy+0x31>
			src++;
  80146a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80146d:	ff 45 fc             	incl   -0x4(%ebp)
  801470:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801473:	3b 45 10             	cmp    0x10(%ebp),%eax
  801476:	72 d9                	jb     801451 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801478:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80147b:	c9                   	leave  
  80147c:	c3                   	ret    

0080147d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
  801480:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801489:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80148d:	74 30                	je     8014bf <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80148f:	eb 16                	jmp    8014a7 <strlcpy+0x2a>
			*dst++ = *src++;
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
  801494:	8d 50 01             	lea    0x1(%eax),%edx
  801497:	89 55 08             	mov    %edx,0x8(%ebp)
  80149a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149d:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014a0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014a3:	8a 12                	mov    (%edx),%dl
  8014a5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014a7:	ff 4d 10             	decl   0x10(%ebp)
  8014aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ae:	74 09                	je     8014b9 <strlcpy+0x3c>
  8014b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b3:	8a 00                	mov    (%eax),%al
  8014b5:	84 c0                	test   %al,%al
  8014b7:	75 d8                	jne    801491 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8014bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8014c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c5:	29 c2                	sub    %eax,%edx
  8014c7:	89 d0                	mov    %edx,%eax
}
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8014ce:	eb 06                	jmp    8014d6 <strcmp+0xb>
		p++, q++;
  8014d0:	ff 45 08             	incl   0x8(%ebp)
  8014d3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d9:	8a 00                	mov    (%eax),%al
  8014db:	84 c0                	test   %al,%al
  8014dd:	74 0e                	je     8014ed <strcmp+0x22>
  8014df:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e2:	8a 10                	mov    (%eax),%dl
  8014e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e7:	8a 00                	mov    (%eax),%al
  8014e9:	38 c2                	cmp    %al,%dl
  8014eb:	74 e3                	je     8014d0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f0:	8a 00                	mov    (%eax),%al
  8014f2:	0f b6 d0             	movzbl %al,%edx
  8014f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f8:	8a 00                	mov    (%eax),%al
  8014fa:	0f b6 c0             	movzbl %al,%eax
  8014fd:	29 c2                	sub    %eax,%edx
  8014ff:	89 d0                	mov    %edx,%eax
}
  801501:	5d                   	pop    %ebp
  801502:	c3                   	ret    

00801503 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801503:	55                   	push   %ebp
  801504:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801506:	eb 09                	jmp    801511 <strncmp+0xe>
		n--, p++, q++;
  801508:	ff 4d 10             	decl   0x10(%ebp)
  80150b:	ff 45 08             	incl   0x8(%ebp)
  80150e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801511:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801515:	74 17                	je     80152e <strncmp+0x2b>
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	8a 00                	mov    (%eax),%al
  80151c:	84 c0                	test   %al,%al
  80151e:	74 0e                	je     80152e <strncmp+0x2b>
  801520:	8b 45 08             	mov    0x8(%ebp),%eax
  801523:	8a 10                	mov    (%eax),%dl
  801525:	8b 45 0c             	mov    0xc(%ebp),%eax
  801528:	8a 00                	mov    (%eax),%al
  80152a:	38 c2                	cmp    %al,%dl
  80152c:	74 da                	je     801508 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80152e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801532:	75 07                	jne    80153b <strncmp+0x38>
		return 0;
  801534:	b8 00 00 00 00       	mov    $0x0,%eax
  801539:	eb 14                	jmp    80154f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
  80153e:	8a 00                	mov    (%eax),%al
  801540:	0f b6 d0             	movzbl %al,%edx
  801543:	8b 45 0c             	mov    0xc(%ebp),%eax
  801546:	8a 00                	mov    (%eax),%al
  801548:	0f b6 c0             	movzbl %al,%eax
  80154b:	29 c2                	sub    %eax,%edx
  80154d:	89 d0                	mov    %edx,%eax
}
  80154f:	5d                   	pop    %ebp
  801550:	c3                   	ret    

00801551 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801551:	55                   	push   %ebp
  801552:	89 e5                	mov    %esp,%ebp
  801554:	83 ec 04             	sub    $0x4,%esp
  801557:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80155d:	eb 12                	jmp    801571 <strchr+0x20>
		if (*s == c)
  80155f:	8b 45 08             	mov    0x8(%ebp),%eax
  801562:	8a 00                	mov    (%eax),%al
  801564:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801567:	75 05                	jne    80156e <strchr+0x1d>
			return (char *) s;
  801569:	8b 45 08             	mov    0x8(%ebp),%eax
  80156c:	eb 11                	jmp    80157f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80156e:	ff 45 08             	incl   0x8(%ebp)
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
  801574:	8a 00                	mov    (%eax),%al
  801576:	84 c0                	test   %al,%al
  801578:	75 e5                	jne    80155f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80157a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
  801584:	83 ec 04             	sub    $0x4,%esp
  801587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80158d:	eb 0d                	jmp    80159c <strfind+0x1b>
		if (*s == c)
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	8a 00                	mov    (%eax),%al
  801594:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801597:	74 0e                	je     8015a7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801599:	ff 45 08             	incl   0x8(%ebp)
  80159c:	8b 45 08             	mov    0x8(%ebp),%eax
  80159f:	8a 00                	mov    (%eax),%al
  8015a1:	84 c0                	test   %al,%al
  8015a3:	75 ea                	jne    80158f <strfind+0xe>
  8015a5:	eb 01                	jmp    8015a8 <strfind+0x27>
		if (*s == c)
			break;
  8015a7:	90                   	nop
	return (char *) s;
  8015a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ab:	c9                   	leave  
  8015ac:	c3                   	ret    

008015ad <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8015ad:	55                   	push   %ebp
  8015ae:	89 e5                	mov    %esp,%ebp
  8015b0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8015b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8015b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8015bf:	eb 0e                	jmp    8015cf <memset+0x22>
		*p++ = c;
  8015c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015c4:	8d 50 01             	lea    0x1(%eax),%edx
  8015c7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015cd:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8015cf:	ff 4d f8             	decl   -0x8(%ebp)
  8015d2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8015d6:	79 e9                	jns    8015c1 <memset+0x14>
		*p++ = c;

	return v;
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
  8015e0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8015e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8015ef:	eb 16                	jmp    801607 <memcpy+0x2a>
		*d++ = *s++;
  8015f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f4:	8d 50 01             	lea    0x1(%eax),%edx
  8015f7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015fd:	8d 4a 01             	lea    0x1(%edx),%ecx
  801600:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801603:	8a 12                	mov    (%edx),%dl
  801605:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801607:	8b 45 10             	mov    0x10(%ebp),%eax
  80160a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80160d:	89 55 10             	mov    %edx,0x10(%ebp)
  801610:	85 c0                	test   %eax,%eax
  801612:	75 dd                	jne    8015f1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
  80161c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80161f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801622:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801625:	8b 45 08             	mov    0x8(%ebp),%eax
  801628:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80162b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80162e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801631:	73 50                	jae    801683 <memmove+0x6a>
  801633:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801636:	8b 45 10             	mov    0x10(%ebp),%eax
  801639:	01 d0                	add    %edx,%eax
  80163b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80163e:	76 43                	jbe    801683 <memmove+0x6a>
		s += n;
  801640:	8b 45 10             	mov    0x10(%ebp),%eax
  801643:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801646:	8b 45 10             	mov    0x10(%ebp),%eax
  801649:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80164c:	eb 10                	jmp    80165e <memmove+0x45>
			*--d = *--s;
  80164e:	ff 4d f8             	decl   -0x8(%ebp)
  801651:	ff 4d fc             	decl   -0x4(%ebp)
  801654:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801657:	8a 10                	mov    (%eax),%dl
  801659:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80165c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80165e:	8b 45 10             	mov    0x10(%ebp),%eax
  801661:	8d 50 ff             	lea    -0x1(%eax),%edx
  801664:	89 55 10             	mov    %edx,0x10(%ebp)
  801667:	85 c0                	test   %eax,%eax
  801669:	75 e3                	jne    80164e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80166b:	eb 23                	jmp    801690 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80166d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801670:	8d 50 01             	lea    0x1(%eax),%edx
  801673:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801676:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801679:	8d 4a 01             	lea    0x1(%edx),%ecx
  80167c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80167f:	8a 12                	mov    (%edx),%dl
  801681:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801683:	8b 45 10             	mov    0x10(%ebp),%eax
  801686:	8d 50 ff             	lea    -0x1(%eax),%edx
  801689:	89 55 10             	mov    %edx,0x10(%ebp)
  80168c:	85 c0                	test   %eax,%eax
  80168e:	75 dd                	jne    80166d <memmove+0x54>
			*d++ = *s++;

	return dst;
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801693:	c9                   	leave  
  801694:	c3                   	ret    

00801695 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801695:	55                   	push   %ebp
  801696:	89 e5                	mov    %esp,%ebp
  801698:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80169b:	8b 45 08             	mov    0x8(%ebp),%eax
  80169e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016a7:	eb 2a                	jmp    8016d3 <memcmp+0x3e>
		if (*s1 != *s2)
  8016a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016ac:	8a 10                	mov    (%eax),%dl
  8016ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b1:	8a 00                	mov    (%eax),%al
  8016b3:	38 c2                	cmp    %al,%dl
  8016b5:	74 16                	je     8016cd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8016b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016ba:	8a 00                	mov    (%eax),%al
  8016bc:	0f b6 d0             	movzbl %al,%edx
  8016bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c2:	8a 00                	mov    (%eax),%al
  8016c4:	0f b6 c0             	movzbl %al,%eax
  8016c7:	29 c2                	sub    %eax,%edx
  8016c9:	89 d0                	mov    %edx,%eax
  8016cb:	eb 18                	jmp    8016e5 <memcmp+0x50>
		s1++, s2++;
  8016cd:	ff 45 fc             	incl   -0x4(%ebp)
  8016d0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8016d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016d9:	89 55 10             	mov    %edx,0x10(%ebp)
  8016dc:	85 c0                	test   %eax,%eax
  8016de:	75 c9                	jne    8016a9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8016e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016e5:	c9                   	leave  
  8016e6:	c3                   	ret    

008016e7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
  8016ea:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8016ed:	8b 55 08             	mov    0x8(%ebp),%edx
  8016f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f3:	01 d0                	add    %edx,%eax
  8016f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8016f8:	eb 15                	jmp    80170f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	8a 00                	mov    (%eax),%al
  8016ff:	0f b6 d0             	movzbl %al,%edx
  801702:	8b 45 0c             	mov    0xc(%ebp),%eax
  801705:	0f b6 c0             	movzbl %al,%eax
  801708:	39 c2                	cmp    %eax,%edx
  80170a:	74 0d                	je     801719 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80170c:	ff 45 08             	incl   0x8(%ebp)
  80170f:	8b 45 08             	mov    0x8(%ebp),%eax
  801712:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801715:	72 e3                	jb     8016fa <memfind+0x13>
  801717:	eb 01                	jmp    80171a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801719:	90                   	nop
	return (void *) s;
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
  801722:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801725:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80172c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801733:	eb 03                	jmp    801738 <strtol+0x19>
		s++;
  801735:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801738:	8b 45 08             	mov    0x8(%ebp),%eax
  80173b:	8a 00                	mov    (%eax),%al
  80173d:	3c 20                	cmp    $0x20,%al
  80173f:	74 f4                	je     801735 <strtol+0x16>
  801741:	8b 45 08             	mov    0x8(%ebp),%eax
  801744:	8a 00                	mov    (%eax),%al
  801746:	3c 09                	cmp    $0x9,%al
  801748:	74 eb                	je     801735 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80174a:	8b 45 08             	mov    0x8(%ebp),%eax
  80174d:	8a 00                	mov    (%eax),%al
  80174f:	3c 2b                	cmp    $0x2b,%al
  801751:	75 05                	jne    801758 <strtol+0x39>
		s++;
  801753:	ff 45 08             	incl   0x8(%ebp)
  801756:	eb 13                	jmp    80176b <strtol+0x4c>
	else if (*s == '-')
  801758:	8b 45 08             	mov    0x8(%ebp),%eax
  80175b:	8a 00                	mov    (%eax),%al
  80175d:	3c 2d                	cmp    $0x2d,%al
  80175f:	75 0a                	jne    80176b <strtol+0x4c>
		s++, neg = 1;
  801761:	ff 45 08             	incl   0x8(%ebp)
  801764:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80176b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80176f:	74 06                	je     801777 <strtol+0x58>
  801771:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801775:	75 20                	jne    801797 <strtol+0x78>
  801777:	8b 45 08             	mov    0x8(%ebp),%eax
  80177a:	8a 00                	mov    (%eax),%al
  80177c:	3c 30                	cmp    $0x30,%al
  80177e:	75 17                	jne    801797 <strtol+0x78>
  801780:	8b 45 08             	mov    0x8(%ebp),%eax
  801783:	40                   	inc    %eax
  801784:	8a 00                	mov    (%eax),%al
  801786:	3c 78                	cmp    $0x78,%al
  801788:	75 0d                	jne    801797 <strtol+0x78>
		s += 2, base = 16;
  80178a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80178e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801795:	eb 28                	jmp    8017bf <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801797:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80179b:	75 15                	jne    8017b2 <strtol+0x93>
  80179d:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a0:	8a 00                	mov    (%eax),%al
  8017a2:	3c 30                	cmp    $0x30,%al
  8017a4:	75 0c                	jne    8017b2 <strtol+0x93>
		s++, base = 8;
  8017a6:	ff 45 08             	incl   0x8(%ebp)
  8017a9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017b0:	eb 0d                	jmp    8017bf <strtol+0xa0>
	else if (base == 0)
  8017b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017b6:	75 07                	jne    8017bf <strtol+0xa0>
		base = 10;
  8017b8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8017bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c2:	8a 00                	mov    (%eax),%al
  8017c4:	3c 2f                	cmp    $0x2f,%al
  8017c6:	7e 19                	jle    8017e1 <strtol+0xc2>
  8017c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cb:	8a 00                	mov    (%eax),%al
  8017cd:	3c 39                	cmp    $0x39,%al
  8017cf:	7f 10                	jg     8017e1 <strtol+0xc2>
			dig = *s - '0';
  8017d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d4:	8a 00                	mov    (%eax),%al
  8017d6:	0f be c0             	movsbl %al,%eax
  8017d9:	83 e8 30             	sub    $0x30,%eax
  8017dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8017df:	eb 42                	jmp    801823 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8017e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e4:	8a 00                	mov    (%eax),%al
  8017e6:	3c 60                	cmp    $0x60,%al
  8017e8:	7e 19                	jle    801803 <strtol+0xe4>
  8017ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ed:	8a 00                	mov    (%eax),%al
  8017ef:	3c 7a                	cmp    $0x7a,%al
  8017f1:	7f 10                	jg     801803 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8017f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f6:	8a 00                	mov    (%eax),%al
  8017f8:	0f be c0             	movsbl %al,%eax
  8017fb:	83 e8 57             	sub    $0x57,%eax
  8017fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801801:	eb 20                	jmp    801823 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801803:	8b 45 08             	mov    0x8(%ebp),%eax
  801806:	8a 00                	mov    (%eax),%al
  801808:	3c 40                	cmp    $0x40,%al
  80180a:	7e 39                	jle    801845 <strtol+0x126>
  80180c:	8b 45 08             	mov    0x8(%ebp),%eax
  80180f:	8a 00                	mov    (%eax),%al
  801811:	3c 5a                	cmp    $0x5a,%al
  801813:	7f 30                	jg     801845 <strtol+0x126>
			dig = *s - 'A' + 10;
  801815:	8b 45 08             	mov    0x8(%ebp),%eax
  801818:	8a 00                	mov    (%eax),%al
  80181a:	0f be c0             	movsbl %al,%eax
  80181d:	83 e8 37             	sub    $0x37,%eax
  801820:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801823:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801826:	3b 45 10             	cmp    0x10(%ebp),%eax
  801829:	7d 19                	jge    801844 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80182b:	ff 45 08             	incl   0x8(%ebp)
  80182e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801831:	0f af 45 10          	imul   0x10(%ebp),%eax
  801835:	89 c2                	mov    %eax,%edx
  801837:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80183a:	01 d0                	add    %edx,%eax
  80183c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80183f:	e9 7b ff ff ff       	jmp    8017bf <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801844:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801845:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801849:	74 08                	je     801853 <strtol+0x134>
		*endptr = (char *) s;
  80184b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184e:	8b 55 08             	mov    0x8(%ebp),%edx
  801851:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801853:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801857:	74 07                	je     801860 <strtol+0x141>
  801859:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80185c:	f7 d8                	neg    %eax
  80185e:	eb 03                	jmp    801863 <strtol+0x144>
  801860:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801863:	c9                   	leave  
  801864:	c3                   	ret    

00801865 <ltostr>:

void
ltostr(long value, char *str)
{
  801865:	55                   	push   %ebp
  801866:	89 e5                	mov    %esp,%ebp
  801868:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80186b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801872:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801879:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80187d:	79 13                	jns    801892 <ltostr+0x2d>
	{
		neg = 1;
  80187f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801886:	8b 45 0c             	mov    0xc(%ebp),%eax
  801889:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80188c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80188f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801892:	8b 45 08             	mov    0x8(%ebp),%eax
  801895:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80189a:	99                   	cltd   
  80189b:	f7 f9                	idiv   %ecx
  80189d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018a3:	8d 50 01             	lea    0x1(%eax),%edx
  8018a6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018a9:	89 c2                	mov    %eax,%edx
  8018ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ae:	01 d0                	add    %edx,%eax
  8018b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018b3:	83 c2 30             	add    $0x30,%edx
  8018b6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8018b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018bb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8018c0:	f7 e9                	imul   %ecx
  8018c2:	c1 fa 02             	sar    $0x2,%edx
  8018c5:	89 c8                	mov    %ecx,%eax
  8018c7:	c1 f8 1f             	sar    $0x1f,%eax
  8018ca:	29 c2                	sub    %eax,%edx
  8018cc:	89 d0                	mov    %edx,%eax
  8018ce:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8018d1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018d4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8018d9:	f7 e9                	imul   %ecx
  8018db:	c1 fa 02             	sar    $0x2,%edx
  8018de:	89 c8                	mov    %ecx,%eax
  8018e0:	c1 f8 1f             	sar    $0x1f,%eax
  8018e3:	29 c2                	sub    %eax,%edx
  8018e5:	89 d0                	mov    %edx,%eax
  8018e7:	c1 e0 02             	shl    $0x2,%eax
  8018ea:	01 d0                	add    %edx,%eax
  8018ec:	01 c0                	add    %eax,%eax
  8018ee:	29 c1                	sub    %eax,%ecx
  8018f0:	89 ca                	mov    %ecx,%edx
  8018f2:	85 d2                	test   %edx,%edx
  8018f4:	75 9c                	jne    801892 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8018f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8018fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801900:	48                   	dec    %eax
  801901:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801904:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801908:	74 3d                	je     801947 <ltostr+0xe2>
		start = 1 ;
  80190a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801911:	eb 34                	jmp    801947 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801913:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801916:	8b 45 0c             	mov    0xc(%ebp),%eax
  801919:	01 d0                	add    %edx,%eax
  80191b:	8a 00                	mov    (%eax),%al
  80191d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801920:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801923:	8b 45 0c             	mov    0xc(%ebp),%eax
  801926:	01 c2                	add    %eax,%edx
  801928:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80192b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80192e:	01 c8                	add    %ecx,%eax
  801930:	8a 00                	mov    (%eax),%al
  801932:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801934:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801937:	8b 45 0c             	mov    0xc(%ebp),%eax
  80193a:	01 c2                	add    %eax,%edx
  80193c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80193f:	88 02                	mov    %al,(%edx)
		start++ ;
  801941:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801944:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801947:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80194a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80194d:	7c c4                	jl     801913 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80194f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801952:	8b 45 0c             	mov    0xc(%ebp),%eax
  801955:	01 d0                	add    %edx,%eax
  801957:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80195a:	90                   	nop
  80195b:	c9                   	leave  
  80195c:	c3                   	ret    

0080195d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80195d:	55                   	push   %ebp
  80195e:	89 e5                	mov    %esp,%ebp
  801960:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801963:	ff 75 08             	pushl  0x8(%ebp)
  801966:	e8 54 fa ff ff       	call   8013bf <strlen>
  80196b:	83 c4 04             	add    $0x4,%esp
  80196e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801971:	ff 75 0c             	pushl  0xc(%ebp)
  801974:	e8 46 fa ff ff       	call   8013bf <strlen>
  801979:	83 c4 04             	add    $0x4,%esp
  80197c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80197f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801986:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80198d:	eb 17                	jmp    8019a6 <strcconcat+0x49>
		final[s] = str1[s] ;
  80198f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801992:	8b 45 10             	mov    0x10(%ebp),%eax
  801995:	01 c2                	add    %eax,%edx
  801997:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80199a:	8b 45 08             	mov    0x8(%ebp),%eax
  80199d:	01 c8                	add    %ecx,%eax
  80199f:	8a 00                	mov    (%eax),%al
  8019a1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019a3:	ff 45 fc             	incl   -0x4(%ebp)
  8019a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019a9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019ac:	7c e1                	jl     80198f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019ae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8019b5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8019bc:	eb 1f                	jmp    8019dd <strcconcat+0x80>
		final[s++] = str2[i] ;
  8019be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019c1:	8d 50 01             	lea    0x1(%eax),%edx
  8019c4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8019c7:	89 c2                	mov    %eax,%edx
  8019c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8019cc:	01 c2                	add    %eax,%edx
  8019ce:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8019d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019d4:	01 c8                	add    %ecx,%eax
  8019d6:	8a 00                	mov    (%eax),%al
  8019d8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8019da:	ff 45 f8             	incl   -0x8(%ebp)
  8019dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019e0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019e3:	7c d9                	jl     8019be <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8019e5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8019eb:	01 d0                	add    %edx,%eax
  8019ed:	c6 00 00             	movb   $0x0,(%eax)
}
  8019f0:	90                   	nop
  8019f1:	c9                   	leave  
  8019f2:	c3                   	ret    

008019f3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8019f3:	55                   	push   %ebp
  8019f4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8019f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8019f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8019ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801a02:	8b 00                	mov    (%eax),%eax
  801a04:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a0b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a0e:	01 d0                	add    %edx,%eax
  801a10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a16:	eb 0c                	jmp    801a24 <strsplit+0x31>
			*string++ = 0;
  801a18:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1b:	8d 50 01             	lea    0x1(%eax),%edx
  801a1e:	89 55 08             	mov    %edx,0x8(%ebp)
  801a21:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a24:	8b 45 08             	mov    0x8(%ebp),%eax
  801a27:	8a 00                	mov    (%eax),%al
  801a29:	84 c0                	test   %al,%al
  801a2b:	74 18                	je     801a45 <strsplit+0x52>
  801a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a30:	8a 00                	mov    (%eax),%al
  801a32:	0f be c0             	movsbl %al,%eax
  801a35:	50                   	push   %eax
  801a36:	ff 75 0c             	pushl  0xc(%ebp)
  801a39:	e8 13 fb ff ff       	call   801551 <strchr>
  801a3e:	83 c4 08             	add    $0x8,%esp
  801a41:	85 c0                	test   %eax,%eax
  801a43:	75 d3                	jne    801a18 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a45:	8b 45 08             	mov    0x8(%ebp),%eax
  801a48:	8a 00                	mov    (%eax),%al
  801a4a:	84 c0                	test   %al,%al
  801a4c:	74 5a                	je     801aa8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a4e:	8b 45 14             	mov    0x14(%ebp),%eax
  801a51:	8b 00                	mov    (%eax),%eax
  801a53:	83 f8 0f             	cmp    $0xf,%eax
  801a56:	75 07                	jne    801a5f <strsplit+0x6c>
		{
			return 0;
  801a58:	b8 00 00 00 00       	mov    $0x0,%eax
  801a5d:	eb 66                	jmp    801ac5 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801a5f:	8b 45 14             	mov    0x14(%ebp),%eax
  801a62:	8b 00                	mov    (%eax),%eax
  801a64:	8d 48 01             	lea    0x1(%eax),%ecx
  801a67:	8b 55 14             	mov    0x14(%ebp),%edx
  801a6a:	89 0a                	mov    %ecx,(%edx)
  801a6c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a73:	8b 45 10             	mov    0x10(%ebp),%eax
  801a76:	01 c2                	add    %eax,%edx
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a7d:	eb 03                	jmp    801a82 <strsplit+0x8f>
			string++;
  801a7f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a82:	8b 45 08             	mov    0x8(%ebp),%eax
  801a85:	8a 00                	mov    (%eax),%al
  801a87:	84 c0                	test   %al,%al
  801a89:	74 8b                	je     801a16 <strsplit+0x23>
  801a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8e:	8a 00                	mov    (%eax),%al
  801a90:	0f be c0             	movsbl %al,%eax
  801a93:	50                   	push   %eax
  801a94:	ff 75 0c             	pushl  0xc(%ebp)
  801a97:	e8 b5 fa ff ff       	call   801551 <strchr>
  801a9c:	83 c4 08             	add    $0x8,%esp
  801a9f:	85 c0                	test   %eax,%eax
  801aa1:	74 dc                	je     801a7f <strsplit+0x8c>
			string++;
	}
  801aa3:	e9 6e ff ff ff       	jmp    801a16 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801aa8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801aa9:	8b 45 14             	mov    0x14(%ebp),%eax
  801aac:	8b 00                	mov    (%eax),%eax
  801aae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ab5:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab8:	01 d0                	add    %edx,%eax
  801aba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801ac0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801ac5:	c9                   	leave  
  801ac6:	c3                   	ret    

00801ac7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ac7:	55                   	push   %ebp
  801ac8:	89 e5                	mov    %esp,%ebp
  801aca:	57                   	push   %edi
  801acb:	56                   	push   %esi
  801acc:	53                   	push   %ebx
  801acd:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ad9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801adc:	8b 7d 18             	mov    0x18(%ebp),%edi
  801adf:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801ae2:	cd 30                	int    $0x30
  801ae4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ae7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801aea:	83 c4 10             	add    $0x10,%esp
  801aed:	5b                   	pop    %ebx
  801aee:	5e                   	pop    %esi
  801aef:	5f                   	pop    %edi
  801af0:	5d                   	pop    %ebp
  801af1:	c3                   	ret    

00801af2 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801af2:	55                   	push   %ebp
  801af3:	89 e5                	mov    %esp,%ebp
  801af5:	83 ec 04             	sub    $0x4,%esp
  801af8:	8b 45 10             	mov    0x10(%ebp),%eax
  801afb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801afe:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b02:	8b 45 08             	mov    0x8(%ebp),%eax
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	52                   	push   %edx
  801b0a:	ff 75 0c             	pushl  0xc(%ebp)
  801b0d:	50                   	push   %eax
  801b0e:	6a 00                	push   $0x0
  801b10:	e8 b2 ff ff ff       	call   801ac7 <syscall>
  801b15:	83 c4 18             	add    $0x18,%esp
}
  801b18:	90                   	nop
  801b19:	c9                   	leave  
  801b1a:	c3                   	ret    

00801b1b <sys_cgetc>:

int
sys_cgetc(void)
{
  801b1b:	55                   	push   %ebp
  801b1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 01                	push   $0x1
  801b2a:	e8 98 ff ff ff       	call   801ac7 <syscall>
  801b2f:	83 c4 18             	add    $0x18,%esp
}
  801b32:	c9                   	leave  
  801b33:	c3                   	ret    

00801b34 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b34:	55                   	push   %ebp
  801b35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b37:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	50                   	push   %eax
  801b43:	6a 05                	push   $0x5
  801b45:	e8 7d ff ff ff       	call   801ac7 <syscall>
  801b4a:	83 c4 18             	add    $0x18,%esp
}
  801b4d:	c9                   	leave  
  801b4e:	c3                   	ret    

00801b4f <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b4f:	55                   	push   %ebp
  801b50:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b52:	6a 00                	push   $0x0
  801b54:	6a 00                	push   $0x0
  801b56:	6a 00                	push   $0x0
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 02                	push   $0x2
  801b5e:	e8 64 ff ff ff       	call   801ac7 <syscall>
  801b63:	83 c4 18             	add    $0x18,%esp
}
  801b66:	c9                   	leave  
  801b67:	c3                   	ret    

00801b68 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b68:	55                   	push   %ebp
  801b69:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 03                	push   $0x3
  801b77:	e8 4b ff ff ff       	call   801ac7 <syscall>
  801b7c:	83 c4 18             	add    $0x18,%esp
}
  801b7f:	c9                   	leave  
  801b80:	c3                   	ret    

00801b81 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b81:	55                   	push   %ebp
  801b82:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 04                	push   $0x4
  801b90:	e8 32 ff ff ff       	call   801ac7 <syscall>
  801b95:	83 c4 18             	add    $0x18,%esp
}
  801b98:	c9                   	leave  
  801b99:	c3                   	ret    

00801b9a <sys_env_exit>:


void sys_env_exit(void)
{
  801b9a:	55                   	push   %ebp
  801b9b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 06                	push   $0x6
  801ba9:	e8 19 ff ff ff       	call   801ac7 <syscall>
  801bae:	83 c4 18             	add    $0x18,%esp
}
  801bb1:	90                   	nop
  801bb2:	c9                   	leave  
  801bb3:	c3                   	ret    

00801bb4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801bb4:	55                   	push   %ebp
  801bb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bb7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bba:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	52                   	push   %edx
  801bc4:	50                   	push   %eax
  801bc5:	6a 07                	push   $0x7
  801bc7:	e8 fb fe ff ff       	call   801ac7 <syscall>
  801bcc:	83 c4 18             	add    $0x18,%esp
}
  801bcf:	c9                   	leave  
  801bd0:	c3                   	ret    

00801bd1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801bd1:	55                   	push   %ebp
  801bd2:	89 e5                	mov    %esp,%ebp
  801bd4:	56                   	push   %esi
  801bd5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801bd6:	8b 75 18             	mov    0x18(%ebp),%esi
  801bd9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bdc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bdf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be2:	8b 45 08             	mov    0x8(%ebp),%eax
  801be5:	56                   	push   %esi
  801be6:	53                   	push   %ebx
  801be7:	51                   	push   %ecx
  801be8:	52                   	push   %edx
  801be9:	50                   	push   %eax
  801bea:	6a 08                	push   $0x8
  801bec:	e8 d6 fe ff ff       	call   801ac7 <syscall>
  801bf1:	83 c4 18             	add    $0x18,%esp
}
  801bf4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bf7:	5b                   	pop    %ebx
  801bf8:	5e                   	pop    %esi
  801bf9:	5d                   	pop    %ebp
  801bfa:	c3                   	ret    

00801bfb <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801bfb:	55                   	push   %ebp
  801bfc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801bfe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c01:	8b 45 08             	mov    0x8(%ebp),%eax
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	52                   	push   %edx
  801c0b:	50                   	push   %eax
  801c0c:	6a 09                	push   $0x9
  801c0e:	e8 b4 fe ff ff       	call   801ac7 <syscall>
  801c13:	83 c4 18             	add    $0x18,%esp
}
  801c16:	c9                   	leave  
  801c17:	c3                   	ret    

00801c18 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c18:	55                   	push   %ebp
  801c19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	ff 75 0c             	pushl  0xc(%ebp)
  801c24:	ff 75 08             	pushl  0x8(%ebp)
  801c27:	6a 0a                	push   $0xa
  801c29:	e8 99 fe ff ff       	call   801ac7 <syscall>
  801c2e:	83 c4 18             	add    $0x18,%esp
}
  801c31:	c9                   	leave  
  801c32:	c3                   	ret    

00801c33 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c33:	55                   	push   %ebp
  801c34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 0b                	push   $0xb
  801c42:	e8 80 fe ff ff       	call   801ac7 <syscall>
  801c47:	83 c4 18             	add    $0x18,%esp
}
  801c4a:	c9                   	leave  
  801c4b:	c3                   	ret    

00801c4c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c4c:	55                   	push   %ebp
  801c4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 00                	push   $0x0
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 0c                	push   $0xc
  801c5b:	e8 67 fe ff ff       	call   801ac7 <syscall>
  801c60:	83 c4 18             	add    $0x18,%esp
}
  801c63:	c9                   	leave  
  801c64:	c3                   	ret    

00801c65 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c65:	55                   	push   %ebp
  801c66:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 0d                	push   $0xd
  801c74:	e8 4e fe ff ff       	call   801ac7 <syscall>
  801c79:	83 c4 18             	add    $0x18,%esp
}
  801c7c:	c9                   	leave  
  801c7d:	c3                   	ret    

00801c7e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c7e:	55                   	push   %ebp
  801c7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	ff 75 0c             	pushl  0xc(%ebp)
  801c8a:	ff 75 08             	pushl  0x8(%ebp)
  801c8d:	6a 11                	push   $0x11
  801c8f:	e8 33 fe ff ff       	call   801ac7 <syscall>
  801c94:	83 c4 18             	add    $0x18,%esp
	return;
  801c97:	90                   	nop
}
  801c98:	c9                   	leave  
  801c99:	c3                   	ret    

00801c9a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c9a:	55                   	push   %ebp
  801c9b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c9d:	6a 00                	push   $0x0
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 00                	push   $0x0
  801ca3:	ff 75 0c             	pushl  0xc(%ebp)
  801ca6:	ff 75 08             	pushl  0x8(%ebp)
  801ca9:	6a 12                	push   $0x12
  801cab:	e8 17 fe ff ff       	call   801ac7 <syscall>
  801cb0:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb3:	90                   	nop
}
  801cb4:	c9                   	leave  
  801cb5:	c3                   	ret    

00801cb6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801cb6:	55                   	push   %ebp
  801cb7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 0e                	push   $0xe
  801cc5:	e8 fd fd ff ff       	call   801ac7 <syscall>
  801cca:	83 c4 18             	add    $0x18,%esp
}
  801ccd:	c9                   	leave  
  801cce:	c3                   	ret    

00801ccf <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ccf:	55                   	push   %ebp
  801cd0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	ff 75 08             	pushl  0x8(%ebp)
  801cdd:	6a 0f                	push   $0xf
  801cdf:	e8 e3 fd ff ff       	call   801ac7 <syscall>
  801ce4:	83 c4 18             	add    $0x18,%esp
}
  801ce7:	c9                   	leave  
  801ce8:	c3                   	ret    

00801ce9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ce9:	55                   	push   %ebp
  801cea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 10                	push   $0x10
  801cf8:	e8 ca fd ff ff       	call   801ac7 <syscall>
  801cfd:	83 c4 18             	add    $0x18,%esp
}
  801d00:	90                   	nop
  801d01:	c9                   	leave  
  801d02:	c3                   	ret    

00801d03 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d03:	55                   	push   %ebp
  801d04:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 14                	push   $0x14
  801d12:	e8 b0 fd ff ff       	call   801ac7 <syscall>
  801d17:	83 c4 18             	add    $0x18,%esp
}
  801d1a:	90                   	nop
  801d1b:	c9                   	leave  
  801d1c:	c3                   	ret    

00801d1d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d1d:	55                   	push   %ebp
  801d1e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 15                	push   $0x15
  801d2c:	e8 96 fd ff ff       	call   801ac7 <syscall>
  801d31:	83 c4 18             	add    $0x18,%esp
}
  801d34:	90                   	nop
  801d35:	c9                   	leave  
  801d36:	c3                   	ret    

00801d37 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d37:	55                   	push   %ebp
  801d38:	89 e5                	mov    %esp,%ebp
  801d3a:	83 ec 04             	sub    $0x4,%esp
  801d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d40:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d43:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 00                	push   $0x0
  801d4d:	6a 00                	push   $0x0
  801d4f:	50                   	push   %eax
  801d50:	6a 16                	push   $0x16
  801d52:	e8 70 fd ff ff       	call   801ac7 <syscall>
  801d57:	83 c4 18             	add    $0x18,%esp
}
  801d5a:	90                   	nop
  801d5b:	c9                   	leave  
  801d5c:	c3                   	ret    

00801d5d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d5d:	55                   	push   %ebp
  801d5e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d60:	6a 00                	push   $0x0
  801d62:	6a 00                	push   $0x0
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 17                	push   $0x17
  801d6c:	e8 56 fd ff ff       	call   801ac7 <syscall>
  801d71:	83 c4 18             	add    $0x18,%esp
}
  801d74:	90                   	nop
  801d75:	c9                   	leave  
  801d76:	c3                   	ret    

00801d77 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d77:	55                   	push   %ebp
  801d78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	ff 75 0c             	pushl  0xc(%ebp)
  801d86:	50                   	push   %eax
  801d87:	6a 18                	push   $0x18
  801d89:	e8 39 fd ff ff       	call   801ac7 <syscall>
  801d8e:	83 c4 18             	add    $0x18,%esp
}
  801d91:	c9                   	leave  
  801d92:	c3                   	ret    

00801d93 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d93:	55                   	push   %ebp
  801d94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d99:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	52                   	push   %edx
  801da3:	50                   	push   %eax
  801da4:	6a 1b                	push   $0x1b
  801da6:	e8 1c fd ff ff       	call   801ac7 <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
}
  801dae:	c9                   	leave  
  801daf:	c3                   	ret    

00801db0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801db0:	55                   	push   %ebp
  801db1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801db3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db6:	8b 45 08             	mov    0x8(%ebp),%eax
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	52                   	push   %edx
  801dc0:	50                   	push   %eax
  801dc1:	6a 19                	push   $0x19
  801dc3:	e8 ff fc ff ff       	call   801ac7 <syscall>
  801dc8:	83 c4 18             	add    $0x18,%esp
}
  801dcb:	90                   	nop
  801dcc:	c9                   	leave  
  801dcd:	c3                   	ret    

00801dce <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801dce:	55                   	push   %ebp
  801dcf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dd1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	52                   	push   %edx
  801dde:	50                   	push   %eax
  801ddf:	6a 1a                	push   $0x1a
  801de1:	e8 e1 fc ff ff       	call   801ac7 <syscall>
  801de6:	83 c4 18             	add    $0x18,%esp
}
  801de9:	90                   	nop
  801dea:	c9                   	leave  
  801deb:	c3                   	ret    

00801dec <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801dec:	55                   	push   %ebp
  801ded:	89 e5                	mov    %esp,%ebp
  801def:	83 ec 04             	sub    $0x4,%esp
  801df2:	8b 45 10             	mov    0x10(%ebp),%eax
  801df5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801df8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801dfb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dff:	8b 45 08             	mov    0x8(%ebp),%eax
  801e02:	6a 00                	push   $0x0
  801e04:	51                   	push   %ecx
  801e05:	52                   	push   %edx
  801e06:	ff 75 0c             	pushl  0xc(%ebp)
  801e09:	50                   	push   %eax
  801e0a:	6a 1c                	push   $0x1c
  801e0c:	e8 b6 fc ff ff       	call   801ac7 <syscall>
  801e11:	83 c4 18             	add    $0x18,%esp
}
  801e14:	c9                   	leave  
  801e15:	c3                   	ret    

00801e16 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e16:	55                   	push   %ebp
  801e17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e19:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	52                   	push   %edx
  801e26:	50                   	push   %eax
  801e27:	6a 1d                	push   $0x1d
  801e29:	e8 99 fc ff ff       	call   801ac7 <syscall>
  801e2e:	83 c4 18             	add    $0x18,%esp
}
  801e31:	c9                   	leave  
  801e32:	c3                   	ret    

00801e33 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e33:	55                   	push   %ebp
  801e34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e36:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e39:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	51                   	push   %ecx
  801e44:	52                   	push   %edx
  801e45:	50                   	push   %eax
  801e46:	6a 1e                	push   $0x1e
  801e48:	e8 7a fc ff ff       	call   801ac7 <syscall>
  801e4d:	83 c4 18             	add    $0x18,%esp
}
  801e50:	c9                   	leave  
  801e51:	c3                   	ret    

00801e52 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e52:	55                   	push   %ebp
  801e53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e55:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e58:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	52                   	push   %edx
  801e62:	50                   	push   %eax
  801e63:	6a 1f                	push   $0x1f
  801e65:	e8 5d fc ff ff       	call   801ac7 <syscall>
  801e6a:	83 c4 18             	add    $0x18,%esp
}
  801e6d:	c9                   	leave  
  801e6e:	c3                   	ret    

00801e6f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e6f:	55                   	push   %ebp
  801e70:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 20                	push   $0x20
  801e7e:	e8 44 fc ff ff       	call   801ac7 <syscall>
  801e83:	83 c4 18             	add    $0x18,%esp
}
  801e86:	c9                   	leave  
  801e87:	c3                   	ret    

00801e88 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801e88:	55                   	push   %ebp
  801e89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8e:	6a 00                	push   $0x0
  801e90:	ff 75 14             	pushl  0x14(%ebp)
  801e93:	ff 75 10             	pushl  0x10(%ebp)
  801e96:	ff 75 0c             	pushl  0xc(%ebp)
  801e99:	50                   	push   %eax
  801e9a:	6a 21                	push   $0x21
  801e9c:	e8 26 fc ff ff       	call   801ac7 <syscall>
  801ea1:	83 c4 18             	add    $0x18,%esp
}
  801ea4:	c9                   	leave  
  801ea5:	c3                   	ret    

00801ea6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  801eac:	6a 00                	push   $0x0
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	50                   	push   %eax
  801eb5:	6a 22                	push   $0x22
  801eb7:	e8 0b fc ff ff       	call   801ac7 <syscall>
  801ebc:	83 c4 18             	add    $0x18,%esp
}
  801ebf:	90                   	nop
  801ec0:	c9                   	leave  
  801ec1:	c3                   	ret    

00801ec2 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ec2:	55                   	push   %ebp
  801ec3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 00                	push   $0x0
  801ed0:	50                   	push   %eax
  801ed1:	6a 23                	push   $0x23
  801ed3:	e8 ef fb ff ff       	call   801ac7 <syscall>
  801ed8:	83 c4 18             	add    $0x18,%esp
}
  801edb:	90                   	nop
  801edc:	c9                   	leave  
  801edd:	c3                   	ret    

00801ede <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ede:	55                   	push   %ebp
  801edf:	89 e5                	mov    %esp,%ebp
  801ee1:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ee4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ee7:	8d 50 04             	lea    0x4(%eax),%edx
  801eea:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801eed:	6a 00                	push   $0x0
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	52                   	push   %edx
  801ef4:	50                   	push   %eax
  801ef5:	6a 24                	push   $0x24
  801ef7:	e8 cb fb ff ff       	call   801ac7 <syscall>
  801efc:	83 c4 18             	add    $0x18,%esp
	return result;
  801eff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f02:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f05:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f08:	89 01                	mov    %eax,(%ecx)
  801f0a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f10:	c9                   	leave  
  801f11:	c2 04 00             	ret    $0x4

00801f14 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f14:	55                   	push   %ebp
  801f15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	ff 75 10             	pushl  0x10(%ebp)
  801f1e:	ff 75 0c             	pushl  0xc(%ebp)
  801f21:	ff 75 08             	pushl  0x8(%ebp)
  801f24:	6a 13                	push   $0x13
  801f26:	e8 9c fb ff ff       	call   801ac7 <syscall>
  801f2b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f2e:	90                   	nop
}
  801f2f:	c9                   	leave  
  801f30:	c3                   	ret    

00801f31 <sys_rcr2>:
uint32 sys_rcr2()
{
  801f31:	55                   	push   %ebp
  801f32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 25                	push   $0x25
  801f40:	e8 82 fb ff ff       	call   801ac7 <syscall>
  801f45:	83 c4 18             	add    $0x18,%esp
}
  801f48:	c9                   	leave  
  801f49:	c3                   	ret    

00801f4a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f4a:	55                   	push   %ebp
  801f4b:	89 e5                	mov    %esp,%ebp
  801f4d:	83 ec 04             	sub    $0x4,%esp
  801f50:	8b 45 08             	mov    0x8(%ebp),%eax
  801f53:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f56:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f5a:	6a 00                	push   $0x0
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	50                   	push   %eax
  801f63:	6a 26                	push   $0x26
  801f65:	e8 5d fb ff ff       	call   801ac7 <syscall>
  801f6a:	83 c4 18             	add    $0x18,%esp
	return ;
  801f6d:	90                   	nop
}
  801f6e:	c9                   	leave  
  801f6f:	c3                   	ret    

00801f70 <rsttst>:
void rsttst()
{
  801f70:	55                   	push   %ebp
  801f71:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f73:	6a 00                	push   $0x0
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 28                	push   $0x28
  801f7f:	e8 43 fb ff ff       	call   801ac7 <syscall>
  801f84:	83 c4 18             	add    $0x18,%esp
	return ;
  801f87:	90                   	nop
}
  801f88:	c9                   	leave  
  801f89:	c3                   	ret    

00801f8a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f8a:	55                   	push   %ebp
  801f8b:	89 e5                	mov    %esp,%ebp
  801f8d:	83 ec 04             	sub    $0x4,%esp
  801f90:	8b 45 14             	mov    0x14(%ebp),%eax
  801f93:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f96:	8b 55 18             	mov    0x18(%ebp),%edx
  801f99:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f9d:	52                   	push   %edx
  801f9e:	50                   	push   %eax
  801f9f:	ff 75 10             	pushl  0x10(%ebp)
  801fa2:	ff 75 0c             	pushl  0xc(%ebp)
  801fa5:	ff 75 08             	pushl  0x8(%ebp)
  801fa8:	6a 27                	push   $0x27
  801faa:	e8 18 fb ff ff       	call   801ac7 <syscall>
  801faf:	83 c4 18             	add    $0x18,%esp
	return ;
  801fb2:	90                   	nop
}
  801fb3:	c9                   	leave  
  801fb4:	c3                   	ret    

00801fb5 <chktst>:
void chktst(uint32 n)
{
  801fb5:	55                   	push   %ebp
  801fb6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 00                	push   $0x0
  801fc0:	ff 75 08             	pushl  0x8(%ebp)
  801fc3:	6a 29                	push   $0x29
  801fc5:	e8 fd fa ff ff       	call   801ac7 <syscall>
  801fca:	83 c4 18             	add    $0x18,%esp
	return ;
  801fcd:	90                   	nop
}
  801fce:	c9                   	leave  
  801fcf:	c3                   	ret    

00801fd0 <inctst>:

void inctst()
{
  801fd0:	55                   	push   %ebp
  801fd1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 2a                	push   $0x2a
  801fdf:	e8 e3 fa ff ff       	call   801ac7 <syscall>
  801fe4:	83 c4 18             	add    $0x18,%esp
	return ;
  801fe7:	90                   	nop
}
  801fe8:	c9                   	leave  
  801fe9:	c3                   	ret    

00801fea <gettst>:
uint32 gettst()
{
  801fea:	55                   	push   %ebp
  801feb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 2b                	push   $0x2b
  801ff9:	e8 c9 fa ff ff       	call   801ac7 <syscall>
  801ffe:	83 c4 18             	add    $0x18,%esp
}
  802001:	c9                   	leave  
  802002:	c3                   	ret    

00802003 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802003:	55                   	push   %ebp
  802004:	89 e5                	mov    %esp,%ebp
  802006:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802009:	6a 00                	push   $0x0
  80200b:	6a 00                	push   $0x0
  80200d:	6a 00                	push   $0x0
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	6a 2c                	push   $0x2c
  802015:	e8 ad fa ff ff       	call   801ac7 <syscall>
  80201a:	83 c4 18             	add    $0x18,%esp
  80201d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802020:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802024:	75 07                	jne    80202d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802026:	b8 01 00 00 00       	mov    $0x1,%eax
  80202b:	eb 05                	jmp    802032 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80202d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802032:	c9                   	leave  
  802033:	c3                   	ret    

00802034 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802034:	55                   	push   %ebp
  802035:	89 e5                	mov    %esp,%ebp
  802037:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 2c                	push   $0x2c
  802046:	e8 7c fa ff ff       	call   801ac7 <syscall>
  80204b:	83 c4 18             	add    $0x18,%esp
  80204e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802051:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802055:	75 07                	jne    80205e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802057:	b8 01 00 00 00       	mov    $0x1,%eax
  80205c:	eb 05                	jmp    802063 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80205e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802063:	c9                   	leave  
  802064:	c3                   	ret    

00802065 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802065:	55                   	push   %ebp
  802066:	89 e5                	mov    %esp,%ebp
  802068:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80206b:	6a 00                	push   $0x0
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	6a 00                	push   $0x0
  802073:	6a 00                	push   $0x0
  802075:	6a 2c                	push   $0x2c
  802077:	e8 4b fa ff ff       	call   801ac7 <syscall>
  80207c:	83 c4 18             	add    $0x18,%esp
  80207f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802082:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802086:	75 07                	jne    80208f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802088:	b8 01 00 00 00       	mov    $0x1,%eax
  80208d:	eb 05                	jmp    802094 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80208f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802094:	c9                   	leave  
  802095:	c3                   	ret    

00802096 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802096:	55                   	push   %ebp
  802097:	89 e5                	mov    %esp,%ebp
  802099:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 00                	push   $0x0
  8020a6:	6a 2c                	push   $0x2c
  8020a8:	e8 1a fa ff ff       	call   801ac7 <syscall>
  8020ad:	83 c4 18             	add    $0x18,%esp
  8020b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8020b3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8020b7:	75 07                	jne    8020c0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8020b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8020be:	eb 05                	jmp    8020c5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8020c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020c5:	c9                   	leave  
  8020c6:	c3                   	ret    

008020c7 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020c7:	55                   	push   %ebp
  8020c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020ca:	6a 00                	push   $0x0
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	ff 75 08             	pushl  0x8(%ebp)
  8020d5:	6a 2d                	push   $0x2d
  8020d7:	e8 eb f9 ff ff       	call   801ac7 <syscall>
  8020dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8020df:	90                   	nop
}
  8020e0:	c9                   	leave  
  8020e1:	c3                   	ret    

008020e2 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020e2:	55                   	push   %ebp
  8020e3:	89 e5                	mov    %esp,%ebp
  8020e5:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8020e6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020e9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f2:	6a 00                	push   $0x0
  8020f4:	53                   	push   %ebx
  8020f5:	51                   	push   %ecx
  8020f6:	52                   	push   %edx
  8020f7:	50                   	push   %eax
  8020f8:	6a 2e                	push   $0x2e
  8020fa:	e8 c8 f9 ff ff       	call   801ac7 <syscall>
  8020ff:	83 c4 18             	add    $0x18,%esp
}
  802102:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802105:	c9                   	leave  
  802106:	c3                   	ret    

00802107 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802107:	55                   	push   %ebp
  802108:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80210a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80210d:	8b 45 08             	mov    0x8(%ebp),%eax
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	52                   	push   %edx
  802117:	50                   	push   %eax
  802118:	6a 2f                	push   $0x2f
  80211a:	e8 a8 f9 ff ff       	call   801ac7 <syscall>
  80211f:	83 c4 18             	add    $0x18,%esp
}
  802122:	c9                   	leave  
  802123:	c3                   	ret    

00802124 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  802124:	55                   	push   %ebp
  802125:	89 e5                	mov    %esp,%ebp
  802127:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80212a:	8b 55 08             	mov    0x8(%ebp),%edx
  80212d:	89 d0                	mov    %edx,%eax
  80212f:	c1 e0 02             	shl    $0x2,%eax
  802132:	01 d0                	add    %edx,%eax
  802134:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80213b:	01 d0                	add    %edx,%eax
  80213d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802144:	01 d0                	add    %edx,%eax
  802146:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80214d:	01 d0                	add    %edx,%eax
  80214f:	c1 e0 04             	shl    $0x4,%eax
  802152:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  802155:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80215c:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80215f:	83 ec 0c             	sub    $0xc,%esp
  802162:	50                   	push   %eax
  802163:	e8 76 fd ff ff       	call   801ede <sys_get_virtual_time>
  802168:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  80216b:	eb 41                	jmp    8021ae <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80216d:	8d 45 e0             	lea    -0x20(%ebp),%eax
  802170:	83 ec 0c             	sub    $0xc,%esp
  802173:	50                   	push   %eax
  802174:	e8 65 fd ff ff       	call   801ede <sys_get_virtual_time>
  802179:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80217c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80217f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802182:	29 c2                	sub    %eax,%edx
  802184:	89 d0                	mov    %edx,%eax
  802186:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  802189:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80218c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80218f:	89 d1                	mov    %edx,%ecx
  802191:	29 c1                	sub    %eax,%ecx
  802193:	8b 55 d8             	mov    -0x28(%ebp),%edx
  802196:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802199:	39 c2                	cmp    %eax,%edx
  80219b:	0f 97 c0             	seta   %al
  80219e:	0f b6 c0             	movzbl %al,%eax
  8021a1:	29 c1                	sub    %eax,%ecx
  8021a3:	89 c8                	mov    %ecx,%eax
  8021a5:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8021a8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8021ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8021ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8021b1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8021b4:	72 b7                	jb     80216d <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  8021b6:	90                   	nop
  8021b7:	c9                   	leave  
  8021b8:	c3                   	ret    

008021b9 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8021b9:	55                   	push   %ebp
  8021ba:	89 e5                	mov    %esp,%ebp
  8021bc:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8021bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8021c6:	eb 03                	jmp    8021cb <busy_wait+0x12>
  8021c8:	ff 45 fc             	incl   -0x4(%ebp)
  8021cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021ce:	3b 45 08             	cmp    0x8(%ebp),%eax
  8021d1:	72 f5                	jb     8021c8 <busy_wait+0xf>
	return i;
  8021d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8021d6:	c9                   	leave  
  8021d7:	c3                   	ret    

008021d8 <__udivdi3>:
  8021d8:	55                   	push   %ebp
  8021d9:	57                   	push   %edi
  8021da:	56                   	push   %esi
  8021db:	53                   	push   %ebx
  8021dc:	83 ec 1c             	sub    $0x1c,%esp
  8021df:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021e3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021e7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021eb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021ef:	89 ca                	mov    %ecx,%edx
  8021f1:	89 f8                	mov    %edi,%eax
  8021f3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021f7:	85 f6                	test   %esi,%esi
  8021f9:	75 2d                	jne    802228 <__udivdi3+0x50>
  8021fb:	39 cf                	cmp    %ecx,%edi
  8021fd:	77 65                	ja     802264 <__udivdi3+0x8c>
  8021ff:	89 fd                	mov    %edi,%ebp
  802201:	85 ff                	test   %edi,%edi
  802203:	75 0b                	jne    802210 <__udivdi3+0x38>
  802205:	b8 01 00 00 00       	mov    $0x1,%eax
  80220a:	31 d2                	xor    %edx,%edx
  80220c:	f7 f7                	div    %edi
  80220e:	89 c5                	mov    %eax,%ebp
  802210:	31 d2                	xor    %edx,%edx
  802212:	89 c8                	mov    %ecx,%eax
  802214:	f7 f5                	div    %ebp
  802216:	89 c1                	mov    %eax,%ecx
  802218:	89 d8                	mov    %ebx,%eax
  80221a:	f7 f5                	div    %ebp
  80221c:	89 cf                	mov    %ecx,%edi
  80221e:	89 fa                	mov    %edi,%edx
  802220:	83 c4 1c             	add    $0x1c,%esp
  802223:	5b                   	pop    %ebx
  802224:	5e                   	pop    %esi
  802225:	5f                   	pop    %edi
  802226:	5d                   	pop    %ebp
  802227:	c3                   	ret    
  802228:	39 ce                	cmp    %ecx,%esi
  80222a:	77 28                	ja     802254 <__udivdi3+0x7c>
  80222c:	0f bd fe             	bsr    %esi,%edi
  80222f:	83 f7 1f             	xor    $0x1f,%edi
  802232:	75 40                	jne    802274 <__udivdi3+0x9c>
  802234:	39 ce                	cmp    %ecx,%esi
  802236:	72 0a                	jb     802242 <__udivdi3+0x6a>
  802238:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80223c:	0f 87 9e 00 00 00    	ja     8022e0 <__udivdi3+0x108>
  802242:	b8 01 00 00 00       	mov    $0x1,%eax
  802247:	89 fa                	mov    %edi,%edx
  802249:	83 c4 1c             	add    $0x1c,%esp
  80224c:	5b                   	pop    %ebx
  80224d:	5e                   	pop    %esi
  80224e:	5f                   	pop    %edi
  80224f:	5d                   	pop    %ebp
  802250:	c3                   	ret    
  802251:	8d 76 00             	lea    0x0(%esi),%esi
  802254:	31 ff                	xor    %edi,%edi
  802256:	31 c0                	xor    %eax,%eax
  802258:	89 fa                	mov    %edi,%edx
  80225a:	83 c4 1c             	add    $0x1c,%esp
  80225d:	5b                   	pop    %ebx
  80225e:	5e                   	pop    %esi
  80225f:	5f                   	pop    %edi
  802260:	5d                   	pop    %ebp
  802261:	c3                   	ret    
  802262:	66 90                	xchg   %ax,%ax
  802264:	89 d8                	mov    %ebx,%eax
  802266:	f7 f7                	div    %edi
  802268:	31 ff                	xor    %edi,%edi
  80226a:	89 fa                	mov    %edi,%edx
  80226c:	83 c4 1c             	add    $0x1c,%esp
  80226f:	5b                   	pop    %ebx
  802270:	5e                   	pop    %esi
  802271:	5f                   	pop    %edi
  802272:	5d                   	pop    %ebp
  802273:	c3                   	ret    
  802274:	bd 20 00 00 00       	mov    $0x20,%ebp
  802279:	89 eb                	mov    %ebp,%ebx
  80227b:	29 fb                	sub    %edi,%ebx
  80227d:	89 f9                	mov    %edi,%ecx
  80227f:	d3 e6                	shl    %cl,%esi
  802281:	89 c5                	mov    %eax,%ebp
  802283:	88 d9                	mov    %bl,%cl
  802285:	d3 ed                	shr    %cl,%ebp
  802287:	89 e9                	mov    %ebp,%ecx
  802289:	09 f1                	or     %esi,%ecx
  80228b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80228f:	89 f9                	mov    %edi,%ecx
  802291:	d3 e0                	shl    %cl,%eax
  802293:	89 c5                	mov    %eax,%ebp
  802295:	89 d6                	mov    %edx,%esi
  802297:	88 d9                	mov    %bl,%cl
  802299:	d3 ee                	shr    %cl,%esi
  80229b:	89 f9                	mov    %edi,%ecx
  80229d:	d3 e2                	shl    %cl,%edx
  80229f:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022a3:	88 d9                	mov    %bl,%cl
  8022a5:	d3 e8                	shr    %cl,%eax
  8022a7:	09 c2                	or     %eax,%edx
  8022a9:	89 d0                	mov    %edx,%eax
  8022ab:	89 f2                	mov    %esi,%edx
  8022ad:	f7 74 24 0c          	divl   0xc(%esp)
  8022b1:	89 d6                	mov    %edx,%esi
  8022b3:	89 c3                	mov    %eax,%ebx
  8022b5:	f7 e5                	mul    %ebp
  8022b7:	39 d6                	cmp    %edx,%esi
  8022b9:	72 19                	jb     8022d4 <__udivdi3+0xfc>
  8022bb:	74 0b                	je     8022c8 <__udivdi3+0xf0>
  8022bd:	89 d8                	mov    %ebx,%eax
  8022bf:	31 ff                	xor    %edi,%edi
  8022c1:	e9 58 ff ff ff       	jmp    80221e <__udivdi3+0x46>
  8022c6:	66 90                	xchg   %ax,%ax
  8022c8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022cc:	89 f9                	mov    %edi,%ecx
  8022ce:	d3 e2                	shl    %cl,%edx
  8022d0:	39 c2                	cmp    %eax,%edx
  8022d2:	73 e9                	jae    8022bd <__udivdi3+0xe5>
  8022d4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022d7:	31 ff                	xor    %edi,%edi
  8022d9:	e9 40 ff ff ff       	jmp    80221e <__udivdi3+0x46>
  8022de:	66 90                	xchg   %ax,%ax
  8022e0:	31 c0                	xor    %eax,%eax
  8022e2:	e9 37 ff ff ff       	jmp    80221e <__udivdi3+0x46>
  8022e7:	90                   	nop

008022e8 <__umoddi3>:
  8022e8:	55                   	push   %ebp
  8022e9:	57                   	push   %edi
  8022ea:	56                   	push   %esi
  8022eb:	53                   	push   %ebx
  8022ec:	83 ec 1c             	sub    $0x1c,%esp
  8022ef:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022f3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022f7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022fb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802303:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802307:	89 f3                	mov    %esi,%ebx
  802309:	89 fa                	mov    %edi,%edx
  80230b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80230f:	89 34 24             	mov    %esi,(%esp)
  802312:	85 c0                	test   %eax,%eax
  802314:	75 1a                	jne    802330 <__umoddi3+0x48>
  802316:	39 f7                	cmp    %esi,%edi
  802318:	0f 86 a2 00 00 00    	jbe    8023c0 <__umoddi3+0xd8>
  80231e:	89 c8                	mov    %ecx,%eax
  802320:	89 f2                	mov    %esi,%edx
  802322:	f7 f7                	div    %edi
  802324:	89 d0                	mov    %edx,%eax
  802326:	31 d2                	xor    %edx,%edx
  802328:	83 c4 1c             	add    $0x1c,%esp
  80232b:	5b                   	pop    %ebx
  80232c:	5e                   	pop    %esi
  80232d:	5f                   	pop    %edi
  80232e:	5d                   	pop    %ebp
  80232f:	c3                   	ret    
  802330:	39 f0                	cmp    %esi,%eax
  802332:	0f 87 ac 00 00 00    	ja     8023e4 <__umoddi3+0xfc>
  802338:	0f bd e8             	bsr    %eax,%ebp
  80233b:	83 f5 1f             	xor    $0x1f,%ebp
  80233e:	0f 84 ac 00 00 00    	je     8023f0 <__umoddi3+0x108>
  802344:	bf 20 00 00 00       	mov    $0x20,%edi
  802349:	29 ef                	sub    %ebp,%edi
  80234b:	89 fe                	mov    %edi,%esi
  80234d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802351:	89 e9                	mov    %ebp,%ecx
  802353:	d3 e0                	shl    %cl,%eax
  802355:	89 d7                	mov    %edx,%edi
  802357:	89 f1                	mov    %esi,%ecx
  802359:	d3 ef                	shr    %cl,%edi
  80235b:	09 c7                	or     %eax,%edi
  80235d:	89 e9                	mov    %ebp,%ecx
  80235f:	d3 e2                	shl    %cl,%edx
  802361:	89 14 24             	mov    %edx,(%esp)
  802364:	89 d8                	mov    %ebx,%eax
  802366:	d3 e0                	shl    %cl,%eax
  802368:	89 c2                	mov    %eax,%edx
  80236a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80236e:	d3 e0                	shl    %cl,%eax
  802370:	89 44 24 04          	mov    %eax,0x4(%esp)
  802374:	8b 44 24 08          	mov    0x8(%esp),%eax
  802378:	89 f1                	mov    %esi,%ecx
  80237a:	d3 e8                	shr    %cl,%eax
  80237c:	09 d0                	or     %edx,%eax
  80237e:	d3 eb                	shr    %cl,%ebx
  802380:	89 da                	mov    %ebx,%edx
  802382:	f7 f7                	div    %edi
  802384:	89 d3                	mov    %edx,%ebx
  802386:	f7 24 24             	mull   (%esp)
  802389:	89 c6                	mov    %eax,%esi
  80238b:	89 d1                	mov    %edx,%ecx
  80238d:	39 d3                	cmp    %edx,%ebx
  80238f:	0f 82 87 00 00 00    	jb     80241c <__umoddi3+0x134>
  802395:	0f 84 91 00 00 00    	je     80242c <__umoddi3+0x144>
  80239b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80239f:	29 f2                	sub    %esi,%edx
  8023a1:	19 cb                	sbb    %ecx,%ebx
  8023a3:	89 d8                	mov    %ebx,%eax
  8023a5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023a9:	d3 e0                	shl    %cl,%eax
  8023ab:	89 e9                	mov    %ebp,%ecx
  8023ad:	d3 ea                	shr    %cl,%edx
  8023af:	09 d0                	or     %edx,%eax
  8023b1:	89 e9                	mov    %ebp,%ecx
  8023b3:	d3 eb                	shr    %cl,%ebx
  8023b5:	89 da                	mov    %ebx,%edx
  8023b7:	83 c4 1c             	add    $0x1c,%esp
  8023ba:	5b                   	pop    %ebx
  8023bb:	5e                   	pop    %esi
  8023bc:	5f                   	pop    %edi
  8023bd:	5d                   	pop    %ebp
  8023be:	c3                   	ret    
  8023bf:	90                   	nop
  8023c0:	89 fd                	mov    %edi,%ebp
  8023c2:	85 ff                	test   %edi,%edi
  8023c4:	75 0b                	jne    8023d1 <__umoddi3+0xe9>
  8023c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8023cb:	31 d2                	xor    %edx,%edx
  8023cd:	f7 f7                	div    %edi
  8023cf:	89 c5                	mov    %eax,%ebp
  8023d1:	89 f0                	mov    %esi,%eax
  8023d3:	31 d2                	xor    %edx,%edx
  8023d5:	f7 f5                	div    %ebp
  8023d7:	89 c8                	mov    %ecx,%eax
  8023d9:	f7 f5                	div    %ebp
  8023db:	89 d0                	mov    %edx,%eax
  8023dd:	e9 44 ff ff ff       	jmp    802326 <__umoddi3+0x3e>
  8023e2:	66 90                	xchg   %ax,%ax
  8023e4:	89 c8                	mov    %ecx,%eax
  8023e6:	89 f2                	mov    %esi,%edx
  8023e8:	83 c4 1c             	add    $0x1c,%esp
  8023eb:	5b                   	pop    %ebx
  8023ec:	5e                   	pop    %esi
  8023ed:	5f                   	pop    %edi
  8023ee:	5d                   	pop    %ebp
  8023ef:	c3                   	ret    
  8023f0:	3b 04 24             	cmp    (%esp),%eax
  8023f3:	72 06                	jb     8023fb <__umoddi3+0x113>
  8023f5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023f9:	77 0f                	ja     80240a <__umoddi3+0x122>
  8023fb:	89 f2                	mov    %esi,%edx
  8023fd:	29 f9                	sub    %edi,%ecx
  8023ff:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802403:	89 14 24             	mov    %edx,(%esp)
  802406:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80240a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80240e:	8b 14 24             	mov    (%esp),%edx
  802411:	83 c4 1c             	add    $0x1c,%esp
  802414:	5b                   	pop    %ebx
  802415:	5e                   	pop    %esi
  802416:	5f                   	pop    %edi
  802417:	5d                   	pop    %ebp
  802418:	c3                   	ret    
  802419:	8d 76 00             	lea    0x0(%esi),%esi
  80241c:	2b 04 24             	sub    (%esp),%eax
  80241f:	19 fa                	sbb    %edi,%edx
  802421:	89 d1                	mov    %edx,%ecx
  802423:	89 c6                	mov    %eax,%esi
  802425:	e9 71 ff ff ff       	jmp    80239b <__umoddi3+0xb3>
  80242a:	66 90                	xchg   %ax,%ax
  80242c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802430:	72 ea                	jb     80241c <__umoddi3+0x134>
  802432:	89 d9                	mov    %ebx,%ecx
  802434:	e9 62 ff ff ff       	jmp    80239b <__umoddi3+0xb3>

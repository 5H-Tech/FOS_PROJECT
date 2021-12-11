
obj/user/tst_mod_4:     file format elf32-i386


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
  800031:	e8 36 04 00 00       	call   80046c <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

#include <inc/lib.h>
extern void sys_clear_ffl() ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
	int envID = sys_getenvid();
  800044:	e8 1c 16 00 00       	call   801665 <sys_getenvid>
  800049:	89 45 cc             	mov    %eax,-0x34(%ebp)
	//	cprintf("envID = %d\n",envID);

	uint8* ptr = (uint8* )0x0801000 ;
  80004c:	c7 45 c8 00 10 80 00 	movl   $0x801000,-0x38(%ebp)
	uint8* ptr2 = (uint8* )0x080400A ;
  800053:	c7 45 c4 0a 40 80 00 	movl   $0x80400a,-0x3c(%ebp)
	uint8* ptr3 = (uint8* )(USTACKTOP - PTSIZE) ;
  80005a:	c7 45 c0 00 e0 7f ee 	movl   $0xee7fe000,-0x40(%ebp)

	//("STEP 0: checking InitialWSError2: INITIAL WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800061:	a1 20 30 80 00       	mov    0x803020,%eax
  800066:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80006c:	8b 00                	mov    (%eax),%eax
  80006e:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800071:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800074:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800079:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80007e:	74 14                	je     800094 <_main+0x5c>
  800080:	83 ec 04             	sub    $0x4,%esp
  800083:	68 a0 1e 80 00       	push   $0x801ea0
  800088:	6a 13                	push   $0x13
  80008a:	68 f2 1e 80 00       	push   $0x801ef2
  80008f:	e8 1d 05 00 00       	call   8005b1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800094:	a1 20 30 80 00       	mov    0x803020,%eax
  800099:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80009f:	83 c0 10             	add    $0x10,%eax
  8000a2:	8b 00                	mov    (%eax),%eax
  8000a4:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8000a7:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8000aa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000af:	3d 00 10 20 00       	cmp    $0x201000,%eax
  8000b4:	74 14                	je     8000ca <_main+0x92>
  8000b6:	83 ec 04             	sub    $0x4,%esp
  8000b9:	68 a0 1e 80 00       	push   $0x801ea0
  8000be:	6a 14                	push   $0x14
  8000c0:	68 f2 1e 80 00       	push   $0x801ef2
  8000c5:	e8 e7 04 00 00       	call   8005b1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8000cf:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000d5:	83 c0 20             	add    $0x20,%eax
  8000d8:	8b 00                	mov    (%eax),%eax
  8000da:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8000dd:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8000e0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000e5:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000ea:	74 14                	je     800100 <_main+0xc8>
  8000ec:	83 ec 04             	sub    $0x4,%esp
  8000ef:	68 a0 1e 80 00       	push   $0x801ea0
  8000f4:	6a 15                	push   $0x15
  8000f6:	68 f2 1e 80 00       	push   $0x801ef2
  8000fb:	e8 b1 04 00 00       	call   8005b1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800100:	a1 20 30 80 00       	mov    0x803020,%eax
  800105:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80010b:	83 c0 30             	add    $0x30,%eax
  80010e:	8b 00                	mov    (%eax),%eax
  800110:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800113:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800116:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80011b:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800120:	74 14                	je     800136 <_main+0xfe>
  800122:	83 ec 04             	sub    $0x4,%esp
  800125:	68 a0 1e 80 00       	push   $0x801ea0
  80012a:	6a 16                	push   $0x16
  80012c:	68 f2 1e 80 00       	push   $0x801ef2
  800131:	e8 7b 04 00 00       	call   8005b1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800136:	a1 20 30 80 00       	mov    0x803020,%eax
  80013b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800141:	83 c0 40             	add    $0x40,%eax
  800144:	8b 00                	mov    (%eax),%eax
  800146:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800149:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80014c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800151:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800156:	74 14                	je     80016c <_main+0x134>
  800158:	83 ec 04             	sub    $0x4,%esp
  80015b:	68 a0 1e 80 00       	push   $0x801ea0
  800160:	6a 17                	push   $0x17
  800162:	68 f2 1e 80 00       	push   $0x801ef2
  800167:	e8 45 04 00 00       	call   8005b1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80016c:	a1 20 30 80 00       	mov    0x803020,%eax
  800171:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800177:	83 c0 50             	add    $0x50,%eax
  80017a:	8b 00                	mov    (%eax),%eax
  80017c:	89 45 a8             	mov    %eax,-0x58(%ebp)
  80017f:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800182:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800187:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80018c:	74 14                	je     8001a2 <_main+0x16a>
  80018e:	83 ec 04             	sub    $0x4,%esp
  800191:	68 a0 1e 80 00       	push   $0x801ea0
  800196:	6a 18                	push   $0x18
  800198:	68 f2 1e 80 00       	push   $0x801ef2
  80019d:	e8 0f 04 00 00       	call   8005b1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001ad:	83 c0 60             	add    $0x60,%eax
  8001b0:	8b 00                	mov    (%eax),%eax
  8001b2:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8001b5:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8001b8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001bd:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001c2:	74 14                	je     8001d8 <_main+0x1a0>
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	68 a0 1e 80 00       	push   $0x801ea0
  8001cc:	6a 19                	push   $0x19
  8001ce:	68 f2 1e 80 00       	push   $0x801ef2
  8001d3:	e8 d9 03 00 00       	call   8005b1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001dd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001e3:	83 c0 70             	add    $0x70,%eax
  8001e6:	8b 00                	mov    (%eax),%eax
  8001e8:	89 45 a0             	mov    %eax,-0x60(%ebp)
  8001eb:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8001ee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001f3:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001f8:	74 14                	je     80020e <_main+0x1d6>
  8001fa:	83 ec 04             	sub    $0x4,%esp
  8001fd:	68 a0 1e 80 00       	push   $0x801ea0
  800202:	6a 1a                	push   $0x1a
  800204:	68 f2 1e 80 00       	push   $0x801ef2
  800209:	e8 a3 03 00 00       	call   8005b1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80020e:	a1 20 30 80 00       	mov    0x803020,%eax
  800213:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800219:	83 e8 80             	sub    $0xffffff80,%eax
  80021c:	8b 00                	mov    (%eax),%eax
  80021e:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800221:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800224:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800229:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80022e:	74 14                	je     800244 <_main+0x20c>
  800230:	83 ec 04             	sub    $0x4,%esp
  800233:	68 a0 1e 80 00       	push   $0x801ea0
  800238:	6a 1b                	push   $0x1b
  80023a:	68 f2 1e 80 00       	push   $0x801ef2
  80023f:	e8 6d 03 00 00       	call   8005b1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800244:	a1 20 30 80 00       	mov    0x803020,%eax
  800249:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80024f:	05 90 00 00 00       	add    $0x90,%eax
  800254:	8b 00                	mov    (%eax),%eax
  800256:	89 45 98             	mov    %eax,-0x68(%ebp)
  800259:	8b 45 98             	mov    -0x68(%ebp),%eax
  80025c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800261:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800266:	74 14                	je     80027c <_main+0x244>
  800268:	83 ec 04             	sub    $0x4,%esp
  80026b:	68 a0 1e 80 00       	push   $0x801ea0
  800270:	6a 1c                	push   $0x1c
  800272:	68 f2 1e 80 00       	push   $0x801ef2
  800277:	e8 35 03 00 00       	call   8005b1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80027c:	a1 20 30 80 00       	mov    0x803020,%eax
  800281:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800287:	05 a0 00 00 00       	add    $0xa0,%eax
  80028c:	8b 00                	mov    (%eax),%eax
  80028e:	89 45 94             	mov    %eax,-0x6c(%ebp)
  800291:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800294:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800299:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80029e:	74 14                	je     8002b4 <_main+0x27c>
  8002a0:	83 ec 04             	sub    $0x4,%esp
  8002a3:	68 a0 1e 80 00       	push   $0x801ea0
  8002a8:	6a 1d                	push   $0x1d
  8002aa:	68 f2 1e 80 00       	push   $0x801ef2
  8002af:	e8 fd 02 00 00       	call   8005b1 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  8002b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b9:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  8002bf:	85 c0                	test   %eax,%eax
  8002c1:	74 14                	je     8002d7 <_main+0x29f>
  8002c3:	83 ec 04             	sub    $0x4,%esp
  8002c6:	68 04 1f 80 00       	push   $0x801f04
  8002cb:	6a 1e                	push   $0x1e
  8002cd:	68 f2 1e 80 00       	push   $0x801ef2
  8002d2:	e8 da 02 00 00       	call   8005b1 <_panic>
	}

	//Reading (Not Modified)
	char garbage1 = *((char*)(0x200000)) ;
  8002d7:	b8 00 00 20 00       	mov    $0x200000,%eax
  8002dc:	8a 00                	mov    (%eax),%al
  8002de:	88 45 93             	mov    %al,-0x6d(%ebp)
	char garbage2 = *((char*)(0x201000)) ;
  8002e1:	b8 00 10 20 00       	mov    $0x201000,%eax
  8002e6:	8a 00                	mov    (%eax),%al
  8002e8:	88 45 92             	mov    %al,-0x6e(%ebp)

	//Writing (Modified)
	char *c = ((char*)(0x202000)) ;
  8002eb:	c7 45 8c 00 20 20 00 	movl   $0x202000,-0x74(%ebp)
	*c = 'A';
  8002f2:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8002f5:	c6 00 41             	movb   $0x41,(%eax)

	//Clear the FFL
	sys_clear_ffl();
  8002f8:	e8 76 15 00 00       	call   801873 <sys_clear_ffl>

	//Writing (Modified) (3 frames should be allocated (stack page, mem table, page file table)
	*ptr3 = 255 ;
  8002fd:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800300:	c6 00 ff             	movb   $0xff,(%eax)

	//Check the written values
	if (*c != 'A') panic("test failed!");
  800303:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800306:	8a 00                	mov    (%eax),%al
  800308:	3c 41                	cmp    $0x41,%al
  80030a:	74 14                	je     800320 <_main+0x2e8>
  80030c:	83 ec 04             	sub    $0x4,%esp
  80030f:	68 5b 1f 80 00       	push   $0x801f5b
  800314:	6a 30                	push   $0x30
  800316:	68 f2 1e 80 00       	push   $0x801ef2
  80031b:	e8 91 02 00 00       	call   8005b1 <_panic>
	if (*ptr3 != 255) panic("test failed!");
  800320:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800323:	8a 00                	mov    (%eax),%al
  800325:	3c ff                	cmp    $0xff,%al
  800327:	74 14                	je     80033d <_main+0x305>
  800329:	83 ec 04             	sub    $0x4,%esp
  80032c:	68 5b 1f 80 00       	push   $0x801f5b
  800331:	6a 31                	push   $0x31
  800333:	68 f2 1e 80 00       	push   $0x801ef2
  800338:	e8 74 02 00 00       	call   8005b1 <_panic>

	//Check the WS and values
	int i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  80033d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800344:	e9 f7 00 00 00       	jmp    800440 <_main+0x408>
	{
		//There should be two empty locations that are freed for the two tables (mem table and page file table)
		int numOfEmptyLocs = 0 ;
  800349:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
		for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  800350:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  800357:	eb 20                	jmp    800379 <_main+0x341>
		{
			if (myEnv->__uptr_pws[i].empty)
  800359:	a1 20 30 80 00       	mov    0x803020,%eax
  80035e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800364:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800367:	c1 e2 04             	shl    $0x4,%edx
  80036a:	01 d0                	add    %edx,%eax
  80036c:	8a 40 04             	mov    0x4(%eax),%al
  80036f:	84 c0                	test   %al,%al
  800371:	74 03                	je     800376 <_main+0x33e>
				numOfEmptyLocs++ ;
  800373:	ff 45 e0             	incl   -0x20(%ebp)
	int i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
	{
		//There should be two empty locations that are freed for the two tables (mem table and page file table)
		int numOfEmptyLocs = 0 ;
		for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  800376:	ff 45 dc             	incl   -0x24(%ebp)
  800379:	a1 20 30 80 00       	mov    0x803020,%eax
  80037e:	8b 50 74             	mov    0x74(%eax),%edx
  800381:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800384:	39 c2                	cmp    %eax,%edx
  800386:	77 d1                	ja     800359 <_main+0x321>
		{
			if (myEnv->__uptr_pws[i].empty)
				numOfEmptyLocs++ ;
		}
		if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");
  800388:	83 7d e0 02          	cmpl   $0x2,-0x20(%ebp)
  80038c:	74 14                	je     8003a2 <_main+0x36a>
  80038e:	83 ec 04             	sub    $0x4,%esp
  800391:	68 68 1f 80 00       	push   $0x801f68
  800396:	6a 3e                	push   $0x3e
  800398:	68 f2 1e 80 00       	push   $0x801ef2
  80039d:	e8 0f 02 00 00       	call   8005b1 <_panic>

		uint32 expectedAddresses[9] = {0x800000,0x801000,0x802000,0x803000,0x202000,0x204000,0x205000,0xee7fe000,0xeebfd000} ;
  8003a2:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
  8003a8:	bb 00 20 80 00       	mov    $0x802000,%ebx
  8003ad:	ba 09 00 00 00       	mov    $0x9,%edx
  8003b2:	89 c7                	mov    %eax,%edi
  8003b4:	89 de                	mov    %ebx,%esi
  8003b6:	89 d1                	mov    %edx,%ecx
  8003b8:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		int numOfFoundedAddresses = 0;
  8003ba:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (int j = 0; j < 9; j++)
  8003c1:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8003c8:	eb 53                	jmp    80041d <_main+0x3e5>
		{
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8003ca:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8003d1:	eb 38                	jmp    80040b <_main+0x3d3>
			{
				if (ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == expectedAddresses[j])
  8003d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003de:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8003e1:	c1 e2 04             	shl    $0x4,%edx
  8003e4:	01 d0                	add    %edx,%eax
  8003e6:	8b 00                	mov    (%eax),%eax
  8003e8:	89 45 88             	mov    %eax,-0x78(%ebp)
  8003eb:	8b 45 88             	mov    -0x78(%ebp),%eax
  8003ee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003f3:	89 c2                	mov    %eax,%edx
  8003f5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003f8:	8b 84 85 64 ff ff ff 	mov    -0x9c(%ebp,%eax,4),%eax
  8003ff:	39 c2                	cmp    %eax,%edx
  800401:	75 05                	jne    800408 <_main+0x3d0>
				{
					numOfFoundedAddresses++;
  800403:	ff 45 d8             	incl   -0x28(%ebp)
					break;
  800406:	eb 12                	jmp    80041a <_main+0x3e2>

		uint32 expectedAddresses[9] = {0x800000,0x801000,0x802000,0x803000,0x202000,0x204000,0x205000,0xee7fe000,0xeebfd000} ;
		int numOfFoundedAddresses = 0;
		for (int j = 0; j < 9; j++)
		{
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  800408:	ff 45 d0             	incl   -0x30(%ebp)
  80040b:	a1 20 30 80 00       	mov    0x803020,%eax
  800410:	8b 50 74             	mov    0x74(%eax),%edx
  800413:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800416:	39 c2                	cmp    %eax,%edx
  800418:	77 b9                	ja     8003d3 <_main+0x39b>
		}
		if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");

		uint32 expectedAddresses[9] = {0x800000,0x801000,0x802000,0x803000,0x202000,0x204000,0x205000,0xee7fe000,0xeebfd000} ;
		int numOfFoundedAddresses = 0;
		for (int j = 0; j < 9; j++)
  80041a:	ff 45 d4             	incl   -0x2c(%ebp)
  80041d:	83 7d d4 08          	cmpl   $0x8,-0x2c(%ebp)
  800421:	7e a7                	jle    8003ca <_main+0x392>
					numOfFoundedAddresses++;
					break;
				}
			}
		}
		if (numOfFoundedAddresses != 9) panic("test failed! either wrong victim or victim is not removed from WS");
  800423:	83 7d d8 09          	cmpl   $0x9,-0x28(%ebp)
  800427:	74 14                	je     80043d <_main+0x405>
  800429:	83 ec 04             	sub    $0x4,%esp
  80042c:	68 68 1f 80 00       	push   $0x801f68
  800431:	6a 4d                	push   $0x4d
  800433:	68 f2 1e 80 00       	push   $0x801ef2
  800438:	e8 74 01 00 00       	call   8005b1 <_panic>
	if (*c != 'A') panic("test failed!");
	if (*ptr3 != 255) panic("test failed!");

	//Check the WS and values
	int i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  80043d:	ff 45 e4             	incl   -0x1c(%ebp)
  800440:	a1 20 30 80 00       	mov    0x803020,%eax
  800445:	8b 50 74             	mov    0x74(%eax),%edx
  800448:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80044b:	39 c2                	cmp    %eax,%edx
  80044d:	0f 87 f6 fe ff ff    	ja     800349 <_main+0x311>
		}
		if (numOfFoundedAddresses != 9) panic("test failed! either wrong victim or victim is not removed from WS");

	}

	cprintf("Congratulations!! test modification is completed successfully.\n");
  800453:	83 ec 0c             	sub    $0xc,%esp
  800456:	68 ac 1f 80 00       	push   $0x801fac
  80045b:	e8 f3 03 00 00       	call   800853 <cprintf>
  800460:	83 c4 10             	add    $0x10,%esp
	return;
  800463:	90                   	nop
}
  800464:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800467:	5b                   	pop    %ebx
  800468:	5e                   	pop    %esi
  800469:	5f                   	pop    %edi
  80046a:	5d                   	pop    %ebp
  80046b:	c3                   	ret    

0080046c <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80046c:	55                   	push   %ebp
  80046d:	89 e5                	mov    %esp,%ebp
  80046f:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800472:	e8 07 12 00 00       	call   80167e <sys_getenvindex>
  800477:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80047a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80047d:	89 d0                	mov    %edx,%eax
  80047f:	c1 e0 03             	shl    $0x3,%eax
  800482:	01 d0                	add    %edx,%eax
  800484:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80048b:	01 c8                	add    %ecx,%eax
  80048d:	01 c0                	add    %eax,%eax
  80048f:	01 d0                	add    %edx,%eax
  800491:	01 c0                	add    %eax,%eax
  800493:	01 d0                	add    %edx,%eax
  800495:	89 c2                	mov    %eax,%edx
  800497:	c1 e2 05             	shl    $0x5,%edx
  80049a:	29 c2                	sub    %eax,%edx
  80049c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8004a3:	89 c2                	mov    %eax,%edx
  8004a5:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8004ab:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8004b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b5:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8004bb:	84 c0                	test   %al,%al
  8004bd:	74 0f                	je     8004ce <libmain+0x62>
		binaryname = myEnv->prog_name;
  8004bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c4:	05 40 3c 01 00       	add    $0x13c40,%eax
  8004c9:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8004ce:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8004d2:	7e 0a                	jle    8004de <libmain+0x72>
		binaryname = argv[0];
  8004d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d7:	8b 00                	mov    (%eax),%eax
  8004d9:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8004de:	83 ec 08             	sub    $0x8,%esp
  8004e1:	ff 75 0c             	pushl  0xc(%ebp)
  8004e4:	ff 75 08             	pushl  0x8(%ebp)
  8004e7:	e8 4c fb ff ff       	call   800038 <_main>
  8004ec:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8004ef:	e8 25 13 00 00       	call   801819 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8004f4:	83 ec 0c             	sub    $0xc,%esp
  8004f7:	68 3c 20 80 00       	push   $0x80203c
  8004fc:	e8 52 03 00 00       	call   800853 <cprintf>
  800501:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800504:	a1 20 30 80 00       	mov    0x803020,%eax
  800509:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80050f:	a1 20 30 80 00       	mov    0x803020,%eax
  800514:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80051a:	83 ec 04             	sub    $0x4,%esp
  80051d:	52                   	push   %edx
  80051e:	50                   	push   %eax
  80051f:	68 64 20 80 00       	push   $0x802064
  800524:	e8 2a 03 00 00       	call   800853 <cprintf>
  800529:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80052c:	a1 20 30 80 00       	mov    0x803020,%eax
  800531:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800537:	a1 20 30 80 00       	mov    0x803020,%eax
  80053c:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800542:	83 ec 04             	sub    $0x4,%esp
  800545:	52                   	push   %edx
  800546:	50                   	push   %eax
  800547:	68 8c 20 80 00       	push   $0x80208c
  80054c:	e8 02 03 00 00       	call   800853 <cprintf>
  800551:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800554:	a1 20 30 80 00       	mov    0x803020,%eax
  800559:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80055f:	83 ec 08             	sub    $0x8,%esp
  800562:	50                   	push   %eax
  800563:	68 cd 20 80 00       	push   $0x8020cd
  800568:	e8 e6 02 00 00       	call   800853 <cprintf>
  80056d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800570:	83 ec 0c             	sub    $0xc,%esp
  800573:	68 3c 20 80 00       	push   $0x80203c
  800578:	e8 d6 02 00 00       	call   800853 <cprintf>
  80057d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800580:	e8 ae 12 00 00       	call   801833 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800585:	e8 19 00 00 00       	call   8005a3 <exit>
}
  80058a:	90                   	nop
  80058b:	c9                   	leave  
  80058c:	c3                   	ret    

0080058d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80058d:	55                   	push   %ebp
  80058e:	89 e5                	mov    %esp,%ebp
  800590:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800593:	83 ec 0c             	sub    $0xc,%esp
  800596:	6a 00                	push   $0x0
  800598:	e8 ad 10 00 00       	call   80164a <sys_env_destroy>
  80059d:	83 c4 10             	add    $0x10,%esp
}
  8005a0:	90                   	nop
  8005a1:	c9                   	leave  
  8005a2:	c3                   	ret    

008005a3 <exit>:

void
exit(void)
{
  8005a3:	55                   	push   %ebp
  8005a4:	89 e5                	mov    %esp,%ebp
  8005a6:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8005a9:	e8 02 11 00 00       	call   8016b0 <sys_env_exit>
}
  8005ae:	90                   	nop
  8005af:	c9                   	leave  
  8005b0:	c3                   	ret    

008005b1 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8005b1:	55                   	push   %ebp
  8005b2:	89 e5                	mov    %esp,%ebp
  8005b4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8005b7:	8d 45 10             	lea    0x10(%ebp),%eax
  8005ba:	83 c0 04             	add    $0x4,%eax
  8005bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8005c0:	a1 18 31 80 00       	mov    0x803118,%eax
  8005c5:	85 c0                	test   %eax,%eax
  8005c7:	74 16                	je     8005df <_panic+0x2e>
		cprintf("%s: ", argv0);
  8005c9:	a1 18 31 80 00       	mov    0x803118,%eax
  8005ce:	83 ec 08             	sub    $0x8,%esp
  8005d1:	50                   	push   %eax
  8005d2:	68 e4 20 80 00       	push   $0x8020e4
  8005d7:	e8 77 02 00 00       	call   800853 <cprintf>
  8005dc:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8005df:	a1 00 30 80 00       	mov    0x803000,%eax
  8005e4:	ff 75 0c             	pushl  0xc(%ebp)
  8005e7:	ff 75 08             	pushl  0x8(%ebp)
  8005ea:	50                   	push   %eax
  8005eb:	68 e9 20 80 00       	push   $0x8020e9
  8005f0:	e8 5e 02 00 00       	call   800853 <cprintf>
  8005f5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8005f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8005fb:	83 ec 08             	sub    $0x8,%esp
  8005fe:	ff 75 f4             	pushl  -0xc(%ebp)
  800601:	50                   	push   %eax
  800602:	e8 e1 01 00 00       	call   8007e8 <vcprintf>
  800607:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80060a:	83 ec 08             	sub    $0x8,%esp
  80060d:	6a 00                	push   $0x0
  80060f:	68 05 21 80 00       	push   $0x802105
  800614:	e8 cf 01 00 00       	call   8007e8 <vcprintf>
  800619:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80061c:	e8 82 ff ff ff       	call   8005a3 <exit>

	// should not return here
	while (1) ;
  800621:	eb fe                	jmp    800621 <_panic+0x70>

00800623 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800623:	55                   	push   %ebp
  800624:	89 e5                	mov    %esp,%ebp
  800626:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800629:	a1 20 30 80 00       	mov    0x803020,%eax
  80062e:	8b 50 74             	mov    0x74(%eax),%edx
  800631:	8b 45 0c             	mov    0xc(%ebp),%eax
  800634:	39 c2                	cmp    %eax,%edx
  800636:	74 14                	je     80064c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800638:	83 ec 04             	sub    $0x4,%esp
  80063b:	68 08 21 80 00       	push   $0x802108
  800640:	6a 26                	push   $0x26
  800642:	68 54 21 80 00       	push   $0x802154
  800647:	e8 65 ff ff ff       	call   8005b1 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80064c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800653:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80065a:	e9 b6 00 00 00       	jmp    800715 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80065f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800662:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800669:	8b 45 08             	mov    0x8(%ebp),%eax
  80066c:	01 d0                	add    %edx,%eax
  80066e:	8b 00                	mov    (%eax),%eax
  800670:	85 c0                	test   %eax,%eax
  800672:	75 08                	jne    80067c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800674:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800677:	e9 96 00 00 00       	jmp    800712 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80067c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800683:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80068a:	eb 5d                	jmp    8006e9 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80068c:	a1 20 30 80 00       	mov    0x803020,%eax
  800691:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800697:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80069a:	c1 e2 04             	shl    $0x4,%edx
  80069d:	01 d0                	add    %edx,%eax
  80069f:	8a 40 04             	mov    0x4(%eax),%al
  8006a2:	84 c0                	test   %al,%al
  8006a4:	75 40                	jne    8006e6 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8006a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ab:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8006b1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006b4:	c1 e2 04             	shl    $0x4,%edx
  8006b7:	01 d0                	add    %edx,%eax
  8006b9:	8b 00                	mov    (%eax),%eax
  8006bb:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8006be:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006c1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006c6:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8006c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006cb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8006d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d5:	01 c8                	add    %ecx,%eax
  8006d7:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8006d9:	39 c2                	cmp    %eax,%edx
  8006db:	75 09                	jne    8006e6 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8006dd:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8006e4:	eb 12                	jmp    8006f8 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006e6:	ff 45 e8             	incl   -0x18(%ebp)
  8006e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ee:	8b 50 74             	mov    0x74(%eax),%edx
  8006f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006f4:	39 c2                	cmp    %eax,%edx
  8006f6:	77 94                	ja     80068c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8006f8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8006fc:	75 14                	jne    800712 <CheckWSWithoutLastIndex+0xef>
			panic(
  8006fe:	83 ec 04             	sub    $0x4,%esp
  800701:	68 60 21 80 00       	push   $0x802160
  800706:	6a 3a                	push   $0x3a
  800708:	68 54 21 80 00       	push   $0x802154
  80070d:	e8 9f fe ff ff       	call   8005b1 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800712:	ff 45 f0             	incl   -0x10(%ebp)
  800715:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800718:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80071b:	0f 8c 3e ff ff ff    	jl     80065f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800721:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800728:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80072f:	eb 20                	jmp    800751 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800731:	a1 20 30 80 00       	mov    0x803020,%eax
  800736:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80073c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80073f:	c1 e2 04             	shl    $0x4,%edx
  800742:	01 d0                	add    %edx,%eax
  800744:	8a 40 04             	mov    0x4(%eax),%al
  800747:	3c 01                	cmp    $0x1,%al
  800749:	75 03                	jne    80074e <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80074b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80074e:	ff 45 e0             	incl   -0x20(%ebp)
  800751:	a1 20 30 80 00       	mov    0x803020,%eax
  800756:	8b 50 74             	mov    0x74(%eax),%edx
  800759:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80075c:	39 c2                	cmp    %eax,%edx
  80075e:	77 d1                	ja     800731 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800760:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800763:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800766:	74 14                	je     80077c <CheckWSWithoutLastIndex+0x159>
		panic(
  800768:	83 ec 04             	sub    $0x4,%esp
  80076b:	68 b4 21 80 00       	push   $0x8021b4
  800770:	6a 44                	push   $0x44
  800772:	68 54 21 80 00       	push   $0x802154
  800777:	e8 35 fe ff ff       	call   8005b1 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80077c:	90                   	nop
  80077d:	c9                   	leave  
  80077e:	c3                   	ret    

0080077f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80077f:	55                   	push   %ebp
  800780:	89 e5                	mov    %esp,%ebp
  800782:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800785:	8b 45 0c             	mov    0xc(%ebp),%eax
  800788:	8b 00                	mov    (%eax),%eax
  80078a:	8d 48 01             	lea    0x1(%eax),%ecx
  80078d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800790:	89 0a                	mov    %ecx,(%edx)
  800792:	8b 55 08             	mov    0x8(%ebp),%edx
  800795:	88 d1                	mov    %dl,%cl
  800797:	8b 55 0c             	mov    0xc(%ebp),%edx
  80079a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80079e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a1:	8b 00                	mov    (%eax),%eax
  8007a3:	3d ff 00 00 00       	cmp    $0xff,%eax
  8007a8:	75 2c                	jne    8007d6 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8007aa:	a0 24 30 80 00       	mov    0x803024,%al
  8007af:	0f b6 c0             	movzbl %al,%eax
  8007b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007b5:	8b 12                	mov    (%edx),%edx
  8007b7:	89 d1                	mov    %edx,%ecx
  8007b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007bc:	83 c2 08             	add    $0x8,%edx
  8007bf:	83 ec 04             	sub    $0x4,%esp
  8007c2:	50                   	push   %eax
  8007c3:	51                   	push   %ecx
  8007c4:	52                   	push   %edx
  8007c5:	e8 3e 0e 00 00       	call   801608 <sys_cputs>
  8007ca:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8007cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8007d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007d9:	8b 40 04             	mov    0x4(%eax),%eax
  8007dc:	8d 50 01             	lea    0x1(%eax),%edx
  8007df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e2:	89 50 04             	mov    %edx,0x4(%eax)
}
  8007e5:	90                   	nop
  8007e6:	c9                   	leave  
  8007e7:	c3                   	ret    

008007e8 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8007e8:	55                   	push   %ebp
  8007e9:	89 e5                	mov    %esp,%ebp
  8007eb:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8007f1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8007f8:	00 00 00 
	b.cnt = 0;
  8007fb:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800802:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800805:	ff 75 0c             	pushl  0xc(%ebp)
  800808:	ff 75 08             	pushl  0x8(%ebp)
  80080b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800811:	50                   	push   %eax
  800812:	68 7f 07 80 00       	push   $0x80077f
  800817:	e8 11 02 00 00       	call   800a2d <vprintfmt>
  80081c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80081f:	a0 24 30 80 00       	mov    0x803024,%al
  800824:	0f b6 c0             	movzbl %al,%eax
  800827:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80082d:	83 ec 04             	sub    $0x4,%esp
  800830:	50                   	push   %eax
  800831:	52                   	push   %edx
  800832:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800838:	83 c0 08             	add    $0x8,%eax
  80083b:	50                   	push   %eax
  80083c:	e8 c7 0d 00 00       	call   801608 <sys_cputs>
  800841:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800844:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80084b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800851:	c9                   	leave  
  800852:	c3                   	ret    

00800853 <cprintf>:

int cprintf(const char *fmt, ...) {
  800853:	55                   	push   %ebp
  800854:	89 e5                	mov    %esp,%ebp
  800856:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800859:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800860:	8d 45 0c             	lea    0xc(%ebp),%eax
  800863:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800866:	8b 45 08             	mov    0x8(%ebp),%eax
  800869:	83 ec 08             	sub    $0x8,%esp
  80086c:	ff 75 f4             	pushl  -0xc(%ebp)
  80086f:	50                   	push   %eax
  800870:	e8 73 ff ff ff       	call   8007e8 <vcprintf>
  800875:	83 c4 10             	add    $0x10,%esp
  800878:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80087b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80087e:	c9                   	leave  
  80087f:	c3                   	ret    

00800880 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800880:	55                   	push   %ebp
  800881:	89 e5                	mov    %esp,%ebp
  800883:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800886:	e8 8e 0f 00 00       	call   801819 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80088b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80088e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800891:	8b 45 08             	mov    0x8(%ebp),%eax
  800894:	83 ec 08             	sub    $0x8,%esp
  800897:	ff 75 f4             	pushl  -0xc(%ebp)
  80089a:	50                   	push   %eax
  80089b:	e8 48 ff ff ff       	call   8007e8 <vcprintf>
  8008a0:	83 c4 10             	add    $0x10,%esp
  8008a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8008a6:	e8 88 0f 00 00       	call   801833 <sys_enable_interrupt>
	return cnt;
  8008ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008ae:	c9                   	leave  
  8008af:	c3                   	ret    

008008b0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8008b0:	55                   	push   %ebp
  8008b1:	89 e5                	mov    %esp,%ebp
  8008b3:	53                   	push   %ebx
  8008b4:	83 ec 14             	sub    $0x14,%esp
  8008b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8008c3:	8b 45 18             	mov    0x18(%ebp),%eax
  8008c6:	ba 00 00 00 00       	mov    $0x0,%edx
  8008cb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008ce:	77 55                	ja     800925 <printnum+0x75>
  8008d0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008d3:	72 05                	jb     8008da <printnum+0x2a>
  8008d5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8008d8:	77 4b                	ja     800925 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8008da:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8008dd:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8008e0:	8b 45 18             	mov    0x18(%ebp),%eax
  8008e3:	ba 00 00 00 00       	mov    $0x0,%edx
  8008e8:	52                   	push   %edx
  8008e9:	50                   	push   %eax
  8008ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ed:	ff 75 f0             	pushl  -0x10(%ebp)
  8008f0:	e8 47 13 00 00       	call   801c3c <__udivdi3>
  8008f5:	83 c4 10             	add    $0x10,%esp
  8008f8:	83 ec 04             	sub    $0x4,%esp
  8008fb:	ff 75 20             	pushl  0x20(%ebp)
  8008fe:	53                   	push   %ebx
  8008ff:	ff 75 18             	pushl  0x18(%ebp)
  800902:	52                   	push   %edx
  800903:	50                   	push   %eax
  800904:	ff 75 0c             	pushl  0xc(%ebp)
  800907:	ff 75 08             	pushl  0x8(%ebp)
  80090a:	e8 a1 ff ff ff       	call   8008b0 <printnum>
  80090f:	83 c4 20             	add    $0x20,%esp
  800912:	eb 1a                	jmp    80092e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800914:	83 ec 08             	sub    $0x8,%esp
  800917:	ff 75 0c             	pushl  0xc(%ebp)
  80091a:	ff 75 20             	pushl  0x20(%ebp)
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	ff d0                	call   *%eax
  800922:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800925:	ff 4d 1c             	decl   0x1c(%ebp)
  800928:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80092c:	7f e6                	jg     800914 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80092e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800931:	bb 00 00 00 00       	mov    $0x0,%ebx
  800936:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800939:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80093c:	53                   	push   %ebx
  80093d:	51                   	push   %ecx
  80093e:	52                   	push   %edx
  80093f:	50                   	push   %eax
  800940:	e8 07 14 00 00       	call   801d4c <__umoddi3>
  800945:	83 c4 10             	add    $0x10,%esp
  800948:	05 14 24 80 00       	add    $0x802414,%eax
  80094d:	8a 00                	mov    (%eax),%al
  80094f:	0f be c0             	movsbl %al,%eax
  800952:	83 ec 08             	sub    $0x8,%esp
  800955:	ff 75 0c             	pushl  0xc(%ebp)
  800958:	50                   	push   %eax
  800959:	8b 45 08             	mov    0x8(%ebp),%eax
  80095c:	ff d0                	call   *%eax
  80095e:	83 c4 10             	add    $0x10,%esp
}
  800961:	90                   	nop
  800962:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800965:	c9                   	leave  
  800966:	c3                   	ret    

00800967 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800967:	55                   	push   %ebp
  800968:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80096a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80096e:	7e 1c                	jle    80098c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	8b 00                	mov    (%eax),%eax
  800975:	8d 50 08             	lea    0x8(%eax),%edx
  800978:	8b 45 08             	mov    0x8(%ebp),%eax
  80097b:	89 10                	mov    %edx,(%eax)
  80097d:	8b 45 08             	mov    0x8(%ebp),%eax
  800980:	8b 00                	mov    (%eax),%eax
  800982:	83 e8 08             	sub    $0x8,%eax
  800985:	8b 50 04             	mov    0x4(%eax),%edx
  800988:	8b 00                	mov    (%eax),%eax
  80098a:	eb 40                	jmp    8009cc <getuint+0x65>
	else if (lflag)
  80098c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800990:	74 1e                	je     8009b0 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800992:	8b 45 08             	mov    0x8(%ebp),%eax
  800995:	8b 00                	mov    (%eax),%eax
  800997:	8d 50 04             	lea    0x4(%eax),%edx
  80099a:	8b 45 08             	mov    0x8(%ebp),%eax
  80099d:	89 10                	mov    %edx,(%eax)
  80099f:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a2:	8b 00                	mov    (%eax),%eax
  8009a4:	83 e8 04             	sub    $0x4,%eax
  8009a7:	8b 00                	mov    (%eax),%eax
  8009a9:	ba 00 00 00 00       	mov    $0x0,%edx
  8009ae:	eb 1c                	jmp    8009cc <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8009b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b3:	8b 00                	mov    (%eax),%eax
  8009b5:	8d 50 04             	lea    0x4(%eax),%edx
  8009b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bb:	89 10                	mov    %edx,(%eax)
  8009bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c0:	8b 00                	mov    (%eax),%eax
  8009c2:	83 e8 04             	sub    $0x4,%eax
  8009c5:	8b 00                	mov    (%eax),%eax
  8009c7:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8009cc:	5d                   	pop    %ebp
  8009cd:	c3                   	ret    

008009ce <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8009ce:	55                   	push   %ebp
  8009cf:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009d1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009d5:	7e 1c                	jle    8009f3 <getint+0x25>
		return va_arg(*ap, long long);
  8009d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009da:	8b 00                	mov    (%eax),%eax
  8009dc:	8d 50 08             	lea    0x8(%eax),%edx
  8009df:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e2:	89 10                	mov    %edx,(%eax)
  8009e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e7:	8b 00                	mov    (%eax),%eax
  8009e9:	83 e8 08             	sub    $0x8,%eax
  8009ec:	8b 50 04             	mov    0x4(%eax),%edx
  8009ef:	8b 00                	mov    (%eax),%eax
  8009f1:	eb 38                	jmp    800a2b <getint+0x5d>
	else if (lflag)
  8009f3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009f7:	74 1a                	je     800a13 <getint+0x45>
		return va_arg(*ap, long);
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	8b 00                	mov    (%eax),%eax
  8009fe:	8d 50 04             	lea    0x4(%eax),%edx
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	89 10                	mov    %edx,(%eax)
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	8b 00                	mov    (%eax),%eax
  800a0b:	83 e8 04             	sub    $0x4,%eax
  800a0e:	8b 00                	mov    (%eax),%eax
  800a10:	99                   	cltd   
  800a11:	eb 18                	jmp    800a2b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	8b 00                	mov    (%eax),%eax
  800a18:	8d 50 04             	lea    0x4(%eax),%edx
  800a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1e:	89 10                	mov    %edx,(%eax)
  800a20:	8b 45 08             	mov    0x8(%ebp),%eax
  800a23:	8b 00                	mov    (%eax),%eax
  800a25:	83 e8 04             	sub    $0x4,%eax
  800a28:	8b 00                	mov    (%eax),%eax
  800a2a:	99                   	cltd   
}
  800a2b:	5d                   	pop    %ebp
  800a2c:	c3                   	ret    

00800a2d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a2d:	55                   	push   %ebp
  800a2e:	89 e5                	mov    %esp,%ebp
  800a30:	56                   	push   %esi
  800a31:	53                   	push   %ebx
  800a32:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a35:	eb 17                	jmp    800a4e <vprintfmt+0x21>
			if (ch == '\0')
  800a37:	85 db                	test   %ebx,%ebx
  800a39:	0f 84 af 03 00 00    	je     800dee <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800a3f:	83 ec 08             	sub    $0x8,%esp
  800a42:	ff 75 0c             	pushl  0xc(%ebp)
  800a45:	53                   	push   %ebx
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	ff d0                	call   *%eax
  800a4b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800a51:	8d 50 01             	lea    0x1(%eax),%edx
  800a54:	89 55 10             	mov    %edx,0x10(%ebp)
  800a57:	8a 00                	mov    (%eax),%al
  800a59:	0f b6 d8             	movzbl %al,%ebx
  800a5c:	83 fb 25             	cmp    $0x25,%ebx
  800a5f:	75 d6                	jne    800a37 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a61:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a65:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a6c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a73:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a7a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a81:	8b 45 10             	mov    0x10(%ebp),%eax
  800a84:	8d 50 01             	lea    0x1(%eax),%edx
  800a87:	89 55 10             	mov    %edx,0x10(%ebp)
  800a8a:	8a 00                	mov    (%eax),%al
  800a8c:	0f b6 d8             	movzbl %al,%ebx
  800a8f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a92:	83 f8 55             	cmp    $0x55,%eax
  800a95:	0f 87 2b 03 00 00    	ja     800dc6 <vprintfmt+0x399>
  800a9b:	8b 04 85 38 24 80 00 	mov    0x802438(,%eax,4),%eax
  800aa2:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800aa4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800aa8:	eb d7                	jmp    800a81 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800aaa:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800aae:	eb d1                	jmp    800a81 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ab0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ab7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800aba:	89 d0                	mov    %edx,%eax
  800abc:	c1 e0 02             	shl    $0x2,%eax
  800abf:	01 d0                	add    %edx,%eax
  800ac1:	01 c0                	add    %eax,%eax
  800ac3:	01 d8                	add    %ebx,%eax
  800ac5:	83 e8 30             	sub    $0x30,%eax
  800ac8:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800acb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ace:	8a 00                	mov    (%eax),%al
  800ad0:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ad3:	83 fb 2f             	cmp    $0x2f,%ebx
  800ad6:	7e 3e                	jle    800b16 <vprintfmt+0xe9>
  800ad8:	83 fb 39             	cmp    $0x39,%ebx
  800adb:	7f 39                	jg     800b16 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800add:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ae0:	eb d5                	jmp    800ab7 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ae2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae5:	83 c0 04             	add    $0x4,%eax
  800ae8:	89 45 14             	mov    %eax,0x14(%ebp)
  800aeb:	8b 45 14             	mov    0x14(%ebp),%eax
  800aee:	83 e8 04             	sub    $0x4,%eax
  800af1:	8b 00                	mov    (%eax),%eax
  800af3:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800af6:	eb 1f                	jmp    800b17 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800af8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800afc:	79 83                	jns    800a81 <vprintfmt+0x54>
				width = 0;
  800afe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800b05:	e9 77 ff ff ff       	jmp    800a81 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800b0a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800b11:	e9 6b ff ff ff       	jmp    800a81 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800b16:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800b17:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b1b:	0f 89 60 ff ff ff    	jns    800a81 <vprintfmt+0x54>
				width = precision, precision = -1;
  800b21:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b27:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b2e:	e9 4e ff ff ff       	jmp    800a81 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b33:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b36:	e9 46 ff ff ff       	jmp    800a81 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b3b:	8b 45 14             	mov    0x14(%ebp),%eax
  800b3e:	83 c0 04             	add    $0x4,%eax
  800b41:	89 45 14             	mov    %eax,0x14(%ebp)
  800b44:	8b 45 14             	mov    0x14(%ebp),%eax
  800b47:	83 e8 04             	sub    $0x4,%eax
  800b4a:	8b 00                	mov    (%eax),%eax
  800b4c:	83 ec 08             	sub    $0x8,%esp
  800b4f:	ff 75 0c             	pushl  0xc(%ebp)
  800b52:	50                   	push   %eax
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
  800b56:	ff d0                	call   *%eax
  800b58:	83 c4 10             	add    $0x10,%esp
			break;
  800b5b:	e9 89 02 00 00       	jmp    800de9 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b60:	8b 45 14             	mov    0x14(%ebp),%eax
  800b63:	83 c0 04             	add    $0x4,%eax
  800b66:	89 45 14             	mov    %eax,0x14(%ebp)
  800b69:	8b 45 14             	mov    0x14(%ebp),%eax
  800b6c:	83 e8 04             	sub    $0x4,%eax
  800b6f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b71:	85 db                	test   %ebx,%ebx
  800b73:	79 02                	jns    800b77 <vprintfmt+0x14a>
				err = -err;
  800b75:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b77:	83 fb 64             	cmp    $0x64,%ebx
  800b7a:	7f 0b                	jg     800b87 <vprintfmt+0x15a>
  800b7c:	8b 34 9d 80 22 80 00 	mov    0x802280(,%ebx,4),%esi
  800b83:	85 f6                	test   %esi,%esi
  800b85:	75 19                	jne    800ba0 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b87:	53                   	push   %ebx
  800b88:	68 25 24 80 00       	push   $0x802425
  800b8d:	ff 75 0c             	pushl  0xc(%ebp)
  800b90:	ff 75 08             	pushl  0x8(%ebp)
  800b93:	e8 5e 02 00 00       	call   800df6 <printfmt>
  800b98:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b9b:	e9 49 02 00 00       	jmp    800de9 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ba0:	56                   	push   %esi
  800ba1:	68 2e 24 80 00       	push   $0x80242e
  800ba6:	ff 75 0c             	pushl  0xc(%ebp)
  800ba9:	ff 75 08             	pushl  0x8(%ebp)
  800bac:	e8 45 02 00 00       	call   800df6 <printfmt>
  800bb1:	83 c4 10             	add    $0x10,%esp
			break;
  800bb4:	e9 30 02 00 00       	jmp    800de9 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800bb9:	8b 45 14             	mov    0x14(%ebp),%eax
  800bbc:	83 c0 04             	add    $0x4,%eax
  800bbf:	89 45 14             	mov    %eax,0x14(%ebp)
  800bc2:	8b 45 14             	mov    0x14(%ebp),%eax
  800bc5:	83 e8 04             	sub    $0x4,%eax
  800bc8:	8b 30                	mov    (%eax),%esi
  800bca:	85 f6                	test   %esi,%esi
  800bcc:	75 05                	jne    800bd3 <vprintfmt+0x1a6>
				p = "(null)";
  800bce:	be 31 24 80 00       	mov    $0x802431,%esi
			if (width > 0 && padc != '-')
  800bd3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bd7:	7e 6d                	jle    800c46 <vprintfmt+0x219>
  800bd9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800bdd:	74 67                	je     800c46 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800bdf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800be2:	83 ec 08             	sub    $0x8,%esp
  800be5:	50                   	push   %eax
  800be6:	56                   	push   %esi
  800be7:	e8 0c 03 00 00       	call   800ef8 <strnlen>
  800bec:	83 c4 10             	add    $0x10,%esp
  800bef:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800bf2:	eb 16                	jmp    800c0a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bf4:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bf8:	83 ec 08             	sub    $0x8,%esp
  800bfb:	ff 75 0c             	pushl  0xc(%ebp)
  800bfe:	50                   	push   %eax
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
  800c02:	ff d0                	call   *%eax
  800c04:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800c07:	ff 4d e4             	decl   -0x1c(%ebp)
  800c0a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c0e:	7f e4                	jg     800bf4 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c10:	eb 34                	jmp    800c46 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800c12:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800c16:	74 1c                	je     800c34 <vprintfmt+0x207>
  800c18:	83 fb 1f             	cmp    $0x1f,%ebx
  800c1b:	7e 05                	jle    800c22 <vprintfmt+0x1f5>
  800c1d:	83 fb 7e             	cmp    $0x7e,%ebx
  800c20:	7e 12                	jle    800c34 <vprintfmt+0x207>
					putch('?', putdat);
  800c22:	83 ec 08             	sub    $0x8,%esp
  800c25:	ff 75 0c             	pushl  0xc(%ebp)
  800c28:	6a 3f                	push   $0x3f
  800c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2d:	ff d0                	call   *%eax
  800c2f:	83 c4 10             	add    $0x10,%esp
  800c32:	eb 0f                	jmp    800c43 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c34:	83 ec 08             	sub    $0x8,%esp
  800c37:	ff 75 0c             	pushl  0xc(%ebp)
  800c3a:	53                   	push   %ebx
  800c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3e:	ff d0                	call   *%eax
  800c40:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c43:	ff 4d e4             	decl   -0x1c(%ebp)
  800c46:	89 f0                	mov    %esi,%eax
  800c48:	8d 70 01             	lea    0x1(%eax),%esi
  800c4b:	8a 00                	mov    (%eax),%al
  800c4d:	0f be d8             	movsbl %al,%ebx
  800c50:	85 db                	test   %ebx,%ebx
  800c52:	74 24                	je     800c78 <vprintfmt+0x24b>
  800c54:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c58:	78 b8                	js     800c12 <vprintfmt+0x1e5>
  800c5a:	ff 4d e0             	decl   -0x20(%ebp)
  800c5d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c61:	79 af                	jns    800c12 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c63:	eb 13                	jmp    800c78 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c65:	83 ec 08             	sub    $0x8,%esp
  800c68:	ff 75 0c             	pushl  0xc(%ebp)
  800c6b:	6a 20                	push   $0x20
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	ff d0                	call   *%eax
  800c72:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c75:	ff 4d e4             	decl   -0x1c(%ebp)
  800c78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c7c:	7f e7                	jg     800c65 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c7e:	e9 66 01 00 00       	jmp    800de9 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c83:	83 ec 08             	sub    $0x8,%esp
  800c86:	ff 75 e8             	pushl  -0x18(%ebp)
  800c89:	8d 45 14             	lea    0x14(%ebp),%eax
  800c8c:	50                   	push   %eax
  800c8d:	e8 3c fd ff ff       	call   8009ce <getint>
  800c92:	83 c4 10             	add    $0x10,%esp
  800c95:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c98:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ca1:	85 d2                	test   %edx,%edx
  800ca3:	79 23                	jns    800cc8 <vprintfmt+0x29b>
				putch('-', putdat);
  800ca5:	83 ec 08             	sub    $0x8,%esp
  800ca8:	ff 75 0c             	pushl  0xc(%ebp)
  800cab:	6a 2d                	push   $0x2d
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	ff d0                	call   *%eax
  800cb2:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800cb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cbb:	f7 d8                	neg    %eax
  800cbd:	83 d2 00             	adc    $0x0,%edx
  800cc0:	f7 da                	neg    %edx
  800cc2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800cc8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ccf:	e9 bc 00 00 00       	jmp    800d90 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800cd4:	83 ec 08             	sub    $0x8,%esp
  800cd7:	ff 75 e8             	pushl  -0x18(%ebp)
  800cda:	8d 45 14             	lea    0x14(%ebp),%eax
  800cdd:	50                   	push   %eax
  800cde:	e8 84 fc ff ff       	call   800967 <getuint>
  800ce3:	83 c4 10             	add    $0x10,%esp
  800ce6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ce9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800cec:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cf3:	e9 98 00 00 00       	jmp    800d90 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cf8:	83 ec 08             	sub    $0x8,%esp
  800cfb:	ff 75 0c             	pushl  0xc(%ebp)
  800cfe:	6a 58                	push   $0x58
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	ff d0                	call   *%eax
  800d05:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d08:	83 ec 08             	sub    $0x8,%esp
  800d0b:	ff 75 0c             	pushl  0xc(%ebp)
  800d0e:	6a 58                	push   $0x58
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	ff d0                	call   *%eax
  800d15:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d18:	83 ec 08             	sub    $0x8,%esp
  800d1b:	ff 75 0c             	pushl  0xc(%ebp)
  800d1e:	6a 58                	push   $0x58
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	ff d0                	call   *%eax
  800d25:	83 c4 10             	add    $0x10,%esp
			break;
  800d28:	e9 bc 00 00 00       	jmp    800de9 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800d2d:	83 ec 08             	sub    $0x8,%esp
  800d30:	ff 75 0c             	pushl  0xc(%ebp)
  800d33:	6a 30                	push   $0x30
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	ff d0                	call   *%eax
  800d3a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d3d:	83 ec 08             	sub    $0x8,%esp
  800d40:	ff 75 0c             	pushl  0xc(%ebp)
  800d43:	6a 78                	push   $0x78
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	ff d0                	call   *%eax
  800d4a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d4d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d50:	83 c0 04             	add    $0x4,%eax
  800d53:	89 45 14             	mov    %eax,0x14(%ebp)
  800d56:	8b 45 14             	mov    0x14(%ebp),%eax
  800d59:	83 e8 04             	sub    $0x4,%eax
  800d5c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d61:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d68:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d6f:	eb 1f                	jmp    800d90 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d71:	83 ec 08             	sub    $0x8,%esp
  800d74:	ff 75 e8             	pushl  -0x18(%ebp)
  800d77:	8d 45 14             	lea    0x14(%ebp),%eax
  800d7a:	50                   	push   %eax
  800d7b:	e8 e7 fb ff ff       	call   800967 <getuint>
  800d80:	83 c4 10             	add    $0x10,%esp
  800d83:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d86:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d89:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d90:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d94:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d97:	83 ec 04             	sub    $0x4,%esp
  800d9a:	52                   	push   %edx
  800d9b:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d9e:	50                   	push   %eax
  800d9f:	ff 75 f4             	pushl  -0xc(%ebp)
  800da2:	ff 75 f0             	pushl  -0x10(%ebp)
  800da5:	ff 75 0c             	pushl  0xc(%ebp)
  800da8:	ff 75 08             	pushl  0x8(%ebp)
  800dab:	e8 00 fb ff ff       	call   8008b0 <printnum>
  800db0:	83 c4 20             	add    $0x20,%esp
			break;
  800db3:	eb 34                	jmp    800de9 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800db5:	83 ec 08             	sub    $0x8,%esp
  800db8:	ff 75 0c             	pushl  0xc(%ebp)
  800dbb:	53                   	push   %ebx
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbf:	ff d0                	call   *%eax
  800dc1:	83 c4 10             	add    $0x10,%esp
			break;
  800dc4:	eb 23                	jmp    800de9 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800dc6:	83 ec 08             	sub    $0x8,%esp
  800dc9:	ff 75 0c             	pushl  0xc(%ebp)
  800dcc:	6a 25                	push   $0x25
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	ff d0                	call   *%eax
  800dd3:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800dd6:	ff 4d 10             	decl   0x10(%ebp)
  800dd9:	eb 03                	jmp    800dde <vprintfmt+0x3b1>
  800ddb:	ff 4d 10             	decl   0x10(%ebp)
  800dde:	8b 45 10             	mov    0x10(%ebp),%eax
  800de1:	48                   	dec    %eax
  800de2:	8a 00                	mov    (%eax),%al
  800de4:	3c 25                	cmp    $0x25,%al
  800de6:	75 f3                	jne    800ddb <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800de8:	90                   	nop
		}
	}
  800de9:	e9 47 fc ff ff       	jmp    800a35 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800dee:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800def:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800df2:	5b                   	pop    %ebx
  800df3:	5e                   	pop    %esi
  800df4:	5d                   	pop    %ebp
  800df5:	c3                   	ret    

00800df6 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800df6:	55                   	push   %ebp
  800df7:	89 e5                	mov    %esp,%ebp
  800df9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800dfc:	8d 45 10             	lea    0x10(%ebp),%eax
  800dff:	83 c0 04             	add    $0x4,%eax
  800e02:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800e05:	8b 45 10             	mov    0x10(%ebp),%eax
  800e08:	ff 75 f4             	pushl  -0xc(%ebp)
  800e0b:	50                   	push   %eax
  800e0c:	ff 75 0c             	pushl  0xc(%ebp)
  800e0f:	ff 75 08             	pushl  0x8(%ebp)
  800e12:	e8 16 fc ff ff       	call   800a2d <vprintfmt>
  800e17:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800e1a:	90                   	nop
  800e1b:	c9                   	leave  
  800e1c:	c3                   	ret    

00800e1d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800e1d:	55                   	push   %ebp
  800e1e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800e20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e23:	8b 40 08             	mov    0x8(%eax),%eax
  800e26:	8d 50 01             	lea    0x1(%eax),%edx
  800e29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e32:	8b 10                	mov    (%eax),%edx
  800e34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e37:	8b 40 04             	mov    0x4(%eax),%eax
  800e3a:	39 c2                	cmp    %eax,%edx
  800e3c:	73 12                	jae    800e50 <sprintputch+0x33>
		*b->buf++ = ch;
  800e3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e41:	8b 00                	mov    (%eax),%eax
  800e43:	8d 48 01             	lea    0x1(%eax),%ecx
  800e46:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e49:	89 0a                	mov    %ecx,(%edx)
  800e4b:	8b 55 08             	mov    0x8(%ebp),%edx
  800e4e:	88 10                	mov    %dl,(%eax)
}
  800e50:	90                   	nop
  800e51:	5d                   	pop    %ebp
  800e52:	c3                   	ret    

00800e53 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e53:	55                   	push   %ebp
  800e54:	89 e5                	mov    %esp,%ebp
  800e56:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e59:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e62:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	01 d0                	add    %edx,%eax
  800e6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e6d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e74:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e78:	74 06                	je     800e80 <vsnprintf+0x2d>
  800e7a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e7e:	7f 07                	jg     800e87 <vsnprintf+0x34>
		return -E_INVAL;
  800e80:	b8 03 00 00 00       	mov    $0x3,%eax
  800e85:	eb 20                	jmp    800ea7 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e87:	ff 75 14             	pushl  0x14(%ebp)
  800e8a:	ff 75 10             	pushl  0x10(%ebp)
  800e8d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e90:	50                   	push   %eax
  800e91:	68 1d 0e 80 00       	push   $0x800e1d
  800e96:	e8 92 fb ff ff       	call   800a2d <vprintfmt>
  800e9b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ea1:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ea4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ea7:	c9                   	leave  
  800ea8:	c3                   	ret    

00800ea9 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ea9:	55                   	push   %ebp
  800eaa:	89 e5                	mov    %esp,%ebp
  800eac:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800eaf:	8d 45 10             	lea    0x10(%ebp),%eax
  800eb2:	83 c0 04             	add    $0x4,%eax
  800eb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800eb8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ebb:	ff 75 f4             	pushl  -0xc(%ebp)
  800ebe:	50                   	push   %eax
  800ebf:	ff 75 0c             	pushl  0xc(%ebp)
  800ec2:	ff 75 08             	pushl  0x8(%ebp)
  800ec5:	e8 89 ff ff ff       	call   800e53 <vsnprintf>
  800eca:	83 c4 10             	add    $0x10,%esp
  800ecd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ed0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ed3:	c9                   	leave  
  800ed4:	c3                   	ret    

00800ed5 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ed5:	55                   	push   %ebp
  800ed6:	89 e5                	mov    %esp,%ebp
  800ed8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800edb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ee2:	eb 06                	jmp    800eea <strlen+0x15>
		n++;
  800ee4:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ee7:	ff 45 08             	incl   0x8(%ebp)
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	84 c0                	test   %al,%al
  800ef1:	75 f1                	jne    800ee4 <strlen+0xf>
		n++;
	return n;
  800ef3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ef6:	c9                   	leave  
  800ef7:	c3                   	ret    

00800ef8 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ef8:	55                   	push   %ebp
  800ef9:	89 e5                	mov    %esp,%ebp
  800efb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800efe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f05:	eb 09                	jmp    800f10 <strnlen+0x18>
		n++;
  800f07:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f0a:	ff 45 08             	incl   0x8(%ebp)
  800f0d:	ff 4d 0c             	decl   0xc(%ebp)
  800f10:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f14:	74 09                	je     800f1f <strnlen+0x27>
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	8a 00                	mov    (%eax),%al
  800f1b:	84 c0                	test   %al,%al
  800f1d:	75 e8                	jne    800f07 <strnlen+0xf>
		n++;
	return n;
  800f1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f22:	c9                   	leave  
  800f23:	c3                   	ret    

00800f24 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f24:	55                   	push   %ebp
  800f25:	89 e5                	mov    %esp,%ebp
  800f27:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f30:	90                   	nop
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	8d 50 01             	lea    0x1(%eax),%edx
  800f37:	89 55 08             	mov    %edx,0x8(%ebp)
  800f3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f3d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f40:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f43:	8a 12                	mov    (%edx),%dl
  800f45:	88 10                	mov    %dl,(%eax)
  800f47:	8a 00                	mov    (%eax),%al
  800f49:	84 c0                	test   %al,%al
  800f4b:	75 e4                	jne    800f31 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f50:	c9                   	leave  
  800f51:	c3                   	ret    

00800f52 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f52:	55                   	push   %ebp
  800f53:	89 e5                	mov    %esp,%ebp
  800f55:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f5e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f65:	eb 1f                	jmp    800f86 <strncpy+0x34>
		*dst++ = *src;
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	8d 50 01             	lea    0x1(%eax),%edx
  800f6d:	89 55 08             	mov    %edx,0x8(%ebp)
  800f70:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f73:	8a 12                	mov    (%edx),%dl
  800f75:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	84 c0                	test   %al,%al
  800f7e:	74 03                	je     800f83 <strncpy+0x31>
			src++;
  800f80:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f83:	ff 45 fc             	incl   -0x4(%ebp)
  800f86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f89:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f8c:	72 d9                	jb     800f67 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f91:	c9                   	leave  
  800f92:	c3                   	ret    

00800f93 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f93:	55                   	push   %ebp
  800f94:	89 e5                	mov    %esp,%ebp
  800f96:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f9f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa3:	74 30                	je     800fd5 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800fa5:	eb 16                	jmp    800fbd <strlcpy+0x2a>
			*dst++ = *src++;
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8d 50 01             	lea    0x1(%eax),%edx
  800fad:	89 55 08             	mov    %edx,0x8(%ebp)
  800fb0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fb6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800fb9:	8a 12                	mov    (%edx),%dl
  800fbb:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800fbd:	ff 4d 10             	decl   0x10(%ebp)
  800fc0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fc4:	74 09                	je     800fcf <strlcpy+0x3c>
  800fc6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc9:	8a 00                	mov    (%eax),%al
  800fcb:	84 c0                	test   %al,%al
  800fcd:	75 d8                	jne    800fa7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800fd5:	8b 55 08             	mov    0x8(%ebp),%edx
  800fd8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fdb:	29 c2                	sub    %eax,%edx
  800fdd:	89 d0                	mov    %edx,%eax
}
  800fdf:	c9                   	leave  
  800fe0:	c3                   	ret    

00800fe1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fe1:	55                   	push   %ebp
  800fe2:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fe4:	eb 06                	jmp    800fec <strcmp+0xb>
		p++, q++;
  800fe6:	ff 45 08             	incl   0x8(%ebp)
  800fe9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	84 c0                	test   %al,%al
  800ff3:	74 0e                	je     801003 <strcmp+0x22>
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	8a 10                	mov    (%eax),%dl
  800ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	38 c2                	cmp    %al,%dl
  801001:	74 e3                	je     800fe6 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	8a 00                	mov    (%eax),%al
  801008:	0f b6 d0             	movzbl %al,%edx
  80100b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100e:	8a 00                	mov    (%eax),%al
  801010:	0f b6 c0             	movzbl %al,%eax
  801013:	29 c2                	sub    %eax,%edx
  801015:	89 d0                	mov    %edx,%eax
}
  801017:	5d                   	pop    %ebp
  801018:	c3                   	ret    

00801019 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801019:	55                   	push   %ebp
  80101a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80101c:	eb 09                	jmp    801027 <strncmp+0xe>
		n--, p++, q++;
  80101e:	ff 4d 10             	decl   0x10(%ebp)
  801021:	ff 45 08             	incl   0x8(%ebp)
  801024:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801027:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80102b:	74 17                	je     801044 <strncmp+0x2b>
  80102d:	8b 45 08             	mov    0x8(%ebp),%eax
  801030:	8a 00                	mov    (%eax),%al
  801032:	84 c0                	test   %al,%al
  801034:	74 0e                	je     801044 <strncmp+0x2b>
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	8a 10                	mov    (%eax),%dl
  80103b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103e:	8a 00                	mov    (%eax),%al
  801040:	38 c2                	cmp    %al,%dl
  801042:	74 da                	je     80101e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801044:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801048:	75 07                	jne    801051 <strncmp+0x38>
		return 0;
  80104a:	b8 00 00 00 00       	mov    $0x0,%eax
  80104f:	eb 14                	jmp    801065 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	8a 00                	mov    (%eax),%al
  801056:	0f b6 d0             	movzbl %al,%edx
  801059:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105c:	8a 00                	mov    (%eax),%al
  80105e:	0f b6 c0             	movzbl %al,%eax
  801061:	29 c2                	sub    %eax,%edx
  801063:	89 d0                	mov    %edx,%eax
}
  801065:	5d                   	pop    %ebp
  801066:	c3                   	ret    

00801067 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801067:	55                   	push   %ebp
  801068:	89 e5                	mov    %esp,%ebp
  80106a:	83 ec 04             	sub    $0x4,%esp
  80106d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801070:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801073:	eb 12                	jmp    801087 <strchr+0x20>
		if (*s == c)
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	8a 00                	mov    (%eax),%al
  80107a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80107d:	75 05                	jne    801084 <strchr+0x1d>
			return (char *) s;
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	eb 11                	jmp    801095 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801084:	ff 45 08             	incl   0x8(%ebp)
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	8a 00                	mov    (%eax),%al
  80108c:	84 c0                	test   %al,%al
  80108e:	75 e5                	jne    801075 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801090:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801095:	c9                   	leave  
  801096:	c3                   	ret    

00801097 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801097:	55                   	push   %ebp
  801098:	89 e5                	mov    %esp,%ebp
  80109a:	83 ec 04             	sub    $0x4,%esp
  80109d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8010a3:	eb 0d                	jmp    8010b2 <strfind+0x1b>
		if (*s == c)
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	8a 00                	mov    (%eax),%al
  8010aa:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8010ad:	74 0e                	je     8010bd <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8010af:	ff 45 08             	incl   0x8(%ebp)
  8010b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b5:	8a 00                	mov    (%eax),%al
  8010b7:	84 c0                	test   %al,%al
  8010b9:	75 ea                	jne    8010a5 <strfind+0xe>
  8010bb:	eb 01                	jmp    8010be <strfind+0x27>
		if (*s == c)
			break;
  8010bd:	90                   	nop
	return (char *) s;
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010c1:	c9                   	leave  
  8010c2:	c3                   	ret    

008010c3 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8010c3:	55                   	push   %ebp
  8010c4:	89 e5                	mov    %esp,%ebp
  8010c6:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8010c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8010cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8010d5:	eb 0e                	jmp    8010e5 <memset+0x22>
		*p++ = c;
  8010d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010da:	8d 50 01             	lea    0x1(%eax),%edx
  8010dd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e3:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8010e5:	ff 4d f8             	decl   -0x8(%ebp)
  8010e8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8010ec:	79 e9                	jns    8010d7 <memset+0x14>
		*p++ = c;

	return v;
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010f1:	c9                   	leave  
  8010f2:	c3                   	ret    

008010f3 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8010f3:	55                   	push   %ebp
  8010f4:	89 e5                	mov    %esp,%ebp
  8010f6:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801102:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801105:	eb 16                	jmp    80111d <memcpy+0x2a>
		*d++ = *s++;
  801107:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110a:	8d 50 01             	lea    0x1(%eax),%edx
  80110d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801110:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801113:	8d 4a 01             	lea    0x1(%edx),%ecx
  801116:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801119:	8a 12                	mov    (%edx),%dl
  80111b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80111d:	8b 45 10             	mov    0x10(%ebp),%eax
  801120:	8d 50 ff             	lea    -0x1(%eax),%edx
  801123:	89 55 10             	mov    %edx,0x10(%ebp)
  801126:	85 c0                	test   %eax,%eax
  801128:	75 dd                	jne    801107 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80112a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80112d:	c9                   	leave  
  80112e:	c3                   	ret    

0080112f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80112f:	55                   	push   %ebp
  801130:	89 e5                	mov    %esp,%ebp
  801132:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801135:	8b 45 0c             	mov    0xc(%ebp),%eax
  801138:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80113b:	8b 45 08             	mov    0x8(%ebp),%eax
  80113e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801141:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801144:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801147:	73 50                	jae    801199 <memmove+0x6a>
  801149:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80114c:	8b 45 10             	mov    0x10(%ebp),%eax
  80114f:	01 d0                	add    %edx,%eax
  801151:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801154:	76 43                	jbe    801199 <memmove+0x6a>
		s += n;
  801156:	8b 45 10             	mov    0x10(%ebp),%eax
  801159:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80115c:	8b 45 10             	mov    0x10(%ebp),%eax
  80115f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801162:	eb 10                	jmp    801174 <memmove+0x45>
			*--d = *--s;
  801164:	ff 4d f8             	decl   -0x8(%ebp)
  801167:	ff 4d fc             	decl   -0x4(%ebp)
  80116a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80116d:	8a 10                	mov    (%eax),%dl
  80116f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801172:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801174:	8b 45 10             	mov    0x10(%ebp),%eax
  801177:	8d 50 ff             	lea    -0x1(%eax),%edx
  80117a:	89 55 10             	mov    %edx,0x10(%ebp)
  80117d:	85 c0                	test   %eax,%eax
  80117f:	75 e3                	jne    801164 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801181:	eb 23                	jmp    8011a6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801183:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801186:	8d 50 01             	lea    0x1(%eax),%edx
  801189:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80118c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80118f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801192:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801195:	8a 12                	mov    (%edx),%dl
  801197:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801199:	8b 45 10             	mov    0x10(%ebp),%eax
  80119c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80119f:	89 55 10             	mov    %edx,0x10(%ebp)
  8011a2:	85 c0                	test   %eax,%eax
  8011a4:	75 dd                	jne    801183 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011a9:	c9                   	leave  
  8011aa:	c3                   	ret    

008011ab <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8011ab:	55                   	push   %ebp
  8011ac:	89 e5                	mov    %esp,%ebp
  8011ae:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8011b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ba:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8011bd:	eb 2a                	jmp    8011e9 <memcmp+0x3e>
		if (*s1 != *s2)
  8011bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011c2:	8a 10                	mov    (%eax),%dl
  8011c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011c7:	8a 00                	mov    (%eax),%al
  8011c9:	38 c2                	cmp    %al,%dl
  8011cb:	74 16                	je     8011e3 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8011cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011d0:	8a 00                	mov    (%eax),%al
  8011d2:	0f b6 d0             	movzbl %al,%edx
  8011d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d8:	8a 00                	mov    (%eax),%al
  8011da:	0f b6 c0             	movzbl %al,%eax
  8011dd:	29 c2                	sub    %eax,%edx
  8011df:	89 d0                	mov    %edx,%eax
  8011e1:	eb 18                	jmp    8011fb <memcmp+0x50>
		s1++, s2++;
  8011e3:	ff 45 fc             	incl   -0x4(%ebp)
  8011e6:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8011e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ec:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011ef:	89 55 10             	mov    %edx,0x10(%ebp)
  8011f2:	85 c0                	test   %eax,%eax
  8011f4:	75 c9                	jne    8011bf <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8011f6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011fb:	c9                   	leave  
  8011fc:	c3                   	ret    

008011fd <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8011fd:	55                   	push   %ebp
  8011fe:	89 e5                	mov    %esp,%ebp
  801200:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801203:	8b 55 08             	mov    0x8(%ebp),%edx
  801206:	8b 45 10             	mov    0x10(%ebp),%eax
  801209:	01 d0                	add    %edx,%eax
  80120b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80120e:	eb 15                	jmp    801225 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	8a 00                	mov    (%eax),%al
  801215:	0f b6 d0             	movzbl %al,%edx
  801218:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121b:	0f b6 c0             	movzbl %al,%eax
  80121e:	39 c2                	cmp    %eax,%edx
  801220:	74 0d                	je     80122f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801222:	ff 45 08             	incl   0x8(%ebp)
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80122b:	72 e3                	jb     801210 <memfind+0x13>
  80122d:	eb 01                	jmp    801230 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80122f:	90                   	nop
	return (void *) s;
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801233:	c9                   	leave  
  801234:	c3                   	ret    

00801235 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801235:	55                   	push   %ebp
  801236:	89 e5                	mov    %esp,%ebp
  801238:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80123b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801242:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801249:	eb 03                	jmp    80124e <strtol+0x19>
		s++;
  80124b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	8a 00                	mov    (%eax),%al
  801253:	3c 20                	cmp    $0x20,%al
  801255:	74 f4                	je     80124b <strtol+0x16>
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	8a 00                	mov    (%eax),%al
  80125c:	3c 09                	cmp    $0x9,%al
  80125e:	74 eb                	je     80124b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801260:	8b 45 08             	mov    0x8(%ebp),%eax
  801263:	8a 00                	mov    (%eax),%al
  801265:	3c 2b                	cmp    $0x2b,%al
  801267:	75 05                	jne    80126e <strtol+0x39>
		s++;
  801269:	ff 45 08             	incl   0x8(%ebp)
  80126c:	eb 13                	jmp    801281 <strtol+0x4c>
	else if (*s == '-')
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
  801271:	8a 00                	mov    (%eax),%al
  801273:	3c 2d                	cmp    $0x2d,%al
  801275:	75 0a                	jne    801281 <strtol+0x4c>
		s++, neg = 1;
  801277:	ff 45 08             	incl   0x8(%ebp)
  80127a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801281:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801285:	74 06                	je     80128d <strtol+0x58>
  801287:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80128b:	75 20                	jne    8012ad <strtol+0x78>
  80128d:	8b 45 08             	mov    0x8(%ebp),%eax
  801290:	8a 00                	mov    (%eax),%al
  801292:	3c 30                	cmp    $0x30,%al
  801294:	75 17                	jne    8012ad <strtol+0x78>
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
  801299:	40                   	inc    %eax
  80129a:	8a 00                	mov    (%eax),%al
  80129c:	3c 78                	cmp    $0x78,%al
  80129e:	75 0d                	jne    8012ad <strtol+0x78>
		s += 2, base = 16;
  8012a0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8012a4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8012ab:	eb 28                	jmp    8012d5 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8012ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012b1:	75 15                	jne    8012c8 <strtol+0x93>
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	8a 00                	mov    (%eax),%al
  8012b8:	3c 30                	cmp    $0x30,%al
  8012ba:	75 0c                	jne    8012c8 <strtol+0x93>
		s++, base = 8;
  8012bc:	ff 45 08             	incl   0x8(%ebp)
  8012bf:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8012c6:	eb 0d                	jmp    8012d5 <strtol+0xa0>
	else if (base == 0)
  8012c8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012cc:	75 07                	jne    8012d5 <strtol+0xa0>
		base = 10;
  8012ce:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8012d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d8:	8a 00                	mov    (%eax),%al
  8012da:	3c 2f                	cmp    $0x2f,%al
  8012dc:	7e 19                	jle    8012f7 <strtol+0xc2>
  8012de:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e1:	8a 00                	mov    (%eax),%al
  8012e3:	3c 39                	cmp    $0x39,%al
  8012e5:	7f 10                	jg     8012f7 <strtol+0xc2>
			dig = *s - '0';
  8012e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ea:	8a 00                	mov    (%eax),%al
  8012ec:	0f be c0             	movsbl %al,%eax
  8012ef:	83 e8 30             	sub    $0x30,%eax
  8012f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012f5:	eb 42                	jmp    801339 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8012f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fa:	8a 00                	mov    (%eax),%al
  8012fc:	3c 60                	cmp    $0x60,%al
  8012fe:	7e 19                	jle    801319 <strtol+0xe4>
  801300:	8b 45 08             	mov    0x8(%ebp),%eax
  801303:	8a 00                	mov    (%eax),%al
  801305:	3c 7a                	cmp    $0x7a,%al
  801307:	7f 10                	jg     801319 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801309:	8b 45 08             	mov    0x8(%ebp),%eax
  80130c:	8a 00                	mov    (%eax),%al
  80130e:	0f be c0             	movsbl %al,%eax
  801311:	83 e8 57             	sub    $0x57,%eax
  801314:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801317:	eb 20                	jmp    801339 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801319:	8b 45 08             	mov    0x8(%ebp),%eax
  80131c:	8a 00                	mov    (%eax),%al
  80131e:	3c 40                	cmp    $0x40,%al
  801320:	7e 39                	jle    80135b <strtol+0x126>
  801322:	8b 45 08             	mov    0x8(%ebp),%eax
  801325:	8a 00                	mov    (%eax),%al
  801327:	3c 5a                	cmp    $0x5a,%al
  801329:	7f 30                	jg     80135b <strtol+0x126>
			dig = *s - 'A' + 10;
  80132b:	8b 45 08             	mov    0x8(%ebp),%eax
  80132e:	8a 00                	mov    (%eax),%al
  801330:	0f be c0             	movsbl %al,%eax
  801333:	83 e8 37             	sub    $0x37,%eax
  801336:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801339:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80133c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80133f:	7d 19                	jge    80135a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801341:	ff 45 08             	incl   0x8(%ebp)
  801344:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801347:	0f af 45 10          	imul   0x10(%ebp),%eax
  80134b:	89 c2                	mov    %eax,%edx
  80134d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801350:	01 d0                	add    %edx,%eax
  801352:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801355:	e9 7b ff ff ff       	jmp    8012d5 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80135a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80135b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80135f:	74 08                	je     801369 <strtol+0x134>
		*endptr = (char *) s;
  801361:	8b 45 0c             	mov    0xc(%ebp),%eax
  801364:	8b 55 08             	mov    0x8(%ebp),%edx
  801367:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801369:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80136d:	74 07                	je     801376 <strtol+0x141>
  80136f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801372:	f7 d8                	neg    %eax
  801374:	eb 03                	jmp    801379 <strtol+0x144>
  801376:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <ltostr>:

void
ltostr(long value, char *str)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
  80137e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801381:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801388:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80138f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801393:	79 13                	jns    8013a8 <ltostr+0x2d>
	{
		neg = 1;
  801395:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80139c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8013a2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8013a5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ab:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8013b0:	99                   	cltd   
  8013b1:	f7 f9                	idiv   %ecx
  8013b3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8013b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013b9:	8d 50 01             	lea    0x1(%eax),%edx
  8013bc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013bf:	89 c2                	mov    %eax,%edx
  8013c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c4:	01 d0                	add    %edx,%eax
  8013c6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013c9:	83 c2 30             	add    $0x30,%edx
  8013cc:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8013ce:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013d1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013d6:	f7 e9                	imul   %ecx
  8013d8:	c1 fa 02             	sar    $0x2,%edx
  8013db:	89 c8                	mov    %ecx,%eax
  8013dd:	c1 f8 1f             	sar    $0x1f,%eax
  8013e0:	29 c2                	sub    %eax,%edx
  8013e2:	89 d0                	mov    %edx,%eax
  8013e4:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8013e7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013ea:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013ef:	f7 e9                	imul   %ecx
  8013f1:	c1 fa 02             	sar    $0x2,%edx
  8013f4:	89 c8                	mov    %ecx,%eax
  8013f6:	c1 f8 1f             	sar    $0x1f,%eax
  8013f9:	29 c2                	sub    %eax,%edx
  8013fb:	89 d0                	mov    %edx,%eax
  8013fd:	c1 e0 02             	shl    $0x2,%eax
  801400:	01 d0                	add    %edx,%eax
  801402:	01 c0                	add    %eax,%eax
  801404:	29 c1                	sub    %eax,%ecx
  801406:	89 ca                	mov    %ecx,%edx
  801408:	85 d2                	test   %edx,%edx
  80140a:	75 9c                	jne    8013a8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80140c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801413:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801416:	48                   	dec    %eax
  801417:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80141a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80141e:	74 3d                	je     80145d <ltostr+0xe2>
		start = 1 ;
  801420:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801427:	eb 34                	jmp    80145d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801429:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80142c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142f:	01 d0                	add    %edx,%eax
  801431:	8a 00                	mov    (%eax),%al
  801433:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801436:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801439:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143c:	01 c2                	add    %eax,%edx
  80143e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801441:	8b 45 0c             	mov    0xc(%ebp),%eax
  801444:	01 c8                	add    %ecx,%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80144a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80144d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801450:	01 c2                	add    %eax,%edx
  801452:	8a 45 eb             	mov    -0x15(%ebp),%al
  801455:	88 02                	mov    %al,(%edx)
		start++ ;
  801457:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80145a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80145d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801460:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801463:	7c c4                	jl     801429 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801465:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801468:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146b:	01 d0                	add    %edx,%eax
  80146d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801470:	90                   	nop
  801471:	c9                   	leave  
  801472:	c3                   	ret    

00801473 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801473:	55                   	push   %ebp
  801474:	89 e5                	mov    %esp,%ebp
  801476:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801479:	ff 75 08             	pushl  0x8(%ebp)
  80147c:	e8 54 fa ff ff       	call   800ed5 <strlen>
  801481:	83 c4 04             	add    $0x4,%esp
  801484:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801487:	ff 75 0c             	pushl  0xc(%ebp)
  80148a:	e8 46 fa ff ff       	call   800ed5 <strlen>
  80148f:	83 c4 04             	add    $0x4,%esp
  801492:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801495:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80149c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014a3:	eb 17                	jmp    8014bc <strcconcat+0x49>
		final[s] = str1[s] ;
  8014a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ab:	01 c2                	add    %eax,%edx
  8014ad:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b3:	01 c8                	add    %ecx,%eax
  8014b5:	8a 00                	mov    (%eax),%al
  8014b7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8014b9:	ff 45 fc             	incl   -0x4(%ebp)
  8014bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014bf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014c2:	7c e1                	jl     8014a5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8014c4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8014cb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8014d2:	eb 1f                	jmp    8014f3 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8014d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014d7:	8d 50 01             	lea    0x1(%eax),%edx
  8014da:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014dd:	89 c2                	mov    %eax,%edx
  8014df:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e2:	01 c2                	add    %eax,%edx
  8014e4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8014e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ea:	01 c8                	add    %ecx,%eax
  8014ec:	8a 00                	mov    (%eax),%al
  8014ee:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8014f0:	ff 45 f8             	incl   -0x8(%ebp)
  8014f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014f9:	7c d9                	jl     8014d4 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8014fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801501:	01 d0                	add    %edx,%eax
  801503:	c6 00 00             	movb   $0x0,(%eax)
}
  801506:	90                   	nop
  801507:	c9                   	leave  
  801508:	c3                   	ret    

00801509 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801509:	55                   	push   %ebp
  80150a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80150c:	8b 45 14             	mov    0x14(%ebp),%eax
  80150f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801515:	8b 45 14             	mov    0x14(%ebp),%eax
  801518:	8b 00                	mov    (%eax),%eax
  80151a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801521:	8b 45 10             	mov    0x10(%ebp),%eax
  801524:	01 d0                	add    %edx,%eax
  801526:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80152c:	eb 0c                	jmp    80153a <strsplit+0x31>
			*string++ = 0;
  80152e:	8b 45 08             	mov    0x8(%ebp),%eax
  801531:	8d 50 01             	lea    0x1(%eax),%edx
  801534:	89 55 08             	mov    %edx,0x8(%ebp)
  801537:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80153a:	8b 45 08             	mov    0x8(%ebp),%eax
  80153d:	8a 00                	mov    (%eax),%al
  80153f:	84 c0                	test   %al,%al
  801541:	74 18                	je     80155b <strsplit+0x52>
  801543:	8b 45 08             	mov    0x8(%ebp),%eax
  801546:	8a 00                	mov    (%eax),%al
  801548:	0f be c0             	movsbl %al,%eax
  80154b:	50                   	push   %eax
  80154c:	ff 75 0c             	pushl  0xc(%ebp)
  80154f:	e8 13 fb ff ff       	call   801067 <strchr>
  801554:	83 c4 08             	add    $0x8,%esp
  801557:	85 c0                	test   %eax,%eax
  801559:	75 d3                	jne    80152e <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	8a 00                	mov    (%eax),%al
  801560:	84 c0                	test   %al,%al
  801562:	74 5a                	je     8015be <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801564:	8b 45 14             	mov    0x14(%ebp),%eax
  801567:	8b 00                	mov    (%eax),%eax
  801569:	83 f8 0f             	cmp    $0xf,%eax
  80156c:	75 07                	jne    801575 <strsplit+0x6c>
		{
			return 0;
  80156e:	b8 00 00 00 00       	mov    $0x0,%eax
  801573:	eb 66                	jmp    8015db <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801575:	8b 45 14             	mov    0x14(%ebp),%eax
  801578:	8b 00                	mov    (%eax),%eax
  80157a:	8d 48 01             	lea    0x1(%eax),%ecx
  80157d:	8b 55 14             	mov    0x14(%ebp),%edx
  801580:	89 0a                	mov    %ecx,(%edx)
  801582:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801589:	8b 45 10             	mov    0x10(%ebp),%eax
  80158c:	01 c2                	add    %eax,%edx
  80158e:	8b 45 08             	mov    0x8(%ebp),%eax
  801591:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801593:	eb 03                	jmp    801598 <strsplit+0x8f>
			string++;
  801595:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801598:	8b 45 08             	mov    0x8(%ebp),%eax
  80159b:	8a 00                	mov    (%eax),%al
  80159d:	84 c0                	test   %al,%al
  80159f:	74 8b                	je     80152c <strsplit+0x23>
  8015a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a4:	8a 00                	mov    (%eax),%al
  8015a6:	0f be c0             	movsbl %al,%eax
  8015a9:	50                   	push   %eax
  8015aa:	ff 75 0c             	pushl  0xc(%ebp)
  8015ad:	e8 b5 fa ff ff       	call   801067 <strchr>
  8015b2:	83 c4 08             	add    $0x8,%esp
  8015b5:	85 c0                	test   %eax,%eax
  8015b7:	74 dc                	je     801595 <strsplit+0x8c>
			string++;
	}
  8015b9:	e9 6e ff ff ff       	jmp    80152c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8015be:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8015bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8015c2:	8b 00                	mov    (%eax),%eax
  8015c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ce:	01 d0                	add    %edx,%eax
  8015d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8015d6:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
  8015e0:	57                   	push   %edi
  8015e1:	56                   	push   %esi
  8015e2:	53                   	push   %ebx
  8015e3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ec:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015ef:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015f2:	8b 7d 18             	mov    0x18(%ebp),%edi
  8015f5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8015f8:	cd 30                	int    $0x30
  8015fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8015fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801600:	83 c4 10             	add    $0x10,%esp
  801603:	5b                   	pop    %ebx
  801604:	5e                   	pop    %esi
  801605:	5f                   	pop    %edi
  801606:	5d                   	pop    %ebp
  801607:	c3                   	ret    

00801608 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
  80160b:	83 ec 04             	sub    $0x4,%esp
  80160e:	8b 45 10             	mov    0x10(%ebp),%eax
  801611:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801614:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801618:	8b 45 08             	mov    0x8(%ebp),%eax
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	52                   	push   %edx
  801620:	ff 75 0c             	pushl  0xc(%ebp)
  801623:	50                   	push   %eax
  801624:	6a 00                	push   $0x0
  801626:	e8 b2 ff ff ff       	call   8015dd <syscall>
  80162b:	83 c4 18             	add    $0x18,%esp
}
  80162e:	90                   	nop
  80162f:	c9                   	leave  
  801630:	c3                   	ret    

00801631 <sys_cgetc>:

int
sys_cgetc(void)
{
  801631:	55                   	push   %ebp
  801632:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	6a 01                	push   $0x1
  801640:	e8 98 ff ff ff       	call   8015dd <syscall>
  801645:	83 c4 18             	add    $0x18,%esp
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80164d:	8b 45 08             	mov    0x8(%ebp),%eax
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	50                   	push   %eax
  801659:	6a 05                	push   $0x5
  80165b:	e8 7d ff ff ff       	call   8015dd <syscall>
  801660:	83 c4 18             	add    $0x18,%esp
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 02                	push   $0x2
  801674:	e8 64 ff ff ff       	call   8015dd <syscall>
  801679:	83 c4 18             	add    $0x18,%esp
}
  80167c:	c9                   	leave  
  80167d:	c3                   	ret    

0080167e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80167e:	55                   	push   %ebp
  80167f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 03                	push   $0x3
  80168d:	e8 4b ff ff ff       	call   8015dd <syscall>
  801692:	83 c4 18             	add    $0x18,%esp
}
  801695:	c9                   	leave  
  801696:	c3                   	ret    

00801697 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801697:	55                   	push   %ebp
  801698:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 04                	push   $0x4
  8016a6:	e8 32 ff ff ff       	call   8015dd <syscall>
  8016ab:	83 c4 18             	add    $0x18,%esp
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <sys_env_exit>:


void sys_env_exit(void)
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 06                	push   $0x6
  8016bf:	e8 19 ff ff ff       	call   8015dd <syscall>
  8016c4:	83 c4 18             	add    $0x18,%esp
}
  8016c7:	90                   	nop
  8016c8:	c9                   	leave  
  8016c9:	c3                   	ret    

008016ca <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016ca:	55                   	push   %ebp
  8016cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	52                   	push   %edx
  8016da:	50                   	push   %eax
  8016db:	6a 07                	push   $0x7
  8016dd:	e8 fb fe ff ff       	call   8015dd <syscall>
  8016e2:	83 c4 18             	add    $0x18,%esp
}
  8016e5:	c9                   	leave  
  8016e6:	c3                   	ret    

008016e7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
  8016ea:	56                   	push   %esi
  8016eb:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016ec:	8b 75 18             	mov    0x18(%ebp),%esi
  8016ef:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016f2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fb:	56                   	push   %esi
  8016fc:	53                   	push   %ebx
  8016fd:	51                   	push   %ecx
  8016fe:	52                   	push   %edx
  8016ff:	50                   	push   %eax
  801700:	6a 08                	push   $0x8
  801702:	e8 d6 fe ff ff       	call   8015dd <syscall>
  801707:	83 c4 18             	add    $0x18,%esp
}
  80170a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80170d:	5b                   	pop    %ebx
  80170e:	5e                   	pop    %esi
  80170f:	5d                   	pop    %ebp
  801710:	c3                   	ret    

00801711 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801711:	55                   	push   %ebp
  801712:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801714:	8b 55 0c             	mov    0xc(%ebp),%edx
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	52                   	push   %edx
  801721:	50                   	push   %eax
  801722:	6a 09                	push   $0x9
  801724:	e8 b4 fe ff ff       	call   8015dd <syscall>
  801729:	83 c4 18             	add    $0x18,%esp
}
  80172c:	c9                   	leave  
  80172d:	c3                   	ret    

0080172e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80172e:	55                   	push   %ebp
  80172f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	ff 75 0c             	pushl  0xc(%ebp)
  80173a:	ff 75 08             	pushl  0x8(%ebp)
  80173d:	6a 0a                	push   $0xa
  80173f:	e8 99 fe ff ff       	call   8015dd <syscall>
  801744:	83 c4 18             	add    $0x18,%esp
}
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 0b                	push   $0xb
  801758:	e8 80 fe ff ff       	call   8015dd <syscall>
  80175d:	83 c4 18             	add    $0x18,%esp
}
  801760:	c9                   	leave  
  801761:	c3                   	ret    

00801762 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 0c                	push   $0xc
  801771:	e8 67 fe ff ff       	call   8015dd <syscall>
  801776:	83 c4 18             	add    $0x18,%esp
}
  801779:	c9                   	leave  
  80177a:	c3                   	ret    

0080177b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80177b:	55                   	push   %ebp
  80177c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 0d                	push   $0xd
  80178a:	e8 4e fe ff ff       	call   8015dd <syscall>
  80178f:	83 c4 18             	add    $0x18,%esp
}
  801792:	c9                   	leave  
  801793:	c3                   	ret    

00801794 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801794:	55                   	push   %ebp
  801795:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	ff 75 0c             	pushl  0xc(%ebp)
  8017a0:	ff 75 08             	pushl  0x8(%ebp)
  8017a3:	6a 11                	push   $0x11
  8017a5:	e8 33 fe ff ff       	call   8015dd <syscall>
  8017aa:	83 c4 18             	add    $0x18,%esp
	return;
  8017ad:	90                   	nop
}
  8017ae:	c9                   	leave  
  8017af:	c3                   	ret    

008017b0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8017b0:	55                   	push   %ebp
  8017b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	ff 75 0c             	pushl  0xc(%ebp)
  8017bc:	ff 75 08             	pushl  0x8(%ebp)
  8017bf:	6a 12                	push   $0x12
  8017c1:	e8 17 fe ff ff       	call   8015dd <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c9:	90                   	nop
}
  8017ca:	c9                   	leave  
  8017cb:	c3                   	ret    

008017cc <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017cc:	55                   	push   %ebp
  8017cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 0e                	push   $0xe
  8017db:	e8 fd fd ff ff       	call   8015dd <syscall>
  8017e0:	83 c4 18             	add    $0x18,%esp
}
  8017e3:	c9                   	leave  
  8017e4:	c3                   	ret    

008017e5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8017e5:	55                   	push   %ebp
  8017e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	ff 75 08             	pushl  0x8(%ebp)
  8017f3:	6a 0f                	push   $0xf
  8017f5:	e8 e3 fd ff ff       	call   8015dd <syscall>
  8017fa:	83 c4 18             	add    $0x18,%esp
}
  8017fd:	c9                   	leave  
  8017fe:	c3                   	ret    

008017ff <sys_scarce_memory>:

void sys_scarce_memory()
{
  8017ff:	55                   	push   %ebp
  801800:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 10                	push   $0x10
  80180e:	e8 ca fd ff ff       	call   8015dd <syscall>
  801813:	83 c4 18             	add    $0x18,%esp
}
  801816:	90                   	nop
  801817:	c9                   	leave  
  801818:	c3                   	ret    

00801819 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801819:	55                   	push   %ebp
  80181a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 14                	push   $0x14
  801828:	e8 b0 fd ff ff       	call   8015dd <syscall>
  80182d:	83 c4 18             	add    $0x18,%esp
}
  801830:	90                   	nop
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 15                	push   $0x15
  801842:	e8 96 fd ff ff       	call   8015dd <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
}
  80184a:	90                   	nop
  80184b:	c9                   	leave  
  80184c:	c3                   	ret    

0080184d <sys_cputc>:


void
sys_cputc(const char c)
{
  80184d:	55                   	push   %ebp
  80184e:	89 e5                	mov    %esp,%ebp
  801850:	83 ec 04             	sub    $0x4,%esp
  801853:	8b 45 08             	mov    0x8(%ebp),%eax
  801856:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801859:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	50                   	push   %eax
  801866:	6a 16                	push   $0x16
  801868:	e8 70 fd ff ff       	call   8015dd <syscall>
  80186d:	83 c4 18             	add    $0x18,%esp
}
  801870:	90                   	nop
  801871:	c9                   	leave  
  801872:	c3                   	ret    

00801873 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 17                	push   $0x17
  801882:	e8 56 fd ff ff       	call   8015dd <syscall>
  801887:	83 c4 18             	add    $0x18,%esp
}
  80188a:	90                   	nop
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801890:	8b 45 08             	mov    0x8(%ebp),%eax
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	ff 75 0c             	pushl  0xc(%ebp)
  80189c:	50                   	push   %eax
  80189d:	6a 18                	push   $0x18
  80189f:	e8 39 fd ff ff       	call   8015dd <syscall>
  8018a4:	83 c4 18             	add    $0x18,%esp
}
  8018a7:	c9                   	leave  
  8018a8:	c3                   	ret    

008018a9 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8018a9:	55                   	push   %ebp
  8018aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018af:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	52                   	push   %edx
  8018b9:	50                   	push   %eax
  8018ba:	6a 1b                	push   $0x1b
  8018bc:	e8 1c fd ff ff       	call   8015dd <syscall>
  8018c1:	83 c4 18             	add    $0x18,%esp
}
  8018c4:	c9                   	leave  
  8018c5:	c3                   	ret    

008018c6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018c6:	55                   	push   %ebp
  8018c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	52                   	push   %edx
  8018d6:	50                   	push   %eax
  8018d7:	6a 19                	push   $0x19
  8018d9:	e8 ff fc ff ff       	call   8015dd <syscall>
  8018de:	83 c4 18             	add    $0x18,%esp
}
  8018e1:	90                   	nop
  8018e2:	c9                   	leave  
  8018e3:	c3                   	ret    

008018e4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018e4:	55                   	push   %ebp
  8018e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	52                   	push   %edx
  8018f4:	50                   	push   %eax
  8018f5:	6a 1a                	push   $0x1a
  8018f7:	e8 e1 fc ff ff       	call   8015dd <syscall>
  8018fc:	83 c4 18             	add    $0x18,%esp
}
  8018ff:	90                   	nop
  801900:	c9                   	leave  
  801901:	c3                   	ret    

00801902 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801902:	55                   	push   %ebp
  801903:	89 e5                	mov    %esp,%ebp
  801905:	83 ec 04             	sub    $0x4,%esp
  801908:	8b 45 10             	mov    0x10(%ebp),%eax
  80190b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80190e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801911:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801915:	8b 45 08             	mov    0x8(%ebp),%eax
  801918:	6a 00                	push   $0x0
  80191a:	51                   	push   %ecx
  80191b:	52                   	push   %edx
  80191c:	ff 75 0c             	pushl  0xc(%ebp)
  80191f:	50                   	push   %eax
  801920:	6a 1c                	push   $0x1c
  801922:	e8 b6 fc ff ff       	call   8015dd <syscall>
  801927:	83 c4 18             	add    $0x18,%esp
}
  80192a:	c9                   	leave  
  80192b:	c3                   	ret    

0080192c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80192c:	55                   	push   %ebp
  80192d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80192f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801932:	8b 45 08             	mov    0x8(%ebp),%eax
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	52                   	push   %edx
  80193c:	50                   	push   %eax
  80193d:	6a 1d                	push   $0x1d
  80193f:	e8 99 fc ff ff       	call   8015dd <syscall>
  801944:	83 c4 18             	add    $0x18,%esp
}
  801947:	c9                   	leave  
  801948:	c3                   	ret    

00801949 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801949:	55                   	push   %ebp
  80194a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80194c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80194f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801952:	8b 45 08             	mov    0x8(%ebp),%eax
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	51                   	push   %ecx
  80195a:	52                   	push   %edx
  80195b:	50                   	push   %eax
  80195c:	6a 1e                	push   $0x1e
  80195e:	e8 7a fc ff ff       	call   8015dd <syscall>
  801963:	83 c4 18             	add    $0x18,%esp
}
  801966:	c9                   	leave  
  801967:	c3                   	ret    

00801968 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801968:	55                   	push   %ebp
  801969:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80196b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80196e:	8b 45 08             	mov    0x8(%ebp),%eax
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	52                   	push   %edx
  801978:	50                   	push   %eax
  801979:	6a 1f                	push   $0x1f
  80197b:	e8 5d fc ff ff       	call   8015dd <syscall>
  801980:	83 c4 18             	add    $0x18,%esp
}
  801983:	c9                   	leave  
  801984:	c3                   	ret    

00801985 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801985:	55                   	push   %ebp
  801986:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 20                	push   $0x20
  801994:	e8 44 fc ff ff       	call   8015dd <syscall>
  801999:	83 c4 18             	add    $0x18,%esp
}
  80199c:	c9                   	leave  
  80199d:	c3                   	ret    

0080199e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80199e:	55                   	push   %ebp
  80199f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8019a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a4:	6a 00                	push   $0x0
  8019a6:	ff 75 14             	pushl  0x14(%ebp)
  8019a9:	ff 75 10             	pushl  0x10(%ebp)
  8019ac:	ff 75 0c             	pushl  0xc(%ebp)
  8019af:	50                   	push   %eax
  8019b0:	6a 21                	push   $0x21
  8019b2:	e8 26 fc ff ff       	call   8015dd <syscall>
  8019b7:	83 c4 18             	add    $0x18,%esp
}
  8019ba:	c9                   	leave  
  8019bb:	c3                   	ret    

008019bc <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8019bc:	55                   	push   %ebp
  8019bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	50                   	push   %eax
  8019cb:	6a 22                	push   $0x22
  8019cd:	e8 0b fc ff ff       	call   8015dd <syscall>
  8019d2:	83 c4 18             	add    $0x18,%esp
}
  8019d5:	90                   	nop
  8019d6:	c9                   	leave  
  8019d7:	c3                   	ret    

008019d8 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8019d8:	55                   	push   %ebp
  8019d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8019db:	8b 45 08             	mov    0x8(%ebp),%eax
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	50                   	push   %eax
  8019e7:	6a 23                	push   $0x23
  8019e9:	e8 ef fb ff ff       	call   8015dd <syscall>
  8019ee:	83 c4 18             	add    $0x18,%esp
}
  8019f1:	90                   	nop
  8019f2:	c9                   	leave  
  8019f3:	c3                   	ret    

008019f4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8019f4:	55                   	push   %ebp
  8019f5:	89 e5                	mov    %esp,%ebp
  8019f7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8019fa:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019fd:	8d 50 04             	lea    0x4(%eax),%edx
  801a00:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	52                   	push   %edx
  801a0a:	50                   	push   %eax
  801a0b:	6a 24                	push   $0x24
  801a0d:	e8 cb fb ff ff       	call   8015dd <syscall>
  801a12:	83 c4 18             	add    $0x18,%esp
	return result;
  801a15:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a1b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a1e:	89 01                	mov    %eax,(%ecx)
  801a20:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a23:	8b 45 08             	mov    0x8(%ebp),%eax
  801a26:	c9                   	leave  
  801a27:	c2 04 00             	ret    $0x4

00801a2a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	ff 75 10             	pushl  0x10(%ebp)
  801a34:	ff 75 0c             	pushl  0xc(%ebp)
  801a37:	ff 75 08             	pushl  0x8(%ebp)
  801a3a:	6a 13                	push   $0x13
  801a3c:	e8 9c fb ff ff       	call   8015dd <syscall>
  801a41:	83 c4 18             	add    $0x18,%esp
	return ;
  801a44:	90                   	nop
}
  801a45:	c9                   	leave  
  801a46:	c3                   	ret    

00801a47 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a47:	55                   	push   %ebp
  801a48:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 25                	push   $0x25
  801a56:	e8 82 fb ff ff       	call   8015dd <syscall>
  801a5b:	83 c4 18             	add    $0x18,%esp
}
  801a5e:	c9                   	leave  
  801a5f:	c3                   	ret    

00801a60 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a60:	55                   	push   %ebp
  801a61:	89 e5                	mov    %esp,%ebp
  801a63:	83 ec 04             	sub    $0x4,%esp
  801a66:	8b 45 08             	mov    0x8(%ebp),%eax
  801a69:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a6c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a70:	6a 00                	push   $0x0
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	50                   	push   %eax
  801a79:	6a 26                	push   $0x26
  801a7b:	e8 5d fb ff ff       	call   8015dd <syscall>
  801a80:	83 c4 18             	add    $0x18,%esp
	return ;
  801a83:	90                   	nop
}
  801a84:	c9                   	leave  
  801a85:	c3                   	ret    

00801a86 <rsttst>:
void rsttst()
{
  801a86:	55                   	push   %ebp
  801a87:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 28                	push   $0x28
  801a95:	e8 43 fb ff ff       	call   8015dd <syscall>
  801a9a:	83 c4 18             	add    $0x18,%esp
	return ;
  801a9d:	90                   	nop
}
  801a9e:	c9                   	leave  
  801a9f:	c3                   	ret    

00801aa0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801aa0:	55                   	push   %ebp
  801aa1:	89 e5                	mov    %esp,%ebp
  801aa3:	83 ec 04             	sub    $0x4,%esp
  801aa6:	8b 45 14             	mov    0x14(%ebp),%eax
  801aa9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801aac:	8b 55 18             	mov    0x18(%ebp),%edx
  801aaf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ab3:	52                   	push   %edx
  801ab4:	50                   	push   %eax
  801ab5:	ff 75 10             	pushl  0x10(%ebp)
  801ab8:	ff 75 0c             	pushl  0xc(%ebp)
  801abb:	ff 75 08             	pushl  0x8(%ebp)
  801abe:	6a 27                	push   $0x27
  801ac0:	e8 18 fb ff ff       	call   8015dd <syscall>
  801ac5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ac8:	90                   	nop
}
  801ac9:	c9                   	leave  
  801aca:	c3                   	ret    

00801acb <chktst>:
void chktst(uint32 n)
{
  801acb:	55                   	push   %ebp
  801acc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	ff 75 08             	pushl  0x8(%ebp)
  801ad9:	6a 29                	push   $0x29
  801adb:	e8 fd fa ff ff       	call   8015dd <syscall>
  801ae0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ae3:	90                   	nop
}
  801ae4:	c9                   	leave  
  801ae5:	c3                   	ret    

00801ae6 <inctst>:

void inctst()
{
  801ae6:	55                   	push   %ebp
  801ae7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 2a                	push   $0x2a
  801af5:	e8 e3 fa ff ff       	call   8015dd <syscall>
  801afa:	83 c4 18             	add    $0x18,%esp
	return ;
  801afd:	90                   	nop
}
  801afe:	c9                   	leave  
  801aff:	c3                   	ret    

00801b00 <gettst>:
uint32 gettst()
{
  801b00:	55                   	push   %ebp
  801b01:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 2b                	push   $0x2b
  801b0f:	e8 c9 fa ff ff       	call   8015dd <syscall>
  801b14:	83 c4 18             	add    $0x18,%esp
}
  801b17:	c9                   	leave  
  801b18:	c3                   	ret    

00801b19 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b19:	55                   	push   %ebp
  801b1a:	89 e5                	mov    %esp,%ebp
  801b1c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	6a 2c                	push   $0x2c
  801b2b:	e8 ad fa ff ff       	call   8015dd <syscall>
  801b30:	83 c4 18             	add    $0x18,%esp
  801b33:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b36:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b3a:	75 07                	jne    801b43 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b3c:	b8 01 00 00 00       	mov    $0x1,%eax
  801b41:	eb 05                	jmp    801b48 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b43:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b48:	c9                   	leave  
  801b49:	c3                   	ret    

00801b4a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b4a:	55                   	push   %ebp
  801b4b:	89 e5                	mov    %esp,%ebp
  801b4d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b50:	6a 00                	push   $0x0
  801b52:	6a 00                	push   $0x0
  801b54:	6a 00                	push   $0x0
  801b56:	6a 00                	push   $0x0
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 2c                	push   $0x2c
  801b5c:	e8 7c fa ff ff       	call   8015dd <syscall>
  801b61:	83 c4 18             	add    $0x18,%esp
  801b64:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b67:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b6b:	75 07                	jne    801b74 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b6d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b72:	eb 05                	jmp    801b79 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b74:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b79:	c9                   	leave  
  801b7a:	c3                   	ret    

00801b7b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b7b:	55                   	push   %ebp
  801b7c:	89 e5                	mov    %esp,%ebp
  801b7e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b81:	6a 00                	push   $0x0
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 2c                	push   $0x2c
  801b8d:	e8 4b fa ff ff       	call   8015dd <syscall>
  801b92:	83 c4 18             	add    $0x18,%esp
  801b95:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b98:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b9c:	75 07                	jne    801ba5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801ba3:	eb 05                	jmp    801baa <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ba5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801baa:	c9                   	leave  
  801bab:	c3                   	ret    

00801bac <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801bac:	55                   	push   %ebp
  801bad:	89 e5                	mov    %esp,%ebp
  801baf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 2c                	push   $0x2c
  801bbe:	e8 1a fa ff ff       	call   8015dd <syscall>
  801bc3:	83 c4 18             	add    $0x18,%esp
  801bc6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801bc9:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bcd:	75 07                	jne    801bd6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bcf:	b8 01 00 00 00       	mov    $0x1,%eax
  801bd4:	eb 05                	jmp    801bdb <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bd6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bdb:	c9                   	leave  
  801bdc:	c3                   	ret    

00801bdd <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801bdd:	55                   	push   %ebp
  801bde:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	ff 75 08             	pushl  0x8(%ebp)
  801beb:	6a 2d                	push   $0x2d
  801bed:	e8 eb f9 ff ff       	call   8015dd <syscall>
  801bf2:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf5:	90                   	nop
}
  801bf6:	c9                   	leave  
  801bf7:	c3                   	ret    

00801bf8 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801bf8:	55                   	push   %ebp
  801bf9:	89 e5                	mov    %esp,%ebp
  801bfb:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801bfc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bff:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c02:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c05:	8b 45 08             	mov    0x8(%ebp),%eax
  801c08:	6a 00                	push   $0x0
  801c0a:	53                   	push   %ebx
  801c0b:	51                   	push   %ecx
  801c0c:	52                   	push   %edx
  801c0d:	50                   	push   %eax
  801c0e:	6a 2e                	push   $0x2e
  801c10:	e8 c8 f9 ff ff       	call   8015dd <syscall>
  801c15:	83 c4 18             	add    $0x18,%esp
}
  801c18:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801c1b:	c9                   	leave  
  801c1c:	c3                   	ret    

00801c1d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801c1d:	55                   	push   %ebp
  801c1e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801c20:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c23:	8b 45 08             	mov    0x8(%ebp),%eax
  801c26:	6a 00                	push   $0x0
  801c28:	6a 00                	push   $0x0
  801c2a:	6a 00                	push   $0x0
  801c2c:	52                   	push   %edx
  801c2d:	50                   	push   %eax
  801c2e:	6a 2f                	push   $0x2f
  801c30:	e8 a8 f9 ff ff       	call   8015dd <syscall>
  801c35:	83 c4 18             	add    $0x18,%esp
}
  801c38:	c9                   	leave  
  801c39:	c3                   	ret    
  801c3a:	66 90                	xchg   %ax,%ax

00801c3c <__udivdi3>:
  801c3c:	55                   	push   %ebp
  801c3d:	57                   	push   %edi
  801c3e:	56                   	push   %esi
  801c3f:	53                   	push   %ebx
  801c40:	83 ec 1c             	sub    $0x1c,%esp
  801c43:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c47:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c4b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c4f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c53:	89 ca                	mov    %ecx,%edx
  801c55:	89 f8                	mov    %edi,%eax
  801c57:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c5b:	85 f6                	test   %esi,%esi
  801c5d:	75 2d                	jne    801c8c <__udivdi3+0x50>
  801c5f:	39 cf                	cmp    %ecx,%edi
  801c61:	77 65                	ja     801cc8 <__udivdi3+0x8c>
  801c63:	89 fd                	mov    %edi,%ebp
  801c65:	85 ff                	test   %edi,%edi
  801c67:	75 0b                	jne    801c74 <__udivdi3+0x38>
  801c69:	b8 01 00 00 00       	mov    $0x1,%eax
  801c6e:	31 d2                	xor    %edx,%edx
  801c70:	f7 f7                	div    %edi
  801c72:	89 c5                	mov    %eax,%ebp
  801c74:	31 d2                	xor    %edx,%edx
  801c76:	89 c8                	mov    %ecx,%eax
  801c78:	f7 f5                	div    %ebp
  801c7a:	89 c1                	mov    %eax,%ecx
  801c7c:	89 d8                	mov    %ebx,%eax
  801c7e:	f7 f5                	div    %ebp
  801c80:	89 cf                	mov    %ecx,%edi
  801c82:	89 fa                	mov    %edi,%edx
  801c84:	83 c4 1c             	add    $0x1c,%esp
  801c87:	5b                   	pop    %ebx
  801c88:	5e                   	pop    %esi
  801c89:	5f                   	pop    %edi
  801c8a:	5d                   	pop    %ebp
  801c8b:	c3                   	ret    
  801c8c:	39 ce                	cmp    %ecx,%esi
  801c8e:	77 28                	ja     801cb8 <__udivdi3+0x7c>
  801c90:	0f bd fe             	bsr    %esi,%edi
  801c93:	83 f7 1f             	xor    $0x1f,%edi
  801c96:	75 40                	jne    801cd8 <__udivdi3+0x9c>
  801c98:	39 ce                	cmp    %ecx,%esi
  801c9a:	72 0a                	jb     801ca6 <__udivdi3+0x6a>
  801c9c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ca0:	0f 87 9e 00 00 00    	ja     801d44 <__udivdi3+0x108>
  801ca6:	b8 01 00 00 00       	mov    $0x1,%eax
  801cab:	89 fa                	mov    %edi,%edx
  801cad:	83 c4 1c             	add    $0x1c,%esp
  801cb0:	5b                   	pop    %ebx
  801cb1:	5e                   	pop    %esi
  801cb2:	5f                   	pop    %edi
  801cb3:	5d                   	pop    %ebp
  801cb4:	c3                   	ret    
  801cb5:	8d 76 00             	lea    0x0(%esi),%esi
  801cb8:	31 ff                	xor    %edi,%edi
  801cba:	31 c0                	xor    %eax,%eax
  801cbc:	89 fa                	mov    %edi,%edx
  801cbe:	83 c4 1c             	add    $0x1c,%esp
  801cc1:	5b                   	pop    %ebx
  801cc2:	5e                   	pop    %esi
  801cc3:	5f                   	pop    %edi
  801cc4:	5d                   	pop    %ebp
  801cc5:	c3                   	ret    
  801cc6:	66 90                	xchg   %ax,%ax
  801cc8:	89 d8                	mov    %ebx,%eax
  801cca:	f7 f7                	div    %edi
  801ccc:	31 ff                	xor    %edi,%edi
  801cce:	89 fa                	mov    %edi,%edx
  801cd0:	83 c4 1c             	add    $0x1c,%esp
  801cd3:	5b                   	pop    %ebx
  801cd4:	5e                   	pop    %esi
  801cd5:	5f                   	pop    %edi
  801cd6:	5d                   	pop    %ebp
  801cd7:	c3                   	ret    
  801cd8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cdd:	89 eb                	mov    %ebp,%ebx
  801cdf:	29 fb                	sub    %edi,%ebx
  801ce1:	89 f9                	mov    %edi,%ecx
  801ce3:	d3 e6                	shl    %cl,%esi
  801ce5:	89 c5                	mov    %eax,%ebp
  801ce7:	88 d9                	mov    %bl,%cl
  801ce9:	d3 ed                	shr    %cl,%ebp
  801ceb:	89 e9                	mov    %ebp,%ecx
  801ced:	09 f1                	or     %esi,%ecx
  801cef:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801cf3:	89 f9                	mov    %edi,%ecx
  801cf5:	d3 e0                	shl    %cl,%eax
  801cf7:	89 c5                	mov    %eax,%ebp
  801cf9:	89 d6                	mov    %edx,%esi
  801cfb:	88 d9                	mov    %bl,%cl
  801cfd:	d3 ee                	shr    %cl,%esi
  801cff:	89 f9                	mov    %edi,%ecx
  801d01:	d3 e2                	shl    %cl,%edx
  801d03:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d07:	88 d9                	mov    %bl,%cl
  801d09:	d3 e8                	shr    %cl,%eax
  801d0b:	09 c2                	or     %eax,%edx
  801d0d:	89 d0                	mov    %edx,%eax
  801d0f:	89 f2                	mov    %esi,%edx
  801d11:	f7 74 24 0c          	divl   0xc(%esp)
  801d15:	89 d6                	mov    %edx,%esi
  801d17:	89 c3                	mov    %eax,%ebx
  801d19:	f7 e5                	mul    %ebp
  801d1b:	39 d6                	cmp    %edx,%esi
  801d1d:	72 19                	jb     801d38 <__udivdi3+0xfc>
  801d1f:	74 0b                	je     801d2c <__udivdi3+0xf0>
  801d21:	89 d8                	mov    %ebx,%eax
  801d23:	31 ff                	xor    %edi,%edi
  801d25:	e9 58 ff ff ff       	jmp    801c82 <__udivdi3+0x46>
  801d2a:	66 90                	xchg   %ax,%ax
  801d2c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d30:	89 f9                	mov    %edi,%ecx
  801d32:	d3 e2                	shl    %cl,%edx
  801d34:	39 c2                	cmp    %eax,%edx
  801d36:	73 e9                	jae    801d21 <__udivdi3+0xe5>
  801d38:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d3b:	31 ff                	xor    %edi,%edi
  801d3d:	e9 40 ff ff ff       	jmp    801c82 <__udivdi3+0x46>
  801d42:	66 90                	xchg   %ax,%ax
  801d44:	31 c0                	xor    %eax,%eax
  801d46:	e9 37 ff ff ff       	jmp    801c82 <__udivdi3+0x46>
  801d4b:	90                   	nop

00801d4c <__umoddi3>:
  801d4c:	55                   	push   %ebp
  801d4d:	57                   	push   %edi
  801d4e:	56                   	push   %esi
  801d4f:	53                   	push   %ebx
  801d50:	83 ec 1c             	sub    $0x1c,%esp
  801d53:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d57:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d5b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d5f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d63:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d67:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d6b:	89 f3                	mov    %esi,%ebx
  801d6d:	89 fa                	mov    %edi,%edx
  801d6f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d73:	89 34 24             	mov    %esi,(%esp)
  801d76:	85 c0                	test   %eax,%eax
  801d78:	75 1a                	jne    801d94 <__umoddi3+0x48>
  801d7a:	39 f7                	cmp    %esi,%edi
  801d7c:	0f 86 a2 00 00 00    	jbe    801e24 <__umoddi3+0xd8>
  801d82:	89 c8                	mov    %ecx,%eax
  801d84:	89 f2                	mov    %esi,%edx
  801d86:	f7 f7                	div    %edi
  801d88:	89 d0                	mov    %edx,%eax
  801d8a:	31 d2                	xor    %edx,%edx
  801d8c:	83 c4 1c             	add    $0x1c,%esp
  801d8f:	5b                   	pop    %ebx
  801d90:	5e                   	pop    %esi
  801d91:	5f                   	pop    %edi
  801d92:	5d                   	pop    %ebp
  801d93:	c3                   	ret    
  801d94:	39 f0                	cmp    %esi,%eax
  801d96:	0f 87 ac 00 00 00    	ja     801e48 <__umoddi3+0xfc>
  801d9c:	0f bd e8             	bsr    %eax,%ebp
  801d9f:	83 f5 1f             	xor    $0x1f,%ebp
  801da2:	0f 84 ac 00 00 00    	je     801e54 <__umoddi3+0x108>
  801da8:	bf 20 00 00 00       	mov    $0x20,%edi
  801dad:	29 ef                	sub    %ebp,%edi
  801daf:	89 fe                	mov    %edi,%esi
  801db1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801db5:	89 e9                	mov    %ebp,%ecx
  801db7:	d3 e0                	shl    %cl,%eax
  801db9:	89 d7                	mov    %edx,%edi
  801dbb:	89 f1                	mov    %esi,%ecx
  801dbd:	d3 ef                	shr    %cl,%edi
  801dbf:	09 c7                	or     %eax,%edi
  801dc1:	89 e9                	mov    %ebp,%ecx
  801dc3:	d3 e2                	shl    %cl,%edx
  801dc5:	89 14 24             	mov    %edx,(%esp)
  801dc8:	89 d8                	mov    %ebx,%eax
  801dca:	d3 e0                	shl    %cl,%eax
  801dcc:	89 c2                	mov    %eax,%edx
  801dce:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dd2:	d3 e0                	shl    %cl,%eax
  801dd4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801dd8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ddc:	89 f1                	mov    %esi,%ecx
  801dde:	d3 e8                	shr    %cl,%eax
  801de0:	09 d0                	or     %edx,%eax
  801de2:	d3 eb                	shr    %cl,%ebx
  801de4:	89 da                	mov    %ebx,%edx
  801de6:	f7 f7                	div    %edi
  801de8:	89 d3                	mov    %edx,%ebx
  801dea:	f7 24 24             	mull   (%esp)
  801ded:	89 c6                	mov    %eax,%esi
  801def:	89 d1                	mov    %edx,%ecx
  801df1:	39 d3                	cmp    %edx,%ebx
  801df3:	0f 82 87 00 00 00    	jb     801e80 <__umoddi3+0x134>
  801df9:	0f 84 91 00 00 00    	je     801e90 <__umoddi3+0x144>
  801dff:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e03:	29 f2                	sub    %esi,%edx
  801e05:	19 cb                	sbb    %ecx,%ebx
  801e07:	89 d8                	mov    %ebx,%eax
  801e09:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e0d:	d3 e0                	shl    %cl,%eax
  801e0f:	89 e9                	mov    %ebp,%ecx
  801e11:	d3 ea                	shr    %cl,%edx
  801e13:	09 d0                	or     %edx,%eax
  801e15:	89 e9                	mov    %ebp,%ecx
  801e17:	d3 eb                	shr    %cl,%ebx
  801e19:	89 da                	mov    %ebx,%edx
  801e1b:	83 c4 1c             	add    $0x1c,%esp
  801e1e:	5b                   	pop    %ebx
  801e1f:	5e                   	pop    %esi
  801e20:	5f                   	pop    %edi
  801e21:	5d                   	pop    %ebp
  801e22:	c3                   	ret    
  801e23:	90                   	nop
  801e24:	89 fd                	mov    %edi,%ebp
  801e26:	85 ff                	test   %edi,%edi
  801e28:	75 0b                	jne    801e35 <__umoddi3+0xe9>
  801e2a:	b8 01 00 00 00       	mov    $0x1,%eax
  801e2f:	31 d2                	xor    %edx,%edx
  801e31:	f7 f7                	div    %edi
  801e33:	89 c5                	mov    %eax,%ebp
  801e35:	89 f0                	mov    %esi,%eax
  801e37:	31 d2                	xor    %edx,%edx
  801e39:	f7 f5                	div    %ebp
  801e3b:	89 c8                	mov    %ecx,%eax
  801e3d:	f7 f5                	div    %ebp
  801e3f:	89 d0                	mov    %edx,%eax
  801e41:	e9 44 ff ff ff       	jmp    801d8a <__umoddi3+0x3e>
  801e46:	66 90                	xchg   %ax,%ax
  801e48:	89 c8                	mov    %ecx,%eax
  801e4a:	89 f2                	mov    %esi,%edx
  801e4c:	83 c4 1c             	add    $0x1c,%esp
  801e4f:	5b                   	pop    %ebx
  801e50:	5e                   	pop    %esi
  801e51:	5f                   	pop    %edi
  801e52:	5d                   	pop    %ebp
  801e53:	c3                   	ret    
  801e54:	3b 04 24             	cmp    (%esp),%eax
  801e57:	72 06                	jb     801e5f <__umoddi3+0x113>
  801e59:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e5d:	77 0f                	ja     801e6e <__umoddi3+0x122>
  801e5f:	89 f2                	mov    %esi,%edx
  801e61:	29 f9                	sub    %edi,%ecx
  801e63:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e67:	89 14 24             	mov    %edx,(%esp)
  801e6a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e6e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e72:	8b 14 24             	mov    (%esp),%edx
  801e75:	83 c4 1c             	add    $0x1c,%esp
  801e78:	5b                   	pop    %ebx
  801e79:	5e                   	pop    %esi
  801e7a:	5f                   	pop    %edi
  801e7b:	5d                   	pop    %ebp
  801e7c:	c3                   	ret    
  801e7d:	8d 76 00             	lea    0x0(%esi),%esi
  801e80:	2b 04 24             	sub    (%esp),%eax
  801e83:	19 fa                	sbb    %edi,%edx
  801e85:	89 d1                	mov    %edx,%ecx
  801e87:	89 c6                	mov    %eax,%esi
  801e89:	e9 71 ff ff ff       	jmp    801dff <__umoddi3+0xb3>
  801e8e:	66 90                	xchg   %ax,%ax
  801e90:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e94:	72 ea                	jb     801e80 <__umoddi3+0x134>
  801e96:	89 d9                	mov    %ebx,%ecx
  801e98:	e9 62 ff ff ff       	jmp    801dff <__umoddi3+0xb3>

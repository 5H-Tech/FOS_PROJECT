
obj/user/tst_mod_3:     file format elf32-i386


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
  800031:	e8 13 04 00 00       	call   800449 <libmain>
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
  800044:	e8 f9 15 00 00       	call   801642 <sys_getenvid>
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
  800083:	68 80 1e 80 00       	push   $0x801e80
  800088:	6a 13                	push   $0x13
  80008a:	68 d2 1e 80 00       	push   $0x801ed2
  80008f:	e8 fa 04 00 00       	call   80058e <_panic>
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
  8000b9:	68 80 1e 80 00       	push   $0x801e80
  8000be:	6a 14                	push   $0x14
  8000c0:	68 d2 1e 80 00       	push   $0x801ed2
  8000c5:	e8 c4 04 00 00       	call   80058e <_panic>
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
  8000ef:	68 80 1e 80 00       	push   $0x801e80
  8000f4:	6a 15                	push   $0x15
  8000f6:	68 d2 1e 80 00       	push   $0x801ed2
  8000fb:	e8 8e 04 00 00       	call   80058e <_panic>
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
  800125:	68 80 1e 80 00       	push   $0x801e80
  80012a:	6a 16                	push   $0x16
  80012c:	68 d2 1e 80 00       	push   $0x801ed2
  800131:	e8 58 04 00 00       	call   80058e <_panic>
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
  80015b:	68 80 1e 80 00       	push   $0x801e80
  800160:	6a 17                	push   $0x17
  800162:	68 d2 1e 80 00       	push   $0x801ed2
  800167:	e8 22 04 00 00       	call   80058e <_panic>
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
  800191:	68 80 1e 80 00       	push   $0x801e80
  800196:	6a 18                	push   $0x18
  800198:	68 d2 1e 80 00       	push   $0x801ed2
  80019d:	e8 ec 03 00 00       	call   80058e <_panic>
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
  8001c7:	68 80 1e 80 00       	push   $0x801e80
  8001cc:	6a 19                	push   $0x19
  8001ce:	68 d2 1e 80 00       	push   $0x801ed2
  8001d3:	e8 b6 03 00 00       	call   80058e <_panic>
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
  8001fd:	68 80 1e 80 00       	push   $0x801e80
  800202:	6a 1a                	push   $0x1a
  800204:	68 d2 1e 80 00       	push   $0x801ed2
  800209:	e8 80 03 00 00       	call   80058e <_panic>
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
  800233:	68 80 1e 80 00       	push   $0x801e80
  800238:	6a 1b                	push   $0x1b
  80023a:	68 d2 1e 80 00       	push   $0x801ed2
  80023f:	e8 4a 03 00 00       	call   80058e <_panic>
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
  80026b:	68 80 1e 80 00       	push   $0x801e80
  800270:	6a 1c                	push   $0x1c
  800272:	68 d2 1e 80 00       	push   $0x801ed2
  800277:	e8 12 03 00 00       	call   80058e <_panic>
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
  8002a3:	68 80 1e 80 00       	push   $0x801e80
  8002a8:	6a 1d                	push   $0x1d
  8002aa:	68 d2 1e 80 00       	push   $0x801ed2
  8002af:	e8 da 02 00 00       	call   80058e <_panic>
	}

	//Reading (Not Modified)
	char garbage1 = *((char*)(0x200000)) ;
  8002b4:	b8 00 00 20 00       	mov    $0x200000,%eax
  8002b9:	8a 00                	mov    (%eax),%al
  8002bb:	88 45 93             	mov    %al,-0x6d(%ebp)
	char garbage2 = *((char*)(0x201000)) ;
  8002be:	b8 00 10 20 00       	mov    $0x201000,%eax
  8002c3:	8a 00                	mov    (%eax),%al
  8002c5:	88 45 92             	mov    %al,-0x6e(%ebp)

	//Writing (Modified)
	char *c = ((char*)(0x202000)) ;
  8002c8:	c7 45 8c 00 20 20 00 	movl   $0x202000,-0x74(%ebp)
	*c = 'A';
  8002cf:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8002d2:	c6 00 41             	movb   $0x41,(%eax)

	//Clear the FFL
	sys_clear_ffl();
  8002d5:	e8 76 15 00 00       	call   801850 <sys_clear_ffl>

	//Writing (Modified) (3 frames should be allocated (stack page, mem table, page file table)
	*ptr3 = 255 ;
  8002da:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002dd:	c6 00 ff             	movb   $0xff,(%eax)

	//Check the written values
	if (*c != 'A') panic("test failed!");
  8002e0:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8002e3:	8a 00                	mov    (%eax),%al
  8002e5:	3c 41                	cmp    $0x41,%al
  8002e7:	74 14                	je     8002fd <_main+0x2c5>
  8002e9:	83 ec 04             	sub    $0x4,%esp
  8002ec:	68 e3 1e 80 00       	push   $0x801ee3
  8002f1:	6a 2f                	push   $0x2f
  8002f3:	68 d2 1e 80 00       	push   $0x801ed2
  8002f8:	e8 91 02 00 00       	call   80058e <_panic>
	if (*ptr3 != 255) panic("test failed!");
  8002fd:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800300:	8a 00                	mov    (%eax),%al
  800302:	3c ff                	cmp    $0xff,%al
  800304:	74 14                	je     80031a <_main+0x2e2>
  800306:	83 ec 04             	sub    $0x4,%esp
  800309:	68 e3 1e 80 00       	push   $0x801ee3
  80030e:	6a 30                	push   $0x30
  800310:	68 d2 1e 80 00       	push   $0x801ed2
  800315:	e8 74 02 00 00       	call   80058e <_panic>

	//Check the WS and values
	int i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  80031a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800321:	e9 f7 00 00 00       	jmp    80041d <_main+0x3e5>
	{
		//There should be two empty locations that are freed for the two tables (mem table and page file table)
		int numOfEmptyLocs = 0 ;
  800326:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
		for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  80032d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  800334:	eb 20                	jmp    800356 <_main+0x31e>
		{
			if (myEnv->__uptr_pws[i].empty)
  800336:	a1 20 30 80 00       	mov    0x803020,%eax
  80033b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800341:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800344:	c1 e2 04             	shl    $0x4,%edx
  800347:	01 d0                	add    %edx,%eax
  800349:	8a 40 04             	mov    0x4(%eax),%al
  80034c:	84 c0                	test   %al,%al
  80034e:	74 03                	je     800353 <_main+0x31b>
				numOfEmptyLocs++ ;
  800350:	ff 45 e0             	incl   -0x20(%ebp)
	int i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
	{
		//There should be two empty locations that are freed for the two tables (mem table and page file table)
		int numOfEmptyLocs = 0 ;
		for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  800353:	ff 45 dc             	incl   -0x24(%ebp)
  800356:	a1 20 30 80 00       	mov    0x803020,%eax
  80035b:	8b 50 74             	mov    0x74(%eax),%edx
  80035e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800361:	39 c2                	cmp    %eax,%edx
  800363:	77 d1                	ja     800336 <_main+0x2fe>
		{
			if (myEnv->__uptr_pws[i].empty)
				numOfEmptyLocs++ ;
		}
		if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");
  800365:	83 7d e0 02          	cmpl   $0x2,-0x20(%ebp)
  800369:	74 14                	je     80037f <_main+0x347>
  80036b:	83 ec 04             	sub    $0x4,%esp
  80036e:	68 f0 1e 80 00       	push   $0x801ef0
  800373:	6a 3d                	push   $0x3d
  800375:	68 d2 1e 80 00       	push   $0x801ed2
  80037a:	e8 0f 02 00 00       	call   80058e <_panic>

		uint32 expectedAddresses[9] = {0x800000,0x801000,0x802000,0x803000,0x203000,0x204000,0x205000,0xee7fe000,0xeebfd000} ;
  80037f:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
  800385:	bb 80 1f 80 00       	mov    $0x801f80,%ebx
  80038a:	ba 09 00 00 00       	mov    $0x9,%edx
  80038f:	89 c7                	mov    %eax,%edi
  800391:	89 de                	mov    %ebx,%esi
  800393:	89 d1                	mov    %edx,%ecx
  800395:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		int numOfFoundedAddresses = 0;
  800397:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (int j = 0; j < 9; j++)
  80039e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8003a5:	eb 53                	jmp    8003fa <_main+0x3c2>
		{
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8003a7:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8003ae:	eb 38                	jmp    8003e8 <_main+0x3b0>
			{
				if (ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == expectedAddresses[j])
  8003b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003bb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8003be:	c1 e2 04             	shl    $0x4,%edx
  8003c1:	01 d0                	add    %edx,%eax
  8003c3:	8b 00                	mov    (%eax),%eax
  8003c5:	89 45 88             	mov    %eax,-0x78(%ebp)
  8003c8:	8b 45 88             	mov    -0x78(%ebp),%eax
  8003cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d0:	89 c2                	mov    %eax,%edx
  8003d2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003d5:	8b 84 85 64 ff ff ff 	mov    -0x9c(%ebp,%eax,4),%eax
  8003dc:	39 c2                	cmp    %eax,%edx
  8003de:	75 05                	jne    8003e5 <_main+0x3ad>
				{
					numOfFoundedAddresses++;
  8003e0:	ff 45 d8             	incl   -0x28(%ebp)
					break;
  8003e3:	eb 12                	jmp    8003f7 <_main+0x3bf>

		uint32 expectedAddresses[9] = {0x800000,0x801000,0x802000,0x803000,0x203000,0x204000,0x205000,0xee7fe000,0xeebfd000} ;
		int numOfFoundedAddresses = 0;
		for (int j = 0; j < 9; j++)
		{
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8003e5:	ff 45 d0             	incl   -0x30(%ebp)
  8003e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ed:	8b 50 74             	mov    0x74(%eax),%edx
  8003f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003f3:	39 c2                	cmp    %eax,%edx
  8003f5:	77 b9                	ja     8003b0 <_main+0x378>
		}
		if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");

		uint32 expectedAddresses[9] = {0x800000,0x801000,0x802000,0x803000,0x203000,0x204000,0x205000,0xee7fe000,0xeebfd000} ;
		int numOfFoundedAddresses = 0;
		for (int j = 0; j < 9; j++)
  8003f7:	ff 45 d4             	incl   -0x2c(%ebp)
  8003fa:	83 7d d4 08          	cmpl   $0x8,-0x2c(%ebp)
  8003fe:	7e a7                	jle    8003a7 <_main+0x36f>
					numOfFoundedAddresses++;
					break;
				}
			}
		}
		if (numOfFoundedAddresses != 9) panic("test failed! either wrong victim or victim is not removed from WS");
  800400:	83 7d d8 09          	cmpl   $0x9,-0x28(%ebp)
  800404:	74 14                	je     80041a <_main+0x3e2>
  800406:	83 ec 04             	sub    $0x4,%esp
  800409:	68 f0 1e 80 00       	push   $0x801ef0
  80040e:	6a 4c                	push   $0x4c
  800410:	68 d2 1e 80 00       	push   $0x801ed2
  800415:	e8 74 01 00 00       	call   80058e <_panic>
	if (*c != 'A') panic("test failed!");
	if (*ptr3 != 255) panic("test failed!");

	//Check the WS and values
	int i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  80041a:	ff 45 e4             	incl   -0x1c(%ebp)
  80041d:	a1 20 30 80 00       	mov    0x803020,%eax
  800422:	8b 50 74             	mov    0x74(%eax),%edx
  800425:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800428:	39 c2                	cmp    %eax,%edx
  80042a:	0f 87 f6 fe ff ff    	ja     800326 <_main+0x2ee>
		if (numOfFoundedAddresses != 9) panic("test failed! either wrong victim or victim is not removed from WS");

	}


	cprintf("Congratulations!! test modification is completed successfully.\n");
  800430:	83 ec 0c             	sub    $0xc,%esp
  800433:	68 34 1f 80 00       	push   $0x801f34
  800438:	e8 f3 03 00 00       	call   800830 <cprintf>
  80043d:	83 c4 10             	add    $0x10,%esp
	return;
  800440:	90                   	nop
}
  800441:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800444:	5b                   	pop    %ebx
  800445:	5e                   	pop    %esi
  800446:	5f                   	pop    %edi
  800447:	5d                   	pop    %ebp
  800448:	c3                   	ret    

00800449 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800449:	55                   	push   %ebp
  80044a:	89 e5                	mov    %esp,%ebp
  80044c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80044f:	e8 07 12 00 00       	call   80165b <sys_getenvindex>
  800454:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800457:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80045a:	89 d0                	mov    %edx,%eax
  80045c:	c1 e0 03             	shl    $0x3,%eax
  80045f:	01 d0                	add    %edx,%eax
  800461:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800468:	01 c8                	add    %ecx,%eax
  80046a:	01 c0                	add    %eax,%eax
  80046c:	01 d0                	add    %edx,%eax
  80046e:	01 c0                	add    %eax,%eax
  800470:	01 d0                	add    %edx,%eax
  800472:	89 c2                	mov    %eax,%edx
  800474:	c1 e2 05             	shl    $0x5,%edx
  800477:	29 c2                	sub    %eax,%edx
  800479:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800480:	89 c2                	mov    %eax,%edx
  800482:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800488:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80048d:	a1 20 30 80 00       	mov    0x803020,%eax
  800492:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800498:	84 c0                	test   %al,%al
  80049a:	74 0f                	je     8004ab <libmain+0x62>
		binaryname = myEnv->prog_name;
  80049c:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a1:	05 40 3c 01 00       	add    $0x13c40,%eax
  8004a6:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8004ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8004af:	7e 0a                	jle    8004bb <libmain+0x72>
		binaryname = argv[0];
  8004b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b4:	8b 00                	mov    (%eax),%eax
  8004b6:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8004bb:	83 ec 08             	sub    $0x8,%esp
  8004be:	ff 75 0c             	pushl  0xc(%ebp)
  8004c1:	ff 75 08             	pushl  0x8(%ebp)
  8004c4:	e8 6f fb ff ff       	call   800038 <_main>
  8004c9:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8004cc:	e8 25 13 00 00       	call   8017f6 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8004d1:	83 ec 0c             	sub    $0xc,%esp
  8004d4:	68 bc 1f 80 00       	push   $0x801fbc
  8004d9:	e8 52 03 00 00       	call   800830 <cprintf>
  8004de:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8004e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8004e6:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8004ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f1:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8004f7:	83 ec 04             	sub    $0x4,%esp
  8004fa:	52                   	push   %edx
  8004fb:	50                   	push   %eax
  8004fc:	68 e4 1f 80 00       	push   $0x801fe4
  800501:	e8 2a 03 00 00       	call   800830 <cprintf>
  800506:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800509:	a1 20 30 80 00       	mov    0x803020,%eax
  80050e:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800514:	a1 20 30 80 00       	mov    0x803020,%eax
  800519:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80051f:	83 ec 04             	sub    $0x4,%esp
  800522:	52                   	push   %edx
  800523:	50                   	push   %eax
  800524:	68 0c 20 80 00       	push   $0x80200c
  800529:	e8 02 03 00 00       	call   800830 <cprintf>
  80052e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800531:	a1 20 30 80 00       	mov    0x803020,%eax
  800536:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80053c:	83 ec 08             	sub    $0x8,%esp
  80053f:	50                   	push   %eax
  800540:	68 4d 20 80 00       	push   $0x80204d
  800545:	e8 e6 02 00 00       	call   800830 <cprintf>
  80054a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80054d:	83 ec 0c             	sub    $0xc,%esp
  800550:	68 bc 1f 80 00       	push   $0x801fbc
  800555:	e8 d6 02 00 00       	call   800830 <cprintf>
  80055a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80055d:	e8 ae 12 00 00       	call   801810 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800562:	e8 19 00 00 00       	call   800580 <exit>
}
  800567:	90                   	nop
  800568:	c9                   	leave  
  800569:	c3                   	ret    

0080056a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80056a:	55                   	push   %ebp
  80056b:	89 e5                	mov    %esp,%ebp
  80056d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800570:	83 ec 0c             	sub    $0xc,%esp
  800573:	6a 00                	push   $0x0
  800575:	e8 ad 10 00 00       	call   801627 <sys_env_destroy>
  80057a:	83 c4 10             	add    $0x10,%esp
}
  80057d:	90                   	nop
  80057e:	c9                   	leave  
  80057f:	c3                   	ret    

00800580 <exit>:

void
exit(void)
{
  800580:	55                   	push   %ebp
  800581:	89 e5                	mov    %esp,%ebp
  800583:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800586:	e8 02 11 00 00       	call   80168d <sys_env_exit>
}
  80058b:	90                   	nop
  80058c:	c9                   	leave  
  80058d:	c3                   	ret    

0080058e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80058e:	55                   	push   %ebp
  80058f:	89 e5                	mov    %esp,%ebp
  800591:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800594:	8d 45 10             	lea    0x10(%ebp),%eax
  800597:	83 c0 04             	add    $0x4,%eax
  80059a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80059d:	a1 18 31 80 00       	mov    0x803118,%eax
  8005a2:	85 c0                	test   %eax,%eax
  8005a4:	74 16                	je     8005bc <_panic+0x2e>
		cprintf("%s: ", argv0);
  8005a6:	a1 18 31 80 00       	mov    0x803118,%eax
  8005ab:	83 ec 08             	sub    $0x8,%esp
  8005ae:	50                   	push   %eax
  8005af:	68 64 20 80 00       	push   $0x802064
  8005b4:	e8 77 02 00 00       	call   800830 <cprintf>
  8005b9:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8005bc:	a1 00 30 80 00       	mov    0x803000,%eax
  8005c1:	ff 75 0c             	pushl  0xc(%ebp)
  8005c4:	ff 75 08             	pushl  0x8(%ebp)
  8005c7:	50                   	push   %eax
  8005c8:	68 69 20 80 00       	push   $0x802069
  8005cd:	e8 5e 02 00 00       	call   800830 <cprintf>
  8005d2:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8005d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8005d8:	83 ec 08             	sub    $0x8,%esp
  8005db:	ff 75 f4             	pushl  -0xc(%ebp)
  8005de:	50                   	push   %eax
  8005df:	e8 e1 01 00 00       	call   8007c5 <vcprintf>
  8005e4:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8005e7:	83 ec 08             	sub    $0x8,%esp
  8005ea:	6a 00                	push   $0x0
  8005ec:	68 85 20 80 00       	push   $0x802085
  8005f1:	e8 cf 01 00 00       	call   8007c5 <vcprintf>
  8005f6:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8005f9:	e8 82 ff ff ff       	call   800580 <exit>

	// should not return here
	while (1) ;
  8005fe:	eb fe                	jmp    8005fe <_panic+0x70>

00800600 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800600:	55                   	push   %ebp
  800601:	89 e5                	mov    %esp,%ebp
  800603:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800606:	a1 20 30 80 00       	mov    0x803020,%eax
  80060b:	8b 50 74             	mov    0x74(%eax),%edx
  80060e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800611:	39 c2                	cmp    %eax,%edx
  800613:	74 14                	je     800629 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800615:	83 ec 04             	sub    $0x4,%esp
  800618:	68 88 20 80 00       	push   $0x802088
  80061d:	6a 26                	push   $0x26
  80061f:	68 d4 20 80 00       	push   $0x8020d4
  800624:	e8 65 ff ff ff       	call   80058e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800629:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800630:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800637:	e9 b6 00 00 00       	jmp    8006f2 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80063c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80063f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800646:	8b 45 08             	mov    0x8(%ebp),%eax
  800649:	01 d0                	add    %edx,%eax
  80064b:	8b 00                	mov    (%eax),%eax
  80064d:	85 c0                	test   %eax,%eax
  80064f:	75 08                	jne    800659 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800651:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800654:	e9 96 00 00 00       	jmp    8006ef <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800659:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800660:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800667:	eb 5d                	jmp    8006c6 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800669:	a1 20 30 80 00       	mov    0x803020,%eax
  80066e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800674:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800677:	c1 e2 04             	shl    $0x4,%edx
  80067a:	01 d0                	add    %edx,%eax
  80067c:	8a 40 04             	mov    0x4(%eax),%al
  80067f:	84 c0                	test   %al,%al
  800681:	75 40                	jne    8006c3 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800683:	a1 20 30 80 00       	mov    0x803020,%eax
  800688:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80068e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800691:	c1 e2 04             	shl    $0x4,%edx
  800694:	01 d0                	add    %edx,%eax
  800696:	8b 00                	mov    (%eax),%eax
  800698:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80069b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80069e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006a3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8006a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006a8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8006af:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b2:	01 c8                	add    %ecx,%eax
  8006b4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8006b6:	39 c2                	cmp    %eax,%edx
  8006b8:	75 09                	jne    8006c3 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8006ba:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8006c1:	eb 12                	jmp    8006d5 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006c3:	ff 45 e8             	incl   -0x18(%ebp)
  8006c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8006cb:	8b 50 74             	mov    0x74(%eax),%edx
  8006ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006d1:	39 c2                	cmp    %eax,%edx
  8006d3:	77 94                	ja     800669 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8006d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8006d9:	75 14                	jne    8006ef <CheckWSWithoutLastIndex+0xef>
			panic(
  8006db:	83 ec 04             	sub    $0x4,%esp
  8006de:	68 e0 20 80 00       	push   $0x8020e0
  8006e3:	6a 3a                	push   $0x3a
  8006e5:	68 d4 20 80 00       	push   $0x8020d4
  8006ea:	e8 9f fe ff ff       	call   80058e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8006ef:	ff 45 f0             	incl   -0x10(%ebp)
  8006f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006f8:	0f 8c 3e ff ff ff    	jl     80063c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8006fe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800705:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80070c:	eb 20                	jmp    80072e <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80070e:	a1 20 30 80 00       	mov    0x803020,%eax
  800713:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800719:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80071c:	c1 e2 04             	shl    $0x4,%edx
  80071f:	01 d0                	add    %edx,%eax
  800721:	8a 40 04             	mov    0x4(%eax),%al
  800724:	3c 01                	cmp    $0x1,%al
  800726:	75 03                	jne    80072b <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800728:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80072b:	ff 45 e0             	incl   -0x20(%ebp)
  80072e:	a1 20 30 80 00       	mov    0x803020,%eax
  800733:	8b 50 74             	mov    0x74(%eax),%edx
  800736:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800739:	39 c2                	cmp    %eax,%edx
  80073b:	77 d1                	ja     80070e <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80073d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800740:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800743:	74 14                	je     800759 <CheckWSWithoutLastIndex+0x159>
		panic(
  800745:	83 ec 04             	sub    $0x4,%esp
  800748:	68 34 21 80 00       	push   $0x802134
  80074d:	6a 44                	push   $0x44
  80074f:	68 d4 20 80 00       	push   $0x8020d4
  800754:	e8 35 fe ff ff       	call   80058e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800759:	90                   	nop
  80075a:	c9                   	leave  
  80075b:	c3                   	ret    

0080075c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80075c:	55                   	push   %ebp
  80075d:	89 e5                	mov    %esp,%ebp
  80075f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800762:	8b 45 0c             	mov    0xc(%ebp),%eax
  800765:	8b 00                	mov    (%eax),%eax
  800767:	8d 48 01             	lea    0x1(%eax),%ecx
  80076a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80076d:	89 0a                	mov    %ecx,(%edx)
  80076f:	8b 55 08             	mov    0x8(%ebp),%edx
  800772:	88 d1                	mov    %dl,%cl
  800774:	8b 55 0c             	mov    0xc(%ebp),%edx
  800777:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80077b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80077e:	8b 00                	mov    (%eax),%eax
  800780:	3d ff 00 00 00       	cmp    $0xff,%eax
  800785:	75 2c                	jne    8007b3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800787:	a0 24 30 80 00       	mov    0x803024,%al
  80078c:	0f b6 c0             	movzbl %al,%eax
  80078f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800792:	8b 12                	mov    (%edx),%edx
  800794:	89 d1                	mov    %edx,%ecx
  800796:	8b 55 0c             	mov    0xc(%ebp),%edx
  800799:	83 c2 08             	add    $0x8,%edx
  80079c:	83 ec 04             	sub    $0x4,%esp
  80079f:	50                   	push   %eax
  8007a0:	51                   	push   %ecx
  8007a1:	52                   	push   %edx
  8007a2:	e8 3e 0e 00 00       	call   8015e5 <sys_cputs>
  8007a7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8007aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8007b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007b6:	8b 40 04             	mov    0x4(%eax),%eax
  8007b9:	8d 50 01             	lea    0x1(%eax),%edx
  8007bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007bf:	89 50 04             	mov    %edx,0x4(%eax)
}
  8007c2:	90                   	nop
  8007c3:	c9                   	leave  
  8007c4:	c3                   	ret    

008007c5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8007c5:	55                   	push   %ebp
  8007c6:	89 e5                	mov    %esp,%ebp
  8007c8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8007ce:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8007d5:	00 00 00 
	b.cnt = 0;
  8007d8:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8007df:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8007e2:	ff 75 0c             	pushl  0xc(%ebp)
  8007e5:	ff 75 08             	pushl  0x8(%ebp)
  8007e8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007ee:	50                   	push   %eax
  8007ef:	68 5c 07 80 00       	push   $0x80075c
  8007f4:	e8 11 02 00 00       	call   800a0a <vprintfmt>
  8007f9:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8007fc:	a0 24 30 80 00       	mov    0x803024,%al
  800801:	0f b6 c0             	movzbl %al,%eax
  800804:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80080a:	83 ec 04             	sub    $0x4,%esp
  80080d:	50                   	push   %eax
  80080e:	52                   	push   %edx
  80080f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800815:	83 c0 08             	add    $0x8,%eax
  800818:	50                   	push   %eax
  800819:	e8 c7 0d 00 00       	call   8015e5 <sys_cputs>
  80081e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800821:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800828:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80082e:	c9                   	leave  
  80082f:	c3                   	ret    

00800830 <cprintf>:

int cprintf(const char *fmt, ...) {
  800830:	55                   	push   %ebp
  800831:	89 e5                	mov    %esp,%ebp
  800833:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800836:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80083d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800840:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800843:	8b 45 08             	mov    0x8(%ebp),%eax
  800846:	83 ec 08             	sub    $0x8,%esp
  800849:	ff 75 f4             	pushl  -0xc(%ebp)
  80084c:	50                   	push   %eax
  80084d:	e8 73 ff ff ff       	call   8007c5 <vcprintf>
  800852:	83 c4 10             	add    $0x10,%esp
  800855:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800858:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80085b:	c9                   	leave  
  80085c:	c3                   	ret    

0080085d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80085d:	55                   	push   %ebp
  80085e:	89 e5                	mov    %esp,%ebp
  800860:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800863:	e8 8e 0f 00 00       	call   8017f6 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800868:	8d 45 0c             	lea    0xc(%ebp),%eax
  80086b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80086e:	8b 45 08             	mov    0x8(%ebp),%eax
  800871:	83 ec 08             	sub    $0x8,%esp
  800874:	ff 75 f4             	pushl  -0xc(%ebp)
  800877:	50                   	push   %eax
  800878:	e8 48 ff ff ff       	call   8007c5 <vcprintf>
  80087d:	83 c4 10             	add    $0x10,%esp
  800880:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800883:	e8 88 0f 00 00       	call   801810 <sys_enable_interrupt>
	return cnt;
  800888:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80088b:	c9                   	leave  
  80088c:	c3                   	ret    

0080088d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80088d:	55                   	push   %ebp
  80088e:	89 e5                	mov    %esp,%ebp
  800890:	53                   	push   %ebx
  800891:	83 ec 14             	sub    $0x14,%esp
  800894:	8b 45 10             	mov    0x10(%ebp),%eax
  800897:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80089a:	8b 45 14             	mov    0x14(%ebp),%eax
  80089d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8008a0:	8b 45 18             	mov    0x18(%ebp),%eax
  8008a3:	ba 00 00 00 00       	mov    $0x0,%edx
  8008a8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008ab:	77 55                	ja     800902 <printnum+0x75>
  8008ad:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008b0:	72 05                	jb     8008b7 <printnum+0x2a>
  8008b2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8008b5:	77 4b                	ja     800902 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8008b7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8008ba:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8008bd:	8b 45 18             	mov    0x18(%ebp),%eax
  8008c0:	ba 00 00 00 00       	mov    $0x0,%edx
  8008c5:	52                   	push   %edx
  8008c6:	50                   	push   %eax
  8008c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ca:	ff 75 f0             	pushl  -0x10(%ebp)
  8008cd:	e8 46 13 00 00       	call   801c18 <__udivdi3>
  8008d2:	83 c4 10             	add    $0x10,%esp
  8008d5:	83 ec 04             	sub    $0x4,%esp
  8008d8:	ff 75 20             	pushl  0x20(%ebp)
  8008db:	53                   	push   %ebx
  8008dc:	ff 75 18             	pushl  0x18(%ebp)
  8008df:	52                   	push   %edx
  8008e0:	50                   	push   %eax
  8008e1:	ff 75 0c             	pushl  0xc(%ebp)
  8008e4:	ff 75 08             	pushl  0x8(%ebp)
  8008e7:	e8 a1 ff ff ff       	call   80088d <printnum>
  8008ec:	83 c4 20             	add    $0x20,%esp
  8008ef:	eb 1a                	jmp    80090b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008f1:	83 ec 08             	sub    $0x8,%esp
  8008f4:	ff 75 0c             	pushl  0xc(%ebp)
  8008f7:	ff 75 20             	pushl  0x20(%ebp)
  8008fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fd:	ff d0                	call   *%eax
  8008ff:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800902:	ff 4d 1c             	decl   0x1c(%ebp)
  800905:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800909:	7f e6                	jg     8008f1 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80090b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80090e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800913:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800916:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800919:	53                   	push   %ebx
  80091a:	51                   	push   %ecx
  80091b:	52                   	push   %edx
  80091c:	50                   	push   %eax
  80091d:	e8 06 14 00 00       	call   801d28 <__umoddi3>
  800922:	83 c4 10             	add    $0x10,%esp
  800925:	05 94 23 80 00       	add    $0x802394,%eax
  80092a:	8a 00                	mov    (%eax),%al
  80092c:	0f be c0             	movsbl %al,%eax
  80092f:	83 ec 08             	sub    $0x8,%esp
  800932:	ff 75 0c             	pushl  0xc(%ebp)
  800935:	50                   	push   %eax
  800936:	8b 45 08             	mov    0x8(%ebp),%eax
  800939:	ff d0                	call   *%eax
  80093b:	83 c4 10             	add    $0x10,%esp
}
  80093e:	90                   	nop
  80093f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800942:	c9                   	leave  
  800943:	c3                   	ret    

00800944 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800944:	55                   	push   %ebp
  800945:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800947:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80094b:	7e 1c                	jle    800969 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80094d:	8b 45 08             	mov    0x8(%ebp),%eax
  800950:	8b 00                	mov    (%eax),%eax
  800952:	8d 50 08             	lea    0x8(%eax),%edx
  800955:	8b 45 08             	mov    0x8(%ebp),%eax
  800958:	89 10                	mov    %edx,(%eax)
  80095a:	8b 45 08             	mov    0x8(%ebp),%eax
  80095d:	8b 00                	mov    (%eax),%eax
  80095f:	83 e8 08             	sub    $0x8,%eax
  800962:	8b 50 04             	mov    0x4(%eax),%edx
  800965:	8b 00                	mov    (%eax),%eax
  800967:	eb 40                	jmp    8009a9 <getuint+0x65>
	else if (lflag)
  800969:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80096d:	74 1e                	je     80098d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80096f:	8b 45 08             	mov    0x8(%ebp),%eax
  800972:	8b 00                	mov    (%eax),%eax
  800974:	8d 50 04             	lea    0x4(%eax),%edx
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	89 10                	mov    %edx,(%eax)
  80097c:	8b 45 08             	mov    0x8(%ebp),%eax
  80097f:	8b 00                	mov    (%eax),%eax
  800981:	83 e8 04             	sub    $0x4,%eax
  800984:	8b 00                	mov    (%eax),%eax
  800986:	ba 00 00 00 00       	mov    $0x0,%edx
  80098b:	eb 1c                	jmp    8009a9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80098d:	8b 45 08             	mov    0x8(%ebp),%eax
  800990:	8b 00                	mov    (%eax),%eax
  800992:	8d 50 04             	lea    0x4(%eax),%edx
  800995:	8b 45 08             	mov    0x8(%ebp),%eax
  800998:	89 10                	mov    %edx,(%eax)
  80099a:	8b 45 08             	mov    0x8(%ebp),%eax
  80099d:	8b 00                	mov    (%eax),%eax
  80099f:	83 e8 04             	sub    $0x4,%eax
  8009a2:	8b 00                	mov    (%eax),%eax
  8009a4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8009a9:	5d                   	pop    %ebp
  8009aa:	c3                   	ret    

008009ab <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8009ab:	55                   	push   %ebp
  8009ac:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009ae:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009b2:	7e 1c                	jle    8009d0 <getint+0x25>
		return va_arg(*ap, long long);
  8009b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b7:	8b 00                	mov    (%eax),%eax
  8009b9:	8d 50 08             	lea    0x8(%eax),%edx
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	89 10                	mov    %edx,(%eax)
  8009c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c4:	8b 00                	mov    (%eax),%eax
  8009c6:	83 e8 08             	sub    $0x8,%eax
  8009c9:	8b 50 04             	mov    0x4(%eax),%edx
  8009cc:	8b 00                	mov    (%eax),%eax
  8009ce:	eb 38                	jmp    800a08 <getint+0x5d>
	else if (lflag)
  8009d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009d4:	74 1a                	je     8009f0 <getint+0x45>
		return va_arg(*ap, long);
  8009d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d9:	8b 00                	mov    (%eax),%eax
  8009db:	8d 50 04             	lea    0x4(%eax),%edx
  8009de:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e1:	89 10                	mov    %edx,(%eax)
  8009e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e6:	8b 00                	mov    (%eax),%eax
  8009e8:	83 e8 04             	sub    $0x4,%eax
  8009eb:	8b 00                	mov    (%eax),%eax
  8009ed:	99                   	cltd   
  8009ee:	eb 18                	jmp    800a08 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f3:	8b 00                	mov    (%eax),%eax
  8009f5:	8d 50 04             	lea    0x4(%eax),%edx
  8009f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fb:	89 10                	mov    %edx,(%eax)
  8009fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800a00:	8b 00                	mov    (%eax),%eax
  800a02:	83 e8 04             	sub    $0x4,%eax
  800a05:	8b 00                	mov    (%eax),%eax
  800a07:	99                   	cltd   
}
  800a08:	5d                   	pop    %ebp
  800a09:	c3                   	ret    

00800a0a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a0a:	55                   	push   %ebp
  800a0b:	89 e5                	mov    %esp,%ebp
  800a0d:	56                   	push   %esi
  800a0e:	53                   	push   %ebx
  800a0f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a12:	eb 17                	jmp    800a2b <vprintfmt+0x21>
			if (ch == '\0')
  800a14:	85 db                	test   %ebx,%ebx
  800a16:	0f 84 af 03 00 00    	je     800dcb <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800a1c:	83 ec 08             	sub    $0x8,%esp
  800a1f:	ff 75 0c             	pushl  0xc(%ebp)
  800a22:	53                   	push   %ebx
  800a23:	8b 45 08             	mov    0x8(%ebp),%eax
  800a26:	ff d0                	call   *%eax
  800a28:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a2e:	8d 50 01             	lea    0x1(%eax),%edx
  800a31:	89 55 10             	mov    %edx,0x10(%ebp)
  800a34:	8a 00                	mov    (%eax),%al
  800a36:	0f b6 d8             	movzbl %al,%ebx
  800a39:	83 fb 25             	cmp    $0x25,%ebx
  800a3c:	75 d6                	jne    800a14 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a3e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a42:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a49:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a50:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a57:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800a61:	8d 50 01             	lea    0x1(%eax),%edx
  800a64:	89 55 10             	mov    %edx,0x10(%ebp)
  800a67:	8a 00                	mov    (%eax),%al
  800a69:	0f b6 d8             	movzbl %al,%ebx
  800a6c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a6f:	83 f8 55             	cmp    $0x55,%eax
  800a72:	0f 87 2b 03 00 00    	ja     800da3 <vprintfmt+0x399>
  800a78:	8b 04 85 b8 23 80 00 	mov    0x8023b8(,%eax,4),%eax
  800a7f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a81:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a85:	eb d7                	jmp    800a5e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a87:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a8b:	eb d1                	jmp    800a5e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a8d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a94:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a97:	89 d0                	mov    %edx,%eax
  800a99:	c1 e0 02             	shl    $0x2,%eax
  800a9c:	01 d0                	add    %edx,%eax
  800a9e:	01 c0                	add    %eax,%eax
  800aa0:	01 d8                	add    %ebx,%eax
  800aa2:	83 e8 30             	sub    $0x30,%eax
  800aa5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800aa8:	8b 45 10             	mov    0x10(%ebp),%eax
  800aab:	8a 00                	mov    (%eax),%al
  800aad:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ab0:	83 fb 2f             	cmp    $0x2f,%ebx
  800ab3:	7e 3e                	jle    800af3 <vprintfmt+0xe9>
  800ab5:	83 fb 39             	cmp    $0x39,%ebx
  800ab8:	7f 39                	jg     800af3 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800aba:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800abd:	eb d5                	jmp    800a94 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800abf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac2:	83 c0 04             	add    $0x4,%eax
  800ac5:	89 45 14             	mov    %eax,0x14(%ebp)
  800ac8:	8b 45 14             	mov    0x14(%ebp),%eax
  800acb:	83 e8 04             	sub    $0x4,%eax
  800ace:	8b 00                	mov    (%eax),%eax
  800ad0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ad3:	eb 1f                	jmp    800af4 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ad5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ad9:	79 83                	jns    800a5e <vprintfmt+0x54>
				width = 0;
  800adb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ae2:	e9 77 ff ff ff       	jmp    800a5e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ae7:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800aee:	e9 6b ff ff ff       	jmp    800a5e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800af3:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800af4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800af8:	0f 89 60 ff ff ff    	jns    800a5e <vprintfmt+0x54>
				width = precision, precision = -1;
  800afe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b01:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b04:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b0b:	e9 4e ff ff ff       	jmp    800a5e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b10:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b13:	e9 46 ff ff ff       	jmp    800a5e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b18:	8b 45 14             	mov    0x14(%ebp),%eax
  800b1b:	83 c0 04             	add    $0x4,%eax
  800b1e:	89 45 14             	mov    %eax,0x14(%ebp)
  800b21:	8b 45 14             	mov    0x14(%ebp),%eax
  800b24:	83 e8 04             	sub    $0x4,%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	83 ec 08             	sub    $0x8,%esp
  800b2c:	ff 75 0c             	pushl  0xc(%ebp)
  800b2f:	50                   	push   %eax
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	ff d0                	call   *%eax
  800b35:	83 c4 10             	add    $0x10,%esp
			break;
  800b38:	e9 89 02 00 00       	jmp    800dc6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b40:	83 c0 04             	add    $0x4,%eax
  800b43:	89 45 14             	mov    %eax,0x14(%ebp)
  800b46:	8b 45 14             	mov    0x14(%ebp),%eax
  800b49:	83 e8 04             	sub    $0x4,%eax
  800b4c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b4e:	85 db                	test   %ebx,%ebx
  800b50:	79 02                	jns    800b54 <vprintfmt+0x14a>
				err = -err;
  800b52:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b54:	83 fb 64             	cmp    $0x64,%ebx
  800b57:	7f 0b                	jg     800b64 <vprintfmt+0x15a>
  800b59:	8b 34 9d 00 22 80 00 	mov    0x802200(,%ebx,4),%esi
  800b60:	85 f6                	test   %esi,%esi
  800b62:	75 19                	jne    800b7d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b64:	53                   	push   %ebx
  800b65:	68 a5 23 80 00       	push   $0x8023a5
  800b6a:	ff 75 0c             	pushl  0xc(%ebp)
  800b6d:	ff 75 08             	pushl  0x8(%ebp)
  800b70:	e8 5e 02 00 00       	call   800dd3 <printfmt>
  800b75:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b78:	e9 49 02 00 00       	jmp    800dc6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b7d:	56                   	push   %esi
  800b7e:	68 ae 23 80 00       	push   $0x8023ae
  800b83:	ff 75 0c             	pushl  0xc(%ebp)
  800b86:	ff 75 08             	pushl  0x8(%ebp)
  800b89:	e8 45 02 00 00       	call   800dd3 <printfmt>
  800b8e:	83 c4 10             	add    $0x10,%esp
			break;
  800b91:	e9 30 02 00 00       	jmp    800dc6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b96:	8b 45 14             	mov    0x14(%ebp),%eax
  800b99:	83 c0 04             	add    $0x4,%eax
  800b9c:	89 45 14             	mov    %eax,0x14(%ebp)
  800b9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800ba2:	83 e8 04             	sub    $0x4,%eax
  800ba5:	8b 30                	mov    (%eax),%esi
  800ba7:	85 f6                	test   %esi,%esi
  800ba9:	75 05                	jne    800bb0 <vprintfmt+0x1a6>
				p = "(null)";
  800bab:	be b1 23 80 00       	mov    $0x8023b1,%esi
			if (width > 0 && padc != '-')
  800bb0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bb4:	7e 6d                	jle    800c23 <vprintfmt+0x219>
  800bb6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800bba:	74 67                	je     800c23 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800bbc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bbf:	83 ec 08             	sub    $0x8,%esp
  800bc2:	50                   	push   %eax
  800bc3:	56                   	push   %esi
  800bc4:	e8 0c 03 00 00       	call   800ed5 <strnlen>
  800bc9:	83 c4 10             	add    $0x10,%esp
  800bcc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800bcf:	eb 16                	jmp    800be7 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bd1:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bd5:	83 ec 08             	sub    $0x8,%esp
  800bd8:	ff 75 0c             	pushl  0xc(%ebp)
  800bdb:	50                   	push   %eax
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	ff d0                	call   *%eax
  800be1:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800be4:	ff 4d e4             	decl   -0x1c(%ebp)
  800be7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800beb:	7f e4                	jg     800bd1 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bed:	eb 34                	jmp    800c23 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bef:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bf3:	74 1c                	je     800c11 <vprintfmt+0x207>
  800bf5:	83 fb 1f             	cmp    $0x1f,%ebx
  800bf8:	7e 05                	jle    800bff <vprintfmt+0x1f5>
  800bfa:	83 fb 7e             	cmp    $0x7e,%ebx
  800bfd:	7e 12                	jle    800c11 <vprintfmt+0x207>
					putch('?', putdat);
  800bff:	83 ec 08             	sub    $0x8,%esp
  800c02:	ff 75 0c             	pushl  0xc(%ebp)
  800c05:	6a 3f                	push   $0x3f
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	ff d0                	call   *%eax
  800c0c:	83 c4 10             	add    $0x10,%esp
  800c0f:	eb 0f                	jmp    800c20 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c11:	83 ec 08             	sub    $0x8,%esp
  800c14:	ff 75 0c             	pushl  0xc(%ebp)
  800c17:	53                   	push   %ebx
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	ff d0                	call   *%eax
  800c1d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c20:	ff 4d e4             	decl   -0x1c(%ebp)
  800c23:	89 f0                	mov    %esi,%eax
  800c25:	8d 70 01             	lea    0x1(%eax),%esi
  800c28:	8a 00                	mov    (%eax),%al
  800c2a:	0f be d8             	movsbl %al,%ebx
  800c2d:	85 db                	test   %ebx,%ebx
  800c2f:	74 24                	je     800c55 <vprintfmt+0x24b>
  800c31:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c35:	78 b8                	js     800bef <vprintfmt+0x1e5>
  800c37:	ff 4d e0             	decl   -0x20(%ebp)
  800c3a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c3e:	79 af                	jns    800bef <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c40:	eb 13                	jmp    800c55 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c42:	83 ec 08             	sub    $0x8,%esp
  800c45:	ff 75 0c             	pushl  0xc(%ebp)
  800c48:	6a 20                	push   $0x20
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	ff d0                	call   *%eax
  800c4f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c52:	ff 4d e4             	decl   -0x1c(%ebp)
  800c55:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c59:	7f e7                	jg     800c42 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c5b:	e9 66 01 00 00       	jmp    800dc6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c60:	83 ec 08             	sub    $0x8,%esp
  800c63:	ff 75 e8             	pushl  -0x18(%ebp)
  800c66:	8d 45 14             	lea    0x14(%ebp),%eax
  800c69:	50                   	push   %eax
  800c6a:	e8 3c fd ff ff       	call   8009ab <getint>
  800c6f:	83 c4 10             	add    $0x10,%esp
  800c72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c75:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c78:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c7e:	85 d2                	test   %edx,%edx
  800c80:	79 23                	jns    800ca5 <vprintfmt+0x29b>
				putch('-', putdat);
  800c82:	83 ec 08             	sub    $0x8,%esp
  800c85:	ff 75 0c             	pushl  0xc(%ebp)
  800c88:	6a 2d                	push   $0x2d
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	ff d0                	call   *%eax
  800c8f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c92:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c95:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c98:	f7 d8                	neg    %eax
  800c9a:	83 d2 00             	adc    $0x0,%edx
  800c9d:	f7 da                	neg    %edx
  800c9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ca5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cac:	e9 bc 00 00 00       	jmp    800d6d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800cb1:	83 ec 08             	sub    $0x8,%esp
  800cb4:	ff 75 e8             	pushl  -0x18(%ebp)
  800cb7:	8d 45 14             	lea    0x14(%ebp),%eax
  800cba:	50                   	push   %eax
  800cbb:	e8 84 fc ff ff       	call   800944 <getuint>
  800cc0:	83 c4 10             	add    $0x10,%esp
  800cc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800cc9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cd0:	e9 98 00 00 00       	jmp    800d6d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cd5:	83 ec 08             	sub    $0x8,%esp
  800cd8:	ff 75 0c             	pushl  0xc(%ebp)
  800cdb:	6a 58                	push   $0x58
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	ff d0                	call   *%eax
  800ce2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ce5:	83 ec 08             	sub    $0x8,%esp
  800ce8:	ff 75 0c             	pushl  0xc(%ebp)
  800ceb:	6a 58                	push   $0x58
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	ff d0                	call   *%eax
  800cf2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cf5:	83 ec 08             	sub    $0x8,%esp
  800cf8:	ff 75 0c             	pushl  0xc(%ebp)
  800cfb:	6a 58                	push   $0x58
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	ff d0                	call   *%eax
  800d02:	83 c4 10             	add    $0x10,%esp
			break;
  800d05:	e9 bc 00 00 00       	jmp    800dc6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800d0a:	83 ec 08             	sub    $0x8,%esp
  800d0d:	ff 75 0c             	pushl  0xc(%ebp)
  800d10:	6a 30                	push   $0x30
  800d12:	8b 45 08             	mov    0x8(%ebp),%eax
  800d15:	ff d0                	call   *%eax
  800d17:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d1a:	83 ec 08             	sub    $0x8,%esp
  800d1d:	ff 75 0c             	pushl  0xc(%ebp)
  800d20:	6a 78                	push   $0x78
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	ff d0                	call   *%eax
  800d27:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d2a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2d:	83 c0 04             	add    $0x4,%eax
  800d30:	89 45 14             	mov    %eax,0x14(%ebp)
  800d33:	8b 45 14             	mov    0x14(%ebp),%eax
  800d36:	83 e8 04             	sub    $0x4,%eax
  800d39:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d45:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d4c:	eb 1f                	jmp    800d6d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d4e:	83 ec 08             	sub    $0x8,%esp
  800d51:	ff 75 e8             	pushl  -0x18(%ebp)
  800d54:	8d 45 14             	lea    0x14(%ebp),%eax
  800d57:	50                   	push   %eax
  800d58:	e8 e7 fb ff ff       	call   800944 <getuint>
  800d5d:	83 c4 10             	add    $0x10,%esp
  800d60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d63:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d66:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d6d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d71:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d74:	83 ec 04             	sub    $0x4,%esp
  800d77:	52                   	push   %edx
  800d78:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d7b:	50                   	push   %eax
  800d7c:	ff 75 f4             	pushl  -0xc(%ebp)
  800d7f:	ff 75 f0             	pushl  -0x10(%ebp)
  800d82:	ff 75 0c             	pushl  0xc(%ebp)
  800d85:	ff 75 08             	pushl  0x8(%ebp)
  800d88:	e8 00 fb ff ff       	call   80088d <printnum>
  800d8d:	83 c4 20             	add    $0x20,%esp
			break;
  800d90:	eb 34                	jmp    800dc6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d92:	83 ec 08             	sub    $0x8,%esp
  800d95:	ff 75 0c             	pushl  0xc(%ebp)
  800d98:	53                   	push   %ebx
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	ff d0                	call   *%eax
  800d9e:	83 c4 10             	add    $0x10,%esp
			break;
  800da1:	eb 23                	jmp    800dc6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800da3:	83 ec 08             	sub    $0x8,%esp
  800da6:	ff 75 0c             	pushl  0xc(%ebp)
  800da9:	6a 25                	push   $0x25
  800dab:	8b 45 08             	mov    0x8(%ebp),%eax
  800dae:	ff d0                	call   *%eax
  800db0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800db3:	ff 4d 10             	decl   0x10(%ebp)
  800db6:	eb 03                	jmp    800dbb <vprintfmt+0x3b1>
  800db8:	ff 4d 10             	decl   0x10(%ebp)
  800dbb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbe:	48                   	dec    %eax
  800dbf:	8a 00                	mov    (%eax),%al
  800dc1:	3c 25                	cmp    $0x25,%al
  800dc3:	75 f3                	jne    800db8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800dc5:	90                   	nop
		}
	}
  800dc6:	e9 47 fc ff ff       	jmp    800a12 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800dcb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800dcc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800dcf:	5b                   	pop    %ebx
  800dd0:	5e                   	pop    %esi
  800dd1:	5d                   	pop    %ebp
  800dd2:	c3                   	ret    

00800dd3 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800dd3:	55                   	push   %ebp
  800dd4:	89 e5                	mov    %esp,%ebp
  800dd6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800dd9:	8d 45 10             	lea    0x10(%ebp),%eax
  800ddc:	83 c0 04             	add    $0x4,%eax
  800ddf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800de2:	8b 45 10             	mov    0x10(%ebp),%eax
  800de5:	ff 75 f4             	pushl  -0xc(%ebp)
  800de8:	50                   	push   %eax
  800de9:	ff 75 0c             	pushl  0xc(%ebp)
  800dec:	ff 75 08             	pushl  0x8(%ebp)
  800def:	e8 16 fc ff ff       	call   800a0a <vprintfmt>
  800df4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800df7:	90                   	nop
  800df8:	c9                   	leave  
  800df9:	c3                   	ret    

00800dfa <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800dfa:	55                   	push   %ebp
  800dfb:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e00:	8b 40 08             	mov    0x8(%eax),%eax
  800e03:	8d 50 01             	lea    0x1(%eax),%edx
  800e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e09:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0f:	8b 10                	mov    (%eax),%edx
  800e11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e14:	8b 40 04             	mov    0x4(%eax),%eax
  800e17:	39 c2                	cmp    %eax,%edx
  800e19:	73 12                	jae    800e2d <sprintputch+0x33>
		*b->buf++ = ch;
  800e1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1e:	8b 00                	mov    (%eax),%eax
  800e20:	8d 48 01             	lea    0x1(%eax),%ecx
  800e23:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e26:	89 0a                	mov    %ecx,(%edx)
  800e28:	8b 55 08             	mov    0x8(%ebp),%edx
  800e2b:	88 10                	mov    %dl,(%eax)
}
  800e2d:	90                   	nop
  800e2e:	5d                   	pop    %ebp
  800e2f:	c3                   	ret    

00800e30 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e30:	55                   	push   %ebp
  800e31:	89 e5                	mov    %esp,%ebp
  800e33:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e36:	8b 45 08             	mov    0x8(%ebp),%eax
  800e39:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e42:	8b 45 08             	mov    0x8(%ebp),%eax
  800e45:	01 d0                	add    %edx,%eax
  800e47:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e4a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e51:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e55:	74 06                	je     800e5d <vsnprintf+0x2d>
  800e57:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e5b:	7f 07                	jg     800e64 <vsnprintf+0x34>
		return -E_INVAL;
  800e5d:	b8 03 00 00 00       	mov    $0x3,%eax
  800e62:	eb 20                	jmp    800e84 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e64:	ff 75 14             	pushl  0x14(%ebp)
  800e67:	ff 75 10             	pushl  0x10(%ebp)
  800e6a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e6d:	50                   	push   %eax
  800e6e:	68 fa 0d 80 00       	push   $0x800dfa
  800e73:	e8 92 fb ff ff       	call   800a0a <vprintfmt>
  800e78:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e7e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e81:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e84:	c9                   	leave  
  800e85:	c3                   	ret    

00800e86 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e86:	55                   	push   %ebp
  800e87:	89 e5                	mov    %esp,%ebp
  800e89:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e8c:	8d 45 10             	lea    0x10(%ebp),%eax
  800e8f:	83 c0 04             	add    $0x4,%eax
  800e92:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e95:	8b 45 10             	mov    0x10(%ebp),%eax
  800e98:	ff 75 f4             	pushl  -0xc(%ebp)
  800e9b:	50                   	push   %eax
  800e9c:	ff 75 0c             	pushl  0xc(%ebp)
  800e9f:	ff 75 08             	pushl  0x8(%ebp)
  800ea2:	e8 89 ff ff ff       	call   800e30 <vsnprintf>
  800ea7:	83 c4 10             	add    $0x10,%esp
  800eaa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ead:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800eb0:	c9                   	leave  
  800eb1:	c3                   	ret    

00800eb2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800eb2:	55                   	push   %ebp
  800eb3:	89 e5                	mov    %esp,%ebp
  800eb5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800eb8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ebf:	eb 06                	jmp    800ec7 <strlen+0x15>
		n++;
  800ec1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ec4:	ff 45 08             	incl   0x8(%ebp)
  800ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eca:	8a 00                	mov    (%eax),%al
  800ecc:	84 c0                	test   %al,%al
  800ece:	75 f1                	jne    800ec1 <strlen+0xf>
		n++;
	return n;
  800ed0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ed3:	c9                   	leave  
  800ed4:	c3                   	ret    

00800ed5 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ed5:	55                   	push   %ebp
  800ed6:	89 e5                	mov    %esp,%ebp
  800ed8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800edb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ee2:	eb 09                	jmp    800eed <strnlen+0x18>
		n++;
  800ee4:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ee7:	ff 45 08             	incl   0x8(%ebp)
  800eea:	ff 4d 0c             	decl   0xc(%ebp)
  800eed:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ef1:	74 09                	je     800efc <strnlen+0x27>
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	8a 00                	mov    (%eax),%al
  800ef8:	84 c0                	test   %al,%al
  800efa:	75 e8                	jne    800ee4 <strnlen+0xf>
		n++;
	return n;
  800efc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eff:	c9                   	leave  
  800f00:	c3                   	ret    

00800f01 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f01:	55                   	push   %ebp
  800f02:	89 e5                	mov    %esp,%ebp
  800f04:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f0d:	90                   	nop
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	8d 50 01             	lea    0x1(%eax),%edx
  800f14:	89 55 08             	mov    %edx,0x8(%ebp)
  800f17:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f1a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f1d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f20:	8a 12                	mov    (%edx),%dl
  800f22:	88 10                	mov    %dl,(%eax)
  800f24:	8a 00                	mov    (%eax),%al
  800f26:	84 c0                	test   %al,%al
  800f28:	75 e4                	jne    800f0e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f2d:	c9                   	leave  
  800f2e:	c3                   	ret    

00800f2f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f2f:	55                   	push   %ebp
  800f30:	89 e5                	mov    %esp,%ebp
  800f32:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f3b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f42:	eb 1f                	jmp    800f63 <strncpy+0x34>
		*dst++ = *src;
  800f44:	8b 45 08             	mov    0x8(%ebp),%eax
  800f47:	8d 50 01             	lea    0x1(%eax),%edx
  800f4a:	89 55 08             	mov    %edx,0x8(%ebp)
  800f4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f50:	8a 12                	mov    (%edx),%dl
  800f52:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f57:	8a 00                	mov    (%eax),%al
  800f59:	84 c0                	test   %al,%al
  800f5b:	74 03                	je     800f60 <strncpy+0x31>
			src++;
  800f5d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f60:	ff 45 fc             	incl   -0x4(%ebp)
  800f63:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f66:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f69:	72 d9                	jb     800f44 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f6e:	c9                   	leave  
  800f6f:	c3                   	ret    

00800f70 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f70:	55                   	push   %ebp
  800f71:	89 e5                	mov    %esp,%ebp
  800f73:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f7c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f80:	74 30                	je     800fb2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f82:	eb 16                	jmp    800f9a <strlcpy+0x2a>
			*dst++ = *src++;
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	8d 50 01             	lea    0x1(%eax),%edx
  800f8a:	89 55 08             	mov    %edx,0x8(%ebp)
  800f8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f90:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f93:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f96:	8a 12                	mov    (%edx),%dl
  800f98:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f9a:	ff 4d 10             	decl   0x10(%ebp)
  800f9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa1:	74 09                	je     800fac <strlcpy+0x3c>
  800fa3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa6:	8a 00                	mov    (%eax),%al
  800fa8:	84 c0                	test   %al,%al
  800faa:	75 d8                	jne    800f84 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800fb2:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb8:	29 c2                	sub    %eax,%edx
  800fba:	89 d0                	mov    %edx,%eax
}
  800fbc:	c9                   	leave  
  800fbd:	c3                   	ret    

00800fbe <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fbe:	55                   	push   %ebp
  800fbf:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fc1:	eb 06                	jmp    800fc9 <strcmp+0xb>
		p++, q++;
  800fc3:	ff 45 08             	incl   0x8(%ebp)
  800fc6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	8a 00                	mov    (%eax),%al
  800fce:	84 c0                	test   %al,%al
  800fd0:	74 0e                	je     800fe0 <strcmp+0x22>
  800fd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd5:	8a 10                	mov    (%eax),%dl
  800fd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	38 c2                	cmp    %al,%dl
  800fde:	74 e3                	je     800fc3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	0f b6 d0             	movzbl %al,%edx
  800fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800feb:	8a 00                	mov    (%eax),%al
  800fed:	0f b6 c0             	movzbl %al,%eax
  800ff0:	29 c2                	sub    %eax,%edx
  800ff2:	89 d0                	mov    %edx,%eax
}
  800ff4:	5d                   	pop    %ebp
  800ff5:	c3                   	ret    

00800ff6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ff6:	55                   	push   %ebp
  800ff7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ff9:	eb 09                	jmp    801004 <strncmp+0xe>
		n--, p++, q++;
  800ffb:	ff 4d 10             	decl   0x10(%ebp)
  800ffe:	ff 45 08             	incl   0x8(%ebp)
  801001:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801004:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801008:	74 17                	je     801021 <strncmp+0x2b>
  80100a:	8b 45 08             	mov    0x8(%ebp),%eax
  80100d:	8a 00                	mov    (%eax),%al
  80100f:	84 c0                	test   %al,%al
  801011:	74 0e                	je     801021 <strncmp+0x2b>
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	8a 10                	mov    (%eax),%dl
  801018:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101b:	8a 00                	mov    (%eax),%al
  80101d:	38 c2                	cmp    %al,%dl
  80101f:	74 da                	je     800ffb <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801021:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801025:	75 07                	jne    80102e <strncmp+0x38>
		return 0;
  801027:	b8 00 00 00 00       	mov    $0x0,%eax
  80102c:	eb 14                	jmp    801042 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	8a 00                	mov    (%eax),%al
  801033:	0f b6 d0             	movzbl %al,%edx
  801036:	8b 45 0c             	mov    0xc(%ebp),%eax
  801039:	8a 00                	mov    (%eax),%al
  80103b:	0f b6 c0             	movzbl %al,%eax
  80103e:	29 c2                	sub    %eax,%edx
  801040:	89 d0                	mov    %edx,%eax
}
  801042:	5d                   	pop    %ebp
  801043:	c3                   	ret    

00801044 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801044:	55                   	push   %ebp
  801045:	89 e5                	mov    %esp,%ebp
  801047:	83 ec 04             	sub    $0x4,%esp
  80104a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801050:	eb 12                	jmp    801064 <strchr+0x20>
		if (*s == c)
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	8a 00                	mov    (%eax),%al
  801057:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80105a:	75 05                	jne    801061 <strchr+0x1d>
			return (char *) s;
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	eb 11                	jmp    801072 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801061:	ff 45 08             	incl   0x8(%ebp)
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	8a 00                	mov    (%eax),%al
  801069:	84 c0                	test   %al,%al
  80106b:	75 e5                	jne    801052 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80106d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801072:	c9                   	leave  
  801073:	c3                   	ret    

00801074 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801074:	55                   	push   %ebp
  801075:	89 e5                	mov    %esp,%ebp
  801077:	83 ec 04             	sub    $0x4,%esp
  80107a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801080:	eb 0d                	jmp    80108f <strfind+0x1b>
		if (*s == c)
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
  801085:	8a 00                	mov    (%eax),%al
  801087:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80108a:	74 0e                	je     80109a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80108c:	ff 45 08             	incl   0x8(%ebp)
  80108f:	8b 45 08             	mov    0x8(%ebp),%eax
  801092:	8a 00                	mov    (%eax),%al
  801094:	84 c0                	test   %al,%al
  801096:	75 ea                	jne    801082 <strfind+0xe>
  801098:	eb 01                	jmp    80109b <strfind+0x27>
		if (*s == c)
			break;
  80109a:	90                   	nop
	return (char *) s;
  80109b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80109e:	c9                   	leave  
  80109f:	c3                   	ret    

008010a0 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8010a0:	55                   	push   %ebp
  8010a1:	89 e5                	mov    %esp,%ebp
  8010a3:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8010a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8010ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8010af:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8010b2:	eb 0e                	jmp    8010c2 <memset+0x22>
		*p++ = c;
  8010b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010b7:	8d 50 01             	lea    0x1(%eax),%edx
  8010ba:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c0:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8010c2:	ff 4d f8             	decl   -0x8(%ebp)
  8010c5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8010c9:	79 e9                	jns    8010b4 <memset+0x14>
		*p++ = c;

	return v;
  8010cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010ce:	c9                   	leave  
  8010cf:	c3                   	ret    

008010d0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8010d0:	55                   	push   %ebp
  8010d1:	89 e5                	mov    %esp,%ebp
  8010d3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010df:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8010e2:	eb 16                	jmp    8010fa <memcpy+0x2a>
		*d++ = *s++;
  8010e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e7:	8d 50 01             	lea    0x1(%eax),%edx
  8010ea:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010ed:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010f0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010f3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010f6:	8a 12                	mov    (%edx),%dl
  8010f8:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8010fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801100:	89 55 10             	mov    %edx,0x10(%ebp)
  801103:	85 c0                	test   %eax,%eax
  801105:	75 dd                	jne    8010e4 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80110a:	c9                   	leave  
  80110b:	c3                   	ret    

0080110c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80110c:	55                   	push   %ebp
  80110d:	89 e5                	mov    %esp,%ebp
  80110f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801112:	8b 45 0c             	mov    0xc(%ebp),%eax
  801115:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
  80111b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80111e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801121:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801124:	73 50                	jae    801176 <memmove+0x6a>
  801126:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801129:	8b 45 10             	mov    0x10(%ebp),%eax
  80112c:	01 d0                	add    %edx,%eax
  80112e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801131:	76 43                	jbe    801176 <memmove+0x6a>
		s += n;
  801133:	8b 45 10             	mov    0x10(%ebp),%eax
  801136:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801139:	8b 45 10             	mov    0x10(%ebp),%eax
  80113c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80113f:	eb 10                	jmp    801151 <memmove+0x45>
			*--d = *--s;
  801141:	ff 4d f8             	decl   -0x8(%ebp)
  801144:	ff 4d fc             	decl   -0x4(%ebp)
  801147:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80114a:	8a 10                	mov    (%eax),%dl
  80114c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80114f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801151:	8b 45 10             	mov    0x10(%ebp),%eax
  801154:	8d 50 ff             	lea    -0x1(%eax),%edx
  801157:	89 55 10             	mov    %edx,0x10(%ebp)
  80115a:	85 c0                	test   %eax,%eax
  80115c:	75 e3                	jne    801141 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80115e:	eb 23                	jmp    801183 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801160:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801163:	8d 50 01             	lea    0x1(%eax),%edx
  801166:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801169:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80116c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80116f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801172:	8a 12                	mov    (%edx),%dl
  801174:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801176:	8b 45 10             	mov    0x10(%ebp),%eax
  801179:	8d 50 ff             	lea    -0x1(%eax),%edx
  80117c:	89 55 10             	mov    %edx,0x10(%ebp)
  80117f:	85 c0                	test   %eax,%eax
  801181:	75 dd                	jne    801160 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801186:	c9                   	leave  
  801187:	c3                   	ret    

00801188 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
  80118b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80118e:	8b 45 08             	mov    0x8(%ebp),%eax
  801191:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801194:	8b 45 0c             	mov    0xc(%ebp),%eax
  801197:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80119a:	eb 2a                	jmp    8011c6 <memcmp+0x3e>
		if (*s1 != *s2)
  80119c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80119f:	8a 10                	mov    (%eax),%dl
  8011a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a4:	8a 00                	mov    (%eax),%al
  8011a6:	38 c2                	cmp    %al,%dl
  8011a8:	74 16                	je     8011c0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8011aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ad:	8a 00                	mov    (%eax),%al
  8011af:	0f b6 d0             	movzbl %al,%edx
  8011b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011b5:	8a 00                	mov    (%eax),%al
  8011b7:	0f b6 c0             	movzbl %al,%eax
  8011ba:	29 c2                	sub    %eax,%edx
  8011bc:	89 d0                	mov    %edx,%eax
  8011be:	eb 18                	jmp    8011d8 <memcmp+0x50>
		s1++, s2++;
  8011c0:	ff 45 fc             	incl   -0x4(%ebp)
  8011c3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8011c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011cc:	89 55 10             	mov    %edx,0x10(%ebp)
  8011cf:	85 c0                	test   %eax,%eax
  8011d1:	75 c9                	jne    80119c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8011d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011d8:	c9                   	leave  
  8011d9:	c3                   	ret    

008011da <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8011da:	55                   	push   %ebp
  8011db:	89 e5                	mov    %esp,%ebp
  8011dd:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8011e0:	8b 55 08             	mov    0x8(%ebp),%edx
  8011e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e6:	01 d0                	add    %edx,%eax
  8011e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8011eb:	eb 15                	jmp    801202 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	8a 00                	mov    (%eax),%al
  8011f2:	0f b6 d0             	movzbl %al,%edx
  8011f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f8:	0f b6 c0             	movzbl %al,%eax
  8011fb:	39 c2                	cmp    %eax,%edx
  8011fd:	74 0d                	je     80120c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8011ff:	ff 45 08             	incl   0x8(%ebp)
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801208:	72 e3                	jb     8011ed <memfind+0x13>
  80120a:	eb 01                	jmp    80120d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80120c:	90                   	nop
	return (void *) s;
  80120d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801210:	c9                   	leave  
  801211:	c3                   	ret    

00801212 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801212:	55                   	push   %ebp
  801213:	89 e5                	mov    %esp,%ebp
  801215:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801218:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80121f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801226:	eb 03                	jmp    80122b <strtol+0x19>
		s++;
  801228:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80122b:	8b 45 08             	mov    0x8(%ebp),%eax
  80122e:	8a 00                	mov    (%eax),%al
  801230:	3c 20                	cmp    $0x20,%al
  801232:	74 f4                	je     801228 <strtol+0x16>
  801234:	8b 45 08             	mov    0x8(%ebp),%eax
  801237:	8a 00                	mov    (%eax),%al
  801239:	3c 09                	cmp    $0x9,%al
  80123b:	74 eb                	je     801228 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	8a 00                	mov    (%eax),%al
  801242:	3c 2b                	cmp    $0x2b,%al
  801244:	75 05                	jne    80124b <strtol+0x39>
		s++;
  801246:	ff 45 08             	incl   0x8(%ebp)
  801249:	eb 13                	jmp    80125e <strtol+0x4c>
	else if (*s == '-')
  80124b:	8b 45 08             	mov    0x8(%ebp),%eax
  80124e:	8a 00                	mov    (%eax),%al
  801250:	3c 2d                	cmp    $0x2d,%al
  801252:	75 0a                	jne    80125e <strtol+0x4c>
		s++, neg = 1;
  801254:	ff 45 08             	incl   0x8(%ebp)
  801257:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80125e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801262:	74 06                	je     80126a <strtol+0x58>
  801264:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801268:	75 20                	jne    80128a <strtol+0x78>
  80126a:	8b 45 08             	mov    0x8(%ebp),%eax
  80126d:	8a 00                	mov    (%eax),%al
  80126f:	3c 30                	cmp    $0x30,%al
  801271:	75 17                	jne    80128a <strtol+0x78>
  801273:	8b 45 08             	mov    0x8(%ebp),%eax
  801276:	40                   	inc    %eax
  801277:	8a 00                	mov    (%eax),%al
  801279:	3c 78                	cmp    $0x78,%al
  80127b:	75 0d                	jne    80128a <strtol+0x78>
		s += 2, base = 16;
  80127d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801281:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801288:	eb 28                	jmp    8012b2 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80128a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80128e:	75 15                	jne    8012a5 <strtol+0x93>
  801290:	8b 45 08             	mov    0x8(%ebp),%eax
  801293:	8a 00                	mov    (%eax),%al
  801295:	3c 30                	cmp    $0x30,%al
  801297:	75 0c                	jne    8012a5 <strtol+0x93>
		s++, base = 8;
  801299:	ff 45 08             	incl   0x8(%ebp)
  80129c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8012a3:	eb 0d                	jmp    8012b2 <strtol+0xa0>
	else if (base == 0)
  8012a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012a9:	75 07                	jne    8012b2 <strtol+0xa0>
		base = 10;
  8012ab:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8012b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b5:	8a 00                	mov    (%eax),%al
  8012b7:	3c 2f                	cmp    $0x2f,%al
  8012b9:	7e 19                	jle    8012d4 <strtol+0xc2>
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	8a 00                	mov    (%eax),%al
  8012c0:	3c 39                	cmp    $0x39,%al
  8012c2:	7f 10                	jg     8012d4 <strtol+0xc2>
			dig = *s - '0';
  8012c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c7:	8a 00                	mov    (%eax),%al
  8012c9:	0f be c0             	movsbl %al,%eax
  8012cc:	83 e8 30             	sub    $0x30,%eax
  8012cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012d2:	eb 42                	jmp    801316 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8012d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d7:	8a 00                	mov    (%eax),%al
  8012d9:	3c 60                	cmp    $0x60,%al
  8012db:	7e 19                	jle    8012f6 <strtol+0xe4>
  8012dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e0:	8a 00                	mov    (%eax),%al
  8012e2:	3c 7a                	cmp    $0x7a,%al
  8012e4:	7f 10                	jg     8012f6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8012e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e9:	8a 00                	mov    (%eax),%al
  8012eb:	0f be c0             	movsbl %al,%eax
  8012ee:	83 e8 57             	sub    $0x57,%eax
  8012f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012f4:	eb 20                	jmp    801316 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8012f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f9:	8a 00                	mov    (%eax),%al
  8012fb:	3c 40                	cmp    $0x40,%al
  8012fd:	7e 39                	jle    801338 <strtol+0x126>
  8012ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801302:	8a 00                	mov    (%eax),%al
  801304:	3c 5a                	cmp    $0x5a,%al
  801306:	7f 30                	jg     801338 <strtol+0x126>
			dig = *s - 'A' + 10;
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	8a 00                	mov    (%eax),%al
  80130d:	0f be c0             	movsbl %al,%eax
  801310:	83 e8 37             	sub    $0x37,%eax
  801313:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801316:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801319:	3b 45 10             	cmp    0x10(%ebp),%eax
  80131c:	7d 19                	jge    801337 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80131e:	ff 45 08             	incl   0x8(%ebp)
  801321:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801324:	0f af 45 10          	imul   0x10(%ebp),%eax
  801328:	89 c2                	mov    %eax,%edx
  80132a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80132d:	01 d0                	add    %edx,%eax
  80132f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801332:	e9 7b ff ff ff       	jmp    8012b2 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801337:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801338:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80133c:	74 08                	je     801346 <strtol+0x134>
		*endptr = (char *) s;
  80133e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801341:	8b 55 08             	mov    0x8(%ebp),%edx
  801344:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801346:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80134a:	74 07                	je     801353 <strtol+0x141>
  80134c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80134f:	f7 d8                	neg    %eax
  801351:	eb 03                	jmp    801356 <strtol+0x144>
  801353:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801356:	c9                   	leave  
  801357:	c3                   	ret    

00801358 <ltostr>:

void
ltostr(long value, char *str)
{
  801358:	55                   	push   %ebp
  801359:	89 e5                	mov    %esp,%ebp
  80135b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80135e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801365:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80136c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801370:	79 13                	jns    801385 <ltostr+0x2d>
	{
		neg = 1;
  801372:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801379:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80137f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801382:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80138d:	99                   	cltd   
  80138e:	f7 f9                	idiv   %ecx
  801390:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801393:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801396:	8d 50 01             	lea    0x1(%eax),%edx
  801399:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80139c:	89 c2                	mov    %eax,%edx
  80139e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a1:	01 d0                	add    %edx,%eax
  8013a3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013a6:	83 c2 30             	add    $0x30,%edx
  8013a9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8013ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013ae:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013b3:	f7 e9                	imul   %ecx
  8013b5:	c1 fa 02             	sar    $0x2,%edx
  8013b8:	89 c8                	mov    %ecx,%eax
  8013ba:	c1 f8 1f             	sar    $0x1f,%eax
  8013bd:	29 c2                	sub    %eax,%edx
  8013bf:	89 d0                	mov    %edx,%eax
  8013c1:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8013c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013c7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013cc:	f7 e9                	imul   %ecx
  8013ce:	c1 fa 02             	sar    $0x2,%edx
  8013d1:	89 c8                	mov    %ecx,%eax
  8013d3:	c1 f8 1f             	sar    $0x1f,%eax
  8013d6:	29 c2                	sub    %eax,%edx
  8013d8:	89 d0                	mov    %edx,%eax
  8013da:	c1 e0 02             	shl    $0x2,%eax
  8013dd:	01 d0                	add    %edx,%eax
  8013df:	01 c0                	add    %eax,%eax
  8013e1:	29 c1                	sub    %eax,%ecx
  8013e3:	89 ca                	mov    %ecx,%edx
  8013e5:	85 d2                	test   %edx,%edx
  8013e7:	75 9c                	jne    801385 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8013e9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8013f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013f3:	48                   	dec    %eax
  8013f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8013f7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013fb:	74 3d                	je     80143a <ltostr+0xe2>
		start = 1 ;
  8013fd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801404:	eb 34                	jmp    80143a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801406:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801409:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140c:	01 d0                	add    %edx,%eax
  80140e:	8a 00                	mov    (%eax),%al
  801410:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801413:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801416:	8b 45 0c             	mov    0xc(%ebp),%eax
  801419:	01 c2                	add    %eax,%edx
  80141b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80141e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801421:	01 c8                	add    %ecx,%eax
  801423:	8a 00                	mov    (%eax),%al
  801425:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801427:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80142a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142d:	01 c2                	add    %eax,%edx
  80142f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801432:	88 02                	mov    %al,(%edx)
		start++ ;
  801434:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801437:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80143a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80143d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801440:	7c c4                	jl     801406 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801442:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801445:	8b 45 0c             	mov    0xc(%ebp),%eax
  801448:	01 d0                	add    %edx,%eax
  80144a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80144d:	90                   	nop
  80144e:	c9                   	leave  
  80144f:	c3                   	ret    

00801450 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801450:	55                   	push   %ebp
  801451:	89 e5                	mov    %esp,%ebp
  801453:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801456:	ff 75 08             	pushl  0x8(%ebp)
  801459:	e8 54 fa ff ff       	call   800eb2 <strlen>
  80145e:	83 c4 04             	add    $0x4,%esp
  801461:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801464:	ff 75 0c             	pushl  0xc(%ebp)
  801467:	e8 46 fa ff ff       	call   800eb2 <strlen>
  80146c:	83 c4 04             	add    $0x4,%esp
  80146f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801472:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801479:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801480:	eb 17                	jmp    801499 <strcconcat+0x49>
		final[s] = str1[s] ;
  801482:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801485:	8b 45 10             	mov    0x10(%ebp),%eax
  801488:	01 c2                	add    %eax,%edx
  80148a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	01 c8                	add    %ecx,%eax
  801492:	8a 00                	mov    (%eax),%al
  801494:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801496:	ff 45 fc             	incl   -0x4(%ebp)
  801499:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80149c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80149f:	7c e1                	jl     801482 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8014a1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8014a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8014af:	eb 1f                	jmp    8014d0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8014b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b4:	8d 50 01             	lea    0x1(%eax),%edx
  8014b7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014ba:	89 c2                	mov    %eax,%edx
  8014bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8014bf:	01 c2                	add    %eax,%edx
  8014c1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8014c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c7:	01 c8                	add    %ecx,%eax
  8014c9:	8a 00                	mov    (%eax),%al
  8014cb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8014cd:	ff 45 f8             	incl   -0x8(%ebp)
  8014d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014d6:	7c d9                	jl     8014b1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8014d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014db:	8b 45 10             	mov    0x10(%ebp),%eax
  8014de:	01 d0                	add    %edx,%eax
  8014e0:	c6 00 00             	movb   $0x0,(%eax)
}
  8014e3:	90                   	nop
  8014e4:	c9                   	leave  
  8014e5:	c3                   	ret    

008014e6 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8014e6:	55                   	push   %ebp
  8014e7:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8014e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8014f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f5:	8b 00                	mov    (%eax),%eax
  8014f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801501:	01 d0                	add    %edx,%eax
  801503:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801509:	eb 0c                	jmp    801517 <strsplit+0x31>
			*string++ = 0;
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	8d 50 01             	lea    0x1(%eax),%edx
  801511:	89 55 08             	mov    %edx,0x8(%ebp)
  801514:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	8a 00                	mov    (%eax),%al
  80151c:	84 c0                	test   %al,%al
  80151e:	74 18                	je     801538 <strsplit+0x52>
  801520:	8b 45 08             	mov    0x8(%ebp),%eax
  801523:	8a 00                	mov    (%eax),%al
  801525:	0f be c0             	movsbl %al,%eax
  801528:	50                   	push   %eax
  801529:	ff 75 0c             	pushl  0xc(%ebp)
  80152c:	e8 13 fb ff ff       	call   801044 <strchr>
  801531:	83 c4 08             	add    $0x8,%esp
  801534:	85 c0                	test   %eax,%eax
  801536:	75 d3                	jne    80150b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	8a 00                	mov    (%eax),%al
  80153d:	84 c0                	test   %al,%al
  80153f:	74 5a                	je     80159b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801541:	8b 45 14             	mov    0x14(%ebp),%eax
  801544:	8b 00                	mov    (%eax),%eax
  801546:	83 f8 0f             	cmp    $0xf,%eax
  801549:	75 07                	jne    801552 <strsplit+0x6c>
		{
			return 0;
  80154b:	b8 00 00 00 00       	mov    $0x0,%eax
  801550:	eb 66                	jmp    8015b8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801552:	8b 45 14             	mov    0x14(%ebp),%eax
  801555:	8b 00                	mov    (%eax),%eax
  801557:	8d 48 01             	lea    0x1(%eax),%ecx
  80155a:	8b 55 14             	mov    0x14(%ebp),%edx
  80155d:	89 0a                	mov    %ecx,(%edx)
  80155f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801566:	8b 45 10             	mov    0x10(%ebp),%eax
  801569:	01 c2                	add    %eax,%edx
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801570:	eb 03                	jmp    801575 <strsplit+0x8f>
			string++;
  801572:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801575:	8b 45 08             	mov    0x8(%ebp),%eax
  801578:	8a 00                	mov    (%eax),%al
  80157a:	84 c0                	test   %al,%al
  80157c:	74 8b                	je     801509 <strsplit+0x23>
  80157e:	8b 45 08             	mov    0x8(%ebp),%eax
  801581:	8a 00                	mov    (%eax),%al
  801583:	0f be c0             	movsbl %al,%eax
  801586:	50                   	push   %eax
  801587:	ff 75 0c             	pushl  0xc(%ebp)
  80158a:	e8 b5 fa ff ff       	call   801044 <strchr>
  80158f:	83 c4 08             	add    $0x8,%esp
  801592:	85 c0                	test   %eax,%eax
  801594:	74 dc                	je     801572 <strsplit+0x8c>
			string++;
	}
  801596:	e9 6e ff ff ff       	jmp    801509 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80159b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80159c:	8b 45 14             	mov    0x14(%ebp),%eax
  80159f:	8b 00                	mov    (%eax),%eax
  8015a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ab:	01 d0                	add    %edx,%eax
  8015ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8015b3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8015b8:	c9                   	leave  
  8015b9:	c3                   	ret    

008015ba <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015ba:	55                   	push   %ebp
  8015bb:	89 e5                	mov    %esp,%ebp
  8015bd:	57                   	push   %edi
  8015be:	56                   	push   %esi
  8015bf:	53                   	push   %ebx
  8015c0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015cc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015cf:	8b 7d 18             	mov    0x18(%ebp),%edi
  8015d2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8015d5:	cd 30                	int    $0x30
  8015d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8015da:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015dd:	83 c4 10             	add    $0x10,%esp
  8015e0:	5b                   	pop    %ebx
  8015e1:	5e                   	pop    %esi
  8015e2:	5f                   	pop    %edi
  8015e3:	5d                   	pop    %ebp
  8015e4:	c3                   	ret    

008015e5 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8015e5:	55                   	push   %ebp
  8015e6:	89 e5                	mov    %esp,%ebp
  8015e8:	83 ec 04             	sub    $0x4,%esp
  8015eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ee:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8015f1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	52                   	push   %edx
  8015fd:	ff 75 0c             	pushl  0xc(%ebp)
  801600:	50                   	push   %eax
  801601:	6a 00                	push   $0x0
  801603:	e8 b2 ff ff ff       	call   8015ba <syscall>
  801608:	83 c4 18             	add    $0x18,%esp
}
  80160b:	90                   	nop
  80160c:	c9                   	leave  
  80160d:	c3                   	ret    

0080160e <sys_cgetc>:

int
sys_cgetc(void)
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 01                	push   $0x1
  80161d:	e8 98 ff ff ff       	call   8015ba <syscall>
  801622:	83 c4 18             	add    $0x18,%esp
}
  801625:	c9                   	leave  
  801626:	c3                   	ret    

00801627 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801627:	55                   	push   %ebp
  801628:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	50                   	push   %eax
  801636:	6a 05                	push   $0x5
  801638:	e8 7d ff ff ff       	call   8015ba <syscall>
  80163d:	83 c4 18             	add    $0x18,%esp
}
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 02                	push   $0x2
  801651:	e8 64 ff ff ff       	call   8015ba <syscall>
  801656:	83 c4 18             	add    $0x18,%esp
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 03                	push   $0x3
  80166a:	e8 4b ff ff ff       	call   8015ba <syscall>
  80166f:	83 c4 18             	add    $0x18,%esp
}
  801672:	c9                   	leave  
  801673:	c3                   	ret    

00801674 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 04                	push   $0x4
  801683:	e8 32 ff ff ff       	call   8015ba <syscall>
  801688:	83 c4 18             	add    $0x18,%esp
}
  80168b:	c9                   	leave  
  80168c:	c3                   	ret    

0080168d <sys_env_exit>:


void sys_env_exit(void)
{
  80168d:	55                   	push   %ebp
  80168e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 06                	push   $0x6
  80169c:	e8 19 ff ff ff       	call   8015ba <syscall>
  8016a1:	83 c4 18             	add    $0x18,%esp
}
  8016a4:	90                   	nop
  8016a5:	c9                   	leave  
  8016a6:	c3                   	ret    

008016a7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016a7:	55                   	push   %ebp
  8016a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	52                   	push   %edx
  8016b7:	50                   	push   %eax
  8016b8:	6a 07                	push   $0x7
  8016ba:	e8 fb fe ff ff       	call   8015ba <syscall>
  8016bf:	83 c4 18             	add    $0x18,%esp
}
  8016c2:	c9                   	leave  
  8016c3:	c3                   	ret    

008016c4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016c4:	55                   	push   %ebp
  8016c5:	89 e5                	mov    %esp,%ebp
  8016c7:	56                   	push   %esi
  8016c8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016c9:	8b 75 18             	mov    0x18(%ebp),%esi
  8016cc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d8:	56                   	push   %esi
  8016d9:	53                   	push   %ebx
  8016da:	51                   	push   %ecx
  8016db:	52                   	push   %edx
  8016dc:	50                   	push   %eax
  8016dd:	6a 08                	push   $0x8
  8016df:	e8 d6 fe ff ff       	call   8015ba <syscall>
  8016e4:	83 c4 18             	add    $0x18,%esp
}
  8016e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016ea:	5b                   	pop    %ebx
  8016eb:	5e                   	pop    %esi
  8016ec:	5d                   	pop    %ebp
  8016ed:	c3                   	ret    

008016ee <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8016ee:	55                   	push   %ebp
  8016ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8016f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	52                   	push   %edx
  8016fe:	50                   	push   %eax
  8016ff:	6a 09                	push   $0x9
  801701:	e8 b4 fe ff ff       	call   8015ba <syscall>
  801706:	83 c4 18             	add    $0x18,%esp
}
  801709:	c9                   	leave  
  80170a:	c3                   	ret    

0080170b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	ff 75 0c             	pushl  0xc(%ebp)
  801717:	ff 75 08             	pushl  0x8(%ebp)
  80171a:	6a 0a                	push   $0xa
  80171c:	e8 99 fe ff ff       	call   8015ba <syscall>
  801721:	83 c4 18             	add    $0x18,%esp
}
  801724:	c9                   	leave  
  801725:	c3                   	ret    

00801726 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801726:	55                   	push   %ebp
  801727:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 0b                	push   $0xb
  801735:	e8 80 fe ff ff       	call   8015ba <syscall>
  80173a:	83 c4 18             	add    $0x18,%esp
}
  80173d:	c9                   	leave  
  80173e:	c3                   	ret    

0080173f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80173f:	55                   	push   %ebp
  801740:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 0c                	push   $0xc
  80174e:	e8 67 fe ff ff       	call   8015ba <syscall>
  801753:	83 c4 18             	add    $0x18,%esp
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 0d                	push   $0xd
  801767:	e8 4e fe ff ff       	call   8015ba <syscall>
  80176c:	83 c4 18             	add    $0x18,%esp
}
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	ff 75 0c             	pushl  0xc(%ebp)
  80177d:	ff 75 08             	pushl  0x8(%ebp)
  801780:	6a 11                	push   $0x11
  801782:	e8 33 fe ff ff       	call   8015ba <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
	return;
  80178a:	90                   	nop
}
  80178b:	c9                   	leave  
  80178c:	c3                   	ret    

0080178d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	ff 75 0c             	pushl  0xc(%ebp)
  801799:	ff 75 08             	pushl  0x8(%ebp)
  80179c:	6a 12                	push   $0x12
  80179e:	e8 17 fe ff ff       	call   8015ba <syscall>
  8017a3:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a6:	90                   	nop
}
  8017a7:	c9                   	leave  
  8017a8:	c3                   	ret    

008017a9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017a9:	55                   	push   %ebp
  8017aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 0e                	push   $0xe
  8017b8:	e8 fd fd ff ff       	call   8015ba <syscall>
  8017bd:	83 c4 18             	add    $0x18,%esp
}
  8017c0:	c9                   	leave  
  8017c1:	c3                   	ret    

008017c2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8017c2:	55                   	push   %ebp
  8017c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	ff 75 08             	pushl  0x8(%ebp)
  8017d0:	6a 0f                	push   $0xf
  8017d2:	e8 e3 fd ff ff       	call   8015ba <syscall>
  8017d7:	83 c4 18             	add    $0x18,%esp
}
  8017da:	c9                   	leave  
  8017db:	c3                   	ret    

008017dc <sys_scarce_memory>:

void sys_scarce_memory()
{
  8017dc:	55                   	push   %ebp
  8017dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 10                	push   $0x10
  8017eb:	e8 ca fd ff ff       	call   8015ba <syscall>
  8017f0:	83 c4 18             	add    $0x18,%esp
}
  8017f3:	90                   	nop
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 14                	push   $0x14
  801805:	e8 b0 fd ff ff       	call   8015ba <syscall>
  80180a:	83 c4 18             	add    $0x18,%esp
}
  80180d:	90                   	nop
  80180e:	c9                   	leave  
  80180f:	c3                   	ret    

00801810 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 15                	push   $0x15
  80181f:	e8 96 fd ff ff       	call   8015ba <syscall>
  801824:	83 c4 18             	add    $0x18,%esp
}
  801827:	90                   	nop
  801828:	c9                   	leave  
  801829:	c3                   	ret    

0080182a <sys_cputc>:


void
sys_cputc(const char c)
{
  80182a:	55                   	push   %ebp
  80182b:	89 e5                	mov    %esp,%ebp
  80182d:	83 ec 04             	sub    $0x4,%esp
  801830:	8b 45 08             	mov    0x8(%ebp),%eax
  801833:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801836:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	50                   	push   %eax
  801843:	6a 16                	push   $0x16
  801845:	e8 70 fd ff ff       	call   8015ba <syscall>
  80184a:	83 c4 18             	add    $0x18,%esp
}
  80184d:	90                   	nop
  80184e:	c9                   	leave  
  80184f:	c3                   	ret    

00801850 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801850:	55                   	push   %ebp
  801851:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 17                	push   $0x17
  80185f:	e8 56 fd ff ff       	call   8015ba <syscall>
  801864:	83 c4 18             	add    $0x18,%esp
}
  801867:	90                   	nop
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80186d:	8b 45 08             	mov    0x8(%ebp),%eax
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	ff 75 0c             	pushl  0xc(%ebp)
  801879:	50                   	push   %eax
  80187a:	6a 18                	push   $0x18
  80187c:	e8 39 fd ff ff       	call   8015ba <syscall>
  801881:	83 c4 18             	add    $0x18,%esp
}
  801884:	c9                   	leave  
  801885:	c3                   	ret    

00801886 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801886:	55                   	push   %ebp
  801887:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801889:	8b 55 0c             	mov    0xc(%ebp),%edx
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	52                   	push   %edx
  801896:	50                   	push   %eax
  801897:	6a 1b                	push   $0x1b
  801899:	e8 1c fd ff ff       	call   8015ba <syscall>
  80189e:	83 c4 18             	add    $0x18,%esp
}
  8018a1:	c9                   	leave  
  8018a2:	c3                   	ret    

008018a3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018a3:	55                   	push   %ebp
  8018a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	52                   	push   %edx
  8018b3:	50                   	push   %eax
  8018b4:	6a 19                	push   $0x19
  8018b6:	e8 ff fc ff ff       	call   8015ba <syscall>
  8018bb:	83 c4 18             	add    $0x18,%esp
}
  8018be:	90                   	nop
  8018bf:	c9                   	leave  
  8018c0:	c3                   	ret    

008018c1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	52                   	push   %edx
  8018d1:	50                   	push   %eax
  8018d2:	6a 1a                	push   $0x1a
  8018d4:	e8 e1 fc ff ff       	call   8015ba <syscall>
  8018d9:	83 c4 18             	add    $0x18,%esp
}
  8018dc:	90                   	nop
  8018dd:	c9                   	leave  
  8018de:	c3                   	ret    

008018df <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
  8018e2:	83 ec 04             	sub    $0x4,%esp
  8018e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e8:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8018eb:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018ee:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f5:	6a 00                	push   $0x0
  8018f7:	51                   	push   %ecx
  8018f8:	52                   	push   %edx
  8018f9:	ff 75 0c             	pushl  0xc(%ebp)
  8018fc:	50                   	push   %eax
  8018fd:	6a 1c                	push   $0x1c
  8018ff:	e8 b6 fc ff ff       	call   8015ba <syscall>
  801904:	83 c4 18             	add    $0x18,%esp
}
  801907:	c9                   	leave  
  801908:	c3                   	ret    

00801909 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801909:	55                   	push   %ebp
  80190a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80190c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190f:	8b 45 08             	mov    0x8(%ebp),%eax
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	52                   	push   %edx
  801919:	50                   	push   %eax
  80191a:	6a 1d                	push   $0x1d
  80191c:	e8 99 fc ff ff       	call   8015ba <syscall>
  801921:	83 c4 18             	add    $0x18,%esp
}
  801924:	c9                   	leave  
  801925:	c3                   	ret    

00801926 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801926:	55                   	push   %ebp
  801927:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801929:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80192c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80192f:	8b 45 08             	mov    0x8(%ebp),%eax
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	51                   	push   %ecx
  801937:	52                   	push   %edx
  801938:	50                   	push   %eax
  801939:	6a 1e                	push   $0x1e
  80193b:	e8 7a fc ff ff       	call   8015ba <syscall>
  801940:	83 c4 18             	add    $0x18,%esp
}
  801943:	c9                   	leave  
  801944:	c3                   	ret    

00801945 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801945:	55                   	push   %ebp
  801946:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801948:	8b 55 0c             	mov    0xc(%ebp),%edx
  80194b:	8b 45 08             	mov    0x8(%ebp),%eax
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	52                   	push   %edx
  801955:	50                   	push   %eax
  801956:	6a 1f                	push   $0x1f
  801958:	e8 5d fc ff ff       	call   8015ba <syscall>
  80195d:	83 c4 18             	add    $0x18,%esp
}
  801960:	c9                   	leave  
  801961:	c3                   	ret    

00801962 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801962:	55                   	push   %ebp
  801963:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 20                	push   $0x20
  801971:	e8 44 fc ff ff       	call   8015ba <syscall>
  801976:	83 c4 18             	add    $0x18,%esp
}
  801979:	c9                   	leave  
  80197a:	c3                   	ret    

0080197b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80197b:	55                   	push   %ebp
  80197c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80197e:	8b 45 08             	mov    0x8(%ebp),%eax
  801981:	6a 00                	push   $0x0
  801983:	ff 75 14             	pushl  0x14(%ebp)
  801986:	ff 75 10             	pushl  0x10(%ebp)
  801989:	ff 75 0c             	pushl  0xc(%ebp)
  80198c:	50                   	push   %eax
  80198d:	6a 21                	push   $0x21
  80198f:	e8 26 fc ff ff       	call   8015ba <syscall>
  801994:	83 c4 18             	add    $0x18,%esp
}
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80199c:	8b 45 08             	mov    0x8(%ebp),%eax
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	50                   	push   %eax
  8019a8:	6a 22                	push   $0x22
  8019aa:	e8 0b fc ff ff       	call   8015ba <syscall>
  8019af:	83 c4 18             	add    $0x18,%esp
}
  8019b2:	90                   	nop
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8019b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	50                   	push   %eax
  8019c4:	6a 23                	push   $0x23
  8019c6:	e8 ef fb ff ff       	call   8015ba <syscall>
  8019cb:	83 c4 18             	add    $0x18,%esp
}
  8019ce:	90                   	nop
  8019cf:	c9                   	leave  
  8019d0:	c3                   	ret    

008019d1 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8019d1:	55                   	push   %ebp
  8019d2:	89 e5                	mov    %esp,%ebp
  8019d4:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8019d7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019da:	8d 50 04             	lea    0x4(%eax),%edx
  8019dd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	52                   	push   %edx
  8019e7:	50                   	push   %eax
  8019e8:	6a 24                	push   $0x24
  8019ea:	e8 cb fb ff ff       	call   8015ba <syscall>
  8019ef:	83 c4 18             	add    $0x18,%esp
	return result;
  8019f2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019f8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019fb:	89 01                	mov    %eax,(%ecx)
  8019fd:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a00:	8b 45 08             	mov    0x8(%ebp),%eax
  801a03:	c9                   	leave  
  801a04:	c2 04 00             	ret    $0x4

00801a07 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a07:	55                   	push   %ebp
  801a08:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	ff 75 10             	pushl  0x10(%ebp)
  801a11:	ff 75 0c             	pushl  0xc(%ebp)
  801a14:	ff 75 08             	pushl  0x8(%ebp)
  801a17:	6a 13                	push   $0x13
  801a19:	e8 9c fb ff ff       	call   8015ba <syscall>
  801a1e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a21:	90                   	nop
}
  801a22:	c9                   	leave  
  801a23:	c3                   	ret    

00801a24 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a24:	55                   	push   %ebp
  801a25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a27:	6a 00                	push   $0x0
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 25                	push   $0x25
  801a33:	e8 82 fb ff ff       	call   8015ba <syscall>
  801a38:	83 c4 18             	add    $0x18,%esp
}
  801a3b:	c9                   	leave  
  801a3c:	c3                   	ret    

00801a3d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a3d:	55                   	push   %ebp
  801a3e:	89 e5                	mov    %esp,%ebp
  801a40:	83 ec 04             	sub    $0x4,%esp
  801a43:	8b 45 08             	mov    0x8(%ebp),%eax
  801a46:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a49:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 00                	push   $0x0
  801a53:	6a 00                	push   $0x0
  801a55:	50                   	push   %eax
  801a56:	6a 26                	push   $0x26
  801a58:	e8 5d fb ff ff       	call   8015ba <syscall>
  801a5d:	83 c4 18             	add    $0x18,%esp
	return ;
  801a60:	90                   	nop
}
  801a61:	c9                   	leave  
  801a62:	c3                   	ret    

00801a63 <rsttst>:
void rsttst()
{
  801a63:	55                   	push   %ebp
  801a64:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	6a 00                	push   $0x0
  801a6c:	6a 00                	push   $0x0
  801a6e:	6a 00                	push   $0x0
  801a70:	6a 28                	push   $0x28
  801a72:	e8 43 fb ff ff       	call   8015ba <syscall>
  801a77:	83 c4 18             	add    $0x18,%esp
	return ;
  801a7a:	90                   	nop
}
  801a7b:	c9                   	leave  
  801a7c:	c3                   	ret    

00801a7d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a7d:	55                   	push   %ebp
  801a7e:	89 e5                	mov    %esp,%ebp
  801a80:	83 ec 04             	sub    $0x4,%esp
  801a83:	8b 45 14             	mov    0x14(%ebp),%eax
  801a86:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a89:	8b 55 18             	mov    0x18(%ebp),%edx
  801a8c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a90:	52                   	push   %edx
  801a91:	50                   	push   %eax
  801a92:	ff 75 10             	pushl  0x10(%ebp)
  801a95:	ff 75 0c             	pushl  0xc(%ebp)
  801a98:	ff 75 08             	pushl  0x8(%ebp)
  801a9b:	6a 27                	push   $0x27
  801a9d:	e8 18 fb ff ff       	call   8015ba <syscall>
  801aa2:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa5:	90                   	nop
}
  801aa6:	c9                   	leave  
  801aa7:	c3                   	ret    

00801aa8 <chktst>:
void chktst(uint32 n)
{
  801aa8:	55                   	push   %ebp
  801aa9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801aab:	6a 00                	push   $0x0
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	ff 75 08             	pushl  0x8(%ebp)
  801ab6:	6a 29                	push   $0x29
  801ab8:	e8 fd fa ff ff       	call   8015ba <syscall>
  801abd:	83 c4 18             	add    $0x18,%esp
	return ;
  801ac0:	90                   	nop
}
  801ac1:	c9                   	leave  
  801ac2:	c3                   	ret    

00801ac3 <inctst>:

void inctst()
{
  801ac3:	55                   	push   %ebp
  801ac4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 2a                	push   $0x2a
  801ad2:	e8 e3 fa ff ff       	call   8015ba <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
	return ;
  801ada:	90                   	nop
}
  801adb:	c9                   	leave  
  801adc:	c3                   	ret    

00801add <gettst>:
uint32 gettst()
{
  801add:	55                   	push   %ebp
  801ade:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 2b                	push   $0x2b
  801aec:	e8 c9 fa ff ff       	call   8015ba <syscall>
  801af1:	83 c4 18             	add    $0x18,%esp
}
  801af4:	c9                   	leave  
  801af5:	c3                   	ret    

00801af6 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801af6:	55                   	push   %ebp
  801af7:	89 e5                	mov    %esp,%ebp
  801af9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	6a 2c                	push   $0x2c
  801b08:	e8 ad fa ff ff       	call   8015ba <syscall>
  801b0d:	83 c4 18             	add    $0x18,%esp
  801b10:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b13:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b17:	75 07                	jne    801b20 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b19:	b8 01 00 00 00       	mov    $0x1,%eax
  801b1e:	eb 05                	jmp    801b25 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b20:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b25:	c9                   	leave  
  801b26:	c3                   	ret    

00801b27 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b27:	55                   	push   %ebp
  801b28:	89 e5                	mov    %esp,%ebp
  801b2a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	6a 2c                	push   $0x2c
  801b39:	e8 7c fa ff ff       	call   8015ba <syscall>
  801b3e:	83 c4 18             	add    $0x18,%esp
  801b41:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b44:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b48:	75 07                	jne    801b51 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b4a:	b8 01 00 00 00       	mov    $0x1,%eax
  801b4f:	eb 05                	jmp    801b56 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b51:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b56:	c9                   	leave  
  801b57:	c3                   	ret    

00801b58 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b58:	55                   	push   %ebp
  801b59:	89 e5                	mov    %esp,%ebp
  801b5b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	6a 2c                	push   $0x2c
  801b6a:	e8 4b fa ff ff       	call   8015ba <syscall>
  801b6f:	83 c4 18             	add    $0x18,%esp
  801b72:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b75:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b79:	75 07                	jne    801b82 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b7b:	b8 01 00 00 00       	mov    $0x1,%eax
  801b80:	eb 05                	jmp    801b87 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b82:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b87:	c9                   	leave  
  801b88:	c3                   	ret    

00801b89 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b89:	55                   	push   %ebp
  801b8a:	89 e5                	mov    %esp,%ebp
  801b8c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 2c                	push   $0x2c
  801b9b:	e8 1a fa ff ff       	call   8015ba <syscall>
  801ba0:	83 c4 18             	add    $0x18,%esp
  801ba3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ba6:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801baa:	75 07                	jne    801bb3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bac:	b8 01 00 00 00       	mov    $0x1,%eax
  801bb1:	eb 05                	jmp    801bb8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bb3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bb8:	c9                   	leave  
  801bb9:	c3                   	ret    

00801bba <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801bba:	55                   	push   %ebp
  801bbb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	ff 75 08             	pushl  0x8(%ebp)
  801bc8:	6a 2d                	push   $0x2d
  801bca:	e8 eb f9 ff ff       	call   8015ba <syscall>
  801bcf:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd2:	90                   	nop
}
  801bd3:	c9                   	leave  
  801bd4:	c3                   	ret    

00801bd5 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801bd5:	55                   	push   %ebp
  801bd6:	89 e5                	mov    %esp,%ebp
  801bd8:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801bd9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bdc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bdf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be2:	8b 45 08             	mov    0x8(%ebp),%eax
  801be5:	6a 00                	push   $0x0
  801be7:	53                   	push   %ebx
  801be8:	51                   	push   %ecx
  801be9:	52                   	push   %edx
  801bea:	50                   	push   %eax
  801beb:	6a 2e                	push   $0x2e
  801bed:	e8 c8 f9 ff ff       	call   8015ba <syscall>
  801bf2:	83 c4 18             	add    $0x18,%esp
}
  801bf5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801bf8:	c9                   	leave  
  801bf9:	c3                   	ret    

00801bfa <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801bfa:	55                   	push   %ebp
  801bfb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801bfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c00:	8b 45 08             	mov    0x8(%ebp),%eax
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	52                   	push   %edx
  801c0a:	50                   	push   %eax
  801c0b:	6a 2f                	push   $0x2f
  801c0d:	e8 a8 f9 ff ff       	call   8015ba <syscall>
  801c12:	83 c4 18             	add    $0x18,%esp
}
  801c15:	c9                   	leave  
  801c16:	c3                   	ret    
  801c17:	90                   	nop

00801c18 <__udivdi3>:
  801c18:	55                   	push   %ebp
  801c19:	57                   	push   %edi
  801c1a:	56                   	push   %esi
  801c1b:	53                   	push   %ebx
  801c1c:	83 ec 1c             	sub    $0x1c,%esp
  801c1f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c23:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c27:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c2b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c2f:	89 ca                	mov    %ecx,%edx
  801c31:	89 f8                	mov    %edi,%eax
  801c33:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c37:	85 f6                	test   %esi,%esi
  801c39:	75 2d                	jne    801c68 <__udivdi3+0x50>
  801c3b:	39 cf                	cmp    %ecx,%edi
  801c3d:	77 65                	ja     801ca4 <__udivdi3+0x8c>
  801c3f:	89 fd                	mov    %edi,%ebp
  801c41:	85 ff                	test   %edi,%edi
  801c43:	75 0b                	jne    801c50 <__udivdi3+0x38>
  801c45:	b8 01 00 00 00       	mov    $0x1,%eax
  801c4a:	31 d2                	xor    %edx,%edx
  801c4c:	f7 f7                	div    %edi
  801c4e:	89 c5                	mov    %eax,%ebp
  801c50:	31 d2                	xor    %edx,%edx
  801c52:	89 c8                	mov    %ecx,%eax
  801c54:	f7 f5                	div    %ebp
  801c56:	89 c1                	mov    %eax,%ecx
  801c58:	89 d8                	mov    %ebx,%eax
  801c5a:	f7 f5                	div    %ebp
  801c5c:	89 cf                	mov    %ecx,%edi
  801c5e:	89 fa                	mov    %edi,%edx
  801c60:	83 c4 1c             	add    $0x1c,%esp
  801c63:	5b                   	pop    %ebx
  801c64:	5e                   	pop    %esi
  801c65:	5f                   	pop    %edi
  801c66:	5d                   	pop    %ebp
  801c67:	c3                   	ret    
  801c68:	39 ce                	cmp    %ecx,%esi
  801c6a:	77 28                	ja     801c94 <__udivdi3+0x7c>
  801c6c:	0f bd fe             	bsr    %esi,%edi
  801c6f:	83 f7 1f             	xor    $0x1f,%edi
  801c72:	75 40                	jne    801cb4 <__udivdi3+0x9c>
  801c74:	39 ce                	cmp    %ecx,%esi
  801c76:	72 0a                	jb     801c82 <__udivdi3+0x6a>
  801c78:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c7c:	0f 87 9e 00 00 00    	ja     801d20 <__udivdi3+0x108>
  801c82:	b8 01 00 00 00       	mov    $0x1,%eax
  801c87:	89 fa                	mov    %edi,%edx
  801c89:	83 c4 1c             	add    $0x1c,%esp
  801c8c:	5b                   	pop    %ebx
  801c8d:	5e                   	pop    %esi
  801c8e:	5f                   	pop    %edi
  801c8f:	5d                   	pop    %ebp
  801c90:	c3                   	ret    
  801c91:	8d 76 00             	lea    0x0(%esi),%esi
  801c94:	31 ff                	xor    %edi,%edi
  801c96:	31 c0                	xor    %eax,%eax
  801c98:	89 fa                	mov    %edi,%edx
  801c9a:	83 c4 1c             	add    $0x1c,%esp
  801c9d:	5b                   	pop    %ebx
  801c9e:	5e                   	pop    %esi
  801c9f:	5f                   	pop    %edi
  801ca0:	5d                   	pop    %ebp
  801ca1:	c3                   	ret    
  801ca2:	66 90                	xchg   %ax,%ax
  801ca4:	89 d8                	mov    %ebx,%eax
  801ca6:	f7 f7                	div    %edi
  801ca8:	31 ff                	xor    %edi,%edi
  801caa:	89 fa                	mov    %edi,%edx
  801cac:	83 c4 1c             	add    $0x1c,%esp
  801caf:	5b                   	pop    %ebx
  801cb0:	5e                   	pop    %esi
  801cb1:	5f                   	pop    %edi
  801cb2:	5d                   	pop    %ebp
  801cb3:	c3                   	ret    
  801cb4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cb9:	89 eb                	mov    %ebp,%ebx
  801cbb:	29 fb                	sub    %edi,%ebx
  801cbd:	89 f9                	mov    %edi,%ecx
  801cbf:	d3 e6                	shl    %cl,%esi
  801cc1:	89 c5                	mov    %eax,%ebp
  801cc3:	88 d9                	mov    %bl,%cl
  801cc5:	d3 ed                	shr    %cl,%ebp
  801cc7:	89 e9                	mov    %ebp,%ecx
  801cc9:	09 f1                	or     %esi,%ecx
  801ccb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ccf:	89 f9                	mov    %edi,%ecx
  801cd1:	d3 e0                	shl    %cl,%eax
  801cd3:	89 c5                	mov    %eax,%ebp
  801cd5:	89 d6                	mov    %edx,%esi
  801cd7:	88 d9                	mov    %bl,%cl
  801cd9:	d3 ee                	shr    %cl,%esi
  801cdb:	89 f9                	mov    %edi,%ecx
  801cdd:	d3 e2                	shl    %cl,%edx
  801cdf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ce3:	88 d9                	mov    %bl,%cl
  801ce5:	d3 e8                	shr    %cl,%eax
  801ce7:	09 c2                	or     %eax,%edx
  801ce9:	89 d0                	mov    %edx,%eax
  801ceb:	89 f2                	mov    %esi,%edx
  801ced:	f7 74 24 0c          	divl   0xc(%esp)
  801cf1:	89 d6                	mov    %edx,%esi
  801cf3:	89 c3                	mov    %eax,%ebx
  801cf5:	f7 e5                	mul    %ebp
  801cf7:	39 d6                	cmp    %edx,%esi
  801cf9:	72 19                	jb     801d14 <__udivdi3+0xfc>
  801cfb:	74 0b                	je     801d08 <__udivdi3+0xf0>
  801cfd:	89 d8                	mov    %ebx,%eax
  801cff:	31 ff                	xor    %edi,%edi
  801d01:	e9 58 ff ff ff       	jmp    801c5e <__udivdi3+0x46>
  801d06:	66 90                	xchg   %ax,%ax
  801d08:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d0c:	89 f9                	mov    %edi,%ecx
  801d0e:	d3 e2                	shl    %cl,%edx
  801d10:	39 c2                	cmp    %eax,%edx
  801d12:	73 e9                	jae    801cfd <__udivdi3+0xe5>
  801d14:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d17:	31 ff                	xor    %edi,%edi
  801d19:	e9 40 ff ff ff       	jmp    801c5e <__udivdi3+0x46>
  801d1e:	66 90                	xchg   %ax,%ax
  801d20:	31 c0                	xor    %eax,%eax
  801d22:	e9 37 ff ff ff       	jmp    801c5e <__udivdi3+0x46>
  801d27:	90                   	nop

00801d28 <__umoddi3>:
  801d28:	55                   	push   %ebp
  801d29:	57                   	push   %edi
  801d2a:	56                   	push   %esi
  801d2b:	53                   	push   %ebx
  801d2c:	83 ec 1c             	sub    $0x1c,%esp
  801d2f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d33:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d3b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d3f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d43:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d47:	89 f3                	mov    %esi,%ebx
  801d49:	89 fa                	mov    %edi,%edx
  801d4b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d4f:	89 34 24             	mov    %esi,(%esp)
  801d52:	85 c0                	test   %eax,%eax
  801d54:	75 1a                	jne    801d70 <__umoddi3+0x48>
  801d56:	39 f7                	cmp    %esi,%edi
  801d58:	0f 86 a2 00 00 00    	jbe    801e00 <__umoddi3+0xd8>
  801d5e:	89 c8                	mov    %ecx,%eax
  801d60:	89 f2                	mov    %esi,%edx
  801d62:	f7 f7                	div    %edi
  801d64:	89 d0                	mov    %edx,%eax
  801d66:	31 d2                	xor    %edx,%edx
  801d68:	83 c4 1c             	add    $0x1c,%esp
  801d6b:	5b                   	pop    %ebx
  801d6c:	5e                   	pop    %esi
  801d6d:	5f                   	pop    %edi
  801d6e:	5d                   	pop    %ebp
  801d6f:	c3                   	ret    
  801d70:	39 f0                	cmp    %esi,%eax
  801d72:	0f 87 ac 00 00 00    	ja     801e24 <__umoddi3+0xfc>
  801d78:	0f bd e8             	bsr    %eax,%ebp
  801d7b:	83 f5 1f             	xor    $0x1f,%ebp
  801d7e:	0f 84 ac 00 00 00    	je     801e30 <__umoddi3+0x108>
  801d84:	bf 20 00 00 00       	mov    $0x20,%edi
  801d89:	29 ef                	sub    %ebp,%edi
  801d8b:	89 fe                	mov    %edi,%esi
  801d8d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d91:	89 e9                	mov    %ebp,%ecx
  801d93:	d3 e0                	shl    %cl,%eax
  801d95:	89 d7                	mov    %edx,%edi
  801d97:	89 f1                	mov    %esi,%ecx
  801d99:	d3 ef                	shr    %cl,%edi
  801d9b:	09 c7                	or     %eax,%edi
  801d9d:	89 e9                	mov    %ebp,%ecx
  801d9f:	d3 e2                	shl    %cl,%edx
  801da1:	89 14 24             	mov    %edx,(%esp)
  801da4:	89 d8                	mov    %ebx,%eax
  801da6:	d3 e0                	shl    %cl,%eax
  801da8:	89 c2                	mov    %eax,%edx
  801daa:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dae:	d3 e0                	shl    %cl,%eax
  801db0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801db4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801db8:	89 f1                	mov    %esi,%ecx
  801dba:	d3 e8                	shr    %cl,%eax
  801dbc:	09 d0                	or     %edx,%eax
  801dbe:	d3 eb                	shr    %cl,%ebx
  801dc0:	89 da                	mov    %ebx,%edx
  801dc2:	f7 f7                	div    %edi
  801dc4:	89 d3                	mov    %edx,%ebx
  801dc6:	f7 24 24             	mull   (%esp)
  801dc9:	89 c6                	mov    %eax,%esi
  801dcb:	89 d1                	mov    %edx,%ecx
  801dcd:	39 d3                	cmp    %edx,%ebx
  801dcf:	0f 82 87 00 00 00    	jb     801e5c <__umoddi3+0x134>
  801dd5:	0f 84 91 00 00 00    	je     801e6c <__umoddi3+0x144>
  801ddb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ddf:	29 f2                	sub    %esi,%edx
  801de1:	19 cb                	sbb    %ecx,%ebx
  801de3:	89 d8                	mov    %ebx,%eax
  801de5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801de9:	d3 e0                	shl    %cl,%eax
  801deb:	89 e9                	mov    %ebp,%ecx
  801ded:	d3 ea                	shr    %cl,%edx
  801def:	09 d0                	or     %edx,%eax
  801df1:	89 e9                	mov    %ebp,%ecx
  801df3:	d3 eb                	shr    %cl,%ebx
  801df5:	89 da                	mov    %ebx,%edx
  801df7:	83 c4 1c             	add    $0x1c,%esp
  801dfa:	5b                   	pop    %ebx
  801dfb:	5e                   	pop    %esi
  801dfc:	5f                   	pop    %edi
  801dfd:	5d                   	pop    %ebp
  801dfe:	c3                   	ret    
  801dff:	90                   	nop
  801e00:	89 fd                	mov    %edi,%ebp
  801e02:	85 ff                	test   %edi,%edi
  801e04:	75 0b                	jne    801e11 <__umoddi3+0xe9>
  801e06:	b8 01 00 00 00       	mov    $0x1,%eax
  801e0b:	31 d2                	xor    %edx,%edx
  801e0d:	f7 f7                	div    %edi
  801e0f:	89 c5                	mov    %eax,%ebp
  801e11:	89 f0                	mov    %esi,%eax
  801e13:	31 d2                	xor    %edx,%edx
  801e15:	f7 f5                	div    %ebp
  801e17:	89 c8                	mov    %ecx,%eax
  801e19:	f7 f5                	div    %ebp
  801e1b:	89 d0                	mov    %edx,%eax
  801e1d:	e9 44 ff ff ff       	jmp    801d66 <__umoddi3+0x3e>
  801e22:	66 90                	xchg   %ax,%ax
  801e24:	89 c8                	mov    %ecx,%eax
  801e26:	89 f2                	mov    %esi,%edx
  801e28:	83 c4 1c             	add    $0x1c,%esp
  801e2b:	5b                   	pop    %ebx
  801e2c:	5e                   	pop    %esi
  801e2d:	5f                   	pop    %edi
  801e2e:	5d                   	pop    %ebp
  801e2f:	c3                   	ret    
  801e30:	3b 04 24             	cmp    (%esp),%eax
  801e33:	72 06                	jb     801e3b <__umoddi3+0x113>
  801e35:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e39:	77 0f                	ja     801e4a <__umoddi3+0x122>
  801e3b:	89 f2                	mov    %esi,%edx
  801e3d:	29 f9                	sub    %edi,%ecx
  801e3f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e43:	89 14 24             	mov    %edx,(%esp)
  801e46:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e4a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e4e:	8b 14 24             	mov    (%esp),%edx
  801e51:	83 c4 1c             	add    $0x1c,%esp
  801e54:	5b                   	pop    %ebx
  801e55:	5e                   	pop    %esi
  801e56:	5f                   	pop    %edi
  801e57:	5d                   	pop    %ebp
  801e58:	c3                   	ret    
  801e59:	8d 76 00             	lea    0x0(%esi),%esi
  801e5c:	2b 04 24             	sub    (%esp),%eax
  801e5f:	19 fa                	sbb    %edi,%edx
  801e61:	89 d1                	mov    %edx,%ecx
  801e63:	89 c6                	mov    %eax,%esi
  801e65:	e9 71 ff ff ff       	jmp    801ddb <__umoddi3+0xb3>
  801e6a:	66 90                	xchg   %ax,%ax
  801e6c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e70:	72 ea                	jb     801e5c <__umoddi3+0x134>
  801e72:	89 d9                	mov    %ebx,%ecx
  801e74:	e9 62 ff ff ff       	jmp    801ddb <__umoddi3+0xb3>


obj/user/tst_mod_44:     file format elf32-i386


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
  800031:	e8 90 03 00 00       	call   8003c6 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

#include <inc/lib.h>
extern void sys_clear_ffl() ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 58             	sub    $0x58,%esp
	//	cprintf("envID = %d\n",envID);

	
	

	uint8* ptr = (uint8* )0x0801000 ;
  80003e:	c7 45 f0 00 10 80 00 	movl   $0x801000,-0x10(%ebp)
	uint8* ptr2 = (uint8* )0x080400A ;
  800045:	c7 45 ec 0a 40 80 00 	movl   $0x80400a,-0x14(%ebp)
	uint8* ptr3 = (uint8* )(USTACKTOP - PTSIZE) ;
  80004c:	c7 45 e8 00 e0 7f ee 	movl   $0xee7fe000,-0x18(%ebp)

	//("STEP 0: checking InitialWSError2: INITIAL WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800053:	a1 20 30 80 00       	mov    0x803020,%eax
  800058:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80005e:	8b 00                	mov    (%eax),%eax
  800060:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800063:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800066:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80006b:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800070:	74 14                	je     800086 <_main+0x4e>
  800072:	83 ec 04             	sub    $0x4,%esp
  800075:	68 00 1e 80 00       	push   $0x801e00
  80007a:	6a 16                	push   $0x16
  80007c:	68 52 1e 80 00       	push   $0x801e52
  800081:	e8 85 04 00 00       	call   80050b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800086:	a1 20 30 80 00       	mov    0x803020,%eax
  80008b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800091:	83 c0 10             	add    $0x10,%eax
  800094:	8b 00                	mov    (%eax),%eax
  800096:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800099:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80009c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000a1:	3d 00 10 20 00       	cmp    $0x201000,%eax
  8000a6:	74 14                	je     8000bc <_main+0x84>
  8000a8:	83 ec 04             	sub    $0x4,%esp
  8000ab:	68 00 1e 80 00       	push   $0x801e00
  8000b0:	6a 17                	push   $0x17
  8000b2:	68 52 1e 80 00       	push   $0x801e52
  8000b7:	e8 4f 04 00 00       	call   80050b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000bc:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000c7:	83 c0 20             	add    $0x20,%eax
  8000ca:	8b 00                	mov    (%eax),%eax
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8000cf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000d7:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000dc:	74 14                	je     8000f2 <_main+0xba>
  8000de:	83 ec 04             	sub    $0x4,%esp
  8000e1:	68 00 1e 80 00       	push   $0x801e00
  8000e6:	6a 18                	push   $0x18
  8000e8:	68 52 1e 80 00       	push   $0x801e52
  8000ed:	e8 19 04 00 00       	call   80050b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000fd:	83 c0 30             	add    $0x30,%eax
  800100:	8b 00                	mov    (%eax),%eax
  800102:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800105:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800108:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80010d:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800112:	74 14                	je     800128 <_main+0xf0>
  800114:	83 ec 04             	sub    $0x4,%esp
  800117:	68 00 1e 80 00       	push   $0x801e00
  80011c:	6a 19                	push   $0x19
  80011e:	68 52 1e 80 00       	push   $0x801e52
  800123:	e8 e3 03 00 00       	call   80050b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800128:	a1 20 30 80 00       	mov    0x803020,%eax
  80012d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800133:	83 c0 40             	add    $0x40,%eax
  800136:	8b 00                	mov    (%eax),%eax
  800138:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  80013b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80013e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800143:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800148:	74 14                	je     80015e <_main+0x126>
  80014a:	83 ec 04             	sub    $0x4,%esp
  80014d:	68 00 1e 80 00       	push   $0x801e00
  800152:	6a 1a                	push   $0x1a
  800154:	68 52 1e 80 00       	push   $0x801e52
  800159:	e8 ad 03 00 00       	call   80050b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80015e:	a1 20 30 80 00       	mov    0x803020,%eax
  800163:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800169:	83 c0 50             	add    $0x50,%eax
  80016c:	8b 00                	mov    (%eax),%eax
  80016e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800171:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800174:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800179:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80017e:	74 14                	je     800194 <_main+0x15c>
  800180:	83 ec 04             	sub    $0x4,%esp
  800183:	68 00 1e 80 00       	push   $0x801e00
  800188:	6a 1b                	push   $0x1b
  80018a:	68 52 1e 80 00       	push   $0x801e52
  80018f:	e8 77 03 00 00       	call   80050b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800194:	a1 20 30 80 00       	mov    0x803020,%eax
  800199:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80019f:	83 c0 60             	add    $0x60,%eax
  8001a2:	8b 00                	mov    (%eax),%eax
  8001a4:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001a7:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001aa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001af:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001b4:	74 14                	je     8001ca <_main+0x192>
  8001b6:	83 ec 04             	sub    $0x4,%esp
  8001b9:	68 00 1e 80 00       	push   $0x801e00
  8001be:	6a 1c                	push   $0x1c
  8001c0:	68 52 1e 80 00       	push   $0x801e52
  8001c5:	e8 41 03 00 00       	call   80050b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8001cf:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001d5:	83 c0 70             	add    $0x70,%eax
  8001d8:	8b 00                	mov    (%eax),%eax
  8001da:	89 45 c8             	mov    %eax,-0x38(%ebp)
  8001dd:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001e0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001e5:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001ea:	74 14                	je     800200 <_main+0x1c8>
  8001ec:	83 ec 04             	sub    $0x4,%esp
  8001ef:	68 00 1e 80 00       	push   $0x801e00
  8001f4:	6a 1d                	push   $0x1d
  8001f6:	68 52 1e 80 00       	push   $0x801e52
  8001fb:	e8 0b 03 00 00       	call   80050b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800200:	a1 20 30 80 00       	mov    0x803020,%eax
  800205:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80020b:	83 e8 80             	sub    $0xffffff80,%eax
  80020e:	8b 00                	mov    (%eax),%eax
  800210:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800213:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800216:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80021b:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800220:	74 14                	je     800236 <_main+0x1fe>
  800222:	83 ec 04             	sub    $0x4,%esp
  800225:	68 00 1e 80 00       	push   $0x801e00
  80022a:	6a 1e                	push   $0x1e
  80022c:	68 52 1e 80 00       	push   $0x801e52
  800231:	e8 d5 02 00 00       	call   80050b <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800236:	a1 20 30 80 00       	mov    0x803020,%eax
  80023b:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  800241:	85 c0                	test   %eax,%eax
  800243:	74 14                	je     800259 <_main+0x221>
  800245:	83 ec 04             	sub    $0x4,%esp
  800248:	68 64 1e 80 00       	push   $0x801e64
  80024d:	6a 1f                	push   $0x1f
  80024f:	68 52 1e 80 00       	push   $0x801e52
  800254:	e8 b2 02 00 00       	call   80050b <_panic>
	}

	//Reading (Not Modified)
	char garbage1 = *((char*)(0x200000)) ;
  800259:	b8 00 00 20 00       	mov    $0x200000,%eax
  80025e:	8a 00                	mov    (%eax),%al
  800260:	88 45 c3             	mov    %al,-0x3d(%ebp)
	char garbage2 = *((char*)(0x202000)) ;
  800263:	b8 00 20 20 00       	mov    $0x202000,%eax
  800268:	8a 00                	mov    (%eax),%al
  80026a:	88 45 c2             	mov    %al,-0x3e(%ebp)
	char garbage3 = *((char*)(0x204000)) ;
  80026d:	b8 00 40 20 00       	mov    $0x204000,%eax
  800272:	8a 00                	mov    (%eax),%al
  800274:	88 45 c1             	mov    %al,-0x3f(%ebp)

	//Writing (Modified)
	char *a = ((char*)(0x201000)) ;
  800277:	c7 45 bc 00 10 20 00 	movl   $0x201000,-0x44(%ebp)
	*a = 'A';
  80027e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800281:	c6 00 41             	movb   $0x41,(%eax)
	char *b = ((char*)(0x203000)) ;
  800284:	c7 45 b8 00 30 20 00 	movl   $0x203000,-0x48(%ebp)
	*b = 'B';
  80028b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80028e:	c6 00 42             	movb   $0x42,(%eax)
	char *c = ((char*)(0x205000)) ;
  800291:	c7 45 b4 00 50 20 00 	movl   $0x205000,-0x4c(%ebp)
	*c = 'C';
  800298:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80029b:	c6 00 43             	movb   $0x43,(%eax)

	//Clear the FFL
	sys_clear_ffl();
  80029e:	e8 2a 15 00 00       	call   8017cd <sys_clear_ffl>

	//Writing (Modified) (3 frames should be allocated (stack page, mem table, page file table)
	*ptr3 = 255 ;
  8002a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002a6:	c6 00 ff             	movb   $0xff,(%eax)

	//Check the WS and values
	int i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  8002a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002b0:	eb 7a                	jmp    80032c <_main+0x2f4>
	{
		if (ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) ==  0x200000 ||
  8002b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002bd:	8b 00                	mov    (%eax),%eax
  8002bf:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8002c2:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002c5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002ca:	3d 00 00 20 00       	cmp    $0x200000,%eax
  8002cf:	74 44                	je     800315 <_main+0x2dd>
			ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) ==  0x202000 ||
  8002d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002dc:	83 c0 20             	add    $0x20,%eax
  8002df:	8b 00                	mov    (%eax),%eax
  8002e1:	89 45 ac             	mov    %eax,-0x54(%ebp)
  8002e4:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8002e7:	25 00 f0 ff ff       	and    $0xfffff000,%eax

	//Check the WS and values
	int i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
	{
		if (ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) ==  0x200000 ||
  8002ec:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8002f1:	74 22                	je     800315 <_main+0x2dd>
			ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) ==  0x202000 ||
			ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) ==  0x204000)
  8002f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002fe:	83 c0 40             	add    $0x40,%eax
  800301:	8b 00                	mov    (%eax),%eax
  800303:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800306:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800309:	25 00 f0 ff ff       	and    $0xfffff000,%eax
	//Check the WS and values
	int i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
	{
		if (ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) ==  0x200000 ||
			ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) ==  0x202000 ||
  80030e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800313:	75 14                	jne    800329 <_main+0x2f1>
			ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) ==  0x204000)
			panic("test failed! either wrong victim or victim is not removed from WS");
  800315:	83 ec 04             	sub    $0x4,%esp
  800318:	68 bc 1e 80 00       	push   $0x801ebc
  80031d:	6a 3c                	push   $0x3c
  80031f:	68 52 1e 80 00       	push   $0x801e52
  800324:	e8 e2 01 00 00       	call   80050b <_panic>
	//Writing (Modified) (3 frames should be allocated (stack page, mem table, page file table)
	*ptr3 = 255 ;

	//Check the WS and values
	int i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  800329:	ff 45 f4             	incl   -0xc(%ebp)
  80032c:	a1 20 30 80 00       	mov    0x803020,%eax
  800331:	8b 50 74             	mov    0x74(%eax),%edx
  800334:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800337:	39 c2                	cmp    %eax,%edx
  800339:	0f 87 73 ff ff ff    	ja     8002b2 <_main+0x27a>
			ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) ==  0x202000 ||
			ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) ==  0x204000)
			panic("test failed! either wrong victim or victim is not removed from WS");

	}
	if (*a != 'A') panic("test failed!");
  80033f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800342:	8a 00                	mov    (%eax),%al
  800344:	3c 41                	cmp    $0x41,%al
  800346:	74 14                	je     80035c <_main+0x324>
  800348:	83 ec 04             	sub    $0x4,%esp
  80034b:	68 fe 1e 80 00       	push   $0x801efe
  800350:	6a 3f                	push   $0x3f
  800352:	68 52 1e 80 00       	push   $0x801e52
  800357:	e8 af 01 00 00       	call   80050b <_panic>
	if (*b != 'B') panic("test failed!");
  80035c:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80035f:	8a 00                	mov    (%eax),%al
  800361:	3c 42                	cmp    $0x42,%al
  800363:	74 14                	je     800379 <_main+0x341>
  800365:	83 ec 04             	sub    $0x4,%esp
  800368:	68 fe 1e 80 00       	push   $0x801efe
  80036d:	6a 40                	push   $0x40
  80036f:	68 52 1e 80 00       	push   $0x801e52
  800374:	e8 92 01 00 00       	call   80050b <_panic>
	if (*c != 'C') panic("test failed!");
  800379:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80037c:	8a 00                	mov    (%eax),%al
  80037e:	3c 43                	cmp    $0x43,%al
  800380:	74 14                	je     800396 <_main+0x35e>
  800382:	83 ec 04             	sub    $0x4,%esp
  800385:	68 fe 1e 80 00       	push   $0x801efe
  80038a:	6a 41                	push   $0x41
  80038c:	68 52 1e 80 00       	push   $0x801e52
  800391:	e8 75 01 00 00       	call   80050b <_panic>
	if (*ptr3 != 255) panic("test failed!");
  800396:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800399:	8a 00                	mov    (%eax),%al
  80039b:	3c ff                	cmp    $0xff,%al
  80039d:	74 14                	je     8003b3 <_main+0x37b>
  80039f:	83 ec 04             	sub    $0x4,%esp
  8003a2:	68 fe 1e 80 00       	push   $0x801efe
  8003a7:	6a 42                	push   $0x42
  8003a9:	68 52 1e 80 00       	push   $0x801e52
  8003ae:	e8 58 01 00 00       	call   80050b <_panic>

	cprintf("Congratulations!! test modification is completed successfully.\n");
  8003b3:	83 ec 0c             	sub    $0xc,%esp
  8003b6:	68 0c 1f 80 00       	push   $0x801f0c
  8003bb:	e8 ed 03 00 00       	call   8007ad <cprintf>
  8003c0:	83 c4 10             	add    $0x10,%esp
	return;
  8003c3:	90                   	nop
}
  8003c4:	c9                   	leave  
  8003c5:	c3                   	ret    

008003c6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8003c6:	55                   	push   %ebp
  8003c7:	89 e5                	mov    %esp,%ebp
  8003c9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8003cc:	e8 07 12 00 00       	call   8015d8 <sys_getenvindex>
  8003d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8003d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003d7:	89 d0                	mov    %edx,%eax
  8003d9:	c1 e0 03             	shl    $0x3,%eax
  8003dc:	01 d0                	add    %edx,%eax
  8003de:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8003e5:	01 c8                	add    %ecx,%eax
  8003e7:	01 c0                	add    %eax,%eax
  8003e9:	01 d0                	add    %edx,%eax
  8003eb:	01 c0                	add    %eax,%eax
  8003ed:	01 d0                	add    %edx,%eax
  8003ef:	89 c2                	mov    %eax,%edx
  8003f1:	c1 e2 05             	shl    $0x5,%edx
  8003f4:	29 c2                	sub    %eax,%edx
  8003f6:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8003fd:	89 c2                	mov    %eax,%edx
  8003ff:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800405:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80040a:	a1 20 30 80 00       	mov    0x803020,%eax
  80040f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800415:	84 c0                	test   %al,%al
  800417:	74 0f                	je     800428 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800419:	a1 20 30 80 00       	mov    0x803020,%eax
  80041e:	05 40 3c 01 00       	add    $0x13c40,%eax
  800423:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800428:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80042c:	7e 0a                	jle    800438 <libmain+0x72>
		binaryname = argv[0];
  80042e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800431:	8b 00                	mov    (%eax),%eax
  800433:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800438:	83 ec 08             	sub    $0x8,%esp
  80043b:	ff 75 0c             	pushl  0xc(%ebp)
  80043e:	ff 75 08             	pushl  0x8(%ebp)
  800441:	e8 f2 fb ff ff       	call   800038 <_main>
  800446:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800449:	e8 25 13 00 00       	call   801773 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80044e:	83 ec 0c             	sub    $0xc,%esp
  800451:	68 64 1f 80 00       	push   $0x801f64
  800456:	e8 52 03 00 00       	call   8007ad <cprintf>
  80045b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80045e:	a1 20 30 80 00       	mov    0x803020,%eax
  800463:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800469:	a1 20 30 80 00       	mov    0x803020,%eax
  80046e:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800474:	83 ec 04             	sub    $0x4,%esp
  800477:	52                   	push   %edx
  800478:	50                   	push   %eax
  800479:	68 8c 1f 80 00       	push   $0x801f8c
  80047e:	e8 2a 03 00 00       	call   8007ad <cprintf>
  800483:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800486:	a1 20 30 80 00       	mov    0x803020,%eax
  80048b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800491:	a1 20 30 80 00       	mov    0x803020,%eax
  800496:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80049c:	83 ec 04             	sub    $0x4,%esp
  80049f:	52                   	push   %edx
  8004a0:	50                   	push   %eax
  8004a1:	68 b4 1f 80 00       	push   $0x801fb4
  8004a6:	e8 02 03 00 00       	call   8007ad <cprintf>
  8004ab:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004ae:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b3:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8004b9:	83 ec 08             	sub    $0x8,%esp
  8004bc:	50                   	push   %eax
  8004bd:	68 f5 1f 80 00       	push   $0x801ff5
  8004c2:	e8 e6 02 00 00       	call   8007ad <cprintf>
  8004c7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8004ca:	83 ec 0c             	sub    $0xc,%esp
  8004cd:	68 64 1f 80 00       	push   $0x801f64
  8004d2:	e8 d6 02 00 00       	call   8007ad <cprintf>
  8004d7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004da:	e8 ae 12 00 00       	call   80178d <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004df:	e8 19 00 00 00       	call   8004fd <exit>
}
  8004e4:	90                   	nop
  8004e5:	c9                   	leave  
  8004e6:	c3                   	ret    

008004e7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004e7:	55                   	push   %ebp
  8004e8:	89 e5                	mov    %esp,%ebp
  8004ea:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8004ed:	83 ec 0c             	sub    $0xc,%esp
  8004f0:	6a 00                	push   $0x0
  8004f2:	e8 ad 10 00 00       	call   8015a4 <sys_env_destroy>
  8004f7:	83 c4 10             	add    $0x10,%esp
}
  8004fa:	90                   	nop
  8004fb:	c9                   	leave  
  8004fc:	c3                   	ret    

008004fd <exit>:

void
exit(void)
{
  8004fd:	55                   	push   %ebp
  8004fe:	89 e5                	mov    %esp,%ebp
  800500:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800503:	e8 02 11 00 00       	call   80160a <sys_env_exit>
}
  800508:	90                   	nop
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800511:	8d 45 10             	lea    0x10(%ebp),%eax
  800514:	83 c0 04             	add    $0x4,%eax
  800517:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80051a:	a1 18 31 80 00       	mov    0x803118,%eax
  80051f:	85 c0                	test   %eax,%eax
  800521:	74 16                	je     800539 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800523:	a1 18 31 80 00       	mov    0x803118,%eax
  800528:	83 ec 08             	sub    $0x8,%esp
  80052b:	50                   	push   %eax
  80052c:	68 0c 20 80 00       	push   $0x80200c
  800531:	e8 77 02 00 00       	call   8007ad <cprintf>
  800536:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800539:	a1 00 30 80 00       	mov    0x803000,%eax
  80053e:	ff 75 0c             	pushl  0xc(%ebp)
  800541:	ff 75 08             	pushl  0x8(%ebp)
  800544:	50                   	push   %eax
  800545:	68 11 20 80 00       	push   $0x802011
  80054a:	e8 5e 02 00 00       	call   8007ad <cprintf>
  80054f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800552:	8b 45 10             	mov    0x10(%ebp),%eax
  800555:	83 ec 08             	sub    $0x8,%esp
  800558:	ff 75 f4             	pushl  -0xc(%ebp)
  80055b:	50                   	push   %eax
  80055c:	e8 e1 01 00 00       	call   800742 <vcprintf>
  800561:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800564:	83 ec 08             	sub    $0x8,%esp
  800567:	6a 00                	push   $0x0
  800569:	68 2d 20 80 00       	push   $0x80202d
  80056e:	e8 cf 01 00 00       	call   800742 <vcprintf>
  800573:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800576:	e8 82 ff ff ff       	call   8004fd <exit>

	// should not return here
	while (1) ;
  80057b:	eb fe                	jmp    80057b <_panic+0x70>

0080057d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80057d:	55                   	push   %ebp
  80057e:	89 e5                	mov    %esp,%ebp
  800580:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800583:	a1 20 30 80 00       	mov    0x803020,%eax
  800588:	8b 50 74             	mov    0x74(%eax),%edx
  80058b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058e:	39 c2                	cmp    %eax,%edx
  800590:	74 14                	je     8005a6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800592:	83 ec 04             	sub    $0x4,%esp
  800595:	68 30 20 80 00       	push   $0x802030
  80059a:	6a 26                	push   $0x26
  80059c:	68 7c 20 80 00       	push   $0x80207c
  8005a1:	e8 65 ff ff ff       	call   80050b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8005a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005b4:	e9 b6 00 00 00       	jmp    80066f <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8005b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c6:	01 d0                	add    %edx,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	85 c0                	test   %eax,%eax
  8005cc:	75 08                	jne    8005d6 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8005ce:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005d1:	e9 96 00 00 00       	jmp    80066c <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8005d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005dd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005e4:	eb 5d                	jmp    800643 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8005e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8005eb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005f1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005f4:	c1 e2 04             	shl    $0x4,%edx
  8005f7:	01 d0                	add    %edx,%eax
  8005f9:	8a 40 04             	mov    0x4(%eax),%al
  8005fc:	84 c0                	test   %al,%al
  8005fe:	75 40                	jne    800640 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800600:	a1 20 30 80 00       	mov    0x803020,%eax
  800605:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80060b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80060e:	c1 e2 04             	shl    $0x4,%edx
  800611:	01 d0                	add    %edx,%eax
  800613:	8b 00                	mov    (%eax),%eax
  800615:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800618:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80061b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800620:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800622:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800625:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80062c:	8b 45 08             	mov    0x8(%ebp),%eax
  80062f:	01 c8                	add    %ecx,%eax
  800631:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800633:	39 c2                	cmp    %eax,%edx
  800635:	75 09                	jne    800640 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800637:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80063e:	eb 12                	jmp    800652 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800640:	ff 45 e8             	incl   -0x18(%ebp)
  800643:	a1 20 30 80 00       	mov    0x803020,%eax
  800648:	8b 50 74             	mov    0x74(%eax),%edx
  80064b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80064e:	39 c2                	cmp    %eax,%edx
  800650:	77 94                	ja     8005e6 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800652:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800656:	75 14                	jne    80066c <CheckWSWithoutLastIndex+0xef>
			panic(
  800658:	83 ec 04             	sub    $0x4,%esp
  80065b:	68 88 20 80 00       	push   $0x802088
  800660:	6a 3a                	push   $0x3a
  800662:	68 7c 20 80 00       	push   $0x80207c
  800667:	e8 9f fe ff ff       	call   80050b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80066c:	ff 45 f0             	incl   -0x10(%ebp)
  80066f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800672:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800675:	0f 8c 3e ff ff ff    	jl     8005b9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80067b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800682:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800689:	eb 20                	jmp    8006ab <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80068b:	a1 20 30 80 00       	mov    0x803020,%eax
  800690:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800696:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800699:	c1 e2 04             	shl    $0x4,%edx
  80069c:	01 d0                	add    %edx,%eax
  80069e:	8a 40 04             	mov    0x4(%eax),%al
  8006a1:	3c 01                	cmp    $0x1,%al
  8006a3:	75 03                	jne    8006a8 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8006a5:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006a8:	ff 45 e0             	incl   -0x20(%ebp)
  8006ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b0:	8b 50 74             	mov    0x74(%eax),%edx
  8006b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006b6:	39 c2                	cmp    %eax,%edx
  8006b8:	77 d1                	ja     80068b <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006bd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006c0:	74 14                	je     8006d6 <CheckWSWithoutLastIndex+0x159>
		panic(
  8006c2:	83 ec 04             	sub    $0x4,%esp
  8006c5:	68 dc 20 80 00       	push   $0x8020dc
  8006ca:	6a 44                	push   $0x44
  8006cc:	68 7c 20 80 00       	push   $0x80207c
  8006d1:	e8 35 fe ff ff       	call   80050b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006d6:	90                   	nop
  8006d7:	c9                   	leave  
  8006d8:	c3                   	ret    

008006d9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8006d9:	55                   	push   %ebp
  8006da:	89 e5                	mov    %esp,%ebp
  8006dc:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8006df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e2:	8b 00                	mov    (%eax),%eax
  8006e4:	8d 48 01             	lea    0x1(%eax),%ecx
  8006e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006ea:	89 0a                	mov    %ecx,(%edx)
  8006ec:	8b 55 08             	mov    0x8(%ebp),%edx
  8006ef:	88 d1                	mov    %dl,%cl
  8006f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006f4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006fb:	8b 00                	mov    (%eax),%eax
  8006fd:	3d ff 00 00 00       	cmp    $0xff,%eax
  800702:	75 2c                	jne    800730 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800704:	a0 24 30 80 00       	mov    0x803024,%al
  800709:	0f b6 c0             	movzbl %al,%eax
  80070c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80070f:	8b 12                	mov    (%edx),%edx
  800711:	89 d1                	mov    %edx,%ecx
  800713:	8b 55 0c             	mov    0xc(%ebp),%edx
  800716:	83 c2 08             	add    $0x8,%edx
  800719:	83 ec 04             	sub    $0x4,%esp
  80071c:	50                   	push   %eax
  80071d:	51                   	push   %ecx
  80071e:	52                   	push   %edx
  80071f:	e8 3e 0e 00 00       	call   801562 <sys_cputs>
  800724:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800727:	8b 45 0c             	mov    0xc(%ebp),%eax
  80072a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800730:	8b 45 0c             	mov    0xc(%ebp),%eax
  800733:	8b 40 04             	mov    0x4(%eax),%eax
  800736:	8d 50 01             	lea    0x1(%eax),%edx
  800739:	8b 45 0c             	mov    0xc(%ebp),%eax
  80073c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80073f:	90                   	nop
  800740:	c9                   	leave  
  800741:	c3                   	ret    

00800742 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800742:	55                   	push   %ebp
  800743:	89 e5                	mov    %esp,%ebp
  800745:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80074b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800752:	00 00 00 
	b.cnt = 0;
  800755:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80075c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80075f:	ff 75 0c             	pushl  0xc(%ebp)
  800762:	ff 75 08             	pushl  0x8(%ebp)
  800765:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80076b:	50                   	push   %eax
  80076c:	68 d9 06 80 00       	push   $0x8006d9
  800771:	e8 11 02 00 00       	call   800987 <vprintfmt>
  800776:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800779:	a0 24 30 80 00       	mov    0x803024,%al
  80077e:	0f b6 c0             	movzbl %al,%eax
  800781:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800787:	83 ec 04             	sub    $0x4,%esp
  80078a:	50                   	push   %eax
  80078b:	52                   	push   %edx
  80078c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800792:	83 c0 08             	add    $0x8,%eax
  800795:	50                   	push   %eax
  800796:	e8 c7 0d 00 00       	call   801562 <sys_cputs>
  80079b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80079e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8007a5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007ab:	c9                   	leave  
  8007ac:	c3                   	ret    

008007ad <cprintf>:

int cprintf(const char *fmt, ...) {
  8007ad:	55                   	push   %ebp
  8007ae:	89 e5                	mov    %esp,%ebp
  8007b0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007b3:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8007ba:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c3:	83 ec 08             	sub    $0x8,%esp
  8007c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8007c9:	50                   	push   %eax
  8007ca:	e8 73 ff ff ff       	call   800742 <vcprintf>
  8007cf:	83 c4 10             	add    $0x10,%esp
  8007d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007d8:	c9                   	leave  
  8007d9:	c3                   	ret    

008007da <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8007da:	55                   	push   %ebp
  8007db:	89 e5                	mov    %esp,%ebp
  8007dd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007e0:	e8 8e 0f 00 00       	call   801773 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8007e5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ee:	83 ec 08             	sub    $0x8,%esp
  8007f1:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f4:	50                   	push   %eax
  8007f5:	e8 48 ff ff ff       	call   800742 <vcprintf>
  8007fa:	83 c4 10             	add    $0x10,%esp
  8007fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800800:	e8 88 0f 00 00       	call   80178d <sys_enable_interrupt>
	return cnt;
  800805:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800808:	c9                   	leave  
  800809:	c3                   	ret    

0080080a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80080a:	55                   	push   %ebp
  80080b:	89 e5                	mov    %esp,%ebp
  80080d:	53                   	push   %ebx
  80080e:	83 ec 14             	sub    $0x14,%esp
  800811:	8b 45 10             	mov    0x10(%ebp),%eax
  800814:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800817:	8b 45 14             	mov    0x14(%ebp),%eax
  80081a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80081d:	8b 45 18             	mov    0x18(%ebp),%eax
  800820:	ba 00 00 00 00       	mov    $0x0,%edx
  800825:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800828:	77 55                	ja     80087f <printnum+0x75>
  80082a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80082d:	72 05                	jb     800834 <printnum+0x2a>
  80082f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800832:	77 4b                	ja     80087f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800834:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800837:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80083a:	8b 45 18             	mov    0x18(%ebp),%eax
  80083d:	ba 00 00 00 00       	mov    $0x0,%edx
  800842:	52                   	push   %edx
  800843:	50                   	push   %eax
  800844:	ff 75 f4             	pushl  -0xc(%ebp)
  800847:	ff 75 f0             	pushl  -0x10(%ebp)
  80084a:	e8 45 13 00 00       	call   801b94 <__udivdi3>
  80084f:	83 c4 10             	add    $0x10,%esp
  800852:	83 ec 04             	sub    $0x4,%esp
  800855:	ff 75 20             	pushl  0x20(%ebp)
  800858:	53                   	push   %ebx
  800859:	ff 75 18             	pushl  0x18(%ebp)
  80085c:	52                   	push   %edx
  80085d:	50                   	push   %eax
  80085e:	ff 75 0c             	pushl  0xc(%ebp)
  800861:	ff 75 08             	pushl  0x8(%ebp)
  800864:	e8 a1 ff ff ff       	call   80080a <printnum>
  800869:	83 c4 20             	add    $0x20,%esp
  80086c:	eb 1a                	jmp    800888 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80086e:	83 ec 08             	sub    $0x8,%esp
  800871:	ff 75 0c             	pushl  0xc(%ebp)
  800874:	ff 75 20             	pushl  0x20(%ebp)
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	ff d0                	call   *%eax
  80087c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80087f:	ff 4d 1c             	decl   0x1c(%ebp)
  800882:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800886:	7f e6                	jg     80086e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800888:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80088b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800890:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800893:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800896:	53                   	push   %ebx
  800897:	51                   	push   %ecx
  800898:	52                   	push   %edx
  800899:	50                   	push   %eax
  80089a:	e8 05 14 00 00       	call   801ca4 <__umoddi3>
  80089f:	83 c4 10             	add    $0x10,%esp
  8008a2:	05 54 23 80 00       	add    $0x802354,%eax
  8008a7:	8a 00                	mov    (%eax),%al
  8008a9:	0f be c0             	movsbl %al,%eax
  8008ac:	83 ec 08             	sub    $0x8,%esp
  8008af:	ff 75 0c             	pushl  0xc(%ebp)
  8008b2:	50                   	push   %eax
  8008b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b6:	ff d0                	call   *%eax
  8008b8:	83 c4 10             	add    $0x10,%esp
}
  8008bb:	90                   	nop
  8008bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8008bf:	c9                   	leave  
  8008c0:	c3                   	ret    

008008c1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8008c1:	55                   	push   %ebp
  8008c2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008c4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008c8:	7e 1c                	jle    8008e6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8008ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cd:	8b 00                	mov    (%eax),%eax
  8008cf:	8d 50 08             	lea    0x8(%eax),%edx
  8008d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d5:	89 10                	mov    %edx,(%eax)
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	8b 00                	mov    (%eax),%eax
  8008dc:	83 e8 08             	sub    $0x8,%eax
  8008df:	8b 50 04             	mov    0x4(%eax),%edx
  8008e2:	8b 00                	mov    (%eax),%eax
  8008e4:	eb 40                	jmp    800926 <getuint+0x65>
	else if (lflag)
  8008e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008ea:	74 1e                	je     80090a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	8b 00                	mov    (%eax),%eax
  8008f1:	8d 50 04             	lea    0x4(%eax),%edx
  8008f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f7:	89 10                	mov    %edx,(%eax)
  8008f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fc:	8b 00                	mov    (%eax),%eax
  8008fe:	83 e8 04             	sub    $0x4,%eax
  800901:	8b 00                	mov    (%eax),%eax
  800903:	ba 00 00 00 00       	mov    $0x0,%edx
  800908:	eb 1c                	jmp    800926 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80090a:	8b 45 08             	mov    0x8(%ebp),%eax
  80090d:	8b 00                	mov    (%eax),%eax
  80090f:	8d 50 04             	lea    0x4(%eax),%edx
  800912:	8b 45 08             	mov    0x8(%ebp),%eax
  800915:	89 10                	mov    %edx,(%eax)
  800917:	8b 45 08             	mov    0x8(%ebp),%eax
  80091a:	8b 00                	mov    (%eax),%eax
  80091c:	83 e8 04             	sub    $0x4,%eax
  80091f:	8b 00                	mov    (%eax),%eax
  800921:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800926:	5d                   	pop    %ebp
  800927:	c3                   	ret    

00800928 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800928:	55                   	push   %ebp
  800929:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80092b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80092f:	7e 1c                	jle    80094d <getint+0x25>
		return va_arg(*ap, long long);
  800931:	8b 45 08             	mov    0x8(%ebp),%eax
  800934:	8b 00                	mov    (%eax),%eax
  800936:	8d 50 08             	lea    0x8(%eax),%edx
  800939:	8b 45 08             	mov    0x8(%ebp),%eax
  80093c:	89 10                	mov    %edx,(%eax)
  80093e:	8b 45 08             	mov    0x8(%ebp),%eax
  800941:	8b 00                	mov    (%eax),%eax
  800943:	83 e8 08             	sub    $0x8,%eax
  800946:	8b 50 04             	mov    0x4(%eax),%edx
  800949:	8b 00                	mov    (%eax),%eax
  80094b:	eb 38                	jmp    800985 <getint+0x5d>
	else if (lflag)
  80094d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800951:	74 1a                	je     80096d <getint+0x45>
		return va_arg(*ap, long);
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	8b 00                	mov    (%eax),%eax
  800958:	8d 50 04             	lea    0x4(%eax),%edx
  80095b:	8b 45 08             	mov    0x8(%ebp),%eax
  80095e:	89 10                	mov    %edx,(%eax)
  800960:	8b 45 08             	mov    0x8(%ebp),%eax
  800963:	8b 00                	mov    (%eax),%eax
  800965:	83 e8 04             	sub    $0x4,%eax
  800968:	8b 00                	mov    (%eax),%eax
  80096a:	99                   	cltd   
  80096b:	eb 18                	jmp    800985 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80096d:	8b 45 08             	mov    0x8(%ebp),%eax
  800970:	8b 00                	mov    (%eax),%eax
  800972:	8d 50 04             	lea    0x4(%eax),%edx
  800975:	8b 45 08             	mov    0x8(%ebp),%eax
  800978:	89 10                	mov    %edx,(%eax)
  80097a:	8b 45 08             	mov    0x8(%ebp),%eax
  80097d:	8b 00                	mov    (%eax),%eax
  80097f:	83 e8 04             	sub    $0x4,%eax
  800982:	8b 00                	mov    (%eax),%eax
  800984:	99                   	cltd   
}
  800985:	5d                   	pop    %ebp
  800986:	c3                   	ret    

00800987 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800987:	55                   	push   %ebp
  800988:	89 e5                	mov    %esp,%ebp
  80098a:	56                   	push   %esi
  80098b:	53                   	push   %ebx
  80098c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80098f:	eb 17                	jmp    8009a8 <vprintfmt+0x21>
			if (ch == '\0')
  800991:	85 db                	test   %ebx,%ebx
  800993:	0f 84 af 03 00 00    	je     800d48 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800999:	83 ec 08             	sub    $0x8,%esp
  80099c:	ff 75 0c             	pushl  0xc(%ebp)
  80099f:	53                   	push   %ebx
  8009a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a3:	ff d0                	call   *%eax
  8009a5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ab:	8d 50 01             	lea    0x1(%eax),%edx
  8009ae:	89 55 10             	mov    %edx,0x10(%ebp)
  8009b1:	8a 00                	mov    (%eax),%al
  8009b3:	0f b6 d8             	movzbl %al,%ebx
  8009b6:	83 fb 25             	cmp    $0x25,%ebx
  8009b9:	75 d6                	jne    800991 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8009bb:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8009bf:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8009c6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8009cd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8009d4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8009db:	8b 45 10             	mov    0x10(%ebp),%eax
  8009de:	8d 50 01             	lea    0x1(%eax),%edx
  8009e1:	89 55 10             	mov    %edx,0x10(%ebp)
  8009e4:	8a 00                	mov    (%eax),%al
  8009e6:	0f b6 d8             	movzbl %al,%ebx
  8009e9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8009ec:	83 f8 55             	cmp    $0x55,%eax
  8009ef:	0f 87 2b 03 00 00    	ja     800d20 <vprintfmt+0x399>
  8009f5:	8b 04 85 78 23 80 00 	mov    0x802378(,%eax,4),%eax
  8009fc:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009fe:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a02:	eb d7                	jmp    8009db <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a04:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a08:	eb d1                	jmp    8009db <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a0a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a11:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a14:	89 d0                	mov    %edx,%eax
  800a16:	c1 e0 02             	shl    $0x2,%eax
  800a19:	01 d0                	add    %edx,%eax
  800a1b:	01 c0                	add    %eax,%eax
  800a1d:	01 d8                	add    %ebx,%eax
  800a1f:	83 e8 30             	sub    $0x30,%eax
  800a22:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a25:	8b 45 10             	mov    0x10(%ebp),%eax
  800a28:	8a 00                	mov    (%eax),%al
  800a2a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a2d:	83 fb 2f             	cmp    $0x2f,%ebx
  800a30:	7e 3e                	jle    800a70 <vprintfmt+0xe9>
  800a32:	83 fb 39             	cmp    $0x39,%ebx
  800a35:	7f 39                	jg     800a70 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a37:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a3a:	eb d5                	jmp    800a11 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a3f:	83 c0 04             	add    $0x4,%eax
  800a42:	89 45 14             	mov    %eax,0x14(%ebp)
  800a45:	8b 45 14             	mov    0x14(%ebp),%eax
  800a48:	83 e8 04             	sub    $0x4,%eax
  800a4b:	8b 00                	mov    (%eax),%eax
  800a4d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a50:	eb 1f                	jmp    800a71 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a52:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a56:	79 83                	jns    8009db <vprintfmt+0x54>
				width = 0;
  800a58:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a5f:	e9 77 ff ff ff       	jmp    8009db <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a64:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a6b:	e9 6b ff ff ff       	jmp    8009db <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a70:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a71:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a75:	0f 89 60 ff ff ff    	jns    8009db <vprintfmt+0x54>
				width = precision, precision = -1;
  800a7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a7e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a81:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a88:	e9 4e ff ff ff       	jmp    8009db <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a8d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a90:	e9 46 ff ff ff       	jmp    8009db <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a95:	8b 45 14             	mov    0x14(%ebp),%eax
  800a98:	83 c0 04             	add    $0x4,%eax
  800a9b:	89 45 14             	mov    %eax,0x14(%ebp)
  800a9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa1:	83 e8 04             	sub    $0x4,%eax
  800aa4:	8b 00                	mov    (%eax),%eax
  800aa6:	83 ec 08             	sub    $0x8,%esp
  800aa9:	ff 75 0c             	pushl  0xc(%ebp)
  800aac:	50                   	push   %eax
  800aad:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab0:	ff d0                	call   *%eax
  800ab2:	83 c4 10             	add    $0x10,%esp
			break;
  800ab5:	e9 89 02 00 00       	jmp    800d43 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800aba:	8b 45 14             	mov    0x14(%ebp),%eax
  800abd:	83 c0 04             	add    $0x4,%eax
  800ac0:	89 45 14             	mov    %eax,0x14(%ebp)
  800ac3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac6:	83 e8 04             	sub    $0x4,%eax
  800ac9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800acb:	85 db                	test   %ebx,%ebx
  800acd:	79 02                	jns    800ad1 <vprintfmt+0x14a>
				err = -err;
  800acf:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ad1:	83 fb 64             	cmp    $0x64,%ebx
  800ad4:	7f 0b                	jg     800ae1 <vprintfmt+0x15a>
  800ad6:	8b 34 9d c0 21 80 00 	mov    0x8021c0(,%ebx,4),%esi
  800add:	85 f6                	test   %esi,%esi
  800adf:	75 19                	jne    800afa <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ae1:	53                   	push   %ebx
  800ae2:	68 65 23 80 00       	push   $0x802365
  800ae7:	ff 75 0c             	pushl  0xc(%ebp)
  800aea:	ff 75 08             	pushl  0x8(%ebp)
  800aed:	e8 5e 02 00 00       	call   800d50 <printfmt>
  800af2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800af5:	e9 49 02 00 00       	jmp    800d43 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800afa:	56                   	push   %esi
  800afb:	68 6e 23 80 00       	push   $0x80236e
  800b00:	ff 75 0c             	pushl  0xc(%ebp)
  800b03:	ff 75 08             	pushl  0x8(%ebp)
  800b06:	e8 45 02 00 00       	call   800d50 <printfmt>
  800b0b:	83 c4 10             	add    $0x10,%esp
			break;
  800b0e:	e9 30 02 00 00       	jmp    800d43 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b13:	8b 45 14             	mov    0x14(%ebp),%eax
  800b16:	83 c0 04             	add    $0x4,%eax
  800b19:	89 45 14             	mov    %eax,0x14(%ebp)
  800b1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b1f:	83 e8 04             	sub    $0x4,%eax
  800b22:	8b 30                	mov    (%eax),%esi
  800b24:	85 f6                	test   %esi,%esi
  800b26:	75 05                	jne    800b2d <vprintfmt+0x1a6>
				p = "(null)";
  800b28:	be 71 23 80 00       	mov    $0x802371,%esi
			if (width > 0 && padc != '-')
  800b2d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b31:	7e 6d                	jle    800ba0 <vprintfmt+0x219>
  800b33:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b37:	74 67                	je     800ba0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b39:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b3c:	83 ec 08             	sub    $0x8,%esp
  800b3f:	50                   	push   %eax
  800b40:	56                   	push   %esi
  800b41:	e8 0c 03 00 00       	call   800e52 <strnlen>
  800b46:	83 c4 10             	add    $0x10,%esp
  800b49:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b4c:	eb 16                	jmp    800b64 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b4e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b52:	83 ec 08             	sub    $0x8,%esp
  800b55:	ff 75 0c             	pushl  0xc(%ebp)
  800b58:	50                   	push   %eax
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	ff d0                	call   *%eax
  800b5e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b61:	ff 4d e4             	decl   -0x1c(%ebp)
  800b64:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b68:	7f e4                	jg     800b4e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b6a:	eb 34                	jmp    800ba0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b6c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b70:	74 1c                	je     800b8e <vprintfmt+0x207>
  800b72:	83 fb 1f             	cmp    $0x1f,%ebx
  800b75:	7e 05                	jle    800b7c <vprintfmt+0x1f5>
  800b77:	83 fb 7e             	cmp    $0x7e,%ebx
  800b7a:	7e 12                	jle    800b8e <vprintfmt+0x207>
					putch('?', putdat);
  800b7c:	83 ec 08             	sub    $0x8,%esp
  800b7f:	ff 75 0c             	pushl  0xc(%ebp)
  800b82:	6a 3f                	push   $0x3f
  800b84:	8b 45 08             	mov    0x8(%ebp),%eax
  800b87:	ff d0                	call   *%eax
  800b89:	83 c4 10             	add    $0x10,%esp
  800b8c:	eb 0f                	jmp    800b9d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b8e:	83 ec 08             	sub    $0x8,%esp
  800b91:	ff 75 0c             	pushl  0xc(%ebp)
  800b94:	53                   	push   %ebx
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	ff d0                	call   *%eax
  800b9a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b9d:	ff 4d e4             	decl   -0x1c(%ebp)
  800ba0:	89 f0                	mov    %esi,%eax
  800ba2:	8d 70 01             	lea    0x1(%eax),%esi
  800ba5:	8a 00                	mov    (%eax),%al
  800ba7:	0f be d8             	movsbl %al,%ebx
  800baa:	85 db                	test   %ebx,%ebx
  800bac:	74 24                	je     800bd2 <vprintfmt+0x24b>
  800bae:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bb2:	78 b8                	js     800b6c <vprintfmt+0x1e5>
  800bb4:	ff 4d e0             	decl   -0x20(%ebp)
  800bb7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bbb:	79 af                	jns    800b6c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bbd:	eb 13                	jmp    800bd2 <vprintfmt+0x24b>
				putch(' ', putdat);
  800bbf:	83 ec 08             	sub    $0x8,%esp
  800bc2:	ff 75 0c             	pushl  0xc(%ebp)
  800bc5:	6a 20                	push   $0x20
  800bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bca:	ff d0                	call   *%eax
  800bcc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bcf:	ff 4d e4             	decl   -0x1c(%ebp)
  800bd2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bd6:	7f e7                	jg     800bbf <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800bd8:	e9 66 01 00 00       	jmp    800d43 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800bdd:	83 ec 08             	sub    $0x8,%esp
  800be0:	ff 75 e8             	pushl  -0x18(%ebp)
  800be3:	8d 45 14             	lea    0x14(%ebp),%eax
  800be6:	50                   	push   %eax
  800be7:	e8 3c fd ff ff       	call   800928 <getint>
  800bec:	83 c4 10             	add    $0x10,%esp
  800bef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800bf5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bf8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bfb:	85 d2                	test   %edx,%edx
  800bfd:	79 23                	jns    800c22 <vprintfmt+0x29b>
				putch('-', putdat);
  800bff:	83 ec 08             	sub    $0x8,%esp
  800c02:	ff 75 0c             	pushl  0xc(%ebp)
  800c05:	6a 2d                	push   $0x2d
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	ff d0                	call   *%eax
  800c0c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c12:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c15:	f7 d8                	neg    %eax
  800c17:	83 d2 00             	adc    $0x0,%edx
  800c1a:	f7 da                	neg    %edx
  800c1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c1f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c22:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c29:	e9 bc 00 00 00       	jmp    800cea <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c2e:	83 ec 08             	sub    $0x8,%esp
  800c31:	ff 75 e8             	pushl  -0x18(%ebp)
  800c34:	8d 45 14             	lea    0x14(%ebp),%eax
  800c37:	50                   	push   %eax
  800c38:	e8 84 fc ff ff       	call   8008c1 <getuint>
  800c3d:	83 c4 10             	add    $0x10,%esp
  800c40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c43:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c46:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c4d:	e9 98 00 00 00       	jmp    800cea <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c52:	83 ec 08             	sub    $0x8,%esp
  800c55:	ff 75 0c             	pushl  0xc(%ebp)
  800c58:	6a 58                	push   $0x58
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	ff d0                	call   *%eax
  800c5f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c62:	83 ec 08             	sub    $0x8,%esp
  800c65:	ff 75 0c             	pushl  0xc(%ebp)
  800c68:	6a 58                	push   $0x58
  800c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6d:	ff d0                	call   *%eax
  800c6f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c72:	83 ec 08             	sub    $0x8,%esp
  800c75:	ff 75 0c             	pushl  0xc(%ebp)
  800c78:	6a 58                	push   $0x58
  800c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7d:	ff d0                	call   *%eax
  800c7f:	83 c4 10             	add    $0x10,%esp
			break;
  800c82:	e9 bc 00 00 00       	jmp    800d43 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c87:	83 ec 08             	sub    $0x8,%esp
  800c8a:	ff 75 0c             	pushl  0xc(%ebp)
  800c8d:	6a 30                	push   $0x30
  800c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c92:	ff d0                	call   *%eax
  800c94:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c97:	83 ec 08             	sub    $0x8,%esp
  800c9a:	ff 75 0c             	pushl  0xc(%ebp)
  800c9d:	6a 78                	push   $0x78
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	ff d0                	call   *%eax
  800ca4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ca7:	8b 45 14             	mov    0x14(%ebp),%eax
  800caa:	83 c0 04             	add    $0x4,%eax
  800cad:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb0:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb3:	83 e8 04             	sub    $0x4,%eax
  800cb6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800cb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cbb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800cc2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800cc9:	eb 1f                	jmp    800cea <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ccb:	83 ec 08             	sub    $0x8,%esp
  800cce:	ff 75 e8             	pushl  -0x18(%ebp)
  800cd1:	8d 45 14             	lea    0x14(%ebp),%eax
  800cd4:	50                   	push   %eax
  800cd5:	e8 e7 fb ff ff       	call   8008c1 <getuint>
  800cda:	83 c4 10             	add    $0x10,%esp
  800cdd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ce0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ce3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800cea:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800cee:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cf1:	83 ec 04             	sub    $0x4,%esp
  800cf4:	52                   	push   %edx
  800cf5:	ff 75 e4             	pushl  -0x1c(%ebp)
  800cf8:	50                   	push   %eax
  800cf9:	ff 75 f4             	pushl  -0xc(%ebp)
  800cfc:	ff 75 f0             	pushl  -0x10(%ebp)
  800cff:	ff 75 0c             	pushl  0xc(%ebp)
  800d02:	ff 75 08             	pushl  0x8(%ebp)
  800d05:	e8 00 fb ff ff       	call   80080a <printnum>
  800d0a:	83 c4 20             	add    $0x20,%esp
			break;
  800d0d:	eb 34                	jmp    800d43 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d0f:	83 ec 08             	sub    $0x8,%esp
  800d12:	ff 75 0c             	pushl  0xc(%ebp)
  800d15:	53                   	push   %ebx
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	ff d0                	call   *%eax
  800d1b:	83 c4 10             	add    $0x10,%esp
			break;
  800d1e:	eb 23                	jmp    800d43 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d20:	83 ec 08             	sub    $0x8,%esp
  800d23:	ff 75 0c             	pushl  0xc(%ebp)
  800d26:	6a 25                	push   $0x25
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	ff d0                	call   *%eax
  800d2d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d30:	ff 4d 10             	decl   0x10(%ebp)
  800d33:	eb 03                	jmp    800d38 <vprintfmt+0x3b1>
  800d35:	ff 4d 10             	decl   0x10(%ebp)
  800d38:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3b:	48                   	dec    %eax
  800d3c:	8a 00                	mov    (%eax),%al
  800d3e:	3c 25                	cmp    $0x25,%al
  800d40:	75 f3                	jne    800d35 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d42:	90                   	nop
		}
	}
  800d43:	e9 47 fc ff ff       	jmp    80098f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d48:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d49:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d4c:	5b                   	pop    %ebx
  800d4d:	5e                   	pop    %esi
  800d4e:	5d                   	pop    %ebp
  800d4f:	c3                   	ret    

00800d50 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d50:	55                   	push   %ebp
  800d51:	89 e5                	mov    %esp,%ebp
  800d53:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d56:	8d 45 10             	lea    0x10(%ebp),%eax
  800d59:	83 c0 04             	add    $0x4,%eax
  800d5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d62:	ff 75 f4             	pushl  -0xc(%ebp)
  800d65:	50                   	push   %eax
  800d66:	ff 75 0c             	pushl  0xc(%ebp)
  800d69:	ff 75 08             	pushl  0x8(%ebp)
  800d6c:	e8 16 fc ff ff       	call   800987 <vprintfmt>
  800d71:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d74:	90                   	nop
  800d75:	c9                   	leave  
  800d76:	c3                   	ret    

00800d77 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d77:	55                   	push   %ebp
  800d78:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7d:	8b 40 08             	mov    0x8(%eax),%eax
  800d80:	8d 50 01             	lea    0x1(%eax),%edx
  800d83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d86:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8c:	8b 10                	mov    (%eax),%edx
  800d8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d91:	8b 40 04             	mov    0x4(%eax),%eax
  800d94:	39 c2                	cmp    %eax,%edx
  800d96:	73 12                	jae    800daa <sprintputch+0x33>
		*b->buf++ = ch;
  800d98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9b:	8b 00                	mov    (%eax),%eax
  800d9d:	8d 48 01             	lea    0x1(%eax),%ecx
  800da0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800da3:	89 0a                	mov    %ecx,(%edx)
  800da5:	8b 55 08             	mov    0x8(%ebp),%edx
  800da8:	88 10                	mov    %dl,(%eax)
}
  800daa:	90                   	nop
  800dab:	5d                   	pop    %ebp
  800dac:	c3                   	ret    

00800dad <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800dad:	55                   	push   %ebp
  800dae:	89 e5                	mov    %esp,%ebp
  800db0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800db3:	8b 45 08             	mov    0x8(%ebp),%eax
  800db6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800db9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	01 d0                	add    %edx,%eax
  800dc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dc7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800dce:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dd2:	74 06                	je     800dda <vsnprintf+0x2d>
  800dd4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dd8:	7f 07                	jg     800de1 <vsnprintf+0x34>
		return -E_INVAL;
  800dda:	b8 03 00 00 00       	mov    $0x3,%eax
  800ddf:	eb 20                	jmp    800e01 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800de1:	ff 75 14             	pushl  0x14(%ebp)
  800de4:	ff 75 10             	pushl  0x10(%ebp)
  800de7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800dea:	50                   	push   %eax
  800deb:	68 77 0d 80 00       	push   $0x800d77
  800df0:	e8 92 fb ff ff       	call   800987 <vprintfmt>
  800df5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800df8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dfb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800dfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e01:	c9                   	leave  
  800e02:	c3                   	ret    

00800e03 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e03:	55                   	push   %ebp
  800e04:	89 e5                	mov    %esp,%ebp
  800e06:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e09:	8d 45 10             	lea    0x10(%ebp),%eax
  800e0c:	83 c0 04             	add    $0x4,%eax
  800e0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e12:	8b 45 10             	mov    0x10(%ebp),%eax
  800e15:	ff 75 f4             	pushl  -0xc(%ebp)
  800e18:	50                   	push   %eax
  800e19:	ff 75 0c             	pushl  0xc(%ebp)
  800e1c:	ff 75 08             	pushl  0x8(%ebp)
  800e1f:	e8 89 ff ff ff       	call   800dad <vsnprintf>
  800e24:	83 c4 10             	add    $0x10,%esp
  800e27:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e2d:	c9                   	leave  
  800e2e:	c3                   	ret    

00800e2f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e2f:	55                   	push   %ebp
  800e30:	89 e5                	mov    %esp,%ebp
  800e32:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e35:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e3c:	eb 06                	jmp    800e44 <strlen+0x15>
		n++;
  800e3e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e41:	ff 45 08             	incl   0x8(%ebp)
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	8a 00                	mov    (%eax),%al
  800e49:	84 c0                	test   %al,%al
  800e4b:	75 f1                	jne    800e3e <strlen+0xf>
		n++;
	return n;
  800e4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e50:	c9                   	leave  
  800e51:	c3                   	ret    

00800e52 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e52:	55                   	push   %ebp
  800e53:	89 e5                	mov    %esp,%ebp
  800e55:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e58:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e5f:	eb 09                	jmp    800e6a <strnlen+0x18>
		n++;
  800e61:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e64:	ff 45 08             	incl   0x8(%ebp)
  800e67:	ff 4d 0c             	decl   0xc(%ebp)
  800e6a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e6e:	74 09                	je     800e79 <strnlen+0x27>
  800e70:	8b 45 08             	mov    0x8(%ebp),%eax
  800e73:	8a 00                	mov    (%eax),%al
  800e75:	84 c0                	test   %al,%al
  800e77:	75 e8                	jne    800e61 <strnlen+0xf>
		n++;
	return n;
  800e79:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e7c:	c9                   	leave  
  800e7d:	c3                   	ret    

00800e7e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e7e:	55                   	push   %ebp
  800e7f:	89 e5                	mov    %esp,%ebp
  800e81:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e8a:	90                   	nop
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	8d 50 01             	lea    0x1(%eax),%edx
  800e91:	89 55 08             	mov    %edx,0x8(%ebp)
  800e94:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e97:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e9a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e9d:	8a 12                	mov    (%edx),%dl
  800e9f:	88 10                	mov    %dl,(%eax)
  800ea1:	8a 00                	mov    (%eax),%al
  800ea3:	84 c0                	test   %al,%al
  800ea5:	75 e4                	jne    800e8b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ea7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eaa:	c9                   	leave  
  800eab:	c3                   	ret    

00800eac <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800eac:	55                   	push   %ebp
  800ead:	89 e5                	mov    %esp,%ebp
  800eaf:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800eb8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ebf:	eb 1f                	jmp    800ee0 <strncpy+0x34>
		*dst++ = *src;
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	8d 50 01             	lea    0x1(%eax),%edx
  800ec7:	89 55 08             	mov    %edx,0x8(%ebp)
  800eca:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ecd:	8a 12                	mov    (%edx),%dl
  800ecf:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ed1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	84 c0                	test   %al,%al
  800ed8:	74 03                	je     800edd <strncpy+0x31>
			src++;
  800eda:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800edd:	ff 45 fc             	incl   -0x4(%ebp)
  800ee0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee3:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ee6:	72 d9                	jb     800ec1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ee8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800eeb:	c9                   	leave  
  800eec:	c3                   	ret    

00800eed <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800eed:	55                   	push   %ebp
  800eee:	89 e5                	mov    %esp,%ebp
  800ef0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ef9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800efd:	74 30                	je     800f2f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800eff:	eb 16                	jmp    800f17 <strlcpy+0x2a>
			*dst++ = *src++;
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	8d 50 01             	lea    0x1(%eax),%edx
  800f07:	89 55 08             	mov    %edx,0x8(%ebp)
  800f0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f0d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f10:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f13:	8a 12                	mov    (%edx),%dl
  800f15:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f17:	ff 4d 10             	decl   0x10(%ebp)
  800f1a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f1e:	74 09                	je     800f29 <strlcpy+0x3c>
  800f20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f23:	8a 00                	mov    (%eax),%al
  800f25:	84 c0                	test   %al,%al
  800f27:	75 d8                	jne    800f01 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f29:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f2f:	8b 55 08             	mov    0x8(%ebp),%edx
  800f32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f35:	29 c2                	sub    %eax,%edx
  800f37:	89 d0                	mov    %edx,%eax
}
  800f39:	c9                   	leave  
  800f3a:	c3                   	ret    

00800f3b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f3b:	55                   	push   %ebp
  800f3c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f3e:	eb 06                	jmp    800f46 <strcmp+0xb>
		p++, q++;
  800f40:	ff 45 08             	incl   0x8(%ebp)
  800f43:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	8a 00                	mov    (%eax),%al
  800f4b:	84 c0                	test   %al,%al
  800f4d:	74 0e                	je     800f5d <strcmp+0x22>
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	8a 10                	mov    (%eax),%dl
  800f54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f57:	8a 00                	mov    (%eax),%al
  800f59:	38 c2                	cmp    %al,%dl
  800f5b:	74 e3                	je     800f40 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	8a 00                	mov    (%eax),%al
  800f62:	0f b6 d0             	movzbl %al,%edx
  800f65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	0f b6 c0             	movzbl %al,%eax
  800f6d:	29 c2                	sub    %eax,%edx
  800f6f:	89 d0                	mov    %edx,%eax
}
  800f71:	5d                   	pop    %ebp
  800f72:	c3                   	ret    

00800f73 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f73:	55                   	push   %ebp
  800f74:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f76:	eb 09                	jmp    800f81 <strncmp+0xe>
		n--, p++, q++;
  800f78:	ff 4d 10             	decl   0x10(%ebp)
  800f7b:	ff 45 08             	incl   0x8(%ebp)
  800f7e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f81:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f85:	74 17                	je     800f9e <strncmp+0x2b>
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8a:	8a 00                	mov    (%eax),%al
  800f8c:	84 c0                	test   %al,%al
  800f8e:	74 0e                	je     800f9e <strncmp+0x2b>
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	8a 10                	mov    (%eax),%dl
  800f95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f98:	8a 00                	mov    (%eax),%al
  800f9a:	38 c2                	cmp    %al,%dl
  800f9c:	74 da                	je     800f78 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa2:	75 07                	jne    800fab <strncmp+0x38>
		return 0;
  800fa4:	b8 00 00 00 00       	mov    $0x0,%eax
  800fa9:	eb 14                	jmp    800fbf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	8a 00                	mov    (%eax),%al
  800fb0:	0f b6 d0             	movzbl %al,%edx
  800fb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	0f b6 c0             	movzbl %al,%eax
  800fbb:	29 c2                	sub    %eax,%edx
  800fbd:	89 d0                	mov    %edx,%eax
}
  800fbf:	5d                   	pop    %ebp
  800fc0:	c3                   	ret    

00800fc1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800fc1:	55                   	push   %ebp
  800fc2:	89 e5                	mov    %esp,%ebp
  800fc4:	83 ec 04             	sub    $0x4,%esp
  800fc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fca:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fcd:	eb 12                	jmp    800fe1 <strchr+0x20>
		if (*s == c)
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	8a 00                	mov    (%eax),%al
  800fd4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fd7:	75 05                	jne    800fde <strchr+0x1d>
			return (char *) s;
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdc:	eb 11                	jmp    800fef <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800fde:	ff 45 08             	incl   0x8(%ebp)
  800fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe4:	8a 00                	mov    (%eax),%al
  800fe6:	84 c0                	test   %al,%al
  800fe8:	75 e5                	jne    800fcf <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800fea:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fef:	c9                   	leave  
  800ff0:	c3                   	ret    

00800ff1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ff1:	55                   	push   %ebp
  800ff2:	89 e5                	mov    %esp,%ebp
  800ff4:	83 ec 04             	sub    $0x4,%esp
  800ff7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffa:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ffd:	eb 0d                	jmp    80100c <strfind+0x1b>
		if (*s == c)
  800fff:	8b 45 08             	mov    0x8(%ebp),%eax
  801002:	8a 00                	mov    (%eax),%al
  801004:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801007:	74 0e                	je     801017 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801009:	ff 45 08             	incl   0x8(%ebp)
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	8a 00                	mov    (%eax),%al
  801011:	84 c0                	test   %al,%al
  801013:	75 ea                	jne    800fff <strfind+0xe>
  801015:	eb 01                	jmp    801018 <strfind+0x27>
		if (*s == c)
			break;
  801017:	90                   	nop
	return (char *) s;
  801018:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80101b:	c9                   	leave  
  80101c:	c3                   	ret    

0080101d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80101d:	55                   	push   %ebp
  80101e:	89 e5                	mov    %esp,%ebp
  801020:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801023:	8b 45 08             	mov    0x8(%ebp),%eax
  801026:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801029:	8b 45 10             	mov    0x10(%ebp),%eax
  80102c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80102f:	eb 0e                	jmp    80103f <memset+0x22>
		*p++ = c;
  801031:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801034:	8d 50 01             	lea    0x1(%eax),%edx
  801037:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80103a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80103d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80103f:	ff 4d f8             	decl   -0x8(%ebp)
  801042:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801046:	79 e9                	jns    801031 <memset+0x14>
		*p++ = c;

	return v;
  801048:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80104b:	c9                   	leave  
  80104c:	c3                   	ret    

0080104d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80104d:	55                   	push   %ebp
  80104e:	89 e5                	mov    %esp,%ebp
  801050:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801053:	8b 45 0c             	mov    0xc(%ebp),%eax
  801056:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801059:	8b 45 08             	mov    0x8(%ebp),%eax
  80105c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80105f:	eb 16                	jmp    801077 <memcpy+0x2a>
		*d++ = *s++;
  801061:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801064:	8d 50 01             	lea    0x1(%eax),%edx
  801067:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80106a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80106d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801070:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801073:	8a 12                	mov    (%edx),%dl
  801075:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801077:	8b 45 10             	mov    0x10(%ebp),%eax
  80107a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80107d:	89 55 10             	mov    %edx,0x10(%ebp)
  801080:	85 c0                	test   %eax,%eax
  801082:	75 dd                	jne    801061 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801084:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801087:	c9                   	leave  
  801088:	c3                   	ret    

00801089 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801089:	55                   	push   %ebp
  80108a:	89 e5                	mov    %esp,%ebp
  80108c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80108f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801092:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
  801098:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80109b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80109e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010a1:	73 50                	jae    8010f3 <memmove+0x6a>
  8010a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a9:	01 d0                	add    %edx,%eax
  8010ab:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010ae:	76 43                	jbe    8010f3 <memmove+0x6a>
		s += n;
  8010b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010bc:	eb 10                	jmp    8010ce <memmove+0x45>
			*--d = *--s;
  8010be:	ff 4d f8             	decl   -0x8(%ebp)
  8010c1:	ff 4d fc             	decl   -0x4(%ebp)
  8010c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c7:	8a 10                	mov    (%eax),%dl
  8010c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010cc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8010d7:	85 c0                	test   %eax,%eax
  8010d9:	75 e3                	jne    8010be <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010db:	eb 23                	jmp    801100 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e0:	8d 50 01             	lea    0x1(%eax),%edx
  8010e3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010e9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010ec:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010ef:	8a 12                	mov    (%edx),%dl
  8010f1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010f9:	89 55 10             	mov    %edx,0x10(%ebp)
  8010fc:	85 c0                	test   %eax,%eax
  8010fe:	75 dd                	jne    8010dd <memmove+0x54>
			*d++ = *s++;

	return dst;
  801100:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801103:	c9                   	leave  
  801104:	c3                   	ret    

00801105 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801105:	55                   	push   %ebp
  801106:	89 e5                	mov    %esp,%ebp
  801108:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801111:	8b 45 0c             	mov    0xc(%ebp),%eax
  801114:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801117:	eb 2a                	jmp    801143 <memcmp+0x3e>
		if (*s1 != *s2)
  801119:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80111c:	8a 10                	mov    (%eax),%dl
  80111e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801121:	8a 00                	mov    (%eax),%al
  801123:	38 c2                	cmp    %al,%dl
  801125:	74 16                	je     80113d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801127:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112a:	8a 00                	mov    (%eax),%al
  80112c:	0f b6 d0             	movzbl %al,%edx
  80112f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801132:	8a 00                	mov    (%eax),%al
  801134:	0f b6 c0             	movzbl %al,%eax
  801137:	29 c2                	sub    %eax,%edx
  801139:	89 d0                	mov    %edx,%eax
  80113b:	eb 18                	jmp    801155 <memcmp+0x50>
		s1++, s2++;
  80113d:	ff 45 fc             	incl   -0x4(%ebp)
  801140:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801143:	8b 45 10             	mov    0x10(%ebp),%eax
  801146:	8d 50 ff             	lea    -0x1(%eax),%edx
  801149:	89 55 10             	mov    %edx,0x10(%ebp)
  80114c:	85 c0                	test   %eax,%eax
  80114e:	75 c9                	jne    801119 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801150:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801155:	c9                   	leave  
  801156:	c3                   	ret    

00801157 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801157:	55                   	push   %ebp
  801158:	89 e5                	mov    %esp,%ebp
  80115a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80115d:	8b 55 08             	mov    0x8(%ebp),%edx
  801160:	8b 45 10             	mov    0x10(%ebp),%eax
  801163:	01 d0                	add    %edx,%eax
  801165:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801168:	eb 15                	jmp    80117f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	0f b6 d0             	movzbl %al,%edx
  801172:	8b 45 0c             	mov    0xc(%ebp),%eax
  801175:	0f b6 c0             	movzbl %al,%eax
  801178:	39 c2                	cmp    %eax,%edx
  80117a:	74 0d                	je     801189 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80117c:	ff 45 08             	incl   0x8(%ebp)
  80117f:	8b 45 08             	mov    0x8(%ebp),%eax
  801182:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801185:	72 e3                	jb     80116a <memfind+0x13>
  801187:	eb 01                	jmp    80118a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801189:	90                   	nop
	return (void *) s;
  80118a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80118d:	c9                   	leave  
  80118e:	c3                   	ret    

0080118f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
  801192:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801195:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80119c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011a3:	eb 03                	jmp    8011a8 <strtol+0x19>
		s++;
  8011a5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ab:	8a 00                	mov    (%eax),%al
  8011ad:	3c 20                	cmp    $0x20,%al
  8011af:	74 f4                	je     8011a5 <strtol+0x16>
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	3c 09                	cmp    $0x9,%al
  8011b8:	74 eb                	je     8011a5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	8a 00                	mov    (%eax),%al
  8011bf:	3c 2b                	cmp    $0x2b,%al
  8011c1:	75 05                	jne    8011c8 <strtol+0x39>
		s++;
  8011c3:	ff 45 08             	incl   0x8(%ebp)
  8011c6:	eb 13                	jmp    8011db <strtol+0x4c>
	else if (*s == '-')
  8011c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cb:	8a 00                	mov    (%eax),%al
  8011cd:	3c 2d                	cmp    $0x2d,%al
  8011cf:	75 0a                	jne    8011db <strtol+0x4c>
		s++, neg = 1;
  8011d1:	ff 45 08             	incl   0x8(%ebp)
  8011d4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011df:	74 06                	je     8011e7 <strtol+0x58>
  8011e1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011e5:	75 20                	jne    801207 <strtol+0x78>
  8011e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ea:	8a 00                	mov    (%eax),%al
  8011ec:	3c 30                	cmp    $0x30,%al
  8011ee:	75 17                	jne    801207 <strtol+0x78>
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f3:	40                   	inc    %eax
  8011f4:	8a 00                	mov    (%eax),%al
  8011f6:	3c 78                	cmp    $0x78,%al
  8011f8:	75 0d                	jne    801207 <strtol+0x78>
		s += 2, base = 16;
  8011fa:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011fe:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801205:	eb 28                	jmp    80122f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801207:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80120b:	75 15                	jne    801222 <strtol+0x93>
  80120d:	8b 45 08             	mov    0x8(%ebp),%eax
  801210:	8a 00                	mov    (%eax),%al
  801212:	3c 30                	cmp    $0x30,%al
  801214:	75 0c                	jne    801222 <strtol+0x93>
		s++, base = 8;
  801216:	ff 45 08             	incl   0x8(%ebp)
  801219:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801220:	eb 0d                	jmp    80122f <strtol+0xa0>
	else if (base == 0)
  801222:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801226:	75 07                	jne    80122f <strtol+0xa0>
		base = 10;
  801228:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80122f:	8b 45 08             	mov    0x8(%ebp),%eax
  801232:	8a 00                	mov    (%eax),%al
  801234:	3c 2f                	cmp    $0x2f,%al
  801236:	7e 19                	jle    801251 <strtol+0xc2>
  801238:	8b 45 08             	mov    0x8(%ebp),%eax
  80123b:	8a 00                	mov    (%eax),%al
  80123d:	3c 39                	cmp    $0x39,%al
  80123f:	7f 10                	jg     801251 <strtol+0xc2>
			dig = *s - '0';
  801241:	8b 45 08             	mov    0x8(%ebp),%eax
  801244:	8a 00                	mov    (%eax),%al
  801246:	0f be c0             	movsbl %al,%eax
  801249:	83 e8 30             	sub    $0x30,%eax
  80124c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80124f:	eb 42                	jmp    801293 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801251:	8b 45 08             	mov    0x8(%ebp),%eax
  801254:	8a 00                	mov    (%eax),%al
  801256:	3c 60                	cmp    $0x60,%al
  801258:	7e 19                	jle    801273 <strtol+0xe4>
  80125a:	8b 45 08             	mov    0x8(%ebp),%eax
  80125d:	8a 00                	mov    (%eax),%al
  80125f:	3c 7a                	cmp    $0x7a,%al
  801261:	7f 10                	jg     801273 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	8a 00                	mov    (%eax),%al
  801268:	0f be c0             	movsbl %al,%eax
  80126b:	83 e8 57             	sub    $0x57,%eax
  80126e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801271:	eb 20                	jmp    801293 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801273:	8b 45 08             	mov    0x8(%ebp),%eax
  801276:	8a 00                	mov    (%eax),%al
  801278:	3c 40                	cmp    $0x40,%al
  80127a:	7e 39                	jle    8012b5 <strtol+0x126>
  80127c:	8b 45 08             	mov    0x8(%ebp),%eax
  80127f:	8a 00                	mov    (%eax),%al
  801281:	3c 5a                	cmp    $0x5a,%al
  801283:	7f 30                	jg     8012b5 <strtol+0x126>
			dig = *s - 'A' + 10;
  801285:	8b 45 08             	mov    0x8(%ebp),%eax
  801288:	8a 00                	mov    (%eax),%al
  80128a:	0f be c0             	movsbl %al,%eax
  80128d:	83 e8 37             	sub    $0x37,%eax
  801290:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801293:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801296:	3b 45 10             	cmp    0x10(%ebp),%eax
  801299:	7d 19                	jge    8012b4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80129b:	ff 45 08             	incl   0x8(%ebp)
  80129e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a1:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012a5:	89 c2                	mov    %eax,%edx
  8012a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012aa:	01 d0                	add    %edx,%eax
  8012ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012af:	e9 7b ff ff ff       	jmp    80122f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012b4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012b9:	74 08                	je     8012c3 <strtol+0x134>
		*endptr = (char *) s;
  8012bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012be:	8b 55 08             	mov    0x8(%ebp),%edx
  8012c1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012c3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012c7:	74 07                	je     8012d0 <strtol+0x141>
  8012c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012cc:	f7 d8                	neg    %eax
  8012ce:	eb 03                	jmp    8012d3 <strtol+0x144>
  8012d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012d3:	c9                   	leave  
  8012d4:	c3                   	ret    

008012d5 <ltostr>:

void
ltostr(long value, char *str)
{
  8012d5:	55                   	push   %ebp
  8012d6:	89 e5                	mov    %esp,%ebp
  8012d8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012e9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012ed:	79 13                	jns    801302 <ltostr+0x2d>
	{
		neg = 1;
  8012ef:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012fc:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012ff:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80130a:	99                   	cltd   
  80130b:	f7 f9                	idiv   %ecx
  80130d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801310:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801313:	8d 50 01             	lea    0x1(%eax),%edx
  801316:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801319:	89 c2                	mov    %eax,%edx
  80131b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131e:	01 d0                	add    %edx,%eax
  801320:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801323:	83 c2 30             	add    $0x30,%edx
  801326:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801328:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80132b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801330:	f7 e9                	imul   %ecx
  801332:	c1 fa 02             	sar    $0x2,%edx
  801335:	89 c8                	mov    %ecx,%eax
  801337:	c1 f8 1f             	sar    $0x1f,%eax
  80133a:	29 c2                	sub    %eax,%edx
  80133c:	89 d0                	mov    %edx,%eax
  80133e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801341:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801344:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801349:	f7 e9                	imul   %ecx
  80134b:	c1 fa 02             	sar    $0x2,%edx
  80134e:	89 c8                	mov    %ecx,%eax
  801350:	c1 f8 1f             	sar    $0x1f,%eax
  801353:	29 c2                	sub    %eax,%edx
  801355:	89 d0                	mov    %edx,%eax
  801357:	c1 e0 02             	shl    $0x2,%eax
  80135a:	01 d0                	add    %edx,%eax
  80135c:	01 c0                	add    %eax,%eax
  80135e:	29 c1                	sub    %eax,%ecx
  801360:	89 ca                	mov    %ecx,%edx
  801362:	85 d2                	test   %edx,%edx
  801364:	75 9c                	jne    801302 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801366:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80136d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801370:	48                   	dec    %eax
  801371:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801374:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801378:	74 3d                	je     8013b7 <ltostr+0xe2>
		start = 1 ;
  80137a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801381:	eb 34                	jmp    8013b7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801383:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801386:	8b 45 0c             	mov    0xc(%ebp),%eax
  801389:	01 d0                	add    %edx,%eax
  80138b:	8a 00                	mov    (%eax),%al
  80138d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801390:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801393:	8b 45 0c             	mov    0xc(%ebp),%eax
  801396:	01 c2                	add    %eax,%edx
  801398:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80139b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139e:	01 c8                	add    %ecx,%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013a4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013aa:	01 c2                	add    %eax,%edx
  8013ac:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013af:	88 02                	mov    %al,(%edx)
		start++ ;
  8013b1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013b4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ba:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013bd:	7c c4                	jl     801383 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013bf:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c5:	01 d0                	add    %edx,%eax
  8013c7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013ca:	90                   	nop
  8013cb:	c9                   	leave  
  8013cc:	c3                   	ret    

008013cd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013cd:	55                   	push   %ebp
  8013ce:	89 e5                	mov    %esp,%ebp
  8013d0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013d3:	ff 75 08             	pushl  0x8(%ebp)
  8013d6:	e8 54 fa ff ff       	call   800e2f <strlen>
  8013db:	83 c4 04             	add    $0x4,%esp
  8013de:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013e1:	ff 75 0c             	pushl  0xc(%ebp)
  8013e4:	e8 46 fa ff ff       	call   800e2f <strlen>
  8013e9:	83 c4 04             	add    $0x4,%esp
  8013ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013fd:	eb 17                	jmp    801416 <strcconcat+0x49>
		final[s] = str1[s] ;
  8013ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801402:	8b 45 10             	mov    0x10(%ebp),%eax
  801405:	01 c2                	add    %eax,%edx
  801407:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	01 c8                	add    %ecx,%eax
  80140f:	8a 00                	mov    (%eax),%al
  801411:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801413:	ff 45 fc             	incl   -0x4(%ebp)
  801416:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801419:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80141c:	7c e1                	jl     8013ff <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80141e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801425:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80142c:	eb 1f                	jmp    80144d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80142e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801431:	8d 50 01             	lea    0x1(%eax),%edx
  801434:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801437:	89 c2                	mov    %eax,%edx
  801439:	8b 45 10             	mov    0x10(%ebp),%eax
  80143c:	01 c2                	add    %eax,%edx
  80143e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801441:	8b 45 0c             	mov    0xc(%ebp),%eax
  801444:	01 c8                	add    %ecx,%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80144a:	ff 45 f8             	incl   -0x8(%ebp)
  80144d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801450:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801453:	7c d9                	jl     80142e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801455:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801458:	8b 45 10             	mov    0x10(%ebp),%eax
  80145b:	01 d0                	add    %edx,%eax
  80145d:	c6 00 00             	movb   $0x0,(%eax)
}
  801460:	90                   	nop
  801461:	c9                   	leave  
  801462:	c3                   	ret    

00801463 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801466:	8b 45 14             	mov    0x14(%ebp),%eax
  801469:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80146f:	8b 45 14             	mov    0x14(%ebp),%eax
  801472:	8b 00                	mov    (%eax),%eax
  801474:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80147b:	8b 45 10             	mov    0x10(%ebp),%eax
  80147e:	01 d0                	add    %edx,%eax
  801480:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801486:	eb 0c                	jmp    801494 <strsplit+0x31>
			*string++ = 0;
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	8d 50 01             	lea    0x1(%eax),%edx
  80148e:	89 55 08             	mov    %edx,0x8(%ebp)
  801491:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801494:	8b 45 08             	mov    0x8(%ebp),%eax
  801497:	8a 00                	mov    (%eax),%al
  801499:	84 c0                	test   %al,%al
  80149b:	74 18                	je     8014b5 <strsplit+0x52>
  80149d:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a0:	8a 00                	mov    (%eax),%al
  8014a2:	0f be c0             	movsbl %al,%eax
  8014a5:	50                   	push   %eax
  8014a6:	ff 75 0c             	pushl  0xc(%ebp)
  8014a9:	e8 13 fb ff ff       	call   800fc1 <strchr>
  8014ae:	83 c4 08             	add    $0x8,%esp
  8014b1:	85 c0                	test   %eax,%eax
  8014b3:	75 d3                	jne    801488 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8014b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b8:	8a 00                	mov    (%eax),%al
  8014ba:	84 c0                	test   %al,%al
  8014bc:	74 5a                	je     801518 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8014be:	8b 45 14             	mov    0x14(%ebp),%eax
  8014c1:	8b 00                	mov    (%eax),%eax
  8014c3:	83 f8 0f             	cmp    $0xf,%eax
  8014c6:	75 07                	jne    8014cf <strsplit+0x6c>
		{
			return 0;
  8014c8:	b8 00 00 00 00       	mov    $0x0,%eax
  8014cd:	eb 66                	jmp    801535 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d2:	8b 00                	mov    (%eax),%eax
  8014d4:	8d 48 01             	lea    0x1(%eax),%ecx
  8014d7:	8b 55 14             	mov    0x14(%ebp),%edx
  8014da:	89 0a                	mov    %ecx,(%edx)
  8014dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e6:	01 c2                	add    %eax,%edx
  8014e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014eb:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014ed:	eb 03                	jmp    8014f2 <strsplit+0x8f>
			string++;
  8014ef:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f5:	8a 00                	mov    (%eax),%al
  8014f7:	84 c0                	test   %al,%al
  8014f9:	74 8b                	je     801486 <strsplit+0x23>
  8014fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fe:	8a 00                	mov    (%eax),%al
  801500:	0f be c0             	movsbl %al,%eax
  801503:	50                   	push   %eax
  801504:	ff 75 0c             	pushl  0xc(%ebp)
  801507:	e8 b5 fa ff ff       	call   800fc1 <strchr>
  80150c:	83 c4 08             	add    $0x8,%esp
  80150f:	85 c0                	test   %eax,%eax
  801511:	74 dc                	je     8014ef <strsplit+0x8c>
			string++;
	}
  801513:	e9 6e ff ff ff       	jmp    801486 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801518:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801519:	8b 45 14             	mov    0x14(%ebp),%eax
  80151c:	8b 00                	mov    (%eax),%eax
  80151e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801525:	8b 45 10             	mov    0x10(%ebp),%eax
  801528:	01 d0                	add    %edx,%eax
  80152a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801530:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801535:	c9                   	leave  
  801536:	c3                   	ret    

00801537 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801537:	55                   	push   %ebp
  801538:	89 e5                	mov    %esp,%ebp
  80153a:	57                   	push   %edi
  80153b:	56                   	push   %esi
  80153c:	53                   	push   %ebx
  80153d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801540:	8b 45 08             	mov    0x8(%ebp),%eax
  801543:	8b 55 0c             	mov    0xc(%ebp),%edx
  801546:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801549:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80154c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80154f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801552:	cd 30                	int    $0x30
  801554:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801557:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80155a:	83 c4 10             	add    $0x10,%esp
  80155d:	5b                   	pop    %ebx
  80155e:	5e                   	pop    %esi
  80155f:	5f                   	pop    %edi
  801560:	5d                   	pop    %ebp
  801561:	c3                   	ret    

00801562 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801562:	55                   	push   %ebp
  801563:	89 e5                	mov    %esp,%ebp
  801565:	83 ec 04             	sub    $0x4,%esp
  801568:	8b 45 10             	mov    0x10(%ebp),%eax
  80156b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80156e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801572:	8b 45 08             	mov    0x8(%ebp),%eax
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	52                   	push   %edx
  80157a:	ff 75 0c             	pushl  0xc(%ebp)
  80157d:	50                   	push   %eax
  80157e:	6a 00                	push   $0x0
  801580:	e8 b2 ff ff ff       	call   801537 <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
}
  801588:	90                   	nop
  801589:	c9                   	leave  
  80158a:	c3                   	ret    

0080158b <sys_cgetc>:

int
sys_cgetc(void)
{
  80158b:	55                   	push   %ebp
  80158c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 01                	push   $0x1
  80159a:	e8 98 ff ff ff       	call   801537 <syscall>
  80159f:	83 c4 18             	add    $0x18,%esp
}
  8015a2:	c9                   	leave  
  8015a3:	c3                   	ret    

008015a4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8015a4:	55                   	push   %ebp
  8015a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	50                   	push   %eax
  8015b3:	6a 05                	push   $0x5
  8015b5:	e8 7d ff ff ff       	call   801537 <syscall>
  8015ba:	83 c4 18             	add    $0x18,%esp
}
  8015bd:	c9                   	leave  
  8015be:	c3                   	ret    

008015bf <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015bf:	55                   	push   %ebp
  8015c0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 02                	push   $0x2
  8015ce:	e8 64 ff ff ff       	call   801537 <syscall>
  8015d3:	83 c4 18             	add    $0x18,%esp
}
  8015d6:	c9                   	leave  
  8015d7:	c3                   	ret    

008015d8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015d8:	55                   	push   %ebp
  8015d9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 03                	push   $0x3
  8015e7:	e8 4b ff ff ff       	call   801537 <syscall>
  8015ec:	83 c4 18             	add    $0x18,%esp
}
  8015ef:	c9                   	leave  
  8015f0:	c3                   	ret    

008015f1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015f1:	55                   	push   %ebp
  8015f2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 04                	push   $0x4
  801600:	e8 32 ff ff ff       	call   801537 <syscall>
  801605:	83 c4 18             	add    $0x18,%esp
}
  801608:	c9                   	leave  
  801609:	c3                   	ret    

0080160a <sys_env_exit>:


void sys_env_exit(void)
{
  80160a:	55                   	push   %ebp
  80160b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 06                	push   $0x6
  801619:	e8 19 ff ff ff       	call   801537 <syscall>
  80161e:	83 c4 18             	add    $0x18,%esp
}
  801621:	90                   	nop
  801622:	c9                   	leave  
  801623:	c3                   	ret    

00801624 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801627:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	52                   	push   %edx
  801634:	50                   	push   %eax
  801635:	6a 07                	push   $0x7
  801637:	e8 fb fe ff ff       	call   801537 <syscall>
  80163c:	83 c4 18             	add    $0x18,%esp
}
  80163f:	c9                   	leave  
  801640:	c3                   	ret    

00801641 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
  801644:	56                   	push   %esi
  801645:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801646:	8b 75 18             	mov    0x18(%ebp),%esi
  801649:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80164c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80164f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801652:	8b 45 08             	mov    0x8(%ebp),%eax
  801655:	56                   	push   %esi
  801656:	53                   	push   %ebx
  801657:	51                   	push   %ecx
  801658:	52                   	push   %edx
  801659:	50                   	push   %eax
  80165a:	6a 08                	push   $0x8
  80165c:	e8 d6 fe ff ff       	call   801537 <syscall>
  801661:	83 c4 18             	add    $0x18,%esp
}
  801664:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801667:	5b                   	pop    %ebx
  801668:	5e                   	pop    %esi
  801669:	5d                   	pop    %ebp
  80166a:	c3                   	ret    

0080166b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80166b:	55                   	push   %ebp
  80166c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80166e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	52                   	push   %edx
  80167b:	50                   	push   %eax
  80167c:	6a 09                	push   $0x9
  80167e:	e8 b4 fe ff ff       	call   801537 <syscall>
  801683:	83 c4 18             	add    $0x18,%esp
}
  801686:	c9                   	leave  
  801687:	c3                   	ret    

00801688 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801688:	55                   	push   %ebp
  801689:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	ff 75 0c             	pushl  0xc(%ebp)
  801694:	ff 75 08             	pushl  0x8(%ebp)
  801697:	6a 0a                	push   $0xa
  801699:	e8 99 fe ff ff       	call   801537 <syscall>
  80169e:	83 c4 18             	add    $0x18,%esp
}
  8016a1:	c9                   	leave  
  8016a2:	c3                   	ret    

008016a3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 0b                	push   $0xb
  8016b2:	e8 80 fe ff ff       	call   801537 <syscall>
  8016b7:	83 c4 18             	add    $0x18,%esp
}
  8016ba:	c9                   	leave  
  8016bb:	c3                   	ret    

008016bc <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 0c                	push   $0xc
  8016cb:	e8 67 fe ff ff       	call   801537 <syscall>
  8016d0:	83 c4 18             	add    $0x18,%esp
}
  8016d3:	c9                   	leave  
  8016d4:	c3                   	ret    

008016d5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 0d                	push   $0xd
  8016e4:	e8 4e fe ff ff       	call   801537 <syscall>
  8016e9:	83 c4 18             	add    $0x18,%esp
}
  8016ec:	c9                   	leave  
  8016ed:	c3                   	ret    

008016ee <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016ee:	55                   	push   %ebp
  8016ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	ff 75 0c             	pushl  0xc(%ebp)
  8016fa:	ff 75 08             	pushl  0x8(%ebp)
  8016fd:	6a 11                	push   $0x11
  8016ff:	e8 33 fe ff ff       	call   801537 <syscall>
  801704:	83 c4 18             	add    $0x18,%esp
	return;
  801707:	90                   	nop
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	ff 75 0c             	pushl  0xc(%ebp)
  801716:	ff 75 08             	pushl  0x8(%ebp)
  801719:	6a 12                	push   $0x12
  80171b:	e8 17 fe ff ff       	call   801537 <syscall>
  801720:	83 c4 18             	add    $0x18,%esp
	return ;
  801723:	90                   	nop
}
  801724:	c9                   	leave  
  801725:	c3                   	ret    

00801726 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801726:	55                   	push   %ebp
  801727:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 0e                	push   $0xe
  801735:	e8 fd fd ff ff       	call   801537 <syscall>
  80173a:	83 c4 18             	add    $0x18,%esp
}
  80173d:	c9                   	leave  
  80173e:	c3                   	ret    

0080173f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80173f:	55                   	push   %ebp
  801740:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	ff 75 08             	pushl  0x8(%ebp)
  80174d:	6a 0f                	push   $0xf
  80174f:	e8 e3 fd ff ff       	call   801537 <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
}
  801757:	c9                   	leave  
  801758:	c3                   	ret    

00801759 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801759:	55                   	push   %ebp
  80175a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 10                	push   $0x10
  801768:	e8 ca fd ff ff       	call   801537 <syscall>
  80176d:	83 c4 18             	add    $0x18,%esp
}
  801770:	90                   	nop
  801771:	c9                   	leave  
  801772:	c3                   	ret    

00801773 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 14                	push   $0x14
  801782:	e8 b0 fd ff ff       	call   801537 <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
}
  80178a:	90                   	nop
  80178b:	c9                   	leave  
  80178c:	c3                   	ret    

0080178d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 15                	push   $0x15
  80179c:	e8 96 fd ff ff       	call   801537 <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
}
  8017a4:	90                   	nop
  8017a5:	c9                   	leave  
  8017a6:	c3                   	ret    

008017a7 <sys_cputc>:


void
sys_cputc(const char c)
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
  8017aa:	83 ec 04             	sub    $0x4,%esp
  8017ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017b3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	50                   	push   %eax
  8017c0:	6a 16                	push   $0x16
  8017c2:	e8 70 fd ff ff       	call   801537 <syscall>
  8017c7:	83 c4 18             	add    $0x18,%esp
}
  8017ca:	90                   	nop
  8017cb:	c9                   	leave  
  8017cc:	c3                   	ret    

008017cd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017cd:	55                   	push   %ebp
  8017ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 17                	push   $0x17
  8017dc:	e8 56 fd ff ff       	call   801537 <syscall>
  8017e1:	83 c4 18             	add    $0x18,%esp
}
  8017e4:	90                   	nop
  8017e5:	c9                   	leave  
  8017e6:	c3                   	ret    

008017e7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017e7:	55                   	push   %ebp
  8017e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	ff 75 0c             	pushl  0xc(%ebp)
  8017f6:	50                   	push   %eax
  8017f7:	6a 18                	push   $0x18
  8017f9:	e8 39 fd ff ff       	call   801537 <syscall>
  8017fe:	83 c4 18             	add    $0x18,%esp
}
  801801:	c9                   	leave  
  801802:	c3                   	ret    

00801803 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801803:	55                   	push   %ebp
  801804:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801806:	8b 55 0c             	mov    0xc(%ebp),%edx
  801809:	8b 45 08             	mov    0x8(%ebp),%eax
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	52                   	push   %edx
  801813:	50                   	push   %eax
  801814:	6a 1b                	push   $0x1b
  801816:	e8 1c fd ff ff       	call   801537 <syscall>
  80181b:	83 c4 18             	add    $0x18,%esp
}
  80181e:	c9                   	leave  
  80181f:	c3                   	ret    

00801820 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801820:	55                   	push   %ebp
  801821:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801823:	8b 55 0c             	mov    0xc(%ebp),%edx
  801826:	8b 45 08             	mov    0x8(%ebp),%eax
  801829:	6a 00                	push   $0x0
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	52                   	push   %edx
  801830:	50                   	push   %eax
  801831:	6a 19                	push   $0x19
  801833:	e8 ff fc ff ff       	call   801537 <syscall>
  801838:	83 c4 18             	add    $0x18,%esp
}
  80183b:	90                   	nop
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801841:	8b 55 0c             	mov    0xc(%ebp),%edx
  801844:	8b 45 08             	mov    0x8(%ebp),%eax
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	52                   	push   %edx
  80184e:	50                   	push   %eax
  80184f:	6a 1a                	push   $0x1a
  801851:	e8 e1 fc ff ff       	call   801537 <syscall>
  801856:	83 c4 18             	add    $0x18,%esp
}
  801859:	90                   	nop
  80185a:	c9                   	leave  
  80185b:	c3                   	ret    

0080185c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80185c:	55                   	push   %ebp
  80185d:	89 e5                	mov    %esp,%ebp
  80185f:	83 ec 04             	sub    $0x4,%esp
  801862:	8b 45 10             	mov    0x10(%ebp),%eax
  801865:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801868:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80186b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80186f:	8b 45 08             	mov    0x8(%ebp),%eax
  801872:	6a 00                	push   $0x0
  801874:	51                   	push   %ecx
  801875:	52                   	push   %edx
  801876:	ff 75 0c             	pushl  0xc(%ebp)
  801879:	50                   	push   %eax
  80187a:	6a 1c                	push   $0x1c
  80187c:	e8 b6 fc ff ff       	call   801537 <syscall>
  801881:	83 c4 18             	add    $0x18,%esp
}
  801884:	c9                   	leave  
  801885:	c3                   	ret    

00801886 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801886:	55                   	push   %ebp
  801887:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801889:	8b 55 0c             	mov    0xc(%ebp),%edx
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	52                   	push   %edx
  801896:	50                   	push   %eax
  801897:	6a 1d                	push   $0x1d
  801899:	e8 99 fc ff ff       	call   801537 <syscall>
  80189e:	83 c4 18             	add    $0x18,%esp
}
  8018a1:	c9                   	leave  
  8018a2:	c3                   	ret    

008018a3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8018a3:	55                   	push   %ebp
  8018a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8018a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	51                   	push   %ecx
  8018b4:	52                   	push   %edx
  8018b5:	50                   	push   %eax
  8018b6:	6a 1e                	push   $0x1e
  8018b8:	e8 7a fc ff ff       	call   801537 <syscall>
  8018bd:	83 c4 18             	add    $0x18,%esp
}
  8018c0:	c9                   	leave  
  8018c1:	c3                   	ret    

008018c2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8018c2:	55                   	push   %ebp
  8018c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8018c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	52                   	push   %edx
  8018d2:	50                   	push   %eax
  8018d3:	6a 1f                	push   $0x1f
  8018d5:	e8 5d fc ff ff       	call   801537 <syscall>
  8018da:	83 c4 18             	add    $0x18,%esp
}
  8018dd:	c9                   	leave  
  8018de:	c3                   	ret    

008018df <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 20                	push   $0x20
  8018ee:	e8 44 fc ff ff       	call   801537 <syscall>
  8018f3:	83 c4 18             	add    $0x18,%esp
}
  8018f6:	c9                   	leave  
  8018f7:	c3                   	ret    

008018f8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8018f8:	55                   	push   %ebp
  8018f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	6a 00                	push   $0x0
  801900:	ff 75 14             	pushl  0x14(%ebp)
  801903:	ff 75 10             	pushl  0x10(%ebp)
  801906:	ff 75 0c             	pushl  0xc(%ebp)
  801909:	50                   	push   %eax
  80190a:	6a 21                	push   $0x21
  80190c:	e8 26 fc ff ff       	call   801537 <syscall>
  801911:	83 c4 18             	add    $0x18,%esp
}
  801914:	c9                   	leave  
  801915:	c3                   	ret    

00801916 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801916:	55                   	push   %ebp
  801917:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801919:	8b 45 08             	mov    0x8(%ebp),%eax
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	50                   	push   %eax
  801925:	6a 22                	push   $0x22
  801927:	e8 0b fc ff ff       	call   801537 <syscall>
  80192c:	83 c4 18             	add    $0x18,%esp
}
  80192f:	90                   	nop
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801935:	8b 45 08             	mov    0x8(%ebp),%eax
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	50                   	push   %eax
  801941:	6a 23                	push   $0x23
  801943:	e8 ef fb ff ff       	call   801537 <syscall>
  801948:	83 c4 18             	add    $0x18,%esp
}
  80194b:	90                   	nop
  80194c:	c9                   	leave  
  80194d:	c3                   	ret    

0080194e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80194e:	55                   	push   %ebp
  80194f:	89 e5                	mov    %esp,%ebp
  801951:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801954:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801957:	8d 50 04             	lea    0x4(%eax),%edx
  80195a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	52                   	push   %edx
  801964:	50                   	push   %eax
  801965:	6a 24                	push   $0x24
  801967:	e8 cb fb ff ff       	call   801537 <syscall>
  80196c:	83 c4 18             	add    $0x18,%esp
	return result;
  80196f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801972:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801975:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801978:	89 01                	mov    %eax,(%ecx)
  80197a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80197d:	8b 45 08             	mov    0x8(%ebp),%eax
  801980:	c9                   	leave  
  801981:	c2 04 00             	ret    $0x4

00801984 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801984:	55                   	push   %ebp
  801985:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	ff 75 10             	pushl  0x10(%ebp)
  80198e:	ff 75 0c             	pushl  0xc(%ebp)
  801991:	ff 75 08             	pushl  0x8(%ebp)
  801994:	6a 13                	push   $0x13
  801996:	e8 9c fb ff ff       	call   801537 <syscall>
  80199b:	83 c4 18             	add    $0x18,%esp
	return ;
  80199e:	90                   	nop
}
  80199f:	c9                   	leave  
  8019a0:	c3                   	ret    

008019a1 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019a1:	55                   	push   %ebp
  8019a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 25                	push   $0x25
  8019b0:	e8 82 fb ff ff       	call   801537 <syscall>
  8019b5:	83 c4 18             	add    $0x18,%esp
}
  8019b8:	c9                   	leave  
  8019b9:	c3                   	ret    

008019ba <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8019ba:	55                   	push   %ebp
  8019bb:	89 e5                	mov    %esp,%ebp
  8019bd:	83 ec 04             	sub    $0x4,%esp
  8019c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019c6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	50                   	push   %eax
  8019d3:	6a 26                	push   $0x26
  8019d5:	e8 5d fb ff ff       	call   801537 <syscall>
  8019da:	83 c4 18             	add    $0x18,%esp
	return ;
  8019dd:	90                   	nop
}
  8019de:	c9                   	leave  
  8019df:	c3                   	ret    

008019e0 <rsttst>:
void rsttst()
{
  8019e0:	55                   	push   %ebp
  8019e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 28                	push   $0x28
  8019ef:	e8 43 fb ff ff       	call   801537 <syscall>
  8019f4:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f7:	90                   	nop
}
  8019f8:	c9                   	leave  
  8019f9:	c3                   	ret    

008019fa <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019fa:	55                   	push   %ebp
  8019fb:	89 e5                	mov    %esp,%ebp
  8019fd:	83 ec 04             	sub    $0x4,%esp
  801a00:	8b 45 14             	mov    0x14(%ebp),%eax
  801a03:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a06:	8b 55 18             	mov    0x18(%ebp),%edx
  801a09:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a0d:	52                   	push   %edx
  801a0e:	50                   	push   %eax
  801a0f:	ff 75 10             	pushl  0x10(%ebp)
  801a12:	ff 75 0c             	pushl  0xc(%ebp)
  801a15:	ff 75 08             	pushl  0x8(%ebp)
  801a18:	6a 27                	push   $0x27
  801a1a:	e8 18 fb ff ff       	call   801537 <syscall>
  801a1f:	83 c4 18             	add    $0x18,%esp
	return ;
  801a22:	90                   	nop
}
  801a23:	c9                   	leave  
  801a24:	c3                   	ret    

00801a25 <chktst>:
void chktst(uint32 n)
{
  801a25:	55                   	push   %ebp
  801a26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	ff 75 08             	pushl  0x8(%ebp)
  801a33:	6a 29                	push   $0x29
  801a35:	e8 fd fa ff ff       	call   801537 <syscall>
  801a3a:	83 c4 18             	add    $0x18,%esp
	return ;
  801a3d:	90                   	nop
}
  801a3e:	c9                   	leave  
  801a3f:	c3                   	ret    

00801a40 <inctst>:

void inctst()
{
  801a40:	55                   	push   %ebp
  801a41:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 2a                	push   $0x2a
  801a4f:	e8 e3 fa ff ff       	call   801537 <syscall>
  801a54:	83 c4 18             	add    $0x18,%esp
	return ;
  801a57:	90                   	nop
}
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <gettst>:
uint32 gettst()
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 2b                	push   $0x2b
  801a69:	e8 c9 fa ff ff       	call   801537 <syscall>
  801a6e:	83 c4 18             	add    $0x18,%esp
}
  801a71:	c9                   	leave  
  801a72:	c3                   	ret    

00801a73 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a73:	55                   	push   %ebp
  801a74:	89 e5                	mov    %esp,%ebp
  801a76:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	6a 2c                	push   $0x2c
  801a85:	e8 ad fa ff ff       	call   801537 <syscall>
  801a8a:	83 c4 18             	add    $0x18,%esp
  801a8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a90:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a94:	75 07                	jne    801a9d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a96:	b8 01 00 00 00       	mov    $0x1,%eax
  801a9b:	eb 05                	jmp    801aa2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aa2:	c9                   	leave  
  801aa3:	c3                   	ret    

00801aa4 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801aa4:	55                   	push   %ebp
  801aa5:	89 e5                	mov    %esp,%ebp
  801aa7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 2c                	push   $0x2c
  801ab6:	e8 7c fa ff ff       	call   801537 <syscall>
  801abb:	83 c4 18             	add    $0x18,%esp
  801abe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ac1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ac5:	75 07                	jne    801ace <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ac7:	b8 01 00 00 00       	mov    $0x1,%eax
  801acc:	eb 05                	jmp    801ad3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ace:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ad3:	c9                   	leave  
  801ad4:	c3                   	ret    

00801ad5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ad5:	55                   	push   %ebp
  801ad6:	89 e5                	mov    %esp,%ebp
  801ad8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 2c                	push   $0x2c
  801ae7:	e8 4b fa ff ff       	call   801537 <syscall>
  801aec:	83 c4 18             	add    $0x18,%esp
  801aef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801af2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801af6:	75 07                	jne    801aff <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801af8:	b8 01 00 00 00       	mov    $0x1,%eax
  801afd:	eb 05                	jmp    801b04 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801aff:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b04:	c9                   	leave  
  801b05:	c3                   	ret    

00801b06 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b06:	55                   	push   %ebp
  801b07:	89 e5                	mov    %esp,%ebp
  801b09:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 2c                	push   $0x2c
  801b18:	e8 1a fa ff ff       	call   801537 <syscall>
  801b1d:	83 c4 18             	add    $0x18,%esp
  801b20:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b23:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b27:	75 07                	jne    801b30 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b29:	b8 01 00 00 00       	mov    $0x1,%eax
  801b2e:	eb 05                	jmp    801b35 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b30:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b35:	c9                   	leave  
  801b36:	c3                   	ret    

00801b37 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b37:	55                   	push   %ebp
  801b38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	ff 75 08             	pushl  0x8(%ebp)
  801b45:	6a 2d                	push   $0x2d
  801b47:	e8 eb f9 ff ff       	call   801537 <syscall>
  801b4c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b4f:	90                   	nop
}
  801b50:	c9                   	leave  
  801b51:	c3                   	ret    

00801b52 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b52:	55                   	push   %ebp
  801b53:	89 e5                	mov    %esp,%ebp
  801b55:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b56:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b59:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b62:	6a 00                	push   $0x0
  801b64:	53                   	push   %ebx
  801b65:	51                   	push   %ecx
  801b66:	52                   	push   %edx
  801b67:	50                   	push   %eax
  801b68:	6a 2e                	push   $0x2e
  801b6a:	e8 c8 f9 ff ff       	call   801537 <syscall>
  801b6f:	83 c4 18             	add    $0x18,%esp
}
  801b72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b75:	c9                   	leave  
  801b76:	c3                   	ret    

00801b77 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b77:	55                   	push   %ebp
  801b78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	52                   	push   %edx
  801b87:	50                   	push   %eax
  801b88:	6a 2f                	push   $0x2f
  801b8a:	e8 a8 f9 ff ff       	call   801537 <syscall>
  801b8f:	83 c4 18             	add    $0x18,%esp
}
  801b92:	c9                   	leave  
  801b93:	c3                   	ret    

00801b94 <__udivdi3>:
  801b94:	55                   	push   %ebp
  801b95:	57                   	push   %edi
  801b96:	56                   	push   %esi
  801b97:	53                   	push   %ebx
  801b98:	83 ec 1c             	sub    $0x1c,%esp
  801b9b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b9f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ba3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ba7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801bab:	89 ca                	mov    %ecx,%edx
  801bad:	89 f8                	mov    %edi,%eax
  801baf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801bb3:	85 f6                	test   %esi,%esi
  801bb5:	75 2d                	jne    801be4 <__udivdi3+0x50>
  801bb7:	39 cf                	cmp    %ecx,%edi
  801bb9:	77 65                	ja     801c20 <__udivdi3+0x8c>
  801bbb:	89 fd                	mov    %edi,%ebp
  801bbd:	85 ff                	test   %edi,%edi
  801bbf:	75 0b                	jne    801bcc <__udivdi3+0x38>
  801bc1:	b8 01 00 00 00       	mov    $0x1,%eax
  801bc6:	31 d2                	xor    %edx,%edx
  801bc8:	f7 f7                	div    %edi
  801bca:	89 c5                	mov    %eax,%ebp
  801bcc:	31 d2                	xor    %edx,%edx
  801bce:	89 c8                	mov    %ecx,%eax
  801bd0:	f7 f5                	div    %ebp
  801bd2:	89 c1                	mov    %eax,%ecx
  801bd4:	89 d8                	mov    %ebx,%eax
  801bd6:	f7 f5                	div    %ebp
  801bd8:	89 cf                	mov    %ecx,%edi
  801bda:	89 fa                	mov    %edi,%edx
  801bdc:	83 c4 1c             	add    $0x1c,%esp
  801bdf:	5b                   	pop    %ebx
  801be0:	5e                   	pop    %esi
  801be1:	5f                   	pop    %edi
  801be2:	5d                   	pop    %ebp
  801be3:	c3                   	ret    
  801be4:	39 ce                	cmp    %ecx,%esi
  801be6:	77 28                	ja     801c10 <__udivdi3+0x7c>
  801be8:	0f bd fe             	bsr    %esi,%edi
  801beb:	83 f7 1f             	xor    $0x1f,%edi
  801bee:	75 40                	jne    801c30 <__udivdi3+0x9c>
  801bf0:	39 ce                	cmp    %ecx,%esi
  801bf2:	72 0a                	jb     801bfe <__udivdi3+0x6a>
  801bf4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801bf8:	0f 87 9e 00 00 00    	ja     801c9c <__udivdi3+0x108>
  801bfe:	b8 01 00 00 00       	mov    $0x1,%eax
  801c03:	89 fa                	mov    %edi,%edx
  801c05:	83 c4 1c             	add    $0x1c,%esp
  801c08:	5b                   	pop    %ebx
  801c09:	5e                   	pop    %esi
  801c0a:	5f                   	pop    %edi
  801c0b:	5d                   	pop    %ebp
  801c0c:	c3                   	ret    
  801c0d:	8d 76 00             	lea    0x0(%esi),%esi
  801c10:	31 ff                	xor    %edi,%edi
  801c12:	31 c0                	xor    %eax,%eax
  801c14:	89 fa                	mov    %edi,%edx
  801c16:	83 c4 1c             	add    $0x1c,%esp
  801c19:	5b                   	pop    %ebx
  801c1a:	5e                   	pop    %esi
  801c1b:	5f                   	pop    %edi
  801c1c:	5d                   	pop    %ebp
  801c1d:	c3                   	ret    
  801c1e:	66 90                	xchg   %ax,%ax
  801c20:	89 d8                	mov    %ebx,%eax
  801c22:	f7 f7                	div    %edi
  801c24:	31 ff                	xor    %edi,%edi
  801c26:	89 fa                	mov    %edi,%edx
  801c28:	83 c4 1c             	add    $0x1c,%esp
  801c2b:	5b                   	pop    %ebx
  801c2c:	5e                   	pop    %esi
  801c2d:	5f                   	pop    %edi
  801c2e:	5d                   	pop    %ebp
  801c2f:	c3                   	ret    
  801c30:	bd 20 00 00 00       	mov    $0x20,%ebp
  801c35:	89 eb                	mov    %ebp,%ebx
  801c37:	29 fb                	sub    %edi,%ebx
  801c39:	89 f9                	mov    %edi,%ecx
  801c3b:	d3 e6                	shl    %cl,%esi
  801c3d:	89 c5                	mov    %eax,%ebp
  801c3f:	88 d9                	mov    %bl,%cl
  801c41:	d3 ed                	shr    %cl,%ebp
  801c43:	89 e9                	mov    %ebp,%ecx
  801c45:	09 f1                	or     %esi,%ecx
  801c47:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801c4b:	89 f9                	mov    %edi,%ecx
  801c4d:	d3 e0                	shl    %cl,%eax
  801c4f:	89 c5                	mov    %eax,%ebp
  801c51:	89 d6                	mov    %edx,%esi
  801c53:	88 d9                	mov    %bl,%cl
  801c55:	d3 ee                	shr    %cl,%esi
  801c57:	89 f9                	mov    %edi,%ecx
  801c59:	d3 e2                	shl    %cl,%edx
  801c5b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c5f:	88 d9                	mov    %bl,%cl
  801c61:	d3 e8                	shr    %cl,%eax
  801c63:	09 c2                	or     %eax,%edx
  801c65:	89 d0                	mov    %edx,%eax
  801c67:	89 f2                	mov    %esi,%edx
  801c69:	f7 74 24 0c          	divl   0xc(%esp)
  801c6d:	89 d6                	mov    %edx,%esi
  801c6f:	89 c3                	mov    %eax,%ebx
  801c71:	f7 e5                	mul    %ebp
  801c73:	39 d6                	cmp    %edx,%esi
  801c75:	72 19                	jb     801c90 <__udivdi3+0xfc>
  801c77:	74 0b                	je     801c84 <__udivdi3+0xf0>
  801c79:	89 d8                	mov    %ebx,%eax
  801c7b:	31 ff                	xor    %edi,%edi
  801c7d:	e9 58 ff ff ff       	jmp    801bda <__udivdi3+0x46>
  801c82:	66 90                	xchg   %ax,%ax
  801c84:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c88:	89 f9                	mov    %edi,%ecx
  801c8a:	d3 e2                	shl    %cl,%edx
  801c8c:	39 c2                	cmp    %eax,%edx
  801c8e:	73 e9                	jae    801c79 <__udivdi3+0xe5>
  801c90:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c93:	31 ff                	xor    %edi,%edi
  801c95:	e9 40 ff ff ff       	jmp    801bda <__udivdi3+0x46>
  801c9a:	66 90                	xchg   %ax,%ax
  801c9c:	31 c0                	xor    %eax,%eax
  801c9e:	e9 37 ff ff ff       	jmp    801bda <__udivdi3+0x46>
  801ca3:	90                   	nop

00801ca4 <__umoddi3>:
  801ca4:	55                   	push   %ebp
  801ca5:	57                   	push   %edi
  801ca6:	56                   	push   %esi
  801ca7:	53                   	push   %ebx
  801ca8:	83 ec 1c             	sub    $0x1c,%esp
  801cab:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801caf:	8b 74 24 34          	mov    0x34(%esp),%esi
  801cb3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cb7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801cbb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801cbf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801cc3:	89 f3                	mov    %esi,%ebx
  801cc5:	89 fa                	mov    %edi,%edx
  801cc7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ccb:	89 34 24             	mov    %esi,(%esp)
  801cce:	85 c0                	test   %eax,%eax
  801cd0:	75 1a                	jne    801cec <__umoddi3+0x48>
  801cd2:	39 f7                	cmp    %esi,%edi
  801cd4:	0f 86 a2 00 00 00    	jbe    801d7c <__umoddi3+0xd8>
  801cda:	89 c8                	mov    %ecx,%eax
  801cdc:	89 f2                	mov    %esi,%edx
  801cde:	f7 f7                	div    %edi
  801ce0:	89 d0                	mov    %edx,%eax
  801ce2:	31 d2                	xor    %edx,%edx
  801ce4:	83 c4 1c             	add    $0x1c,%esp
  801ce7:	5b                   	pop    %ebx
  801ce8:	5e                   	pop    %esi
  801ce9:	5f                   	pop    %edi
  801cea:	5d                   	pop    %ebp
  801ceb:	c3                   	ret    
  801cec:	39 f0                	cmp    %esi,%eax
  801cee:	0f 87 ac 00 00 00    	ja     801da0 <__umoddi3+0xfc>
  801cf4:	0f bd e8             	bsr    %eax,%ebp
  801cf7:	83 f5 1f             	xor    $0x1f,%ebp
  801cfa:	0f 84 ac 00 00 00    	je     801dac <__umoddi3+0x108>
  801d00:	bf 20 00 00 00       	mov    $0x20,%edi
  801d05:	29 ef                	sub    %ebp,%edi
  801d07:	89 fe                	mov    %edi,%esi
  801d09:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d0d:	89 e9                	mov    %ebp,%ecx
  801d0f:	d3 e0                	shl    %cl,%eax
  801d11:	89 d7                	mov    %edx,%edi
  801d13:	89 f1                	mov    %esi,%ecx
  801d15:	d3 ef                	shr    %cl,%edi
  801d17:	09 c7                	or     %eax,%edi
  801d19:	89 e9                	mov    %ebp,%ecx
  801d1b:	d3 e2                	shl    %cl,%edx
  801d1d:	89 14 24             	mov    %edx,(%esp)
  801d20:	89 d8                	mov    %ebx,%eax
  801d22:	d3 e0                	shl    %cl,%eax
  801d24:	89 c2                	mov    %eax,%edx
  801d26:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d2a:	d3 e0                	shl    %cl,%eax
  801d2c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801d30:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d34:	89 f1                	mov    %esi,%ecx
  801d36:	d3 e8                	shr    %cl,%eax
  801d38:	09 d0                	or     %edx,%eax
  801d3a:	d3 eb                	shr    %cl,%ebx
  801d3c:	89 da                	mov    %ebx,%edx
  801d3e:	f7 f7                	div    %edi
  801d40:	89 d3                	mov    %edx,%ebx
  801d42:	f7 24 24             	mull   (%esp)
  801d45:	89 c6                	mov    %eax,%esi
  801d47:	89 d1                	mov    %edx,%ecx
  801d49:	39 d3                	cmp    %edx,%ebx
  801d4b:	0f 82 87 00 00 00    	jb     801dd8 <__umoddi3+0x134>
  801d51:	0f 84 91 00 00 00    	je     801de8 <__umoddi3+0x144>
  801d57:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d5b:	29 f2                	sub    %esi,%edx
  801d5d:	19 cb                	sbb    %ecx,%ebx
  801d5f:	89 d8                	mov    %ebx,%eax
  801d61:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d65:	d3 e0                	shl    %cl,%eax
  801d67:	89 e9                	mov    %ebp,%ecx
  801d69:	d3 ea                	shr    %cl,%edx
  801d6b:	09 d0                	or     %edx,%eax
  801d6d:	89 e9                	mov    %ebp,%ecx
  801d6f:	d3 eb                	shr    %cl,%ebx
  801d71:	89 da                	mov    %ebx,%edx
  801d73:	83 c4 1c             	add    $0x1c,%esp
  801d76:	5b                   	pop    %ebx
  801d77:	5e                   	pop    %esi
  801d78:	5f                   	pop    %edi
  801d79:	5d                   	pop    %ebp
  801d7a:	c3                   	ret    
  801d7b:	90                   	nop
  801d7c:	89 fd                	mov    %edi,%ebp
  801d7e:	85 ff                	test   %edi,%edi
  801d80:	75 0b                	jne    801d8d <__umoddi3+0xe9>
  801d82:	b8 01 00 00 00       	mov    $0x1,%eax
  801d87:	31 d2                	xor    %edx,%edx
  801d89:	f7 f7                	div    %edi
  801d8b:	89 c5                	mov    %eax,%ebp
  801d8d:	89 f0                	mov    %esi,%eax
  801d8f:	31 d2                	xor    %edx,%edx
  801d91:	f7 f5                	div    %ebp
  801d93:	89 c8                	mov    %ecx,%eax
  801d95:	f7 f5                	div    %ebp
  801d97:	89 d0                	mov    %edx,%eax
  801d99:	e9 44 ff ff ff       	jmp    801ce2 <__umoddi3+0x3e>
  801d9e:	66 90                	xchg   %ax,%ax
  801da0:	89 c8                	mov    %ecx,%eax
  801da2:	89 f2                	mov    %esi,%edx
  801da4:	83 c4 1c             	add    $0x1c,%esp
  801da7:	5b                   	pop    %ebx
  801da8:	5e                   	pop    %esi
  801da9:	5f                   	pop    %edi
  801daa:	5d                   	pop    %ebp
  801dab:	c3                   	ret    
  801dac:	3b 04 24             	cmp    (%esp),%eax
  801daf:	72 06                	jb     801db7 <__umoddi3+0x113>
  801db1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801db5:	77 0f                	ja     801dc6 <__umoddi3+0x122>
  801db7:	89 f2                	mov    %esi,%edx
  801db9:	29 f9                	sub    %edi,%ecx
  801dbb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801dbf:	89 14 24             	mov    %edx,(%esp)
  801dc2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801dc6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801dca:	8b 14 24             	mov    (%esp),%edx
  801dcd:	83 c4 1c             	add    $0x1c,%esp
  801dd0:	5b                   	pop    %ebx
  801dd1:	5e                   	pop    %esi
  801dd2:	5f                   	pop    %edi
  801dd3:	5d                   	pop    %ebp
  801dd4:	c3                   	ret    
  801dd5:	8d 76 00             	lea    0x0(%esi),%esi
  801dd8:	2b 04 24             	sub    (%esp),%eax
  801ddb:	19 fa                	sbb    %edi,%edx
  801ddd:	89 d1                	mov    %edx,%ecx
  801ddf:	89 c6                	mov    %eax,%esi
  801de1:	e9 71 ff ff ff       	jmp    801d57 <__umoddi3+0xb3>
  801de6:	66 90                	xchg   %ax,%ax
  801de8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801dec:	72 ea                	jb     801dd8 <__umoddi3+0x134>
  801dee:	89 d9                	mov    %ebx,%ecx
  801df0:	e9 62 ff ff ff       	jmp    801d57 <__umoddi3+0xb3>

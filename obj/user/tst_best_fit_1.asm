
obj/user/tst_best_fit_1:     file format elf32-i386


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
  800031:	e8 bc 0a 00 00       	call   800af2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* MAKE SURE PAGE_WS_MAX_SIZE = 1000 */
/* *********************************************************** */
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 02                	push   $0x2
  800045:	e8 00 25 00 00       	call   80254a <sys_set_uheap_strategy>
  80004a:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80004d:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800051:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800058:	eb 23                	jmp    80007d <_main+0x45>
		{
			if (myEnv->__uptr_pws[i].empty)
  80005a:	a1 20 30 80 00       	mov    0x803020,%eax
  80005f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800065:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800068:	c1 e2 04             	shl    $0x4,%edx
  80006b:	01 d0                	add    %edx,%eax
  80006d:	8a 40 04             	mov    0x4(%eax),%al
  800070:	84 c0                	test   %al,%al
  800072:	74 06                	je     80007a <_main+0x42>
			{
				fullWS = 0;
  800074:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800078:	eb 12                	jmp    80008c <_main+0x54>
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80007a:	ff 45 f0             	incl   -0x10(%ebp)
  80007d:	a1 20 30 80 00       	mov    0x803020,%eax
  800082:	8b 50 74             	mov    0x74(%eax),%edx
  800085:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800088:	39 c2                	cmp    %eax,%edx
  80008a:	77 ce                	ja     80005a <_main+0x22>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80008c:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800090:	74 14                	je     8000a6 <_main+0x6e>
  800092:	83 ec 04             	sub    $0x4,%esp
  800095:	68 20 28 80 00       	push   $0x802820
  80009a:	6a 15                	push   $0x15
  80009c:	68 3c 28 80 00       	push   $0x80283c
  8000a1:	e8 91 0b 00 00       	call   800c37 <_panic>
	}

	int Mega = 1024*1024;
  8000a6:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000ad:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	void* ptr_allocations[20] = {0};
  8000b4:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000b7:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c1:	89 d7                	mov    %edx,%edi
  8000c3:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	//[1] Allocate all
	{
		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8000c5:	e8 ec 1f 00 00       	call   8020b6 <sys_calculate_free_frames>
  8000ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000cd:	e8 67 20 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8000d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(3*Mega-kilo);
  8000d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000d8:	89 c2                	mov    %eax,%edx
  8000da:	01 d2                	add    %edx,%edx
  8000dc:	01 d0                	add    %edx,%eax
  8000de:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000e1:	83 ec 0c             	sub    $0xc,%esp
  8000e4:	50                   	push   %eax
  8000e5:	e8 79 1b 00 00       	call   801c63 <malloc>
  8000ea:	83 c4 10             	add    $0x10,%esp
  8000ed:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  8000f0:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000f3:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000f8:	74 14                	je     80010e <_main+0xd6>
  8000fa:	83 ec 04             	sub    $0x4,%esp
  8000fd:	68 54 28 80 00       	push   $0x802854
  800102:	6a 23                	push   $0x23
  800104:	68 3c 28 80 00       	push   $0x80283c
  800109:	e8 29 0b 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*256) panic("Wrong page file allocation: ");
  80010e:	e8 26 20 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800113:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800116:	3d 00 03 00 00       	cmp    $0x300,%eax
  80011b:	74 14                	je     800131 <_main+0xf9>
  80011d:	83 ec 04             	sub    $0x4,%esp
  800120:	68 84 28 80 00       	push   $0x802884
  800125:	6a 25                	push   $0x25
  800127:	68 3c 28 80 00       	push   $0x80283c
  80012c:	e8 06 0b 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800131:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800134:	e8 7d 1f 00 00       	call   8020b6 <sys_calculate_free_frames>
  800139:	29 c3                	sub    %eax,%ebx
  80013b:	89 d8                	mov    %ebx,%eax
  80013d:	83 f8 01             	cmp    $0x1,%eax
  800140:	74 14                	je     800156 <_main+0x11e>
  800142:	83 ec 04             	sub    $0x4,%esp
  800145:	68 a1 28 80 00       	push   $0x8028a1
  80014a:	6a 26                	push   $0x26
  80014c:	68 3c 28 80 00       	push   $0x80283c
  800151:	e8 e1 0a 00 00       	call   800c37 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800156:	e8 5b 1f 00 00       	call   8020b6 <sys_calculate_free_frames>
  80015b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80015e:	e8 d6 1f 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800163:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(3*Mega-kilo);
  800166:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800169:	89 c2                	mov    %eax,%edx
  80016b:	01 d2                	add    %edx,%edx
  80016d:	01 d0                	add    %edx,%eax
  80016f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800172:	83 ec 0c             	sub    $0xc,%esp
  800175:	50                   	push   %eax
  800176:	e8 e8 1a 00 00       	call   801c63 <malloc>
  80017b:	83 c4 10             	add    $0x10,%esp
  80017e:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 3*Mega)) panic("Wrong start address for the allocated space... ");
  800181:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800184:	89 c1                	mov    %eax,%ecx
  800186:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800189:	89 c2                	mov    %eax,%edx
  80018b:	01 d2                	add    %edx,%edx
  80018d:	01 d0                	add    %edx,%eax
  80018f:	05 00 00 00 80       	add    $0x80000000,%eax
  800194:	39 c1                	cmp    %eax,%ecx
  800196:	74 14                	je     8001ac <_main+0x174>
  800198:	83 ec 04             	sub    $0x4,%esp
  80019b:	68 54 28 80 00       	push   $0x802854
  8001a0:	6a 2c                	push   $0x2c
  8001a2:	68 3c 28 80 00       	push   $0x80283c
  8001a7:	e8 8b 0a 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*256) panic("Wrong page file allocation: ");
  8001ac:	e8 88 1f 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8001b1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b4:	3d 00 03 00 00       	cmp    $0x300,%eax
  8001b9:	74 14                	je     8001cf <_main+0x197>
  8001bb:	83 ec 04             	sub    $0x4,%esp
  8001be:	68 84 28 80 00       	push   $0x802884
  8001c3:	6a 2e                	push   $0x2e
  8001c5:	68 3c 28 80 00       	push   $0x80283c
  8001ca:	e8 68 0a 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  8001cf:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8001d2:	e8 df 1e 00 00       	call   8020b6 <sys_calculate_free_frames>
  8001d7:	29 c3                	sub    %eax,%ebx
  8001d9:	89 d8                	mov    %ebx,%eax
  8001db:	83 f8 01             	cmp    $0x1,%eax
  8001de:	74 14                	je     8001f4 <_main+0x1bc>
  8001e0:	83 ec 04             	sub    $0x4,%esp
  8001e3:	68 a1 28 80 00       	push   $0x8028a1
  8001e8:	6a 2f                	push   $0x2f
  8001ea:	68 3c 28 80 00       	push   $0x80283c
  8001ef:	e8 43 0a 00 00       	call   800c37 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8001f4:	e8 bd 1e 00 00       	call   8020b6 <sys_calculate_free_frames>
  8001f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001fc:	e8 38 1f 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800201:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*Mega-kilo);
  800204:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800207:	01 c0                	add    %eax,%eax
  800209:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80020c:	83 ec 0c             	sub    $0xc,%esp
  80020f:	50                   	push   %eax
  800210:	e8 4e 1a 00 00       	call   801c63 <malloc>
  800215:	83 c4 10             	add    $0x10,%esp
  800218:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  80021b:	8b 45 98             	mov    -0x68(%ebp),%eax
  80021e:	89 c1                	mov    %eax,%ecx
  800220:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800223:	89 d0                	mov    %edx,%eax
  800225:	01 c0                	add    %eax,%eax
  800227:	01 d0                	add    %edx,%eax
  800229:	01 c0                	add    %eax,%eax
  80022b:	05 00 00 00 80       	add    $0x80000000,%eax
  800230:	39 c1                	cmp    %eax,%ecx
  800232:	74 14                	je     800248 <_main+0x210>
  800234:	83 ec 04             	sub    $0x4,%esp
  800237:	68 54 28 80 00       	push   $0x802854
  80023c:	6a 35                	push   $0x35
  80023e:	68 3c 28 80 00       	push   $0x80283c
  800243:	e8 ef 09 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  800248:	e8 ec 1e 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  80024d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800250:	3d 00 02 00 00       	cmp    $0x200,%eax
  800255:	74 14                	je     80026b <_main+0x233>
  800257:	83 ec 04             	sub    $0x4,%esp
  80025a:	68 84 28 80 00       	push   $0x802884
  80025f:	6a 37                	push   $0x37
  800261:	68 3c 28 80 00       	push   $0x80283c
  800266:	e8 cc 09 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  80026b:	e8 46 1e 00 00       	call   8020b6 <sys_calculate_free_frames>
  800270:	89 c2                	mov    %eax,%edx
  800272:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800275:	39 c2                	cmp    %eax,%edx
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 a1 28 80 00       	push   $0x8028a1
  800281:	6a 38                	push   $0x38
  800283:	68 3c 28 80 00       	push   $0x80283c
  800288:	e8 aa 09 00 00       	call   800c37 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  80028d:	e8 24 1e 00 00       	call   8020b6 <sys_calculate_free_frames>
  800292:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800295:	e8 9f 1e 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  80029a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*Mega-kilo);
  80029d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002a0:	01 c0                	add    %eax,%eax
  8002a2:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8002a5:	83 ec 0c             	sub    $0xc,%esp
  8002a8:	50                   	push   %eax
  8002a9:	e8 b5 19 00 00       	call   801c63 <malloc>
  8002ae:	83 c4 10             	add    $0x10,%esp
  8002b1:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8002b4:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002b7:	89 c2                	mov    %eax,%edx
  8002b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002bc:	c1 e0 03             	shl    $0x3,%eax
  8002bf:	05 00 00 00 80       	add    $0x80000000,%eax
  8002c4:	39 c2                	cmp    %eax,%edx
  8002c6:	74 14                	je     8002dc <_main+0x2a4>
  8002c8:	83 ec 04             	sub    $0x4,%esp
  8002cb:	68 54 28 80 00       	push   $0x802854
  8002d0:	6a 3e                	push   $0x3e
  8002d2:	68 3c 28 80 00       	push   $0x80283c
  8002d7:	e8 5b 09 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  8002dc:	e8 58 1e 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8002e1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002e4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002e9:	74 14                	je     8002ff <_main+0x2c7>
  8002eb:	83 ec 04             	sub    $0x4,%esp
  8002ee:	68 84 28 80 00       	push   $0x802884
  8002f3:	6a 40                	push   $0x40
  8002f5:	68 3c 28 80 00       	push   $0x80283c
  8002fa:	e8 38 09 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  8002ff:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800302:	e8 af 1d 00 00       	call   8020b6 <sys_calculate_free_frames>
  800307:	29 c3                	sub    %eax,%ebx
  800309:	89 d8                	mov    %ebx,%eax
  80030b:	83 f8 01             	cmp    $0x1,%eax
  80030e:	74 14                	je     800324 <_main+0x2ec>
  800310:	83 ec 04             	sub    $0x4,%esp
  800313:	68 a1 28 80 00       	push   $0x8028a1
  800318:	6a 41                	push   $0x41
  80031a:	68 3c 28 80 00       	push   $0x80283c
  80031f:	e8 13 09 00 00       	call   800c37 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800324:	e8 8d 1d 00 00       	call   8020b6 <sys_calculate_free_frames>
  800329:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80032c:	e8 08 1e 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800331:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(1*Mega-kilo);
  800334:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800337:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80033a:	83 ec 0c             	sub    $0xc,%esp
  80033d:	50                   	push   %eax
  80033e:	e8 20 19 00 00       	call   801c63 <malloc>
  800343:	83 c4 10             	add    $0x10,%esp
  800346:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] !=  (USER_HEAP_START + 10*Mega) ) panic("Wrong start address for the allocated space... ");
  800349:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80034c:	89 c1                	mov    %eax,%ecx
  80034e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800351:	89 d0                	mov    %edx,%eax
  800353:	c1 e0 02             	shl    $0x2,%eax
  800356:	01 d0                	add    %edx,%eax
  800358:	01 c0                	add    %eax,%eax
  80035a:	05 00 00 00 80       	add    $0x80000000,%eax
  80035f:	39 c1                	cmp    %eax,%ecx
  800361:	74 14                	je     800377 <_main+0x33f>
  800363:	83 ec 04             	sub    $0x4,%esp
  800366:	68 54 28 80 00       	push   $0x802854
  80036b:	6a 47                	push   $0x47
  80036d:	68 3c 28 80 00       	push   $0x80283c
  800372:	e8 c0 08 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800377:	e8 bd 1d 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  80037c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80037f:	3d 00 01 00 00       	cmp    $0x100,%eax
  800384:	74 14                	je     80039a <_main+0x362>
  800386:	83 ec 04             	sub    $0x4,%esp
  800389:	68 84 28 80 00       	push   $0x802884
  80038e:	6a 49                	push   $0x49
  800390:	68 3c 28 80 00       	push   $0x80283c
  800395:	e8 9d 08 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80039a:	e8 17 1d 00 00       	call   8020b6 <sys_calculate_free_frames>
  80039f:	89 c2                	mov    %eax,%edx
  8003a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003a4:	39 c2                	cmp    %eax,%edx
  8003a6:	74 14                	je     8003bc <_main+0x384>
  8003a8:	83 ec 04             	sub    $0x4,%esp
  8003ab:	68 a1 28 80 00       	push   $0x8028a1
  8003b0:	6a 4a                	push   $0x4a
  8003b2:	68 3c 28 80 00       	push   $0x80283c
  8003b7:	e8 7b 08 00 00       	call   800c37 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8003bc:	e8 f5 1c 00 00       	call   8020b6 <sys_calculate_free_frames>
  8003c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c4:	e8 70 1d 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8003c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(1*Mega-kilo);
  8003cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003cf:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003d2:	83 ec 0c             	sub    $0xc,%esp
  8003d5:	50                   	push   %eax
  8003d6:	e8 88 18 00 00       	call   801c63 <malloc>
  8003db:	83 c4 10             	add    $0x10,%esp
  8003de:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 11*Mega) ) panic("Wrong start address for the allocated space... ");
  8003e1:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003e4:	89 c1                	mov    %eax,%ecx
  8003e6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003e9:	89 d0                	mov    %edx,%eax
  8003eb:	c1 e0 02             	shl    $0x2,%eax
  8003ee:	01 d0                	add    %edx,%eax
  8003f0:	01 c0                	add    %eax,%eax
  8003f2:	01 d0                	add    %edx,%eax
  8003f4:	05 00 00 00 80       	add    $0x80000000,%eax
  8003f9:	39 c1                	cmp    %eax,%ecx
  8003fb:	74 14                	je     800411 <_main+0x3d9>
  8003fd:	83 ec 04             	sub    $0x4,%esp
  800400:	68 54 28 80 00       	push   $0x802854
  800405:	6a 50                	push   $0x50
  800407:	68 3c 28 80 00       	push   $0x80283c
  80040c:	e8 26 08 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800411:	e8 23 1d 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800416:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800419:	3d 00 01 00 00       	cmp    $0x100,%eax
  80041e:	74 14                	je     800434 <_main+0x3fc>
  800420:	83 ec 04             	sub    $0x4,%esp
  800423:	68 84 28 80 00       	push   $0x802884
  800428:	6a 52                	push   $0x52
  80042a:	68 3c 28 80 00       	push   $0x80283c
  80042f:	e8 03 08 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800434:	e8 7d 1c 00 00       	call   8020b6 <sys_calculate_free_frames>
  800439:	89 c2                	mov    %eax,%edx
  80043b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80043e:	39 c2                	cmp    %eax,%edx
  800440:	74 14                	je     800456 <_main+0x41e>
  800442:	83 ec 04             	sub    $0x4,%esp
  800445:	68 a1 28 80 00       	push   $0x8028a1
  80044a:	6a 53                	push   $0x53
  80044c:	68 3c 28 80 00       	push   $0x80283c
  800451:	e8 e1 07 00 00       	call   800c37 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800456:	e8 5b 1c 00 00       	call   8020b6 <sys_calculate_free_frames>
  80045b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80045e:	e8 d6 1c 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800463:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(1*Mega-kilo);
  800466:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800469:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80046c:	83 ec 0c             	sub    $0xc,%esp
  80046f:	50                   	push   %eax
  800470:	e8 ee 17 00 00       	call   801c63 <malloc>
  800475:	83 c4 10             	add    $0x10,%esp
  800478:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 12*Mega) ) panic("Wrong start address for the allocated space... ");
  80047b:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80047e:	89 c1                	mov    %eax,%ecx
  800480:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800483:	89 d0                	mov    %edx,%eax
  800485:	01 c0                	add    %eax,%eax
  800487:	01 d0                	add    %edx,%eax
  800489:	c1 e0 02             	shl    $0x2,%eax
  80048c:	05 00 00 00 80       	add    $0x80000000,%eax
  800491:	39 c1                	cmp    %eax,%ecx
  800493:	74 14                	je     8004a9 <_main+0x471>
  800495:	83 ec 04             	sub    $0x4,%esp
  800498:	68 54 28 80 00       	push   $0x802854
  80049d:	6a 59                	push   $0x59
  80049f:	68 3c 28 80 00       	push   $0x80283c
  8004a4:	e8 8e 07 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8004a9:	e8 8b 1c 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8004ae:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004b1:	3d 00 01 00 00       	cmp    $0x100,%eax
  8004b6:	74 14                	je     8004cc <_main+0x494>
  8004b8:	83 ec 04             	sub    $0x4,%esp
  8004bb:	68 84 28 80 00       	push   $0x802884
  8004c0:	6a 5b                	push   $0x5b
  8004c2:	68 3c 28 80 00       	push   $0x80283c
  8004c7:	e8 6b 07 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004cc:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8004cf:	e8 e2 1b 00 00       	call   8020b6 <sys_calculate_free_frames>
  8004d4:	29 c3                	sub    %eax,%ebx
  8004d6:	89 d8                	mov    %ebx,%eax
  8004d8:	83 f8 01             	cmp    $0x1,%eax
  8004db:	74 14                	je     8004f1 <_main+0x4b9>
  8004dd:	83 ec 04             	sub    $0x4,%esp
  8004e0:	68 a1 28 80 00       	push   $0x8028a1
  8004e5:	6a 5c                	push   $0x5c
  8004e7:	68 3c 28 80 00       	push   $0x80283c
  8004ec:	e8 46 07 00 00       	call   800c37 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8004f1:	e8 c0 1b 00 00       	call   8020b6 <sys_calculate_free_frames>
  8004f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004f9:	e8 3b 1c 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8004fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(1*Mega-kilo);
  800501:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800504:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800507:	83 ec 0c             	sub    $0xc,%esp
  80050a:	50                   	push   %eax
  80050b:	e8 53 17 00 00       	call   801c63 <malloc>
  800510:	83 c4 10             	add    $0x10,%esp
  800513:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 13*Mega)) panic("Wrong start address for the allocated space... ");
  800516:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800519:	89 c1                	mov    %eax,%ecx
  80051b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80051e:	89 d0                	mov    %edx,%eax
  800520:	01 c0                	add    %eax,%eax
  800522:	01 d0                	add    %edx,%eax
  800524:	c1 e0 02             	shl    $0x2,%eax
  800527:	01 d0                	add    %edx,%eax
  800529:	05 00 00 00 80       	add    $0x80000000,%eax
  80052e:	39 c1                	cmp    %eax,%ecx
  800530:	74 14                	je     800546 <_main+0x50e>
  800532:	83 ec 04             	sub    $0x4,%esp
  800535:	68 54 28 80 00       	push   $0x802854
  80053a:	6a 62                	push   $0x62
  80053c:	68 3c 28 80 00       	push   $0x80283c
  800541:	e8 f1 06 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800546:	e8 ee 1b 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  80054b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80054e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800553:	74 14                	je     800569 <_main+0x531>
  800555:	83 ec 04             	sub    $0x4,%esp
  800558:	68 84 28 80 00       	push   $0x802884
  80055d:	6a 64                	push   $0x64
  80055f:	68 3c 28 80 00       	push   $0x80283c
  800564:	e8 ce 06 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800569:	e8 48 1b 00 00       	call   8020b6 <sys_calculate_free_frames>
  80056e:	89 c2                	mov    %eax,%edx
  800570:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800573:	39 c2                	cmp    %eax,%edx
  800575:	74 14                	je     80058b <_main+0x553>
  800577:	83 ec 04             	sub    $0x4,%esp
  80057a:	68 a1 28 80 00       	push   $0x8028a1
  80057f:	6a 65                	push   $0x65
  800581:	68 3c 28 80 00       	push   $0x80283c
  800586:	e8 ac 06 00 00       	call   800c37 <_panic>
	}

	//[2] Free some to create holes
	{
		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80058b:	e8 26 1b 00 00       	call   8020b6 <sys_calculate_free_frames>
  800590:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800593:	e8 a1 1b 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800598:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  80059b:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80059e:	83 ec 0c             	sub    $0xc,%esp
  8005a1:	50                   	push   %eax
  8005a2:	e8 cc 18 00 00       	call   801e73 <free>
  8005a7:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  3*256) panic("Wrong page file free: ");
  8005aa:	e8 8a 1b 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8005af:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005b2:	29 c2                	sub    %eax,%edx
  8005b4:	89 d0                	mov    %edx,%eax
  8005b6:	3d 00 03 00 00       	cmp    $0x300,%eax
  8005bb:	74 14                	je     8005d1 <_main+0x599>
  8005bd:	83 ec 04             	sub    $0x4,%esp
  8005c0:	68 b4 28 80 00       	push   $0x8028b4
  8005c5:	6a 6f                	push   $0x6f
  8005c7:	68 3c 28 80 00       	push   $0x80283c
  8005cc:	e8 66 06 00 00       	call   800c37 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005d1:	e8 e0 1a 00 00       	call   8020b6 <sys_calculate_free_frames>
  8005d6:	89 c2                	mov    %eax,%edx
  8005d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005db:	39 c2                	cmp    %eax,%edx
  8005dd:	74 14                	je     8005f3 <_main+0x5bb>
  8005df:	83 ec 04             	sub    $0x4,%esp
  8005e2:	68 cb 28 80 00       	push   $0x8028cb
  8005e7:	6a 70                	push   $0x70
  8005e9:	68 3c 28 80 00       	push   $0x80283c
  8005ee:	e8 44 06 00 00       	call   800c37 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005f3:	e8 be 1a 00 00       	call   8020b6 <sys_calculate_free_frames>
  8005f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005fb:	e8 39 1b 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800600:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[3]);
  800603:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800606:	83 ec 0c             	sub    $0xc,%esp
  800609:	50                   	push   %eax
  80060a:	e8 64 18 00 00       	call   801e73 <free>
  80060f:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  2*256) panic("Wrong page file free: ");
  800612:	e8 22 1b 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800617:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80061a:	29 c2                	sub    %eax,%edx
  80061c:	89 d0                	mov    %edx,%eax
  80061e:	3d 00 02 00 00       	cmp    $0x200,%eax
  800623:	74 14                	je     800639 <_main+0x601>
  800625:	83 ec 04             	sub    $0x4,%esp
  800628:	68 b4 28 80 00       	push   $0x8028b4
  80062d:	6a 77                	push   $0x77
  80062f:	68 3c 28 80 00       	push   $0x80283c
  800634:	e8 fe 05 00 00       	call   800c37 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800639:	e8 78 1a 00 00       	call   8020b6 <sys_calculate_free_frames>
  80063e:	89 c2                	mov    %eax,%edx
  800640:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800643:	39 c2                	cmp    %eax,%edx
  800645:	74 14                	je     80065b <_main+0x623>
  800647:	83 ec 04             	sub    $0x4,%esp
  80064a:	68 cb 28 80 00       	push   $0x8028cb
  80064f:	6a 78                	push   $0x78
  800651:	68 3c 28 80 00       	push   $0x80283c
  800656:	e8 dc 05 00 00       	call   800c37 <_panic>

		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80065b:	e8 56 1a 00 00       	call   8020b6 <sys_calculate_free_frames>
  800660:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800663:	e8 d1 1a 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800668:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  80066b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80066e:	83 ec 0c             	sub    $0xc,%esp
  800671:	50                   	push   %eax
  800672:	e8 fc 17 00 00       	call   801e73 <free>
  800677:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  80067a:	e8 ba 1a 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  80067f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800682:	29 c2                	sub    %eax,%edx
  800684:	89 d0                	mov    %edx,%eax
  800686:	3d 00 01 00 00       	cmp    $0x100,%eax
  80068b:	74 14                	je     8006a1 <_main+0x669>
  80068d:	83 ec 04             	sub    $0x4,%esp
  800690:	68 b4 28 80 00       	push   $0x8028b4
  800695:	6a 7f                	push   $0x7f
  800697:	68 3c 28 80 00       	push   $0x80283c
  80069c:	e8 96 05 00 00       	call   800c37 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8006a1:	e8 10 1a 00 00       	call   8020b6 <sys_calculate_free_frames>
  8006a6:	89 c2                	mov    %eax,%edx
  8006a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ab:	39 c2                	cmp    %eax,%edx
  8006ad:	74 17                	je     8006c6 <_main+0x68e>
  8006af:	83 ec 04             	sub    $0x4,%esp
  8006b2:	68 cb 28 80 00       	push   $0x8028cb
  8006b7:	68 80 00 00 00       	push   $0x80
  8006bc:	68 3c 28 80 00       	push   $0x80283c
  8006c1:	e8 71 05 00 00       	call   800c37 <_panic>
	}

	//[3] Allocate again [test best fit]
	{
		//Allocate 512 KB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  8006c6:	e8 eb 19 00 00       	call   8020b6 <sys_calculate_free_frames>
  8006cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006ce:	e8 66 1a 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8006d3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(512*kilo);
  8006d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006d9:	c1 e0 09             	shl    $0x9,%eax
  8006dc:	83 ec 0c             	sub    $0xc,%esp
  8006df:	50                   	push   %eax
  8006e0:	e8 7e 15 00 00       	call   801c63 <malloc>
  8006e5:	83 c4 10             	add    $0x10,%esp
  8006e8:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  8006eb:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8006ee:	89 c1                	mov    %eax,%ecx
  8006f0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006f3:	89 d0                	mov    %edx,%eax
  8006f5:	c1 e0 02             	shl    $0x2,%eax
  8006f8:	01 d0                	add    %edx,%eax
  8006fa:	01 c0                	add    %eax,%eax
  8006fc:	01 d0                	add    %edx,%eax
  8006fe:	05 00 00 00 80       	add    $0x80000000,%eax
  800703:	39 c1                	cmp    %eax,%ecx
  800705:	74 17                	je     80071e <_main+0x6e6>
  800707:	83 ec 04             	sub    $0x4,%esp
  80070a:	68 54 28 80 00       	push   $0x802854
  80070f:	68 89 00 00 00       	push   $0x89
  800714:	68 3c 28 80 00       	push   $0x80283c
  800719:	e8 19 05 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  80071e:	e8 16 1a 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800723:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800726:	3d 80 00 00 00       	cmp    $0x80,%eax
  80072b:	74 17                	je     800744 <_main+0x70c>
  80072d:	83 ec 04             	sub    $0x4,%esp
  800730:	68 84 28 80 00       	push   $0x802884
  800735:	68 8b 00 00 00       	push   $0x8b
  80073a:	68 3c 28 80 00       	push   $0x80283c
  80073f:	e8 f3 04 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800744:	e8 6d 19 00 00       	call   8020b6 <sys_calculate_free_frames>
  800749:	89 c2                	mov    %eax,%edx
  80074b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80074e:	39 c2                	cmp    %eax,%edx
  800750:	74 17                	je     800769 <_main+0x731>
  800752:	83 ec 04             	sub    $0x4,%esp
  800755:	68 a1 28 80 00       	push   $0x8028a1
  80075a:	68 8c 00 00 00       	push   $0x8c
  80075f:	68 3c 28 80 00       	push   $0x80283c
  800764:	e8 ce 04 00 00       	call   800c37 <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800769:	e8 48 19 00 00       	call   8020b6 <sys_calculate_free_frames>
  80076e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800771:	e8 c3 19 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800776:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  800779:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80077c:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80077f:	83 ec 0c             	sub    $0xc,%esp
  800782:	50                   	push   %eax
  800783:	e8 db 14 00 00       	call   801c63 <malloc>
  800788:	83 c4 10             	add    $0x10,%esp
  80078b:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  80078e:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800791:	89 c2                	mov    %eax,%edx
  800793:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800796:	c1 e0 03             	shl    $0x3,%eax
  800799:	05 00 00 00 80       	add    $0x80000000,%eax
  80079e:	39 c2                	cmp    %eax,%edx
  8007a0:	74 17                	je     8007b9 <_main+0x781>
  8007a2:	83 ec 04             	sub    $0x4,%esp
  8007a5:	68 54 28 80 00       	push   $0x802854
  8007aa:	68 92 00 00 00       	push   $0x92
  8007af:	68 3c 28 80 00       	push   $0x80283c
  8007b4:	e8 7e 04 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007b9:	e8 7b 19 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8007be:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007c1:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007c6:	74 17                	je     8007df <_main+0x7a7>
  8007c8:	83 ec 04             	sub    $0x4,%esp
  8007cb:	68 84 28 80 00       	push   $0x802884
  8007d0:	68 94 00 00 00       	push   $0x94
  8007d5:	68 3c 28 80 00       	push   $0x80283c
  8007da:	e8 58 04 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007df:	e8 d2 18 00 00       	call   8020b6 <sys_calculate_free_frames>
  8007e4:	89 c2                	mov    %eax,%edx
  8007e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007e9:	39 c2                	cmp    %eax,%edx
  8007eb:	74 17                	je     800804 <_main+0x7cc>
  8007ed:	83 ec 04             	sub    $0x4,%esp
  8007f0:	68 a1 28 80 00       	push   $0x8028a1
  8007f5:	68 95 00 00 00       	push   $0x95
  8007fa:	68 3c 28 80 00       	push   $0x80283c
  8007ff:	e8 33 04 00 00       	call   800c37 <_panic>

		//Allocate 256 KB - should be placed in remaining of 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  800804:	e8 ad 18 00 00       	call   8020b6 <sys_calculate_free_frames>
  800809:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80080c:	e8 28 19 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800811:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  800814:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800817:	89 d0                	mov    %edx,%eax
  800819:	c1 e0 08             	shl    $0x8,%eax
  80081c:	29 d0                	sub    %edx,%eax
  80081e:	83 ec 0c             	sub    $0xc,%esp
  800821:	50                   	push   %eax
  800822:	e8 3c 14 00 00       	call   801c63 <malloc>
  800827:	83 c4 10             	add    $0x10,%esp
  80082a:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] !=  (USER_HEAP_START + 11*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  80082d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800830:	89 c1                	mov    %eax,%ecx
  800832:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800835:	89 d0                	mov    %edx,%eax
  800837:	c1 e0 02             	shl    $0x2,%eax
  80083a:	01 d0                	add    %edx,%eax
  80083c:	01 c0                	add    %eax,%eax
  80083e:	01 d0                	add    %edx,%eax
  800840:	89 c2                	mov    %eax,%edx
  800842:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800845:	c1 e0 09             	shl    $0x9,%eax
  800848:	01 d0                	add    %edx,%eax
  80084a:	05 00 00 00 80       	add    $0x80000000,%eax
  80084f:	39 c1                	cmp    %eax,%ecx
  800851:	74 17                	je     80086a <_main+0x832>
  800853:	83 ec 04             	sub    $0x4,%esp
  800856:	68 54 28 80 00       	push   $0x802854
  80085b:	68 9b 00 00 00       	push   $0x9b
  800860:	68 3c 28 80 00       	push   $0x80283c
  800865:	e8 cd 03 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  80086a:	e8 ca 18 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  80086f:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800872:	83 f8 40             	cmp    $0x40,%eax
  800875:	74 17                	je     80088e <_main+0x856>
  800877:	83 ec 04             	sub    $0x4,%esp
  80087a:	68 84 28 80 00       	push   $0x802884
  80087f:	68 9d 00 00 00       	push   $0x9d
  800884:	68 3c 28 80 00       	push   $0x80283c
  800889:	e8 a9 03 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80088e:	e8 23 18 00 00       	call   8020b6 <sys_calculate_free_frames>
  800893:	89 c2                	mov    %eax,%edx
  800895:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800898:	39 c2                	cmp    %eax,%edx
  80089a:	74 17                	je     8008b3 <_main+0x87b>
  80089c:	83 ec 04             	sub    $0x4,%esp
  80089f:	68 a1 28 80 00       	push   $0x8028a1
  8008a4:	68 9e 00 00 00       	push   $0x9e
  8008a9:	68 3c 28 80 00       	push   $0x80283c
  8008ae:	e8 84 03 00 00       	call   800c37 <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  8008b3:	e8 fe 17 00 00       	call   8020b6 <sys_calculate_free_frames>
  8008b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8008bb:	e8 79 18 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8008c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(4*Mega - kilo);
  8008c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008c6:	c1 e0 02             	shl    $0x2,%eax
  8008c9:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8008cc:	83 ec 0c             	sub    $0xc,%esp
  8008cf:	50                   	push   %eax
  8008d0:	e8 8e 13 00 00       	call   801c63 <malloc>
  8008d5:	83 c4 10             	add    $0x10,%esp
  8008d8:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the allocated space... ");
  8008db:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8008de:	89 c1                	mov    %eax,%ecx
  8008e0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8008e3:	89 d0                	mov    %edx,%eax
  8008e5:	01 c0                	add    %eax,%eax
  8008e7:	01 d0                	add    %edx,%eax
  8008e9:	01 c0                	add    %eax,%eax
  8008eb:	01 d0                	add    %edx,%eax
  8008ed:	01 c0                	add    %eax,%eax
  8008ef:	05 00 00 00 80       	add    $0x80000000,%eax
  8008f4:	39 c1                	cmp    %eax,%ecx
  8008f6:	74 17                	je     80090f <_main+0x8d7>
  8008f8:	83 ec 04             	sub    $0x4,%esp
  8008fb:	68 54 28 80 00       	push   $0x802854
  800900:	68 a4 00 00 00       	push   $0xa4
  800905:	68 3c 28 80 00       	push   $0x80283c
  80090a:	e8 28 03 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  80090f:	e8 25 18 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800914:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800917:	3d 00 04 00 00       	cmp    $0x400,%eax
  80091c:	74 17                	je     800935 <_main+0x8fd>
  80091e:	83 ec 04             	sub    $0x4,%esp
  800921:	68 84 28 80 00       	push   $0x802884
  800926:	68 a6 00 00 00       	push   $0xa6
  80092b:	68 3c 28 80 00       	push   $0x80283c
  800930:	e8 02 03 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  800935:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800938:	e8 79 17 00 00       	call   8020b6 <sys_calculate_free_frames>
  80093d:	29 c3                	sub    %eax,%ebx
  80093f:	89 d8                	mov    %ebx,%eax
  800941:	83 f8 01             	cmp    $0x1,%eax
  800944:	74 17                	je     80095d <_main+0x925>
  800946:	83 ec 04             	sub    $0x4,%esp
  800949:	68 a1 28 80 00       	push   $0x8028a1
  80094e:	68 a7 00 00 00       	push   $0xa7
  800953:	68 3c 28 80 00       	push   $0x80283c
  800958:	e8 da 02 00 00       	call   800c37 <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1M Hole appended to already existing 1M hole in the middle
		freeFrames = sys_calculate_free_frames() ;
  80095d:	e8 54 17 00 00       	call   8020b6 <sys_calculate_free_frames>
  800962:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800965:	e8 cf 17 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  80096a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[4]);
  80096d:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800970:	83 ec 0c             	sub    $0xc,%esp
  800973:	50                   	push   %eax
  800974:	e8 fa 14 00 00       	call   801e73 <free>
  800979:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  80097c:	e8 b8 17 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800981:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800984:	29 c2                	sub    %eax,%edx
  800986:	89 d0                	mov    %edx,%eax
  800988:	3d 00 01 00 00       	cmp    $0x100,%eax
  80098d:	74 17                	je     8009a6 <_main+0x96e>
  80098f:	83 ec 04             	sub    $0x4,%esp
  800992:	68 b4 28 80 00       	push   $0x8028b4
  800997:	68 b1 00 00 00       	push   $0xb1
  80099c:	68 3c 28 80 00       	push   $0x80283c
  8009a1:	e8 91 02 00 00       	call   800c37 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8009a6:	e8 0b 17 00 00       	call   8020b6 <sys_calculate_free_frames>
  8009ab:	89 c2                	mov    %eax,%edx
  8009ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009b0:	39 c2                	cmp    %eax,%edx
  8009b2:	74 17                	je     8009cb <_main+0x993>
  8009b4:	83 ec 04             	sub    $0x4,%esp
  8009b7:	68 cb 28 80 00       	push   $0x8028cb
  8009bc:	68 b2 00 00 00       	push   $0xb2
  8009c1:	68 3c 28 80 00       	push   $0x80283c
  8009c6:	e8 6c 02 00 00       	call   800c37 <_panic>

		//another 512 KB Hole appended to the hole
		freeFrames = sys_calculate_free_frames() ;
  8009cb:	e8 e6 16 00 00       	call   8020b6 <sys_calculate_free_frames>
  8009d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009d3:	e8 61 17 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8009d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[8]);
  8009db:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8009de:	83 ec 0c             	sub    $0xc,%esp
  8009e1:	50                   	push   %eax
  8009e2:	e8 8c 14 00 00       	call   801e73 <free>
  8009e7:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  128) panic("Wrong page file free: ");
  8009ea:	e8 4a 17 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  8009ef:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009f2:	29 c2                	sub    %eax,%edx
  8009f4:	89 d0                	mov    %edx,%eax
  8009f6:	3d 80 00 00 00       	cmp    $0x80,%eax
  8009fb:	74 17                	je     800a14 <_main+0x9dc>
  8009fd:	83 ec 04             	sub    $0x4,%esp
  800a00:	68 b4 28 80 00       	push   $0x8028b4
  800a05:	68 b9 00 00 00       	push   $0xb9
  800a0a:	68 3c 28 80 00       	push   $0x80283c
  800a0f:	e8 23 02 00 00       	call   800c37 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a14:	e8 9d 16 00 00       	call   8020b6 <sys_calculate_free_frames>
  800a19:	89 c2                	mov    %eax,%edx
  800a1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a1e:	39 c2                	cmp    %eax,%edx
  800a20:	74 17                	je     800a39 <_main+0xa01>
  800a22:	83 ec 04             	sub    $0x4,%esp
  800a25:	68 cb 28 80 00       	push   $0x8028cb
  800a2a:	68 ba 00 00 00       	push   $0xba
  800a2f:	68 3c 28 80 00       	push   $0x80283c
  800a34:	e8 fe 01 00 00       	call   800c37 <_panic>
	}

	//[5] Allocate again [test best fit]
	{
		//Allocate 2 MB - should be placed in the contiguous hole (2 MB + 512 KB)
		freeFrames = sys_calculate_free_frames();
  800a39:	e8 78 16 00 00       	call   8020b6 <sys_calculate_free_frames>
  800a3e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a41:	e8 f3 16 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800a46:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[12] = malloc(2*Mega - kilo);
  800a49:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a4c:	01 c0                	add    %eax,%eax
  800a4e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800a51:	83 ec 0c             	sub    $0xc,%esp
  800a54:	50                   	push   %eax
  800a55:	e8 09 12 00 00       	call   801c63 <malloc>
  800a5a:	83 c4 10             	add    $0x10,%esp
  800a5d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 9*Mega)) panic("Wrong start address for the allocated space... ");
  800a60:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800a63:	89 c1                	mov    %eax,%ecx
  800a65:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800a68:	89 d0                	mov    %edx,%eax
  800a6a:	c1 e0 03             	shl    $0x3,%eax
  800a6d:	01 d0                	add    %edx,%eax
  800a6f:	05 00 00 00 80       	add    $0x80000000,%eax
  800a74:	39 c1                	cmp    %eax,%ecx
  800a76:	74 17                	je     800a8f <_main+0xa57>
  800a78:	83 ec 04             	sub    $0x4,%esp
  800a7b:	68 54 28 80 00       	push   $0x802854
  800a80:	68 c3 00 00 00       	push   $0xc3
  800a85:	68 3c 28 80 00       	push   $0x80283c
  800a8a:	e8 a8 01 00 00       	call   800c37 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  800a8f:	e8 a5 16 00 00       	call   802139 <sys_pf_calculate_allocated_pages>
  800a94:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800a97:	3d 00 02 00 00       	cmp    $0x200,%eax
  800a9c:	74 17                	je     800ab5 <_main+0xa7d>
  800a9e:	83 ec 04             	sub    $0x4,%esp
  800aa1:	68 84 28 80 00       	push   $0x802884
  800aa6:	68 c5 00 00 00       	push   $0xc5
  800aab:	68 3c 28 80 00       	push   $0x80283c
  800ab0:	e8 82 01 00 00       	call   800c37 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800ab5:	e8 fc 15 00 00       	call   8020b6 <sys_calculate_free_frames>
  800aba:	89 c2                	mov    %eax,%edx
  800abc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800abf:	39 c2                	cmp    %eax,%edx
  800ac1:	74 17                	je     800ada <_main+0xaa2>
  800ac3:	83 ec 04             	sub    $0x4,%esp
  800ac6:	68 a1 28 80 00       	push   $0x8028a1
  800acb:	68 c6 00 00 00       	push   $0xc6
  800ad0:	68 3c 28 80 00       	push   $0x80283c
  800ad5:	e8 5d 01 00 00       	call   800c37 <_panic>
	}
	cprintf("Congratulations!! test BEST FIT allocation (1) completed successfully.\n");
  800ada:	83 ec 0c             	sub    $0xc,%esp
  800add:	68 d8 28 80 00       	push   $0x8028d8
  800ae2:	e8 f2 03 00 00       	call   800ed9 <cprintf>
  800ae7:	83 c4 10             	add    $0x10,%esp

	return;
  800aea:	90                   	nop
}
  800aeb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800aee:	5b                   	pop    %ebx
  800aef:	5f                   	pop    %edi
  800af0:	5d                   	pop    %ebp
  800af1:	c3                   	ret    

00800af2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800af2:	55                   	push   %ebp
  800af3:	89 e5                	mov    %esp,%ebp
  800af5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800af8:	e8 ee 14 00 00       	call   801feb <sys_getenvindex>
  800afd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800b00:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b03:	89 d0                	mov    %edx,%eax
  800b05:	c1 e0 03             	shl    $0x3,%eax
  800b08:	01 d0                	add    %edx,%eax
  800b0a:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800b11:	01 c8                	add    %ecx,%eax
  800b13:	01 c0                	add    %eax,%eax
  800b15:	01 d0                	add    %edx,%eax
  800b17:	01 c0                	add    %eax,%eax
  800b19:	01 d0                	add    %edx,%eax
  800b1b:	89 c2                	mov    %eax,%edx
  800b1d:	c1 e2 05             	shl    $0x5,%edx
  800b20:	29 c2                	sub    %eax,%edx
  800b22:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800b29:	89 c2                	mov    %eax,%edx
  800b2b:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800b31:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800b36:	a1 20 30 80 00       	mov    0x803020,%eax
  800b3b:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800b41:	84 c0                	test   %al,%al
  800b43:	74 0f                	je     800b54 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800b45:	a1 20 30 80 00       	mov    0x803020,%eax
  800b4a:	05 40 3c 01 00       	add    $0x13c40,%eax
  800b4f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800b54:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b58:	7e 0a                	jle    800b64 <libmain+0x72>
		binaryname = argv[0];
  800b5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5d:	8b 00                	mov    (%eax),%eax
  800b5f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800b64:	83 ec 08             	sub    $0x8,%esp
  800b67:	ff 75 0c             	pushl  0xc(%ebp)
  800b6a:	ff 75 08             	pushl  0x8(%ebp)
  800b6d:	e8 c6 f4 ff ff       	call   800038 <_main>
  800b72:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800b75:	e8 0c 16 00 00       	call   802186 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800b7a:	83 ec 0c             	sub    $0xc,%esp
  800b7d:	68 38 29 80 00       	push   $0x802938
  800b82:	e8 52 03 00 00       	call   800ed9 <cprintf>
  800b87:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800b8a:	a1 20 30 80 00       	mov    0x803020,%eax
  800b8f:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800b95:	a1 20 30 80 00       	mov    0x803020,%eax
  800b9a:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800ba0:	83 ec 04             	sub    $0x4,%esp
  800ba3:	52                   	push   %edx
  800ba4:	50                   	push   %eax
  800ba5:	68 60 29 80 00       	push   $0x802960
  800baa:	e8 2a 03 00 00       	call   800ed9 <cprintf>
  800baf:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800bb2:	a1 20 30 80 00       	mov    0x803020,%eax
  800bb7:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800bbd:	a1 20 30 80 00       	mov    0x803020,%eax
  800bc2:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800bc8:	83 ec 04             	sub    $0x4,%esp
  800bcb:	52                   	push   %edx
  800bcc:	50                   	push   %eax
  800bcd:	68 88 29 80 00       	push   $0x802988
  800bd2:	e8 02 03 00 00       	call   800ed9 <cprintf>
  800bd7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800bda:	a1 20 30 80 00       	mov    0x803020,%eax
  800bdf:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800be5:	83 ec 08             	sub    $0x8,%esp
  800be8:	50                   	push   %eax
  800be9:	68 c9 29 80 00       	push   $0x8029c9
  800bee:	e8 e6 02 00 00       	call   800ed9 <cprintf>
  800bf3:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800bf6:	83 ec 0c             	sub    $0xc,%esp
  800bf9:	68 38 29 80 00       	push   $0x802938
  800bfe:	e8 d6 02 00 00       	call   800ed9 <cprintf>
  800c03:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800c06:	e8 95 15 00 00       	call   8021a0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800c0b:	e8 19 00 00 00       	call   800c29 <exit>
}
  800c10:	90                   	nop
  800c11:	c9                   	leave  
  800c12:	c3                   	ret    

00800c13 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800c13:	55                   	push   %ebp
  800c14:	89 e5                	mov    %esp,%ebp
  800c16:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800c19:	83 ec 0c             	sub    $0xc,%esp
  800c1c:	6a 00                	push   $0x0
  800c1e:	e8 94 13 00 00       	call   801fb7 <sys_env_destroy>
  800c23:	83 c4 10             	add    $0x10,%esp
}
  800c26:	90                   	nop
  800c27:	c9                   	leave  
  800c28:	c3                   	ret    

00800c29 <exit>:

void
exit(void)
{
  800c29:	55                   	push   %ebp
  800c2a:	89 e5                	mov    %esp,%ebp
  800c2c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800c2f:	e8 e9 13 00 00       	call   80201d <sys_env_exit>
}
  800c34:	90                   	nop
  800c35:	c9                   	leave  
  800c36:	c3                   	ret    

00800c37 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800c37:	55                   	push   %ebp
  800c38:	89 e5                	mov    %esp,%ebp
  800c3a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800c3d:	8d 45 10             	lea    0x10(%ebp),%eax
  800c40:	83 c0 04             	add    $0x4,%eax
  800c43:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800c46:	a1 18 31 80 00       	mov    0x803118,%eax
  800c4b:	85 c0                	test   %eax,%eax
  800c4d:	74 16                	je     800c65 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800c4f:	a1 18 31 80 00       	mov    0x803118,%eax
  800c54:	83 ec 08             	sub    $0x8,%esp
  800c57:	50                   	push   %eax
  800c58:	68 e0 29 80 00       	push   $0x8029e0
  800c5d:	e8 77 02 00 00       	call   800ed9 <cprintf>
  800c62:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800c65:	a1 00 30 80 00       	mov    0x803000,%eax
  800c6a:	ff 75 0c             	pushl  0xc(%ebp)
  800c6d:	ff 75 08             	pushl  0x8(%ebp)
  800c70:	50                   	push   %eax
  800c71:	68 e5 29 80 00       	push   $0x8029e5
  800c76:	e8 5e 02 00 00       	call   800ed9 <cprintf>
  800c7b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800c7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c81:	83 ec 08             	sub    $0x8,%esp
  800c84:	ff 75 f4             	pushl  -0xc(%ebp)
  800c87:	50                   	push   %eax
  800c88:	e8 e1 01 00 00       	call   800e6e <vcprintf>
  800c8d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800c90:	83 ec 08             	sub    $0x8,%esp
  800c93:	6a 00                	push   $0x0
  800c95:	68 01 2a 80 00       	push   $0x802a01
  800c9a:	e8 cf 01 00 00       	call   800e6e <vcprintf>
  800c9f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800ca2:	e8 82 ff ff ff       	call   800c29 <exit>

	// should not return here
	while (1) ;
  800ca7:	eb fe                	jmp    800ca7 <_panic+0x70>

00800ca9 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800ca9:	55                   	push   %ebp
  800caa:	89 e5                	mov    %esp,%ebp
  800cac:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800caf:	a1 20 30 80 00       	mov    0x803020,%eax
  800cb4:	8b 50 74             	mov    0x74(%eax),%edx
  800cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cba:	39 c2                	cmp    %eax,%edx
  800cbc:	74 14                	je     800cd2 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800cbe:	83 ec 04             	sub    $0x4,%esp
  800cc1:	68 04 2a 80 00       	push   $0x802a04
  800cc6:	6a 26                	push   $0x26
  800cc8:	68 50 2a 80 00       	push   $0x802a50
  800ccd:	e8 65 ff ff ff       	call   800c37 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800cd2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800cd9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800ce0:	e9 b6 00 00 00       	jmp    800d9b <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800ce5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ce8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	01 d0                	add    %edx,%eax
  800cf4:	8b 00                	mov    (%eax),%eax
  800cf6:	85 c0                	test   %eax,%eax
  800cf8:	75 08                	jne    800d02 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800cfa:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800cfd:	e9 96 00 00 00       	jmp    800d98 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800d02:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d09:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800d10:	eb 5d                	jmp    800d6f <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800d12:	a1 20 30 80 00       	mov    0x803020,%eax
  800d17:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d1d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d20:	c1 e2 04             	shl    $0x4,%edx
  800d23:	01 d0                	add    %edx,%eax
  800d25:	8a 40 04             	mov    0x4(%eax),%al
  800d28:	84 c0                	test   %al,%al
  800d2a:	75 40                	jne    800d6c <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d2c:	a1 20 30 80 00       	mov    0x803020,%eax
  800d31:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d37:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d3a:	c1 e2 04             	shl    $0x4,%edx
  800d3d:	01 d0                	add    %edx,%eax
  800d3f:	8b 00                	mov    (%eax),%eax
  800d41:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800d44:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d47:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d4c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800d4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d51:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	01 c8                	add    %ecx,%eax
  800d5d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d5f:	39 c2                	cmp    %eax,%edx
  800d61:	75 09                	jne    800d6c <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800d63:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800d6a:	eb 12                	jmp    800d7e <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d6c:	ff 45 e8             	incl   -0x18(%ebp)
  800d6f:	a1 20 30 80 00       	mov    0x803020,%eax
  800d74:	8b 50 74             	mov    0x74(%eax),%edx
  800d77:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800d7a:	39 c2                	cmp    %eax,%edx
  800d7c:	77 94                	ja     800d12 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800d7e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800d82:	75 14                	jne    800d98 <CheckWSWithoutLastIndex+0xef>
			panic(
  800d84:	83 ec 04             	sub    $0x4,%esp
  800d87:	68 5c 2a 80 00       	push   $0x802a5c
  800d8c:	6a 3a                	push   $0x3a
  800d8e:	68 50 2a 80 00       	push   $0x802a50
  800d93:	e8 9f fe ff ff       	call   800c37 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800d98:	ff 45 f0             	incl   -0x10(%ebp)
  800d9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d9e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800da1:	0f 8c 3e ff ff ff    	jl     800ce5 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800da7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dae:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800db5:	eb 20                	jmp    800dd7 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800db7:	a1 20 30 80 00       	mov    0x803020,%eax
  800dbc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800dc2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dc5:	c1 e2 04             	shl    $0x4,%edx
  800dc8:	01 d0                	add    %edx,%eax
  800dca:	8a 40 04             	mov    0x4(%eax),%al
  800dcd:	3c 01                	cmp    $0x1,%al
  800dcf:	75 03                	jne    800dd4 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800dd1:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dd4:	ff 45 e0             	incl   -0x20(%ebp)
  800dd7:	a1 20 30 80 00       	mov    0x803020,%eax
  800ddc:	8b 50 74             	mov    0x74(%eax),%edx
  800ddf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800de2:	39 c2                	cmp    %eax,%edx
  800de4:	77 d1                	ja     800db7 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800de9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800dec:	74 14                	je     800e02 <CheckWSWithoutLastIndex+0x159>
		panic(
  800dee:	83 ec 04             	sub    $0x4,%esp
  800df1:	68 b0 2a 80 00       	push   $0x802ab0
  800df6:	6a 44                	push   $0x44
  800df8:	68 50 2a 80 00       	push   $0x802a50
  800dfd:	e8 35 fe ff ff       	call   800c37 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800e02:	90                   	nop
  800e03:	c9                   	leave  
  800e04:	c3                   	ret    

00800e05 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800e05:	55                   	push   %ebp
  800e06:	89 e5                	mov    %esp,%ebp
  800e08:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800e0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0e:	8b 00                	mov    (%eax),%eax
  800e10:	8d 48 01             	lea    0x1(%eax),%ecx
  800e13:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e16:	89 0a                	mov    %ecx,(%edx)
  800e18:	8b 55 08             	mov    0x8(%ebp),%edx
  800e1b:	88 d1                	mov    %dl,%cl
  800e1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e20:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800e24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e27:	8b 00                	mov    (%eax),%eax
  800e29:	3d ff 00 00 00       	cmp    $0xff,%eax
  800e2e:	75 2c                	jne    800e5c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800e30:	a0 24 30 80 00       	mov    0x803024,%al
  800e35:	0f b6 c0             	movzbl %al,%eax
  800e38:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e3b:	8b 12                	mov    (%edx),%edx
  800e3d:	89 d1                	mov    %edx,%ecx
  800e3f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e42:	83 c2 08             	add    $0x8,%edx
  800e45:	83 ec 04             	sub    $0x4,%esp
  800e48:	50                   	push   %eax
  800e49:	51                   	push   %ecx
  800e4a:	52                   	push   %edx
  800e4b:	e8 25 11 00 00       	call   801f75 <sys_cputs>
  800e50:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800e53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e56:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800e5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5f:	8b 40 04             	mov    0x4(%eax),%eax
  800e62:	8d 50 01             	lea    0x1(%eax),%edx
  800e65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e68:	89 50 04             	mov    %edx,0x4(%eax)
}
  800e6b:	90                   	nop
  800e6c:	c9                   	leave  
  800e6d:	c3                   	ret    

00800e6e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800e6e:	55                   	push   %ebp
  800e6f:	89 e5                	mov    %esp,%ebp
  800e71:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800e77:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800e7e:	00 00 00 
	b.cnt = 0;
  800e81:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800e88:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800e8b:	ff 75 0c             	pushl  0xc(%ebp)
  800e8e:	ff 75 08             	pushl  0x8(%ebp)
  800e91:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800e97:	50                   	push   %eax
  800e98:	68 05 0e 80 00       	push   $0x800e05
  800e9d:	e8 11 02 00 00       	call   8010b3 <vprintfmt>
  800ea2:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800ea5:	a0 24 30 80 00       	mov    0x803024,%al
  800eaa:	0f b6 c0             	movzbl %al,%eax
  800ead:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800eb3:	83 ec 04             	sub    $0x4,%esp
  800eb6:	50                   	push   %eax
  800eb7:	52                   	push   %edx
  800eb8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ebe:	83 c0 08             	add    $0x8,%eax
  800ec1:	50                   	push   %eax
  800ec2:	e8 ae 10 00 00       	call   801f75 <sys_cputs>
  800ec7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800eca:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800ed1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800ed7:	c9                   	leave  
  800ed8:	c3                   	ret    

00800ed9 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ed9:	55                   	push   %ebp
  800eda:	89 e5                	mov    %esp,%ebp
  800edc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800edf:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800ee6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ee9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800eec:	8b 45 08             	mov    0x8(%ebp),%eax
  800eef:	83 ec 08             	sub    $0x8,%esp
  800ef2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ef5:	50                   	push   %eax
  800ef6:	e8 73 ff ff ff       	call   800e6e <vcprintf>
  800efb:	83 c4 10             	add    $0x10,%esp
  800efe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800f01:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f04:	c9                   	leave  
  800f05:	c3                   	ret    

00800f06 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800f06:	55                   	push   %ebp
  800f07:	89 e5                	mov    %esp,%ebp
  800f09:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800f0c:	e8 75 12 00 00       	call   802186 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800f11:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f14:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	83 ec 08             	sub    $0x8,%esp
  800f1d:	ff 75 f4             	pushl  -0xc(%ebp)
  800f20:	50                   	push   %eax
  800f21:	e8 48 ff ff ff       	call   800e6e <vcprintf>
  800f26:	83 c4 10             	add    $0x10,%esp
  800f29:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800f2c:	e8 6f 12 00 00       	call   8021a0 <sys_enable_interrupt>
	return cnt;
  800f31:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f34:	c9                   	leave  
  800f35:	c3                   	ret    

00800f36 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800f36:	55                   	push   %ebp
  800f37:	89 e5                	mov    %esp,%ebp
  800f39:	53                   	push   %ebx
  800f3a:	83 ec 14             	sub    $0x14,%esp
  800f3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f43:	8b 45 14             	mov    0x14(%ebp),%eax
  800f46:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800f49:	8b 45 18             	mov    0x18(%ebp),%eax
  800f4c:	ba 00 00 00 00       	mov    $0x0,%edx
  800f51:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f54:	77 55                	ja     800fab <printnum+0x75>
  800f56:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f59:	72 05                	jb     800f60 <printnum+0x2a>
  800f5b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f5e:	77 4b                	ja     800fab <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800f60:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800f63:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800f66:	8b 45 18             	mov    0x18(%ebp),%eax
  800f69:	ba 00 00 00 00       	mov    $0x0,%edx
  800f6e:	52                   	push   %edx
  800f6f:	50                   	push   %eax
  800f70:	ff 75 f4             	pushl  -0xc(%ebp)
  800f73:	ff 75 f0             	pushl  -0x10(%ebp)
  800f76:	e8 2d 16 00 00       	call   8025a8 <__udivdi3>
  800f7b:	83 c4 10             	add    $0x10,%esp
  800f7e:	83 ec 04             	sub    $0x4,%esp
  800f81:	ff 75 20             	pushl  0x20(%ebp)
  800f84:	53                   	push   %ebx
  800f85:	ff 75 18             	pushl  0x18(%ebp)
  800f88:	52                   	push   %edx
  800f89:	50                   	push   %eax
  800f8a:	ff 75 0c             	pushl  0xc(%ebp)
  800f8d:	ff 75 08             	pushl  0x8(%ebp)
  800f90:	e8 a1 ff ff ff       	call   800f36 <printnum>
  800f95:	83 c4 20             	add    $0x20,%esp
  800f98:	eb 1a                	jmp    800fb4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800f9a:	83 ec 08             	sub    $0x8,%esp
  800f9d:	ff 75 0c             	pushl  0xc(%ebp)
  800fa0:	ff 75 20             	pushl  0x20(%ebp)
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	ff d0                	call   *%eax
  800fa8:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800fab:	ff 4d 1c             	decl   0x1c(%ebp)
  800fae:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800fb2:	7f e6                	jg     800f9a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800fb4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800fb7:	bb 00 00 00 00       	mov    $0x0,%ebx
  800fbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fbf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc2:	53                   	push   %ebx
  800fc3:	51                   	push   %ecx
  800fc4:	52                   	push   %edx
  800fc5:	50                   	push   %eax
  800fc6:	e8 ed 16 00 00       	call   8026b8 <__umoddi3>
  800fcb:	83 c4 10             	add    $0x10,%esp
  800fce:	05 14 2d 80 00       	add    $0x802d14,%eax
  800fd3:	8a 00                	mov    (%eax),%al
  800fd5:	0f be c0             	movsbl %al,%eax
  800fd8:	83 ec 08             	sub    $0x8,%esp
  800fdb:	ff 75 0c             	pushl  0xc(%ebp)
  800fde:	50                   	push   %eax
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe2:	ff d0                	call   *%eax
  800fe4:	83 c4 10             	add    $0x10,%esp
}
  800fe7:	90                   	nop
  800fe8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800feb:	c9                   	leave  
  800fec:	c3                   	ret    

00800fed <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800fed:	55                   	push   %ebp
  800fee:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ff0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ff4:	7e 1c                	jle    801012 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff9:	8b 00                	mov    (%eax),%eax
  800ffb:	8d 50 08             	lea    0x8(%eax),%edx
  800ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  801001:	89 10                	mov    %edx,(%eax)
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	8b 00                	mov    (%eax),%eax
  801008:	83 e8 08             	sub    $0x8,%eax
  80100b:	8b 50 04             	mov    0x4(%eax),%edx
  80100e:	8b 00                	mov    (%eax),%eax
  801010:	eb 40                	jmp    801052 <getuint+0x65>
	else if (lflag)
  801012:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801016:	74 1e                	je     801036 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801018:	8b 45 08             	mov    0x8(%ebp),%eax
  80101b:	8b 00                	mov    (%eax),%eax
  80101d:	8d 50 04             	lea    0x4(%eax),%edx
  801020:	8b 45 08             	mov    0x8(%ebp),%eax
  801023:	89 10                	mov    %edx,(%eax)
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	8b 00                	mov    (%eax),%eax
  80102a:	83 e8 04             	sub    $0x4,%eax
  80102d:	8b 00                	mov    (%eax),%eax
  80102f:	ba 00 00 00 00       	mov    $0x0,%edx
  801034:	eb 1c                	jmp    801052 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	8b 00                	mov    (%eax),%eax
  80103b:	8d 50 04             	lea    0x4(%eax),%edx
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	89 10                	mov    %edx,(%eax)
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	8b 00                	mov    (%eax),%eax
  801048:	83 e8 04             	sub    $0x4,%eax
  80104b:	8b 00                	mov    (%eax),%eax
  80104d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801052:	5d                   	pop    %ebp
  801053:	c3                   	ret    

00801054 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801054:	55                   	push   %ebp
  801055:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801057:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80105b:	7e 1c                	jle    801079 <getint+0x25>
		return va_arg(*ap, long long);
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	8b 00                	mov    (%eax),%eax
  801062:	8d 50 08             	lea    0x8(%eax),%edx
  801065:	8b 45 08             	mov    0x8(%ebp),%eax
  801068:	89 10                	mov    %edx,(%eax)
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	8b 00                	mov    (%eax),%eax
  80106f:	83 e8 08             	sub    $0x8,%eax
  801072:	8b 50 04             	mov    0x4(%eax),%edx
  801075:	8b 00                	mov    (%eax),%eax
  801077:	eb 38                	jmp    8010b1 <getint+0x5d>
	else if (lflag)
  801079:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80107d:	74 1a                	je     801099 <getint+0x45>
		return va_arg(*ap, long);
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8b 00                	mov    (%eax),%eax
  801084:	8d 50 04             	lea    0x4(%eax),%edx
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	89 10                	mov    %edx,(%eax)
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	8b 00                	mov    (%eax),%eax
  801091:	83 e8 04             	sub    $0x4,%eax
  801094:	8b 00                	mov    (%eax),%eax
  801096:	99                   	cltd   
  801097:	eb 18                	jmp    8010b1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	8b 00                	mov    (%eax),%eax
  80109e:	8d 50 04             	lea    0x4(%eax),%edx
  8010a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a4:	89 10                	mov    %edx,(%eax)
  8010a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a9:	8b 00                	mov    (%eax),%eax
  8010ab:	83 e8 04             	sub    $0x4,%eax
  8010ae:	8b 00                	mov    (%eax),%eax
  8010b0:	99                   	cltd   
}
  8010b1:	5d                   	pop    %ebp
  8010b2:	c3                   	ret    

008010b3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8010b3:	55                   	push   %ebp
  8010b4:	89 e5                	mov    %esp,%ebp
  8010b6:	56                   	push   %esi
  8010b7:	53                   	push   %ebx
  8010b8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8010bb:	eb 17                	jmp    8010d4 <vprintfmt+0x21>
			if (ch == '\0')
  8010bd:	85 db                	test   %ebx,%ebx
  8010bf:	0f 84 af 03 00 00    	je     801474 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8010c5:	83 ec 08             	sub    $0x8,%esp
  8010c8:	ff 75 0c             	pushl  0xc(%ebp)
  8010cb:	53                   	push   %ebx
  8010cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cf:	ff d0                	call   *%eax
  8010d1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8010d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d7:	8d 50 01             	lea    0x1(%eax),%edx
  8010da:	89 55 10             	mov    %edx,0x10(%ebp)
  8010dd:	8a 00                	mov    (%eax),%al
  8010df:	0f b6 d8             	movzbl %al,%ebx
  8010e2:	83 fb 25             	cmp    $0x25,%ebx
  8010e5:	75 d6                	jne    8010bd <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8010e7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8010eb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8010f2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8010f9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801100:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801107:	8b 45 10             	mov    0x10(%ebp),%eax
  80110a:	8d 50 01             	lea    0x1(%eax),%edx
  80110d:	89 55 10             	mov    %edx,0x10(%ebp)
  801110:	8a 00                	mov    (%eax),%al
  801112:	0f b6 d8             	movzbl %al,%ebx
  801115:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801118:	83 f8 55             	cmp    $0x55,%eax
  80111b:	0f 87 2b 03 00 00    	ja     80144c <vprintfmt+0x399>
  801121:	8b 04 85 38 2d 80 00 	mov    0x802d38(,%eax,4),%eax
  801128:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80112a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80112e:	eb d7                	jmp    801107 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801130:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801134:	eb d1                	jmp    801107 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801136:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80113d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801140:	89 d0                	mov    %edx,%eax
  801142:	c1 e0 02             	shl    $0x2,%eax
  801145:	01 d0                	add    %edx,%eax
  801147:	01 c0                	add    %eax,%eax
  801149:	01 d8                	add    %ebx,%eax
  80114b:	83 e8 30             	sub    $0x30,%eax
  80114e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801151:	8b 45 10             	mov    0x10(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801159:	83 fb 2f             	cmp    $0x2f,%ebx
  80115c:	7e 3e                	jle    80119c <vprintfmt+0xe9>
  80115e:	83 fb 39             	cmp    $0x39,%ebx
  801161:	7f 39                	jg     80119c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801163:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801166:	eb d5                	jmp    80113d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801168:	8b 45 14             	mov    0x14(%ebp),%eax
  80116b:	83 c0 04             	add    $0x4,%eax
  80116e:	89 45 14             	mov    %eax,0x14(%ebp)
  801171:	8b 45 14             	mov    0x14(%ebp),%eax
  801174:	83 e8 04             	sub    $0x4,%eax
  801177:	8b 00                	mov    (%eax),%eax
  801179:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80117c:	eb 1f                	jmp    80119d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80117e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801182:	79 83                	jns    801107 <vprintfmt+0x54>
				width = 0;
  801184:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80118b:	e9 77 ff ff ff       	jmp    801107 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801190:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801197:	e9 6b ff ff ff       	jmp    801107 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80119c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80119d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011a1:	0f 89 60 ff ff ff    	jns    801107 <vprintfmt+0x54>
				width = precision, precision = -1;
  8011a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8011aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8011ad:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8011b4:	e9 4e ff ff ff       	jmp    801107 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8011b9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8011bc:	e9 46 ff ff ff       	jmp    801107 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8011c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c4:	83 c0 04             	add    $0x4,%eax
  8011c7:	89 45 14             	mov    %eax,0x14(%ebp)
  8011ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cd:	83 e8 04             	sub    $0x4,%eax
  8011d0:	8b 00                	mov    (%eax),%eax
  8011d2:	83 ec 08             	sub    $0x8,%esp
  8011d5:	ff 75 0c             	pushl  0xc(%ebp)
  8011d8:	50                   	push   %eax
  8011d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dc:	ff d0                	call   *%eax
  8011de:	83 c4 10             	add    $0x10,%esp
			break;
  8011e1:	e9 89 02 00 00       	jmp    80146f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8011e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e9:	83 c0 04             	add    $0x4,%eax
  8011ec:	89 45 14             	mov    %eax,0x14(%ebp)
  8011ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f2:	83 e8 04             	sub    $0x4,%eax
  8011f5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8011f7:	85 db                	test   %ebx,%ebx
  8011f9:	79 02                	jns    8011fd <vprintfmt+0x14a>
				err = -err;
  8011fb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8011fd:	83 fb 64             	cmp    $0x64,%ebx
  801200:	7f 0b                	jg     80120d <vprintfmt+0x15a>
  801202:	8b 34 9d 80 2b 80 00 	mov    0x802b80(,%ebx,4),%esi
  801209:	85 f6                	test   %esi,%esi
  80120b:	75 19                	jne    801226 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80120d:	53                   	push   %ebx
  80120e:	68 25 2d 80 00       	push   $0x802d25
  801213:	ff 75 0c             	pushl  0xc(%ebp)
  801216:	ff 75 08             	pushl  0x8(%ebp)
  801219:	e8 5e 02 00 00       	call   80147c <printfmt>
  80121e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801221:	e9 49 02 00 00       	jmp    80146f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801226:	56                   	push   %esi
  801227:	68 2e 2d 80 00       	push   $0x802d2e
  80122c:	ff 75 0c             	pushl  0xc(%ebp)
  80122f:	ff 75 08             	pushl  0x8(%ebp)
  801232:	e8 45 02 00 00       	call   80147c <printfmt>
  801237:	83 c4 10             	add    $0x10,%esp
			break;
  80123a:	e9 30 02 00 00       	jmp    80146f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80123f:	8b 45 14             	mov    0x14(%ebp),%eax
  801242:	83 c0 04             	add    $0x4,%eax
  801245:	89 45 14             	mov    %eax,0x14(%ebp)
  801248:	8b 45 14             	mov    0x14(%ebp),%eax
  80124b:	83 e8 04             	sub    $0x4,%eax
  80124e:	8b 30                	mov    (%eax),%esi
  801250:	85 f6                	test   %esi,%esi
  801252:	75 05                	jne    801259 <vprintfmt+0x1a6>
				p = "(null)";
  801254:	be 31 2d 80 00       	mov    $0x802d31,%esi
			if (width > 0 && padc != '-')
  801259:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80125d:	7e 6d                	jle    8012cc <vprintfmt+0x219>
  80125f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801263:	74 67                	je     8012cc <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801265:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801268:	83 ec 08             	sub    $0x8,%esp
  80126b:	50                   	push   %eax
  80126c:	56                   	push   %esi
  80126d:	e8 0c 03 00 00       	call   80157e <strnlen>
  801272:	83 c4 10             	add    $0x10,%esp
  801275:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801278:	eb 16                	jmp    801290 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80127a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80127e:	83 ec 08             	sub    $0x8,%esp
  801281:	ff 75 0c             	pushl  0xc(%ebp)
  801284:	50                   	push   %eax
  801285:	8b 45 08             	mov    0x8(%ebp),%eax
  801288:	ff d0                	call   *%eax
  80128a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80128d:	ff 4d e4             	decl   -0x1c(%ebp)
  801290:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801294:	7f e4                	jg     80127a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801296:	eb 34                	jmp    8012cc <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801298:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80129c:	74 1c                	je     8012ba <vprintfmt+0x207>
  80129e:	83 fb 1f             	cmp    $0x1f,%ebx
  8012a1:	7e 05                	jle    8012a8 <vprintfmt+0x1f5>
  8012a3:	83 fb 7e             	cmp    $0x7e,%ebx
  8012a6:	7e 12                	jle    8012ba <vprintfmt+0x207>
					putch('?', putdat);
  8012a8:	83 ec 08             	sub    $0x8,%esp
  8012ab:	ff 75 0c             	pushl  0xc(%ebp)
  8012ae:	6a 3f                	push   $0x3f
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	ff d0                	call   *%eax
  8012b5:	83 c4 10             	add    $0x10,%esp
  8012b8:	eb 0f                	jmp    8012c9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8012ba:	83 ec 08             	sub    $0x8,%esp
  8012bd:	ff 75 0c             	pushl  0xc(%ebp)
  8012c0:	53                   	push   %ebx
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	ff d0                	call   *%eax
  8012c6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8012c9:	ff 4d e4             	decl   -0x1c(%ebp)
  8012cc:	89 f0                	mov    %esi,%eax
  8012ce:	8d 70 01             	lea    0x1(%eax),%esi
  8012d1:	8a 00                	mov    (%eax),%al
  8012d3:	0f be d8             	movsbl %al,%ebx
  8012d6:	85 db                	test   %ebx,%ebx
  8012d8:	74 24                	je     8012fe <vprintfmt+0x24b>
  8012da:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8012de:	78 b8                	js     801298 <vprintfmt+0x1e5>
  8012e0:	ff 4d e0             	decl   -0x20(%ebp)
  8012e3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8012e7:	79 af                	jns    801298 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8012e9:	eb 13                	jmp    8012fe <vprintfmt+0x24b>
				putch(' ', putdat);
  8012eb:	83 ec 08             	sub    $0x8,%esp
  8012ee:	ff 75 0c             	pushl  0xc(%ebp)
  8012f1:	6a 20                	push   $0x20
  8012f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f6:	ff d0                	call   *%eax
  8012f8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8012fb:	ff 4d e4             	decl   -0x1c(%ebp)
  8012fe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801302:	7f e7                	jg     8012eb <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801304:	e9 66 01 00 00       	jmp    80146f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801309:	83 ec 08             	sub    $0x8,%esp
  80130c:	ff 75 e8             	pushl  -0x18(%ebp)
  80130f:	8d 45 14             	lea    0x14(%ebp),%eax
  801312:	50                   	push   %eax
  801313:	e8 3c fd ff ff       	call   801054 <getint>
  801318:	83 c4 10             	add    $0x10,%esp
  80131b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80131e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801321:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801324:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801327:	85 d2                	test   %edx,%edx
  801329:	79 23                	jns    80134e <vprintfmt+0x29b>
				putch('-', putdat);
  80132b:	83 ec 08             	sub    $0x8,%esp
  80132e:	ff 75 0c             	pushl  0xc(%ebp)
  801331:	6a 2d                	push   $0x2d
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
  801336:	ff d0                	call   *%eax
  801338:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80133b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80133e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801341:	f7 d8                	neg    %eax
  801343:	83 d2 00             	adc    $0x0,%edx
  801346:	f7 da                	neg    %edx
  801348:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80134b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80134e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801355:	e9 bc 00 00 00       	jmp    801416 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80135a:	83 ec 08             	sub    $0x8,%esp
  80135d:	ff 75 e8             	pushl  -0x18(%ebp)
  801360:	8d 45 14             	lea    0x14(%ebp),%eax
  801363:	50                   	push   %eax
  801364:	e8 84 fc ff ff       	call   800fed <getuint>
  801369:	83 c4 10             	add    $0x10,%esp
  80136c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80136f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801372:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801379:	e9 98 00 00 00       	jmp    801416 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80137e:	83 ec 08             	sub    $0x8,%esp
  801381:	ff 75 0c             	pushl  0xc(%ebp)
  801384:	6a 58                	push   $0x58
  801386:	8b 45 08             	mov    0x8(%ebp),%eax
  801389:	ff d0                	call   *%eax
  80138b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80138e:	83 ec 08             	sub    $0x8,%esp
  801391:	ff 75 0c             	pushl  0xc(%ebp)
  801394:	6a 58                	push   $0x58
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	ff d0                	call   *%eax
  80139b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80139e:	83 ec 08             	sub    $0x8,%esp
  8013a1:	ff 75 0c             	pushl  0xc(%ebp)
  8013a4:	6a 58                	push   $0x58
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	ff d0                	call   *%eax
  8013ab:	83 c4 10             	add    $0x10,%esp
			break;
  8013ae:	e9 bc 00 00 00       	jmp    80146f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8013b3:	83 ec 08             	sub    $0x8,%esp
  8013b6:	ff 75 0c             	pushl  0xc(%ebp)
  8013b9:	6a 30                	push   $0x30
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	ff d0                	call   *%eax
  8013c0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8013c3:	83 ec 08             	sub    $0x8,%esp
  8013c6:	ff 75 0c             	pushl  0xc(%ebp)
  8013c9:	6a 78                	push   $0x78
  8013cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ce:	ff d0                	call   *%eax
  8013d0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8013d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d6:	83 c0 04             	add    $0x4,%eax
  8013d9:	89 45 14             	mov    %eax,0x14(%ebp)
  8013dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8013df:	83 e8 04             	sub    $0x4,%eax
  8013e2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8013e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8013ee:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8013f5:	eb 1f                	jmp    801416 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8013f7:	83 ec 08             	sub    $0x8,%esp
  8013fa:	ff 75 e8             	pushl  -0x18(%ebp)
  8013fd:	8d 45 14             	lea    0x14(%ebp),%eax
  801400:	50                   	push   %eax
  801401:	e8 e7 fb ff ff       	call   800fed <getuint>
  801406:	83 c4 10             	add    $0x10,%esp
  801409:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80140c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80140f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801416:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80141a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80141d:	83 ec 04             	sub    $0x4,%esp
  801420:	52                   	push   %edx
  801421:	ff 75 e4             	pushl  -0x1c(%ebp)
  801424:	50                   	push   %eax
  801425:	ff 75 f4             	pushl  -0xc(%ebp)
  801428:	ff 75 f0             	pushl  -0x10(%ebp)
  80142b:	ff 75 0c             	pushl  0xc(%ebp)
  80142e:	ff 75 08             	pushl  0x8(%ebp)
  801431:	e8 00 fb ff ff       	call   800f36 <printnum>
  801436:	83 c4 20             	add    $0x20,%esp
			break;
  801439:	eb 34                	jmp    80146f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80143b:	83 ec 08             	sub    $0x8,%esp
  80143e:	ff 75 0c             	pushl  0xc(%ebp)
  801441:	53                   	push   %ebx
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	ff d0                	call   *%eax
  801447:	83 c4 10             	add    $0x10,%esp
			break;
  80144a:	eb 23                	jmp    80146f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80144c:	83 ec 08             	sub    $0x8,%esp
  80144f:	ff 75 0c             	pushl  0xc(%ebp)
  801452:	6a 25                	push   $0x25
  801454:	8b 45 08             	mov    0x8(%ebp),%eax
  801457:	ff d0                	call   *%eax
  801459:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80145c:	ff 4d 10             	decl   0x10(%ebp)
  80145f:	eb 03                	jmp    801464 <vprintfmt+0x3b1>
  801461:	ff 4d 10             	decl   0x10(%ebp)
  801464:	8b 45 10             	mov    0x10(%ebp),%eax
  801467:	48                   	dec    %eax
  801468:	8a 00                	mov    (%eax),%al
  80146a:	3c 25                	cmp    $0x25,%al
  80146c:	75 f3                	jne    801461 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80146e:	90                   	nop
		}
	}
  80146f:	e9 47 fc ff ff       	jmp    8010bb <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801474:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801475:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801478:	5b                   	pop    %ebx
  801479:	5e                   	pop    %esi
  80147a:	5d                   	pop    %ebp
  80147b:	c3                   	ret    

0080147c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80147c:	55                   	push   %ebp
  80147d:	89 e5                	mov    %esp,%ebp
  80147f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801482:	8d 45 10             	lea    0x10(%ebp),%eax
  801485:	83 c0 04             	add    $0x4,%eax
  801488:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80148b:	8b 45 10             	mov    0x10(%ebp),%eax
  80148e:	ff 75 f4             	pushl  -0xc(%ebp)
  801491:	50                   	push   %eax
  801492:	ff 75 0c             	pushl  0xc(%ebp)
  801495:	ff 75 08             	pushl  0x8(%ebp)
  801498:	e8 16 fc ff ff       	call   8010b3 <vprintfmt>
  80149d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8014a0:	90                   	nop
  8014a1:	c9                   	leave  
  8014a2:	c3                   	ret    

008014a3 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8014a3:	55                   	push   %ebp
  8014a4:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8014a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a9:	8b 40 08             	mov    0x8(%eax),%eax
  8014ac:	8d 50 01             	lea    0x1(%eax),%edx
  8014af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8014b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b8:	8b 10                	mov    (%eax),%edx
  8014ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bd:	8b 40 04             	mov    0x4(%eax),%eax
  8014c0:	39 c2                	cmp    %eax,%edx
  8014c2:	73 12                	jae    8014d6 <sprintputch+0x33>
		*b->buf++ = ch;
  8014c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c7:	8b 00                	mov    (%eax),%eax
  8014c9:	8d 48 01             	lea    0x1(%eax),%ecx
  8014cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014cf:	89 0a                	mov    %ecx,(%edx)
  8014d1:	8b 55 08             	mov    0x8(%ebp),%edx
  8014d4:	88 10                	mov    %dl,(%eax)
}
  8014d6:	90                   	nop
  8014d7:	5d                   	pop    %ebp
  8014d8:	c3                   	ret    

008014d9 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8014d9:	55                   	push   %ebp
  8014da:	89 e5                	mov    %esp,%ebp
  8014dc:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8014df:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8014e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ee:	01 d0                	add    %edx,%eax
  8014f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8014fa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014fe:	74 06                	je     801506 <vsnprintf+0x2d>
  801500:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801504:	7f 07                	jg     80150d <vsnprintf+0x34>
		return -E_INVAL;
  801506:	b8 03 00 00 00       	mov    $0x3,%eax
  80150b:	eb 20                	jmp    80152d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80150d:	ff 75 14             	pushl  0x14(%ebp)
  801510:	ff 75 10             	pushl  0x10(%ebp)
  801513:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801516:	50                   	push   %eax
  801517:	68 a3 14 80 00       	push   $0x8014a3
  80151c:	e8 92 fb ff ff       	call   8010b3 <vprintfmt>
  801521:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801524:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801527:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80152a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80152d:	c9                   	leave  
  80152e:	c3                   	ret    

0080152f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80152f:	55                   	push   %ebp
  801530:	89 e5                	mov    %esp,%ebp
  801532:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801535:	8d 45 10             	lea    0x10(%ebp),%eax
  801538:	83 c0 04             	add    $0x4,%eax
  80153b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80153e:	8b 45 10             	mov    0x10(%ebp),%eax
  801541:	ff 75 f4             	pushl  -0xc(%ebp)
  801544:	50                   	push   %eax
  801545:	ff 75 0c             	pushl  0xc(%ebp)
  801548:	ff 75 08             	pushl  0x8(%ebp)
  80154b:	e8 89 ff ff ff       	call   8014d9 <vsnprintf>
  801550:	83 c4 10             	add    $0x10,%esp
  801553:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801556:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
  80155e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801561:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801568:	eb 06                	jmp    801570 <strlen+0x15>
		n++;
  80156a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80156d:	ff 45 08             	incl   0x8(%ebp)
  801570:	8b 45 08             	mov    0x8(%ebp),%eax
  801573:	8a 00                	mov    (%eax),%al
  801575:	84 c0                	test   %al,%al
  801577:	75 f1                	jne    80156a <strlen+0xf>
		n++;
	return n;
  801579:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
  801581:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801584:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80158b:	eb 09                	jmp    801596 <strnlen+0x18>
		n++;
  80158d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801590:	ff 45 08             	incl   0x8(%ebp)
  801593:	ff 4d 0c             	decl   0xc(%ebp)
  801596:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80159a:	74 09                	je     8015a5 <strnlen+0x27>
  80159c:	8b 45 08             	mov    0x8(%ebp),%eax
  80159f:	8a 00                	mov    (%eax),%al
  8015a1:	84 c0                	test   %al,%al
  8015a3:	75 e8                	jne    80158d <strnlen+0xf>
		n++;
	return n;
  8015a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
  8015ad:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8015b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8015b6:	90                   	nop
  8015b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ba:	8d 50 01             	lea    0x1(%eax),%edx
  8015bd:	89 55 08             	mov    %edx,0x8(%ebp)
  8015c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015c6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8015c9:	8a 12                	mov    (%edx),%dl
  8015cb:	88 10                	mov    %dl,(%eax)
  8015cd:	8a 00                	mov    (%eax),%al
  8015cf:	84 c0                	test   %al,%al
  8015d1:	75 e4                	jne    8015b7 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8015d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015d6:	c9                   	leave  
  8015d7:	c3                   	ret    

008015d8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8015d8:	55                   	push   %ebp
  8015d9:	89 e5                	mov    %esp,%ebp
  8015db:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8015de:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8015e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015eb:	eb 1f                	jmp    80160c <strncpy+0x34>
		*dst++ = *src;
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	8d 50 01             	lea    0x1(%eax),%edx
  8015f3:	89 55 08             	mov    %edx,0x8(%ebp)
  8015f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f9:	8a 12                	mov    (%edx),%dl
  8015fb:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8015fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801600:	8a 00                	mov    (%eax),%al
  801602:	84 c0                	test   %al,%al
  801604:	74 03                	je     801609 <strncpy+0x31>
			src++;
  801606:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801609:	ff 45 fc             	incl   -0x4(%ebp)
  80160c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80160f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801612:	72 d9                	jb     8015ed <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801614:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
  80161c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801625:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801629:	74 30                	je     80165b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80162b:	eb 16                	jmp    801643 <strlcpy+0x2a>
			*dst++ = *src++;
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	8d 50 01             	lea    0x1(%eax),%edx
  801633:	89 55 08             	mov    %edx,0x8(%ebp)
  801636:	8b 55 0c             	mov    0xc(%ebp),%edx
  801639:	8d 4a 01             	lea    0x1(%edx),%ecx
  80163c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80163f:	8a 12                	mov    (%edx),%dl
  801641:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801643:	ff 4d 10             	decl   0x10(%ebp)
  801646:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80164a:	74 09                	je     801655 <strlcpy+0x3c>
  80164c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164f:	8a 00                	mov    (%eax),%al
  801651:	84 c0                	test   %al,%al
  801653:	75 d8                	jne    80162d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801655:	8b 45 08             	mov    0x8(%ebp),%eax
  801658:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80165b:	8b 55 08             	mov    0x8(%ebp),%edx
  80165e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801661:	29 c2                	sub    %eax,%edx
  801663:	89 d0                	mov    %edx,%eax
}
  801665:	c9                   	leave  
  801666:	c3                   	ret    

00801667 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801667:	55                   	push   %ebp
  801668:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80166a:	eb 06                	jmp    801672 <strcmp+0xb>
		p++, q++;
  80166c:	ff 45 08             	incl   0x8(%ebp)
  80166f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
  801675:	8a 00                	mov    (%eax),%al
  801677:	84 c0                	test   %al,%al
  801679:	74 0e                	je     801689 <strcmp+0x22>
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	8a 10                	mov    (%eax),%dl
  801680:	8b 45 0c             	mov    0xc(%ebp),%eax
  801683:	8a 00                	mov    (%eax),%al
  801685:	38 c2                	cmp    %al,%dl
  801687:	74 e3                	je     80166c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801689:	8b 45 08             	mov    0x8(%ebp),%eax
  80168c:	8a 00                	mov    (%eax),%al
  80168e:	0f b6 d0             	movzbl %al,%edx
  801691:	8b 45 0c             	mov    0xc(%ebp),%eax
  801694:	8a 00                	mov    (%eax),%al
  801696:	0f b6 c0             	movzbl %al,%eax
  801699:	29 c2                	sub    %eax,%edx
  80169b:	89 d0                	mov    %edx,%eax
}
  80169d:	5d                   	pop    %ebp
  80169e:	c3                   	ret    

0080169f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80169f:	55                   	push   %ebp
  8016a0:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8016a2:	eb 09                	jmp    8016ad <strncmp+0xe>
		n--, p++, q++;
  8016a4:	ff 4d 10             	decl   0x10(%ebp)
  8016a7:	ff 45 08             	incl   0x8(%ebp)
  8016aa:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8016ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016b1:	74 17                	je     8016ca <strncmp+0x2b>
  8016b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b6:	8a 00                	mov    (%eax),%al
  8016b8:	84 c0                	test   %al,%al
  8016ba:	74 0e                	je     8016ca <strncmp+0x2b>
  8016bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bf:	8a 10                	mov    (%eax),%dl
  8016c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c4:	8a 00                	mov    (%eax),%al
  8016c6:	38 c2                	cmp    %al,%dl
  8016c8:	74 da                	je     8016a4 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8016ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016ce:	75 07                	jne    8016d7 <strncmp+0x38>
		return 0;
  8016d0:	b8 00 00 00 00       	mov    $0x0,%eax
  8016d5:	eb 14                	jmp    8016eb <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	8a 00                	mov    (%eax),%al
  8016dc:	0f b6 d0             	movzbl %al,%edx
  8016df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e2:	8a 00                	mov    (%eax),%al
  8016e4:	0f b6 c0             	movzbl %al,%eax
  8016e7:	29 c2                	sub    %eax,%edx
  8016e9:	89 d0                	mov    %edx,%eax
}
  8016eb:	5d                   	pop    %ebp
  8016ec:	c3                   	ret    

008016ed <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8016ed:	55                   	push   %ebp
  8016ee:	89 e5                	mov    %esp,%ebp
  8016f0:	83 ec 04             	sub    $0x4,%esp
  8016f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8016f9:	eb 12                	jmp    80170d <strchr+0x20>
		if (*s == c)
  8016fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fe:	8a 00                	mov    (%eax),%al
  801700:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801703:	75 05                	jne    80170a <strchr+0x1d>
			return (char *) s;
  801705:	8b 45 08             	mov    0x8(%ebp),%eax
  801708:	eb 11                	jmp    80171b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80170a:	ff 45 08             	incl   0x8(%ebp)
  80170d:	8b 45 08             	mov    0x8(%ebp),%eax
  801710:	8a 00                	mov    (%eax),%al
  801712:	84 c0                	test   %al,%al
  801714:	75 e5                	jne    8016fb <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801716:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80171b:	c9                   	leave  
  80171c:	c3                   	ret    

0080171d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80171d:	55                   	push   %ebp
  80171e:	89 e5                	mov    %esp,%ebp
  801720:	83 ec 04             	sub    $0x4,%esp
  801723:	8b 45 0c             	mov    0xc(%ebp),%eax
  801726:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801729:	eb 0d                	jmp    801738 <strfind+0x1b>
		if (*s == c)
  80172b:	8b 45 08             	mov    0x8(%ebp),%eax
  80172e:	8a 00                	mov    (%eax),%al
  801730:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801733:	74 0e                	je     801743 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801735:	ff 45 08             	incl   0x8(%ebp)
  801738:	8b 45 08             	mov    0x8(%ebp),%eax
  80173b:	8a 00                	mov    (%eax),%al
  80173d:	84 c0                	test   %al,%al
  80173f:	75 ea                	jne    80172b <strfind+0xe>
  801741:	eb 01                	jmp    801744 <strfind+0x27>
		if (*s == c)
			break;
  801743:	90                   	nop
	return (char *) s;
  801744:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
  80174c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80174f:	8b 45 08             	mov    0x8(%ebp),%eax
  801752:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801755:	8b 45 10             	mov    0x10(%ebp),%eax
  801758:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80175b:	eb 0e                	jmp    80176b <memset+0x22>
		*p++ = c;
  80175d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801760:	8d 50 01             	lea    0x1(%eax),%edx
  801763:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801766:	8b 55 0c             	mov    0xc(%ebp),%edx
  801769:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80176b:	ff 4d f8             	decl   -0x8(%ebp)
  80176e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801772:	79 e9                	jns    80175d <memset+0x14>
		*p++ = c;

	return v;
  801774:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801777:	c9                   	leave  
  801778:	c3                   	ret    

00801779 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801779:	55                   	push   %ebp
  80177a:	89 e5                	mov    %esp,%ebp
  80177c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80177f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801782:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801785:	8b 45 08             	mov    0x8(%ebp),%eax
  801788:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80178b:	eb 16                	jmp    8017a3 <memcpy+0x2a>
		*d++ = *s++;
  80178d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801790:	8d 50 01             	lea    0x1(%eax),%edx
  801793:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801796:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801799:	8d 4a 01             	lea    0x1(%edx),%ecx
  80179c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80179f:	8a 12                	mov    (%edx),%dl
  8017a1:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8017a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017a6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017a9:	89 55 10             	mov    %edx,0x10(%ebp)
  8017ac:	85 c0                	test   %eax,%eax
  8017ae:	75 dd                	jne    80178d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8017b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017b3:	c9                   	leave  
  8017b4:	c3                   	ret    

008017b5 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8017b5:	55                   	push   %ebp
  8017b6:	89 e5                	mov    %esp,%ebp
  8017b8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8017bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017be:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8017c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8017c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8017cd:	73 50                	jae    80181f <memmove+0x6a>
  8017cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d5:	01 d0                	add    %edx,%eax
  8017d7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8017da:	76 43                	jbe    80181f <memmove+0x6a>
		s += n;
  8017dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8017df:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8017e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8017e5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8017e8:	eb 10                	jmp    8017fa <memmove+0x45>
			*--d = *--s;
  8017ea:	ff 4d f8             	decl   -0x8(%ebp)
  8017ed:	ff 4d fc             	decl   -0x4(%ebp)
  8017f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017f3:	8a 10                	mov    (%eax),%dl
  8017f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017f8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8017fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8017fd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801800:	89 55 10             	mov    %edx,0x10(%ebp)
  801803:	85 c0                	test   %eax,%eax
  801805:	75 e3                	jne    8017ea <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801807:	eb 23                	jmp    80182c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801809:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80180c:	8d 50 01             	lea    0x1(%eax),%edx
  80180f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801812:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801815:	8d 4a 01             	lea    0x1(%edx),%ecx
  801818:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80181b:	8a 12                	mov    (%edx),%dl
  80181d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80181f:	8b 45 10             	mov    0x10(%ebp),%eax
  801822:	8d 50 ff             	lea    -0x1(%eax),%edx
  801825:	89 55 10             	mov    %edx,0x10(%ebp)
  801828:	85 c0                	test   %eax,%eax
  80182a:	75 dd                	jne    801809 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80182f:	c9                   	leave  
  801830:	c3                   	ret    

00801831 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801831:	55                   	push   %ebp
  801832:	89 e5                	mov    %esp,%ebp
  801834:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801837:	8b 45 08             	mov    0x8(%ebp),%eax
  80183a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80183d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801840:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801843:	eb 2a                	jmp    80186f <memcmp+0x3e>
		if (*s1 != *s2)
  801845:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801848:	8a 10                	mov    (%eax),%dl
  80184a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80184d:	8a 00                	mov    (%eax),%al
  80184f:	38 c2                	cmp    %al,%dl
  801851:	74 16                	je     801869 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801853:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801856:	8a 00                	mov    (%eax),%al
  801858:	0f b6 d0             	movzbl %al,%edx
  80185b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80185e:	8a 00                	mov    (%eax),%al
  801860:	0f b6 c0             	movzbl %al,%eax
  801863:	29 c2                	sub    %eax,%edx
  801865:	89 d0                	mov    %edx,%eax
  801867:	eb 18                	jmp    801881 <memcmp+0x50>
		s1++, s2++;
  801869:	ff 45 fc             	incl   -0x4(%ebp)
  80186c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80186f:	8b 45 10             	mov    0x10(%ebp),%eax
  801872:	8d 50 ff             	lea    -0x1(%eax),%edx
  801875:	89 55 10             	mov    %edx,0x10(%ebp)
  801878:	85 c0                	test   %eax,%eax
  80187a:	75 c9                	jne    801845 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80187c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801881:	c9                   	leave  
  801882:	c3                   	ret    

00801883 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801883:	55                   	push   %ebp
  801884:	89 e5                	mov    %esp,%ebp
  801886:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801889:	8b 55 08             	mov    0x8(%ebp),%edx
  80188c:	8b 45 10             	mov    0x10(%ebp),%eax
  80188f:	01 d0                	add    %edx,%eax
  801891:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801894:	eb 15                	jmp    8018ab <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801896:	8b 45 08             	mov    0x8(%ebp),%eax
  801899:	8a 00                	mov    (%eax),%al
  80189b:	0f b6 d0             	movzbl %al,%edx
  80189e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a1:	0f b6 c0             	movzbl %al,%eax
  8018a4:	39 c2                	cmp    %eax,%edx
  8018a6:	74 0d                	je     8018b5 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8018a8:	ff 45 08             	incl   0x8(%ebp)
  8018ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ae:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8018b1:	72 e3                	jb     801896 <memfind+0x13>
  8018b3:	eb 01                	jmp    8018b6 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8018b5:	90                   	nop
	return (void *) s;
  8018b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018b9:	c9                   	leave  
  8018ba:	c3                   	ret    

008018bb <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8018bb:	55                   	push   %ebp
  8018bc:	89 e5                	mov    %esp,%ebp
  8018be:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8018c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8018c8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8018cf:	eb 03                	jmp    8018d4 <strtol+0x19>
		s++;
  8018d1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8018d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d7:	8a 00                	mov    (%eax),%al
  8018d9:	3c 20                	cmp    $0x20,%al
  8018db:	74 f4                	je     8018d1 <strtol+0x16>
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	8a 00                	mov    (%eax),%al
  8018e2:	3c 09                	cmp    $0x9,%al
  8018e4:	74 eb                	je     8018d1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8018e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e9:	8a 00                	mov    (%eax),%al
  8018eb:	3c 2b                	cmp    $0x2b,%al
  8018ed:	75 05                	jne    8018f4 <strtol+0x39>
		s++;
  8018ef:	ff 45 08             	incl   0x8(%ebp)
  8018f2:	eb 13                	jmp    801907 <strtol+0x4c>
	else if (*s == '-')
  8018f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f7:	8a 00                	mov    (%eax),%al
  8018f9:	3c 2d                	cmp    $0x2d,%al
  8018fb:	75 0a                	jne    801907 <strtol+0x4c>
		s++, neg = 1;
  8018fd:	ff 45 08             	incl   0x8(%ebp)
  801900:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801907:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80190b:	74 06                	je     801913 <strtol+0x58>
  80190d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801911:	75 20                	jne    801933 <strtol+0x78>
  801913:	8b 45 08             	mov    0x8(%ebp),%eax
  801916:	8a 00                	mov    (%eax),%al
  801918:	3c 30                	cmp    $0x30,%al
  80191a:	75 17                	jne    801933 <strtol+0x78>
  80191c:	8b 45 08             	mov    0x8(%ebp),%eax
  80191f:	40                   	inc    %eax
  801920:	8a 00                	mov    (%eax),%al
  801922:	3c 78                	cmp    $0x78,%al
  801924:	75 0d                	jne    801933 <strtol+0x78>
		s += 2, base = 16;
  801926:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80192a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801931:	eb 28                	jmp    80195b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801933:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801937:	75 15                	jne    80194e <strtol+0x93>
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	8a 00                	mov    (%eax),%al
  80193e:	3c 30                	cmp    $0x30,%al
  801940:	75 0c                	jne    80194e <strtol+0x93>
		s++, base = 8;
  801942:	ff 45 08             	incl   0x8(%ebp)
  801945:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80194c:	eb 0d                	jmp    80195b <strtol+0xa0>
	else if (base == 0)
  80194e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801952:	75 07                	jne    80195b <strtol+0xa0>
		base = 10;
  801954:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80195b:	8b 45 08             	mov    0x8(%ebp),%eax
  80195e:	8a 00                	mov    (%eax),%al
  801960:	3c 2f                	cmp    $0x2f,%al
  801962:	7e 19                	jle    80197d <strtol+0xc2>
  801964:	8b 45 08             	mov    0x8(%ebp),%eax
  801967:	8a 00                	mov    (%eax),%al
  801969:	3c 39                	cmp    $0x39,%al
  80196b:	7f 10                	jg     80197d <strtol+0xc2>
			dig = *s - '0';
  80196d:	8b 45 08             	mov    0x8(%ebp),%eax
  801970:	8a 00                	mov    (%eax),%al
  801972:	0f be c0             	movsbl %al,%eax
  801975:	83 e8 30             	sub    $0x30,%eax
  801978:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80197b:	eb 42                	jmp    8019bf <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80197d:	8b 45 08             	mov    0x8(%ebp),%eax
  801980:	8a 00                	mov    (%eax),%al
  801982:	3c 60                	cmp    $0x60,%al
  801984:	7e 19                	jle    80199f <strtol+0xe4>
  801986:	8b 45 08             	mov    0x8(%ebp),%eax
  801989:	8a 00                	mov    (%eax),%al
  80198b:	3c 7a                	cmp    $0x7a,%al
  80198d:	7f 10                	jg     80199f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80198f:	8b 45 08             	mov    0x8(%ebp),%eax
  801992:	8a 00                	mov    (%eax),%al
  801994:	0f be c0             	movsbl %al,%eax
  801997:	83 e8 57             	sub    $0x57,%eax
  80199a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80199d:	eb 20                	jmp    8019bf <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80199f:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a2:	8a 00                	mov    (%eax),%al
  8019a4:	3c 40                	cmp    $0x40,%al
  8019a6:	7e 39                	jle    8019e1 <strtol+0x126>
  8019a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ab:	8a 00                	mov    (%eax),%al
  8019ad:	3c 5a                	cmp    $0x5a,%al
  8019af:	7f 30                	jg     8019e1 <strtol+0x126>
			dig = *s - 'A' + 10;
  8019b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b4:	8a 00                	mov    (%eax),%al
  8019b6:	0f be c0             	movsbl %al,%eax
  8019b9:	83 e8 37             	sub    $0x37,%eax
  8019bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8019bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019c2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8019c5:	7d 19                	jge    8019e0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8019c7:	ff 45 08             	incl   0x8(%ebp)
  8019ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019cd:	0f af 45 10          	imul   0x10(%ebp),%eax
  8019d1:	89 c2                	mov    %eax,%edx
  8019d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019d6:	01 d0                	add    %edx,%eax
  8019d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8019db:	e9 7b ff ff ff       	jmp    80195b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8019e0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8019e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8019e5:	74 08                	je     8019ef <strtol+0x134>
		*endptr = (char *) s;
  8019e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ea:	8b 55 08             	mov    0x8(%ebp),%edx
  8019ed:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8019ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019f3:	74 07                	je     8019fc <strtol+0x141>
  8019f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019f8:	f7 d8                	neg    %eax
  8019fa:	eb 03                	jmp    8019ff <strtol+0x144>
  8019fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <ltostr>:

void
ltostr(long value, char *str)
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
  801a04:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801a07:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801a0e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801a15:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a19:	79 13                	jns    801a2e <ltostr+0x2d>
	{
		neg = 1;
  801a1b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801a22:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a25:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801a28:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801a2b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801a2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a31:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801a36:	99                   	cltd   
  801a37:	f7 f9                	idiv   %ecx
  801a39:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801a3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a3f:	8d 50 01             	lea    0x1(%eax),%edx
  801a42:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a45:	89 c2                	mov    %eax,%edx
  801a47:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a4a:	01 d0                	add    %edx,%eax
  801a4c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a4f:	83 c2 30             	add    $0x30,%edx
  801a52:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801a54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a57:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a5c:	f7 e9                	imul   %ecx
  801a5e:	c1 fa 02             	sar    $0x2,%edx
  801a61:	89 c8                	mov    %ecx,%eax
  801a63:	c1 f8 1f             	sar    $0x1f,%eax
  801a66:	29 c2                	sub    %eax,%edx
  801a68:	89 d0                	mov    %edx,%eax
  801a6a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801a6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a70:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a75:	f7 e9                	imul   %ecx
  801a77:	c1 fa 02             	sar    $0x2,%edx
  801a7a:	89 c8                	mov    %ecx,%eax
  801a7c:	c1 f8 1f             	sar    $0x1f,%eax
  801a7f:	29 c2                	sub    %eax,%edx
  801a81:	89 d0                	mov    %edx,%eax
  801a83:	c1 e0 02             	shl    $0x2,%eax
  801a86:	01 d0                	add    %edx,%eax
  801a88:	01 c0                	add    %eax,%eax
  801a8a:	29 c1                	sub    %eax,%ecx
  801a8c:	89 ca                	mov    %ecx,%edx
  801a8e:	85 d2                	test   %edx,%edx
  801a90:	75 9c                	jne    801a2e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801a92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801a99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a9c:	48                   	dec    %eax
  801a9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801aa0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801aa4:	74 3d                	je     801ae3 <ltostr+0xe2>
		start = 1 ;
  801aa6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801aad:	eb 34                	jmp    801ae3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801aaf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ab2:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ab5:	01 d0                	add    %edx,%eax
  801ab7:	8a 00                	mov    (%eax),%al
  801ab9:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801abc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801abf:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ac2:	01 c2                	add    %eax,%edx
  801ac4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801ac7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aca:	01 c8                	add    %ecx,%eax
  801acc:	8a 00                	mov    (%eax),%al
  801ace:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801ad0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801ad3:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ad6:	01 c2                	add    %eax,%edx
  801ad8:	8a 45 eb             	mov    -0x15(%ebp),%al
  801adb:	88 02                	mov    %al,(%edx)
		start++ ;
  801add:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801ae0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ae6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ae9:	7c c4                	jl     801aaf <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801aeb:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801aee:	8b 45 0c             	mov    0xc(%ebp),%eax
  801af1:	01 d0                	add    %edx,%eax
  801af3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801af6:	90                   	nop
  801af7:	c9                   	leave  
  801af8:	c3                   	ret    

00801af9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801af9:	55                   	push   %ebp
  801afa:	89 e5                	mov    %esp,%ebp
  801afc:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801aff:	ff 75 08             	pushl  0x8(%ebp)
  801b02:	e8 54 fa ff ff       	call   80155b <strlen>
  801b07:	83 c4 04             	add    $0x4,%esp
  801b0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801b0d:	ff 75 0c             	pushl  0xc(%ebp)
  801b10:	e8 46 fa ff ff       	call   80155b <strlen>
  801b15:	83 c4 04             	add    $0x4,%esp
  801b18:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801b1b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801b22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b29:	eb 17                	jmp    801b42 <strcconcat+0x49>
		final[s] = str1[s] ;
  801b2b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b2e:	8b 45 10             	mov    0x10(%ebp),%eax
  801b31:	01 c2                	add    %eax,%edx
  801b33:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b36:	8b 45 08             	mov    0x8(%ebp),%eax
  801b39:	01 c8                	add    %ecx,%eax
  801b3b:	8a 00                	mov    (%eax),%al
  801b3d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801b3f:	ff 45 fc             	incl   -0x4(%ebp)
  801b42:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b45:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b48:	7c e1                	jl     801b2b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801b4a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801b51:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801b58:	eb 1f                	jmp    801b79 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801b5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b5d:	8d 50 01             	lea    0x1(%eax),%edx
  801b60:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801b63:	89 c2                	mov    %eax,%edx
  801b65:	8b 45 10             	mov    0x10(%ebp),%eax
  801b68:	01 c2                	add    %eax,%edx
  801b6a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801b6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b70:	01 c8                	add    %ecx,%eax
  801b72:	8a 00                	mov    (%eax),%al
  801b74:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801b76:	ff 45 f8             	incl   -0x8(%ebp)
  801b79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b7c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b7f:	7c d9                	jl     801b5a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801b81:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b84:	8b 45 10             	mov    0x10(%ebp),%eax
  801b87:	01 d0                	add    %edx,%eax
  801b89:	c6 00 00             	movb   $0x0,(%eax)
}
  801b8c:	90                   	nop
  801b8d:	c9                   	leave  
  801b8e:	c3                   	ret    

00801b8f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801b8f:	55                   	push   %ebp
  801b90:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801b92:	8b 45 14             	mov    0x14(%ebp),%eax
  801b95:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801b9b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b9e:	8b 00                	mov    (%eax),%eax
  801ba0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ba7:	8b 45 10             	mov    0x10(%ebp),%eax
  801baa:	01 d0                	add    %edx,%eax
  801bac:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801bb2:	eb 0c                	jmp    801bc0 <strsplit+0x31>
			*string++ = 0;
  801bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb7:	8d 50 01             	lea    0x1(%eax),%edx
  801bba:	89 55 08             	mov    %edx,0x8(%ebp)
  801bbd:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc3:	8a 00                	mov    (%eax),%al
  801bc5:	84 c0                	test   %al,%al
  801bc7:	74 18                	je     801be1 <strsplit+0x52>
  801bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcc:	8a 00                	mov    (%eax),%al
  801bce:	0f be c0             	movsbl %al,%eax
  801bd1:	50                   	push   %eax
  801bd2:	ff 75 0c             	pushl  0xc(%ebp)
  801bd5:	e8 13 fb ff ff       	call   8016ed <strchr>
  801bda:	83 c4 08             	add    $0x8,%esp
  801bdd:	85 c0                	test   %eax,%eax
  801bdf:	75 d3                	jne    801bb4 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801be1:	8b 45 08             	mov    0x8(%ebp),%eax
  801be4:	8a 00                	mov    (%eax),%al
  801be6:	84 c0                	test   %al,%al
  801be8:	74 5a                	je     801c44 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801bea:	8b 45 14             	mov    0x14(%ebp),%eax
  801bed:	8b 00                	mov    (%eax),%eax
  801bef:	83 f8 0f             	cmp    $0xf,%eax
  801bf2:	75 07                	jne    801bfb <strsplit+0x6c>
		{
			return 0;
  801bf4:	b8 00 00 00 00       	mov    $0x0,%eax
  801bf9:	eb 66                	jmp    801c61 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801bfb:	8b 45 14             	mov    0x14(%ebp),%eax
  801bfe:	8b 00                	mov    (%eax),%eax
  801c00:	8d 48 01             	lea    0x1(%eax),%ecx
  801c03:	8b 55 14             	mov    0x14(%ebp),%edx
  801c06:	89 0a                	mov    %ecx,(%edx)
  801c08:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c0f:	8b 45 10             	mov    0x10(%ebp),%eax
  801c12:	01 c2                	add    %eax,%edx
  801c14:	8b 45 08             	mov    0x8(%ebp),%eax
  801c17:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c19:	eb 03                	jmp    801c1e <strsplit+0x8f>
			string++;
  801c1b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c21:	8a 00                	mov    (%eax),%al
  801c23:	84 c0                	test   %al,%al
  801c25:	74 8b                	je     801bb2 <strsplit+0x23>
  801c27:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2a:	8a 00                	mov    (%eax),%al
  801c2c:	0f be c0             	movsbl %al,%eax
  801c2f:	50                   	push   %eax
  801c30:	ff 75 0c             	pushl  0xc(%ebp)
  801c33:	e8 b5 fa ff ff       	call   8016ed <strchr>
  801c38:	83 c4 08             	add    $0x8,%esp
  801c3b:	85 c0                	test   %eax,%eax
  801c3d:	74 dc                	je     801c1b <strsplit+0x8c>
			string++;
	}
  801c3f:	e9 6e ff ff ff       	jmp    801bb2 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801c44:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801c45:	8b 45 14             	mov    0x14(%ebp),%eax
  801c48:	8b 00                	mov    (%eax),%eax
  801c4a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c51:	8b 45 10             	mov    0x10(%ebp),%eax
  801c54:	01 d0                	add    %edx,%eax
  801c56:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801c5c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801c61:	c9                   	leave  
  801c62:	c3                   	ret    

00801c63 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  801c63:	55                   	push   %ebp
  801c64:	89 e5                	mov    %esp,%ebp
  801c66:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801c69:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6c:	c1 e8 0c             	shr    $0xc,%eax
  801c6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801c72:	8b 45 08             	mov    0x8(%ebp),%eax
  801c75:	25 ff 0f 00 00       	and    $0xfff,%eax
  801c7a:	85 c0                	test   %eax,%eax
  801c7c:	74 03                	je     801c81 <malloc+0x1e>
			num++;
  801c7e:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801c81:	a1 04 30 80 00       	mov    0x803004,%eax
  801c86:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801c8b:	75 73                	jne    801d00 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801c8d:	83 ec 08             	sub    $0x8,%esp
  801c90:	ff 75 08             	pushl  0x8(%ebp)
  801c93:	68 00 00 00 80       	push   $0x80000000
  801c98:	e8 80 04 00 00       	call   80211d <sys_allocateMem>
  801c9d:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801ca0:	a1 04 30 80 00       	mov    0x803004,%eax
  801ca5:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801ca8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cab:	c1 e0 0c             	shl    $0xc,%eax
  801cae:	89 c2                	mov    %eax,%edx
  801cb0:	a1 04 30 80 00       	mov    0x803004,%eax
  801cb5:	01 d0                	add    %edx,%eax
  801cb7:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801cbc:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801cc1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801cc4:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801ccb:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801cd0:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801cd6:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801cdd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801ce2:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801ce9:	01 00 00 00 
			sizeofarray++;
  801ced:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801cf2:	40                   	inc    %eax
  801cf3:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  801cf8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801cfb:	e9 71 01 00 00       	jmp    801e71 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801d00:	a1 28 30 80 00       	mov    0x803028,%eax
  801d05:	85 c0                	test   %eax,%eax
  801d07:	75 71                	jne    801d7a <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801d09:	a1 04 30 80 00       	mov    0x803004,%eax
  801d0e:	83 ec 08             	sub    $0x8,%esp
  801d11:	ff 75 08             	pushl  0x8(%ebp)
  801d14:	50                   	push   %eax
  801d15:	e8 03 04 00 00       	call   80211d <sys_allocateMem>
  801d1a:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801d1d:	a1 04 30 80 00       	mov    0x803004,%eax
  801d22:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801d25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d28:	c1 e0 0c             	shl    $0xc,%eax
  801d2b:	89 c2                	mov    %eax,%edx
  801d2d:	a1 04 30 80 00       	mov    0x803004,%eax
  801d32:	01 d0                	add    %edx,%eax
  801d34:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801d39:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801d3e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d41:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801d48:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801d4d:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801d50:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801d57:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801d5c:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801d63:	01 00 00 00 
				sizeofarray++;
  801d67:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801d6c:	40                   	inc    %eax
  801d6d:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801d72:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801d75:	e9 f7 00 00 00       	jmp    801e71 <malloc+0x20e>
			}
			else{
				int count=0;
  801d7a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801d81:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801d88:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801d8f:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801d96:	eb 7c                	jmp    801e14 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801d98:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801d9f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801da6:	eb 1a                	jmp    801dc2 <malloc+0x15f>
					{
						if(addresses[j]==i)
  801da8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801dab:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801db2:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801db5:	75 08                	jne    801dbf <malloc+0x15c>
						{
							index=j;
  801db7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801dba:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801dbd:	eb 0d                	jmp    801dcc <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801dbf:	ff 45 dc             	incl   -0x24(%ebp)
  801dc2:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801dc7:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801dca:	7c dc                	jl     801da8 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801dcc:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801dd0:	75 05                	jne    801dd7 <malloc+0x174>
					{
						count++;
  801dd2:	ff 45 f0             	incl   -0x10(%ebp)
  801dd5:	eb 36                	jmp    801e0d <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801dd7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801dda:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  801de1:	85 c0                	test   %eax,%eax
  801de3:	75 05                	jne    801dea <malloc+0x187>
						{
							count++;
  801de5:	ff 45 f0             	incl   -0x10(%ebp)
  801de8:	eb 23                	jmp    801e0d <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801dea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ded:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801df0:	7d 14                	jge    801e06 <malloc+0x1a3>
  801df2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801df5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801df8:	7c 0c                	jl     801e06 <malloc+0x1a3>
							{
								min=count;
  801dfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dfd:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801e00:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e03:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801e06:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801e0d:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801e14:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801e1b:	0f 86 77 ff ff ff    	jbe    801d98 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801e21:	83 ec 08             	sub    $0x8,%esp
  801e24:	ff 75 08             	pushl  0x8(%ebp)
  801e27:	ff 75 e4             	pushl  -0x1c(%ebp)
  801e2a:	e8 ee 02 00 00       	call   80211d <sys_allocateMem>
  801e2f:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801e32:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801e37:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e3a:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801e41:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801e46:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801e4c:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801e53:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801e58:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801e5f:	01 00 00 00 
				sizeofarray++;
  801e63:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801e68:	40                   	inc    %eax
  801e69:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  801e6e:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801e71:	c9                   	leave  
  801e72:	c3                   	ret    

00801e73 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801e73:	55                   	push   %ebp
  801e74:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  801e76:	90                   	nop
  801e77:	5d                   	pop    %ebp
  801e78:	c3                   	ret    

00801e79 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801e79:	55                   	push   %ebp
  801e7a:	89 e5                	mov    %esp,%ebp
  801e7c:	83 ec 18             	sub    $0x18,%esp
  801e7f:	8b 45 10             	mov    0x10(%ebp),%eax
  801e82:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801e85:	83 ec 04             	sub    $0x4,%esp
  801e88:	68 90 2e 80 00       	push   $0x802e90
  801e8d:	68 8d 00 00 00       	push   $0x8d
  801e92:	68 b3 2e 80 00       	push   $0x802eb3
  801e97:	e8 9b ed ff ff       	call   800c37 <_panic>

00801e9c <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801e9c:	55                   	push   %ebp
  801e9d:	89 e5                	mov    %esp,%ebp
  801e9f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ea2:	83 ec 04             	sub    $0x4,%esp
  801ea5:	68 90 2e 80 00       	push   $0x802e90
  801eaa:	68 93 00 00 00       	push   $0x93
  801eaf:	68 b3 2e 80 00       	push   $0x802eb3
  801eb4:	e8 7e ed ff ff       	call   800c37 <_panic>

00801eb9 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801eb9:	55                   	push   %ebp
  801eba:	89 e5                	mov    %esp,%ebp
  801ebc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ebf:	83 ec 04             	sub    $0x4,%esp
  801ec2:	68 90 2e 80 00       	push   $0x802e90
  801ec7:	68 99 00 00 00       	push   $0x99
  801ecc:	68 b3 2e 80 00       	push   $0x802eb3
  801ed1:	e8 61 ed ff ff       	call   800c37 <_panic>

00801ed6 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801ed6:	55                   	push   %ebp
  801ed7:	89 e5                	mov    %esp,%ebp
  801ed9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801edc:	83 ec 04             	sub    $0x4,%esp
  801edf:	68 90 2e 80 00       	push   $0x802e90
  801ee4:	68 9e 00 00 00       	push   $0x9e
  801ee9:	68 b3 2e 80 00       	push   $0x802eb3
  801eee:	e8 44 ed ff ff       	call   800c37 <_panic>

00801ef3 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801ef3:	55                   	push   %ebp
  801ef4:	89 e5                	mov    %esp,%ebp
  801ef6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ef9:	83 ec 04             	sub    $0x4,%esp
  801efc:	68 90 2e 80 00       	push   $0x802e90
  801f01:	68 a4 00 00 00       	push   $0xa4
  801f06:	68 b3 2e 80 00       	push   $0x802eb3
  801f0b:	e8 27 ed ff ff       	call   800c37 <_panic>

00801f10 <shrink>:
}
void shrink(uint32 newSize)
{
  801f10:	55                   	push   %ebp
  801f11:	89 e5                	mov    %esp,%ebp
  801f13:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f16:	83 ec 04             	sub    $0x4,%esp
  801f19:	68 90 2e 80 00       	push   $0x802e90
  801f1e:	68 a8 00 00 00       	push   $0xa8
  801f23:	68 b3 2e 80 00       	push   $0x802eb3
  801f28:	e8 0a ed ff ff       	call   800c37 <_panic>

00801f2d <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801f2d:	55                   	push   %ebp
  801f2e:	89 e5                	mov    %esp,%ebp
  801f30:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f33:	83 ec 04             	sub    $0x4,%esp
  801f36:	68 90 2e 80 00       	push   $0x802e90
  801f3b:	68 ad 00 00 00       	push   $0xad
  801f40:	68 b3 2e 80 00       	push   $0x802eb3
  801f45:	e8 ed ec ff ff       	call   800c37 <_panic>

00801f4a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801f4a:	55                   	push   %ebp
  801f4b:	89 e5                	mov    %esp,%ebp
  801f4d:	57                   	push   %edi
  801f4e:	56                   	push   %esi
  801f4f:	53                   	push   %ebx
  801f50:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801f53:	8b 45 08             	mov    0x8(%ebp),%eax
  801f56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f59:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f5c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f5f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801f62:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801f65:	cd 30                	int    $0x30
  801f67:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801f6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801f6d:	83 c4 10             	add    $0x10,%esp
  801f70:	5b                   	pop    %ebx
  801f71:	5e                   	pop    %esi
  801f72:	5f                   	pop    %edi
  801f73:	5d                   	pop    %ebp
  801f74:	c3                   	ret    

00801f75 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801f75:	55                   	push   %ebp
  801f76:	89 e5                	mov    %esp,%ebp
  801f78:	83 ec 04             	sub    $0x4,%esp
  801f7b:	8b 45 10             	mov    0x10(%ebp),%eax
  801f7e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801f81:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f85:	8b 45 08             	mov    0x8(%ebp),%eax
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 00                	push   $0x0
  801f8c:	52                   	push   %edx
  801f8d:	ff 75 0c             	pushl  0xc(%ebp)
  801f90:	50                   	push   %eax
  801f91:	6a 00                	push   $0x0
  801f93:	e8 b2 ff ff ff       	call   801f4a <syscall>
  801f98:	83 c4 18             	add    $0x18,%esp
}
  801f9b:	90                   	nop
  801f9c:	c9                   	leave  
  801f9d:	c3                   	ret    

00801f9e <sys_cgetc>:

int
sys_cgetc(void)
{
  801f9e:	55                   	push   %ebp
  801f9f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801fa1:	6a 00                	push   $0x0
  801fa3:	6a 00                	push   $0x0
  801fa5:	6a 00                	push   $0x0
  801fa7:	6a 00                	push   $0x0
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 01                	push   $0x1
  801fad:	e8 98 ff ff ff       	call   801f4a <syscall>
  801fb2:	83 c4 18             	add    $0x18,%esp
}
  801fb5:	c9                   	leave  
  801fb6:	c3                   	ret    

00801fb7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801fb7:	55                   	push   %ebp
  801fb8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801fba:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	50                   	push   %eax
  801fc6:	6a 05                	push   $0x5
  801fc8:	e8 7d ff ff ff       	call   801f4a <syscall>
  801fcd:	83 c4 18             	add    $0x18,%esp
}
  801fd0:	c9                   	leave  
  801fd1:	c3                   	ret    

00801fd2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801fd2:	55                   	push   %ebp
  801fd3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 02                	push   $0x2
  801fe1:	e8 64 ff ff ff       	call   801f4a <syscall>
  801fe6:	83 c4 18             	add    $0x18,%esp
}
  801fe9:	c9                   	leave  
  801fea:	c3                   	ret    

00801feb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801feb:	55                   	push   %ebp
  801fec:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 00                	push   $0x0
  801ff8:	6a 03                	push   $0x3
  801ffa:	e8 4b ff ff ff       	call   801f4a <syscall>
  801fff:	83 c4 18             	add    $0x18,%esp
}
  802002:	c9                   	leave  
  802003:	c3                   	ret    

00802004 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802004:	55                   	push   %ebp
  802005:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802007:	6a 00                	push   $0x0
  802009:	6a 00                	push   $0x0
  80200b:	6a 00                	push   $0x0
  80200d:	6a 00                	push   $0x0
  80200f:	6a 00                	push   $0x0
  802011:	6a 04                	push   $0x4
  802013:	e8 32 ff ff ff       	call   801f4a <syscall>
  802018:	83 c4 18             	add    $0x18,%esp
}
  80201b:	c9                   	leave  
  80201c:	c3                   	ret    

0080201d <sys_env_exit>:


void sys_env_exit(void)
{
  80201d:	55                   	push   %ebp
  80201e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	6a 00                	push   $0x0
  80202a:	6a 06                	push   $0x6
  80202c:	e8 19 ff ff ff       	call   801f4a <syscall>
  802031:	83 c4 18             	add    $0x18,%esp
}
  802034:	90                   	nop
  802035:	c9                   	leave  
  802036:	c3                   	ret    

00802037 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802037:	55                   	push   %ebp
  802038:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80203a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80203d:	8b 45 08             	mov    0x8(%ebp),%eax
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	52                   	push   %edx
  802047:	50                   	push   %eax
  802048:	6a 07                	push   $0x7
  80204a:	e8 fb fe ff ff       	call   801f4a <syscall>
  80204f:	83 c4 18             	add    $0x18,%esp
}
  802052:	c9                   	leave  
  802053:	c3                   	ret    

00802054 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802054:	55                   	push   %ebp
  802055:	89 e5                	mov    %esp,%ebp
  802057:	56                   	push   %esi
  802058:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802059:	8b 75 18             	mov    0x18(%ebp),%esi
  80205c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80205f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802062:	8b 55 0c             	mov    0xc(%ebp),%edx
  802065:	8b 45 08             	mov    0x8(%ebp),%eax
  802068:	56                   	push   %esi
  802069:	53                   	push   %ebx
  80206a:	51                   	push   %ecx
  80206b:	52                   	push   %edx
  80206c:	50                   	push   %eax
  80206d:	6a 08                	push   $0x8
  80206f:	e8 d6 fe ff ff       	call   801f4a <syscall>
  802074:	83 c4 18             	add    $0x18,%esp
}
  802077:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80207a:	5b                   	pop    %ebx
  80207b:	5e                   	pop    %esi
  80207c:	5d                   	pop    %ebp
  80207d:	c3                   	ret    

0080207e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80207e:	55                   	push   %ebp
  80207f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802081:	8b 55 0c             	mov    0xc(%ebp),%edx
  802084:	8b 45 08             	mov    0x8(%ebp),%eax
  802087:	6a 00                	push   $0x0
  802089:	6a 00                	push   $0x0
  80208b:	6a 00                	push   $0x0
  80208d:	52                   	push   %edx
  80208e:	50                   	push   %eax
  80208f:	6a 09                	push   $0x9
  802091:	e8 b4 fe ff ff       	call   801f4a <syscall>
  802096:	83 c4 18             	add    $0x18,%esp
}
  802099:	c9                   	leave  
  80209a:	c3                   	ret    

0080209b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80209b:	55                   	push   %ebp
  80209c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	ff 75 0c             	pushl  0xc(%ebp)
  8020a7:	ff 75 08             	pushl  0x8(%ebp)
  8020aa:	6a 0a                	push   $0xa
  8020ac:	e8 99 fe ff ff       	call   801f4a <syscall>
  8020b1:	83 c4 18             	add    $0x18,%esp
}
  8020b4:	c9                   	leave  
  8020b5:	c3                   	ret    

008020b6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8020b6:	55                   	push   %ebp
  8020b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 0b                	push   $0xb
  8020c5:	e8 80 fe ff ff       	call   801f4a <syscall>
  8020ca:	83 c4 18             	add    $0x18,%esp
}
  8020cd:	c9                   	leave  
  8020ce:	c3                   	ret    

008020cf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8020cf:	55                   	push   %ebp
  8020d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 00                	push   $0x0
  8020d8:	6a 00                	push   $0x0
  8020da:	6a 00                	push   $0x0
  8020dc:	6a 0c                	push   $0xc
  8020de:	e8 67 fe ff ff       	call   801f4a <syscall>
  8020e3:	83 c4 18             	add    $0x18,%esp
}
  8020e6:	c9                   	leave  
  8020e7:	c3                   	ret    

008020e8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8020e8:	55                   	push   %ebp
  8020e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 00                	push   $0x0
  8020f3:	6a 00                	push   $0x0
  8020f5:	6a 0d                	push   $0xd
  8020f7:	e8 4e fe ff ff       	call   801f4a <syscall>
  8020fc:	83 c4 18             	add    $0x18,%esp
}
  8020ff:	c9                   	leave  
  802100:	c3                   	ret    

00802101 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802101:	55                   	push   %ebp
  802102:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802104:	6a 00                	push   $0x0
  802106:	6a 00                	push   $0x0
  802108:	6a 00                	push   $0x0
  80210a:	ff 75 0c             	pushl  0xc(%ebp)
  80210d:	ff 75 08             	pushl  0x8(%ebp)
  802110:	6a 11                	push   $0x11
  802112:	e8 33 fe ff ff       	call   801f4a <syscall>
  802117:	83 c4 18             	add    $0x18,%esp
	return;
  80211a:	90                   	nop
}
  80211b:	c9                   	leave  
  80211c:	c3                   	ret    

0080211d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80211d:	55                   	push   %ebp
  80211e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	ff 75 0c             	pushl  0xc(%ebp)
  802129:	ff 75 08             	pushl  0x8(%ebp)
  80212c:	6a 12                	push   $0x12
  80212e:	e8 17 fe ff ff       	call   801f4a <syscall>
  802133:	83 c4 18             	add    $0x18,%esp
	return ;
  802136:	90                   	nop
}
  802137:	c9                   	leave  
  802138:	c3                   	ret    

00802139 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802139:	55                   	push   %ebp
  80213a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 00                	push   $0x0
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 0e                	push   $0xe
  802148:	e8 fd fd ff ff       	call   801f4a <syscall>
  80214d:	83 c4 18             	add    $0x18,%esp
}
  802150:	c9                   	leave  
  802151:	c3                   	ret    

00802152 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802152:	55                   	push   %ebp
  802153:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 00                	push   $0x0
  80215b:	6a 00                	push   $0x0
  80215d:	ff 75 08             	pushl  0x8(%ebp)
  802160:	6a 0f                	push   $0xf
  802162:	e8 e3 fd ff ff       	call   801f4a <syscall>
  802167:	83 c4 18             	add    $0x18,%esp
}
  80216a:	c9                   	leave  
  80216b:	c3                   	ret    

0080216c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80216c:	55                   	push   %ebp
  80216d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80216f:	6a 00                	push   $0x0
  802171:	6a 00                	push   $0x0
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	6a 00                	push   $0x0
  802179:	6a 10                	push   $0x10
  80217b:	e8 ca fd ff ff       	call   801f4a <syscall>
  802180:	83 c4 18             	add    $0x18,%esp
}
  802183:	90                   	nop
  802184:	c9                   	leave  
  802185:	c3                   	ret    

00802186 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802186:	55                   	push   %ebp
  802187:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802189:	6a 00                	push   $0x0
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	6a 14                	push   $0x14
  802195:	e8 b0 fd ff ff       	call   801f4a <syscall>
  80219a:	83 c4 18             	add    $0x18,%esp
}
  80219d:	90                   	nop
  80219e:	c9                   	leave  
  80219f:	c3                   	ret    

008021a0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8021a0:	55                   	push   %ebp
  8021a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 15                	push   $0x15
  8021af:	e8 96 fd ff ff       	call   801f4a <syscall>
  8021b4:	83 c4 18             	add    $0x18,%esp
}
  8021b7:	90                   	nop
  8021b8:	c9                   	leave  
  8021b9:	c3                   	ret    

008021ba <sys_cputc>:


void
sys_cputc(const char c)
{
  8021ba:	55                   	push   %ebp
  8021bb:	89 e5                	mov    %esp,%ebp
  8021bd:	83 ec 04             	sub    $0x4,%esp
  8021c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8021c6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021ca:	6a 00                	push   $0x0
  8021cc:	6a 00                	push   $0x0
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	50                   	push   %eax
  8021d3:	6a 16                	push   $0x16
  8021d5:	e8 70 fd ff ff       	call   801f4a <syscall>
  8021da:	83 c4 18             	add    $0x18,%esp
}
  8021dd:	90                   	nop
  8021de:	c9                   	leave  
  8021df:	c3                   	ret    

008021e0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8021e0:	55                   	push   %ebp
  8021e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 00                	push   $0x0
  8021e9:	6a 00                	push   $0x0
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 17                	push   $0x17
  8021ef:	e8 56 fd ff ff       	call   801f4a <syscall>
  8021f4:	83 c4 18             	add    $0x18,%esp
}
  8021f7:	90                   	nop
  8021f8:	c9                   	leave  
  8021f9:	c3                   	ret    

008021fa <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8021fa:	55                   	push   %ebp
  8021fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8021fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802200:	6a 00                	push   $0x0
  802202:	6a 00                	push   $0x0
  802204:	6a 00                	push   $0x0
  802206:	ff 75 0c             	pushl  0xc(%ebp)
  802209:	50                   	push   %eax
  80220a:	6a 18                	push   $0x18
  80220c:	e8 39 fd ff ff       	call   801f4a <syscall>
  802211:	83 c4 18             	add    $0x18,%esp
}
  802214:	c9                   	leave  
  802215:	c3                   	ret    

00802216 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802216:	55                   	push   %ebp
  802217:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802219:	8b 55 0c             	mov    0xc(%ebp),%edx
  80221c:	8b 45 08             	mov    0x8(%ebp),%eax
  80221f:	6a 00                	push   $0x0
  802221:	6a 00                	push   $0x0
  802223:	6a 00                	push   $0x0
  802225:	52                   	push   %edx
  802226:	50                   	push   %eax
  802227:	6a 1b                	push   $0x1b
  802229:	e8 1c fd ff ff       	call   801f4a <syscall>
  80222e:	83 c4 18             	add    $0x18,%esp
}
  802231:	c9                   	leave  
  802232:	c3                   	ret    

00802233 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802233:	55                   	push   %ebp
  802234:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802236:	8b 55 0c             	mov    0xc(%ebp),%edx
  802239:	8b 45 08             	mov    0x8(%ebp),%eax
  80223c:	6a 00                	push   $0x0
  80223e:	6a 00                	push   $0x0
  802240:	6a 00                	push   $0x0
  802242:	52                   	push   %edx
  802243:	50                   	push   %eax
  802244:	6a 19                	push   $0x19
  802246:	e8 ff fc ff ff       	call   801f4a <syscall>
  80224b:	83 c4 18             	add    $0x18,%esp
}
  80224e:	90                   	nop
  80224f:	c9                   	leave  
  802250:	c3                   	ret    

00802251 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802251:	55                   	push   %ebp
  802252:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802254:	8b 55 0c             	mov    0xc(%ebp),%edx
  802257:	8b 45 08             	mov    0x8(%ebp),%eax
  80225a:	6a 00                	push   $0x0
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	52                   	push   %edx
  802261:	50                   	push   %eax
  802262:	6a 1a                	push   $0x1a
  802264:	e8 e1 fc ff ff       	call   801f4a <syscall>
  802269:	83 c4 18             	add    $0x18,%esp
}
  80226c:	90                   	nop
  80226d:	c9                   	leave  
  80226e:	c3                   	ret    

0080226f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80226f:	55                   	push   %ebp
  802270:	89 e5                	mov    %esp,%ebp
  802272:	83 ec 04             	sub    $0x4,%esp
  802275:	8b 45 10             	mov    0x10(%ebp),%eax
  802278:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80227b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80227e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802282:	8b 45 08             	mov    0x8(%ebp),%eax
  802285:	6a 00                	push   $0x0
  802287:	51                   	push   %ecx
  802288:	52                   	push   %edx
  802289:	ff 75 0c             	pushl  0xc(%ebp)
  80228c:	50                   	push   %eax
  80228d:	6a 1c                	push   $0x1c
  80228f:	e8 b6 fc ff ff       	call   801f4a <syscall>
  802294:	83 c4 18             	add    $0x18,%esp
}
  802297:	c9                   	leave  
  802298:	c3                   	ret    

00802299 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802299:	55                   	push   %ebp
  80229a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80229c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80229f:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a2:	6a 00                	push   $0x0
  8022a4:	6a 00                	push   $0x0
  8022a6:	6a 00                	push   $0x0
  8022a8:	52                   	push   %edx
  8022a9:	50                   	push   %eax
  8022aa:	6a 1d                	push   $0x1d
  8022ac:	e8 99 fc ff ff       	call   801f4a <syscall>
  8022b1:	83 c4 18             	add    $0x18,%esp
}
  8022b4:	c9                   	leave  
  8022b5:	c3                   	ret    

008022b6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8022b6:	55                   	push   %ebp
  8022b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8022b9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c2:	6a 00                	push   $0x0
  8022c4:	6a 00                	push   $0x0
  8022c6:	51                   	push   %ecx
  8022c7:	52                   	push   %edx
  8022c8:	50                   	push   %eax
  8022c9:	6a 1e                	push   $0x1e
  8022cb:	e8 7a fc ff ff       	call   801f4a <syscall>
  8022d0:	83 c4 18             	add    $0x18,%esp
}
  8022d3:	c9                   	leave  
  8022d4:	c3                   	ret    

008022d5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8022d5:	55                   	push   %ebp
  8022d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8022d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022db:	8b 45 08             	mov    0x8(%ebp),%eax
  8022de:	6a 00                	push   $0x0
  8022e0:	6a 00                	push   $0x0
  8022e2:	6a 00                	push   $0x0
  8022e4:	52                   	push   %edx
  8022e5:	50                   	push   %eax
  8022e6:	6a 1f                	push   $0x1f
  8022e8:	e8 5d fc ff ff       	call   801f4a <syscall>
  8022ed:	83 c4 18             	add    $0x18,%esp
}
  8022f0:	c9                   	leave  
  8022f1:	c3                   	ret    

008022f2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8022f2:	55                   	push   %ebp
  8022f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8022f5:	6a 00                	push   $0x0
  8022f7:	6a 00                	push   $0x0
  8022f9:	6a 00                	push   $0x0
  8022fb:	6a 00                	push   $0x0
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 20                	push   $0x20
  802301:	e8 44 fc ff ff       	call   801f4a <syscall>
  802306:	83 c4 18             	add    $0x18,%esp
}
  802309:	c9                   	leave  
  80230a:	c3                   	ret    

0080230b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80230b:	55                   	push   %ebp
  80230c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80230e:	8b 45 08             	mov    0x8(%ebp),%eax
  802311:	6a 00                	push   $0x0
  802313:	ff 75 14             	pushl  0x14(%ebp)
  802316:	ff 75 10             	pushl  0x10(%ebp)
  802319:	ff 75 0c             	pushl  0xc(%ebp)
  80231c:	50                   	push   %eax
  80231d:	6a 21                	push   $0x21
  80231f:	e8 26 fc ff ff       	call   801f4a <syscall>
  802324:	83 c4 18             	add    $0x18,%esp
}
  802327:	c9                   	leave  
  802328:	c3                   	ret    

00802329 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802329:	55                   	push   %ebp
  80232a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80232c:	8b 45 08             	mov    0x8(%ebp),%eax
  80232f:	6a 00                	push   $0x0
  802331:	6a 00                	push   $0x0
  802333:	6a 00                	push   $0x0
  802335:	6a 00                	push   $0x0
  802337:	50                   	push   %eax
  802338:	6a 22                	push   $0x22
  80233a:	e8 0b fc ff ff       	call   801f4a <syscall>
  80233f:	83 c4 18             	add    $0x18,%esp
}
  802342:	90                   	nop
  802343:	c9                   	leave  
  802344:	c3                   	ret    

00802345 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802345:	55                   	push   %ebp
  802346:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802348:	8b 45 08             	mov    0x8(%ebp),%eax
  80234b:	6a 00                	push   $0x0
  80234d:	6a 00                	push   $0x0
  80234f:	6a 00                	push   $0x0
  802351:	6a 00                	push   $0x0
  802353:	50                   	push   %eax
  802354:	6a 23                	push   $0x23
  802356:	e8 ef fb ff ff       	call   801f4a <syscall>
  80235b:	83 c4 18             	add    $0x18,%esp
}
  80235e:	90                   	nop
  80235f:	c9                   	leave  
  802360:	c3                   	ret    

00802361 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802361:	55                   	push   %ebp
  802362:	89 e5                	mov    %esp,%ebp
  802364:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802367:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80236a:	8d 50 04             	lea    0x4(%eax),%edx
  80236d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802370:	6a 00                	push   $0x0
  802372:	6a 00                	push   $0x0
  802374:	6a 00                	push   $0x0
  802376:	52                   	push   %edx
  802377:	50                   	push   %eax
  802378:	6a 24                	push   $0x24
  80237a:	e8 cb fb ff ff       	call   801f4a <syscall>
  80237f:	83 c4 18             	add    $0x18,%esp
	return result;
  802382:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802385:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802388:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80238b:	89 01                	mov    %eax,(%ecx)
  80238d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802390:	8b 45 08             	mov    0x8(%ebp),%eax
  802393:	c9                   	leave  
  802394:	c2 04 00             	ret    $0x4

00802397 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802397:	55                   	push   %ebp
  802398:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80239a:	6a 00                	push   $0x0
  80239c:	6a 00                	push   $0x0
  80239e:	ff 75 10             	pushl  0x10(%ebp)
  8023a1:	ff 75 0c             	pushl  0xc(%ebp)
  8023a4:	ff 75 08             	pushl  0x8(%ebp)
  8023a7:	6a 13                	push   $0x13
  8023a9:	e8 9c fb ff ff       	call   801f4a <syscall>
  8023ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8023b1:	90                   	nop
}
  8023b2:	c9                   	leave  
  8023b3:	c3                   	ret    

008023b4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8023b4:	55                   	push   %ebp
  8023b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8023b7:	6a 00                	push   $0x0
  8023b9:	6a 00                	push   $0x0
  8023bb:	6a 00                	push   $0x0
  8023bd:	6a 00                	push   $0x0
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 25                	push   $0x25
  8023c3:	e8 82 fb ff ff       	call   801f4a <syscall>
  8023c8:	83 c4 18             	add    $0x18,%esp
}
  8023cb:	c9                   	leave  
  8023cc:	c3                   	ret    

008023cd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8023cd:	55                   	push   %ebp
  8023ce:	89 e5                	mov    %esp,%ebp
  8023d0:	83 ec 04             	sub    $0x4,%esp
  8023d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8023d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8023d9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8023dd:	6a 00                	push   $0x0
  8023df:	6a 00                	push   $0x0
  8023e1:	6a 00                	push   $0x0
  8023e3:	6a 00                	push   $0x0
  8023e5:	50                   	push   %eax
  8023e6:	6a 26                	push   $0x26
  8023e8:	e8 5d fb ff ff       	call   801f4a <syscall>
  8023ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8023f0:	90                   	nop
}
  8023f1:	c9                   	leave  
  8023f2:	c3                   	ret    

008023f3 <rsttst>:
void rsttst()
{
  8023f3:	55                   	push   %ebp
  8023f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8023f6:	6a 00                	push   $0x0
  8023f8:	6a 00                	push   $0x0
  8023fa:	6a 00                	push   $0x0
  8023fc:	6a 00                	push   $0x0
  8023fe:	6a 00                	push   $0x0
  802400:	6a 28                	push   $0x28
  802402:	e8 43 fb ff ff       	call   801f4a <syscall>
  802407:	83 c4 18             	add    $0x18,%esp
	return ;
  80240a:	90                   	nop
}
  80240b:	c9                   	leave  
  80240c:	c3                   	ret    

0080240d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80240d:	55                   	push   %ebp
  80240e:	89 e5                	mov    %esp,%ebp
  802410:	83 ec 04             	sub    $0x4,%esp
  802413:	8b 45 14             	mov    0x14(%ebp),%eax
  802416:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802419:	8b 55 18             	mov    0x18(%ebp),%edx
  80241c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802420:	52                   	push   %edx
  802421:	50                   	push   %eax
  802422:	ff 75 10             	pushl  0x10(%ebp)
  802425:	ff 75 0c             	pushl  0xc(%ebp)
  802428:	ff 75 08             	pushl  0x8(%ebp)
  80242b:	6a 27                	push   $0x27
  80242d:	e8 18 fb ff ff       	call   801f4a <syscall>
  802432:	83 c4 18             	add    $0x18,%esp
	return ;
  802435:	90                   	nop
}
  802436:	c9                   	leave  
  802437:	c3                   	ret    

00802438 <chktst>:
void chktst(uint32 n)
{
  802438:	55                   	push   %ebp
  802439:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80243b:	6a 00                	push   $0x0
  80243d:	6a 00                	push   $0x0
  80243f:	6a 00                	push   $0x0
  802441:	6a 00                	push   $0x0
  802443:	ff 75 08             	pushl  0x8(%ebp)
  802446:	6a 29                	push   $0x29
  802448:	e8 fd fa ff ff       	call   801f4a <syscall>
  80244d:	83 c4 18             	add    $0x18,%esp
	return ;
  802450:	90                   	nop
}
  802451:	c9                   	leave  
  802452:	c3                   	ret    

00802453 <inctst>:

void inctst()
{
  802453:	55                   	push   %ebp
  802454:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802456:	6a 00                	push   $0x0
  802458:	6a 00                	push   $0x0
  80245a:	6a 00                	push   $0x0
  80245c:	6a 00                	push   $0x0
  80245e:	6a 00                	push   $0x0
  802460:	6a 2a                	push   $0x2a
  802462:	e8 e3 fa ff ff       	call   801f4a <syscall>
  802467:	83 c4 18             	add    $0x18,%esp
	return ;
  80246a:	90                   	nop
}
  80246b:	c9                   	leave  
  80246c:	c3                   	ret    

0080246d <gettst>:
uint32 gettst()
{
  80246d:	55                   	push   %ebp
  80246e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802470:	6a 00                	push   $0x0
  802472:	6a 00                	push   $0x0
  802474:	6a 00                	push   $0x0
  802476:	6a 00                	push   $0x0
  802478:	6a 00                	push   $0x0
  80247a:	6a 2b                	push   $0x2b
  80247c:	e8 c9 fa ff ff       	call   801f4a <syscall>
  802481:	83 c4 18             	add    $0x18,%esp
}
  802484:	c9                   	leave  
  802485:	c3                   	ret    

00802486 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802486:	55                   	push   %ebp
  802487:	89 e5                	mov    %esp,%ebp
  802489:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80248c:	6a 00                	push   $0x0
  80248e:	6a 00                	push   $0x0
  802490:	6a 00                	push   $0x0
  802492:	6a 00                	push   $0x0
  802494:	6a 00                	push   $0x0
  802496:	6a 2c                	push   $0x2c
  802498:	e8 ad fa ff ff       	call   801f4a <syscall>
  80249d:	83 c4 18             	add    $0x18,%esp
  8024a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8024a3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8024a7:	75 07                	jne    8024b0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8024a9:	b8 01 00 00 00       	mov    $0x1,%eax
  8024ae:	eb 05                	jmp    8024b5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8024b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024b5:	c9                   	leave  
  8024b6:	c3                   	ret    

008024b7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8024b7:	55                   	push   %ebp
  8024b8:	89 e5                	mov    %esp,%ebp
  8024ba:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024bd:	6a 00                	push   $0x0
  8024bf:	6a 00                	push   $0x0
  8024c1:	6a 00                	push   $0x0
  8024c3:	6a 00                	push   $0x0
  8024c5:	6a 00                	push   $0x0
  8024c7:	6a 2c                	push   $0x2c
  8024c9:	e8 7c fa ff ff       	call   801f4a <syscall>
  8024ce:	83 c4 18             	add    $0x18,%esp
  8024d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8024d4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8024d8:	75 07                	jne    8024e1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8024da:	b8 01 00 00 00       	mov    $0x1,%eax
  8024df:	eb 05                	jmp    8024e6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8024e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024e6:	c9                   	leave  
  8024e7:	c3                   	ret    

008024e8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8024e8:	55                   	push   %ebp
  8024e9:	89 e5                	mov    %esp,%ebp
  8024eb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024ee:	6a 00                	push   $0x0
  8024f0:	6a 00                	push   $0x0
  8024f2:	6a 00                	push   $0x0
  8024f4:	6a 00                	push   $0x0
  8024f6:	6a 00                	push   $0x0
  8024f8:	6a 2c                	push   $0x2c
  8024fa:	e8 4b fa ff ff       	call   801f4a <syscall>
  8024ff:	83 c4 18             	add    $0x18,%esp
  802502:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802505:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802509:	75 07                	jne    802512 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80250b:	b8 01 00 00 00       	mov    $0x1,%eax
  802510:	eb 05                	jmp    802517 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802512:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802517:	c9                   	leave  
  802518:	c3                   	ret    

00802519 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802519:	55                   	push   %ebp
  80251a:	89 e5                	mov    %esp,%ebp
  80251c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80251f:	6a 00                	push   $0x0
  802521:	6a 00                	push   $0x0
  802523:	6a 00                	push   $0x0
  802525:	6a 00                	push   $0x0
  802527:	6a 00                	push   $0x0
  802529:	6a 2c                	push   $0x2c
  80252b:	e8 1a fa ff ff       	call   801f4a <syscall>
  802530:	83 c4 18             	add    $0x18,%esp
  802533:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802536:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80253a:	75 07                	jne    802543 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80253c:	b8 01 00 00 00       	mov    $0x1,%eax
  802541:	eb 05                	jmp    802548 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802543:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802548:	c9                   	leave  
  802549:	c3                   	ret    

0080254a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80254a:	55                   	push   %ebp
  80254b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80254d:	6a 00                	push   $0x0
  80254f:	6a 00                	push   $0x0
  802551:	6a 00                	push   $0x0
  802553:	6a 00                	push   $0x0
  802555:	ff 75 08             	pushl  0x8(%ebp)
  802558:	6a 2d                	push   $0x2d
  80255a:	e8 eb f9 ff ff       	call   801f4a <syscall>
  80255f:	83 c4 18             	add    $0x18,%esp
	return ;
  802562:	90                   	nop
}
  802563:	c9                   	leave  
  802564:	c3                   	ret    

00802565 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802565:	55                   	push   %ebp
  802566:	89 e5                	mov    %esp,%ebp
  802568:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802569:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80256c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80256f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802572:	8b 45 08             	mov    0x8(%ebp),%eax
  802575:	6a 00                	push   $0x0
  802577:	53                   	push   %ebx
  802578:	51                   	push   %ecx
  802579:	52                   	push   %edx
  80257a:	50                   	push   %eax
  80257b:	6a 2e                	push   $0x2e
  80257d:	e8 c8 f9 ff ff       	call   801f4a <syscall>
  802582:	83 c4 18             	add    $0x18,%esp
}
  802585:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802588:	c9                   	leave  
  802589:	c3                   	ret    

0080258a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80258a:	55                   	push   %ebp
  80258b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80258d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802590:	8b 45 08             	mov    0x8(%ebp),%eax
  802593:	6a 00                	push   $0x0
  802595:	6a 00                	push   $0x0
  802597:	6a 00                	push   $0x0
  802599:	52                   	push   %edx
  80259a:	50                   	push   %eax
  80259b:	6a 2f                	push   $0x2f
  80259d:	e8 a8 f9 ff ff       	call   801f4a <syscall>
  8025a2:	83 c4 18             	add    $0x18,%esp
}
  8025a5:	c9                   	leave  
  8025a6:	c3                   	ret    
  8025a7:	90                   	nop

008025a8 <__udivdi3>:
  8025a8:	55                   	push   %ebp
  8025a9:	57                   	push   %edi
  8025aa:	56                   	push   %esi
  8025ab:	53                   	push   %ebx
  8025ac:	83 ec 1c             	sub    $0x1c,%esp
  8025af:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8025b3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8025b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025bb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8025bf:	89 ca                	mov    %ecx,%edx
  8025c1:	89 f8                	mov    %edi,%eax
  8025c3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8025c7:	85 f6                	test   %esi,%esi
  8025c9:	75 2d                	jne    8025f8 <__udivdi3+0x50>
  8025cb:	39 cf                	cmp    %ecx,%edi
  8025cd:	77 65                	ja     802634 <__udivdi3+0x8c>
  8025cf:	89 fd                	mov    %edi,%ebp
  8025d1:	85 ff                	test   %edi,%edi
  8025d3:	75 0b                	jne    8025e0 <__udivdi3+0x38>
  8025d5:	b8 01 00 00 00       	mov    $0x1,%eax
  8025da:	31 d2                	xor    %edx,%edx
  8025dc:	f7 f7                	div    %edi
  8025de:	89 c5                	mov    %eax,%ebp
  8025e0:	31 d2                	xor    %edx,%edx
  8025e2:	89 c8                	mov    %ecx,%eax
  8025e4:	f7 f5                	div    %ebp
  8025e6:	89 c1                	mov    %eax,%ecx
  8025e8:	89 d8                	mov    %ebx,%eax
  8025ea:	f7 f5                	div    %ebp
  8025ec:	89 cf                	mov    %ecx,%edi
  8025ee:	89 fa                	mov    %edi,%edx
  8025f0:	83 c4 1c             	add    $0x1c,%esp
  8025f3:	5b                   	pop    %ebx
  8025f4:	5e                   	pop    %esi
  8025f5:	5f                   	pop    %edi
  8025f6:	5d                   	pop    %ebp
  8025f7:	c3                   	ret    
  8025f8:	39 ce                	cmp    %ecx,%esi
  8025fa:	77 28                	ja     802624 <__udivdi3+0x7c>
  8025fc:	0f bd fe             	bsr    %esi,%edi
  8025ff:	83 f7 1f             	xor    $0x1f,%edi
  802602:	75 40                	jne    802644 <__udivdi3+0x9c>
  802604:	39 ce                	cmp    %ecx,%esi
  802606:	72 0a                	jb     802612 <__udivdi3+0x6a>
  802608:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80260c:	0f 87 9e 00 00 00    	ja     8026b0 <__udivdi3+0x108>
  802612:	b8 01 00 00 00       	mov    $0x1,%eax
  802617:	89 fa                	mov    %edi,%edx
  802619:	83 c4 1c             	add    $0x1c,%esp
  80261c:	5b                   	pop    %ebx
  80261d:	5e                   	pop    %esi
  80261e:	5f                   	pop    %edi
  80261f:	5d                   	pop    %ebp
  802620:	c3                   	ret    
  802621:	8d 76 00             	lea    0x0(%esi),%esi
  802624:	31 ff                	xor    %edi,%edi
  802626:	31 c0                	xor    %eax,%eax
  802628:	89 fa                	mov    %edi,%edx
  80262a:	83 c4 1c             	add    $0x1c,%esp
  80262d:	5b                   	pop    %ebx
  80262e:	5e                   	pop    %esi
  80262f:	5f                   	pop    %edi
  802630:	5d                   	pop    %ebp
  802631:	c3                   	ret    
  802632:	66 90                	xchg   %ax,%ax
  802634:	89 d8                	mov    %ebx,%eax
  802636:	f7 f7                	div    %edi
  802638:	31 ff                	xor    %edi,%edi
  80263a:	89 fa                	mov    %edi,%edx
  80263c:	83 c4 1c             	add    $0x1c,%esp
  80263f:	5b                   	pop    %ebx
  802640:	5e                   	pop    %esi
  802641:	5f                   	pop    %edi
  802642:	5d                   	pop    %ebp
  802643:	c3                   	ret    
  802644:	bd 20 00 00 00       	mov    $0x20,%ebp
  802649:	89 eb                	mov    %ebp,%ebx
  80264b:	29 fb                	sub    %edi,%ebx
  80264d:	89 f9                	mov    %edi,%ecx
  80264f:	d3 e6                	shl    %cl,%esi
  802651:	89 c5                	mov    %eax,%ebp
  802653:	88 d9                	mov    %bl,%cl
  802655:	d3 ed                	shr    %cl,%ebp
  802657:	89 e9                	mov    %ebp,%ecx
  802659:	09 f1                	or     %esi,%ecx
  80265b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80265f:	89 f9                	mov    %edi,%ecx
  802661:	d3 e0                	shl    %cl,%eax
  802663:	89 c5                	mov    %eax,%ebp
  802665:	89 d6                	mov    %edx,%esi
  802667:	88 d9                	mov    %bl,%cl
  802669:	d3 ee                	shr    %cl,%esi
  80266b:	89 f9                	mov    %edi,%ecx
  80266d:	d3 e2                	shl    %cl,%edx
  80266f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802673:	88 d9                	mov    %bl,%cl
  802675:	d3 e8                	shr    %cl,%eax
  802677:	09 c2                	or     %eax,%edx
  802679:	89 d0                	mov    %edx,%eax
  80267b:	89 f2                	mov    %esi,%edx
  80267d:	f7 74 24 0c          	divl   0xc(%esp)
  802681:	89 d6                	mov    %edx,%esi
  802683:	89 c3                	mov    %eax,%ebx
  802685:	f7 e5                	mul    %ebp
  802687:	39 d6                	cmp    %edx,%esi
  802689:	72 19                	jb     8026a4 <__udivdi3+0xfc>
  80268b:	74 0b                	je     802698 <__udivdi3+0xf0>
  80268d:	89 d8                	mov    %ebx,%eax
  80268f:	31 ff                	xor    %edi,%edi
  802691:	e9 58 ff ff ff       	jmp    8025ee <__udivdi3+0x46>
  802696:	66 90                	xchg   %ax,%ax
  802698:	8b 54 24 08          	mov    0x8(%esp),%edx
  80269c:	89 f9                	mov    %edi,%ecx
  80269e:	d3 e2                	shl    %cl,%edx
  8026a0:	39 c2                	cmp    %eax,%edx
  8026a2:	73 e9                	jae    80268d <__udivdi3+0xe5>
  8026a4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8026a7:	31 ff                	xor    %edi,%edi
  8026a9:	e9 40 ff ff ff       	jmp    8025ee <__udivdi3+0x46>
  8026ae:	66 90                	xchg   %ax,%ax
  8026b0:	31 c0                	xor    %eax,%eax
  8026b2:	e9 37 ff ff ff       	jmp    8025ee <__udivdi3+0x46>
  8026b7:	90                   	nop

008026b8 <__umoddi3>:
  8026b8:	55                   	push   %ebp
  8026b9:	57                   	push   %edi
  8026ba:	56                   	push   %esi
  8026bb:	53                   	push   %ebx
  8026bc:	83 ec 1c             	sub    $0x1c,%esp
  8026bf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8026c3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8026c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026cb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8026cf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8026d3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8026d7:	89 f3                	mov    %esi,%ebx
  8026d9:	89 fa                	mov    %edi,%edx
  8026db:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8026df:	89 34 24             	mov    %esi,(%esp)
  8026e2:	85 c0                	test   %eax,%eax
  8026e4:	75 1a                	jne    802700 <__umoddi3+0x48>
  8026e6:	39 f7                	cmp    %esi,%edi
  8026e8:	0f 86 a2 00 00 00    	jbe    802790 <__umoddi3+0xd8>
  8026ee:	89 c8                	mov    %ecx,%eax
  8026f0:	89 f2                	mov    %esi,%edx
  8026f2:	f7 f7                	div    %edi
  8026f4:	89 d0                	mov    %edx,%eax
  8026f6:	31 d2                	xor    %edx,%edx
  8026f8:	83 c4 1c             	add    $0x1c,%esp
  8026fb:	5b                   	pop    %ebx
  8026fc:	5e                   	pop    %esi
  8026fd:	5f                   	pop    %edi
  8026fe:	5d                   	pop    %ebp
  8026ff:	c3                   	ret    
  802700:	39 f0                	cmp    %esi,%eax
  802702:	0f 87 ac 00 00 00    	ja     8027b4 <__umoddi3+0xfc>
  802708:	0f bd e8             	bsr    %eax,%ebp
  80270b:	83 f5 1f             	xor    $0x1f,%ebp
  80270e:	0f 84 ac 00 00 00    	je     8027c0 <__umoddi3+0x108>
  802714:	bf 20 00 00 00       	mov    $0x20,%edi
  802719:	29 ef                	sub    %ebp,%edi
  80271b:	89 fe                	mov    %edi,%esi
  80271d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802721:	89 e9                	mov    %ebp,%ecx
  802723:	d3 e0                	shl    %cl,%eax
  802725:	89 d7                	mov    %edx,%edi
  802727:	89 f1                	mov    %esi,%ecx
  802729:	d3 ef                	shr    %cl,%edi
  80272b:	09 c7                	or     %eax,%edi
  80272d:	89 e9                	mov    %ebp,%ecx
  80272f:	d3 e2                	shl    %cl,%edx
  802731:	89 14 24             	mov    %edx,(%esp)
  802734:	89 d8                	mov    %ebx,%eax
  802736:	d3 e0                	shl    %cl,%eax
  802738:	89 c2                	mov    %eax,%edx
  80273a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80273e:	d3 e0                	shl    %cl,%eax
  802740:	89 44 24 04          	mov    %eax,0x4(%esp)
  802744:	8b 44 24 08          	mov    0x8(%esp),%eax
  802748:	89 f1                	mov    %esi,%ecx
  80274a:	d3 e8                	shr    %cl,%eax
  80274c:	09 d0                	or     %edx,%eax
  80274e:	d3 eb                	shr    %cl,%ebx
  802750:	89 da                	mov    %ebx,%edx
  802752:	f7 f7                	div    %edi
  802754:	89 d3                	mov    %edx,%ebx
  802756:	f7 24 24             	mull   (%esp)
  802759:	89 c6                	mov    %eax,%esi
  80275b:	89 d1                	mov    %edx,%ecx
  80275d:	39 d3                	cmp    %edx,%ebx
  80275f:	0f 82 87 00 00 00    	jb     8027ec <__umoddi3+0x134>
  802765:	0f 84 91 00 00 00    	je     8027fc <__umoddi3+0x144>
  80276b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80276f:	29 f2                	sub    %esi,%edx
  802771:	19 cb                	sbb    %ecx,%ebx
  802773:	89 d8                	mov    %ebx,%eax
  802775:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802779:	d3 e0                	shl    %cl,%eax
  80277b:	89 e9                	mov    %ebp,%ecx
  80277d:	d3 ea                	shr    %cl,%edx
  80277f:	09 d0                	or     %edx,%eax
  802781:	89 e9                	mov    %ebp,%ecx
  802783:	d3 eb                	shr    %cl,%ebx
  802785:	89 da                	mov    %ebx,%edx
  802787:	83 c4 1c             	add    $0x1c,%esp
  80278a:	5b                   	pop    %ebx
  80278b:	5e                   	pop    %esi
  80278c:	5f                   	pop    %edi
  80278d:	5d                   	pop    %ebp
  80278e:	c3                   	ret    
  80278f:	90                   	nop
  802790:	89 fd                	mov    %edi,%ebp
  802792:	85 ff                	test   %edi,%edi
  802794:	75 0b                	jne    8027a1 <__umoddi3+0xe9>
  802796:	b8 01 00 00 00       	mov    $0x1,%eax
  80279b:	31 d2                	xor    %edx,%edx
  80279d:	f7 f7                	div    %edi
  80279f:	89 c5                	mov    %eax,%ebp
  8027a1:	89 f0                	mov    %esi,%eax
  8027a3:	31 d2                	xor    %edx,%edx
  8027a5:	f7 f5                	div    %ebp
  8027a7:	89 c8                	mov    %ecx,%eax
  8027a9:	f7 f5                	div    %ebp
  8027ab:	89 d0                	mov    %edx,%eax
  8027ad:	e9 44 ff ff ff       	jmp    8026f6 <__umoddi3+0x3e>
  8027b2:	66 90                	xchg   %ax,%ax
  8027b4:	89 c8                	mov    %ecx,%eax
  8027b6:	89 f2                	mov    %esi,%edx
  8027b8:	83 c4 1c             	add    $0x1c,%esp
  8027bb:	5b                   	pop    %ebx
  8027bc:	5e                   	pop    %esi
  8027bd:	5f                   	pop    %edi
  8027be:	5d                   	pop    %ebp
  8027bf:	c3                   	ret    
  8027c0:	3b 04 24             	cmp    (%esp),%eax
  8027c3:	72 06                	jb     8027cb <__umoddi3+0x113>
  8027c5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8027c9:	77 0f                	ja     8027da <__umoddi3+0x122>
  8027cb:	89 f2                	mov    %esi,%edx
  8027cd:	29 f9                	sub    %edi,%ecx
  8027cf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8027d3:	89 14 24             	mov    %edx,(%esp)
  8027d6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027da:	8b 44 24 04          	mov    0x4(%esp),%eax
  8027de:	8b 14 24             	mov    (%esp),%edx
  8027e1:	83 c4 1c             	add    $0x1c,%esp
  8027e4:	5b                   	pop    %ebx
  8027e5:	5e                   	pop    %esi
  8027e6:	5f                   	pop    %edi
  8027e7:	5d                   	pop    %ebp
  8027e8:	c3                   	ret    
  8027e9:	8d 76 00             	lea    0x0(%esi),%esi
  8027ec:	2b 04 24             	sub    (%esp),%eax
  8027ef:	19 fa                	sbb    %edi,%edx
  8027f1:	89 d1                	mov    %edx,%ecx
  8027f3:	89 c6                	mov    %eax,%esi
  8027f5:	e9 71 ff ff ff       	jmp    80276b <__umoddi3+0xb3>
  8027fa:	66 90                	xchg   %ax,%ax
  8027fc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802800:	72 ea                	jb     8027ec <__umoddi3+0x134>
  802802:	89 d9                	mov    %ebx,%ecx
  802804:	e9 62 ff ff ff       	jmp    80276b <__umoddi3+0xb3>


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
  800031:	e8 2e 0b 00 00       	call   800b64 <libmain>
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
  800045:	e8 bd 26 00 00       	call   802707 <sys_set_uheap_strategy>
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
  80005a:	a1 20 40 80 00       	mov    0x804020,%eax
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
  80007d:	a1 20 40 80 00       	mov    0x804020,%eax
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
  800095:	68 e0 29 80 00       	push   $0x8029e0
  80009a:	6a 15                	push   $0x15
  80009c:	68 fc 29 80 00       	push   $0x8029fc
  8000a1:	e8 03 0c 00 00       	call   800ca9 <_panic>
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
  8000c5:	e8 a9 21 00 00       	call   802273 <sys_calculate_free_frames>
  8000ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000cd:	e8 24 22 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8000d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(3*Mega-kilo);
  8000d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000d8:	89 c2                	mov    %eax,%edx
  8000da:	01 d2                	add    %edx,%edx
  8000dc:	01 d0                	add    %edx,%eax
  8000de:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000e1:	83 ec 0c             	sub    $0xc,%esp
  8000e4:	50                   	push   %eax
  8000e5:	e8 eb 1b 00 00       	call   801cd5 <malloc>
  8000ea:	83 c4 10             	add    $0x10,%esp
  8000ed:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  8000f0:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000f3:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000f8:	74 14                	je     80010e <_main+0xd6>
  8000fa:	83 ec 04             	sub    $0x4,%esp
  8000fd:	68 14 2a 80 00       	push   $0x802a14
  800102:	6a 23                	push   $0x23
  800104:	68 fc 29 80 00       	push   $0x8029fc
  800109:	e8 9b 0b 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*256) panic("Wrong page file allocation: ");
  80010e:	e8 e3 21 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800113:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800116:	3d 00 03 00 00       	cmp    $0x300,%eax
  80011b:	74 14                	je     800131 <_main+0xf9>
  80011d:	83 ec 04             	sub    $0x4,%esp
  800120:	68 44 2a 80 00       	push   $0x802a44
  800125:	6a 25                	push   $0x25
  800127:	68 fc 29 80 00       	push   $0x8029fc
  80012c:	e8 78 0b 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800131:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800134:	e8 3a 21 00 00       	call   802273 <sys_calculate_free_frames>
  800139:	29 c3                	sub    %eax,%ebx
  80013b:	89 d8                	mov    %ebx,%eax
  80013d:	83 f8 01             	cmp    $0x1,%eax
  800140:	74 14                	je     800156 <_main+0x11e>
  800142:	83 ec 04             	sub    $0x4,%esp
  800145:	68 61 2a 80 00       	push   $0x802a61
  80014a:	6a 26                	push   $0x26
  80014c:	68 fc 29 80 00       	push   $0x8029fc
  800151:	e8 53 0b 00 00       	call   800ca9 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800156:	e8 18 21 00 00       	call   802273 <sys_calculate_free_frames>
  80015b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80015e:	e8 93 21 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800163:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(3*Mega-kilo);
  800166:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800169:	89 c2                	mov    %eax,%edx
  80016b:	01 d2                	add    %edx,%edx
  80016d:	01 d0                	add    %edx,%eax
  80016f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800172:	83 ec 0c             	sub    $0xc,%esp
  800175:	50                   	push   %eax
  800176:	e8 5a 1b 00 00       	call   801cd5 <malloc>
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
  80019b:	68 14 2a 80 00       	push   $0x802a14
  8001a0:	6a 2c                	push   $0x2c
  8001a2:	68 fc 29 80 00       	push   $0x8029fc
  8001a7:	e8 fd 0a 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*256) panic("Wrong page file allocation: ");
  8001ac:	e8 45 21 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8001b1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b4:	3d 00 03 00 00       	cmp    $0x300,%eax
  8001b9:	74 14                	je     8001cf <_main+0x197>
  8001bb:	83 ec 04             	sub    $0x4,%esp
  8001be:	68 44 2a 80 00       	push   $0x802a44
  8001c3:	6a 2e                	push   $0x2e
  8001c5:	68 fc 29 80 00       	push   $0x8029fc
  8001ca:	e8 da 0a 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  8001cf:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8001d2:	e8 9c 20 00 00       	call   802273 <sys_calculate_free_frames>
  8001d7:	29 c3                	sub    %eax,%ebx
  8001d9:	89 d8                	mov    %ebx,%eax
  8001db:	83 f8 01             	cmp    $0x1,%eax
  8001de:	74 14                	je     8001f4 <_main+0x1bc>
  8001e0:	83 ec 04             	sub    $0x4,%esp
  8001e3:	68 61 2a 80 00       	push   $0x802a61
  8001e8:	6a 2f                	push   $0x2f
  8001ea:	68 fc 29 80 00       	push   $0x8029fc
  8001ef:	e8 b5 0a 00 00       	call   800ca9 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8001f4:	e8 7a 20 00 00       	call   802273 <sys_calculate_free_frames>
  8001f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001fc:	e8 f5 20 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800201:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*Mega-kilo);
  800204:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800207:	01 c0                	add    %eax,%eax
  800209:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80020c:	83 ec 0c             	sub    $0xc,%esp
  80020f:	50                   	push   %eax
  800210:	e8 c0 1a 00 00       	call   801cd5 <malloc>
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
  800237:	68 14 2a 80 00       	push   $0x802a14
  80023c:	6a 35                	push   $0x35
  80023e:	68 fc 29 80 00       	push   $0x8029fc
  800243:	e8 61 0a 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  800248:	e8 a9 20 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  80024d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800250:	3d 00 02 00 00       	cmp    $0x200,%eax
  800255:	74 14                	je     80026b <_main+0x233>
  800257:	83 ec 04             	sub    $0x4,%esp
  80025a:	68 44 2a 80 00       	push   $0x802a44
  80025f:	6a 37                	push   $0x37
  800261:	68 fc 29 80 00       	push   $0x8029fc
  800266:	e8 3e 0a 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  80026b:	e8 03 20 00 00       	call   802273 <sys_calculate_free_frames>
  800270:	89 c2                	mov    %eax,%edx
  800272:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800275:	39 c2                	cmp    %eax,%edx
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 61 2a 80 00       	push   $0x802a61
  800281:	6a 38                	push   $0x38
  800283:	68 fc 29 80 00       	push   $0x8029fc
  800288:	e8 1c 0a 00 00       	call   800ca9 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  80028d:	e8 e1 1f 00 00       	call   802273 <sys_calculate_free_frames>
  800292:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800295:	e8 5c 20 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  80029a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*Mega-kilo);
  80029d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002a0:	01 c0                	add    %eax,%eax
  8002a2:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8002a5:	83 ec 0c             	sub    $0xc,%esp
  8002a8:	50                   	push   %eax
  8002a9:	e8 27 1a 00 00       	call   801cd5 <malloc>
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
  8002cb:	68 14 2a 80 00       	push   $0x802a14
  8002d0:	6a 3e                	push   $0x3e
  8002d2:	68 fc 29 80 00       	push   $0x8029fc
  8002d7:	e8 cd 09 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  8002dc:	e8 15 20 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8002e1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002e4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002e9:	74 14                	je     8002ff <_main+0x2c7>
  8002eb:	83 ec 04             	sub    $0x4,%esp
  8002ee:	68 44 2a 80 00       	push   $0x802a44
  8002f3:	6a 40                	push   $0x40
  8002f5:	68 fc 29 80 00       	push   $0x8029fc
  8002fa:	e8 aa 09 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  8002ff:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800302:	e8 6c 1f 00 00       	call   802273 <sys_calculate_free_frames>
  800307:	29 c3                	sub    %eax,%ebx
  800309:	89 d8                	mov    %ebx,%eax
  80030b:	83 f8 01             	cmp    $0x1,%eax
  80030e:	74 14                	je     800324 <_main+0x2ec>
  800310:	83 ec 04             	sub    $0x4,%esp
  800313:	68 61 2a 80 00       	push   $0x802a61
  800318:	6a 41                	push   $0x41
  80031a:	68 fc 29 80 00       	push   $0x8029fc
  80031f:	e8 85 09 00 00       	call   800ca9 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800324:	e8 4a 1f 00 00       	call   802273 <sys_calculate_free_frames>
  800329:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80032c:	e8 c5 1f 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800331:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(1*Mega-kilo);
  800334:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800337:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80033a:	83 ec 0c             	sub    $0xc,%esp
  80033d:	50                   	push   %eax
  80033e:	e8 92 19 00 00       	call   801cd5 <malloc>
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
  800366:	68 14 2a 80 00       	push   $0x802a14
  80036b:	6a 47                	push   $0x47
  80036d:	68 fc 29 80 00       	push   $0x8029fc
  800372:	e8 32 09 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800377:	e8 7a 1f 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  80037c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80037f:	3d 00 01 00 00       	cmp    $0x100,%eax
  800384:	74 14                	je     80039a <_main+0x362>
  800386:	83 ec 04             	sub    $0x4,%esp
  800389:	68 44 2a 80 00       	push   $0x802a44
  80038e:	6a 49                	push   $0x49
  800390:	68 fc 29 80 00       	push   $0x8029fc
  800395:	e8 0f 09 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80039a:	e8 d4 1e 00 00       	call   802273 <sys_calculate_free_frames>
  80039f:	89 c2                	mov    %eax,%edx
  8003a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003a4:	39 c2                	cmp    %eax,%edx
  8003a6:	74 14                	je     8003bc <_main+0x384>
  8003a8:	83 ec 04             	sub    $0x4,%esp
  8003ab:	68 61 2a 80 00       	push   $0x802a61
  8003b0:	6a 4a                	push   $0x4a
  8003b2:	68 fc 29 80 00       	push   $0x8029fc
  8003b7:	e8 ed 08 00 00       	call   800ca9 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8003bc:	e8 b2 1e 00 00       	call   802273 <sys_calculate_free_frames>
  8003c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c4:	e8 2d 1f 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8003c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(1*Mega-kilo);
  8003cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003cf:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003d2:	83 ec 0c             	sub    $0xc,%esp
  8003d5:	50                   	push   %eax
  8003d6:	e8 fa 18 00 00       	call   801cd5 <malloc>
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
  800400:	68 14 2a 80 00       	push   $0x802a14
  800405:	6a 50                	push   $0x50
  800407:	68 fc 29 80 00       	push   $0x8029fc
  80040c:	e8 98 08 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800411:	e8 e0 1e 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800416:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800419:	3d 00 01 00 00       	cmp    $0x100,%eax
  80041e:	74 14                	je     800434 <_main+0x3fc>
  800420:	83 ec 04             	sub    $0x4,%esp
  800423:	68 44 2a 80 00       	push   $0x802a44
  800428:	6a 52                	push   $0x52
  80042a:	68 fc 29 80 00       	push   $0x8029fc
  80042f:	e8 75 08 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800434:	e8 3a 1e 00 00       	call   802273 <sys_calculate_free_frames>
  800439:	89 c2                	mov    %eax,%edx
  80043b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80043e:	39 c2                	cmp    %eax,%edx
  800440:	74 14                	je     800456 <_main+0x41e>
  800442:	83 ec 04             	sub    $0x4,%esp
  800445:	68 61 2a 80 00       	push   $0x802a61
  80044a:	6a 53                	push   $0x53
  80044c:	68 fc 29 80 00       	push   $0x8029fc
  800451:	e8 53 08 00 00       	call   800ca9 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800456:	e8 18 1e 00 00       	call   802273 <sys_calculate_free_frames>
  80045b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80045e:	e8 93 1e 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800463:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(1*Mega-kilo);
  800466:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800469:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80046c:	83 ec 0c             	sub    $0xc,%esp
  80046f:	50                   	push   %eax
  800470:	e8 60 18 00 00       	call   801cd5 <malloc>
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
  800498:	68 14 2a 80 00       	push   $0x802a14
  80049d:	6a 59                	push   $0x59
  80049f:	68 fc 29 80 00       	push   $0x8029fc
  8004a4:	e8 00 08 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8004a9:	e8 48 1e 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8004ae:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004b1:	3d 00 01 00 00       	cmp    $0x100,%eax
  8004b6:	74 14                	je     8004cc <_main+0x494>
  8004b8:	83 ec 04             	sub    $0x4,%esp
  8004bb:	68 44 2a 80 00       	push   $0x802a44
  8004c0:	6a 5b                	push   $0x5b
  8004c2:	68 fc 29 80 00       	push   $0x8029fc
  8004c7:	e8 dd 07 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004cc:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8004cf:	e8 9f 1d 00 00       	call   802273 <sys_calculate_free_frames>
  8004d4:	29 c3                	sub    %eax,%ebx
  8004d6:	89 d8                	mov    %ebx,%eax
  8004d8:	83 f8 01             	cmp    $0x1,%eax
  8004db:	74 14                	je     8004f1 <_main+0x4b9>
  8004dd:	83 ec 04             	sub    $0x4,%esp
  8004e0:	68 61 2a 80 00       	push   $0x802a61
  8004e5:	6a 5c                	push   $0x5c
  8004e7:	68 fc 29 80 00       	push   $0x8029fc
  8004ec:	e8 b8 07 00 00       	call   800ca9 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8004f1:	e8 7d 1d 00 00       	call   802273 <sys_calculate_free_frames>
  8004f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004f9:	e8 f8 1d 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8004fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(1*Mega-kilo);
  800501:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800504:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800507:	83 ec 0c             	sub    $0xc,%esp
  80050a:	50                   	push   %eax
  80050b:	e8 c5 17 00 00       	call   801cd5 <malloc>
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
  800535:	68 14 2a 80 00       	push   $0x802a14
  80053a:	6a 62                	push   $0x62
  80053c:	68 fc 29 80 00       	push   $0x8029fc
  800541:	e8 63 07 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800546:	e8 ab 1d 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  80054b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80054e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800553:	74 14                	je     800569 <_main+0x531>
  800555:	83 ec 04             	sub    $0x4,%esp
  800558:	68 44 2a 80 00       	push   $0x802a44
  80055d:	6a 64                	push   $0x64
  80055f:	68 fc 29 80 00       	push   $0x8029fc
  800564:	e8 40 07 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800569:	e8 05 1d 00 00       	call   802273 <sys_calculate_free_frames>
  80056e:	89 c2                	mov    %eax,%edx
  800570:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800573:	39 c2                	cmp    %eax,%edx
  800575:	74 14                	je     80058b <_main+0x553>
  800577:	83 ec 04             	sub    $0x4,%esp
  80057a:	68 61 2a 80 00       	push   $0x802a61
  80057f:	6a 65                	push   $0x65
  800581:	68 fc 29 80 00       	push   $0x8029fc
  800586:	e8 1e 07 00 00       	call   800ca9 <_panic>
	}

	//[2] Free some to create holes
	{
		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80058b:	e8 e3 1c 00 00       	call   802273 <sys_calculate_free_frames>
  800590:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800593:	e8 5e 1d 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800598:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  80059b:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80059e:	83 ec 0c             	sub    $0xc,%esp
  8005a1:	50                   	push   %eax
  8005a2:	e8 f6 19 00 00       	call   801f9d <free>
  8005a7:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  3*256) panic("Wrong page file free: ");
  8005aa:	e8 47 1d 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8005af:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005b2:	29 c2                	sub    %eax,%edx
  8005b4:	89 d0                	mov    %edx,%eax
  8005b6:	3d 00 03 00 00       	cmp    $0x300,%eax
  8005bb:	74 14                	je     8005d1 <_main+0x599>
  8005bd:	83 ec 04             	sub    $0x4,%esp
  8005c0:	68 74 2a 80 00       	push   $0x802a74
  8005c5:	6a 6f                	push   $0x6f
  8005c7:	68 fc 29 80 00       	push   $0x8029fc
  8005cc:	e8 d8 06 00 00       	call   800ca9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005d1:	e8 9d 1c 00 00       	call   802273 <sys_calculate_free_frames>
  8005d6:	89 c2                	mov    %eax,%edx
  8005d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005db:	39 c2                	cmp    %eax,%edx
  8005dd:	74 14                	je     8005f3 <_main+0x5bb>
  8005df:	83 ec 04             	sub    $0x4,%esp
  8005e2:	68 8b 2a 80 00       	push   $0x802a8b
  8005e7:	6a 70                	push   $0x70
  8005e9:	68 fc 29 80 00       	push   $0x8029fc
  8005ee:	e8 b6 06 00 00       	call   800ca9 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005f3:	e8 7b 1c 00 00       	call   802273 <sys_calculate_free_frames>
  8005f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005fb:	e8 f6 1c 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800600:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[3]);
  800603:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800606:	83 ec 0c             	sub    $0xc,%esp
  800609:	50                   	push   %eax
  80060a:	e8 8e 19 00 00       	call   801f9d <free>
  80060f:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  2*256) panic("Wrong page file free: ");
  800612:	e8 df 1c 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800617:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80061a:	29 c2                	sub    %eax,%edx
  80061c:	89 d0                	mov    %edx,%eax
  80061e:	3d 00 02 00 00       	cmp    $0x200,%eax
  800623:	74 14                	je     800639 <_main+0x601>
  800625:	83 ec 04             	sub    $0x4,%esp
  800628:	68 74 2a 80 00       	push   $0x802a74
  80062d:	6a 77                	push   $0x77
  80062f:	68 fc 29 80 00       	push   $0x8029fc
  800634:	e8 70 06 00 00       	call   800ca9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800639:	e8 35 1c 00 00       	call   802273 <sys_calculate_free_frames>
  80063e:	89 c2                	mov    %eax,%edx
  800640:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800643:	39 c2                	cmp    %eax,%edx
  800645:	74 14                	je     80065b <_main+0x623>
  800647:	83 ec 04             	sub    $0x4,%esp
  80064a:	68 8b 2a 80 00       	push   $0x802a8b
  80064f:	6a 78                	push   $0x78
  800651:	68 fc 29 80 00       	push   $0x8029fc
  800656:	e8 4e 06 00 00       	call   800ca9 <_panic>

		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80065b:	e8 13 1c 00 00       	call   802273 <sys_calculate_free_frames>
  800660:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800663:	e8 8e 1c 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800668:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  80066b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80066e:	83 ec 0c             	sub    $0xc,%esp
  800671:	50                   	push   %eax
  800672:	e8 26 19 00 00       	call   801f9d <free>
  800677:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  80067a:	e8 77 1c 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  80067f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800682:	29 c2                	sub    %eax,%edx
  800684:	89 d0                	mov    %edx,%eax
  800686:	3d 00 01 00 00       	cmp    $0x100,%eax
  80068b:	74 14                	je     8006a1 <_main+0x669>
  80068d:	83 ec 04             	sub    $0x4,%esp
  800690:	68 74 2a 80 00       	push   $0x802a74
  800695:	6a 7f                	push   $0x7f
  800697:	68 fc 29 80 00       	push   $0x8029fc
  80069c:	e8 08 06 00 00       	call   800ca9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8006a1:	e8 cd 1b 00 00       	call   802273 <sys_calculate_free_frames>
  8006a6:	89 c2                	mov    %eax,%edx
  8006a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ab:	39 c2                	cmp    %eax,%edx
  8006ad:	74 17                	je     8006c6 <_main+0x68e>
  8006af:	83 ec 04             	sub    $0x4,%esp
  8006b2:	68 8b 2a 80 00       	push   $0x802a8b
  8006b7:	68 80 00 00 00       	push   $0x80
  8006bc:	68 fc 29 80 00       	push   $0x8029fc
  8006c1:	e8 e3 05 00 00       	call   800ca9 <_panic>
	}

	//[3] Allocate again [test best fit]
	{
		//Allocate 512 KB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  8006c6:	e8 a8 1b 00 00       	call   802273 <sys_calculate_free_frames>
  8006cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006ce:	e8 23 1c 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8006d3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(512*kilo);
  8006d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006d9:	c1 e0 09             	shl    $0x9,%eax
  8006dc:	83 ec 0c             	sub    $0xc,%esp
  8006df:	50                   	push   %eax
  8006e0:	e8 f0 15 00 00       	call   801cd5 <malloc>
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
  80070a:	68 14 2a 80 00       	push   $0x802a14
  80070f:	68 89 00 00 00       	push   $0x89
  800714:	68 fc 29 80 00       	push   $0x8029fc
  800719:	e8 8b 05 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  80071e:	e8 d3 1b 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800723:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800726:	3d 80 00 00 00       	cmp    $0x80,%eax
  80072b:	74 17                	je     800744 <_main+0x70c>
  80072d:	83 ec 04             	sub    $0x4,%esp
  800730:	68 44 2a 80 00       	push   $0x802a44
  800735:	68 8b 00 00 00       	push   $0x8b
  80073a:	68 fc 29 80 00       	push   $0x8029fc
  80073f:	e8 65 05 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800744:	e8 2a 1b 00 00       	call   802273 <sys_calculate_free_frames>
  800749:	89 c2                	mov    %eax,%edx
  80074b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80074e:	39 c2                	cmp    %eax,%edx
  800750:	74 17                	je     800769 <_main+0x731>
  800752:	83 ec 04             	sub    $0x4,%esp
  800755:	68 61 2a 80 00       	push   $0x802a61
  80075a:	68 8c 00 00 00       	push   $0x8c
  80075f:	68 fc 29 80 00       	push   $0x8029fc
  800764:	e8 40 05 00 00       	call   800ca9 <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800769:	e8 05 1b 00 00       	call   802273 <sys_calculate_free_frames>
  80076e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800771:	e8 80 1b 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800776:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  800779:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80077c:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80077f:	83 ec 0c             	sub    $0xc,%esp
  800782:	50                   	push   %eax
  800783:	e8 4d 15 00 00       	call   801cd5 <malloc>
  800788:	83 c4 10             	add    $0x10,%esp
  80078b:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		cprintf("ptralloc :  %x\n",ptr_allocations[9]);
  80078e:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800791:	83 ec 08             	sub    $0x8,%esp
  800794:	50                   	push   %eax
  800795:	68 98 2a 80 00       	push   $0x802a98
  80079a:	e8 ac 07 00 00       	call   800f4b <cprintf>
  80079f:	83 c4 10             	add    $0x10,%esp
		cprintf("acctual :  %x\n",USER_HEAP_START + 8*Mega);
  8007a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007a5:	c1 e0 03             	shl    $0x3,%eax
  8007a8:	05 00 00 00 80       	add    $0x80000000,%eax
  8007ad:	83 ec 08             	sub    $0x8,%esp
  8007b0:	50                   	push   %eax
  8007b1:	68 a8 2a 80 00       	push   $0x802aa8
  8007b6:	e8 90 07 00 00       	call   800f4b <cprintf>
  8007bb:	83 c4 10             	add    $0x10,%esp
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8007be:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8007c1:	89 c2                	mov    %eax,%edx
  8007c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007c6:	c1 e0 03             	shl    $0x3,%eax
  8007c9:	05 00 00 00 80       	add    $0x80000000,%eax
  8007ce:	39 c2                	cmp    %eax,%edx
  8007d0:	74 17                	je     8007e9 <_main+0x7b1>
  8007d2:	83 ec 04             	sub    $0x4,%esp
  8007d5:	68 14 2a 80 00       	push   $0x802a14
  8007da:	68 94 00 00 00       	push   $0x94
  8007df:	68 fc 29 80 00       	push   $0x8029fc
  8007e4:	e8 c0 04 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007e9:	e8 08 1b 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8007ee:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007f1:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007f6:	74 17                	je     80080f <_main+0x7d7>
  8007f8:	83 ec 04             	sub    $0x4,%esp
  8007fb:	68 44 2a 80 00       	push   $0x802a44
  800800:	68 96 00 00 00       	push   $0x96
  800805:	68 fc 29 80 00       	push   $0x8029fc
  80080a:	e8 9a 04 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80080f:	e8 5f 1a 00 00       	call   802273 <sys_calculate_free_frames>
  800814:	89 c2                	mov    %eax,%edx
  800816:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800819:	39 c2                	cmp    %eax,%edx
  80081b:	74 17                	je     800834 <_main+0x7fc>
  80081d:	83 ec 04             	sub    $0x4,%esp
  800820:	68 61 2a 80 00       	push   $0x802a61
  800825:	68 97 00 00 00       	push   $0x97
  80082a:	68 fc 29 80 00       	push   $0x8029fc
  80082f:	e8 75 04 00 00       	call   800ca9 <_panic>

		//Allocate 256 KB - should be placed in remaining of 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  800834:	e8 3a 1a 00 00       	call   802273 <sys_calculate_free_frames>
  800839:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80083c:	e8 b5 1a 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800841:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  800844:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800847:	89 d0                	mov    %edx,%eax
  800849:	c1 e0 08             	shl    $0x8,%eax
  80084c:	29 d0                	sub    %edx,%eax
  80084e:	83 ec 0c             	sub    $0xc,%esp
  800851:	50                   	push   %eax
  800852:	e8 7e 14 00 00       	call   801cd5 <malloc>
  800857:	83 c4 10             	add    $0x10,%esp
  80085a:	89 45 b8             	mov    %eax,-0x48(%ebp)
		cprintf("ptralloc :  %x\n",ptr_allocations[10]);
  80085d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800860:	83 ec 08             	sub    $0x8,%esp
  800863:	50                   	push   %eax
  800864:	68 98 2a 80 00       	push   $0x802a98
  800869:	e8 dd 06 00 00       	call   800f4b <cprintf>
  80086e:	83 c4 10             	add    $0x10,%esp
				cprintf("acctual :  %x\n",USER_HEAP_START + 11*Mega + 512*kilo);
  800871:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800874:	89 d0                	mov    %edx,%eax
  800876:	c1 e0 02             	shl    $0x2,%eax
  800879:	01 d0                	add    %edx,%eax
  80087b:	01 c0                	add    %eax,%eax
  80087d:	01 d0                	add    %edx,%eax
  80087f:	89 c2                	mov    %eax,%edx
  800881:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800884:	c1 e0 09             	shl    $0x9,%eax
  800887:	01 d0                	add    %edx,%eax
  800889:	05 00 00 00 80       	add    $0x80000000,%eax
  80088e:	83 ec 08             	sub    $0x8,%esp
  800891:	50                   	push   %eax
  800892:	68 a8 2a 80 00       	push   $0x802aa8
  800897:	e8 af 06 00 00       	call   800f4b <cprintf>
  80089c:	83 c4 10             	add    $0x10,%esp
		if ((uint32) ptr_allocations[10] !=  (USER_HEAP_START + 11*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  80089f:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8008a2:	89 c1                	mov    %eax,%ecx
  8008a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8008a7:	89 d0                	mov    %edx,%eax
  8008a9:	c1 e0 02             	shl    $0x2,%eax
  8008ac:	01 d0                	add    %edx,%eax
  8008ae:	01 c0                	add    %eax,%eax
  8008b0:	01 d0                	add    %edx,%eax
  8008b2:	89 c2                	mov    %eax,%edx
  8008b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008b7:	c1 e0 09             	shl    $0x9,%eax
  8008ba:	01 d0                	add    %edx,%eax
  8008bc:	05 00 00 00 80       	add    $0x80000000,%eax
  8008c1:	39 c1                	cmp    %eax,%ecx
  8008c3:	74 17                	je     8008dc <_main+0x8a4>
  8008c5:	83 ec 04             	sub    $0x4,%esp
  8008c8:	68 14 2a 80 00       	push   $0x802a14
  8008cd:	68 9f 00 00 00       	push   $0x9f
  8008d2:	68 fc 29 80 00       	push   $0x8029fc
  8008d7:	e8 cd 03 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  8008dc:	e8 15 1a 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8008e1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8008e4:	83 f8 40             	cmp    $0x40,%eax
  8008e7:	74 17                	je     800900 <_main+0x8c8>
  8008e9:	83 ec 04             	sub    $0x4,%esp
  8008ec:	68 44 2a 80 00       	push   $0x802a44
  8008f1:	68 a1 00 00 00       	push   $0xa1
  8008f6:	68 fc 29 80 00       	push   $0x8029fc
  8008fb:	e8 a9 03 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800900:	e8 6e 19 00 00       	call   802273 <sys_calculate_free_frames>
  800905:	89 c2                	mov    %eax,%edx
  800907:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80090a:	39 c2                	cmp    %eax,%edx
  80090c:	74 17                	je     800925 <_main+0x8ed>
  80090e:	83 ec 04             	sub    $0x4,%esp
  800911:	68 61 2a 80 00       	push   $0x802a61
  800916:	68 a2 00 00 00       	push   $0xa2
  80091b:	68 fc 29 80 00       	push   $0x8029fc
  800920:	e8 84 03 00 00       	call   800ca9 <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  800925:	e8 49 19 00 00       	call   802273 <sys_calculate_free_frames>
  80092a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80092d:	e8 c4 19 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800932:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(4*Mega - kilo);
  800935:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800938:	c1 e0 02             	shl    $0x2,%eax
  80093b:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80093e:	83 ec 0c             	sub    $0xc,%esp
  800941:	50                   	push   %eax
  800942:	e8 8e 13 00 00       	call   801cd5 <malloc>
  800947:	83 c4 10             	add    $0x10,%esp
  80094a:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the allocated space... ");
  80094d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800950:	89 c1                	mov    %eax,%ecx
  800952:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800955:	89 d0                	mov    %edx,%eax
  800957:	01 c0                	add    %eax,%eax
  800959:	01 d0                	add    %edx,%eax
  80095b:	01 c0                	add    %eax,%eax
  80095d:	01 d0                	add    %edx,%eax
  80095f:	01 c0                	add    %eax,%eax
  800961:	05 00 00 00 80       	add    $0x80000000,%eax
  800966:	39 c1                	cmp    %eax,%ecx
  800968:	74 17                	je     800981 <_main+0x949>
  80096a:	83 ec 04             	sub    $0x4,%esp
  80096d:	68 14 2a 80 00       	push   $0x802a14
  800972:	68 a8 00 00 00       	push   $0xa8
  800977:	68 fc 29 80 00       	push   $0x8029fc
  80097c:	e8 28 03 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  800981:	e8 70 19 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800986:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800989:	3d 00 04 00 00       	cmp    $0x400,%eax
  80098e:	74 17                	je     8009a7 <_main+0x96f>
  800990:	83 ec 04             	sub    $0x4,%esp
  800993:	68 44 2a 80 00       	push   $0x802a44
  800998:	68 aa 00 00 00       	push   $0xaa
  80099d:	68 fc 29 80 00       	push   $0x8029fc
  8009a2:	e8 02 03 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8009a7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8009aa:	e8 c4 18 00 00       	call   802273 <sys_calculate_free_frames>
  8009af:	29 c3                	sub    %eax,%ebx
  8009b1:	89 d8                	mov    %ebx,%eax
  8009b3:	83 f8 01             	cmp    $0x1,%eax
  8009b6:	74 17                	je     8009cf <_main+0x997>
  8009b8:	83 ec 04             	sub    $0x4,%esp
  8009bb:	68 61 2a 80 00       	push   $0x802a61
  8009c0:	68 ab 00 00 00       	push   $0xab
  8009c5:	68 fc 29 80 00       	push   $0x8029fc
  8009ca:	e8 da 02 00 00       	call   800ca9 <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1M Hole appended to already existing 1M hole in the middle
		freeFrames = sys_calculate_free_frames() ;
  8009cf:	e8 9f 18 00 00       	call   802273 <sys_calculate_free_frames>
  8009d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009d7:	e8 1a 19 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8009dc:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[4]);
  8009df:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8009e2:	83 ec 0c             	sub    $0xc,%esp
  8009e5:	50                   	push   %eax
  8009e6:	e8 b2 15 00 00       	call   801f9d <free>
  8009eb:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  8009ee:	e8 03 19 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  8009f3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009f6:	29 c2                	sub    %eax,%edx
  8009f8:	89 d0                	mov    %edx,%eax
  8009fa:	3d 00 01 00 00       	cmp    $0x100,%eax
  8009ff:	74 17                	je     800a18 <_main+0x9e0>
  800a01:	83 ec 04             	sub    $0x4,%esp
  800a04:	68 74 2a 80 00       	push   $0x802a74
  800a09:	68 b5 00 00 00       	push   $0xb5
  800a0e:	68 fc 29 80 00       	push   $0x8029fc
  800a13:	e8 91 02 00 00       	call   800ca9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a18:	e8 56 18 00 00       	call   802273 <sys_calculate_free_frames>
  800a1d:	89 c2                	mov    %eax,%edx
  800a1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a22:	39 c2                	cmp    %eax,%edx
  800a24:	74 17                	je     800a3d <_main+0xa05>
  800a26:	83 ec 04             	sub    $0x4,%esp
  800a29:	68 8b 2a 80 00       	push   $0x802a8b
  800a2e:	68 b6 00 00 00       	push   $0xb6
  800a33:	68 fc 29 80 00       	push   $0x8029fc
  800a38:	e8 6c 02 00 00       	call   800ca9 <_panic>

		//another 512 KB Hole appended to the hole
		freeFrames = sys_calculate_free_frames() ;
  800a3d:	e8 31 18 00 00       	call   802273 <sys_calculate_free_frames>
  800a42:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a45:	e8 ac 18 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800a4a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[8]);
  800a4d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800a50:	83 ec 0c             	sub    $0xc,%esp
  800a53:	50                   	push   %eax
  800a54:	e8 44 15 00 00       	call   801f9d <free>
  800a59:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  128) panic("Wrong page file free: ");
  800a5c:	e8 95 18 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800a61:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a64:	29 c2                	sub    %eax,%edx
  800a66:	89 d0                	mov    %edx,%eax
  800a68:	3d 80 00 00 00       	cmp    $0x80,%eax
  800a6d:	74 17                	je     800a86 <_main+0xa4e>
  800a6f:	83 ec 04             	sub    $0x4,%esp
  800a72:	68 74 2a 80 00       	push   $0x802a74
  800a77:	68 bd 00 00 00       	push   $0xbd
  800a7c:	68 fc 29 80 00       	push   $0x8029fc
  800a81:	e8 23 02 00 00       	call   800ca9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a86:	e8 e8 17 00 00       	call   802273 <sys_calculate_free_frames>
  800a8b:	89 c2                	mov    %eax,%edx
  800a8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a90:	39 c2                	cmp    %eax,%edx
  800a92:	74 17                	je     800aab <_main+0xa73>
  800a94:	83 ec 04             	sub    $0x4,%esp
  800a97:	68 8b 2a 80 00       	push   $0x802a8b
  800a9c:	68 be 00 00 00       	push   $0xbe
  800aa1:	68 fc 29 80 00       	push   $0x8029fc
  800aa6:	e8 fe 01 00 00       	call   800ca9 <_panic>
	}

	//[5] Allocate again [test best fit]
	{
		//Allocate 2 MB - should be placed in the contiguous hole (2 MB + 512 KB)
		freeFrames = sys_calculate_free_frames();
  800aab:	e8 c3 17 00 00       	call   802273 <sys_calculate_free_frames>
  800ab0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800ab3:	e8 3e 18 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800ab8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[12] = malloc(2*Mega - kilo);
  800abb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800abe:	01 c0                	add    %eax,%eax
  800ac0:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800ac3:	83 ec 0c             	sub    $0xc,%esp
  800ac6:	50                   	push   %eax
  800ac7:	e8 09 12 00 00       	call   801cd5 <malloc>
  800acc:	83 c4 10             	add    $0x10,%esp
  800acf:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 9*Mega)) panic("Wrong start address for the allocated space... ");
  800ad2:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800ad5:	89 c1                	mov    %eax,%ecx
  800ad7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ada:	89 d0                	mov    %edx,%eax
  800adc:	c1 e0 03             	shl    $0x3,%eax
  800adf:	01 d0                	add    %edx,%eax
  800ae1:	05 00 00 00 80       	add    $0x80000000,%eax
  800ae6:	39 c1                	cmp    %eax,%ecx
  800ae8:	74 17                	je     800b01 <_main+0xac9>
  800aea:	83 ec 04             	sub    $0x4,%esp
  800aed:	68 14 2a 80 00       	push   $0x802a14
  800af2:	68 c7 00 00 00       	push   $0xc7
  800af7:	68 fc 29 80 00       	push   $0x8029fc
  800afc:	e8 a8 01 00 00       	call   800ca9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  800b01:	e8 f0 17 00 00       	call   8022f6 <sys_pf_calculate_allocated_pages>
  800b06:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800b09:	3d 00 02 00 00       	cmp    $0x200,%eax
  800b0e:	74 17                	je     800b27 <_main+0xaef>
  800b10:	83 ec 04             	sub    $0x4,%esp
  800b13:	68 44 2a 80 00       	push   $0x802a44
  800b18:	68 c9 00 00 00       	push   $0xc9
  800b1d:	68 fc 29 80 00       	push   $0x8029fc
  800b22:	e8 82 01 00 00       	call   800ca9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800b27:	e8 47 17 00 00       	call   802273 <sys_calculate_free_frames>
  800b2c:	89 c2                	mov    %eax,%edx
  800b2e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b31:	39 c2                	cmp    %eax,%edx
  800b33:	74 17                	je     800b4c <_main+0xb14>
  800b35:	83 ec 04             	sub    $0x4,%esp
  800b38:	68 61 2a 80 00       	push   $0x802a61
  800b3d:	68 ca 00 00 00       	push   $0xca
  800b42:	68 fc 29 80 00       	push   $0x8029fc
  800b47:	e8 5d 01 00 00       	call   800ca9 <_panic>
	}
	cprintf("Congratulations!! test BEST FIT allocation (1) completed successfully.\n");
  800b4c:	83 ec 0c             	sub    $0xc,%esp
  800b4f:	68 b8 2a 80 00       	push   $0x802ab8
  800b54:	e8 f2 03 00 00       	call   800f4b <cprintf>
  800b59:	83 c4 10             	add    $0x10,%esp

	return;
  800b5c:	90                   	nop
}
  800b5d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b60:	5b                   	pop    %ebx
  800b61:	5f                   	pop    %edi
  800b62:	5d                   	pop    %ebp
  800b63:	c3                   	ret    

00800b64 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800b64:	55                   	push   %ebp
  800b65:	89 e5                	mov    %esp,%ebp
  800b67:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800b6a:	e8 39 16 00 00       	call   8021a8 <sys_getenvindex>
  800b6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800b72:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b75:	89 d0                	mov    %edx,%eax
  800b77:	c1 e0 03             	shl    $0x3,%eax
  800b7a:	01 d0                	add    %edx,%eax
  800b7c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800b83:	01 c8                	add    %ecx,%eax
  800b85:	01 c0                	add    %eax,%eax
  800b87:	01 d0                	add    %edx,%eax
  800b89:	01 c0                	add    %eax,%eax
  800b8b:	01 d0                	add    %edx,%eax
  800b8d:	89 c2                	mov    %eax,%edx
  800b8f:	c1 e2 05             	shl    $0x5,%edx
  800b92:	29 c2                	sub    %eax,%edx
  800b94:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800b9b:	89 c2                	mov    %eax,%edx
  800b9d:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800ba3:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800ba8:	a1 20 40 80 00       	mov    0x804020,%eax
  800bad:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800bb3:	84 c0                	test   %al,%al
  800bb5:	74 0f                	je     800bc6 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800bb7:	a1 20 40 80 00       	mov    0x804020,%eax
  800bbc:	05 40 3c 01 00       	add    $0x13c40,%eax
  800bc1:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800bc6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bca:	7e 0a                	jle    800bd6 <libmain+0x72>
		binaryname = argv[0];
  800bcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bcf:	8b 00                	mov    (%eax),%eax
  800bd1:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800bd6:	83 ec 08             	sub    $0x8,%esp
  800bd9:	ff 75 0c             	pushl  0xc(%ebp)
  800bdc:	ff 75 08             	pushl  0x8(%ebp)
  800bdf:	e8 54 f4 ff ff       	call   800038 <_main>
  800be4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800be7:	e8 57 17 00 00       	call   802343 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800bec:	83 ec 0c             	sub    $0xc,%esp
  800bef:	68 18 2b 80 00       	push   $0x802b18
  800bf4:	e8 52 03 00 00       	call   800f4b <cprintf>
  800bf9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800bfc:	a1 20 40 80 00       	mov    0x804020,%eax
  800c01:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800c07:	a1 20 40 80 00       	mov    0x804020,%eax
  800c0c:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800c12:	83 ec 04             	sub    $0x4,%esp
  800c15:	52                   	push   %edx
  800c16:	50                   	push   %eax
  800c17:	68 40 2b 80 00       	push   $0x802b40
  800c1c:	e8 2a 03 00 00       	call   800f4b <cprintf>
  800c21:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800c24:	a1 20 40 80 00       	mov    0x804020,%eax
  800c29:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800c2f:	a1 20 40 80 00       	mov    0x804020,%eax
  800c34:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800c3a:	83 ec 04             	sub    $0x4,%esp
  800c3d:	52                   	push   %edx
  800c3e:	50                   	push   %eax
  800c3f:	68 68 2b 80 00       	push   $0x802b68
  800c44:	e8 02 03 00 00       	call   800f4b <cprintf>
  800c49:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800c4c:	a1 20 40 80 00       	mov    0x804020,%eax
  800c51:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800c57:	83 ec 08             	sub    $0x8,%esp
  800c5a:	50                   	push   %eax
  800c5b:	68 a9 2b 80 00       	push   $0x802ba9
  800c60:	e8 e6 02 00 00       	call   800f4b <cprintf>
  800c65:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800c68:	83 ec 0c             	sub    $0xc,%esp
  800c6b:	68 18 2b 80 00       	push   $0x802b18
  800c70:	e8 d6 02 00 00       	call   800f4b <cprintf>
  800c75:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800c78:	e8 e0 16 00 00       	call   80235d <sys_enable_interrupt>

	// exit gracefully
	exit();
  800c7d:	e8 19 00 00 00       	call   800c9b <exit>
}
  800c82:	90                   	nop
  800c83:	c9                   	leave  
  800c84:	c3                   	ret    

00800c85 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800c85:	55                   	push   %ebp
  800c86:	89 e5                	mov    %esp,%ebp
  800c88:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800c8b:	83 ec 0c             	sub    $0xc,%esp
  800c8e:	6a 00                	push   $0x0
  800c90:	e8 df 14 00 00       	call   802174 <sys_env_destroy>
  800c95:	83 c4 10             	add    $0x10,%esp
}
  800c98:	90                   	nop
  800c99:	c9                   	leave  
  800c9a:	c3                   	ret    

00800c9b <exit>:

void
exit(void)
{
  800c9b:	55                   	push   %ebp
  800c9c:	89 e5                	mov    %esp,%ebp
  800c9e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800ca1:	e8 34 15 00 00       	call   8021da <sys_env_exit>
}
  800ca6:	90                   	nop
  800ca7:	c9                   	leave  
  800ca8:	c3                   	ret    

00800ca9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800ca9:	55                   	push   %ebp
  800caa:	89 e5                	mov    %esp,%ebp
  800cac:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800caf:	8d 45 10             	lea    0x10(%ebp),%eax
  800cb2:	83 c0 04             	add    $0x4,%eax
  800cb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800cb8:	a1 18 41 80 00       	mov    0x804118,%eax
  800cbd:	85 c0                	test   %eax,%eax
  800cbf:	74 16                	je     800cd7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800cc1:	a1 18 41 80 00       	mov    0x804118,%eax
  800cc6:	83 ec 08             	sub    $0x8,%esp
  800cc9:	50                   	push   %eax
  800cca:	68 c0 2b 80 00       	push   $0x802bc0
  800ccf:	e8 77 02 00 00       	call   800f4b <cprintf>
  800cd4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800cd7:	a1 00 40 80 00       	mov    0x804000,%eax
  800cdc:	ff 75 0c             	pushl  0xc(%ebp)
  800cdf:	ff 75 08             	pushl  0x8(%ebp)
  800ce2:	50                   	push   %eax
  800ce3:	68 c5 2b 80 00       	push   $0x802bc5
  800ce8:	e8 5e 02 00 00       	call   800f4b <cprintf>
  800ced:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800cf0:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf3:	83 ec 08             	sub    $0x8,%esp
  800cf6:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf9:	50                   	push   %eax
  800cfa:	e8 e1 01 00 00       	call   800ee0 <vcprintf>
  800cff:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800d02:	83 ec 08             	sub    $0x8,%esp
  800d05:	6a 00                	push   $0x0
  800d07:	68 e1 2b 80 00       	push   $0x802be1
  800d0c:	e8 cf 01 00 00       	call   800ee0 <vcprintf>
  800d11:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800d14:	e8 82 ff ff ff       	call   800c9b <exit>

	// should not return here
	while (1) ;
  800d19:	eb fe                	jmp    800d19 <_panic+0x70>

00800d1b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800d1b:	55                   	push   %ebp
  800d1c:	89 e5                	mov    %esp,%ebp
  800d1e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800d21:	a1 20 40 80 00       	mov    0x804020,%eax
  800d26:	8b 50 74             	mov    0x74(%eax),%edx
  800d29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2c:	39 c2                	cmp    %eax,%edx
  800d2e:	74 14                	je     800d44 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800d30:	83 ec 04             	sub    $0x4,%esp
  800d33:	68 e4 2b 80 00       	push   $0x802be4
  800d38:	6a 26                	push   $0x26
  800d3a:	68 30 2c 80 00       	push   $0x802c30
  800d3f:	e8 65 ff ff ff       	call   800ca9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800d44:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800d4b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800d52:	e9 b6 00 00 00       	jmp    800e0d <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800d57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d5a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	01 d0                	add    %edx,%eax
  800d66:	8b 00                	mov    (%eax),%eax
  800d68:	85 c0                	test   %eax,%eax
  800d6a:	75 08                	jne    800d74 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800d6c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800d6f:	e9 96 00 00 00       	jmp    800e0a <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800d74:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d7b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800d82:	eb 5d                	jmp    800de1 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800d84:	a1 20 40 80 00       	mov    0x804020,%eax
  800d89:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d8f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d92:	c1 e2 04             	shl    $0x4,%edx
  800d95:	01 d0                	add    %edx,%eax
  800d97:	8a 40 04             	mov    0x4(%eax),%al
  800d9a:	84 c0                	test   %al,%al
  800d9c:	75 40                	jne    800dde <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d9e:	a1 20 40 80 00       	mov    0x804020,%eax
  800da3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800da9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800dac:	c1 e2 04             	shl    $0x4,%edx
  800daf:	01 d0                	add    %edx,%eax
  800db1:	8b 00                	mov    (%eax),%eax
  800db3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800db6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800db9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dbe:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800dc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800dca:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcd:	01 c8                	add    %ecx,%eax
  800dcf:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800dd1:	39 c2                	cmp    %eax,%edx
  800dd3:	75 09                	jne    800dde <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800dd5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800ddc:	eb 12                	jmp    800df0 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dde:	ff 45 e8             	incl   -0x18(%ebp)
  800de1:	a1 20 40 80 00       	mov    0x804020,%eax
  800de6:	8b 50 74             	mov    0x74(%eax),%edx
  800de9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800dec:	39 c2                	cmp    %eax,%edx
  800dee:	77 94                	ja     800d84 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800df0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800df4:	75 14                	jne    800e0a <CheckWSWithoutLastIndex+0xef>
			panic(
  800df6:	83 ec 04             	sub    $0x4,%esp
  800df9:	68 3c 2c 80 00       	push   $0x802c3c
  800dfe:	6a 3a                	push   $0x3a
  800e00:	68 30 2c 80 00       	push   $0x802c30
  800e05:	e8 9f fe ff ff       	call   800ca9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800e0a:	ff 45 f0             	incl   -0x10(%ebp)
  800e0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e10:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800e13:	0f 8c 3e ff ff ff    	jl     800d57 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800e19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e20:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800e27:	eb 20                	jmp    800e49 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800e29:	a1 20 40 80 00       	mov    0x804020,%eax
  800e2e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800e34:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e37:	c1 e2 04             	shl    $0x4,%edx
  800e3a:	01 d0                	add    %edx,%eax
  800e3c:	8a 40 04             	mov    0x4(%eax),%al
  800e3f:	3c 01                	cmp    $0x1,%al
  800e41:	75 03                	jne    800e46 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800e43:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e46:	ff 45 e0             	incl   -0x20(%ebp)
  800e49:	a1 20 40 80 00       	mov    0x804020,%eax
  800e4e:	8b 50 74             	mov    0x74(%eax),%edx
  800e51:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e54:	39 c2                	cmp    %eax,%edx
  800e56:	77 d1                	ja     800e29 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800e58:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e5b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800e5e:	74 14                	je     800e74 <CheckWSWithoutLastIndex+0x159>
		panic(
  800e60:	83 ec 04             	sub    $0x4,%esp
  800e63:	68 90 2c 80 00       	push   $0x802c90
  800e68:	6a 44                	push   $0x44
  800e6a:	68 30 2c 80 00       	push   $0x802c30
  800e6f:	e8 35 fe ff ff       	call   800ca9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800e74:	90                   	nop
  800e75:	c9                   	leave  
  800e76:	c3                   	ret    

00800e77 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800e77:	55                   	push   %ebp
  800e78:	89 e5                	mov    %esp,%ebp
  800e7a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800e7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e80:	8b 00                	mov    (%eax),%eax
  800e82:	8d 48 01             	lea    0x1(%eax),%ecx
  800e85:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e88:	89 0a                	mov    %ecx,(%edx)
  800e8a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e8d:	88 d1                	mov    %dl,%cl
  800e8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e92:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800e96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e99:	8b 00                	mov    (%eax),%eax
  800e9b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ea0:	75 2c                	jne    800ece <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ea2:	a0 24 40 80 00       	mov    0x804024,%al
  800ea7:	0f b6 c0             	movzbl %al,%eax
  800eaa:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ead:	8b 12                	mov    (%edx),%edx
  800eaf:	89 d1                	mov    %edx,%ecx
  800eb1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eb4:	83 c2 08             	add    $0x8,%edx
  800eb7:	83 ec 04             	sub    $0x4,%esp
  800eba:	50                   	push   %eax
  800ebb:	51                   	push   %ecx
  800ebc:	52                   	push   %edx
  800ebd:	e8 70 12 00 00       	call   802132 <sys_cputs>
  800ec2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800ece:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed1:	8b 40 04             	mov    0x4(%eax),%eax
  800ed4:	8d 50 01             	lea    0x1(%eax),%edx
  800ed7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eda:	89 50 04             	mov    %edx,0x4(%eax)
}
  800edd:	90                   	nop
  800ede:	c9                   	leave  
  800edf:	c3                   	ret    

00800ee0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ee0:	55                   	push   %ebp
  800ee1:	89 e5                	mov    %esp,%ebp
  800ee3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800ee9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ef0:	00 00 00 
	b.cnt = 0;
  800ef3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800efa:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800efd:	ff 75 0c             	pushl  0xc(%ebp)
  800f00:	ff 75 08             	pushl  0x8(%ebp)
  800f03:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f09:	50                   	push   %eax
  800f0a:	68 77 0e 80 00       	push   $0x800e77
  800f0f:	e8 11 02 00 00       	call   801125 <vprintfmt>
  800f14:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800f17:	a0 24 40 80 00       	mov    0x804024,%al
  800f1c:	0f b6 c0             	movzbl %al,%eax
  800f1f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800f25:	83 ec 04             	sub    $0x4,%esp
  800f28:	50                   	push   %eax
  800f29:	52                   	push   %edx
  800f2a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f30:	83 c0 08             	add    $0x8,%eax
  800f33:	50                   	push   %eax
  800f34:	e8 f9 11 00 00       	call   802132 <sys_cputs>
  800f39:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800f3c:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  800f43:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800f49:	c9                   	leave  
  800f4a:	c3                   	ret    

00800f4b <cprintf>:

int cprintf(const char *fmt, ...) {
  800f4b:	55                   	push   %ebp
  800f4c:	89 e5                	mov    %esp,%ebp
  800f4e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800f51:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  800f58:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	83 ec 08             	sub    $0x8,%esp
  800f64:	ff 75 f4             	pushl  -0xc(%ebp)
  800f67:	50                   	push   %eax
  800f68:	e8 73 ff ff ff       	call   800ee0 <vcprintf>
  800f6d:	83 c4 10             	add    $0x10,%esp
  800f70:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800f73:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f76:	c9                   	leave  
  800f77:	c3                   	ret    

00800f78 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800f78:	55                   	push   %ebp
  800f79:	89 e5                	mov    %esp,%ebp
  800f7b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800f7e:	e8 c0 13 00 00       	call   802343 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800f83:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f86:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	83 ec 08             	sub    $0x8,%esp
  800f8f:	ff 75 f4             	pushl  -0xc(%ebp)
  800f92:	50                   	push   %eax
  800f93:	e8 48 ff ff ff       	call   800ee0 <vcprintf>
  800f98:	83 c4 10             	add    $0x10,%esp
  800f9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800f9e:	e8 ba 13 00 00       	call   80235d <sys_enable_interrupt>
	return cnt;
  800fa3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fa6:	c9                   	leave  
  800fa7:	c3                   	ret    

00800fa8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800fa8:	55                   	push   %ebp
  800fa9:	89 e5                	mov    %esp,%ebp
  800fab:	53                   	push   %ebx
  800fac:	83 ec 14             	sub    $0x14,%esp
  800faf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800fbb:	8b 45 18             	mov    0x18(%ebp),%eax
  800fbe:	ba 00 00 00 00       	mov    $0x0,%edx
  800fc3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800fc6:	77 55                	ja     80101d <printnum+0x75>
  800fc8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800fcb:	72 05                	jb     800fd2 <printnum+0x2a>
  800fcd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fd0:	77 4b                	ja     80101d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800fd2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800fd5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800fd8:	8b 45 18             	mov    0x18(%ebp),%eax
  800fdb:	ba 00 00 00 00       	mov    $0x0,%edx
  800fe0:	52                   	push   %edx
  800fe1:	50                   	push   %eax
  800fe2:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe5:	ff 75 f0             	pushl  -0x10(%ebp)
  800fe8:	e8 77 17 00 00       	call   802764 <__udivdi3>
  800fed:	83 c4 10             	add    $0x10,%esp
  800ff0:	83 ec 04             	sub    $0x4,%esp
  800ff3:	ff 75 20             	pushl  0x20(%ebp)
  800ff6:	53                   	push   %ebx
  800ff7:	ff 75 18             	pushl  0x18(%ebp)
  800ffa:	52                   	push   %edx
  800ffb:	50                   	push   %eax
  800ffc:	ff 75 0c             	pushl  0xc(%ebp)
  800fff:	ff 75 08             	pushl  0x8(%ebp)
  801002:	e8 a1 ff ff ff       	call   800fa8 <printnum>
  801007:	83 c4 20             	add    $0x20,%esp
  80100a:	eb 1a                	jmp    801026 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80100c:	83 ec 08             	sub    $0x8,%esp
  80100f:	ff 75 0c             	pushl  0xc(%ebp)
  801012:	ff 75 20             	pushl  0x20(%ebp)
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	ff d0                	call   *%eax
  80101a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80101d:	ff 4d 1c             	decl   0x1c(%ebp)
  801020:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801024:	7f e6                	jg     80100c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801026:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801029:	bb 00 00 00 00       	mov    $0x0,%ebx
  80102e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801031:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801034:	53                   	push   %ebx
  801035:	51                   	push   %ecx
  801036:	52                   	push   %edx
  801037:	50                   	push   %eax
  801038:	e8 37 18 00 00       	call   802874 <__umoddi3>
  80103d:	83 c4 10             	add    $0x10,%esp
  801040:	05 f4 2e 80 00       	add    $0x802ef4,%eax
  801045:	8a 00                	mov    (%eax),%al
  801047:	0f be c0             	movsbl %al,%eax
  80104a:	83 ec 08             	sub    $0x8,%esp
  80104d:	ff 75 0c             	pushl  0xc(%ebp)
  801050:	50                   	push   %eax
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	ff d0                	call   *%eax
  801056:	83 c4 10             	add    $0x10,%esp
}
  801059:	90                   	nop
  80105a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80105d:	c9                   	leave  
  80105e:	c3                   	ret    

0080105f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80105f:	55                   	push   %ebp
  801060:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801062:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801066:	7e 1c                	jle    801084 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	8b 00                	mov    (%eax),%eax
  80106d:	8d 50 08             	lea    0x8(%eax),%edx
  801070:	8b 45 08             	mov    0x8(%ebp),%eax
  801073:	89 10                	mov    %edx,(%eax)
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	8b 00                	mov    (%eax),%eax
  80107a:	83 e8 08             	sub    $0x8,%eax
  80107d:	8b 50 04             	mov    0x4(%eax),%edx
  801080:	8b 00                	mov    (%eax),%eax
  801082:	eb 40                	jmp    8010c4 <getuint+0x65>
	else if (lflag)
  801084:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801088:	74 1e                	je     8010a8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80108a:	8b 45 08             	mov    0x8(%ebp),%eax
  80108d:	8b 00                	mov    (%eax),%eax
  80108f:	8d 50 04             	lea    0x4(%eax),%edx
  801092:	8b 45 08             	mov    0x8(%ebp),%eax
  801095:	89 10                	mov    %edx,(%eax)
  801097:	8b 45 08             	mov    0x8(%ebp),%eax
  80109a:	8b 00                	mov    (%eax),%eax
  80109c:	83 e8 04             	sub    $0x4,%eax
  80109f:	8b 00                	mov    (%eax),%eax
  8010a1:	ba 00 00 00 00       	mov    $0x0,%edx
  8010a6:	eb 1c                	jmp    8010c4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8010a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ab:	8b 00                	mov    (%eax),%eax
  8010ad:	8d 50 04             	lea    0x4(%eax),%edx
  8010b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b3:	89 10                	mov    %edx,(%eax)
  8010b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b8:	8b 00                	mov    (%eax),%eax
  8010ba:	83 e8 04             	sub    $0x4,%eax
  8010bd:	8b 00                	mov    (%eax),%eax
  8010bf:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8010c4:	5d                   	pop    %ebp
  8010c5:	c3                   	ret    

008010c6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8010c6:	55                   	push   %ebp
  8010c7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8010c9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8010cd:	7e 1c                	jle    8010eb <getint+0x25>
		return va_arg(*ap, long long);
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	8b 00                	mov    (%eax),%eax
  8010d4:	8d 50 08             	lea    0x8(%eax),%edx
  8010d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010da:	89 10                	mov    %edx,(%eax)
  8010dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010df:	8b 00                	mov    (%eax),%eax
  8010e1:	83 e8 08             	sub    $0x8,%eax
  8010e4:	8b 50 04             	mov    0x4(%eax),%edx
  8010e7:	8b 00                	mov    (%eax),%eax
  8010e9:	eb 38                	jmp    801123 <getint+0x5d>
	else if (lflag)
  8010eb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010ef:	74 1a                	je     80110b <getint+0x45>
		return va_arg(*ap, long);
  8010f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f4:	8b 00                	mov    (%eax),%eax
  8010f6:	8d 50 04             	lea    0x4(%eax),%edx
  8010f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fc:	89 10                	mov    %edx,(%eax)
  8010fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801101:	8b 00                	mov    (%eax),%eax
  801103:	83 e8 04             	sub    $0x4,%eax
  801106:	8b 00                	mov    (%eax),%eax
  801108:	99                   	cltd   
  801109:	eb 18                	jmp    801123 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	8b 00                	mov    (%eax),%eax
  801110:	8d 50 04             	lea    0x4(%eax),%edx
  801113:	8b 45 08             	mov    0x8(%ebp),%eax
  801116:	89 10                	mov    %edx,(%eax)
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
  80111b:	8b 00                	mov    (%eax),%eax
  80111d:	83 e8 04             	sub    $0x4,%eax
  801120:	8b 00                	mov    (%eax),%eax
  801122:	99                   	cltd   
}
  801123:	5d                   	pop    %ebp
  801124:	c3                   	ret    

00801125 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801125:	55                   	push   %ebp
  801126:	89 e5                	mov    %esp,%ebp
  801128:	56                   	push   %esi
  801129:	53                   	push   %ebx
  80112a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80112d:	eb 17                	jmp    801146 <vprintfmt+0x21>
			if (ch == '\0')
  80112f:	85 db                	test   %ebx,%ebx
  801131:	0f 84 af 03 00 00    	je     8014e6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801137:	83 ec 08             	sub    $0x8,%esp
  80113a:	ff 75 0c             	pushl  0xc(%ebp)
  80113d:	53                   	push   %ebx
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	ff d0                	call   *%eax
  801143:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801146:	8b 45 10             	mov    0x10(%ebp),%eax
  801149:	8d 50 01             	lea    0x1(%eax),%edx
  80114c:	89 55 10             	mov    %edx,0x10(%ebp)
  80114f:	8a 00                	mov    (%eax),%al
  801151:	0f b6 d8             	movzbl %al,%ebx
  801154:	83 fb 25             	cmp    $0x25,%ebx
  801157:	75 d6                	jne    80112f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801159:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80115d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801164:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80116b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801172:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801179:	8b 45 10             	mov    0x10(%ebp),%eax
  80117c:	8d 50 01             	lea    0x1(%eax),%edx
  80117f:	89 55 10             	mov    %edx,0x10(%ebp)
  801182:	8a 00                	mov    (%eax),%al
  801184:	0f b6 d8             	movzbl %al,%ebx
  801187:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80118a:	83 f8 55             	cmp    $0x55,%eax
  80118d:	0f 87 2b 03 00 00    	ja     8014be <vprintfmt+0x399>
  801193:	8b 04 85 18 2f 80 00 	mov    0x802f18(,%eax,4),%eax
  80119a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80119c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8011a0:	eb d7                	jmp    801179 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8011a2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8011a6:	eb d1                	jmp    801179 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8011a8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8011af:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8011b2:	89 d0                	mov    %edx,%eax
  8011b4:	c1 e0 02             	shl    $0x2,%eax
  8011b7:	01 d0                	add    %edx,%eax
  8011b9:	01 c0                	add    %eax,%eax
  8011bb:	01 d8                	add    %ebx,%eax
  8011bd:	83 e8 30             	sub    $0x30,%eax
  8011c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8011c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c6:	8a 00                	mov    (%eax),%al
  8011c8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8011cb:	83 fb 2f             	cmp    $0x2f,%ebx
  8011ce:	7e 3e                	jle    80120e <vprintfmt+0xe9>
  8011d0:	83 fb 39             	cmp    $0x39,%ebx
  8011d3:	7f 39                	jg     80120e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8011d5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8011d8:	eb d5                	jmp    8011af <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8011da:	8b 45 14             	mov    0x14(%ebp),%eax
  8011dd:	83 c0 04             	add    $0x4,%eax
  8011e0:	89 45 14             	mov    %eax,0x14(%ebp)
  8011e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e6:	83 e8 04             	sub    $0x4,%eax
  8011e9:	8b 00                	mov    (%eax),%eax
  8011eb:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8011ee:	eb 1f                	jmp    80120f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8011f0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011f4:	79 83                	jns    801179 <vprintfmt+0x54>
				width = 0;
  8011f6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8011fd:	e9 77 ff ff ff       	jmp    801179 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801202:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801209:	e9 6b ff ff ff       	jmp    801179 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80120e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80120f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801213:	0f 89 60 ff ff ff    	jns    801179 <vprintfmt+0x54>
				width = precision, precision = -1;
  801219:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80121c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80121f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801226:	e9 4e ff ff ff       	jmp    801179 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80122b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80122e:	e9 46 ff ff ff       	jmp    801179 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801233:	8b 45 14             	mov    0x14(%ebp),%eax
  801236:	83 c0 04             	add    $0x4,%eax
  801239:	89 45 14             	mov    %eax,0x14(%ebp)
  80123c:	8b 45 14             	mov    0x14(%ebp),%eax
  80123f:	83 e8 04             	sub    $0x4,%eax
  801242:	8b 00                	mov    (%eax),%eax
  801244:	83 ec 08             	sub    $0x8,%esp
  801247:	ff 75 0c             	pushl  0xc(%ebp)
  80124a:	50                   	push   %eax
  80124b:	8b 45 08             	mov    0x8(%ebp),%eax
  80124e:	ff d0                	call   *%eax
  801250:	83 c4 10             	add    $0x10,%esp
			break;
  801253:	e9 89 02 00 00       	jmp    8014e1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801258:	8b 45 14             	mov    0x14(%ebp),%eax
  80125b:	83 c0 04             	add    $0x4,%eax
  80125e:	89 45 14             	mov    %eax,0x14(%ebp)
  801261:	8b 45 14             	mov    0x14(%ebp),%eax
  801264:	83 e8 04             	sub    $0x4,%eax
  801267:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801269:	85 db                	test   %ebx,%ebx
  80126b:	79 02                	jns    80126f <vprintfmt+0x14a>
				err = -err;
  80126d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80126f:	83 fb 64             	cmp    $0x64,%ebx
  801272:	7f 0b                	jg     80127f <vprintfmt+0x15a>
  801274:	8b 34 9d 60 2d 80 00 	mov    0x802d60(,%ebx,4),%esi
  80127b:	85 f6                	test   %esi,%esi
  80127d:	75 19                	jne    801298 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80127f:	53                   	push   %ebx
  801280:	68 05 2f 80 00       	push   $0x802f05
  801285:	ff 75 0c             	pushl  0xc(%ebp)
  801288:	ff 75 08             	pushl  0x8(%ebp)
  80128b:	e8 5e 02 00 00       	call   8014ee <printfmt>
  801290:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801293:	e9 49 02 00 00       	jmp    8014e1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801298:	56                   	push   %esi
  801299:	68 0e 2f 80 00       	push   $0x802f0e
  80129e:	ff 75 0c             	pushl  0xc(%ebp)
  8012a1:	ff 75 08             	pushl  0x8(%ebp)
  8012a4:	e8 45 02 00 00       	call   8014ee <printfmt>
  8012a9:	83 c4 10             	add    $0x10,%esp
			break;
  8012ac:	e9 30 02 00 00       	jmp    8014e1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8012b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b4:	83 c0 04             	add    $0x4,%eax
  8012b7:	89 45 14             	mov    %eax,0x14(%ebp)
  8012ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8012bd:	83 e8 04             	sub    $0x4,%eax
  8012c0:	8b 30                	mov    (%eax),%esi
  8012c2:	85 f6                	test   %esi,%esi
  8012c4:	75 05                	jne    8012cb <vprintfmt+0x1a6>
				p = "(null)";
  8012c6:	be 11 2f 80 00       	mov    $0x802f11,%esi
			if (width > 0 && padc != '-')
  8012cb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012cf:	7e 6d                	jle    80133e <vprintfmt+0x219>
  8012d1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8012d5:	74 67                	je     80133e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8012d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8012da:	83 ec 08             	sub    $0x8,%esp
  8012dd:	50                   	push   %eax
  8012de:	56                   	push   %esi
  8012df:	e8 0c 03 00 00       	call   8015f0 <strnlen>
  8012e4:	83 c4 10             	add    $0x10,%esp
  8012e7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8012ea:	eb 16                	jmp    801302 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8012ec:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8012f0:	83 ec 08             	sub    $0x8,%esp
  8012f3:	ff 75 0c             	pushl  0xc(%ebp)
  8012f6:	50                   	push   %eax
  8012f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fa:	ff d0                	call   *%eax
  8012fc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8012ff:	ff 4d e4             	decl   -0x1c(%ebp)
  801302:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801306:	7f e4                	jg     8012ec <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801308:	eb 34                	jmp    80133e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80130a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80130e:	74 1c                	je     80132c <vprintfmt+0x207>
  801310:	83 fb 1f             	cmp    $0x1f,%ebx
  801313:	7e 05                	jle    80131a <vprintfmt+0x1f5>
  801315:	83 fb 7e             	cmp    $0x7e,%ebx
  801318:	7e 12                	jle    80132c <vprintfmt+0x207>
					putch('?', putdat);
  80131a:	83 ec 08             	sub    $0x8,%esp
  80131d:	ff 75 0c             	pushl  0xc(%ebp)
  801320:	6a 3f                	push   $0x3f
  801322:	8b 45 08             	mov    0x8(%ebp),%eax
  801325:	ff d0                	call   *%eax
  801327:	83 c4 10             	add    $0x10,%esp
  80132a:	eb 0f                	jmp    80133b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80132c:	83 ec 08             	sub    $0x8,%esp
  80132f:	ff 75 0c             	pushl  0xc(%ebp)
  801332:	53                   	push   %ebx
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
  801336:	ff d0                	call   *%eax
  801338:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80133b:	ff 4d e4             	decl   -0x1c(%ebp)
  80133e:	89 f0                	mov    %esi,%eax
  801340:	8d 70 01             	lea    0x1(%eax),%esi
  801343:	8a 00                	mov    (%eax),%al
  801345:	0f be d8             	movsbl %al,%ebx
  801348:	85 db                	test   %ebx,%ebx
  80134a:	74 24                	je     801370 <vprintfmt+0x24b>
  80134c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801350:	78 b8                	js     80130a <vprintfmt+0x1e5>
  801352:	ff 4d e0             	decl   -0x20(%ebp)
  801355:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801359:	79 af                	jns    80130a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80135b:	eb 13                	jmp    801370 <vprintfmt+0x24b>
				putch(' ', putdat);
  80135d:	83 ec 08             	sub    $0x8,%esp
  801360:	ff 75 0c             	pushl  0xc(%ebp)
  801363:	6a 20                	push   $0x20
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
  801368:	ff d0                	call   *%eax
  80136a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80136d:	ff 4d e4             	decl   -0x1c(%ebp)
  801370:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801374:	7f e7                	jg     80135d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801376:	e9 66 01 00 00       	jmp    8014e1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80137b:	83 ec 08             	sub    $0x8,%esp
  80137e:	ff 75 e8             	pushl  -0x18(%ebp)
  801381:	8d 45 14             	lea    0x14(%ebp),%eax
  801384:	50                   	push   %eax
  801385:	e8 3c fd ff ff       	call   8010c6 <getint>
  80138a:	83 c4 10             	add    $0x10,%esp
  80138d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801390:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801393:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801396:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801399:	85 d2                	test   %edx,%edx
  80139b:	79 23                	jns    8013c0 <vprintfmt+0x29b>
				putch('-', putdat);
  80139d:	83 ec 08             	sub    $0x8,%esp
  8013a0:	ff 75 0c             	pushl  0xc(%ebp)
  8013a3:	6a 2d                	push   $0x2d
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	ff d0                	call   *%eax
  8013aa:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8013ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013b3:	f7 d8                	neg    %eax
  8013b5:	83 d2 00             	adc    $0x0,%edx
  8013b8:	f7 da                	neg    %edx
  8013ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8013c0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8013c7:	e9 bc 00 00 00       	jmp    801488 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8013cc:	83 ec 08             	sub    $0x8,%esp
  8013cf:	ff 75 e8             	pushl  -0x18(%ebp)
  8013d2:	8d 45 14             	lea    0x14(%ebp),%eax
  8013d5:	50                   	push   %eax
  8013d6:	e8 84 fc ff ff       	call   80105f <getuint>
  8013db:	83 c4 10             	add    $0x10,%esp
  8013de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8013e4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8013eb:	e9 98 00 00 00       	jmp    801488 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8013f0:	83 ec 08             	sub    $0x8,%esp
  8013f3:	ff 75 0c             	pushl  0xc(%ebp)
  8013f6:	6a 58                	push   $0x58
  8013f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fb:	ff d0                	call   *%eax
  8013fd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801400:	83 ec 08             	sub    $0x8,%esp
  801403:	ff 75 0c             	pushl  0xc(%ebp)
  801406:	6a 58                	push   $0x58
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	ff d0                	call   *%eax
  80140d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801410:	83 ec 08             	sub    $0x8,%esp
  801413:	ff 75 0c             	pushl  0xc(%ebp)
  801416:	6a 58                	push   $0x58
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	ff d0                	call   *%eax
  80141d:	83 c4 10             	add    $0x10,%esp
			break;
  801420:	e9 bc 00 00 00       	jmp    8014e1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801425:	83 ec 08             	sub    $0x8,%esp
  801428:	ff 75 0c             	pushl  0xc(%ebp)
  80142b:	6a 30                	push   $0x30
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	ff d0                	call   *%eax
  801432:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801435:	83 ec 08             	sub    $0x8,%esp
  801438:	ff 75 0c             	pushl  0xc(%ebp)
  80143b:	6a 78                	push   $0x78
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	ff d0                	call   *%eax
  801442:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801445:	8b 45 14             	mov    0x14(%ebp),%eax
  801448:	83 c0 04             	add    $0x4,%eax
  80144b:	89 45 14             	mov    %eax,0x14(%ebp)
  80144e:	8b 45 14             	mov    0x14(%ebp),%eax
  801451:	83 e8 04             	sub    $0x4,%eax
  801454:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801456:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801459:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801460:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801467:	eb 1f                	jmp    801488 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801469:	83 ec 08             	sub    $0x8,%esp
  80146c:	ff 75 e8             	pushl  -0x18(%ebp)
  80146f:	8d 45 14             	lea    0x14(%ebp),%eax
  801472:	50                   	push   %eax
  801473:	e8 e7 fb ff ff       	call   80105f <getuint>
  801478:	83 c4 10             	add    $0x10,%esp
  80147b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80147e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801481:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801488:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80148c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80148f:	83 ec 04             	sub    $0x4,%esp
  801492:	52                   	push   %edx
  801493:	ff 75 e4             	pushl  -0x1c(%ebp)
  801496:	50                   	push   %eax
  801497:	ff 75 f4             	pushl  -0xc(%ebp)
  80149a:	ff 75 f0             	pushl  -0x10(%ebp)
  80149d:	ff 75 0c             	pushl  0xc(%ebp)
  8014a0:	ff 75 08             	pushl  0x8(%ebp)
  8014a3:	e8 00 fb ff ff       	call   800fa8 <printnum>
  8014a8:	83 c4 20             	add    $0x20,%esp
			break;
  8014ab:	eb 34                	jmp    8014e1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8014ad:	83 ec 08             	sub    $0x8,%esp
  8014b0:	ff 75 0c             	pushl  0xc(%ebp)
  8014b3:	53                   	push   %ebx
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b7:	ff d0                	call   *%eax
  8014b9:	83 c4 10             	add    $0x10,%esp
			break;
  8014bc:	eb 23                	jmp    8014e1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8014be:	83 ec 08             	sub    $0x8,%esp
  8014c1:	ff 75 0c             	pushl  0xc(%ebp)
  8014c4:	6a 25                	push   $0x25
  8014c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c9:	ff d0                	call   *%eax
  8014cb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8014ce:	ff 4d 10             	decl   0x10(%ebp)
  8014d1:	eb 03                	jmp    8014d6 <vprintfmt+0x3b1>
  8014d3:	ff 4d 10             	decl   0x10(%ebp)
  8014d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d9:	48                   	dec    %eax
  8014da:	8a 00                	mov    (%eax),%al
  8014dc:	3c 25                	cmp    $0x25,%al
  8014de:	75 f3                	jne    8014d3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8014e0:	90                   	nop
		}
	}
  8014e1:	e9 47 fc ff ff       	jmp    80112d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8014e6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8014e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8014ea:	5b                   	pop    %ebx
  8014eb:	5e                   	pop    %esi
  8014ec:	5d                   	pop    %ebp
  8014ed:	c3                   	ret    

008014ee <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8014ee:	55                   	push   %ebp
  8014ef:	89 e5                	mov    %esp,%ebp
  8014f1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8014f4:	8d 45 10             	lea    0x10(%ebp),%eax
  8014f7:	83 c0 04             	add    $0x4,%eax
  8014fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8014fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801500:	ff 75 f4             	pushl  -0xc(%ebp)
  801503:	50                   	push   %eax
  801504:	ff 75 0c             	pushl  0xc(%ebp)
  801507:	ff 75 08             	pushl  0x8(%ebp)
  80150a:	e8 16 fc ff ff       	call   801125 <vprintfmt>
  80150f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801512:	90                   	nop
  801513:	c9                   	leave  
  801514:	c3                   	ret    

00801515 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801515:	55                   	push   %ebp
  801516:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801518:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151b:	8b 40 08             	mov    0x8(%eax),%eax
  80151e:	8d 50 01             	lea    0x1(%eax),%edx
  801521:	8b 45 0c             	mov    0xc(%ebp),%eax
  801524:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801527:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152a:	8b 10                	mov    (%eax),%edx
  80152c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152f:	8b 40 04             	mov    0x4(%eax),%eax
  801532:	39 c2                	cmp    %eax,%edx
  801534:	73 12                	jae    801548 <sprintputch+0x33>
		*b->buf++ = ch;
  801536:	8b 45 0c             	mov    0xc(%ebp),%eax
  801539:	8b 00                	mov    (%eax),%eax
  80153b:	8d 48 01             	lea    0x1(%eax),%ecx
  80153e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801541:	89 0a                	mov    %ecx,(%edx)
  801543:	8b 55 08             	mov    0x8(%ebp),%edx
  801546:	88 10                	mov    %dl,(%eax)
}
  801548:	90                   	nop
  801549:	5d                   	pop    %ebp
  80154a:	c3                   	ret    

0080154b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80154b:	55                   	push   %ebp
  80154c:	89 e5                	mov    %esp,%ebp
  80154e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801551:	8b 45 08             	mov    0x8(%ebp),%eax
  801554:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801557:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80155d:	8b 45 08             	mov    0x8(%ebp),%eax
  801560:	01 d0                	add    %edx,%eax
  801562:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801565:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80156c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801570:	74 06                	je     801578 <vsnprintf+0x2d>
  801572:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801576:	7f 07                	jg     80157f <vsnprintf+0x34>
		return -E_INVAL;
  801578:	b8 03 00 00 00       	mov    $0x3,%eax
  80157d:	eb 20                	jmp    80159f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80157f:	ff 75 14             	pushl  0x14(%ebp)
  801582:	ff 75 10             	pushl  0x10(%ebp)
  801585:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801588:	50                   	push   %eax
  801589:	68 15 15 80 00       	push   $0x801515
  80158e:	e8 92 fb ff ff       	call   801125 <vprintfmt>
  801593:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801596:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801599:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80159c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80159f:	c9                   	leave  
  8015a0:	c3                   	ret    

008015a1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8015a1:	55                   	push   %ebp
  8015a2:	89 e5                	mov    %esp,%ebp
  8015a4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8015a7:	8d 45 10             	lea    0x10(%ebp),%eax
  8015aa:	83 c0 04             	add    $0x4,%eax
  8015ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8015b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b3:	ff 75 f4             	pushl  -0xc(%ebp)
  8015b6:	50                   	push   %eax
  8015b7:	ff 75 0c             	pushl  0xc(%ebp)
  8015ba:	ff 75 08             	pushl  0x8(%ebp)
  8015bd:	e8 89 ff ff ff       	call   80154b <vsnprintf>
  8015c2:	83 c4 10             	add    $0x10,%esp
  8015c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8015c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015cb:	c9                   	leave  
  8015cc:	c3                   	ret    

008015cd <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8015cd:	55                   	push   %ebp
  8015ce:	89 e5                	mov    %esp,%ebp
  8015d0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8015d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015da:	eb 06                	jmp    8015e2 <strlen+0x15>
		n++;
  8015dc:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8015df:	ff 45 08             	incl   0x8(%ebp)
  8015e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e5:	8a 00                	mov    (%eax),%al
  8015e7:	84 c0                	test   %al,%al
  8015e9:	75 f1                	jne    8015dc <strlen+0xf>
		n++;
	return n;
  8015eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015ee:	c9                   	leave  
  8015ef:	c3                   	ret    

008015f0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8015f0:	55                   	push   %ebp
  8015f1:	89 e5                	mov    %esp,%ebp
  8015f3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8015f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015fd:	eb 09                	jmp    801608 <strnlen+0x18>
		n++;
  8015ff:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801602:	ff 45 08             	incl   0x8(%ebp)
  801605:	ff 4d 0c             	decl   0xc(%ebp)
  801608:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80160c:	74 09                	je     801617 <strnlen+0x27>
  80160e:	8b 45 08             	mov    0x8(%ebp),%eax
  801611:	8a 00                	mov    (%eax),%al
  801613:	84 c0                	test   %al,%al
  801615:	75 e8                	jne    8015ff <strnlen+0xf>
		n++;
	return n;
  801617:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80161a:	c9                   	leave  
  80161b:	c3                   	ret    

0080161c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80161c:	55                   	push   %ebp
  80161d:	89 e5                	mov    %esp,%ebp
  80161f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801622:	8b 45 08             	mov    0x8(%ebp),%eax
  801625:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801628:	90                   	nop
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
  80162c:	8d 50 01             	lea    0x1(%eax),%edx
  80162f:	89 55 08             	mov    %edx,0x8(%ebp)
  801632:	8b 55 0c             	mov    0xc(%ebp),%edx
  801635:	8d 4a 01             	lea    0x1(%edx),%ecx
  801638:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80163b:	8a 12                	mov    (%edx),%dl
  80163d:	88 10                	mov    %dl,(%eax)
  80163f:	8a 00                	mov    (%eax),%al
  801641:	84 c0                	test   %al,%al
  801643:	75 e4                	jne    801629 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801645:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
  80164d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801656:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80165d:	eb 1f                	jmp    80167e <strncpy+0x34>
		*dst++ = *src;
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8d 50 01             	lea    0x1(%eax),%edx
  801665:	89 55 08             	mov    %edx,0x8(%ebp)
  801668:	8b 55 0c             	mov    0xc(%ebp),%edx
  80166b:	8a 12                	mov    (%edx),%dl
  80166d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80166f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801672:	8a 00                	mov    (%eax),%al
  801674:	84 c0                	test   %al,%al
  801676:	74 03                	je     80167b <strncpy+0x31>
			src++;
  801678:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80167b:	ff 45 fc             	incl   -0x4(%ebp)
  80167e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801681:	3b 45 10             	cmp    0x10(%ebp),%eax
  801684:	72 d9                	jb     80165f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801686:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801689:	c9                   	leave  
  80168a:	c3                   	ret    

0080168b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80168b:	55                   	push   %ebp
  80168c:	89 e5                	mov    %esp,%ebp
  80168e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801691:	8b 45 08             	mov    0x8(%ebp),%eax
  801694:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801697:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80169b:	74 30                	je     8016cd <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80169d:	eb 16                	jmp    8016b5 <strlcpy+0x2a>
			*dst++ = *src++;
  80169f:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a2:	8d 50 01             	lea    0x1(%eax),%edx
  8016a5:	89 55 08             	mov    %edx,0x8(%ebp)
  8016a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ab:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016ae:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8016b1:	8a 12                	mov    (%edx),%dl
  8016b3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8016b5:	ff 4d 10             	decl   0x10(%ebp)
  8016b8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016bc:	74 09                	je     8016c7 <strlcpy+0x3c>
  8016be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c1:	8a 00                	mov    (%eax),%al
  8016c3:	84 c0                	test   %al,%al
  8016c5:	75 d8                	jne    80169f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8016c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ca:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8016cd:	8b 55 08             	mov    0x8(%ebp),%edx
  8016d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016d3:	29 c2                	sub    %eax,%edx
  8016d5:	89 d0                	mov    %edx,%eax
}
  8016d7:	c9                   	leave  
  8016d8:	c3                   	ret    

008016d9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8016dc:	eb 06                	jmp    8016e4 <strcmp+0xb>
		p++, q++;
  8016de:	ff 45 08             	incl   0x8(%ebp)
  8016e1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	8a 00                	mov    (%eax),%al
  8016e9:	84 c0                	test   %al,%al
  8016eb:	74 0e                	je     8016fb <strcmp+0x22>
  8016ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f0:	8a 10                	mov    (%eax),%dl
  8016f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f5:	8a 00                	mov    (%eax),%al
  8016f7:	38 c2                	cmp    %al,%dl
  8016f9:	74 e3                	je     8016de <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8016fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fe:	8a 00                	mov    (%eax),%al
  801700:	0f b6 d0             	movzbl %al,%edx
  801703:	8b 45 0c             	mov    0xc(%ebp),%eax
  801706:	8a 00                	mov    (%eax),%al
  801708:	0f b6 c0             	movzbl %al,%eax
  80170b:	29 c2                	sub    %eax,%edx
  80170d:	89 d0                	mov    %edx,%eax
}
  80170f:	5d                   	pop    %ebp
  801710:	c3                   	ret    

00801711 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801711:	55                   	push   %ebp
  801712:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801714:	eb 09                	jmp    80171f <strncmp+0xe>
		n--, p++, q++;
  801716:	ff 4d 10             	decl   0x10(%ebp)
  801719:	ff 45 08             	incl   0x8(%ebp)
  80171c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80171f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801723:	74 17                	je     80173c <strncmp+0x2b>
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	8a 00                	mov    (%eax),%al
  80172a:	84 c0                	test   %al,%al
  80172c:	74 0e                	je     80173c <strncmp+0x2b>
  80172e:	8b 45 08             	mov    0x8(%ebp),%eax
  801731:	8a 10                	mov    (%eax),%dl
  801733:	8b 45 0c             	mov    0xc(%ebp),%eax
  801736:	8a 00                	mov    (%eax),%al
  801738:	38 c2                	cmp    %al,%dl
  80173a:	74 da                	je     801716 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80173c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801740:	75 07                	jne    801749 <strncmp+0x38>
		return 0;
  801742:	b8 00 00 00 00       	mov    $0x0,%eax
  801747:	eb 14                	jmp    80175d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801749:	8b 45 08             	mov    0x8(%ebp),%eax
  80174c:	8a 00                	mov    (%eax),%al
  80174e:	0f b6 d0             	movzbl %al,%edx
  801751:	8b 45 0c             	mov    0xc(%ebp),%eax
  801754:	8a 00                	mov    (%eax),%al
  801756:	0f b6 c0             	movzbl %al,%eax
  801759:	29 c2                	sub    %eax,%edx
  80175b:	89 d0                	mov    %edx,%eax
}
  80175d:	5d                   	pop    %ebp
  80175e:	c3                   	ret    

0080175f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80175f:	55                   	push   %ebp
  801760:	89 e5                	mov    %esp,%ebp
  801762:	83 ec 04             	sub    $0x4,%esp
  801765:	8b 45 0c             	mov    0xc(%ebp),%eax
  801768:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80176b:	eb 12                	jmp    80177f <strchr+0x20>
		if (*s == c)
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	8a 00                	mov    (%eax),%al
  801772:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801775:	75 05                	jne    80177c <strchr+0x1d>
			return (char *) s;
  801777:	8b 45 08             	mov    0x8(%ebp),%eax
  80177a:	eb 11                	jmp    80178d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80177c:	ff 45 08             	incl   0x8(%ebp)
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
  801782:	8a 00                	mov    (%eax),%al
  801784:	84 c0                	test   %al,%al
  801786:	75 e5                	jne    80176d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801788:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80178d:	c9                   	leave  
  80178e:	c3                   	ret    

0080178f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80178f:	55                   	push   %ebp
  801790:	89 e5                	mov    %esp,%ebp
  801792:	83 ec 04             	sub    $0x4,%esp
  801795:	8b 45 0c             	mov    0xc(%ebp),%eax
  801798:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80179b:	eb 0d                	jmp    8017aa <strfind+0x1b>
		if (*s == c)
  80179d:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a0:	8a 00                	mov    (%eax),%al
  8017a2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8017a5:	74 0e                	je     8017b5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8017a7:	ff 45 08             	incl   0x8(%ebp)
  8017aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ad:	8a 00                	mov    (%eax),%al
  8017af:	84 c0                	test   %al,%al
  8017b1:	75 ea                	jne    80179d <strfind+0xe>
  8017b3:	eb 01                	jmp    8017b6 <strfind+0x27>
		if (*s == c)
			break;
  8017b5:	90                   	nop
	return (char *) s;
  8017b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017b9:	c9                   	leave  
  8017ba:	c3                   	ret    

008017bb <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8017bb:	55                   	push   %ebp
  8017bc:	89 e5                	mov    %esp,%ebp
  8017be:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8017c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8017c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ca:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8017cd:	eb 0e                	jmp    8017dd <memset+0x22>
		*p++ = c;
  8017cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017d2:	8d 50 01             	lea    0x1(%eax),%edx
  8017d5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8017d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017db:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8017dd:	ff 4d f8             	decl   -0x8(%ebp)
  8017e0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8017e4:	79 e9                	jns    8017cf <memset+0x14>
		*p++ = c;

	return v;
  8017e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017e9:	c9                   	leave  
  8017ea:	c3                   	ret    

008017eb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8017eb:	55                   	push   %ebp
  8017ec:	89 e5                	mov    %esp,%ebp
  8017ee:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8017f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8017f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8017fd:	eb 16                	jmp    801815 <memcpy+0x2a>
		*d++ = *s++;
  8017ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801802:	8d 50 01             	lea    0x1(%eax),%edx
  801805:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801808:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80180b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80180e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801811:	8a 12                	mov    (%edx),%dl
  801813:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801815:	8b 45 10             	mov    0x10(%ebp),%eax
  801818:	8d 50 ff             	lea    -0x1(%eax),%edx
  80181b:	89 55 10             	mov    %edx,0x10(%ebp)
  80181e:	85 c0                	test   %eax,%eax
  801820:	75 dd                	jne    8017ff <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801822:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801825:	c9                   	leave  
  801826:	c3                   	ret    

00801827 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801827:	55                   	push   %ebp
  801828:	89 e5                	mov    %esp,%ebp
  80182a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80182d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801830:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801833:	8b 45 08             	mov    0x8(%ebp),%eax
  801836:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801839:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80183c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80183f:	73 50                	jae    801891 <memmove+0x6a>
  801841:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801844:	8b 45 10             	mov    0x10(%ebp),%eax
  801847:	01 d0                	add    %edx,%eax
  801849:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80184c:	76 43                	jbe    801891 <memmove+0x6a>
		s += n;
  80184e:	8b 45 10             	mov    0x10(%ebp),%eax
  801851:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801854:	8b 45 10             	mov    0x10(%ebp),%eax
  801857:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80185a:	eb 10                	jmp    80186c <memmove+0x45>
			*--d = *--s;
  80185c:	ff 4d f8             	decl   -0x8(%ebp)
  80185f:	ff 4d fc             	decl   -0x4(%ebp)
  801862:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801865:	8a 10                	mov    (%eax),%dl
  801867:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80186a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80186c:	8b 45 10             	mov    0x10(%ebp),%eax
  80186f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801872:	89 55 10             	mov    %edx,0x10(%ebp)
  801875:	85 c0                	test   %eax,%eax
  801877:	75 e3                	jne    80185c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801879:	eb 23                	jmp    80189e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80187b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187e:	8d 50 01             	lea    0x1(%eax),%edx
  801881:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801884:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801887:	8d 4a 01             	lea    0x1(%edx),%ecx
  80188a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80188d:	8a 12                	mov    (%edx),%dl
  80188f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801891:	8b 45 10             	mov    0x10(%ebp),%eax
  801894:	8d 50 ff             	lea    -0x1(%eax),%edx
  801897:	89 55 10             	mov    %edx,0x10(%ebp)
  80189a:	85 c0                	test   %eax,%eax
  80189c:	75 dd                	jne    80187b <memmove+0x54>
			*d++ = *s++;

	return dst;
  80189e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018a1:	c9                   	leave  
  8018a2:	c3                   	ret    

008018a3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8018a3:	55                   	push   %ebp
  8018a4:	89 e5                	mov    %esp,%ebp
  8018a6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8018a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8018af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8018b5:	eb 2a                	jmp    8018e1 <memcmp+0x3e>
		if (*s1 != *s2)
  8018b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018ba:	8a 10                	mov    (%eax),%dl
  8018bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018bf:	8a 00                	mov    (%eax),%al
  8018c1:	38 c2                	cmp    %al,%dl
  8018c3:	74 16                	je     8018db <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8018c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018c8:	8a 00                	mov    (%eax),%al
  8018ca:	0f b6 d0             	movzbl %al,%edx
  8018cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018d0:	8a 00                	mov    (%eax),%al
  8018d2:	0f b6 c0             	movzbl %al,%eax
  8018d5:	29 c2                	sub    %eax,%edx
  8018d7:	89 d0                	mov    %edx,%eax
  8018d9:	eb 18                	jmp    8018f3 <memcmp+0x50>
		s1++, s2++;
  8018db:	ff 45 fc             	incl   -0x4(%ebp)
  8018de:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8018e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8018ea:	85 c0                	test   %eax,%eax
  8018ec:	75 c9                	jne    8018b7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8018ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018f3:	c9                   	leave  
  8018f4:	c3                   	ret    

008018f5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8018f5:	55                   	push   %ebp
  8018f6:	89 e5                	mov    %esp,%ebp
  8018f8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8018fb:	8b 55 08             	mov    0x8(%ebp),%edx
  8018fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801901:	01 d0                	add    %edx,%eax
  801903:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801906:	eb 15                	jmp    80191d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801908:	8b 45 08             	mov    0x8(%ebp),%eax
  80190b:	8a 00                	mov    (%eax),%al
  80190d:	0f b6 d0             	movzbl %al,%edx
  801910:	8b 45 0c             	mov    0xc(%ebp),%eax
  801913:	0f b6 c0             	movzbl %al,%eax
  801916:	39 c2                	cmp    %eax,%edx
  801918:	74 0d                	je     801927 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80191a:	ff 45 08             	incl   0x8(%ebp)
  80191d:	8b 45 08             	mov    0x8(%ebp),%eax
  801920:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801923:	72 e3                	jb     801908 <memfind+0x13>
  801925:	eb 01                	jmp    801928 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801927:	90                   	nop
	return (void *) s;
  801928:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80192b:	c9                   	leave  
  80192c:	c3                   	ret    

0080192d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80192d:	55                   	push   %ebp
  80192e:	89 e5                	mov    %esp,%ebp
  801930:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801933:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80193a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801941:	eb 03                	jmp    801946 <strtol+0x19>
		s++;
  801943:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801946:	8b 45 08             	mov    0x8(%ebp),%eax
  801949:	8a 00                	mov    (%eax),%al
  80194b:	3c 20                	cmp    $0x20,%al
  80194d:	74 f4                	je     801943 <strtol+0x16>
  80194f:	8b 45 08             	mov    0x8(%ebp),%eax
  801952:	8a 00                	mov    (%eax),%al
  801954:	3c 09                	cmp    $0x9,%al
  801956:	74 eb                	je     801943 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801958:	8b 45 08             	mov    0x8(%ebp),%eax
  80195b:	8a 00                	mov    (%eax),%al
  80195d:	3c 2b                	cmp    $0x2b,%al
  80195f:	75 05                	jne    801966 <strtol+0x39>
		s++;
  801961:	ff 45 08             	incl   0x8(%ebp)
  801964:	eb 13                	jmp    801979 <strtol+0x4c>
	else if (*s == '-')
  801966:	8b 45 08             	mov    0x8(%ebp),%eax
  801969:	8a 00                	mov    (%eax),%al
  80196b:	3c 2d                	cmp    $0x2d,%al
  80196d:	75 0a                	jne    801979 <strtol+0x4c>
		s++, neg = 1;
  80196f:	ff 45 08             	incl   0x8(%ebp)
  801972:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801979:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80197d:	74 06                	je     801985 <strtol+0x58>
  80197f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801983:	75 20                	jne    8019a5 <strtol+0x78>
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	8a 00                	mov    (%eax),%al
  80198a:	3c 30                	cmp    $0x30,%al
  80198c:	75 17                	jne    8019a5 <strtol+0x78>
  80198e:	8b 45 08             	mov    0x8(%ebp),%eax
  801991:	40                   	inc    %eax
  801992:	8a 00                	mov    (%eax),%al
  801994:	3c 78                	cmp    $0x78,%al
  801996:	75 0d                	jne    8019a5 <strtol+0x78>
		s += 2, base = 16;
  801998:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80199c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8019a3:	eb 28                	jmp    8019cd <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8019a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019a9:	75 15                	jne    8019c0 <strtol+0x93>
  8019ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ae:	8a 00                	mov    (%eax),%al
  8019b0:	3c 30                	cmp    $0x30,%al
  8019b2:	75 0c                	jne    8019c0 <strtol+0x93>
		s++, base = 8;
  8019b4:	ff 45 08             	incl   0x8(%ebp)
  8019b7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8019be:	eb 0d                	jmp    8019cd <strtol+0xa0>
	else if (base == 0)
  8019c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019c4:	75 07                	jne    8019cd <strtol+0xa0>
		base = 10;
  8019c6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8019cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d0:	8a 00                	mov    (%eax),%al
  8019d2:	3c 2f                	cmp    $0x2f,%al
  8019d4:	7e 19                	jle    8019ef <strtol+0xc2>
  8019d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d9:	8a 00                	mov    (%eax),%al
  8019db:	3c 39                	cmp    $0x39,%al
  8019dd:	7f 10                	jg     8019ef <strtol+0xc2>
			dig = *s - '0';
  8019df:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e2:	8a 00                	mov    (%eax),%al
  8019e4:	0f be c0             	movsbl %al,%eax
  8019e7:	83 e8 30             	sub    $0x30,%eax
  8019ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8019ed:	eb 42                	jmp    801a31 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8019ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f2:	8a 00                	mov    (%eax),%al
  8019f4:	3c 60                	cmp    $0x60,%al
  8019f6:	7e 19                	jle    801a11 <strtol+0xe4>
  8019f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fb:	8a 00                	mov    (%eax),%al
  8019fd:	3c 7a                	cmp    $0x7a,%al
  8019ff:	7f 10                	jg     801a11 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801a01:	8b 45 08             	mov    0x8(%ebp),%eax
  801a04:	8a 00                	mov    (%eax),%al
  801a06:	0f be c0             	movsbl %al,%eax
  801a09:	83 e8 57             	sub    $0x57,%eax
  801a0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a0f:	eb 20                	jmp    801a31 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801a11:	8b 45 08             	mov    0x8(%ebp),%eax
  801a14:	8a 00                	mov    (%eax),%al
  801a16:	3c 40                	cmp    $0x40,%al
  801a18:	7e 39                	jle    801a53 <strtol+0x126>
  801a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1d:	8a 00                	mov    (%eax),%al
  801a1f:	3c 5a                	cmp    $0x5a,%al
  801a21:	7f 30                	jg     801a53 <strtol+0x126>
			dig = *s - 'A' + 10;
  801a23:	8b 45 08             	mov    0x8(%ebp),%eax
  801a26:	8a 00                	mov    (%eax),%al
  801a28:	0f be c0             	movsbl %al,%eax
  801a2b:	83 e8 37             	sub    $0x37,%eax
  801a2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a34:	3b 45 10             	cmp    0x10(%ebp),%eax
  801a37:	7d 19                	jge    801a52 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801a39:	ff 45 08             	incl   0x8(%ebp)
  801a3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a3f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801a43:	89 c2                	mov    %eax,%edx
  801a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a48:	01 d0                	add    %edx,%eax
  801a4a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801a4d:	e9 7b ff ff ff       	jmp    8019cd <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801a52:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801a53:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801a57:	74 08                	je     801a61 <strtol+0x134>
		*endptr = (char *) s;
  801a59:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a5c:	8b 55 08             	mov    0x8(%ebp),%edx
  801a5f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801a61:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a65:	74 07                	je     801a6e <strtol+0x141>
  801a67:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a6a:	f7 d8                	neg    %eax
  801a6c:	eb 03                	jmp    801a71 <strtol+0x144>
  801a6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801a71:	c9                   	leave  
  801a72:	c3                   	ret    

00801a73 <ltostr>:

void
ltostr(long value, char *str)
{
  801a73:	55                   	push   %ebp
  801a74:	89 e5                	mov    %esp,%ebp
  801a76:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801a79:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801a80:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801a87:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a8b:	79 13                	jns    801aa0 <ltostr+0x2d>
	{
		neg = 1;
  801a8d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801a94:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a97:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801a9a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801a9d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801aa8:	99                   	cltd   
  801aa9:	f7 f9                	idiv   %ecx
  801aab:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801aae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ab1:	8d 50 01             	lea    0x1(%eax),%edx
  801ab4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801ab7:	89 c2                	mov    %eax,%edx
  801ab9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801abc:	01 d0                	add    %edx,%eax
  801abe:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ac1:	83 c2 30             	add    $0x30,%edx
  801ac4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801ac6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ac9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801ace:	f7 e9                	imul   %ecx
  801ad0:	c1 fa 02             	sar    $0x2,%edx
  801ad3:	89 c8                	mov    %ecx,%eax
  801ad5:	c1 f8 1f             	sar    $0x1f,%eax
  801ad8:	29 c2                	sub    %eax,%edx
  801ada:	89 d0                	mov    %edx,%eax
  801adc:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801adf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ae2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801ae7:	f7 e9                	imul   %ecx
  801ae9:	c1 fa 02             	sar    $0x2,%edx
  801aec:	89 c8                	mov    %ecx,%eax
  801aee:	c1 f8 1f             	sar    $0x1f,%eax
  801af1:	29 c2                	sub    %eax,%edx
  801af3:	89 d0                	mov    %edx,%eax
  801af5:	c1 e0 02             	shl    $0x2,%eax
  801af8:	01 d0                	add    %edx,%eax
  801afa:	01 c0                	add    %eax,%eax
  801afc:	29 c1                	sub    %eax,%ecx
  801afe:	89 ca                	mov    %ecx,%edx
  801b00:	85 d2                	test   %edx,%edx
  801b02:	75 9c                	jne    801aa0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801b04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801b0b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b0e:	48                   	dec    %eax
  801b0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801b12:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b16:	74 3d                	je     801b55 <ltostr+0xe2>
		start = 1 ;
  801b18:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801b1f:	eb 34                	jmp    801b55 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801b21:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b24:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b27:	01 d0                	add    %edx,%eax
  801b29:	8a 00                	mov    (%eax),%al
  801b2b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801b2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b31:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b34:	01 c2                	add    %eax,%edx
  801b36:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801b39:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b3c:	01 c8                	add    %ecx,%eax
  801b3e:	8a 00                	mov    (%eax),%al
  801b40:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801b42:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b45:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b48:	01 c2                	add    %eax,%edx
  801b4a:	8a 45 eb             	mov    -0x15(%ebp),%al
  801b4d:	88 02                	mov    %al,(%edx)
		start++ ;
  801b4f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801b52:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b58:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b5b:	7c c4                	jl     801b21 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801b5d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801b60:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b63:	01 d0                	add    %edx,%eax
  801b65:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801b68:	90                   	nop
  801b69:	c9                   	leave  
  801b6a:	c3                   	ret    

00801b6b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801b6b:	55                   	push   %ebp
  801b6c:	89 e5                	mov    %esp,%ebp
  801b6e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801b71:	ff 75 08             	pushl  0x8(%ebp)
  801b74:	e8 54 fa ff ff       	call   8015cd <strlen>
  801b79:	83 c4 04             	add    $0x4,%esp
  801b7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801b7f:	ff 75 0c             	pushl  0xc(%ebp)
  801b82:	e8 46 fa ff ff       	call   8015cd <strlen>
  801b87:	83 c4 04             	add    $0x4,%esp
  801b8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801b8d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801b94:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b9b:	eb 17                	jmp    801bb4 <strcconcat+0x49>
		final[s] = str1[s] ;
  801b9d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ba0:	8b 45 10             	mov    0x10(%ebp),%eax
  801ba3:	01 c2                	add    %eax,%edx
  801ba5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bab:	01 c8                	add    %ecx,%eax
  801bad:	8a 00                	mov    (%eax),%al
  801baf:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801bb1:	ff 45 fc             	incl   -0x4(%ebp)
  801bb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bb7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801bba:	7c e1                	jl     801b9d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801bbc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801bc3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801bca:	eb 1f                	jmp    801beb <strcconcat+0x80>
		final[s++] = str2[i] ;
  801bcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bcf:	8d 50 01             	lea    0x1(%eax),%edx
  801bd2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801bd5:	89 c2                	mov    %eax,%edx
  801bd7:	8b 45 10             	mov    0x10(%ebp),%eax
  801bda:	01 c2                	add    %eax,%edx
  801bdc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801bdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  801be2:	01 c8                	add    %ecx,%eax
  801be4:	8a 00                	mov    (%eax),%al
  801be6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801be8:	ff 45 f8             	incl   -0x8(%ebp)
  801beb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bee:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bf1:	7c d9                	jl     801bcc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801bf3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bf6:	8b 45 10             	mov    0x10(%ebp),%eax
  801bf9:	01 d0                	add    %edx,%eax
  801bfb:	c6 00 00             	movb   $0x0,(%eax)
}
  801bfe:	90                   	nop
  801bff:	c9                   	leave  
  801c00:	c3                   	ret    

00801c01 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801c01:	55                   	push   %ebp
  801c02:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801c04:	8b 45 14             	mov    0x14(%ebp),%eax
  801c07:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801c0d:	8b 45 14             	mov    0x14(%ebp),%eax
  801c10:	8b 00                	mov    (%eax),%eax
  801c12:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c19:	8b 45 10             	mov    0x10(%ebp),%eax
  801c1c:	01 d0                	add    %edx,%eax
  801c1e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c24:	eb 0c                	jmp    801c32 <strsplit+0x31>
			*string++ = 0;
  801c26:	8b 45 08             	mov    0x8(%ebp),%eax
  801c29:	8d 50 01             	lea    0x1(%eax),%edx
  801c2c:	89 55 08             	mov    %edx,0x8(%ebp)
  801c2f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c32:	8b 45 08             	mov    0x8(%ebp),%eax
  801c35:	8a 00                	mov    (%eax),%al
  801c37:	84 c0                	test   %al,%al
  801c39:	74 18                	je     801c53 <strsplit+0x52>
  801c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3e:	8a 00                	mov    (%eax),%al
  801c40:	0f be c0             	movsbl %al,%eax
  801c43:	50                   	push   %eax
  801c44:	ff 75 0c             	pushl  0xc(%ebp)
  801c47:	e8 13 fb ff ff       	call   80175f <strchr>
  801c4c:	83 c4 08             	add    $0x8,%esp
  801c4f:	85 c0                	test   %eax,%eax
  801c51:	75 d3                	jne    801c26 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801c53:	8b 45 08             	mov    0x8(%ebp),%eax
  801c56:	8a 00                	mov    (%eax),%al
  801c58:	84 c0                	test   %al,%al
  801c5a:	74 5a                	je     801cb6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801c5c:	8b 45 14             	mov    0x14(%ebp),%eax
  801c5f:	8b 00                	mov    (%eax),%eax
  801c61:	83 f8 0f             	cmp    $0xf,%eax
  801c64:	75 07                	jne    801c6d <strsplit+0x6c>
		{
			return 0;
  801c66:	b8 00 00 00 00       	mov    $0x0,%eax
  801c6b:	eb 66                	jmp    801cd3 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801c6d:	8b 45 14             	mov    0x14(%ebp),%eax
  801c70:	8b 00                	mov    (%eax),%eax
  801c72:	8d 48 01             	lea    0x1(%eax),%ecx
  801c75:	8b 55 14             	mov    0x14(%ebp),%edx
  801c78:	89 0a                	mov    %ecx,(%edx)
  801c7a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c81:	8b 45 10             	mov    0x10(%ebp),%eax
  801c84:	01 c2                	add    %eax,%edx
  801c86:	8b 45 08             	mov    0x8(%ebp),%eax
  801c89:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c8b:	eb 03                	jmp    801c90 <strsplit+0x8f>
			string++;
  801c8d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c90:	8b 45 08             	mov    0x8(%ebp),%eax
  801c93:	8a 00                	mov    (%eax),%al
  801c95:	84 c0                	test   %al,%al
  801c97:	74 8b                	je     801c24 <strsplit+0x23>
  801c99:	8b 45 08             	mov    0x8(%ebp),%eax
  801c9c:	8a 00                	mov    (%eax),%al
  801c9e:	0f be c0             	movsbl %al,%eax
  801ca1:	50                   	push   %eax
  801ca2:	ff 75 0c             	pushl  0xc(%ebp)
  801ca5:	e8 b5 fa ff ff       	call   80175f <strchr>
  801caa:	83 c4 08             	add    $0x8,%esp
  801cad:	85 c0                	test   %eax,%eax
  801caf:	74 dc                	je     801c8d <strsplit+0x8c>
			string++;
	}
  801cb1:	e9 6e ff ff ff       	jmp    801c24 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801cb6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801cb7:	8b 45 14             	mov    0x14(%ebp),%eax
  801cba:	8b 00                	mov    (%eax),%eax
  801cbc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cc3:	8b 45 10             	mov    0x10(%ebp),%eax
  801cc6:	01 d0                	add    %edx,%eax
  801cc8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801cce:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801cd3:	c9                   	leave  
  801cd4:	c3                   	ret    

00801cd5 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801cd5:	55                   	push   %ebp
  801cd6:	89 e5                	mov    %esp,%ebp
  801cd8:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801cdb:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801ce2:	76 0a                	jbe    801cee <malloc+0x19>
		return NULL;
  801ce4:	b8 00 00 00 00       	mov    $0x0,%eax
  801ce9:	e9 ad 02 00 00       	jmp    801f9b <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801cee:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf1:	c1 e8 0c             	shr    $0xc,%eax
  801cf4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfa:	25 ff 0f 00 00       	and    $0xfff,%eax
  801cff:	85 c0                	test   %eax,%eax
  801d01:	74 03                	je     801d06 <malloc+0x31>
		num++;
  801d03:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801d06:	a1 28 40 80 00       	mov    0x804028,%eax
  801d0b:	85 c0                	test   %eax,%eax
  801d0d:	75 71                	jne    801d80 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801d0f:	a1 04 40 80 00       	mov    0x804004,%eax
  801d14:	83 ec 08             	sub    $0x8,%esp
  801d17:	ff 75 08             	pushl  0x8(%ebp)
  801d1a:	50                   	push   %eax
  801d1b:	e8 ba 05 00 00       	call   8022da <sys_allocateMem>
  801d20:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801d23:	a1 04 40 80 00       	mov    0x804004,%eax
  801d28:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  801d2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d2e:	c1 e0 0c             	shl    $0xc,%eax
  801d31:	89 c2                	mov    %eax,%edx
  801d33:	a1 04 40 80 00       	mov    0x804004,%eax
  801d38:	01 d0                	add    %edx,%eax
  801d3a:	a3 04 40 80 00       	mov    %eax,0x804004
		numOfPages[sizeofarray] = num;
  801d3f:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d44:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d47:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801d4e:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d53:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801d56:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
		changed[sizeofarray] = 1;
  801d5d:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d62:	c7 04 85 20 76 8c 00 	movl   $0x1,0x8c7620(,%eax,4)
  801d69:	01 00 00 00 
		sizeofarray++;
  801d6d:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d72:	40                   	inc    %eax
  801d73:	a3 2c 40 80 00       	mov    %eax,0x80402c
		return (void*) return_addres;
  801d78:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801d7b:	e9 1b 02 00 00       	jmp    801f9b <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801d80:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801d87:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801d8e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801d95:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801d9c:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801da3:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801daa:	eb 72                	jmp    801e1e <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801dac:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801daf:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  801db6:	85 c0                	test   %eax,%eax
  801db8:	75 12                	jne    801dcc <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801dba:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801dbd:	8b 04 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%eax
  801dc4:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801dc7:	ff 45 dc             	incl   -0x24(%ebp)
  801dca:	eb 4f                	jmp    801e1b <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801dcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dcf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801dd2:	7d 39                	jge    801e0d <malloc+0x138>
  801dd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dd7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801dda:	7c 31                	jl     801e0d <malloc+0x138>
					{
						min=count;
  801ddc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ddf:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801de2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801de5:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  801dec:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801def:	c1 e2 0c             	shl    $0xc,%edx
  801df2:	29 d0                	sub    %edx,%eax
  801df4:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801df7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801dfa:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801dfd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801e00:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801e07:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e0a:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801e0d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801e14:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801e1b:	ff 45 d4             	incl   -0x2c(%ebp)
  801e1e:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e23:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801e26:	7c 84                	jl     801dac <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801e28:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801e2c:	0f 85 e3 00 00 00    	jne    801f15 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801e32:	83 ec 08             	sub    $0x8,%esp
  801e35:	ff 75 08             	pushl  0x8(%ebp)
  801e38:	ff 75 e0             	pushl  -0x20(%ebp)
  801e3b:	e8 9a 04 00 00       	call   8022da <sys_allocateMem>
  801e40:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801e43:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e48:	40                   	inc    %eax
  801e49:	a3 2c 40 80 00       	mov    %eax,0x80402c
				for(int i=sizeofarray-1;i>index;i--)
  801e4e:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e53:	48                   	dec    %eax
  801e54:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801e57:	eb 42                	jmp    801e9b <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801e59:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e5c:	48                   	dec    %eax
  801e5d:	8b 14 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%edx
  801e64:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e67:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801e6e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e71:	48                   	dec    %eax
  801e72:	8b 14 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%edx
  801e79:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e7c:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
					changed[i]=changed[i-1];
  801e83:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e86:	48                   	dec    %eax
  801e87:	8b 14 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%edx
  801e8e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e91:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801e98:	ff 4d d0             	decl   -0x30(%ebp)
  801e9b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e9e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801ea1:	7f b6                	jg     801e59 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801ea3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ea6:	40                   	inc    %eax
  801ea7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801eaa:	8b 55 08             	mov    0x8(%ebp),%edx
  801ead:	01 ca                	add    %ecx,%edx
  801eaf:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801eb6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801eb9:	8d 50 01             	lea    0x1(%eax),%edx
  801ebc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ebf:	8b 04 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%eax
  801ec6:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801ec9:	89 04 95 a0 90 92 00 	mov    %eax,0x9290a0(,%edx,4)
				changed[index+1]=0;
  801ed0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ed3:	40                   	inc    %eax
  801ed4:	c7 04 85 20 76 8c 00 	movl   $0x0,0x8c7620(,%eax,4)
  801edb:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801edf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ee2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ee5:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801eec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801eef:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801ef2:	eb 11                	jmp    801f05 <malloc+0x230>
				{
					changed[index] = 1;
  801ef4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ef7:	c7 04 85 20 76 8c 00 	movl   $0x1,0x8c7620(,%eax,4)
  801efe:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801f02:	ff 45 cc             	incl   -0x34(%ebp)
  801f05:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801f08:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801f0b:	7c e7                	jl     801ef4 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801f0d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f10:	e9 86 00 00 00       	jmp    801f9b <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801f15:	a1 04 40 80 00       	mov    0x804004,%eax
  801f1a:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801f1f:	29 c2                	sub    %eax,%edx
  801f21:	89 d0                	mov    %edx,%eax
  801f23:	3b 45 08             	cmp    0x8(%ebp),%eax
  801f26:	73 07                	jae    801f2f <malloc+0x25a>
						return NULL;
  801f28:	b8 00 00 00 00       	mov    $0x0,%eax
  801f2d:	eb 6c                	jmp    801f9b <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801f2f:	a1 04 40 80 00       	mov    0x804004,%eax
  801f34:	83 ec 08             	sub    $0x8,%esp
  801f37:	ff 75 08             	pushl  0x8(%ebp)
  801f3a:	50                   	push   %eax
  801f3b:	e8 9a 03 00 00       	call   8022da <sys_allocateMem>
  801f40:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801f43:	a1 04 40 80 00       	mov    0x804004,%eax
  801f48:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801f4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f4e:	c1 e0 0c             	shl    $0xc,%eax
  801f51:	89 c2                	mov    %eax,%edx
  801f53:	a1 04 40 80 00       	mov    0x804004,%eax
  801f58:	01 d0                	add    %edx,%eax
  801f5a:	a3 04 40 80 00       	mov    %eax,0x804004
					numOfPages[sizeofarray] = num;
  801f5f:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f64:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f67:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801f6e:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f73:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801f76:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801f7d:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f82:	c7 04 85 20 76 8c 00 	movl   $0x1,0x8c7620(,%eax,4)
  801f89:	01 00 00 00 
					sizeofarray++;
  801f8d:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f92:	40                   	inc    %eax
  801f93:	a3 2c 40 80 00       	mov    %eax,0x80402c
					return (void*) return_addres;
  801f98:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801f9b:	c9                   	leave  
  801f9c:	c3                   	ret    

00801f9d <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801f9d:	55                   	push   %ebp
  801f9e:	89 e5                	mov    %esp,%ebp
  801fa0:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa6:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801fa9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801fb0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801fb7:	eb 30                	jmp    801fe9 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801fb9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fbc:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  801fc3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801fc6:	75 1e                	jne    801fe6 <free+0x49>
  801fc8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fcb:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  801fd2:	83 f8 01             	cmp    $0x1,%eax
  801fd5:	75 0f                	jne    801fe6 <free+0x49>
			is_found = 1;
  801fd7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801fde:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fe1:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801fe4:	eb 0d                	jmp    801ff3 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801fe6:	ff 45 ec             	incl   -0x14(%ebp)
  801fe9:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801fee:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801ff1:	7c c6                	jl     801fb9 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801ff3:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801ff7:	75 3a                	jne    802033 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801ff9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ffc:	8b 04 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%eax
  802003:	c1 e0 0c             	shl    $0xc,%eax
  802006:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  802009:	83 ec 08             	sub    $0x8,%esp
  80200c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80200f:	ff 75 e8             	pushl  -0x18(%ebp)
  802012:	e8 a7 02 00 00       	call   8022be <sys_freeMem>
  802017:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  80201a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80201d:	c7 04 85 20 76 8c 00 	movl   $0x0,0x8c7620(,%eax,4)
  802024:	00 00 00 00 
		changes++;
  802028:	a1 28 40 80 00       	mov    0x804028,%eax
  80202d:	40                   	inc    %eax
  80202e:	a3 28 40 80 00       	mov    %eax,0x804028
	}
	//refer to the project presentation and documentation for details
}
  802033:	90                   	nop
  802034:	c9                   	leave  
  802035:	c3                   	ret    

00802036 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  802036:	55                   	push   %ebp
  802037:	89 e5                	mov    %esp,%ebp
  802039:	83 ec 18             	sub    $0x18,%esp
  80203c:	8b 45 10             	mov    0x10(%ebp),%eax
  80203f:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802042:	83 ec 04             	sub    $0x4,%esp
  802045:	68 70 30 80 00       	push   $0x803070
  80204a:	68 b6 00 00 00       	push   $0xb6
  80204f:	68 93 30 80 00       	push   $0x803093
  802054:	e8 50 ec ff ff       	call   800ca9 <_panic>

00802059 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  802059:	55                   	push   %ebp
  80205a:	89 e5                	mov    %esp,%ebp
  80205c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80205f:	83 ec 04             	sub    $0x4,%esp
  802062:	68 70 30 80 00       	push   $0x803070
  802067:	68 bb 00 00 00       	push   $0xbb
  80206c:	68 93 30 80 00       	push   $0x803093
  802071:	e8 33 ec ff ff       	call   800ca9 <_panic>

00802076 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  802076:	55                   	push   %ebp
  802077:	89 e5                	mov    %esp,%ebp
  802079:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80207c:	83 ec 04             	sub    $0x4,%esp
  80207f:	68 70 30 80 00       	push   $0x803070
  802084:	68 c0 00 00 00       	push   $0xc0
  802089:	68 93 30 80 00       	push   $0x803093
  80208e:	e8 16 ec ff ff       	call   800ca9 <_panic>

00802093 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  802093:	55                   	push   %ebp
  802094:	89 e5                	mov    %esp,%ebp
  802096:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802099:	83 ec 04             	sub    $0x4,%esp
  80209c:	68 70 30 80 00       	push   $0x803070
  8020a1:	68 c4 00 00 00       	push   $0xc4
  8020a6:	68 93 30 80 00       	push   $0x803093
  8020ab:	e8 f9 eb ff ff       	call   800ca9 <_panic>

008020b0 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8020b0:	55                   	push   %ebp
  8020b1:	89 e5                	mov    %esp,%ebp
  8020b3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020b6:	83 ec 04             	sub    $0x4,%esp
  8020b9:	68 70 30 80 00       	push   $0x803070
  8020be:	68 c9 00 00 00       	push   $0xc9
  8020c3:	68 93 30 80 00       	push   $0x803093
  8020c8:	e8 dc eb ff ff       	call   800ca9 <_panic>

008020cd <shrink>:
}
void shrink(uint32 newSize) {
  8020cd:	55                   	push   %ebp
  8020ce:	89 e5                	mov    %esp,%ebp
  8020d0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020d3:	83 ec 04             	sub    $0x4,%esp
  8020d6:	68 70 30 80 00       	push   $0x803070
  8020db:	68 cc 00 00 00       	push   $0xcc
  8020e0:	68 93 30 80 00       	push   $0x803093
  8020e5:	e8 bf eb ff ff       	call   800ca9 <_panic>

008020ea <freeHeap>:
}

void freeHeap(void* virtual_address) {
  8020ea:	55                   	push   %ebp
  8020eb:	89 e5                	mov    %esp,%ebp
  8020ed:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020f0:	83 ec 04             	sub    $0x4,%esp
  8020f3:	68 70 30 80 00       	push   $0x803070
  8020f8:	68 d0 00 00 00       	push   $0xd0
  8020fd:	68 93 30 80 00       	push   $0x803093
  802102:	e8 a2 eb ff ff       	call   800ca9 <_panic>

00802107 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802107:	55                   	push   %ebp
  802108:	89 e5                	mov    %esp,%ebp
  80210a:	57                   	push   %edi
  80210b:	56                   	push   %esi
  80210c:	53                   	push   %ebx
  80210d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802110:	8b 45 08             	mov    0x8(%ebp),%eax
  802113:	8b 55 0c             	mov    0xc(%ebp),%edx
  802116:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802119:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80211c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80211f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802122:	cd 30                	int    $0x30
  802124:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802127:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80212a:	83 c4 10             	add    $0x10,%esp
  80212d:	5b                   	pop    %ebx
  80212e:	5e                   	pop    %esi
  80212f:	5f                   	pop    %edi
  802130:	5d                   	pop    %ebp
  802131:	c3                   	ret    

00802132 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802132:	55                   	push   %ebp
  802133:	89 e5                	mov    %esp,%ebp
  802135:	83 ec 04             	sub    $0x4,%esp
  802138:	8b 45 10             	mov    0x10(%ebp),%eax
  80213b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80213e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802142:	8b 45 08             	mov    0x8(%ebp),%eax
  802145:	6a 00                	push   $0x0
  802147:	6a 00                	push   $0x0
  802149:	52                   	push   %edx
  80214a:	ff 75 0c             	pushl  0xc(%ebp)
  80214d:	50                   	push   %eax
  80214e:	6a 00                	push   $0x0
  802150:	e8 b2 ff ff ff       	call   802107 <syscall>
  802155:	83 c4 18             	add    $0x18,%esp
}
  802158:	90                   	nop
  802159:	c9                   	leave  
  80215a:	c3                   	ret    

0080215b <sys_cgetc>:

int
sys_cgetc(void)
{
  80215b:	55                   	push   %ebp
  80215c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80215e:	6a 00                	push   $0x0
  802160:	6a 00                	push   $0x0
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	6a 00                	push   $0x0
  802168:	6a 01                	push   $0x1
  80216a:	e8 98 ff ff ff       	call   802107 <syscall>
  80216f:	83 c4 18             	add    $0x18,%esp
}
  802172:	c9                   	leave  
  802173:	c3                   	ret    

00802174 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802174:	55                   	push   %ebp
  802175:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802177:	8b 45 08             	mov    0x8(%ebp),%eax
  80217a:	6a 00                	push   $0x0
  80217c:	6a 00                	push   $0x0
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	50                   	push   %eax
  802183:	6a 05                	push   $0x5
  802185:	e8 7d ff ff ff       	call   802107 <syscall>
  80218a:	83 c4 18             	add    $0x18,%esp
}
  80218d:	c9                   	leave  
  80218e:	c3                   	ret    

0080218f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80218f:	55                   	push   %ebp
  802190:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802192:	6a 00                	push   $0x0
  802194:	6a 00                	push   $0x0
  802196:	6a 00                	push   $0x0
  802198:	6a 00                	push   $0x0
  80219a:	6a 00                	push   $0x0
  80219c:	6a 02                	push   $0x2
  80219e:	e8 64 ff ff ff       	call   802107 <syscall>
  8021a3:	83 c4 18             	add    $0x18,%esp
}
  8021a6:	c9                   	leave  
  8021a7:	c3                   	ret    

008021a8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8021a8:	55                   	push   %ebp
  8021a9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 00                	push   $0x0
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 03                	push   $0x3
  8021b7:	e8 4b ff ff ff       	call   802107 <syscall>
  8021bc:	83 c4 18             	add    $0x18,%esp
}
  8021bf:	c9                   	leave  
  8021c0:	c3                   	ret    

008021c1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8021c1:	55                   	push   %ebp
  8021c2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8021c4:	6a 00                	push   $0x0
  8021c6:	6a 00                	push   $0x0
  8021c8:	6a 00                	push   $0x0
  8021ca:	6a 00                	push   $0x0
  8021cc:	6a 00                	push   $0x0
  8021ce:	6a 04                	push   $0x4
  8021d0:	e8 32 ff ff ff       	call   802107 <syscall>
  8021d5:	83 c4 18             	add    $0x18,%esp
}
  8021d8:	c9                   	leave  
  8021d9:	c3                   	ret    

008021da <sys_env_exit>:


void sys_env_exit(void)
{
  8021da:	55                   	push   %ebp
  8021db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 06                	push   $0x6
  8021e9:	e8 19 ff ff ff       	call   802107 <syscall>
  8021ee:	83 c4 18             	add    $0x18,%esp
}
  8021f1:	90                   	nop
  8021f2:	c9                   	leave  
  8021f3:	c3                   	ret    

008021f4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8021f4:	55                   	push   %ebp
  8021f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8021f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	6a 00                	push   $0x0
  802203:	52                   	push   %edx
  802204:	50                   	push   %eax
  802205:	6a 07                	push   $0x7
  802207:	e8 fb fe ff ff       	call   802107 <syscall>
  80220c:	83 c4 18             	add    $0x18,%esp
}
  80220f:	c9                   	leave  
  802210:	c3                   	ret    

00802211 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802211:	55                   	push   %ebp
  802212:	89 e5                	mov    %esp,%ebp
  802214:	56                   	push   %esi
  802215:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802216:	8b 75 18             	mov    0x18(%ebp),%esi
  802219:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80221c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80221f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802222:	8b 45 08             	mov    0x8(%ebp),%eax
  802225:	56                   	push   %esi
  802226:	53                   	push   %ebx
  802227:	51                   	push   %ecx
  802228:	52                   	push   %edx
  802229:	50                   	push   %eax
  80222a:	6a 08                	push   $0x8
  80222c:	e8 d6 fe ff ff       	call   802107 <syscall>
  802231:	83 c4 18             	add    $0x18,%esp
}
  802234:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802237:	5b                   	pop    %ebx
  802238:	5e                   	pop    %esi
  802239:	5d                   	pop    %ebp
  80223a:	c3                   	ret    

0080223b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80223b:	55                   	push   %ebp
  80223c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80223e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802241:	8b 45 08             	mov    0x8(%ebp),%eax
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	52                   	push   %edx
  80224b:	50                   	push   %eax
  80224c:	6a 09                	push   $0x9
  80224e:	e8 b4 fe ff ff       	call   802107 <syscall>
  802253:	83 c4 18             	add    $0x18,%esp
}
  802256:	c9                   	leave  
  802257:	c3                   	ret    

00802258 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802258:	55                   	push   %ebp
  802259:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80225b:	6a 00                	push   $0x0
  80225d:	6a 00                	push   $0x0
  80225f:	6a 00                	push   $0x0
  802261:	ff 75 0c             	pushl  0xc(%ebp)
  802264:	ff 75 08             	pushl  0x8(%ebp)
  802267:	6a 0a                	push   $0xa
  802269:	e8 99 fe ff ff       	call   802107 <syscall>
  80226e:	83 c4 18             	add    $0x18,%esp
}
  802271:	c9                   	leave  
  802272:	c3                   	ret    

00802273 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802273:	55                   	push   %ebp
  802274:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802276:	6a 00                	push   $0x0
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 00                	push   $0x0
  80227e:	6a 00                	push   $0x0
  802280:	6a 0b                	push   $0xb
  802282:	e8 80 fe ff ff       	call   802107 <syscall>
  802287:	83 c4 18             	add    $0x18,%esp
}
  80228a:	c9                   	leave  
  80228b:	c3                   	ret    

0080228c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80228c:	55                   	push   %ebp
  80228d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80228f:	6a 00                	push   $0x0
  802291:	6a 00                	push   $0x0
  802293:	6a 00                	push   $0x0
  802295:	6a 00                	push   $0x0
  802297:	6a 00                	push   $0x0
  802299:	6a 0c                	push   $0xc
  80229b:	e8 67 fe ff ff       	call   802107 <syscall>
  8022a0:	83 c4 18             	add    $0x18,%esp
}
  8022a3:	c9                   	leave  
  8022a4:	c3                   	ret    

008022a5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8022a5:	55                   	push   %ebp
  8022a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8022a8:	6a 00                	push   $0x0
  8022aa:	6a 00                	push   $0x0
  8022ac:	6a 00                	push   $0x0
  8022ae:	6a 00                	push   $0x0
  8022b0:	6a 00                	push   $0x0
  8022b2:	6a 0d                	push   $0xd
  8022b4:	e8 4e fe ff ff       	call   802107 <syscall>
  8022b9:	83 c4 18             	add    $0x18,%esp
}
  8022bc:	c9                   	leave  
  8022bd:	c3                   	ret    

008022be <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8022be:	55                   	push   %ebp
  8022bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8022c1:	6a 00                	push   $0x0
  8022c3:	6a 00                	push   $0x0
  8022c5:	6a 00                	push   $0x0
  8022c7:	ff 75 0c             	pushl  0xc(%ebp)
  8022ca:	ff 75 08             	pushl  0x8(%ebp)
  8022cd:	6a 11                	push   $0x11
  8022cf:	e8 33 fe ff ff       	call   802107 <syscall>
  8022d4:	83 c4 18             	add    $0x18,%esp
	return;
  8022d7:	90                   	nop
}
  8022d8:	c9                   	leave  
  8022d9:	c3                   	ret    

008022da <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8022da:	55                   	push   %ebp
  8022db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8022dd:	6a 00                	push   $0x0
  8022df:	6a 00                	push   $0x0
  8022e1:	6a 00                	push   $0x0
  8022e3:	ff 75 0c             	pushl  0xc(%ebp)
  8022e6:	ff 75 08             	pushl  0x8(%ebp)
  8022e9:	6a 12                	push   $0x12
  8022eb:	e8 17 fe ff ff       	call   802107 <syscall>
  8022f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8022f3:	90                   	nop
}
  8022f4:	c9                   	leave  
  8022f5:	c3                   	ret    

008022f6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8022f6:	55                   	push   %ebp
  8022f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8022f9:	6a 00                	push   $0x0
  8022fb:	6a 00                	push   $0x0
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	6a 0e                	push   $0xe
  802305:	e8 fd fd ff ff       	call   802107 <syscall>
  80230a:	83 c4 18             	add    $0x18,%esp
}
  80230d:	c9                   	leave  
  80230e:	c3                   	ret    

0080230f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80230f:	55                   	push   %ebp
  802310:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802312:	6a 00                	push   $0x0
  802314:	6a 00                	push   $0x0
  802316:	6a 00                	push   $0x0
  802318:	6a 00                	push   $0x0
  80231a:	ff 75 08             	pushl  0x8(%ebp)
  80231d:	6a 0f                	push   $0xf
  80231f:	e8 e3 fd ff ff       	call   802107 <syscall>
  802324:	83 c4 18             	add    $0x18,%esp
}
  802327:	c9                   	leave  
  802328:	c3                   	ret    

00802329 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802329:	55                   	push   %ebp
  80232a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80232c:	6a 00                	push   $0x0
  80232e:	6a 00                	push   $0x0
  802330:	6a 00                	push   $0x0
  802332:	6a 00                	push   $0x0
  802334:	6a 00                	push   $0x0
  802336:	6a 10                	push   $0x10
  802338:	e8 ca fd ff ff       	call   802107 <syscall>
  80233d:	83 c4 18             	add    $0x18,%esp
}
  802340:	90                   	nop
  802341:	c9                   	leave  
  802342:	c3                   	ret    

00802343 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802343:	55                   	push   %ebp
  802344:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802346:	6a 00                	push   $0x0
  802348:	6a 00                	push   $0x0
  80234a:	6a 00                	push   $0x0
  80234c:	6a 00                	push   $0x0
  80234e:	6a 00                	push   $0x0
  802350:	6a 14                	push   $0x14
  802352:	e8 b0 fd ff ff       	call   802107 <syscall>
  802357:	83 c4 18             	add    $0x18,%esp
}
  80235a:	90                   	nop
  80235b:	c9                   	leave  
  80235c:	c3                   	ret    

0080235d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80235d:	55                   	push   %ebp
  80235e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802360:	6a 00                	push   $0x0
  802362:	6a 00                	push   $0x0
  802364:	6a 00                	push   $0x0
  802366:	6a 00                	push   $0x0
  802368:	6a 00                	push   $0x0
  80236a:	6a 15                	push   $0x15
  80236c:	e8 96 fd ff ff       	call   802107 <syscall>
  802371:	83 c4 18             	add    $0x18,%esp
}
  802374:	90                   	nop
  802375:	c9                   	leave  
  802376:	c3                   	ret    

00802377 <sys_cputc>:


void
sys_cputc(const char c)
{
  802377:	55                   	push   %ebp
  802378:	89 e5                	mov    %esp,%ebp
  80237a:	83 ec 04             	sub    $0x4,%esp
  80237d:	8b 45 08             	mov    0x8(%ebp),%eax
  802380:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802383:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802387:	6a 00                	push   $0x0
  802389:	6a 00                	push   $0x0
  80238b:	6a 00                	push   $0x0
  80238d:	6a 00                	push   $0x0
  80238f:	50                   	push   %eax
  802390:	6a 16                	push   $0x16
  802392:	e8 70 fd ff ff       	call   802107 <syscall>
  802397:	83 c4 18             	add    $0x18,%esp
}
  80239a:	90                   	nop
  80239b:	c9                   	leave  
  80239c:	c3                   	ret    

0080239d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80239d:	55                   	push   %ebp
  80239e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8023a0:	6a 00                	push   $0x0
  8023a2:	6a 00                	push   $0x0
  8023a4:	6a 00                	push   $0x0
  8023a6:	6a 00                	push   $0x0
  8023a8:	6a 00                	push   $0x0
  8023aa:	6a 17                	push   $0x17
  8023ac:	e8 56 fd ff ff       	call   802107 <syscall>
  8023b1:	83 c4 18             	add    $0x18,%esp
}
  8023b4:	90                   	nop
  8023b5:	c9                   	leave  
  8023b6:	c3                   	ret    

008023b7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8023b7:	55                   	push   %ebp
  8023b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8023ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8023bd:	6a 00                	push   $0x0
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 00                	push   $0x0
  8023c3:	ff 75 0c             	pushl  0xc(%ebp)
  8023c6:	50                   	push   %eax
  8023c7:	6a 18                	push   $0x18
  8023c9:	e8 39 fd ff ff       	call   802107 <syscall>
  8023ce:	83 c4 18             	add    $0x18,%esp
}
  8023d1:	c9                   	leave  
  8023d2:	c3                   	ret    

008023d3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8023d3:	55                   	push   %ebp
  8023d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8023d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8023dc:	6a 00                	push   $0x0
  8023de:	6a 00                	push   $0x0
  8023e0:	6a 00                	push   $0x0
  8023e2:	52                   	push   %edx
  8023e3:	50                   	push   %eax
  8023e4:	6a 1b                	push   $0x1b
  8023e6:	e8 1c fd ff ff       	call   802107 <syscall>
  8023eb:	83 c4 18             	add    $0x18,%esp
}
  8023ee:	c9                   	leave  
  8023ef:	c3                   	ret    

008023f0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8023f0:	55                   	push   %ebp
  8023f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8023f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8023f9:	6a 00                	push   $0x0
  8023fb:	6a 00                	push   $0x0
  8023fd:	6a 00                	push   $0x0
  8023ff:	52                   	push   %edx
  802400:	50                   	push   %eax
  802401:	6a 19                	push   $0x19
  802403:	e8 ff fc ff ff       	call   802107 <syscall>
  802408:	83 c4 18             	add    $0x18,%esp
}
  80240b:	90                   	nop
  80240c:	c9                   	leave  
  80240d:	c3                   	ret    

0080240e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80240e:	55                   	push   %ebp
  80240f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802411:	8b 55 0c             	mov    0xc(%ebp),%edx
  802414:	8b 45 08             	mov    0x8(%ebp),%eax
  802417:	6a 00                	push   $0x0
  802419:	6a 00                	push   $0x0
  80241b:	6a 00                	push   $0x0
  80241d:	52                   	push   %edx
  80241e:	50                   	push   %eax
  80241f:	6a 1a                	push   $0x1a
  802421:	e8 e1 fc ff ff       	call   802107 <syscall>
  802426:	83 c4 18             	add    $0x18,%esp
}
  802429:	90                   	nop
  80242a:	c9                   	leave  
  80242b:	c3                   	ret    

0080242c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80242c:	55                   	push   %ebp
  80242d:	89 e5                	mov    %esp,%ebp
  80242f:	83 ec 04             	sub    $0x4,%esp
  802432:	8b 45 10             	mov    0x10(%ebp),%eax
  802435:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802438:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80243b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80243f:	8b 45 08             	mov    0x8(%ebp),%eax
  802442:	6a 00                	push   $0x0
  802444:	51                   	push   %ecx
  802445:	52                   	push   %edx
  802446:	ff 75 0c             	pushl  0xc(%ebp)
  802449:	50                   	push   %eax
  80244a:	6a 1c                	push   $0x1c
  80244c:	e8 b6 fc ff ff       	call   802107 <syscall>
  802451:	83 c4 18             	add    $0x18,%esp
}
  802454:	c9                   	leave  
  802455:	c3                   	ret    

00802456 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802456:	55                   	push   %ebp
  802457:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802459:	8b 55 0c             	mov    0xc(%ebp),%edx
  80245c:	8b 45 08             	mov    0x8(%ebp),%eax
  80245f:	6a 00                	push   $0x0
  802461:	6a 00                	push   $0x0
  802463:	6a 00                	push   $0x0
  802465:	52                   	push   %edx
  802466:	50                   	push   %eax
  802467:	6a 1d                	push   $0x1d
  802469:	e8 99 fc ff ff       	call   802107 <syscall>
  80246e:	83 c4 18             	add    $0x18,%esp
}
  802471:	c9                   	leave  
  802472:	c3                   	ret    

00802473 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802473:	55                   	push   %ebp
  802474:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802476:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802479:	8b 55 0c             	mov    0xc(%ebp),%edx
  80247c:	8b 45 08             	mov    0x8(%ebp),%eax
  80247f:	6a 00                	push   $0x0
  802481:	6a 00                	push   $0x0
  802483:	51                   	push   %ecx
  802484:	52                   	push   %edx
  802485:	50                   	push   %eax
  802486:	6a 1e                	push   $0x1e
  802488:	e8 7a fc ff ff       	call   802107 <syscall>
  80248d:	83 c4 18             	add    $0x18,%esp
}
  802490:	c9                   	leave  
  802491:	c3                   	ret    

00802492 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802492:	55                   	push   %ebp
  802493:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802495:	8b 55 0c             	mov    0xc(%ebp),%edx
  802498:	8b 45 08             	mov    0x8(%ebp),%eax
  80249b:	6a 00                	push   $0x0
  80249d:	6a 00                	push   $0x0
  80249f:	6a 00                	push   $0x0
  8024a1:	52                   	push   %edx
  8024a2:	50                   	push   %eax
  8024a3:	6a 1f                	push   $0x1f
  8024a5:	e8 5d fc ff ff       	call   802107 <syscall>
  8024aa:	83 c4 18             	add    $0x18,%esp
}
  8024ad:	c9                   	leave  
  8024ae:	c3                   	ret    

008024af <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8024af:	55                   	push   %ebp
  8024b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8024b2:	6a 00                	push   $0x0
  8024b4:	6a 00                	push   $0x0
  8024b6:	6a 00                	push   $0x0
  8024b8:	6a 00                	push   $0x0
  8024ba:	6a 00                	push   $0x0
  8024bc:	6a 20                	push   $0x20
  8024be:	e8 44 fc ff ff       	call   802107 <syscall>
  8024c3:	83 c4 18             	add    $0x18,%esp
}
  8024c6:	c9                   	leave  
  8024c7:	c3                   	ret    

008024c8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8024c8:	55                   	push   %ebp
  8024c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8024cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ce:	6a 00                	push   $0x0
  8024d0:	ff 75 14             	pushl  0x14(%ebp)
  8024d3:	ff 75 10             	pushl  0x10(%ebp)
  8024d6:	ff 75 0c             	pushl  0xc(%ebp)
  8024d9:	50                   	push   %eax
  8024da:	6a 21                	push   $0x21
  8024dc:	e8 26 fc ff ff       	call   802107 <syscall>
  8024e1:	83 c4 18             	add    $0x18,%esp
}
  8024e4:	c9                   	leave  
  8024e5:	c3                   	ret    

008024e6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8024e6:	55                   	push   %ebp
  8024e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8024e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ec:	6a 00                	push   $0x0
  8024ee:	6a 00                	push   $0x0
  8024f0:	6a 00                	push   $0x0
  8024f2:	6a 00                	push   $0x0
  8024f4:	50                   	push   %eax
  8024f5:	6a 22                	push   $0x22
  8024f7:	e8 0b fc ff ff       	call   802107 <syscall>
  8024fc:	83 c4 18             	add    $0x18,%esp
}
  8024ff:	90                   	nop
  802500:	c9                   	leave  
  802501:	c3                   	ret    

00802502 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802502:	55                   	push   %ebp
  802503:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802505:	8b 45 08             	mov    0x8(%ebp),%eax
  802508:	6a 00                	push   $0x0
  80250a:	6a 00                	push   $0x0
  80250c:	6a 00                	push   $0x0
  80250e:	6a 00                	push   $0x0
  802510:	50                   	push   %eax
  802511:	6a 23                	push   $0x23
  802513:	e8 ef fb ff ff       	call   802107 <syscall>
  802518:	83 c4 18             	add    $0x18,%esp
}
  80251b:	90                   	nop
  80251c:	c9                   	leave  
  80251d:	c3                   	ret    

0080251e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80251e:	55                   	push   %ebp
  80251f:	89 e5                	mov    %esp,%ebp
  802521:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802524:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802527:	8d 50 04             	lea    0x4(%eax),%edx
  80252a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80252d:	6a 00                	push   $0x0
  80252f:	6a 00                	push   $0x0
  802531:	6a 00                	push   $0x0
  802533:	52                   	push   %edx
  802534:	50                   	push   %eax
  802535:	6a 24                	push   $0x24
  802537:	e8 cb fb ff ff       	call   802107 <syscall>
  80253c:	83 c4 18             	add    $0x18,%esp
	return result;
  80253f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802542:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802545:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802548:	89 01                	mov    %eax,(%ecx)
  80254a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80254d:	8b 45 08             	mov    0x8(%ebp),%eax
  802550:	c9                   	leave  
  802551:	c2 04 00             	ret    $0x4

00802554 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802554:	55                   	push   %ebp
  802555:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802557:	6a 00                	push   $0x0
  802559:	6a 00                	push   $0x0
  80255b:	ff 75 10             	pushl  0x10(%ebp)
  80255e:	ff 75 0c             	pushl  0xc(%ebp)
  802561:	ff 75 08             	pushl  0x8(%ebp)
  802564:	6a 13                	push   $0x13
  802566:	e8 9c fb ff ff       	call   802107 <syscall>
  80256b:	83 c4 18             	add    $0x18,%esp
	return ;
  80256e:	90                   	nop
}
  80256f:	c9                   	leave  
  802570:	c3                   	ret    

00802571 <sys_rcr2>:
uint32 sys_rcr2()
{
  802571:	55                   	push   %ebp
  802572:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802574:	6a 00                	push   $0x0
  802576:	6a 00                	push   $0x0
  802578:	6a 00                	push   $0x0
  80257a:	6a 00                	push   $0x0
  80257c:	6a 00                	push   $0x0
  80257e:	6a 25                	push   $0x25
  802580:	e8 82 fb ff ff       	call   802107 <syscall>
  802585:	83 c4 18             	add    $0x18,%esp
}
  802588:	c9                   	leave  
  802589:	c3                   	ret    

0080258a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80258a:	55                   	push   %ebp
  80258b:	89 e5                	mov    %esp,%ebp
  80258d:	83 ec 04             	sub    $0x4,%esp
  802590:	8b 45 08             	mov    0x8(%ebp),%eax
  802593:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802596:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80259a:	6a 00                	push   $0x0
  80259c:	6a 00                	push   $0x0
  80259e:	6a 00                	push   $0x0
  8025a0:	6a 00                	push   $0x0
  8025a2:	50                   	push   %eax
  8025a3:	6a 26                	push   $0x26
  8025a5:	e8 5d fb ff ff       	call   802107 <syscall>
  8025aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8025ad:	90                   	nop
}
  8025ae:	c9                   	leave  
  8025af:	c3                   	ret    

008025b0 <rsttst>:
void rsttst()
{
  8025b0:	55                   	push   %ebp
  8025b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8025b3:	6a 00                	push   $0x0
  8025b5:	6a 00                	push   $0x0
  8025b7:	6a 00                	push   $0x0
  8025b9:	6a 00                	push   $0x0
  8025bb:	6a 00                	push   $0x0
  8025bd:	6a 28                	push   $0x28
  8025bf:	e8 43 fb ff ff       	call   802107 <syscall>
  8025c4:	83 c4 18             	add    $0x18,%esp
	return ;
  8025c7:	90                   	nop
}
  8025c8:	c9                   	leave  
  8025c9:	c3                   	ret    

008025ca <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8025ca:	55                   	push   %ebp
  8025cb:	89 e5                	mov    %esp,%ebp
  8025cd:	83 ec 04             	sub    $0x4,%esp
  8025d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8025d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8025d6:	8b 55 18             	mov    0x18(%ebp),%edx
  8025d9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8025dd:	52                   	push   %edx
  8025de:	50                   	push   %eax
  8025df:	ff 75 10             	pushl  0x10(%ebp)
  8025e2:	ff 75 0c             	pushl  0xc(%ebp)
  8025e5:	ff 75 08             	pushl  0x8(%ebp)
  8025e8:	6a 27                	push   $0x27
  8025ea:	e8 18 fb ff ff       	call   802107 <syscall>
  8025ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8025f2:	90                   	nop
}
  8025f3:	c9                   	leave  
  8025f4:	c3                   	ret    

008025f5 <chktst>:
void chktst(uint32 n)
{
  8025f5:	55                   	push   %ebp
  8025f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8025f8:	6a 00                	push   $0x0
  8025fa:	6a 00                	push   $0x0
  8025fc:	6a 00                	push   $0x0
  8025fe:	6a 00                	push   $0x0
  802600:	ff 75 08             	pushl  0x8(%ebp)
  802603:	6a 29                	push   $0x29
  802605:	e8 fd fa ff ff       	call   802107 <syscall>
  80260a:	83 c4 18             	add    $0x18,%esp
	return ;
  80260d:	90                   	nop
}
  80260e:	c9                   	leave  
  80260f:	c3                   	ret    

00802610 <inctst>:

void inctst()
{
  802610:	55                   	push   %ebp
  802611:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802613:	6a 00                	push   $0x0
  802615:	6a 00                	push   $0x0
  802617:	6a 00                	push   $0x0
  802619:	6a 00                	push   $0x0
  80261b:	6a 00                	push   $0x0
  80261d:	6a 2a                	push   $0x2a
  80261f:	e8 e3 fa ff ff       	call   802107 <syscall>
  802624:	83 c4 18             	add    $0x18,%esp
	return ;
  802627:	90                   	nop
}
  802628:	c9                   	leave  
  802629:	c3                   	ret    

0080262a <gettst>:
uint32 gettst()
{
  80262a:	55                   	push   %ebp
  80262b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80262d:	6a 00                	push   $0x0
  80262f:	6a 00                	push   $0x0
  802631:	6a 00                	push   $0x0
  802633:	6a 00                	push   $0x0
  802635:	6a 00                	push   $0x0
  802637:	6a 2b                	push   $0x2b
  802639:	e8 c9 fa ff ff       	call   802107 <syscall>
  80263e:	83 c4 18             	add    $0x18,%esp
}
  802641:	c9                   	leave  
  802642:	c3                   	ret    

00802643 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802643:	55                   	push   %ebp
  802644:	89 e5                	mov    %esp,%ebp
  802646:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802649:	6a 00                	push   $0x0
  80264b:	6a 00                	push   $0x0
  80264d:	6a 00                	push   $0x0
  80264f:	6a 00                	push   $0x0
  802651:	6a 00                	push   $0x0
  802653:	6a 2c                	push   $0x2c
  802655:	e8 ad fa ff ff       	call   802107 <syscall>
  80265a:	83 c4 18             	add    $0x18,%esp
  80265d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802660:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802664:	75 07                	jne    80266d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802666:	b8 01 00 00 00       	mov    $0x1,%eax
  80266b:	eb 05                	jmp    802672 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80266d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802672:	c9                   	leave  
  802673:	c3                   	ret    

00802674 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802674:	55                   	push   %ebp
  802675:	89 e5                	mov    %esp,%ebp
  802677:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80267a:	6a 00                	push   $0x0
  80267c:	6a 00                	push   $0x0
  80267e:	6a 00                	push   $0x0
  802680:	6a 00                	push   $0x0
  802682:	6a 00                	push   $0x0
  802684:	6a 2c                	push   $0x2c
  802686:	e8 7c fa ff ff       	call   802107 <syscall>
  80268b:	83 c4 18             	add    $0x18,%esp
  80268e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802691:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802695:	75 07                	jne    80269e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802697:	b8 01 00 00 00       	mov    $0x1,%eax
  80269c:	eb 05                	jmp    8026a3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80269e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026a3:	c9                   	leave  
  8026a4:	c3                   	ret    

008026a5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8026a5:	55                   	push   %ebp
  8026a6:	89 e5                	mov    %esp,%ebp
  8026a8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026ab:	6a 00                	push   $0x0
  8026ad:	6a 00                	push   $0x0
  8026af:	6a 00                	push   $0x0
  8026b1:	6a 00                	push   $0x0
  8026b3:	6a 00                	push   $0x0
  8026b5:	6a 2c                	push   $0x2c
  8026b7:	e8 4b fa ff ff       	call   802107 <syscall>
  8026bc:	83 c4 18             	add    $0x18,%esp
  8026bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8026c2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8026c6:	75 07                	jne    8026cf <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8026c8:	b8 01 00 00 00       	mov    $0x1,%eax
  8026cd:	eb 05                	jmp    8026d4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8026cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026d4:	c9                   	leave  
  8026d5:	c3                   	ret    

008026d6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8026d6:	55                   	push   %ebp
  8026d7:	89 e5                	mov    %esp,%ebp
  8026d9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026dc:	6a 00                	push   $0x0
  8026de:	6a 00                	push   $0x0
  8026e0:	6a 00                	push   $0x0
  8026e2:	6a 00                	push   $0x0
  8026e4:	6a 00                	push   $0x0
  8026e6:	6a 2c                	push   $0x2c
  8026e8:	e8 1a fa ff ff       	call   802107 <syscall>
  8026ed:	83 c4 18             	add    $0x18,%esp
  8026f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8026f3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8026f7:	75 07                	jne    802700 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8026f9:	b8 01 00 00 00       	mov    $0x1,%eax
  8026fe:	eb 05                	jmp    802705 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802700:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802705:	c9                   	leave  
  802706:	c3                   	ret    

00802707 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802707:	55                   	push   %ebp
  802708:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80270a:	6a 00                	push   $0x0
  80270c:	6a 00                	push   $0x0
  80270e:	6a 00                	push   $0x0
  802710:	6a 00                	push   $0x0
  802712:	ff 75 08             	pushl  0x8(%ebp)
  802715:	6a 2d                	push   $0x2d
  802717:	e8 eb f9 ff ff       	call   802107 <syscall>
  80271c:	83 c4 18             	add    $0x18,%esp
	return ;
  80271f:	90                   	nop
}
  802720:	c9                   	leave  
  802721:	c3                   	ret    

00802722 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802722:	55                   	push   %ebp
  802723:	89 e5                	mov    %esp,%ebp
  802725:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802726:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802729:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80272c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80272f:	8b 45 08             	mov    0x8(%ebp),%eax
  802732:	6a 00                	push   $0x0
  802734:	53                   	push   %ebx
  802735:	51                   	push   %ecx
  802736:	52                   	push   %edx
  802737:	50                   	push   %eax
  802738:	6a 2e                	push   $0x2e
  80273a:	e8 c8 f9 ff ff       	call   802107 <syscall>
  80273f:	83 c4 18             	add    $0x18,%esp
}
  802742:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802745:	c9                   	leave  
  802746:	c3                   	ret    

00802747 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802747:	55                   	push   %ebp
  802748:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80274a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80274d:	8b 45 08             	mov    0x8(%ebp),%eax
  802750:	6a 00                	push   $0x0
  802752:	6a 00                	push   $0x0
  802754:	6a 00                	push   $0x0
  802756:	52                   	push   %edx
  802757:	50                   	push   %eax
  802758:	6a 2f                	push   $0x2f
  80275a:	e8 a8 f9 ff ff       	call   802107 <syscall>
  80275f:	83 c4 18             	add    $0x18,%esp
}
  802762:	c9                   	leave  
  802763:	c3                   	ret    

00802764 <__udivdi3>:
  802764:	55                   	push   %ebp
  802765:	57                   	push   %edi
  802766:	56                   	push   %esi
  802767:	53                   	push   %ebx
  802768:	83 ec 1c             	sub    $0x1c,%esp
  80276b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80276f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802773:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802777:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80277b:	89 ca                	mov    %ecx,%edx
  80277d:	89 f8                	mov    %edi,%eax
  80277f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802783:	85 f6                	test   %esi,%esi
  802785:	75 2d                	jne    8027b4 <__udivdi3+0x50>
  802787:	39 cf                	cmp    %ecx,%edi
  802789:	77 65                	ja     8027f0 <__udivdi3+0x8c>
  80278b:	89 fd                	mov    %edi,%ebp
  80278d:	85 ff                	test   %edi,%edi
  80278f:	75 0b                	jne    80279c <__udivdi3+0x38>
  802791:	b8 01 00 00 00       	mov    $0x1,%eax
  802796:	31 d2                	xor    %edx,%edx
  802798:	f7 f7                	div    %edi
  80279a:	89 c5                	mov    %eax,%ebp
  80279c:	31 d2                	xor    %edx,%edx
  80279e:	89 c8                	mov    %ecx,%eax
  8027a0:	f7 f5                	div    %ebp
  8027a2:	89 c1                	mov    %eax,%ecx
  8027a4:	89 d8                	mov    %ebx,%eax
  8027a6:	f7 f5                	div    %ebp
  8027a8:	89 cf                	mov    %ecx,%edi
  8027aa:	89 fa                	mov    %edi,%edx
  8027ac:	83 c4 1c             	add    $0x1c,%esp
  8027af:	5b                   	pop    %ebx
  8027b0:	5e                   	pop    %esi
  8027b1:	5f                   	pop    %edi
  8027b2:	5d                   	pop    %ebp
  8027b3:	c3                   	ret    
  8027b4:	39 ce                	cmp    %ecx,%esi
  8027b6:	77 28                	ja     8027e0 <__udivdi3+0x7c>
  8027b8:	0f bd fe             	bsr    %esi,%edi
  8027bb:	83 f7 1f             	xor    $0x1f,%edi
  8027be:	75 40                	jne    802800 <__udivdi3+0x9c>
  8027c0:	39 ce                	cmp    %ecx,%esi
  8027c2:	72 0a                	jb     8027ce <__udivdi3+0x6a>
  8027c4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8027c8:	0f 87 9e 00 00 00    	ja     80286c <__udivdi3+0x108>
  8027ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8027d3:	89 fa                	mov    %edi,%edx
  8027d5:	83 c4 1c             	add    $0x1c,%esp
  8027d8:	5b                   	pop    %ebx
  8027d9:	5e                   	pop    %esi
  8027da:	5f                   	pop    %edi
  8027db:	5d                   	pop    %ebp
  8027dc:	c3                   	ret    
  8027dd:	8d 76 00             	lea    0x0(%esi),%esi
  8027e0:	31 ff                	xor    %edi,%edi
  8027e2:	31 c0                	xor    %eax,%eax
  8027e4:	89 fa                	mov    %edi,%edx
  8027e6:	83 c4 1c             	add    $0x1c,%esp
  8027e9:	5b                   	pop    %ebx
  8027ea:	5e                   	pop    %esi
  8027eb:	5f                   	pop    %edi
  8027ec:	5d                   	pop    %ebp
  8027ed:	c3                   	ret    
  8027ee:	66 90                	xchg   %ax,%ax
  8027f0:	89 d8                	mov    %ebx,%eax
  8027f2:	f7 f7                	div    %edi
  8027f4:	31 ff                	xor    %edi,%edi
  8027f6:	89 fa                	mov    %edi,%edx
  8027f8:	83 c4 1c             	add    $0x1c,%esp
  8027fb:	5b                   	pop    %ebx
  8027fc:	5e                   	pop    %esi
  8027fd:	5f                   	pop    %edi
  8027fe:	5d                   	pop    %ebp
  8027ff:	c3                   	ret    
  802800:	bd 20 00 00 00       	mov    $0x20,%ebp
  802805:	89 eb                	mov    %ebp,%ebx
  802807:	29 fb                	sub    %edi,%ebx
  802809:	89 f9                	mov    %edi,%ecx
  80280b:	d3 e6                	shl    %cl,%esi
  80280d:	89 c5                	mov    %eax,%ebp
  80280f:	88 d9                	mov    %bl,%cl
  802811:	d3 ed                	shr    %cl,%ebp
  802813:	89 e9                	mov    %ebp,%ecx
  802815:	09 f1                	or     %esi,%ecx
  802817:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80281b:	89 f9                	mov    %edi,%ecx
  80281d:	d3 e0                	shl    %cl,%eax
  80281f:	89 c5                	mov    %eax,%ebp
  802821:	89 d6                	mov    %edx,%esi
  802823:	88 d9                	mov    %bl,%cl
  802825:	d3 ee                	shr    %cl,%esi
  802827:	89 f9                	mov    %edi,%ecx
  802829:	d3 e2                	shl    %cl,%edx
  80282b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80282f:	88 d9                	mov    %bl,%cl
  802831:	d3 e8                	shr    %cl,%eax
  802833:	09 c2                	or     %eax,%edx
  802835:	89 d0                	mov    %edx,%eax
  802837:	89 f2                	mov    %esi,%edx
  802839:	f7 74 24 0c          	divl   0xc(%esp)
  80283d:	89 d6                	mov    %edx,%esi
  80283f:	89 c3                	mov    %eax,%ebx
  802841:	f7 e5                	mul    %ebp
  802843:	39 d6                	cmp    %edx,%esi
  802845:	72 19                	jb     802860 <__udivdi3+0xfc>
  802847:	74 0b                	je     802854 <__udivdi3+0xf0>
  802849:	89 d8                	mov    %ebx,%eax
  80284b:	31 ff                	xor    %edi,%edi
  80284d:	e9 58 ff ff ff       	jmp    8027aa <__udivdi3+0x46>
  802852:	66 90                	xchg   %ax,%ax
  802854:	8b 54 24 08          	mov    0x8(%esp),%edx
  802858:	89 f9                	mov    %edi,%ecx
  80285a:	d3 e2                	shl    %cl,%edx
  80285c:	39 c2                	cmp    %eax,%edx
  80285e:	73 e9                	jae    802849 <__udivdi3+0xe5>
  802860:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802863:	31 ff                	xor    %edi,%edi
  802865:	e9 40 ff ff ff       	jmp    8027aa <__udivdi3+0x46>
  80286a:	66 90                	xchg   %ax,%ax
  80286c:	31 c0                	xor    %eax,%eax
  80286e:	e9 37 ff ff ff       	jmp    8027aa <__udivdi3+0x46>
  802873:	90                   	nop

00802874 <__umoddi3>:
  802874:	55                   	push   %ebp
  802875:	57                   	push   %edi
  802876:	56                   	push   %esi
  802877:	53                   	push   %ebx
  802878:	83 ec 1c             	sub    $0x1c,%esp
  80287b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80287f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802883:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802887:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80288b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80288f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802893:	89 f3                	mov    %esi,%ebx
  802895:	89 fa                	mov    %edi,%edx
  802897:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80289b:	89 34 24             	mov    %esi,(%esp)
  80289e:	85 c0                	test   %eax,%eax
  8028a0:	75 1a                	jne    8028bc <__umoddi3+0x48>
  8028a2:	39 f7                	cmp    %esi,%edi
  8028a4:	0f 86 a2 00 00 00    	jbe    80294c <__umoddi3+0xd8>
  8028aa:	89 c8                	mov    %ecx,%eax
  8028ac:	89 f2                	mov    %esi,%edx
  8028ae:	f7 f7                	div    %edi
  8028b0:	89 d0                	mov    %edx,%eax
  8028b2:	31 d2                	xor    %edx,%edx
  8028b4:	83 c4 1c             	add    $0x1c,%esp
  8028b7:	5b                   	pop    %ebx
  8028b8:	5e                   	pop    %esi
  8028b9:	5f                   	pop    %edi
  8028ba:	5d                   	pop    %ebp
  8028bb:	c3                   	ret    
  8028bc:	39 f0                	cmp    %esi,%eax
  8028be:	0f 87 ac 00 00 00    	ja     802970 <__umoddi3+0xfc>
  8028c4:	0f bd e8             	bsr    %eax,%ebp
  8028c7:	83 f5 1f             	xor    $0x1f,%ebp
  8028ca:	0f 84 ac 00 00 00    	je     80297c <__umoddi3+0x108>
  8028d0:	bf 20 00 00 00       	mov    $0x20,%edi
  8028d5:	29 ef                	sub    %ebp,%edi
  8028d7:	89 fe                	mov    %edi,%esi
  8028d9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8028dd:	89 e9                	mov    %ebp,%ecx
  8028df:	d3 e0                	shl    %cl,%eax
  8028e1:	89 d7                	mov    %edx,%edi
  8028e3:	89 f1                	mov    %esi,%ecx
  8028e5:	d3 ef                	shr    %cl,%edi
  8028e7:	09 c7                	or     %eax,%edi
  8028e9:	89 e9                	mov    %ebp,%ecx
  8028eb:	d3 e2                	shl    %cl,%edx
  8028ed:	89 14 24             	mov    %edx,(%esp)
  8028f0:	89 d8                	mov    %ebx,%eax
  8028f2:	d3 e0                	shl    %cl,%eax
  8028f4:	89 c2                	mov    %eax,%edx
  8028f6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8028fa:	d3 e0                	shl    %cl,%eax
  8028fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  802900:	8b 44 24 08          	mov    0x8(%esp),%eax
  802904:	89 f1                	mov    %esi,%ecx
  802906:	d3 e8                	shr    %cl,%eax
  802908:	09 d0                	or     %edx,%eax
  80290a:	d3 eb                	shr    %cl,%ebx
  80290c:	89 da                	mov    %ebx,%edx
  80290e:	f7 f7                	div    %edi
  802910:	89 d3                	mov    %edx,%ebx
  802912:	f7 24 24             	mull   (%esp)
  802915:	89 c6                	mov    %eax,%esi
  802917:	89 d1                	mov    %edx,%ecx
  802919:	39 d3                	cmp    %edx,%ebx
  80291b:	0f 82 87 00 00 00    	jb     8029a8 <__umoddi3+0x134>
  802921:	0f 84 91 00 00 00    	je     8029b8 <__umoddi3+0x144>
  802927:	8b 54 24 04          	mov    0x4(%esp),%edx
  80292b:	29 f2                	sub    %esi,%edx
  80292d:	19 cb                	sbb    %ecx,%ebx
  80292f:	89 d8                	mov    %ebx,%eax
  802931:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802935:	d3 e0                	shl    %cl,%eax
  802937:	89 e9                	mov    %ebp,%ecx
  802939:	d3 ea                	shr    %cl,%edx
  80293b:	09 d0                	or     %edx,%eax
  80293d:	89 e9                	mov    %ebp,%ecx
  80293f:	d3 eb                	shr    %cl,%ebx
  802941:	89 da                	mov    %ebx,%edx
  802943:	83 c4 1c             	add    $0x1c,%esp
  802946:	5b                   	pop    %ebx
  802947:	5e                   	pop    %esi
  802948:	5f                   	pop    %edi
  802949:	5d                   	pop    %ebp
  80294a:	c3                   	ret    
  80294b:	90                   	nop
  80294c:	89 fd                	mov    %edi,%ebp
  80294e:	85 ff                	test   %edi,%edi
  802950:	75 0b                	jne    80295d <__umoddi3+0xe9>
  802952:	b8 01 00 00 00       	mov    $0x1,%eax
  802957:	31 d2                	xor    %edx,%edx
  802959:	f7 f7                	div    %edi
  80295b:	89 c5                	mov    %eax,%ebp
  80295d:	89 f0                	mov    %esi,%eax
  80295f:	31 d2                	xor    %edx,%edx
  802961:	f7 f5                	div    %ebp
  802963:	89 c8                	mov    %ecx,%eax
  802965:	f7 f5                	div    %ebp
  802967:	89 d0                	mov    %edx,%eax
  802969:	e9 44 ff ff ff       	jmp    8028b2 <__umoddi3+0x3e>
  80296e:	66 90                	xchg   %ax,%ax
  802970:	89 c8                	mov    %ecx,%eax
  802972:	89 f2                	mov    %esi,%edx
  802974:	83 c4 1c             	add    $0x1c,%esp
  802977:	5b                   	pop    %ebx
  802978:	5e                   	pop    %esi
  802979:	5f                   	pop    %edi
  80297a:	5d                   	pop    %ebp
  80297b:	c3                   	ret    
  80297c:	3b 04 24             	cmp    (%esp),%eax
  80297f:	72 06                	jb     802987 <__umoddi3+0x113>
  802981:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802985:	77 0f                	ja     802996 <__umoddi3+0x122>
  802987:	89 f2                	mov    %esi,%edx
  802989:	29 f9                	sub    %edi,%ecx
  80298b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80298f:	89 14 24             	mov    %edx,(%esp)
  802992:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802996:	8b 44 24 04          	mov    0x4(%esp),%eax
  80299a:	8b 14 24             	mov    (%esp),%edx
  80299d:	83 c4 1c             	add    $0x1c,%esp
  8029a0:	5b                   	pop    %ebx
  8029a1:	5e                   	pop    %esi
  8029a2:	5f                   	pop    %edi
  8029a3:	5d                   	pop    %ebp
  8029a4:	c3                   	ret    
  8029a5:	8d 76 00             	lea    0x0(%esi),%esi
  8029a8:	2b 04 24             	sub    (%esp),%eax
  8029ab:	19 fa                	sbb    %edi,%edx
  8029ad:	89 d1                	mov    %edx,%ecx
  8029af:	89 c6                	mov    %eax,%esi
  8029b1:	e9 71 ff ff ff       	jmp    802927 <__umoddi3+0xb3>
  8029b6:	66 90                	xchg   %ax,%ax
  8029b8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8029bc:	72 ea                	jb     8029a8 <__umoddi3+0x134>
  8029be:	89 d9                	mov    %ebx,%ecx
  8029c0:	e9 62 ff ff ff       	jmp    802927 <__umoddi3+0xb3>

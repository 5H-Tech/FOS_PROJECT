
obj/user/tst_placement_1:     file format elf32-i386


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
  800031:	e8 41 03 00 00       	call   800377 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	81 ec 70 00 00 01    	sub    $0x1000070,%esp

	//	cprintf("envID = %d\n",envID);
	char arr[PAGE_SIZE*1024*4];

	uint32 actual_active_list[17] = {0xedbfdb78,0xeebfd000,0x803000,0x802000,0x801000,0x800000,0x205000,0x204000,0x203000,0x202000,0x201000,0x200000};
  800043:	8d 95 9c ff ff fe    	lea    -0x1000064(%ebp),%edx
  800049:	b9 11 00 00 00       	mov    $0x11,%ecx
  80004e:	b8 00 00 00 00       	mov    $0x0,%eax
  800053:	89 d7                	mov    %edx,%edi
  800055:	f3 ab                	rep stos %eax,%es:(%edi)
  800057:	c7 85 9c ff ff fe 78 	movl   $0xedbfdb78,-0x1000064(%ebp)
  80005e:	db bf ed 
  800061:	c7 85 a0 ff ff fe 00 	movl   $0xeebfd000,-0x1000060(%ebp)
  800068:	d0 bf ee 
  80006b:	c7 85 a4 ff ff fe 00 	movl   $0x803000,-0x100005c(%ebp)
  800072:	30 80 00 
  800075:	c7 85 a8 ff ff fe 00 	movl   $0x802000,-0x1000058(%ebp)
  80007c:	20 80 00 
  80007f:	c7 85 ac ff ff fe 00 	movl   $0x801000,-0x1000054(%ebp)
  800086:	10 80 00 
  800089:	c7 85 b0 ff ff fe 00 	movl   $0x800000,-0x1000050(%ebp)
  800090:	00 80 00 
  800093:	c7 85 b4 ff ff fe 00 	movl   $0x205000,-0x100004c(%ebp)
  80009a:	50 20 00 
  80009d:	c7 85 b8 ff ff fe 00 	movl   $0x204000,-0x1000048(%ebp)
  8000a4:	40 20 00 
  8000a7:	c7 85 bc ff ff fe 00 	movl   $0x203000,-0x1000044(%ebp)
  8000ae:	30 20 00 
  8000b1:	c7 85 c0 ff ff fe 00 	movl   $0x202000,-0x1000040(%ebp)
  8000b8:	20 20 00 
  8000bb:	c7 85 c4 ff ff fe 00 	movl   $0x201000,-0x100003c(%ebp)
  8000c2:	10 20 00 
  8000c5:	c7 85 c8 ff ff fe 00 	movl   $0x200000,-0x1000038(%ebp)
  8000cc:	00 20 00 
	uint32 actual_second_list[2] = {};
  8000cf:	c7 85 94 ff ff fe 00 	movl   $0x0,-0x100006c(%ebp)
  8000d6:	00 00 00 
  8000d9:	c7 85 98 ff ff fe 00 	movl   $0x0,-0x1000068(%ebp)
  8000e0:	00 00 00 
	("STEP 0: checking Initial LRU lists entries ...\n");
	{
		int check = sys_check_LRU_lists(actual_active_list, actual_second_list, 12, 0);
  8000e3:	6a 00                	push   $0x0
  8000e5:	6a 0c                	push   $0xc
  8000e7:	8d 85 94 ff ff fe    	lea    -0x100006c(%ebp),%eax
  8000ed:	50                   	push   %eax
  8000ee:	8d 85 9c ff ff fe    	lea    -0x1000064(%ebp),%eax
  8000f4:	50                   	push   %eax
  8000f5:	e8 09 1a 00 00       	call   801b03 <sys_check_LRU_lists>
  8000fa:	83 c4 10             	add    $0x10,%esp
  8000fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if(check == 0)
  800100:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800104:	75 14                	jne    80011a <_main+0xe2>
			panic("INITIAL PAGE LRU LISTs entry checking failed! Review size of the LRU lists..!!");
  800106:	83 ec 04             	sub    $0x4,%esp
  800109:	68 c0 1d 80 00       	push   $0x801dc0
  80010e:	6a 15                	push   $0x15
  800110:	68 0f 1e 80 00       	push   $0x801e0f
  800115:	e8 a2 03 00 00       	call   8004bc <_panic>
	}

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80011a:	e8 b8 15 00 00       	call   8016d7 <sys_pf_calculate_allocated_pages>
  80011f:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int freePages = sys_calculate_free_frames();
  800122:	e8 2d 15 00 00       	call   801654 <sys_calculate_free_frames>
  800127:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	int i=0;
  80012a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for(;i<=PAGE_SIZE;i++)
  800131:	eb 11                	jmp    800144 <_main+0x10c>
	{
		arr[i] = -1;
  800133:	8d 95 e0 ff ff fe    	lea    -0x1000020(%ebp),%edx
  800139:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	c6 00 ff             	movb   $0xff,(%eax)

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
	int freePages = sys_calculate_free_frames();

	int i=0;
	for(;i<=PAGE_SIZE;i++)
  800141:	ff 45 f4             	incl   -0xc(%ebp)
  800144:	81 7d f4 00 10 00 00 	cmpl   $0x1000,-0xc(%ebp)
  80014b:	7e e6                	jle    800133 <_main+0xfb>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
  80014d:	c7 45 f4 00 00 40 00 	movl   $0x400000,-0xc(%ebp)
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  800154:	eb 11                	jmp    800167 <_main+0x12f>
	{
		arr[i] = -1;
  800156:	8d 95 e0 ff ff fe    	lea    -0x1000020(%ebp),%edx
  80015c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80015f:	01 d0                	add    %edx,%eax
  800161:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  800164:	ff 45 f4             	incl   -0xc(%ebp)
  800167:	81 7d f4 00 10 40 00 	cmpl   $0x401000,-0xc(%ebp)
  80016e:	7e e6                	jle    800156 <_main+0x11e>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
  800170:	c7 45 f4 00 00 80 00 	movl   $0x800000,-0xc(%ebp)
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  800177:	eb 11                	jmp    80018a <_main+0x152>
	{
		arr[i] = -1;
  800179:	8d 95 e0 ff ff fe    	lea    -0x1000020(%ebp),%edx
  80017f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800182:	01 d0                	add    %edx,%eax
  800184:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  800187:	ff 45 f4             	incl   -0xc(%ebp)
  80018a:	81 7d f4 00 10 80 00 	cmpl   $0x801000,-0xc(%ebp)
  800191:	7e e6                	jle    800179 <_main+0x141>
		arr[i] = -1;
	}



	cprintf("STEP A: checking PLACEMENT fault handling ... \n");
  800193:	83 ec 0c             	sub    $0xc,%esp
  800196:	68 28 1e 80 00       	push   $0x801e28
  80019b:	e8 be 05 00 00       	call   80075e <cprintf>
  8001a0:	83 c4 10             	add    $0x10,%esp
	{
		if( arr[0] !=  -1)  panic("PLACEMENT of stack page failed");
  8001a3:	8a 85 e0 ff ff fe    	mov    -0x1000020(%ebp),%al
  8001a9:	3c ff                	cmp    $0xff,%al
  8001ab:	74 14                	je     8001c1 <_main+0x189>
  8001ad:	83 ec 04             	sub    $0x4,%esp
  8001b0:	68 58 1e 80 00       	push   $0x801e58
  8001b5:	6a 31                	push   $0x31
  8001b7:	68 0f 1e 80 00       	push   $0x801e0f
  8001bc:	e8 fb 02 00 00       	call   8004bc <_panic>
		if( arr[PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  8001c1:	8a 85 e0 0f 00 ff    	mov    -0xfff020(%ebp),%al
  8001c7:	3c ff                	cmp    $0xff,%al
  8001c9:	74 14                	je     8001df <_main+0x1a7>
  8001cb:	83 ec 04             	sub    $0x4,%esp
  8001ce:	68 58 1e 80 00       	push   $0x801e58
  8001d3:	6a 32                	push   $0x32
  8001d5:	68 0f 1e 80 00       	push   $0x801e0f
  8001da:	e8 dd 02 00 00       	call   8004bc <_panic>

		if( arr[PAGE_SIZE*1024] !=  -1)  panic("PLACEMENT of stack page failed");
  8001df:	8a 85 e0 ff 3f ff    	mov    -0xc00020(%ebp),%al
  8001e5:	3c ff                	cmp    $0xff,%al
  8001e7:	74 14                	je     8001fd <_main+0x1c5>
  8001e9:	83 ec 04             	sub    $0x4,%esp
  8001ec:	68 58 1e 80 00       	push   $0x801e58
  8001f1:	6a 34                	push   $0x34
  8001f3:	68 0f 1e 80 00       	push   $0x801e0f
  8001f8:	e8 bf 02 00 00       	call   8004bc <_panic>
		if( arr[PAGE_SIZE*1025] !=  -1)  panic("PLACEMENT of stack page failed");
  8001fd:	8a 85 e0 0f 40 ff    	mov    -0xbff020(%ebp),%al
  800203:	3c ff                	cmp    $0xff,%al
  800205:	74 14                	je     80021b <_main+0x1e3>
  800207:	83 ec 04             	sub    $0x4,%esp
  80020a:	68 58 1e 80 00       	push   $0x801e58
  80020f:	6a 35                	push   $0x35
  800211:	68 0f 1e 80 00       	push   $0x801e0f
  800216:	e8 a1 02 00 00       	call   8004bc <_panic>

		if( arr[PAGE_SIZE*1024*2] !=  -1)  panic("PLACEMENT of stack page failed");
  80021b:	8a 85 e0 ff 7f ff    	mov    -0x800020(%ebp),%al
  800221:	3c ff                	cmp    $0xff,%al
  800223:	74 14                	je     800239 <_main+0x201>
  800225:	83 ec 04             	sub    $0x4,%esp
  800228:	68 58 1e 80 00       	push   $0x801e58
  80022d:	6a 37                	push   $0x37
  80022f:	68 0f 1e 80 00       	push   $0x801e0f
  800234:	e8 83 02 00 00       	call   8004bc <_panic>
		if( arr[PAGE_SIZE*1024*2 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  800239:	8a 85 e0 0f 80 ff    	mov    -0x7ff020(%ebp),%al
  80023f:	3c ff                	cmp    $0xff,%al
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 58 1e 80 00       	push   $0x801e58
  80024b:	6a 38                	push   $0x38
  80024d:	68 0f 1e 80 00       	push   $0x801e0f
  800252:	e8 65 02 00 00       	call   8004bc <_panic>

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5) panic("new stack pages are not written to Page File");
  800257:	e8 7b 14 00 00       	call   8016d7 <sys_pf_calculate_allocated_pages>
  80025c:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80025f:	83 f8 05             	cmp    $0x5,%eax
  800262:	74 14                	je     800278 <_main+0x240>
  800264:	83 ec 04             	sub    $0x4,%esp
  800267:	68 78 1e 80 00       	push   $0x801e78
  80026c:	6a 3a                	push   $0x3a
  80026e:	68 0f 1e 80 00       	push   $0x801e0f
  800273:	e8 44 02 00 00       	call   8004bc <_panic>

		if( (freePages - sys_calculate_free_frames() ) != 9 ) panic("allocated memory size incorrect");
  800278:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80027b:	e8 d4 13 00 00       	call   801654 <sys_calculate_free_frames>
  800280:	29 c3                	sub    %eax,%ebx
  800282:	89 d8                	mov    %ebx,%eax
  800284:	83 f8 09             	cmp    $0x9,%eax
  800287:	74 14                	je     80029d <_main+0x265>
  800289:	83 ec 04             	sub    $0x4,%esp
  80028c:	68 a8 1e 80 00       	push   $0x801ea8
  800291:	6a 3c                	push   $0x3c
  800293:	68 0f 1e 80 00       	push   $0x801e0f
  800298:	e8 1f 02 00 00       	call   8004bc <_panic>
	}
	cprintf("STEP A passed: PLACEMENT fault handling works!\n\n\n");
  80029d:	83 ec 0c             	sub    $0xc,%esp
  8002a0:	68 c8 1e 80 00       	push   $0x801ec8
  8002a5:	e8 b4 04 00 00       	call   80075e <cprintf>
  8002aa:	83 c4 10             	add    $0x10,%esp

	for (int i=16;i>4;i--)
  8002ad:	c7 45 f0 10 00 00 00 	movl   $0x10,-0x10(%ebp)
  8002b4:	eb 1a                	jmp    8002d0 <_main+0x298>
		actual_active_list[i]=actual_active_list[i-5];
  8002b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002b9:	83 e8 05             	sub    $0x5,%eax
  8002bc:	8b 94 85 9c ff ff fe 	mov    -0x1000064(%ebp,%eax,4),%edx
  8002c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002c6:	89 94 85 9c ff ff fe 	mov    %edx,-0x1000064(%ebp,%eax,4)

		if( (freePages - sys_calculate_free_frames() ) != 9 ) panic("allocated memory size incorrect");
	}
	cprintf("STEP A passed: PLACEMENT fault handling works!\n\n\n");

	for (int i=16;i>4;i--)
  8002cd:	ff 4d f0             	decl   -0x10(%ebp)
  8002d0:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  8002d4:	7f e0                	jg     8002b6 <_main+0x27e>
		actual_active_list[i]=actual_active_list[i-5];

	actual_active_list[0]=0xee3fe000;
  8002d6:	c7 85 9c ff ff fe 00 	movl   $0xee3fe000,-0x1000064(%ebp)
  8002dd:	e0 3f ee 
	actual_active_list[1]=0xee3fdfa4;
  8002e0:	c7 85 a0 ff ff fe a4 	movl   $0xee3fdfa4,-0x1000060(%ebp)
  8002e7:	df 3f ee 
	actual_active_list[2]=0xedffe000;
  8002ea:	c7 85 a4 ff ff fe 00 	movl   $0xedffe000,-0x100005c(%ebp)
  8002f1:	e0 ff ed 
	actual_active_list[3]=0xedffdfa4;
  8002f4:	c7 85 a8 ff ff fe a4 	movl   $0xedffdfa4,-0x1000058(%ebp)
  8002fb:	df ff ed 
	actual_active_list[4]=0xedbfe000;
  8002fe:	c7 85 ac ff ff fe 00 	movl   $0xedbfe000,-0x1000054(%ebp)
  800305:	e0 bf ed 

	cprintf("STEP B: checking LRU lists entries ...\n");
  800308:	83 ec 0c             	sub    $0xc,%esp
  80030b:	68 fc 1e 80 00       	push   $0x801efc
  800310:	e8 49 04 00 00       	call   80075e <cprintf>
  800315:	83 c4 10             	add    $0x10,%esp
	{
		int check = sys_check_LRU_lists(actual_active_list, actual_second_list, 17, 0);
  800318:	6a 00                	push   $0x0
  80031a:	6a 11                	push   $0x11
  80031c:	8d 85 94 ff ff fe    	lea    -0x100006c(%ebp),%eax
  800322:	50                   	push   %eax
  800323:	8d 85 9c ff ff fe    	lea    -0x1000064(%ebp),%eax
  800329:	50                   	push   %eax
  80032a:	e8 d4 17 00 00       	call   801b03 <sys_check_LRU_lists>
  80032f:	83 c4 10             	add    $0x10,%esp
  800332:	89 45 e0             	mov    %eax,-0x20(%ebp)
			if(check == 0)
  800335:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800339:	75 14                	jne    80034f <_main+0x317>
				panic("LRU lists entries are not correct, check your logic again!!");
  80033b:	83 ec 04             	sub    $0x4,%esp
  80033e:	68 24 1f 80 00       	push   $0x801f24
  800343:	6a 4d                	push   $0x4d
  800345:	68 0f 1e 80 00       	push   $0x801e0f
  80034a:	e8 6d 01 00 00       	call   8004bc <_panic>
	}
	cprintf("STEP B passed: LRU lists entries test are correct\n\n\n");
  80034f:	83 ec 0c             	sub    $0xc,%esp
  800352:	68 60 1f 80 00       	push   $0x801f60
  800357:	e8 02 04 00 00       	call   80075e <cprintf>
  80035c:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! Test of PAGE PLACEMENT FIRST SCENARIO completed successfully!!\n\n\n");
  80035f:	83 ec 0c             	sub    $0xc,%esp
  800362:	68 98 1f 80 00       	push   $0x801f98
  800367:	e8 f2 03 00 00       	call   80075e <cprintf>
  80036c:	83 c4 10             	add    $0x10,%esp
	return;
  80036f:	90                   	nop
}
  800370:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800373:	5b                   	pop    %ebx
  800374:	5f                   	pop    %edi
  800375:	5d                   	pop    %ebp
  800376:	c3                   	ret    

00800377 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800377:	55                   	push   %ebp
  800378:	89 e5                	mov    %esp,%ebp
  80037a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80037d:	e8 07 12 00 00       	call   801589 <sys_getenvindex>
  800382:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800385:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800388:	89 d0                	mov    %edx,%eax
  80038a:	c1 e0 03             	shl    $0x3,%eax
  80038d:	01 d0                	add    %edx,%eax
  80038f:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800396:	01 c8                	add    %ecx,%eax
  800398:	01 c0                	add    %eax,%eax
  80039a:	01 d0                	add    %edx,%eax
  80039c:	01 c0                	add    %eax,%eax
  80039e:	01 d0                	add    %edx,%eax
  8003a0:	89 c2                	mov    %eax,%edx
  8003a2:	c1 e2 05             	shl    $0x5,%edx
  8003a5:	29 c2                	sub    %eax,%edx
  8003a7:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8003ae:	89 c2                	mov    %eax,%edx
  8003b0:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8003b6:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c0:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8003c6:	84 c0                	test   %al,%al
  8003c8:	74 0f                	je     8003d9 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8003ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8003cf:	05 40 3c 01 00       	add    $0x13c40,%eax
  8003d4:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003d9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003dd:	7e 0a                	jle    8003e9 <libmain+0x72>
		binaryname = argv[0];
  8003df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e2:	8b 00                	mov    (%eax),%eax
  8003e4:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8003e9:	83 ec 08             	sub    $0x8,%esp
  8003ec:	ff 75 0c             	pushl  0xc(%ebp)
  8003ef:	ff 75 08             	pushl  0x8(%ebp)
  8003f2:	e8 41 fc ff ff       	call   800038 <_main>
  8003f7:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003fa:	e8 25 13 00 00       	call   801724 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003ff:	83 ec 0c             	sub    $0xc,%esp
  800402:	68 04 20 80 00       	push   $0x802004
  800407:	e8 52 03 00 00       	call   80075e <cprintf>
  80040c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80040f:	a1 20 30 80 00       	mov    0x803020,%eax
  800414:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80041a:	a1 20 30 80 00       	mov    0x803020,%eax
  80041f:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800425:	83 ec 04             	sub    $0x4,%esp
  800428:	52                   	push   %edx
  800429:	50                   	push   %eax
  80042a:	68 2c 20 80 00       	push   $0x80202c
  80042f:	e8 2a 03 00 00       	call   80075e <cprintf>
  800434:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800437:	a1 20 30 80 00       	mov    0x803020,%eax
  80043c:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800442:	a1 20 30 80 00       	mov    0x803020,%eax
  800447:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80044d:	83 ec 04             	sub    $0x4,%esp
  800450:	52                   	push   %edx
  800451:	50                   	push   %eax
  800452:	68 54 20 80 00       	push   $0x802054
  800457:	e8 02 03 00 00       	call   80075e <cprintf>
  80045c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80045f:	a1 20 30 80 00       	mov    0x803020,%eax
  800464:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80046a:	83 ec 08             	sub    $0x8,%esp
  80046d:	50                   	push   %eax
  80046e:	68 95 20 80 00       	push   $0x802095
  800473:	e8 e6 02 00 00       	call   80075e <cprintf>
  800478:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80047b:	83 ec 0c             	sub    $0xc,%esp
  80047e:	68 04 20 80 00       	push   $0x802004
  800483:	e8 d6 02 00 00       	call   80075e <cprintf>
  800488:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80048b:	e8 ae 12 00 00       	call   80173e <sys_enable_interrupt>

	// exit gracefully
	exit();
  800490:	e8 19 00 00 00       	call   8004ae <exit>
}
  800495:	90                   	nop
  800496:	c9                   	leave  
  800497:	c3                   	ret    

00800498 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800498:	55                   	push   %ebp
  800499:	89 e5                	mov    %esp,%ebp
  80049b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80049e:	83 ec 0c             	sub    $0xc,%esp
  8004a1:	6a 00                	push   $0x0
  8004a3:	e8 ad 10 00 00       	call   801555 <sys_env_destroy>
  8004a8:	83 c4 10             	add    $0x10,%esp
}
  8004ab:	90                   	nop
  8004ac:	c9                   	leave  
  8004ad:	c3                   	ret    

008004ae <exit>:

void
exit(void)
{
  8004ae:	55                   	push   %ebp
  8004af:	89 e5                	mov    %esp,%ebp
  8004b1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8004b4:	e8 02 11 00 00       	call   8015bb <sys_env_exit>
}
  8004b9:	90                   	nop
  8004ba:	c9                   	leave  
  8004bb:	c3                   	ret    

008004bc <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004bc:	55                   	push   %ebp
  8004bd:	89 e5                	mov    %esp,%ebp
  8004bf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004c2:	8d 45 10             	lea    0x10(%ebp),%eax
  8004c5:	83 c0 04             	add    $0x4,%eax
  8004c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004cb:	a1 18 31 80 00       	mov    0x803118,%eax
  8004d0:	85 c0                	test   %eax,%eax
  8004d2:	74 16                	je     8004ea <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004d4:	a1 18 31 80 00       	mov    0x803118,%eax
  8004d9:	83 ec 08             	sub    $0x8,%esp
  8004dc:	50                   	push   %eax
  8004dd:	68 ac 20 80 00       	push   $0x8020ac
  8004e2:	e8 77 02 00 00       	call   80075e <cprintf>
  8004e7:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004ea:	a1 00 30 80 00       	mov    0x803000,%eax
  8004ef:	ff 75 0c             	pushl  0xc(%ebp)
  8004f2:	ff 75 08             	pushl  0x8(%ebp)
  8004f5:	50                   	push   %eax
  8004f6:	68 b1 20 80 00       	push   $0x8020b1
  8004fb:	e8 5e 02 00 00       	call   80075e <cprintf>
  800500:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800503:	8b 45 10             	mov    0x10(%ebp),%eax
  800506:	83 ec 08             	sub    $0x8,%esp
  800509:	ff 75 f4             	pushl  -0xc(%ebp)
  80050c:	50                   	push   %eax
  80050d:	e8 e1 01 00 00       	call   8006f3 <vcprintf>
  800512:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800515:	83 ec 08             	sub    $0x8,%esp
  800518:	6a 00                	push   $0x0
  80051a:	68 cd 20 80 00       	push   $0x8020cd
  80051f:	e8 cf 01 00 00       	call   8006f3 <vcprintf>
  800524:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800527:	e8 82 ff ff ff       	call   8004ae <exit>

	// should not return here
	while (1) ;
  80052c:	eb fe                	jmp    80052c <_panic+0x70>

0080052e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80052e:	55                   	push   %ebp
  80052f:	89 e5                	mov    %esp,%ebp
  800531:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800534:	a1 20 30 80 00       	mov    0x803020,%eax
  800539:	8b 50 74             	mov    0x74(%eax),%edx
  80053c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80053f:	39 c2                	cmp    %eax,%edx
  800541:	74 14                	je     800557 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800543:	83 ec 04             	sub    $0x4,%esp
  800546:	68 d0 20 80 00       	push   $0x8020d0
  80054b:	6a 26                	push   $0x26
  80054d:	68 1c 21 80 00       	push   $0x80211c
  800552:	e8 65 ff ff ff       	call   8004bc <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800557:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80055e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800565:	e9 b6 00 00 00       	jmp    800620 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80056a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80056d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800574:	8b 45 08             	mov    0x8(%ebp),%eax
  800577:	01 d0                	add    %edx,%eax
  800579:	8b 00                	mov    (%eax),%eax
  80057b:	85 c0                	test   %eax,%eax
  80057d:	75 08                	jne    800587 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80057f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800582:	e9 96 00 00 00       	jmp    80061d <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800587:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80058e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800595:	eb 5d                	jmp    8005f4 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800597:	a1 20 30 80 00       	mov    0x803020,%eax
  80059c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005a2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005a5:	c1 e2 04             	shl    $0x4,%edx
  8005a8:	01 d0                	add    %edx,%eax
  8005aa:	8a 40 04             	mov    0x4(%eax),%al
  8005ad:	84 c0                	test   %al,%al
  8005af:	75 40                	jne    8005f1 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005bc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005bf:	c1 e2 04             	shl    $0x4,%edx
  8005c2:	01 d0                	add    %edx,%eax
  8005c4:	8b 00                	mov    (%eax),%eax
  8005c6:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005d1:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e0:	01 c8                	add    %ecx,%eax
  8005e2:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005e4:	39 c2                	cmp    %eax,%edx
  8005e6:	75 09                	jne    8005f1 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8005e8:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005ef:	eb 12                	jmp    800603 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005f1:	ff 45 e8             	incl   -0x18(%ebp)
  8005f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f9:	8b 50 74             	mov    0x74(%eax),%edx
  8005fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ff:	39 c2                	cmp    %eax,%edx
  800601:	77 94                	ja     800597 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800603:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800607:	75 14                	jne    80061d <CheckWSWithoutLastIndex+0xef>
			panic(
  800609:	83 ec 04             	sub    $0x4,%esp
  80060c:	68 28 21 80 00       	push   $0x802128
  800611:	6a 3a                	push   $0x3a
  800613:	68 1c 21 80 00       	push   $0x80211c
  800618:	e8 9f fe ff ff       	call   8004bc <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80061d:	ff 45 f0             	incl   -0x10(%ebp)
  800620:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800623:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800626:	0f 8c 3e ff ff ff    	jl     80056a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80062c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800633:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80063a:	eb 20                	jmp    80065c <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80063c:	a1 20 30 80 00       	mov    0x803020,%eax
  800641:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800647:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80064a:	c1 e2 04             	shl    $0x4,%edx
  80064d:	01 d0                	add    %edx,%eax
  80064f:	8a 40 04             	mov    0x4(%eax),%al
  800652:	3c 01                	cmp    $0x1,%al
  800654:	75 03                	jne    800659 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800656:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800659:	ff 45 e0             	incl   -0x20(%ebp)
  80065c:	a1 20 30 80 00       	mov    0x803020,%eax
  800661:	8b 50 74             	mov    0x74(%eax),%edx
  800664:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800667:	39 c2                	cmp    %eax,%edx
  800669:	77 d1                	ja     80063c <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80066b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80066e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800671:	74 14                	je     800687 <CheckWSWithoutLastIndex+0x159>
		panic(
  800673:	83 ec 04             	sub    $0x4,%esp
  800676:	68 7c 21 80 00       	push   $0x80217c
  80067b:	6a 44                	push   $0x44
  80067d:	68 1c 21 80 00       	push   $0x80211c
  800682:	e8 35 fe ff ff       	call   8004bc <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800687:	90                   	nop
  800688:	c9                   	leave  
  800689:	c3                   	ret    

0080068a <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80068a:	55                   	push   %ebp
  80068b:	89 e5                	mov    %esp,%ebp
  80068d:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800690:	8b 45 0c             	mov    0xc(%ebp),%eax
  800693:	8b 00                	mov    (%eax),%eax
  800695:	8d 48 01             	lea    0x1(%eax),%ecx
  800698:	8b 55 0c             	mov    0xc(%ebp),%edx
  80069b:	89 0a                	mov    %ecx,(%edx)
  80069d:	8b 55 08             	mov    0x8(%ebp),%edx
  8006a0:	88 d1                	mov    %dl,%cl
  8006a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ac:	8b 00                	mov    (%eax),%eax
  8006ae:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006b3:	75 2c                	jne    8006e1 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006b5:	a0 24 30 80 00       	mov    0x803024,%al
  8006ba:	0f b6 c0             	movzbl %al,%eax
  8006bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c0:	8b 12                	mov    (%edx),%edx
  8006c2:	89 d1                	mov    %edx,%ecx
  8006c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c7:	83 c2 08             	add    $0x8,%edx
  8006ca:	83 ec 04             	sub    $0x4,%esp
  8006cd:	50                   	push   %eax
  8006ce:	51                   	push   %ecx
  8006cf:	52                   	push   %edx
  8006d0:	e8 3e 0e 00 00       	call   801513 <sys_cputs>
  8006d5:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006db:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e4:	8b 40 04             	mov    0x4(%eax),%eax
  8006e7:	8d 50 01             	lea    0x1(%eax),%edx
  8006ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ed:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006f0:	90                   	nop
  8006f1:	c9                   	leave  
  8006f2:	c3                   	ret    

008006f3 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006f3:	55                   	push   %ebp
  8006f4:	89 e5                	mov    %esp,%ebp
  8006f6:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006fc:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800703:	00 00 00 
	b.cnt = 0;
  800706:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80070d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800710:	ff 75 0c             	pushl  0xc(%ebp)
  800713:	ff 75 08             	pushl  0x8(%ebp)
  800716:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80071c:	50                   	push   %eax
  80071d:	68 8a 06 80 00       	push   $0x80068a
  800722:	e8 11 02 00 00       	call   800938 <vprintfmt>
  800727:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80072a:	a0 24 30 80 00       	mov    0x803024,%al
  80072f:	0f b6 c0             	movzbl %al,%eax
  800732:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800738:	83 ec 04             	sub    $0x4,%esp
  80073b:	50                   	push   %eax
  80073c:	52                   	push   %edx
  80073d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800743:	83 c0 08             	add    $0x8,%eax
  800746:	50                   	push   %eax
  800747:	e8 c7 0d 00 00       	call   801513 <sys_cputs>
  80074c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80074f:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800756:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80075c:	c9                   	leave  
  80075d:	c3                   	ret    

0080075e <cprintf>:

int cprintf(const char *fmt, ...) {
  80075e:	55                   	push   %ebp
  80075f:	89 e5                	mov    %esp,%ebp
  800761:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800764:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80076b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80076e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800771:	8b 45 08             	mov    0x8(%ebp),%eax
  800774:	83 ec 08             	sub    $0x8,%esp
  800777:	ff 75 f4             	pushl  -0xc(%ebp)
  80077a:	50                   	push   %eax
  80077b:	e8 73 ff ff ff       	call   8006f3 <vcprintf>
  800780:	83 c4 10             	add    $0x10,%esp
  800783:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800786:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800789:	c9                   	leave  
  80078a:	c3                   	ret    

0080078b <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80078b:	55                   	push   %ebp
  80078c:	89 e5                	mov    %esp,%ebp
  80078e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800791:	e8 8e 0f 00 00       	call   801724 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800796:	8d 45 0c             	lea    0xc(%ebp),%eax
  800799:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80079c:	8b 45 08             	mov    0x8(%ebp),%eax
  80079f:	83 ec 08             	sub    $0x8,%esp
  8007a2:	ff 75 f4             	pushl  -0xc(%ebp)
  8007a5:	50                   	push   %eax
  8007a6:	e8 48 ff ff ff       	call   8006f3 <vcprintf>
  8007ab:	83 c4 10             	add    $0x10,%esp
  8007ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007b1:	e8 88 0f 00 00       	call   80173e <sys_enable_interrupt>
	return cnt;
  8007b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007b9:	c9                   	leave  
  8007ba:	c3                   	ret    

008007bb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007bb:	55                   	push   %ebp
  8007bc:	89 e5                	mov    %esp,%ebp
  8007be:	53                   	push   %ebx
  8007bf:	83 ec 14             	sub    $0x14,%esp
  8007c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007ce:	8b 45 18             	mov    0x18(%ebp),%eax
  8007d1:	ba 00 00 00 00       	mov    $0x0,%edx
  8007d6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007d9:	77 55                	ja     800830 <printnum+0x75>
  8007db:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007de:	72 05                	jb     8007e5 <printnum+0x2a>
  8007e0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007e3:	77 4b                	ja     800830 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007e5:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007e8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007eb:	8b 45 18             	mov    0x18(%ebp),%eax
  8007ee:	ba 00 00 00 00       	mov    $0x0,%edx
  8007f3:	52                   	push   %edx
  8007f4:	50                   	push   %eax
  8007f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f8:	ff 75 f0             	pushl  -0x10(%ebp)
  8007fb:	e8 48 13 00 00       	call   801b48 <__udivdi3>
  800800:	83 c4 10             	add    $0x10,%esp
  800803:	83 ec 04             	sub    $0x4,%esp
  800806:	ff 75 20             	pushl  0x20(%ebp)
  800809:	53                   	push   %ebx
  80080a:	ff 75 18             	pushl  0x18(%ebp)
  80080d:	52                   	push   %edx
  80080e:	50                   	push   %eax
  80080f:	ff 75 0c             	pushl  0xc(%ebp)
  800812:	ff 75 08             	pushl  0x8(%ebp)
  800815:	e8 a1 ff ff ff       	call   8007bb <printnum>
  80081a:	83 c4 20             	add    $0x20,%esp
  80081d:	eb 1a                	jmp    800839 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80081f:	83 ec 08             	sub    $0x8,%esp
  800822:	ff 75 0c             	pushl  0xc(%ebp)
  800825:	ff 75 20             	pushl  0x20(%ebp)
  800828:	8b 45 08             	mov    0x8(%ebp),%eax
  80082b:	ff d0                	call   *%eax
  80082d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800830:	ff 4d 1c             	decl   0x1c(%ebp)
  800833:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800837:	7f e6                	jg     80081f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800839:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80083c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800841:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800844:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800847:	53                   	push   %ebx
  800848:	51                   	push   %ecx
  800849:	52                   	push   %edx
  80084a:	50                   	push   %eax
  80084b:	e8 08 14 00 00       	call   801c58 <__umoddi3>
  800850:	83 c4 10             	add    $0x10,%esp
  800853:	05 f4 23 80 00       	add    $0x8023f4,%eax
  800858:	8a 00                	mov    (%eax),%al
  80085a:	0f be c0             	movsbl %al,%eax
  80085d:	83 ec 08             	sub    $0x8,%esp
  800860:	ff 75 0c             	pushl  0xc(%ebp)
  800863:	50                   	push   %eax
  800864:	8b 45 08             	mov    0x8(%ebp),%eax
  800867:	ff d0                	call   *%eax
  800869:	83 c4 10             	add    $0x10,%esp
}
  80086c:	90                   	nop
  80086d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800870:	c9                   	leave  
  800871:	c3                   	ret    

00800872 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800872:	55                   	push   %ebp
  800873:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800875:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800879:	7e 1c                	jle    800897 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80087b:	8b 45 08             	mov    0x8(%ebp),%eax
  80087e:	8b 00                	mov    (%eax),%eax
  800880:	8d 50 08             	lea    0x8(%eax),%edx
  800883:	8b 45 08             	mov    0x8(%ebp),%eax
  800886:	89 10                	mov    %edx,(%eax)
  800888:	8b 45 08             	mov    0x8(%ebp),%eax
  80088b:	8b 00                	mov    (%eax),%eax
  80088d:	83 e8 08             	sub    $0x8,%eax
  800890:	8b 50 04             	mov    0x4(%eax),%edx
  800893:	8b 00                	mov    (%eax),%eax
  800895:	eb 40                	jmp    8008d7 <getuint+0x65>
	else if (lflag)
  800897:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80089b:	74 1e                	je     8008bb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80089d:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a0:	8b 00                	mov    (%eax),%eax
  8008a2:	8d 50 04             	lea    0x4(%eax),%edx
  8008a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a8:	89 10                	mov    %edx,(%eax)
  8008aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ad:	8b 00                	mov    (%eax),%eax
  8008af:	83 e8 04             	sub    $0x4,%eax
  8008b2:	8b 00                	mov    (%eax),%eax
  8008b4:	ba 00 00 00 00       	mov    $0x0,%edx
  8008b9:	eb 1c                	jmp    8008d7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008be:	8b 00                	mov    (%eax),%eax
  8008c0:	8d 50 04             	lea    0x4(%eax),%edx
  8008c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c6:	89 10                	mov    %edx,(%eax)
  8008c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cb:	8b 00                	mov    (%eax),%eax
  8008cd:	83 e8 04             	sub    $0x4,%eax
  8008d0:	8b 00                	mov    (%eax),%eax
  8008d2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008d7:	5d                   	pop    %ebp
  8008d8:	c3                   	ret    

008008d9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008d9:	55                   	push   %ebp
  8008da:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008dc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008e0:	7e 1c                	jle    8008fe <getint+0x25>
		return va_arg(*ap, long long);
  8008e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e5:	8b 00                	mov    (%eax),%eax
  8008e7:	8d 50 08             	lea    0x8(%eax),%edx
  8008ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ed:	89 10                	mov    %edx,(%eax)
  8008ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f2:	8b 00                	mov    (%eax),%eax
  8008f4:	83 e8 08             	sub    $0x8,%eax
  8008f7:	8b 50 04             	mov    0x4(%eax),%edx
  8008fa:	8b 00                	mov    (%eax),%eax
  8008fc:	eb 38                	jmp    800936 <getint+0x5d>
	else if (lflag)
  8008fe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800902:	74 1a                	je     80091e <getint+0x45>
		return va_arg(*ap, long);
  800904:	8b 45 08             	mov    0x8(%ebp),%eax
  800907:	8b 00                	mov    (%eax),%eax
  800909:	8d 50 04             	lea    0x4(%eax),%edx
  80090c:	8b 45 08             	mov    0x8(%ebp),%eax
  80090f:	89 10                	mov    %edx,(%eax)
  800911:	8b 45 08             	mov    0x8(%ebp),%eax
  800914:	8b 00                	mov    (%eax),%eax
  800916:	83 e8 04             	sub    $0x4,%eax
  800919:	8b 00                	mov    (%eax),%eax
  80091b:	99                   	cltd   
  80091c:	eb 18                	jmp    800936 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80091e:	8b 45 08             	mov    0x8(%ebp),%eax
  800921:	8b 00                	mov    (%eax),%eax
  800923:	8d 50 04             	lea    0x4(%eax),%edx
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	89 10                	mov    %edx,(%eax)
  80092b:	8b 45 08             	mov    0x8(%ebp),%eax
  80092e:	8b 00                	mov    (%eax),%eax
  800930:	83 e8 04             	sub    $0x4,%eax
  800933:	8b 00                	mov    (%eax),%eax
  800935:	99                   	cltd   
}
  800936:	5d                   	pop    %ebp
  800937:	c3                   	ret    

00800938 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800938:	55                   	push   %ebp
  800939:	89 e5                	mov    %esp,%ebp
  80093b:	56                   	push   %esi
  80093c:	53                   	push   %ebx
  80093d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800940:	eb 17                	jmp    800959 <vprintfmt+0x21>
			if (ch == '\0')
  800942:	85 db                	test   %ebx,%ebx
  800944:	0f 84 af 03 00 00    	je     800cf9 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80094a:	83 ec 08             	sub    $0x8,%esp
  80094d:	ff 75 0c             	pushl  0xc(%ebp)
  800950:	53                   	push   %ebx
  800951:	8b 45 08             	mov    0x8(%ebp),%eax
  800954:	ff d0                	call   *%eax
  800956:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800959:	8b 45 10             	mov    0x10(%ebp),%eax
  80095c:	8d 50 01             	lea    0x1(%eax),%edx
  80095f:	89 55 10             	mov    %edx,0x10(%ebp)
  800962:	8a 00                	mov    (%eax),%al
  800964:	0f b6 d8             	movzbl %al,%ebx
  800967:	83 fb 25             	cmp    $0x25,%ebx
  80096a:	75 d6                	jne    800942 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80096c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800970:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800977:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80097e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800985:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80098c:	8b 45 10             	mov    0x10(%ebp),%eax
  80098f:	8d 50 01             	lea    0x1(%eax),%edx
  800992:	89 55 10             	mov    %edx,0x10(%ebp)
  800995:	8a 00                	mov    (%eax),%al
  800997:	0f b6 d8             	movzbl %al,%ebx
  80099a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80099d:	83 f8 55             	cmp    $0x55,%eax
  8009a0:	0f 87 2b 03 00 00    	ja     800cd1 <vprintfmt+0x399>
  8009a6:	8b 04 85 18 24 80 00 	mov    0x802418(,%eax,4),%eax
  8009ad:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009af:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009b3:	eb d7                	jmp    80098c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009b5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009b9:	eb d1                	jmp    80098c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009bb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009c2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009c5:	89 d0                	mov    %edx,%eax
  8009c7:	c1 e0 02             	shl    $0x2,%eax
  8009ca:	01 d0                	add    %edx,%eax
  8009cc:	01 c0                	add    %eax,%eax
  8009ce:	01 d8                	add    %ebx,%eax
  8009d0:	83 e8 30             	sub    $0x30,%eax
  8009d3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8009d9:	8a 00                	mov    (%eax),%al
  8009db:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009de:	83 fb 2f             	cmp    $0x2f,%ebx
  8009e1:	7e 3e                	jle    800a21 <vprintfmt+0xe9>
  8009e3:	83 fb 39             	cmp    $0x39,%ebx
  8009e6:	7f 39                	jg     800a21 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009e8:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009eb:	eb d5                	jmp    8009c2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f0:	83 c0 04             	add    $0x4,%eax
  8009f3:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f9:	83 e8 04             	sub    $0x4,%eax
  8009fc:	8b 00                	mov    (%eax),%eax
  8009fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a01:	eb 1f                	jmp    800a22 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a03:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a07:	79 83                	jns    80098c <vprintfmt+0x54>
				width = 0;
  800a09:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a10:	e9 77 ff ff ff       	jmp    80098c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a15:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a1c:	e9 6b ff ff ff       	jmp    80098c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a21:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a22:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a26:	0f 89 60 ff ff ff    	jns    80098c <vprintfmt+0x54>
				width = precision, precision = -1;
  800a2c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a2f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a32:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a39:	e9 4e ff ff ff       	jmp    80098c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a3e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a41:	e9 46 ff ff ff       	jmp    80098c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a46:	8b 45 14             	mov    0x14(%ebp),%eax
  800a49:	83 c0 04             	add    $0x4,%eax
  800a4c:	89 45 14             	mov    %eax,0x14(%ebp)
  800a4f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a52:	83 e8 04             	sub    $0x4,%eax
  800a55:	8b 00                	mov    (%eax),%eax
  800a57:	83 ec 08             	sub    $0x8,%esp
  800a5a:	ff 75 0c             	pushl  0xc(%ebp)
  800a5d:	50                   	push   %eax
  800a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a61:	ff d0                	call   *%eax
  800a63:	83 c4 10             	add    $0x10,%esp
			break;
  800a66:	e9 89 02 00 00       	jmp    800cf4 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a6b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6e:	83 c0 04             	add    $0x4,%eax
  800a71:	89 45 14             	mov    %eax,0x14(%ebp)
  800a74:	8b 45 14             	mov    0x14(%ebp),%eax
  800a77:	83 e8 04             	sub    $0x4,%eax
  800a7a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a7c:	85 db                	test   %ebx,%ebx
  800a7e:	79 02                	jns    800a82 <vprintfmt+0x14a>
				err = -err;
  800a80:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a82:	83 fb 64             	cmp    $0x64,%ebx
  800a85:	7f 0b                	jg     800a92 <vprintfmt+0x15a>
  800a87:	8b 34 9d 60 22 80 00 	mov    0x802260(,%ebx,4),%esi
  800a8e:	85 f6                	test   %esi,%esi
  800a90:	75 19                	jne    800aab <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a92:	53                   	push   %ebx
  800a93:	68 05 24 80 00       	push   $0x802405
  800a98:	ff 75 0c             	pushl  0xc(%ebp)
  800a9b:	ff 75 08             	pushl  0x8(%ebp)
  800a9e:	e8 5e 02 00 00       	call   800d01 <printfmt>
  800aa3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800aa6:	e9 49 02 00 00       	jmp    800cf4 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800aab:	56                   	push   %esi
  800aac:	68 0e 24 80 00       	push   $0x80240e
  800ab1:	ff 75 0c             	pushl  0xc(%ebp)
  800ab4:	ff 75 08             	pushl  0x8(%ebp)
  800ab7:	e8 45 02 00 00       	call   800d01 <printfmt>
  800abc:	83 c4 10             	add    $0x10,%esp
			break;
  800abf:	e9 30 02 00 00       	jmp    800cf4 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ac4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac7:	83 c0 04             	add    $0x4,%eax
  800aca:	89 45 14             	mov    %eax,0x14(%ebp)
  800acd:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad0:	83 e8 04             	sub    $0x4,%eax
  800ad3:	8b 30                	mov    (%eax),%esi
  800ad5:	85 f6                	test   %esi,%esi
  800ad7:	75 05                	jne    800ade <vprintfmt+0x1a6>
				p = "(null)";
  800ad9:	be 11 24 80 00       	mov    $0x802411,%esi
			if (width > 0 && padc != '-')
  800ade:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ae2:	7e 6d                	jle    800b51 <vprintfmt+0x219>
  800ae4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ae8:	74 67                	je     800b51 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800aea:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aed:	83 ec 08             	sub    $0x8,%esp
  800af0:	50                   	push   %eax
  800af1:	56                   	push   %esi
  800af2:	e8 0c 03 00 00       	call   800e03 <strnlen>
  800af7:	83 c4 10             	add    $0x10,%esp
  800afa:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800afd:	eb 16                	jmp    800b15 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800aff:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b03:	83 ec 08             	sub    $0x8,%esp
  800b06:	ff 75 0c             	pushl  0xc(%ebp)
  800b09:	50                   	push   %eax
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	ff d0                	call   *%eax
  800b0f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b12:	ff 4d e4             	decl   -0x1c(%ebp)
  800b15:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b19:	7f e4                	jg     800aff <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b1b:	eb 34                	jmp    800b51 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b1d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b21:	74 1c                	je     800b3f <vprintfmt+0x207>
  800b23:	83 fb 1f             	cmp    $0x1f,%ebx
  800b26:	7e 05                	jle    800b2d <vprintfmt+0x1f5>
  800b28:	83 fb 7e             	cmp    $0x7e,%ebx
  800b2b:	7e 12                	jle    800b3f <vprintfmt+0x207>
					putch('?', putdat);
  800b2d:	83 ec 08             	sub    $0x8,%esp
  800b30:	ff 75 0c             	pushl  0xc(%ebp)
  800b33:	6a 3f                	push   $0x3f
  800b35:	8b 45 08             	mov    0x8(%ebp),%eax
  800b38:	ff d0                	call   *%eax
  800b3a:	83 c4 10             	add    $0x10,%esp
  800b3d:	eb 0f                	jmp    800b4e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b3f:	83 ec 08             	sub    $0x8,%esp
  800b42:	ff 75 0c             	pushl  0xc(%ebp)
  800b45:	53                   	push   %ebx
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	ff d0                	call   *%eax
  800b4b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b4e:	ff 4d e4             	decl   -0x1c(%ebp)
  800b51:	89 f0                	mov    %esi,%eax
  800b53:	8d 70 01             	lea    0x1(%eax),%esi
  800b56:	8a 00                	mov    (%eax),%al
  800b58:	0f be d8             	movsbl %al,%ebx
  800b5b:	85 db                	test   %ebx,%ebx
  800b5d:	74 24                	je     800b83 <vprintfmt+0x24b>
  800b5f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b63:	78 b8                	js     800b1d <vprintfmt+0x1e5>
  800b65:	ff 4d e0             	decl   -0x20(%ebp)
  800b68:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b6c:	79 af                	jns    800b1d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b6e:	eb 13                	jmp    800b83 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b70:	83 ec 08             	sub    $0x8,%esp
  800b73:	ff 75 0c             	pushl  0xc(%ebp)
  800b76:	6a 20                	push   $0x20
  800b78:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7b:	ff d0                	call   *%eax
  800b7d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b80:	ff 4d e4             	decl   -0x1c(%ebp)
  800b83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b87:	7f e7                	jg     800b70 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b89:	e9 66 01 00 00       	jmp    800cf4 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b8e:	83 ec 08             	sub    $0x8,%esp
  800b91:	ff 75 e8             	pushl  -0x18(%ebp)
  800b94:	8d 45 14             	lea    0x14(%ebp),%eax
  800b97:	50                   	push   %eax
  800b98:	e8 3c fd ff ff       	call   8008d9 <getint>
  800b9d:	83 c4 10             	add    $0x10,%esp
  800ba0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ba6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ba9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bac:	85 d2                	test   %edx,%edx
  800bae:	79 23                	jns    800bd3 <vprintfmt+0x29b>
				putch('-', putdat);
  800bb0:	83 ec 08             	sub    $0x8,%esp
  800bb3:	ff 75 0c             	pushl  0xc(%ebp)
  800bb6:	6a 2d                	push   $0x2d
  800bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbb:	ff d0                	call   *%eax
  800bbd:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800bc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bc3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bc6:	f7 d8                	neg    %eax
  800bc8:	83 d2 00             	adc    $0x0,%edx
  800bcb:	f7 da                	neg    %edx
  800bcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bd3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bda:	e9 bc 00 00 00       	jmp    800c9b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800bdf:	83 ec 08             	sub    $0x8,%esp
  800be2:	ff 75 e8             	pushl  -0x18(%ebp)
  800be5:	8d 45 14             	lea    0x14(%ebp),%eax
  800be8:	50                   	push   %eax
  800be9:	e8 84 fc ff ff       	call   800872 <getuint>
  800bee:	83 c4 10             	add    $0x10,%esp
  800bf1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bf7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bfe:	e9 98 00 00 00       	jmp    800c9b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c03:	83 ec 08             	sub    $0x8,%esp
  800c06:	ff 75 0c             	pushl  0xc(%ebp)
  800c09:	6a 58                	push   $0x58
  800c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0e:	ff d0                	call   *%eax
  800c10:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c13:	83 ec 08             	sub    $0x8,%esp
  800c16:	ff 75 0c             	pushl  0xc(%ebp)
  800c19:	6a 58                	push   $0x58
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	ff d0                	call   *%eax
  800c20:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c23:	83 ec 08             	sub    $0x8,%esp
  800c26:	ff 75 0c             	pushl  0xc(%ebp)
  800c29:	6a 58                	push   $0x58
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	ff d0                	call   *%eax
  800c30:	83 c4 10             	add    $0x10,%esp
			break;
  800c33:	e9 bc 00 00 00       	jmp    800cf4 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c38:	83 ec 08             	sub    $0x8,%esp
  800c3b:	ff 75 0c             	pushl  0xc(%ebp)
  800c3e:	6a 30                	push   $0x30
  800c40:	8b 45 08             	mov    0x8(%ebp),%eax
  800c43:	ff d0                	call   *%eax
  800c45:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c48:	83 ec 08             	sub    $0x8,%esp
  800c4b:	ff 75 0c             	pushl  0xc(%ebp)
  800c4e:	6a 78                	push   $0x78
  800c50:	8b 45 08             	mov    0x8(%ebp),%eax
  800c53:	ff d0                	call   *%eax
  800c55:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c58:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5b:	83 c0 04             	add    $0x4,%eax
  800c5e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c61:	8b 45 14             	mov    0x14(%ebp),%eax
  800c64:	83 e8 04             	sub    $0x4,%eax
  800c67:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c69:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c6c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c73:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c7a:	eb 1f                	jmp    800c9b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c7c:	83 ec 08             	sub    $0x8,%esp
  800c7f:	ff 75 e8             	pushl  -0x18(%ebp)
  800c82:	8d 45 14             	lea    0x14(%ebp),%eax
  800c85:	50                   	push   %eax
  800c86:	e8 e7 fb ff ff       	call   800872 <getuint>
  800c8b:	83 c4 10             	add    $0x10,%esp
  800c8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c91:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c94:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c9b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ca2:	83 ec 04             	sub    $0x4,%esp
  800ca5:	52                   	push   %edx
  800ca6:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ca9:	50                   	push   %eax
  800caa:	ff 75 f4             	pushl  -0xc(%ebp)
  800cad:	ff 75 f0             	pushl  -0x10(%ebp)
  800cb0:	ff 75 0c             	pushl  0xc(%ebp)
  800cb3:	ff 75 08             	pushl  0x8(%ebp)
  800cb6:	e8 00 fb ff ff       	call   8007bb <printnum>
  800cbb:	83 c4 20             	add    $0x20,%esp
			break;
  800cbe:	eb 34                	jmp    800cf4 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800cc0:	83 ec 08             	sub    $0x8,%esp
  800cc3:	ff 75 0c             	pushl  0xc(%ebp)
  800cc6:	53                   	push   %ebx
  800cc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cca:	ff d0                	call   *%eax
  800ccc:	83 c4 10             	add    $0x10,%esp
			break;
  800ccf:	eb 23                	jmp    800cf4 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cd1:	83 ec 08             	sub    $0x8,%esp
  800cd4:	ff 75 0c             	pushl  0xc(%ebp)
  800cd7:	6a 25                	push   $0x25
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	ff d0                	call   *%eax
  800cde:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ce1:	ff 4d 10             	decl   0x10(%ebp)
  800ce4:	eb 03                	jmp    800ce9 <vprintfmt+0x3b1>
  800ce6:	ff 4d 10             	decl   0x10(%ebp)
  800ce9:	8b 45 10             	mov    0x10(%ebp),%eax
  800cec:	48                   	dec    %eax
  800ced:	8a 00                	mov    (%eax),%al
  800cef:	3c 25                	cmp    $0x25,%al
  800cf1:	75 f3                	jne    800ce6 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cf3:	90                   	nop
		}
	}
  800cf4:	e9 47 fc ff ff       	jmp    800940 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cf9:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800cfa:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cfd:	5b                   	pop    %ebx
  800cfe:	5e                   	pop    %esi
  800cff:	5d                   	pop    %ebp
  800d00:	c3                   	ret    

00800d01 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d01:	55                   	push   %ebp
  800d02:	89 e5                	mov    %esp,%ebp
  800d04:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d07:	8d 45 10             	lea    0x10(%ebp),%eax
  800d0a:	83 c0 04             	add    $0x4,%eax
  800d0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d10:	8b 45 10             	mov    0x10(%ebp),%eax
  800d13:	ff 75 f4             	pushl  -0xc(%ebp)
  800d16:	50                   	push   %eax
  800d17:	ff 75 0c             	pushl  0xc(%ebp)
  800d1a:	ff 75 08             	pushl  0x8(%ebp)
  800d1d:	e8 16 fc ff ff       	call   800938 <vprintfmt>
  800d22:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d25:	90                   	nop
  800d26:	c9                   	leave  
  800d27:	c3                   	ret    

00800d28 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d28:	55                   	push   %ebp
  800d29:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2e:	8b 40 08             	mov    0x8(%eax),%eax
  800d31:	8d 50 01             	lea    0x1(%eax),%edx
  800d34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d37:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3d:	8b 10                	mov    (%eax),%edx
  800d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d42:	8b 40 04             	mov    0x4(%eax),%eax
  800d45:	39 c2                	cmp    %eax,%edx
  800d47:	73 12                	jae    800d5b <sprintputch+0x33>
		*b->buf++ = ch;
  800d49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4c:	8b 00                	mov    (%eax),%eax
  800d4e:	8d 48 01             	lea    0x1(%eax),%ecx
  800d51:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d54:	89 0a                	mov    %ecx,(%edx)
  800d56:	8b 55 08             	mov    0x8(%ebp),%edx
  800d59:	88 10                	mov    %dl,(%eax)
}
  800d5b:	90                   	nop
  800d5c:	5d                   	pop    %ebp
  800d5d:	c3                   	ret    

00800d5e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d5e:	55                   	push   %ebp
  800d5f:	89 e5                	mov    %esp,%ebp
  800d61:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d64:	8b 45 08             	mov    0x8(%ebp),%eax
  800d67:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	01 d0                	add    %edx,%eax
  800d75:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d7f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d83:	74 06                	je     800d8b <vsnprintf+0x2d>
  800d85:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d89:	7f 07                	jg     800d92 <vsnprintf+0x34>
		return -E_INVAL;
  800d8b:	b8 03 00 00 00       	mov    $0x3,%eax
  800d90:	eb 20                	jmp    800db2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d92:	ff 75 14             	pushl  0x14(%ebp)
  800d95:	ff 75 10             	pushl  0x10(%ebp)
  800d98:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d9b:	50                   	push   %eax
  800d9c:	68 28 0d 80 00       	push   $0x800d28
  800da1:	e8 92 fb ff ff       	call   800938 <vprintfmt>
  800da6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800da9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dac:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800daf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800db2:	c9                   	leave  
  800db3:	c3                   	ret    

00800db4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800db4:	55                   	push   %ebp
  800db5:	89 e5                	mov    %esp,%ebp
  800db7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800dba:	8d 45 10             	lea    0x10(%ebp),%eax
  800dbd:	83 c0 04             	add    $0x4,%eax
  800dc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800dc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc6:	ff 75 f4             	pushl  -0xc(%ebp)
  800dc9:	50                   	push   %eax
  800dca:	ff 75 0c             	pushl  0xc(%ebp)
  800dcd:	ff 75 08             	pushl  0x8(%ebp)
  800dd0:	e8 89 ff ff ff       	call   800d5e <vsnprintf>
  800dd5:	83 c4 10             	add    $0x10,%esp
  800dd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ddb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dde:	c9                   	leave  
  800ddf:	c3                   	ret    

00800de0 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800de0:	55                   	push   %ebp
  800de1:	89 e5                	mov    %esp,%ebp
  800de3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800de6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ded:	eb 06                	jmp    800df5 <strlen+0x15>
		n++;
  800def:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800df2:	ff 45 08             	incl   0x8(%ebp)
  800df5:	8b 45 08             	mov    0x8(%ebp),%eax
  800df8:	8a 00                	mov    (%eax),%al
  800dfa:	84 c0                	test   %al,%al
  800dfc:	75 f1                	jne    800def <strlen+0xf>
		n++;
	return n;
  800dfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e01:	c9                   	leave  
  800e02:	c3                   	ret    

00800e03 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e03:	55                   	push   %ebp
  800e04:	89 e5                	mov    %esp,%ebp
  800e06:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e09:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e10:	eb 09                	jmp    800e1b <strnlen+0x18>
		n++;
  800e12:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e15:	ff 45 08             	incl   0x8(%ebp)
  800e18:	ff 4d 0c             	decl   0xc(%ebp)
  800e1b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e1f:	74 09                	je     800e2a <strnlen+0x27>
  800e21:	8b 45 08             	mov    0x8(%ebp),%eax
  800e24:	8a 00                	mov    (%eax),%al
  800e26:	84 c0                	test   %al,%al
  800e28:	75 e8                	jne    800e12 <strnlen+0xf>
		n++;
	return n;
  800e2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e2d:	c9                   	leave  
  800e2e:	c3                   	ret    

00800e2f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e2f:	55                   	push   %ebp
  800e30:	89 e5                	mov    %esp,%ebp
  800e32:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e3b:	90                   	nop
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3f:	8d 50 01             	lea    0x1(%eax),%edx
  800e42:	89 55 08             	mov    %edx,0x8(%ebp)
  800e45:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e48:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e4b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e4e:	8a 12                	mov    (%edx),%dl
  800e50:	88 10                	mov    %dl,(%eax)
  800e52:	8a 00                	mov    (%eax),%al
  800e54:	84 c0                	test   %al,%al
  800e56:	75 e4                	jne    800e3c <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e58:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e5b:	c9                   	leave  
  800e5c:	c3                   	ret    

00800e5d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e5d:	55                   	push   %ebp
  800e5e:	89 e5                	mov    %esp,%ebp
  800e60:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e63:	8b 45 08             	mov    0x8(%ebp),%eax
  800e66:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e69:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e70:	eb 1f                	jmp    800e91 <strncpy+0x34>
		*dst++ = *src;
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	8d 50 01             	lea    0x1(%eax),%edx
  800e78:	89 55 08             	mov    %edx,0x8(%ebp)
  800e7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e7e:	8a 12                	mov    (%edx),%dl
  800e80:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e85:	8a 00                	mov    (%eax),%al
  800e87:	84 c0                	test   %al,%al
  800e89:	74 03                	je     800e8e <strncpy+0x31>
			src++;
  800e8b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e8e:	ff 45 fc             	incl   -0x4(%ebp)
  800e91:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e94:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e97:	72 d9                	jb     800e72 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e99:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e9c:	c9                   	leave  
  800e9d:	c3                   	ret    

00800e9e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e9e:	55                   	push   %ebp
  800e9f:	89 e5                	mov    %esp,%ebp
  800ea1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800eaa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eae:	74 30                	je     800ee0 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800eb0:	eb 16                	jmp    800ec8 <strlcpy+0x2a>
			*dst++ = *src++;
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	8d 50 01             	lea    0x1(%eax),%edx
  800eb8:	89 55 08             	mov    %edx,0x8(%ebp)
  800ebb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ebe:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ec1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ec4:	8a 12                	mov    (%edx),%dl
  800ec6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ec8:	ff 4d 10             	decl   0x10(%ebp)
  800ecb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ecf:	74 09                	je     800eda <strlcpy+0x3c>
  800ed1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	84 c0                	test   %al,%al
  800ed8:	75 d8                	jne    800eb2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ee0:	8b 55 08             	mov    0x8(%ebp),%edx
  800ee3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee6:	29 c2                	sub    %eax,%edx
  800ee8:	89 d0                	mov    %edx,%eax
}
  800eea:	c9                   	leave  
  800eeb:	c3                   	ret    

00800eec <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800eec:	55                   	push   %ebp
  800eed:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800eef:	eb 06                	jmp    800ef7 <strcmp+0xb>
		p++, q++;
  800ef1:	ff 45 08             	incl   0x8(%ebp)
  800ef4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	8a 00                	mov    (%eax),%al
  800efc:	84 c0                	test   %al,%al
  800efe:	74 0e                	je     800f0e <strcmp+0x22>
  800f00:	8b 45 08             	mov    0x8(%ebp),%eax
  800f03:	8a 10                	mov    (%eax),%dl
  800f05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f08:	8a 00                	mov    (%eax),%al
  800f0a:	38 c2                	cmp    %al,%dl
  800f0c:	74 e3                	je     800ef1 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	0f b6 d0             	movzbl %al,%edx
  800f16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f19:	8a 00                	mov    (%eax),%al
  800f1b:	0f b6 c0             	movzbl %al,%eax
  800f1e:	29 c2                	sub    %eax,%edx
  800f20:	89 d0                	mov    %edx,%eax
}
  800f22:	5d                   	pop    %ebp
  800f23:	c3                   	ret    

00800f24 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f24:	55                   	push   %ebp
  800f25:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f27:	eb 09                	jmp    800f32 <strncmp+0xe>
		n--, p++, q++;
  800f29:	ff 4d 10             	decl   0x10(%ebp)
  800f2c:	ff 45 08             	incl   0x8(%ebp)
  800f2f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f32:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f36:	74 17                	je     800f4f <strncmp+0x2b>
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	8a 00                	mov    (%eax),%al
  800f3d:	84 c0                	test   %al,%al
  800f3f:	74 0e                	je     800f4f <strncmp+0x2b>
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	8a 10                	mov    (%eax),%dl
  800f46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f49:	8a 00                	mov    (%eax),%al
  800f4b:	38 c2                	cmp    %al,%dl
  800f4d:	74 da                	je     800f29 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f53:	75 07                	jne    800f5c <strncmp+0x38>
		return 0;
  800f55:	b8 00 00 00 00       	mov    $0x0,%eax
  800f5a:	eb 14                	jmp    800f70 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	8a 00                	mov    (%eax),%al
  800f61:	0f b6 d0             	movzbl %al,%edx
  800f64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f67:	8a 00                	mov    (%eax),%al
  800f69:	0f b6 c0             	movzbl %al,%eax
  800f6c:	29 c2                	sub    %eax,%edx
  800f6e:	89 d0                	mov    %edx,%eax
}
  800f70:	5d                   	pop    %ebp
  800f71:	c3                   	ret    

00800f72 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f72:	55                   	push   %ebp
  800f73:	89 e5                	mov    %esp,%ebp
  800f75:	83 ec 04             	sub    $0x4,%esp
  800f78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f7e:	eb 12                	jmp    800f92 <strchr+0x20>
		if (*s == c)
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f88:	75 05                	jne    800f8f <strchr+0x1d>
			return (char *) s;
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	eb 11                	jmp    800fa0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f8f:	ff 45 08             	incl   0x8(%ebp)
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	8a 00                	mov    (%eax),%al
  800f97:	84 c0                	test   %al,%al
  800f99:	75 e5                	jne    800f80 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f9b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fa0:	c9                   	leave  
  800fa1:	c3                   	ret    

00800fa2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fa2:	55                   	push   %ebp
  800fa3:	89 e5                	mov    %esp,%ebp
  800fa5:	83 ec 04             	sub    $0x4,%esp
  800fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fab:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fae:	eb 0d                	jmp    800fbd <strfind+0x1b>
		if (*s == c)
  800fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb3:	8a 00                	mov    (%eax),%al
  800fb5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fb8:	74 0e                	je     800fc8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fba:	ff 45 08             	incl   0x8(%ebp)
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	8a 00                	mov    (%eax),%al
  800fc2:	84 c0                	test   %al,%al
  800fc4:	75 ea                	jne    800fb0 <strfind+0xe>
  800fc6:	eb 01                	jmp    800fc9 <strfind+0x27>
		if (*s == c)
			break;
  800fc8:	90                   	nop
	return (char *) s;
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fcc:	c9                   	leave  
  800fcd:	c3                   	ret    

00800fce <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800fce:	55                   	push   %ebp
  800fcf:	89 e5                	mov    %esp,%ebp
  800fd1:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fda:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fe0:	eb 0e                	jmp    800ff0 <memset+0x22>
		*p++ = c;
  800fe2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe5:	8d 50 01             	lea    0x1(%eax),%edx
  800fe8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800feb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fee:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ff0:	ff 4d f8             	decl   -0x8(%ebp)
  800ff3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ff7:	79 e9                	jns    800fe2 <memset+0x14>
		*p++ = c;

	return v;
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ffc:	c9                   	leave  
  800ffd:	c3                   	ret    

00800ffe <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ffe:	55                   	push   %ebp
  800fff:	89 e5                	mov    %esp,%ebp
  801001:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801004:	8b 45 0c             	mov    0xc(%ebp),%eax
  801007:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80100a:	8b 45 08             	mov    0x8(%ebp),%eax
  80100d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801010:	eb 16                	jmp    801028 <memcpy+0x2a>
		*d++ = *s++;
  801012:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801015:	8d 50 01             	lea    0x1(%eax),%edx
  801018:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80101b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80101e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801021:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801024:	8a 12                	mov    (%edx),%dl
  801026:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801028:	8b 45 10             	mov    0x10(%ebp),%eax
  80102b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80102e:	89 55 10             	mov    %edx,0x10(%ebp)
  801031:	85 c0                	test   %eax,%eax
  801033:	75 dd                	jne    801012 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801038:	c9                   	leave  
  801039:	c3                   	ret    

0080103a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80103a:	55                   	push   %ebp
  80103b:	89 e5                	mov    %esp,%ebp
  80103d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801040:	8b 45 0c             	mov    0xc(%ebp),%eax
  801043:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80104c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80104f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801052:	73 50                	jae    8010a4 <memmove+0x6a>
  801054:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801057:	8b 45 10             	mov    0x10(%ebp),%eax
  80105a:	01 d0                	add    %edx,%eax
  80105c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80105f:	76 43                	jbe    8010a4 <memmove+0x6a>
		s += n;
  801061:	8b 45 10             	mov    0x10(%ebp),%eax
  801064:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801067:	8b 45 10             	mov    0x10(%ebp),%eax
  80106a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80106d:	eb 10                	jmp    80107f <memmove+0x45>
			*--d = *--s;
  80106f:	ff 4d f8             	decl   -0x8(%ebp)
  801072:	ff 4d fc             	decl   -0x4(%ebp)
  801075:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801078:	8a 10                	mov    (%eax),%dl
  80107a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80107d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80107f:	8b 45 10             	mov    0x10(%ebp),%eax
  801082:	8d 50 ff             	lea    -0x1(%eax),%edx
  801085:	89 55 10             	mov    %edx,0x10(%ebp)
  801088:	85 c0                	test   %eax,%eax
  80108a:	75 e3                	jne    80106f <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80108c:	eb 23                	jmp    8010b1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80108e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801091:	8d 50 01             	lea    0x1(%eax),%edx
  801094:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801097:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80109a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80109d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010a0:	8a 12                	mov    (%edx),%dl
  8010a2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010aa:	89 55 10             	mov    %edx,0x10(%ebp)
  8010ad:	85 c0                	test   %eax,%eax
  8010af:	75 dd                	jne    80108e <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010b4:	c9                   	leave  
  8010b5:	c3                   	ret    

008010b6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010b6:	55                   	push   %ebp
  8010b7:	89 e5                	mov    %esp,%ebp
  8010b9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010c8:	eb 2a                	jmp    8010f4 <memcmp+0x3e>
		if (*s1 != *s2)
  8010ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010cd:	8a 10                	mov    (%eax),%dl
  8010cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d2:	8a 00                	mov    (%eax),%al
  8010d4:	38 c2                	cmp    %al,%dl
  8010d6:	74 16                	je     8010ee <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010db:	8a 00                	mov    (%eax),%al
  8010dd:	0f b6 d0             	movzbl %al,%edx
  8010e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e3:	8a 00                	mov    (%eax),%al
  8010e5:	0f b6 c0             	movzbl %al,%eax
  8010e8:	29 c2                	sub    %eax,%edx
  8010ea:	89 d0                	mov    %edx,%eax
  8010ec:	eb 18                	jmp    801106 <memcmp+0x50>
		s1++, s2++;
  8010ee:	ff 45 fc             	incl   -0x4(%ebp)
  8010f1:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010fa:	89 55 10             	mov    %edx,0x10(%ebp)
  8010fd:	85 c0                	test   %eax,%eax
  8010ff:	75 c9                	jne    8010ca <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801101:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801106:	c9                   	leave  
  801107:	c3                   	ret    

00801108 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801108:	55                   	push   %ebp
  801109:	89 e5                	mov    %esp,%ebp
  80110b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80110e:	8b 55 08             	mov    0x8(%ebp),%edx
  801111:	8b 45 10             	mov    0x10(%ebp),%eax
  801114:	01 d0                	add    %edx,%eax
  801116:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801119:	eb 15                	jmp    801130 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80111b:	8b 45 08             	mov    0x8(%ebp),%eax
  80111e:	8a 00                	mov    (%eax),%al
  801120:	0f b6 d0             	movzbl %al,%edx
  801123:	8b 45 0c             	mov    0xc(%ebp),%eax
  801126:	0f b6 c0             	movzbl %al,%eax
  801129:	39 c2                	cmp    %eax,%edx
  80112b:	74 0d                	je     80113a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80112d:	ff 45 08             	incl   0x8(%ebp)
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801136:	72 e3                	jb     80111b <memfind+0x13>
  801138:	eb 01                	jmp    80113b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80113a:	90                   	nop
	return (void *) s;
  80113b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80113e:	c9                   	leave  
  80113f:	c3                   	ret    

00801140 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801140:	55                   	push   %ebp
  801141:	89 e5                	mov    %esp,%ebp
  801143:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801146:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80114d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801154:	eb 03                	jmp    801159 <strtol+0x19>
		s++;
  801156:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801159:	8b 45 08             	mov    0x8(%ebp),%eax
  80115c:	8a 00                	mov    (%eax),%al
  80115e:	3c 20                	cmp    $0x20,%al
  801160:	74 f4                	je     801156 <strtol+0x16>
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	3c 09                	cmp    $0x9,%al
  801169:	74 eb                	je     801156 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	3c 2b                	cmp    $0x2b,%al
  801172:	75 05                	jne    801179 <strtol+0x39>
		s++;
  801174:	ff 45 08             	incl   0x8(%ebp)
  801177:	eb 13                	jmp    80118c <strtol+0x4c>
	else if (*s == '-')
  801179:	8b 45 08             	mov    0x8(%ebp),%eax
  80117c:	8a 00                	mov    (%eax),%al
  80117e:	3c 2d                	cmp    $0x2d,%al
  801180:	75 0a                	jne    80118c <strtol+0x4c>
		s++, neg = 1;
  801182:	ff 45 08             	incl   0x8(%ebp)
  801185:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80118c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801190:	74 06                	je     801198 <strtol+0x58>
  801192:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801196:	75 20                	jne    8011b8 <strtol+0x78>
  801198:	8b 45 08             	mov    0x8(%ebp),%eax
  80119b:	8a 00                	mov    (%eax),%al
  80119d:	3c 30                	cmp    $0x30,%al
  80119f:	75 17                	jne    8011b8 <strtol+0x78>
  8011a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a4:	40                   	inc    %eax
  8011a5:	8a 00                	mov    (%eax),%al
  8011a7:	3c 78                	cmp    $0x78,%al
  8011a9:	75 0d                	jne    8011b8 <strtol+0x78>
		s += 2, base = 16;
  8011ab:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011af:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011b6:	eb 28                	jmp    8011e0 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011b8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011bc:	75 15                	jne    8011d3 <strtol+0x93>
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	8a 00                	mov    (%eax),%al
  8011c3:	3c 30                	cmp    $0x30,%al
  8011c5:	75 0c                	jne    8011d3 <strtol+0x93>
		s++, base = 8;
  8011c7:	ff 45 08             	incl   0x8(%ebp)
  8011ca:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011d1:	eb 0d                	jmp    8011e0 <strtol+0xa0>
	else if (base == 0)
  8011d3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d7:	75 07                	jne    8011e0 <strtol+0xa0>
		base = 10;
  8011d9:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e3:	8a 00                	mov    (%eax),%al
  8011e5:	3c 2f                	cmp    $0x2f,%al
  8011e7:	7e 19                	jle    801202 <strtol+0xc2>
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	8a 00                	mov    (%eax),%al
  8011ee:	3c 39                	cmp    $0x39,%al
  8011f0:	7f 10                	jg     801202 <strtol+0xc2>
			dig = *s - '0';
  8011f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f5:	8a 00                	mov    (%eax),%al
  8011f7:	0f be c0             	movsbl %al,%eax
  8011fa:	83 e8 30             	sub    $0x30,%eax
  8011fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801200:	eb 42                	jmp    801244 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 00                	mov    (%eax),%al
  801207:	3c 60                	cmp    $0x60,%al
  801209:	7e 19                	jle    801224 <strtol+0xe4>
  80120b:	8b 45 08             	mov    0x8(%ebp),%eax
  80120e:	8a 00                	mov    (%eax),%al
  801210:	3c 7a                	cmp    $0x7a,%al
  801212:	7f 10                	jg     801224 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801214:	8b 45 08             	mov    0x8(%ebp),%eax
  801217:	8a 00                	mov    (%eax),%al
  801219:	0f be c0             	movsbl %al,%eax
  80121c:	83 e8 57             	sub    $0x57,%eax
  80121f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801222:	eb 20                	jmp    801244 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801224:	8b 45 08             	mov    0x8(%ebp),%eax
  801227:	8a 00                	mov    (%eax),%al
  801229:	3c 40                	cmp    $0x40,%al
  80122b:	7e 39                	jle    801266 <strtol+0x126>
  80122d:	8b 45 08             	mov    0x8(%ebp),%eax
  801230:	8a 00                	mov    (%eax),%al
  801232:	3c 5a                	cmp    $0x5a,%al
  801234:	7f 30                	jg     801266 <strtol+0x126>
			dig = *s - 'A' + 10;
  801236:	8b 45 08             	mov    0x8(%ebp),%eax
  801239:	8a 00                	mov    (%eax),%al
  80123b:	0f be c0             	movsbl %al,%eax
  80123e:	83 e8 37             	sub    $0x37,%eax
  801241:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801244:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801247:	3b 45 10             	cmp    0x10(%ebp),%eax
  80124a:	7d 19                	jge    801265 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80124c:	ff 45 08             	incl   0x8(%ebp)
  80124f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801252:	0f af 45 10          	imul   0x10(%ebp),%eax
  801256:	89 c2                	mov    %eax,%edx
  801258:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80125b:	01 d0                	add    %edx,%eax
  80125d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801260:	e9 7b ff ff ff       	jmp    8011e0 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801265:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801266:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80126a:	74 08                	je     801274 <strtol+0x134>
		*endptr = (char *) s;
  80126c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126f:	8b 55 08             	mov    0x8(%ebp),%edx
  801272:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801274:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801278:	74 07                	je     801281 <strtol+0x141>
  80127a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80127d:	f7 d8                	neg    %eax
  80127f:	eb 03                	jmp    801284 <strtol+0x144>
  801281:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801284:	c9                   	leave  
  801285:	c3                   	ret    

00801286 <ltostr>:

void
ltostr(long value, char *str)
{
  801286:	55                   	push   %ebp
  801287:	89 e5                	mov    %esp,%ebp
  801289:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80128c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801293:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80129a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80129e:	79 13                	jns    8012b3 <ltostr+0x2d>
	{
		neg = 1;
  8012a0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012aa:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012ad:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012b0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012bb:	99                   	cltd   
  8012bc:	f7 f9                	idiv   %ecx
  8012be:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c4:	8d 50 01             	lea    0x1(%eax),%edx
  8012c7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012ca:	89 c2                	mov    %eax,%edx
  8012cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cf:	01 d0                	add    %edx,%eax
  8012d1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012d4:	83 c2 30             	add    $0x30,%edx
  8012d7:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012dc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012e1:	f7 e9                	imul   %ecx
  8012e3:	c1 fa 02             	sar    $0x2,%edx
  8012e6:	89 c8                	mov    %ecx,%eax
  8012e8:	c1 f8 1f             	sar    $0x1f,%eax
  8012eb:	29 c2                	sub    %eax,%edx
  8012ed:	89 d0                	mov    %edx,%eax
  8012ef:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012f2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012f5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012fa:	f7 e9                	imul   %ecx
  8012fc:	c1 fa 02             	sar    $0x2,%edx
  8012ff:	89 c8                	mov    %ecx,%eax
  801301:	c1 f8 1f             	sar    $0x1f,%eax
  801304:	29 c2                	sub    %eax,%edx
  801306:	89 d0                	mov    %edx,%eax
  801308:	c1 e0 02             	shl    $0x2,%eax
  80130b:	01 d0                	add    %edx,%eax
  80130d:	01 c0                	add    %eax,%eax
  80130f:	29 c1                	sub    %eax,%ecx
  801311:	89 ca                	mov    %ecx,%edx
  801313:	85 d2                	test   %edx,%edx
  801315:	75 9c                	jne    8012b3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801317:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80131e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801321:	48                   	dec    %eax
  801322:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801325:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801329:	74 3d                	je     801368 <ltostr+0xe2>
		start = 1 ;
  80132b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801332:	eb 34                	jmp    801368 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801334:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801337:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133a:	01 d0                	add    %edx,%eax
  80133c:	8a 00                	mov    (%eax),%al
  80133e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801341:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801344:	8b 45 0c             	mov    0xc(%ebp),%eax
  801347:	01 c2                	add    %eax,%edx
  801349:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80134c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134f:	01 c8                	add    %ecx,%eax
  801351:	8a 00                	mov    (%eax),%al
  801353:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801355:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801358:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135b:	01 c2                	add    %eax,%edx
  80135d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801360:	88 02                	mov    %al,(%edx)
		start++ ;
  801362:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801365:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801368:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80136b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80136e:	7c c4                	jl     801334 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801370:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801373:	8b 45 0c             	mov    0xc(%ebp),%eax
  801376:	01 d0                	add    %edx,%eax
  801378:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80137b:	90                   	nop
  80137c:	c9                   	leave  
  80137d:	c3                   	ret    

0080137e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80137e:	55                   	push   %ebp
  80137f:	89 e5                	mov    %esp,%ebp
  801381:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801384:	ff 75 08             	pushl  0x8(%ebp)
  801387:	e8 54 fa ff ff       	call   800de0 <strlen>
  80138c:	83 c4 04             	add    $0x4,%esp
  80138f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801392:	ff 75 0c             	pushl  0xc(%ebp)
  801395:	e8 46 fa ff ff       	call   800de0 <strlen>
  80139a:	83 c4 04             	add    $0x4,%esp
  80139d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013ae:	eb 17                	jmp    8013c7 <strcconcat+0x49>
		final[s] = str1[s] ;
  8013b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b6:	01 c2                	add    %eax,%edx
  8013b8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	01 c8                	add    %ecx,%eax
  8013c0:	8a 00                	mov    (%eax),%al
  8013c2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013c4:	ff 45 fc             	incl   -0x4(%ebp)
  8013c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ca:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013cd:	7c e1                	jl     8013b0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013d6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013dd:	eb 1f                	jmp    8013fe <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013e2:	8d 50 01             	lea    0x1(%eax),%edx
  8013e5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013e8:	89 c2                	mov    %eax,%edx
  8013ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ed:	01 c2                	add    %eax,%edx
  8013ef:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f5:	01 c8                	add    %ecx,%eax
  8013f7:	8a 00                	mov    (%eax),%al
  8013f9:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013fb:	ff 45 f8             	incl   -0x8(%ebp)
  8013fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801401:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801404:	7c d9                	jl     8013df <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801406:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801409:	8b 45 10             	mov    0x10(%ebp),%eax
  80140c:	01 d0                	add    %edx,%eax
  80140e:	c6 00 00             	movb   $0x0,(%eax)
}
  801411:	90                   	nop
  801412:	c9                   	leave  
  801413:	c3                   	ret    

00801414 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801417:	8b 45 14             	mov    0x14(%ebp),%eax
  80141a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801420:	8b 45 14             	mov    0x14(%ebp),%eax
  801423:	8b 00                	mov    (%eax),%eax
  801425:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80142c:	8b 45 10             	mov    0x10(%ebp),%eax
  80142f:	01 d0                	add    %edx,%eax
  801431:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801437:	eb 0c                	jmp    801445 <strsplit+0x31>
			*string++ = 0;
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	8d 50 01             	lea    0x1(%eax),%edx
  80143f:	89 55 08             	mov    %edx,0x8(%ebp)
  801442:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801445:	8b 45 08             	mov    0x8(%ebp),%eax
  801448:	8a 00                	mov    (%eax),%al
  80144a:	84 c0                	test   %al,%al
  80144c:	74 18                	je     801466 <strsplit+0x52>
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	8a 00                	mov    (%eax),%al
  801453:	0f be c0             	movsbl %al,%eax
  801456:	50                   	push   %eax
  801457:	ff 75 0c             	pushl  0xc(%ebp)
  80145a:	e8 13 fb ff ff       	call   800f72 <strchr>
  80145f:	83 c4 08             	add    $0x8,%esp
  801462:	85 c0                	test   %eax,%eax
  801464:	75 d3                	jne    801439 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801466:	8b 45 08             	mov    0x8(%ebp),%eax
  801469:	8a 00                	mov    (%eax),%al
  80146b:	84 c0                	test   %al,%al
  80146d:	74 5a                	je     8014c9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80146f:	8b 45 14             	mov    0x14(%ebp),%eax
  801472:	8b 00                	mov    (%eax),%eax
  801474:	83 f8 0f             	cmp    $0xf,%eax
  801477:	75 07                	jne    801480 <strsplit+0x6c>
		{
			return 0;
  801479:	b8 00 00 00 00       	mov    $0x0,%eax
  80147e:	eb 66                	jmp    8014e6 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801480:	8b 45 14             	mov    0x14(%ebp),%eax
  801483:	8b 00                	mov    (%eax),%eax
  801485:	8d 48 01             	lea    0x1(%eax),%ecx
  801488:	8b 55 14             	mov    0x14(%ebp),%edx
  80148b:	89 0a                	mov    %ecx,(%edx)
  80148d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801494:	8b 45 10             	mov    0x10(%ebp),%eax
  801497:	01 c2                	add    %eax,%edx
  801499:	8b 45 08             	mov    0x8(%ebp),%eax
  80149c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80149e:	eb 03                	jmp    8014a3 <strsplit+0x8f>
			string++;
  8014a0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	8a 00                	mov    (%eax),%al
  8014a8:	84 c0                	test   %al,%al
  8014aa:	74 8b                	je     801437 <strsplit+0x23>
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8014af:	8a 00                	mov    (%eax),%al
  8014b1:	0f be c0             	movsbl %al,%eax
  8014b4:	50                   	push   %eax
  8014b5:	ff 75 0c             	pushl  0xc(%ebp)
  8014b8:	e8 b5 fa ff ff       	call   800f72 <strchr>
  8014bd:	83 c4 08             	add    $0x8,%esp
  8014c0:	85 c0                	test   %eax,%eax
  8014c2:	74 dc                	je     8014a0 <strsplit+0x8c>
			string++;
	}
  8014c4:	e9 6e ff ff ff       	jmp    801437 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014c9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8014cd:	8b 00                	mov    (%eax),%eax
  8014cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d9:	01 d0                	add    %edx,%eax
  8014db:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014e1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014e6:	c9                   	leave  
  8014e7:	c3                   	ret    

008014e8 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014e8:	55                   	push   %ebp
  8014e9:	89 e5                	mov    %esp,%ebp
  8014eb:	57                   	push   %edi
  8014ec:	56                   	push   %esi
  8014ed:	53                   	push   %ebx
  8014ee:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014fa:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014fd:	8b 7d 18             	mov    0x18(%ebp),%edi
  801500:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801503:	cd 30                	int    $0x30
  801505:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801508:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80150b:	83 c4 10             	add    $0x10,%esp
  80150e:	5b                   	pop    %ebx
  80150f:	5e                   	pop    %esi
  801510:	5f                   	pop    %edi
  801511:	5d                   	pop    %ebp
  801512:	c3                   	ret    

00801513 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
  801516:	83 ec 04             	sub    $0x4,%esp
  801519:	8b 45 10             	mov    0x10(%ebp),%eax
  80151c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80151f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801523:	8b 45 08             	mov    0x8(%ebp),%eax
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	52                   	push   %edx
  80152b:	ff 75 0c             	pushl  0xc(%ebp)
  80152e:	50                   	push   %eax
  80152f:	6a 00                	push   $0x0
  801531:	e8 b2 ff ff ff       	call   8014e8 <syscall>
  801536:	83 c4 18             	add    $0x18,%esp
}
  801539:	90                   	nop
  80153a:	c9                   	leave  
  80153b:	c3                   	ret    

0080153c <sys_cgetc>:

int
sys_cgetc(void)
{
  80153c:	55                   	push   %ebp
  80153d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 01                	push   $0x1
  80154b:	e8 98 ff ff ff       	call   8014e8 <syscall>
  801550:	83 c4 18             	add    $0x18,%esp
}
  801553:	c9                   	leave  
  801554:	c3                   	ret    

00801555 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801555:	55                   	push   %ebp
  801556:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801558:	8b 45 08             	mov    0x8(%ebp),%eax
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	50                   	push   %eax
  801564:	6a 05                	push   $0x5
  801566:	e8 7d ff ff ff       	call   8014e8 <syscall>
  80156b:	83 c4 18             	add    $0x18,%esp
}
  80156e:	c9                   	leave  
  80156f:	c3                   	ret    

00801570 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801570:	55                   	push   %ebp
  801571:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801573:	6a 00                	push   $0x0
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 02                	push   $0x2
  80157f:	e8 64 ff ff ff       	call   8014e8 <syscall>
  801584:	83 c4 18             	add    $0x18,%esp
}
  801587:	c9                   	leave  
  801588:	c3                   	ret    

00801589 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 03                	push   $0x3
  801598:	e8 4b ff ff ff       	call   8014e8 <syscall>
  80159d:	83 c4 18             	add    $0x18,%esp
}
  8015a0:	c9                   	leave  
  8015a1:	c3                   	ret    

008015a2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015a2:	55                   	push   %ebp
  8015a3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 04                	push   $0x4
  8015b1:	e8 32 ff ff ff       	call   8014e8 <syscall>
  8015b6:	83 c4 18             	add    $0x18,%esp
}
  8015b9:	c9                   	leave  
  8015ba:	c3                   	ret    

008015bb <sys_env_exit>:


void sys_env_exit(void)
{
  8015bb:	55                   	push   %ebp
  8015bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 06                	push   $0x6
  8015ca:	e8 19 ff ff ff       	call   8014e8 <syscall>
  8015cf:	83 c4 18             	add    $0x18,%esp
}
  8015d2:	90                   	nop
  8015d3:	c9                   	leave  
  8015d4:	c3                   	ret    

008015d5 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015d5:	55                   	push   %ebp
  8015d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	52                   	push   %edx
  8015e5:	50                   	push   %eax
  8015e6:	6a 07                	push   $0x7
  8015e8:	e8 fb fe ff ff       	call   8014e8 <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
  8015f5:	56                   	push   %esi
  8015f6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015f7:	8b 75 18             	mov    0x18(%ebp),%esi
  8015fa:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015fd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801600:	8b 55 0c             	mov    0xc(%ebp),%edx
  801603:	8b 45 08             	mov    0x8(%ebp),%eax
  801606:	56                   	push   %esi
  801607:	53                   	push   %ebx
  801608:	51                   	push   %ecx
  801609:	52                   	push   %edx
  80160a:	50                   	push   %eax
  80160b:	6a 08                	push   $0x8
  80160d:	e8 d6 fe ff ff       	call   8014e8 <syscall>
  801612:	83 c4 18             	add    $0x18,%esp
}
  801615:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801618:	5b                   	pop    %ebx
  801619:	5e                   	pop    %esi
  80161a:	5d                   	pop    %ebp
  80161b:	c3                   	ret    

0080161c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80161c:	55                   	push   %ebp
  80161d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80161f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801622:	8b 45 08             	mov    0x8(%ebp),%eax
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	52                   	push   %edx
  80162c:	50                   	push   %eax
  80162d:	6a 09                	push   $0x9
  80162f:	e8 b4 fe ff ff       	call   8014e8 <syscall>
  801634:	83 c4 18             	add    $0x18,%esp
}
  801637:	c9                   	leave  
  801638:	c3                   	ret    

00801639 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801639:	55                   	push   %ebp
  80163a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	ff 75 0c             	pushl  0xc(%ebp)
  801645:	ff 75 08             	pushl  0x8(%ebp)
  801648:	6a 0a                	push   $0xa
  80164a:	e8 99 fe ff ff       	call   8014e8 <syscall>
  80164f:	83 c4 18             	add    $0x18,%esp
}
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 0b                	push   $0xb
  801663:	e8 80 fe ff ff       	call   8014e8 <syscall>
  801668:	83 c4 18             	add    $0x18,%esp
}
  80166b:	c9                   	leave  
  80166c:	c3                   	ret    

0080166d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80166d:	55                   	push   %ebp
  80166e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 0c                	push   $0xc
  80167c:	e8 67 fe ff ff       	call   8014e8 <syscall>
  801681:	83 c4 18             	add    $0x18,%esp
}
  801684:	c9                   	leave  
  801685:	c3                   	ret    

00801686 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801686:	55                   	push   %ebp
  801687:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 0d                	push   $0xd
  801695:	e8 4e fe ff ff       	call   8014e8 <syscall>
  80169a:	83 c4 18             	add    $0x18,%esp
}
  80169d:	c9                   	leave  
  80169e:	c3                   	ret    

0080169f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80169f:	55                   	push   %ebp
  8016a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	ff 75 0c             	pushl  0xc(%ebp)
  8016ab:	ff 75 08             	pushl  0x8(%ebp)
  8016ae:	6a 11                	push   $0x11
  8016b0:	e8 33 fe ff ff       	call   8014e8 <syscall>
  8016b5:	83 c4 18             	add    $0x18,%esp
	return;
  8016b8:	90                   	nop
}
  8016b9:	c9                   	leave  
  8016ba:	c3                   	ret    

008016bb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8016bb:	55                   	push   %ebp
  8016bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	ff 75 0c             	pushl  0xc(%ebp)
  8016c7:	ff 75 08             	pushl  0x8(%ebp)
  8016ca:	6a 12                	push   $0x12
  8016cc:	e8 17 fe ff ff       	call   8014e8 <syscall>
  8016d1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d4:	90                   	nop
}
  8016d5:	c9                   	leave  
  8016d6:	c3                   	ret    

008016d7 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016d7:	55                   	push   %ebp
  8016d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 0e                	push   $0xe
  8016e6:	e8 fd fd ff ff       	call   8014e8 <syscall>
  8016eb:	83 c4 18             	add    $0x18,%esp
}
  8016ee:	c9                   	leave  
  8016ef:	c3                   	ret    

008016f0 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	ff 75 08             	pushl  0x8(%ebp)
  8016fe:	6a 0f                	push   $0xf
  801700:	e8 e3 fd ff ff       	call   8014e8 <syscall>
  801705:	83 c4 18             	add    $0x18,%esp
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 10                	push   $0x10
  801719:	e8 ca fd ff ff       	call   8014e8 <syscall>
  80171e:	83 c4 18             	add    $0x18,%esp
}
  801721:	90                   	nop
  801722:	c9                   	leave  
  801723:	c3                   	ret    

00801724 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801724:	55                   	push   %ebp
  801725:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 14                	push   $0x14
  801733:	e8 b0 fd ff ff       	call   8014e8 <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
}
  80173b:	90                   	nop
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 15                	push   $0x15
  80174d:	e8 96 fd ff ff       	call   8014e8 <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
}
  801755:	90                   	nop
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <sys_cputc>:


void
sys_cputc(const char c)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
  80175b:	83 ec 04             	sub    $0x4,%esp
  80175e:	8b 45 08             	mov    0x8(%ebp),%eax
  801761:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801764:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	50                   	push   %eax
  801771:	6a 16                	push   $0x16
  801773:	e8 70 fd ff ff       	call   8014e8 <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
}
  80177b:	90                   	nop
  80177c:	c9                   	leave  
  80177d:	c3                   	ret    

0080177e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 17                	push   $0x17
  80178d:	e8 56 fd ff ff       	call   8014e8 <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
}
  801795:	90                   	nop
  801796:	c9                   	leave  
  801797:	c3                   	ret    

00801798 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801798:	55                   	push   %ebp
  801799:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80179b:	8b 45 08             	mov    0x8(%ebp),%eax
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	ff 75 0c             	pushl  0xc(%ebp)
  8017a7:	50                   	push   %eax
  8017a8:	6a 18                	push   $0x18
  8017aa:	e8 39 fd ff ff       	call   8014e8 <syscall>
  8017af:	83 c4 18             	add    $0x18,%esp
}
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	52                   	push   %edx
  8017c4:	50                   	push   %eax
  8017c5:	6a 1b                	push   $0x1b
  8017c7:	e8 1c fd ff ff       	call   8014e8 <syscall>
  8017cc:	83 c4 18             	add    $0x18,%esp
}
  8017cf:	c9                   	leave  
  8017d0:	c3                   	ret    

008017d1 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017d1:	55                   	push   %ebp
  8017d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	52                   	push   %edx
  8017e1:	50                   	push   %eax
  8017e2:	6a 19                	push   $0x19
  8017e4:	e8 ff fc ff ff       	call   8014e8 <syscall>
  8017e9:	83 c4 18             	add    $0x18,%esp
}
  8017ec:	90                   	nop
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	52                   	push   %edx
  8017ff:	50                   	push   %eax
  801800:	6a 1a                	push   $0x1a
  801802:	e8 e1 fc ff ff       	call   8014e8 <syscall>
  801807:	83 c4 18             	add    $0x18,%esp
}
  80180a:	90                   	nop
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
  801810:	83 ec 04             	sub    $0x4,%esp
  801813:	8b 45 10             	mov    0x10(%ebp),%eax
  801816:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801819:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80181c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801820:	8b 45 08             	mov    0x8(%ebp),%eax
  801823:	6a 00                	push   $0x0
  801825:	51                   	push   %ecx
  801826:	52                   	push   %edx
  801827:	ff 75 0c             	pushl  0xc(%ebp)
  80182a:	50                   	push   %eax
  80182b:	6a 1c                	push   $0x1c
  80182d:	e8 b6 fc ff ff       	call   8014e8 <syscall>
  801832:	83 c4 18             	add    $0x18,%esp
}
  801835:	c9                   	leave  
  801836:	c3                   	ret    

00801837 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801837:	55                   	push   %ebp
  801838:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80183a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183d:	8b 45 08             	mov    0x8(%ebp),%eax
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	52                   	push   %edx
  801847:	50                   	push   %eax
  801848:	6a 1d                	push   $0x1d
  80184a:	e8 99 fc ff ff       	call   8014e8 <syscall>
  80184f:	83 c4 18             	add    $0x18,%esp
}
  801852:	c9                   	leave  
  801853:	c3                   	ret    

00801854 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801854:	55                   	push   %ebp
  801855:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801857:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80185a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	51                   	push   %ecx
  801865:	52                   	push   %edx
  801866:	50                   	push   %eax
  801867:	6a 1e                	push   $0x1e
  801869:	e8 7a fc ff ff       	call   8014e8 <syscall>
  80186e:	83 c4 18             	add    $0x18,%esp
}
  801871:	c9                   	leave  
  801872:	c3                   	ret    

00801873 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801876:	8b 55 0c             	mov    0xc(%ebp),%edx
  801879:	8b 45 08             	mov    0x8(%ebp),%eax
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	52                   	push   %edx
  801883:	50                   	push   %eax
  801884:	6a 1f                	push   $0x1f
  801886:	e8 5d fc ff ff       	call   8014e8 <syscall>
  80188b:	83 c4 18             	add    $0x18,%esp
}
  80188e:	c9                   	leave  
  80188f:	c3                   	ret    

00801890 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801890:	55                   	push   %ebp
  801891:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 20                	push   $0x20
  80189f:	e8 44 fc ff ff       	call   8014e8 <syscall>
  8018a4:	83 c4 18             	add    $0x18,%esp
}
  8018a7:	c9                   	leave  
  8018a8:	c3                   	ret    

008018a9 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8018a9:	55                   	push   %ebp
  8018aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8018af:	6a 00                	push   $0x0
  8018b1:	ff 75 14             	pushl  0x14(%ebp)
  8018b4:	ff 75 10             	pushl  0x10(%ebp)
  8018b7:	ff 75 0c             	pushl  0xc(%ebp)
  8018ba:	50                   	push   %eax
  8018bb:	6a 21                	push   $0x21
  8018bd:	e8 26 fc ff ff       	call   8014e8 <syscall>
  8018c2:	83 c4 18             	add    $0x18,%esp
}
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	50                   	push   %eax
  8018d6:	6a 22                	push   $0x22
  8018d8:	e8 0b fc ff ff       	call   8014e8 <syscall>
  8018dd:	83 c4 18             	add    $0x18,%esp
}
  8018e0:	90                   	nop
  8018e1:	c9                   	leave  
  8018e2:	c3                   	ret    

008018e3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8018e3:	55                   	push   %ebp
  8018e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8018e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	50                   	push   %eax
  8018f2:	6a 23                	push   $0x23
  8018f4:	e8 ef fb ff ff       	call   8014e8 <syscall>
  8018f9:	83 c4 18             	add    $0x18,%esp
}
  8018fc:	90                   	nop
  8018fd:	c9                   	leave  
  8018fe:	c3                   	ret    

008018ff <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8018ff:	55                   	push   %ebp
  801900:	89 e5                	mov    %esp,%ebp
  801902:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801905:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801908:	8d 50 04             	lea    0x4(%eax),%edx
  80190b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	52                   	push   %edx
  801915:	50                   	push   %eax
  801916:	6a 24                	push   $0x24
  801918:	e8 cb fb ff ff       	call   8014e8 <syscall>
  80191d:	83 c4 18             	add    $0x18,%esp
	return result;
  801920:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801923:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801926:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801929:	89 01                	mov    %eax,(%ecx)
  80192b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80192e:	8b 45 08             	mov    0x8(%ebp),%eax
  801931:	c9                   	leave  
  801932:	c2 04 00             	ret    $0x4

00801935 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	ff 75 10             	pushl  0x10(%ebp)
  80193f:	ff 75 0c             	pushl  0xc(%ebp)
  801942:	ff 75 08             	pushl  0x8(%ebp)
  801945:	6a 13                	push   $0x13
  801947:	e8 9c fb ff ff       	call   8014e8 <syscall>
  80194c:	83 c4 18             	add    $0x18,%esp
	return ;
  80194f:	90                   	nop
}
  801950:	c9                   	leave  
  801951:	c3                   	ret    

00801952 <sys_rcr2>:
uint32 sys_rcr2()
{
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 25                	push   $0x25
  801961:	e8 82 fb ff ff       	call   8014e8 <syscall>
  801966:	83 c4 18             	add    $0x18,%esp
}
  801969:	c9                   	leave  
  80196a:	c3                   	ret    

0080196b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80196b:	55                   	push   %ebp
  80196c:	89 e5                	mov    %esp,%ebp
  80196e:	83 ec 04             	sub    $0x4,%esp
  801971:	8b 45 08             	mov    0x8(%ebp),%eax
  801974:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801977:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	50                   	push   %eax
  801984:	6a 26                	push   $0x26
  801986:	e8 5d fb ff ff       	call   8014e8 <syscall>
  80198b:	83 c4 18             	add    $0x18,%esp
	return ;
  80198e:	90                   	nop
}
  80198f:	c9                   	leave  
  801990:	c3                   	ret    

00801991 <rsttst>:
void rsttst()
{
  801991:	55                   	push   %ebp
  801992:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 28                	push   $0x28
  8019a0:	e8 43 fb ff ff       	call   8014e8 <syscall>
  8019a5:	83 c4 18             	add    $0x18,%esp
	return ;
  8019a8:	90                   	nop
}
  8019a9:	c9                   	leave  
  8019aa:	c3                   	ret    

008019ab <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019ab:	55                   	push   %ebp
  8019ac:	89 e5                	mov    %esp,%ebp
  8019ae:	83 ec 04             	sub    $0x4,%esp
  8019b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8019b4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019b7:	8b 55 18             	mov    0x18(%ebp),%edx
  8019ba:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019be:	52                   	push   %edx
  8019bf:	50                   	push   %eax
  8019c0:	ff 75 10             	pushl  0x10(%ebp)
  8019c3:	ff 75 0c             	pushl  0xc(%ebp)
  8019c6:	ff 75 08             	pushl  0x8(%ebp)
  8019c9:	6a 27                	push   $0x27
  8019cb:	e8 18 fb ff ff       	call   8014e8 <syscall>
  8019d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8019d3:	90                   	nop
}
  8019d4:	c9                   	leave  
  8019d5:	c3                   	ret    

008019d6 <chktst>:
void chktst(uint32 n)
{
  8019d6:	55                   	push   %ebp
  8019d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	ff 75 08             	pushl  0x8(%ebp)
  8019e4:	6a 29                	push   $0x29
  8019e6:	e8 fd fa ff ff       	call   8014e8 <syscall>
  8019eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ee:	90                   	nop
}
  8019ef:	c9                   	leave  
  8019f0:	c3                   	ret    

008019f1 <inctst>:

void inctst()
{
  8019f1:	55                   	push   %ebp
  8019f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 2a                	push   $0x2a
  801a00:	e8 e3 fa ff ff       	call   8014e8 <syscall>
  801a05:	83 c4 18             	add    $0x18,%esp
	return ;
  801a08:	90                   	nop
}
  801a09:	c9                   	leave  
  801a0a:	c3                   	ret    

00801a0b <gettst>:
uint32 gettst()
{
  801a0b:	55                   	push   %ebp
  801a0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 2b                	push   $0x2b
  801a1a:	e8 c9 fa ff ff       	call   8014e8 <syscall>
  801a1f:	83 c4 18             	add    $0x18,%esp
}
  801a22:	c9                   	leave  
  801a23:	c3                   	ret    

00801a24 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a24:	55                   	push   %ebp
  801a25:	89 e5                	mov    %esp,%ebp
  801a27:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 2c                	push   $0x2c
  801a36:	e8 ad fa ff ff       	call   8014e8 <syscall>
  801a3b:	83 c4 18             	add    $0x18,%esp
  801a3e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a41:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a45:	75 07                	jne    801a4e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a47:	b8 01 00 00 00       	mov    $0x1,%eax
  801a4c:	eb 05                	jmp    801a53 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a4e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a53:	c9                   	leave  
  801a54:	c3                   	ret    

00801a55 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a55:	55                   	push   %ebp
  801a56:	89 e5                	mov    %esp,%ebp
  801a58:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 2c                	push   $0x2c
  801a67:	e8 7c fa ff ff       	call   8014e8 <syscall>
  801a6c:	83 c4 18             	add    $0x18,%esp
  801a6f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a72:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a76:	75 07                	jne    801a7f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a78:	b8 01 00 00 00       	mov    $0x1,%eax
  801a7d:	eb 05                	jmp    801a84 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a7f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a84:	c9                   	leave  
  801a85:	c3                   	ret    

00801a86 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a86:	55                   	push   %ebp
  801a87:	89 e5                	mov    %esp,%ebp
  801a89:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 2c                	push   $0x2c
  801a98:	e8 4b fa ff ff       	call   8014e8 <syscall>
  801a9d:	83 c4 18             	add    $0x18,%esp
  801aa0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801aa3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801aa7:	75 07                	jne    801ab0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801aa9:	b8 01 00 00 00       	mov    $0x1,%eax
  801aae:	eb 05                	jmp    801ab5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ab0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ab5:	c9                   	leave  
  801ab6:	c3                   	ret    

00801ab7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ab7:	55                   	push   %ebp
  801ab8:	89 e5                	mov    %esp,%ebp
  801aba:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 2c                	push   $0x2c
  801ac9:	e8 1a fa ff ff       	call   8014e8 <syscall>
  801ace:	83 c4 18             	add    $0x18,%esp
  801ad1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ad4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ad8:	75 07                	jne    801ae1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ada:	b8 01 00 00 00       	mov    $0x1,%eax
  801adf:	eb 05                	jmp    801ae6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ae1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ae6:	c9                   	leave  
  801ae7:	c3                   	ret    

00801ae8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ae8:	55                   	push   %ebp
  801ae9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	ff 75 08             	pushl  0x8(%ebp)
  801af6:	6a 2d                	push   $0x2d
  801af8:	e8 eb f9 ff ff       	call   8014e8 <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
	return ;
  801b00:	90                   	nop
}
  801b01:	c9                   	leave  
  801b02:	c3                   	ret    

00801b03 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b03:	55                   	push   %ebp
  801b04:	89 e5                	mov    %esp,%ebp
  801b06:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b07:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b0a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b10:	8b 45 08             	mov    0x8(%ebp),%eax
  801b13:	6a 00                	push   $0x0
  801b15:	53                   	push   %ebx
  801b16:	51                   	push   %ecx
  801b17:	52                   	push   %edx
  801b18:	50                   	push   %eax
  801b19:	6a 2e                	push   $0x2e
  801b1b:	e8 c8 f9 ff ff       	call   8014e8 <syscall>
  801b20:	83 c4 18             	add    $0x18,%esp
}
  801b23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b26:	c9                   	leave  
  801b27:	c3                   	ret    

00801b28 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	52                   	push   %edx
  801b38:	50                   	push   %eax
  801b39:	6a 2f                	push   $0x2f
  801b3b:	e8 a8 f9 ff ff       	call   8014e8 <syscall>
  801b40:	83 c4 18             	add    $0x18,%esp
}
  801b43:	c9                   	leave  
  801b44:	c3                   	ret    
  801b45:	66 90                	xchg   %ax,%ax
  801b47:	90                   	nop

00801b48 <__udivdi3>:
  801b48:	55                   	push   %ebp
  801b49:	57                   	push   %edi
  801b4a:	56                   	push   %esi
  801b4b:	53                   	push   %ebx
  801b4c:	83 ec 1c             	sub    $0x1c,%esp
  801b4f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b53:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b57:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b5b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b5f:	89 ca                	mov    %ecx,%edx
  801b61:	89 f8                	mov    %edi,%eax
  801b63:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b67:	85 f6                	test   %esi,%esi
  801b69:	75 2d                	jne    801b98 <__udivdi3+0x50>
  801b6b:	39 cf                	cmp    %ecx,%edi
  801b6d:	77 65                	ja     801bd4 <__udivdi3+0x8c>
  801b6f:	89 fd                	mov    %edi,%ebp
  801b71:	85 ff                	test   %edi,%edi
  801b73:	75 0b                	jne    801b80 <__udivdi3+0x38>
  801b75:	b8 01 00 00 00       	mov    $0x1,%eax
  801b7a:	31 d2                	xor    %edx,%edx
  801b7c:	f7 f7                	div    %edi
  801b7e:	89 c5                	mov    %eax,%ebp
  801b80:	31 d2                	xor    %edx,%edx
  801b82:	89 c8                	mov    %ecx,%eax
  801b84:	f7 f5                	div    %ebp
  801b86:	89 c1                	mov    %eax,%ecx
  801b88:	89 d8                	mov    %ebx,%eax
  801b8a:	f7 f5                	div    %ebp
  801b8c:	89 cf                	mov    %ecx,%edi
  801b8e:	89 fa                	mov    %edi,%edx
  801b90:	83 c4 1c             	add    $0x1c,%esp
  801b93:	5b                   	pop    %ebx
  801b94:	5e                   	pop    %esi
  801b95:	5f                   	pop    %edi
  801b96:	5d                   	pop    %ebp
  801b97:	c3                   	ret    
  801b98:	39 ce                	cmp    %ecx,%esi
  801b9a:	77 28                	ja     801bc4 <__udivdi3+0x7c>
  801b9c:	0f bd fe             	bsr    %esi,%edi
  801b9f:	83 f7 1f             	xor    $0x1f,%edi
  801ba2:	75 40                	jne    801be4 <__udivdi3+0x9c>
  801ba4:	39 ce                	cmp    %ecx,%esi
  801ba6:	72 0a                	jb     801bb2 <__udivdi3+0x6a>
  801ba8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801bac:	0f 87 9e 00 00 00    	ja     801c50 <__udivdi3+0x108>
  801bb2:	b8 01 00 00 00       	mov    $0x1,%eax
  801bb7:	89 fa                	mov    %edi,%edx
  801bb9:	83 c4 1c             	add    $0x1c,%esp
  801bbc:	5b                   	pop    %ebx
  801bbd:	5e                   	pop    %esi
  801bbe:	5f                   	pop    %edi
  801bbf:	5d                   	pop    %ebp
  801bc0:	c3                   	ret    
  801bc1:	8d 76 00             	lea    0x0(%esi),%esi
  801bc4:	31 ff                	xor    %edi,%edi
  801bc6:	31 c0                	xor    %eax,%eax
  801bc8:	89 fa                	mov    %edi,%edx
  801bca:	83 c4 1c             	add    $0x1c,%esp
  801bcd:	5b                   	pop    %ebx
  801bce:	5e                   	pop    %esi
  801bcf:	5f                   	pop    %edi
  801bd0:	5d                   	pop    %ebp
  801bd1:	c3                   	ret    
  801bd2:	66 90                	xchg   %ax,%ax
  801bd4:	89 d8                	mov    %ebx,%eax
  801bd6:	f7 f7                	div    %edi
  801bd8:	31 ff                	xor    %edi,%edi
  801bda:	89 fa                	mov    %edi,%edx
  801bdc:	83 c4 1c             	add    $0x1c,%esp
  801bdf:	5b                   	pop    %ebx
  801be0:	5e                   	pop    %esi
  801be1:	5f                   	pop    %edi
  801be2:	5d                   	pop    %ebp
  801be3:	c3                   	ret    
  801be4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801be9:	89 eb                	mov    %ebp,%ebx
  801beb:	29 fb                	sub    %edi,%ebx
  801bed:	89 f9                	mov    %edi,%ecx
  801bef:	d3 e6                	shl    %cl,%esi
  801bf1:	89 c5                	mov    %eax,%ebp
  801bf3:	88 d9                	mov    %bl,%cl
  801bf5:	d3 ed                	shr    %cl,%ebp
  801bf7:	89 e9                	mov    %ebp,%ecx
  801bf9:	09 f1                	or     %esi,%ecx
  801bfb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bff:	89 f9                	mov    %edi,%ecx
  801c01:	d3 e0                	shl    %cl,%eax
  801c03:	89 c5                	mov    %eax,%ebp
  801c05:	89 d6                	mov    %edx,%esi
  801c07:	88 d9                	mov    %bl,%cl
  801c09:	d3 ee                	shr    %cl,%esi
  801c0b:	89 f9                	mov    %edi,%ecx
  801c0d:	d3 e2                	shl    %cl,%edx
  801c0f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c13:	88 d9                	mov    %bl,%cl
  801c15:	d3 e8                	shr    %cl,%eax
  801c17:	09 c2                	or     %eax,%edx
  801c19:	89 d0                	mov    %edx,%eax
  801c1b:	89 f2                	mov    %esi,%edx
  801c1d:	f7 74 24 0c          	divl   0xc(%esp)
  801c21:	89 d6                	mov    %edx,%esi
  801c23:	89 c3                	mov    %eax,%ebx
  801c25:	f7 e5                	mul    %ebp
  801c27:	39 d6                	cmp    %edx,%esi
  801c29:	72 19                	jb     801c44 <__udivdi3+0xfc>
  801c2b:	74 0b                	je     801c38 <__udivdi3+0xf0>
  801c2d:	89 d8                	mov    %ebx,%eax
  801c2f:	31 ff                	xor    %edi,%edi
  801c31:	e9 58 ff ff ff       	jmp    801b8e <__udivdi3+0x46>
  801c36:	66 90                	xchg   %ax,%ax
  801c38:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c3c:	89 f9                	mov    %edi,%ecx
  801c3e:	d3 e2                	shl    %cl,%edx
  801c40:	39 c2                	cmp    %eax,%edx
  801c42:	73 e9                	jae    801c2d <__udivdi3+0xe5>
  801c44:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c47:	31 ff                	xor    %edi,%edi
  801c49:	e9 40 ff ff ff       	jmp    801b8e <__udivdi3+0x46>
  801c4e:	66 90                	xchg   %ax,%ax
  801c50:	31 c0                	xor    %eax,%eax
  801c52:	e9 37 ff ff ff       	jmp    801b8e <__udivdi3+0x46>
  801c57:	90                   	nop

00801c58 <__umoddi3>:
  801c58:	55                   	push   %ebp
  801c59:	57                   	push   %edi
  801c5a:	56                   	push   %esi
  801c5b:	53                   	push   %ebx
  801c5c:	83 ec 1c             	sub    $0x1c,%esp
  801c5f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c63:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c67:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c6b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c6f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c73:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c77:	89 f3                	mov    %esi,%ebx
  801c79:	89 fa                	mov    %edi,%edx
  801c7b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c7f:	89 34 24             	mov    %esi,(%esp)
  801c82:	85 c0                	test   %eax,%eax
  801c84:	75 1a                	jne    801ca0 <__umoddi3+0x48>
  801c86:	39 f7                	cmp    %esi,%edi
  801c88:	0f 86 a2 00 00 00    	jbe    801d30 <__umoddi3+0xd8>
  801c8e:	89 c8                	mov    %ecx,%eax
  801c90:	89 f2                	mov    %esi,%edx
  801c92:	f7 f7                	div    %edi
  801c94:	89 d0                	mov    %edx,%eax
  801c96:	31 d2                	xor    %edx,%edx
  801c98:	83 c4 1c             	add    $0x1c,%esp
  801c9b:	5b                   	pop    %ebx
  801c9c:	5e                   	pop    %esi
  801c9d:	5f                   	pop    %edi
  801c9e:	5d                   	pop    %ebp
  801c9f:	c3                   	ret    
  801ca0:	39 f0                	cmp    %esi,%eax
  801ca2:	0f 87 ac 00 00 00    	ja     801d54 <__umoddi3+0xfc>
  801ca8:	0f bd e8             	bsr    %eax,%ebp
  801cab:	83 f5 1f             	xor    $0x1f,%ebp
  801cae:	0f 84 ac 00 00 00    	je     801d60 <__umoddi3+0x108>
  801cb4:	bf 20 00 00 00       	mov    $0x20,%edi
  801cb9:	29 ef                	sub    %ebp,%edi
  801cbb:	89 fe                	mov    %edi,%esi
  801cbd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801cc1:	89 e9                	mov    %ebp,%ecx
  801cc3:	d3 e0                	shl    %cl,%eax
  801cc5:	89 d7                	mov    %edx,%edi
  801cc7:	89 f1                	mov    %esi,%ecx
  801cc9:	d3 ef                	shr    %cl,%edi
  801ccb:	09 c7                	or     %eax,%edi
  801ccd:	89 e9                	mov    %ebp,%ecx
  801ccf:	d3 e2                	shl    %cl,%edx
  801cd1:	89 14 24             	mov    %edx,(%esp)
  801cd4:	89 d8                	mov    %ebx,%eax
  801cd6:	d3 e0                	shl    %cl,%eax
  801cd8:	89 c2                	mov    %eax,%edx
  801cda:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cde:	d3 e0                	shl    %cl,%eax
  801ce0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ce4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ce8:	89 f1                	mov    %esi,%ecx
  801cea:	d3 e8                	shr    %cl,%eax
  801cec:	09 d0                	or     %edx,%eax
  801cee:	d3 eb                	shr    %cl,%ebx
  801cf0:	89 da                	mov    %ebx,%edx
  801cf2:	f7 f7                	div    %edi
  801cf4:	89 d3                	mov    %edx,%ebx
  801cf6:	f7 24 24             	mull   (%esp)
  801cf9:	89 c6                	mov    %eax,%esi
  801cfb:	89 d1                	mov    %edx,%ecx
  801cfd:	39 d3                	cmp    %edx,%ebx
  801cff:	0f 82 87 00 00 00    	jb     801d8c <__umoddi3+0x134>
  801d05:	0f 84 91 00 00 00    	je     801d9c <__umoddi3+0x144>
  801d0b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d0f:	29 f2                	sub    %esi,%edx
  801d11:	19 cb                	sbb    %ecx,%ebx
  801d13:	89 d8                	mov    %ebx,%eax
  801d15:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d19:	d3 e0                	shl    %cl,%eax
  801d1b:	89 e9                	mov    %ebp,%ecx
  801d1d:	d3 ea                	shr    %cl,%edx
  801d1f:	09 d0                	or     %edx,%eax
  801d21:	89 e9                	mov    %ebp,%ecx
  801d23:	d3 eb                	shr    %cl,%ebx
  801d25:	89 da                	mov    %ebx,%edx
  801d27:	83 c4 1c             	add    $0x1c,%esp
  801d2a:	5b                   	pop    %ebx
  801d2b:	5e                   	pop    %esi
  801d2c:	5f                   	pop    %edi
  801d2d:	5d                   	pop    %ebp
  801d2e:	c3                   	ret    
  801d2f:	90                   	nop
  801d30:	89 fd                	mov    %edi,%ebp
  801d32:	85 ff                	test   %edi,%edi
  801d34:	75 0b                	jne    801d41 <__umoddi3+0xe9>
  801d36:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3b:	31 d2                	xor    %edx,%edx
  801d3d:	f7 f7                	div    %edi
  801d3f:	89 c5                	mov    %eax,%ebp
  801d41:	89 f0                	mov    %esi,%eax
  801d43:	31 d2                	xor    %edx,%edx
  801d45:	f7 f5                	div    %ebp
  801d47:	89 c8                	mov    %ecx,%eax
  801d49:	f7 f5                	div    %ebp
  801d4b:	89 d0                	mov    %edx,%eax
  801d4d:	e9 44 ff ff ff       	jmp    801c96 <__umoddi3+0x3e>
  801d52:	66 90                	xchg   %ax,%ax
  801d54:	89 c8                	mov    %ecx,%eax
  801d56:	89 f2                	mov    %esi,%edx
  801d58:	83 c4 1c             	add    $0x1c,%esp
  801d5b:	5b                   	pop    %ebx
  801d5c:	5e                   	pop    %esi
  801d5d:	5f                   	pop    %edi
  801d5e:	5d                   	pop    %ebp
  801d5f:	c3                   	ret    
  801d60:	3b 04 24             	cmp    (%esp),%eax
  801d63:	72 06                	jb     801d6b <__umoddi3+0x113>
  801d65:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d69:	77 0f                	ja     801d7a <__umoddi3+0x122>
  801d6b:	89 f2                	mov    %esi,%edx
  801d6d:	29 f9                	sub    %edi,%ecx
  801d6f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d73:	89 14 24             	mov    %edx,(%esp)
  801d76:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d7a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d7e:	8b 14 24             	mov    (%esp),%edx
  801d81:	83 c4 1c             	add    $0x1c,%esp
  801d84:	5b                   	pop    %ebx
  801d85:	5e                   	pop    %esi
  801d86:	5f                   	pop    %edi
  801d87:	5d                   	pop    %ebp
  801d88:	c3                   	ret    
  801d89:	8d 76 00             	lea    0x0(%esi),%esi
  801d8c:	2b 04 24             	sub    (%esp),%eax
  801d8f:	19 fa                	sbb    %edi,%edx
  801d91:	89 d1                	mov    %edx,%ecx
  801d93:	89 c6                	mov    %eax,%esi
  801d95:	e9 71 ff ff ff       	jmp    801d0b <__umoddi3+0xb3>
  801d9a:	66 90                	xchg   %ax,%ax
  801d9c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801da0:	72 ea                	jb     801d8c <__umoddi3+0x134>
  801da2:	89 d9                	mov    %ebx,%ecx
  801da4:	e9 62 ff ff ff       	jmp    801d0b <__umoddi3+0xb3>

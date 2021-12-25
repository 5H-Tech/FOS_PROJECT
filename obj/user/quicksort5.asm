
obj/user/quicksort5:     file format elf32-i386


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
  800031:	e8 96 06 00 00       	call   8006cc <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);
uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec c4 63 00 00    	sub    $0x63c4,%esp
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[25500] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int envID = sys_getenvid();
  800049:	e8 af 1e 00 00       	call   801efd <sys_getenvid>
  80004e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_createSemaphore("1", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 40 27 80 00       	push   $0x802740
  80005b:	e8 c5 20 00 00       	call   802125 <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 79 1f 00 00       	call   801fe1 <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 8b 1f 00 00       	call   801ffa <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();
		sys_waitSemaphore(envID, "1");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 40 27 80 00       	push   $0x802740
  80007f:	ff 75 e8             	pushl  -0x18(%ebp)
  800082:	e8 d7 20 00 00       	call   80215e <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 44 27 80 00       	push   $0x802744
  800099:	e8 97 10 00 00       	call   801135 <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 e7 15 00 00       	call   80169b <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 7a 19 00 00       	call   801a43 <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 64 27 80 00       	push   $0x802764
  8000d7:	e8 d7 09 00 00       	call   800ab3 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 87 27 80 00       	push   $0x802787
  8000e7:	e8 c7 09 00 00       	call   800ab3 <cprintf>
  8000ec:	83 c4 10             	add    $0x10,%esp
		int ii, j = 0 ;
  8000ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (ii = 0 ; ii < 100000; ii++)
  8000f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000fd:	eb 09                	jmp    800108 <_main+0xd0>
		{
			j+= ii;
  8000ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800102:	01 45 ec             	add    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
		cprintf("a) Ascending\n") ;
		int ii, j = 0 ;
		for (ii = 0 ; ii < 100000; ii++)
  800105:	ff 45 f0             	incl   -0x10(%ebp)
  800108:	81 7d f0 9f 86 01 00 	cmpl   $0x1869f,-0x10(%ebp)
  80010f:	7e ee                	jle    8000ff <_main+0xc7>
		{
			j+= ii;
		}
		cprintf("b) Descending\n") ;
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	68 95 27 80 00       	push   $0x802795
  800119:	e8 95 09 00 00       	call   800ab3 <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 a4 27 80 00       	push   $0x8027a4
  800129:	e8 85 09 00 00       	call   800ab3 <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	68 b4 27 80 00       	push   $0x8027b4
  800139:	e8 75 09 00 00       	call   800ab3 <cprintf>
  80013e:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800141:	e8 2e 05 00 00       	call   800674 <getchar>
  800146:	88 45 db             	mov    %al,-0x25(%ebp)
			cputchar(Chose);
  800149:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80014d:	83 ec 0c             	sub    $0xc,%esp
  800150:	50                   	push   %eax
  800151:	e8 d6 04 00 00       	call   80062c <cputchar>
  800156:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800159:	83 ec 0c             	sub    $0xc,%esp
  80015c:	6a 0a                	push   $0xa
  80015e:	e8 c9 04 00 00       	call   80062c <cputchar>
  800163:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800166:	80 7d db 61          	cmpb   $0x61,-0x25(%ebp)
  80016a:	74 0c                	je     800178 <_main+0x140>
  80016c:	80 7d db 62          	cmpb   $0x62,-0x25(%ebp)
  800170:	74 06                	je     800178 <_main+0x140>
  800172:	80 7d db 63          	cmpb   $0x63,-0x25(%ebp)
  800176:	75 b9                	jne    800131 <_main+0xf9>
		sys_signalSemaphore(envID, "1");
  800178:	83 ec 08             	sub    $0x8,%esp
  80017b:	68 40 27 80 00       	push   $0x802740
  800180:	ff 75 e8             	pushl  -0x18(%ebp)
  800183:	e8 f4 1f 00 00       	call   80217c <sys_signalSemaphore>
  800188:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  80018b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80018f:	83 f8 62             	cmp    $0x62,%eax
  800192:	74 1d                	je     8001b1 <_main+0x179>
  800194:	83 f8 63             	cmp    $0x63,%eax
  800197:	74 2b                	je     8001c4 <_main+0x18c>
  800199:	83 f8 61             	cmp    $0x61,%eax
  80019c:	75 39                	jne    8001d7 <_main+0x19f>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80019e:	83 ec 08             	sub    $0x8,%esp
  8001a1:	ff 75 e0             	pushl  -0x20(%ebp)
  8001a4:	ff 75 dc             	pushl  -0x24(%ebp)
  8001a7:	e8 48 03 00 00       	call   8004f4 <InitializeAscending>
  8001ac:	83 c4 10             	add    $0x10,%esp
			break ;
  8001af:	eb 37                	jmp    8001e8 <_main+0x1b0>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b1:	83 ec 08             	sub    $0x8,%esp
  8001b4:	ff 75 e0             	pushl  -0x20(%ebp)
  8001b7:	ff 75 dc             	pushl  -0x24(%ebp)
  8001ba:	e8 66 03 00 00       	call   800525 <InitializeDescending>
  8001bf:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c2:	eb 24                	jmp    8001e8 <_main+0x1b0>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ca:	ff 75 dc             	pushl  -0x24(%ebp)
  8001cd:	e8 88 03 00 00       	call   80055a <InitializeSemiRandom>
  8001d2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d5:	eb 11                	jmp    8001e8 <_main+0x1b0>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 e0             	pushl  -0x20(%ebp)
  8001dd:	ff 75 dc             	pushl  -0x24(%ebp)
  8001e0:	e8 75 03 00 00       	call   80055a <InitializeSemiRandom>
  8001e5:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001e8:	83 ec 08             	sub    $0x8,%esp
  8001eb:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ee:	ff 75 dc             	pushl  -0x24(%ebp)
  8001f1:	e8 43 01 00 00       	call   800339 <QuickSort>
  8001f6:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f9:	83 ec 08             	sub    $0x8,%esp
  8001fc:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ff:	ff 75 dc             	pushl  -0x24(%ebp)
  800202:	e8 43 02 00 00       	call   80044a <CheckSorted>
  800207:	83 c4 10             	add    $0x10,%esp
  80020a:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80020d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  800211:	75 14                	jne    800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 c0 27 80 00       	push   $0x8027c0
  80021b:	6a 4f                	push   $0x4f
  80021d:	68 e2 27 80 00       	push   $0x8027e2
  800222:	e8 ea 05 00 00       	call   800811 <_panic>
		else
		{
			sys_waitSemaphore(envID, "1");
  800227:	83 ec 08             	sub    $0x8,%esp
  80022a:	68 40 27 80 00       	push   $0x802740
  80022f:	ff 75 e8             	pushl  -0x18(%ebp)
  800232:	e8 27 1f 00 00       	call   80215e <sys_waitSemaphore>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 f4 27 80 00       	push   $0x8027f4
  800242:	e8 6c 08 00 00       	call   800ab3 <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 28 28 80 00       	push   $0x802828
  800252:	e8 5c 08 00 00       	call   800ab3 <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80025a:	83 ec 0c             	sub    $0xc,%esp
  80025d:	68 5c 28 80 00       	push   $0x80285c
  800262:	e8 4c 08 00 00       	call   800ab3 <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "1");
  80026a:	83 ec 08             	sub    $0x8,%esp
  80026d:	68 40 27 80 00       	push   $0x802740
  800272:	ff 75 e8             	pushl  -0x18(%ebp)
  800275:	e8 02 1f 00 00       	call   80217c <sys_signalSemaphore>
  80027a:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_waitSemaphore(envID, "1");
  80027d:	83 ec 08             	sub    $0x8,%esp
  800280:	68 40 27 80 00       	push   $0x802740
  800285:	ff 75 e8             	pushl  -0x18(%ebp)
  800288:	e8 d1 1e 00 00       	call   80215e <sys_waitSemaphore>
  80028d:	83 c4 10             	add    $0x10,%esp
		cprintf("Freeing the Heap...\n\n") ;
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	68 8e 28 80 00       	push   $0x80288e
  800298:	e8 16 08 00 00       	call   800ab3 <cprintf>
  80029d:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "1");
  8002a0:	83 ec 08             	sub    $0x8,%esp
  8002a3:	68 40 27 80 00       	push   $0x802740
  8002a8:	ff 75 e8             	pushl  -0x18(%ebp)
  8002ab:	e8 cc 1e 00 00       	call   80217c <sys_signalSemaphore>
  8002b0:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  8002b3:	83 ec 0c             	sub    $0xc,%esp
  8002b6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002b9:	e8 4d 1a 00 00       	call   801d0b <free>
  8002be:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "1");
  8002c1:	83 ec 08             	sub    $0x8,%esp
  8002c4:	68 40 27 80 00       	push   $0x802740
  8002c9:	ff 75 e8             	pushl  -0x18(%ebp)
  8002cc:	e8 8d 1e 00 00       	call   80215e <sys_waitSemaphore>
  8002d1:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  8002d4:	83 ec 0c             	sub    $0xc,%esp
  8002d7:	68 a4 28 80 00       	push   $0x8028a4
  8002dc:	e8 d2 07 00 00       	call   800ab3 <cprintf>
  8002e1:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  8002e4:	e8 8b 03 00 00       	call   800674 <getchar>
  8002e9:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  8002ec:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8002f0:	83 ec 0c             	sub    $0xc,%esp
  8002f3:	50                   	push   %eax
  8002f4:	e8 33 03 00 00       	call   80062c <cputchar>
  8002f9:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002fc:	83 ec 0c             	sub    $0xc,%esp
  8002ff:	6a 0a                	push   $0xa
  800301:	e8 26 03 00 00       	call   80062c <cputchar>
  800306:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800309:	83 ec 0c             	sub    $0xc,%esp
  80030c:	6a 0a                	push   $0xa
  80030e:	e8 19 03 00 00       	call   80062c <cputchar>
  800313:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID, "1");
  800316:	83 ec 08             	sub    $0x8,%esp
  800319:	68 40 27 80 00       	push   $0x802740
  80031e:	ff 75 e8             	pushl  -0x18(%ebp)
  800321:	e8 56 1e 00 00       	call   80217c <sys_signalSemaphore>
  800326:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  800329:	80 7d db 79          	cmpb   $0x79,-0x25(%ebp)
  80032d:	0f 84 30 fd ff ff    	je     800063 <_main+0x2b>

}
  800333:	90                   	nop
  800334:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800337:	c9                   	leave  
  800338:	c3                   	ret    

00800339 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  800339:	55                   	push   %ebp
  80033a:	89 e5                	mov    %esp,%ebp
  80033c:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80033f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800342:	48                   	dec    %eax
  800343:	50                   	push   %eax
  800344:	6a 00                	push   $0x0
  800346:	ff 75 0c             	pushl  0xc(%ebp)
  800349:	ff 75 08             	pushl  0x8(%ebp)
  80034c:	e8 06 00 00 00       	call   800357 <QSort>
  800351:	83 c4 10             	add    $0x10,%esp
}
  800354:	90                   	nop
  800355:	c9                   	leave  
  800356:	c3                   	ret    

00800357 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800357:	55                   	push   %ebp
  800358:	89 e5                	mov    %esp,%ebp
  80035a:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80035d:	8b 45 10             	mov    0x10(%ebp),%eax
  800360:	3b 45 14             	cmp    0x14(%ebp),%eax
  800363:	0f 8d de 00 00 00    	jge    800447 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800369:	8b 45 10             	mov    0x10(%ebp),%eax
  80036c:	40                   	inc    %eax
  80036d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800370:	8b 45 14             	mov    0x14(%ebp),%eax
  800373:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800376:	e9 80 00 00 00       	jmp    8003fb <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  80037b:	ff 45 f4             	incl   -0xc(%ebp)
  80037e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800381:	3b 45 14             	cmp    0x14(%ebp),%eax
  800384:	7f 2b                	jg     8003b1 <QSort+0x5a>
  800386:	8b 45 10             	mov    0x10(%ebp),%eax
  800389:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800390:	8b 45 08             	mov    0x8(%ebp),%eax
  800393:	01 d0                	add    %edx,%eax
  800395:	8b 10                	mov    (%eax),%edx
  800397:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80039a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	01 c8                	add    %ecx,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	39 c2                	cmp    %eax,%edx
  8003aa:	7d cf                	jge    80037b <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8003ac:	eb 03                	jmp    8003b1 <QSort+0x5a>
  8003ae:	ff 4d f0             	decl   -0x10(%ebp)
  8003b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8003b7:	7e 26                	jle    8003df <QSort+0x88>
  8003b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8003bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c6:	01 d0                	add    %edx,%eax
  8003c8:	8b 10                	mov    (%eax),%edx
  8003ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d7:	01 c8                	add    %ecx,%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	39 c2                	cmp    %eax,%edx
  8003dd:	7e cf                	jle    8003ae <QSort+0x57>

		if (i <= j)
  8003df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003e5:	7f 14                	jg     8003fb <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8003e7:	83 ec 04             	sub    $0x4,%esp
  8003ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8003ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8003f0:	ff 75 08             	pushl  0x8(%ebp)
  8003f3:	e8 a9 00 00 00       	call   8004a1 <Swap>
  8003f8:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800401:	0f 8e 77 ff ff ff    	jle    80037e <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800407:	83 ec 04             	sub    $0x4,%esp
  80040a:	ff 75 f0             	pushl  -0x10(%ebp)
  80040d:	ff 75 10             	pushl  0x10(%ebp)
  800410:	ff 75 08             	pushl  0x8(%ebp)
  800413:	e8 89 00 00 00       	call   8004a1 <Swap>
  800418:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80041b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80041e:	48                   	dec    %eax
  80041f:	50                   	push   %eax
  800420:	ff 75 10             	pushl  0x10(%ebp)
  800423:	ff 75 0c             	pushl  0xc(%ebp)
  800426:	ff 75 08             	pushl  0x8(%ebp)
  800429:	e8 29 ff ff ff       	call   800357 <QSort>
  80042e:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800431:	ff 75 14             	pushl  0x14(%ebp)
  800434:	ff 75 f4             	pushl  -0xc(%ebp)
  800437:	ff 75 0c             	pushl  0xc(%ebp)
  80043a:	ff 75 08             	pushl  0x8(%ebp)
  80043d:	e8 15 ff ff ff       	call   800357 <QSort>
  800442:	83 c4 10             	add    $0x10,%esp
  800445:	eb 01                	jmp    800448 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800447:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800448:	c9                   	leave  
  800449:	c3                   	ret    

0080044a <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80044a:	55                   	push   %ebp
  80044b:	89 e5                	mov    %esp,%ebp
  80044d:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800450:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800457:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80045e:	eb 33                	jmp    800493 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800460:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800463:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	01 d0                	add    %edx,%eax
  80046f:	8b 10                	mov    (%eax),%edx
  800471:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800474:	40                   	inc    %eax
  800475:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80047c:	8b 45 08             	mov    0x8(%ebp),%eax
  80047f:	01 c8                	add    %ecx,%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	39 c2                	cmp    %eax,%edx
  800485:	7e 09                	jle    800490 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800487:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80048e:	eb 0c                	jmp    80049c <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800490:	ff 45 f8             	incl   -0x8(%ebp)
  800493:	8b 45 0c             	mov    0xc(%ebp),%eax
  800496:	48                   	dec    %eax
  800497:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80049a:	7f c4                	jg     800460 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80049c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80049f:	c9                   	leave  
  8004a0:	c3                   	ret    

008004a1 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8004a1:	55                   	push   %ebp
  8004a2:	89 e5                	mov    %esp,%ebp
  8004a4:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8004a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b4:	01 d0                	add    %edx,%eax
  8004b6:	8b 00                	mov    (%eax),%eax
  8004b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c8:	01 c2                	add    %eax,%edx
  8004ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d7:	01 c8                	add    %ecx,%eax
  8004d9:	8b 00                	mov    (%eax),%eax
  8004db:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8004dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ea:	01 c2                	add    %eax,%edx
  8004ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ef:	89 02                	mov    %eax,(%edx)
}
  8004f1:	90                   	nop
  8004f2:	c9                   	leave  
  8004f3:	c3                   	ret    

008004f4 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004f4:	55                   	push   %ebp
  8004f5:	89 e5                	mov    %esp,%ebp
  8004f7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800501:	eb 17                	jmp    80051a <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800503:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800506:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	01 c2                	add    %eax,%edx
  800512:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800515:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800517:	ff 45 fc             	incl   -0x4(%ebp)
  80051a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80051d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800520:	7c e1                	jl     800503 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800522:	90                   	nop
  800523:	c9                   	leave  
  800524:	c3                   	ret    

00800525 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800525:	55                   	push   %ebp
  800526:	89 e5                	mov    %esp,%ebp
  800528:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80052b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800532:	eb 1b                	jmp    80054f <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800534:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800537:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80053e:	8b 45 08             	mov    0x8(%ebp),%eax
  800541:	01 c2                	add    %eax,%edx
  800543:	8b 45 0c             	mov    0xc(%ebp),%eax
  800546:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800549:	48                   	dec    %eax
  80054a:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80054c:	ff 45 fc             	incl   -0x4(%ebp)
  80054f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800552:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800555:	7c dd                	jl     800534 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800557:	90                   	nop
  800558:	c9                   	leave  
  800559:	c3                   	ret    

0080055a <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80055a:	55                   	push   %ebp
  80055b:	89 e5                	mov    %esp,%ebp
  80055d:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800560:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800563:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800568:	f7 e9                	imul   %ecx
  80056a:	c1 f9 1f             	sar    $0x1f,%ecx
  80056d:	89 d0                	mov    %edx,%eax
  80056f:	29 c8                	sub    %ecx,%eax
  800571:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800574:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80057b:	eb 1e                	jmp    80059b <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80057d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800580:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800587:	8b 45 08             	mov    0x8(%ebp),%eax
  80058a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80058d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800590:	99                   	cltd   
  800591:	f7 7d f8             	idivl  -0x8(%ebp)
  800594:	89 d0                	mov    %edx,%eax
  800596:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800598:	ff 45 fc             	incl   -0x4(%ebp)
  80059b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80059e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005a1:	7c da                	jl     80057d <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8005a3:	90                   	nop
  8005a4:	c9                   	leave  
  8005a5:	c3                   	ret    

008005a6 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8005a6:	55                   	push   %ebp
  8005a7:	89 e5                	mov    %esp,%ebp
  8005a9:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8005ac:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005ba:	eb 42                	jmp    8005fe <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8005bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005bf:	99                   	cltd   
  8005c0:	f7 7d f0             	idivl  -0x10(%ebp)
  8005c3:	89 d0                	mov    %edx,%eax
  8005c5:	85 c0                	test   %eax,%eax
  8005c7:	75 10                	jne    8005d9 <PrintElements+0x33>
			cprintf("\n");
  8005c9:	83 ec 0c             	sub    $0xc,%esp
  8005cc:	68 c2 28 80 00       	push   $0x8028c2
  8005d1:	e8 dd 04 00 00       	call   800ab3 <cprintf>
  8005d6:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8005d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e6:	01 d0                	add    %edx,%eax
  8005e8:	8b 00                	mov    (%eax),%eax
  8005ea:	83 ec 08             	sub    $0x8,%esp
  8005ed:	50                   	push   %eax
  8005ee:	68 c4 28 80 00       	push   $0x8028c4
  8005f3:	e8 bb 04 00 00       	call   800ab3 <cprintf>
  8005f8:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005fb:	ff 45 f4             	incl   -0xc(%ebp)
  8005fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800601:	48                   	dec    %eax
  800602:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800605:	7f b5                	jg     8005bc <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800607:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800611:	8b 45 08             	mov    0x8(%ebp),%eax
  800614:	01 d0                	add    %edx,%eax
  800616:	8b 00                	mov    (%eax),%eax
  800618:	83 ec 08             	sub    $0x8,%esp
  80061b:	50                   	push   %eax
  80061c:	68 c9 28 80 00       	push   $0x8028c9
  800621:	e8 8d 04 00 00       	call   800ab3 <cprintf>
  800626:	83 c4 10             	add    $0x10,%esp

}
  800629:	90                   	nop
  80062a:	c9                   	leave  
  80062b:	c3                   	ret    

0080062c <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80062c:	55                   	push   %ebp
  80062d:	89 e5                	mov    %esp,%ebp
  80062f:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800638:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80063c:	83 ec 0c             	sub    $0xc,%esp
  80063f:	50                   	push   %eax
  800640:	e8 a0 1a 00 00       	call   8020e5 <sys_cputc>
  800645:	83 c4 10             	add    $0x10,%esp
}
  800648:	90                   	nop
  800649:	c9                   	leave  
  80064a:	c3                   	ret    

0080064b <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80064b:	55                   	push   %ebp
  80064c:	89 e5                	mov    %esp,%ebp
  80064e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800651:	e8 5b 1a 00 00       	call   8020b1 <sys_disable_interrupt>
	char c = ch;
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80065c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800660:	83 ec 0c             	sub    $0xc,%esp
  800663:	50                   	push   %eax
  800664:	e8 7c 1a 00 00       	call   8020e5 <sys_cputc>
  800669:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80066c:	e8 5a 1a 00 00       	call   8020cb <sys_enable_interrupt>
}
  800671:	90                   	nop
  800672:	c9                   	leave  
  800673:	c3                   	ret    

00800674 <getchar>:

int
getchar(void)
{
  800674:	55                   	push   %ebp
  800675:	89 e5                	mov    %esp,%ebp
  800677:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80067a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800681:	eb 08                	jmp    80068b <getchar+0x17>
	{
		c = sys_cgetc();
  800683:	e8 41 18 00 00       	call   801ec9 <sys_cgetc>
  800688:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80068b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80068f:	74 f2                	je     800683 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800691:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800694:	c9                   	leave  
  800695:	c3                   	ret    

00800696 <atomic_getchar>:

int
atomic_getchar(void)
{
  800696:	55                   	push   %ebp
  800697:	89 e5                	mov    %esp,%ebp
  800699:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80069c:	e8 10 1a 00 00       	call   8020b1 <sys_disable_interrupt>
	int c=0;
  8006a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8006a8:	eb 08                	jmp    8006b2 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8006aa:	e8 1a 18 00 00       	call   801ec9 <sys_cgetc>
  8006af:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8006b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8006b6:	74 f2                	je     8006aa <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8006b8:	e8 0e 1a 00 00       	call   8020cb <sys_enable_interrupt>
	return c;
  8006bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8006c0:	c9                   	leave  
  8006c1:	c3                   	ret    

008006c2 <iscons>:

int iscons(int fdnum)
{
  8006c2:	55                   	push   %ebp
  8006c3:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8006c5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8006ca:	5d                   	pop    %ebp
  8006cb:	c3                   	ret    

008006cc <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006cc:	55                   	push   %ebp
  8006cd:	89 e5                	mov    %esp,%ebp
  8006cf:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006d2:	e8 3f 18 00 00       	call   801f16 <sys_getenvindex>
  8006d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006dd:	89 d0                	mov    %edx,%eax
  8006df:	c1 e0 03             	shl    $0x3,%eax
  8006e2:	01 d0                	add    %edx,%eax
  8006e4:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8006eb:	01 c8                	add    %ecx,%eax
  8006ed:	01 c0                	add    %eax,%eax
  8006ef:	01 d0                	add    %edx,%eax
  8006f1:	01 c0                	add    %eax,%eax
  8006f3:	01 d0                	add    %edx,%eax
  8006f5:	89 c2                	mov    %eax,%edx
  8006f7:	c1 e2 05             	shl    $0x5,%edx
  8006fa:	29 c2                	sub    %eax,%edx
  8006fc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800703:	89 c2                	mov    %eax,%edx
  800705:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80070b:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800710:	a1 24 30 80 00       	mov    0x803024,%eax
  800715:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80071b:	84 c0                	test   %al,%al
  80071d:	74 0f                	je     80072e <libmain+0x62>
		binaryname = myEnv->prog_name;
  80071f:	a1 24 30 80 00       	mov    0x803024,%eax
  800724:	05 40 3c 01 00       	add    $0x13c40,%eax
  800729:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80072e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800732:	7e 0a                	jle    80073e <libmain+0x72>
		binaryname = argv[0];
  800734:	8b 45 0c             	mov    0xc(%ebp),%eax
  800737:	8b 00                	mov    (%eax),%eax
  800739:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80073e:	83 ec 08             	sub    $0x8,%esp
  800741:	ff 75 0c             	pushl  0xc(%ebp)
  800744:	ff 75 08             	pushl  0x8(%ebp)
  800747:	e8 ec f8 ff ff       	call   800038 <_main>
  80074c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80074f:	e8 5d 19 00 00       	call   8020b1 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800754:	83 ec 0c             	sub    $0xc,%esp
  800757:	68 e8 28 80 00       	push   $0x8028e8
  80075c:	e8 52 03 00 00       	call   800ab3 <cprintf>
  800761:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800764:	a1 24 30 80 00       	mov    0x803024,%eax
  800769:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80076f:	a1 24 30 80 00       	mov    0x803024,%eax
  800774:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80077a:	83 ec 04             	sub    $0x4,%esp
  80077d:	52                   	push   %edx
  80077e:	50                   	push   %eax
  80077f:	68 10 29 80 00       	push   $0x802910
  800784:	e8 2a 03 00 00       	call   800ab3 <cprintf>
  800789:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80078c:	a1 24 30 80 00       	mov    0x803024,%eax
  800791:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800797:	a1 24 30 80 00       	mov    0x803024,%eax
  80079c:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8007a2:	83 ec 04             	sub    $0x4,%esp
  8007a5:	52                   	push   %edx
  8007a6:	50                   	push   %eax
  8007a7:	68 38 29 80 00       	push   $0x802938
  8007ac:	e8 02 03 00 00       	call   800ab3 <cprintf>
  8007b1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8007b4:	a1 24 30 80 00       	mov    0x803024,%eax
  8007b9:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8007bf:	83 ec 08             	sub    $0x8,%esp
  8007c2:	50                   	push   %eax
  8007c3:	68 79 29 80 00       	push   $0x802979
  8007c8:	e8 e6 02 00 00       	call   800ab3 <cprintf>
  8007cd:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8007d0:	83 ec 0c             	sub    $0xc,%esp
  8007d3:	68 e8 28 80 00       	push   $0x8028e8
  8007d8:	e8 d6 02 00 00       	call   800ab3 <cprintf>
  8007dd:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007e0:	e8 e6 18 00 00       	call   8020cb <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007e5:	e8 19 00 00 00       	call   800803 <exit>
}
  8007ea:	90                   	nop
  8007eb:	c9                   	leave  
  8007ec:	c3                   	ret    

008007ed <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007ed:	55                   	push   %ebp
  8007ee:	89 e5                	mov    %esp,%ebp
  8007f0:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007f3:	83 ec 0c             	sub    $0xc,%esp
  8007f6:	6a 00                	push   $0x0
  8007f8:	e8 e5 16 00 00       	call   801ee2 <sys_env_destroy>
  8007fd:	83 c4 10             	add    $0x10,%esp
}
  800800:	90                   	nop
  800801:	c9                   	leave  
  800802:	c3                   	ret    

00800803 <exit>:

void
exit(void)
{
  800803:	55                   	push   %ebp
  800804:	89 e5                	mov    %esp,%ebp
  800806:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800809:	e8 3a 17 00 00       	call   801f48 <sys_env_exit>
}
  80080e:	90                   	nop
  80080f:	c9                   	leave  
  800810:	c3                   	ret    

00800811 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800811:	55                   	push   %ebp
  800812:	89 e5                	mov    %esp,%ebp
  800814:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800817:	8d 45 10             	lea    0x10(%ebp),%eax
  80081a:	83 c0 04             	add    $0x4,%eax
  80081d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800820:	a1 18 31 80 00       	mov    0x803118,%eax
  800825:	85 c0                	test   %eax,%eax
  800827:	74 16                	je     80083f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800829:	a1 18 31 80 00       	mov    0x803118,%eax
  80082e:	83 ec 08             	sub    $0x8,%esp
  800831:	50                   	push   %eax
  800832:	68 90 29 80 00       	push   $0x802990
  800837:	e8 77 02 00 00       	call   800ab3 <cprintf>
  80083c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80083f:	a1 00 30 80 00       	mov    0x803000,%eax
  800844:	ff 75 0c             	pushl  0xc(%ebp)
  800847:	ff 75 08             	pushl  0x8(%ebp)
  80084a:	50                   	push   %eax
  80084b:	68 95 29 80 00       	push   $0x802995
  800850:	e8 5e 02 00 00       	call   800ab3 <cprintf>
  800855:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800858:	8b 45 10             	mov    0x10(%ebp),%eax
  80085b:	83 ec 08             	sub    $0x8,%esp
  80085e:	ff 75 f4             	pushl  -0xc(%ebp)
  800861:	50                   	push   %eax
  800862:	e8 e1 01 00 00       	call   800a48 <vcprintf>
  800867:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80086a:	83 ec 08             	sub    $0x8,%esp
  80086d:	6a 00                	push   $0x0
  80086f:	68 b1 29 80 00       	push   $0x8029b1
  800874:	e8 cf 01 00 00       	call   800a48 <vcprintf>
  800879:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80087c:	e8 82 ff ff ff       	call   800803 <exit>

	// should not return here
	while (1) ;
  800881:	eb fe                	jmp    800881 <_panic+0x70>

00800883 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800883:	55                   	push   %ebp
  800884:	89 e5                	mov    %esp,%ebp
  800886:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800889:	a1 24 30 80 00       	mov    0x803024,%eax
  80088e:	8b 50 74             	mov    0x74(%eax),%edx
  800891:	8b 45 0c             	mov    0xc(%ebp),%eax
  800894:	39 c2                	cmp    %eax,%edx
  800896:	74 14                	je     8008ac <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800898:	83 ec 04             	sub    $0x4,%esp
  80089b:	68 b4 29 80 00       	push   $0x8029b4
  8008a0:	6a 26                	push   $0x26
  8008a2:	68 00 2a 80 00       	push   $0x802a00
  8008a7:	e8 65 ff ff ff       	call   800811 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008ba:	e9 b6 00 00 00       	jmp    800975 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8008bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cc:	01 d0                	add    %edx,%eax
  8008ce:	8b 00                	mov    (%eax),%eax
  8008d0:	85 c0                	test   %eax,%eax
  8008d2:	75 08                	jne    8008dc <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008d4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008d7:	e9 96 00 00 00       	jmp    800972 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8008dc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008e3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008ea:	eb 5d                	jmp    800949 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008ec:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008f7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008fa:	c1 e2 04             	shl    $0x4,%edx
  8008fd:	01 d0                	add    %edx,%eax
  8008ff:	8a 40 04             	mov    0x4(%eax),%al
  800902:	84 c0                	test   %al,%al
  800904:	75 40                	jne    800946 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800906:	a1 24 30 80 00       	mov    0x803024,%eax
  80090b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800911:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800914:	c1 e2 04             	shl    $0x4,%edx
  800917:	01 d0                	add    %edx,%eax
  800919:	8b 00                	mov    (%eax),%eax
  80091b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80091e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800921:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800926:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800928:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80092b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800932:	8b 45 08             	mov    0x8(%ebp),%eax
  800935:	01 c8                	add    %ecx,%eax
  800937:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800939:	39 c2                	cmp    %eax,%edx
  80093b:	75 09                	jne    800946 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80093d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800944:	eb 12                	jmp    800958 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800946:	ff 45 e8             	incl   -0x18(%ebp)
  800949:	a1 24 30 80 00       	mov    0x803024,%eax
  80094e:	8b 50 74             	mov    0x74(%eax),%edx
  800951:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800954:	39 c2                	cmp    %eax,%edx
  800956:	77 94                	ja     8008ec <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800958:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80095c:	75 14                	jne    800972 <CheckWSWithoutLastIndex+0xef>
			panic(
  80095e:	83 ec 04             	sub    $0x4,%esp
  800961:	68 0c 2a 80 00       	push   $0x802a0c
  800966:	6a 3a                	push   $0x3a
  800968:	68 00 2a 80 00       	push   $0x802a00
  80096d:	e8 9f fe ff ff       	call   800811 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800972:	ff 45 f0             	incl   -0x10(%ebp)
  800975:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800978:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80097b:	0f 8c 3e ff ff ff    	jl     8008bf <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800981:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800988:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80098f:	eb 20                	jmp    8009b1 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800991:	a1 24 30 80 00       	mov    0x803024,%eax
  800996:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80099c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80099f:	c1 e2 04             	shl    $0x4,%edx
  8009a2:	01 d0                	add    %edx,%eax
  8009a4:	8a 40 04             	mov    0x4(%eax),%al
  8009a7:	3c 01                	cmp    $0x1,%al
  8009a9:	75 03                	jne    8009ae <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8009ab:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009ae:	ff 45 e0             	incl   -0x20(%ebp)
  8009b1:	a1 24 30 80 00       	mov    0x803024,%eax
  8009b6:	8b 50 74             	mov    0x74(%eax),%edx
  8009b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009bc:	39 c2                	cmp    %eax,%edx
  8009be:	77 d1                	ja     800991 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009c3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009c6:	74 14                	je     8009dc <CheckWSWithoutLastIndex+0x159>
		panic(
  8009c8:	83 ec 04             	sub    $0x4,%esp
  8009cb:	68 60 2a 80 00       	push   $0x802a60
  8009d0:	6a 44                	push   $0x44
  8009d2:	68 00 2a 80 00       	push   $0x802a00
  8009d7:	e8 35 fe ff ff       	call   800811 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009dc:	90                   	nop
  8009dd:	c9                   	leave  
  8009de:	c3                   	ret    

008009df <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009df:	55                   	push   %ebp
  8009e0:	89 e5                	mov    %esp,%ebp
  8009e2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e8:	8b 00                	mov    (%eax),%eax
  8009ea:	8d 48 01             	lea    0x1(%eax),%ecx
  8009ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f0:	89 0a                	mov    %ecx,(%edx)
  8009f2:	8b 55 08             	mov    0x8(%ebp),%edx
  8009f5:	88 d1                	mov    %dl,%cl
  8009f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009fa:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a01:	8b 00                	mov    (%eax),%eax
  800a03:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a08:	75 2c                	jne    800a36 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a0a:	a0 28 30 80 00       	mov    0x803028,%al
  800a0f:	0f b6 c0             	movzbl %al,%eax
  800a12:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a15:	8b 12                	mov    (%edx),%edx
  800a17:	89 d1                	mov    %edx,%ecx
  800a19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1c:	83 c2 08             	add    $0x8,%edx
  800a1f:	83 ec 04             	sub    $0x4,%esp
  800a22:	50                   	push   %eax
  800a23:	51                   	push   %ecx
  800a24:	52                   	push   %edx
  800a25:	e8 76 14 00 00       	call   801ea0 <sys_cputs>
  800a2a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a30:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a39:	8b 40 04             	mov    0x4(%eax),%eax
  800a3c:	8d 50 01             	lea    0x1(%eax),%edx
  800a3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a42:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a45:	90                   	nop
  800a46:	c9                   	leave  
  800a47:	c3                   	ret    

00800a48 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a48:	55                   	push   %ebp
  800a49:	89 e5                	mov    %esp,%ebp
  800a4b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a51:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a58:	00 00 00 
	b.cnt = 0;
  800a5b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a62:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a65:	ff 75 0c             	pushl  0xc(%ebp)
  800a68:	ff 75 08             	pushl  0x8(%ebp)
  800a6b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a71:	50                   	push   %eax
  800a72:	68 df 09 80 00       	push   $0x8009df
  800a77:	e8 11 02 00 00       	call   800c8d <vprintfmt>
  800a7c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a7f:	a0 28 30 80 00       	mov    0x803028,%al
  800a84:	0f b6 c0             	movzbl %al,%eax
  800a87:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a8d:	83 ec 04             	sub    $0x4,%esp
  800a90:	50                   	push   %eax
  800a91:	52                   	push   %edx
  800a92:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a98:	83 c0 08             	add    $0x8,%eax
  800a9b:	50                   	push   %eax
  800a9c:	e8 ff 13 00 00       	call   801ea0 <sys_cputs>
  800aa1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800aa4:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800aab:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800ab1:	c9                   	leave  
  800ab2:	c3                   	ret    

00800ab3 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ab3:	55                   	push   %ebp
  800ab4:	89 e5                	mov    %esp,%ebp
  800ab6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ab9:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800ac0:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ac3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	83 ec 08             	sub    $0x8,%esp
  800acc:	ff 75 f4             	pushl  -0xc(%ebp)
  800acf:	50                   	push   %eax
  800ad0:	e8 73 ff ff ff       	call   800a48 <vcprintf>
  800ad5:	83 c4 10             	add    $0x10,%esp
  800ad8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800adb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ade:	c9                   	leave  
  800adf:	c3                   	ret    

00800ae0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ae0:	55                   	push   %ebp
  800ae1:	89 e5                	mov    %esp,%ebp
  800ae3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ae6:	e8 c6 15 00 00       	call   8020b1 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800aeb:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	83 ec 08             	sub    $0x8,%esp
  800af7:	ff 75 f4             	pushl  -0xc(%ebp)
  800afa:	50                   	push   %eax
  800afb:	e8 48 ff ff ff       	call   800a48 <vcprintf>
  800b00:	83 c4 10             	add    $0x10,%esp
  800b03:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b06:	e8 c0 15 00 00       	call   8020cb <sys_enable_interrupt>
	return cnt;
  800b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b0e:	c9                   	leave  
  800b0f:	c3                   	ret    

00800b10 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b10:	55                   	push   %ebp
  800b11:	89 e5                	mov    %esp,%ebp
  800b13:	53                   	push   %ebx
  800b14:	83 ec 14             	sub    $0x14,%esp
  800b17:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b20:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b23:	8b 45 18             	mov    0x18(%ebp),%eax
  800b26:	ba 00 00 00 00       	mov    $0x0,%edx
  800b2b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b2e:	77 55                	ja     800b85 <printnum+0x75>
  800b30:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b33:	72 05                	jb     800b3a <printnum+0x2a>
  800b35:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b38:	77 4b                	ja     800b85 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b3a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b3d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b40:	8b 45 18             	mov    0x18(%ebp),%eax
  800b43:	ba 00 00 00 00       	mov    $0x0,%edx
  800b48:	52                   	push   %edx
  800b49:	50                   	push   %eax
  800b4a:	ff 75 f4             	pushl  -0xc(%ebp)
  800b4d:	ff 75 f0             	pushl  -0x10(%ebp)
  800b50:	e8 7f 19 00 00       	call   8024d4 <__udivdi3>
  800b55:	83 c4 10             	add    $0x10,%esp
  800b58:	83 ec 04             	sub    $0x4,%esp
  800b5b:	ff 75 20             	pushl  0x20(%ebp)
  800b5e:	53                   	push   %ebx
  800b5f:	ff 75 18             	pushl  0x18(%ebp)
  800b62:	52                   	push   %edx
  800b63:	50                   	push   %eax
  800b64:	ff 75 0c             	pushl  0xc(%ebp)
  800b67:	ff 75 08             	pushl  0x8(%ebp)
  800b6a:	e8 a1 ff ff ff       	call   800b10 <printnum>
  800b6f:	83 c4 20             	add    $0x20,%esp
  800b72:	eb 1a                	jmp    800b8e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b74:	83 ec 08             	sub    $0x8,%esp
  800b77:	ff 75 0c             	pushl  0xc(%ebp)
  800b7a:	ff 75 20             	pushl  0x20(%ebp)
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	ff d0                	call   *%eax
  800b82:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b85:	ff 4d 1c             	decl   0x1c(%ebp)
  800b88:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b8c:	7f e6                	jg     800b74 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b8e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b91:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b96:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b99:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b9c:	53                   	push   %ebx
  800b9d:	51                   	push   %ecx
  800b9e:	52                   	push   %edx
  800b9f:	50                   	push   %eax
  800ba0:	e8 3f 1a 00 00       	call   8025e4 <__umoddi3>
  800ba5:	83 c4 10             	add    $0x10,%esp
  800ba8:	05 d4 2c 80 00       	add    $0x802cd4,%eax
  800bad:	8a 00                	mov    (%eax),%al
  800baf:	0f be c0             	movsbl %al,%eax
  800bb2:	83 ec 08             	sub    $0x8,%esp
  800bb5:	ff 75 0c             	pushl  0xc(%ebp)
  800bb8:	50                   	push   %eax
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	ff d0                	call   *%eax
  800bbe:	83 c4 10             	add    $0x10,%esp
}
  800bc1:	90                   	nop
  800bc2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bc5:	c9                   	leave  
  800bc6:	c3                   	ret    

00800bc7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800bc7:	55                   	push   %ebp
  800bc8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bca:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bce:	7e 1c                	jle    800bec <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	8b 00                	mov    (%eax),%eax
  800bd5:	8d 50 08             	lea    0x8(%eax),%edx
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	89 10                	mov    %edx,(%eax)
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	8b 00                	mov    (%eax),%eax
  800be2:	83 e8 08             	sub    $0x8,%eax
  800be5:	8b 50 04             	mov    0x4(%eax),%edx
  800be8:	8b 00                	mov    (%eax),%eax
  800bea:	eb 40                	jmp    800c2c <getuint+0x65>
	else if (lflag)
  800bec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bf0:	74 1e                	je     800c10 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	8b 00                	mov    (%eax),%eax
  800bf7:	8d 50 04             	lea    0x4(%eax),%edx
  800bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfd:	89 10                	mov    %edx,(%eax)
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
  800c02:	8b 00                	mov    (%eax),%eax
  800c04:	83 e8 04             	sub    $0x4,%eax
  800c07:	8b 00                	mov    (%eax),%eax
  800c09:	ba 00 00 00 00       	mov    $0x0,%edx
  800c0e:	eb 1c                	jmp    800c2c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	8b 00                	mov    (%eax),%eax
  800c15:	8d 50 04             	lea    0x4(%eax),%edx
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	89 10                	mov    %edx,(%eax)
  800c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c20:	8b 00                	mov    (%eax),%eax
  800c22:	83 e8 04             	sub    $0x4,%eax
  800c25:	8b 00                	mov    (%eax),%eax
  800c27:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c2c:	5d                   	pop    %ebp
  800c2d:	c3                   	ret    

00800c2e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c2e:	55                   	push   %ebp
  800c2f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c31:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c35:	7e 1c                	jle    800c53 <getint+0x25>
		return va_arg(*ap, long long);
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	8b 00                	mov    (%eax),%eax
  800c3c:	8d 50 08             	lea    0x8(%eax),%edx
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	89 10                	mov    %edx,(%eax)
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	8b 00                	mov    (%eax),%eax
  800c49:	83 e8 08             	sub    $0x8,%eax
  800c4c:	8b 50 04             	mov    0x4(%eax),%edx
  800c4f:	8b 00                	mov    (%eax),%eax
  800c51:	eb 38                	jmp    800c8b <getint+0x5d>
	else if (lflag)
  800c53:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c57:	74 1a                	je     800c73 <getint+0x45>
		return va_arg(*ap, long);
  800c59:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5c:	8b 00                	mov    (%eax),%eax
  800c5e:	8d 50 04             	lea    0x4(%eax),%edx
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	89 10                	mov    %edx,(%eax)
  800c66:	8b 45 08             	mov    0x8(%ebp),%eax
  800c69:	8b 00                	mov    (%eax),%eax
  800c6b:	83 e8 04             	sub    $0x4,%eax
  800c6e:	8b 00                	mov    (%eax),%eax
  800c70:	99                   	cltd   
  800c71:	eb 18                	jmp    800c8b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	8b 00                	mov    (%eax),%eax
  800c78:	8d 50 04             	lea    0x4(%eax),%edx
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	89 10                	mov    %edx,(%eax)
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	8b 00                	mov    (%eax),%eax
  800c85:	83 e8 04             	sub    $0x4,%eax
  800c88:	8b 00                	mov    (%eax),%eax
  800c8a:	99                   	cltd   
}
  800c8b:	5d                   	pop    %ebp
  800c8c:	c3                   	ret    

00800c8d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c8d:	55                   	push   %ebp
  800c8e:	89 e5                	mov    %esp,%ebp
  800c90:	56                   	push   %esi
  800c91:	53                   	push   %ebx
  800c92:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c95:	eb 17                	jmp    800cae <vprintfmt+0x21>
			if (ch == '\0')
  800c97:	85 db                	test   %ebx,%ebx
  800c99:	0f 84 af 03 00 00    	je     80104e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c9f:	83 ec 08             	sub    $0x8,%esp
  800ca2:	ff 75 0c             	pushl  0xc(%ebp)
  800ca5:	53                   	push   %ebx
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	ff d0                	call   *%eax
  800cab:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800cae:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb1:	8d 50 01             	lea    0x1(%eax),%edx
  800cb4:	89 55 10             	mov    %edx,0x10(%ebp)
  800cb7:	8a 00                	mov    (%eax),%al
  800cb9:	0f b6 d8             	movzbl %al,%ebx
  800cbc:	83 fb 25             	cmp    $0x25,%ebx
  800cbf:	75 d6                	jne    800c97 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800cc1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800cc5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ccc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cd3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cda:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ce1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce4:	8d 50 01             	lea    0x1(%eax),%edx
  800ce7:	89 55 10             	mov    %edx,0x10(%ebp)
  800cea:	8a 00                	mov    (%eax),%al
  800cec:	0f b6 d8             	movzbl %al,%ebx
  800cef:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800cf2:	83 f8 55             	cmp    $0x55,%eax
  800cf5:	0f 87 2b 03 00 00    	ja     801026 <vprintfmt+0x399>
  800cfb:	8b 04 85 f8 2c 80 00 	mov    0x802cf8(,%eax,4),%eax
  800d02:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d04:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d08:	eb d7                	jmp    800ce1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d0a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d0e:	eb d1                	jmp    800ce1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d10:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d17:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d1a:	89 d0                	mov    %edx,%eax
  800d1c:	c1 e0 02             	shl    $0x2,%eax
  800d1f:	01 d0                	add    %edx,%eax
  800d21:	01 c0                	add    %eax,%eax
  800d23:	01 d8                	add    %ebx,%eax
  800d25:	83 e8 30             	sub    $0x30,%eax
  800d28:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2e:	8a 00                	mov    (%eax),%al
  800d30:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d33:	83 fb 2f             	cmp    $0x2f,%ebx
  800d36:	7e 3e                	jle    800d76 <vprintfmt+0xe9>
  800d38:	83 fb 39             	cmp    $0x39,%ebx
  800d3b:	7f 39                	jg     800d76 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d3d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d40:	eb d5                	jmp    800d17 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d42:	8b 45 14             	mov    0x14(%ebp),%eax
  800d45:	83 c0 04             	add    $0x4,%eax
  800d48:	89 45 14             	mov    %eax,0x14(%ebp)
  800d4b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4e:	83 e8 04             	sub    $0x4,%eax
  800d51:	8b 00                	mov    (%eax),%eax
  800d53:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d56:	eb 1f                	jmp    800d77 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d58:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d5c:	79 83                	jns    800ce1 <vprintfmt+0x54>
				width = 0;
  800d5e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d65:	e9 77 ff ff ff       	jmp    800ce1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d6a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d71:	e9 6b ff ff ff       	jmp    800ce1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d76:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d77:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d7b:	0f 89 60 ff ff ff    	jns    800ce1 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d81:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d84:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d87:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d8e:	e9 4e ff ff ff       	jmp    800ce1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d93:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d96:	e9 46 ff ff ff       	jmp    800ce1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9e:	83 c0 04             	add    $0x4,%eax
  800da1:	89 45 14             	mov    %eax,0x14(%ebp)
  800da4:	8b 45 14             	mov    0x14(%ebp),%eax
  800da7:	83 e8 04             	sub    $0x4,%eax
  800daa:	8b 00                	mov    (%eax),%eax
  800dac:	83 ec 08             	sub    $0x8,%esp
  800daf:	ff 75 0c             	pushl  0xc(%ebp)
  800db2:	50                   	push   %eax
  800db3:	8b 45 08             	mov    0x8(%ebp),%eax
  800db6:	ff d0                	call   *%eax
  800db8:	83 c4 10             	add    $0x10,%esp
			break;
  800dbb:	e9 89 02 00 00       	jmp    801049 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800dc0:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc3:	83 c0 04             	add    $0x4,%eax
  800dc6:	89 45 14             	mov    %eax,0x14(%ebp)
  800dc9:	8b 45 14             	mov    0x14(%ebp),%eax
  800dcc:	83 e8 04             	sub    $0x4,%eax
  800dcf:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dd1:	85 db                	test   %ebx,%ebx
  800dd3:	79 02                	jns    800dd7 <vprintfmt+0x14a>
				err = -err;
  800dd5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800dd7:	83 fb 64             	cmp    $0x64,%ebx
  800dda:	7f 0b                	jg     800de7 <vprintfmt+0x15a>
  800ddc:	8b 34 9d 40 2b 80 00 	mov    0x802b40(,%ebx,4),%esi
  800de3:	85 f6                	test   %esi,%esi
  800de5:	75 19                	jne    800e00 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800de7:	53                   	push   %ebx
  800de8:	68 e5 2c 80 00       	push   $0x802ce5
  800ded:	ff 75 0c             	pushl  0xc(%ebp)
  800df0:	ff 75 08             	pushl  0x8(%ebp)
  800df3:	e8 5e 02 00 00       	call   801056 <printfmt>
  800df8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800dfb:	e9 49 02 00 00       	jmp    801049 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e00:	56                   	push   %esi
  800e01:	68 ee 2c 80 00       	push   $0x802cee
  800e06:	ff 75 0c             	pushl  0xc(%ebp)
  800e09:	ff 75 08             	pushl  0x8(%ebp)
  800e0c:	e8 45 02 00 00       	call   801056 <printfmt>
  800e11:	83 c4 10             	add    $0x10,%esp
			break;
  800e14:	e9 30 02 00 00       	jmp    801049 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e19:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1c:	83 c0 04             	add    $0x4,%eax
  800e1f:	89 45 14             	mov    %eax,0x14(%ebp)
  800e22:	8b 45 14             	mov    0x14(%ebp),%eax
  800e25:	83 e8 04             	sub    $0x4,%eax
  800e28:	8b 30                	mov    (%eax),%esi
  800e2a:	85 f6                	test   %esi,%esi
  800e2c:	75 05                	jne    800e33 <vprintfmt+0x1a6>
				p = "(null)";
  800e2e:	be f1 2c 80 00       	mov    $0x802cf1,%esi
			if (width > 0 && padc != '-')
  800e33:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e37:	7e 6d                	jle    800ea6 <vprintfmt+0x219>
  800e39:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e3d:	74 67                	je     800ea6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e3f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e42:	83 ec 08             	sub    $0x8,%esp
  800e45:	50                   	push   %eax
  800e46:	56                   	push   %esi
  800e47:	e8 12 05 00 00       	call   80135e <strnlen>
  800e4c:	83 c4 10             	add    $0x10,%esp
  800e4f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e52:	eb 16                	jmp    800e6a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e54:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e58:	83 ec 08             	sub    $0x8,%esp
  800e5b:	ff 75 0c             	pushl  0xc(%ebp)
  800e5e:	50                   	push   %eax
  800e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e62:	ff d0                	call   *%eax
  800e64:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e67:	ff 4d e4             	decl   -0x1c(%ebp)
  800e6a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e6e:	7f e4                	jg     800e54 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e70:	eb 34                	jmp    800ea6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e72:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e76:	74 1c                	je     800e94 <vprintfmt+0x207>
  800e78:	83 fb 1f             	cmp    $0x1f,%ebx
  800e7b:	7e 05                	jle    800e82 <vprintfmt+0x1f5>
  800e7d:	83 fb 7e             	cmp    $0x7e,%ebx
  800e80:	7e 12                	jle    800e94 <vprintfmt+0x207>
					putch('?', putdat);
  800e82:	83 ec 08             	sub    $0x8,%esp
  800e85:	ff 75 0c             	pushl  0xc(%ebp)
  800e88:	6a 3f                	push   $0x3f
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	ff d0                	call   *%eax
  800e8f:	83 c4 10             	add    $0x10,%esp
  800e92:	eb 0f                	jmp    800ea3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e94:	83 ec 08             	sub    $0x8,%esp
  800e97:	ff 75 0c             	pushl  0xc(%ebp)
  800e9a:	53                   	push   %ebx
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	ff d0                	call   *%eax
  800ea0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ea3:	ff 4d e4             	decl   -0x1c(%ebp)
  800ea6:	89 f0                	mov    %esi,%eax
  800ea8:	8d 70 01             	lea    0x1(%eax),%esi
  800eab:	8a 00                	mov    (%eax),%al
  800ead:	0f be d8             	movsbl %al,%ebx
  800eb0:	85 db                	test   %ebx,%ebx
  800eb2:	74 24                	je     800ed8 <vprintfmt+0x24b>
  800eb4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eb8:	78 b8                	js     800e72 <vprintfmt+0x1e5>
  800eba:	ff 4d e0             	decl   -0x20(%ebp)
  800ebd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ec1:	79 af                	jns    800e72 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ec3:	eb 13                	jmp    800ed8 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ec5:	83 ec 08             	sub    $0x8,%esp
  800ec8:	ff 75 0c             	pushl  0xc(%ebp)
  800ecb:	6a 20                	push   $0x20
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	ff d0                	call   *%eax
  800ed2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ed5:	ff 4d e4             	decl   -0x1c(%ebp)
  800ed8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800edc:	7f e7                	jg     800ec5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ede:	e9 66 01 00 00       	jmp    801049 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ee3:	83 ec 08             	sub    $0x8,%esp
  800ee6:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee9:	8d 45 14             	lea    0x14(%ebp),%eax
  800eec:	50                   	push   %eax
  800eed:	e8 3c fd ff ff       	call   800c2e <getint>
  800ef2:	83 c4 10             	add    $0x10,%esp
  800ef5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800efb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800efe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f01:	85 d2                	test   %edx,%edx
  800f03:	79 23                	jns    800f28 <vprintfmt+0x29b>
				putch('-', putdat);
  800f05:	83 ec 08             	sub    $0x8,%esp
  800f08:	ff 75 0c             	pushl  0xc(%ebp)
  800f0b:	6a 2d                	push   $0x2d
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	ff d0                	call   *%eax
  800f12:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f15:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f18:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1b:	f7 d8                	neg    %eax
  800f1d:	83 d2 00             	adc    $0x0,%edx
  800f20:	f7 da                	neg    %edx
  800f22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f25:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f28:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f2f:	e9 bc 00 00 00       	jmp    800ff0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f34:	83 ec 08             	sub    $0x8,%esp
  800f37:	ff 75 e8             	pushl  -0x18(%ebp)
  800f3a:	8d 45 14             	lea    0x14(%ebp),%eax
  800f3d:	50                   	push   %eax
  800f3e:	e8 84 fc ff ff       	call   800bc7 <getuint>
  800f43:	83 c4 10             	add    $0x10,%esp
  800f46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f49:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f4c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f53:	e9 98 00 00 00       	jmp    800ff0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f58:	83 ec 08             	sub    $0x8,%esp
  800f5b:	ff 75 0c             	pushl  0xc(%ebp)
  800f5e:	6a 58                	push   $0x58
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	ff d0                	call   *%eax
  800f65:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f68:	83 ec 08             	sub    $0x8,%esp
  800f6b:	ff 75 0c             	pushl  0xc(%ebp)
  800f6e:	6a 58                	push   $0x58
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	ff d0                	call   *%eax
  800f75:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f78:	83 ec 08             	sub    $0x8,%esp
  800f7b:	ff 75 0c             	pushl  0xc(%ebp)
  800f7e:	6a 58                	push   $0x58
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	ff d0                	call   *%eax
  800f85:	83 c4 10             	add    $0x10,%esp
			break;
  800f88:	e9 bc 00 00 00       	jmp    801049 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f8d:	83 ec 08             	sub    $0x8,%esp
  800f90:	ff 75 0c             	pushl  0xc(%ebp)
  800f93:	6a 30                	push   $0x30
  800f95:	8b 45 08             	mov    0x8(%ebp),%eax
  800f98:	ff d0                	call   *%eax
  800f9a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f9d:	83 ec 08             	sub    $0x8,%esp
  800fa0:	ff 75 0c             	pushl  0xc(%ebp)
  800fa3:	6a 78                	push   $0x78
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	ff d0                	call   *%eax
  800faa:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fad:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb0:	83 c0 04             	add    $0x4,%eax
  800fb3:	89 45 14             	mov    %eax,0x14(%ebp)
  800fb6:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb9:	83 e8 04             	sub    $0x4,%eax
  800fbc:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fc8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fcf:	eb 1f                	jmp    800ff0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fd1:	83 ec 08             	sub    $0x8,%esp
  800fd4:	ff 75 e8             	pushl  -0x18(%ebp)
  800fd7:	8d 45 14             	lea    0x14(%ebp),%eax
  800fda:	50                   	push   %eax
  800fdb:	e8 e7 fb ff ff       	call   800bc7 <getuint>
  800fe0:	83 c4 10             	add    $0x10,%esp
  800fe3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fe9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ff0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ff4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ff7:	83 ec 04             	sub    $0x4,%esp
  800ffa:	52                   	push   %edx
  800ffb:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ffe:	50                   	push   %eax
  800fff:	ff 75 f4             	pushl  -0xc(%ebp)
  801002:	ff 75 f0             	pushl  -0x10(%ebp)
  801005:	ff 75 0c             	pushl  0xc(%ebp)
  801008:	ff 75 08             	pushl  0x8(%ebp)
  80100b:	e8 00 fb ff ff       	call   800b10 <printnum>
  801010:	83 c4 20             	add    $0x20,%esp
			break;
  801013:	eb 34                	jmp    801049 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801015:	83 ec 08             	sub    $0x8,%esp
  801018:	ff 75 0c             	pushl  0xc(%ebp)
  80101b:	53                   	push   %ebx
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
  80101f:	ff d0                	call   *%eax
  801021:	83 c4 10             	add    $0x10,%esp
			break;
  801024:	eb 23                	jmp    801049 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801026:	83 ec 08             	sub    $0x8,%esp
  801029:	ff 75 0c             	pushl  0xc(%ebp)
  80102c:	6a 25                	push   $0x25
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	ff d0                	call   *%eax
  801033:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801036:	ff 4d 10             	decl   0x10(%ebp)
  801039:	eb 03                	jmp    80103e <vprintfmt+0x3b1>
  80103b:	ff 4d 10             	decl   0x10(%ebp)
  80103e:	8b 45 10             	mov    0x10(%ebp),%eax
  801041:	48                   	dec    %eax
  801042:	8a 00                	mov    (%eax),%al
  801044:	3c 25                	cmp    $0x25,%al
  801046:	75 f3                	jne    80103b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801048:	90                   	nop
		}
	}
  801049:	e9 47 fc ff ff       	jmp    800c95 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80104e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80104f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801052:	5b                   	pop    %ebx
  801053:	5e                   	pop    %esi
  801054:	5d                   	pop    %ebp
  801055:	c3                   	ret    

00801056 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801056:	55                   	push   %ebp
  801057:	89 e5                	mov    %esp,%ebp
  801059:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80105c:	8d 45 10             	lea    0x10(%ebp),%eax
  80105f:	83 c0 04             	add    $0x4,%eax
  801062:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801065:	8b 45 10             	mov    0x10(%ebp),%eax
  801068:	ff 75 f4             	pushl  -0xc(%ebp)
  80106b:	50                   	push   %eax
  80106c:	ff 75 0c             	pushl  0xc(%ebp)
  80106f:	ff 75 08             	pushl  0x8(%ebp)
  801072:	e8 16 fc ff ff       	call   800c8d <vprintfmt>
  801077:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80107a:	90                   	nop
  80107b:	c9                   	leave  
  80107c:	c3                   	ret    

0080107d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801080:	8b 45 0c             	mov    0xc(%ebp),%eax
  801083:	8b 40 08             	mov    0x8(%eax),%eax
  801086:	8d 50 01             	lea    0x1(%eax),%edx
  801089:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80108f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801092:	8b 10                	mov    (%eax),%edx
  801094:	8b 45 0c             	mov    0xc(%ebp),%eax
  801097:	8b 40 04             	mov    0x4(%eax),%eax
  80109a:	39 c2                	cmp    %eax,%edx
  80109c:	73 12                	jae    8010b0 <sprintputch+0x33>
		*b->buf++ = ch;
  80109e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a1:	8b 00                	mov    (%eax),%eax
  8010a3:	8d 48 01             	lea    0x1(%eax),%ecx
  8010a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a9:	89 0a                	mov    %ecx,(%edx)
  8010ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8010ae:	88 10                	mov    %dl,(%eax)
}
  8010b0:	90                   	nop
  8010b1:	5d                   	pop    %ebp
  8010b2:	c3                   	ret    

008010b3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010b3:	55                   	push   %ebp
  8010b4:	89 e5                	mov    %esp,%ebp
  8010b6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c8:	01 d0                	add    %edx,%eax
  8010ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010d8:	74 06                	je     8010e0 <vsnprintf+0x2d>
  8010da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010de:	7f 07                	jg     8010e7 <vsnprintf+0x34>
		return -E_INVAL;
  8010e0:	b8 03 00 00 00       	mov    $0x3,%eax
  8010e5:	eb 20                	jmp    801107 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010e7:	ff 75 14             	pushl  0x14(%ebp)
  8010ea:	ff 75 10             	pushl  0x10(%ebp)
  8010ed:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010f0:	50                   	push   %eax
  8010f1:	68 7d 10 80 00       	push   $0x80107d
  8010f6:	e8 92 fb ff ff       	call   800c8d <vprintfmt>
  8010fb:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801101:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801104:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801107:	c9                   	leave  
  801108:	c3                   	ret    

00801109 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801109:	55                   	push   %ebp
  80110a:	89 e5                	mov    %esp,%ebp
  80110c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80110f:	8d 45 10             	lea    0x10(%ebp),%eax
  801112:	83 c0 04             	add    $0x4,%eax
  801115:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801118:	8b 45 10             	mov    0x10(%ebp),%eax
  80111b:	ff 75 f4             	pushl  -0xc(%ebp)
  80111e:	50                   	push   %eax
  80111f:	ff 75 0c             	pushl  0xc(%ebp)
  801122:	ff 75 08             	pushl  0x8(%ebp)
  801125:	e8 89 ff ff ff       	call   8010b3 <vsnprintf>
  80112a:	83 c4 10             	add    $0x10,%esp
  80112d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801130:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801133:	c9                   	leave  
  801134:	c3                   	ret    

00801135 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801135:	55                   	push   %ebp
  801136:	89 e5                	mov    %esp,%ebp
  801138:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80113b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80113f:	74 13                	je     801154 <readline+0x1f>
		cprintf("%s", prompt);
  801141:	83 ec 08             	sub    $0x8,%esp
  801144:	ff 75 08             	pushl  0x8(%ebp)
  801147:	68 50 2e 80 00       	push   $0x802e50
  80114c:	e8 62 f9 ff ff       	call   800ab3 <cprintf>
  801151:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801154:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80115b:	83 ec 0c             	sub    $0xc,%esp
  80115e:	6a 00                	push   $0x0
  801160:	e8 5d f5 ff ff       	call   8006c2 <iscons>
  801165:	83 c4 10             	add    $0x10,%esp
  801168:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80116b:	e8 04 f5 ff ff       	call   800674 <getchar>
  801170:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801173:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801177:	79 22                	jns    80119b <readline+0x66>
			if (c != -E_EOF)
  801179:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80117d:	0f 84 ad 00 00 00    	je     801230 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801183:	83 ec 08             	sub    $0x8,%esp
  801186:	ff 75 ec             	pushl  -0x14(%ebp)
  801189:	68 53 2e 80 00       	push   $0x802e53
  80118e:	e8 20 f9 ff ff       	call   800ab3 <cprintf>
  801193:	83 c4 10             	add    $0x10,%esp
			return;
  801196:	e9 95 00 00 00       	jmp    801230 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80119b:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80119f:	7e 34                	jle    8011d5 <readline+0xa0>
  8011a1:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011a8:	7f 2b                	jg     8011d5 <readline+0xa0>
			if (echoing)
  8011aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011ae:	74 0e                	je     8011be <readline+0x89>
				cputchar(c);
  8011b0:	83 ec 0c             	sub    $0xc,%esp
  8011b3:	ff 75 ec             	pushl  -0x14(%ebp)
  8011b6:	e8 71 f4 ff ff       	call   80062c <cputchar>
  8011bb:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011c1:	8d 50 01             	lea    0x1(%eax),%edx
  8011c4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011c7:	89 c2                	mov    %eax,%edx
  8011c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cc:	01 d0                	add    %edx,%eax
  8011ce:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011d1:	88 10                	mov    %dl,(%eax)
  8011d3:	eb 56                	jmp    80122b <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8011d5:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011d9:	75 1f                	jne    8011fa <readline+0xc5>
  8011db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011df:	7e 19                	jle    8011fa <readline+0xc5>
			if (echoing)
  8011e1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011e5:	74 0e                	je     8011f5 <readline+0xc0>
				cputchar(c);
  8011e7:	83 ec 0c             	sub    $0xc,%esp
  8011ea:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ed:	e8 3a f4 ff ff       	call   80062c <cputchar>
  8011f2:	83 c4 10             	add    $0x10,%esp

			i--;
  8011f5:	ff 4d f4             	decl   -0xc(%ebp)
  8011f8:	eb 31                	jmp    80122b <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011fa:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011fe:	74 0a                	je     80120a <readline+0xd5>
  801200:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801204:	0f 85 61 ff ff ff    	jne    80116b <readline+0x36>
			if (echoing)
  80120a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80120e:	74 0e                	je     80121e <readline+0xe9>
				cputchar(c);
  801210:	83 ec 0c             	sub    $0xc,%esp
  801213:	ff 75 ec             	pushl  -0x14(%ebp)
  801216:	e8 11 f4 ff ff       	call   80062c <cputchar>
  80121b:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80121e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801221:	8b 45 0c             	mov    0xc(%ebp),%eax
  801224:	01 d0                	add    %edx,%eax
  801226:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801229:	eb 06                	jmp    801231 <readline+0xfc>
		}
	}
  80122b:	e9 3b ff ff ff       	jmp    80116b <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801230:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801231:	c9                   	leave  
  801232:	c3                   	ret    

00801233 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801233:	55                   	push   %ebp
  801234:	89 e5                	mov    %esp,%ebp
  801236:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801239:	e8 73 0e 00 00       	call   8020b1 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80123e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801242:	74 13                	je     801257 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801244:	83 ec 08             	sub    $0x8,%esp
  801247:	ff 75 08             	pushl  0x8(%ebp)
  80124a:	68 50 2e 80 00       	push   $0x802e50
  80124f:	e8 5f f8 ff ff       	call   800ab3 <cprintf>
  801254:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801257:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80125e:	83 ec 0c             	sub    $0xc,%esp
  801261:	6a 00                	push   $0x0
  801263:	e8 5a f4 ff ff       	call   8006c2 <iscons>
  801268:	83 c4 10             	add    $0x10,%esp
  80126b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80126e:	e8 01 f4 ff ff       	call   800674 <getchar>
  801273:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801276:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80127a:	79 23                	jns    80129f <atomic_readline+0x6c>
			if (c != -E_EOF)
  80127c:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801280:	74 13                	je     801295 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801282:	83 ec 08             	sub    $0x8,%esp
  801285:	ff 75 ec             	pushl  -0x14(%ebp)
  801288:	68 53 2e 80 00       	push   $0x802e53
  80128d:	e8 21 f8 ff ff       	call   800ab3 <cprintf>
  801292:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801295:	e8 31 0e 00 00       	call   8020cb <sys_enable_interrupt>
			return;
  80129a:	e9 9a 00 00 00       	jmp    801339 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80129f:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8012a3:	7e 34                	jle    8012d9 <atomic_readline+0xa6>
  8012a5:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8012ac:	7f 2b                	jg     8012d9 <atomic_readline+0xa6>
			if (echoing)
  8012ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012b2:	74 0e                	je     8012c2 <atomic_readline+0x8f>
				cputchar(c);
  8012b4:	83 ec 0c             	sub    $0xc,%esp
  8012b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8012ba:	e8 6d f3 ff ff       	call   80062c <cputchar>
  8012bf:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c5:	8d 50 01             	lea    0x1(%eax),%edx
  8012c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012cb:	89 c2                	mov    %eax,%edx
  8012cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d0:	01 d0                	add    %edx,%eax
  8012d2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012d5:	88 10                	mov    %dl,(%eax)
  8012d7:	eb 5b                	jmp    801334 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8012d9:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012dd:	75 1f                	jne    8012fe <atomic_readline+0xcb>
  8012df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012e3:	7e 19                	jle    8012fe <atomic_readline+0xcb>
			if (echoing)
  8012e5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012e9:	74 0e                	je     8012f9 <atomic_readline+0xc6>
				cputchar(c);
  8012eb:	83 ec 0c             	sub    $0xc,%esp
  8012ee:	ff 75 ec             	pushl  -0x14(%ebp)
  8012f1:	e8 36 f3 ff ff       	call   80062c <cputchar>
  8012f6:	83 c4 10             	add    $0x10,%esp
			i--;
  8012f9:	ff 4d f4             	decl   -0xc(%ebp)
  8012fc:	eb 36                	jmp    801334 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012fe:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801302:	74 0a                	je     80130e <atomic_readline+0xdb>
  801304:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801308:	0f 85 60 ff ff ff    	jne    80126e <atomic_readline+0x3b>
			if (echoing)
  80130e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801312:	74 0e                	je     801322 <atomic_readline+0xef>
				cputchar(c);
  801314:	83 ec 0c             	sub    $0xc,%esp
  801317:	ff 75 ec             	pushl  -0x14(%ebp)
  80131a:	e8 0d f3 ff ff       	call   80062c <cputchar>
  80131f:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801322:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801325:	8b 45 0c             	mov    0xc(%ebp),%eax
  801328:	01 d0                	add    %edx,%eax
  80132a:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80132d:	e8 99 0d 00 00       	call   8020cb <sys_enable_interrupt>
			return;
  801332:	eb 05                	jmp    801339 <atomic_readline+0x106>
		}
	}
  801334:	e9 35 ff ff ff       	jmp    80126e <atomic_readline+0x3b>
}
  801339:	c9                   	leave  
  80133a:	c3                   	ret    

0080133b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80133b:	55                   	push   %ebp
  80133c:	89 e5                	mov    %esp,%ebp
  80133e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801341:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801348:	eb 06                	jmp    801350 <strlen+0x15>
		n++;
  80134a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80134d:	ff 45 08             	incl   0x8(%ebp)
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	8a 00                	mov    (%eax),%al
  801355:	84 c0                	test   %al,%al
  801357:	75 f1                	jne    80134a <strlen+0xf>
		n++;
	return n;
  801359:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80135c:	c9                   	leave  
  80135d:	c3                   	ret    

0080135e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80135e:	55                   	push   %ebp
  80135f:	89 e5                	mov    %esp,%ebp
  801361:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801364:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80136b:	eb 09                	jmp    801376 <strnlen+0x18>
		n++;
  80136d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801370:	ff 45 08             	incl   0x8(%ebp)
  801373:	ff 4d 0c             	decl   0xc(%ebp)
  801376:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80137a:	74 09                	je     801385 <strnlen+0x27>
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	84 c0                	test   %al,%al
  801383:	75 e8                	jne    80136d <strnlen+0xf>
		n++;
	return n;
  801385:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801388:	c9                   	leave  
  801389:	c3                   	ret    

0080138a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80138a:	55                   	push   %ebp
  80138b:	89 e5                	mov    %esp,%ebp
  80138d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801396:	90                   	nop
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	8d 50 01             	lea    0x1(%eax),%edx
  80139d:	89 55 08             	mov    %edx,0x8(%ebp)
  8013a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013a6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013a9:	8a 12                	mov    (%edx),%dl
  8013ab:	88 10                	mov    %dl,(%eax)
  8013ad:	8a 00                	mov    (%eax),%al
  8013af:	84 c0                	test   %al,%al
  8013b1:	75 e4                	jne    801397 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013b6:	c9                   	leave  
  8013b7:	c3                   	ret    

008013b8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013b8:	55                   	push   %ebp
  8013b9:	89 e5                	mov    %esp,%ebp
  8013bb:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013cb:	eb 1f                	jmp    8013ec <strncpy+0x34>
		*dst++ = *src;
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	8d 50 01             	lea    0x1(%eax),%edx
  8013d3:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d9:	8a 12                	mov    (%edx),%dl
  8013db:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e0:	8a 00                	mov    (%eax),%al
  8013e2:	84 c0                	test   %al,%al
  8013e4:	74 03                	je     8013e9 <strncpy+0x31>
			src++;
  8013e6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013e9:	ff 45 fc             	incl   -0x4(%ebp)
  8013ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ef:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013f2:	72 d9                	jb     8013cd <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013f7:	c9                   	leave  
  8013f8:	c3                   	ret    

008013f9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013f9:	55                   	push   %ebp
  8013fa:	89 e5                	mov    %esp,%ebp
  8013fc:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801405:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801409:	74 30                	je     80143b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80140b:	eb 16                	jmp    801423 <strlcpy+0x2a>
			*dst++ = *src++;
  80140d:	8b 45 08             	mov    0x8(%ebp),%eax
  801410:	8d 50 01             	lea    0x1(%eax),%edx
  801413:	89 55 08             	mov    %edx,0x8(%ebp)
  801416:	8b 55 0c             	mov    0xc(%ebp),%edx
  801419:	8d 4a 01             	lea    0x1(%edx),%ecx
  80141c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80141f:	8a 12                	mov    (%edx),%dl
  801421:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801423:	ff 4d 10             	decl   0x10(%ebp)
  801426:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80142a:	74 09                	je     801435 <strlcpy+0x3c>
  80142c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142f:	8a 00                	mov    (%eax),%al
  801431:	84 c0                	test   %al,%al
  801433:	75 d8                	jne    80140d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80143b:	8b 55 08             	mov    0x8(%ebp),%edx
  80143e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801441:	29 c2                	sub    %eax,%edx
  801443:	89 d0                	mov    %edx,%eax
}
  801445:	c9                   	leave  
  801446:	c3                   	ret    

00801447 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801447:	55                   	push   %ebp
  801448:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80144a:	eb 06                	jmp    801452 <strcmp+0xb>
		p++, q++;
  80144c:	ff 45 08             	incl   0x8(%ebp)
  80144f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
  801455:	8a 00                	mov    (%eax),%al
  801457:	84 c0                	test   %al,%al
  801459:	74 0e                	je     801469 <strcmp+0x22>
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
  80145e:	8a 10                	mov    (%eax),%dl
  801460:	8b 45 0c             	mov    0xc(%ebp),%eax
  801463:	8a 00                	mov    (%eax),%al
  801465:	38 c2                	cmp    %al,%dl
  801467:	74 e3                	je     80144c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801469:	8b 45 08             	mov    0x8(%ebp),%eax
  80146c:	8a 00                	mov    (%eax),%al
  80146e:	0f b6 d0             	movzbl %al,%edx
  801471:	8b 45 0c             	mov    0xc(%ebp),%eax
  801474:	8a 00                	mov    (%eax),%al
  801476:	0f b6 c0             	movzbl %al,%eax
  801479:	29 c2                	sub    %eax,%edx
  80147b:	89 d0                	mov    %edx,%eax
}
  80147d:	5d                   	pop    %ebp
  80147e:	c3                   	ret    

0080147f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80147f:	55                   	push   %ebp
  801480:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801482:	eb 09                	jmp    80148d <strncmp+0xe>
		n--, p++, q++;
  801484:	ff 4d 10             	decl   0x10(%ebp)
  801487:	ff 45 08             	incl   0x8(%ebp)
  80148a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80148d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801491:	74 17                	je     8014aa <strncmp+0x2b>
  801493:	8b 45 08             	mov    0x8(%ebp),%eax
  801496:	8a 00                	mov    (%eax),%al
  801498:	84 c0                	test   %al,%al
  80149a:	74 0e                	je     8014aa <strncmp+0x2b>
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	8a 10                	mov    (%eax),%dl
  8014a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a4:	8a 00                	mov    (%eax),%al
  8014a6:	38 c2                	cmp    %al,%dl
  8014a8:	74 da                	je     801484 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ae:	75 07                	jne    8014b7 <strncmp+0x38>
		return 0;
  8014b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8014b5:	eb 14                	jmp    8014cb <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ba:	8a 00                	mov    (%eax),%al
  8014bc:	0f b6 d0             	movzbl %al,%edx
  8014bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c2:	8a 00                	mov    (%eax),%al
  8014c4:	0f b6 c0             	movzbl %al,%eax
  8014c7:	29 c2                	sub    %eax,%edx
  8014c9:	89 d0                	mov    %edx,%eax
}
  8014cb:	5d                   	pop    %ebp
  8014cc:	c3                   	ret    

008014cd <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
  8014d0:	83 ec 04             	sub    $0x4,%esp
  8014d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014d9:	eb 12                	jmp    8014ed <strchr+0x20>
		if (*s == c)
  8014db:	8b 45 08             	mov    0x8(%ebp),%eax
  8014de:	8a 00                	mov    (%eax),%al
  8014e0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014e3:	75 05                	jne    8014ea <strchr+0x1d>
			return (char *) s;
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	eb 11                	jmp    8014fb <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014ea:	ff 45 08             	incl   0x8(%ebp)
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f0:	8a 00                	mov    (%eax),%al
  8014f2:	84 c0                	test   %al,%al
  8014f4:	75 e5                	jne    8014db <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014f6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014fb:	c9                   	leave  
  8014fc:	c3                   	ret    

008014fd <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014fd:	55                   	push   %ebp
  8014fe:	89 e5                	mov    %esp,%ebp
  801500:	83 ec 04             	sub    $0x4,%esp
  801503:	8b 45 0c             	mov    0xc(%ebp),%eax
  801506:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801509:	eb 0d                	jmp    801518 <strfind+0x1b>
		if (*s == c)
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	8a 00                	mov    (%eax),%al
  801510:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801513:	74 0e                	je     801523 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801515:	ff 45 08             	incl   0x8(%ebp)
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
  80151b:	8a 00                	mov    (%eax),%al
  80151d:	84 c0                	test   %al,%al
  80151f:	75 ea                	jne    80150b <strfind+0xe>
  801521:	eb 01                	jmp    801524 <strfind+0x27>
		if (*s == c)
			break;
  801523:	90                   	nop
	return (char *) s;
  801524:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
  80152c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801535:	8b 45 10             	mov    0x10(%ebp),%eax
  801538:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80153b:	eb 0e                	jmp    80154b <memset+0x22>
		*p++ = c;
  80153d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801540:	8d 50 01             	lea    0x1(%eax),%edx
  801543:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801546:	8b 55 0c             	mov    0xc(%ebp),%edx
  801549:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80154b:	ff 4d f8             	decl   -0x8(%ebp)
  80154e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801552:	79 e9                	jns    80153d <memset+0x14>
		*p++ = c;

	return v;
  801554:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801557:	c9                   	leave  
  801558:	c3                   	ret    

00801559 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801559:	55                   	push   %ebp
  80155a:	89 e5                	mov    %esp,%ebp
  80155c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80155f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801562:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801565:	8b 45 08             	mov    0x8(%ebp),%eax
  801568:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80156b:	eb 16                	jmp    801583 <memcpy+0x2a>
		*d++ = *s++;
  80156d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801570:	8d 50 01             	lea    0x1(%eax),%edx
  801573:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801576:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801579:	8d 4a 01             	lea    0x1(%edx),%ecx
  80157c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80157f:	8a 12                	mov    (%edx),%dl
  801581:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801583:	8b 45 10             	mov    0x10(%ebp),%eax
  801586:	8d 50 ff             	lea    -0x1(%eax),%edx
  801589:	89 55 10             	mov    %edx,0x10(%ebp)
  80158c:	85 c0                	test   %eax,%eax
  80158e:	75 dd                	jne    80156d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801590:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801593:	c9                   	leave  
  801594:	c3                   	ret    

00801595 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801595:	55                   	push   %ebp
  801596:	89 e5                	mov    %esp,%ebp
  801598:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80159b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8015a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015ad:	73 50                	jae    8015ff <memmove+0x6a>
  8015af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b5:	01 d0                	add    %edx,%eax
  8015b7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015ba:	76 43                	jbe    8015ff <memmove+0x6a>
		s += n;
  8015bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bf:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015c8:	eb 10                	jmp    8015da <memmove+0x45>
			*--d = *--s;
  8015ca:	ff 4d f8             	decl   -0x8(%ebp)
  8015cd:	ff 4d fc             	decl   -0x4(%ebp)
  8015d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d3:	8a 10                	mov    (%eax),%dl
  8015d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015da:	8b 45 10             	mov    0x10(%ebp),%eax
  8015dd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015e0:	89 55 10             	mov    %edx,0x10(%ebp)
  8015e3:	85 c0                	test   %eax,%eax
  8015e5:	75 e3                	jne    8015ca <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015e7:	eb 23                	jmp    80160c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ec:	8d 50 01             	lea    0x1(%eax),%edx
  8015ef:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015f8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015fb:	8a 12                	mov    (%edx),%dl
  8015fd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801602:	8d 50 ff             	lea    -0x1(%eax),%edx
  801605:	89 55 10             	mov    %edx,0x10(%ebp)
  801608:	85 c0                	test   %eax,%eax
  80160a:	75 dd                	jne    8015e9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80160f:	c9                   	leave  
  801610:	c3                   	ret    

00801611 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
  801614:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80161d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801620:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801623:	eb 2a                	jmp    80164f <memcmp+0x3e>
		if (*s1 != *s2)
  801625:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801628:	8a 10                	mov    (%eax),%dl
  80162a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80162d:	8a 00                	mov    (%eax),%al
  80162f:	38 c2                	cmp    %al,%dl
  801631:	74 16                	je     801649 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801633:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801636:	8a 00                	mov    (%eax),%al
  801638:	0f b6 d0             	movzbl %al,%edx
  80163b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80163e:	8a 00                	mov    (%eax),%al
  801640:	0f b6 c0             	movzbl %al,%eax
  801643:	29 c2                	sub    %eax,%edx
  801645:	89 d0                	mov    %edx,%eax
  801647:	eb 18                	jmp    801661 <memcmp+0x50>
		s1++, s2++;
  801649:	ff 45 fc             	incl   -0x4(%ebp)
  80164c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80164f:	8b 45 10             	mov    0x10(%ebp),%eax
  801652:	8d 50 ff             	lea    -0x1(%eax),%edx
  801655:	89 55 10             	mov    %edx,0x10(%ebp)
  801658:	85 c0                	test   %eax,%eax
  80165a:	75 c9                	jne    801625 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80165c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801661:	c9                   	leave  
  801662:	c3                   	ret    

00801663 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
  801666:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801669:	8b 55 08             	mov    0x8(%ebp),%edx
  80166c:	8b 45 10             	mov    0x10(%ebp),%eax
  80166f:	01 d0                	add    %edx,%eax
  801671:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801674:	eb 15                	jmp    80168b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	8a 00                	mov    (%eax),%al
  80167b:	0f b6 d0             	movzbl %al,%edx
  80167e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801681:	0f b6 c0             	movzbl %al,%eax
  801684:	39 c2                	cmp    %eax,%edx
  801686:	74 0d                	je     801695 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801688:	ff 45 08             	incl   0x8(%ebp)
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801691:	72 e3                	jb     801676 <memfind+0x13>
  801693:	eb 01                	jmp    801696 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801695:	90                   	nop
	return (void *) s;
  801696:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
  80169e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8016a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016af:	eb 03                	jmp    8016b4 <strtol+0x19>
		s++;
  8016b1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	8a 00                	mov    (%eax),%al
  8016b9:	3c 20                	cmp    $0x20,%al
  8016bb:	74 f4                	je     8016b1 <strtol+0x16>
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	8a 00                	mov    (%eax),%al
  8016c2:	3c 09                	cmp    $0x9,%al
  8016c4:	74 eb                	je     8016b1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c9:	8a 00                	mov    (%eax),%al
  8016cb:	3c 2b                	cmp    $0x2b,%al
  8016cd:	75 05                	jne    8016d4 <strtol+0x39>
		s++;
  8016cf:	ff 45 08             	incl   0x8(%ebp)
  8016d2:	eb 13                	jmp    8016e7 <strtol+0x4c>
	else if (*s == '-')
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	8a 00                	mov    (%eax),%al
  8016d9:	3c 2d                	cmp    $0x2d,%al
  8016db:	75 0a                	jne    8016e7 <strtol+0x4c>
		s++, neg = 1;
  8016dd:	ff 45 08             	incl   0x8(%ebp)
  8016e0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016eb:	74 06                	je     8016f3 <strtol+0x58>
  8016ed:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016f1:	75 20                	jne    801713 <strtol+0x78>
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	8a 00                	mov    (%eax),%al
  8016f8:	3c 30                	cmp    $0x30,%al
  8016fa:	75 17                	jne    801713 <strtol+0x78>
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	40                   	inc    %eax
  801700:	8a 00                	mov    (%eax),%al
  801702:	3c 78                	cmp    $0x78,%al
  801704:	75 0d                	jne    801713 <strtol+0x78>
		s += 2, base = 16;
  801706:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80170a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801711:	eb 28                	jmp    80173b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801713:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801717:	75 15                	jne    80172e <strtol+0x93>
  801719:	8b 45 08             	mov    0x8(%ebp),%eax
  80171c:	8a 00                	mov    (%eax),%al
  80171e:	3c 30                	cmp    $0x30,%al
  801720:	75 0c                	jne    80172e <strtol+0x93>
		s++, base = 8;
  801722:	ff 45 08             	incl   0x8(%ebp)
  801725:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80172c:	eb 0d                	jmp    80173b <strtol+0xa0>
	else if (base == 0)
  80172e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801732:	75 07                	jne    80173b <strtol+0xa0>
		base = 10;
  801734:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80173b:	8b 45 08             	mov    0x8(%ebp),%eax
  80173e:	8a 00                	mov    (%eax),%al
  801740:	3c 2f                	cmp    $0x2f,%al
  801742:	7e 19                	jle    80175d <strtol+0xc2>
  801744:	8b 45 08             	mov    0x8(%ebp),%eax
  801747:	8a 00                	mov    (%eax),%al
  801749:	3c 39                	cmp    $0x39,%al
  80174b:	7f 10                	jg     80175d <strtol+0xc2>
			dig = *s - '0';
  80174d:	8b 45 08             	mov    0x8(%ebp),%eax
  801750:	8a 00                	mov    (%eax),%al
  801752:	0f be c0             	movsbl %al,%eax
  801755:	83 e8 30             	sub    $0x30,%eax
  801758:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80175b:	eb 42                	jmp    80179f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80175d:	8b 45 08             	mov    0x8(%ebp),%eax
  801760:	8a 00                	mov    (%eax),%al
  801762:	3c 60                	cmp    $0x60,%al
  801764:	7e 19                	jle    80177f <strtol+0xe4>
  801766:	8b 45 08             	mov    0x8(%ebp),%eax
  801769:	8a 00                	mov    (%eax),%al
  80176b:	3c 7a                	cmp    $0x7a,%al
  80176d:	7f 10                	jg     80177f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80176f:	8b 45 08             	mov    0x8(%ebp),%eax
  801772:	8a 00                	mov    (%eax),%al
  801774:	0f be c0             	movsbl %al,%eax
  801777:	83 e8 57             	sub    $0x57,%eax
  80177a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80177d:	eb 20                	jmp    80179f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
  801782:	8a 00                	mov    (%eax),%al
  801784:	3c 40                	cmp    $0x40,%al
  801786:	7e 39                	jle    8017c1 <strtol+0x126>
  801788:	8b 45 08             	mov    0x8(%ebp),%eax
  80178b:	8a 00                	mov    (%eax),%al
  80178d:	3c 5a                	cmp    $0x5a,%al
  80178f:	7f 30                	jg     8017c1 <strtol+0x126>
			dig = *s - 'A' + 10;
  801791:	8b 45 08             	mov    0x8(%ebp),%eax
  801794:	8a 00                	mov    (%eax),%al
  801796:	0f be c0             	movsbl %al,%eax
  801799:	83 e8 37             	sub    $0x37,%eax
  80179c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80179f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017a2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8017a5:	7d 19                	jge    8017c0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8017a7:	ff 45 08             	incl   0x8(%ebp)
  8017aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ad:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017b1:	89 c2                	mov    %eax,%edx
  8017b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017b6:	01 d0                	add    %edx,%eax
  8017b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017bb:	e9 7b ff ff ff       	jmp    80173b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017c0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017c5:	74 08                	je     8017cf <strtol+0x134>
		*endptr = (char *) s;
  8017c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8017cd:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017d3:	74 07                	je     8017dc <strtol+0x141>
  8017d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d8:	f7 d8                	neg    %eax
  8017da:	eb 03                	jmp    8017df <strtol+0x144>
  8017dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <ltostr>:

void
ltostr(long value, char *str)
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
  8017e4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017f9:	79 13                	jns    80180e <ltostr+0x2d>
	{
		neg = 1;
  8017fb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801802:	8b 45 0c             	mov    0xc(%ebp),%eax
  801805:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801808:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80180b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80180e:	8b 45 08             	mov    0x8(%ebp),%eax
  801811:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801816:	99                   	cltd   
  801817:	f7 f9                	idiv   %ecx
  801819:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80181c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80181f:	8d 50 01             	lea    0x1(%eax),%edx
  801822:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801825:	89 c2                	mov    %eax,%edx
  801827:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182a:	01 d0                	add    %edx,%eax
  80182c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80182f:	83 c2 30             	add    $0x30,%edx
  801832:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801834:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801837:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80183c:	f7 e9                	imul   %ecx
  80183e:	c1 fa 02             	sar    $0x2,%edx
  801841:	89 c8                	mov    %ecx,%eax
  801843:	c1 f8 1f             	sar    $0x1f,%eax
  801846:	29 c2                	sub    %eax,%edx
  801848:	89 d0                	mov    %edx,%eax
  80184a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80184d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801850:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801855:	f7 e9                	imul   %ecx
  801857:	c1 fa 02             	sar    $0x2,%edx
  80185a:	89 c8                	mov    %ecx,%eax
  80185c:	c1 f8 1f             	sar    $0x1f,%eax
  80185f:	29 c2                	sub    %eax,%edx
  801861:	89 d0                	mov    %edx,%eax
  801863:	c1 e0 02             	shl    $0x2,%eax
  801866:	01 d0                	add    %edx,%eax
  801868:	01 c0                	add    %eax,%eax
  80186a:	29 c1                	sub    %eax,%ecx
  80186c:	89 ca                	mov    %ecx,%edx
  80186e:	85 d2                	test   %edx,%edx
  801870:	75 9c                	jne    80180e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801872:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801879:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187c:	48                   	dec    %eax
  80187d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801880:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801884:	74 3d                	je     8018c3 <ltostr+0xe2>
		start = 1 ;
  801886:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80188d:	eb 34                	jmp    8018c3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80188f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801892:	8b 45 0c             	mov    0xc(%ebp),%eax
  801895:	01 d0                	add    %edx,%eax
  801897:	8a 00                	mov    (%eax),%al
  801899:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80189c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80189f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a2:	01 c2                	add    %eax,%edx
  8018a4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8018a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018aa:	01 c8                	add    %ecx,%eax
  8018ac:	8a 00                	mov    (%eax),%al
  8018ae:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018b0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b6:	01 c2                	add    %eax,%edx
  8018b8:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018bb:	88 02                	mov    %al,(%edx)
		start++ ;
  8018bd:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018c0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018c9:	7c c4                	jl     80188f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018cb:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d1:	01 d0                	add    %edx,%eax
  8018d3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018d6:	90                   	nop
  8018d7:	c9                   	leave  
  8018d8:	c3                   	ret    

008018d9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018d9:	55                   	push   %ebp
  8018da:	89 e5                	mov    %esp,%ebp
  8018dc:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018df:	ff 75 08             	pushl  0x8(%ebp)
  8018e2:	e8 54 fa ff ff       	call   80133b <strlen>
  8018e7:	83 c4 04             	add    $0x4,%esp
  8018ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018ed:	ff 75 0c             	pushl  0xc(%ebp)
  8018f0:	e8 46 fa ff ff       	call   80133b <strlen>
  8018f5:	83 c4 04             	add    $0x4,%esp
  8018f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801902:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801909:	eb 17                	jmp    801922 <strcconcat+0x49>
		final[s] = str1[s] ;
  80190b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80190e:	8b 45 10             	mov    0x10(%ebp),%eax
  801911:	01 c2                	add    %eax,%edx
  801913:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801916:	8b 45 08             	mov    0x8(%ebp),%eax
  801919:	01 c8                	add    %ecx,%eax
  80191b:	8a 00                	mov    (%eax),%al
  80191d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80191f:	ff 45 fc             	incl   -0x4(%ebp)
  801922:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801925:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801928:	7c e1                	jl     80190b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80192a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801931:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801938:	eb 1f                	jmp    801959 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80193a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80193d:	8d 50 01             	lea    0x1(%eax),%edx
  801940:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801943:	89 c2                	mov    %eax,%edx
  801945:	8b 45 10             	mov    0x10(%ebp),%eax
  801948:	01 c2                	add    %eax,%edx
  80194a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80194d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801950:	01 c8                	add    %ecx,%eax
  801952:	8a 00                	mov    (%eax),%al
  801954:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801956:	ff 45 f8             	incl   -0x8(%ebp)
  801959:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80195f:	7c d9                	jl     80193a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801961:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801964:	8b 45 10             	mov    0x10(%ebp),%eax
  801967:	01 d0                	add    %edx,%eax
  801969:	c6 00 00             	movb   $0x0,(%eax)
}
  80196c:	90                   	nop
  80196d:	c9                   	leave  
  80196e:	c3                   	ret    

0080196f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801972:	8b 45 14             	mov    0x14(%ebp),%eax
  801975:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80197b:	8b 45 14             	mov    0x14(%ebp),%eax
  80197e:	8b 00                	mov    (%eax),%eax
  801980:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801987:	8b 45 10             	mov    0x10(%ebp),%eax
  80198a:	01 d0                	add    %edx,%eax
  80198c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801992:	eb 0c                	jmp    8019a0 <strsplit+0x31>
			*string++ = 0;
  801994:	8b 45 08             	mov    0x8(%ebp),%eax
  801997:	8d 50 01             	lea    0x1(%eax),%edx
  80199a:	89 55 08             	mov    %edx,0x8(%ebp)
  80199d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a3:	8a 00                	mov    (%eax),%al
  8019a5:	84 c0                	test   %al,%al
  8019a7:	74 18                	je     8019c1 <strsplit+0x52>
  8019a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ac:	8a 00                	mov    (%eax),%al
  8019ae:	0f be c0             	movsbl %al,%eax
  8019b1:	50                   	push   %eax
  8019b2:	ff 75 0c             	pushl  0xc(%ebp)
  8019b5:	e8 13 fb ff ff       	call   8014cd <strchr>
  8019ba:	83 c4 08             	add    $0x8,%esp
  8019bd:	85 c0                	test   %eax,%eax
  8019bf:	75 d3                	jne    801994 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	8a 00                	mov    (%eax),%al
  8019c6:	84 c0                	test   %al,%al
  8019c8:	74 5a                	je     801a24 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8019ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8019cd:	8b 00                	mov    (%eax),%eax
  8019cf:	83 f8 0f             	cmp    $0xf,%eax
  8019d2:	75 07                	jne    8019db <strsplit+0x6c>
		{
			return 0;
  8019d4:	b8 00 00 00 00       	mov    $0x0,%eax
  8019d9:	eb 66                	jmp    801a41 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019db:	8b 45 14             	mov    0x14(%ebp),%eax
  8019de:	8b 00                	mov    (%eax),%eax
  8019e0:	8d 48 01             	lea    0x1(%eax),%ecx
  8019e3:	8b 55 14             	mov    0x14(%ebp),%edx
  8019e6:	89 0a                	mov    %ecx,(%edx)
  8019e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f2:	01 c2                	add    %eax,%edx
  8019f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019f9:	eb 03                	jmp    8019fe <strsplit+0x8f>
			string++;
  8019fb:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801a01:	8a 00                	mov    (%eax),%al
  801a03:	84 c0                	test   %al,%al
  801a05:	74 8b                	je     801992 <strsplit+0x23>
  801a07:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0a:	8a 00                	mov    (%eax),%al
  801a0c:	0f be c0             	movsbl %al,%eax
  801a0f:	50                   	push   %eax
  801a10:	ff 75 0c             	pushl  0xc(%ebp)
  801a13:	e8 b5 fa ff ff       	call   8014cd <strchr>
  801a18:	83 c4 08             	add    $0x8,%esp
  801a1b:	85 c0                	test   %eax,%eax
  801a1d:	74 dc                	je     8019fb <strsplit+0x8c>
			string++;
	}
  801a1f:	e9 6e ff ff ff       	jmp    801992 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a24:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a25:	8b 45 14             	mov    0x14(%ebp),%eax
  801a28:	8b 00                	mov    (%eax),%eax
  801a2a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a31:	8b 45 10             	mov    0x10(%ebp),%eax
  801a34:	01 d0                	add    %edx,%eax
  801a36:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a3c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a41:	c9                   	leave  
  801a42:	c3                   	ret    

00801a43 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801a43:	55                   	push   %ebp
  801a44:	89 e5                	mov    %esp,%ebp
  801a46:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801a49:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801a50:	76 0a                	jbe    801a5c <malloc+0x19>
		return NULL;
  801a52:	b8 00 00 00 00       	mov    $0x0,%eax
  801a57:	e9 ad 02 00 00       	jmp    801d09 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5f:	c1 e8 0c             	shr    $0xc,%eax
  801a62:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801a65:	8b 45 08             	mov    0x8(%ebp),%eax
  801a68:	25 ff 0f 00 00       	and    $0xfff,%eax
  801a6d:	85 c0                	test   %eax,%eax
  801a6f:	74 03                	je     801a74 <malloc+0x31>
		num++;
  801a71:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801a74:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a79:	85 c0                	test   %eax,%eax
  801a7b:	75 71                	jne    801aee <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801a7d:	a1 04 30 80 00       	mov    0x803004,%eax
  801a82:	83 ec 08             	sub    $0x8,%esp
  801a85:	ff 75 08             	pushl  0x8(%ebp)
  801a88:	50                   	push   %eax
  801a89:	e8 ba 05 00 00       	call   802048 <sys_allocateMem>
  801a8e:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801a91:	a1 04 30 80 00       	mov    0x803004,%eax
  801a96:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  801a99:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a9c:	c1 e0 0c             	shl    $0xc,%eax
  801a9f:	89 c2                	mov    %eax,%edx
  801aa1:	a1 04 30 80 00       	mov    0x803004,%eax
  801aa6:	01 d0                	add    %edx,%eax
  801aa8:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801aad:	a1 30 30 80 00       	mov    0x803030,%eax
  801ab2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ab5:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801abc:	a1 30 30 80 00       	mov    0x803030,%eax
  801ac1:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801ac4:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  801acb:	a1 30 30 80 00       	mov    0x803030,%eax
  801ad0:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801ad7:	01 00 00 00 
		sizeofarray++;
  801adb:	a1 30 30 80 00       	mov    0x803030,%eax
  801ae0:	40                   	inc    %eax
  801ae1:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) return_addres;
  801ae6:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801ae9:	e9 1b 02 00 00       	jmp    801d09 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801aee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801af5:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801afc:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801b03:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801b0a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801b11:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801b18:	eb 72                	jmp    801b8c <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801b1a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801b1d:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801b24:	85 c0                	test   %eax,%eax
  801b26:	75 12                	jne    801b3a <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801b28:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801b2b:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801b32:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801b35:	ff 45 dc             	incl   -0x24(%ebp)
  801b38:	eb 4f                	jmp    801b89 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801b3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b3d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801b40:	7d 39                	jge    801b7b <malloc+0x138>
  801b42:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b45:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b48:	7c 31                	jl     801b7b <malloc+0x138>
					{
						min=count;
  801b4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b4d:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801b50:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801b53:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801b5a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b5d:	c1 e2 0c             	shl    $0xc,%edx
  801b60:	29 d0                	sub    %edx,%eax
  801b62:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801b65:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801b68:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801b6b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801b6e:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801b75:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801b78:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801b7b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801b82:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801b89:	ff 45 d4             	incl   -0x2c(%ebp)
  801b8c:	a1 30 30 80 00       	mov    0x803030,%eax
  801b91:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801b94:	7c 84                	jl     801b1a <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801b96:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801b9a:	0f 85 e3 00 00 00    	jne    801c83 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801ba0:	83 ec 08             	sub    $0x8,%esp
  801ba3:	ff 75 08             	pushl  0x8(%ebp)
  801ba6:	ff 75 e0             	pushl  -0x20(%ebp)
  801ba9:	e8 9a 04 00 00       	call   802048 <sys_allocateMem>
  801bae:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801bb1:	a1 30 30 80 00       	mov    0x803030,%eax
  801bb6:	40                   	inc    %eax
  801bb7:	a3 30 30 80 00       	mov    %eax,0x803030
				for(int i=sizeofarray-1;i>index;i--)
  801bbc:	a1 30 30 80 00       	mov    0x803030,%eax
  801bc1:	48                   	dec    %eax
  801bc2:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801bc5:	eb 42                	jmp    801c09 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801bc7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801bca:	48                   	dec    %eax
  801bcb:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801bd2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801bd5:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801bdc:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801bdf:	48                   	dec    %eax
  801be0:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801be7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801bea:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801bf1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801bf4:	48                   	dec    %eax
  801bf5:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801bfc:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801bff:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801c06:	ff 4d d0             	decl   -0x30(%ebp)
  801c09:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801c0c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801c0f:	7f b6                	jg     801bc7 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801c11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c14:	40                   	inc    %eax
  801c15:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801c18:	8b 55 08             	mov    0x8(%ebp),%edx
  801c1b:	01 ca                	add    %ecx,%edx
  801c1d:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801c24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c27:	8d 50 01             	lea    0x1(%eax),%edx
  801c2a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c2d:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801c34:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801c37:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801c3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c41:	40                   	inc    %eax
  801c42:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801c49:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801c4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c50:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c53:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801c5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c5d:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801c60:	eb 11                	jmp    801c73 <malloc+0x230>
				{
					changed[index] = 1;
  801c62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c65:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801c6c:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801c70:	ff 45 cc             	incl   -0x34(%ebp)
  801c73:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801c76:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c79:	7c e7                	jl     801c62 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801c7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c7e:	e9 86 00 00 00       	jmp    801d09 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801c83:	a1 04 30 80 00       	mov    0x803004,%eax
  801c88:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801c8d:	29 c2                	sub    %eax,%edx
  801c8f:	89 d0                	mov    %edx,%eax
  801c91:	3b 45 08             	cmp    0x8(%ebp),%eax
  801c94:	73 07                	jae    801c9d <malloc+0x25a>
						return NULL;
  801c96:	b8 00 00 00 00       	mov    $0x0,%eax
  801c9b:	eb 6c                	jmp    801d09 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801c9d:	a1 04 30 80 00       	mov    0x803004,%eax
  801ca2:	83 ec 08             	sub    $0x8,%esp
  801ca5:	ff 75 08             	pushl  0x8(%ebp)
  801ca8:	50                   	push   %eax
  801ca9:	e8 9a 03 00 00       	call   802048 <sys_allocateMem>
  801cae:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801cb1:	a1 04 30 80 00       	mov    0x803004,%eax
  801cb6:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801cb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cbc:	c1 e0 0c             	shl    $0xc,%eax
  801cbf:	89 c2                	mov    %eax,%edx
  801cc1:	a1 04 30 80 00       	mov    0x803004,%eax
  801cc6:	01 d0                	add    %edx,%eax
  801cc8:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801ccd:	a1 30 30 80 00       	mov    0x803030,%eax
  801cd2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801cd5:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801cdc:	a1 30 30 80 00       	mov    0x803030,%eax
  801ce1:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801ce4:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801ceb:	a1 30 30 80 00       	mov    0x803030,%eax
  801cf0:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801cf7:	01 00 00 00 
					sizeofarray++;
  801cfb:	a1 30 30 80 00       	mov    0x803030,%eax
  801d00:	40                   	inc    %eax
  801d01:	a3 30 30 80 00       	mov    %eax,0x803030
					return (void*) return_addres;
  801d06:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801d09:	c9                   	leave  
  801d0a:	c3                   	ret    

00801d0b <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801d0b:	55                   	push   %ebp
  801d0c:	89 e5                	mov    %esp,%ebp
  801d0e:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801d11:	8b 45 08             	mov    0x8(%ebp),%eax
  801d14:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801d17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801d1e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801d25:	eb 30                	jmp    801d57 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801d27:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d2a:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801d31:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801d34:	75 1e                	jne    801d54 <free+0x49>
  801d36:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d39:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801d40:	83 f8 01             	cmp    $0x1,%eax
  801d43:	75 0f                	jne    801d54 <free+0x49>
			is_found = 1;
  801d45:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801d4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801d52:	eb 0d                	jmp    801d61 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801d54:	ff 45 ec             	incl   -0x14(%ebp)
  801d57:	a1 30 30 80 00       	mov    0x803030,%eax
  801d5c:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801d5f:	7c c6                	jl     801d27 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801d61:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801d65:	75 3a                	jne    801da1 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801d67:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d6a:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801d71:	c1 e0 0c             	shl    $0xc,%eax
  801d74:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801d77:	83 ec 08             	sub    $0x8,%esp
  801d7a:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d7d:	ff 75 e8             	pushl  -0x18(%ebp)
  801d80:	e8 a7 02 00 00       	call   80202c <sys_freeMem>
  801d85:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801d88:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d8b:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801d92:	00 00 00 00 
		changes++;
  801d96:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801d9b:	40                   	inc    %eax
  801d9c:	a3 2c 30 80 00       	mov    %eax,0x80302c
	}
	//refer to the project presentation and documentation for details
}
  801da1:	90                   	nop
  801da2:	c9                   	leave  
  801da3:	c3                   	ret    

00801da4 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801da4:	55                   	push   %ebp
  801da5:	89 e5                	mov    %esp,%ebp
  801da7:	83 ec 18             	sub    $0x18,%esp
  801daa:	8b 45 10             	mov    0x10(%ebp),%eax
  801dad:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801db0:	83 ec 04             	sub    $0x4,%esp
  801db3:	68 64 2e 80 00       	push   $0x802e64
  801db8:	68 b6 00 00 00       	push   $0xb6
  801dbd:	68 87 2e 80 00       	push   $0x802e87
  801dc2:	e8 4a ea ff ff       	call   800811 <_panic>

00801dc7 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
  801dca:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dcd:	83 ec 04             	sub    $0x4,%esp
  801dd0:	68 64 2e 80 00       	push   $0x802e64
  801dd5:	68 bb 00 00 00       	push   $0xbb
  801dda:	68 87 2e 80 00       	push   $0x802e87
  801ddf:	e8 2d ea ff ff       	call   800811 <_panic>

00801de4 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801de4:	55                   	push   %ebp
  801de5:	89 e5                	mov    %esp,%ebp
  801de7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dea:	83 ec 04             	sub    $0x4,%esp
  801ded:	68 64 2e 80 00       	push   $0x802e64
  801df2:	68 c0 00 00 00       	push   $0xc0
  801df7:	68 87 2e 80 00       	push   $0x802e87
  801dfc:	e8 10 ea ff ff       	call   800811 <_panic>

00801e01 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801e01:	55                   	push   %ebp
  801e02:	89 e5                	mov    %esp,%ebp
  801e04:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e07:	83 ec 04             	sub    $0x4,%esp
  801e0a:	68 64 2e 80 00       	push   $0x802e64
  801e0f:	68 c4 00 00 00       	push   $0xc4
  801e14:	68 87 2e 80 00       	push   $0x802e87
  801e19:	e8 f3 e9 ff ff       	call   800811 <_panic>

00801e1e <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801e1e:	55                   	push   %ebp
  801e1f:	89 e5                	mov    %esp,%ebp
  801e21:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e24:	83 ec 04             	sub    $0x4,%esp
  801e27:	68 64 2e 80 00       	push   $0x802e64
  801e2c:	68 c9 00 00 00       	push   $0xc9
  801e31:	68 87 2e 80 00       	push   $0x802e87
  801e36:	e8 d6 e9 ff ff       	call   800811 <_panic>

00801e3b <shrink>:
}
void shrink(uint32 newSize) {
  801e3b:	55                   	push   %ebp
  801e3c:	89 e5                	mov    %esp,%ebp
  801e3e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e41:	83 ec 04             	sub    $0x4,%esp
  801e44:	68 64 2e 80 00       	push   $0x802e64
  801e49:	68 cc 00 00 00       	push   $0xcc
  801e4e:	68 87 2e 80 00       	push   $0x802e87
  801e53:	e8 b9 e9 ff ff       	call   800811 <_panic>

00801e58 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801e58:	55                   	push   %ebp
  801e59:	89 e5                	mov    %esp,%ebp
  801e5b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e5e:	83 ec 04             	sub    $0x4,%esp
  801e61:	68 64 2e 80 00       	push   $0x802e64
  801e66:	68 d0 00 00 00       	push   $0xd0
  801e6b:	68 87 2e 80 00       	push   $0x802e87
  801e70:	e8 9c e9 ff ff       	call   800811 <_panic>

00801e75 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e75:	55                   	push   %ebp
  801e76:	89 e5                	mov    %esp,%ebp
  801e78:	57                   	push   %edi
  801e79:	56                   	push   %esi
  801e7a:	53                   	push   %ebx
  801e7b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e81:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e84:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e87:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e8a:	8b 7d 18             	mov    0x18(%ebp),%edi
  801e8d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801e90:	cd 30                	int    $0x30
  801e92:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801e95:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e98:	83 c4 10             	add    $0x10,%esp
  801e9b:	5b                   	pop    %ebx
  801e9c:	5e                   	pop    %esi
  801e9d:	5f                   	pop    %edi
  801e9e:	5d                   	pop    %ebp
  801e9f:	c3                   	ret    

00801ea0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801ea0:	55                   	push   %ebp
  801ea1:	89 e5                	mov    %esp,%ebp
  801ea3:	83 ec 04             	sub    $0x4,%esp
  801ea6:	8b 45 10             	mov    0x10(%ebp),%eax
  801ea9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801eac:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	52                   	push   %edx
  801eb8:	ff 75 0c             	pushl  0xc(%ebp)
  801ebb:	50                   	push   %eax
  801ebc:	6a 00                	push   $0x0
  801ebe:	e8 b2 ff ff ff       	call   801e75 <syscall>
  801ec3:	83 c4 18             	add    $0x18,%esp
}
  801ec6:	90                   	nop
  801ec7:	c9                   	leave  
  801ec8:	c3                   	ret    

00801ec9 <sys_cgetc>:

int
sys_cgetc(void)
{
  801ec9:	55                   	push   %ebp
  801eca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 00                	push   $0x0
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 00                	push   $0x0
  801ed6:	6a 01                	push   $0x1
  801ed8:	e8 98 ff ff ff       	call   801e75 <syscall>
  801edd:	83 c4 18             	add    $0x18,%esp
}
  801ee0:	c9                   	leave  
  801ee1:	c3                   	ret    

00801ee2 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ee2:	55                   	push   %ebp
  801ee3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	50                   	push   %eax
  801ef1:	6a 05                	push   $0x5
  801ef3:	e8 7d ff ff ff       	call   801e75 <syscall>
  801ef8:	83 c4 18             	add    $0x18,%esp
}
  801efb:	c9                   	leave  
  801efc:	c3                   	ret    

00801efd <sys_getenvid>:

int32 sys_getenvid(void)
{
  801efd:	55                   	push   %ebp
  801efe:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 02                	push   $0x2
  801f0c:	e8 64 ff ff ff       	call   801e75 <syscall>
  801f11:	83 c4 18             	add    $0x18,%esp
}
  801f14:	c9                   	leave  
  801f15:	c3                   	ret    

00801f16 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801f16:	55                   	push   %ebp
  801f17:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	6a 03                	push   $0x3
  801f25:	e8 4b ff ff ff       	call   801e75 <syscall>
  801f2a:	83 c4 18             	add    $0x18,%esp
}
  801f2d:	c9                   	leave  
  801f2e:	c3                   	ret    

00801f2f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f2f:	55                   	push   %ebp
  801f30:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 04                	push   $0x4
  801f3e:	e8 32 ff ff ff       	call   801e75 <syscall>
  801f43:	83 c4 18             	add    $0x18,%esp
}
  801f46:	c9                   	leave  
  801f47:	c3                   	ret    

00801f48 <sys_env_exit>:


void sys_env_exit(void)
{
  801f48:	55                   	push   %ebp
  801f49:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 06                	push   $0x6
  801f57:	e8 19 ff ff ff       	call   801e75 <syscall>
  801f5c:	83 c4 18             	add    $0x18,%esp
}
  801f5f:	90                   	nop
  801f60:	c9                   	leave  
  801f61:	c3                   	ret    

00801f62 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801f62:	55                   	push   %ebp
  801f63:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801f65:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f68:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	52                   	push   %edx
  801f72:	50                   	push   %eax
  801f73:	6a 07                	push   $0x7
  801f75:	e8 fb fe ff ff       	call   801e75 <syscall>
  801f7a:	83 c4 18             	add    $0x18,%esp
}
  801f7d:	c9                   	leave  
  801f7e:	c3                   	ret    

00801f7f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f7f:	55                   	push   %ebp
  801f80:	89 e5                	mov    %esp,%ebp
  801f82:	56                   	push   %esi
  801f83:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801f84:	8b 75 18             	mov    0x18(%ebp),%esi
  801f87:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f8a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f90:	8b 45 08             	mov    0x8(%ebp),%eax
  801f93:	56                   	push   %esi
  801f94:	53                   	push   %ebx
  801f95:	51                   	push   %ecx
  801f96:	52                   	push   %edx
  801f97:	50                   	push   %eax
  801f98:	6a 08                	push   $0x8
  801f9a:	e8 d6 fe ff ff       	call   801e75 <syscall>
  801f9f:	83 c4 18             	add    $0x18,%esp
}
  801fa2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801fa5:	5b                   	pop    %ebx
  801fa6:	5e                   	pop    %esi
  801fa7:	5d                   	pop    %ebp
  801fa8:	c3                   	ret    

00801fa9 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801fa9:	55                   	push   %ebp
  801faa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801fac:	8b 55 0c             	mov    0xc(%ebp),%edx
  801faf:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	52                   	push   %edx
  801fb9:	50                   	push   %eax
  801fba:	6a 09                	push   $0x9
  801fbc:	e8 b4 fe ff ff       	call   801e75 <syscall>
  801fc1:	83 c4 18             	add    $0x18,%esp
}
  801fc4:	c9                   	leave  
  801fc5:	c3                   	ret    

00801fc6 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801fc6:	55                   	push   %ebp
  801fc7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	ff 75 0c             	pushl  0xc(%ebp)
  801fd2:	ff 75 08             	pushl  0x8(%ebp)
  801fd5:	6a 0a                	push   $0xa
  801fd7:	e8 99 fe ff ff       	call   801e75 <syscall>
  801fdc:	83 c4 18             	add    $0x18,%esp
}
  801fdf:	c9                   	leave  
  801fe0:	c3                   	ret    

00801fe1 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801fe1:	55                   	push   %ebp
  801fe2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 0b                	push   $0xb
  801ff0:	e8 80 fe ff ff       	call   801e75 <syscall>
  801ff5:	83 c4 18             	add    $0x18,%esp
}
  801ff8:	c9                   	leave  
  801ff9:	c3                   	ret    

00801ffa <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ffa:	55                   	push   %ebp
  801ffb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	6a 00                	push   $0x0
  802007:	6a 0c                	push   $0xc
  802009:	e8 67 fe ff ff       	call   801e75 <syscall>
  80200e:	83 c4 18             	add    $0x18,%esp
}
  802011:	c9                   	leave  
  802012:	c3                   	ret    

00802013 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802013:	55                   	push   %ebp
  802014:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 0d                	push   $0xd
  802022:	e8 4e fe ff ff       	call   801e75 <syscall>
  802027:	83 c4 18             	add    $0x18,%esp
}
  80202a:	c9                   	leave  
  80202b:	c3                   	ret    

0080202c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80202c:	55                   	push   %ebp
  80202d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	ff 75 0c             	pushl  0xc(%ebp)
  802038:	ff 75 08             	pushl  0x8(%ebp)
  80203b:	6a 11                	push   $0x11
  80203d:	e8 33 fe ff ff       	call   801e75 <syscall>
  802042:	83 c4 18             	add    $0x18,%esp
	return;
  802045:	90                   	nop
}
  802046:	c9                   	leave  
  802047:	c3                   	ret    

00802048 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802048:	55                   	push   %ebp
  802049:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	ff 75 0c             	pushl  0xc(%ebp)
  802054:	ff 75 08             	pushl  0x8(%ebp)
  802057:	6a 12                	push   $0x12
  802059:	e8 17 fe ff ff       	call   801e75 <syscall>
  80205e:	83 c4 18             	add    $0x18,%esp
	return ;
  802061:	90                   	nop
}
  802062:	c9                   	leave  
  802063:	c3                   	ret    

00802064 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802064:	55                   	push   %ebp
  802065:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	6a 0e                	push   $0xe
  802073:	e8 fd fd ff ff       	call   801e75 <syscall>
  802078:	83 c4 18             	add    $0x18,%esp
}
  80207b:	c9                   	leave  
  80207c:	c3                   	ret    

0080207d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80207d:	55                   	push   %ebp
  80207e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	ff 75 08             	pushl  0x8(%ebp)
  80208b:	6a 0f                	push   $0xf
  80208d:	e8 e3 fd ff ff       	call   801e75 <syscall>
  802092:	83 c4 18             	add    $0x18,%esp
}
  802095:	c9                   	leave  
  802096:	c3                   	ret    

00802097 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802097:	55                   	push   %ebp
  802098:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 10                	push   $0x10
  8020a6:	e8 ca fd ff ff       	call   801e75 <syscall>
  8020ab:	83 c4 18             	add    $0x18,%esp
}
  8020ae:	90                   	nop
  8020af:	c9                   	leave  
  8020b0:	c3                   	ret    

008020b1 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8020b1:	55                   	push   %ebp
  8020b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 14                	push   $0x14
  8020c0:	e8 b0 fd ff ff       	call   801e75 <syscall>
  8020c5:	83 c4 18             	add    $0x18,%esp
}
  8020c8:	90                   	nop
  8020c9:	c9                   	leave  
  8020ca:	c3                   	ret    

008020cb <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8020cb:	55                   	push   %ebp
  8020cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 00                	push   $0x0
  8020d8:	6a 15                	push   $0x15
  8020da:	e8 96 fd ff ff       	call   801e75 <syscall>
  8020df:	83 c4 18             	add    $0x18,%esp
}
  8020e2:	90                   	nop
  8020e3:	c9                   	leave  
  8020e4:	c3                   	ret    

008020e5 <sys_cputc>:


void
sys_cputc(const char c)
{
  8020e5:	55                   	push   %ebp
  8020e6:	89 e5                	mov    %esp,%ebp
  8020e8:	83 ec 04             	sub    $0x4,%esp
  8020eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ee:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8020f1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020f5:	6a 00                	push   $0x0
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	50                   	push   %eax
  8020fe:	6a 16                	push   $0x16
  802100:	e8 70 fd ff ff       	call   801e75 <syscall>
  802105:	83 c4 18             	add    $0x18,%esp
}
  802108:	90                   	nop
  802109:	c9                   	leave  
  80210a:	c3                   	ret    

0080210b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80210b:	55                   	push   %ebp
  80210c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 17                	push   $0x17
  80211a:	e8 56 fd ff ff       	call   801e75 <syscall>
  80211f:	83 c4 18             	add    $0x18,%esp
}
  802122:	90                   	nop
  802123:	c9                   	leave  
  802124:	c3                   	ret    

00802125 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802125:	55                   	push   %ebp
  802126:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802128:	8b 45 08             	mov    0x8(%ebp),%eax
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	ff 75 0c             	pushl  0xc(%ebp)
  802134:	50                   	push   %eax
  802135:	6a 18                	push   $0x18
  802137:	e8 39 fd ff ff       	call   801e75 <syscall>
  80213c:	83 c4 18             	add    $0x18,%esp
}
  80213f:	c9                   	leave  
  802140:	c3                   	ret    

00802141 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802141:	55                   	push   %ebp
  802142:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802144:	8b 55 0c             	mov    0xc(%ebp),%edx
  802147:	8b 45 08             	mov    0x8(%ebp),%eax
  80214a:	6a 00                	push   $0x0
  80214c:	6a 00                	push   $0x0
  80214e:	6a 00                	push   $0x0
  802150:	52                   	push   %edx
  802151:	50                   	push   %eax
  802152:	6a 1b                	push   $0x1b
  802154:	e8 1c fd ff ff       	call   801e75 <syscall>
  802159:	83 c4 18             	add    $0x18,%esp
}
  80215c:	c9                   	leave  
  80215d:	c3                   	ret    

0080215e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80215e:	55                   	push   %ebp
  80215f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802161:	8b 55 0c             	mov    0xc(%ebp),%edx
  802164:	8b 45 08             	mov    0x8(%ebp),%eax
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	6a 00                	push   $0x0
  80216d:	52                   	push   %edx
  80216e:	50                   	push   %eax
  80216f:	6a 19                	push   $0x19
  802171:	e8 ff fc ff ff       	call   801e75 <syscall>
  802176:	83 c4 18             	add    $0x18,%esp
}
  802179:	90                   	nop
  80217a:	c9                   	leave  
  80217b:	c3                   	ret    

0080217c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80217c:	55                   	push   %ebp
  80217d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80217f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802182:	8b 45 08             	mov    0x8(%ebp),%eax
  802185:	6a 00                	push   $0x0
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	52                   	push   %edx
  80218c:	50                   	push   %eax
  80218d:	6a 1a                	push   $0x1a
  80218f:	e8 e1 fc ff ff       	call   801e75 <syscall>
  802194:	83 c4 18             	add    $0x18,%esp
}
  802197:	90                   	nop
  802198:	c9                   	leave  
  802199:	c3                   	ret    

0080219a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80219a:	55                   	push   %ebp
  80219b:	89 e5                	mov    %esp,%ebp
  80219d:	83 ec 04             	sub    $0x4,%esp
  8021a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8021a3:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8021a6:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8021a9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8021ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b0:	6a 00                	push   $0x0
  8021b2:	51                   	push   %ecx
  8021b3:	52                   	push   %edx
  8021b4:	ff 75 0c             	pushl  0xc(%ebp)
  8021b7:	50                   	push   %eax
  8021b8:	6a 1c                	push   $0x1c
  8021ba:	e8 b6 fc ff ff       	call   801e75 <syscall>
  8021bf:	83 c4 18             	add    $0x18,%esp
}
  8021c2:	c9                   	leave  
  8021c3:	c3                   	ret    

008021c4 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8021c4:	55                   	push   %ebp
  8021c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8021c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 00                	push   $0x0
  8021d3:	52                   	push   %edx
  8021d4:	50                   	push   %eax
  8021d5:	6a 1d                	push   $0x1d
  8021d7:	e8 99 fc ff ff       	call   801e75 <syscall>
  8021dc:	83 c4 18             	add    $0x18,%esp
}
  8021df:	c9                   	leave  
  8021e0:	c3                   	ret    

008021e1 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8021e1:	55                   	push   %ebp
  8021e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8021e4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	51                   	push   %ecx
  8021f2:	52                   	push   %edx
  8021f3:	50                   	push   %eax
  8021f4:	6a 1e                	push   $0x1e
  8021f6:	e8 7a fc ff ff       	call   801e75 <syscall>
  8021fb:	83 c4 18             	add    $0x18,%esp
}
  8021fe:	c9                   	leave  
  8021ff:	c3                   	ret    

00802200 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802200:	55                   	push   %ebp
  802201:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802203:	8b 55 0c             	mov    0xc(%ebp),%edx
  802206:	8b 45 08             	mov    0x8(%ebp),%eax
  802209:	6a 00                	push   $0x0
  80220b:	6a 00                	push   $0x0
  80220d:	6a 00                	push   $0x0
  80220f:	52                   	push   %edx
  802210:	50                   	push   %eax
  802211:	6a 1f                	push   $0x1f
  802213:	e8 5d fc ff ff       	call   801e75 <syscall>
  802218:	83 c4 18             	add    $0x18,%esp
}
  80221b:	c9                   	leave  
  80221c:	c3                   	ret    

0080221d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80221d:	55                   	push   %ebp
  80221e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802220:	6a 00                	push   $0x0
  802222:	6a 00                	push   $0x0
  802224:	6a 00                	push   $0x0
  802226:	6a 00                	push   $0x0
  802228:	6a 00                	push   $0x0
  80222a:	6a 20                	push   $0x20
  80222c:	e8 44 fc ff ff       	call   801e75 <syscall>
  802231:	83 c4 18             	add    $0x18,%esp
}
  802234:	c9                   	leave  
  802235:	c3                   	ret    

00802236 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802236:	55                   	push   %ebp
  802237:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802239:	8b 45 08             	mov    0x8(%ebp),%eax
  80223c:	6a 00                	push   $0x0
  80223e:	ff 75 14             	pushl  0x14(%ebp)
  802241:	ff 75 10             	pushl  0x10(%ebp)
  802244:	ff 75 0c             	pushl  0xc(%ebp)
  802247:	50                   	push   %eax
  802248:	6a 21                	push   $0x21
  80224a:	e8 26 fc ff ff       	call   801e75 <syscall>
  80224f:	83 c4 18             	add    $0x18,%esp
}
  802252:	c9                   	leave  
  802253:	c3                   	ret    

00802254 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802254:	55                   	push   %ebp
  802255:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802257:	8b 45 08             	mov    0x8(%ebp),%eax
  80225a:	6a 00                	push   $0x0
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	6a 00                	push   $0x0
  802262:	50                   	push   %eax
  802263:	6a 22                	push   $0x22
  802265:	e8 0b fc ff ff       	call   801e75 <syscall>
  80226a:	83 c4 18             	add    $0x18,%esp
}
  80226d:	90                   	nop
  80226e:	c9                   	leave  
  80226f:	c3                   	ret    

00802270 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802270:	55                   	push   %ebp
  802271:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802273:	8b 45 08             	mov    0x8(%ebp),%eax
  802276:	6a 00                	push   $0x0
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 00                	push   $0x0
  80227e:	50                   	push   %eax
  80227f:	6a 23                	push   $0x23
  802281:	e8 ef fb ff ff       	call   801e75 <syscall>
  802286:	83 c4 18             	add    $0x18,%esp
}
  802289:	90                   	nop
  80228a:	c9                   	leave  
  80228b:	c3                   	ret    

0080228c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80228c:	55                   	push   %ebp
  80228d:	89 e5                	mov    %esp,%ebp
  80228f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802292:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802295:	8d 50 04             	lea    0x4(%eax),%edx
  802298:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80229b:	6a 00                	push   $0x0
  80229d:	6a 00                	push   $0x0
  80229f:	6a 00                	push   $0x0
  8022a1:	52                   	push   %edx
  8022a2:	50                   	push   %eax
  8022a3:	6a 24                	push   $0x24
  8022a5:	e8 cb fb ff ff       	call   801e75 <syscall>
  8022aa:	83 c4 18             	add    $0x18,%esp
	return result;
  8022ad:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8022b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022b3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022b6:	89 01                	mov    %eax,(%ecx)
  8022b8:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8022bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8022be:	c9                   	leave  
  8022bf:	c2 04 00             	ret    $0x4

008022c2 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8022c2:	55                   	push   %ebp
  8022c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8022c5:	6a 00                	push   $0x0
  8022c7:	6a 00                	push   $0x0
  8022c9:	ff 75 10             	pushl  0x10(%ebp)
  8022cc:	ff 75 0c             	pushl  0xc(%ebp)
  8022cf:	ff 75 08             	pushl  0x8(%ebp)
  8022d2:	6a 13                	push   $0x13
  8022d4:	e8 9c fb ff ff       	call   801e75 <syscall>
  8022d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8022dc:	90                   	nop
}
  8022dd:	c9                   	leave  
  8022de:	c3                   	ret    

008022df <sys_rcr2>:
uint32 sys_rcr2()
{
  8022df:	55                   	push   %ebp
  8022e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8022e2:	6a 00                	push   $0x0
  8022e4:	6a 00                	push   $0x0
  8022e6:	6a 00                	push   $0x0
  8022e8:	6a 00                	push   $0x0
  8022ea:	6a 00                	push   $0x0
  8022ec:	6a 25                	push   $0x25
  8022ee:	e8 82 fb ff ff       	call   801e75 <syscall>
  8022f3:	83 c4 18             	add    $0x18,%esp
}
  8022f6:	c9                   	leave  
  8022f7:	c3                   	ret    

008022f8 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8022f8:	55                   	push   %ebp
  8022f9:	89 e5                	mov    %esp,%ebp
  8022fb:	83 ec 04             	sub    $0x4,%esp
  8022fe:	8b 45 08             	mov    0x8(%ebp),%eax
  802301:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802304:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802308:	6a 00                	push   $0x0
  80230a:	6a 00                	push   $0x0
  80230c:	6a 00                	push   $0x0
  80230e:	6a 00                	push   $0x0
  802310:	50                   	push   %eax
  802311:	6a 26                	push   $0x26
  802313:	e8 5d fb ff ff       	call   801e75 <syscall>
  802318:	83 c4 18             	add    $0x18,%esp
	return ;
  80231b:	90                   	nop
}
  80231c:	c9                   	leave  
  80231d:	c3                   	ret    

0080231e <rsttst>:
void rsttst()
{
  80231e:	55                   	push   %ebp
  80231f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802321:	6a 00                	push   $0x0
  802323:	6a 00                	push   $0x0
  802325:	6a 00                	push   $0x0
  802327:	6a 00                	push   $0x0
  802329:	6a 00                	push   $0x0
  80232b:	6a 28                	push   $0x28
  80232d:	e8 43 fb ff ff       	call   801e75 <syscall>
  802332:	83 c4 18             	add    $0x18,%esp
	return ;
  802335:	90                   	nop
}
  802336:	c9                   	leave  
  802337:	c3                   	ret    

00802338 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802338:	55                   	push   %ebp
  802339:	89 e5                	mov    %esp,%ebp
  80233b:	83 ec 04             	sub    $0x4,%esp
  80233e:	8b 45 14             	mov    0x14(%ebp),%eax
  802341:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802344:	8b 55 18             	mov    0x18(%ebp),%edx
  802347:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80234b:	52                   	push   %edx
  80234c:	50                   	push   %eax
  80234d:	ff 75 10             	pushl  0x10(%ebp)
  802350:	ff 75 0c             	pushl  0xc(%ebp)
  802353:	ff 75 08             	pushl  0x8(%ebp)
  802356:	6a 27                	push   $0x27
  802358:	e8 18 fb ff ff       	call   801e75 <syscall>
  80235d:	83 c4 18             	add    $0x18,%esp
	return ;
  802360:	90                   	nop
}
  802361:	c9                   	leave  
  802362:	c3                   	ret    

00802363 <chktst>:
void chktst(uint32 n)
{
  802363:	55                   	push   %ebp
  802364:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802366:	6a 00                	push   $0x0
  802368:	6a 00                	push   $0x0
  80236a:	6a 00                	push   $0x0
  80236c:	6a 00                	push   $0x0
  80236e:	ff 75 08             	pushl  0x8(%ebp)
  802371:	6a 29                	push   $0x29
  802373:	e8 fd fa ff ff       	call   801e75 <syscall>
  802378:	83 c4 18             	add    $0x18,%esp
	return ;
  80237b:	90                   	nop
}
  80237c:	c9                   	leave  
  80237d:	c3                   	ret    

0080237e <inctst>:

void inctst()
{
  80237e:	55                   	push   %ebp
  80237f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802381:	6a 00                	push   $0x0
  802383:	6a 00                	push   $0x0
  802385:	6a 00                	push   $0x0
  802387:	6a 00                	push   $0x0
  802389:	6a 00                	push   $0x0
  80238b:	6a 2a                	push   $0x2a
  80238d:	e8 e3 fa ff ff       	call   801e75 <syscall>
  802392:	83 c4 18             	add    $0x18,%esp
	return ;
  802395:	90                   	nop
}
  802396:	c9                   	leave  
  802397:	c3                   	ret    

00802398 <gettst>:
uint32 gettst()
{
  802398:	55                   	push   %ebp
  802399:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80239b:	6a 00                	push   $0x0
  80239d:	6a 00                	push   $0x0
  80239f:	6a 00                	push   $0x0
  8023a1:	6a 00                	push   $0x0
  8023a3:	6a 00                	push   $0x0
  8023a5:	6a 2b                	push   $0x2b
  8023a7:	e8 c9 fa ff ff       	call   801e75 <syscall>
  8023ac:	83 c4 18             	add    $0x18,%esp
}
  8023af:	c9                   	leave  
  8023b0:	c3                   	ret    

008023b1 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8023b1:	55                   	push   %ebp
  8023b2:	89 e5                	mov    %esp,%ebp
  8023b4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023b7:	6a 00                	push   $0x0
  8023b9:	6a 00                	push   $0x0
  8023bb:	6a 00                	push   $0x0
  8023bd:	6a 00                	push   $0x0
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 2c                	push   $0x2c
  8023c3:	e8 ad fa ff ff       	call   801e75 <syscall>
  8023c8:	83 c4 18             	add    $0x18,%esp
  8023cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8023ce:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8023d2:	75 07                	jne    8023db <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8023d4:	b8 01 00 00 00       	mov    $0x1,%eax
  8023d9:	eb 05                	jmp    8023e0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8023db:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023e0:	c9                   	leave  
  8023e1:	c3                   	ret    

008023e2 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8023e2:	55                   	push   %ebp
  8023e3:	89 e5                	mov    %esp,%ebp
  8023e5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023e8:	6a 00                	push   $0x0
  8023ea:	6a 00                	push   $0x0
  8023ec:	6a 00                	push   $0x0
  8023ee:	6a 00                	push   $0x0
  8023f0:	6a 00                	push   $0x0
  8023f2:	6a 2c                	push   $0x2c
  8023f4:	e8 7c fa ff ff       	call   801e75 <syscall>
  8023f9:	83 c4 18             	add    $0x18,%esp
  8023fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8023ff:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802403:	75 07                	jne    80240c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802405:	b8 01 00 00 00       	mov    $0x1,%eax
  80240a:	eb 05                	jmp    802411 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80240c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802411:	c9                   	leave  
  802412:	c3                   	ret    

00802413 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802413:	55                   	push   %ebp
  802414:	89 e5                	mov    %esp,%ebp
  802416:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802419:	6a 00                	push   $0x0
  80241b:	6a 00                	push   $0x0
  80241d:	6a 00                	push   $0x0
  80241f:	6a 00                	push   $0x0
  802421:	6a 00                	push   $0x0
  802423:	6a 2c                	push   $0x2c
  802425:	e8 4b fa ff ff       	call   801e75 <syscall>
  80242a:	83 c4 18             	add    $0x18,%esp
  80242d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802430:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802434:	75 07                	jne    80243d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802436:	b8 01 00 00 00       	mov    $0x1,%eax
  80243b:	eb 05                	jmp    802442 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80243d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802442:	c9                   	leave  
  802443:	c3                   	ret    

00802444 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802444:	55                   	push   %ebp
  802445:	89 e5                	mov    %esp,%ebp
  802447:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80244a:	6a 00                	push   $0x0
  80244c:	6a 00                	push   $0x0
  80244e:	6a 00                	push   $0x0
  802450:	6a 00                	push   $0x0
  802452:	6a 00                	push   $0x0
  802454:	6a 2c                	push   $0x2c
  802456:	e8 1a fa ff ff       	call   801e75 <syscall>
  80245b:	83 c4 18             	add    $0x18,%esp
  80245e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802461:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802465:	75 07                	jne    80246e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802467:	b8 01 00 00 00       	mov    $0x1,%eax
  80246c:	eb 05                	jmp    802473 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80246e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802473:	c9                   	leave  
  802474:	c3                   	ret    

00802475 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802475:	55                   	push   %ebp
  802476:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802478:	6a 00                	push   $0x0
  80247a:	6a 00                	push   $0x0
  80247c:	6a 00                	push   $0x0
  80247e:	6a 00                	push   $0x0
  802480:	ff 75 08             	pushl  0x8(%ebp)
  802483:	6a 2d                	push   $0x2d
  802485:	e8 eb f9 ff ff       	call   801e75 <syscall>
  80248a:	83 c4 18             	add    $0x18,%esp
	return ;
  80248d:	90                   	nop
}
  80248e:	c9                   	leave  
  80248f:	c3                   	ret    

00802490 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802490:	55                   	push   %ebp
  802491:	89 e5                	mov    %esp,%ebp
  802493:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802494:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802497:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80249a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80249d:	8b 45 08             	mov    0x8(%ebp),%eax
  8024a0:	6a 00                	push   $0x0
  8024a2:	53                   	push   %ebx
  8024a3:	51                   	push   %ecx
  8024a4:	52                   	push   %edx
  8024a5:	50                   	push   %eax
  8024a6:	6a 2e                	push   $0x2e
  8024a8:	e8 c8 f9 ff ff       	call   801e75 <syscall>
  8024ad:	83 c4 18             	add    $0x18,%esp
}
  8024b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8024b3:	c9                   	leave  
  8024b4:	c3                   	ret    

008024b5 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8024b5:	55                   	push   %ebp
  8024b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8024b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8024be:	6a 00                	push   $0x0
  8024c0:	6a 00                	push   $0x0
  8024c2:	6a 00                	push   $0x0
  8024c4:	52                   	push   %edx
  8024c5:	50                   	push   %eax
  8024c6:	6a 2f                	push   $0x2f
  8024c8:	e8 a8 f9 ff ff       	call   801e75 <syscall>
  8024cd:	83 c4 18             	add    $0x18,%esp
}
  8024d0:	c9                   	leave  
  8024d1:	c3                   	ret    
  8024d2:	66 90                	xchg   %ax,%ax

008024d4 <__udivdi3>:
  8024d4:	55                   	push   %ebp
  8024d5:	57                   	push   %edi
  8024d6:	56                   	push   %esi
  8024d7:	53                   	push   %ebx
  8024d8:	83 ec 1c             	sub    $0x1c,%esp
  8024db:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8024df:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8024e3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024e7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8024eb:	89 ca                	mov    %ecx,%edx
  8024ed:	89 f8                	mov    %edi,%eax
  8024ef:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8024f3:	85 f6                	test   %esi,%esi
  8024f5:	75 2d                	jne    802524 <__udivdi3+0x50>
  8024f7:	39 cf                	cmp    %ecx,%edi
  8024f9:	77 65                	ja     802560 <__udivdi3+0x8c>
  8024fb:	89 fd                	mov    %edi,%ebp
  8024fd:	85 ff                	test   %edi,%edi
  8024ff:	75 0b                	jne    80250c <__udivdi3+0x38>
  802501:	b8 01 00 00 00       	mov    $0x1,%eax
  802506:	31 d2                	xor    %edx,%edx
  802508:	f7 f7                	div    %edi
  80250a:	89 c5                	mov    %eax,%ebp
  80250c:	31 d2                	xor    %edx,%edx
  80250e:	89 c8                	mov    %ecx,%eax
  802510:	f7 f5                	div    %ebp
  802512:	89 c1                	mov    %eax,%ecx
  802514:	89 d8                	mov    %ebx,%eax
  802516:	f7 f5                	div    %ebp
  802518:	89 cf                	mov    %ecx,%edi
  80251a:	89 fa                	mov    %edi,%edx
  80251c:	83 c4 1c             	add    $0x1c,%esp
  80251f:	5b                   	pop    %ebx
  802520:	5e                   	pop    %esi
  802521:	5f                   	pop    %edi
  802522:	5d                   	pop    %ebp
  802523:	c3                   	ret    
  802524:	39 ce                	cmp    %ecx,%esi
  802526:	77 28                	ja     802550 <__udivdi3+0x7c>
  802528:	0f bd fe             	bsr    %esi,%edi
  80252b:	83 f7 1f             	xor    $0x1f,%edi
  80252e:	75 40                	jne    802570 <__udivdi3+0x9c>
  802530:	39 ce                	cmp    %ecx,%esi
  802532:	72 0a                	jb     80253e <__udivdi3+0x6a>
  802534:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802538:	0f 87 9e 00 00 00    	ja     8025dc <__udivdi3+0x108>
  80253e:	b8 01 00 00 00       	mov    $0x1,%eax
  802543:	89 fa                	mov    %edi,%edx
  802545:	83 c4 1c             	add    $0x1c,%esp
  802548:	5b                   	pop    %ebx
  802549:	5e                   	pop    %esi
  80254a:	5f                   	pop    %edi
  80254b:	5d                   	pop    %ebp
  80254c:	c3                   	ret    
  80254d:	8d 76 00             	lea    0x0(%esi),%esi
  802550:	31 ff                	xor    %edi,%edi
  802552:	31 c0                	xor    %eax,%eax
  802554:	89 fa                	mov    %edi,%edx
  802556:	83 c4 1c             	add    $0x1c,%esp
  802559:	5b                   	pop    %ebx
  80255a:	5e                   	pop    %esi
  80255b:	5f                   	pop    %edi
  80255c:	5d                   	pop    %ebp
  80255d:	c3                   	ret    
  80255e:	66 90                	xchg   %ax,%ax
  802560:	89 d8                	mov    %ebx,%eax
  802562:	f7 f7                	div    %edi
  802564:	31 ff                	xor    %edi,%edi
  802566:	89 fa                	mov    %edi,%edx
  802568:	83 c4 1c             	add    $0x1c,%esp
  80256b:	5b                   	pop    %ebx
  80256c:	5e                   	pop    %esi
  80256d:	5f                   	pop    %edi
  80256e:	5d                   	pop    %ebp
  80256f:	c3                   	ret    
  802570:	bd 20 00 00 00       	mov    $0x20,%ebp
  802575:	89 eb                	mov    %ebp,%ebx
  802577:	29 fb                	sub    %edi,%ebx
  802579:	89 f9                	mov    %edi,%ecx
  80257b:	d3 e6                	shl    %cl,%esi
  80257d:	89 c5                	mov    %eax,%ebp
  80257f:	88 d9                	mov    %bl,%cl
  802581:	d3 ed                	shr    %cl,%ebp
  802583:	89 e9                	mov    %ebp,%ecx
  802585:	09 f1                	or     %esi,%ecx
  802587:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80258b:	89 f9                	mov    %edi,%ecx
  80258d:	d3 e0                	shl    %cl,%eax
  80258f:	89 c5                	mov    %eax,%ebp
  802591:	89 d6                	mov    %edx,%esi
  802593:	88 d9                	mov    %bl,%cl
  802595:	d3 ee                	shr    %cl,%esi
  802597:	89 f9                	mov    %edi,%ecx
  802599:	d3 e2                	shl    %cl,%edx
  80259b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80259f:	88 d9                	mov    %bl,%cl
  8025a1:	d3 e8                	shr    %cl,%eax
  8025a3:	09 c2                	or     %eax,%edx
  8025a5:	89 d0                	mov    %edx,%eax
  8025a7:	89 f2                	mov    %esi,%edx
  8025a9:	f7 74 24 0c          	divl   0xc(%esp)
  8025ad:	89 d6                	mov    %edx,%esi
  8025af:	89 c3                	mov    %eax,%ebx
  8025b1:	f7 e5                	mul    %ebp
  8025b3:	39 d6                	cmp    %edx,%esi
  8025b5:	72 19                	jb     8025d0 <__udivdi3+0xfc>
  8025b7:	74 0b                	je     8025c4 <__udivdi3+0xf0>
  8025b9:	89 d8                	mov    %ebx,%eax
  8025bb:	31 ff                	xor    %edi,%edi
  8025bd:	e9 58 ff ff ff       	jmp    80251a <__udivdi3+0x46>
  8025c2:	66 90                	xchg   %ax,%ax
  8025c4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8025c8:	89 f9                	mov    %edi,%ecx
  8025ca:	d3 e2                	shl    %cl,%edx
  8025cc:	39 c2                	cmp    %eax,%edx
  8025ce:	73 e9                	jae    8025b9 <__udivdi3+0xe5>
  8025d0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8025d3:	31 ff                	xor    %edi,%edi
  8025d5:	e9 40 ff ff ff       	jmp    80251a <__udivdi3+0x46>
  8025da:	66 90                	xchg   %ax,%ax
  8025dc:	31 c0                	xor    %eax,%eax
  8025de:	e9 37 ff ff ff       	jmp    80251a <__udivdi3+0x46>
  8025e3:	90                   	nop

008025e4 <__umoddi3>:
  8025e4:	55                   	push   %ebp
  8025e5:	57                   	push   %edi
  8025e6:	56                   	push   %esi
  8025e7:	53                   	push   %ebx
  8025e8:	83 ec 1c             	sub    $0x1c,%esp
  8025eb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8025ef:	8b 74 24 34          	mov    0x34(%esp),%esi
  8025f3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025f7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8025fb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8025ff:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802603:	89 f3                	mov    %esi,%ebx
  802605:	89 fa                	mov    %edi,%edx
  802607:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80260b:	89 34 24             	mov    %esi,(%esp)
  80260e:	85 c0                	test   %eax,%eax
  802610:	75 1a                	jne    80262c <__umoddi3+0x48>
  802612:	39 f7                	cmp    %esi,%edi
  802614:	0f 86 a2 00 00 00    	jbe    8026bc <__umoddi3+0xd8>
  80261a:	89 c8                	mov    %ecx,%eax
  80261c:	89 f2                	mov    %esi,%edx
  80261e:	f7 f7                	div    %edi
  802620:	89 d0                	mov    %edx,%eax
  802622:	31 d2                	xor    %edx,%edx
  802624:	83 c4 1c             	add    $0x1c,%esp
  802627:	5b                   	pop    %ebx
  802628:	5e                   	pop    %esi
  802629:	5f                   	pop    %edi
  80262a:	5d                   	pop    %ebp
  80262b:	c3                   	ret    
  80262c:	39 f0                	cmp    %esi,%eax
  80262e:	0f 87 ac 00 00 00    	ja     8026e0 <__umoddi3+0xfc>
  802634:	0f bd e8             	bsr    %eax,%ebp
  802637:	83 f5 1f             	xor    $0x1f,%ebp
  80263a:	0f 84 ac 00 00 00    	je     8026ec <__umoddi3+0x108>
  802640:	bf 20 00 00 00       	mov    $0x20,%edi
  802645:	29 ef                	sub    %ebp,%edi
  802647:	89 fe                	mov    %edi,%esi
  802649:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80264d:	89 e9                	mov    %ebp,%ecx
  80264f:	d3 e0                	shl    %cl,%eax
  802651:	89 d7                	mov    %edx,%edi
  802653:	89 f1                	mov    %esi,%ecx
  802655:	d3 ef                	shr    %cl,%edi
  802657:	09 c7                	or     %eax,%edi
  802659:	89 e9                	mov    %ebp,%ecx
  80265b:	d3 e2                	shl    %cl,%edx
  80265d:	89 14 24             	mov    %edx,(%esp)
  802660:	89 d8                	mov    %ebx,%eax
  802662:	d3 e0                	shl    %cl,%eax
  802664:	89 c2                	mov    %eax,%edx
  802666:	8b 44 24 08          	mov    0x8(%esp),%eax
  80266a:	d3 e0                	shl    %cl,%eax
  80266c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802670:	8b 44 24 08          	mov    0x8(%esp),%eax
  802674:	89 f1                	mov    %esi,%ecx
  802676:	d3 e8                	shr    %cl,%eax
  802678:	09 d0                	or     %edx,%eax
  80267a:	d3 eb                	shr    %cl,%ebx
  80267c:	89 da                	mov    %ebx,%edx
  80267e:	f7 f7                	div    %edi
  802680:	89 d3                	mov    %edx,%ebx
  802682:	f7 24 24             	mull   (%esp)
  802685:	89 c6                	mov    %eax,%esi
  802687:	89 d1                	mov    %edx,%ecx
  802689:	39 d3                	cmp    %edx,%ebx
  80268b:	0f 82 87 00 00 00    	jb     802718 <__umoddi3+0x134>
  802691:	0f 84 91 00 00 00    	je     802728 <__umoddi3+0x144>
  802697:	8b 54 24 04          	mov    0x4(%esp),%edx
  80269b:	29 f2                	sub    %esi,%edx
  80269d:	19 cb                	sbb    %ecx,%ebx
  80269f:	89 d8                	mov    %ebx,%eax
  8026a1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8026a5:	d3 e0                	shl    %cl,%eax
  8026a7:	89 e9                	mov    %ebp,%ecx
  8026a9:	d3 ea                	shr    %cl,%edx
  8026ab:	09 d0                	or     %edx,%eax
  8026ad:	89 e9                	mov    %ebp,%ecx
  8026af:	d3 eb                	shr    %cl,%ebx
  8026b1:	89 da                	mov    %ebx,%edx
  8026b3:	83 c4 1c             	add    $0x1c,%esp
  8026b6:	5b                   	pop    %ebx
  8026b7:	5e                   	pop    %esi
  8026b8:	5f                   	pop    %edi
  8026b9:	5d                   	pop    %ebp
  8026ba:	c3                   	ret    
  8026bb:	90                   	nop
  8026bc:	89 fd                	mov    %edi,%ebp
  8026be:	85 ff                	test   %edi,%edi
  8026c0:	75 0b                	jne    8026cd <__umoddi3+0xe9>
  8026c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8026c7:	31 d2                	xor    %edx,%edx
  8026c9:	f7 f7                	div    %edi
  8026cb:	89 c5                	mov    %eax,%ebp
  8026cd:	89 f0                	mov    %esi,%eax
  8026cf:	31 d2                	xor    %edx,%edx
  8026d1:	f7 f5                	div    %ebp
  8026d3:	89 c8                	mov    %ecx,%eax
  8026d5:	f7 f5                	div    %ebp
  8026d7:	89 d0                	mov    %edx,%eax
  8026d9:	e9 44 ff ff ff       	jmp    802622 <__umoddi3+0x3e>
  8026de:	66 90                	xchg   %ax,%ax
  8026e0:	89 c8                	mov    %ecx,%eax
  8026e2:	89 f2                	mov    %esi,%edx
  8026e4:	83 c4 1c             	add    $0x1c,%esp
  8026e7:	5b                   	pop    %ebx
  8026e8:	5e                   	pop    %esi
  8026e9:	5f                   	pop    %edi
  8026ea:	5d                   	pop    %ebp
  8026eb:	c3                   	ret    
  8026ec:	3b 04 24             	cmp    (%esp),%eax
  8026ef:	72 06                	jb     8026f7 <__umoddi3+0x113>
  8026f1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8026f5:	77 0f                	ja     802706 <__umoddi3+0x122>
  8026f7:	89 f2                	mov    %esi,%edx
  8026f9:	29 f9                	sub    %edi,%ecx
  8026fb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8026ff:	89 14 24             	mov    %edx,(%esp)
  802702:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802706:	8b 44 24 04          	mov    0x4(%esp),%eax
  80270a:	8b 14 24             	mov    (%esp),%edx
  80270d:	83 c4 1c             	add    $0x1c,%esp
  802710:	5b                   	pop    %ebx
  802711:	5e                   	pop    %esi
  802712:	5f                   	pop    %edi
  802713:	5d                   	pop    %ebp
  802714:	c3                   	ret    
  802715:	8d 76 00             	lea    0x0(%esi),%esi
  802718:	2b 04 24             	sub    (%esp),%eax
  80271b:	19 fa                	sbb    %edi,%edx
  80271d:	89 d1                	mov    %edx,%ecx
  80271f:	89 c6                	mov    %eax,%esi
  802721:	e9 71 ff ff ff       	jmp    802697 <__umoddi3+0xb3>
  802726:	66 90                	xchg   %ax,%ax
  802728:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80272c:	72 ea                	jb     802718 <__umoddi3+0x134>
  80272e:	89 d9                	mov    %ebx,%ecx
  802730:	e9 62 ff ff ff       	jmp    802697 <__umoddi3+0xb3>


obj/user/mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 8f 07 00 00       	call   8007c5 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_disable_interrupt();
  800041:	e8 64 21 00 00       	call   8021aa <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 40 28 80 00       	push   $0x802840
  80004e:	e8 59 0b 00 00       	call   800bac <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 42 28 80 00       	push   $0x802842
  80005e:	e8 49 0b 00 00       	call   800bac <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 58 28 80 00       	push   $0x802858
  80006e:	e8 39 0b 00 00       	call   800bac <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 42 28 80 00       	push   $0x802842
  80007e:	e8 29 0b 00 00       	call   800bac <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 40 28 80 00       	push   $0x802840
  80008e:	e8 19 0b 00 00       	call   800bac <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 70 28 80 00       	push   $0x802870
  8000a5:	e8 84 11 00 00       	call   80122e <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 d4 16 00 00       	call   801794 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 67 1a 00 00       	call   801b3c <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 90 28 80 00       	push   $0x802890
  8000e3:	e8 c4 0a 00 00       	call   800bac <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 b2 28 80 00       	push   $0x8028b2
  8000f3:	e8 b4 0a 00 00       	call   800bac <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 c0 28 80 00       	push   $0x8028c0
  800103:	e8 a4 0a 00 00       	call   800bac <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 cf 28 80 00       	push   $0x8028cf
  800113:	e8 94 0a 00 00       	call   800bac <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 df 28 80 00       	push   $0x8028df
  800123:	e8 84 0a 00 00       	call   800bac <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 3d 06 00 00       	call   80076d <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 e5 05 00 00       	call   800725 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 d8 05 00 00       	call   800725 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 5d 20 00 00       	call   8021c4 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80016b:	83 f8 62             	cmp    $0x62,%eax
  80016e:	74 1d                	je     80018d <_main+0x155>
  800170:	83 f8 63             	cmp    $0x63,%eax
  800173:	74 2b                	je     8001a0 <_main+0x168>
  800175:	83 f8 61             	cmp    $0x61,%eax
  800178:	75 39                	jne    8001b3 <_main+0x17b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 f0             	pushl  -0x10(%ebp)
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	e8 f4 01 00 00       	call   80037c <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 12 02 00 00       	call   8003ad <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 34 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 21 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	6a 01                	push   $0x1
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 e0 02 00 00       	call   8004b4 <MSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d7:	e8 ce 1f 00 00       	call   8021aa <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 e8 28 80 00       	push   $0x8028e8
  8001e4:	e8 c3 09 00 00       	call   800bac <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 d3 1f 00 00       	call   8021c4 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f1:	83 ec 08             	sub    $0x8,%esp
  8001f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001fa:	e8 d3 00 00 00       	call   8002d2 <CheckSorted>
  8001ff:	83 c4 10             	add    $0x10,%esp
  800202:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800205:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800209:	75 14                	jne    80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 1c 29 80 00       	push   $0x80291c
  800213:	6a 4a                	push   $0x4a
  800215:	68 3e 29 80 00       	push   $0x80293e
  80021a:	e8 eb 06 00 00       	call   80090a <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 86 1f 00 00       	call   8021aa <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 5c 29 80 00       	push   $0x80295c
  80022c:	e8 7b 09 00 00       	call   800bac <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 90 29 80 00       	push   $0x802990
  80023c:	e8 6b 09 00 00       	call   800bac <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 c4 29 80 00       	push   $0x8029c4
  80024c:	e8 5b 09 00 00       	call   800bac <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 6b 1f 00 00       	call   8021c4 <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 a0 1b 00 00       	call   801e04 <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 3e 1f 00 00       	call   8021aa <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 f6 29 80 00       	push   $0x8029f6
  80027a:	e8 2d 09 00 00       	call   800bac <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800282:	e8 e6 04 00 00       	call   80076d <getchar>
  800287:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80028a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 8e 04 00 00       	call   800725 <cputchar>
  800297:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	6a 0a                	push   $0xa
  80029f:	e8 81 04 00 00       	call   800725 <cputchar>
  8002a4:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a7:	83 ec 0c             	sub    $0xc,%esp
  8002aa:	6a 0a                	push   $0xa
  8002ac:	e8 74 04 00 00       	call   800725 <cputchar>
  8002b1:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002b4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b8:	74 06                	je     8002c0 <_main+0x288>
  8002ba:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002be:	75 b2                	jne    800272 <_main+0x23a>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002c0:	e8 ff 1e 00 00       	call   8021c4 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002c5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002c9:	0f 84 72 fd ff ff    	je     800041 <_main+0x9>

}
  8002cf:	90                   	nop
  8002d0:	c9                   	leave  
  8002d1:	c3                   	ret    

008002d2 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002d2:	55                   	push   %ebp
  8002d3:	89 e5                	mov    %esp,%ebp
  8002d5:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002d8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002e6:	eb 33                	jmp    80031b <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f5:	01 d0                	add    %edx,%eax
  8002f7:	8b 10                	mov    (%eax),%edx
  8002f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002fc:	40                   	inc    %eax
  8002fd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800304:	8b 45 08             	mov    0x8(%ebp),%eax
  800307:	01 c8                	add    %ecx,%eax
  800309:	8b 00                	mov    (%eax),%eax
  80030b:	39 c2                	cmp    %eax,%edx
  80030d:	7e 09                	jle    800318 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  80030f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800316:	eb 0c                	jmp    800324 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800318:	ff 45 f8             	incl   -0x8(%ebp)
  80031b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80031e:	48                   	dec    %eax
  80031f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800322:	7f c4                	jg     8002e8 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800324:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800327:	c9                   	leave  
  800328:	c3                   	ret    

00800329 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80032f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800339:	8b 45 08             	mov    0x8(%ebp),%eax
  80033c:	01 d0                	add    %edx,%eax
  80033e:	8b 00                	mov    (%eax),%eax
  800340:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800343:	8b 45 0c             	mov    0xc(%ebp),%eax
  800346:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034d:	8b 45 08             	mov    0x8(%ebp),%eax
  800350:	01 c2                	add    %eax,%edx
  800352:	8b 45 10             	mov    0x10(%ebp),%eax
  800355:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035c:	8b 45 08             	mov    0x8(%ebp),%eax
  80035f:	01 c8                	add    %ecx,%eax
  800361:	8b 00                	mov    (%eax),%eax
  800363:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800365:	8b 45 10             	mov    0x10(%ebp),%eax
  800368:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036f:	8b 45 08             	mov    0x8(%ebp),%eax
  800372:	01 c2                	add    %eax,%edx
  800374:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800377:	89 02                	mov    %eax,(%edx)
}
  800379:	90                   	nop
  80037a:	c9                   	leave  
  80037b:	c3                   	ret    

0080037c <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80037c:	55                   	push   %ebp
  80037d:	89 e5                	mov    %esp,%ebp
  80037f:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800382:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800389:	eb 17                	jmp    8003a2 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80038b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	01 c2                	add    %eax,%edx
  80039a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80039d:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80039f:	ff 45 fc             	incl   -0x4(%ebp)
  8003a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003a8:	7c e1                	jl     80038b <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003aa:	90                   	nop
  8003ab:	c9                   	leave  
  8003ac:	c3                   	ret    

008003ad <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8003ad:	55                   	push   %ebp
  8003ae:	89 e5                	mov    %esp,%ebp
  8003b0:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ba:	eb 1b                	jmp    8003d7 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	01 c2                	add    %eax,%edx
  8003cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ce:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003d1:	48                   	dec    %eax
  8003d2:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003d4:	ff 45 fc             	incl   -0x4(%ebp)
  8003d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003da:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003dd:	7c dd                	jl     8003bc <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003df:	90                   	nop
  8003e0:	c9                   	leave  
  8003e1:	c3                   	ret    

008003e2 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003eb:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003f0:	f7 e9                	imul   %ecx
  8003f2:	c1 f9 1f             	sar    $0x1f,%ecx
  8003f5:	89 d0                	mov    %edx,%eax
  8003f7:	29 c8                	sub    %ecx,%eax
  8003f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800403:	eb 1e                	jmp    800423 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800405:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800408:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040f:	8b 45 08             	mov    0x8(%ebp),%eax
  800412:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	99                   	cltd   
  800419:	f7 7d f8             	idivl  -0x8(%ebp)
  80041c:	89 d0                	mov    %edx,%eax
  80041e:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800420:	ff 45 fc             	incl   -0x4(%ebp)
  800423:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800426:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800429:	7c da                	jl     800405 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80042b:	90                   	nop
  80042c:	c9                   	leave  
  80042d:	c3                   	ret    

0080042e <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80042e:	55                   	push   %ebp
  80042f:	89 e5                	mov    %esp,%ebp
  800431:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800434:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80043b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800442:	eb 42                	jmp    800486 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800444:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800447:	99                   	cltd   
  800448:	f7 7d f0             	idivl  -0x10(%ebp)
  80044b:	89 d0                	mov    %edx,%eax
  80044d:	85 c0                	test   %eax,%eax
  80044f:	75 10                	jne    800461 <PrintElements+0x33>
			cprintf("\n");
  800451:	83 ec 0c             	sub    $0xc,%esp
  800454:	68 40 28 80 00       	push   $0x802840
  800459:	e8 4e 07 00 00       	call   800bac <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 14 2a 80 00       	push   $0x802a14
  80047b:	e8 2c 07 00 00       	call   800bac <cprintf>
  800480:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800483:	ff 45 f4             	incl   -0xc(%ebp)
  800486:	8b 45 0c             	mov    0xc(%ebp),%eax
  800489:	48                   	dec    %eax
  80048a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80048d:	7f b5                	jg     800444 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80048f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800492:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	01 d0                	add    %edx,%eax
  80049e:	8b 00                	mov    (%eax),%eax
  8004a0:	83 ec 08             	sub    $0x8,%esp
  8004a3:	50                   	push   %eax
  8004a4:	68 19 2a 80 00       	push   $0x802a19
  8004a9:	e8 fe 06 00 00       	call   800bac <cprintf>
  8004ae:	83 c4 10             	add    $0x10,%esp

}
  8004b1:	90                   	nop
  8004b2:	c9                   	leave  
  8004b3:	c3                   	ret    

008004b4 <MSort>:


void MSort(int* A, int p, int r)
{
  8004b4:	55                   	push   %ebp
  8004b5:	89 e5                	mov    %esp,%ebp
  8004b7:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004c0:	7d 54                	jge    800516 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c8:	01 d0                	add    %edx,%eax
  8004ca:	89 c2                	mov    %eax,%edx
  8004cc:	c1 ea 1f             	shr    $0x1f,%edx
  8004cf:	01 d0                	add    %edx,%eax
  8004d1:	d1 f8                	sar    %eax
  8004d3:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004d6:	83 ec 04             	sub    $0x4,%esp
  8004d9:	ff 75 f4             	pushl  -0xc(%ebp)
  8004dc:	ff 75 0c             	pushl  0xc(%ebp)
  8004df:	ff 75 08             	pushl  0x8(%ebp)
  8004e2:	e8 cd ff ff ff       	call   8004b4 <MSort>
  8004e7:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004ed:	40                   	inc    %eax
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	ff 75 10             	pushl  0x10(%ebp)
  8004f4:	50                   	push   %eax
  8004f5:	ff 75 08             	pushl  0x8(%ebp)
  8004f8:	e8 b7 ff ff ff       	call   8004b4 <MSort>
  8004fd:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800500:	ff 75 10             	pushl  0x10(%ebp)
  800503:	ff 75 f4             	pushl  -0xc(%ebp)
  800506:	ff 75 0c             	pushl  0xc(%ebp)
  800509:	ff 75 08             	pushl  0x8(%ebp)
  80050c:	e8 08 00 00 00       	call   800519 <Merge>
  800511:	83 c4 10             	add    $0x10,%esp
  800514:	eb 01                	jmp    800517 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800516:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800517:	c9                   	leave  
  800518:	c3                   	ret    

00800519 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800519:	55                   	push   %ebp
  80051a:	89 e5                	mov    %esp,%ebp
  80051c:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80051f:	8b 45 10             	mov    0x10(%ebp),%eax
  800522:	2b 45 0c             	sub    0xc(%ebp),%eax
  800525:	40                   	inc    %eax
  800526:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800529:	8b 45 14             	mov    0x14(%ebp),%eax
  80052c:	2b 45 10             	sub    0x10(%ebp),%eax
  80052f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800532:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800539:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	//cprintf("allocate LEFT\n");
	int* Left = malloc(sizeof(int) * leftCapacity);
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 ed 15 00 00       	call   801b3c <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 d8 15 00 00       	call   801b3c <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80056a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800571:	eb 2f                	jmp    8005a2 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800573:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800576:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80057d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800580:	01 c2                	add    %eax,%edx
  800582:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800585:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800588:	01 c8                	add    %ecx,%eax
  80058a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80058f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	01 c8                	add    %ecx,%eax
  80059b:	8b 00                	mov    (%eax),%eax
  80059d:	89 02                	mov    %eax,(%edx)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80059f:	ff 45 ec             	incl   -0x14(%ebp)
  8005a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005a5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005a8:	7c c9                	jl     800573 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005aa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005b1:	eb 2a                	jmp    8005dd <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005c0:	01 c2                	add    %eax,%edx
  8005c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005c8:	01 c8                	add    %ecx,%eax
  8005ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	01 c8                	add    %ecx,%eax
  8005d6:	8b 00                	mov    (%eax),%eax
  8005d8:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005da:	ff 45 e8             	incl   -0x18(%ebp)
  8005dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005e0:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005e3:	7c ce                	jl     8005b3 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005eb:	e9 0a 01 00 00       	jmp    8006fa <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005f6:	0f 8d 95 00 00 00    	jge    800691 <Merge+0x178>
  8005fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ff:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800602:	0f 8d 89 00 00 00    	jge    800691 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800608:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800612:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800615:	01 d0                	add    %edx,%eax
  800617:	8b 10                	mov    (%eax),%edx
  800619:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80061c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800623:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800626:	01 c8                	add    %ecx,%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	39 c2                	cmp    %eax,%edx
  80062c:	7d 33                	jge    800661 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80062e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800631:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800636:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063d:	8b 45 08             	mov    0x8(%ebp),%eax
  800640:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800643:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800646:	8d 50 01             	lea    0x1(%eax),%edx
  800649:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80064c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800653:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800656:	01 d0                	add    %edx,%eax
  800658:	8b 00                	mov    (%eax),%eax
  80065a:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80065c:	e9 96 00 00 00       	jmp    8006f7 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800661:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800664:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800669:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800676:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800679:	8d 50 01             	lea    0x1(%eax),%edx
  80067c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80067f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800686:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800689:	01 d0                	add    %edx,%eax
  80068b:	8b 00                	mov    (%eax),%eax
  80068d:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80068f:	eb 66                	jmp    8006f7 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800691:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800694:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800697:	7d 30                	jge    8006c9 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  800699:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80069c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006b1:	8d 50 01             	lea    0x1(%eax),%edx
  8006b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006be:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006c1:	01 d0                	add    %edx,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	89 01                	mov    %eax,(%ecx)
  8006c7:	eb 2e                	jmp    8006f7 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006cc:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e1:	8d 50 01             	lea    0x1(%eax),%edx
  8006e4:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006e7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ee:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006f1:	01 d0                	add    %edx,%eax
  8006f3:	8b 00                	mov    (%eax),%eax
  8006f5:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006f7:	ff 45 e4             	incl   -0x1c(%ebp)
  8006fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006fd:	3b 45 14             	cmp    0x14(%ebp),%eax
  800700:	0f 8e ea fe ff ff    	jle    8005f0 <Merge+0xd7>
			A[k - 1] = Right[rightIndex++];
		}
	}

	//cprintf("free LEFT\n");
	free(Left);
  800706:	83 ec 0c             	sub    $0xc,%esp
  800709:	ff 75 d8             	pushl  -0x28(%ebp)
  80070c:	e8 f3 16 00 00       	call   801e04 <free>
  800711:	83 c4 10             	add    $0x10,%esp
	//cprintf("free RIGHT\n");
	free(Right);
  800714:	83 ec 0c             	sub    $0xc,%esp
  800717:	ff 75 d4             	pushl  -0x2c(%ebp)
  80071a:	e8 e5 16 00 00       	call   801e04 <free>
  80071f:	83 c4 10             	add    $0x10,%esp

}
  800722:	90                   	nop
  800723:	c9                   	leave  
  800724:	c3                   	ret    

00800725 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800725:	55                   	push   %ebp
  800726:	89 e5                	mov    %esp,%ebp
  800728:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800731:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800735:	83 ec 0c             	sub    $0xc,%esp
  800738:	50                   	push   %eax
  800739:	e8 a0 1a 00 00       	call   8021de <sys_cputc>
  80073e:	83 c4 10             	add    $0x10,%esp
}
  800741:	90                   	nop
  800742:	c9                   	leave  
  800743:	c3                   	ret    

00800744 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800744:	55                   	push   %ebp
  800745:	89 e5                	mov    %esp,%ebp
  800747:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80074a:	e8 5b 1a 00 00       	call   8021aa <sys_disable_interrupt>
	char c = ch;
  80074f:	8b 45 08             	mov    0x8(%ebp),%eax
  800752:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800755:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800759:	83 ec 0c             	sub    $0xc,%esp
  80075c:	50                   	push   %eax
  80075d:	e8 7c 1a 00 00       	call   8021de <sys_cputc>
  800762:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800765:	e8 5a 1a 00 00       	call   8021c4 <sys_enable_interrupt>
}
  80076a:	90                   	nop
  80076b:	c9                   	leave  
  80076c:	c3                   	ret    

0080076d <getchar>:

int
getchar(void)
{
  80076d:	55                   	push   %ebp
  80076e:	89 e5                	mov    %esp,%ebp
  800770:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800773:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80077a:	eb 08                	jmp    800784 <getchar+0x17>
	{
		c = sys_cgetc();
  80077c:	e8 41 18 00 00       	call   801fc2 <sys_cgetc>
  800781:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800784:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800788:	74 f2                	je     80077c <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80078a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80078d:	c9                   	leave  
  80078e:	c3                   	ret    

0080078f <atomic_getchar>:

int
atomic_getchar(void)
{
  80078f:	55                   	push   %ebp
  800790:	89 e5                	mov    %esp,%ebp
  800792:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800795:	e8 10 1a 00 00       	call   8021aa <sys_disable_interrupt>
	int c=0;
  80079a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007a1:	eb 08                	jmp    8007ab <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8007a3:	e8 1a 18 00 00       	call   801fc2 <sys_cgetc>
  8007a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8007ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007af:	74 f2                	je     8007a3 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007b1:	e8 0e 1a 00 00       	call   8021c4 <sys_enable_interrupt>
	return c;
  8007b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007b9:	c9                   	leave  
  8007ba:	c3                   	ret    

008007bb <iscons>:

int iscons(int fdnum)
{
  8007bb:	55                   	push   %ebp
  8007bc:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007be:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007c3:	5d                   	pop    %ebp
  8007c4:	c3                   	ret    

008007c5 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007c5:	55                   	push   %ebp
  8007c6:	89 e5                	mov    %esp,%ebp
  8007c8:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007cb:	e8 3f 18 00 00       	call   80200f <sys_getenvindex>
  8007d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007d6:	89 d0                	mov    %edx,%eax
  8007d8:	c1 e0 03             	shl    $0x3,%eax
  8007db:	01 d0                	add    %edx,%eax
  8007dd:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007e4:	01 c8                	add    %ecx,%eax
  8007e6:	01 c0                	add    %eax,%eax
  8007e8:	01 d0                	add    %edx,%eax
  8007ea:	01 c0                	add    %eax,%eax
  8007ec:	01 d0                	add    %edx,%eax
  8007ee:	89 c2                	mov    %eax,%edx
  8007f0:	c1 e2 05             	shl    $0x5,%edx
  8007f3:	29 c2                	sub    %eax,%edx
  8007f5:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8007fc:	89 c2                	mov    %eax,%edx
  8007fe:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800804:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800809:	a1 24 30 80 00       	mov    0x803024,%eax
  80080e:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800814:	84 c0                	test   %al,%al
  800816:	74 0f                	je     800827 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800818:	a1 24 30 80 00       	mov    0x803024,%eax
  80081d:	05 40 3c 01 00       	add    $0x13c40,%eax
  800822:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800827:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80082b:	7e 0a                	jle    800837 <libmain+0x72>
		binaryname = argv[0];
  80082d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800830:	8b 00                	mov    (%eax),%eax
  800832:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800837:	83 ec 08             	sub    $0x8,%esp
  80083a:	ff 75 0c             	pushl  0xc(%ebp)
  80083d:	ff 75 08             	pushl  0x8(%ebp)
  800840:	e8 f3 f7 ff ff       	call   800038 <_main>
  800845:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800848:	e8 5d 19 00 00       	call   8021aa <sys_disable_interrupt>
	cprintf("**************************************\n");
  80084d:	83 ec 0c             	sub    $0xc,%esp
  800850:	68 38 2a 80 00       	push   $0x802a38
  800855:	e8 52 03 00 00       	call   800bac <cprintf>
  80085a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80085d:	a1 24 30 80 00       	mov    0x803024,%eax
  800862:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800868:	a1 24 30 80 00       	mov    0x803024,%eax
  80086d:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800873:	83 ec 04             	sub    $0x4,%esp
  800876:	52                   	push   %edx
  800877:	50                   	push   %eax
  800878:	68 60 2a 80 00       	push   $0x802a60
  80087d:	e8 2a 03 00 00       	call   800bac <cprintf>
  800882:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800885:	a1 24 30 80 00       	mov    0x803024,%eax
  80088a:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800890:	a1 24 30 80 00       	mov    0x803024,%eax
  800895:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80089b:	83 ec 04             	sub    $0x4,%esp
  80089e:	52                   	push   %edx
  80089f:	50                   	push   %eax
  8008a0:	68 88 2a 80 00       	push   $0x802a88
  8008a5:	e8 02 03 00 00       	call   800bac <cprintf>
  8008aa:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8008ad:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b2:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8008b8:	83 ec 08             	sub    $0x8,%esp
  8008bb:	50                   	push   %eax
  8008bc:	68 c9 2a 80 00       	push   $0x802ac9
  8008c1:	e8 e6 02 00 00       	call   800bac <cprintf>
  8008c6:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8008c9:	83 ec 0c             	sub    $0xc,%esp
  8008cc:	68 38 2a 80 00       	push   $0x802a38
  8008d1:	e8 d6 02 00 00       	call   800bac <cprintf>
  8008d6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008d9:	e8 e6 18 00 00       	call   8021c4 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008de:	e8 19 00 00 00       	call   8008fc <exit>
}
  8008e3:	90                   	nop
  8008e4:	c9                   	leave  
  8008e5:	c3                   	ret    

008008e6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008e6:	55                   	push   %ebp
  8008e7:	89 e5                	mov    %esp,%ebp
  8008e9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008ec:	83 ec 0c             	sub    $0xc,%esp
  8008ef:	6a 00                	push   $0x0
  8008f1:	e8 e5 16 00 00       	call   801fdb <sys_env_destroy>
  8008f6:	83 c4 10             	add    $0x10,%esp
}
  8008f9:	90                   	nop
  8008fa:	c9                   	leave  
  8008fb:	c3                   	ret    

008008fc <exit>:

void
exit(void)
{
  8008fc:	55                   	push   %ebp
  8008fd:	89 e5                	mov    %esp,%ebp
  8008ff:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800902:	e8 3a 17 00 00       	call   802041 <sys_env_exit>
}
  800907:	90                   	nop
  800908:	c9                   	leave  
  800909:	c3                   	ret    

0080090a <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80090a:	55                   	push   %ebp
  80090b:	89 e5                	mov    %esp,%ebp
  80090d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800910:	8d 45 10             	lea    0x10(%ebp),%eax
  800913:	83 c0 04             	add    $0x4,%eax
  800916:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800919:	a1 18 31 80 00       	mov    0x803118,%eax
  80091e:	85 c0                	test   %eax,%eax
  800920:	74 16                	je     800938 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800922:	a1 18 31 80 00       	mov    0x803118,%eax
  800927:	83 ec 08             	sub    $0x8,%esp
  80092a:	50                   	push   %eax
  80092b:	68 e0 2a 80 00       	push   $0x802ae0
  800930:	e8 77 02 00 00       	call   800bac <cprintf>
  800935:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800938:	a1 00 30 80 00       	mov    0x803000,%eax
  80093d:	ff 75 0c             	pushl  0xc(%ebp)
  800940:	ff 75 08             	pushl  0x8(%ebp)
  800943:	50                   	push   %eax
  800944:	68 e5 2a 80 00       	push   $0x802ae5
  800949:	e8 5e 02 00 00       	call   800bac <cprintf>
  80094e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800951:	8b 45 10             	mov    0x10(%ebp),%eax
  800954:	83 ec 08             	sub    $0x8,%esp
  800957:	ff 75 f4             	pushl  -0xc(%ebp)
  80095a:	50                   	push   %eax
  80095b:	e8 e1 01 00 00       	call   800b41 <vcprintf>
  800960:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800963:	83 ec 08             	sub    $0x8,%esp
  800966:	6a 00                	push   $0x0
  800968:	68 01 2b 80 00       	push   $0x802b01
  80096d:	e8 cf 01 00 00       	call   800b41 <vcprintf>
  800972:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800975:	e8 82 ff ff ff       	call   8008fc <exit>

	// should not return here
	while (1) ;
  80097a:	eb fe                	jmp    80097a <_panic+0x70>

0080097c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80097c:	55                   	push   %ebp
  80097d:	89 e5                	mov    %esp,%ebp
  80097f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800982:	a1 24 30 80 00       	mov    0x803024,%eax
  800987:	8b 50 74             	mov    0x74(%eax),%edx
  80098a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80098d:	39 c2                	cmp    %eax,%edx
  80098f:	74 14                	je     8009a5 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800991:	83 ec 04             	sub    $0x4,%esp
  800994:	68 04 2b 80 00       	push   $0x802b04
  800999:	6a 26                	push   $0x26
  80099b:	68 50 2b 80 00       	push   $0x802b50
  8009a0:	e8 65 ff ff ff       	call   80090a <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8009a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8009ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8009b3:	e9 b6 00 00 00       	jmp    800a6e <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8009b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009bb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c5:	01 d0                	add    %edx,%eax
  8009c7:	8b 00                	mov    (%eax),%eax
  8009c9:	85 c0                	test   %eax,%eax
  8009cb:	75 08                	jne    8009d5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009cd:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009d0:	e9 96 00 00 00       	jmp    800a6b <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8009d5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009dc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009e3:	eb 5d                	jmp    800a42 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009e5:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ea:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009f0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009f3:	c1 e2 04             	shl    $0x4,%edx
  8009f6:	01 d0                	add    %edx,%eax
  8009f8:	8a 40 04             	mov    0x4(%eax),%al
  8009fb:	84 c0                	test   %al,%al
  8009fd:	75 40                	jne    800a3f <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009ff:	a1 24 30 80 00       	mov    0x803024,%eax
  800a04:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a0a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a0d:	c1 e2 04             	shl    $0x4,%edx
  800a10:	01 d0                	add    %edx,%eax
  800a12:	8b 00                	mov    (%eax),%eax
  800a14:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a17:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a1a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a1f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a21:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a24:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2e:	01 c8                	add    %ecx,%eax
  800a30:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a32:	39 c2                	cmp    %eax,%edx
  800a34:	75 09                	jne    800a3f <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800a36:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a3d:	eb 12                	jmp    800a51 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a3f:	ff 45 e8             	incl   -0x18(%ebp)
  800a42:	a1 24 30 80 00       	mov    0x803024,%eax
  800a47:	8b 50 74             	mov    0x74(%eax),%edx
  800a4a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a4d:	39 c2                	cmp    %eax,%edx
  800a4f:	77 94                	ja     8009e5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a51:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a55:	75 14                	jne    800a6b <CheckWSWithoutLastIndex+0xef>
			panic(
  800a57:	83 ec 04             	sub    $0x4,%esp
  800a5a:	68 5c 2b 80 00       	push   $0x802b5c
  800a5f:	6a 3a                	push   $0x3a
  800a61:	68 50 2b 80 00       	push   $0x802b50
  800a66:	e8 9f fe ff ff       	call   80090a <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a6b:	ff 45 f0             	incl   -0x10(%ebp)
  800a6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a71:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a74:	0f 8c 3e ff ff ff    	jl     8009b8 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a7a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a81:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a88:	eb 20                	jmp    800aaa <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a8a:	a1 24 30 80 00       	mov    0x803024,%eax
  800a8f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a95:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a98:	c1 e2 04             	shl    $0x4,%edx
  800a9b:	01 d0                	add    %edx,%eax
  800a9d:	8a 40 04             	mov    0x4(%eax),%al
  800aa0:	3c 01                	cmp    $0x1,%al
  800aa2:	75 03                	jne    800aa7 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800aa4:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800aa7:	ff 45 e0             	incl   -0x20(%ebp)
  800aaa:	a1 24 30 80 00       	mov    0x803024,%eax
  800aaf:	8b 50 74             	mov    0x74(%eax),%edx
  800ab2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ab5:	39 c2                	cmp    %eax,%edx
  800ab7:	77 d1                	ja     800a8a <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800abc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800abf:	74 14                	je     800ad5 <CheckWSWithoutLastIndex+0x159>
		panic(
  800ac1:	83 ec 04             	sub    $0x4,%esp
  800ac4:	68 b0 2b 80 00       	push   $0x802bb0
  800ac9:	6a 44                	push   $0x44
  800acb:	68 50 2b 80 00       	push   $0x802b50
  800ad0:	e8 35 fe ff ff       	call   80090a <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ad5:	90                   	nop
  800ad6:	c9                   	leave  
  800ad7:	c3                   	ret    

00800ad8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ad8:	55                   	push   %ebp
  800ad9:	89 e5                	mov    %esp,%ebp
  800adb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ade:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae1:	8b 00                	mov    (%eax),%eax
  800ae3:	8d 48 01             	lea    0x1(%eax),%ecx
  800ae6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae9:	89 0a                	mov    %ecx,(%edx)
  800aeb:	8b 55 08             	mov    0x8(%ebp),%edx
  800aee:	88 d1                	mov    %dl,%cl
  800af0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800af7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afa:	8b 00                	mov    (%eax),%eax
  800afc:	3d ff 00 00 00       	cmp    $0xff,%eax
  800b01:	75 2c                	jne    800b2f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800b03:	a0 28 30 80 00       	mov    0x803028,%al
  800b08:	0f b6 c0             	movzbl %al,%eax
  800b0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0e:	8b 12                	mov    (%edx),%edx
  800b10:	89 d1                	mov    %edx,%ecx
  800b12:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b15:	83 c2 08             	add    $0x8,%edx
  800b18:	83 ec 04             	sub    $0x4,%esp
  800b1b:	50                   	push   %eax
  800b1c:	51                   	push   %ecx
  800b1d:	52                   	push   %edx
  800b1e:	e8 76 14 00 00       	call   801f99 <sys_cputs>
  800b23:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b29:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b32:	8b 40 04             	mov    0x4(%eax),%eax
  800b35:	8d 50 01             	lea    0x1(%eax),%edx
  800b38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3b:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b3e:	90                   	nop
  800b3f:	c9                   	leave  
  800b40:	c3                   	ret    

00800b41 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b41:	55                   	push   %ebp
  800b42:	89 e5                	mov    %esp,%ebp
  800b44:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b4a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b51:	00 00 00 
	b.cnt = 0;
  800b54:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b5b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b5e:	ff 75 0c             	pushl  0xc(%ebp)
  800b61:	ff 75 08             	pushl  0x8(%ebp)
  800b64:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b6a:	50                   	push   %eax
  800b6b:	68 d8 0a 80 00       	push   $0x800ad8
  800b70:	e8 11 02 00 00       	call   800d86 <vprintfmt>
  800b75:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b78:	a0 28 30 80 00       	mov    0x803028,%al
  800b7d:	0f b6 c0             	movzbl %al,%eax
  800b80:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b86:	83 ec 04             	sub    $0x4,%esp
  800b89:	50                   	push   %eax
  800b8a:	52                   	push   %edx
  800b8b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b91:	83 c0 08             	add    $0x8,%eax
  800b94:	50                   	push   %eax
  800b95:	e8 ff 13 00 00       	call   801f99 <sys_cputs>
  800b9a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b9d:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800ba4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800baa:	c9                   	leave  
  800bab:	c3                   	ret    

00800bac <cprintf>:

int cprintf(const char *fmt, ...) {
  800bac:	55                   	push   %ebp
  800bad:	89 e5                	mov    %esp,%ebp
  800baf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800bb2:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800bb9:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bbc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc2:	83 ec 08             	sub    $0x8,%esp
  800bc5:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc8:	50                   	push   %eax
  800bc9:	e8 73 ff ff ff       	call   800b41 <vcprintf>
  800bce:	83 c4 10             	add    $0x10,%esp
  800bd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bd7:	c9                   	leave  
  800bd8:	c3                   	ret    

00800bd9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bd9:	55                   	push   %ebp
  800bda:	89 e5                	mov    %esp,%ebp
  800bdc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bdf:	e8 c6 15 00 00       	call   8021aa <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800be4:	8d 45 0c             	lea    0xc(%ebp),%eax
  800be7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bea:	8b 45 08             	mov    0x8(%ebp),%eax
  800bed:	83 ec 08             	sub    $0x8,%esp
  800bf0:	ff 75 f4             	pushl  -0xc(%ebp)
  800bf3:	50                   	push   %eax
  800bf4:	e8 48 ff ff ff       	call   800b41 <vcprintf>
  800bf9:	83 c4 10             	add    $0x10,%esp
  800bfc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bff:	e8 c0 15 00 00       	call   8021c4 <sys_enable_interrupt>
	return cnt;
  800c04:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c07:	c9                   	leave  
  800c08:	c3                   	ret    

00800c09 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800c09:	55                   	push   %ebp
  800c0a:	89 e5                	mov    %esp,%ebp
  800c0c:	53                   	push   %ebx
  800c0d:	83 ec 14             	sub    $0x14,%esp
  800c10:	8b 45 10             	mov    0x10(%ebp),%eax
  800c13:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c16:	8b 45 14             	mov    0x14(%ebp),%eax
  800c19:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c1c:	8b 45 18             	mov    0x18(%ebp),%eax
  800c1f:	ba 00 00 00 00       	mov    $0x0,%edx
  800c24:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c27:	77 55                	ja     800c7e <printnum+0x75>
  800c29:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c2c:	72 05                	jb     800c33 <printnum+0x2a>
  800c2e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c31:	77 4b                	ja     800c7e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c33:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c36:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c39:	8b 45 18             	mov    0x18(%ebp),%eax
  800c3c:	ba 00 00 00 00       	mov    $0x0,%edx
  800c41:	52                   	push   %edx
  800c42:	50                   	push   %eax
  800c43:	ff 75 f4             	pushl  -0xc(%ebp)
  800c46:	ff 75 f0             	pushl  -0x10(%ebp)
  800c49:	e8 7e 19 00 00       	call   8025cc <__udivdi3>
  800c4e:	83 c4 10             	add    $0x10,%esp
  800c51:	83 ec 04             	sub    $0x4,%esp
  800c54:	ff 75 20             	pushl  0x20(%ebp)
  800c57:	53                   	push   %ebx
  800c58:	ff 75 18             	pushl  0x18(%ebp)
  800c5b:	52                   	push   %edx
  800c5c:	50                   	push   %eax
  800c5d:	ff 75 0c             	pushl  0xc(%ebp)
  800c60:	ff 75 08             	pushl  0x8(%ebp)
  800c63:	e8 a1 ff ff ff       	call   800c09 <printnum>
  800c68:	83 c4 20             	add    $0x20,%esp
  800c6b:	eb 1a                	jmp    800c87 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c6d:	83 ec 08             	sub    $0x8,%esp
  800c70:	ff 75 0c             	pushl  0xc(%ebp)
  800c73:	ff 75 20             	pushl  0x20(%ebp)
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
  800c79:	ff d0                	call   *%eax
  800c7b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c7e:	ff 4d 1c             	decl   0x1c(%ebp)
  800c81:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c85:	7f e6                	jg     800c6d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c87:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c8a:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c92:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c95:	53                   	push   %ebx
  800c96:	51                   	push   %ecx
  800c97:	52                   	push   %edx
  800c98:	50                   	push   %eax
  800c99:	e8 3e 1a 00 00       	call   8026dc <__umoddi3>
  800c9e:	83 c4 10             	add    $0x10,%esp
  800ca1:	05 14 2e 80 00       	add    $0x802e14,%eax
  800ca6:	8a 00                	mov    (%eax),%al
  800ca8:	0f be c0             	movsbl %al,%eax
  800cab:	83 ec 08             	sub    $0x8,%esp
  800cae:	ff 75 0c             	pushl  0xc(%ebp)
  800cb1:	50                   	push   %eax
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	ff d0                	call   *%eax
  800cb7:	83 c4 10             	add    $0x10,%esp
}
  800cba:	90                   	nop
  800cbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800cbe:	c9                   	leave  
  800cbf:	c3                   	ret    

00800cc0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800cc0:	55                   	push   %ebp
  800cc1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cc3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cc7:	7e 1c                	jle    800ce5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	8b 00                	mov    (%eax),%eax
  800cce:	8d 50 08             	lea    0x8(%eax),%edx
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	89 10                	mov    %edx,(%eax)
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	8b 00                	mov    (%eax),%eax
  800cdb:	83 e8 08             	sub    $0x8,%eax
  800cde:	8b 50 04             	mov    0x4(%eax),%edx
  800ce1:	8b 00                	mov    (%eax),%eax
  800ce3:	eb 40                	jmp    800d25 <getuint+0x65>
	else if (lflag)
  800ce5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ce9:	74 1e                	je     800d09 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	8b 00                	mov    (%eax),%eax
  800cf0:	8d 50 04             	lea    0x4(%eax),%edx
  800cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf6:	89 10                	mov    %edx,(%eax)
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfb:	8b 00                	mov    (%eax),%eax
  800cfd:	83 e8 04             	sub    $0x4,%eax
  800d00:	8b 00                	mov    (%eax),%eax
  800d02:	ba 00 00 00 00       	mov    $0x0,%edx
  800d07:	eb 1c                	jmp    800d25 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8b 00                	mov    (%eax),%eax
  800d0e:	8d 50 04             	lea    0x4(%eax),%edx
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	89 10                	mov    %edx,(%eax)
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8b 00                	mov    (%eax),%eax
  800d1b:	83 e8 04             	sub    $0x4,%eax
  800d1e:	8b 00                	mov    (%eax),%eax
  800d20:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d25:	5d                   	pop    %ebp
  800d26:	c3                   	ret    

00800d27 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d27:	55                   	push   %ebp
  800d28:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d2a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d2e:	7e 1c                	jle    800d4c <getint+0x25>
		return va_arg(*ap, long long);
  800d30:	8b 45 08             	mov    0x8(%ebp),%eax
  800d33:	8b 00                	mov    (%eax),%eax
  800d35:	8d 50 08             	lea    0x8(%eax),%edx
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	89 10                	mov    %edx,(%eax)
  800d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d40:	8b 00                	mov    (%eax),%eax
  800d42:	83 e8 08             	sub    $0x8,%eax
  800d45:	8b 50 04             	mov    0x4(%eax),%edx
  800d48:	8b 00                	mov    (%eax),%eax
  800d4a:	eb 38                	jmp    800d84 <getint+0x5d>
	else if (lflag)
  800d4c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d50:	74 1a                	je     800d6c <getint+0x45>
		return va_arg(*ap, long);
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8b 00                	mov    (%eax),%eax
  800d57:	8d 50 04             	lea    0x4(%eax),%edx
  800d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5d:	89 10                	mov    %edx,(%eax)
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	8b 00                	mov    (%eax),%eax
  800d64:	83 e8 04             	sub    $0x4,%eax
  800d67:	8b 00                	mov    (%eax),%eax
  800d69:	99                   	cltd   
  800d6a:	eb 18                	jmp    800d84 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	8b 00                	mov    (%eax),%eax
  800d71:	8d 50 04             	lea    0x4(%eax),%edx
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
  800d77:	89 10                	mov    %edx,(%eax)
  800d79:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7c:	8b 00                	mov    (%eax),%eax
  800d7e:	83 e8 04             	sub    $0x4,%eax
  800d81:	8b 00                	mov    (%eax),%eax
  800d83:	99                   	cltd   
}
  800d84:	5d                   	pop    %ebp
  800d85:	c3                   	ret    

00800d86 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d86:	55                   	push   %ebp
  800d87:	89 e5                	mov    %esp,%ebp
  800d89:	56                   	push   %esi
  800d8a:	53                   	push   %ebx
  800d8b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d8e:	eb 17                	jmp    800da7 <vprintfmt+0x21>
			if (ch == '\0')
  800d90:	85 db                	test   %ebx,%ebx
  800d92:	0f 84 af 03 00 00    	je     801147 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d98:	83 ec 08             	sub    $0x8,%esp
  800d9b:	ff 75 0c             	pushl  0xc(%ebp)
  800d9e:	53                   	push   %ebx
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	ff d0                	call   *%eax
  800da4:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800da7:	8b 45 10             	mov    0x10(%ebp),%eax
  800daa:	8d 50 01             	lea    0x1(%eax),%edx
  800dad:	89 55 10             	mov    %edx,0x10(%ebp)
  800db0:	8a 00                	mov    (%eax),%al
  800db2:	0f b6 d8             	movzbl %al,%ebx
  800db5:	83 fb 25             	cmp    $0x25,%ebx
  800db8:	75 d6                	jne    800d90 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800dba:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800dbe:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800dc5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800dcc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dd3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800dda:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddd:	8d 50 01             	lea    0x1(%eax),%edx
  800de0:	89 55 10             	mov    %edx,0x10(%ebp)
  800de3:	8a 00                	mov    (%eax),%al
  800de5:	0f b6 d8             	movzbl %al,%ebx
  800de8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800deb:	83 f8 55             	cmp    $0x55,%eax
  800dee:	0f 87 2b 03 00 00    	ja     80111f <vprintfmt+0x399>
  800df4:	8b 04 85 38 2e 80 00 	mov    0x802e38(,%eax,4),%eax
  800dfb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dfd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800e01:	eb d7                	jmp    800dda <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800e03:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800e07:	eb d1                	jmp    800dda <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e09:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e10:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e13:	89 d0                	mov    %edx,%eax
  800e15:	c1 e0 02             	shl    $0x2,%eax
  800e18:	01 d0                	add    %edx,%eax
  800e1a:	01 c0                	add    %eax,%eax
  800e1c:	01 d8                	add    %ebx,%eax
  800e1e:	83 e8 30             	sub    $0x30,%eax
  800e21:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e24:	8b 45 10             	mov    0x10(%ebp),%eax
  800e27:	8a 00                	mov    (%eax),%al
  800e29:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e2c:	83 fb 2f             	cmp    $0x2f,%ebx
  800e2f:	7e 3e                	jle    800e6f <vprintfmt+0xe9>
  800e31:	83 fb 39             	cmp    $0x39,%ebx
  800e34:	7f 39                	jg     800e6f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e36:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e39:	eb d5                	jmp    800e10 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e3b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e3e:	83 c0 04             	add    $0x4,%eax
  800e41:	89 45 14             	mov    %eax,0x14(%ebp)
  800e44:	8b 45 14             	mov    0x14(%ebp),%eax
  800e47:	83 e8 04             	sub    $0x4,%eax
  800e4a:	8b 00                	mov    (%eax),%eax
  800e4c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e4f:	eb 1f                	jmp    800e70 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e51:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e55:	79 83                	jns    800dda <vprintfmt+0x54>
				width = 0;
  800e57:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e5e:	e9 77 ff ff ff       	jmp    800dda <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e63:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e6a:	e9 6b ff ff ff       	jmp    800dda <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e6f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e70:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e74:	0f 89 60 ff ff ff    	jns    800dda <vprintfmt+0x54>
				width = precision, precision = -1;
  800e7a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e7d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e80:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e87:	e9 4e ff ff ff       	jmp    800dda <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e8c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e8f:	e9 46 ff ff ff       	jmp    800dda <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e94:	8b 45 14             	mov    0x14(%ebp),%eax
  800e97:	83 c0 04             	add    $0x4,%eax
  800e9a:	89 45 14             	mov    %eax,0x14(%ebp)
  800e9d:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea0:	83 e8 04             	sub    $0x4,%eax
  800ea3:	8b 00                	mov    (%eax),%eax
  800ea5:	83 ec 08             	sub    $0x8,%esp
  800ea8:	ff 75 0c             	pushl  0xc(%ebp)
  800eab:	50                   	push   %eax
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	ff d0                	call   *%eax
  800eb1:	83 c4 10             	add    $0x10,%esp
			break;
  800eb4:	e9 89 02 00 00       	jmp    801142 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800eb9:	8b 45 14             	mov    0x14(%ebp),%eax
  800ebc:	83 c0 04             	add    $0x4,%eax
  800ebf:	89 45 14             	mov    %eax,0x14(%ebp)
  800ec2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec5:	83 e8 04             	sub    $0x4,%eax
  800ec8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800eca:	85 db                	test   %ebx,%ebx
  800ecc:	79 02                	jns    800ed0 <vprintfmt+0x14a>
				err = -err;
  800ece:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ed0:	83 fb 64             	cmp    $0x64,%ebx
  800ed3:	7f 0b                	jg     800ee0 <vprintfmt+0x15a>
  800ed5:	8b 34 9d 80 2c 80 00 	mov    0x802c80(,%ebx,4),%esi
  800edc:	85 f6                	test   %esi,%esi
  800ede:	75 19                	jne    800ef9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ee0:	53                   	push   %ebx
  800ee1:	68 25 2e 80 00       	push   $0x802e25
  800ee6:	ff 75 0c             	pushl  0xc(%ebp)
  800ee9:	ff 75 08             	pushl  0x8(%ebp)
  800eec:	e8 5e 02 00 00       	call   80114f <printfmt>
  800ef1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ef4:	e9 49 02 00 00       	jmp    801142 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ef9:	56                   	push   %esi
  800efa:	68 2e 2e 80 00       	push   $0x802e2e
  800eff:	ff 75 0c             	pushl  0xc(%ebp)
  800f02:	ff 75 08             	pushl  0x8(%ebp)
  800f05:	e8 45 02 00 00       	call   80114f <printfmt>
  800f0a:	83 c4 10             	add    $0x10,%esp
			break;
  800f0d:	e9 30 02 00 00       	jmp    801142 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f12:	8b 45 14             	mov    0x14(%ebp),%eax
  800f15:	83 c0 04             	add    $0x4,%eax
  800f18:	89 45 14             	mov    %eax,0x14(%ebp)
  800f1b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1e:	83 e8 04             	sub    $0x4,%eax
  800f21:	8b 30                	mov    (%eax),%esi
  800f23:	85 f6                	test   %esi,%esi
  800f25:	75 05                	jne    800f2c <vprintfmt+0x1a6>
				p = "(null)";
  800f27:	be 31 2e 80 00       	mov    $0x802e31,%esi
			if (width > 0 && padc != '-')
  800f2c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f30:	7e 6d                	jle    800f9f <vprintfmt+0x219>
  800f32:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f36:	74 67                	je     800f9f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f38:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f3b:	83 ec 08             	sub    $0x8,%esp
  800f3e:	50                   	push   %eax
  800f3f:	56                   	push   %esi
  800f40:	e8 12 05 00 00       	call   801457 <strnlen>
  800f45:	83 c4 10             	add    $0x10,%esp
  800f48:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f4b:	eb 16                	jmp    800f63 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f4d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f51:	83 ec 08             	sub    $0x8,%esp
  800f54:	ff 75 0c             	pushl  0xc(%ebp)
  800f57:	50                   	push   %eax
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	ff d0                	call   *%eax
  800f5d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f60:	ff 4d e4             	decl   -0x1c(%ebp)
  800f63:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f67:	7f e4                	jg     800f4d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f69:	eb 34                	jmp    800f9f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f6b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f6f:	74 1c                	je     800f8d <vprintfmt+0x207>
  800f71:	83 fb 1f             	cmp    $0x1f,%ebx
  800f74:	7e 05                	jle    800f7b <vprintfmt+0x1f5>
  800f76:	83 fb 7e             	cmp    $0x7e,%ebx
  800f79:	7e 12                	jle    800f8d <vprintfmt+0x207>
					putch('?', putdat);
  800f7b:	83 ec 08             	sub    $0x8,%esp
  800f7e:	ff 75 0c             	pushl  0xc(%ebp)
  800f81:	6a 3f                	push   $0x3f
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	ff d0                	call   *%eax
  800f88:	83 c4 10             	add    $0x10,%esp
  800f8b:	eb 0f                	jmp    800f9c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f8d:	83 ec 08             	sub    $0x8,%esp
  800f90:	ff 75 0c             	pushl  0xc(%ebp)
  800f93:	53                   	push   %ebx
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	ff d0                	call   *%eax
  800f99:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f9c:	ff 4d e4             	decl   -0x1c(%ebp)
  800f9f:	89 f0                	mov    %esi,%eax
  800fa1:	8d 70 01             	lea    0x1(%eax),%esi
  800fa4:	8a 00                	mov    (%eax),%al
  800fa6:	0f be d8             	movsbl %al,%ebx
  800fa9:	85 db                	test   %ebx,%ebx
  800fab:	74 24                	je     800fd1 <vprintfmt+0x24b>
  800fad:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fb1:	78 b8                	js     800f6b <vprintfmt+0x1e5>
  800fb3:	ff 4d e0             	decl   -0x20(%ebp)
  800fb6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fba:	79 af                	jns    800f6b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fbc:	eb 13                	jmp    800fd1 <vprintfmt+0x24b>
				putch(' ', putdat);
  800fbe:	83 ec 08             	sub    $0x8,%esp
  800fc1:	ff 75 0c             	pushl  0xc(%ebp)
  800fc4:	6a 20                	push   $0x20
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	ff d0                	call   *%eax
  800fcb:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fce:	ff 4d e4             	decl   -0x1c(%ebp)
  800fd1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fd5:	7f e7                	jg     800fbe <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fd7:	e9 66 01 00 00       	jmp    801142 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fdc:	83 ec 08             	sub    $0x8,%esp
  800fdf:	ff 75 e8             	pushl  -0x18(%ebp)
  800fe2:	8d 45 14             	lea    0x14(%ebp),%eax
  800fe5:	50                   	push   %eax
  800fe6:	e8 3c fd ff ff       	call   800d27 <getint>
  800feb:	83 c4 10             	add    $0x10,%esp
  800fee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ff4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ff7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ffa:	85 d2                	test   %edx,%edx
  800ffc:	79 23                	jns    801021 <vprintfmt+0x29b>
				putch('-', putdat);
  800ffe:	83 ec 08             	sub    $0x8,%esp
  801001:	ff 75 0c             	pushl  0xc(%ebp)
  801004:	6a 2d                	push   $0x2d
  801006:	8b 45 08             	mov    0x8(%ebp),%eax
  801009:	ff d0                	call   *%eax
  80100b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80100e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801011:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801014:	f7 d8                	neg    %eax
  801016:	83 d2 00             	adc    $0x0,%edx
  801019:	f7 da                	neg    %edx
  80101b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80101e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801021:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801028:	e9 bc 00 00 00       	jmp    8010e9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80102d:	83 ec 08             	sub    $0x8,%esp
  801030:	ff 75 e8             	pushl  -0x18(%ebp)
  801033:	8d 45 14             	lea    0x14(%ebp),%eax
  801036:	50                   	push   %eax
  801037:	e8 84 fc ff ff       	call   800cc0 <getuint>
  80103c:	83 c4 10             	add    $0x10,%esp
  80103f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801042:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801045:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80104c:	e9 98 00 00 00       	jmp    8010e9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801051:	83 ec 08             	sub    $0x8,%esp
  801054:	ff 75 0c             	pushl  0xc(%ebp)
  801057:	6a 58                	push   $0x58
  801059:	8b 45 08             	mov    0x8(%ebp),%eax
  80105c:	ff d0                	call   *%eax
  80105e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801061:	83 ec 08             	sub    $0x8,%esp
  801064:	ff 75 0c             	pushl  0xc(%ebp)
  801067:	6a 58                	push   $0x58
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	ff d0                	call   *%eax
  80106e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801071:	83 ec 08             	sub    $0x8,%esp
  801074:	ff 75 0c             	pushl  0xc(%ebp)
  801077:	6a 58                	push   $0x58
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
  80107c:	ff d0                	call   *%eax
  80107e:	83 c4 10             	add    $0x10,%esp
			break;
  801081:	e9 bc 00 00 00       	jmp    801142 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801086:	83 ec 08             	sub    $0x8,%esp
  801089:	ff 75 0c             	pushl  0xc(%ebp)
  80108c:	6a 30                	push   $0x30
  80108e:	8b 45 08             	mov    0x8(%ebp),%eax
  801091:	ff d0                	call   *%eax
  801093:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801096:	83 ec 08             	sub    $0x8,%esp
  801099:	ff 75 0c             	pushl  0xc(%ebp)
  80109c:	6a 78                	push   $0x78
  80109e:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a1:	ff d0                	call   *%eax
  8010a3:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8010a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a9:	83 c0 04             	add    $0x4,%eax
  8010ac:	89 45 14             	mov    %eax,0x14(%ebp)
  8010af:	8b 45 14             	mov    0x14(%ebp),%eax
  8010b2:	83 e8 04             	sub    $0x4,%eax
  8010b5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8010b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010c1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010c8:	eb 1f                	jmp    8010e9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010ca:	83 ec 08             	sub    $0x8,%esp
  8010cd:	ff 75 e8             	pushl  -0x18(%ebp)
  8010d0:	8d 45 14             	lea    0x14(%ebp),%eax
  8010d3:	50                   	push   %eax
  8010d4:	e8 e7 fb ff ff       	call   800cc0 <getuint>
  8010d9:	83 c4 10             	add    $0x10,%esp
  8010dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010df:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010e2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010e9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010f0:	83 ec 04             	sub    $0x4,%esp
  8010f3:	52                   	push   %edx
  8010f4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010f7:	50                   	push   %eax
  8010f8:	ff 75 f4             	pushl  -0xc(%ebp)
  8010fb:	ff 75 f0             	pushl  -0x10(%ebp)
  8010fe:	ff 75 0c             	pushl  0xc(%ebp)
  801101:	ff 75 08             	pushl  0x8(%ebp)
  801104:	e8 00 fb ff ff       	call   800c09 <printnum>
  801109:	83 c4 20             	add    $0x20,%esp
			break;
  80110c:	eb 34                	jmp    801142 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80110e:	83 ec 08             	sub    $0x8,%esp
  801111:	ff 75 0c             	pushl  0xc(%ebp)
  801114:	53                   	push   %ebx
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	ff d0                	call   *%eax
  80111a:	83 c4 10             	add    $0x10,%esp
			break;
  80111d:	eb 23                	jmp    801142 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80111f:	83 ec 08             	sub    $0x8,%esp
  801122:	ff 75 0c             	pushl  0xc(%ebp)
  801125:	6a 25                	push   $0x25
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	ff d0                	call   *%eax
  80112c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80112f:	ff 4d 10             	decl   0x10(%ebp)
  801132:	eb 03                	jmp    801137 <vprintfmt+0x3b1>
  801134:	ff 4d 10             	decl   0x10(%ebp)
  801137:	8b 45 10             	mov    0x10(%ebp),%eax
  80113a:	48                   	dec    %eax
  80113b:	8a 00                	mov    (%eax),%al
  80113d:	3c 25                	cmp    $0x25,%al
  80113f:	75 f3                	jne    801134 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801141:	90                   	nop
		}
	}
  801142:	e9 47 fc ff ff       	jmp    800d8e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801147:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801148:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80114b:	5b                   	pop    %ebx
  80114c:	5e                   	pop    %esi
  80114d:	5d                   	pop    %ebp
  80114e:	c3                   	ret    

0080114f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80114f:	55                   	push   %ebp
  801150:	89 e5                	mov    %esp,%ebp
  801152:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801155:	8d 45 10             	lea    0x10(%ebp),%eax
  801158:	83 c0 04             	add    $0x4,%eax
  80115b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80115e:	8b 45 10             	mov    0x10(%ebp),%eax
  801161:	ff 75 f4             	pushl  -0xc(%ebp)
  801164:	50                   	push   %eax
  801165:	ff 75 0c             	pushl  0xc(%ebp)
  801168:	ff 75 08             	pushl  0x8(%ebp)
  80116b:	e8 16 fc ff ff       	call   800d86 <vprintfmt>
  801170:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801173:	90                   	nop
  801174:	c9                   	leave  
  801175:	c3                   	ret    

00801176 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801176:	55                   	push   %ebp
  801177:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801179:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117c:	8b 40 08             	mov    0x8(%eax),%eax
  80117f:	8d 50 01             	lea    0x1(%eax),%edx
  801182:	8b 45 0c             	mov    0xc(%ebp),%eax
  801185:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801188:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118b:	8b 10                	mov    (%eax),%edx
  80118d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801190:	8b 40 04             	mov    0x4(%eax),%eax
  801193:	39 c2                	cmp    %eax,%edx
  801195:	73 12                	jae    8011a9 <sprintputch+0x33>
		*b->buf++ = ch;
  801197:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119a:	8b 00                	mov    (%eax),%eax
  80119c:	8d 48 01             	lea    0x1(%eax),%ecx
  80119f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011a2:	89 0a                	mov    %ecx,(%edx)
  8011a4:	8b 55 08             	mov    0x8(%ebp),%edx
  8011a7:	88 10                	mov    %dl,(%eax)
}
  8011a9:	90                   	nop
  8011aa:	5d                   	pop    %ebp
  8011ab:	c3                   	ret    

008011ac <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8011ac:	55                   	push   %ebp
  8011ad:	89 e5                	mov    %esp,%ebp
  8011af:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	01 d0                	add    %edx,%eax
  8011c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011cd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011d1:	74 06                	je     8011d9 <vsnprintf+0x2d>
  8011d3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011d7:	7f 07                	jg     8011e0 <vsnprintf+0x34>
		return -E_INVAL;
  8011d9:	b8 03 00 00 00       	mov    $0x3,%eax
  8011de:	eb 20                	jmp    801200 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011e0:	ff 75 14             	pushl  0x14(%ebp)
  8011e3:	ff 75 10             	pushl  0x10(%ebp)
  8011e6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011e9:	50                   	push   %eax
  8011ea:	68 76 11 80 00       	push   $0x801176
  8011ef:	e8 92 fb ff ff       	call   800d86 <vprintfmt>
  8011f4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011fa:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801200:	c9                   	leave  
  801201:	c3                   	ret    

00801202 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801202:	55                   	push   %ebp
  801203:	89 e5                	mov    %esp,%ebp
  801205:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801208:	8d 45 10             	lea    0x10(%ebp),%eax
  80120b:	83 c0 04             	add    $0x4,%eax
  80120e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801211:	8b 45 10             	mov    0x10(%ebp),%eax
  801214:	ff 75 f4             	pushl  -0xc(%ebp)
  801217:	50                   	push   %eax
  801218:	ff 75 0c             	pushl  0xc(%ebp)
  80121b:	ff 75 08             	pushl  0x8(%ebp)
  80121e:	e8 89 ff ff ff       	call   8011ac <vsnprintf>
  801223:	83 c4 10             	add    $0x10,%esp
  801226:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801229:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80122c:	c9                   	leave  
  80122d:	c3                   	ret    

0080122e <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80122e:	55                   	push   %ebp
  80122f:	89 e5                	mov    %esp,%ebp
  801231:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801234:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801238:	74 13                	je     80124d <readline+0x1f>
		cprintf("%s", prompt);
  80123a:	83 ec 08             	sub    $0x8,%esp
  80123d:	ff 75 08             	pushl  0x8(%ebp)
  801240:	68 90 2f 80 00       	push   $0x802f90
  801245:	e8 62 f9 ff ff       	call   800bac <cprintf>
  80124a:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80124d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801254:	83 ec 0c             	sub    $0xc,%esp
  801257:	6a 00                	push   $0x0
  801259:	e8 5d f5 ff ff       	call   8007bb <iscons>
  80125e:	83 c4 10             	add    $0x10,%esp
  801261:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801264:	e8 04 f5 ff ff       	call   80076d <getchar>
  801269:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80126c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801270:	79 22                	jns    801294 <readline+0x66>
			if (c != -E_EOF)
  801272:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801276:	0f 84 ad 00 00 00    	je     801329 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80127c:	83 ec 08             	sub    $0x8,%esp
  80127f:	ff 75 ec             	pushl  -0x14(%ebp)
  801282:	68 93 2f 80 00       	push   $0x802f93
  801287:	e8 20 f9 ff ff       	call   800bac <cprintf>
  80128c:	83 c4 10             	add    $0x10,%esp
			return;
  80128f:	e9 95 00 00 00       	jmp    801329 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801294:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801298:	7e 34                	jle    8012ce <readline+0xa0>
  80129a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8012a1:	7f 2b                	jg     8012ce <readline+0xa0>
			if (echoing)
  8012a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012a7:	74 0e                	je     8012b7 <readline+0x89>
				cputchar(c);
  8012a9:	83 ec 0c             	sub    $0xc,%esp
  8012ac:	ff 75 ec             	pushl  -0x14(%ebp)
  8012af:	e8 71 f4 ff ff       	call   800725 <cputchar>
  8012b4:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012ba:	8d 50 01             	lea    0x1(%eax),%edx
  8012bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012c0:	89 c2                	mov    %eax,%edx
  8012c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c5:	01 d0                	add    %edx,%eax
  8012c7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012ca:	88 10                	mov    %dl,(%eax)
  8012cc:	eb 56                	jmp    801324 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012ce:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012d2:	75 1f                	jne    8012f3 <readline+0xc5>
  8012d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012d8:	7e 19                	jle    8012f3 <readline+0xc5>
			if (echoing)
  8012da:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012de:	74 0e                	je     8012ee <readline+0xc0>
				cputchar(c);
  8012e0:	83 ec 0c             	sub    $0xc,%esp
  8012e3:	ff 75 ec             	pushl  -0x14(%ebp)
  8012e6:	e8 3a f4 ff ff       	call   800725 <cputchar>
  8012eb:	83 c4 10             	add    $0x10,%esp

			i--;
  8012ee:	ff 4d f4             	decl   -0xc(%ebp)
  8012f1:	eb 31                	jmp    801324 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012f3:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012f7:	74 0a                	je     801303 <readline+0xd5>
  8012f9:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012fd:	0f 85 61 ff ff ff    	jne    801264 <readline+0x36>
			if (echoing)
  801303:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801307:	74 0e                	je     801317 <readline+0xe9>
				cputchar(c);
  801309:	83 ec 0c             	sub    $0xc,%esp
  80130c:	ff 75 ec             	pushl  -0x14(%ebp)
  80130f:	e8 11 f4 ff ff       	call   800725 <cputchar>
  801314:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801317:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80131a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131d:	01 d0                	add    %edx,%eax
  80131f:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801322:	eb 06                	jmp    80132a <readline+0xfc>
		}
	}
  801324:	e9 3b ff ff ff       	jmp    801264 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801329:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80132a:	c9                   	leave  
  80132b:	c3                   	ret    

0080132c <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
  80132f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801332:	e8 73 0e 00 00       	call   8021aa <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801337:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80133b:	74 13                	je     801350 <atomic_readline+0x24>
		cprintf("%s", prompt);
  80133d:	83 ec 08             	sub    $0x8,%esp
  801340:	ff 75 08             	pushl  0x8(%ebp)
  801343:	68 90 2f 80 00       	push   $0x802f90
  801348:	e8 5f f8 ff ff       	call   800bac <cprintf>
  80134d:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801350:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801357:	83 ec 0c             	sub    $0xc,%esp
  80135a:	6a 00                	push   $0x0
  80135c:	e8 5a f4 ff ff       	call   8007bb <iscons>
  801361:	83 c4 10             	add    $0x10,%esp
  801364:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801367:	e8 01 f4 ff ff       	call   80076d <getchar>
  80136c:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80136f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801373:	79 23                	jns    801398 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801375:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801379:	74 13                	je     80138e <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80137b:	83 ec 08             	sub    $0x8,%esp
  80137e:	ff 75 ec             	pushl  -0x14(%ebp)
  801381:	68 93 2f 80 00       	push   $0x802f93
  801386:	e8 21 f8 ff ff       	call   800bac <cprintf>
  80138b:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80138e:	e8 31 0e 00 00       	call   8021c4 <sys_enable_interrupt>
			return;
  801393:	e9 9a 00 00 00       	jmp    801432 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801398:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80139c:	7e 34                	jle    8013d2 <atomic_readline+0xa6>
  80139e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8013a5:	7f 2b                	jg     8013d2 <atomic_readline+0xa6>
			if (echoing)
  8013a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013ab:	74 0e                	je     8013bb <atomic_readline+0x8f>
				cputchar(c);
  8013ad:	83 ec 0c             	sub    $0xc,%esp
  8013b0:	ff 75 ec             	pushl  -0x14(%ebp)
  8013b3:	e8 6d f3 ff ff       	call   800725 <cputchar>
  8013b8:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8013bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013be:	8d 50 01             	lea    0x1(%eax),%edx
  8013c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013c4:	89 c2                	mov    %eax,%edx
  8013c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c9:	01 d0                	add    %edx,%eax
  8013cb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013ce:	88 10                	mov    %dl,(%eax)
  8013d0:	eb 5b                	jmp    80142d <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013d2:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013d6:	75 1f                	jne    8013f7 <atomic_readline+0xcb>
  8013d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013dc:	7e 19                	jle    8013f7 <atomic_readline+0xcb>
			if (echoing)
  8013de:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013e2:	74 0e                	je     8013f2 <atomic_readline+0xc6>
				cputchar(c);
  8013e4:	83 ec 0c             	sub    $0xc,%esp
  8013e7:	ff 75 ec             	pushl  -0x14(%ebp)
  8013ea:	e8 36 f3 ff ff       	call   800725 <cputchar>
  8013ef:	83 c4 10             	add    $0x10,%esp
			i--;
  8013f2:	ff 4d f4             	decl   -0xc(%ebp)
  8013f5:	eb 36                	jmp    80142d <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013f7:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013fb:	74 0a                	je     801407 <atomic_readline+0xdb>
  8013fd:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801401:	0f 85 60 ff ff ff    	jne    801367 <atomic_readline+0x3b>
			if (echoing)
  801407:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80140b:	74 0e                	je     80141b <atomic_readline+0xef>
				cputchar(c);
  80140d:	83 ec 0c             	sub    $0xc,%esp
  801410:	ff 75 ec             	pushl  -0x14(%ebp)
  801413:	e8 0d f3 ff ff       	call   800725 <cputchar>
  801418:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80141b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80141e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801421:	01 d0                	add    %edx,%eax
  801423:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801426:	e8 99 0d 00 00       	call   8021c4 <sys_enable_interrupt>
			return;
  80142b:	eb 05                	jmp    801432 <atomic_readline+0x106>
		}
	}
  80142d:	e9 35 ff ff ff       	jmp    801367 <atomic_readline+0x3b>
}
  801432:	c9                   	leave  
  801433:	c3                   	ret    

00801434 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801434:	55                   	push   %ebp
  801435:	89 e5                	mov    %esp,%ebp
  801437:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80143a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801441:	eb 06                	jmp    801449 <strlen+0x15>
		n++;
  801443:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801446:	ff 45 08             	incl   0x8(%ebp)
  801449:	8b 45 08             	mov    0x8(%ebp),%eax
  80144c:	8a 00                	mov    (%eax),%al
  80144e:	84 c0                	test   %al,%al
  801450:	75 f1                	jne    801443 <strlen+0xf>
		n++;
	return n;
  801452:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801455:	c9                   	leave  
  801456:	c3                   	ret    

00801457 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801457:	55                   	push   %ebp
  801458:	89 e5                	mov    %esp,%ebp
  80145a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80145d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801464:	eb 09                	jmp    80146f <strnlen+0x18>
		n++;
  801466:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801469:	ff 45 08             	incl   0x8(%ebp)
  80146c:	ff 4d 0c             	decl   0xc(%ebp)
  80146f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801473:	74 09                	je     80147e <strnlen+0x27>
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
  801478:	8a 00                	mov    (%eax),%al
  80147a:	84 c0                	test   %al,%al
  80147c:	75 e8                	jne    801466 <strnlen+0xf>
		n++;
	return n;
  80147e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801481:	c9                   	leave  
  801482:	c3                   	ret    

00801483 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
  801486:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80148f:	90                   	nop
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	8d 50 01             	lea    0x1(%eax),%edx
  801496:	89 55 08             	mov    %edx,0x8(%ebp)
  801499:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80149f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014a2:	8a 12                	mov    (%edx),%dl
  8014a4:	88 10                	mov    %dl,(%eax)
  8014a6:	8a 00                	mov    (%eax),%al
  8014a8:	84 c0                	test   %al,%al
  8014aa:	75 e4                	jne    801490 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8014ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
  8014b4:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8014b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8014bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014c4:	eb 1f                	jmp    8014e5 <strncpy+0x34>
		*dst++ = *src;
  8014c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c9:	8d 50 01             	lea    0x1(%eax),%edx
  8014cc:	89 55 08             	mov    %edx,0x8(%ebp)
  8014cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014d2:	8a 12                	mov    (%edx),%dl
  8014d4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d9:	8a 00                	mov    (%eax),%al
  8014db:	84 c0                	test   %al,%al
  8014dd:	74 03                	je     8014e2 <strncpy+0x31>
			src++;
  8014df:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014e2:	ff 45 fc             	incl   -0x4(%ebp)
  8014e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014eb:	72 d9                	jb     8014c6 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014f0:	c9                   	leave  
  8014f1:	c3                   	ret    

008014f2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014f2:	55                   	push   %ebp
  8014f3:	89 e5                	mov    %esp,%ebp
  8014f5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014fe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801502:	74 30                	je     801534 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801504:	eb 16                	jmp    80151c <strlcpy+0x2a>
			*dst++ = *src++;
  801506:	8b 45 08             	mov    0x8(%ebp),%eax
  801509:	8d 50 01             	lea    0x1(%eax),%edx
  80150c:	89 55 08             	mov    %edx,0x8(%ebp)
  80150f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801512:	8d 4a 01             	lea    0x1(%edx),%ecx
  801515:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801518:	8a 12                	mov    (%edx),%dl
  80151a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80151c:	ff 4d 10             	decl   0x10(%ebp)
  80151f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801523:	74 09                	je     80152e <strlcpy+0x3c>
  801525:	8b 45 0c             	mov    0xc(%ebp),%eax
  801528:	8a 00                	mov    (%eax),%al
  80152a:	84 c0                	test   %al,%al
  80152c:	75 d8                	jne    801506 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80152e:	8b 45 08             	mov    0x8(%ebp),%eax
  801531:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801534:	8b 55 08             	mov    0x8(%ebp),%edx
  801537:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153a:	29 c2                	sub    %eax,%edx
  80153c:	89 d0                	mov    %edx,%eax
}
  80153e:	c9                   	leave  
  80153f:	c3                   	ret    

00801540 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801540:	55                   	push   %ebp
  801541:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801543:	eb 06                	jmp    80154b <strcmp+0xb>
		p++, q++;
  801545:	ff 45 08             	incl   0x8(%ebp)
  801548:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	8a 00                	mov    (%eax),%al
  801550:	84 c0                	test   %al,%al
  801552:	74 0e                	je     801562 <strcmp+0x22>
  801554:	8b 45 08             	mov    0x8(%ebp),%eax
  801557:	8a 10                	mov    (%eax),%dl
  801559:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155c:	8a 00                	mov    (%eax),%al
  80155e:	38 c2                	cmp    %al,%dl
  801560:	74 e3                	je     801545 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801562:	8b 45 08             	mov    0x8(%ebp),%eax
  801565:	8a 00                	mov    (%eax),%al
  801567:	0f b6 d0             	movzbl %al,%edx
  80156a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156d:	8a 00                	mov    (%eax),%al
  80156f:	0f b6 c0             	movzbl %al,%eax
  801572:	29 c2                	sub    %eax,%edx
  801574:	89 d0                	mov    %edx,%eax
}
  801576:	5d                   	pop    %ebp
  801577:	c3                   	ret    

00801578 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80157b:	eb 09                	jmp    801586 <strncmp+0xe>
		n--, p++, q++;
  80157d:	ff 4d 10             	decl   0x10(%ebp)
  801580:	ff 45 08             	incl   0x8(%ebp)
  801583:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801586:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80158a:	74 17                	je     8015a3 <strncmp+0x2b>
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	8a 00                	mov    (%eax),%al
  801591:	84 c0                	test   %al,%al
  801593:	74 0e                	je     8015a3 <strncmp+0x2b>
  801595:	8b 45 08             	mov    0x8(%ebp),%eax
  801598:	8a 10                	mov    (%eax),%dl
  80159a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159d:	8a 00                	mov    (%eax),%al
  80159f:	38 c2                	cmp    %al,%dl
  8015a1:	74 da                	je     80157d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8015a3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015a7:	75 07                	jne    8015b0 <strncmp+0x38>
		return 0;
  8015a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8015ae:	eb 14                	jmp    8015c4 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8015b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b3:	8a 00                	mov    (%eax),%al
  8015b5:	0f b6 d0             	movzbl %al,%edx
  8015b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bb:	8a 00                	mov    (%eax),%al
  8015bd:	0f b6 c0             	movzbl %al,%eax
  8015c0:	29 c2                	sub    %eax,%edx
  8015c2:	89 d0                	mov    %edx,%eax
}
  8015c4:	5d                   	pop    %ebp
  8015c5:	c3                   	ret    

008015c6 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015c6:	55                   	push   %ebp
  8015c7:	89 e5                	mov    %esp,%ebp
  8015c9:	83 ec 04             	sub    $0x4,%esp
  8015cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015d2:	eb 12                	jmp    8015e6 <strchr+0x20>
		if (*s == c)
  8015d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d7:	8a 00                	mov    (%eax),%al
  8015d9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015dc:	75 05                	jne    8015e3 <strchr+0x1d>
			return (char *) s;
  8015de:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e1:	eb 11                	jmp    8015f4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015e3:	ff 45 08             	incl   0x8(%ebp)
  8015e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e9:	8a 00                	mov    (%eax),%al
  8015eb:	84 c0                	test   %al,%al
  8015ed:	75 e5                	jne    8015d4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015f4:	c9                   	leave  
  8015f5:	c3                   	ret    

008015f6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015f6:	55                   	push   %ebp
  8015f7:	89 e5                	mov    %esp,%ebp
  8015f9:	83 ec 04             	sub    $0x4,%esp
  8015fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ff:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801602:	eb 0d                	jmp    801611 <strfind+0x1b>
		if (*s == c)
  801604:	8b 45 08             	mov    0x8(%ebp),%eax
  801607:	8a 00                	mov    (%eax),%al
  801609:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80160c:	74 0e                	je     80161c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80160e:	ff 45 08             	incl   0x8(%ebp)
  801611:	8b 45 08             	mov    0x8(%ebp),%eax
  801614:	8a 00                	mov    (%eax),%al
  801616:	84 c0                	test   %al,%al
  801618:	75 ea                	jne    801604 <strfind+0xe>
  80161a:	eb 01                	jmp    80161d <strfind+0x27>
		if (*s == c)
			break;
  80161c:	90                   	nop
	return (char *) s;
  80161d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801620:	c9                   	leave  
  801621:	c3                   	ret    

00801622 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801622:	55                   	push   %ebp
  801623:	89 e5                	mov    %esp,%ebp
  801625:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80162e:	8b 45 10             	mov    0x10(%ebp),%eax
  801631:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801634:	eb 0e                	jmp    801644 <memset+0x22>
		*p++ = c;
  801636:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801639:	8d 50 01             	lea    0x1(%eax),%edx
  80163c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80163f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801642:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801644:	ff 4d f8             	decl   -0x8(%ebp)
  801647:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80164b:	79 e9                	jns    801636 <memset+0x14>
		*p++ = c;

	return v;
  80164d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801650:	c9                   	leave  
  801651:	c3                   	ret    

00801652 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801652:	55                   	push   %ebp
  801653:	89 e5                	mov    %esp,%ebp
  801655:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801658:	8b 45 0c             	mov    0xc(%ebp),%eax
  80165b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801664:	eb 16                	jmp    80167c <memcpy+0x2a>
		*d++ = *s++;
  801666:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801669:	8d 50 01             	lea    0x1(%eax),%edx
  80166c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80166f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801672:	8d 4a 01             	lea    0x1(%edx),%ecx
  801675:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801678:	8a 12                	mov    (%edx),%dl
  80167a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80167c:	8b 45 10             	mov    0x10(%ebp),%eax
  80167f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801682:	89 55 10             	mov    %edx,0x10(%ebp)
  801685:	85 c0                	test   %eax,%eax
  801687:	75 dd                	jne    801666 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801689:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80168c:	c9                   	leave  
  80168d:	c3                   	ret    

0080168e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80168e:	55                   	push   %ebp
  80168f:	89 e5                	mov    %esp,%ebp
  801691:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801694:	8b 45 0c             	mov    0xc(%ebp),%eax
  801697:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80169a:	8b 45 08             	mov    0x8(%ebp),%eax
  80169d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8016a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016a6:	73 50                	jae    8016f8 <memmove+0x6a>
  8016a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ae:	01 d0                	add    %edx,%eax
  8016b0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016b3:	76 43                	jbe    8016f8 <memmove+0x6a>
		s += n;
  8016b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b8:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8016bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8016be:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016c1:	eb 10                	jmp    8016d3 <memmove+0x45>
			*--d = *--s;
  8016c3:	ff 4d f8             	decl   -0x8(%ebp)
  8016c6:	ff 4d fc             	decl   -0x4(%ebp)
  8016c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016cc:	8a 10                	mov    (%eax),%dl
  8016ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016d9:	89 55 10             	mov    %edx,0x10(%ebp)
  8016dc:	85 c0                	test   %eax,%eax
  8016de:	75 e3                	jne    8016c3 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016e0:	eb 23                	jmp    801705 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e5:	8d 50 01             	lea    0x1(%eax),%edx
  8016e8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ee:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016f1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016f4:	8a 12                	mov    (%edx),%dl
  8016f6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8016fb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016fe:	89 55 10             	mov    %edx,0x10(%ebp)
  801701:	85 c0                	test   %eax,%eax
  801703:	75 dd                	jne    8016e2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801705:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
  80170d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801710:	8b 45 08             	mov    0x8(%ebp),%eax
  801713:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801716:	8b 45 0c             	mov    0xc(%ebp),%eax
  801719:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80171c:	eb 2a                	jmp    801748 <memcmp+0x3e>
		if (*s1 != *s2)
  80171e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801721:	8a 10                	mov    (%eax),%dl
  801723:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801726:	8a 00                	mov    (%eax),%al
  801728:	38 c2                	cmp    %al,%dl
  80172a:	74 16                	je     801742 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80172c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80172f:	8a 00                	mov    (%eax),%al
  801731:	0f b6 d0             	movzbl %al,%edx
  801734:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801737:	8a 00                	mov    (%eax),%al
  801739:	0f b6 c0             	movzbl %al,%eax
  80173c:	29 c2                	sub    %eax,%edx
  80173e:	89 d0                	mov    %edx,%eax
  801740:	eb 18                	jmp    80175a <memcmp+0x50>
		s1++, s2++;
  801742:	ff 45 fc             	incl   -0x4(%ebp)
  801745:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801748:	8b 45 10             	mov    0x10(%ebp),%eax
  80174b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80174e:	89 55 10             	mov    %edx,0x10(%ebp)
  801751:	85 c0                	test   %eax,%eax
  801753:	75 c9                	jne    80171e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801755:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80175a:	c9                   	leave  
  80175b:	c3                   	ret    

0080175c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80175c:	55                   	push   %ebp
  80175d:	89 e5                	mov    %esp,%ebp
  80175f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801762:	8b 55 08             	mov    0x8(%ebp),%edx
  801765:	8b 45 10             	mov    0x10(%ebp),%eax
  801768:	01 d0                	add    %edx,%eax
  80176a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80176d:	eb 15                	jmp    801784 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80176f:	8b 45 08             	mov    0x8(%ebp),%eax
  801772:	8a 00                	mov    (%eax),%al
  801774:	0f b6 d0             	movzbl %al,%edx
  801777:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177a:	0f b6 c0             	movzbl %al,%eax
  80177d:	39 c2                	cmp    %eax,%edx
  80177f:	74 0d                	je     80178e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801781:	ff 45 08             	incl   0x8(%ebp)
  801784:	8b 45 08             	mov    0x8(%ebp),%eax
  801787:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80178a:	72 e3                	jb     80176f <memfind+0x13>
  80178c:	eb 01                	jmp    80178f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80178e:	90                   	nop
	return (void *) s;
  80178f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801792:	c9                   	leave  
  801793:	c3                   	ret    

00801794 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801794:	55                   	push   %ebp
  801795:	89 e5                	mov    %esp,%ebp
  801797:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80179a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8017a1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017a8:	eb 03                	jmp    8017ad <strtol+0x19>
		s++;
  8017aa:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b0:	8a 00                	mov    (%eax),%al
  8017b2:	3c 20                	cmp    $0x20,%al
  8017b4:	74 f4                	je     8017aa <strtol+0x16>
  8017b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b9:	8a 00                	mov    (%eax),%al
  8017bb:	3c 09                	cmp    $0x9,%al
  8017bd:	74 eb                	je     8017aa <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8017bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c2:	8a 00                	mov    (%eax),%al
  8017c4:	3c 2b                	cmp    $0x2b,%al
  8017c6:	75 05                	jne    8017cd <strtol+0x39>
		s++;
  8017c8:	ff 45 08             	incl   0x8(%ebp)
  8017cb:	eb 13                	jmp    8017e0 <strtol+0x4c>
	else if (*s == '-')
  8017cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d0:	8a 00                	mov    (%eax),%al
  8017d2:	3c 2d                	cmp    $0x2d,%al
  8017d4:	75 0a                	jne    8017e0 <strtol+0x4c>
		s++, neg = 1;
  8017d6:	ff 45 08             	incl   0x8(%ebp)
  8017d9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017e4:	74 06                	je     8017ec <strtol+0x58>
  8017e6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017ea:	75 20                	jne    80180c <strtol+0x78>
  8017ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ef:	8a 00                	mov    (%eax),%al
  8017f1:	3c 30                	cmp    $0x30,%al
  8017f3:	75 17                	jne    80180c <strtol+0x78>
  8017f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f8:	40                   	inc    %eax
  8017f9:	8a 00                	mov    (%eax),%al
  8017fb:	3c 78                	cmp    $0x78,%al
  8017fd:	75 0d                	jne    80180c <strtol+0x78>
		s += 2, base = 16;
  8017ff:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801803:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80180a:	eb 28                	jmp    801834 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80180c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801810:	75 15                	jne    801827 <strtol+0x93>
  801812:	8b 45 08             	mov    0x8(%ebp),%eax
  801815:	8a 00                	mov    (%eax),%al
  801817:	3c 30                	cmp    $0x30,%al
  801819:	75 0c                	jne    801827 <strtol+0x93>
		s++, base = 8;
  80181b:	ff 45 08             	incl   0x8(%ebp)
  80181e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801825:	eb 0d                	jmp    801834 <strtol+0xa0>
	else if (base == 0)
  801827:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80182b:	75 07                	jne    801834 <strtol+0xa0>
		base = 10;
  80182d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801834:	8b 45 08             	mov    0x8(%ebp),%eax
  801837:	8a 00                	mov    (%eax),%al
  801839:	3c 2f                	cmp    $0x2f,%al
  80183b:	7e 19                	jle    801856 <strtol+0xc2>
  80183d:	8b 45 08             	mov    0x8(%ebp),%eax
  801840:	8a 00                	mov    (%eax),%al
  801842:	3c 39                	cmp    $0x39,%al
  801844:	7f 10                	jg     801856 <strtol+0xc2>
			dig = *s - '0';
  801846:	8b 45 08             	mov    0x8(%ebp),%eax
  801849:	8a 00                	mov    (%eax),%al
  80184b:	0f be c0             	movsbl %al,%eax
  80184e:	83 e8 30             	sub    $0x30,%eax
  801851:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801854:	eb 42                	jmp    801898 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801856:	8b 45 08             	mov    0x8(%ebp),%eax
  801859:	8a 00                	mov    (%eax),%al
  80185b:	3c 60                	cmp    $0x60,%al
  80185d:	7e 19                	jle    801878 <strtol+0xe4>
  80185f:	8b 45 08             	mov    0x8(%ebp),%eax
  801862:	8a 00                	mov    (%eax),%al
  801864:	3c 7a                	cmp    $0x7a,%al
  801866:	7f 10                	jg     801878 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801868:	8b 45 08             	mov    0x8(%ebp),%eax
  80186b:	8a 00                	mov    (%eax),%al
  80186d:	0f be c0             	movsbl %al,%eax
  801870:	83 e8 57             	sub    $0x57,%eax
  801873:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801876:	eb 20                	jmp    801898 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801878:	8b 45 08             	mov    0x8(%ebp),%eax
  80187b:	8a 00                	mov    (%eax),%al
  80187d:	3c 40                	cmp    $0x40,%al
  80187f:	7e 39                	jle    8018ba <strtol+0x126>
  801881:	8b 45 08             	mov    0x8(%ebp),%eax
  801884:	8a 00                	mov    (%eax),%al
  801886:	3c 5a                	cmp    $0x5a,%al
  801888:	7f 30                	jg     8018ba <strtol+0x126>
			dig = *s - 'A' + 10;
  80188a:	8b 45 08             	mov    0x8(%ebp),%eax
  80188d:	8a 00                	mov    (%eax),%al
  80188f:	0f be c0             	movsbl %al,%eax
  801892:	83 e8 37             	sub    $0x37,%eax
  801895:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801898:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80189b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80189e:	7d 19                	jge    8018b9 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8018a0:	ff 45 08             	incl   0x8(%ebp)
  8018a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018a6:	0f af 45 10          	imul   0x10(%ebp),%eax
  8018aa:	89 c2                	mov    %eax,%edx
  8018ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018af:	01 d0                	add    %edx,%eax
  8018b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8018b4:	e9 7b ff ff ff       	jmp    801834 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8018b9:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8018ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018be:	74 08                	je     8018c8 <strtol+0x134>
		*endptr = (char *) s;
  8018c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c3:	8b 55 08             	mov    0x8(%ebp),%edx
  8018c6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018cc:	74 07                	je     8018d5 <strtol+0x141>
  8018ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018d1:	f7 d8                	neg    %eax
  8018d3:	eb 03                	jmp    8018d8 <strtol+0x144>
  8018d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <ltostr>:

void
ltostr(long value, char *str)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
  8018dd:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018e7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018f2:	79 13                	jns    801907 <ltostr+0x2d>
	{
		neg = 1;
  8018f4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018fe:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801901:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801904:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801907:	8b 45 08             	mov    0x8(%ebp),%eax
  80190a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80190f:	99                   	cltd   
  801910:	f7 f9                	idiv   %ecx
  801912:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801915:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801918:	8d 50 01             	lea    0x1(%eax),%edx
  80191b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80191e:	89 c2                	mov    %eax,%edx
  801920:	8b 45 0c             	mov    0xc(%ebp),%eax
  801923:	01 d0                	add    %edx,%eax
  801925:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801928:	83 c2 30             	add    $0x30,%edx
  80192b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80192d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801930:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801935:	f7 e9                	imul   %ecx
  801937:	c1 fa 02             	sar    $0x2,%edx
  80193a:	89 c8                	mov    %ecx,%eax
  80193c:	c1 f8 1f             	sar    $0x1f,%eax
  80193f:	29 c2                	sub    %eax,%edx
  801941:	89 d0                	mov    %edx,%eax
  801943:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801946:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801949:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80194e:	f7 e9                	imul   %ecx
  801950:	c1 fa 02             	sar    $0x2,%edx
  801953:	89 c8                	mov    %ecx,%eax
  801955:	c1 f8 1f             	sar    $0x1f,%eax
  801958:	29 c2                	sub    %eax,%edx
  80195a:	89 d0                	mov    %edx,%eax
  80195c:	c1 e0 02             	shl    $0x2,%eax
  80195f:	01 d0                	add    %edx,%eax
  801961:	01 c0                	add    %eax,%eax
  801963:	29 c1                	sub    %eax,%ecx
  801965:	89 ca                	mov    %ecx,%edx
  801967:	85 d2                	test   %edx,%edx
  801969:	75 9c                	jne    801907 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80196b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801972:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801975:	48                   	dec    %eax
  801976:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801979:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80197d:	74 3d                	je     8019bc <ltostr+0xe2>
		start = 1 ;
  80197f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801986:	eb 34                	jmp    8019bc <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801988:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80198b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80198e:	01 d0                	add    %edx,%eax
  801990:	8a 00                	mov    (%eax),%al
  801992:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801995:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801998:	8b 45 0c             	mov    0xc(%ebp),%eax
  80199b:	01 c2                	add    %eax,%edx
  80199d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8019a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a3:	01 c8                	add    %ecx,%eax
  8019a5:	8a 00                	mov    (%eax),%al
  8019a7:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8019a9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019af:	01 c2                	add    %eax,%edx
  8019b1:	8a 45 eb             	mov    -0x15(%ebp),%al
  8019b4:	88 02                	mov    %al,(%edx)
		start++ ;
  8019b6:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8019b9:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8019bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019bf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019c2:	7c c4                	jl     801988 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8019c4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ca:	01 d0                	add    %edx,%eax
  8019cc:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019cf:	90                   	nop
  8019d0:	c9                   	leave  
  8019d1:	c3                   	ret    

008019d2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019d2:	55                   	push   %ebp
  8019d3:	89 e5                	mov    %esp,%ebp
  8019d5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019d8:	ff 75 08             	pushl  0x8(%ebp)
  8019db:	e8 54 fa ff ff       	call   801434 <strlen>
  8019e0:	83 c4 04             	add    $0x4,%esp
  8019e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019e6:	ff 75 0c             	pushl  0xc(%ebp)
  8019e9:	e8 46 fa ff ff       	call   801434 <strlen>
  8019ee:	83 c4 04             	add    $0x4,%esp
  8019f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a02:	eb 17                	jmp    801a1b <strcconcat+0x49>
		final[s] = str1[s] ;
  801a04:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a07:	8b 45 10             	mov    0x10(%ebp),%eax
  801a0a:	01 c2                	add    %eax,%edx
  801a0c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a12:	01 c8                	add    %ecx,%eax
  801a14:	8a 00                	mov    (%eax),%al
  801a16:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a18:	ff 45 fc             	incl   -0x4(%ebp)
  801a1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a1e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a21:	7c e1                	jl     801a04 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a23:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a2a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a31:	eb 1f                	jmp    801a52 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a33:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a36:	8d 50 01             	lea    0x1(%eax),%edx
  801a39:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a3c:	89 c2                	mov    %eax,%edx
  801a3e:	8b 45 10             	mov    0x10(%ebp),%eax
  801a41:	01 c2                	add    %eax,%edx
  801a43:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a46:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a49:	01 c8                	add    %ecx,%eax
  801a4b:	8a 00                	mov    (%eax),%al
  801a4d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a4f:	ff 45 f8             	incl   -0x8(%ebp)
  801a52:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a55:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a58:	7c d9                	jl     801a33 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a5a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a5d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a60:	01 d0                	add    %edx,%eax
  801a62:	c6 00 00             	movb   $0x0,(%eax)
}
  801a65:	90                   	nop
  801a66:	c9                   	leave  
  801a67:	c3                   	ret    

00801a68 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a68:	55                   	push   %ebp
  801a69:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a6b:	8b 45 14             	mov    0x14(%ebp),%eax
  801a6e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a74:	8b 45 14             	mov    0x14(%ebp),%eax
  801a77:	8b 00                	mov    (%eax),%eax
  801a79:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a80:	8b 45 10             	mov    0x10(%ebp),%eax
  801a83:	01 d0                	add    %edx,%eax
  801a85:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a8b:	eb 0c                	jmp    801a99 <strsplit+0x31>
			*string++ = 0;
  801a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a90:	8d 50 01             	lea    0x1(%eax),%edx
  801a93:	89 55 08             	mov    %edx,0x8(%ebp)
  801a96:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a99:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9c:	8a 00                	mov    (%eax),%al
  801a9e:	84 c0                	test   %al,%al
  801aa0:	74 18                	je     801aba <strsplit+0x52>
  801aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa5:	8a 00                	mov    (%eax),%al
  801aa7:	0f be c0             	movsbl %al,%eax
  801aaa:	50                   	push   %eax
  801aab:	ff 75 0c             	pushl  0xc(%ebp)
  801aae:	e8 13 fb ff ff       	call   8015c6 <strchr>
  801ab3:	83 c4 08             	add    $0x8,%esp
  801ab6:	85 c0                	test   %eax,%eax
  801ab8:	75 d3                	jne    801a8d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801aba:	8b 45 08             	mov    0x8(%ebp),%eax
  801abd:	8a 00                	mov    (%eax),%al
  801abf:	84 c0                	test   %al,%al
  801ac1:	74 5a                	je     801b1d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801ac3:	8b 45 14             	mov    0x14(%ebp),%eax
  801ac6:	8b 00                	mov    (%eax),%eax
  801ac8:	83 f8 0f             	cmp    $0xf,%eax
  801acb:	75 07                	jne    801ad4 <strsplit+0x6c>
		{
			return 0;
  801acd:	b8 00 00 00 00       	mov    $0x0,%eax
  801ad2:	eb 66                	jmp    801b3a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801ad4:	8b 45 14             	mov    0x14(%ebp),%eax
  801ad7:	8b 00                	mov    (%eax),%eax
  801ad9:	8d 48 01             	lea    0x1(%eax),%ecx
  801adc:	8b 55 14             	mov    0x14(%ebp),%edx
  801adf:	89 0a                	mov    %ecx,(%edx)
  801ae1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ae8:	8b 45 10             	mov    0x10(%ebp),%eax
  801aeb:	01 c2                	add    %eax,%edx
  801aed:	8b 45 08             	mov    0x8(%ebp),%eax
  801af0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801af2:	eb 03                	jmp    801af7 <strsplit+0x8f>
			string++;
  801af4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801af7:	8b 45 08             	mov    0x8(%ebp),%eax
  801afa:	8a 00                	mov    (%eax),%al
  801afc:	84 c0                	test   %al,%al
  801afe:	74 8b                	je     801a8b <strsplit+0x23>
  801b00:	8b 45 08             	mov    0x8(%ebp),%eax
  801b03:	8a 00                	mov    (%eax),%al
  801b05:	0f be c0             	movsbl %al,%eax
  801b08:	50                   	push   %eax
  801b09:	ff 75 0c             	pushl  0xc(%ebp)
  801b0c:	e8 b5 fa ff ff       	call   8015c6 <strchr>
  801b11:	83 c4 08             	add    $0x8,%esp
  801b14:	85 c0                	test   %eax,%eax
  801b16:	74 dc                	je     801af4 <strsplit+0x8c>
			string++;
	}
  801b18:	e9 6e ff ff ff       	jmp    801a8b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b1d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b1e:	8b 45 14             	mov    0x14(%ebp),%eax
  801b21:	8b 00                	mov    (%eax),%eax
  801b23:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b2a:	8b 45 10             	mov    0x10(%ebp),%eax
  801b2d:	01 d0                	add    %edx,%eax
  801b2f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b35:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b3a:	c9                   	leave  
  801b3b:	c3                   	ret    

00801b3c <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801b3c:	55                   	push   %ebp
  801b3d:	89 e5                	mov    %esp,%ebp
  801b3f:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801b42:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801b49:	76 0a                	jbe    801b55 <malloc+0x19>
		return NULL;
  801b4b:	b8 00 00 00 00       	mov    $0x0,%eax
  801b50:	e9 ad 02 00 00       	jmp    801e02 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801b55:	8b 45 08             	mov    0x8(%ebp),%eax
  801b58:	c1 e8 0c             	shr    $0xc,%eax
  801b5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b61:	25 ff 0f 00 00       	and    $0xfff,%eax
  801b66:	85 c0                	test   %eax,%eax
  801b68:	74 03                	je     801b6d <malloc+0x31>
		num++;
  801b6a:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801b6d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b72:	85 c0                	test   %eax,%eax
  801b74:	75 71                	jne    801be7 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801b76:	a1 04 30 80 00       	mov    0x803004,%eax
  801b7b:	83 ec 08             	sub    $0x8,%esp
  801b7e:	ff 75 08             	pushl  0x8(%ebp)
  801b81:	50                   	push   %eax
  801b82:	e8 ba 05 00 00       	call   802141 <sys_allocateMem>
  801b87:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801b8a:	a1 04 30 80 00       	mov    0x803004,%eax
  801b8f:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  801b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b95:	c1 e0 0c             	shl    $0xc,%eax
  801b98:	89 c2                	mov    %eax,%edx
  801b9a:	a1 04 30 80 00       	mov    0x803004,%eax
  801b9f:	01 d0                	add    %edx,%eax
  801ba1:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801ba6:	a1 30 30 80 00       	mov    0x803030,%eax
  801bab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bae:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801bb5:	a1 30 30 80 00       	mov    0x803030,%eax
  801bba:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801bbd:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  801bc4:	a1 30 30 80 00       	mov    0x803030,%eax
  801bc9:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801bd0:	01 00 00 00 
		sizeofarray++;
  801bd4:	a1 30 30 80 00       	mov    0x803030,%eax
  801bd9:	40                   	inc    %eax
  801bda:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) return_addres;
  801bdf:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801be2:	e9 1b 02 00 00       	jmp    801e02 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801be7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801bee:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801bf5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801bfc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801c03:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801c0a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801c11:	eb 72                	jmp    801c85 <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801c13:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801c16:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801c1d:	85 c0                	test   %eax,%eax
  801c1f:	75 12                	jne    801c33 <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801c21:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801c24:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801c2b:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801c2e:	ff 45 dc             	incl   -0x24(%ebp)
  801c31:	eb 4f                	jmp    801c82 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801c33:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c36:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801c39:	7d 39                	jge    801c74 <malloc+0x138>
  801c3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c3e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c41:	7c 31                	jl     801c74 <malloc+0x138>
					{
						min=count;
  801c43:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c46:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801c49:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801c4c:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c53:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801c56:	c1 e2 0c             	shl    $0xc,%edx
  801c59:	29 d0                	sub    %edx,%eax
  801c5b:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801c5e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801c61:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801c64:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801c67:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801c6e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801c71:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801c74:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801c7b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801c82:	ff 45 d4             	incl   -0x2c(%ebp)
  801c85:	a1 30 30 80 00       	mov    0x803030,%eax
  801c8a:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801c8d:	7c 84                	jl     801c13 <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801c8f:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801c93:	0f 85 e3 00 00 00    	jne    801d7c <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801c99:	83 ec 08             	sub    $0x8,%esp
  801c9c:	ff 75 08             	pushl  0x8(%ebp)
  801c9f:	ff 75 e0             	pushl  -0x20(%ebp)
  801ca2:	e8 9a 04 00 00       	call   802141 <sys_allocateMem>
  801ca7:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801caa:	a1 30 30 80 00       	mov    0x803030,%eax
  801caf:	40                   	inc    %eax
  801cb0:	a3 30 30 80 00       	mov    %eax,0x803030
				for(int i=sizeofarray-1;i>index;i--)
  801cb5:	a1 30 30 80 00       	mov    0x803030,%eax
  801cba:	48                   	dec    %eax
  801cbb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801cbe:	eb 42                	jmp    801d02 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801cc0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cc3:	48                   	dec    %eax
  801cc4:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801ccb:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cce:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801cd5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cd8:	48                   	dec    %eax
  801cd9:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801ce0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ce3:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801cea:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ced:	48                   	dec    %eax
  801cee:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801cf5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cf8:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801cff:	ff 4d d0             	decl   -0x30(%ebp)
  801d02:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801d05:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d08:	7f b6                	jg     801cc0 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801d0a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d0d:	40                   	inc    %eax
  801d0e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801d11:	8b 55 08             	mov    0x8(%ebp),%edx
  801d14:	01 ca                	add    %ecx,%edx
  801d16:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801d1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d20:	8d 50 01             	lea    0x1(%eax),%edx
  801d23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d26:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801d2d:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801d30:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801d37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d3a:	40                   	inc    %eax
  801d3b:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801d42:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801d46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d49:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d4c:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801d53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d56:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801d59:	eb 11                	jmp    801d6c <malloc+0x230>
				{
					changed[index] = 1;
  801d5b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d5e:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801d65:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801d69:	ff 45 cc             	incl   -0x34(%ebp)
  801d6c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801d6f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801d72:	7c e7                	jl     801d5b <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801d74:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d77:	e9 86 00 00 00       	jmp    801e02 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801d7c:	a1 04 30 80 00       	mov    0x803004,%eax
  801d81:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801d86:	29 c2                	sub    %eax,%edx
  801d88:	89 d0                	mov    %edx,%eax
  801d8a:	3b 45 08             	cmp    0x8(%ebp),%eax
  801d8d:	73 07                	jae    801d96 <malloc+0x25a>
						return NULL;
  801d8f:	b8 00 00 00 00       	mov    $0x0,%eax
  801d94:	eb 6c                	jmp    801e02 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801d96:	a1 04 30 80 00       	mov    0x803004,%eax
  801d9b:	83 ec 08             	sub    $0x8,%esp
  801d9e:	ff 75 08             	pushl  0x8(%ebp)
  801da1:	50                   	push   %eax
  801da2:	e8 9a 03 00 00       	call   802141 <sys_allocateMem>
  801da7:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801daa:	a1 04 30 80 00       	mov    0x803004,%eax
  801daf:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801db2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801db5:	c1 e0 0c             	shl    $0xc,%eax
  801db8:	89 c2                	mov    %eax,%edx
  801dba:	a1 04 30 80 00       	mov    0x803004,%eax
  801dbf:	01 d0                	add    %edx,%eax
  801dc1:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801dc6:	a1 30 30 80 00       	mov    0x803030,%eax
  801dcb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801dce:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801dd5:	a1 30 30 80 00       	mov    0x803030,%eax
  801dda:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801ddd:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801de4:	a1 30 30 80 00       	mov    0x803030,%eax
  801de9:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801df0:	01 00 00 00 
					sizeofarray++;
  801df4:	a1 30 30 80 00       	mov    0x803030,%eax
  801df9:	40                   	inc    %eax
  801dfa:	a3 30 30 80 00       	mov    %eax,0x803030
					return (void*) return_addres;
  801dff:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801e02:	c9                   	leave  
  801e03:	c3                   	ret    

00801e04 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801e04:	55                   	push   %ebp
  801e05:	89 e5                	mov    %esp,%ebp
  801e07:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0d:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801e10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801e17:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801e1e:	eb 30                	jmp    801e50 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801e20:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e23:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801e2a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801e2d:	75 1e                	jne    801e4d <free+0x49>
  801e2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e32:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801e39:	83 f8 01             	cmp    $0x1,%eax
  801e3c:	75 0f                	jne    801e4d <free+0x49>
			is_found = 1;
  801e3e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801e45:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e48:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801e4b:	eb 0d                	jmp    801e5a <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801e4d:	ff 45 ec             	incl   -0x14(%ebp)
  801e50:	a1 30 30 80 00       	mov    0x803030,%eax
  801e55:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801e58:	7c c6                	jl     801e20 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801e5a:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801e5e:	75 3a                	jne    801e9a <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801e60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e63:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801e6a:	c1 e0 0c             	shl    $0xc,%eax
  801e6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801e70:	83 ec 08             	sub    $0x8,%esp
  801e73:	ff 75 e4             	pushl  -0x1c(%ebp)
  801e76:	ff 75 e8             	pushl  -0x18(%ebp)
  801e79:	e8 a7 02 00 00       	call   802125 <sys_freeMem>
  801e7e:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801e81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e84:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801e8b:	00 00 00 00 
		changes++;
  801e8f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801e94:	40                   	inc    %eax
  801e95:	a3 2c 30 80 00       	mov    %eax,0x80302c
	}
	//refer to the project presentation and documentation for details
}
  801e9a:	90                   	nop
  801e9b:	c9                   	leave  
  801e9c:	c3                   	ret    

00801e9d <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801e9d:	55                   	push   %ebp
  801e9e:	89 e5                	mov    %esp,%ebp
  801ea0:	83 ec 18             	sub    $0x18,%esp
  801ea3:	8b 45 10             	mov    0x10(%ebp),%eax
  801ea6:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801ea9:	83 ec 04             	sub    $0x4,%esp
  801eac:	68 a4 2f 80 00       	push   $0x802fa4
  801eb1:	68 b6 00 00 00       	push   $0xb6
  801eb6:	68 c7 2f 80 00       	push   $0x802fc7
  801ebb:	e8 4a ea ff ff       	call   80090a <_panic>

00801ec0 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801ec0:	55                   	push   %ebp
  801ec1:	89 e5                	mov    %esp,%ebp
  801ec3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ec6:	83 ec 04             	sub    $0x4,%esp
  801ec9:	68 a4 2f 80 00       	push   $0x802fa4
  801ece:	68 bb 00 00 00       	push   $0xbb
  801ed3:	68 c7 2f 80 00       	push   $0x802fc7
  801ed8:	e8 2d ea ff ff       	call   80090a <_panic>

00801edd <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801edd:	55                   	push   %ebp
  801ede:	89 e5                	mov    %esp,%ebp
  801ee0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ee3:	83 ec 04             	sub    $0x4,%esp
  801ee6:	68 a4 2f 80 00       	push   $0x802fa4
  801eeb:	68 c0 00 00 00       	push   $0xc0
  801ef0:	68 c7 2f 80 00       	push   $0x802fc7
  801ef5:	e8 10 ea ff ff       	call   80090a <_panic>

00801efa <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801efa:	55                   	push   %ebp
  801efb:	89 e5                	mov    %esp,%ebp
  801efd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f00:	83 ec 04             	sub    $0x4,%esp
  801f03:	68 a4 2f 80 00       	push   $0x802fa4
  801f08:	68 c4 00 00 00       	push   $0xc4
  801f0d:	68 c7 2f 80 00       	push   $0x802fc7
  801f12:	e8 f3 e9 ff ff       	call   80090a <_panic>

00801f17 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801f17:	55                   	push   %ebp
  801f18:	89 e5                	mov    %esp,%ebp
  801f1a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f1d:	83 ec 04             	sub    $0x4,%esp
  801f20:	68 a4 2f 80 00       	push   $0x802fa4
  801f25:	68 c9 00 00 00       	push   $0xc9
  801f2a:	68 c7 2f 80 00       	push   $0x802fc7
  801f2f:	e8 d6 e9 ff ff       	call   80090a <_panic>

00801f34 <shrink>:
}
void shrink(uint32 newSize) {
  801f34:	55                   	push   %ebp
  801f35:	89 e5                	mov    %esp,%ebp
  801f37:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f3a:	83 ec 04             	sub    $0x4,%esp
  801f3d:	68 a4 2f 80 00       	push   $0x802fa4
  801f42:	68 cc 00 00 00       	push   $0xcc
  801f47:	68 c7 2f 80 00       	push   $0x802fc7
  801f4c:	e8 b9 e9 ff ff       	call   80090a <_panic>

00801f51 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801f51:	55                   	push   %ebp
  801f52:	89 e5                	mov    %esp,%ebp
  801f54:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f57:	83 ec 04             	sub    $0x4,%esp
  801f5a:	68 a4 2f 80 00       	push   $0x802fa4
  801f5f:	68 d0 00 00 00       	push   $0xd0
  801f64:	68 c7 2f 80 00       	push   $0x802fc7
  801f69:	e8 9c e9 ff ff       	call   80090a <_panic>

00801f6e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801f6e:	55                   	push   %ebp
  801f6f:	89 e5                	mov    %esp,%ebp
  801f71:	57                   	push   %edi
  801f72:	56                   	push   %esi
  801f73:	53                   	push   %ebx
  801f74:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801f77:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f7d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f80:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f83:	8b 7d 18             	mov    0x18(%ebp),%edi
  801f86:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801f89:	cd 30                	int    $0x30
  801f8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801f8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801f91:	83 c4 10             	add    $0x10,%esp
  801f94:	5b                   	pop    %ebx
  801f95:	5e                   	pop    %esi
  801f96:	5f                   	pop    %edi
  801f97:	5d                   	pop    %ebp
  801f98:	c3                   	ret    

00801f99 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801f99:	55                   	push   %ebp
  801f9a:	89 e5                	mov    %esp,%ebp
  801f9c:	83 ec 04             	sub    $0x4,%esp
  801f9f:	8b 45 10             	mov    0x10(%ebp),%eax
  801fa2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801fa5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	52                   	push   %edx
  801fb1:	ff 75 0c             	pushl  0xc(%ebp)
  801fb4:	50                   	push   %eax
  801fb5:	6a 00                	push   $0x0
  801fb7:	e8 b2 ff ff ff       	call   801f6e <syscall>
  801fbc:	83 c4 18             	add    $0x18,%esp
}
  801fbf:	90                   	nop
  801fc0:	c9                   	leave  
  801fc1:	c3                   	ret    

00801fc2 <sys_cgetc>:

int
sys_cgetc(void)
{
  801fc2:	55                   	push   %ebp
  801fc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 01                	push   $0x1
  801fd1:	e8 98 ff ff ff       	call   801f6e <syscall>
  801fd6:	83 c4 18             	add    $0x18,%esp
}
  801fd9:	c9                   	leave  
  801fda:	c3                   	ret    

00801fdb <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801fdb:	55                   	push   %ebp
  801fdc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801fde:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	50                   	push   %eax
  801fea:	6a 05                	push   $0x5
  801fec:	e8 7d ff ff ff       	call   801f6e <syscall>
  801ff1:	83 c4 18             	add    $0x18,%esp
}
  801ff4:	c9                   	leave  
  801ff5:	c3                   	ret    

00801ff6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ff6:	55                   	push   %ebp
  801ff7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 02                	push   $0x2
  802005:	e8 64 ff ff ff       	call   801f6e <syscall>
  80200a:	83 c4 18             	add    $0x18,%esp
}
  80200d:	c9                   	leave  
  80200e:	c3                   	ret    

0080200f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80200f:	55                   	push   %ebp
  802010:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 03                	push   $0x3
  80201e:	e8 4b ff ff ff       	call   801f6e <syscall>
  802023:	83 c4 18             	add    $0x18,%esp
}
  802026:	c9                   	leave  
  802027:	c3                   	ret    

00802028 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802028:	55                   	push   %ebp
  802029:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	6a 04                	push   $0x4
  802037:	e8 32 ff ff ff       	call   801f6e <syscall>
  80203c:	83 c4 18             	add    $0x18,%esp
}
  80203f:	c9                   	leave  
  802040:	c3                   	ret    

00802041 <sys_env_exit>:


void sys_env_exit(void)
{
  802041:	55                   	push   %ebp
  802042:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	6a 06                	push   $0x6
  802050:	e8 19 ff ff ff       	call   801f6e <syscall>
  802055:	83 c4 18             	add    $0x18,%esp
}
  802058:	90                   	nop
  802059:	c9                   	leave  
  80205a:	c3                   	ret    

0080205b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80205b:	55                   	push   %ebp
  80205c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80205e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802061:	8b 45 08             	mov    0x8(%ebp),%eax
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	52                   	push   %edx
  80206b:	50                   	push   %eax
  80206c:	6a 07                	push   $0x7
  80206e:	e8 fb fe ff ff       	call   801f6e <syscall>
  802073:	83 c4 18             	add    $0x18,%esp
}
  802076:	c9                   	leave  
  802077:	c3                   	ret    

00802078 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802078:	55                   	push   %ebp
  802079:	89 e5                	mov    %esp,%ebp
  80207b:	56                   	push   %esi
  80207c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80207d:	8b 75 18             	mov    0x18(%ebp),%esi
  802080:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802083:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802086:	8b 55 0c             	mov    0xc(%ebp),%edx
  802089:	8b 45 08             	mov    0x8(%ebp),%eax
  80208c:	56                   	push   %esi
  80208d:	53                   	push   %ebx
  80208e:	51                   	push   %ecx
  80208f:	52                   	push   %edx
  802090:	50                   	push   %eax
  802091:	6a 08                	push   $0x8
  802093:	e8 d6 fe ff ff       	call   801f6e <syscall>
  802098:	83 c4 18             	add    $0x18,%esp
}
  80209b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80209e:	5b                   	pop    %ebx
  80209f:	5e                   	pop    %esi
  8020a0:	5d                   	pop    %ebp
  8020a1:	c3                   	ret    

008020a2 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8020a2:	55                   	push   %ebp
  8020a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8020a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	52                   	push   %edx
  8020b2:	50                   	push   %eax
  8020b3:	6a 09                	push   $0x9
  8020b5:	e8 b4 fe ff ff       	call   801f6e <syscall>
  8020ba:	83 c4 18             	add    $0x18,%esp
}
  8020bd:	c9                   	leave  
  8020be:	c3                   	ret    

008020bf <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8020bf:	55                   	push   %ebp
  8020c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8020c2:	6a 00                	push   $0x0
  8020c4:	6a 00                	push   $0x0
  8020c6:	6a 00                	push   $0x0
  8020c8:	ff 75 0c             	pushl  0xc(%ebp)
  8020cb:	ff 75 08             	pushl  0x8(%ebp)
  8020ce:	6a 0a                	push   $0xa
  8020d0:	e8 99 fe ff ff       	call   801f6e <syscall>
  8020d5:	83 c4 18             	add    $0x18,%esp
}
  8020d8:	c9                   	leave  
  8020d9:	c3                   	ret    

008020da <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8020da:	55                   	push   %ebp
  8020db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 00                	push   $0x0
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 0b                	push   $0xb
  8020e9:	e8 80 fe ff ff       	call   801f6e <syscall>
  8020ee:	83 c4 18             	add    $0x18,%esp
}
  8020f1:	c9                   	leave  
  8020f2:	c3                   	ret    

008020f3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8020f3:	55                   	push   %ebp
  8020f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8020f6:	6a 00                	push   $0x0
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 00                	push   $0x0
  802100:	6a 0c                	push   $0xc
  802102:	e8 67 fe ff ff       	call   801f6e <syscall>
  802107:	83 c4 18             	add    $0x18,%esp
}
  80210a:	c9                   	leave  
  80210b:	c3                   	ret    

0080210c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80210c:	55                   	push   %ebp
  80210d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80210f:	6a 00                	push   $0x0
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	6a 0d                	push   $0xd
  80211b:	e8 4e fe ff ff       	call   801f6e <syscall>
  802120:	83 c4 18             	add    $0x18,%esp
}
  802123:	c9                   	leave  
  802124:	c3                   	ret    

00802125 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802125:	55                   	push   %ebp
  802126:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802128:	6a 00                	push   $0x0
  80212a:	6a 00                	push   $0x0
  80212c:	6a 00                	push   $0x0
  80212e:	ff 75 0c             	pushl  0xc(%ebp)
  802131:	ff 75 08             	pushl  0x8(%ebp)
  802134:	6a 11                	push   $0x11
  802136:	e8 33 fe ff ff       	call   801f6e <syscall>
  80213b:	83 c4 18             	add    $0x18,%esp
	return;
  80213e:	90                   	nop
}
  80213f:	c9                   	leave  
  802140:	c3                   	ret    

00802141 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802141:	55                   	push   %ebp
  802142:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	ff 75 0c             	pushl  0xc(%ebp)
  80214d:	ff 75 08             	pushl  0x8(%ebp)
  802150:	6a 12                	push   $0x12
  802152:	e8 17 fe ff ff       	call   801f6e <syscall>
  802157:	83 c4 18             	add    $0x18,%esp
	return ;
  80215a:	90                   	nop
}
  80215b:	c9                   	leave  
  80215c:	c3                   	ret    

0080215d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80215d:	55                   	push   %ebp
  80215e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802160:	6a 00                	push   $0x0
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	6a 00                	push   $0x0
  802168:	6a 00                	push   $0x0
  80216a:	6a 0e                	push   $0xe
  80216c:	e8 fd fd ff ff       	call   801f6e <syscall>
  802171:	83 c4 18             	add    $0x18,%esp
}
  802174:	c9                   	leave  
  802175:	c3                   	ret    

00802176 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802176:	55                   	push   %ebp
  802177:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802179:	6a 00                	push   $0x0
  80217b:	6a 00                	push   $0x0
  80217d:	6a 00                	push   $0x0
  80217f:	6a 00                	push   $0x0
  802181:	ff 75 08             	pushl  0x8(%ebp)
  802184:	6a 0f                	push   $0xf
  802186:	e8 e3 fd ff ff       	call   801f6e <syscall>
  80218b:	83 c4 18             	add    $0x18,%esp
}
  80218e:	c9                   	leave  
  80218f:	c3                   	ret    

00802190 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802190:	55                   	push   %ebp
  802191:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802193:	6a 00                	push   $0x0
  802195:	6a 00                	push   $0x0
  802197:	6a 00                	push   $0x0
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	6a 10                	push   $0x10
  80219f:	e8 ca fd ff ff       	call   801f6e <syscall>
  8021a4:	83 c4 18             	add    $0x18,%esp
}
  8021a7:	90                   	nop
  8021a8:	c9                   	leave  
  8021a9:	c3                   	ret    

008021aa <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8021aa:	55                   	push   %ebp
  8021ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 00                	push   $0x0
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 00                	push   $0x0
  8021b7:	6a 14                	push   $0x14
  8021b9:	e8 b0 fd ff ff       	call   801f6e <syscall>
  8021be:	83 c4 18             	add    $0x18,%esp
}
  8021c1:	90                   	nop
  8021c2:	c9                   	leave  
  8021c3:	c3                   	ret    

008021c4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8021c4:	55                   	push   %ebp
  8021c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 15                	push   $0x15
  8021d3:	e8 96 fd ff ff       	call   801f6e <syscall>
  8021d8:	83 c4 18             	add    $0x18,%esp
}
  8021db:	90                   	nop
  8021dc:	c9                   	leave  
  8021dd:	c3                   	ret    

008021de <sys_cputc>:


void
sys_cputc(const char c)
{
  8021de:	55                   	push   %ebp
  8021df:	89 e5                	mov    %esp,%ebp
  8021e1:	83 ec 04             	sub    $0x4,%esp
  8021e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8021ea:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021ee:	6a 00                	push   $0x0
  8021f0:	6a 00                	push   $0x0
  8021f2:	6a 00                	push   $0x0
  8021f4:	6a 00                	push   $0x0
  8021f6:	50                   	push   %eax
  8021f7:	6a 16                	push   $0x16
  8021f9:	e8 70 fd ff ff       	call   801f6e <syscall>
  8021fe:	83 c4 18             	add    $0x18,%esp
}
  802201:	90                   	nop
  802202:	c9                   	leave  
  802203:	c3                   	ret    

00802204 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802204:	55                   	push   %ebp
  802205:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802207:	6a 00                	push   $0x0
  802209:	6a 00                	push   $0x0
  80220b:	6a 00                	push   $0x0
  80220d:	6a 00                	push   $0x0
  80220f:	6a 00                	push   $0x0
  802211:	6a 17                	push   $0x17
  802213:	e8 56 fd ff ff       	call   801f6e <syscall>
  802218:	83 c4 18             	add    $0x18,%esp
}
  80221b:	90                   	nop
  80221c:	c9                   	leave  
  80221d:	c3                   	ret    

0080221e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80221e:	55                   	push   %ebp
  80221f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802221:	8b 45 08             	mov    0x8(%ebp),%eax
  802224:	6a 00                	push   $0x0
  802226:	6a 00                	push   $0x0
  802228:	6a 00                	push   $0x0
  80222a:	ff 75 0c             	pushl  0xc(%ebp)
  80222d:	50                   	push   %eax
  80222e:	6a 18                	push   $0x18
  802230:	e8 39 fd ff ff       	call   801f6e <syscall>
  802235:	83 c4 18             	add    $0x18,%esp
}
  802238:	c9                   	leave  
  802239:	c3                   	ret    

0080223a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80223a:	55                   	push   %ebp
  80223b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80223d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802240:	8b 45 08             	mov    0x8(%ebp),%eax
  802243:	6a 00                	push   $0x0
  802245:	6a 00                	push   $0x0
  802247:	6a 00                	push   $0x0
  802249:	52                   	push   %edx
  80224a:	50                   	push   %eax
  80224b:	6a 1b                	push   $0x1b
  80224d:	e8 1c fd ff ff       	call   801f6e <syscall>
  802252:	83 c4 18             	add    $0x18,%esp
}
  802255:	c9                   	leave  
  802256:	c3                   	ret    

00802257 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802257:	55                   	push   %ebp
  802258:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80225a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80225d:	8b 45 08             	mov    0x8(%ebp),%eax
  802260:	6a 00                	push   $0x0
  802262:	6a 00                	push   $0x0
  802264:	6a 00                	push   $0x0
  802266:	52                   	push   %edx
  802267:	50                   	push   %eax
  802268:	6a 19                	push   $0x19
  80226a:	e8 ff fc ff ff       	call   801f6e <syscall>
  80226f:	83 c4 18             	add    $0x18,%esp
}
  802272:	90                   	nop
  802273:	c9                   	leave  
  802274:	c3                   	ret    

00802275 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802275:	55                   	push   %ebp
  802276:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802278:	8b 55 0c             	mov    0xc(%ebp),%edx
  80227b:	8b 45 08             	mov    0x8(%ebp),%eax
  80227e:	6a 00                	push   $0x0
  802280:	6a 00                	push   $0x0
  802282:	6a 00                	push   $0x0
  802284:	52                   	push   %edx
  802285:	50                   	push   %eax
  802286:	6a 1a                	push   $0x1a
  802288:	e8 e1 fc ff ff       	call   801f6e <syscall>
  80228d:	83 c4 18             	add    $0x18,%esp
}
  802290:	90                   	nop
  802291:	c9                   	leave  
  802292:	c3                   	ret    

00802293 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802293:	55                   	push   %ebp
  802294:	89 e5                	mov    %esp,%ebp
  802296:	83 ec 04             	sub    $0x4,%esp
  802299:	8b 45 10             	mov    0x10(%ebp),%eax
  80229c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80229f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8022a2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8022a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a9:	6a 00                	push   $0x0
  8022ab:	51                   	push   %ecx
  8022ac:	52                   	push   %edx
  8022ad:	ff 75 0c             	pushl  0xc(%ebp)
  8022b0:	50                   	push   %eax
  8022b1:	6a 1c                	push   $0x1c
  8022b3:	e8 b6 fc ff ff       	call   801f6e <syscall>
  8022b8:	83 c4 18             	add    $0x18,%esp
}
  8022bb:	c9                   	leave  
  8022bc:	c3                   	ret    

008022bd <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8022bd:	55                   	push   %ebp
  8022be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8022c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c6:	6a 00                	push   $0x0
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 00                	push   $0x0
  8022cc:	52                   	push   %edx
  8022cd:	50                   	push   %eax
  8022ce:	6a 1d                	push   $0x1d
  8022d0:	e8 99 fc ff ff       	call   801f6e <syscall>
  8022d5:	83 c4 18             	add    $0x18,%esp
}
  8022d8:	c9                   	leave  
  8022d9:	c3                   	ret    

008022da <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8022da:	55                   	push   %ebp
  8022db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8022dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e6:	6a 00                	push   $0x0
  8022e8:	6a 00                	push   $0x0
  8022ea:	51                   	push   %ecx
  8022eb:	52                   	push   %edx
  8022ec:	50                   	push   %eax
  8022ed:	6a 1e                	push   $0x1e
  8022ef:	e8 7a fc ff ff       	call   801f6e <syscall>
  8022f4:	83 c4 18             	add    $0x18,%esp
}
  8022f7:	c9                   	leave  
  8022f8:	c3                   	ret    

008022f9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8022f9:	55                   	push   %ebp
  8022fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8022fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022ff:	8b 45 08             	mov    0x8(%ebp),%eax
  802302:	6a 00                	push   $0x0
  802304:	6a 00                	push   $0x0
  802306:	6a 00                	push   $0x0
  802308:	52                   	push   %edx
  802309:	50                   	push   %eax
  80230a:	6a 1f                	push   $0x1f
  80230c:	e8 5d fc ff ff       	call   801f6e <syscall>
  802311:	83 c4 18             	add    $0x18,%esp
}
  802314:	c9                   	leave  
  802315:	c3                   	ret    

00802316 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802316:	55                   	push   %ebp
  802317:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802319:	6a 00                	push   $0x0
  80231b:	6a 00                	push   $0x0
  80231d:	6a 00                	push   $0x0
  80231f:	6a 00                	push   $0x0
  802321:	6a 00                	push   $0x0
  802323:	6a 20                	push   $0x20
  802325:	e8 44 fc ff ff       	call   801f6e <syscall>
  80232a:	83 c4 18             	add    $0x18,%esp
}
  80232d:	c9                   	leave  
  80232e:	c3                   	ret    

0080232f <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80232f:	55                   	push   %ebp
  802330:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802332:	8b 45 08             	mov    0x8(%ebp),%eax
  802335:	6a 00                	push   $0x0
  802337:	ff 75 14             	pushl  0x14(%ebp)
  80233a:	ff 75 10             	pushl  0x10(%ebp)
  80233d:	ff 75 0c             	pushl  0xc(%ebp)
  802340:	50                   	push   %eax
  802341:	6a 21                	push   $0x21
  802343:	e8 26 fc ff ff       	call   801f6e <syscall>
  802348:	83 c4 18             	add    $0x18,%esp
}
  80234b:	c9                   	leave  
  80234c:	c3                   	ret    

0080234d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80234d:	55                   	push   %ebp
  80234e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802350:	8b 45 08             	mov    0x8(%ebp),%eax
  802353:	6a 00                	push   $0x0
  802355:	6a 00                	push   $0x0
  802357:	6a 00                	push   $0x0
  802359:	6a 00                	push   $0x0
  80235b:	50                   	push   %eax
  80235c:	6a 22                	push   $0x22
  80235e:	e8 0b fc ff ff       	call   801f6e <syscall>
  802363:	83 c4 18             	add    $0x18,%esp
}
  802366:	90                   	nop
  802367:	c9                   	leave  
  802368:	c3                   	ret    

00802369 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802369:	55                   	push   %ebp
  80236a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80236c:	8b 45 08             	mov    0x8(%ebp),%eax
  80236f:	6a 00                	push   $0x0
  802371:	6a 00                	push   $0x0
  802373:	6a 00                	push   $0x0
  802375:	6a 00                	push   $0x0
  802377:	50                   	push   %eax
  802378:	6a 23                	push   $0x23
  80237a:	e8 ef fb ff ff       	call   801f6e <syscall>
  80237f:	83 c4 18             	add    $0x18,%esp
}
  802382:	90                   	nop
  802383:	c9                   	leave  
  802384:	c3                   	ret    

00802385 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802385:	55                   	push   %ebp
  802386:	89 e5                	mov    %esp,%ebp
  802388:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80238b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80238e:	8d 50 04             	lea    0x4(%eax),%edx
  802391:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802394:	6a 00                	push   $0x0
  802396:	6a 00                	push   $0x0
  802398:	6a 00                	push   $0x0
  80239a:	52                   	push   %edx
  80239b:	50                   	push   %eax
  80239c:	6a 24                	push   $0x24
  80239e:	e8 cb fb ff ff       	call   801f6e <syscall>
  8023a3:	83 c4 18             	add    $0x18,%esp
	return result;
  8023a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8023a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8023af:	89 01                	mov    %eax,(%ecx)
  8023b1:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8023b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8023b7:	c9                   	leave  
  8023b8:	c2 04 00             	ret    $0x4

008023bb <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8023bb:	55                   	push   %ebp
  8023bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8023be:	6a 00                	push   $0x0
  8023c0:	6a 00                	push   $0x0
  8023c2:	ff 75 10             	pushl  0x10(%ebp)
  8023c5:	ff 75 0c             	pushl  0xc(%ebp)
  8023c8:	ff 75 08             	pushl  0x8(%ebp)
  8023cb:	6a 13                	push   $0x13
  8023cd:	e8 9c fb ff ff       	call   801f6e <syscall>
  8023d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8023d5:	90                   	nop
}
  8023d6:	c9                   	leave  
  8023d7:	c3                   	ret    

008023d8 <sys_rcr2>:
uint32 sys_rcr2()
{
  8023d8:	55                   	push   %ebp
  8023d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8023db:	6a 00                	push   $0x0
  8023dd:	6a 00                	push   $0x0
  8023df:	6a 00                	push   $0x0
  8023e1:	6a 00                	push   $0x0
  8023e3:	6a 00                	push   $0x0
  8023e5:	6a 25                	push   $0x25
  8023e7:	e8 82 fb ff ff       	call   801f6e <syscall>
  8023ec:	83 c4 18             	add    $0x18,%esp
}
  8023ef:	c9                   	leave  
  8023f0:	c3                   	ret    

008023f1 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8023f1:	55                   	push   %ebp
  8023f2:	89 e5                	mov    %esp,%ebp
  8023f4:	83 ec 04             	sub    $0x4,%esp
  8023f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8023fa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8023fd:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802401:	6a 00                	push   $0x0
  802403:	6a 00                	push   $0x0
  802405:	6a 00                	push   $0x0
  802407:	6a 00                	push   $0x0
  802409:	50                   	push   %eax
  80240a:	6a 26                	push   $0x26
  80240c:	e8 5d fb ff ff       	call   801f6e <syscall>
  802411:	83 c4 18             	add    $0x18,%esp
	return ;
  802414:	90                   	nop
}
  802415:	c9                   	leave  
  802416:	c3                   	ret    

00802417 <rsttst>:
void rsttst()
{
  802417:	55                   	push   %ebp
  802418:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80241a:	6a 00                	push   $0x0
  80241c:	6a 00                	push   $0x0
  80241e:	6a 00                	push   $0x0
  802420:	6a 00                	push   $0x0
  802422:	6a 00                	push   $0x0
  802424:	6a 28                	push   $0x28
  802426:	e8 43 fb ff ff       	call   801f6e <syscall>
  80242b:	83 c4 18             	add    $0x18,%esp
	return ;
  80242e:	90                   	nop
}
  80242f:	c9                   	leave  
  802430:	c3                   	ret    

00802431 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802431:	55                   	push   %ebp
  802432:	89 e5                	mov    %esp,%ebp
  802434:	83 ec 04             	sub    $0x4,%esp
  802437:	8b 45 14             	mov    0x14(%ebp),%eax
  80243a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80243d:	8b 55 18             	mov    0x18(%ebp),%edx
  802440:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802444:	52                   	push   %edx
  802445:	50                   	push   %eax
  802446:	ff 75 10             	pushl  0x10(%ebp)
  802449:	ff 75 0c             	pushl  0xc(%ebp)
  80244c:	ff 75 08             	pushl  0x8(%ebp)
  80244f:	6a 27                	push   $0x27
  802451:	e8 18 fb ff ff       	call   801f6e <syscall>
  802456:	83 c4 18             	add    $0x18,%esp
	return ;
  802459:	90                   	nop
}
  80245a:	c9                   	leave  
  80245b:	c3                   	ret    

0080245c <chktst>:
void chktst(uint32 n)
{
  80245c:	55                   	push   %ebp
  80245d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80245f:	6a 00                	push   $0x0
  802461:	6a 00                	push   $0x0
  802463:	6a 00                	push   $0x0
  802465:	6a 00                	push   $0x0
  802467:	ff 75 08             	pushl  0x8(%ebp)
  80246a:	6a 29                	push   $0x29
  80246c:	e8 fd fa ff ff       	call   801f6e <syscall>
  802471:	83 c4 18             	add    $0x18,%esp
	return ;
  802474:	90                   	nop
}
  802475:	c9                   	leave  
  802476:	c3                   	ret    

00802477 <inctst>:

void inctst()
{
  802477:	55                   	push   %ebp
  802478:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80247a:	6a 00                	push   $0x0
  80247c:	6a 00                	push   $0x0
  80247e:	6a 00                	push   $0x0
  802480:	6a 00                	push   $0x0
  802482:	6a 00                	push   $0x0
  802484:	6a 2a                	push   $0x2a
  802486:	e8 e3 fa ff ff       	call   801f6e <syscall>
  80248b:	83 c4 18             	add    $0x18,%esp
	return ;
  80248e:	90                   	nop
}
  80248f:	c9                   	leave  
  802490:	c3                   	ret    

00802491 <gettst>:
uint32 gettst()
{
  802491:	55                   	push   %ebp
  802492:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802494:	6a 00                	push   $0x0
  802496:	6a 00                	push   $0x0
  802498:	6a 00                	push   $0x0
  80249a:	6a 00                	push   $0x0
  80249c:	6a 00                	push   $0x0
  80249e:	6a 2b                	push   $0x2b
  8024a0:	e8 c9 fa ff ff       	call   801f6e <syscall>
  8024a5:	83 c4 18             	add    $0x18,%esp
}
  8024a8:	c9                   	leave  
  8024a9:	c3                   	ret    

008024aa <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8024aa:	55                   	push   %ebp
  8024ab:	89 e5                	mov    %esp,%ebp
  8024ad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024b0:	6a 00                	push   $0x0
  8024b2:	6a 00                	push   $0x0
  8024b4:	6a 00                	push   $0x0
  8024b6:	6a 00                	push   $0x0
  8024b8:	6a 00                	push   $0x0
  8024ba:	6a 2c                	push   $0x2c
  8024bc:	e8 ad fa ff ff       	call   801f6e <syscall>
  8024c1:	83 c4 18             	add    $0x18,%esp
  8024c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8024c7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8024cb:	75 07                	jne    8024d4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8024cd:	b8 01 00 00 00       	mov    $0x1,%eax
  8024d2:	eb 05                	jmp    8024d9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8024d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024d9:	c9                   	leave  
  8024da:	c3                   	ret    

008024db <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8024db:	55                   	push   %ebp
  8024dc:	89 e5                	mov    %esp,%ebp
  8024de:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024e1:	6a 00                	push   $0x0
  8024e3:	6a 00                	push   $0x0
  8024e5:	6a 00                	push   $0x0
  8024e7:	6a 00                	push   $0x0
  8024e9:	6a 00                	push   $0x0
  8024eb:	6a 2c                	push   $0x2c
  8024ed:	e8 7c fa ff ff       	call   801f6e <syscall>
  8024f2:	83 c4 18             	add    $0x18,%esp
  8024f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8024f8:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8024fc:	75 07                	jne    802505 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8024fe:	b8 01 00 00 00       	mov    $0x1,%eax
  802503:	eb 05                	jmp    80250a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802505:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80250a:	c9                   	leave  
  80250b:	c3                   	ret    

0080250c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80250c:	55                   	push   %ebp
  80250d:	89 e5                	mov    %esp,%ebp
  80250f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802512:	6a 00                	push   $0x0
  802514:	6a 00                	push   $0x0
  802516:	6a 00                	push   $0x0
  802518:	6a 00                	push   $0x0
  80251a:	6a 00                	push   $0x0
  80251c:	6a 2c                	push   $0x2c
  80251e:	e8 4b fa ff ff       	call   801f6e <syscall>
  802523:	83 c4 18             	add    $0x18,%esp
  802526:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802529:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80252d:	75 07                	jne    802536 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80252f:	b8 01 00 00 00       	mov    $0x1,%eax
  802534:	eb 05                	jmp    80253b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802536:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80253b:	c9                   	leave  
  80253c:	c3                   	ret    

0080253d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80253d:	55                   	push   %ebp
  80253e:	89 e5                	mov    %esp,%ebp
  802540:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802543:	6a 00                	push   $0x0
  802545:	6a 00                	push   $0x0
  802547:	6a 00                	push   $0x0
  802549:	6a 00                	push   $0x0
  80254b:	6a 00                	push   $0x0
  80254d:	6a 2c                	push   $0x2c
  80254f:	e8 1a fa ff ff       	call   801f6e <syscall>
  802554:	83 c4 18             	add    $0x18,%esp
  802557:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80255a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80255e:	75 07                	jne    802567 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802560:	b8 01 00 00 00       	mov    $0x1,%eax
  802565:	eb 05                	jmp    80256c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802567:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80256c:	c9                   	leave  
  80256d:	c3                   	ret    

0080256e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80256e:	55                   	push   %ebp
  80256f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802571:	6a 00                	push   $0x0
  802573:	6a 00                	push   $0x0
  802575:	6a 00                	push   $0x0
  802577:	6a 00                	push   $0x0
  802579:	ff 75 08             	pushl  0x8(%ebp)
  80257c:	6a 2d                	push   $0x2d
  80257e:	e8 eb f9 ff ff       	call   801f6e <syscall>
  802583:	83 c4 18             	add    $0x18,%esp
	return ;
  802586:	90                   	nop
}
  802587:	c9                   	leave  
  802588:	c3                   	ret    

00802589 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802589:	55                   	push   %ebp
  80258a:	89 e5                	mov    %esp,%ebp
  80258c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80258d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802590:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802593:	8b 55 0c             	mov    0xc(%ebp),%edx
  802596:	8b 45 08             	mov    0x8(%ebp),%eax
  802599:	6a 00                	push   $0x0
  80259b:	53                   	push   %ebx
  80259c:	51                   	push   %ecx
  80259d:	52                   	push   %edx
  80259e:	50                   	push   %eax
  80259f:	6a 2e                	push   $0x2e
  8025a1:	e8 c8 f9 ff ff       	call   801f6e <syscall>
  8025a6:	83 c4 18             	add    $0x18,%esp
}
  8025a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8025ac:	c9                   	leave  
  8025ad:	c3                   	ret    

008025ae <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8025ae:	55                   	push   %ebp
  8025af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8025b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8025b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8025b7:	6a 00                	push   $0x0
  8025b9:	6a 00                	push   $0x0
  8025bb:	6a 00                	push   $0x0
  8025bd:	52                   	push   %edx
  8025be:	50                   	push   %eax
  8025bf:	6a 2f                	push   $0x2f
  8025c1:	e8 a8 f9 ff ff       	call   801f6e <syscall>
  8025c6:	83 c4 18             	add    $0x18,%esp
}
  8025c9:	c9                   	leave  
  8025ca:	c3                   	ret    
  8025cb:	90                   	nop

008025cc <__udivdi3>:
  8025cc:	55                   	push   %ebp
  8025cd:	57                   	push   %edi
  8025ce:	56                   	push   %esi
  8025cf:	53                   	push   %ebx
  8025d0:	83 ec 1c             	sub    $0x1c,%esp
  8025d3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8025d7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8025db:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025df:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8025e3:	89 ca                	mov    %ecx,%edx
  8025e5:	89 f8                	mov    %edi,%eax
  8025e7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8025eb:	85 f6                	test   %esi,%esi
  8025ed:	75 2d                	jne    80261c <__udivdi3+0x50>
  8025ef:	39 cf                	cmp    %ecx,%edi
  8025f1:	77 65                	ja     802658 <__udivdi3+0x8c>
  8025f3:	89 fd                	mov    %edi,%ebp
  8025f5:	85 ff                	test   %edi,%edi
  8025f7:	75 0b                	jne    802604 <__udivdi3+0x38>
  8025f9:	b8 01 00 00 00       	mov    $0x1,%eax
  8025fe:	31 d2                	xor    %edx,%edx
  802600:	f7 f7                	div    %edi
  802602:	89 c5                	mov    %eax,%ebp
  802604:	31 d2                	xor    %edx,%edx
  802606:	89 c8                	mov    %ecx,%eax
  802608:	f7 f5                	div    %ebp
  80260a:	89 c1                	mov    %eax,%ecx
  80260c:	89 d8                	mov    %ebx,%eax
  80260e:	f7 f5                	div    %ebp
  802610:	89 cf                	mov    %ecx,%edi
  802612:	89 fa                	mov    %edi,%edx
  802614:	83 c4 1c             	add    $0x1c,%esp
  802617:	5b                   	pop    %ebx
  802618:	5e                   	pop    %esi
  802619:	5f                   	pop    %edi
  80261a:	5d                   	pop    %ebp
  80261b:	c3                   	ret    
  80261c:	39 ce                	cmp    %ecx,%esi
  80261e:	77 28                	ja     802648 <__udivdi3+0x7c>
  802620:	0f bd fe             	bsr    %esi,%edi
  802623:	83 f7 1f             	xor    $0x1f,%edi
  802626:	75 40                	jne    802668 <__udivdi3+0x9c>
  802628:	39 ce                	cmp    %ecx,%esi
  80262a:	72 0a                	jb     802636 <__udivdi3+0x6a>
  80262c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802630:	0f 87 9e 00 00 00    	ja     8026d4 <__udivdi3+0x108>
  802636:	b8 01 00 00 00       	mov    $0x1,%eax
  80263b:	89 fa                	mov    %edi,%edx
  80263d:	83 c4 1c             	add    $0x1c,%esp
  802640:	5b                   	pop    %ebx
  802641:	5e                   	pop    %esi
  802642:	5f                   	pop    %edi
  802643:	5d                   	pop    %ebp
  802644:	c3                   	ret    
  802645:	8d 76 00             	lea    0x0(%esi),%esi
  802648:	31 ff                	xor    %edi,%edi
  80264a:	31 c0                	xor    %eax,%eax
  80264c:	89 fa                	mov    %edi,%edx
  80264e:	83 c4 1c             	add    $0x1c,%esp
  802651:	5b                   	pop    %ebx
  802652:	5e                   	pop    %esi
  802653:	5f                   	pop    %edi
  802654:	5d                   	pop    %ebp
  802655:	c3                   	ret    
  802656:	66 90                	xchg   %ax,%ax
  802658:	89 d8                	mov    %ebx,%eax
  80265a:	f7 f7                	div    %edi
  80265c:	31 ff                	xor    %edi,%edi
  80265e:	89 fa                	mov    %edi,%edx
  802660:	83 c4 1c             	add    $0x1c,%esp
  802663:	5b                   	pop    %ebx
  802664:	5e                   	pop    %esi
  802665:	5f                   	pop    %edi
  802666:	5d                   	pop    %ebp
  802667:	c3                   	ret    
  802668:	bd 20 00 00 00       	mov    $0x20,%ebp
  80266d:	89 eb                	mov    %ebp,%ebx
  80266f:	29 fb                	sub    %edi,%ebx
  802671:	89 f9                	mov    %edi,%ecx
  802673:	d3 e6                	shl    %cl,%esi
  802675:	89 c5                	mov    %eax,%ebp
  802677:	88 d9                	mov    %bl,%cl
  802679:	d3 ed                	shr    %cl,%ebp
  80267b:	89 e9                	mov    %ebp,%ecx
  80267d:	09 f1                	or     %esi,%ecx
  80267f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802683:	89 f9                	mov    %edi,%ecx
  802685:	d3 e0                	shl    %cl,%eax
  802687:	89 c5                	mov    %eax,%ebp
  802689:	89 d6                	mov    %edx,%esi
  80268b:	88 d9                	mov    %bl,%cl
  80268d:	d3 ee                	shr    %cl,%esi
  80268f:	89 f9                	mov    %edi,%ecx
  802691:	d3 e2                	shl    %cl,%edx
  802693:	8b 44 24 08          	mov    0x8(%esp),%eax
  802697:	88 d9                	mov    %bl,%cl
  802699:	d3 e8                	shr    %cl,%eax
  80269b:	09 c2                	or     %eax,%edx
  80269d:	89 d0                	mov    %edx,%eax
  80269f:	89 f2                	mov    %esi,%edx
  8026a1:	f7 74 24 0c          	divl   0xc(%esp)
  8026a5:	89 d6                	mov    %edx,%esi
  8026a7:	89 c3                	mov    %eax,%ebx
  8026a9:	f7 e5                	mul    %ebp
  8026ab:	39 d6                	cmp    %edx,%esi
  8026ad:	72 19                	jb     8026c8 <__udivdi3+0xfc>
  8026af:	74 0b                	je     8026bc <__udivdi3+0xf0>
  8026b1:	89 d8                	mov    %ebx,%eax
  8026b3:	31 ff                	xor    %edi,%edi
  8026b5:	e9 58 ff ff ff       	jmp    802612 <__udivdi3+0x46>
  8026ba:	66 90                	xchg   %ax,%ax
  8026bc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8026c0:	89 f9                	mov    %edi,%ecx
  8026c2:	d3 e2                	shl    %cl,%edx
  8026c4:	39 c2                	cmp    %eax,%edx
  8026c6:	73 e9                	jae    8026b1 <__udivdi3+0xe5>
  8026c8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8026cb:	31 ff                	xor    %edi,%edi
  8026cd:	e9 40 ff ff ff       	jmp    802612 <__udivdi3+0x46>
  8026d2:	66 90                	xchg   %ax,%ax
  8026d4:	31 c0                	xor    %eax,%eax
  8026d6:	e9 37 ff ff ff       	jmp    802612 <__udivdi3+0x46>
  8026db:	90                   	nop

008026dc <__umoddi3>:
  8026dc:	55                   	push   %ebp
  8026dd:	57                   	push   %edi
  8026de:	56                   	push   %esi
  8026df:	53                   	push   %ebx
  8026e0:	83 ec 1c             	sub    $0x1c,%esp
  8026e3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8026e7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8026eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026ef:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8026f3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8026f7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8026fb:	89 f3                	mov    %esi,%ebx
  8026fd:	89 fa                	mov    %edi,%edx
  8026ff:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802703:	89 34 24             	mov    %esi,(%esp)
  802706:	85 c0                	test   %eax,%eax
  802708:	75 1a                	jne    802724 <__umoddi3+0x48>
  80270a:	39 f7                	cmp    %esi,%edi
  80270c:	0f 86 a2 00 00 00    	jbe    8027b4 <__umoddi3+0xd8>
  802712:	89 c8                	mov    %ecx,%eax
  802714:	89 f2                	mov    %esi,%edx
  802716:	f7 f7                	div    %edi
  802718:	89 d0                	mov    %edx,%eax
  80271a:	31 d2                	xor    %edx,%edx
  80271c:	83 c4 1c             	add    $0x1c,%esp
  80271f:	5b                   	pop    %ebx
  802720:	5e                   	pop    %esi
  802721:	5f                   	pop    %edi
  802722:	5d                   	pop    %ebp
  802723:	c3                   	ret    
  802724:	39 f0                	cmp    %esi,%eax
  802726:	0f 87 ac 00 00 00    	ja     8027d8 <__umoddi3+0xfc>
  80272c:	0f bd e8             	bsr    %eax,%ebp
  80272f:	83 f5 1f             	xor    $0x1f,%ebp
  802732:	0f 84 ac 00 00 00    	je     8027e4 <__umoddi3+0x108>
  802738:	bf 20 00 00 00       	mov    $0x20,%edi
  80273d:	29 ef                	sub    %ebp,%edi
  80273f:	89 fe                	mov    %edi,%esi
  802741:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802745:	89 e9                	mov    %ebp,%ecx
  802747:	d3 e0                	shl    %cl,%eax
  802749:	89 d7                	mov    %edx,%edi
  80274b:	89 f1                	mov    %esi,%ecx
  80274d:	d3 ef                	shr    %cl,%edi
  80274f:	09 c7                	or     %eax,%edi
  802751:	89 e9                	mov    %ebp,%ecx
  802753:	d3 e2                	shl    %cl,%edx
  802755:	89 14 24             	mov    %edx,(%esp)
  802758:	89 d8                	mov    %ebx,%eax
  80275a:	d3 e0                	shl    %cl,%eax
  80275c:	89 c2                	mov    %eax,%edx
  80275e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802762:	d3 e0                	shl    %cl,%eax
  802764:	89 44 24 04          	mov    %eax,0x4(%esp)
  802768:	8b 44 24 08          	mov    0x8(%esp),%eax
  80276c:	89 f1                	mov    %esi,%ecx
  80276e:	d3 e8                	shr    %cl,%eax
  802770:	09 d0                	or     %edx,%eax
  802772:	d3 eb                	shr    %cl,%ebx
  802774:	89 da                	mov    %ebx,%edx
  802776:	f7 f7                	div    %edi
  802778:	89 d3                	mov    %edx,%ebx
  80277a:	f7 24 24             	mull   (%esp)
  80277d:	89 c6                	mov    %eax,%esi
  80277f:	89 d1                	mov    %edx,%ecx
  802781:	39 d3                	cmp    %edx,%ebx
  802783:	0f 82 87 00 00 00    	jb     802810 <__umoddi3+0x134>
  802789:	0f 84 91 00 00 00    	je     802820 <__umoddi3+0x144>
  80278f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802793:	29 f2                	sub    %esi,%edx
  802795:	19 cb                	sbb    %ecx,%ebx
  802797:	89 d8                	mov    %ebx,%eax
  802799:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80279d:	d3 e0                	shl    %cl,%eax
  80279f:	89 e9                	mov    %ebp,%ecx
  8027a1:	d3 ea                	shr    %cl,%edx
  8027a3:	09 d0                	or     %edx,%eax
  8027a5:	89 e9                	mov    %ebp,%ecx
  8027a7:	d3 eb                	shr    %cl,%ebx
  8027a9:	89 da                	mov    %ebx,%edx
  8027ab:	83 c4 1c             	add    $0x1c,%esp
  8027ae:	5b                   	pop    %ebx
  8027af:	5e                   	pop    %esi
  8027b0:	5f                   	pop    %edi
  8027b1:	5d                   	pop    %ebp
  8027b2:	c3                   	ret    
  8027b3:	90                   	nop
  8027b4:	89 fd                	mov    %edi,%ebp
  8027b6:	85 ff                	test   %edi,%edi
  8027b8:	75 0b                	jne    8027c5 <__umoddi3+0xe9>
  8027ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8027bf:	31 d2                	xor    %edx,%edx
  8027c1:	f7 f7                	div    %edi
  8027c3:	89 c5                	mov    %eax,%ebp
  8027c5:	89 f0                	mov    %esi,%eax
  8027c7:	31 d2                	xor    %edx,%edx
  8027c9:	f7 f5                	div    %ebp
  8027cb:	89 c8                	mov    %ecx,%eax
  8027cd:	f7 f5                	div    %ebp
  8027cf:	89 d0                	mov    %edx,%eax
  8027d1:	e9 44 ff ff ff       	jmp    80271a <__umoddi3+0x3e>
  8027d6:	66 90                	xchg   %ax,%ax
  8027d8:	89 c8                	mov    %ecx,%eax
  8027da:	89 f2                	mov    %esi,%edx
  8027dc:	83 c4 1c             	add    $0x1c,%esp
  8027df:	5b                   	pop    %ebx
  8027e0:	5e                   	pop    %esi
  8027e1:	5f                   	pop    %edi
  8027e2:	5d                   	pop    %ebp
  8027e3:	c3                   	ret    
  8027e4:	3b 04 24             	cmp    (%esp),%eax
  8027e7:	72 06                	jb     8027ef <__umoddi3+0x113>
  8027e9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8027ed:	77 0f                	ja     8027fe <__umoddi3+0x122>
  8027ef:	89 f2                	mov    %esi,%edx
  8027f1:	29 f9                	sub    %edi,%ecx
  8027f3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8027f7:	89 14 24             	mov    %edx,(%esp)
  8027fa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027fe:	8b 44 24 04          	mov    0x4(%esp),%eax
  802802:	8b 14 24             	mov    (%esp),%edx
  802805:	83 c4 1c             	add    $0x1c,%esp
  802808:	5b                   	pop    %ebx
  802809:	5e                   	pop    %esi
  80280a:	5f                   	pop    %edi
  80280b:	5d                   	pop    %ebp
  80280c:	c3                   	ret    
  80280d:	8d 76 00             	lea    0x0(%esi),%esi
  802810:	2b 04 24             	sub    (%esp),%eax
  802813:	19 fa                	sbb    %edi,%edx
  802815:	89 d1                	mov    %edx,%ecx
  802817:	89 c6                	mov    %eax,%esi
  802819:	e9 71 ff ff ff       	jmp    80278f <__umoddi3+0xb3>
  80281e:	66 90                	xchg   %ax,%ax
  802820:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802824:	72 ea                	jb     802810 <__umoddi3+0x134>
  802826:	89 d9                	mov    %ebx,%ecx
  802828:	e9 62 ff ff ff       	jmp    80278f <__umoddi3+0xb3>


obj/user/arrayOperations_quicksort:     file format elf32-i386


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
  800031:	e8 20 03 00 00       	call   800356 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int32 envID = sys_getenvid();
  80003e:	e8 2e 14 00 00       	call   801471 <sys_getenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int32 parentenvID = sys_getparentenvid();
  800046:	e8 58 14 00 00       	call   8014a3 <sys_getparentenvid>
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)

	int ret;
	/*[1] GET SHARED VARs*/
	//Get the shared array & its size
	int *numOfElements = NULL;
  80004e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	int *sharedArray = NULL;
  800055:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	sharedArray = sget(parentenvID,"arr") ;
  80005c:	83 ec 08             	sub    $0x8,%esp
  80005f:	68 80 1e 80 00       	push   $0x801e80
  800064:	ff 75 ec             	pushl  -0x14(%ebp)
  800067:	e8 e1 12 00 00       	call   80134d <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	numOfElements = sget(parentenvID,"arrSize") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 84 1e 80 00       	push   $0x801e84
  80007a:	ff 75 ec             	pushl  -0x14(%ebp)
  80007d:	e8 cb 12 00 00       	call   80134d <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800088:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	finishedCount = sget(parentenvID,"finishedCount") ;
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	68 8c 1e 80 00       	push   $0x801e8c
  800097:	ff 75 ec             	pushl  -0x14(%ebp)
  80009a:	e8 ae 12 00 00       	call   80134d <sget>
  80009f:	83 c4 10             	add    $0x10,%esp
  8000a2:	89 45 e0             	mov    %eax,-0x20(%ebp)

	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("quicksortedArr", sizeof(int) * *numOfElements, 0) ;
  8000a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000a8:	8b 00                	mov    (%eax),%eax
  8000aa:	c1 e0 02             	shl    $0x2,%eax
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 00                	push   $0x0
  8000b2:	50                   	push   %eax
  8000b3:	68 9a 1e 80 00       	push   $0x801e9a
  8000b8:	e8 70 12 00 00       	call   80132d <smalloc>
  8000bd:	83 c4 10             	add    $0x10,%esp
  8000c0:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000ca:	eb 25                	jmp    8000f1 <_main+0xb9>
	{
		sortedArray[i] = sharedArray[i];
  8000cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000d9:	01 c2                	add    %eax,%edx
  8000db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000de:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e8:	01 c8                	add    %ecx,%eax
  8000ea:	8b 00                	mov    (%eax),%eax
  8000ec:	89 02                	mov    %eax,(%edx)
	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("quicksortedArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000ee:	ff 45 f4             	incl   -0xc(%ebp)
  8000f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f4:	8b 00                	mov    (%eax),%eax
  8000f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f9:	7f d1                	jg     8000cc <_main+0x94>
	{
		sortedArray[i] = sharedArray[i];
	}
	QuickSort(sortedArray, *numOfElements);
  8000fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000fe:	8b 00                	mov    (%eax),%eax
  800100:	83 ec 08             	sub    $0x8,%esp
  800103:	50                   	push   %eax
  800104:	ff 75 dc             	pushl  -0x24(%ebp)
  800107:	e8 23 00 00 00       	call   80012f <QuickSort>
  80010c:	83 c4 10             	add    $0x10,%esp
	cprintf("Quick sort is Finished!!!!\n") ;
  80010f:	83 ec 0c             	sub    $0xc,%esp
  800112:	68 a9 1e 80 00       	push   $0x801ea9
  800117:	e8 53 04 00 00       	call   80056f <cprintf>
  80011c:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	(*finishedCount)++ ;
  80011f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	8d 50 01             	lea    0x1(%eax),%edx
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	89 10                	mov    %edx,(%eax)

}
  80012c:	90                   	nop
  80012d:	c9                   	leave  
  80012e:	c3                   	ret    

0080012f <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  80012f:	55                   	push   %ebp
  800130:	89 e5                	mov    %esp,%ebp
  800132:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800135:	8b 45 0c             	mov    0xc(%ebp),%eax
  800138:	48                   	dec    %eax
  800139:	50                   	push   %eax
  80013a:	6a 00                	push   $0x0
  80013c:	ff 75 0c             	pushl  0xc(%ebp)
  80013f:	ff 75 08             	pushl  0x8(%ebp)
  800142:	e8 06 00 00 00       	call   80014d <QSort>
  800147:	83 c4 10             	add    $0x10,%esp
}
  80014a:	90                   	nop
  80014b:	c9                   	leave  
  80014c:	c3                   	ret    

0080014d <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  80014d:	55                   	push   %ebp
  80014e:	89 e5                	mov    %esp,%ebp
  800150:	83 ec 28             	sub    $0x28,%esp
	if (startIndex >= finalIndex) return;
  800153:	8b 45 10             	mov    0x10(%ebp),%eax
  800156:	3b 45 14             	cmp    0x14(%ebp),%eax
  800159:	0f 8d 1b 01 00 00    	jge    80027a <QSort+0x12d>
	int pvtIndex = RAND(startIndex, finalIndex) ;
  80015f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  800162:	83 ec 0c             	sub    $0xc,%esp
  800165:	50                   	push   %eax
  800166:	e8 95 16 00 00       	call   801800 <sys_get_virtual_time>
  80016b:	83 c4 0c             	add    $0xc,%esp
  80016e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800171:	8b 55 14             	mov    0x14(%ebp),%edx
  800174:	2b 55 10             	sub    0x10(%ebp),%edx
  800177:	89 d1                	mov    %edx,%ecx
  800179:	ba 00 00 00 00       	mov    $0x0,%edx
  80017e:	f7 f1                	div    %ecx
  800180:	8b 45 10             	mov    0x10(%ebp),%eax
  800183:	01 d0                	add    %edx,%eax
  800185:	89 45 ec             	mov    %eax,-0x14(%ebp)
	Swap(Elements, startIndex, pvtIndex);
  800188:	83 ec 04             	sub    $0x4,%esp
  80018b:	ff 75 ec             	pushl  -0x14(%ebp)
  80018e:	ff 75 10             	pushl  0x10(%ebp)
  800191:	ff 75 08             	pushl  0x8(%ebp)
  800194:	e8 e4 00 00 00       	call   80027d <Swap>
  800199:	83 c4 10             	add    $0x10,%esp

	int i = startIndex+1, j = finalIndex;
  80019c:	8b 45 10             	mov    0x10(%ebp),%eax
  80019f:	40                   	inc    %eax
  8001a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8001a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8001a6:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8001a9:	e9 80 00 00 00       	jmp    80022e <QSort+0xe1>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8001ae:	ff 45 f4             	incl   -0xc(%ebp)
  8001b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b4:	3b 45 14             	cmp    0x14(%ebp),%eax
  8001b7:	7f 2b                	jg     8001e4 <QSort+0x97>
  8001b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8001bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8001c6:	01 d0                	add    %edx,%eax
  8001c8:	8b 10                	mov    (%eax),%edx
  8001ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8001d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8001d7:	01 c8                	add    %ecx,%eax
  8001d9:	8b 00                	mov    (%eax),%eax
  8001db:	39 c2                	cmp    %eax,%edx
  8001dd:	7d cf                	jge    8001ae <QSort+0x61>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8001df:	eb 03                	jmp    8001e4 <QSort+0x97>
  8001e1:	ff 4d f0             	decl   -0x10(%ebp)
  8001e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8001e7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8001ea:	7e 26                	jle    800212 <QSort+0xc5>
  8001ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8001ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8001f9:	01 d0                	add    %edx,%eax
  8001fb:	8b 10                	mov    (%eax),%edx
  8001fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800200:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800207:	8b 45 08             	mov    0x8(%ebp),%eax
  80020a:	01 c8                	add    %ecx,%eax
  80020c:	8b 00                	mov    (%eax),%eax
  80020e:	39 c2                	cmp    %eax,%edx
  800210:	7e cf                	jle    8001e1 <QSort+0x94>

		if (i <= j)
  800212:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800215:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800218:	7f 14                	jg     80022e <QSort+0xe1>
		{
			Swap(Elements, i, j);
  80021a:	83 ec 04             	sub    $0x4,%esp
  80021d:	ff 75 f0             	pushl  -0x10(%ebp)
  800220:	ff 75 f4             	pushl  -0xc(%ebp)
  800223:	ff 75 08             	pushl  0x8(%ebp)
  800226:	e8 52 00 00 00       	call   80027d <Swap>
  80022b:	83 c4 10             	add    $0x10,%esp
	int pvtIndex = RAND(startIndex, finalIndex) ;
	Swap(Elements, startIndex, pvtIndex);

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  80022e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800231:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800234:	0f 8e 77 ff ff ff    	jle    8001b1 <QSort+0x64>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	ff 75 f0             	pushl  -0x10(%ebp)
  800240:	ff 75 10             	pushl  0x10(%ebp)
  800243:	ff 75 08             	pushl  0x8(%ebp)
  800246:	e8 32 00 00 00       	call   80027d <Swap>
  80024b:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80024e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800251:	48                   	dec    %eax
  800252:	50                   	push   %eax
  800253:	ff 75 10             	pushl  0x10(%ebp)
  800256:	ff 75 0c             	pushl  0xc(%ebp)
  800259:	ff 75 08             	pushl  0x8(%ebp)
  80025c:	e8 ec fe ff ff       	call   80014d <QSort>
  800261:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800264:	ff 75 14             	pushl  0x14(%ebp)
  800267:	ff 75 f4             	pushl  -0xc(%ebp)
  80026a:	ff 75 0c             	pushl  0xc(%ebp)
  80026d:	ff 75 08             	pushl  0x8(%ebp)
  800270:	e8 d8 fe ff ff       	call   80014d <QSort>
  800275:	83 c4 10             	add    $0x10,%esp
  800278:	eb 01                	jmp    80027b <QSort+0x12e>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80027a:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  80027b:	c9                   	leave  
  80027c:	c3                   	ret    

0080027d <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80027d:	55                   	push   %ebp
  80027e:	89 e5                	mov    %esp,%ebp
  800280:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800283:	8b 45 0c             	mov    0xc(%ebp),%eax
  800286:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028d:	8b 45 08             	mov    0x8(%ebp),%eax
  800290:	01 d0                	add    %edx,%eax
  800292:	8b 00                	mov    (%eax),%eax
  800294:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80029a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a4:	01 c2                	add    %eax,%edx
  8002a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b3:	01 c8                	add    %ecx,%eax
  8002b5:	8b 00                	mov    (%eax),%eax
  8002b7:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8002b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c6:	01 c2                	add    %eax,%edx
  8002c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8002cb:	89 02                	mov    %eax,(%edx)
}
  8002cd:	90                   	nop
  8002ce:	c9                   	leave  
  8002cf:	c3                   	ret    

008002d0 <PrintElements>:


void PrintElements(int *Elements, int NumOfElements)
{
  8002d0:	55                   	push   %ebp
  8002d1:	89 e5                	mov    %esp,%ebp
  8002d3:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8002d6:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8002dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002e4:	eb 42                	jmp    800328 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8002e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e9:	99                   	cltd   
  8002ea:	f7 7d f0             	idivl  -0x10(%ebp)
  8002ed:	89 d0                	mov    %edx,%eax
  8002ef:	85 c0                	test   %eax,%eax
  8002f1:	75 10                	jne    800303 <PrintElements+0x33>
			cprintf("\n");
  8002f3:	83 ec 0c             	sub    $0xc,%esp
  8002f6:	68 c5 1e 80 00       	push   $0x801ec5
  8002fb:	e8 6f 02 00 00       	call   80056f <cprintf>
  800300:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800303:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800306:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030d:	8b 45 08             	mov    0x8(%ebp),%eax
  800310:	01 d0                	add    %edx,%eax
  800312:	8b 00                	mov    (%eax),%eax
  800314:	83 ec 08             	sub    $0x8,%esp
  800317:	50                   	push   %eax
  800318:	68 c7 1e 80 00       	push   $0x801ec7
  80031d:	e8 4d 02 00 00       	call   80056f <cprintf>
  800322:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800325:	ff 45 f4             	incl   -0xc(%ebp)
  800328:	8b 45 0c             	mov    0xc(%ebp),%eax
  80032b:	48                   	dec    %eax
  80032c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80032f:	7f b5                	jg     8002e6 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800331:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800334:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033b:	8b 45 08             	mov    0x8(%ebp),%eax
  80033e:	01 d0                	add    %edx,%eax
  800340:	8b 00                	mov    (%eax),%eax
  800342:	83 ec 08             	sub    $0x8,%esp
  800345:	50                   	push   %eax
  800346:	68 cc 1e 80 00       	push   $0x801ecc
  80034b:	e8 1f 02 00 00       	call   80056f <cprintf>
  800350:	83 c4 10             	add    $0x10,%esp

}
  800353:	90                   	nop
  800354:	c9                   	leave  
  800355:	c3                   	ret    

00800356 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800356:	55                   	push   %ebp
  800357:	89 e5                	mov    %esp,%ebp
  800359:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80035c:	e8 29 11 00 00       	call   80148a <sys_getenvindex>
  800361:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800364:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800367:	89 d0                	mov    %edx,%eax
  800369:	c1 e0 03             	shl    $0x3,%eax
  80036c:	01 d0                	add    %edx,%eax
  80036e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800375:	01 c8                	add    %ecx,%eax
  800377:	01 c0                	add    %eax,%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	01 c0                	add    %eax,%eax
  80037d:	01 d0                	add    %edx,%eax
  80037f:	89 c2                	mov    %eax,%edx
  800381:	c1 e2 05             	shl    $0x5,%edx
  800384:	29 c2                	sub    %eax,%edx
  800386:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80038d:	89 c2                	mov    %eax,%edx
  80038f:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800395:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80039a:	a1 20 30 80 00       	mov    0x803020,%eax
  80039f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8003a5:	84 c0                	test   %al,%al
  8003a7:	74 0f                	je     8003b8 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8003a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ae:	05 40 3c 01 00       	add    $0x13c40,%eax
  8003b3:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003b8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003bc:	7e 0a                	jle    8003c8 <libmain+0x72>
		binaryname = argv[0];
  8003be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c1:	8b 00                	mov    (%eax),%eax
  8003c3:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8003c8:	83 ec 08             	sub    $0x8,%esp
  8003cb:	ff 75 0c             	pushl  0xc(%ebp)
  8003ce:	ff 75 08             	pushl  0x8(%ebp)
  8003d1:	e8 62 fc ff ff       	call   800038 <_main>
  8003d6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003d9:	e8 47 12 00 00       	call   801625 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003de:	83 ec 0c             	sub    $0xc,%esp
  8003e1:	68 e8 1e 80 00       	push   $0x801ee8
  8003e6:	e8 84 01 00 00       	call   80056f <cprintf>
  8003eb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f3:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8003f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fe:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800404:	83 ec 04             	sub    $0x4,%esp
  800407:	52                   	push   %edx
  800408:	50                   	push   %eax
  800409:	68 10 1f 80 00       	push   $0x801f10
  80040e:	e8 5c 01 00 00       	call   80056f <cprintf>
  800413:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800416:	a1 20 30 80 00       	mov    0x803020,%eax
  80041b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800421:	a1 20 30 80 00       	mov    0x803020,%eax
  800426:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80042c:	83 ec 04             	sub    $0x4,%esp
  80042f:	52                   	push   %edx
  800430:	50                   	push   %eax
  800431:	68 38 1f 80 00       	push   $0x801f38
  800436:	e8 34 01 00 00       	call   80056f <cprintf>
  80043b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80043e:	a1 20 30 80 00       	mov    0x803020,%eax
  800443:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800449:	83 ec 08             	sub    $0x8,%esp
  80044c:	50                   	push   %eax
  80044d:	68 79 1f 80 00       	push   $0x801f79
  800452:	e8 18 01 00 00       	call   80056f <cprintf>
  800457:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80045a:	83 ec 0c             	sub    $0xc,%esp
  80045d:	68 e8 1e 80 00       	push   $0x801ee8
  800462:	e8 08 01 00 00       	call   80056f <cprintf>
  800467:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80046a:	e8 d0 11 00 00       	call   80163f <sys_enable_interrupt>

	// exit gracefully
	exit();
  80046f:	e8 19 00 00 00       	call   80048d <exit>
}
  800474:	90                   	nop
  800475:	c9                   	leave  
  800476:	c3                   	ret    

00800477 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800477:	55                   	push   %ebp
  800478:	89 e5                	mov    %esp,%ebp
  80047a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80047d:	83 ec 0c             	sub    $0xc,%esp
  800480:	6a 00                	push   $0x0
  800482:	e8 cf 0f 00 00       	call   801456 <sys_env_destroy>
  800487:	83 c4 10             	add    $0x10,%esp
}
  80048a:	90                   	nop
  80048b:	c9                   	leave  
  80048c:	c3                   	ret    

0080048d <exit>:

void
exit(void)
{
  80048d:	55                   	push   %ebp
  80048e:	89 e5                	mov    %esp,%ebp
  800490:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800493:	e8 24 10 00 00       	call   8014bc <sys_env_exit>
}
  800498:	90                   	nop
  800499:	c9                   	leave  
  80049a:	c3                   	ret    

0080049b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80049b:	55                   	push   %ebp
  80049c:	89 e5                	mov    %esp,%ebp
  80049e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a4:	8b 00                	mov    (%eax),%eax
  8004a6:	8d 48 01             	lea    0x1(%eax),%ecx
  8004a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004ac:	89 0a                	mov    %ecx,(%edx)
  8004ae:	8b 55 08             	mov    0x8(%ebp),%edx
  8004b1:	88 d1                	mov    %dl,%cl
  8004b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b6:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bd:	8b 00                	mov    (%eax),%eax
  8004bf:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004c4:	75 2c                	jne    8004f2 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004c6:	a0 24 30 80 00       	mov    0x803024,%al
  8004cb:	0f b6 c0             	movzbl %al,%eax
  8004ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d1:	8b 12                	mov    (%edx),%edx
  8004d3:	89 d1                	mov    %edx,%ecx
  8004d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d8:	83 c2 08             	add    $0x8,%edx
  8004db:	83 ec 04             	sub    $0x4,%esp
  8004de:	50                   	push   %eax
  8004df:	51                   	push   %ecx
  8004e0:	52                   	push   %edx
  8004e1:	e8 2e 0f 00 00       	call   801414 <sys_cputs>
  8004e6:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f5:	8b 40 04             	mov    0x4(%eax),%eax
  8004f8:	8d 50 01             	lea    0x1(%eax),%edx
  8004fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004fe:	89 50 04             	mov    %edx,0x4(%eax)
}
  800501:	90                   	nop
  800502:	c9                   	leave  
  800503:	c3                   	ret    

00800504 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800504:	55                   	push   %ebp
  800505:	89 e5                	mov    %esp,%ebp
  800507:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80050d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800514:	00 00 00 
	b.cnt = 0;
  800517:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80051e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800521:	ff 75 0c             	pushl  0xc(%ebp)
  800524:	ff 75 08             	pushl  0x8(%ebp)
  800527:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80052d:	50                   	push   %eax
  80052e:	68 9b 04 80 00       	push   $0x80049b
  800533:	e8 11 02 00 00       	call   800749 <vprintfmt>
  800538:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80053b:	a0 24 30 80 00       	mov    0x803024,%al
  800540:	0f b6 c0             	movzbl %al,%eax
  800543:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800549:	83 ec 04             	sub    $0x4,%esp
  80054c:	50                   	push   %eax
  80054d:	52                   	push   %edx
  80054e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800554:	83 c0 08             	add    $0x8,%eax
  800557:	50                   	push   %eax
  800558:	e8 b7 0e 00 00       	call   801414 <sys_cputs>
  80055d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800560:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800567:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80056d:	c9                   	leave  
  80056e:	c3                   	ret    

0080056f <cprintf>:

int cprintf(const char *fmt, ...) {
  80056f:	55                   	push   %ebp
  800570:	89 e5                	mov    %esp,%ebp
  800572:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800575:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80057c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80057f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	83 ec 08             	sub    $0x8,%esp
  800588:	ff 75 f4             	pushl  -0xc(%ebp)
  80058b:	50                   	push   %eax
  80058c:	e8 73 ff ff ff       	call   800504 <vcprintf>
  800591:	83 c4 10             	add    $0x10,%esp
  800594:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800597:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80059a:	c9                   	leave  
  80059b:	c3                   	ret    

0080059c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80059c:	55                   	push   %ebp
  80059d:	89 e5                	mov    %esp,%ebp
  80059f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005a2:	e8 7e 10 00 00       	call   801625 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005a7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b0:	83 ec 08             	sub    $0x8,%esp
  8005b3:	ff 75 f4             	pushl  -0xc(%ebp)
  8005b6:	50                   	push   %eax
  8005b7:	e8 48 ff ff ff       	call   800504 <vcprintf>
  8005bc:	83 c4 10             	add    $0x10,%esp
  8005bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005c2:	e8 78 10 00 00       	call   80163f <sys_enable_interrupt>
	return cnt;
  8005c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005ca:	c9                   	leave  
  8005cb:	c3                   	ret    

008005cc <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005cc:	55                   	push   %ebp
  8005cd:	89 e5                	mov    %esp,%ebp
  8005cf:	53                   	push   %ebx
  8005d0:	83 ec 14             	sub    $0x14,%esp
  8005d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8005d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005df:	8b 45 18             	mov    0x18(%ebp),%eax
  8005e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8005e7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005ea:	77 55                	ja     800641 <printnum+0x75>
  8005ec:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005ef:	72 05                	jb     8005f6 <printnum+0x2a>
  8005f1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005f4:	77 4b                	ja     800641 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005f6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005f9:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005fc:	8b 45 18             	mov    0x18(%ebp),%eax
  8005ff:	ba 00 00 00 00       	mov    $0x0,%edx
  800604:	52                   	push   %edx
  800605:	50                   	push   %eax
  800606:	ff 75 f4             	pushl  -0xc(%ebp)
  800609:	ff 75 f0             	pushl  -0x10(%ebp)
  80060c:	e8 03 16 00 00       	call   801c14 <__udivdi3>
  800611:	83 c4 10             	add    $0x10,%esp
  800614:	83 ec 04             	sub    $0x4,%esp
  800617:	ff 75 20             	pushl  0x20(%ebp)
  80061a:	53                   	push   %ebx
  80061b:	ff 75 18             	pushl  0x18(%ebp)
  80061e:	52                   	push   %edx
  80061f:	50                   	push   %eax
  800620:	ff 75 0c             	pushl  0xc(%ebp)
  800623:	ff 75 08             	pushl  0x8(%ebp)
  800626:	e8 a1 ff ff ff       	call   8005cc <printnum>
  80062b:	83 c4 20             	add    $0x20,%esp
  80062e:	eb 1a                	jmp    80064a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800630:	83 ec 08             	sub    $0x8,%esp
  800633:	ff 75 0c             	pushl  0xc(%ebp)
  800636:	ff 75 20             	pushl  0x20(%ebp)
  800639:	8b 45 08             	mov    0x8(%ebp),%eax
  80063c:	ff d0                	call   *%eax
  80063e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800641:	ff 4d 1c             	decl   0x1c(%ebp)
  800644:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800648:	7f e6                	jg     800630 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80064a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80064d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800652:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800655:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800658:	53                   	push   %ebx
  800659:	51                   	push   %ecx
  80065a:	52                   	push   %edx
  80065b:	50                   	push   %eax
  80065c:	e8 c3 16 00 00       	call   801d24 <__umoddi3>
  800661:	83 c4 10             	add    $0x10,%esp
  800664:	05 b4 21 80 00       	add    $0x8021b4,%eax
  800669:	8a 00                	mov    (%eax),%al
  80066b:	0f be c0             	movsbl %al,%eax
  80066e:	83 ec 08             	sub    $0x8,%esp
  800671:	ff 75 0c             	pushl  0xc(%ebp)
  800674:	50                   	push   %eax
  800675:	8b 45 08             	mov    0x8(%ebp),%eax
  800678:	ff d0                	call   *%eax
  80067a:	83 c4 10             	add    $0x10,%esp
}
  80067d:	90                   	nop
  80067e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800681:	c9                   	leave  
  800682:	c3                   	ret    

00800683 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800683:	55                   	push   %ebp
  800684:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800686:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80068a:	7e 1c                	jle    8006a8 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80068c:	8b 45 08             	mov    0x8(%ebp),%eax
  80068f:	8b 00                	mov    (%eax),%eax
  800691:	8d 50 08             	lea    0x8(%eax),%edx
  800694:	8b 45 08             	mov    0x8(%ebp),%eax
  800697:	89 10                	mov    %edx,(%eax)
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	83 e8 08             	sub    $0x8,%eax
  8006a1:	8b 50 04             	mov    0x4(%eax),%edx
  8006a4:	8b 00                	mov    (%eax),%eax
  8006a6:	eb 40                	jmp    8006e8 <getuint+0x65>
	else if (lflag)
  8006a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006ac:	74 1e                	je     8006cc <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b1:	8b 00                	mov    (%eax),%eax
  8006b3:	8d 50 04             	lea    0x4(%eax),%edx
  8006b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b9:	89 10                	mov    %edx,(%eax)
  8006bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006be:	8b 00                	mov    (%eax),%eax
  8006c0:	83 e8 04             	sub    $0x4,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	ba 00 00 00 00       	mov    $0x0,%edx
  8006ca:	eb 1c                	jmp    8006e8 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cf:	8b 00                	mov    (%eax),%eax
  8006d1:	8d 50 04             	lea    0x4(%eax),%edx
  8006d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d7:	89 10                	mov    %edx,(%eax)
  8006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dc:	8b 00                	mov    (%eax),%eax
  8006de:	83 e8 04             	sub    $0x4,%eax
  8006e1:	8b 00                	mov    (%eax),%eax
  8006e3:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006e8:	5d                   	pop    %ebp
  8006e9:	c3                   	ret    

008006ea <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006ea:	55                   	push   %ebp
  8006eb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006ed:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006f1:	7e 1c                	jle    80070f <getint+0x25>
		return va_arg(*ap, long long);
  8006f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f6:	8b 00                	mov    (%eax),%eax
  8006f8:	8d 50 08             	lea    0x8(%eax),%edx
  8006fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fe:	89 10                	mov    %edx,(%eax)
  800700:	8b 45 08             	mov    0x8(%ebp),%eax
  800703:	8b 00                	mov    (%eax),%eax
  800705:	83 e8 08             	sub    $0x8,%eax
  800708:	8b 50 04             	mov    0x4(%eax),%edx
  80070b:	8b 00                	mov    (%eax),%eax
  80070d:	eb 38                	jmp    800747 <getint+0x5d>
	else if (lflag)
  80070f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800713:	74 1a                	je     80072f <getint+0x45>
		return va_arg(*ap, long);
  800715:	8b 45 08             	mov    0x8(%ebp),%eax
  800718:	8b 00                	mov    (%eax),%eax
  80071a:	8d 50 04             	lea    0x4(%eax),%edx
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	89 10                	mov    %edx,(%eax)
  800722:	8b 45 08             	mov    0x8(%ebp),%eax
  800725:	8b 00                	mov    (%eax),%eax
  800727:	83 e8 04             	sub    $0x4,%eax
  80072a:	8b 00                	mov    (%eax),%eax
  80072c:	99                   	cltd   
  80072d:	eb 18                	jmp    800747 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	8b 00                	mov    (%eax),%eax
  800734:	8d 50 04             	lea    0x4(%eax),%edx
  800737:	8b 45 08             	mov    0x8(%ebp),%eax
  80073a:	89 10                	mov    %edx,(%eax)
  80073c:	8b 45 08             	mov    0x8(%ebp),%eax
  80073f:	8b 00                	mov    (%eax),%eax
  800741:	83 e8 04             	sub    $0x4,%eax
  800744:	8b 00                	mov    (%eax),%eax
  800746:	99                   	cltd   
}
  800747:	5d                   	pop    %ebp
  800748:	c3                   	ret    

00800749 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800749:	55                   	push   %ebp
  80074a:	89 e5                	mov    %esp,%ebp
  80074c:	56                   	push   %esi
  80074d:	53                   	push   %ebx
  80074e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800751:	eb 17                	jmp    80076a <vprintfmt+0x21>
			if (ch == '\0')
  800753:	85 db                	test   %ebx,%ebx
  800755:	0f 84 af 03 00 00    	je     800b0a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80075b:	83 ec 08             	sub    $0x8,%esp
  80075e:	ff 75 0c             	pushl  0xc(%ebp)
  800761:	53                   	push   %ebx
  800762:	8b 45 08             	mov    0x8(%ebp),%eax
  800765:	ff d0                	call   *%eax
  800767:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80076a:	8b 45 10             	mov    0x10(%ebp),%eax
  80076d:	8d 50 01             	lea    0x1(%eax),%edx
  800770:	89 55 10             	mov    %edx,0x10(%ebp)
  800773:	8a 00                	mov    (%eax),%al
  800775:	0f b6 d8             	movzbl %al,%ebx
  800778:	83 fb 25             	cmp    $0x25,%ebx
  80077b:	75 d6                	jne    800753 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80077d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800781:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800788:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80078f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800796:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80079d:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a0:	8d 50 01             	lea    0x1(%eax),%edx
  8007a3:	89 55 10             	mov    %edx,0x10(%ebp)
  8007a6:	8a 00                	mov    (%eax),%al
  8007a8:	0f b6 d8             	movzbl %al,%ebx
  8007ab:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007ae:	83 f8 55             	cmp    $0x55,%eax
  8007b1:	0f 87 2b 03 00 00    	ja     800ae2 <vprintfmt+0x399>
  8007b7:	8b 04 85 d8 21 80 00 	mov    0x8021d8(,%eax,4),%eax
  8007be:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007c0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007c4:	eb d7                	jmp    80079d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007c6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007ca:	eb d1                	jmp    80079d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007cc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007d3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007d6:	89 d0                	mov    %edx,%eax
  8007d8:	c1 e0 02             	shl    $0x2,%eax
  8007db:	01 d0                	add    %edx,%eax
  8007dd:	01 c0                	add    %eax,%eax
  8007df:	01 d8                	add    %ebx,%eax
  8007e1:	83 e8 30             	sub    $0x30,%eax
  8007e4:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ea:	8a 00                	mov    (%eax),%al
  8007ec:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007ef:	83 fb 2f             	cmp    $0x2f,%ebx
  8007f2:	7e 3e                	jle    800832 <vprintfmt+0xe9>
  8007f4:	83 fb 39             	cmp    $0x39,%ebx
  8007f7:	7f 39                	jg     800832 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007f9:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007fc:	eb d5                	jmp    8007d3 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800801:	83 c0 04             	add    $0x4,%eax
  800804:	89 45 14             	mov    %eax,0x14(%ebp)
  800807:	8b 45 14             	mov    0x14(%ebp),%eax
  80080a:	83 e8 04             	sub    $0x4,%eax
  80080d:	8b 00                	mov    (%eax),%eax
  80080f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800812:	eb 1f                	jmp    800833 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800814:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800818:	79 83                	jns    80079d <vprintfmt+0x54>
				width = 0;
  80081a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800821:	e9 77 ff ff ff       	jmp    80079d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800826:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80082d:	e9 6b ff ff ff       	jmp    80079d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800832:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800833:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800837:	0f 89 60 ff ff ff    	jns    80079d <vprintfmt+0x54>
				width = precision, precision = -1;
  80083d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800840:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800843:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80084a:	e9 4e ff ff ff       	jmp    80079d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80084f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800852:	e9 46 ff ff ff       	jmp    80079d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800857:	8b 45 14             	mov    0x14(%ebp),%eax
  80085a:	83 c0 04             	add    $0x4,%eax
  80085d:	89 45 14             	mov    %eax,0x14(%ebp)
  800860:	8b 45 14             	mov    0x14(%ebp),%eax
  800863:	83 e8 04             	sub    $0x4,%eax
  800866:	8b 00                	mov    (%eax),%eax
  800868:	83 ec 08             	sub    $0x8,%esp
  80086b:	ff 75 0c             	pushl  0xc(%ebp)
  80086e:	50                   	push   %eax
  80086f:	8b 45 08             	mov    0x8(%ebp),%eax
  800872:	ff d0                	call   *%eax
  800874:	83 c4 10             	add    $0x10,%esp
			break;
  800877:	e9 89 02 00 00       	jmp    800b05 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80087c:	8b 45 14             	mov    0x14(%ebp),%eax
  80087f:	83 c0 04             	add    $0x4,%eax
  800882:	89 45 14             	mov    %eax,0x14(%ebp)
  800885:	8b 45 14             	mov    0x14(%ebp),%eax
  800888:	83 e8 04             	sub    $0x4,%eax
  80088b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80088d:	85 db                	test   %ebx,%ebx
  80088f:	79 02                	jns    800893 <vprintfmt+0x14a>
				err = -err;
  800891:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800893:	83 fb 64             	cmp    $0x64,%ebx
  800896:	7f 0b                	jg     8008a3 <vprintfmt+0x15a>
  800898:	8b 34 9d 20 20 80 00 	mov    0x802020(,%ebx,4),%esi
  80089f:	85 f6                	test   %esi,%esi
  8008a1:	75 19                	jne    8008bc <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008a3:	53                   	push   %ebx
  8008a4:	68 c5 21 80 00       	push   $0x8021c5
  8008a9:	ff 75 0c             	pushl  0xc(%ebp)
  8008ac:	ff 75 08             	pushl  0x8(%ebp)
  8008af:	e8 5e 02 00 00       	call   800b12 <printfmt>
  8008b4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008b7:	e9 49 02 00 00       	jmp    800b05 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008bc:	56                   	push   %esi
  8008bd:	68 ce 21 80 00       	push   $0x8021ce
  8008c2:	ff 75 0c             	pushl  0xc(%ebp)
  8008c5:	ff 75 08             	pushl  0x8(%ebp)
  8008c8:	e8 45 02 00 00       	call   800b12 <printfmt>
  8008cd:	83 c4 10             	add    $0x10,%esp
			break;
  8008d0:	e9 30 02 00 00       	jmp    800b05 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d8:	83 c0 04             	add    $0x4,%eax
  8008db:	89 45 14             	mov    %eax,0x14(%ebp)
  8008de:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e1:	83 e8 04             	sub    $0x4,%eax
  8008e4:	8b 30                	mov    (%eax),%esi
  8008e6:	85 f6                	test   %esi,%esi
  8008e8:	75 05                	jne    8008ef <vprintfmt+0x1a6>
				p = "(null)";
  8008ea:	be d1 21 80 00       	mov    $0x8021d1,%esi
			if (width > 0 && padc != '-')
  8008ef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008f3:	7e 6d                	jle    800962 <vprintfmt+0x219>
  8008f5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008f9:	74 67                	je     800962 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008fe:	83 ec 08             	sub    $0x8,%esp
  800901:	50                   	push   %eax
  800902:	56                   	push   %esi
  800903:	e8 0c 03 00 00       	call   800c14 <strnlen>
  800908:	83 c4 10             	add    $0x10,%esp
  80090b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80090e:	eb 16                	jmp    800926 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800910:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800914:	83 ec 08             	sub    $0x8,%esp
  800917:	ff 75 0c             	pushl  0xc(%ebp)
  80091a:	50                   	push   %eax
  80091b:	8b 45 08             	mov    0x8(%ebp),%eax
  80091e:	ff d0                	call   *%eax
  800920:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800923:	ff 4d e4             	decl   -0x1c(%ebp)
  800926:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80092a:	7f e4                	jg     800910 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80092c:	eb 34                	jmp    800962 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80092e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800932:	74 1c                	je     800950 <vprintfmt+0x207>
  800934:	83 fb 1f             	cmp    $0x1f,%ebx
  800937:	7e 05                	jle    80093e <vprintfmt+0x1f5>
  800939:	83 fb 7e             	cmp    $0x7e,%ebx
  80093c:	7e 12                	jle    800950 <vprintfmt+0x207>
					putch('?', putdat);
  80093e:	83 ec 08             	sub    $0x8,%esp
  800941:	ff 75 0c             	pushl  0xc(%ebp)
  800944:	6a 3f                	push   $0x3f
  800946:	8b 45 08             	mov    0x8(%ebp),%eax
  800949:	ff d0                	call   *%eax
  80094b:	83 c4 10             	add    $0x10,%esp
  80094e:	eb 0f                	jmp    80095f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800950:	83 ec 08             	sub    $0x8,%esp
  800953:	ff 75 0c             	pushl  0xc(%ebp)
  800956:	53                   	push   %ebx
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	ff d0                	call   *%eax
  80095c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80095f:	ff 4d e4             	decl   -0x1c(%ebp)
  800962:	89 f0                	mov    %esi,%eax
  800964:	8d 70 01             	lea    0x1(%eax),%esi
  800967:	8a 00                	mov    (%eax),%al
  800969:	0f be d8             	movsbl %al,%ebx
  80096c:	85 db                	test   %ebx,%ebx
  80096e:	74 24                	je     800994 <vprintfmt+0x24b>
  800970:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800974:	78 b8                	js     80092e <vprintfmt+0x1e5>
  800976:	ff 4d e0             	decl   -0x20(%ebp)
  800979:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80097d:	79 af                	jns    80092e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80097f:	eb 13                	jmp    800994 <vprintfmt+0x24b>
				putch(' ', putdat);
  800981:	83 ec 08             	sub    $0x8,%esp
  800984:	ff 75 0c             	pushl  0xc(%ebp)
  800987:	6a 20                	push   $0x20
  800989:	8b 45 08             	mov    0x8(%ebp),%eax
  80098c:	ff d0                	call   *%eax
  80098e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800991:	ff 4d e4             	decl   -0x1c(%ebp)
  800994:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800998:	7f e7                	jg     800981 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80099a:	e9 66 01 00 00       	jmp    800b05 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80099f:	83 ec 08             	sub    $0x8,%esp
  8009a2:	ff 75 e8             	pushl  -0x18(%ebp)
  8009a5:	8d 45 14             	lea    0x14(%ebp),%eax
  8009a8:	50                   	push   %eax
  8009a9:	e8 3c fd ff ff       	call   8006ea <getint>
  8009ae:	83 c4 10             	add    $0x10,%esp
  8009b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009bd:	85 d2                	test   %edx,%edx
  8009bf:	79 23                	jns    8009e4 <vprintfmt+0x29b>
				putch('-', putdat);
  8009c1:	83 ec 08             	sub    $0x8,%esp
  8009c4:	ff 75 0c             	pushl  0xc(%ebp)
  8009c7:	6a 2d                	push   $0x2d
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	ff d0                	call   *%eax
  8009ce:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009d7:	f7 d8                	neg    %eax
  8009d9:	83 d2 00             	adc    $0x0,%edx
  8009dc:	f7 da                	neg    %edx
  8009de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009e4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009eb:	e9 bc 00 00 00       	jmp    800aac <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009f0:	83 ec 08             	sub    $0x8,%esp
  8009f3:	ff 75 e8             	pushl  -0x18(%ebp)
  8009f6:	8d 45 14             	lea    0x14(%ebp),%eax
  8009f9:	50                   	push   %eax
  8009fa:	e8 84 fc ff ff       	call   800683 <getuint>
  8009ff:	83 c4 10             	add    $0x10,%esp
  800a02:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a05:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a08:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a0f:	e9 98 00 00 00       	jmp    800aac <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a14:	83 ec 08             	sub    $0x8,%esp
  800a17:	ff 75 0c             	pushl  0xc(%ebp)
  800a1a:	6a 58                	push   $0x58
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	ff d0                	call   *%eax
  800a21:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a24:	83 ec 08             	sub    $0x8,%esp
  800a27:	ff 75 0c             	pushl  0xc(%ebp)
  800a2a:	6a 58                	push   $0x58
  800a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2f:	ff d0                	call   *%eax
  800a31:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a34:	83 ec 08             	sub    $0x8,%esp
  800a37:	ff 75 0c             	pushl  0xc(%ebp)
  800a3a:	6a 58                	push   $0x58
  800a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3f:	ff d0                	call   *%eax
  800a41:	83 c4 10             	add    $0x10,%esp
			break;
  800a44:	e9 bc 00 00 00       	jmp    800b05 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a49:	83 ec 08             	sub    $0x8,%esp
  800a4c:	ff 75 0c             	pushl  0xc(%ebp)
  800a4f:	6a 30                	push   $0x30
  800a51:	8b 45 08             	mov    0x8(%ebp),%eax
  800a54:	ff d0                	call   *%eax
  800a56:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a59:	83 ec 08             	sub    $0x8,%esp
  800a5c:	ff 75 0c             	pushl  0xc(%ebp)
  800a5f:	6a 78                	push   $0x78
  800a61:	8b 45 08             	mov    0x8(%ebp),%eax
  800a64:	ff d0                	call   *%eax
  800a66:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a69:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6c:	83 c0 04             	add    $0x4,%eax
  800a6f:	89 45 14             	mov    %eax,0x14(%ebp)
  800a72:	8b 45 14             	mov    0x14(%ebp),%eax
  800a75:	83 e8 04             	sub    $0x4,%eax
  800a78:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a84:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a8b:	eb 1f                	jmp    800aac <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a8d:	83 ec 08             	sub    $0x8,%esp
  800a90:	ff 75 e8             	pushl  -0x18(%ebp)
  800a93:	8d 45 14             	lea    0x14(%ebp),%eax
  800a96:	50                   	push   %eax
  800a97:	e8 e7 fb ff ff       	call   800683 <getuint>
  800a9c:	83 c4 10             	add    $0x10,%esp
  800a9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aa2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800aa5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800aac:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ab0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ab3:	83 ec 04             	sub    $0x4,%esp
  800ab6:	52                   	push   %edx
  800ab7:	ff 75 e4             	pushl  -0x1c(%ebp)
  800aba:	50                   	push   %eax
  800abb:	ff 75 f4             	pushl  -0xc(%ebp)
  800abe:	ff 75 f0             	pushl  -0x10(%ebp)
  800ac1:	ff 75 0c             	pushl  0xc(%ebp)
  800ac4:	ff 75 08             	pushl  0x8(%ebp)
  800ac7:	e8 00 fb ff ff       	call   8005cc <printnum>
  800acc:	83 c4 20             	add    $0x20,%esp
			break;
  800acf:	eb 34                	jmp    800b05 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ad1:	83 ec 08             	sub    $0x8,%esp
  800ad4:	ff 75 0c             	pushl  0xc(%ebp)
  800ad7:	53                   	push   %ebx
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	ff d0                	call   *%eax
  800add:	83 c4 10             	add    $0x10,%esp
			break;
  800ae0:	eb 23                	jmp    800b05 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ae2:	83 ec 08             	sub    $0x8,%esp
  800ae5:	ff 75 0c             	pushl  0xc(%ebp)
  800ae8:	6a 25                	push   $0x25
  800aea:	8b 45 08             	mov    0x8(%ebp),%eax
  800aed:	ff d0                	call   *%eax
  800aef:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800af2:	ff 4d 10             	decl   0x10(%ebp)
  800af5:	eb 03                	jmp    800afa <vprintfmt+0x3b1>
  800af7:	ff 4d 10             	decl   0x10(%ebp)
  800afa:	8b 45 10             	mov    0x10(%ebp),%eax
  800afd:	48                   	dec    %eax
  800afe:	8a 00                	mov    (%eax),%al
  800b00:	3c 25                	cmp    $0x25,%al
  800b02:	75 f3                	jne    800af7 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b04:	90                   	nop
		}
	}
  800b05:	e9 47 fc ff ff       	jmp    800751 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b0a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b0b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b0e:	5b                   	pop    %ebx
  800b0f:	5e                   	pop    %esi
  800b10:	5d                   	pop    %ebp
  800b11:	c3                   	ret    

00800b12 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b12:	55                   	push   %ebp
  800b13:	89 e5                	mov    %esp,%ebp
  800b15:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b18:	8d 45 10             	lea    0x10(%ebp),%eax
  800b1b:	83 c0 04             	add    $0x4,%eax
  800b1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b21:	8b 45 10             	mov    0x10(%ebp),%eax
  800b24:	ff 75 f4             	pushl  -0xc(%ebp)
  800b27:	50                   	push   %eax
  800b28:	ff 75 0c             	pushl  0xc(%ebp)
  800b2b:	ff 75 08             	pushl  0x8(%ebp)
  800b2e:	e8 16 fc ff ff       	call   800749 <vprintfmt>
  800b33:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b36:	90                   	nop
  800b37:	c9                   	leave  
  800b38:	c3                   	ret    

00800b39 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b39:	55                   	push   %ebp
  800b3a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3f:	8b 40 08             	mov    0x8(%eax),%eax
  800b42:	8d 50 01             	lea    0x1(%eax),%edx
  800b45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b48:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4e:	8b 10                	mov    (%eax),%edx
  800b50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b53:	8b 40 04             	mov    0x4(%eax),%eax
  800b56:	39 c2                	cmp    %eax,%edx
  800b58:	73 12                	jae    800b6c <sprintputch+0x33>
		*b->buf++ = ch;
  800b5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5d:	8b 00                	mov    (%eax),%eax
  800b5f:	8d 48 01             	lea    0x1(%eax),%ecx
  800b62:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b65:	89 0a                	mov    %ecx,(%edx)
  800b67:	8b 55 08             	mov    0x8(%ebp),%edx
  800b6a:	88 10                	mov    %dl,(%eax)
}
  800b6c:	90                   	nop
  800b6d:	5d                   	pop    %ebp
  800b6e:	c3                   	ret    

00800b6f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b6f:	55                   	push   %ebp
  800b70:	89 e5                	mov    %esp,%ebp
  800b72:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	01 d0                	add    %edx,%eax
  800b86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b89:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b90:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b94:	74 06                	je     800b9c <vsnprintf+0x2d>
  800b96:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b9a:	7f 07                	jg     800ba3 <vsnprintf+0x34>
		return -E_INVAL;
  800b9c:	b8 03 00 00 00       	mov    $0x3,%eax
  800ba1:	eb 20                	jmp    800bc3 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ba3:	ff 75 14             	pushl  0x14(%ebp)
  800ba6:	ff 75 10             	pushl  0x10(%ebp)
  800ba9:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bac:	50                   	push   %eax
  800bad:	68 39 0b 80 00       	push   $0x800b39
  800bb2:	e8 92 fb ff ff       	call   800749 <vprintfmt>
  800bb7:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bbd:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bc3:	c9                   	leave  
  800bc4:	c3                   	ret    

00800bc5 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bc5:	55                   	push   %ebp
  800bc6:	89 e5                	mov    %esp,%ebp
  800bc8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bcb:	8d 45 10             	lea    0x10(%ebp),%eax
  800bce:	83 c0 04             	add    $0x4,%eax
  800bd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd7:	ff 75 f4             	pushl  -0xc(%ebp)
  800bda:	50                   	push   %eax
  800bdb:	ff 75 0c             	pushl  0xc(%ebp)
  800bde:	ff 75 08             	pushl  0x8(%ebp)
  800be1:	e8 89 ff ff ff       	call   800b6f <vsnprintf>
  800be6:	83 c4 10             	add    $0x10,%esp
  800be9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800bec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bef:	c9                   	leave  
  800bf0:	c3                   	ret    

00800bf1 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bf1:	55                   	push   %ebp
  800bf2:	89 e5                	mov    %esp,%ebp
  800bf4:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bf7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bfe:	eb 06                	jmp    800c06 <strlen+0x15>
		n++;
  800c00:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c03:	ff 45 08             	incl   0x8(%ebp)
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	8a 00                	mov    (%eax),%al
  800c0b:	84 c0                	test   %al,%al
  800c0d:	75 f1                	jne    800c00 <strlen+0xf>
		n++;
	return n;
  800c0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c12:	c9                   	leave  
  800c13:	c3                   	ret    

00800c14 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c14:	55                   	push   %ebp
  800c15:	89 e5                	mov    %esp,%ebp
  800c17:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c1a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c21:	eb 09                	jmp    800c2c <strnlen+0x18>
		n++;
  800c23:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c26:	ff 45 08             	incl   0x8(%ebp)
  800c29:	ff 4d 0c             	decl   0xc(%ebp)
  800c2c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c30:	74 09                	je     800c3b <strnlen+0x27>
  800c32:	8b 45 08             	mov    0x8(%ebp),%eax
  800c35:	8a 00                	mov    (%eax),%al
  800c37:	84 c0                	test   %al,%al
  800c39:	75 e8                	jne    800c23 <strnlen+0xf>
		n++;
	return n;
  800c3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c3e:	c9                   	leave  
  800c3f:	c3                   	ret    

00800c40 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c40:	55                   	push   %ebp
  800c41:	89 e5                	mov    %esp,%ebp
  800c43:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c4c:	90                   	nop
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	8d 50 01             	lea    0x1(%eax),%edx
  800c53:	89 55 08             	mov    %edx,0x8(%ebp)
  800c56:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c59:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c5c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c5f:	8a 12                	mov    (%edx),%dl
  800c61:	88 10                	mov    %dl,(%eax)
  800c63:	8a 00                	mov    (%eax),%al
  800c65:	84 c0                	test   %al,%al
  800c67:	75 e4                	jne    800c4d <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c69:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c6c:	c9                   	leave  
  800c6d:	c3                   	ret    

00800c6e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
  800c71:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c74:	8b 45 08             	mov    0x8(%ebp),%eax
  800c77:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c81:	eb 1f                	jmp    800ca2 <strncpy+0x34>
		*dst++ = *src;
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	8d 50 01             	lea    0x1(%eax),%edx
  800c89:	89 55 08             	mov    %edx,0x8(%ebp)
  800c8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c8f:	8a 12                	mov    (%edx),%dl
  800c91:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c96:	8a 00                	mov    (%eax),%al
  800c98:	84 c0                	test   %al,%al
  800c9a:	74 03                	je     800c9f <strncpy+0x31>
			src++;
  800c9c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c9f:	ff 45 fc             	incl   -0x4(%ebp)
  800ca2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ca5:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ca8:	72 d9                	jb     800c83 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800caa:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cad:	c9                   	leave  
  800cae:	c3                   	ret    

00800caf <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800caf:	55                   	push   %ebp
  800cb0:	89 e5                	mov    %esp,%ebp
  800cb2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cbb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cbf:	74 30                	je     800cf1 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800cc1:	eb 16                	jmp    800cd9 <strlcpy+0x2a>
			*dst++ = *src++;
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	8d 50 01             	lea    0x1(%eax),%edx
  800cc9:	89 55 08             	mov    %edx,0x8(%ebp)
  800ccc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ccf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cd2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cd5:	8a 12                	mov    (%edx),%dl
  800cd7:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800cd9:	ff 4d 10             	decl   0x10(%ebp)
  800cdc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce0:	74 09                	je     800ceb <strlcpy+0x3c>
  800ce2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	84 c0                	test   %al,%al
  800ce9:	75 d8                	jne    800cc3 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cf1:	8b 55 08             	mov    0x8(%ebp),%edx
  800cf4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf7:	29 c2                	sub    %eax,%edx
  800cf9:	89 d0                	mov    %edx,%eax
}
  800cfb:	c9                   	leave  
  800cfc:	c3                   	ret    

00800cfd <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d00:	eb 06                	jmp    800d08 <strcmp+0xb>
		p++, q++;
  800d02:	ff 45 08             	incl   0x8(%ebp)
  800d05:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	8a 00                	mov    (%eax),%al
  800d0d:	84 c0                	test   %al,%al
  800d0f:	74 0e                	je     800d1f <strcmp+0x22>
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	8a 10                	mov    (%eax),%dl
  800d16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	38 c2                	cmp    %al,%dl
  800d1d:	74 e3                	je     800d02 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8a 00                	mov    (%eax),%al
  800d24:	0f b6 d0             	movzbl %al,%edx
  800d27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2a:	8a 00                	mov    (%eax),%al
  800d2c:	0f b6 c0             	movzbl %al,%eax
  800d2f:	29 c2                	sub    %eax,%edx
  800d31:	89 d0                	mov    %edx,%eax
}
  800d33:	5d                   	pop    %ebp
  800d34:	c3                   	ret    

00800d35 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d35:	55                   	push   %ebp
  800d36:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d38:	eb 09                	jmp    800d43 <strncmp+0xe>
		n--, p++, q++;
  800d3a:	ff 4d 10             	decl   0x10(%ebp)
  800d3d:	ff 45 08             	incl   0x8(%ebp)
  800d40:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d43:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d47:	74 17                	je     800d60 <strncmp+0x2b>
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	8a 00                	mov    (%eax),%al
  800d4e:	84 c0                	test   %al,%al
  800d50:	74 0e                	je     800d60 <strncmp+0x2b>
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8a 10                	mov    (%eax),%dl
  800d57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5a:	8a 00                	mov    (%eax),%al
  800d5c:	38 c2                	cmp    %al,%dl
  800d5e:	74 da                	je     800d3a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d60:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d64:	75 07                	jne    800d6d <strncmp+0x38>
		return 0;
  800d66:	b8 00 00 00 00       	mov    $0x0,%eax
  800d6b:	eb 14                	jmp    800d81 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	0f b6 d0             	movzbl %al,%edx
  800d75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d78:	8a 00                	mov    (%eax),%al
  800d7a:	0f b6 c0             	movzbl %al,%eax
  800d7d:	29 c2                	sub    %eax,%edx
  800d7f:	89 d0                	mov    %edx,%eax
}
  800d81:	5d                   	pop    %ebp
  800d82:	c3                   	ret    

00800d83 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d83:	55                   	push   %ebp
  800d84:	89 e5                	mov    %esp,%ebp
  800d86:	83 ec 04             	sub    $0x4,%esp
  800d89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d8f:	eb 12                	jmp    800da3 <strchr+0x20>
		if (*s == c)
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	8a 00                	mov    (%eax),%al
  800d96:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d99:	75 05                	jne    800da0 <strchr+0x1d>
			return (char *) s;
  800d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9e:	eb 11                	jmp    800db1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800da0:	ff 45 08             	incl   0x8(%ebp)
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
  800da6:	8a 00                	mov    (%eax),%al
  800da8:	84 c0                	test   %al,%al
  800daa:	75 e5                	jne    800d91 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800dac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800db1:	c9                   	leave  
  800db2:	c3                   	ret    

00800db3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800db3:	55                   	push   %ebp
  800db4:	89 e5                	mov    %esp,%ebp
  800db6:	83 ec 04             	sub    $0x4,%esp
  800db9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dbf:	eb 0d                	jmp    800dce <strfind+0x1b>
		if (*s == c)
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	8a 00                	mov    (%eax),%al
  800dc6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dc9:	74 0e                	je     800dd9 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800dcb:	ff 45 08             	incl   0x8(%ebp)
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	8a 00                	mov    (%eax),%al
  800dd3:	84 c0                	test   %al,%al
  800dd5:	75 ea                	jne    800dc1 <strfind+0xe>
  800dd7:	eb 01                	jmp    800dda <strfind+0x27>
		if (*s == c)
			break;
  800dd9:	90                   	nop
	return (char *) s;
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ddd:	c9                   	leave  
  800dde:	c3                   	ret    

00800ddf <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ddf:	55                   	push   %ebp
  800de0:	89 e5                	mov    %esp,%ebp
  800de2:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800deb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dee:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800df1:	eb 0e                	jmp    800e01 <memset+0x22>
		*p++ = c;
  800df3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df6:	8d 50 01             	lea    0x1(%eax),%edx
  800df9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800dfc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dff:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e01:	ff 4d f8             	decl   -0x8(%ebp)
  800e04:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e08:	79 e9                	jns    800df3 <memset+0x14>
		*p++ = c;

	return v;
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e0d:	c9                   	leave  
  800e0e:	c3                   	ret    

00800e0f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e0f:	55                   	push   %ebp
  800e10:	89 e5                	mov    %esp,%ebp
  800e12:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e18:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e21:	eb 16                	jmp    800e39 <memcpy+0x2a>
		*d++ = *s++;
  800e23:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e26:	8d 50 01             	lea    0x1(%eax),%edx
  800e29:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e2c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e2f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e32:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e35:	8a 12                	mov    (%edx),%dl
  800e37:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e39:	8b 45 10             	mov    0x10(%ebp),%eax
  800e3c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e42:	85 c0                	test   %eax,%eax
  800e44:	75 dd                	jne    800e23 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e49:	c9                   	leave  
  800e4a:	c3                   	ret    

00800e4b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e4b:	55                   	push   %ebp
  800e4c:	89 e5                	mov    %esp,%ebp
  800e4e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e54:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e60:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e63:	73 50                	jae    800eb5 <memmove+0x6a>
  800e65:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e68:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6b:	01 d0                	add    %edx,%eax
  800e6d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e70:	76 43                	jbe    800eb5 <memmove+0x6a>
		s += n;
  800e72:	8b 45 10             	mov    0x10(%ebp),%eax
  800e75:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e78:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e7e:	eb 10                	jmp    800e90 <memmove+0x45>
			*--d = *--s;
  800e80:	ff 4d f8             	decl   -0x8(%ebp)
  800e83:	ff 4d fc             	decl   -0x4(%ebp)
  800e86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e89:	8a 10                	mov    (%eax),%dl
  800e8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e8e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e90:	8b 45 10             	mov    0x10(%ebp),%eax
  800e93:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e96:	89 55 10             	mov    %edx,0x10(%ebp)
  800e99:	85 c0                	test   %eax,%eax
  800e9b:	75 e3                	jne    800e80 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e9d:	eb 23                	jmp    800ec2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea2:	8d 50 01             	lea    0x1(%eax),%edx
  800ea5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ea8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eab:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eae:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800eb1:	8a 12                	mov    (%edx),%dl
  800eb3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800eb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ebb:	89 55 10             	mov    %edx,0x10(%ebp)
  800ebe:	85 c0                	test   %eax,%eax
  800ec0:	75 dd                	jne    800e9f <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ec5:	c9                   	leave  
  800ec6:	c3                   	ret    

00800ec7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ec7:	55                   	push   %ebp
  800ec8:	89 e5                	mov    %esp,%ebp
  800eca:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ed3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ed9:	eb 2a                	jmp    800f05 <memcmp+0x3e>
		if (*s1 != *s2)
  800edb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ede:	8a 10                	mov    (%eax),%dl
  800ee0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee3:	8a 00                	mov    (%eax),%al
  800ee5:	38 c2                	cmp    %al,%dl
  800ee7:	74 16                	je     800eff <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ee9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eec:	8a 00                	mov    (%eax),%al
  800eee:	0f b6 d0             	movzbl %al,%edx
  800ef1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef4:	8a 00                	mov    (%eax),%al
  800ef6:	0f b6 c0             	movzbl %al,%eax
  800ef9:	29 c2                	sub    %eax,%edx
  800efb:	89 d0                	mov    %edx,%eax
  800efd:	eb 18                	jmp    800f17 <memcmp+0x50>
		s1++, s2++;
  800eff:	ff 45 fc             	incl   -0x4(%ebp)
  800f02:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f05:	8b 45 10             	mov    0x10(%ebp),%eax
  800f08:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f0b:	89 55 10             	mov    %edx,0x10(%ebp)
  800f0e:	85 c0                	test   %eax,%eax
  800f10:	75 c9                	jne    800edb <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f12:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f17:	c9                   	leave  
  800f18:	c3                   	ret    

00800f19 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f19:	55                   	push   %ebp
  800f1a:	89 e5                	mov    %esp,%ebp
  800f1c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f1f:	8b 55 08             	mov    0x8(%ebp),%edx
  800f22:	8b 45 10             	mov    0x10(%ebp),%eax
  800f25:	01 d0                	add    %edx,%eax
  800f27:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f2a:	eb 15                	jmp    800f41 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	0f b6 d0             	movzbl %al,%edx
  800f34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f37:	0f b6 c0             	movzbl %al,%eax
  800f3a:	39 c2                	cmp    %eax,%edx
  800f3c:	74 0d                	je     800f4b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f3e:	ff 45 08             	incl   0x8(%ebp)
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f47:	72 e3                	jb     800f2c <memfind+0x13>
  800f49:	eb 01                	jmp    800f4c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f4b:	90                   	nop
	return (void *) s;
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4f:	c9                   	leave  
  800f50:	c3                   	ret    

00800f51 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f51:	55                   	push   %ebp
  800f52:	89 e5                	mov    %esp,%ebp
  800f54:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f57:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f5e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f65:	eb 03                	jmp    800f6a <strtol+0x19>
		s++;
  800f67:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	8a 00                	mov    (%eax),%al
  800f6f:	3c 20                	cmp    $0x20,%al
  800f71:	74 f4                	je     800f67 <strtol+0x16>
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	3c 09                	cmp    $0x9,%al
  800f7a:	74 eb                	je     800f67 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	8a 00                	mov    (%eax),%al
  800f81:	3c 2b                	cmp    $0x2b,%al
  800f83:	75 05                	jne    800f8a <strtol+0x39>
		s++;
  800f85:	ff 45 08             	incl   0x8(%ebp)
  800f88:	eb 13                	jmp    800f9d <strtol+0x4c>
	else if (*s == '-')
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3c 2d                	cmp    $0x2d,%al
  800f91:	75 0a                	jne    800f9d <strtol+0x4c>
		s++, neg = 1;
  800f93:	ff 45 08             	incl   0x8(%ebp)
  800f96:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa1:	74 06                	je     800fa9 <strtol+0x58>
  800fa3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fa7:	75 20                	jne    800fc9 <strtol+0x78>
  800fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fac:	8a 00                	mov    (%eax),%al
  800fae:	3c 30                	cmp    $0x30,%al
  800fb0:	75 17                	jne    800fc9 <strtol+0x78>
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	40                   	inc    %eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	3c 78                	cmp    $0x78,%al
  800fba:	75 0d                	jne    800fc9 <strtol+0x78>
		s += 2, base = 16;
  800fbc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fc0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fc7:	eb 28                	jmp    800ff1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fc9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fcd:	75 15                	jne    800fe4 <strtol+0x93>
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	8a 00                	mov    (%eax),%al
  800fd4:	3c 30                	cmp    $0x30,%al
  800fd6:	75 0c                	jne    800fe4 <strtol+0x93>
		s++, base = 8;
  800fd8:	ff 45 08             	incl   0x8(%ebp)
  800fdb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fe2:	eb 0d                	jmp    800ff1 <strtol+0xa0>
	else if (base == 0)
  800fe4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fe8:	75 07                	jne    800ff1 <strtol+0xa0>
		base = 10;
  800fea:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff4:	8a 00                	mov    (%eax),%al
  800ff6:	3c 2f                	cmp    $0x2f,%al
  800ff8:	7e 19                	jle    801013 <strtol+0xc2>
  800ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	3c 39                	cmp    $0x39,%al
  801001:	7f 10                	jg     801013 <strtol+0xc2>
			dig = *s - '0';
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	8a 00                	mov    (%eax),%al
  801008:	0f be c0             	movsbl %al,%eax
  80100b:	83 e8 30             	sub    $0x30,%eax
  80100e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801011:	eb 42                	jmp    801055 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	8a 00                	mov    (%eax),%al
  801018:	3c 60                	cmp    $0x60,%al
  80101a:	7e 19                	jle    801035 <strtol+0xe4>
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
  80101f:	8a 00                	mov    (%eax),%al
  801021:	3c 7a                	cmp    $0x7a,%al
  801023:	7f 10                	jg     801035 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	8a 00                	mov    (%eax),%al
  80102a:	0f be c0             	movsbl %al,%eax
  80102d:	83 e8 57             	sub    $0x57,%eax
  801030:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801033:	eb 20                	jmp    801055 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	8a 00                	mov    (%eax),%al
  80103a:	3c 40                	cmp    $0x40,%al
  80103c:	7e 39                	jle    801077 <strtol+0x126>
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8a 00                	mov    (%eax),%al
  801043:	3c 5a                	cmp    $0x5a,%al
  801045:	7f 30                	jg     801077 <strtol+0x126>
			dig = *s - 'A' + 10;
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	8a 00                	mov    (%eax),%al
  80104c:	0f be c0             	movsbl %al,%eax
  80104f:	83 e8 37             	sub    $0x37,%eax
  801052:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801058:	3b 45 10             	cmp    0x10(%ebp),%eax
  80105b:	7d 19                	jge    801076 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80105d:	ff 45 08             	incl   0x8(%ebp)
  801060:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801063:	0f af 45 10          	imul   0x10(%ebp),%eax
  801067:	89 c2                	mov    %eax,%edx
  801069:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80106c:	01 d0                	add    %edx,%eax
  80106e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801071:	e9 7b ff ff ff       	jmp    800ff1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801076:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801077:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80107b:	74 08                	je     801085 <strtol+0x134>
		*endptr = (char *) s;
  80107d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801080:	8b 55 08             	mov    0x8(%ebp),%edx
  801083:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801085:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801089:	74 07                	je     801092 <strtol+0x141>
  80108b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80108e:	f7 d8                	neg    %eax
  801090:	eb 03                	jmp    801095 <strtol+0x144>
  801092:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801095:	c9                   	leave  
  801096:	c3                   	ret    

00801097 <ltostr>:

void
ltostr(long value, char *str)
{
  801097:	55                   	push   %ebp
  801098:	89 e5                	mov    %esp,%ebp
  80109a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80109d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010af:	79 13                	jns    8010c4 <ltostr+0x2d>
	{
		neg = 1;
  8010b1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010be:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010c1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010cc:	99                   	cltd   
  8010cd:	f7 f9                	idiv   %ecx
  8010cf:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d5:	8d 50 01             	lea    0x1(%eax),%edx
  8010d8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010db:	89 c2                	mov    %eax,%edx
  8010dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e0:	01 d0                	add    %edx,%eax
  8010e2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010e5:	83 c2 30             	add    $0x30,%edx
  8010e8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010ea:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010ed:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010f2:	f7 e9                	imul   %ecx
  8010f4:	c1 fa 02             	sar    $0x2,%edx
  8010f7:	89 c8                	mov    %ecx,%eax
  8010f9:	c1 f8 1f             	sar    $0x1f,%eax
  8010fc:	29 c2                	sub    %eax,%edx
  8010fe:	89 d0                	mov    %edx,%eax
  801100:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801106:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80110b:	f7 e9                	imul   %ecx
  80110d:	c1 fa 02             	sar    $0x2,%edx
  801110:	89 c8                	mov    %ecx,%eax
  801112:	c1 f8 1f             	sar    $0x1f,%eax
  801115:	29 c2                	sub    %eax,%edx
  801117:	89 d0                	mov    %edx,%eax
  801119:	c1 e0 02             	shl    $0x2,%eax
  80111c:	01 d0                	add    %edx,%eax
  80111e:	01 c0                	add    %eax,%eax
  801120:	29 c1                	sub    %eax,%ecx
  801122:	89 ca                	mov    %ecx,%edx
  801124:	85 d2                	test   %edx,%edx
  801126:	75 9c                	jne    8010c4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801128:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80112f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801132:	48                   	dec    %eax
  801133:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801136:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80113a:	74 3d                	je     801179 <ltostr+0xe2>
		start = 1 ;
  80113c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801143:	eb 34                	jmp    801179 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801145:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801148:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114b:	01 d0                	add    %edx,%eax
  80114d:	8a 00                	mov    (%eax),%al
  80114f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801152:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801155:	8b 45 0c             	mov    0xc(%ebp),%eax
  801158:	01 c2                	add    %eax,%edx
  80115a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80115d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801160:	01 c8                	add    %ecx,%eax
  801162:	8a 00                	mov    (%eax),%al
  801164:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801166:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801169:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116c:	01 c2                	add    %eax,%edx
  80116e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801171:	88 02                	mov    %al,(%edx)
		start++ ;
  801173:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801176:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801179:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80117c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80117f:	7c c4                	jl     801145 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801181:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801184:	8b 45 0c             	mov    0xc(%ebp),%eax
  801187:	01 d0                	add    %edx,%eax
  801189:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80118c:	90                   	nop
  80118d:	c9                   	leave  
  80118e:	c3                   	ret    

0080118f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
  801192:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801195:	ff 75 08             	pushl  0x8(%ebp)
  801198:	e8 54 fa ff ff       	call   800bf1 <strlen>
  80119d:	83 c4 04             	add    $0x4,%esp
  8011a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011a3:	ff 75 0c             	pushl  0xc(%ebp)
  8011a6:	e8 46 fa ff ff       	call   800bf1 <strlen>
  8011ab:	83 c4 04             	add    $0x4,%esp
  8011ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011bf:	eb 17                	jmp    8011d8 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c7:	01 c2                	add    %eax,%edx
  8011c9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cf:	01 c8                	add    %ecx,%eax
  8011d1:	8a 00                	mov    (%eax),%al
  8011d3:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011d5:	ff 45 fc             	incl   -0x4(%ebp)
  8011d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011db:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011de:	7c e1                	jl     8011c1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011e7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011ee:	eb 1f                	jmp    80120f <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011f3:	8d 50 01             	lea    0x1(%eax),%edx
  8011f6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011f9:	89 c2                	mov    %eax,%edx
  8011fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fe:	01 c2                	add    %eax,%edx
  801200:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801203:	8b 45 0c             	mov    0xc(%ebp),%eax
  801206:	01 c8                	add    %ecx,%eax
  801208:	8a 00                	mov    (%eax),%al
  80120a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80120c:	ff 45 f8             	incl   -0x8(%ebp)
  80120f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801212:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801215:	7c d9                	jl     8011f0 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801217:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80121a:	8b 45 10             	mov    0x10(%ebp),%eax
  80121d:	01 d0                	add    %edx,%eax
  80121f:	c6 00 00             	movb   $0x0,(%eax)
}
  801222:	90                   	nop
  801223:	c9                   	leave  
  801224:	c3                   	ret    

00801225 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801225:	55                   	push   %ebp
  801226:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801228:	8b 45 14             	mov    0x14(%ebp),%eax
  80122b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801231:	8b 45 14             	mov    0x14(%ebp),%eax
  801234:	8b 00                	mov    (%eax),%eax
  801236:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80123d:	8b 45 10             	mov    0x10(%ebp),%eax
  801240:	01 d0                	add    %edx,%eax
  801242:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801248:	eb 0c                	jmp    801256 <strsplit+0x31>
			*string++ = 0;
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
  80124d:	8d 50 01             	lea    0x1(%eax),%edx
  801250:	89 55 08             	mov    %edx,0x8(%ebp)
  801253:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	8a 00                	mov    (%eax),%al
  80125b:	84 c0                	test   %al,%al
  80125d:	74 18                	je     801277 <strsplit+0x52>
  80125f:	8b 45 08             	mov    0x8(%ebp),%eax
  801262:	8a 00                	mov    (%eax),%al
  801264:	0f be c0             	movsbl %al,%eax
  801267:	50                   	push   %eax
  801268:	ff 75 0c             	pushl  0xc(%ebp)
  80126b:	e8 13 fb ff ff       	call   800d83 <strchr>
  801270:	83 c4 08             	add    $0x8,%esp
  801273:	85 c0                	test   %eax,%eax
  801275:	75 d3                	jne    80124a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801277:	8b 45 08             	mov    0x8(%ebp),%eax
  80127a:	8a 00                	mov    (%eax),%al
  80127c:	84 c0                	test   %al,%al
  80127e:	74 5a                	je     8012da <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801280:	8b 45 14             	mov    0x14(%ebp),%eax
  801283:	8b 00                	mov    (%eax),%eax
  801285:	83 f8 0f             	cmp    $0xf,%eax
  801288:	75 07                	jne    801291 <strsplit+0x6c>
		{
			return 0;
  80128a:	b8 00 00 00 00       	mov    $0x0,%eax
  80128f:	eb 66                	jmp    8012f7 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801291:	8b 45 14             	mov    0x14(%ebp),%eax
  801294:	8b 00                	mov    (%eax),%eax
  801296:	8d 48 01             	lea    0x1(%eax),%ecx
  801299:	8b 55 14             	mov    0x14(%ebp),%edx
  80129c:	89 0a                	mov    %ecx,(%edx)
  80129e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a8:	01 c2                	add    %eax,%edx
  8012aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ad:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012af:	eb 03                	jmp    8012b4 <strsplit+0x8f>
			string++;
  8012b1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	8a 00                	mov    (%eax),%al
  8012b9:	84 c0                	test   %al,%al
  8012bb:	74 8b                	je     801248 <strsplit+0x23>
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	8a 00                	mov    (%eax),%al
  8012c2:	0f be c0             	movsbl %al,%eax
  8012c5:	50                   	push   %eax
  8012c6:	ff 75 0c             	pushl  0xc(%ebp)
  8012c9:	e8 b5 fa ff ff       	call   800d83 <strchr>
  8012ce:	83 c4 08             	add    $0x8,%esp
  8012d1:	85 c0                	test   %eax,%eax
  8012d3:	74 dc                	je     8012b1 <strsplit+0x8c>
			string++;
	}
  8012d5:	e9 6e ff ff ff       	jmp    801248 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012da:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012db:	8b 45 14             	mov    0x14(%ebp),%eax
  8012de:	8b 00                	mov    (%eax),%eax
  8012e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ea:	01 d0                	add    %edx,%eax
  8012ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012f2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012f7:	c9                   	leave  
  8012f8:	c3                   	ret    

008012f9 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8012f9:	55                   	push   %ebp
  8012fa:	89 e5                	mov    %esp,%ebp
  8012fc:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8012ff:	83 ec 04             	sub    $0x4,%esp
  801302:	68 30 23 80 00       	push   $0x802330
  801307:	6a 16                	push   $0x16
  801309:	68 55 23 80 00       	push   $0x802355
  80130e:	e8 33 07 00 00       	call   801a46 <_panic>

00801313 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801313:	55                   	push   %ebp
  801314:	89 e5                	mov    %esp,%ebp
  801316:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801319:	83 ec 04             	sub    $0x4,%esp
  80131c:	68 64 23 80 00       	push   $0x802364
  801321:	6a 2e                	push   $0x2e
  801323:	68 55 23 80 00       	push   $0x802355
  801328:	e8 19 07 00 00       	call   801a46 <_panic>

0080132d <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80132d:	55                   	push   %ebp
  80132e:	89 e5                	mov    %esp,%ebp
  801330:	83 ec 18             	sub    $0x18,%esp
  801333:	8b 45 10             	mov    0x10(%ebp),%eax
  801336:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801339:	83 ec 04             	sub    $0x4,%esp
  80133c:	68 88 23 80 00       	push   $0x802388
  801341:	6a 3b                	push   $0x3b
  801343:	68 55 23 80 00       	push   $0x802355
  801348:	e8 f9 06 00 00       	call   801a46 <_panic>

0080134d <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80134d:	55                   	push   %ebp
  80134e:	89 e5                	mov    %esp,%ebp
  801350:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801353:	83 ec 04             	sub    $0x4,%esp
  801356:	68 88 23 80 00       	push   $0x802388
  80135b:	6a 41                	push   $0x41
  80135d:	68 55 23 80 00       	push   $0x802355
  801362:	e8 df 06 00 00       	call   801a46 <_panic>

00801367 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801367:	55                   	push   %ebp
  801368:	89 e5                	mov    %esp,%ebp
  80136a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80136d:	83 ec 04             	sub    $0x4,%esp
  801370:	68 88 23 80 00       	push   $0x802388
  801375:	6a 47                	push   $0x47
  801377:	68 55 23 80 00       	push   $0x802355
  80137c:	e8 c5 06 00 00       	call   801a46 <_panic>

00801381 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801381:	55                   	push   %ebp
  801382:	89 e5                	mov    %esp,%ebp
  801384:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801387:	83 ec 04             	sub    $0x4,%esp
  80138a:	68 88 23 80 00       	push   $0x802388
  80138f:	6a 4c                	push   $0x4c
  801391:	68 55 23 80 00       	push   $0x802355
  801396:	e8 ab 06 00 00       	call   801a46 <_panic>

0080139b <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  80139b:	55                   	push   %ebp
  80139c:	89 e5                	mov    %esp,%ebp
  80139e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013a1:	83 ec 04             	sub    $0x4,%esp
  8013a4:	68 88 23 80 00       	push   $0x802388
  8013a9:	6a 52                	push   $0x52
  8013ab:	68 55 23 80 00       	push   $0x802355
  8013b0:	e8 91 06 00 00       	call   801a46 <_panic>

008013b5 <shrink>:
}
void shrink(uint32 newSize)
{
  8013b5:	55                   	push   %ebp
  8013b6:	89 e5                	mov    %esp,%ebp
  8013b8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013bb:	83 ec 04             	sub    $0x4,%esp
  8013be:	68 88 23 80 00       	push   $0x802388
  8013c3:	6a 56                	push   $0x56
  8013c5:	68 55 23 80 00       	push   $0x802355
  8013ca:	e8 77 06 00 00       	call   801a46 <_panic>

008013cf <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8013cf:	55                   	push   %ebp
  8013d0:	89 e5                	mov    %esp,%ebp
  8013d2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013d5:	83 ec 04             	sub    $0x4,%esp
  8013d8:	68 88 23 80 00       	push   $0x802388
  8013dd:	6a 5b                	push   $0x5b
  8013df:	68 55 23 80 00       	push   $0x802355
  8013e4:	e8 5d 06 00 00       	call   801a46 <_panic>

008013e9 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
  8013ec:	57                   	push   %edi
  8013ed:	56                   	push   %esi
  8013ee:	53                   	push   %ebx
  8013ef:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8013f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013fb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013fe:	8b 7d 18             	mov    0x18(%ebp),%edi
  801401:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801404:	cd 30                	int    $0x30
  801406:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801409:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80140c:	83 c4 10             	add    $0x10,%esp
  80140f:	5b                   	pop    %ebx
  801410:	5e                   	pop    %esi
  801411:	5f                   	pop    %edi
  801412:	5d                   	pop    %ebp
  801413:	c3                   	ret    

00801414 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
  801417:	83 ec 04             	sub    $0x4,%esp
  80141a:	8b 45 10             	mov    0x10(%ebp),%eax
  80141d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801420:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	52                   	push   %edx
  80142c:	ff 75 0c             	pushl  0xc(%ebp)
  80142f:	50                   	push   %eax
  801430:	6a 00                	push   $0x0
  801432:	e8 b2 ff ff ff       	call   8013e9 <syscall>
  801437:	83 c4 18             	add    $0x18,%esp
}
  80143a:	90                   	nop
  80143b:	c9                   	leave  
  80143c:	c3                   	ret    

0080143d <sys_cgetc>:

int
sys_cgetc(void)
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 01                	push   $0x1
  80144c:	e8 98 ff ff ff       	call   8013e9 <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	50                   	push   %eax
  801465:	6a 05                	push   $0x5
  801467:	e8 7d ff ff ff       	call   8013e9 <syscall>
  80146c:	83 c4 18             	add    $0x18,%esp
}
  80146f:	c9                   	leave  
  801470:	c3                   	ret    

00801471 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801471:	55                   	push   %ebp
  801472:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 02                	push   $0x2
  801480:	e8 64 ff ff ff       	call   8013e9 <syscall>
  801485:	83 c4 18             	add    $0x18,%esp
}
  801488:	c9                   	leave  
  801489:	c3                   	ret    

0080148a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80148a:	55                   	push   %ebp
  80148b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 03                	push   $0x3
  801499:	e8 4b ff ff ff       	call   8013e9 <syscall>
  80149e:	83 c4 18             	add    $0x18,%esp
}
  8014a1:	c9                   	leave  
  8014a2:	c3                   	ret    

008014a3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014a3:	55                   	push   %ebp
  8014a4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 04                	push   $0x4
  8014b2:	e8 32 ff ff ff       	call   8013e9 <syscall>
  8014b7:	83 c4 18             	add    $0x18,%esp
}
  8014ba:	c9                   	leave  
  8014bb:	c3                   	ret    

008014bc <sys_env_exit>:


void sys_env_exit(void)
{
  8014bc:	55                   	push   %ebp
  8014bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 06                	push   $0x6
  8014cb:	e8 19 ff ff ff       	call   8013e9 <syscall>
  8014d0:	83 c4 18             	add    $0x18,%esp
}
  8014d3:	90                   	nop
  8014d4:	c9                   	leave  
  8014d5:	c3                   	ret    

008014d6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8014d6:	55                   	push   %ebp
  8014d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8014d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	52                   	push   %edx
  8014e6:	50                   	push   %eax
  8014e7:	6a 07                	push   $0x7
  8014e9:	e8 fb fe ff ff       	call   8013e9 <syscall>
  8014ee:	83 c4 18             	add    $0x18,%esp
}
  8014f1:	c9                   	leave  
  8014f2:	c3                   	ret    

008014f3 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
  8014f6:	56                   	push   %esi
  8014f7:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8014f8:	8b 75 18             	mov    0x18(%ebp),%esi
  8014fb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014fe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801501:	8b 55 0c             	mov    0xc(%ebp),%edx
  801504:	8b 45 08             	mov    0x8(%ebp),%eax
  801507:	56                   	push   %esi
  801508:	53                   	push   %ebx
  801509:	51                   	push   %ecx
  80150a:	52                   	push   %edx
  80150b:	50                   	push   %eax
  80150c:	6a 08                	push   $0x8
  80150e:	e8 d6 fe ff ff       	call   8013e9 <syscall>
  801513:	83 c4 18             	add    $0x18,%esp
}
  801516:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801519:	5b                   	pop    %ebx
  80151a:	5e                   	pop    %esi
  80151b:	5d                   	pop    %ebp
  80151c:	c3                   	ret    

0080151d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80151d:	55                   	push   %ebp
  80151e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801520:	8b 55 0c             	mov    0xc(%ebp),%edx
  801523:	8b 45 08             	mov    0x8(%ebp),%eax
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	52                   	push   %edx
  80152d:	50                   	push   %eax
  80152e:	6a 09                	push   $0x9
  801530:	e8 b4 fe ff ff       	call   8013e9 <syscall>
  801535:	83 c4 18             	add    $0x18,%esp
}
  801538:	c9                   	leave  
  801539:	c3                   	ret    

0080153a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80153a:	55                   	push   %ebp
  80153b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	ff 75 0c             	pushl  0xc(%ebp)
  801546:	ff 75 08             	pushl  0x8(%ebp)
  801549:	6a 0a                	push   $0xa
  80154b:	e8 99 fe ff ff       	call   8013e9 <syscall>
  801550:	83 c4 18             	add    $0x18,%esp
}
  801553:	c9                   	leave  
  801554:	c3                   	ret    

00801555 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801555:	55                   	push   %ebp
  801556:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 0b                	push   $0xb
  801564:	e8 80 fe ff ff       	call   8013e9 <syscall>
  801569:	83 c4 18             	add    $0x18,%esp
}
  80156c:	c9                   	leave  
  80156d:	c3                   	ret    

0080156e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80156e:	55                   	push   %ebp
  80156f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801571:	6a 00                	push   $0x0
  801573:	6a 00                	push   $0x0
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 0c                	push   $0xc
  80157d:	e8 67 fe ff ff       	call   8013e9 <syscall>
  801582:	83 c4 18             	add    $0x18,%esp
}
  801585:	c9                   	leave  
  801586:	c3                   	ret    

00801587 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801587:	55                   	push   %ebp
  801588:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 0d                	push   $0xd
  801596:	e8 4e fe ff ff       	call   8013e9 <syscall>
  80159b:	83 c4 18             	add    $0x18,%esp
}
  80159e:	c9                   	leave  
  80159f:	c3                   	ret    

008015a0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015a0:	55                   	push   %ebp
  8015a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	ff 75 0c             	pushl  0xc(%ebp)
  8015ac:	ff 75 08             	pushl  0x8(%ebp)
  8015af:	6a 11                	push   $0x11
  8015b1:	e8 33 fe ff ff       	call   8013e9 <syscall>
  8015b6:	83 c4 18             	add    $0x18,%esp
	return;
  8015b9:	90                   	nop
}
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	ff 75 0c             	pushl  0xc(%ebp)
  8015c8:	ff 75 08             	pushl  0x8(%ebp)
  8015cb:	6a 12                	push   $0x12
  8015cd:	e8 17 fe ff ff       	call   8013e9 <syscall>
  8015d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8015d5:	90                   	nop
}
  8015d6:	c9                   	leave  
  8015d7:	c3                   	ret    

008015d8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8015d8:	55                   	push   %ebp
  8015d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 0e                	push   $0xe
  8015e7:	e8 fd fd ff ff       	call   8013e9 <syscall>
  8015ec:	83 c4 18             	add    $0x18,%esp
}
  8015ef:	c9                   	leave  
  8015f0:	c3                   	ret    

008015f1 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8015f1:	55                   	push   %ebp
  8015f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	ff 75 08             	pushl  0x8(%ebp)
  8015ff:	6a 0f                	push   $0xf
  801601:	e8 e3 fd ff ff       	call   8013e9 <syscall>
  801606:	83 c4 18             	add    $0x18,%esp
}
  801609:	c9                   	leave  
  80160a:	c3                   	ret    

0080160b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 10                	push   $0x10
  80161a:	e8 ca fd ff ff       	call   8013e9 <syscall>
  80161f:	83 c4 18             	add    $0x18,%esp
}
  801622:	90                   	nop
  801623:	c9                   	leave  
  801624:	c3                   	ret    

00801625 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801625:	55                   	push   %ebp
  801626:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 14                	push   $0x14
  801634:	e8 b0 fd ff ff       	call   8013e9 <syscall>
  801639:	83 c4 18             	add    $0x18,%esp
}
  80163c:	90                   	nop
  80163d:	c9                   	leave  
  80163e:	c3                   	ret    

0080163f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80163f:	55                   	push   %ebp
  801640:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 15                	push   $0x15
  80164e:	e8 96 fd ff ff       	call   8013e9 <syscall>
  801653:	83 c4 18             	add    $0x18,%esp
}
  801656:	90                   	nop
  801657:	c9                   	leave  
  801658:	c3                   	ret    

00801659 <sys_cputc>:


void
sys_cputc(const char c)
{
  801659:	55                   	push   %ebp
  80165a:	89 e5                	mov    %esp,%ebp
  80165c:	83 ec 04             	sub    $0x4,%esp
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801665:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	50                   	push   %eax
  801672:	6a 16                	push   $0x16
  801674:	e8 70 fd ff ff       	call   8013e9 <syscall>
  801679:	83 c4 18             	add    $0x18,%esp
}
  80167c:	90                   	nop
  80167d:	c9                   	leave  
  80167e:	c3                   	ret    

0080167f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	6a 17                	push   $0x17
  80168e:	e8 56 fd ff ff       	call   8013e9 <syscall>
  801693:	83 c4 18             	add    $0x18,%esp
}
  801696:	90                   	nop
  801697:	c9                   	leave  
  801698:	c3                   	ret    

00801699 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801699:	55                   	push   %ebp
  80169a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80169c:	8b 45 08             	mov    0x8(%ebp),%eax
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	ff 75 0c             	pushl  0xc(%ebp)
  8016a8:	50                   	push   %eax
  8016a9:	6a 18                	push   $0x18
  8016ab:	e8 39 fd ff ff       	call   8013e9 <syscall>
  8016b0:	83 c4 18             	add    $0x18,%esp
}
  8016b3:	c9                   	leave  
  8016b4:	c3                   	ret    

008016b5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8016b5:	55                   	push   %ebp
  8016b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	52                   	push   %edx
  8016c5:	50                   	push   %eax
  8016c6:	6a 1b                	push   $0x1b
  8016c8:	e8 1c fd ff ff       	call   8013e9 <syscall>
  8016cd:	83 c4 18             	add    $0x18,%esp
}
  8016d0:	c9                   	leave  
  8016d1:	c3                   	ret    

008016d2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8016d2:	55                   	push   %ebp
  8016d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	52                   	push   %edx
  8016e2:	50                   	push   %eax
  8016e3:	6a 19                	push   $0x19
  8016e5:	e8 ff fc ff ff       	call   8013e9 <syscall>
  8016ea:	83 c4 18             	add    $0x18,%esp
}
  8016ed:	90                   	nop
  8016ee:	c9                   	leave  
  8016ef:	c3                   	ret    

008016f0 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	52                   	push   %edx
  801700:	50                   	push   %eax
  801701:	6a 1a                	push   $0x1a
  801703:	e8 e1 fc ff ff       	call   8013e9 <syscall>
  801708:	83 c4 18             	add    $0x18,%esp
}
  80170b:	90                   	nop
  80170c:	c9                   	leave  
  80170d:	c3                   	ret    

0080170e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
  801711:	83 ec 04             	sub    $0x4,%esp
  801714:	8b 45 10             	mov    0x10(%ebp),%eax
  801717:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80171a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80171d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	6a 00                	push   $0x0
  801726:	51                   	push   %ecx
  801727:	52                   	push   %edx
  801728:	ff 75 0c             	pushl  0xc(%ebp)
  80172b:	50                   	push   %eax
  80172c:	6a 1c                	push   $0x1c
  80172e:	e8 b6 fc ff ff       	call   8013e9 <syscall>
  801733:	83 c4 18             	add    $0x18,%esp
}
  801736:	c9                   	leave  
  801737:	c3                   	ret    

00801738 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801738:	55                   	push   %ebp
  801739:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80173b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80173e:	8b 45 08             	mov    0x8(%ebp),%eax
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	52                   	push   %edx
  801748:	50                   	push   %eax
  801749:	6a 1d                	push   $0x1d
  80174b:	e8 99 fc ff ff       	call   8013e9 <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
}
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801758:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80175b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80175e:	8b 45 08             	mov    0x8(%ebp),%eax
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	51                   	push   %ecx
  801766:	52                   	push   %edx
  801767:	50                   	push   %eax
  801768:	6a 1e                	push   $0x1e
  80176a:	e8 7a fc ff ff       	call   8013e9 <syscall>
  80176f:	83 c4 18             	add    $0x18,%esp
}
  801772:	c9                   	leave  
  801773:	c3                   	ret    

00801774 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801774:	55                   	push   %ebp
  801775:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801777:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177a:	8b 45 08             	mov    0x8(%ebp),%eax
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	52                   	push   %edx
  801784:	50                   	push   %eax
  801785:	6a 1f                	push   $0x1f
  801787:	e8 5d fc ff ff       	call   8013e9 <syscall>
  80178c:	83 c4 18             	add    $0x18,%esp
}
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 20                	push   $0x20
  8017a0:	e8 44 fc ff ff       	call   8013e9 <syscall>
  8017a5:	83 c4 18             	add    $0x18,%esp
}
  8017a8:	c9                   	leave  
  8017a9:	c3                   	ret    

008017aa <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8017aa:	55                   	push   %ebp
  8017ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8017ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b0:	6a 00                	push   $0x0
  8017b2:	ff 75 14             	pushl  0x14(%ebp)
  8017b5:	ff 75 10             	pushl  0x10(%ebp)
  8017b8:	ff 75 0c             	pushl  0xc(%ebp)
  8017bb:	50                   	push   %eax
  8017bc:	6a 21                	push   $0x21
  8017be:	e8 26 fc ff ff       	call   8013e9 <syscall>
  8017c3:	83 c4 18             	add    $0x18,%esp
}
  8017c6:	c9                   	leave  
  8017c7:	c3                   	ret    

008017c8 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8017c8:	55                   	push   %ebp
  8017c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	50                   	push   %eax
  8017d7:	6a 22                	push   $0x22
  8017d9:	e8 0b fc ff ff       	call   8013e9 <syscall>
  8017de:	83 c4 18             	add    $0x18,%esp
}
  8017e1:	90                   	nop
  8017e2:	c9                   	leave  
  8017e3:	c3                   	ret    

008017e4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8017e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	50                   	push   %eax
  8017f3:	6a 23                	push   $0x23
  8017f5:	e8 ef fb ff ff       	call   8013e9 <syscall>
  8017fa:	83 c4 18             	add    $0x18,%esp
}
  8017fd:	90                   	nop
  8017fe:	c9                   	leave  
  8017ff:	c3                   	ret    

00801800 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801800:	55                   	push   %ebp
  801801:	89 e5                	mov    %esp,%ebp
  801803:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801806:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801809:	8d 50 04             	lea    0x4(%eax),%edx
  80180c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	52                   	push   %edx
  801816:	50                   	push   %eax
  801817:	6a 24                	push   $0x24
  801819:	e8 cb fb ff ff       	call   8013e9 <syscall>
  80181e:	83 c4 18             	add    $0x18,%esp
	return result;
  801821:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801824:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801827:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80182a:	89 01                	mov    %eax,(%ecx)
  80182c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80182f:	8b 45 08             	mov    0x8(%ebp),%eax
  801832:	c9                   	leave  
  801833:	c2 04 00             	ret    $0x4

00801836 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	ff 75 10             	pushl  0x10(%ebp)
  801840:	ff 75 0c             	pushl  0xc(%ebp)
  801843:	ff 75 08             	pushl  0x8(%ebp)
  801846:	6a 13                	push   $0x13
  801848:	e8 9c fb ff ff       	call   8013e9 <syscall>
  80184d:	83 c4 18             	add    $0x18,%esp
	return ;
  801850:	90                   	nop
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_rcr2>:
uint32 sys_rcr2()
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 25                	push   $0x25
  801862:	e8 82 fb ff ff       	call   8013e9 <syscall>
  801867:	83 c4 18             	add    $0x18,%esp
}
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
  80186f:	83 ec 04             	sub    $0x4,%esp
  801872:	8b 45 08             	mov    0x8(%ebp),%eax
  801875:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801878:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	50                   	push   %eax
  801885:	6a 26                	push   $0x26
  801887:	e8 5d fb ff ff       	call   8013e9 <syscall>
  80188c:	83 c4 18             	add    $0x18,%esp
	return ;
  80188f:	90                   	nop
}
  801890:	c9                   	leave  
  801891:	c3                   	ret    

00801892 <rsttst>:
void rsttst()
{
  801892:	55                   	push   %ebp
  801893:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 28                	push   $0x28
  8018a1:	e8 43 fb ff ff       	call   8013e9 <syscall>
  8018a6:	83 c4 18             	add    $0x18,%esp
	return ;
  8018a9:	90                   	nop
}
  8018aa:	c9                   	leave  
  8018ab:	c3                   	ret    

008018ac <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018ac:	55                   	push   %ebp
  8018ad:	89 e5                	mov    %esp,%ebp
  8018af:	83 ec 04             	sub    $0x4,%esp
  8018b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018b8:	8b 55 18             	mov    0x18(%ebp),%edx
  8018bb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018bf:	52                   	push   %edx
  8018c0:	50                   	push   %eax
  8018c1:	ff 75 10             	pushl  0x10(%ebp)
  8018c4:	ff 75 0c             	pushl  0xc(%ebp)
  8018c7:	ff 75 08             	pushl  0x8(%ebp)
  8018ca:	6a 27                	push   $0x27
  8018cc:	e8 18 fb ff ff       	call   8013e9 <syscall>
  8018d1:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d4:	90                   	nop
}
  8018d5:	c9                   	leave  
  8018d6:	c3                   	ret    

008018d7 <chktst>:
void chktst(uint32 n)
{
  8018d7:	55                   	push   %ebp
  8018d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	ff 75 08             	pushl  0x8(%ebp)
  8018e5:	6a 29                	push   $0x29
  8018e7:	e8 fd fa ff ff       	call   8013e9 <syscall>
  8018ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ef:	90                   	nop
}
  8018f0:	c9                   	leave  
  8018f1:	c3                   	ret    

008018f2 <inctst>:

void inctst()
{
  8018f2:	55                   	push   %ebp
  8018f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 2a                	push   $0x2a
  801901:	e8 e3 fa ff ff       	call   8013e9 <syscall>
  801906:	83 c4 18             	add    $0x18,%esp
	return ;
  801909:	90                   	nop
}
  80190a:	c9                   	leave  
  80190b:	c3                   	ret    

0080190c <gettst>:
uint32 gettst()
{
  80190c:	55                   	push   %ebp
  80190d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 2b                	push   $0x2b
  80191b:	e8 c9 fa ff ff       	call   8013e9 <syscall>
  801920:	83 c4 18             	add    $0x18,%esp
}
  801923:	c9                   	leave  
  801924:	c3                   	ret    

00801925 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801925:	55                   	push   %ebp
  801926:	89 e5                	mov    %esp,%ebp
  801928:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 2c                	push   $0x2c
  801937:	e8 ad fa ff ff       	call   8013e9 <syscall>
  80193c:	83 c4 18             	add    $0x18,%esp
  80193f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801942:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801946:	75 07                	jne    80194f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801948:	b8 01 00 00 00       	mov    $0x1,%eax
  80194d:	eb 05                	jmp    801954 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80194f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801954:	c9                   	leave  
  801955:	c3                   	ret    

00801956 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801956:	55                   	push   %ebp
  801957:	89 e5                	mov    %esp,%ebp
  801959:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 2c                	push   $0x2c
  801968:	e8 7c fa ff ff       	call   8013e9 <syscall>
  80196d:	83 c4 18             	add    $0x18,%esp
  801970:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801973:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801977:	75 07                	jne    801980 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801979:	b8 01 00 00 00       	mov    $0x1,%eax
  80197e:	eb 05                	jmp    801985 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801980:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801985:	c9                   	leave  
  801986:	c3                   	ret    

00801987 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801987:	55                   	push   %ebp
  801988:	89 e5                	mov    %esp,%ebp
  80198a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 2c                	push   $0x2c
  801999:	e8 4b fa ff ff       	call   8013e9 <syscall>
  80199e:	83 c4 18             	add    $0x18,%esp
  8019a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019a4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019a8:	75 07                	jne    8019b1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8019af:	eb 05                	jmp    8019b6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8019b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019b6:	c9                   	leave  
  8019b7:	c3                   	ret    

008019b8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8019b8:	55                   	push   %ebp
  8019b9:	89 e5                	mov    %esp,%ebp
  8019bb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 2c                	push   $0x2c
  8019ca:	e8 1a fa ff ff       	call   8013e9 <syscall>
  8019cf:	83 c4 18             	add    $0x18,%esp
  8019d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8019d5:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8019d9:	75 07                	jne    8019e2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8019db:	b8 01 00 00 00       	mov    $0x1,%eax
  8019e0:	eb 05                	jmp    8019e7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8019e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019e7:	c9                   	leave  
  8019e8:	c3                   	ret    

008019e9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8019e9:	55                   	push   %ebp
  8019ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	ff 75 08             	pushl  0x8(%ebp)
  8019f7:	6a 2d                	push   $0x2d
  8019f9:	e8 eb f9 ff ff       	call   8013e9 <syscall>
  8019fe:	83 c4 18             	add    $0x18,%esp
	return ;
  801a01:	90                   	nop
}
  801a02:	c9                   	leave  
  801a03:	c3                   	ret    

00801a04 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a04:	55                   	push   %ebp
  801a05:	89 e5                	mov    %esp,%ebp
  801a07:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a08:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a0b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a11:	8b 45 08             	mov    0x8(%ebp),%eax
  801a14:	6a 00                	push   $0x0
  801a16:	53                   	push   %ebx
  801a17:	51                   	push   %ecx
  801a18:	52                   	push   %edx
  801a19:	50                   	push   %eax
  801a1a:	6a 2e                	push   $0x2e
  801a1c:	e8 c8 f9 ff ff       	call   8013e9 <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
}
  801a24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801a27:	c9                   	leave  
  801a28:	c3                   	ret    

00801a29 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801a29:	55                   	push   %ebp
  801a2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801a2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 00                	push   $0x0
  801a38:	52                   	push   %edx
  801a39:	50                   	push   %eax
  801a3a:	6a 2f                	push   $0x2f
  801a3c:	e8 a8 f9 ff ff       	call   8013e9 <syscall>
  801a41:	83 c4 18             	add    $0x18,%esp
}
  801a44:	c9                   	leave  
  801a45:	c3                   	ret    

00801a46 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801a46:	55                   	push   %ebp
  801a47:	89 e5                	mov    %esp,%ebp
  801a49:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801a4c:	8d 45 10             	lea    0x10(%ebp),%eax
  801a4f:	83 c0 04             	add    $0x4,%eax
  801a52:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801a55:	a1 18 31 80 00       	mov    0x803118,%eax
  801a5a:	85 c0                	test   %eax,%eax
  801a5c:	74 16                	je     801a74 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801a5e:	a1 18 31 80 00       	mov    0x803118,%eax
  801a63:	83 ec 08             	sub    $0x8,%esp
  801a66:	50                   	push   %eax
  801a67:	68 ac 23 80 00       	push   $0x8023ac
  801a6c:	e8 fe ea ff ff       	call   80056f <cprintf>
  801a71:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801a74:	a1 00 30 80 00       	mov    0x803000,%eax
  801a79:	ff 75 0c             	pushl  0xc(%ebp)
  801a7c:	ff 75 08             	pushl  0x8(%ebp)
  801a7f:	50                   	push   %eax
  801a80:	68 b1 23 80 00       	push   $0x8023b1
  801a85:	e8 e5 ea ff ff       	call   80056f <cprintf>
  801a8a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801a8d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a90:	83 ec 08             	sub    $0x8,%esp
  801a93:	ff 75 f4             	pushl  -0xc(%ebp)
  801a96:	50                   	push   %eax
  801a97:	e8 68 ea ff ff       	call   800504 <vcprintf>
  801a9c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801a9f:	83 ec 08             	sub    $0x8,%esp
  801aa2:	6a 00                	push   $0x0
  801aa4:	68 cd 23 80 00       	push   $0x8023cd
  801aa9:	e8 56 ea ff ff       	call   800504 <vcprintf>
  801aae:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801ab1:	e8 d7 e9 ff ff       	call   80048d <exit>

	// should not return here
	while (1) ;
  801ab6:	eb fe                	jmp    801ab6 <_panic+0x70>

00801ab8 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801ab8:	55                   	push   %ebp
  801ab9:	89 e5                	mov    %esp,%ebp
  801abb:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801abe:	a1 20 30 80 00       	mov    0x803020,%eax
  801ac3:	8b 50 74             	mov    0x74(%eax),%edx
  801ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ac9:	39 c2                	cmp    %eax,%edx
  801acb:	74 14                	je     801ae1 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801acd:	83 ec 04             	sub    $0x4,%esp
  801ad0:	68 d0 23 80 00       	push   $0x8023d0
  801ad5:	6a 26                	push   $0x26
  801ad7:	68 1c 24 80 00       	push   $0x80241c
  801adc:	e8 65 ff ff ff       	call   801a46 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801ae1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801ae8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801aef:	e9 b6 00 00 00       	jmp    801baa <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801af4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801af7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801afe:	8b 45 08             	mov    0x8(%ebp),%eax
  801b01:	01 d0                	add    %edx,%eax
  801b03:	8b 00                	mov    (%eax),%eax
  801b05:	85 c0                	test   %eax,%eax
  801b07:	75 08                	jne    801b11 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801b09:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801b0c:	e9 96 00 00 00       	jmp    801ba7 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801b11:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b18:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801b1f:	eb 5d                	jmp    801b7e <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801b21:	a1 20 30 80 00       	mov    0x803020,%eax
  801b26:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801b2c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b2f:	c1 e2 04             	shl    $0x4,%edx
  801b32:	01 d0                	add    %edx,%eax
  801b34:	8a 40 04             	mov    0x4(%eax),%al
  801b37:	84 c0                	test   %al,%al
  801b39:	75 40                	jne    801b7b <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b3b:	a1 20 30 80 00       	mov    0x803020,%eax
  801b40:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801b46:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b49:	c1 e2 04             	shl    $0x4,%edx
  801b4c:	01 d0                	add    %edx,%eax
  801b4e:	8b 00                	mov    (%eax),%eax
  801b50:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801b53:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b56:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801b5b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801b5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b60:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801b67:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6a:	01 c8                	add    %ecx,%eax
  801b6c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b6e:	39 c2                	cmp    %eax,%edx
  801b70:	75 09                	jne    801b7b <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801b72:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801b79:	eb 12                	jmp    801b8d <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b7b:	ff 45 e8             	incl   -0x18(%ebp)
  801b7e:	a1 20 30 80 00       	mov    0x803020,%eax
  801b83:	8b 50 74             	mov    0x74(%eax),%edx
  801b86:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b89:	39 c2                	cmp    %eax,%edx
  801b8b:	77 94                	ja     801b21 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801b8d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801b91:	75 14                	jne    801ba7 <CheckWSWithoutLastIndex+0xef>
			panic(
  801b93:	83 ec 04             	sub    $0x4,%esp
  801b96:	68 28 24 80 00       	push   $0x802428
  801b9b:	6a 3a                	push   $0x3a
  801b9d:	68 1c 24 80 00       	push   $0x80241c
  801ba2:	e8 9f fe ff ff       	call   801a46 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801ba7:	ff 45 f0             	incl   -0x10(%ebp)
  801baa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bad:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801bb0:	0f 8c 3e ff ff ff    	jl     801af4 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801bb6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bbd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801bc4:	eb 20                	jmp    801be6 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801bc6:	a1 20 30 80 00       	mov    0x803020,%eax
  801bcb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801bd1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801bd4:	c1 e2 04             	shl    $0x4,%edx
  801bd7:	01 d0                	add    %edx,%eax
  801bd9:	8a 40 04             	mov    0x4(%eax),%al
  801bdc:	3c 01                	cmp    $0x1,%al
  801bde:	75 03                	jne    801be3 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801be0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801be3:	ff 45 e0             	incl   -0x20(%ebp)
  801be6:	a1 20 30 80 00       	mov    0x803020,%eax
  801beb:	8b 50 74             	mov    0x74(%eax),%edx
  801bee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bf1:	39 c2                	cmp    %eax,%edx
  801bf3:	77 d1                	ja     801bc6 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801bf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bf8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801bfb:	74 14                	je     801c11 <CheckWSWithoutLastIndex+0x159>
		panic(
  801bfd:	83 ec 04             	sub    $0x4,%esp
  801c00:	68 7c 24 80 00       	push   $0x80247c
  801c05:	6a 44                	push   $0x44
  801c07:	68 1c 24 80 00       	push   $0x80241c
  801c0c:	e8 35 fe ff ff       	call   801a46 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801c11:	90                   	nop
  801c12:	c9                   	leave  
  801c13:	c3                   	ret    

00801c14 <__udivdi3>:
  801c14:	55                   	push   %ebp
  801c15:	57                   	push   %edi
  801c16:	56                   	push   %esi
  801c17:	53                   	push   %ebx
  801c18:	83 ec 1c             	sub    $0x1c,%esp
  801c1b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c1f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c23:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c27:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c2b:	89 ca                	mov    %ecx,%edx
  801c2d:	89 f8                	mov    %edi,%eax
  801c2f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c33:	85 f6                	test   %esi,%esi
  801c35:	75 2d                	jne    801c64 <__udivdi3+0x50>
  801c37:	39 cf                	cmp    %ecx,%edi
  801c39:	77 65                	ja     801ca0 <__udivdi3+0x8c>
  801c3b:	89 fd                	mov    %edi,%ebp
  801c3d:	85 ff                	test   %edi,%edi
  801c3f:	75 0b                	jne    801c4c <__udivdi3+0x38>
  801c41:	b8 01 00 00 00       	mov    $0x1,%eax
  801c46:	31 d2                	xor    %edx,%edx
  801c48:	f7 f7                	div    %edi
  801c4a:	89 c5                	mov    %eax,%ebp
  801c4c:	31 d2                	xor    %edx,%edx
  801c4e:	89 c8                	mov    %ecx,%eax
  801c50:	f7 f5                	div    %ebp
  801c52:	89 c1                	mov    %eax,%ecx
  801c54:	89 d8                	mov    %ebx,%eax
  801c56:	f7 f5                	div    %ebp
  801c58:	89 cf                	mov    %ecx,%edi
  801c5a:	89 fa                	mov    %edi,%edx
  801c5c:	83 c4 1c             	add    $0x1c,%esp
  801c5f:	5b                   	pop    %ebx
  801c60:	5e                   	pop    %esi
  801c61:	5f                   	pop    %edi
  801c62:	5d                   	pop    %ebp
  801c63:	c3                   	ret    
  801c64:	39 ce                	cmp    %ecx,%esi
  801c66:	77 28                	ja     801c90 <__udivdi3+0x7c>
  801c68:	0f bd fe             	bsr    %esi,%edi
  801c6b:	83 f7 1f             	xor    $0x1f,%edi
  801c6e:	75 40                	jne    801cb0 <__udivdi3+0x9c>
  801c70:	39 ce                	cmp    %ecx,%esi
  801c72:	72 0a                	jb     801c7e <__udivdi3+0x6a>
  801c74:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c78:	0f 87 9e 00 00 00    	ja     801d1c <__udivdi3+0x108>
  801c7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c83:	89 fa                	mov    %edi,%edx
  801c85:	83 c4 1c             	add    $0x1c,%esp
  801c88:	5b                   	pop    %ebx
  801c89:	5e                   	pop    %esi
  801c8a:	5f                   	pop    %edi
  801c8b:	5d                   	pop    %ebp
  801c8c:	c3                   	ret    
  801c8d:	8d 76 00             	lea    0x0(%esi),%esi
  801c90:	31 ff                	xor    %edi,%edi
  801c92:	31 c0                	xor    %eax,%eax
  801c94:	89 fa                	mov    %edi,%edx
  801c96:	83 c4 1c             	add    $0x1c,%esp
  801c99:	5b                   	pop    %ebx
  801c9a:	5e                   	pop    %esi
  801c9b:	5f                   	pop    %edi
  801c9c:	5d                   	pop    %ebp
  801c9d:	c3                   	ret    
  801c9e:	66 90                	xchg   %ax,%ax
  801ca0:	89 d8                	mov    %ebx,%eax
  801ca2:	f7 f7                	div    %edi
  801ca4:	31 ff                	xor    %edi,%edi
  801ca6:	89 fa                	mov    %edi,%edx
  801ca8:	83 c4 1c             	add    $0x1c,%esp
  801cab:	5b                   	pop    %ebx
  801cac:	5e                   	pop    %esi
  801cad:	5f                   	pop    %edi
  801cae:	5d                   	pop    %ebp
  801caf:	c3                   	ret    
  801cb0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cb5:	89 eb                	mov    %ebp,%ebx
  801cb7:	29 fb                	sub    %edi,%ebx
  801cb9:	89 f9                	mov    %edi,%ecx
  801cbb:	d3 e6                	shl    %cl,%esi
  801cbd:	89 c5                	mov    %eax,%ebp
  801cbf:	88 d9                	mov    %bl,%cl
  801cc1:	d3 ed                	shr    %cl,%ebp
  801cc3:	89 e9                	mov    %ebp,%ecx
  801cc5:	09 f1                	or     %esi,%ecx
  801cc7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ccb:	89 f9                	mov    %edi,%ecx
  801ccd:	d3 e0                	shl    %cl,%eax
  801ccf:	89 c5                	mov    %eax,%ebp
  801cd1:	89 d6                	mov    %edx,%esi
  801cd3:	88 d9                	mov    %bl,%cl
  801cd5:	d3 ee                	shr    %cl,%esi
  801cd7:	89 f9                	mov    %edi,%ecx
  801cd9:	d3 e2                	shl    %cl,%edx
  801cdb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cdf:	88 d9                	mov    %bl,%cl
  801ce1:	d3 e8                	shr    %cl,%eax
  801ce3:	09 c2                	or     %eax,%edx
  801ce5:	89 d0                	mov    %edx,%eax
  801ce7:	89 f2                	mov    %esi,%edx
  801ce9:	f7 74 24 0c          	divl   0xc(%esp)
  801ced:	89 d6                	mov    %edx,%esi
  801cef:	89 c3                	mov    %eax,%ebx
  801cf1:	f7 e5                	mul    %ebp
  801cf3:	39 d6                	cmp    %edx,%esi
  801cf5:	72 19                	jb     801d10 <__udivdi3+0xfc>
  801cf7:	74 0b                	je     801d04 <__udivdi3+0xf0>
  801cf9:	89 d8                	mov    %ebx,%eax
  801cfb:	31 ff                	xor    %edi,%edi
  801cfd:	e9 58 ff ff ff       	jmp    801c5a <__udivdi3+0x46>
  801d02:	66 90                	xchg   %ax,%ax
  801d04:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d08:	89 f9                	mov    %edi,%ecx
  801d0a:	d3 e2                	shl    %cl,%edx
  801d0c:	39 c2                	cmp    %eax,%edx
  801d0e:	73 e9                	jae    801cf9 <__udivdi3+0xe5>
  801d10:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d13:	31 ff                	xor    %edi,%edi
  801d15:	e9 40 ff ff ff       	jmp    801c5a <__udivdi3+0x46>
  801d1a:	66 90                	xchg   %ax,%ax
  801d1c:	31 c0                	xor    %eax,%eax
  801d1e:	e9 37 ff ff ff       	jmp    801c5a <__udivdi3+0x46>
  801d23:	90                   	nop

00801d24 <__umoddi3>:
  801d24:	55                   	push   %ebp
  801d25:	57                   	push   %edi
  801d26:	56                   	push   %esi
  801d27:	53                   	push   %ebx
  801d28:	83 ec 1c             	sub    $0x1c,%esp
  801d2b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d2f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d37:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d3b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d3f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d43:	89 f3                	mov    %esi,%ebx
  801d45:	89 fa                	mov    %edi,%edx
  801d47:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d4b:	89 34 24             	mov    %esi,(%esp)
  801d4e:	85 c0                	test   %eax,%eax
  801d50:	75 1a                	jne    801d6c <__umoddi3+0x48>
  801d52:	39 f7                	cmp    %esi,%edi
  801d54:	0f 86 a2 00 00 00    	jbe    801dfc <__umoddi3+0xd8>
  801d5a:	89 c8                	mov    %ecx,%eax
  801d5c:	89 f2                	mov    %esi,%edx
  801d5e:	f7 f7                	div    %edi
  801d60:	89 d0                	mov    %edx,%eax
  801d62:	31 d2                	xor    %edx,%edx
  801d64:	83 c4 1c             	add    $0x1c,%esp
  801d67:	5b                   	pop    %ebx
  801d68:	5e                   	pop    %esi
  801d69:	5f                   	pop    %edi
  801d6a:	5d                   	pop    %ebp
  801d6b:	c3                   	ret    
  801d6c:	39 f0                	cmp    %esi,%eax
  801d6e:	0f 87 ac 00 00 00    	ja     801e20 <__umoddi3+0xfc>
  801d74:	0f bd e8             	bsr    %eax,%ebp
  801d77:	83 f5 1f             	xor    $0x1f,%ebp
  801d7a:	0f 84 ac 00 00 00    	je     801e2c <__umoddi3+0x108>
  801d80:	bf 20 00 00 00       	mov    $0x20,%edi
  801d85:	29 ef                	sub    %ebp,%edi
  801d87:	89 fe                	mov    %edi,%esi
  801d89:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d8d:	89 e9                	mov    %ebp,%ecx
  801d8f:	d3 e0                	shl    %cl,%eax
  801d91:	89 d7                	mov    %edx,%edi
  801d93:	89 f1                	mov    %esi,%ecx
  801d95:	d3 ef                	shr    %cl,%edi
  801d97:	09 c7                	or     %eax,%edi
  801d99:	89 e9                	mov    %ebp,%ecx
  801d9b:	d3 e2                	shl    %cl,%edx
  801d9d:	89 14 24             	mov    %edx,(%esp)
  801da0:	89 d8                	mov    %ebx,%eax
  801da2:	d3 e0                	shl    %cl,%eax
  801da4:	89 c2                	mov    %eax,%edx
  801da6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801daa:	d3 e0                	shl    %cl,%eax
  801dac:	89 44 24 04          	mov    %eax,0x4(%esp)
  801db0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801db4:	89 f1                	mov    %esi,%ecx
  801db6:	d3 e8                	shr    %cl,%eax
  801db8:	09 d0                	or     %edx,%eax
  801dba:	d3 eb                	shr    %cl,%ebx
  801dbc:	89 da                	mov    %ebx,%edx
  801dbe:	f7 f7                	div    %edi
  801dc0:	89 d3                	mov    %edx,%ebx
  801dc2:	f7 24 24             	mull   (%esp)
  801dc5:	89 c6                	mov    %eax,%esi
  801dc7:	89 d1                	mov    %edx,%ecx
  801dc9:	39 d3                	cmp    %edx,%ebx
  801dcb:	0f 82 87 00 00 00    	jb     801e58 <__umoddi3+0x134>
  801dd1:	0f 84 91 00 00 00    	je     801e68 <__umoddi3+0x144>
  801dd7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ddb:	29 f2                	sub    %esi,%edx
  801ddd:	19 cb                	sbb    %ecx,%ebx
  801ddf:	89 d8                	mov    %ebx,%eax
  801de1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801de5:	d3 e0                	shl    %cl,%eax
  801de7:	89 e9                	mov    %ebp,%ecx
  801de9:	d3 ea                	shr    %cl,%edx
  801deb:	09 d0                	or     %edx,%eax
  801ded:	89 e9                	mov    %ebp,%ecx
  801def:	d3 eb                	shr    %cl,%ebx
  801df1:	89 da                	mov    %ebx,%edx
  801df3:	83 c4 1c             	add    $0x1c,%esp
  801df6:	5b                   	pop    %ebx
  801df7:	5e                   	pop    %esi
  801df8:	5f                   	pop    %edi
  801df9:	5d                   	pop    %ebp
  801dfa:	c3                   	ret    
  801dfb:	90                   	nop
  801dfc:	89 fd                	mov    %edi,%ebp
  801dfe:	85 ff                	test   %edi,%edi
  801e00:	75 0b                	jne    801e0d <__umoddi3+0xe9>
  801e02:	b8 01 00 00 00       	mov    $0x1,%eax
  801e07:	31 d2                	xor    %edx,%edx
  801e09:	f7 f7                	div    %edi
  801e0b:	89 c5                	mov    %eax,%ebp
  801e0d:	89 f0                	mov    %esi,%eax
  801e0f:	31 d2                	xor    %edx,%edx
  801e11:	f7 f5                	div    %ebp
  801e13:	89 c8                	mov    %ecx,%eax
  801e15:	f7 f5                	div    %ebp
  801e17:	89 d0                	mov    %edx,%eax
  801e19:	e9 44 ff ff ff       	jmp    801d62 <__umoddi3+0x3e>
  801e1e:	66 90                	xchg   %ax,%ax
  801e20:	89 c8                	mov    %ecx,%eax
  801e22:	89 f2                	mov    %esi,%edx
  801e24:	83 c4 1c             	add    $0x1c,%esp
  801e27:	5b                   	pop    %ebx
  801e28:	5e                   	pop    %esi
  801e29:	5f                   	pop    %edi
  801e2a:	5d                   	pop    %ebp
  801e2b:	c3                   	ret    
  801e2c:	3b 04 24             	cmp    (%esp),%eax
  801e2f:	72 06                	jb     801e37 <__umoddi3+0x113>
  801e31:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e35:	77 0f                	ja     801e46 <__umoddi3+0x122>
  801e37:	89 f2                	mov    %esi,%edx
  801e39:	29 f9                	sub    %edi,%ecx
  801e3b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e3f:	89 14 24             	mov    %edx,(%esp)
  801e42:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e46:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e4a:	8b 14 24             	mov    (%esp),%edx
  801e4d:	83 c4 1c             	add    $0x1c,%esp
  801e50:	5b                   	pop    %ebx
  801e51:	5e                   	pop    %esi
  801e52:	5f                   	pop    %edi
  801e53:	5d                   	pop    %ebp
  801e54:	c3                   	ret    
  801e55:	8d 76 00             	lea    0x0(%esi),%esi
  801e58:	2b 04 24             	sub    (%esp),%eax
  801e5b:	19 fa                	sbb    %edi,%edx
  801e5d:	89 d1                	mov    %edx,%ecx
  801e5f:	89 c6                	mov    %eax,%esi
  801e61:	e9 71 ff ff ff       	jmp    801dd7 <__umoddi3+0xb3>
  801e66:	66 90                	xchg   %ax,%ax
  801e68:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e6c:	72 ea                	jb     801e58 <__umoddi3+0x134>
  801e6e:	89 d9                	mov    %ebx,%ecx
  801e70:	e9 62 ff ff ff       	jmp    801dd7 <__umoddi3+0xb3>

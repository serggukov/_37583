﻿

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
    
    ЗаполнитьТаблицуПараметров();
    
    Если Не Параметры.Ключ.Пустая()  Тогда
        
        НастройкиТекстАлгоритма = ХранилищеОбщихНастроек.ПолучитьСписок(Строка(Параметры.Ключ)+"-n1");
        
        Для Каждого ЭлементСписка  Из НастройкиТекстАлгоритма Цикл 
            
            НастройкаТекстАлгоритма = ХранилищеОбщихНастроек.Загрузить(Строка(Параметры.Ключ)+"-n1",ЭлементСписка.Значение);
            Элементы.ТекстАлгоритма[ЭлементСписка.Значение] = НастройкаТекстАлгоритма;
        КонецЦикла;
        
        НастройкаШаблонов = ХранилищеОбщихНастроек.Загрузить(Строка(Параметры.Ключ) + "-n2","Шаблонизатор");
        
        Если Не НастройкаШаблонов = Неопределено Тогда
            
            Шаблонизатор = НастройкаШаблонов;
            ШаблонизаторПриИзмененииНаСервере();
        КонецЕсли;
    КонецЕсли;	
    
    ЗаполнитьСпискиВыбораПолейФормы();
    
    УстановитьВидимостьИДоступность();

    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
    
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
    Если Модифицированность Тогда 
        ТекущийОбъект.КодАлгоритма = _37583_ОбщегоНазначенияКлиентСервер.ПреобразоватьТекстВКодАлгоритма(Объект.Текст);
    КонецЕсли;
    Элементы.ТекстАлгоритма.ЦветРамки=Новый Цвет;
    Элементы.Записать.ЦветФона=Новый Цвет;
    Если Не Параметры.Ключ.Пустая() Тогда 
        Если Параметры.ИзменитьНастройкиОтображенияШрифт Тогда
            ХранилищеОбщихНастроек.Сохранить(Строка(Параметры.Ключ)+"-n1","Шрифт",Шрифт);
        КонецЕсли;
        Если Параметры.ИзменитьНастройкиОтображенияЦветТекста Тогда
            ХранилищеОбщихНастроек.Сохранить(Строка(Параметры.Ключ)+"-n1","ЦветТекста",ЦветТекста);
        КонецЕсли;
        Если Параметры.ИзменитьНастройкиОтображенияЦветФона Тогда
            ХранилищеОбщихНастроек.Сохранить(Строка(Параметры.Ключ)+"-n1","ЦветФона",ЦветФона);
        КонецЕсли;
        Если Не Шаблонизатор.Пустая() = Неопределено Тогда
            ХранилищеОбщихНастроек.Сохранить(Строка(Параметры.Ключ)+"-n2","Шаблонизатор",Шаблонизатор);
        КонецЕсли;
    КонецЕсли;
    
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
    УстановитьВидимостьИДоступность();
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
    Если ИмяСобытия="ИзменилсяПараметр" Тогда
        Прочитать(); 
        ЗаполнитьТаблицуПараметров();
    ИначеЕсли ИмяСобытия="Обновить" Тогда 
        Прочитать(); 
    ИначеЕсли ИмяСобытия="ОбновитьКод" Тогда 
        Прочитать();
        Записать();
    КонецЕсли;	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ШаблонизаторПриИзменении(Элемент)
    ШаблонизаторПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ГруппаПанельСтраницПриСменеСтраницы(Элемент, ТекущаяСтраница)
    Если Модифицированность И  ТекущаяСтраница.Имя <> "ГруппаКод" Тогда
        Записать();
    КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ШрифтПриИзменении(Элемент)
    Элементы.ТекстАлгоритма.Шрифт = Шрифт;
    Параметры.ИзменитьНастройкиОтображенияШрифт = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ЦветФонаПриИзменении(Элемент)
    Элементы.ТекстАлгоритма.ЦветФона = ЦветФона;
    Параметры.ИзменитьНастройкиОтображенияЦветФона = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ЦветТекстаПриИзменении(Элемент)
    Элементы.ТекстАлгоритма.ЦветТекста = ЦветТекста;
    Параметры.ИзменитьНастройкиОтображенияЦветТекста = Истина;
КонецПроцедуры

&НаКлиенте
Процедура РегламентноеЗаданиеПриИзменении(Элемент)
    Если Параметры.Ключ.Пустая() Или Объект.ПометкаУдаления Тогда
        Объект.РегламентноеЗадание = Ложь;
        Возврат;
    КонецЕсли;
    Если Объект.РегламентноеЗадание И ПустаяСтрока(Объект.ИдентификаторРегламентногоЗадания) Тогда 
        Объект.ИдентификаторРегламентногоЗадания = "GUID_"+Строка(Объект.Ссылка.УникальныйИдентификатор());
    КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТекстАлгоритмаИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
    Модифицированность = Истина;
КонецПроцедуры

&НаКлиенте
Процедура тШаблоныОкончаниеПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
   Объект.Текст = Объект.Текст +  СтрЗаменить(Элемент.ТекущиеДанные.Значение,Символ(182),Символы.ПС);
КонецПроцедуры


#КонецОбласти


#Область ОбработчикиСобытийЭлементовТаблицыФормы_Параметры

&НаКлиенте
Процедура ТаблицаПараметровПередУдалением(Элемент, Отказ)
    ПоказатьВопрос(Новый ОписаниеОповещения("ТаблицаПараметровПередУдалениемЗавершение",ЭтотОбъект,Новый Структура("Строка,Параметр",Элемент.ТекущаяСтрока,Элемент.ТекущиеДанные.Параметр)),"Элемент структуры настроек будет удален без возможности  восстановления !"+Символы.ПС+"Продолжить выполнение ? ",РежимДиалогаВопрос.ДаНетОтмена);
    Отказ=Истина;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПараметровПередУдалениемЗавершение(Результат,ДополнительныеПараметры)Экспорт 
    Если Результат=КодВозвратаДиалога.Да Тогда
        Если УдалитьПараметрНаСервере(ДополнительныеПараметры.Параметр) Тогда
            Прочитать();
            ЗаполнитьТаблицуПараметров();
        КонецЕсли; 
    КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПараметровПараметрОткрытие(Элемент, СтандартнаяОбработка)
    СтандартнаяОбработка=Ложь;
    Если Элемент.Родитель.ТекущиеДанные.ОписаниеТипа="Таблица значений"
        ИЛИ Элемент.Родитель.ТекущиеДанные.ОписаниеТипа="Двоичные данные"
        Тогда  Возврат; КонецЕсли;
    Попытка
        Значение=ПолучитьПараметрНаСервере(Элементы.ТаблицаПараметров.ТекущиеДанные.Параметр);
        ПоказатьЗначение(,Значение);
    Исключение
        Сообщить(ОписаниеОшибки());
    КонецПопытки;
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовТаблицыФормы_КомандныйИнтерфейс

&НаКлиенте
Процедура КомандныйИнтерфейсУсловияВидимостиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
    ОписаниеКоманды = СокрЛП(СтрЗаменить(Элементы.КомандныйИнтерфейс.ТекущиеДанные.Представление,Символ(32),""));
    Если Не ПустаяСтрока(ОписаниеКоманды) Тогда
        ОписаниеОповещения = Новый ОписаниеОповещения("СоздатьТаблицуУсловийВидимостиКомандыЗавершение",ЭтотОбъект,Новый Структура("НаименованиеТаблицы","УсловияВидимостиКоманды_"+ОписаниеКоманды));
        ПоказатьВопрос(ОписаниеОповещения ,"Создать таблицу условий видимости ? ",РежимДиалогаВопрос.ДаНетОтмена);
    КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СоздатьТаблицуУсловийВидимостиКомандыЗавершение(Результат,ДополнительныеПараметры)Экспорт 
    Если Результат=КодВозвратаДиалога.Да Тогда
        Элементы.КомандныйИнтерфейс.ТекущиеДанные.УсловияВидимости = ДополнительныеПараметры.НаименованиеТаблицы; 
        СоздатьТаблицуУсловийНаСервере(ДополнительныеПараметры.НаименованиеТаблицы);
        Прочитать();
        ЗаполнитьТаблицуПараметров();
    КонецЕсли;
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы
///
&НаКлиенте
Процедура ДобавитьПараметр(Команда)
    П=Новый Структура("Ключ",Объект.Ссылка);
    ОткрытьФорму("Справочник._37583_ALG.Форма.ФормаПараметра",П,ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьИмя(Команда)
    Если Элементы.ТаблицаПараметров.ТекущиеДанные=Неопределено Тогда Возврат КонецЕсли;
    П=Новый Структура("Ключ,ИмяПараметра,Переименовать",Параметры.Ключ,Элементы.ТаблицаПараметров.ТекущиеДанные.Параметр,Истина);
    ОткрытьФорму("Справочник._37583_ALG.Форма.ФормаПараметра",П,ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьЗначение(Команда)
    Если Элементы.ТаблицаПараметров.ТекущиеДанные<>Неопределено Тогда
        П=Новый Структура;
        П.Вставить("Ключ", Параметры.Ключ);
        П.Вставить("ИмяПараметра", Элементы.ТаблицаПараметров.ТекущиеДанные.Параметр);
        П.Вставить("ТипПараметра", Элементы.ТаблицаПараметров.ТекущиеДанные.ОписаниеТипа);
        ОткрытьФорму("Справочник._37583_ALG.Форма.ФормаПараметра",П,ЭтотОбъект);
    КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СоздатьТаблицуШаблонов(Команда)
    СоздатьТаблицуШаблоновНаСервере();
    Прочитать();
    ЗаполнитьТаблицуПараметров();
КонецПроцедуры

///
&НаКлиенте
Процедура ВыполнитьПроцедуру(Команда)
    ВремяСтарт= ТекущаяУниверсальнаяДатаВМиллисекундах();
    Ошибка = Ложь; СообщениеОбОшибке = "";
    Если Объект.НаКлиенте Тогда
        _37583_АлгоритмыКлиент.ВыполнитьПроцедуру(Объект.Ссылка,,Ошибка,СообщениеОбОшибке);
    Иначе 
        ВыполнитьПроцедуруНаСервере(Ошибка,СообщениеОбОшибке);
    КонецЕсли;	
    Если Ошибка Тогда
        _37583_АлгоритмыКлиент.PopUp(СообщениеОбОшибке);
        Элементы.ОткрытьЖурналРегистрации.Заголовок="ПОСМОТРЕТЬ ОШИБКИ";
        ВыделитьОшибку(СообщениеОбОшибке);
    Иначе 
        Элементы.ОткрытьЖурналРегистрации.Заголовок=" ";
    КонецЕсли;
    Элементы.ВыполнитьПроцедуру.Заголовок="Выполнить процедуру ("+Строка(ТекущаяУниверсальнаяДатаВМиллисекундах() - ВремяСтарт)+" мс.)";
    Элементы.ГруппаКодАлгоритма.Видимость=Ложь;
    Элементы.ТекстАлгоритма.Видимость=Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПереключательТекстКод(Команда)
    Элементы.ГруппаКодАлгоритма.Видимость=Не Элементы.ГруппаКодАлгоритма.Видимость;
    Элементы.ГруппаТекстАлгоритма.Видимость=Не Элементы.ГруппаКодАлгоритма.Видимость;
КонецПроцедуры

&НаКлиенте
Процедура СохранитьТекст(Команда)
    СохранитьТекстНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ВосстановитьТекст(Команда)
    ВосстановитьТекстНаСервере();
КонецПроцедуры

///
&НаКлиенте
Процедура КонструкторЗапросаПоказать(Команда)
    Конструктор = Новый КонструкторЗапроса;
    ВыделенныйТекст = Элементы.ТекстАлгоритма.ВыделенныйТекст;
    ВесьТекст = Элементы.ТекстАлгоритма.ТекстРедактирования;
    НайтиВесьТекстВКовычках (ВыделенныйТекст,ВесьТекст);
    Конструктор.Текст = СтрЗаменить(ВыделенныйТекст ,"|",""); 
    ДополнительныеПараметры = Новый Структура("ПервыйВызовКонструктора,ВесьТекст,ВыделенныйТекст",СтрНайти(ВыделенныйТекст,"ВЫБРАТЬ")=0,ВесьТекст,ВыделенныйТекст);
    Оповещение = Новый ОписаниеОповещения("ПолучитьТекстЗапроса",ЭтотОбъект,ДополнительныеПараметры);
    Конструктор.Показать(Оповещение);
КонецПроцедуры

&НаКлиенте
Процедура ФорматироватьТекст(Команда)
    Текст = Объект.Текст;
    Текст = СтрЗаменить(Текст,Символы.ПС," \\ ");
    Текст = СтрЗаменить(Текст,Символы.Таб," ");
    Текст = СтрЗаменить(Текст,"="," = ");
    Текст = СтрЗаменить(Текст,"< ="," <=");
    Текст = СтрЗаменить(Текст,"> ="," >=");
    Для А=0 по Окр(Sqrt(СтрЧислоВхождений(Текст,"  ")),0) Цикл
        Текст = СтрЗаменить(Текст,"  "," ");
    КонецЦикла;
    Текст = СтрЗаменить(Текст," ;",";");
    МассивСлов = _37583_ОбщегоНазначенияКлиентСервер.СтрокаВМассив(Текст,Символ(32));
    ФормТекст = "";
    СтрокаТаб = "";
    ТипыСлов = Новый Массив;
    ТипыСлов.Добавить(_37583_ОбщегоНазначенияКлиентСервер.СтрокаВМассив("ТОГДА,ЦИКЛ,\\",","));  // перенос справа
    ТипыСлов.Добавить(_37583_ОбщегоНазначенияКлиентСервер.СтрокаВМассив("ЕСЛИ,ПОКА,ДЛЯ",",")); // опер скобки открываются
    ТипыСлов.Добавить(_37583_ОбщегоНазначенияКлиентСервер.СтрокаВМассив("КОНЕЦЦИКЛА;,КОНЕЦЕСЛИ;",",")); // опер скобки закрываются
    ТипыСлов.Добавить(_37583_ОбщегоНазначенияКлиентСервер.СтрокаВМассив("ИНАЧЕ,ИНАЧЕЕСЛИ",",")); // опер скобки внутри
    
    БылТип = Новый Соответствие;
    Для Ё=0 По МассивСлов.Количество()-1 Цикл
        ФорматДо = ""  ; ФорматПосле = "";
        
        ТипСлова=ТипСлова(МассивСлов[Ё],ТипыСлов); 
        
        Если ТипСлова["СкобкаОткрылась"] Тогда 
            СтрокаТаб = СтрокаТаб + Символы.Таб;
        КонецЕсли;
        
        Если ТипСлова["СкобкаВнутри"] Тогда 
            ФормТекст = Лев(ФормТекст,СтрДлина(ФормТекст)-1); 
        КонецЕсли;
        
        Если ТипСлова["СкобкаЗакрылась"] Тогда 
            СтрокаТаб = Лев(СтрокаТаб,СтрДлина(СтрокаТаб)-1);
            ФормТекст = Лев(ФормТекст,СтрДлина(ФормТекст)-1); 
        КонецЕсли;
        
        Если ТипСлова["ПереносСправа"] И Не БылТип["ПереносСправа"]   Тогда 
            ФорматПосле =  Символы.ПС + СтрокаТаб ;
        КонецЕсли;
        
        //Если ТипСлова["ПереносСлева"] И Не БылТип["ПереносСправа"]  Тогда 
        //	ФорматДо =  Символы.ПС + СтрокаТаб ;
        //КонецЕсли;
        
        ФормТекст = ФормТекст+ФорматДо+МассивСлов[Ё]+Символ(32)+ФорматПосле;
        
        БылТип = ТипСлова;
    КонецЦикла;
    
    ФормТекст = СтрЗаменить(ФормТекст,"\\ ","");
    ФормТекст = СтрЗаменить(ФормТекст,"\\","");
    Объект.Текст = ФормТекст;
    
КонецПроцедуры


///
&НаКлиенте
Процедура ЗагрузитьXML(Команда)
    СтандартнаяОбработка=ложь;
    Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
    Диалог.Заголовок = "Выберите файл";
    Диалог.ПолноеИмяФайла = ""; 
    Фильтр = "XML файлы  (*.xml)|*.xml"; 
    Диалог.Фильтр = Фильтр; 
    Диалог.МножественныйВыбор = Ложь;
    Диалог.Показать(Новый ОписаниеОповещения("ВнешнийФайлНачалоВыбораЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьXML(Команда)
    Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
    Диалог.Заголовок = "Выберите каталог";
    Диалог.МножественныйВыбор = Ложь;
    Диалог.Показать(Новый ОписаниеОповещения("ВыборКаталогаЗавершение",ЭтотОбъект,Новый Структура("ВыгрузитьXML",Истина)));
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьДвоичныеДанные(Команда)
    Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
    Диалог.Заголовок = "Выберите каталог";
    Диалог.МножественныйВыбор = Ложь;
    Диалог.Показать(Новый ОписаниеОповещения("ВыборКаталогаЗавершение",ЭтотОбъект));
КонецПроцедуры

///
&НаКлиенте
Процедура ДобавитьРегламентноеЗадание(Команда)
    Если Объект.НаКлиенте Тогда
        Сообщить(" это клиентская процедура");
        Возврат;
    КонецЕсли;	
    СоздатьРегламентноеЗадание();
КонецПроцедуры

&НаКлиенте
Процедура УдалитьРегламентноеЗадание(Команда)
    УдалитьРегламентноеЗаданиеНаСервере();
КонецПроцедуры


&НаКлиенте
Процедура ОткрытьЖурналРегистрации(Команда)
    ПодключитьВнешнююОбработкуНаСервере();
    ПараметрыОткрытия = Новый Структура;
    ПараметрыОткрытия.Вставить("Данные",Объект.Ссылка);
    ПараметрыОткрытия.Вставить("ДатаНачала", НачалоДня(ТекущаяДата()));
    ОткрытьФорму("ВнешняяОбработка.StandardEventLog.Форма",ПараметрыОткрытия);
КонецПроцедуры



 &НаКлиенте
Процедура Шаблоны(Команда)
    Префикс = "==";	
    Пока Найти(Объект.Текст,Префикс)>0 Цикл
        Слово =  _37583_ОбщегоНазначенияКлиентСервер.ПолучитьПервоеВхождениеСловоБезПрефикса(Объект.Текст,Префикс,Префикс);
        Объект.Текст = СтрЗаменить(Объект.Текст,Префикс+Слово,СтрЗаменить(НайтиПоШаблону(Слово),Символ(182),Символы.ПС));
    КонецЦикла;
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции


#Область РаботаСПараметрами

&НаСервере
Процедура ЗаполнитьТаблицуПараметров()
    ВыбОбъект=РеквизитФормыВЗначение("Объект");
    тПараметров=РеквизитФормыВЗначение("ТаблицаПараметров");
    тПараметров.Очистить();
    СтруктураПараметров=ВыбОбъект.Хранилище.Получить();
    Если Не СтруктураПараметров=Неопределено Тогда
        Для Каждого ЭлементСтруктуры Из СтруктураПараметров Цикл 
            НС=тПараметров.Добавить();
            НС.Параметр=ЭлементСтруктуры.Ключ;
            НС.ОписаниеТипа=ПолучитьСтрокуОписаниеТипа(ЭлементСтруктуры.Значение);
        КонецЦикла;
        ЗначениеВРеквизитФормы(тПараметров,"ТаблицаПараметров");
    КонецЕсли;
КонецПроцедуры

&НаСервере
Функция ПолучитьСтрокуОписаниеТипа(Значение)
    Если XMLТипЗнч(Значение) <> Неопределено Тогда 
        Возврат XMLТип(ТипЗнч(Значение)).ИмяТипа;
    Иначе 
        Возврат Строка(ТипЗнч(Значение));
    КонецЕсли;
КонецФункции 


&НаСервере
Процедура ДобавитьНовыйПараметрНаСервере(СтруктураПараметра)
    ВыбОбъект=РеквизитФормыВЗначение("Объект");
    ВыбОбъект.ИзменитьПараметр(СтруктураПараметра);
КонецПроцедуры

&НаСервере
Функция УдалитьПараметрНаСервере(Ключ)
    ВыбОбъект=РеквизитФормыВЗначение("Объект");
    Возврат ВыбОбъект.УдалитьПараметр(Ключ);
КонецФункции

&НаСервере
Функция ПолучитьПараметрНаСервере(НаименованиеПараметра)
    ВыбОбъект=РеквизитФормыВЗначение("Объект");
    Возврат ВыбОбъект.ПолучитьПараметр(НаименованиеПараметра);
КонецФункции 

#КонецОбласти



#Область РАБОТАСКОДОМ 

&НаКлиенте
Процедура ВыделитьОшибку(ТекстОшибки)
    ПозОшибки =  СтрНайти(ТекстОшибки,"{(");
    Если ПозОшибки > 0  Тогда
        ПозСкобкаЗакрылась =  СтрНайти(ТекстОшибки,")}",,ПозОшибки);
        Если  ПозСкобкаЗакрылась > 0 Тогда
            ПозЗапятая =  СтрНайти(Лев(ТекстОшибки,ПозСкобкаЗакрылась),",",,ПозОшибки);
            Если ПозЗапятая > 0  Тогда 
                ТекстНомерСтроки = Сред(ТекстОшибки,ПозОшибки + 2,СтрДлина(Лев(ТекстОшибки,ПозЗапятая))- СтрДлина(Лев(ТекстОшибки,ПозОшибки))- 2 );
            Иначе 
                ТекстНомерСтроки = Сред(ТекстОшибки,ПозОшибки + 2,СтрДлина(Лев(ТекстОшибки,ПозСкобкаЗакрылась))- СтрДлина(Лев(ТекстОшибки,ПозОшибки))- 2 );
            КонецЕсли;
            // вложенная   ошибка   напр.  запрос
            ПозОшибки2 =  СтрНайти(ТекстОшибки,"{(",,,2);
            Если ПозОшибки2 > 0  Тогда
                ПозСкобкаЗакрылась2 =  СтрНайти(ТекстОшибки,")}",,ПозОшибки2);
                Если  ПозСкобкаЗакрылась2 > 0 Тогда
                    ПозЗапятая2 =  СтрНайти(Лев(ТекстОшибки,ПозСкобкаЗакрылась2),",",,ПозОшибки2);
                    Если ПозЗапятая2 > 0  Тогда 
                        ТекстНомерСтроки2 = Сред(ТекстОшибки,ПозОшибки2 + 2,СтрДлина(Лев(ТекстОшибки,ПозЗапятая2))- СтрДлина(Лев(ТекстОшибки,ПозОшибки2))- 2 );
                    Иначе 
                        ТекстНомерСтроки2 = Сред(ТекстОшибки,ПозОшибки2 + 2,СтрДлина(Лев(ТекстОшибки,ПозСкобкаЗакрылась2))- СтрДлина(Лев(ТекстОшибки,ПозОшибки2))- 2 );
                    КонецЕсли;
                КонецЕсли;
            КонецЕсли;
            Попытка
                НомерСтроки = Число(ТекстНомерСтроки);
                мСтрок = СтрРазделить(Объект.Текст, Символы.ПС, Истина);
                мСтрок[НомерСтроки - 1 ] =  мСтрок[НомерСтроки - 1 ] + " <<<<<" ;
                Если ПозОшибки2 > 0 Тогда
                    НомерСтроки2 = Число(ТекстНомерСтроки2);
                    Ъ = НомерСтроки - 1; 
                    Пока  Ъ >= 0  Цикл
                        Если СтрНайти(мСтрок[Ъ],"ВЫБРАТЬ") >  0 
                            ИЛИ СтрНайти(мСтрок[Ъ],"Выбрать") >  0  
                            ИЛИ СтрНайти(мСтрок[Ъ],"выбрать") >  0 Тогда
                            мСтрок[Ъ + НомерСтроки2 - 1] = мСтрок[Ъ + НомерСтроки2 - 1 ] + " <<<<<" ;
                        КонецЕсли;
                        Ъ = Ъ - 1;
                    КонецЦикла;
                КонецЕсли;	
                Объект.Текст = СтрСоединить(мСтрок,Символы.ПС);
            Исключение
                Возврат;
            КонецПопытки;
        КонецЕсли;
    КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВыделитьИзменившийсяКод()
    //Элементы.ТекстАлгоритма.ЦветРамки=Новый Цвет(255,99,71);
    //Элементы.Записать.ЦветФона=Новый Цвет(255,99,71);
    Модифицированность = Истина;
КонецПроцедуры

&НаКлиенте
Процедура НайтиВесьТекстВКовычках (ВыделенныйТекст,ВесьТекст)
    Если СтрДлина(ВыделенныйТекст) > 10 Тогда   // нужен уникальный текст , по хорошему нужно проверить количество включений
        ИщемЗдесь = СтрНайти(ВесьТекст,ВыделенныйТекст);
        НашлиКавычкуДо = 0;
        Для А = 1 По СтрЧислоВхождений(ВесьТекст,"""") Цикл
            НашлиКавычкуПосле = СтрНайти(ВесьТекст, """", , , А);
            Если  НашлиКавычкуПосле > ИщемЗдесь  Тогда
                ВыделенныйТекст = Сред(ВесьТекст,НашлиКавычкуДо+1,СтрДлина(Лев(Весьтекст,НашлиКавычкуПосле)) - СтрДлина(Лев(Весьтекст,НашлиКавычкуДо))-1);
                Прервать;
            КонецЕсли;
            НашлиКавычкуДо = НашлиКавычкуПосле;
        КонецЦикла;
    КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьТекстЗапроса(Текст, ДополнительныеПараметры)  Экспорт
    Если Текст = Неопределено Тогда
        Возврат;
    КонецЕсли;
    МассивСтрок = СтрРазделить(Текст,Символы.ПС);
    ТекстЗапроса = МассивСтрок[0];
    Для Ё=1 По МассивСтрок.Количество()-1  Цикл
        ТекстЗапроса = ТекстЗапроса+ Символы.ПС+"|"+СокрЛП(МассивСтрок[Ё]);
    КонецЦикла;
    ТекстВставки = "";
    Если ДополнительныеПараметры.ПервыйВызовКонструктора Тогда
        ТекстВставки = "
        |Запрос = Новый Запрос;
        |ТекстЗапроса = """+ ТекстЗапроса +""";
        |Запрос.Текст = ТекстЗапроса;";
        Пока Найти(ТекстЗапроса,"&") > 0 Цикл
            ПарметрЗапроса =_37583_ОбщегоНазначенияКлиентСервер.ПолучитьПервоеВхождениеСловоБезПрефикса(ТекстЗапроса,"&");
            ТекстВставки = ТекстВставки + "
            |Запрос.УстановитьПараметр("""+ПарметрЗапроса+""",@"+ПарметрЗапроса+" );";
            ТекстЗапроса=СтрЗаменить(ТекстЗапроса,"&"+ПарметрЗапроса,"~"+ПарметрЗапроса);
        КонецЦикла;
        Текст = Текст + "
        |Результат = Запрос.Выполнить();
        |Если Не Результат.Пустой() Тогда
        |	Выборка = Результат.Выбрать();
        |	Пока Выборка.Следующий() Цикл
        |	 	// Сообщить("");
        |	КонецЦикла;
        |КонецЕсли;";
    Иначе 
        ТекстВставки = ТекстЗапроса;
    КонецЕсли;
    Если ПустаяСтрока(ДополнительныеПараметры.ВыделенныйТекст) Тогда
        Объект.Текст  = Объект.Текст + ТекстВставки;
        Элементы.ТекстАлгоритма.ОбновитьТекстРедактирования(); 	
    Иначе 
        Объект.Текст = СтрЗаменить(ДополнительныеПараметры.ВесьТекст,ДополнительныеПараметры.ВыделенныйТекст,ТекстВставки);
        Элементы.ТекстАлгоритма.ОбновитьТекстРедактирования(); 	
    КонецЕсли;
    ВыделитьИзменившийсяКод();
    
КонецПроцедуры

&НаКлиенте
Функция ТипСлова(Слово,ТипыСлов)
    ТипСлова = Новый Соответствие;
    
    ТипСлова["ПереносСправа"]			= ?(ТипыСлов[0].Найти(ВРег(СокрЛП(Слово))) = Неопределено,Ложь,Истина);
    ТипСлова["СкобкаОткрылась"]			= ?(ТипыСлов[1].Найти(ВРег(СокрЛП(Слово))) = Неопределено,Ложь,Истина);
    ТипСлова["СкобкаЗакрылась"]			= ?(ТипыСлов[2].Найти(ВРег(СокрЛП(Слово))) = Неопределено,Ложь,Истина);
    ТипСлова["СкобкаВнутри"]			= ?(ТипыСлов[3].Найти(ВРег(СокрЛП(Слово))) = Неопределено,Ложь,Истина);
    Возврат ТипСлова;
    
КонецФункции

&НаСервере
Процедура ВыполнитьПроцедуруНаСервере(ОшибкаВыполнения = Ложь,СообщениеОбОшибке ="")
    ВыбОбъект=РеквизитФормыВЗначение("Объект");
    ДополнительныеПараметры = Новый Структура;
    ВыбОбъект.ВыполнитьПроцедуру(ДополнительныеПараметры);
    ОшибкаВыполнения = ДополнительныеПараметры.Отказ;
    СообщениеОбОшибке = ДополнительныеПараметры.СообщениеОбОшибке;
КонецПроцедуры

&НаСервере
Процедура СохранитьТекстНаСервере()
    ВыбОбъект=РеквизитФормыВЗначение("Объект");
    ВыбОбъект.ИзменитьПараметр(Новый Структура("НаименованиеПараметра,ЗначениеПараметра","ТекстАлгоритма"+_37583_ОбщегоНазначенияКлиентСервер.ШтампВремени(),Объект.Текст));
    Прочитать();
    ЗаполнитьТаблицуПараметров();
КонецПроцедуры

&НаСервере
Процедура ВосстановитьТекстНаСервере()
    ВыбОбъект=РеквизитФормыВЗначение("Объект");
    Объект.Текст=ВыбОбъект.ПолучитьПараметр("ТекстАлгоритма");
КонецПроцедуры

#КонецОбласти  //------------------------------------- РАБОТАСКОДОМ



&НаСервереБезКонтекста
Функция ОбъектыМетаданных()
    
    ОбъектыМетаданных=Новый Соответствие;
    ОбъектыМетаданных.Вставить("Справочник.","Справочники");
    ОбъектыМетаданных.Вставить("Документ.","Документы");
    //ОбъектыМетаданных.Вставить("Отчет.","Отчеты");
    //ОбъектыМетаданных.Вставить("Обработка.","Обработки");
    
    Возврат ОбъектыМетаданных;
КонецФункции

&НаСервере
Процедура ЗаполнитьСпискиВыбораПолейФормы()
    
    //СписокВыбора ОбъектМетаданных КомандныйИнтерфейс
    ОбъектыМетаданных =   ОбъектыМетаданных();
    Для Каждого ЭлементСоответствия Из ОбъектыМетаданных Цикл
        Для Каждого Элемент Из Метаданные[ЭлементСоответствия.Значение] Цикл
            Элементы.КомандныйИнтерфейсОбъектМетаданных.СписокВыбора.Добавить(ЭлементСоответствия.Ключ+Элемент.Имя);
        КонецЦикла; 
    КонецЦикла;
    
    // СпискиВыбора  ПрограммныйИнтерфейс
    Запрос = Новый Запрос;
    Запрос.Текст = 
    "ВЫБРАТЬ РАЗЛИЧНЫЕ
    |   _37583_ALGПрограммныйИнтерфейс.ТипПараметра КАК ТипПараметра
    |ИЗ
    |   Справочник._37583_ALG.ПрограммныйИнтерфейс КАК _37583_ALGПрограммныйИнтерфейс";
    
    Выборка = Запрос.Выполнить().Выбрать();
    
    Пока Выборка.Следующий() Цикл 
        
        Если Не ПустаяСтрока(Выборка.ТипПараметра) Тогда 
            
            Элементы.ПрограммныйИнтерфейсТипПараметра.СписокВыбора.Добавить(СокрЛП(Выборка.ТипПараметра));
        КонецЕсли;
        
    КонецЦикла;
    
    // СпискиВыбора  КомандныйИнтерфейс
    Запрос = Новый Запрос;
    Запрос.Текст = 
    "ВЫБРАТЬ РАЗЛИЧНЫЕ
    |   _37583_ALGКомандныйИнтерфейс.ГруппаКоманд КАК ГруппаКоманд
    |ИЗ
    |   Справочник._37583_ALG.КомандныйИнтерфейс КАК _37583_ALGКомандныйИнтерфейс";
    
    Выборка = Запрос.Выполнить().Выбрать();
    
    Пока Выборка.Следующий() Цикл 
        
        Если Не ПустаяСтрока(Выборка.ГруппаКоманд) Тогда 
            
            Элементы.КомандныйИнтерфейсГруппаКоманд.СписокВыбора.Добавить(СокрЛП(Выборка.ГруппаКоманд));
        КонецЕсли;
    КонецЦикла;
    
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьИДоступность()
    Элементы.ГруппаПанельСтраниц.Доступность= Не Параметры.Ключ.Пустая();
    Элементы.Теги.СписокВыбора.Очистить();
    Запрос = Новый Запрос;
    Запрос.Текст = 
    "ВЫБРАТЬ РАЗЛИЧНЫЕ
    |	_37583_ALG.Теги Теги
    |ИЗ
    |	Справочник._37583_ALG КАК _37583_ALG
    |ГДЕ
    |	_37583_ALG.Теги <> """"";
    Выборка = Запрос.Выполнить().Выбрать();
    Пока Выборка.Следующий() Цикл 
        М = СтрРазделить(Выборка.Теги,",",Ложь);
        Для Каждого ЭлМ Из М Цикл
            Если  Элементы.Теги.СписокВыбора.НайтиПоЗначению(СокрЛП(ЭлМ))= Неопределено Тогда
                Элементы.Теги.СписокВыбора.Добавить(СокрЛП(ЭлМ));
            КонецЕсли;
        КонецЦикла;		
    КонецЦикла; 	
    Элементы.ОткрытьЖурналРегистрации.Заголовок = " ";
    Проверить37583();
КонецПроцедуры

&НаСервере
Процедура Проверить37583()
    Если Не Параметры.Ключ.Пустая() Тогда 
        Если Объект.Наименование = "37583"  Тогда
            Элементы.ГрПредупреждение.Видимость = Истина;
        Иначе 
            Элементы.ГрПредупреждение.Видимость = Ложь;		
        КонецЕсли;
    КонецЕсли;
КонецПроцедуры // Проверить37558()


#Область Шаблоны

&НаСервере
Процедура ШаблонизаторПриИзмененииНаСервере()
    Если Шаблонизатор.Пустая() Тогда 
        Возврат;
    КонецЕсли;
    Т = _37583_АлгоритмыСервер.ПолучитьПараметр(Шаблонизатор,"Шаблоны");
    Отказ = Т.Отказ;
    Если НЕ Отказ Тогда 
        Если НЕ Т.Шаблоны = Неопределено И 	ТипЗнч(Т.Шаблоны)=Тип("ТаблицаЗначений") Тогда
            ЗначениеВДанныеФормы(Т.Шаблоны,тШаблоны);
            Если Т.Шаблоны.Колонки.Найти("Справка") = Неопределено Тогда
                Т.Шаблоны.Колонки.Добавить("Справка");
            КонецЕсли;	
            сПаттерн.ЗагрузитьЗначения(Т.Шаблоны.ВыгрузитьКолонку("Ключ"));
            сШаблоны.ЗагрузитьЗначения(Т.Шаблоны.ВыгрузитьКолонку("Значение"));
            сСправка.ЗагрузитьЗначения(Т.Шаблоны.ВыгрузитьКолонку("Справка"));
        КонецЕсли;
    КонецЕсли;
КонецПроцедуры


&НаКлиенте
Функция НайтиПоШаблону(Паттерн)
    НайденныйЭлемент = сПаттерн.НайтиПоЗначению(Паттерн); 
    Если Не НайденныйЭлемент = Неопределено  Тогда
        Возврат сШаблоны[сПаттерн.Индекс(НайденныйЭлемент)].Значение;
    Иначе 
        Возврат Паттерн;
    КонецЕсли;	
КонецФункции

&НаСервере
Процедура СоздатьТаблицуШаблоновНаСервере()
    ТаблицаШаблонов=Новый ТаблицаЗначений;
    ОписаниеТипа=Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(30, ДопустимаяДлина.Переменная));
    ТаблицаШаблонов.Колонки.Добавить("Ключ",ОписаниеТипа);
    ОписаниеТипа=Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(1024, ДопустимаяДлина.Переменная));
    ТаблицаШаблонов.Колонки.Добавить("Значение",ОписаниеТипа);
    ТаблицаШаблонов.Колонки.Добавить("Справка",ОписаниеТипа);
    ДобавитьНовыйПараметрНаСервере(Новый Структура("НаименованиеПараметра,ЗначениеПараметра","Шаблоны",ТаблицаШаблонов));
КонецПроцедуры

&НаСервере
Процедура СоздатьТаблицуУсловийНаСервере(НаименованиеТаблицы)
    ТаблицаУсловий=Новый ТаблицаЗначений;
    ОписаниеТипаСтрока = Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(30, ДопустимаяДлина.Переменная));
    ТаблицаУсловий.Колонки.Добавить("Реквизит",ОписаниеТипаСтрока);
    ТаблицаУсловий.Колонки.Добавить("ВидСравнения",Новый ОписаниеТипов("ВидСравненияКомпоновкиДанных"));
    ТаблицаУсловий.Колонки.Добавить("Значение");
    ДобавитьНовыйПараметрНаСервере(Новый Структура("НаименованиеПараметра,ЗначениеПараметра",НаименованиеТаблицы,ТаблицаУсловий));
КонецПроцедуры


#КонецОбласти


#Область ИмпортЭкспорт
//Импорт

&НаКлиенте
Процедура ВнешнийФайлНачалоВыбораЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
    Если (ТипЗнч(ВыбранныеФайлы) = Тип("Массив") И  ВыбранныеФайлы.Количество() > 0 ) Тогда
        ВнешнийФайл = ВыбранныеФайлы[0];
        Каталог = Лев(ВнешнийФайл,СтрНайти(ВнешнийФайл,?(_37583_ОбщегоНазначенияКлиентСервер.ЭтоLinux(),"/","\"),НаправлениеПоиска.СКонца));
        ОписаниеОповещения = Новый ОписаниеОповещения("ЗакончитьПомещениеФайла", ЭтотОбъект, Новый Структура("Каталог",Каталог));		
        НачатьПомещениеФайла(ОписаниеОповещения, , ВнешнийФайл, Ложь, ЭтотОбъект.УникальныйИдентификатор);
    Иначе
        _37583_АлгоритмыКлиент.PopUp(" нет файла ");
    КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗакончитьПомещениеФайла(Результат, АдресХранилища, ВыбранноеИмяФайла, ДополнительныеПараметры) Экспорт
    Если Результат Тогда
        ПрочитатьНаСервере(АдресХранилища, ВыбранноеИмяФайла, ДополнительныеПараметры);
    Иначе
        _37583_АлгоритмыКлиент.PopUp("Ошибка помещения файла в хранилище");
    КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПрочитатьНаСервере(АдресХранилища, ВыбранноеИмяФайла, ДополнительныеПараметры)
    НаименованиеПараметра = СтрЗаменить(СтрЗаменить(СтрЗаменить(СтрЗаменить(Врег(ВыбранноеИмяФайла),Врег(ДополнительныеПараметры.Каталог),""),".",""),"XML",""),Символ(32),"");
    Попытка
        ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресХранилища);	
        Поток = ДвоичныеДанные.ОткрытьПотокДляЧтения();	
        ЧтениеXML = новый ЧтениеXML;
        ЧтениеXML.ОткрытьПоток(Поток);
        ЗначениеПараметра = СериализаторXDTO.ПрочитатьXML(ЧтениеXML);
        ДобавитьНовыйПараметрНаСервере(Новый Структура("НаименованиеПараметра,ЗначениеПараметра",НаименованиеПараметра,ЗначениеПараметра));
    Исключение
        ВызватьИсключение "Ошибка записи файла XLM : " + ОписаниеОшибки();
    КонецПопытки;
КонецПроцедуры // ПрочитатьНаСервере()

//Экспорт


&НаКлиенте
Процедура ВыборКаталогаЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
    Если (ТипЗнч(ВыбранныеФайлы) = Тип("Массив") И  ВыбранныеФайлы.Количество() > 0 ) Тогда
        Каталог  = ВыбранныеФайлы[0];
        Параметр = Элементы.ТаблицаПараметров.ТекущиеДанные.Параметр;
        РасширениеФайла = ""; ИмяФайла = СокрЛП(Параметр); 
        Если ТипЗнч(ДополнительныеПараметры) = Тип("Структура")
            И ДополнительныеПараметры.Свойство("ВыгрузитьXML") Тогда
            РасширениеФайла = ".xml";
            АдресХранилища = ПолучитьФайлНаСервере(Параметр,Истина);
        Иначе
            Если СтрНайти(Параметр,"Файл") > 0 Тогда 
                Поз = СтрНайти(ИмяФайла,"_");
                РасширениеФайла = "."+НРег(Сред(ИмяФайла,5,Поз - 5));
                ИмяФайла = Сред(ИмяФайла,Поз + 1);
            КонецЕсли;
            АдресХранилища = ПолучитьФайлНаСервере(Параметр,Ложь);
        КонецЕсли;
        Оповещение = Новый ОписаниеОповещения("ПослеПолученияФайла", ЭтотОбъект);		
        ОписаниеФайла = Новый ОписаниеПередаваемогоФайла();
        ОписаниеФайла.Хранение = АдресХранилища;
        ОписаниеФайла.Имя = Каталог+?(_37583_ОбщегоНазначенияКлиентСервер.ЭтоLinux(),"/","\") + ИмяФайла + РасширениеФайла ;
        ПолучаемыеФайлы = Новый Массив;
        ПолучаемыеФайлы.Добавить(ОписаниеФайла);		
        НачатьПолучениеФайлов(Оповещение, ПолучаемыеФайлы,, Ложь);
    КонецЕсли;
КонецПроцедуры

&НаСервере
Функция ПолучитьФайлНаСервере(Параметр,ВыгрузитьXML)
    ВыбПараметр = ПолучитьПараметрНаСервере(Параметр);
    Если ВыгрузитьXML Тогда
        ЗаписьXML = Новый ЗаписьXML;
        Поток = Новый ПотокВПамяти;
        ЗаписьXML.ОткрытьПоток(Поток);
        СериализаторXDTO.ЗаписатьXML(ЗаписьXML,ВыбПараметр);
        ЗаписьXML.Закрыть();
        ДвоичныеДанные = Поток.ЗакрытьИПолучитьДвоичныеДанные();
        АдресХранилища = ПоместитьВоВременноеХранилище(ДвоичныеДанные, ЭтотОбъект.УникальныйИдентификатор);
    Иначе
        АдресХранилища = ПоместитьВоВременноеХранилище(ВыбПараметр, ЭтотОбъект.УникальныйИдентификатор);
    КонецЕсли;	
    Возврат АдресХранилища;
КонецФункции

&НаКлиенте
Процедура ПослеполученияФайла(ПолученныеФайлы, ДопПараметры) Экспорт
    Если ТипЗнч(ПолученныеФайлы) = Тип("Массив")	Тогда
        _37583_АлгоритмыКлиент.PopUp("Файл " + ПолученныеФайлы[0].Имя + " записан","ok .. "); 
    КонецЕсли; 
КонецПроцедуры


&НаКлиенте
Процедура ПроверкаПараметровПрограммныйИнтерфейс(Команда)
    Объект.ПрограммныйИнтерфейс.Очистить();
    КодАлгоритма = Объект.КодАлгоритма;
    мИсключая = _37583_ОбщегоНазначенияКлиентСервер.МассивИсключаемыхСимволов();
    Префикс = "Параметры.";
    Заполнение = Новый Структура;
    Пока Найти(КодАлгоритма,Префикс)>0 Цикл
        Слово = _37583_ОбщегоНазначенияКлиентСервер.ПолучитьПервоеВхождениеСловоБезПрефикса(КодАлгоритма,Префикс,мИсключая);
        КодАлгоритма = СтрЗаменить(КодАлгоритма,Префикс+Слово,Слово);
        Попытка
            Заполнение.Вставить(Слово,Истина);
        Исключение
        КонецПопытки;
    КонецЦикла;
    Текст = Объект.Текст;
    Префикс = "$";
    Пока Найти(КодАлгоритма,Префикс)>0 Цикл
        Слово = _37583_ОбщегоНазначенияКлиентСервер.ПолучитьПервоеВхождениеСловоБезПрефикса(Текст,Префикс,мИсключая);
        Текст = СтрЗаменить(Текст,Префикс+Слово,Слово);
        Попытка
            Заполнение.Вставить(Слово,Ложь);
        Исключение
        КонецПопытки;
    КонецЦикла;
    
    АдресХранилища = _37583_АлгоритмыСервер.ПолучитьПараметры(Объект.Ссылка,Истина);
    
    ХранимыеПараметры = ПолучитьИзВременногоХранилища(АдресХранилища);

    Для каждого ЭлементСоответствия Из Заполнение Цикл
        НоваяСтрока = Объект.ПрограммныйИнтерфейс.Добавить();
        НоваяСтрока.Вход = ЭлементСоответствия.Значение;
        НоваяСтрока.Имя = ЭлементСоответствия.Ключ;
        Если НоваяСтрока.Вход И ХранимыеПараметры.Свойство(ЭлементСоответствия.Ключ) Тогда
            НоваяСтрока.ТипПараметра = ПолучитьСтрокуОписаниеТипа(ХранимыеПараметры[ ЭлементСоответствия.Ключ]);
            НоваяСтрока.ПоУмолчанию = Строка(ХранимыеПараметры[ ЭлементСоответствия.Ключ]);
        КонецЕсли;
    КонецЦикла; 
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьСписокВыбораЭлемента(СтрокаОбъектМетаданных)
    ОбъектыМетаданных =   ОбъектыМетаданных();
    СписокФорм = Новый Массив;
    КлючСоответствия=Лев(СтрокаОбъектМетаданных,Найти(СтрокаОбъектМетаданных,"."));
    ЗначениеСоответствия=ОбъектыМетаданных[КлючСоответствия];
    ИмяОбъекта=СтрЗаменить(СтрокаОбъектМетаданных,КлючСоответствия,"");
    Для Каждого Форма Из Метаданные[ЗначениеСоответствия][ИмяОбъекта].Формы Цикл
        СписокФорм.Добавить(СтрокаОбъектМетаданных+".Форма."+Форма.Имя);
    КонецЦикла; 
    Возврат СписокФорм;
КонецФункции

&НаКлиенте
Процедура КомандныйИнтерфейсКонтекстНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
    СписокФорм = ПолучитьСписокВыбораЭлемента(Элементы.КомандныйИнтерфейс.ТекущиеДанные.ОбъектМетаданных);
    Элемент.СписокВыбора.ЗагрузитьЗначения(СписокФорм);
КонецПроцедуры

#КонецОбласти 


&НаСервере
Процедура ПодключитьВнешнююОбработкуНаСервере()
    ВнешниеОбработки.Подключить("v8res://mngbase/StandardEventLog.epf", "StandardEventLog", false);
КонецПроцедуры

&НаСервере
Процедура СоздатьРегламентноеЗадание()
    Если Параметры.Ключ.Пустая() Тогда
        Возврат;
    КонецЕсли;	
    МассивПараметров =  Новый Массив();
    МассивПараметров.Добавить(Объект.Ссылка);
    Отбор =Новый  Структура;
    Отбор.Вставить("Ключ",Объект.Ссылка.УникальныйИдентификатор());
    МассивЗаданий=РегламентныеЗадания.ПолучитьРегламентныеЗадания(Отбор);
    Если МассивЗаданий.Количество()>=1 Тогда
        Сообщить("Задание с  ключом "+ Отбор.Ключ + " уже существует");
    Иначе
        Задание = РегламентныеЗадания.СоздатьРегламентноеЗадание("alg_УниверсальноеРегламентноеЗадание");
        Задание.Наименование = Объект.Наименование;
        Задание.Ключ =  Отбор.Ключ;
        Задание.Использование = Ложь;
        Задание.Параметры=МассивПараметров;
        Задание.Записать();
        Сообщить("Создано регламентное задание "+Объект.Наименование+" с  ключом "+ Отбор.Ключ);
    КонецЕсли;
КонецПроцедуры // СоздатьРегламентноеЗадание()


&НаСервере
Процедура УдалитьРегламентноеЗаданиеНаСервере()
    Если Параметры.Ключ.Пустая() Тогда
        Возврат;
    КонецЕсли;	
    МассивПараметров =  Новый Массив();
    МассивПараметров.Добавить(Объект.Ссылка);
    Отбор =Новый  Структура;
    Отбор.Вставить("Ключ",Объект.Ссылка.УникальныйИдентификатор());
    МассивЗаданий=РегламентныеЗадания.ПолучитьРегламентныеЗадания(Отбор);
    Если МассивЗаданий.Количество()>= 1 Тогда
        МассивЗаданий[0].Удалить();
        Сообщить("Удалено регламентное задание  "+ Объект.Наименование);
    КонецЕсли;
    // Вставить содержимое обработчика.
КонецПроцедуры


#КонецОбласти


#Область СлужебныеПроцедурыИФункцииБСП

&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры
&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры
&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
    	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

#КонецОбласти








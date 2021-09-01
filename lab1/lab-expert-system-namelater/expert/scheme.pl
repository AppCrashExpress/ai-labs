%Базовые навыки
base_trait(physics, "Вы знаете физику?").
base_trait(math, "Вы знаете математику?").

base_trait(algs, "Вы знаете основные алгоритмы?").
base_trait(oop, "Вы знаете основы ООП?").
base_trait(framework, "Вы умеете работать с фреймворками?").

base_trait(unity, "Вы умеете работать в Unity?").
base_trait(unreal, "Вы умеете работать в Unreal Engine?").
base_trait(cryengine, "Вы умеете работать в Cry Engine?").
base_trait(idtech, "Вы умеете работать в Id Tech?").

base_trait(cpp, "Вы владеете языком программирования C/C++?").
base_trait(python, "Вы владеете языком программирования Python?").
base_trait(java, "Вы владеете языком программирования Java?").
base_trait(csharp, "Вы владеете языком программирования C#?").

base_trait(test, "Вы можете протестировать продукт?").
base_trait(concept, "Вы можете продумать концепцию игры?").
base_trait(enviroment, "Вы умеете прорабатывать окружение в играх?").
base_trait(characters, "Вы умеете работать над персонажами в играх?").

base_trait(zbrush, "Вы умеете работать в zBrush?").
base_trait(blender, "Вы умеете работать в Blender?").
base_trait(sculptris, "Вы умеете работать в Sculptris?").
base_trait(anatomy, "Вы знаете анатомию?").
base_trait(coloristic, "Вы знаете основы колористики?").

base_trait(photoshop, "Вы умеете работать в Photoshop?").
base_trait(illustrator, "Вы умеете работать в Illustrator?").
base_trait(gimp, "Вы умеете работать в GIMP?").
base_trait(gui, "Вы умеете работать над интерфейсом?").

base_trait(linux, "Вы знаете основы операционной системы Linux?").
base_trait(mac, "Вы знаете основы операционной системы Mac?").
base_trait(windows, "Вы знаете основы операционной системы Window?").

base_trait(sql, "Вы владеете языком SQL?").
base_trait(makebase, "Вы умеете проектировать базы данных?").

base_trait(git, "Вы умеете пользоваться Git?").
base_trait(github, "Вы умеете пользоваться GitHub?").
base_trait(cvs, "Вы умеете пользоваться CVS?").

base_trait(css, "Вы владеете языком CSS?").
base_trait(html, "Вы владеете языком HTML?").

base_trait(js, "Вы владеете языком JavaScript?").
base_trait(angular, "Вы умеете работать с Angular?").
base_trait(nodejs, "Вы умеете работать с NodeJS?").
base_trait(react, "Вы умеете работать с React?").

base_trait(macket, "Вы можете создать макет проекта?").

base_trait(release, "Вы можете определить платформу реализации?").

base_trait(findrequirements, "Вы можете согласовать требования с заказчиком?").
base_trait(findusers, "Вы можете определить пользователей продукта?").
base_trait(findtask, "Вы можете выявить задачу, которую должен решать продукт?").

base_trait(risk, "Вы умеете анализировать риски?").
base_trait(tz, "Вы можете сформулировать техническое задание?").
base_trait(rinok, "Вы умеете анализировать ситуацию на рынке?").

base_trait(modelbp, "Вы можете смоделировать бизнес процесс?").
base_trait(optimizebp, "Вы умеете оптимизировать бизнес процесс?").
base_trait(describebp, "Вы можете описать бизнес процесс?").

base_trait(text, "Вы умеете писать тексты?").

base_trait(vk, "Вы работаете с соц.сетью ВКонтакте?").
base_trait(instagram, "Вы работаете с соц.сетью Instagram?").
base_trait(facebook, "Вы работаете с соц.сетью Facebook?").
base_trait(tiktok, "Вы работаете с соц.сетью TikTok?").

base_trait(joint, "Вы поддерживаете связь с аудиторией?").
base_trait(alalizeprod, "Вы умеете анализировать продукт?").
base_trait(goodspeech, "У вас грамотная речь?").

base_trait(predictsell, "Вы умеете прогнозировать продажи?").
base_trait(marketstrategy, "Вы знаете маркетинговые стратегии?").

base_trait(monitorspros, "Вы умеете мониторить спрос?").
base_trait(monitorconcurents, "Вы умеете мониторить конкурентов?").

base_trait(organize, "Вы можете организовать работу команды?").

base_trait(knownmark, "Вы можете создать узнаваемую марку?").
base_trait(sellstrategy, "Вы знаете стратегии продаж?").

%Более сложные условия
trait(mechanics) :- 
	check(physics); check(math).

trait(deepprog) :- 
	(check(algs); check(oop); check(framework)), check(langs).

trait(langs) :-
	check(cpp); check(python); check(java); check(csharp); check(nodejs).

trait(engines) :-
	check(unity); check(unreal); check(cryengine); check(idtech).

trait(model3d) :-
	check(zbrush); check(blender); check(sculptris).

trait(artist) :-
	check(anatomy); check(coloristic).

trait(model2d) :-
	check(photoshop); check(illustrator); check(gimp).

trait(baseos) :- 
	check(linux); check(mac); check(windows).

trait(skilldb) :- 
	check(sql); check(makebase).

trait(vercontrol) :- 
	check(git); check(github); check(cvs).

trait(skilljs) :- 
	check(js), (check(angular); check(react)).
	
trait(web) :- 
	check(css), check(html), check(skilljs).
	
trait(uiux) :- 
	check(coloristic), check(macket).
	
trait(client) :- 
	check(findrequirements), check(findusers), check(findtask).

trait(controlbp) :- 
	check(modelbp); check(optimizebp); check(describebp).
	
trait(socseti) :- 
	check(vk); check(instagram); check(facebook); check(tiktok).

trait(monitor) :- 
	check(monitorspros); check(monitorconcurents).

trait(branding) :-
	check(knownmark); check(sellstrategy).
	
%Финальный результат
job("Разработчик игр") :-
	check(mechanics), check(deepprog), check(engines).

job("Тестировщик") :-
	check(engines), check(langs), check(test).

job("Геймдизайнер") :-
	check(test), check(concept), check(enviroment), check(characters).

job("3D художник") :-
	check(characters), check(model3d), check(artist).

job("2D художник") :-
	check(artist), check(enviroment), check(model2d), check(gui).
	
job("Backend-разработчик") :-
	check(deepprog), check(baseos), check(skilldb), check(vercontrol).

job("Frontend-разработчик") :-
	check(vercontrol), check(skilldb), check(web), check(model2d), check(uiux).
	
job("Системный аналитик") :-
	check(test), check(skilldb), check(langs), check(release), check(client), check(risk), check(tz).

job("Бизнес аналитик") :-
	check(risk), check(client), check(controlbp), check(rinok).
	
job("SMM менеджер") :-
	check(text), check(socseti), check(joint), check(alalizeprod), check(rinok), check(goodspeech).

job("Продакт-менеджер") :-
	check(predictsell), check(joint), check(alalizeprod), check(rinok), check(monitor), check(marketstrategy).

job("Тимлид менеджер") :-
	check(goodspeech), check(predictsell), check(rinok), check(marketstrategy), check(monitor), check(organize).

job("Маркетолог") :-
	check(marketstrategy), check(rinok), check(alalizeprod), check(monitor), check(branding).

-- encoding: UTF-8

------------------------------------------------
-- 谷歌拼音输入法学生评语输入扩展
-- 版本: 0.1.0.1
-- 作者: Yichen Lu
-- 作者主页: http://orzfly.com/
-- 扩展主页: http://orztech.com/google-pinyin-ime-extension/students-comments-input
-- 项目主页: http://code.google.com/p/google-pinyin-api/
-- 问题反馈: http://orztech.com/forms/2
--
-- 此扩展遵循GPLv3发布
------------------------------------------------
-- orderedPairs: http://lua-users.org/wiki/SortedIteration
_0=pairs function _1(_6)local _2={}for _4 in _0(_6)do table.insert(_2,_4)end table.sort(_2)return _2 end function _3(_6,_5)if _5==nil then _6._7=_1(_6)_4=_6._7[1]return _4,_6[_4]end _4=nil for _8 = 1,table.getn(_6._7)do if _6._7[_8]==_5 then _4=_6._7[_8+1]end end if _4 then return _4,_6[_4]end _6._7=nil return end function _9(_6)return _3,_6,nil end pairs=_9

function YichenLu_StudentsComments(arg)
  local input = string.lower(arg)
  local metatables = {}
  local suggest = ""
  local id = ""
  local flag = false
  for k, v in pairs(_YichenLu_StudentsComments_Code) do
    flag = false
    if (#k >= #input) and (string.sub(k, 1, #input) == input) then flag = true suggest = string.sub(k, #input+1) id = k end
    if (#k < #input) and (string.sub(input, 1, #k) == k) then flag = true suggest = "" id = k end
    if flag == true then table.insert(metatables, {["suggest"] = suggest, ["help"] = v[1], ["id"] = id}) end
  end
  if #metatables == 0 then
    metatables = "-- net::ERR_CONNECTION_RESET --"
  elseif (#metatables == 1) and (metatables[1]["suggest"] == "") then
    local newtable = _YichenLu_StudentsComments_Code[metatables[1]["id"]][2]
    if type(newtable[1]) == "string" then
      metatables = newtable
    else
      local newinput = string.sub(input, #(_YichenLu_StudentsComments_Code[metatables[1]["id"]]))
      metatables = {}
      for k, v in pairs(newtable) do
        if string.sub(k, 1, #newinput) == newinput then
          table.insert(metatables, {["suggest"] = string.sub(k, #newinput+1), ["help"] = v[1], ["id"] = k})
        end
      end
      if #metatables == 0 then
        metatables = "-- net::ERR_CONNECTION_RESET --"
      elseif (#metatables == 1) and (metatables[1]["suggest"] == "") then
        metatables = newtable[metatables[1]["id"]][2]
      end
    end
  end
  return metatables
end

_YichenLu_StudentsComments_Code={
["a"] = { "印象", {
  ["a"] = { "外貌", {"眉清目秀，机智敏捷，你的身上洋溢着青春的气息，你应该是一位有出息的女孩。","那双黑亮的眼睛，透射出你的机灵；那句句入耳的话语，表明你是个懂道理的孩子。","你长得虎头虎脑，一见就是一个很聪明的男孩。","你纯真可爱，对待同学热情大方。","你脸上的每一个表情都很温和，宛如你身上每一根线条都很柔和一样。","你面目五官清清秀秀，言谈举止斯斯文文，衣服穿得干干净净。","你随时都是笑眯眯的，自然地流露出心灵的善良。","你有一颗纯真的心，你的笑容如春风洋溢。","你真是一个可爱的女孩；你让人越来越看不见昔日不听话的影子。","你总是带着甜甜的笑容，能与同学友爱相处。","为什么你的校服穿着总是马虎了事呢？老师多次发现你衣着不文明，这不是一个好学生应有的表现。","秀气的你总是默默的坐在角落里，其实你也有活泼的一面，能将它表现到课堂上吗？","一看就觉得你像位文质彬彬的书生。",} },
  ["b"] = { "思想、性格", {"不骄傲，不炫耀是你取得成功的途径。","不知你有没有觉察到自己性格暴躁，脾气大，希望能自觉控制自己的情绪。","诚实、热情，尊敬师长，关心集体，学习自觉是你最突出的优点。","经历艰苦的磨砺时，你不失奋斗的勇气；享受荣誉的赞美时，你不沾沾自喜。","老师很欣赏你这种敢于说真话的人。","你本学期以来，心理上成熟了许多，为人处事有了自己的主见。","你常常觉得自己不聪明，但在我的心目中你很聪明，只有那些自以为是、不努力学习的人才是最大的笨蛋，在我心目中，你是个自尊、好强、不贪慕虚荣的人。","你的平凡、朴实、聪明、大方，你的神情已深深印在老师的记忆中。","你的勤奋刻苦是无与伦比的，你惊人的意志力令我欣慰不已。","你的自尊心很强，这本来会帮你成功，但你却常常因这而犯错。","你很聪明，也很灵气，你本来不应该是一个普普通通的学生，只可惜，你太贪玩了。","你积极进取的精神真令人赞赏！","你快人快语，直抒胸襟；你办事利索、果断，不拖泥带水；你眼睛里闪烁着智慧的光芒，你是一个思维敏捷的好学生。","你品学皆优、奋进向上，是老师最满意的学生。","你朴实无华，积极上进，身处逆境也永不退缩。","你是个懂礼貌、明事理的孩子，虽然不爱言语，对事物却有自己独到的见解。","你是个人见人爱的小女孩，每件事都做得那么细致、认真。","你是一个不服输的男子汉。","你是一个聪明、勇敢、集体荣誉感极强的男子汉。","你是一个懂事，有爱心的女孩。","你是一个很要强的女孩子，很棒。","你是一个很有修养的女孩，对待同学总是谦虚友好，对待学习总是毫不怠慢，对待工作总是勤勤恳恳，对待困难总是坦然应对……","你是一个积极要求上进的男孩，从一次次的发言中，流露出迫切要求入团的愿望，但你还缺乏明辨是非的能力，常常让老师有些失望。","你是一个朴实的孩子，平时总是默默地做事、任劳任怨。","你是一个上进心强，聪明而且心地善良的女孩。","你是一个秀外慧中的懂事的孩子。","你是一个自我管理能力很强的女孩子，无论在哪你都能严格要求自己。","你心眼儿是很好的，对班级也十分热爱，就是脾气不好，时不时还和科任老师顶撞几句；做事常常由着性子来，严重时还有点霸王作风，因而引起同学的强烈不满。","你有宽阔的胸怀，却少了坚韧不拔的钢铁意志，你是老师的“重点牵挂对象”。","你有时处理问题自以为是，一意孤行，课余有不文明的举止。","善良懂事的男孩子，最让人欣赏，恰好你就是；开朗乐观的男孩子最若惹人喜爱，恰好你也是；热情懂事的男孩子最值得称赞，恰好还是你。","虽然平日你默默无闻，却看得出你样样要强。","现在的你，越来越像一个真正的男子汉了！",} },
  ["c"] = { "作业", {"美中不足的是上课时而不专心听讲，作业有时不按时完成。","你不能按时交作业却让老师头疼，我想主要的是你缺少“勤”字，是吗？","你的作业不能令老师满意，希望你在写字方面能有所进步。","你写作业的速度可有些慢，总喜欢边写边玩，这可不是什么好习惯。","你有时会忘记老师布置的事或作业，希望你从小养成做事认真的习惯。","你总是很怕做作业，经常拖欠作业。","平时你对自己不严格要求，作业拖拖拉拉、马马虎虎，老师为你感到可惜。","请把你的作业书写得像你的外貌一样漂亮！","俗话说：字如其人，把字写得更好看一些，就再好不过了。","你知道吗？有时老师清点作业时，竟然发现少你一本！","如果你作业能认真按时一点的话，你真是好学生。","翻开你的作业本，真是让大家赞不绝口。","尽管你的作业有时出现小差错，老师仍然欣赏你的机敏和大胆。","看你作业认真，字写得漂亮，的确是一种享受，说明你有着认真的态度。","课下你能按时完成作业，成绩有了明显的提高，这些都说明你是有潜力的。","课下你认真完成作业，及时改错，一丝不苟地对待学习。","每次看你的作业，老师都会觉得是一种美的享受。","每当我看到你工工整整的作业，就忍不住停下来欣赏。","你刻苦踏实的学习精神很让我喜欢。","能认真完成老师布置的作业。","你的作业又干净又整齐，批阅时真是赏心悦目。","你能按时完成作业，字迹工整。","你是个很认真的学生，每一次的作业都做得很清爽，很仔细。","你写作业的速度更是令人惊讶，你的作业本干净，整齐，老师十分欣赏。","你作业的质量有了显著的提高，老师也为你感到高兴。","儒雅的你，无论是作业还是考试，书写总是工工整整。","老师发现你的作业干净整齐，你的字清秀漂亮，看你的作业真是一种享受。","这学期的进步很大，很少有不能完成作业的现象。","这学期你最大的进步就是改掉了拖拉作业的坏习惯，老师为你高兴、自豪。",} },
  ["d"] = { "学习", {"爱动脑、好提问，你的优点真不少。","从你彬彬有礼的话语中可以看出你是个有礼貌的好孩子；从你积极肯学的学习态度上，我知道你是个有上进心的好学生。","娟秀的小字，干净的卷面都说明确你是一个认真仔细的好孩子。","你的聪明真让老师和同学们佩服，再难的题你都能解答。","你的理解能力、创新意识、逻辑思维在同龄的孩子中皆属佼佼者。","你的钻研精神极强，喜欢独立思考，而且常提出一些颇有见地的问题。","你对于自己取得的成绩容易产生骄傲、沾沾自喜、目中无人的不正常情绪。","你是个与众不同的孩子，很有个性，只要遇到问题你就会“打破沙锅问到底”，非弄明白不可。","你是一个爱学习的好姑娘！","你是一个积极上进，勤奋学习的好孩子。","你是一个肯学习、会用脑的学生，你不再胆小了，上课发言积极了很多。","你是一个勤奋的孩子，经常见你向别人请教，你的成绩也在不断进步。","你是一个学习自觉、成绩优良的好学生。","你思维比较活跃，作文有新意。","你思维敏捷，反应较快，是个聪明的孩子。","你喜欢动脑筋，爱钻偏难题。","你喜欢开动脑筋思考问题，有一定的分析能力。","你学习成绩优良，比较稳定。","你一个非常聪明、机灵的孩子。","你一个非常聪明、机灵而又调皮的孩子。","你有丰富的想象力，课堂上能用流畅而较准确的语言表达发言内容。","你有较强的应变力和适应力，善于调整自己的知识结构，学习踏实，表现优秀。","你有一颗聪明的头脑，你很活泼，口才很好，也是班上的开心豆。","我发现这学期你学习自觉了，成绩进步了，老师为你的进步而高兴。",} },
  ["e"] = { "体育", {"老师至今还记得你在参加跳绳比赛时轻盈的身影，老师也知道这是你刻苦练习的结果！","你富有朝气，性格直率，爱好广泛，努力为班级争荣誉，运动场上的英姿是你最大的骄傲。",} },
  ["f"] = { "友爱", {"难能可贵的是，你在自己进步的同时，还带动了其他几位同学。","你待人诚恳、礼貌，作风踏实，品学兼优，热爱班级，认真做好班级工作。","你对人很温和，有副好脾气。","你活泼可爱，为人坦诚。","你平时处理问题以自我为中心，不太注意考虑别人的感受。","你热心助人，集体观念较强，心直口快，不隐瞒自己的想法，做事风风火火。","你是善良、朴实、懂事而又认真的女孩，做事一贯认真，经常帮助教师排忧解难，帮助其他同学攻克难关，我对你充满了感激之情，我想得到你帮助的同学也会经常感谢你。","你是同学们可信赖的人，是老师较得力的助手。","你是一个活泼的氯离子，班级有你更添活力。","你是一个乐于助人、活泼可爱的好孩子。","你思想纯朴，待人随和、诚恳，处事稳重；同学关系好，热爱集体，乐意助人是你的美德。","你为人诚实，与同学关系相处不错。","你文静温和，大家都愿意和你一起玩。","你心地善良，脾气温柔，接物待人春风扑面。","你用实际行动证明你是一个诚实、乐于助人的好同学。","你有很多优点，像做事麻利、待人热情等。","你有很多优秀的品质，遵守纪律，认真学习，和同学相处时宽容大度，热心班上的人和事。","同学们都喜欢围在你身边，和你一起玩，因为你善解人意，宽容大方。","这学期，老师欣喜地发现，你能与自己的小伙伴们友好相处，互帮互助。","只要谁需要帮助，你准会伸出友谊之手。",} },
  ["g"] = { "班务", {"对于中队委的工作你更是认真负责，积极组织各种活动，是一个优秀的小干部。","你是个热心肠，班集体的事你时刻记在心上，拿螺丝钉、印卷子、为中队会找材料，你跑前跑后，没少费心。","你是我心目中比较认真踏实的男孩，你谦虚、诚实，乐于做好自己的本职工作，从小事做起，默默为班集体争荣誉。","你是一个学习认真，工作负责的好孩子。","你为人朴实正直，工作认真负责。",} },
  ["h"] = { "其他", {"你爱好广泛、知识面较宽，对自然、人生的美丽有一份执着信念。","你爱抒鸿鹄志，不乏真诚感；你乐作深沉文，偶有通假字。","你不断进步，老师看在眼中，喜在心头。","你的的确确是一个德才兼备的好学生。","你的优点像你的缺点一样丰富，你的缺点像你的优点一样突出。","你点点滴滴的进步，老师都看在眼里，喜在心头。","你给我的印象是：“你真棒”！","你看起来很调皮哟。","你留给老师的印象就是：老老实实，真真实实，踏踏实实，朴朴实实！","你没有少挨我的批评，但我真的不认为你是一位“坏”同学。","你是爸爸、妈妈的好女儿，也是老师的乖学生！","你是个聪明、直爽的女孩，对待他人热情友好，对待工作一丝不苟，但也常常不自觉流露出许多小毛病：课堂上的心不在焉、自修课上的蠢蠢欲动、学习上的平平淡淡。","你是个兴趣广泛，充满好奇心的学生。","你是一个全面发展的、各方面表现出色的好学生。","我对你最满意的是，你能够理解老师对你的帮助，还能虚心接受同学的批评，正因为这样，你最近的进步才如此之大，让老师、同学、家长笑眯了眼！","我记得你是第一个让老师为你借校服的同学，当时我很生气，但是从那以后，你乐意把每一件小事做好，再也没有出现自己的事要别人帮你完成的情况了。","喜欢你的羊角辫（虽然时常显得凌乱）；喜欢你的思维敏捷（虽然有时接下茬）；喜欢你做作业的思路清晰（虽然字迹不很清秀）……","在老师同学的眼里，你是一个可以信任的人。","在每个人的眼里，你绝对是一个听话懂事的孩子。","在我的印象中，你只有两种表情：忧郁（微微皱眉）和快乐（甜甜微笑）。",} },
} },
["b"] = { "工作", {
  ["a"] = { "工作态度", {"担任***的你更是能严格要求自己，积极组织各种活动，决心把班集体建设的更好，对工作认真负责的劲真让人佩服。","担任***后，你更是能严格要求自己，处处做同学们的榜样，真棒！","工作认真负责，计划性较强，有始有终，令人放心，但如能更加大胆一点就更好了。","工作中，你的干劲鼓得足足的，从不泄气。","你对班级工作认真负责，尤其是卫生清洁，总是任劳任怨，一丝不苟，从不推诿。","你对班级工作认真负责，在任何情况下，总是稳稳当当、扎扎实实地完成老师交给的任务。","你对工作认真负责，而且能够虚心地接受老师对你的建议。","你工作积极，乐意为老师当小助手。","你认真负责的工作态度给我留下了深刻的印象。","你是一名优秀的班干部，对自己的本职工作尤其负责，收发作业，认真及时。","你有一种现代学生少有的“较真”的正气，同学送给你“铁面无私”的美称。","你做事认真，责任心强，关心集体，任劳任怨，是老师的得力助手。","生活委员琐事太多，可你对待这些鸡毛蒜皮的工作，却认真到了一丝不苟的地步，因而大大减少了我这个班主任的繁琐事务。","谢谢你对老师的帮助，在工作中，老师知道你是一个做事有条理、认真负责的好同学。","作为班干部，你能积极主动搞好本职工作，得到同学的信任和支持。","作为组长，你对工作非常认真，有困难就自己解决，为老师减轻了很多负担。",} },
  ["b"] = { "工作方法", {"对待工作，你认真负责，如果工作时再有点魄力就更好了。","发扬优点，并在工作上多想想办法，你会更加优秀。","工作要讲究方法，希望你能和其他班委联合起来，做好班里的工作。","看来在工作艺术方面，我这个班主任确实还得向你学习啊！","老师很欣赏你的工作能力，相信在以后的学习与工作中，你会发展得更好。","你工作很能干，是班上的小能手。","你能公正地处理同学之间的矛盾，每一次都让大家信服。",} },
  ["c"] = { "效果", {"班干工作，你不够主动大胆，所以尽管付出了一定的时间和精力，但效果较差。","你的内心其实非常纯洁善良，而且有着内在的集体责任感，自从当上物理科代表之后，以你特有的细腻，认真地履行着自己的职责，而且“身先士卒”，带头把物理学得十分灿烂！","你是个称职的卫生委员，为全班同学创造了优美清洁的学习环境。","你是一班之长，你的表现说明你无愧于这样的称号，你所取得的成绩说明了你是个认真、执着、上进的男孩，你用你的实力创造了一个又一个成绩，也树立了你的威望，你是班主任的得力助手，我为你喝彩，我为你骄傲。","你有较强的班集体荣誉感，有一定的号召力，能把老师交给的任务完成好。","同学们对班委进行民主评议时，你受到的赞扬最多！","曾任小组长，你“政绩”不菲。","作为科代表的你，很好地起到了任课老师与同学们之间的“桥梁”作用。","做事稳重踏实是你的特点，也是你赢得同学们交口称赞的原因。",} },
  ["d"] = { "其他", {"从你当班长开始，班委真正实现了对班集体的自我管理。","你待人善良，律己严格，具有强烈的责任感和服务意识，且工作能力很强。","你担任了团支部书记，还被同学们评选为三好学生，令人羡慕更令人敬佩。","你是一个不可多得的好干部，是班主任最得力的助手。","虽然平时你默默无闻，却看得出你其实样样要强，你用实际的行动证明，你无愧于学生会干部的称号；你用点点滴滴的汗水，浇灌着成功的花朵。","为集体做了不少的好事，大家都很喜欢你。","作为一名学生，你是成功的；作为一名班干部，你也是成功的。",} },
} },
["c"] = { "纪律", {
  ["a"] = { "好", {"本学期在纪律上有进步，可以看出你确实付出了努力。","你能严格遵守班级和宿舍纪律，热爱集体，关爱同学。","你能自觉遵守学校的各项规章制度，自觉抵制各种不良思想。","你是我们班路程较远的学生，但你竟然做到了提前到校，你真了不起！","你严于律已，小小年纪就懂得自觉，老师祝贺你！","让我高兴的是你在纪律上的变化，你克服了自身的随意性，变得懂事、踏实多了。","作为一名班干部，你能以身作则，严格遵守学校的各项纪律。",} },
  ["b"] = { "中", {"不过，自我控制能力仍有待提高，迟到现象也时有出现。","大多数的时候你都能遵守纪律，偶尔会犯一些小错误。","老师知道你也想改掉不好的习惯，但是自控能力差。","你渴望做一个守纪律的学生，但又常常不能约束自己。","你缺乏自制力，如果能改掉课堂上随便说话的毛病，那该多好啊！","你在无意识中会犯一些小错误，但总的来说还是一个遵规守纪的学生，以后应注意培养自己的控制能力。","你总管不住自己，免不了受到老师和同学的责怪，这多可惜呀！","严于律己稍逊，常挨老师“骂”；宽以待人渐佳，时被同学夸。",} },
  ["c"] = { "差", {"考试时，你有作弊行为，弄虚作假，诚实是一种美德，希望你也拥有这种美德。","课间你常和同学打闹，多危险啊！","你有时在冲动的情况下破坏了公物，今后要控制自己的情绪，改正这种不良行为。","这学期你在纪律方面有所退步，固然有客观原因，也排除不了主观上的放松。","中午经常性不在课室，这直接影响你下午上课时的精神。",} },
} },
["d"] = { "课堂", {
  ["a"] = { "好", {"看到课堂上，你那专注的神情，认真的学习态度，老师也感到欣慰。","课上，你总是认真听讲，并能积极举手回答问题。","课堂上，你总是聚精会神；从你上课高举的手中，老师看到了你的自信。","课堂上，你总是踊跃发言，这也证明你在留心听讲、积极思考。","课堂上你精彩的发言常常博得阵阵掌声，也给老师留下了很好印象。","老师喜欢你那种敢想、敢说、敢问、敢辩的课堂表现。","你学习勤奋，课堂上那双求知的大眼睛总能把老师深深地感动！","儒雅的你，上课总是全神贯注，无论是作业还是考试，书写总是工工整整。","上课积极发言，见解独到，赢得了师生对你的好评。","上课你能注意听讲，课后你能自觉完成作业，课间与同学打闹的现象也少了，你的变化让老师感到很欣慰。","上课时用心听讲的神情，让人感到你的专注、认真。",} },
  ["b"] = { "不好", {"不足这处就是上课发言不够积极。","可当我看到你上课又走神时，又多了一声叹息。","美中不足的是：上课回答问题不积极，今后在课堂上能经常看到你大胆地举手发言吗？","美中不足的是：上课时不专心听讲，作业有时不按时完成。","你头脑聪明，可学习成绩不够理想，老师认为主要是你上课听讲不够认真，不能约束自己。","若是改掉课堂上随便说话的毛病，那该多好啊！","上课经常麻木不仁，作业经常一塌糊涂，还不时和妈妈发生争吵……你到底是怎么了？","上课要开动脑筋，举手发言，珍惜每一次锻炼的机会，你才能获得学习上的丰收。","上课要专心，因为上课走神，影响了自已的学习，多可惜呀。","上课注意力不够集中，有时会发呆。是不是有什么心事？可以告诉老师吗？","秀气的你总是默默的坐在角落里，其实你也有活泼的一面，能将它表现到课堂上吗？","有时上课不够留心，还有些小动作，你能想办法控制自己吗？",} },
} },
["e"] = { "作业", {
  ["a"] = { "好", {"翻开你的作业本，真是让大家赞不绝口。","课下你能按时完成作业，成绩有了明显的提高，这些都说明你是有潜力的，但前提是要努力。","课下你认真完成作业，及时改错，一丝不苟地对待学习。","每次看你的作业，老师都会觉得是一种美的享受。","每当我看到你工工整整的作业，就忍不住停下来欣赏，刻苦踏实的学习精神也很让我喜欢。","能认真完成老师布置的作业。","你的作业又干净又整齐，批阅时真是赏心悦目。","你能按时完成作业，字迹工整。","你写作业的速度更是令人惊讶，你的作业本干净，整齐，你抢着回答问题时急切的表情让老师感受到你对知识的渴望。","你作业的质量有了显著的提高，老师也为你感到高兴。","儒雅的你，上课总是全神贯注，无论是作业还是考试，书写总是工工整整。","一开学老师就发现你的作业干净又整齐，你的字清秀又漂亮，看你的作业真是一种享受。","这学期的进步很大，很少有不能完成作业的现象。","这学期你最大的进步就是改掉了拖拉作业的坏习惯，看着你的学习成绩不断进步，老师为你高兴、为你自豪。",} },
  ["b"] = { "不好", {"美中不足的是上课时而不专心听讲，作业有时不按时完成。","你不能按时交作业却让老师头疼，我想写作业速度慢是一个原因，但更主要的是你缺少“勤”字，是吗？","你的作业不能令老师满意，希望你在写字方面能有所进步。","你写作业的速度可有些慢，总喜欢边写边玩，这可不是什么好习惯，是男子汉就改掉它，怎么样？","你有时会忘记老师布置的事或作业，希望你从小养成做事认真的习惯。","你总是很怕做作业，经常拖欠作业。","平时你对自己没有严格要求，作业拖拖拉拉、马马虎虎，老师为你感到可惜。","请把你的作业书写得像你的外貌一样漂亮！","俗话说：字如其人，把字写得更好看一些，就再好不过了。",} },
} },
["f"] = { "学习/态度", {
  ["a"] = { "好", {"爱好广泛，在学习上有股子钻劲儿。","聪明的你对待学习态度端正，能够认真地完成学习任务。","对待学习你同样认真，上课大胆发言，课下认真完成作业，学习成绩优秀，你是同学们的好榜样！","对待学习生活中的每一件事你都是一丝不苟，你能认真完成作业，及时改错，严格要求自己。","对待学习态度端正，上课能够专心听讲，课下能够认真完成作业。","和去年那个不完成作业的你相比，真是判若两人。","后半学期，在学习上有进步，上课能专心听讲了，下课也能按时完成作业了，大家都为你的重大进步感到高兴。","课上，你思维敏捷，积极回答问题，受到了各科老师的好评；课下，你爱好广泛，勤学苦练。","老师欣赏你认真、踏实的学习态度。","你的自觉性很强，勤奋学习，能吃苦，成绩有进步。","你很聪明，而且在学习上很用心，课上积极大胆的发言，课下认真仔细的作业都说明这一点。","你虚心地向别人学习，使自己变成一个各方面都优秀的女孩。","你也是个认真、自觉的女孩，对待学习毫不怠慢，星期天常自觉到校自修，我内心很佩服你。","平时总是沉默寡言的你在课堂上却能认真听讲，积极举手回答问题，你专注的神情让老师感受到你对知识的渴望。","学习刻苦认真，善于思考,勇于进取。","学习肯努力，作业越写越好。","学习上，你的基础较差，学起来有些吃力，但你并没有放弃学习，还不断向成绩好的同学学习。","学习上你好学上进，积极要求进步，能够比较严格地要求自己。","学习上认认真真，从不松懈，成绩优良，常常能得到老师的夸奖。","学习态度向来很端正，课堂纪律、各科作业等等，从不需老师操心。","学习中你不畏惧，勇敢地克服学习中的困难，做到按时按质完成老师的作业。","在学习上，好学爱钻，不把问题搞清楚就誓不罢休的钻劲儿，是老师最欣赏你的地方。","在学习上，好学上进，有一股不服输的韧劲儿。","在学习上，能够不断地何优秀生学习，弥补自己的不足。","在学习上，你积极肯学，领悟力较强。","在学习上很自觉，所以从来不会落到别人后面。",} },
  ["b"] = { "不好", {"不过，粗心、马虎，阻碍了你的进步。","不过学习上你有不足之处，热情不高，以致成绩不理想。","但你的学习态度却着实令老师着急，只要告别懒惰，相信你不会比别人差。","但学习上还欠勤奋、踏实，一手字也写不好，我真为你担心。","对待学习，你马马虎虎，满不在乎，辜负了妈妈的期望。","对待学习，有充分的自信心，思维较敏捷，肯钻研，学习自主能力有较大提高，但我总觉得你与班级有着一段距离。","对于你来说，全身心地搞好学习才无愧于你的父母，懂吗？","可遗憾的是为什么在课堂上看不到你积极发言的身影呢？","老师想对你说，对学习，你要能有像打游戏的那股冲劲、拼劲，那该有多好啊！","你爱好广泛，但总不能正确处理“学习”与“活动”的关系，以致于学习毫无起色。","你的数学作业本上总是缺少干净与整齐，你的作文也缺少自己的特色，如果你能努力让自己做得更好，相信大家会更喜欢你的，是吗？","你的学习成绩时好时差，是你沒有恒心的缘故。","你基础不弱，理解能力也挺好，只要用心学习，成绩很快会提高。","你渴望学习成绩的进步，但又缺乏顽强拼搏的精神。","你是一个很聪明的孩子，只是过于贪玩，对学习不够重视，因此课堂听讲常要走神，课后复习也不充分，一年来，成绩正慢慢下降。","你也很想成为一名优秀的学生，以优异的成绩去回报父母和老师，但一次次原谅自己的错误，放松对自己的要求，使得你没有取得太大的进步。","你也有上进的愿望，希望得到老师和同学们的喜爱，但一次次地放松对自己的要求，使你一直没有实现这个愿望。","你真的很聪明，知识面广，反应快，只要用功，学习将会不是一般的优秀。","我真为你惋惜，凭你的头脑，凭你的基础，你完全可以学业有成，为什么不珍惜呢？","我知道，因为基础不好，你学起来真的不容易，不过学好学坏是一回事，有没有去学又是一回事，学得再少，它也是属于自己的。","我知道你基础不好，学起来比较困难，可怎么能因此放弃呢？","学习就是这样，只要你肯下苦功夫，就会取得很大进步。","学习上你不够重视，上课容易分心，影响听课效率，这一点以后应改纠正。","学习上你渴望进步，但还缺乏刻苦钻研精神、缺乏正确有效的学习方法，学习成绩还无起色。","学习上你有一定的自觉性，不过努力程度恐怕还不够，希望你今后能专心听讲，大胆发问，不断提高自己的知识水平。","学习上你有一定自觉性，但我总觉得努力程度还不够，否则，像你这样聪明的人，学习成绩怎会停滞不前？","学习上一贯自觉，成绩也不错，但某些科的成绩好像不太稳定。","学习是没有捷径可走的，需要的是脚踏实地。","学习是要付出汗水的，勇敢地走出第一步，别后退，好吗？","在学习上，你也有学好各科的愿望，但是还不能坚持，有些龙头蛇尾。","这么优越的智力，学好英语是没问题的，可你却把课余的时光用在“游戏机”上了，多可惜呀！",} },
} },
["g"] = { "学习/方法", {
  ["a"] = { "好", {"聪明的你在行为和学习习惯上都取得了很大的进步。","对于不明白的问题你能虚心请教他人。","记忆力好，自学能力较强。","你懂得合理安排各门功课的学习时间，喜欢寻找各门学科有效的学习方法，学习成绩有明显的优势。","你能根据自己的实际，选用恰当的学习方法。","你思维灵活，接受能力较强，勤于思考，大胆质疑。","你学习有计划，有条理。",} },
  ["b"] = { "不好", {"方法上你还要多向***同学讨教，平时可经常与成绩比你更好的同学交流学习体会。","课前预习、课后复习你都做得不够。","理科相对较弱，你可在这方面多下功夫，注意学习方法，加强理科思维的培养。","你充满了求知的欲望，如果能学会学习，加上你的聪明，一定会取得令所有人刮目相看的成绩。","你的学习方法有待改进，掌握知识也不够牢固，思维能力要进一步培养和提高。","你动作太慢，学习方法也有待改善，思维能力要进一步培养。","你是一个很老实的学生，其他方面表现很好，就是学习有点跟不上，其实你平时一向很认真，很努力，为什么反而事倍功半呢？","你思维不够灵活，学习上喜欢死记硬背，有畏难的情绪。","你未能培养起良好的学习品质，缺乏顽强的学习意志和科学的学习方法。","你有时思维不够灵活，做事速度慢。","其实，你只要上课认真听，课后认真复习，有什么不懂的及时向别人请教，成绩是会跟上来的，你并不是笨，只是还没有掌握学习的方法。","其实，以你的基础，以你的勤奋，你的学习应能进一步提高，关键在于你要找到适合自己的方法。","如果在平时学习中能统筹兼顾，扎扎实实搞好文科科目基础学习，成绩会更上一层楼。","学习不是简单的记忆，更重要的是能把所学的知识灵活应用起来，知道吗？","学习成绩上不去的主要原因是没有掌握好正确的学习方法。","学习方法也有所不足，这一切阻碍了你学习成绩的提高。","学习上，你有很强的自觉性，成绩也基本稳定，如果你能讲究方法，多学多问，做得稳中有进就更好了。","学习上你依赖性较强，未注意培养独立思考的能力。","学习上你有一定的钻研精神，但学习效率不高，功课起伏较大。","这一学期你的成绩有点下降，并非你不努力，而是方法上有问题，我想这可能和你性格有关，你性格过于内向，思维的灵活性受到影响，平时也不敢发问。","只是我不明白，你看上去并不像是个胆小鬼，怎么有疑问不敢问老师？",} },
} },
["h"] = { "学习/成绩", {
  ["a"] = { "好", {"出众的学习成绩让全班同学非常佩服你！","几番努力，成绩已经有所进步；来日方长，学习应更一丝不苟。","看着你的学习成绩不断进步，老师为你高兴、为你自豪。","课堂听讲你很认真，作业也及时完成，就学习而言，我想你付出了努力，成绩也良好。","你表面上是个文静的女孩，但你又是个好强的女孩，你总不服输，学习上愿与男生比高下，成绩也是喜人的。","你的各科都有很大的进步！","你的计算题正确率多高啊！","你的学习成绩一直都很优秀，在班里是一个听话的好孩子。","你的作业总是工工整整，碰到难题也总是全力以赴、刻苦钻研，又懂得合理安排各门功课的学习时间，还喜欢寻找各门学科有效的学习方法，所以你的学习成绩才有今天的辉煌。","你懂得合理安排各门功课的学习时间，喜欢寻找各门学科有效的学习方法，学习成绩有明显的优势。","你勤奋好学，在学习上有钻劲，学习成绩稳步提高。","你是个非常出色的孩子，在学习上你谦虚好学刻苦努力，学习成绩名列前茅。","你是我们班里的佼佼者，学习成绩名列前茅。","你踏踏实实的学习态度换来了可喜的成绩。","你有一个聪明的头脑，数学成绩很好。","你在班里从不张扬，总是默默无闻的，但这并不影响你在同学们心中的威信，因为你用自己优秀的学习成绩证明着你的实力。","期中考试优秀的成绩说明了你的潜力，老师希望你继续努力争取保持住这种上升的势头，争取在各个方面都能有长足的进步！","学习成绩优秀，这有赖于你良好的学习习惯。","学习上的进步，老师和同学们都看在眼里，同样也为你感到高兴。","学习上勤勤恳恳，取得了不错的成绩。","在学习上你很有心计，上课总是全神贯注的听讲，下课会一丝不苟的完成作业，所以你的学习成绩非常优秀。",} },
  ["b"] = { "中", {"刚进新学校时，你显得不太适应这里的学习，后来情况有所好转，成绩也有所进步，但还有待继续努力，争取更好的成绩。","你本具备优等生的一切条件，但你的成绩却与之不大相符。","你的基础知识掌握得不够牢固，虽然付出了很大努力，但由于没有从根本上解决问题，因而成绩徘徊不前。","你的学习比较认真，成绩也还可以，但语文不理想，尤其是书写十分糟糕，而且常常在作文中“发明”许多“汉字”。","你的学习成绩起伏不定，基础不牢固，学习偏科，成绩不好时不能正视自己的不足，成绩稍有进步就会有骄傲自满的思想。","你渴望学习成绩的进步，为此一如既往的坚持着自己刻苦努力、奋发图强的求学原则，所有这些努力也最终换来了丰收的喜悦，尽管你的学习成绩还不够理想，但你有坚定的信念。","你勤奋好学，思维敏捷，但我总担心你后劲不足。","你知识面较宽，学习也认真，上进心很强，但美中不足的是功课起伏较大。","学习上从未挨过老师的批评，这似乎令人高兴；但也很少获得老师夸奖，这可令人遗憾！",} },
  ["c"] = { "差", {"你的学习成绩时好时差，是你沒有恒心的缘故。","数学基础不够牢固，成绩有一定的波动，对自己的不足未能正视。","学习成绩总是在前半学期稍差，后半学期较好，希望能将成绩稳定在一个较好的层次。",} },
} },
["i"] = { "特长爱好", {
  ["a"] = { "文化类", {"辩论会上你口若悬河，让同学十分信服。","参加演讲比赛成绩喜人，班队活动主持得有声有色，老师为有你这样的学生而感到骄傲。","看书是你最大的兴趣。","老师和同学们最爱听你绘声绘色地讲故事。","你的口头表达能力较强，有一定的演讲才能。","你的日记写得真有趣呀，给老师和同学们留下了多么深刻的印象。","你的写作水平出类拔萃，每次作文都会被老师当作范文在全班朗读，丰富的词汇，优美的语句让同学们非常佩服。","你很有演说才能，一篇《******》，博得全校上千师生掌声如潮。","你能写一手好字，人见人夸。","你平时能广泛阅读课外书，所以文笔优美，使人看了惊叹。","你特别喜爱阅读课外书籍，写作能力较高。","你最大的特长是写作。","台上一席讲演，未来豪杰锋芒初露。","喜欢读你的周记，平凡的语言中散发不平凡的魅力。","学校里的每次演出都少不了你，给大家留下了深深的印象。",} },
  ["b"] = { "艺术类", {"黑板报中有你倾注的心血。","你不但弹得一手好古筝，还弹得一手好钢琴。","你的笛子吹得真棒，清脆悦耳，让大家佩服。","你那婀娜的舞姿，成了同学们心中一道美丽的风景线。","你能歌善舞，是班级中的文娱积极分子。","你善歌咏，以美声唱法参赛曾获奖。","你是我们班上出了名的小画家。","你是一个能绘出美好生活的小画家。","你有说相声的才能，常常逗得大家前仰后合。","你在音乐，绘画等方面都有特长，在其它方面也表现不错。",} },
  ["c"] = { "体育类", {"老师还记得你在100米比赛中奋力拼搏、勇往直前的身影，你是名副其实冠军，你是我的骄傲。","你是咱们班的运动健将，跑道上总能看见你矫健的身影。","跳绳，长跑，你样样拿手，咱们班好多同学都特别佩服你。","忘不了你在跳绳比赛中大显身手的情景。","运动赛场上，你是班级和学校的骄傲，总是用优异的体育成绩向老师和同学们报喜。",} },
  ["d"] = { "其他", {"丰富的课外生活和广泛的兴趣爱好使你越来越聪明活泼。","老师从你的日记里得知你非常喜欢电脑，而且在这方面有着丰富的知识。","你好像很关心国家大事，因为每次谈到有关国内新闻或国际风云，你往往能从容对答，令人赞叹。","要注意加强你的兴趣培养和特长训练，全面发展。",} },
} },
["j"] = { "劳动卫生", {
  ["a"] = { "好", {"打扫卫生时，你把瓷砖擦得干干净净。","对于班里的事情你总能放在心上，劳动时也总能看到你勤劳的身影，大家都喜欢和你在一起。","对于集体的利益更是时时放在心上，值日时你总是忙前忙后，大家都看到了。","更为可贵的是，劳动中你从来不怕脏、不怕累，而且做得是那样井井有条。","劳动时，你总表现得很积极。","劳动时老师同学们总能看见你忙前忙后的身影，真让大家感动。","劳动时你总是默默无闻地出色完成任务。","你踏实肯干，每次劳动都可以看到你任劳任怨的身影。","你在劳动中总是最能干。","你总是默默地、自觉地维护教室的清洁卫生。","认真做好值日工作，劳动认真负责。","做扫除时你勤劳的身影总会出现在我们的面前。",} },
  ["b"] = { "不好", {"你不够重视劳动，未能按时完成日常的值日工作，态度较马虎。","你能按要求完成值日任务，但在劳动中表现出嫌脏怕累的思想。","你做值日生时有嫌脏怕累的思想，有时不听组长的指挥，甚至逃避做值日生的责任，这可不是一个优秀的学生应有的表现。","平时值日及大扫除中你马虎应付了事，不听组长指挥。",} },
} },
["k"] = { "文体活动", {
  ["a"] = { "体育/好", {"老师至今还记得你在参加跳绳比赛时轻盈的身影，老师也知道这是你刻苦练习的结果！","男篮比赛中，你让同学们改变打法，让不可一世的对方招架不住。","你能积极参加各项活动，在校运会中奋力拼搏，虽没有取得名次，但这种精神是很值得大家学习的。","你是体育竞赛场上的强者，用汗水和拼搏精神为我班取得了许多荣誉。","你在100米、200米跑道上奋力冲刺的那一刻，有多少人为你呐喊、为你加油、为你喝彩，而当时的我，好激动、好兴奋！","体育更是没话说，总之让人竖大拇指。","跳绳比赛中你灵活的动作轻盈的跳跃给老师留下了深刻的印象。","校运会上你双脚生风，绿茵场上你过关斩将，你为集体荣誉曾立下汗马功劳。","运动场上的你，让我们知道了什么样叫健美。","在篮球场训练时，你既投入，又认真，深得同学的好评。",} },
  ["b"] = { "体育/不好", {"老师要提醒你——身体是革命的本钱。","你的体育成绩不理想，锻炼过程中不够积极，有怕辛苦、畏难的情绪。","你的体育成绩未能令人满意，需加强锻炼。","你身体太差，动作太慢，这直接影响到你的学习成绩，如果加强体育锻炼，效果一定会很理想。","你体质较差，但又不愿锻炼身体，这必将对你的各方面产生不良影响。","体育上，你一定要加强锻炼、加大运动量，增强体质，消灭体育成绩不及格的现象。",} },
  ["c"] = { "集体活动/积极参加", {"你爱集体就象爱自己的生命，我为你感到无比的自豪。","你对班集体有满腔的热情，有正义感！","你能积极参加班的文体活动，还出色地完成了班的墙报工作。","你能积极参加各项活动，为班级建设出力，与同学能和睦相处。","你外表文静，但内心火热，在班里的各项活动中都有你的身影。","你总是默默地为班集体的每一项活动增添光彩。","热爱集体到了“死心塌地”的地步，虽是“一介小民”，却“处江湖之远，则忧其君”（这个“君”嘛，嘿嘿）！","虽然平日里默默无闻，但班级活动总有你的身影。","文化体育活动你能积极参加。","这次***比赛，你积极参与、跑前跑后，表现出你有一颗火热的爱集体的心。",} },
  ["d"] = { "集体活动/不够积极", {"不过，你有时只是埋头在自已的小天地里，对集体活动欠热心。","建议你多参加一些集体活动，培养自己开朗大方的性格。","在文体方面，再活跃些，你的思维将会变得更敏捷。",} },
} },
["l"] = { "家庭父母", {"感谢你的父母对你的培养！","老师盼望你快快长大，否则你对不起日夜为你操劳的母亲的！","你的懂事、可爱，给了你奔波劳作的母亲最大的安慰。","你的父母都一直不在家，你却这么听话。","你的进步缩短了你们父子之间的距离，抚慰了妈妈受伤的灵魂。","你的优秀首先得力于你父母的教子有方，我感谢他们！","你父母长期不在你身边，你却照样每天把自己该做的事做到更好。","你父母真该好好奖励你呢！","你能够以自己的言行，破除母女之间不必要的隔膜。","你是上期全班学习成绩进步最大的一位同学，别忘记了家长会上，你母亲上台领奖时的笑容！","你是我们班少有的爸爸、妈妈都来开家长会的幸运者。","你是一个幸福的女孩，母亲在家就为了你！","你也是我们女生成绩进步最大的一个，你母亲在家长会上的发言，使我明白了你的成绩来于你的自觉。","你有一个爱学习的爸爸，懂得爱你的妈妈。","你有一个关心你也关心我们全班同学进步的母亲，我在这里感谢她！","你有一位了不起的母亲，她是坚强的、非常爱你的！","你有一位了不起的母亲，她是勇敢的！","请别忘了你母亲，为了你，她放弃了一切！","如果继续这样消沉下去，你怎么对得起很关心你学习的父母呢？","物质条件的优越没有导致你精神上的贫穷，因为很幸运的是你有懂得教育方法的父母。","这都要感谢你的父母，乐于与老师配合。","这学期的家长会上，你的爸爸、妈妈都来了，可见他们对你的重视。",} },
["m"] = { "建议期望", {
  ["a"] = { "勉励", {"凡是你认真做的事，就会有好的结果。","孩子，树立起必胜的信心吧！","继续努力，相信你一定会美梦成真的。","继续努力吧，我深深地为你祝福！","老师期望看到你在学习上的丰收。","老师相信，只要坚持下去，理想大学之门会为你而开。","老师相信只要你信心不倒，努力不懈，终有一天会到达成功的彼岸！","老师永远在支持你，相信你一定能击败困难，因为你是优秀的。","利用自己聪颖的天资，老师相信你会进步得很快的。","每一滴水都能折射出太阳的光辉，从每一件小事做起，你会不断取得进步。","面对一生的各种名利的诱惑，我不反对甚至欣赏“淡泊明志”式的“平淡”，但对于你的现在，我更希望你“辉煌”！","你面前有许多的高山等着你去攀越，做无畏的勇士吧，不要做胆小的懦夫！","你是个聪明的孩子，我相信你将成为胸纳百川，恢宏大度的杰出人才。","前进的道路是坎坷的，愿你做一个无畏的勇士，采撷最美丽的花朵！","请你不要灰心，慢慢来，不懈追求、不断努力，让无数次失败奠定成功的基石，你终能得到成功的喜悦！","如果能一如既往地走下去，你将会是老师、家人、同学的骄傲！","如果你在纪律上继续进步，在学习上更加努力，前途无可限量啊！","望你继续努力，老师关注着你的进步。","我为你感到无比的高兴，希望你做生活的强者，不屈不挠、勇往直前，我会永远支持你、祝福你！","我希望你不要妄自菲薄，继续努力，我始终会做你的支持者，为你加油，为你鼓劲！","我相信，成功的花朵在汗水的浇灌中会更加鲜艳。","希望你能再接再厉，不负老师和家长的重望，你可要争气啊！","希望你再接再厉，拥有一个美好、辉煌的明天！","相信“工夫不负有心人”，最后的胜利一定属于你！","相信你会不断总结，好好把握今天，早日腾飞！","要记住“山外有山”的道理，胜不骄，败不馁，永远不放弃追求。","一点一滴，都是前进的脚印，愿你顺着这条路朝成功走下去！","愿你把美好的理想转化为实际的行动，只有脚踏实地的人，才能达到光辉的顶点！","愿你不断地充实自我，变成一个各方面都优秀的女孩！","愿你策马前行，快马加鞭！","愿你多多努力，永不停息，勇攀高峰！","愿你坚持不懈，再创辉煌！","在通往知识的顶峰的路上长满了荆棘，望你克服困难，勇往直前！","知道吗？只要你持之以恒，理想的大门会为你而开的。","只要有恒心，有毅力，老师相信你会在各方面取得长足进步。",} },
  ["b"] = { "同学之间", {"老师有一个建议，希望你能接受：你有时很任性，甚至很固执，常常表现出以自我为中心，也许，我是说错了，但我仍然希望你能以此为鉴。","你要善交良友益友，提高自己明辩是非的能力。","希望能与同学友好相处，团结好每一位同学。","希望你能正视自己的缺点，加强与同学之间的沟通联系，重新塑造一个良好的自我形象，成为一个真正受欢迎的人。",} },
  ["c"] = { "班务工作", {"今后要更严格要求自己，时时带好头，事事学好样，做个名副其实的好干部。","你要在培养组织能力方面下些功夫，全方位施展自己的聪明才智，我想这对你今后的人生大有裨益。","希望你在工作上能更敢想敢干，提高工作效率，积累经验，不断提高自己的工作能力。","愿你活泼、开朗、锻炼能力，做一个全面发展的好学生！","愿你在紧张学习之余锻炼自己的工作能力，做一个全面发展的优秀的中学生！",} },
  ["d"] = { "言行纪律", {"爱玩虽算不上什么缺点，可贪玩会影响你的进步，你能下决心改正吗？","你平时太爱哭，这可不好，坚强一些，你一定能成为生活中的强者。","暑假建议你钓鱼（经父母同意），你暴烈的性格要所改变，老师可不忍心出了校门的你处事还如此鲁莽！","希望你能坚持住，要不然，“小调皮”还会来捣乱的！","希望你洗刷往昔的坏毛病，以崭新的姿态迎接新的学年。","心动不如行动，你只要能给自己培养一份恒心，给自己增加一点自制力，你会进步的。",} },
  ["e"] = { "学习/态度", {"今后如果你能在学习上多用心，认真做每一次的作业，及时改错，不断努力，相信你的学习成绩会有很大的提高，你有信心吗？","今后上课若能积极发言，多开动脑筋，你一定会进步得更快。","你的最大问题就是太懒太懒，我希望你痛下决心，把你脑壳里的“懒虫”挖出来丢了！","你要记住：谦虚谨慎永远是成功的法宝。","希望你能改掉贪玩的毛病，端正学习态度，在新的一年里，争取更大的进步。","希望你能重新认识与评价自己，谦虚好学，勇往直前！","希望你在课堂上能认真听讲，开动脑筋，遇到问题敢于请教。","有时你却让老师头疼，作业本上缺少干净和整齐，作文水平还有待提高，你能努力让自己做得更好吗？","愿你能发挥自己的聪明才智，勤奋学习。",} },
  ["f"] = { "学习/方法", {"不过，随着学科的增多，知识难度的加大，你可能会感到学习不像以前那么轻松了，这时就要特别注意养成良好的学习习惯和掌握先进的学习方法。","多练习应用题，用以训练自己的思维，相信你会有更大的进步。","改掉粗心的毛病，你才能出类拔萃。","今后你能提高写作业的速度，争取更大的进步吗？","你的英语基础不够牢固，成绩有一定的波动，希望能在平时多做练习，多开口读、背。","你今后的努力方向是：精益求精，扩大自己的知识面，讲究更有效的学习方法。","其实你反应能力不错，只要勤补基础，多思多问，成绩是可以提高的，就看你愿不愿意付出努力。","其实文科的学习很注重平时的积累，只要持之以恒地坚持复习，合理安排好时间，要赶上来是完全可以的。","如果平时你能多思、多问、多说，那你的进步会很大的！","希望你今后能积极开动脑筋，活跃思维，不断改进学习方法，提高学习效率，争取更大的进步。","学习上有不懂的问题，不要羞于开口，多问，多思考，多练习，并注意学习方法，定能收到良好的效果。","要改掉粗心的毛病，那样你才能出类拔萃。","愿你在平时更注重基础知识的学习与训练，加强能力的培养，做一个全面发展的好学生！",} },
  ["g"] = { "学习/综合", {"老师知道你之所以能写出这么出色的文章是和你平时的刻苦练习分不开的，老师希望你今后能继续努力，刻苦练习争取成为一个真正的作家。","令我欣慰的是，你很听我的话，而且很理解我对你的严格要求，相信你会把足球场上的拼搏用在学习上，给我们一个又一个的惊喜！","能“垄断”第一名当然是好事，但如果偶尔有几次没当上第一名，也没有什么，关键是知识和能力应协调发展。","你的作文也总是生动有趣，继续努力，在这方面多下点功夫。","你一直很努力学习，在逆境中你没有放弃自己，这是最可贵，我希望你能更轻松些，要知道，每个人的生活中都有阴影，但也有阳光。","你真的很聪明，知识面广，反应快，只要用功，学习将会不是一般的优秀。","努力学习是为了自己有个更美好的将来，把你的聪明劲多用在学习上吧！","凭着你的聪明和勇敢，如果用在学习上，哪一科又在你的话下呢？","如果你每一科都能像学语文这样有热情就好了。","如果一个人安于现状，没有远大的志向，就会退步，希望你今后多读书、勤思考，把你的聪明才智发挥出来，做老师的小助手。","天才出自勤奋，希望你在新学期里严格要求自己，你的聪明加上勤奋好学才会令你成功。","希望今后在课堂上能经常看到你大胆地举手发言，行吗？","希望你能发扬刻苦学习精神，保持优秀成绩。","希望你能吸取教训，正确处理好学与玩的关系，严于律己，重新塑造一个良好的自我形象，争取成为一个品学兼优的好学生。","希望你能正视不足，严格要求自己，努力提高语文和英语成绩，养成谦逊踏实的学习品格。","希望你能做学习上的主人，在知识的蓝天上张开翅膀，勇敢地高飞！","希望你在假期里多读课外书，拓宽自己的知识面。","学习是你目前的主要任务，你应该分清主次，在学习上多下功夫，为今后从事你喜爱的职业打下牢固的基础。","要想提高成绩，还需要有坚强的毅力和拼搏精神，你不是常说长大后要成为对社会有用的人吗？那就从现在做起，努力学习吧！","愿你敢于质疑解难、大胆发言，投入集体的怀抱，在集体中锻炼、成长！","愿你快快改正缺点，做一个勤奋好学、踏实上进的好学生！","愿你拿出勇气，战胜自我，全面提高学习成绩，提高各项能力！","愿你培养自己活泼的个性，学习上抓好平衡，来年取得更大的成绩！","愿你扬长避短，勤奋学习，争做全面发展的三好学生！","愿你在新学期理敢于质疑解难、大胆发言，做一个全面发展的好学生！","愿你在学习过程中，统筹兼顾，全面发展！","愿你在知识的海洋里遨游，做一个强者、胜利者！","愿你注意提高学习效率，奋发上进！",} },
  ["h"] = { "体育", {"平时你要多进行体育锻炼，增强体质。","提高体育成绩，争取早日成为三好学生，好吗？","愿你加强锻炼，增强体质，为你今后的事业打下坚实的基础！",} },
  ["i"] = { "劳动", {"劳动时要积极主动，那样你才能真正得到大家的喜爱。","要树立劳动光荣的思想，否则谁来创造一个干净整洁的学习环境呢？",} },
  ["j"] = { "其他", {"“千里之行，始于足下”，只有脚踏实地、埋头苦干，才能结出丰硕之果！","“书籍是人类进步的阶梯”，希望你与书本交上朋友。","但你可知道，除了学习以外，你还比别人缺少了好多，是吗？","老师要提醒你：山外有山，人外有人。","你现在有所醒悟，我为你高兴，快马加鞭，积极追赶才是你的上策。","你应该开朗一些，活泼一些，十多岁的少年对生活本应充满热情；你应该主动一些，积极一些，学习光有自觉性还不够，还要靠自己多努力，多探索。","勤奋是天才的摇篮，耕耘是智慧的源泉。","取得荣誉之时，须诵“非淡泊以明志”；遇到挫折之际，犹记“非宁静以致远”。","认真是成功的秘诀，粗心是失败的伴侣。","失败一次并没有关系，记住：笑在最后的才是真正的胜利者。","书山有路勤为径，学海无涯苦作舟。","俗话说：吃得苦中苦，方为人上人。","望你记住：“精诚所至，金石为开。","望你记住“学无止境”，不断进取，更上一层楼。","我所要对你说的是从现在开始还来得及，千万不要白白浪费自己的才智。","希望更严格要求自己，在各方面打个漂亮仗。","希望你充分发扬自己的优点，奋起直追，赶上或超过别人。","希望你快快成长起来，早日摆脱稚气，做一个自省自律的好学生。","希望你能真正理解“笨鸟先飞”的含义。","现在的磨砺就是将来成功的资本。","一分耕耘，一分收获。","愿你打下扎实的文化基础，使你能在足球王国里腾飞，我愿做你最忠实的球迷！","愿你亲手培育的花儿更美丽！","愿你我共携手，共创班级美好明天！","愿你永远健康、漂亮、快乐、上进，做一个能主宰自己的人！","愿你振作起来，增强信心，永不厌倦、永远进取！","在今后的学习生活中，要增强明辩是非的能力和自我教育的能力，克服自身的弱点，争取更上新台阶。",} },
} },
}
------------

ime.register_command("xs", "YichenLu_StudentsComments", "评语","","按数字选择适当评语")
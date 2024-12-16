#import "template.typ": *

#set page(
  margin: (
    left: 15mm, 
    right: 15mm, 
    top: 15mm, 
    bottom: 15mm
  ),
)

#set text(font: "平方")

#show: project.with(
  theme: rgb("#6CDFC1"),
  name: "焉知非鱼",
  title: "Perl 6 开发工程师",
  contact: (
    contact(
      text: "电话：0376-5611339"
    ),
    contact(
      text: "邮箱：ohmycloudy@gmail.com", 
      link: "mailto:ohmycloudy@gmail.com"
    ),
    contact(
      text: "Github：GitHub.com/ohmycloud", 
      link: "https://www.github.com/ohmycloud"
    ),
    contact(
      text: "主页：rakulang.github.io", 
      link: "https://rakulang.github.io"
    )
  ),
  main: (
    section(
      title: "工作经历",
      content: (
        subSection(
          title: text(size: 16pt)[小妖怪的冬天],
          titleEnd: "浪浪山",
          subTitle: "高级维修工程师",
          subTitleEnd: "(2020.09 - 现在)",
          content: list(
            [去镇子上买了五十斤盐。],
            [去镇子上买了三十斤孜然。],
            [去镇子上买了二十斤花椒。]
          ),
        ),
        subSection(
          title: text(size: 16pt)[小妖怪的秋天],
          titleEnd: "浪浪山",
          subTitle: "中级维修工程师",
          subTitleEnd: "(2018.05 – 2020.05)",
          content: list(
            [按照熊教头的命令，做出了1000只羽箭。],
            [和乌鸦这个妖精一块儿清洗了一口大锅。],
            [和乌鸦这个妖精一块儿去砍了1000斤柴。]
          ),
        ),
        subSection(
          title: text(size: 16pt)[小妖怪的夏天],
          titleEnd: "浪浪山",
          subTitle: "初级维修工程师",
          subTitleEnd: "(2016.10 – 2018.05)",
          content: list(
            [在后山1000平方米的草地上打滚。],
            [在后山砍伐了1000棵竹子。],
            [填平了大路上挖的1000个陷阱。],
          ),
        ),
        subSection(
          title: text(size: 16pt)[小妖怪的春天],
          titleEnd: "浪浪山",
          subTitle: "零级维修工程师",
          subTitleEnd: "(2012.07 – 2016.09)",
          content: list(
            [在后山上种了1000亩草坪。],
            [在后山上种了1000棵竹子。],
            [在大路上挖了1000个陷阱。],
          ),
        ),
      ),
    ),
    section(
      title: "项目经历",
      content: (
        subSection(
          title: "背诵滕王阁序",
          content: list("豫章故郡，洪都新府。星分翼轸，地接衡庐。襟三江而带五湖，控蛮荆而引瓯越。物华天宝，龙光射牛斗之墟；人杰地灵，徐孺下陈蕃之榻。雄州雾列，俊采星驰。")
        ),
        subSection(
          title: "背诵滕王阁序",
          content: list("台隍枕夷夏之交，宾主尽东南之美。都督阎公之雅望，棨戟遥临；宇文新州之懿范，襜帷暂驻。十旬休假，胜友如云；千里逢迎，高朋满座。腾蛟起凤，孟学士之词宗；紫电青霜，王将军之武库。家君作宰，路出名区；童子何知，躬逢胜饯。")
        ),
        subSection(
          title: "背诵滕王阁序",
          content: list("时维九月，序属三秋。潦水尽而寒潭清，烟光凝而暮山紫。俨骖騑于上路，访风景于崇阿。临帝子之长洲，得天人之旧馆。层峦耸翠，上出重霄；飞阁流丹，下临无地。鹤汀凫渚，穷岛屿之萦回；桂殿兰宫，即冈峦之体势。")
        )
      ),
    )
  ),
  sidebar: (
    section(
      title: "技能",
      content: (
        subSection(
          title: "编程语言",
          content: (
            "Raku",
            "Scala",
            "Swift",
            "Ruby",
            "Rust",
            "R",
            "Python",
            "Zig",
            "Nim",
            "Julia",
            "Go",
            "Dart",
            "Elixir",
            "Powershell",
            "Typescript"
          ).join(" • "),
        ),
        subSection(
          title: "技术",
          content: (
            "Apache Spark",
            "Apache Flink",
            "Git",
            "GPT-4",
            "Apache Arrow",
            "DuckDB",
            "Polars",
            "TensorFlow",
            "Keras",
            "Scikit-Learn", 
            "FastAPI",
            "SwiftUI",
            "ggplot2",
          ).join(" • "),
        ),
        subSection(
          title: "概念",
          content: (
            "面向对象编程",
            "机器学习",
            "单元测试",
            "函数式编程"
          ).join(" • "),
        ),
      ),
    ),
    section(
      title: "教育经历",
      content: (
        subSection(
          title: [
            #set par(justify: false)
            霍格沃茨建筑学院
          ],
          subTitle: "Hogwarts School of Witchcraft and Wizardry",
          content: [
            毕业时间: 2012.07
          ],
        ),
      ),
    ),
    section(
      title: "志愿者经历",
      content: (
        subSection(
          title: "",
          content: list(
            [节省了 *900L* 水], 
            [在支付宝种了 *3* 棵树],
            [骑行了 *1000* 公里],
          ),
        ),
      ),
    ),
    section(
      title: "获奖经历",
      content: (
        subSection(
          content: list(
            [2023年浪浪山打野第一名],
            [2022年浪浪山打野第一名],
            [2021年浪浪山打野第一名],
            [2020年浪浪山打蓝第一名],
            [2019年浪浪山打蓝第一名],
            [2018年浪浪山打蓝第一名],
            [2017年浪浪山摆懒第一名],
            [2016年浪浪山打蓝第一名],
            [2015年浪浪山摆懒第一名],
            [2014年浪浪山打蓝第一名],
            [2013年浪浪山打蓝第一名]
          ),
        ),
      ),
    ),
  ),
)

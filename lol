{
  "paragraphs": [
    {
      "text": "%md\n## Welcome to Zeppelin.\n##### This is a live tutorial, you can run the code yourself. (Shift-Enter to Run)",
      "config": {
        "colWidth": 12.0,
        "graph": {
          "mode": "table",
          "height": 300.0,
          "optionOpen": false,
          "keys": [],
          "values": [],
          "groups": [],
          "scatter": {}
        },
        "editorHide": true
      },
      "settings": {
        "params": {},
        "forms": {}
      },
      "jobName": "paragraph_1423836981412_-1007008116",
      "id": "20150213-231621_168813393",
      "result": {
        "code": "SUCCESS",
        "type": "HTML",
        "msg": "\u003ch2\u003eWelcome to Zeppelin.\u003c/h2\u003e\n\u003ch5\u003eThis is a live tutorial, you can run the code yourself. (Shift-Enter to Run)\u003c/h5\u003e\n"
      },
      "dateCreated": "Feb 13, 2015 11:16:21 PM",
      "dateStarted": "Apr 1, 2015 9:11:09 PM",
      "dateFinished": "Apr 1, 2015 9:11:10 PM",
      "status": "FINISHED",
      "progressUpdateIntervalMs": 500
    },
    {
      "title": "Load data into table",
      "text": "import org.apache.commons.io.IOUtils\nimport java.net.URL\nimport java.nio.charset.Charset\n\n// Zeppelin creates and injects sc (SparkContext) and sqlContext (HiveContext or SqlContext)\n// So you don\u0027t need create them manually\n\n// load bank data\nval bankText \u003d sc.parallelize(\n    IOUtils.toString(\n        new URL(\"https://s3.amazonaws.com/apache-zeppelin/tutorial/bank/bank.csv\"),\n        Charset.forName(\"utf8\")).split(\"\\n\"))\n\ncase class Bank(age: Integer, job: String, marital: String, education: String, balance: Integer)\n\nval bank \u003d bankText.map(s \u003d\u003e s.split(\";\")).filter(s \u003d\u003e s(0) !\u003d \"\\\"age\\\"\").map(\n    s \u003d\u003e Bank(s(0).toInt, \n            s(1).replaceAll(\"\\\"\", \"\"),\n            s(2).replaceAll(\"\\\"\", \"\"),\n            s(3).replaceAll(\"\\\"\", \"\"),\n            s(5).replaceAll(\"\\\"\", \"\").toInt\n        )\n).toDF()\nbank.registerTempTable(\"bank\")",
      "dateUpdated": "Jan 14, 2016 7:58:56 PM",
      "config": {
        "colWidth": 12.0,
        "graph": {
          "mode": "table",
          "height": 300.0,
          "optionOpen": false,
          "keys": [],
          "values": [],
          "groups": [],
          "scatter": {}
        },
        "title": true,
        "enabled": true,
        "editorMode": "ace/mode/scala"
      },
      "settings": {
        "params": {},
        "forms": {}
      },
      "jobName": "paragraph_1423500779206_-1502780787",
      "id": "20150210-015259_1403135953",
      "result": {
        "code": "SUCCESS",
        "type": "TEXT",
        "msg": "import org.apache.commons.io.IOUtils\nimport java.net.URL\nimport java.nio.charset.Charset\nbankText: org.apache.spark.rdd.RDD[String] \u003d ParallelCollectionRDD[32] at parallelize at \u003cconsole\u003e:65\ndefined class Bank\nbank: org.apache.spark.sql.DataFrame \u003d [age: int, job: string, marital: string, education: string, balance: int]\n"
      },
      "dateCreated": "Feb 10, 2015 1:52:59 AM",
      "dateStarted": "Jul 3, 2015 1:43:40 PM",
      "dateFinished": "Jul 3, 2015 1:43:45 PM",
      "status": "FINISHED",
      "progressUpdateIntervalMs": 500
    },
    {
      "text": "%sql \nselect age, count(1) value\nfrom bank \nwhere age \u003c 30 \ngroup by age \norder by age",
      "config": {
        "colWidth": 4.0,
        "graph": {
          "mode": "multiBarChart",
          "height": 300.0,
          "optionOpen": false,
          "keys": [
            {
              "name": "age",
              "index": 0.0,
              "aggr": "sum"
            }
          ],
          "values": [
            {
              "name": "value",
              "index": 1.0,
              "aggr": "sum"
            }
          ],
          "groups": [],
          "scatter": {
            "xAxis": {
              "name": "age",
              "index": 0.0,
              "aggr": "sum"
            },
            "yAxis": {
              "name": "value",
              "index": 1.0,
              "aggr": "sum"
            }
          }
        }
      },
      "settings": {
        "params": {},
        "forms": {}
      },
      "jobName": "paragraph_1423500782552_-1439281894",
      "id": "20150210-015302_1492795503",
      "result": {
        "code": "SUCCESS",
        "type": "TABLE",
        "msg": "age\tvalue\n19\t4\n20\t3\n21\t7\n22\t9\n23\t20\n24\t24\n25\t44\n26\t77\n27\t94\n28\t103\n29\t97\n"
      },
      "dateCreated": "Feb 10, 2015 1:53:02 AM",
      "dateStarted": "Jul 3, 2015 1:43:17 PM",
      "dateFinished": "Jul 3, 2015 1:43:23 PM",
      "status": "FINISHED",
      "progressUpdateIntervalMs": 500
    },
    {
      "text": "%sql \nselect age, count(1) value \nfrom bank \nwhere age \u003c ${maxAge\u003d30} \ngroup by age \norder by age",
      "config": {
        "colWidth": 4.0,
        "graph": {
          "mode": "multiBarChart",
          "height": 300.0,
          "optionOpen": false,
          "keys": [
            {
              "name": "age",
              "index": 0.0,
              "aggr": "sum"
            }
          ],
          "values": [
            {
              "name": "value",
              "index": 1.0,
              "aggr": "sum"
            }
          ],
          "groups": [],
          "scatter": {
            "xAxis": {
              "name": "age",
              "index": 0.0,
              "aggr": "sum"
            },
            "yAxis": {
              "name": "value",
              "index": 1.0,
              "aggr": "sum"
            }
          }
        }
      },
      "settings": {
        "params": {
          "maxAge": "35"
        },
        "forms": {
          "maxAge": {
            "name": "maxAge",
            "defaultValue": "30",
            "hidden": false
          }
        }
      },
      "jobName": "paragraph_1423720444030_-1424110477",
      "id": "20150212-145404_867439529",
      "result": {
        "code": "SUCCESS",
        "type": "TABLE",
        "msg": "age\tvalue\n19\t4\n20\t3\n21\t7\n22\t9\n23\t20\n24\t24\n25\t44\n26\t77\n27\t94\n28\t103\n29\t97\n30\t150\n31\t199\n32\t224\n33\t186\n34\t231\n"
      },
      "dateCreated": "Feb 12, 2015 2:54:04 PM",
      "dateStarted": "Jul 3, 2015 1:43:28 PM",
      "dateFinished": "Jul 3, 2015 1:43:29 PM",
      "status": "FINISHED",
      "progressUpdateIntervalMs": 500
    },
    {
      "text": "%sql \nselect age, count(1) value \nfrom bank \nwhere marital\u003d\"${marital\u003dsingle,single|divorced|married}\" \ngroup by age \norder by age",
      "config": {
        "colWidth": 4.0,
        "graph": {
          "mode": "multiBarChart",
          "height": 300.0,
          "optionOpen": false,
          "keys": [
            {
              "name": "age",
              "index": 0.0,
              "aggr": "sum"
            }
          ],
          "values": [
            {
              "name": "value",
              "index": 1.0,
              "aggr": "sum"
            }
          ],
          "groups": [],
          "scatter": {
            "xAxis": {
              "name": "age",
              "index": 0.0,
              "aggr": "sum"
            },
            "yAxis": {
              "name": "value",
              "index": 1.0,
              "aggr": "sum"
            }
          }
        }
      },
      "settings": {
        "params": {
          "marital": "single"
        },
        "forms": {
          "marital": {
            "name": "marital",
            "defaultValue": "single",
            "options": [
              {
                "value": "single"
              },
              {
                "value": "divorced"
              },
              {
                "value": "married"
              }
            ],
            "hidden": false
          }
        }
      },
      "jobName": "paragraph_1423836262027_-210588283",
      "id": "20150213-230422_1600658137",
      "result": {
        "code": "SUCCESS",
        "type": "TABLE",
        "msg": "age\tvalue\n19\t4\n20\t3\n21\t7\n22\t9\n23\t17\n24\t13\n25\t33\n26\t56\n27\t64\n28\t78\n29\t56\n30\t92\n31\t86\n32\t105\n33\t61\n34\t75\n35\t46\n36\t50\n37\t43\n38\t44\n39\t30\n40\t25\n41\t19\n42\t23\n43\t21\n44\t20\n45\t15\n46\t14\n47\t12\n48\t12\n49\t11\n50\t8\n51\t6\n52\t9\n53\t4\n55\t3\n56\t3\n57\t2\n58\t7\n59\t2\n60\t5\n66\t2\n69\t1\n"
      },
      "dateCreated": "Feb 13, 2015 11:04:22 PM",
      "dateStarted": "Jul 3, 2015 1:43:33 PM",
      "dateFinished": "Jul 3, 2015 1:43:34 PM",
      "status": "FINISHED",
      "progressUpdateIntervalMs": 500
    },
    {
      "text": "%md\n## Congratulations, it\u0027s done.\n##### You can create your own notebook in \u0027Notebook\u0027 menu. Good luck!",
      "config": {
        "colWidth": 12.0,
        "graph": {
          "mode": "table",
          "height": 300.0,
          "optionOpen": false,
          "keys": [],
          "values": [],
          "groups": [],
          "scatter": {}
        },
        "editorHide": true
      },
      "settings": {
        "params": {},
        "forms": {}
      },
      "jobName": "paragraph_1423836268492_216498320",
      "id": "20150213-230428_1231780373",
      "result": {
        "code": "SUCCESS",
        "type": "HTML",
        "msg": "\u003ch2\u003eCongratulations, it\u0027s done.\u003c/h2\u003e\n\u003ch5\u003eYou can create your own notebook in \u0027Notebook\u0027 menu. Good luck!\u003c/h5\u003e\n"
      },
      "dateCreated": "Feb 13, 2015 11:04:28 PM",
      "dateStarted": "Apr 1, 2015 9:12:18 PM",
      "dateFinished": "Apr 1, 2015 9:12:18 PM",
      "status": "FINISHED",
      "progressUpdateIntervalMs": 500
    },
    {
      "text": "%md\n\nAbout bank data\n\n```\nCitation Request:\n  This dataset is public available for research. The details are described in [Moro et al., 2011]. \n  Please include this citation if you plan to use this database:\n\n  [Moro et al., 2011] S. Moro, R. Laureano and P. Cortez. Using Data Mining for Bank Direct Marketing: An Application of the CRISP-DM Methodology. \n  In P. Novais et al. (Eds.), Proceedings of the European Simulation and Modelling Conference - ESM\u00272011, pp. 117-121, Guimarães, Portugal, October, 2011. EUROSIS.\n\n  Available at: [pdf] http://hdl.handle.net/1822/14838\n                [bib] http://www3.dsi.uminho.pt/pcortez/bib/2011-esm-1.txt\n```",
      "config": {
        "colWidth": 12.0,
        "graph": {
          "mode": "table",
          "height": 300.0,
          "optionOpen": false,
          "keys": [],
          "values": [],
          "groups": [],
          "scatter": {}
        },
        "editorHide": true
      },
      "settings": {
        "params": {},
        "forms": {}
      },
      "jobName": "paragraph_1427420818407_872443482",
      "id": "20150326-214658_12335843",
      "result": {
        "code": "SUCCESS",
        "type": "HTML",
        "msg": "\u003cp\u003eAbout bank data\u003c/p\u003e\n\u003cpre\u003e\u003ccode\u003eCitation Request:\n  This dataset is public available for research. The details are described in [Moro et al., 2011]. \n  Please include this citation if you plan to use this database:\n\n  [Moro et al., 2011] S. Moro, R. Laureano and P. Cortez. Using Data Mining for Bank Direct Marketing: An Application of the CRISP-DM Methodology. \n  In P. Novais et al. (Eds.), Proceedings of the European Simulation and Modelling Conference - ESM\u00272011, pp. 117-121, Guimarães, Portugal, October, 2011. EUROSIS.\n\n  Available at: [pdf] http://hdl.handle.net/1822/14838\n                [bib] http://www3.dsi.uminho.pt/pcortez/bib/2011-esm-1.txt\n\u003c/code\u003e\u003c/pre\u003e\n"
      },
      "dateCreated": "Mar 26, 2015 9:46:58 PM",
      "dateStarted": "Jul 3, 2015 1:44:56 PM",
      "dateFinished": "Jul 3, 2015 1:44:56 PM",
      "status": "FINISHED",
      "progressUpdateIntervalMs": 500
    },
    {
      "text": "%sh\necho lol",
      "dateUpdated": "Jul 28, 2016 12:57:51 PM",
      "config": {
        "colWidth": 12.0,
        "graph": {
          "mode": "table",
          "height": 300.0,
          "optionOpen": false,
          "keys": [],
          "values": [],
          "groups": [],
          "scatter": {}
        },
        "enabled": true,
        "editorMode": "ace/mode/sh"
      },
      "settings": {
        "params": {},
        "forms": {}
      },
      "jobName": "paragraph_1435955447812_-158639899",
      "id": "20150703-133047_853701097",
      "result": {
        "code": "SUCCESS",
        "type": "TEXT",
        "msg": "lol\n"
      },
      "dateCreated": "Jul 3, 2015 1:30:47 PM",
      "dateStarted": "Jul 28, 2016 12:57:51 PM",
      "dateFinished": "Jul 28, 2016 12:57:53 PM",
      "status": "FINISHED",
      "progressUpdateIntervalMs": 500
    },
    {
      "config": {},
      "settings": {
        "params": {},
        "forms": {}
      },
      "jobName": "paragraph_1469690871683_612298624",
      "id": "20160728-125751_670512901",
      "dateCreated": "Jul 28, 2016 12:57:51 PM",
      "status": "READY",
      "progressUpdateIntervalMs": 500
    }
  ],
  "name": "new notw",
  "id": "SCS5RSKZRP1469689357",
  "angularObjects": {
    "2BPKMWVS5null1466396774119": [],
    "2BMQSTYGBnull1466396774121": [],
    "2BQ7JCWGGnull1466396774124": [],
    "2BPGFB1HMnull1466396774126": [],
    "2BN215GY6null1466396774115": []
  },
  "config": {
    "looknfeel": "default"
  },
  "info": {},
  "source": "FCN"
}
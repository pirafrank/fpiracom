// JSONP generator for prose.io
// created by pirafrank
// notes:
// https://github.com/prose/prose/wiki/Prose-Configuration#select--multiselect
// [{"name": "Granny Apples", "value": "granny-apples" }]

const fs = require('fs')
const path = require('path')
const readline = require('readline');

async function processLineByLine(filepath, targetObj) {
  const fileStream = fs.createReadStream(filepath);

  const rl = readline.createInterface({
    input: fileStream,
  });
  for await (const line of rl) {
    targetObj.push({ name: line, value: line })
  }
}

async function processStdinLineByLine(targetObj) {
  const rl = readline.createInterface({
    input: process.stdin,
  });
  return new Promise(resolve => {
    rl.on('line', function(line){
      line = line.trim()
      targetObj.push({ name: line, value: line })
    })
    .on('close', () => {
      resolve(targetObj);
    });
  })
}

function work(what){
  // processLineByLine(`path.resolve(__dirname + `/../${what}.txt`, objs)
  processStdinLineByLine([])
    .then(r => {
      let output = `${what}Callback(` + JSON.stringify(r) + ')'
      console.log(`${what} processed. Output written to file: ${output}`)

      let filePath = path.resolve(__dirname + `/../jsonp/${what}.jsonp`)
      // write output to file (overwrites existant with same name)
      fs.writeFile(filePath, output, err => {
        if (err) console.error("ERROR while writing:" + err.message)
        // else file has been written successfully
      })
    })
    .catch(e => {
      console.log("ERROR: " + e.message)
    })
}

// script
const args = process.argv.slice(2);
if(!args || !args[0]){
  console.error(`ERROR: missing mandatory param`)
  process.exit(1)
}
switch (args[0]){
  case 'cat':
  case 'categories':
    work('categories')
    break;
  case 'tag':
  case 'tags':
    work('tags')
    break;
  default:
    console.error(`ERROR: unknown option ${args[0]}`)
}

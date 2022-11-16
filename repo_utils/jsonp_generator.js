// JSONP generator for prose.io
// created by pirafrank
// notes:
// https://github.com/prose/prose/wiki/Prose-Configuration#select--multiselect
// [{"name": "Granny Apples", "value": "granny-apples" }]

const fs = require('fs')
const path = require('path')
const readline = require('readline');

/*
async function processFileLineByLine(filepath, targetObj) {
  const fileStream = fs.createReadStream(filepath);

  const rl = readline.createInterface({
    input: fileStream,
  });
  for await (const line of rl) {
    targetObj.push({ name: line, value: line })
  }
}
*/

async function processStdinLineByLine(targetObj) {
  const rl = readline.createInterface({
    input: process.stdin,
  });
  return await new Promise(resolve => {
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
      const output = `${what}Callback(` + JSON.stringify(r) + ')'

      const filePath = path.join(__dirname, '..', 'jsonp', `${what}.jsonp`)
      // write output to file (overwrites existant with same name)
      fs.writeFile(filePath, output, err => {
        if (err) console.error(`ERROR while writing to file=${filePath}: ${err.message}`)
        // else file has been written successfully
        console.log(`${what} has been processed.\nOutput file: ${filePath}\nOutput written to file: ${output}`)
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

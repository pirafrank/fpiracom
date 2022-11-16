// JSONP generator for prose.io
// created by pirafrank
// notes:
// https://github.com/prose/prose/wiki/Prose-Configuration#select--multiselect
// [{"name": "Granny Apples", "value": "granny-apples" }]

const fs = require('fs')
const path = require('path')
const readline = require('readline');

/* constants */
const targetSubDir = path.join('..', 'jsonp')

/* functions */

function quitOnError(msg, errCode){
  console.error(msg)
  process.exit(errCode)
}

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

function createDirIfDoesNotExists(target){
  try{
    if (!fs.existsSync(target)){
      console.log(`Directory ${target} does not exist, creating it...`)
      fs.mkdirSync(target);
    } else {
      console.log(`Directory ${target} already exists, doing nothing...`)
    }
  } catch (err) {
    quitOnError(`Error while trying to creating dir=${target}`, 99)
  }
}

function work(what){
  // processLineByLine(`path.resolve(__dirname + `/../${what}.txt`, objs)
  processStdinLineByLine([])
    .then(r => {
      const output = `${what}Callback(` + JSON.stringify(r) + ')'

      const targetDir = path.join(__dirname, targetSubDir)
      createDirIfDoesNotExists(targetDir)
      const filePath = path.join(targetDir, `${what}.jsonp`)
      // write output to file (overwrites existant with same name)
      fs.writeFile(filePath, output, err => {
        if (err) {
          quitOnError(`ERROR while writing to file=${filePath}: ${err.message}`, 101)
        } else {
          // else file has been written successfully
          console.log(`${what} processed successfully.\nOutput file: ${filePath}\nOutput written to file: ${output}`)
        }
      })
    })
    .catch(e => {
      quitOnError("ERROR: " + e.message, 100)
    })
}

// script
const args = process.argv.slice(2);
if(!args || !args[0]){
  quitOnError(`ERROR: missing mandatory param`, 1)
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
    quitOnError(`ERROR: unknown option ${args[0]}`, 2)
}

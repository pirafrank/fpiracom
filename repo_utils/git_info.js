/*
 *  [git info generator]
 *  write git repository info to json file
 *  created by pirafrank
 */

const fs = require('fs')
const path = require('path')
const util = require('util')
const exec = util.promisify(require('child_process').exec)

const commandInfo = 'git log --pretty=format:"%H;;%aI;;%an;;%ae" | head -n1'
const commandBranchName = 'git rev-parse --abbrev-ref HEAD'
const commandTags = 'git tag --points-at HEAD'

const keys = [
  'commit_hash',
  'commit_date',
  'author_name',
  'author_email'
]

// outputs to _data/git.json
const targetPath = `/../_data/git.json`

const getGitInfo = async () => {
  let result = {}
  let p = await exec(commandInfo)
  p.stdout.split(';;').forEach((value, i) => {
    result[keys[i]] = value.replace(/[\n]+/g,'')
  })

  p = await exec(commandBranchName)
  result['branch'] = p.stdout.replace(/[\n]+/g,'')

  p = await exec(commandTags)
  result['tags'] = p.stdout.split('\n').filter(x => x)

  return result
}

// write to file
getGitInfo()
  .then(r => {
    let output = JSON.stringify(r)
    //console.log("gitinfo object: " + output)
    let filePath = path.resolve(__dirname + targetPath)
    fs.writeFile(filePath, output, err => {
      if (err) console.error("ERROR while writing:" + err.message)
      // else file has been written successfully
    })
  })
  .catch(err => {
    console.error("ERROR: " + err.message)
  })

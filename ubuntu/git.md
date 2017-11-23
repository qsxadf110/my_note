 https://www.liaoxuefeng.com

$ git config --global user.name "Your Name"
$ git config --global user.email "email@example.com"

# 让Git显示颜色，会让命令输出看起来更醒目
$ git config --global color.ui true
# 命令可以简写，很多人都用co表示checkout，ci表示commit，br表示branch
$ git config --global alias.co checkout
$ git config --global alias.ci commit
$ git config --global alias.br branch
# --global参数是全局参数，也就是这些命令在这台电脑的所有Git仓库下都有用, 
	针对当前用户起作用的，如果不加，那只针对当前的仓库起作用

# 配置一个git last，让其显示最后一次提交信息
$ git config --global alias.last 'log -1'

$ git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# 配置文件放哪了？每个仓库的Git配置文件都放在.git/config文件中
# 而当前用户的Git配置文件放在用户主目录下的一个隐藏文件.gitconfig中


# 把这个目录变成Git可以管理的仓库：
$ git init 

# 用命令git add告诉Git，把文件添加到仓库
$ git add <file>
# 强制添加到Git
$ git add -f <file>

# 把文件提交到仓库(可以一次提交很多文件)：	-m 后面输入的是本次提交的说明
$ git commit -m "wrote a readme file"

# 仓库当前的状态, 也可以告诉我们冲突的文件
$ git status

# 看看具体修改了什么内容
$ git diff <file>

# 查看提交历史，以便确定要回退到哪个版本。  --pretty=oneline
$ git log
# 分支的合并情况
$ git log --graph --pretty=oneline --abbrev-commit

# 既可以回退版本，也可以把暂存区的修改回退到工作区
$ git reset HEAD <file>
# 用HEAD->当前版本，上一个版本->HEAD^，上上一个版本->HEAD^^，当然往上100个版本写成HEAD~100
$ git reset --hard HEAD^
# 指定回到未来的某个版本  3628164->版本号  (版本号没必要写全，前几位就可以了，Git会自动去找。)
$ git reset --hard 3628164

# 要重返未来，用git reflog查看命令历史，以便确定要回到未来的哪个版本。
$ git reflog

# 把readme.txt文件在工作区的修改还是删除全部撤销,让这个文件回到最近一次commit/add时的状态。
$ git checkout -- readme.txt

# 删除一个文件
$ git rm <file>


# 创建SSH Key：
$ ssh-keygen -t rsa -C "youremail@example.com"
...顺利的话，可以在用户主目录里找到.ssh目录，里面有id_rsa和id_rsa.pub两个文件，这两个就是SSH Key的秘钥对，id_rsa是私钥，不能泄露出去，id_rsa.pub是公钥，可以放心地告诉任何人。

$ git remote add origin git@github.com:qsxadf110/my_note.git

# 把本地库的所有内容推送到远程库上, 实际上是把当前分支master推送到远程。
# 由于远程库是空的，我们第一次推送master分支时，加上了-u参数，Git不但会把本地的master分支内容推送的远程新的master分支，还会把本地的master分支和远程的master分支关联起来
$ git push -u origin master

# 从现在起，只要本地作了提交，就可以通过命令：
$ git push origin master

# 克隆一个本地库
$ git clone git@github.com:michaelliao/gitskills.git

# 创建dev分支，然后切换到dev分支
$ git checkout -b dev
Switched to a new branch 'dev'
# git checkout命令加上-b参数表示创建并切换，相当于以下两条命令
$ git branch dev
$ git checkout dev

# 查看当前分支, 当前分支前面会标一个 * 号
$ git branch
* dev
  master

# 把dev分支的工作成果合并到master分支上
$ git merge dev

# 删除dev分支
$ git branch -d dev

# 合并dev分支，请注意--no-ff参数，表示禁用Fast forward
$ git merge --no-ff -m "merge with no-ff" dev

# 把当前工作现场“储藏”起来，等以后恢复现场后继续工作：
$ git stash

# 刚才的工作现场存到哪去了
$ git stash list
# 一是用git stash apply恢复，但是恢复后，stash内容并不删除，你需要用git stash drop来删除
# 另一种方式是用git stash pop，恢复的同时把stash内容也删了：
# 你可以多次stash，恢复的时候，先用git stash list查看，然后恢复指定的stash，用命令
$ git stash apply stash@{0}

# 查看远程库的信息
$ git remote
$ git remote -v		更详细的信息

# 创建远程origin的dev分支到本地
$ git checkout -b dev origin/dev
# 在本地创建和远程分支对应的分支，使用
$ git checkout -b branch-name origin/branch-name
# 如果git pull提示“no tracking information”，
# 则说明本地分支和远程分支的链接关系没有创建，用命令
$ git branch --set-upstream branch-name origin/branch-name


# 切换到需要打标签的分支上, 打一个新标签, 默认标签是打在最新提交的commit上的
# 创建带有说明的标签, 用-a指定标签名，-m指定说明文字
$ git tag <name>
# 查看所有标签
$ git tag
# commit id(6224937) 打标签
$ git tag <name> 6224937
# 查看标签信息
$ git show <tagname>
# 推送某个标签到远程
$ git push origin <tagname>
# 一次性推送全部尚未推送到远程的本地标签
$ git push origin --tags
# 如果标签已经推送到远程，要删除远程标签就麻烦一点，先从本地删除
$ git tag -d <tagname>
# 然后，从远程删除。删除命令也是push，但是格式如下：
$ git push origin :refs/tags/<tagname>


# 删除已有的GitHub远程库
$ git remote rm origin


# Git工作区的根目录下创建一个特殊的.gitignore文件，把要忽略的文件名填进去，就会自动忽略这些文件。
# 忽略Python编译产生的.pyc、.pyo、dist等文件或目录
Desktop.ini
* .py[cod]
* .so
dist
build

# 最后一步就是把.gitignore也提交到Git，就完成了
# 可能是.gitignore写得有问题，需要找出来到底哪个规则写错了，可以用命令检查
$ git check-ignore
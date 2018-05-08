first modify `/etc/apt/sources.list` 

    sudo -s
    apt-add-repository ppa:numix/ppa
    apt-get update
    [for desktop] apt-get install unity-tweak-tool numix-icon-theme-circle numix-gtk-theme git vim-gtk ctags build-essential gcc-multilib chromium-browser firefox htop goldendict kolourpaint4 gimp php apache2 playonlinux steam mplayer vlc evince fortune cowsay gitk gitg idea default-jdk -y
    [for VM]apt-get install unity-tweak-tool numix-icon-theme-circle numix-gtk-theme git vim-gtk ctags build-essential gcc-multilib openssh-server -y
    apt-get dist-upgrade -y
    
config
 * unity-tweak-tool    
 * ~~github.com/YeXiaoRain/MyVim.git~~ spf13-vim
 * /etc/hosts
 * ~/.bashrc
 * dict
 * goldendict
 * playonlinux
 * beyond compare
 * git username useremail

### might useful

chmsee

tutorial
---

this tutorial is copy from other website

# QQ
  1. `sudo apt-get install playonlinux`
  2. 打开playonlinux选择工具=>管理wine版本=>wine版本(amd64)=>在可用的wine版本里选择1.7.51添加安装,添加后关闭版本界面.
  3. playonlinux主界面选择配置,默认的default这个不用!直接新建一个选择64bits windows installation,然后选择的wine版本,给虚拟盘命名(你喜欢什么名字自便).
  4. 还在playonlinux配置这页选择你设置的虚拟盘,wine版本选择你安装的1.7.51.
  5. 然后点击wine配置wine.应用程序=>设置为win7(这里有原因的,因为后面QQ需要字体库,我的字体库是复制于win7,所有你懂得,)
  6. 函数库增加d3d9 gdiplus msvcm80 msvcm90 msvcp80 msvcp90 msxml msxml6 riched20 riched32 comp90(以上虽然我不知道为什么,但是添加后没什么问题,少添加会可能出现帐号不能输入,密码不能输入等问题.).应用后退出回到playonlinux主程序.
  7. 开始要安装下载后的QQ6.7咯.点安装一个程序>安装未在列表中的程=>选择的编辑更新现有的应用程序=>选择你设置的虚拟盘=>前你希望做什么一个都不选=>64bits windows installatinon选择你安装(你自己下载的路径)以后的步骤和windows一样,下一步下一步...软件安装后有个页面在那转.不管直接关闭.
  8. 在playonlinux主界面选择配置=>选择你的虚拟盘=>点击自该虚拟盘创建快捷方式找到QQ的图标确定就好.然后退出
  9. 从win7复制字体库到虚拟盘c:\windows里的fnots复制到home\你的帐号名字\虚拟盘\你的设置虚拟盘\drive_c\windows里(这里如果你第5步如果选择的是其他的就设置其他的版本)
  10. 回到到第五步,在应用程序里添加QQ里的QQ.EXE TXPLATFORM.EXE QQSAFEUD.EXE这3个并设置为win7版本~保存应用
  11. 重启windows.QQ自动就出来咯!
希望能给大家一些灵感!谢谢

# 网易云音乐
  1. [网易云音乐官网下载deb](http://music.163.com/#/download)
  2. 安装会出现错误`sudo dpkg -i *.deb`
  3. 修复 `sudo apt-get install -f`
  4. 再次安装`sudo dpkg -i *.deb`

# 搜狗输入法
  1. `sudo apt-get install fcitx fcitx-googlepinyin fcitx-sunpinyiin`
  2. 语言配置
  3. [搜狗输入法官网下载deb](http://pinyin.sogou.com/linux/?r=pinyin)
  4. 安装会出现错误`sudo dpkg -i *.deb`
  5. 修复 `sudo apt-get install -f`
  6. 再次安装`sudo dpkg -i *.deb`

# 未整理
 * deepin 商店
 * deepin 截图
 * deepin 启动盘制作工具
 * deepin 日历

# 替代OneNote
 * backet
 * rednotebook
 * zim

# 可安装但命令未涉及
 * android studio
 * monodevelop
 * virtualbox
 * vmware
 * genymotion
 * lantern
 
# Deepin bash init scripts

use `sudo -s` and` chmod +x scripts.sh` first

```bash
cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb [by-hash=force] http://mirrors.aliyun.com/deepin unstable main contrib non-free" > /etc/apt/sources.list
apt update
apt install viewnior git vim-gtk ctags build-essential gcc-multilib firefox htop goldendict kolourpaint4 gimp php apache2 mplayer vlc evince gitk gitg idea webstorm command-not-found skypeforlinux -y
apt dist-upgrade -y
apt autoremove -y
apt autoclean -y
```

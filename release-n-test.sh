
. scripts/version-patcher.sh
cversion=$(cat pyproject.toml |tr '"' " " |awk '/version/ {print $3}')
git commit . -m "v$cversion" ;git tag "$cversion" && git push --tags ;git push &> /dev/null 

make dist && twine upload dist/* &&         echo "Bypassed install and prep testing :  " && \
	(echo "conda deactivate && pip install --user -U jgtfx2console";echo pip install --user jgtfx2console==$cversion) 
echo pip install --user jgtfx2console==$cversion
	#&& \
	#(conda deactivate && conda deactivate && conda deactivate && pip install --user -U jgtfx2console;pip install --user jgtfx2console==$cversion) &> /dev/null

#	&&    echo "        pip install -U jgtfx2console==$cversion"
#&& sleep 29 &&  . pypi-conda-gaia-env.sh $1

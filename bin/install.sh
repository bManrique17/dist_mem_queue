echo "[ Creating Conda Python Environment ]"

CENV=`conda info --envs`

if grep -w "dist_mem_queue" <<< "$CENV"
then
	mymsg "Conda dist_mem_queue environment already created."
else
	conda create -n dist_mem_queue -y python=3.10
	CONDSH=`conda info | grep 'base environment' | awk '{print $4}'`/etc/profile.d/conda.sh 
	source $CONDSH
	conda activate dist_mem_queue
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
	pip install -r requirements.txt	
    python3 get_tokenizer.py
	conda deactivate
fi
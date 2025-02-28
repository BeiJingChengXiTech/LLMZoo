model_name_or_path=/dev/shm/cl/mode/bloomz-7b1-mt/
model_max_length=1024
data_path=/dev/shm/cl/traindata/phoenix-sft-data-v1/data.json
output_dir=checkpointsout

torchrun \
  --nnodes=1 \
  --nproc_per_node=8 \
  train.py \
  --model_name_or_path ${model_name_or_path} \
  --lora True \
  --cache_dir ./cache_dir/ \
  --model_max_length ${model_max_length} \
  --data_path ${data_path} \
  --output_dir ${output_dir} \
  --bf16 True \
  --num_train_epochs 1 \
  --per_device_train_batch_size 1 \
  --per_device_eval_batch_size 1 \
  --gradient_accumulation_steps 1 \
  --save_strategy "steps" \
  --save_steps 3 \
  --evaluation_strategy "no" \
  --save_total_limit 3 \
  --learning_rate 2e-5 \
  --weight_decay 0. \
  --warmup_ratio 0.03 \
  --lr_scheduler_type "cosine" \
  --logging_steps 1 \
  --fsdp "full_shard auto_wrap" \
  --fsdp_transformer_layer_cls_to_wrap 'BloomBlock' \
  --tf32 True \
  --gradient_checkpointing True

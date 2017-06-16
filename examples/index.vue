<template>
	<div class="conatiner">
		<text style="margin-bottom: 20px;">weex plugin wheel picker example:</text>
		<div @click="showPicker" style="margin: 20px;padding:20px;background-color:#1ba1e2;color:#fff;"><text style="color:#fff">Click to show picker</text></div>
		<text style="margin-bottom: 20px;">result: {{value}}</text>
	</div>
</template>

<style>
	.container{
		flex: 1;
	}
</style>

<script>

	const plugin = weex.requireModule('weexPluginWheelPicker');
	module.exports = {
		data: {
			value: 'N/A'
		},
		methods: {
            showPicker: function() {
                let _this = this;
                let param = {
					startIndex: 1,
					endIndex: 4,
					showDates: [
                        'item-1',
                        'item-2',
                        'item-3',
                        'item-4',
                        'item-5',
                        'item-6',
                        'item-7',
                        'item-8',
                        'item-9',
                        'item-10',
                        'item-11',
                        'item-12'
                    ]
				};
				plugin.showPicker(param, function (ret) {
                    var result = ret.result;
                    _this.value = JSON.stringify(ret);
                    if(result == 'success')
                    {
                    }
                });

			}
		}
	}
</script>
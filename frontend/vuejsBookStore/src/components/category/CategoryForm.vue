<template>
  <div class="d-flex justify-content-center rounded w-50 m-3 pt-5 theme">
    <form>
      <div class="form-group form mt-3">
        <label for="name">{{ t('edit.form.labels.title') }}</label>
        <input
          type="text"
          id="name"
          class="form-control p-3"
          :class="{
            'is-invalid': state.errors?.title?.length > 0,
          }"
          v-model="state.category.title"
        />
        <div v-if="state.errors?.title?.length" class="invalid-feedback">
          {{ state.errors.title[0] }}
        </div>
      </div>

      <div class="form-group mt-3">
        <label for="name">{{ t('edit.form.labels.description') }}</label>
        <input
          type="text"
          id="name"
          class="form-control p-3"
          v-model="state.category.description"
        />
      </div>

      <div class="form-group mt-3">
        <label for="image" class="form-label">{{
          t('edit.form.labels.image')
        }}</label>
        <input
          type="file"
          id="formFile"
          class="form-control pt-0"
          @change="handleFileUpload"
        />
      </div>

      <div v-if="displayImage" class="form-group mt-3">
        <label for="image">{{ t('edit.form.labels.preview') }}</label>
        <img
          :src="displayImage"
          alt="Category Image"
          style="max-width: 100px"
          class="form-control"
        />
      </div>
      <div class="form-group mt-3">
        <button type="button" @click="submitForm" class="btn btn-primary">
          {{ t('edit.form.buttons.save') }}
        </button>
      </div>
    </form>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref, watch } from 'vue'
import type { Category } from '@/interfaces/Category'
import { useI18n } from 'vue-i18n'

const { t } = useI18n({
  useScope: 'local',
})

const props = defineProps<{
  category: Category
  errors?: Record<string, any>
}>()

const state = reactive({
  category: props.category,
  errors: props.errors,
})

const displayImage = ref()

watch(
  () => props.category,
  newVal => {
    state.category = newVal
    displayImage.value = state.category?.image
  },
)

watch(
  () => props.errors,
  newVal => {
    console.log(newVal)
    state.errors = newVal
  },
)

const emit = defineEmits<{
  (e: 'submit', category: Category): void
}>()

const handleFileUpload = (event: Event) => {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]
  state.category.image = file

  displayImage.value = URL.createObjectURL(file as Blob)
}

const submitForm = () => {
  emit('submit', state.category)
}
</script>

<style scoped>
.theme {
  background-color: #eee;
}
</style>

<i18n lang="json5">
{
  en: {
    edit: {
      title: 'Edit Category',
      form: {
        labels: {
          title: 'Title',
          description: 'Description',
          image: 'Category Image URL',
          preview: 'Image Preview',
        },
        buttons: {
          save: 'Save',
        },
        errors: {
          titleRequired: 'Title is required',
        },
      },
    },
  },
  vi: {
    edit: {
      title: 'Chỉnh sửa danh mục',
      form: {
        labels: {
          title: 'Tiêu đề',
          description: 'Mô tả',
          image: 'URL hình ảnh danh mục',
          preview: 'Xem trước hình ảnh',
        },
        buttons: {
          save: 'Lưu',
        },
        errors: {
          titleRequired: 'Tiêu đề là bắt buộc',
        },
      },
    },
  },
}
</i18n>

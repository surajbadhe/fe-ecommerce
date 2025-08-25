<!--<template>-->
<!--  <div class="container py-5">-->
<!--    <div class="row mb-3">-->
<!--      <div class="col-12 d-flex justify-content-between align-items-center">-->
<!--        <h4>📋 All Categories</h4>-->
<!--        <router-link class="btn btn-success" to="/admin/category/add">➕ Add Category</router-link>-->
<!--      </div>-->
<!--    </div>-->

<!--    <div class="row">-->
<!--      <div class="col-12">-->
<!--        <table class="table table-striped table-bordered shadow-sm">-->
<!--          <thead class="table-primary">-->
<!--          <tr>-->
<!--            <th>ID</th>-->
<!--            <th>Name</th>-->
<!--            <th>Description</th>-->
<!--            <th>Image</th>-->
<!--            &lt;!&ndash; Optional: Actions &ndash;&gt;-->
<!--            <th>Actions</th>-->
<!--          </tr>-->
<!--          </thead>-->
<!--          <tbody>-->
<!--          <tr v-for="category in categories" :key="category.id">-->
<!--            <td>{{ category.id }}</td>-->
<!--            <td>{{ category.categoryName }}</td>-->
<!--            <td>{{ category.description }}</td>-->
<!--            <td>-->
<!--              <img-->
<!--                  v-if="category.imageUrl"-->
<!--                  :src="category.imageUrl"-->
<!--                  alt="Category Image"-->
<!--                  style="width: 50px; height: 50px; object-fit: cover;"-->
<!--              >-->
<!--            </td>-->

<!--            <td>-->
<!--              <button class="btn btn-sm btn-warning me-1">✏️ Edit</button>-->
<!--              <button class="btn btn-sm btn-danger">🗑️ Delete</button>-->
<!--            </td>-->
<!--          </tr>-->
<!--          <tr v-if="categories.length === 0">-->
<!--            <td colspan="6" class="text-center text-muted">No categories found.</td>-->
<!--          </tr>-->
<!--          </tbody>-->
<!--        </table>-->
<!--      </div>-->
<!--    </div>-->
<!--  </div>-->
<!--</template>-->
<template>
  <div class="container mt-4">


    <h3 class="text-center mb-3">📋 All Categories</h3>
    <table class="table table-bordered">
      <thead class="table-light">
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Image</th>

        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="category in categories" :key="category.id">
        <td>{{ category.id }}</td>
        <td>
          <input v-model="category.categoryName" class="form-control">
        </td>
        <td>
          <input v-model="category.description" class="form-control">
        </td>
        <td>
          <input v-model="category.imageUrl" class="form-control">
        </td>

        <td>
          <button class="btn btn-sm btn-success me-1" @click="updateCategory(category)">Update</button>
          <button class="btn btn-sm btn-danger" @click="deleteCategory(category.id)">Delete</button>
        </td>
      </tr>
      </tbody>

    </table>
    <div class="row mb-3">
      <div class="col-12 d-flex justify-content-between align-items-center">

        <router-link class="btn btn-success" to="/admin/category/add">Add Category</router-link>
      </div>
    </div>

  </div>
</template>

<!--<script>-->
<!--import axios from "axios";-->

<!--export default {-->
<!--  data() {-->
<!--    return {-->
<!--      categories: [],-->
<!--      baseURL: "http://localhost:8080/"-->
<!--    };-->
<!--  },-->
<!--  methods: {-->
<!--    async fetchCategories() {-->
<!--      try {-->
<!--        const response = await axios.get(this.baseURL + "categories/all");-->
<!--        this.categories = response.data;-->
<!--      } catch (err) {-->
<!--        console.error("❌ Error fetching categories:", err);-->
<!--        alert("Failed to load categories. Check console.");-->
<!--      }-->
<!--    }-->
<!--  },-->
<!--  mounted() {-->
<!--    this.fetchCategories();-->
<!--  }-->
<!--};-->
<!--</script>-->
<script>
import axios from "axios";

export default {
  data() {
    return {
      categories: [],
      baseURL: "http://51.21.199.182/categories/"
    };
  },
  methods: {
    async fetchCategories() {
      try {
        const response = await axios.get(this.baseURL + "all");
        this.categories = response.data;
      } catch (err) {
        console.error("Error fetching categories:", err);
      }
    },
    async updateCategory(category) {
      try {
        await axios.patch(this.baseURL + category.id, category);
        alert("✅ Category updated successfully!");
      } catch (err) {
        console.error("Error updating category:", err);
        alert("Failed to update category.");
      }
    },
    async deleteCategory(id) {
      if (!confirm("Are you sure you want to delete this category?")) return;

      try {
        await axios.delete(this.baseURL + id);
        alert("✅ Category deleted successfully!");
        this.categories = this.categories.filter(c => c.id !== id);
      } catch (err) {
        console.error("Error deleting category:", err);
        alert("Failed to delete category.");
      }
    }
  },
  mounted() {
    this.fetchCategories();
  }
};
</script>
